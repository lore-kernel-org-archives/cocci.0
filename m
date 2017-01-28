From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 28 Jan 2017 07:47:23 +0100 (CET)
Subject: [Cocci] modifying initializers with spatch?
In-Reply-To: <1485559204.14579.16.camel@sipsolutions.net>
References: <1485433691.14760.1.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261415040.3109@hadrien>
 <1485437521.14760.5.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261518560.3109@hadrien>
 <1485440882.14760.8.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261644140.3109@hadrien>
 <1485445951.14760.16.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261655450.3109@hadrien>
 <1485553437.14579.4.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701272250210.2830@hadrien>
 <1485554630.14579.6.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701272309260.3612@hadrien>
 <1485558136.14579.14.camel@sipsolutions.net>
 <1485559204.14579.16.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.20.1701280743530.2822@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 28 Jan 2017, Johannes Berg wrote:

> On Sat, 2017-01-28 at 00:02 +0100, Johannes Berg wrote:
> > On Fri, 2017-01-27 at 23:09 +0100, Julia Lawall wrote:
> > >
> > > Ok, sounds good.??Let me know if you encounter further problems.
> >
> > I've now ended up with the following overall:
> > https://p.sipsolutions.net/15e6265ea961d9a6.txt
> >
> > Interestingly, that takes minutes to run on this file:
> > https://w1.fi/cgit/hostap/tree/wpa_supplicant/dbus/dbus_new_handlers_
> > p2p.c
>
> Well, it's been 20 minutes - I'm giving up :)

It seems that the control flow was quite complete in one function, and the
when any at the end of the rule was taking a long time.  But actually you
don't need the outer ... and braces at all.  Furthermore, from the initial
declaration to the first following statement, there should be no branches,
so it is safe to put exists on each rule, ie trace through each possible
control-flow path individually.  The revised semantic patch is attached.
It terminates quite quickly.

You can add an option --timeout 120, or some other number of seconds.  It
will tell you if there are any timeouts, so you can see where there may
be problems.

julia
-------------- next part --------------
@nonconst1@
type T;
identifier x;
position p;
@@
const T x at p = { ... };

@exists@
type T;
expression E;
statement S1, S2;
identifier x;
identifier f;
position p != nonconst1.p;
@@

 T x at p = {
-  .f = E,
 };
... when != S1
++ x.f = E;
 S2

@nonconst2@
type T;
identifier x;
position p;
@@
const T x at p = { ... };

@exists@
type T;
statement S1, S2;
identifier x;
position p != nonconst2.p;
@@

 T x at p
- = {0}
 ;
... when != S1
    when != x
++ _memclr(&x, sizeof(x));
 S2

@nonconst3@
type T;
identifier x;
position p;
@@
const T x at p = { ... };

@exists@
type T;
statement S1, S2;
identifier x;
position p != nonconst3.p;
@@

 T x at p
- = {}
 ;
... when != S1
    when != x
++ _memclr(&x, sizeof(x));
 S2
