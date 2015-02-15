From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 15 Feb 2015 10:38:00 +0100 (CET)
Subject: [Cocci] remove typedefs from struct
In-Reply-To: <db4839c19266450b88ea802a7c5ab597@BL2FFO11FD013.protection.gbl>
References: <2bb2afa2a75f464b900af8506ddc84dd@BN1BFFO11FD029.protection.gbl>
 <alpine.DEB.2.10.1502141955040.6185@hadrien>
 <db4839c19266450b88ea802a7c5ab597@BL2FFO11FD013.protection.gbl>
Message-ID: <alpine.DEB.2.02.1502151036100.2033@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 14 Feb 2015, S?ren Brinkmann wrote:

> Hi Julia,
> 
> On Sat, 2015-02-14 at 07:56PM +0100, Julia Lawall wrote:
> > On Sat, 14 Feb 2015, S?ren Brinkmann wrote:
> > 
> > > Hi,
> > >
> > > I'm just getting my feet wet with coccinelle, so I'm probably missing
> > > something really obvious in my problem.
> > >
> > > I have a codebase that uses plenty of
> > >   typedef struct foo {
> > >   	...
> > >   } bar;
> > >
> > > I want to remove all these typedefs and simply use struct foo instead. I
> > > came up with this patch:
> > >
> > >   /// Convert typdefed structs to structs
> > >
> > >   @ rule1 @
> > >   identifier i;
> > >   type t;
> > >   @@
> > >   -typedef struct i {
> > >   +struct i {
> > >   	...
> > >   - }t;
> > >   + };
> > >
> > >   @@
> > >   identifier rule1.i;
> > >   type rule1.t;
> > >   @@
> > >   -t
> > >   +struct i
> > >   // end of patch
> > >
> > > This seems to work for most occurrences, but there are a couple of
> > > variables defined like this:
> > >
> > >   static const t *const baz[MAX] = {
> > >   	...
> > >   };
> > >
> > > And also function declarations like:
> > >   u32 fn(const t* const baz);
> > >
> > > In such cases, t isn't replaces as I would expect, but those lines
> > > aren't changed at all.
> > >
> > > Other variables and non-const function parameters seem to be replaced as
> > > expected.
> > > Does anybody have an idea what I'm missing?

OK, the issue is that const is considered to be part of the type, so when 
you have a metavariable that contains type foo, it doesn't match an 
occurrence of const foo.  I'm not sure if it is correct to consider const 
to be part of the type, but I'm also not eager to change it.  Could you 
live with the solution of just making one more rule:

@@
identifier rule1.i;
type rule1.t;
@@
 const
-t
+struct i

julia
