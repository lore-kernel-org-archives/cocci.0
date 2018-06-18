From: chrisz@openbsd.org (Christopher Zimmermann)
Date: Mon, 18 Jun 2018 22:09:31 +0200
Subject: [Cocci] [bug-cocci] fix bytecode build of pyml
Message-ID: <20180618220931.058e9627@mortimer.gmerlin.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

please consider inclusion of the following patches.

Christopher Zimmermann


Index: bundles/pyml/Makefile
--- bundles/pyml/Makefile.orig
+++ bundles/pyml/Makefile
@@ -52,8 +52,8 @@ $(SRC_DIR)/pyml_compat.cmx: $(SRC_DIR)/pyml_compat.ml 
 $(SRC_DIR)/pyml_compat.cmo: $(SRC_DIR)/pyml_compat.ml $(SRC_DIR)/pyml_compat.cmi
 	$(OCAMLC_CMD) -c $< -o $@
 
-$(SRC_DIR)/generate: $(SRC_DIR)/pyml_compat.cmx $(SRC_DIR)/generate.cmx
-	$(OCAMLOPT) $^ -o $@
+$(SRC_DIR)/generate: $(SRC_DIR)/pyml_compat.cmo $(SRC_DIR)/generate.cmo
+	$(OCAMLC_CMD) $^ -o $@
 
 $(SRC_DIR)/generate.cmx: $(SRC_DIR)/generate.ml $(SRC_DIR)/pyml_compat.cmx
 	$(OCAMLOPT_CMD) -c $< -o $@




This does not set a default options as suggested in configure.ac,
but overrides the user-provided setting.

Index: configure
--- configure.orig
+++ configure
@@ -14416,7 +14416,6 @@ fi
 
 fi
 
-enable_opt="yes"
 
 
 if test "x$enable_opt" = xyes; then :



Index: parsing_c/unparse_c.ml
--- parsing_c/unparse_c.ml.orig
+++ parsing_c/unparse_c.ml
@@ -2362,11 +2362,11 @@ let start_mark = function
 *)
 module String = struct
   let init n f =
-    let s = String.make n ' ' in
+    let s = Bytes.make n ' ' in
     for i = 0 to n - 1 do
       s.[i] <- f i
     done;
-    s
+    Bytes.unsafe_to_string s
 
   let map f s =
     init (String.length s) (fun i -> f s.[i])


Index: Makefile
--- Makefile.orig
+++ Makefile
@@ -71,7 +71,7 @@ INCLUDEDIRSDEP=commons commons/ocamlextra \
  parsing_cocci parsing_c ocaml python engine popl09 extra \
  $(MAKELIBS)
 
-INCLUDEDIRS=$(INCLUDEDIRSDEP) $(PCREDIR) $(PARMAPDIR) $(INCLIBS)
+INCLUDEDIRS=$(INCLUDEDIRSDEP) $(PCREDIR) $(PARMAPDIR) $(INCLIBS) +num
 
 ##############################################################################
 # Generic variables



Index: parsing_c/Makefile
--- parsing_c/Makefile.orig
+++ parsing_c/Makefile
@@ -42,9 +42,9 @@ LIBS=../commons/commons.cma ../globals/globals.cma \
 INCLUDESDEP= -I ../commons -I ../commons/ocamlextra \
   -I ../globals -I  ../parsing_cocci
 
-INCLUDES=$(INCLUDESDEP) $(TARZANINCLUDE)
+INCLUDES=$(INCLUDESDEP) $(TARZANINCLUDE) -I +num
 
-SYSLIBS= str.cma unix.cma num.cma
+SYSLIBS= str.cma unix.cma nums.cma
 
 ##############################################################################
 # Generic variables




Index: parsing_c/unparse_c.ml
--- parsing_c/unparse_c.ml.orig
+++ parsing_c/unparse_c.ml
@@ -2362,11 +2362,11 @@ let start_mark = function
 *)
 module String = struct
   let init n f =
-    let s = String.make n ' ' in
+    let s = Bytes.make n ' ' in
     for i = 0 to n - 1 do
       s.[i] <- f i
     done;
-    s
+    Bytes.unsafe_to_string s
 
   let map f s =
     init (String.length s) (fun i -> f s.[i])



Index: tools/spgen/source/Makefile
--- tools/spgen/source/Makefile.orig
+++ tools/spgen/source/Makefile
@@ -39,7 +39,7 @@ LIBS_OPT = $(LIBS:=.cmxa)
 
 INCLUDEDIRS= $(COCCIDIR)/commons $(COCCIDIR)/commons/ocamlextra \
 	$(COCCIDIR)/globals $(COCCIDIR)/parsing_cocci
$(COCCIDIR)/parsing_c \
-	$(PCREDIR)
+	$(PCREDIR) +num
 
 INCLUDES=$(INCLUDEDIRS:%=-I %)
 


-- 
http://gmerlin.de
OpenPGP: http://gmerlin.de/christopher.pub
2779 7F73 44FD 0736 B67A  C410 69EC 7922 34B4 2566
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180618/f06a28f9/attachment.asc>
