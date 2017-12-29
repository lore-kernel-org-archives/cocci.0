From: jeremy.lefaure@lse.epita.fr (=?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?=)
Date: Fri, 29 Dec 2017 19:14:23 +0100
Subject: [Cocci] [RESEND PATCH 1/1] Coccinelle: array_size: report even if
	include is missing
Message-ID: <20171229181423.23263-1-jeremy.lefaure@lse.epita.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Rule r does not depend on rule i (which is the include of
linux/kernel.h) so the output should not depend on i in
org and report mode.

Signed-off-by: J?r?my Lefaure <jeremy.lefaure@lse.epita.fr>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---

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
