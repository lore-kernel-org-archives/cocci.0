From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 29 Jan 2013 17:19:43 +0100 (CET)
Subject: [Cocci] coccinelle and bitmask arithmetic (was: Re: [patch]
 TTY: synclink, small cleanup in dtr_rts())
In-Reply-To: <1359475998.4196.26.camel@joe-AO722>
References: <20130127194039.GA18787@elgon.mountain>
 <1359317078.14406.12.camel@joe-AO722> <20130127201947.GO16282@mwanda>
 <9561.1359474916@turing-police.cc.vt.edu>
 <1359475998.4196.26.camel@joe-AO722>
Message-ID: <alpine.DEB.2.02.1301291717530.3339@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 29 Jan 2013, Joe Perches wrote:

> On Tue, 2013-01-29 at 10:55 -0500, Valdis.Kletnieks at vt.edu wrote:
> > On Sun, 27 Jan 2013 23:19:47 +0300, Dan Carpenter said:
> >
> > > Yeah.  I think it would be, but adding bitflags together instead of
> > > doing bitwise ORs is very common as well.
> >
> > The fact it's common doesn't mean it's good programming practice,
> > or even correct.  Consider:
> >
> > #define F_FOO 0x01
> > #define F_BAR 0x02
> > #define F_BAZ 0x04
> >
> > unsigned int flags = F_FOO;
> > ...
> >       flags |= F_BAR;
> >
> > Now some time later, another code path does this:
> >
> >       flags += F_FOO;
> >
> > If it was another |, it would be a no harm no foul class of bug.
> > But how long is it going to take you to figure out who set F_BAZ?
> >
> > I wonder if there's a way to write a coccinelle patch to find places
> > where we do arithmetic operations on bitmasks....
>
> Not so far as I know, but maybe someone on the
> cocci lists does. (cc'd)
>
> I could imagine a test for variables that have
> uses of both arithmetic and bit operations but
> not a discriminator for when one type is
> appropriate and the other is not.

If the definition of a bitmask is an identifier in all capital letters,
that would be easy.  Another possibility is such an identifier that is
defined to a value expressed beginning with 0x.  Another possibility is
such an identifier that is sometimes used with & and | and sometimes used
with an arithmetic operation.  I will give them a try.

julia
