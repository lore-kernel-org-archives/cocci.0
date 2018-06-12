From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 12 Jun 2018 07:29:59 +0200 (CEST)
Subject: [Cocci] check for non-const arguments used only as const
	accesses
In-Reply-To: <ef6d66c75ebb2b23cb1d3802bf5becd7b972e027.camel@perches.com>
References: <be8cb9f390cec1bfd8db88cb5d792f9d99b5c138.camel@perches.com>
 <alpine.DEB.2.20.1806112321370.2521@hadrien>
 <ef6d66c75ebb2b23cb1d3802bf5becd7b972e027.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1806120728290.2309@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 11 Jun 2018, Joe Perches wrote:

> On Mon, 2018-06-11 at 23:23 +0200, Julia Lawall wrote:
> > On Mon, 11 Jun 2018, Joe Perches wrote:
> > > Many times it would be useful to update functions
> > > where non-const arguments are used only as const
> > > dereferences or as arguments to other function that
> > > use const.
> > >
> > > Is it possible for coccinelle to find and show
> > > these types of uses that could be const?
> >
> > Yes, it's possible.  It's a bit complex because the use is often inter
> > procedural.  I made a semantic patch for it, but I didn't invest a lot of
> > time in it because I wasn't sure if it would be considered to be useful,
> > or just useless churn.
>
> I believe such a patch would not be useless as
> it allows conversion of structures and arrays
> that are currently placed into r/w memory (data)
> to be moved to const (text).

I guess that for such a patch to be accepted, one would have to show that
it does permit that.

julia
