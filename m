From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Sun, 15 Feb 2015 20:31:26 -0800
Subject: [Cocci] remove typedefs from struct
In-Reply-To: <alpine.DEB.2.02.1502151828021.2278@localhost6.localdomain6>
References: <54E0D3D1.9070608@users.sourceforge.net>
 <alpine.DEB.2.02.1502151828021.2278@localhost6.localdomain6>
Message-ID: <a1d292690ef1492c8c3f14978b59843f@BN1AFFO11FD020.protection.gbl>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 2015-02-15 at 06:32PM +0100, Julia Lawall wrote:
> On Sun, 15 Feb 2015, SF Markus Elfring wrote:
> 
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
> > 
> > How do you think about a bit more fine-tuning for your SmPL approach?
> > 
> >  ...
> >  }
> > -t
> >  ;
> > 
> > Is it sufficient to express the desired deletion at this place?
> 
> It is possible, but perhaps not necessary.  It would depend on whether 
> there are any comments or attributes between the } and the ; that need to 
> be preserved.  Currently they will be removed.
> 
> Another issue is that the typedef name might be (closer to) the one that 
> ou want to preserve.  And i is not even necessary, I believe.  You could 
> have another rule for the case where it is not present.

Sorry for bugging you again, but I tried to create a rule for cases that
don't name the struct. E.g.
  typedef struct {
  	int bar;
  } foo;

My problem seems to be, that a struct identifier is an identifier, while
the newly created type is a type. Hence, my naive approach:
@@
type t;
@@
-typedef struct {
+struct t {
	...
}
- t
;

does not work. And thus far, I couldn't find a way to get around this. I
suspect there is some subtle trick to make it do what I want but I'm
just not seeing it.

	Soren
