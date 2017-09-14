From: jeremy.lefaure@lse.epita.fr (=?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?=)
Date: Wed, 13 Sep 2017 22:38:07 -0400
Subject: [Cocci] [PATCH 1/1] Coccinelle: array_size: report even if include
	is missing
Message-ID: <20170914023807.12972-1-jeremy.lefaure@lse.epita.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Rule r does not depend on rule i (which is the include of
linux/kernel.h) so the output should not depend on i in
org and report mode.

Signed-off-by: J?r?my Lefaure <jeremy.lefaure@lse.epita.fr>
---

I have tested this patch in report mode on the file
drivers/staging/rtlwifi/phydm/rtl8822b/halhwimg8822b_rf.c which does not
use ARRAY_SIZE and does not include linux/kernel.h.

 scripts/coccinelle/misc/array_size.cocci | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/misc/array_size.cocci b/scripts/coccinelle/misc/array_size.cocci
index 6ec05710b017..09520f0941f0 100644
--- a/scripts/coccinelle/misc/array_size.cocci
+++ b/scripts/coccinelle/misc/array_size.cocci
@@ -72,13 +72,13 @@ position p;
  (sizeof(E)@p /sizeof(T))
 )
 
- at script:python depends on i&&org@
+ at script:python depends on org@
 p << r.p;
 @@
 
 coccilib.org.print_todo(p[0], "WARNING should use ARRAY_SIZE")
 
- at script:python depends on i&&report@
+@script:python depends on report@
 p << r.p;
 @@
 
-- 
2.14.1
