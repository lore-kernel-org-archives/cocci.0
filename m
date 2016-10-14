From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 14 Oct 2016 13:10:45 +0200 (CEST)
Subject: [Cocci] Replacing calls of general functions by more specific
 ones with SmPL
In-Reply-To: <11ec513e-cc4d-4748-4fb0-e44088a5f223@users.sourceforge.net>
References: <8c2c37de-baee-8282-b5cc-ad6eea3bb66f@users.sourceforge.net>
 <alpine.DEB.2.10.1610141019550.3002@hadrien>
 <2d2a0414-0e23-790b-e99c-0220ffda2b35@users.sourceforge.net>
 <alpine.DEB.2.10.1610141101550.3272@hadrien>
 <11ec513e-cc4d-4748-4fb0-e44088a5f223@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1610141309260.3203@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> * But I will also need a way to construct a source code change ("plus code" in
>   the semantic patch) with OCaml or Python scripting, won't I?

If you need to do this, you can follow the examples in
demos/camltococci.cocci and demos/pythontococci.cocci

julia
