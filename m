From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 13 Jul 2015 13:48:36 -0400 (EDT)
Subject: [Cocci] Checking of OCaml functionality
In-Reply-To: <55A3F7DB.3090407@users.sourceforge.net>
References: <55A36680.1020707@users.sourceforge.net>
 <55A39908.6060600@users.sourceforge.net>
 <alpine.DEB.2.10.1507130657040.2561@hadrien>
 <55A3E506.90905@users.sourceforge.net>
 <alpine.DEB.2.10.1507131301110.6439@hadrien>
 <55A3F35F.5000501@users.sourceforge.net>
 <alpine.DEB.2.10.1507131322440.6439@hadrien>
 <55A3F7DB.3090407@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1507131347430.9638@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 13 Jul 2015, SF Markus Elfring wrote:

> > It seems that you are not getting the proper dynamic linking
> > with ocaml.
>
> Do you know a small test to check this aspect better?

No.  Your test is already as small as it can be.

> > Perhaps send the result of running configure.
>
> What do you hope to see there?

I would do a diff with my configuration and see if there is anything
different with respect to ocaml.

julia
