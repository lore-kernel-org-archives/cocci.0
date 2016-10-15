From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 15 Oct 2016 09:33:50 +0200 (CEST)
Subject: [Cocci] Replacing calls of general functions by more specific
 ones with SmPL
In-Reply-To: <db49dd34-98f8-c9ff-c05b-015d16d71e68@users.sourceforge.net>
References: <8c2c37de-baee-8282-b5cc-ad6eea3bb66f@users.sourceforge.net>
 <alpine.DEB.2.10.1610141019550.3002@hadrien>
 <db49dd34-98f8-c9ff-c05b-015d16d71e68@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1610150933070.9280@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 15 Oct 2016, SF Markus Elfring wrote:

> > The simplest would be to use python or ocaml code to make the checks that
> > are needed.  You can use cocci.include_match(False) in python or
> > Coccilib.include_match false in ocaml when your test detects that
> > something is not suitable.
>
> Will it occasionally matter then to distinguish better if a specific source code
> fragment or a complete source file should be excluded from an analysis run
> on demand?

I have no idea what you mean by this.  But since I know very little about
this printing problem in general, I doubt that I can give an answer.  Try
it and see what requirements turn up.

julia
