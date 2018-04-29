From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 29 Apr 2018 20:30:10 +0200 (CEST)
Subject: [Cocci] a small nuisance report
In-Reply-To: <kkpo2hubnk.fsf@bora.foobar.de>
References: <kkwowq17f3.fsf@bora.foobar.de>
 <alpine.DEB.2.20.1804291955550.3679@hadrien> <kkpo2hubnk.fsf@bora.foobar.de>
Message-ID: <alpine.DEB.2.20.1804292029440.3679@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 29 Apr 2018, Robert Larice wrote:

> Julia Lawall <julia.lawall@lip6.fr> writes:
>
> > On Sun, 29 Apr 2018, Robert Larice wrote:
> >
> >> Hello,
> >>
> >>   attached is a small example which
> >>     injects a statement and a comment.
> >>
> >>   It works well, but does'nt do exactly as wanted.
> >>
> >>   I get :
> >>
> >> +    j /* comments are overrated */
> >> +    -= 3;
> >>
> >>   The comment popped up within the expression instead
> >>     of in front of it.
> >>   no bug, but uggly.
> >
> > This problem is solve in the github version of Coccinelle.  The problem
> > was because j was declared as a symbol.
> >
> > julia
>
> Thank You,
>
>   so I could work around by simply using an "identifier"
>     perhaps augmented with a regexp match.

No, just pull from github and recompile.

julia
