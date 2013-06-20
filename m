From: nicolas.palix@imag.fr (Nicolas Palix)
Date: Thu, 20 Jun 2013 13:10:55 +0200
Subject: [Cocci] [PATCH 1/3] Coccinelle: Update section of MAINTAINERS
Message-ID: <1371726656-24928-1-git-send-email-nicolas.palix@imag.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Add Documentation/coccinelle.txt in the COCCINELLE section.

Signed-off-by: Nicolas Palix <nicolas.palix@imag.fr>
---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 73b1b3a..2d94051 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2103,6 +2103,7 @@ L:	cocci at systeme.lip6.fr (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mmarek/kbuild.git misc
 W:	http://coccinelle.lip6.fr/
 S:	Supported
+F:	Documentation/coccinelle.txt
 F:	scripts/coccinelle/
 F:	scripts/coccicheck
 
-- 
1.7.9.5
