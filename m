From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Sat, 18 Jun 2016 00:33:27 +0200
Subject: [Cocci] [PATCH] bundles/pycaml/: force pycaml preparation to be
 done serially
In-Reply-To: <20160617184724.GW11948@wotan.suse.de>
References: <1466186657-25309-1-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.10.1606172009220.3164@hadrien>
 <20160617184724.GW11948@wotan.suse.de>
Message-ID: <20160617223327.GX11948@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Jun 17, 2016 at 08:47:24PM +0200, Luis R. Rodriguez wrote:
> On Fri, Jun 17, 2016 at 08:10:14PM +0200, Julia Lawall wrote:
> > 
> > 
> > On Fri, 17 Jun 2016, Luis R. Rodriguez wrote:
> > 
> > > This fixes parallel compilation when using 32 threads on a 32-core
> > > system:
> > >
> > > The error:
> > >
> > > make[6]: Entering directory '/home/mcgrof/coccinelle/bundles/pycaml'
> > > /usr/bin/ocamlopt.opt -I chemoelectric-pycaml-8614105 -cclib
> > > -lpycaml_stubs -ccopt -I/usr/include/python2.7 -ccopt
> > > -I/usr/include/x86_64-linux-gnu/python2.7 -cclib -lpython2.7 -c
> > > chemoelectric-pycaml-8614105/pycaml.ml -o
> > > chemoelectric-pycaml-8614105/pycaml.cmx
> > > make[6]: *** No rule to make target
> > > 'chemoelectric-pycaml-8614105/pycaml.a', needed by
> > > 'all-opt-build-targets'.  Stop.
> > > make[6]: *** Waiting for unfinished jobs....
> > > make[6]: Leaving directory '/home/mcgrof/coccinelle/bundles/pycaml'
> > > ../Makefile.bundles:33: recipe for target 'all.opt' failed
> > > make[5]: *** [all.opt] Error 2
> > > make[5]: Leaving directory '/home/mcgrof/coccinelle/bundles/pycaml'
> > > Makefile:186: recipe for target
> > > '/home/mcgrof/coccinelle/bundles/pycaml/.opt' failed
> > > make[4]: *** [/home/mcgrof/coccinelle/bundles/pycaml/.opt] Error 2
> > > make[4]: Leaving directory '/home/mcgrof/coccinelle'
> > > Makefile:180: recipe for target 'subdirs.opt' failed
> > > make[3]: *** [subdirs.opt] Error 1
> > > make[3]: Leaving directory '/home/mcgrof/coccinelle'
> > > Makefile:163: recipe for target 'opt-compil' failed
> > > make[2]: *** [opt-compil] Error 2
> > > make[2]: Leaving directory '/home/mcgrof/coccinelle'
> > > Makefile:143: recipe for target 'all-release' failed
> > > make[1]: *** [all-release] Error 2
> > > make[1]: Leaving directory '/home/mcgrof/coccinelle'
> > > Makefile:121: recipe for target 'all' failed
> > > make: *** [all] Error 2
> > >
> > > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> > > ---
> > >  bundles/pycaml/Makefile | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/bundles/pycaml/Makefile b/bundles/pycaml/Makefile
> > > index 5045c27..4a619f4 100644
> > > --- a/bundles/pycaml/Makefile
> > > +++ b/bundles/pycaml/Makefile
> > > @@ -17,6 +17,8 @@ export PYMAJOR=$(shell echo ${PYTHON_VERSION} | sed -e 's/\..*//')
> > >
> > >  include ../Makefile.bundles
> > >
> > > +.NOTPARALLEL: .prepare
> > > +
> > >  .prepare: $(MARKER)
> > >  	rm -f "$(SRC_DIR)/pycaml.mli"
> > >  	$(CC) -E -w -D PYMAJOR$(PYMAJOR) -xc pycaml.pp.ml >$(SRC_DIR)/pycaml.ml
> > 
> > Thanks for the patch.  I'm not sure that it will address all possible
> > issues,
> 
> Agreed.
> 
> > but if it is an improvement, then ok.
> 
> It makes parallel building work with a minimal change. The bigger
> hammer is to not trust any bundles and add +.NOTPARALLEL: all to
> the top level bundles/Makefile, that was my first approach, however
> it didn't seem like a good idea either as then you'd slow the bundle
> build generally.

I actually thing we also need .ONESHELL on all bundle Makefiles as well.
This alone does not suffice to make it build correctly, however it seems
this is correct. So the following patch seems more appropriate. Let
me know.

>From 850cc1b16132d4984d1f4c61eea36472571db44b Mon Sep 17 00:00:00 2001
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Fri, 17 Jun 2016 17:08:40 +0000
Subject: [PATCH] bundles/pycaml/: use .ONESHELL and .NOTPARALLEL on bundles

Bundles need their preparation to run in one shell [0], for pycaml
we also need to disable parallel builds on the preparation. The
.ONESHELL can be placed anywhere in the file.

