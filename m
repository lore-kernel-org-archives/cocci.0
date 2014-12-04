From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 4 Dec 2014 13:56:52 +0100 (CET)
Subject: [Cocci] What is the spatch file for this change and the
 corresponding spatch command line invocation
In-Reply-To: <5480584A.30107@inria.fr>
References: <547F4892.6080405@inria.fr> <20141203173449.GX25677@wotan.suse.de>
 <5480584A.30107@inria.fr>
Message-ID: <alpine.DEB.2.10.1412041354440.2118@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 4 Dec 2014, Francois Berenger wrote:

> On 12/03/2014 06:34 PM, Luis R. Rodriguez wrote:
> > On Wed, Dec 03, 2014 at 06:29:54PM +0100, Francois Berenger wrote:
> > > Hello,
> > >
> > > I give up trying to write the spatch myself:
> > >
> > > Before file:
> > > ---
> > > int i;
> > >
> > > for ( ; ; ++i ) {
> > >    if (1) {
> > >      continue;
> > >    }
> > > }
> > > ---
> > >
> > > After file:
> > > ---
> > > int i;
> > >
> > > for ( ; ; ) {
> > >    if (1) {
> > >      ++i;
> > >      continue;
> > >    }
> > >    ++i;
> > > }
> > > ---
> > >
> > > All my trials don't work, not any change in the file appears
> > > if I try --in-place and -o fails because
> > > "-o can not be applied because there are no modified files"
> >
> > Can you take the hands on tutorial before expecting folks to
> > write rules for you?
> >
> > https://www.youtube.com/watch?v=buZrNd6XkEw
>
> If I really need to invest two hours before being able to use coccinelle
> productively, that would be a serious entry barrier.
>
> And probably not just for me: for any potential new user of
> coccinelle.

I think that you may have started with an unfortunate case.  I'm not sure
what is the strategy for matching the empty space in a for header.  It's
not an expression, so what is it.  It may be possible only to match it
exactly.

On the other hand, it is helpful if you provide a semantic patch that
you have tried, rather than just the before and after code.  From one
example of before and after code, it is not always possible to guess the
full generality of the rule that you are trying to implement.

julia
