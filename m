From: thierry.martinez@inria.fr (Thierry Martinez)
Date: Wed, 11 Oct 2017 15:28:13 +0200 (CEST)
Subject: [Cocci] make install broken
In-Reply-To: <5ecbf5f5-0af4-7c44-258e-c2b464d9a01f@mykolab.com>
References: <9bf92fad-06e9-b1d5-cae2-6ba4fb9fc022@mykolab.com>
 <alpine.DEB.2.20.1710061604140.6420@hadrien>
 <5ecbf5f5-0af4-7c44-258e-c2b464d9a01f@mykolab.com>
Message-ID: <1237246237.5049793.1507728493328.JavaMail.zimbra@inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Michael Stefaniuc:
> But it isn't working when I have a symlink to spatch.

This surprises me because this is precisely what 82a6a045 is supposed to fix,
and your version 3ba77b3 includes it.

I suppose it is because your shell does not define the environment variable
"_" to the path of the running executable.

I just pushed on GitHub a more portable way for determining the path of the
executable relying on proc_pidpath.

Thank you for the report.
-- 
Thierry Martinez.

----- Original Message -----
> From: "Michael Stefaniuc" <mstefani@mykolab.com>
> To: "Julia Lawall" <julia.lawall@lip6.fr>
> Cc: cocci at systeme.lip6.fr
> Sent: Friday, October 6, 2017 9:03:44 PM
> Subject: Re: [Cocci] make install broken
> 
> On 10/06/2017 04:04 PM, Julia Lawall wrote:
> > The makefile issues are perhaps now resolved.
> Looks better as the missing stuff is installed.
> But it isn't working when I have a symlink to spatch.
> 
> My workflow:
> 
> VERSION=`git describe`
> ./configure --prefix=/usr/local/packages/coccinelle-$VERSION
> make
> make install
> cd /usr/local/bin
> ln -sf ../packages/coccinelle-$VERSION/bin/* .
> 
> spatch foo.cocci foo.c
> warning: Can't find macro file: ./../lib/coccinelle/standard.h
> init_defs: ./macros
> warning: Can't find default iso file: ./../lib/coccinelle/standard.iso
> Python error: No module named 'coccilib'
> 
> Using an absolute symbolic link doesn't works either.
> Using an absolute PATH to spatch makes it work:
> /usr/local/packages/coccinelle-1.0.6-328-g3ba77b3/bin/spatch foo.cocci foo.c
> 
> coccinelle-1.0.6-179-g058cb06 is the last version that I have compiled
> and works with the symlinks.
> 
> No clue is there is something similar in OCaml but under perl there is
> the handy FindBin module (FindBin::RealBin) to find the real location of
> the binary.
> 
> bye
> 	michael
> 
> > 
> > julia
> > 
> > On Tue, 3 Oct 2017, Michael Stefaniuc wrote:
> > 
> >> Hello,
> >>
> >> while my Makefile patch lets make install finish a lot of stuff is
> >> missing:
> >> spatch foo.cocci foo.c
> >> warning: Can't find macro file: ./../lib/coccinelle/standard.h
> >> warning: Can't find default iso file: ./../lib/coccinelle/standard.iso
> >> Python error: No module named 'coccilib'
> >>
> >> Only this stuff gets installed:
> >> find /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/
> >> /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/
> >> /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/bin
> >> /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/bin/spatch
> >> /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/bin/spgen
> >> /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/lib
> >> /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/lib/coccinelle
> >> /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/lib/coccinelle/dllpyml_stubs.so
> >> /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/etc
> >> /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/etc/bash_completion.d
> >> /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/etc/bash_completion.d/spatch
> >>
> >>
> >> bye
> >>          michael
> >> _______________________________________________
> >> Cocci mailing list
> >> Cocci at systeme.lip6.fr
> >> https://systeme.lip6.fr/mailman/listinfo/cocci
> >>
> 
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
