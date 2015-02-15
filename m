From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 15 Feb 2015 18:32:11 +0100 (CET)
Subject: [Cocci] remove typedefs from struct
In-Reply-To: <54E0D3D1.9070608@users.sourceforge.net>
References: <2bb2afa2a75f464b900af8506ddc84dd@BN1BFFO11FD029.protection.gbl>
 <54E0D3D1.9070608@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1502151828021.2278@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 15 Feb 2015, SF Markus Elfring wrote:

> >   /// Convert typdefed structs to structs
> >   
> >   @ rule1 @
> >   identifier i;
> >   type t;
> >   @@
> >   -typedef struct i {
> >   +struct i {
> >   	...
> >   - }t;
> >   + };
> 
> How do you think about a bit more fine-tuning for your SmPL approach?
> 
>  ...
>  }
> -t
>  ;
> 
> Is it sufficient to express the desired deletion at this place?

It is possible, but perhaps not necessary.  It would depend on whether 
there are any comments or attributes between the } and the ; that need to 
be preserved.  Currently they will be removed.

Another issue is that the typedef name might be (closer to) the one that 
ou want to preserve.  And i is not even necessary, I believe.  You could 
have another rule for the case where it is not present.

julia
