From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 13 Jul 2015 14:07:32 -0400 (EDT)
Subject: [Cocci] Checking of OCaml functionality
In-Reply-To: <55A3FD82.2080508@users.sourceforge.net>
References: <55A36680.1020707@users.sourceforge.net>
 <55A39908.6060600@users.sourceforge.net>
 <alpine.DEB.2.10.1507130657040.2561@hadrien>
 <55A3E506.90905@users.sourceforge.net>
 <alpine.DEB.2.10.1507131301110.6439@hadrien>
 <55A3F35F.5000501@users.sourceforge.net>
 <alpine.DEB.2.10.1507131322440.6439@hadrien>
 <55A3F7DB.3090407@users.sourceforge.net>
 <alpine.DEB.2.10.1507131347430.9638@hadrien>
 <55A3FD82.2080508@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1507131406440.9638@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 13 Jul 2015, SF Markus Elfring wrote:

> > I would do a diff with my configuration and see if there is anything
> > different with respect to ocaml.
>
> The software "OCaml 4.02.1-1.2" was provided by a RPM package
> from my Linux distribution.
> https://build.opensuse.org/package/show?project=openSUSE%3AFactory&package=ocaml
>
>
> Your tool "spatch 1.0.1" was built on my own here.
>
> Where do you imagine to find interesting differences?

I asked about the output of the configure program.  The software can be
fine, but it will not do the right thing if it is configured properly.

julia
