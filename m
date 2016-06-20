From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Mon, 20 Jun 2016 15:20:06 -0700
Subject: [Cocci] [PATCH v3] bundles/pycaml/: use .NOTPARALLEL on bundles
Message-ID: <1466461206-6960-1-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

We need to disable parallel builds on the preparation of bundles.
This fixes parallel compilation when using 32 threads on a 32-core
system and on an 8 core system:

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

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 bundles/menhirLib/Makefile | 1 +
 bundles/parmap/Makefile    | 1 +
 bundles/pcre/Makefile      | 1 +
 bundles/pycaml/Makefile    | 1 +
 4 files changed, 4 insertions(+)

diff --git a/bundles/menhirLib/Makefile b/bundles/menhirLib/Makefile
index 23ac0d6..e1bc4d2 100644
--- a/bundles/menhirLib/Makefile
+++ b/bundles/menhirLib/Makefile
@@ -33,6 +33,7 @@ include ../Makefile.bundles
 depend: .depend
 	@$(MAKE) all-build
 
+.NOTPARALLEL: .prepare
 .prepare: $(MARKER)
 	echo "let libdir = \"$(shell pwd\)\"" > $(SRC_DIR)/installation.ml
 	echo "let ocamlfind = false" >> $(SRC_DIR)/installation.ml
diff --git a/bundles/parmap/Makefile b/bundles/parmap/Makefile
index 67c65ec..675a71d 100644
--- a/bundles/parmap/Makefile
+++ b/bundles/parmap/Makefile
@@ -17,6 +17,7 @@ OCAMLCCFLAGS+=-ccopt -D_GNU_SOURCE
 
 include ../Makefile.bundles
 
+.NOTPARALLEL: .prepare
 .prepare: $(MARKER)
 	cd $(SRC_DIR) && ./configure
 	touch $@
diff --git a/bundles/pcre/Makefile b/bundles/pcre/Makefile
index 97aa12e..4a07d2f 100644
--- a/bundles/pcre/Makefile
+++ b/bundles/pcre/Makefile
@@ -24,6 +24,7 @@ EXTRALNKFLAGS=$(PCRE_LIBS:%=-ldopt %)
 
 include ../Makefile.bundles
 
+.NOTPARALLEL: .prepare
 .prepare: $(MARKER)
 	if [ "$$OCAMLVERSION" "<" 4.02.0 ]; then \
 	  cp $(SRC_DIR)/pcre_compat312.ml $(SRC_DIR)/pcre_compat.ml; \
diff --git a/bundles/pycaml/Makefile b/bundles/pycaml/Makefile
index 5045c27..0ee7757 100644
--- a/bundles/pycaml/Makefile
+++ b/bundles/pycaml/Makefile
@@ -17,6 +17,7 @@ export PYMAJOR=$(shell echo ${PYTHON_VERSION} | sed -e 's/\..*//')
 
 include ../Makefile.bundles
 
+.NOTPARALLEL: .prepare
 .prepare: $(MARKER)
 	rm -f "$(SRC_DIR)/pycaml.mli"
 	$(CC) -E -w -D PYMAJOR$(PYMAJOR) -xc pycaml.pp.ml >$(SRC_DIR)/pycaml.ml
-- 
2.7.0
