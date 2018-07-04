From: Thierry.Martinez@inria.fr (Thierry Martinez)
Date: Wed, 04 Jul 2018 18:00:40 +0200
Subject: [Cocci] Checking evolution around software build parameters
In-Reply-To: <b5366687-eac7-1a85-0c90-15b620b734d5@users.sourceforge.net>
References: <169e2663-6c92-c6ce-4b27-47d8494490f4@users.sourceforge.net>
 <alpine.DEB.2.20.1806031831320.2242@hadrien>
 <7e3bd4a1-daaf-5b84-5de2-c446cc0a4c1c@users.sourceforge.net>
 <alpine.DEB.2.20.1806032126430.2740@hadrien>
 <c8f05f51-fa3c-9770-ac99-20a23df8e4c3@users.sourceforge.net>
 <alpine.DEB.2.20.1806111248510.3334@hadrien>
 <b5366687-eac7-1a85-0c90-15b620b734d5@users.sourceforge.net>
Message-ID: <ow4bmbnvvmf.fsf@wifi-eduroam-85-166.paris.inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

SF Markus Elfring?:
> /usr/bin/ocamlc.opt -c commons/proc_pidpath_stubs.c
> gcc: error: unrecognized command line option
> ?-fstack-clash-protection?; did you mean ?-fstack-protector??

Thank you for reporting this. It seems that ocamlc assumes a version
of GCC more recent than the version installed on your system.

In commit c619caf8 (github master), I removed the C stubs and replaced
by pure OCaml implementations. The problem should have disappeared now.

Cheers,
-- 
Thierry.

SF Markus Elfring?:
>> delete [] is now supported by the C++ parser (ie with option --c++).
>
> Thanks for this software extension.
>
> Now I am curious on collateral evolution around this information.
>
> elfring at Sonne:~/Projekte/Coccinelle/20160205> git checkout master && git pull && ./autogen && ./configure && grep VERSION=1 Makefile.config && LANG=C make world
> ?
> VERSION=1.0.6-00452-g175de16b
> ?
> /usr/bin/ocamlc.opt -c commons/proc_pidpath_stubs.c
> gcc: error: unrecognized command line option ?-fstack-clash-protection?; did you mean ?-fstack-protector??
> make: *** [Makefile:633: commons/proc_pidpath_stubs.o] Error 2
>
>
> Are there any special dependencies to consider for the usage of
> the software ?OCaml 4.05.0-5.1? (on my openSUSE development system)?
>
> Regards,
> Markus
