From: mstefani@mykolab.com (Michael Stefaniuc)
Date: Mon,  2 Oct 2017 23:05:44 +0200
Subject: [Cocci] [PATCH] Create the BINDIR too during make install
Message-ID: <20171002210544.7971-1-mstefani@mykolab.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Fixes:
make install
...
/usr/bin/install -c -m 755 spatch.opt /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/bin/spatch
/usr/bin/install: cannot create regular file '/usr/local/packages/coccinelle-1.0.6-318-g0bf5304/bin/spatch': No such file or directory
Makefile:262: recipe for target 'install-spatch' failed
make: *** [install-spatch] Error 1

Signed-off-by: Michael Stefaniuc <mstefani@mykolab.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9c7f721..2b59d45 100644
--- a/Makefile
+++ b/Makefile
@@ -259,7 +259,7 @@ install-bash:
 
 .PHONY: install-spatch
 install-spatch : spatch$(TOOLS_SUFFIX)
-	$(MKDIR_P) $(DESTDIR)$(LIBDIR)
+	$(MKDIR_P) $(DESTDIR)$(BINDIR) $(DESTDIR)$(LIBDIR)
 	if test -f bundles/pyml/dllpyml_stubs.so; then \
 		$(INSTALL_PROGRAM) bundles/pyml/dllpyml_stubs.so \
 			$(DESTDIR)$(LIBDIR); \
-- 
2.9.5
