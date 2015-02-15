From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Sun, 15 Feb 2015 12:15:56 -0800
Subject: [Cocci] remove typedefs from struct
In-Reply-To: <alpine.DEB.2.02.1502151828021.2278@localhost6.localdomain6>
References: <54E0D3D1.9070608@users.sourceforge.net>
 <alpine.DEB.2.02.1502151828021.2278@localhost6.localdomain6>
Message-ID: <3b59128bc4e8416abb9f27705cdb413e@BN1BFFO11FD039.protection.gbl>
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

Good point. I hadn't looked into such cases yet and the codebase I'm
looking at doesn't have attributes or comments in that line. But in
general, it seems to make sense changing the patch this way.
I didn't even expect such a change would have any effect on the result. I
have a lot to learn still :)

> 
> Another issue is that the typedef name might be (closer to) the one that 
> ou want to preserve.  And i is not even necessary, I believe.  You could 
> have another rule for the case where it is not present.

Right. In my case, the typedefs consistently use i and t with i and t
even being identical. I guess it depends on your sources which one you
want to preserve. My assumption is that we'd have something like
 typedef struct foo {...} foo_t;
which would make i more appropriate to preserve than t. But depending on
the coding style your sources follow things can look quite different, I
suppose.

	Thanks,
	Soren
