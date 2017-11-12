From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 12 Nov 2017 16:02:18 +0100 (CET)
Subject: [Cocci] [PATCH] coccinelle: use exists to improve efficiency
Message-ID: <alpine.DEB.2.20.1711121554110.8028@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This just needs to find any reassignment of the loop iterator, and doesn't
need such a thing on all execution paths, so use exists on the first rule.

Signed-off-by: Julia Lawall <julia.lawall@lip6.fr>

---

diff --git a/scripts/coccinelle/iterators/list_entry_update.cocci b/scripts/coccinelle/iterators/list_entry_update.cocci
index 873f444..be6f9f1 100644
--- a/scripts/coccinelle/iterators/list_entry_update.cocci
+++ b/scripts/coccinelle/iterators/list_entry_update.cocci
@@ -15,7 +15,7 @@ virtual context
 virtual org
 virtual report

- at r@
+ at r exists@
 iterator name list_for_each_entry;
 expression x,E;
 position p1,p2;
