From: iago.abal@gmail.com (Iago Abal)
Date: Tue, 8 Mar 2016 13:01:35 +0100
Subject: [Cocci] Parsing C source files by Coccinelle
In-Reply-To: <56DEA8D5.6070902@users.sourceforge.net>
References: <CAJTCqFadstafOZPgjDoV48zNFBHkTdp+4=a0WLGbfKaTCSqgOw@mail.gmail.com>
 <56D99C75.7080100@users.sourceforge.net>
 <CAO=9Y+2Qm+A9a91zGrYNJavOXcWFR2hj5Xx+=FPG1p02KdC7Ew@mail.gmail.com>
 <56DDCAD3.2080309@users.sourceforge.net>
 <CAO=9Y+0KUsrK4OpR9YrNpp5JJ2tDDoY-DOq0xfDBcY8GdKWwCQ@mail.gmail.com>
 <56DDDCB7.5060206@users.sourceforge.net>
 <CAGbDTvr_nmt-SVtvYtvOM9tcsUvh_tdg0i=+R1QDLck0G9uctg@mail.gmail.com>
 <56DEA8D5.6070902@users.sourceforge.net>
Message-ID: <CAGbDTvqu=ibTqvPSjkSBgSyNEk9JSvgBfXXN75n72k+G1_4PVQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> How similar was this approach?
>
The query language is not as expressive as Coccinelle SmPL, but you can
write queries like

  ... when P
  Q

Here P and Q, apart from matching syntax, can make use of aliasing and
other lightweight semantic information.


> Do you need also a special software infrastructure to reduce the
> probability
> for the undesired reporting of false positives?
>
In my case, alias analysis allowed me to find bugs that I could not find
easily with Coccinelle, using similar or relatively simpler queries
(simpler here is arguable of course). But it has introduced a lot more
false positives. I basically had to fine tune the alias analysis, and made
a lot of unsound and sometimes project-specific assumptions. Good support
of structs is a must and is probably the trickiest part.

How would these data be integrated for the use in SmPL scripts?
>

In its simplest form, using OCaml or Python scripts within SmPL patches to
access external aliasing data. You could ran a separate tool to build an
aliasing database, and then once you have matched two variables `x' and `y'
with Coccinelle, you may query such database to know whether those two
variables may be aliased. Some features would need a proper integration
with Coccinelle though, and that's another nontrivial task.

If you want to do this you should also note that Coccinelle runs on code on
which neither macros nor #if have been resolved. Your alias analysis will
likely work on preprocessed code, therefore your aliasing information may
be incomplete or even misleading. All in all, truly integrating alias
analysis into a fully functional Coccinelle is a project that will take you
a few years, IMHO.

Iago
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160308/850bb3a2/attachment.html>
