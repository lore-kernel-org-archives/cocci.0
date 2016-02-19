From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 19 Feb 2016 07:31:51 -0500 (EST)
Subject: [Cocci] [PATCH] scripts/coccinelle: modernize &
In-Reply-To: <56C709A1.6060004@users.sourceforge.net>
References: <1455750974-24339-1-git-send-email-Julia.Lawall@lip6.fr>
 <56C709A1.6060004@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1602190729410.2801@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > diff --git a/scripts/coccinelle/iterators/use_after_iter.cocci b/scripts/coccinelle/iterators/use_after_iter.cocci
> > index f085f59..ce8cc9c 100644
> > --- a/scripts/coccinelle/iterators/use_after_iter.cocci
> > +++ b/scripts/coccinelle/iterators/use_after_iter.cocci
> > @@ -123,7 +123,7 @@ list_remove_head(x,c,...)
> >  |
> >  sizeof(<+...c...+>)
> >  |
> > -&c->member
> > + &c->member
>
> The added space character is not in the first column of this SmPL script.
>
> * Can it be that the additional character will be transformed according to
>   special pretty-printing rules?
>   https://github.com/coccinelle/coccinelle/issues/37

I don't understand the question.  Spaces in the script (at least before
and after the pattern) don't impact spaces in the source code.

> * Is such a change a possible workaround for open issues around
>   the message "minus: parse error" (or software improvements
>   which were developed in the meantime)?

No idea what is referred to here.  Maybe you don't like the parse errors,
but that is the errors that the parser generator generates.  You are
welcome to write a parser generator that produces bettwe messages if you
like.

> >  |
> >  c = E
> >  |
>
>
> Does the shown tweak need any further considerations?

No idea what is referred to here.

julia
