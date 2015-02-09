From: Sebastien.Hinderer@inria.fr (=?utf-8?Q?S=C3=A9bastien?= Hinderer)
Date: Mon, 9 Feb 2015 09:21:15 +0100
Subject: [Cocci] Build errors with coccinelle 1.0.0-rc24 on OpenBSD and
 Linux
In-Reply-To: <20150208214908.GM24492@acyclic.org>
References: <20150208214908.GM24492@acyclic.org>
Message-ID: <20150209082115.GD1632@pl-59055.rocqadm.inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dear Douglas,

Thanks a lot for the report.

Doug Hogan (2015/02/08 13:49 -0800):
> There are two build errors with this release.  I think both are due to
> assuming you have parmap installed rather than using the bundled
> version.

As far as I know, the way it is supposed to work is rather the
opposite: the build system is supposed to unconditionnally use the
bundled version. It is also supposed to ignore an installed version,
which can of course be considered as not very optimal, but that's how
the situation is supposed to be currently.

> I get the same errors on OpenBSD and Linux.  I have built
> and used coccinelle in the past on both systems so I think this is a
> new problem with this release.

Indeed, as Julia mentionned, Parmap was not used befre so that's indeed
a new problem.

> For OpenBSD, I'm running OpenBSD -current with OCaml 4.02.1 (ports).
> For Linux, I'm running Debian testing with OCaml 4.01.0.

I'm also using Debian testing, just re-downloaded the archive of
1.0-rc24 rom Coccinlle's web site, unpacked, ran ./configure and make,
but onmy system it worked,so I'm unable o reproduce the problem so far.

> Here's the build failure.  This was on OpenBSD, but I get the same build
> failure on Linux.  This was without any changes other than running
> ./configure:
> 
> gmake[6]: Entering directory '/home/build/tmp/coccinelle-1.0.0-rc24/bundles/parmap/parmap-1.0-rc5-patched'
> ...
> ocamlc -c bytearray_stubs.c
> ocamlc -c -cc "gcc -D_GNU_SOURCE -o setcore_stubs.o -fPIC" setcore_stubs.c
> setcore_stubs.c: In function 'setcore':
> setcore_stubs.c:55: error: expected expression before 'else'
> Makefile:54: recipe for target 'setcore_stubs.o' failed
> gmake[6]: *** [setcore_stubs.o] Error 2
> gmake[6]: Leaving directory '/home/build/tmp/coccinelle-1.0.0-rc24/bundles/parmap/parmap-1.0-rc5-patched'
> ...
> 
> 
> Parmap has a bug that prevents it from building on any OS that doesn't
> have <mach/threads_policy.h> which includes OpenBSD and Linux.  Here's
> the syntax fix:
> 
> --- coccinelle-1.0.0-rc24.orig/bundles/parmap/parmap-1.0-rc5-patched/setcore_stubs.c	Wed Jan  7 16:58:46 2015
> +++ coccinelle-1.0.0-rc24/bundles/parmap/parmap-1.0-rc5-patched/setcore_stubs.c	Sun Feb  8 13:15:29 2015
> @@ -51,8 +51,8 @@ CAMLprim value setcore(value which) {
>          fprintf(stderr,"MAC OS X: Failed pinning to cpu %d, trying %d/2\n",w, w);
>          w=w/2;
>        }
> -#endif
>        else 
> +#endif
>  	{ //fprintf(stderr,"Succeeded pinning to cpu %d\n",w); 
>  	  finished=1;
>  	}

I indeed don't have this mc/thread_policy.h and it indeed seems it is
not present in any Debian package. So at the moment I don't understand
why things work here and not for you.

It may also depend on how HAVE_DECL_SCHED_SETAFFINITY is handled, since
that block ends with an if statemen. So presumably, that block is
included on you system and not on mine and may be why you get the error
and I don't.

> Even with this fix, it fails to build on both OSes.  It's the same
> failure with both OpenBSD and Linux (Unbound module Parmap).
> 
> gmake[4]: Leaving directory '/home/build/tmp/coccinelle-1.0.0-rc24/bundles/parmap'
> ...
> /usr/local/bin/ocamlopt.opt -unsafe -cclib -lparmap_stubs -I /home/build/tmp/coccinelle-1.0.0-rc24/bundles/menhirLib/ -I /home/build/tmp/coccinelle-1.0.0-rc24/bundles/pycaml/ -I /usr/local/lib/ocaml -I /usr/local/lib/ocaml/pcre -I bundles/parmap/parmap-1.0-rc5-patched/_build -I commons -I commons/ocamlextra -I ctl -I engine -I extra -I globals -I ocaml -I parsing_c -I parsing_cocci -I popl09 -I python -c main.ml
> File "./main.ml", line 956, characters 35-60:
> Error: Unbound module Parmap
> Makefile:660: recipe for target 'main.cmx' failed
> gmake[3]: *** [main.cmx] Error 2
> gmake[3]: Leaving directory '/home/build/tmp/coccinelle-1.0.0-rc24'
> ...
> 
> 
> On Debian, if I install libparmap-ocaml and libparmap-ocaml-dev, then
> I can build coccinelle.  I presume that's because it doesn't use this
> bundled version and the system version is picked up in a different
> manner than the bundled version.

It may be more subtle, e.g. it uses some files of the installed version
and some files of the bundled version.

S?bastien.
