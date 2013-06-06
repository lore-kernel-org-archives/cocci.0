From: nicolas.palix@imag.fr (Nicolas Palix)
Date: Thu,  6 Jun 2013 23:39:53 +0200
Subject: [Cocci] [PATCH 2/2] Coccinelle: Update the Coccinelle section of
	MAINTAINERS
In-Reply-To: <1370554793-9152-1-git-send-email-nicolas.palix@imag.fr>
References: <1370554793-9152-1-git-send-email-nicolas.palix@imag.fr>
Message-ID: <1370554793-9152-2-git-send-email-nicolas.palix@imag.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Add Michal Marek and the misc branch of the kbuild tree
in the Coccinelle section of MAINTAINERS.

Signed-off-by: Nicolas Palix <nicolas.palix@imag.fr>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d7782b..73b1b3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2098,7 +2098,9 @@ COCCINELLE/Semantic Patches (SmPL)
 M:	Julia Lawall <Julia.Lawall@lip6.fr>
 M:	Gilles Muller <Gilles.Muller@lip6.fr>
 M:	Nicolas Palix <nicolas.palix@imag.fr>
+M:	Michal Marek <mmarek@suse.cz>
 L:	cocci at systeme.lip6.fr (moderated for non-subscribers)
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mmarek/kbuild.git misc
 W:	http://coccinelle.lip6.fr/
 S:	Supported
 F:	scripts/coccinelle/
-- 
1.8.1.2