[0] https://www.gnu.org/software/make/manual/make.html#Execution

This fixes parallel compilation when using 32 threads on a 32-core
system:

The error:

make[6]: Entering directory '/home/mcgrof/coccinelle/bundles/pycaml'
/usr/bin/ocamlopt.opt -I chemoelectric-pycaml-8614105 -cclib
-lpycaml_stubs -ccopt -I/usr/include/python2.7 -ccopt
-I/usr/include/x86_64-linux-gnu/python2.7 -cclib -lpython2.7 -c
chemoelectric-pycaml-8614105/pycaml.ml -o
chemoelectric-pycaml-8614105/pycaml.cmx
make[6]: *** No rule to make target
'chemoelectric-pycaml-8614105/pycaml.a', needed by
'all-opt-build-targets'.  Stop.
make[6]: *** Waiting for unfinished jobs....
make[6]: Leaving directory '/home/mcgrof/coccinelle/bundles/pycaml'
../Makefile.bundles:33: recipe for target 'all.opt' failed
make[5]: *** [all.opt] Error 2
make[5]: Leaving directory '/home/mcgrof/coccinelle/bundles/pycaml'
Makefile:186: recipe for target
'/home/mcgrof/coccinelle/bundles/pycaml/.opt' failed
make[4]: *** [/home/mcgrof/coccinelle/bundles/pycaml/.opt] Error 2
make[4]: Leaving directory '/home/mcgrof/coccinelle'
Makefile:180: recipe for target 'subdirs.opt' failed
make[3]: *** [subdirs.opt] Error 1
make[3]: Leaving directory '/home/mcgrof/coccinelle'
Makefile:163: recipe for target 'opt-compil' failed
make[2]: *** [opt-compil] Error 2
make[2]: Leaving directory '/home/mcgrof/coccinelle'
Makefile:143: recipe for target 'all-release' failed
make[1]: *** [all-release] Error 2
make[1]: Leaving directory '/home/mcgrof/coccinelle'
Makefile:121: recipe for target 'all' failed
make: *** [all] Error 2

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 bundles/menhirLib/Makefile | 1 +
 bundles/parmap/Makefile    | 1 +
 bundles/pcre/Makefile      | 1 +
 bundles/pycaml/Makefile    | 2 ++
 4 files changed, 5 insertions(+)

diff --git a/bundles/menhirLib/Makefile b/bundles/menhirLib/Makefile
index 23ac0d6..59b8fe0 100644
--- a/bundles/menhirLib/Makefile
+++ b/bundles/menhirLib/Makefile
@@ -33,6 +33,7 @@ include ../Makefile.bundles
 depend: .depend
 	@$(MAKE) all-build
 
+.ONESHELL:
 .prepare: $(MARKER)
 	echo "let libdir = \"$(shell pwd\)\"" > $(SRC_DIR)/installation.ml
 	echo "let ocamlfind = false" >> $(SRC_DIR)/installation.ml
diff --git a/bundles/parmap/Makefile b/bundles/parmap/Makefile
index 67c65ec..4436ba9 100644
--- a/bundles/parmap/Makefile
+++ b/bundles/parmap/Makefile
@@ -17,6 +17,7 @@ OCAMLCCFLAGS+=-ccopt -D_GNU_SOURCE
 
 include ../Makefile.bundles
 
+.ONESHELL:
 .prepare: $(MARKER)
 	cd $(SRC_DIR) && ./configure
 	touch $@
diff --git a/bundles/pcre/Makefile b/bundles/pcre/Makefile
index 97aa12e..9cfbf88 100644
--- a/bundles/pcre/Makefile
+++ b/bundles/pcre/Makefile
@@ -24,6 +24,7 @@ EXTRALNKFLAGS=$(PCRE_LIBS:%=-ldopt %)
 
 include ../Makefile.bundles
 
+.ONESHELL:
 .prepare: $(MARKER)
 	if [ "$$OCAMLVERSION" "<" 4.02.0 ]; then \
 	  cp $(SRC_DIR)/pcre_compat312.ml $(SRC_DIR)/pcre_compat.ml; \
diff --git a/bundles/pycaml/Makefile b/bundles/pycaml/Makefile
index 5045c27..bded209 100644
--- a/bundles/pycaml/Makefile
+++ b/bundles/pycaml/Makefile
@@ -17,6 +17,8 @@ export PYMAJOR=$(shell echo ${PYTHON_VERSION} | sed -e 's/\..*//')
 
 include ../Makefile.bundles
 
+.ONESHELL:
+.NOTPARALLEL: .prepare
 .prepare: $(MARKER)
 	rm -f "$(SRC_DIR)/pycaml.mli"
 	$(CC) -E -w -D PYMAJOR$(PYMAJOR) -xc pycaml.pp.ml >$(SRC_DIR)/pycaml.ml
-- 
2.8.1
