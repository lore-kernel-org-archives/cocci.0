From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 12 Jul 2013 09:00:35 +0200 (CEST)
Subject: [Cocci] gboolean -> bool conversion
In-Reply-To: <51DFA84A.4050805@monom.org>
References: <51DE6A05.9050008@monom.org>
 <alpine.DEB.2.02.1307111026390.2253@hadrien> <51DE75BF.3060207@monom.org>
 <51DE81CC.3010805@monom.org> <alpine.DEB.2.02.1307111221320.2253@hadrien>
 <51DE944F.1000903@monom.org> <alpine.DEB.2.02.1307111417120.2253@hadrien>
 <51DEA75C.10309@monom.org> <alpine.DEB.2.02.1307111451080.2253@hadrien>
 <51DFA84A.4050805@monom.org>
Message-ID: <alpine.DEB.2.02.1307120858060.2013@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 12 Jul 2013, Daniel Wagner wrote:

> Hi Julia,
> 
> On 07/11/2013 03:07 PM, Julia Lawall wrote:
> > > I am pondering if it would be possible to say
> > > 
> > > - gboolean
> > > 	when != 'static gboolean func(gpointer)'
> > > + bool
> > 
> > No, this is not possible.  Is the idea that you don't want to change the
> > return type of a static function?  Then you can record the position of the
> > gbooleans that you don't want to change, and only change the others.
> 
> It is so obvious when you explain it. Thanks a lot.
> 
> > An example is as follows:
> > 
> > @keep@
> > identifier f;
> > position p;
> > typedef	gpointer;
> > identifier i;
> > @@
> > 
> > static gboolean at p f(gpointer i)	{ ... }
> > 
> > @@
> > typedef bool;
> > position p != keep.p;
> > @@
> > 
> > - gboolean at p
> > + bool
> > 
> 
> With some small modification this works fine now.
> 
> The only outstanding problem I'd like to address is patching the function
> calls.
> 
> Let's say I have this deceleration (which will be changed by the above
> rules):
> 
> 	int foo(gboolean b);
> 
> and some place I call then
> 
> 	foo(FALSE);
> 
> This should be changed to
> 
> 	foo(false);
> 
> > Note that you could never refer to
> > 
> > static gboolean func(gpointer)
> > 
> > because it is not a complete syntactic unit.  If you wanted to mention a
> > prototype, you would need a ; after it.  If you wanted to mention the
> > definition, then you need to put the complete definition, as shown above.
> 
> I see. Thanks again for explaining.


@r@
identifier f;
parameter list[n] ps;
identifier i;
@@

f(ps, gboolean i, ...) { ... }

@@
identifier r.f;
expression list [r.n] es;
@@

f(es,
(
- FALSE
+ false
|
- TRUE
+ true
)
 ,...)


I have not tested this, but it should work.  Write back if you have 
problems.

julia
