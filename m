From: iago.abal@gmail.com (Iago Abal)
Date: Tue, 8 Mar 2016 10:59:51 +0100
Subject: [Cocci] Parsing C source files by Coccinelle
In-Reply-To: <56DDDCB7.5060206@users.sourceforge.net>
References: <CAJTCqFadstafOZPgjDoV48zNFBHkTdp+4=a0WLGbfKaTCSqgOw@mail.gmail.com>
 <56D99C75.7080100@users.sourceforge.net>
 <CAO=9Y+2Qm+A9a91zGrYNJavOXcWFR2hj5Xx+=FPG1p02KdC7Ew@mail.gmail.com>
 <56DDCAD3.2080309@users.sourceforge.net>
 <CAO=9Y+0KUsrK4OpR9YrNpp5JJ2tDDoY-DOq0xfDBcY8GdKWwCQ@mail.gmail.com>
 <56DDDCB7.5060206@users.sourceforge.net>
Message-ID: <CAGbDTvr_nmt-SVtvYtvOM9tcsUvh_tdg0i=+R1QDLck0G9uctg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Mar 7, 2016 at 8:55 PM, SF Markus Elfring <
elfring@users.sourceforge.net> wrote:

> > In particular, we would like to see whether it is possible to improve
> Coccinelle results
> > by supplying it with aliasing information about variables.
>
> Does such a goal indicate that you are going to experiment also with data
> flow analysis?
>

If you are talking about using Coccinelle as a bug finder, and empower it
with alias analysis, then I have spent about a year working on a similar
idea. I am available to discuss my experience with you, if you want. I
don't know exactly in what direction you want to "improve" Coccinelle
results, but let me warn you that in principle alias analysis may just give
you a lot more false positives. It's a double-edged sword... it will help
you with some issues, but you'll get new issues to deal with. Linked data
structures are a common source of confusion, since you will have trouble to
distinguish between individual elements of, for instance, a linked list. If
your alias analysis is very precise it is going to be hard to scale up; and
if your alias analysis is not precise enough, it may not be very useful.
Sometimes, in functions with complex manipulation of pointers, I find that
alias analysis hurts more than it helps. That said, I think advanced
Coccinelle users could make good use of aliasing information.

Iago
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160308/3bd96470/attachment-0001.html>
