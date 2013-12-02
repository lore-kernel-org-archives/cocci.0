From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Mon,  2 Dec 2013 16:46:08 +0100
Subject: [Cocci] [PATCH 1/2] coccinelle: mkdir ocaml/coccilib/ upon install
Message-ID: <1385999169-19497-1-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Create the directory before copying files into it.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 2b6c78a..8700df5 100644
--- a/Makefile
+++ b/Makefile
@@ -188,6 +188,7 @@ top: $(EXEC).top
 
 # the .cmi file of coccilib
 ocaml/coccilib/coccilib.cmi: ocaml/coccilib.cmi
+	@mkdir -p ocaml/coccilib/
 	cp ocaml/coccilib.cmi ocaml/coccilib/coccilib.cmi
 
 # ocamlbuild version of the main make targets
-- 
1.8.4.3
