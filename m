From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 14 Nov 2017 18:47:20 +0900
Subject: [Cocci] [PATCH] kbuild: move coccicheck help in
	scripts/Makefile.help to top Makefile
Message-ID: <1510652841-6779-1-git-send-email-yamada.masahiro@socionext.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I do not think it is helpful to have a separate file just for the
coccicheck help message.  Merge scripts/Makefile.help into the
top-level Makefile.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile              | 2 +-
 scripts/Makefile.help | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)
 delete mode 100644 scripts/Makefile.help

diff --git a/Makefile b/Makefile
index f060f94..3b7d477 100644
--- a/Makefile
+++ b/Makefile
@@ -1388,7 +1388,7 @@ help:
 	@echo  '  export_report   - List the usages of all exported symbols'
 	@echo  '  headers_check   - Sanity check on exported headers'
 	@echo  '  headerdep       - Detect inclusion cycles in headers'
-	@$(MAKE) -f $(srctree)/scripts/Makefile.help checker-help
+	@echo  '  coccicheck      - Check with Coccinelle'
 	@echo  ''
 	@echo  'Kernel selftest:'
 	@echo  '  kselftest       - Build and run kernel selftest (run as root)'
diff --git a/scripts/Makefile.help b/scripts/Makefile.help
deleted file mode 100644
index d03608f..0000000
--- a/scripts/Makefile.help
+++ /dev/null
@@ -1,3 +0,0 @@
-
-checker-help:
-	@echo  '  coccicheck      - Check with Coccinelle.'
-- 
2.7.4
