From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 11 Sep 2014 11:23:21 +0200 (CEST)
Subject: [Cocci] Matching literal strings
In-Reply-To: <87sijyed74.fsf@rasmusvillemoes.dk>
References: <87wq9aedwx.fsf@rasmusvillemoes.dk>
 <alpine.DEB.2.10.1409111054500.2419@hadrien>
 <87sijyed74.fsf@rasmusvillemoes.dk>
Message-ID: <alpine.DEB.2.10.1409111121160.2419@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 11 Sep 2014, Rasmus Villemoes wrote:

> On Thu, Sep 11 2014, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
> > On Thu, 11 Sep 2014, Rasmus Villemoes wrote:
> >
> >>
> >> which is obviously wrong. What should I do to make coccinelle match a
> >> specific string literal? I guess I could introduce 'constant c =~
> >> "^\"%s\"$";', but there might be a more canonical way.
> >
> > It looks like a bug.  There have been some improvements in the handling of
> > format strings, but perhaps the changes have not all been positive...
>
> In that case you might like to know
>
> $ spatch --version
> spatch version 1.0.0-rc21 with Python support and with PCRE support
>
> Note that it shouldn't really matter that "%s" is a format
> string (which is why I didn't attempt to use a "format" variable; I
> don't really understand those); I just want to find instances where
> seq_printf is called with a specific string literal as its second argument.

The problem seems to be fixed.  On the other hand, I'm not sure what patch
to send you.  Perhaps you could just use the regexp solution in the short
term.

julia
