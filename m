From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 6 Oct 2016 07:55:14 +0200 (CEST)
Subject: [Cocci] Replacing one (specific!) type with another
In-Reply-To: <8760p6ctgw.fsf@thinkpad.rath.org>
References: <87r37vzd8j.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610050744460.3061@hadrien>
 <87shsa7p71.fsf@thinkpad.rath.org>
 <alpine.DEB.2.10.1610052158110.3130@hadrien>
 <8760p6ctgw.fsf@thinkpad.rath.org>
Message-ID: <alpine.DEB.2.10.1610060750180.3179@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 5 Oct 2016, Nikolaus Rath wrote:

> On Oct 05 2016, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >> 1. What would I need to do if I don't want to replace a struct but
> >>    something typedef'd? (my_type *ptr --> new_type *ptr).
> >
> > Coccinelle needs to know that the thing is a typedef.  So this time, you
> > can start your rule with
> >
> > @@
> > typedef my_type;
> > typedef new_type;
> > @@
>
> Makes sense, thanks!
>
> >> 2. ..and how would I go about if instead of the type, I want to replace
> >>    a variable name? (my_type *ptr --> my_type *pointer).
> >
> > I'm not completely sure what the issue is here.  Do you specifically want
> > to convert ptr to pointer?  Is the type important?  To make exactly what
> > you have written, you could put:
> >
> > @@
> > typedef my_type;
> > idexpression mytype * p1;
> > @@
> >
> > - ptr at p1
> > + pointer
> >
> > This checks for the word ptr, and also checks that it is an identifier of
> > the right type.  I haven't tested it, so let me know if there is any
> > problem.
>
> Well, I don't have an actual use-case anymore. My problem is solved, I'm
> just curious what else I could do with Coccinelle to do :-).
>
> Somehow I'm having a really hard time grasping the fundamentals. The
> first two examples make sense - I could adapt them for similar
> situations. But then, I still have absolutely no idea how I would come
> up with the third example, or how to adapt it. What does "idexpression"
> mean? What does "ptr at p1" mean? Is this documented anywhere?

idexpression is an expression that is resricted to be an identifier.  It
allows you to put a type on an expression that has the form of an
identifier.  You can also say identifier x;  But that is just a name.  It
has no type.  It could be an expression, a field name, a parameter name,
etc.

@ connects patterns that match the same term.  So match a term against the
explicit name ptr and also match it against an identifier expression that
has a particular type.  This is not exactly a beginner example.

> I'd hate to waste your time asking tons of such trivial questions on the
> mailing list, but I just can't find any helpful documentation at all...

If you look on the web page in the papers and slides section, at the top
there are several tutorials and overview talks, some with video.

There is a grammar of the language at
http://coccinelle.lip6.fr/documentation.php
I doubt that it would be very helpful for a beginner.  But there are many
examples at another link on the same page.

julia

>
> Best,
> -Nikolaus
> --
> GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
> Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F
>
>              ?Time flies like an arrow, fruit flies like a Banana.?
>
