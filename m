From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 22 May 2013 19:36:37 +0200 (CEST)
Subject: [Cocci] isomorphism with unlikely
In-Reply-To: <519A75DE.1040604@metafoo.de>
References: <20130520173406.GB5890@katana> <519A61A8.7010402@metafoo.de>
 <20130520182415.GA6975@katana> <519A6ABC.1090004@metafoo.de>
 <alpine.DEB.2.02.1305202051210.2036@localhost6.localdomain6>
 <519A75DE.1040604@metafoo.de>
Message-ID: <alpine.DEB.2.02.1305221936070.2020@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 20 May 2013, Lars-Peter Clausen wrote:

> On 05/20/2013 08:51 PM, Julia Lawall wrote:
> > On Mon, 20 May 2013, Lars-Peter Clausen wrote:
> >
> >> On 05/20/2013 08:24 PM, Wolfram Sang wrote:
> >>>
> >>>> There is already an isomorphism for unlikely. But it is in one direction
> >>>> only, so 'unlikely(E)' in your cocci script will also match 'E', but 'E'
> >>>> wont match 'unlikely(E)'.
> >>>
> >>> Okay, but I would then still need 'unlikely(!r)' and 'unlikely(r ==
> >>> NULL)' because the !r isomorphisms won't apply. I'd like to have both :)
> >>
> >> No, just unlikley(r == NULL) also matches !r (and unlikely(!r)). This should
> >> also work for unlikely(!r) matching unlikely(r == NULL) but for some reason
> >> it doesn't. I just did a quick test and it looks as if even 'if(!r) ..."
> >> doesn't match 'if(r == NULL) ...' either.
> >
> > It should work if r has pointer type.  Otherwise, if r is not a pointer,
> > then !r should become r == 0.
>
> But for some reason it does not. With --verbose-match I can see that it
> generates the correct isomorphisms (both for the case that r is a pointer or
> that r is an integer), but for some reason they don't seem to match.
>
> The testcase is simple:
>
> cocci file:
>
> @@
> expression *r;
> statement S;
> @@
> *if(!r) S
>
> c file:
>
> int foo(struct resource *r)
> {
> 	if (r == NULL)
> 		return 0;
> 	return 1;
> }

Thanks for the report.  I have found the problem, and will try to fix it
shortly.

julia
