From: doug@acyclic.org (Doug Hogan)
Date: Sun, 8 Feb 2015 13:49:08 -0800
Subject: [Cocci] Build errors with coccinelle 1.0.0-rc24 on OpenBSD and Linux
Message-ID: <20150208214908.GM24492@acyclic.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

There are two build errors with this release.  I think both are due to
assuming you have parmap installed rather than using the bundled
version.  I get the same errors on OpenBSD and Linux.  I have built
and used coccinelle in the past on both systems so I think this is a
new problem with this release.

For OpenBSD, I'm running OpenBSD -current with OCaml 4.02.1 (ports).
For Linux, I'm running Debian testing with OCaml 4.01.0.

On both OSes, I just installed ocaml and ocaml-findlib (plus whatever
dependencies they dragged in).


Here's the build failure.  This was on OpenBSD, but I get the same build
failure on Linux.  This was without any changes other than running
./configure:

gmake[6]: Entering directory '/home/build/tmp/coccinelle-1.0.0-rc24/bundles/parmap/parmap-1.0-rc5-patched'
...
ocamlc -c bytearray_stubs.c
ocamlc -c -cc "gcc -D_GNU_SOURCE -o setcore_stubs.o -fPIC" setcore_stubs.c
setcore_stubs.c: In function 'setcore':
setcore_stubs.c:55: error: expected expression before 'else'
Makefile:54: recipe for target 'setcore_stubs.o' failed
gmake[6]: *** [setcore_stubs.o] Error 2
gmake[6]: Leaving directory '/home/build/tmp/coccinelle-1.0.0-rc24/bundles/parmap/parmap-1.0-rc5-patched'
...


Parmap has a bug that prevents it from building on any OS that doesn't
have <mach/threads_policy.h> which includes OpenBSD and Linux.  Here's
the syntax fix:

--- coccinelle-1.0.0-rc24.orig/bundles/parmap/parmap-1.0-rc5-patched/setcore_stubs.c	Wed Jan  7 16:58:46 2015
+++ coccinelle-1.0.0-rc24/bundles/parmap/parmap-1.0-rc5-patched/setcore_stubs.c	Sun Feb  8 13:15:29 2015
@@ -51,8 +51,8 @@ CAMLprim value setcore(value which) {
         fprintf(stderr,"MAC OS X: Failed pinning to cpu %d, trying %d/2\n",w, w);
         w=w/2;
       }
-#endif
       else 
+#endif
 	{ //fprintf(stderr,"Succeeded pinning to cpu %d\n",w); 
 	  finished=1;
 	}


Even with this fix, it fails to build on both OSes.  It's the same
failure with both OpenBSD and Linux (Unbound module Parmap).

gmake[4]: Leaving directory '/home/build/tmp/coccinelle-1.0.0-rc24/bundles/parmap'
...
/usr/local/bin/ocamlopt.opt -unsafe -cclib -lparmap_stubs -I /home/build/tmp/coccinelle-1.0.0-rc24/bundles/menhirLib/ -I /home/build/tmp/coccinelle-1.0.0-rc24/bundles/pycaml/ -I /usr/local/lib/ocaml -I /usr/local/lib/ocaml/pcre -I bundles/parmap/parmap-1.0-rc5-patched/_build -I commons -I commons/ocamlextra -I ctl -I engine -I extra -I globals -I ocaml -I parsing_c -I parsing_cocci -I popl09 -I python -c main.ml
File "./main.ml", line 956, characters 35-60:
Error: Unbound module Parmap
Makefile:660: recipe for target 'main.cmx' failed
gmake[3]: *** [main.cmx] Error 2
gmake[3]: Leaving directory '/home/build/tmp/coccinelle-1.0.0-rc24'
...


On Debian, if I install libparmap-ocaml and libparmap-ocaml-dev, then
I can build coccinelle.  I presume that's because it doesn't use this
bundled version and the system version is picked up in a different
manner than the bundled version.
