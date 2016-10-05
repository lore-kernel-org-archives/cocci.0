From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 5 Oct 2016 22:02:21 +0200 (CEST)
Subject: [Cocci] Replacing one (specific!) type with another
In-Reply-To: <87shsa7p71.fsf@thinkpad.rath.org>
References: <87r37vzd8j.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610050744460.3061@hadrien>
 <87shsa7p71.fsf@thinkpad.rath.org>
Message-ID: <alpine.DEB.2.10.1610052158110.3130@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 5 Oct 2016, Nikolaus Rath wrote:

> On Oct 05 2016, Julia Lawall <julia.lawall@lip6.fr> wrote:
> > On Tue, 4 Oct 2016, Nikolaus Rath wrote:
> >
> >> Hello,
> >>
> >> In a set of C files, I would like to replace each instance of one type
> >> (struct fasel_foo) with another type (struct fasel_bar). For instance,
> >>
> >> char* fasel_foo_print(struct fasel_foo *ptr) {
> >>     // ...
> >>    return "this struct fasel_foo string should not change";
> >> }
> >>
> >> should become
> >>
> >> char* fasel_foo_print(struct fasel_bar *ptr) {
> >>     // ...
> >>    return "this struct fasel_foo string should not change";
> >> }
> >>
> >>
> >> Based on the LWN articles that I've read, this seems like the perfect
> >> use-case for coccinelle. However, somehow I'm struggling to write a
> >> patch for this. All the documentation that I could get my hands on seems
> >> to describe more abstract changes that require the use of variables -
> >> but as far as I can tell, I need something much simpler:
> >>
> >> @@
> >> "struct fasel_foo must be a type name!"
> >> @@
> >> - struct fasel_foo
> >> + struct fasel_bar
> >>
> >>
> >> ...if only I knew what to put between the @@.
> >
> > Put nothing :)  From the word struct it should figure out that it is
> > working on a type.
>
> Oh, great! Thanks!
> >
> This solves my problem, but it makes me wonder how this generalizes to
> other problems. For example,
>
> 1. What would I need to do if I don't want to replace a struct but
>    something typedef'd? (my_type *ptr --> new_type *ptr).

Coccinelle needs to know that the thing is a typedef.  So this time, you
can start your rule with

@@
typedef my_type;
typedef new_type;
@@

>
> 2. ..and how would I go about if instead of the type, I want to replace
>    a variable name? (my_type *ptr --> my_type *pointer).

I'm not completely sure what the issue is here.  Do you specifically want
to convert ptr to pointer?  Is the type important?  To make exactly what
you have written, you could put:

@@
typedef my_type;
idexpression mytype * p1;
@@

- ptr at p1
+ pointer

This checks for the word ptr, and also checks that it is an identifier of
the right type.  I haven't tested it, so let me know if there is any
problem.

julia
