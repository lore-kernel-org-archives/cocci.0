From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Wed, 23 Aug 2017 15:11:13 +0200
Subject: [Cocci] [PATCH] Coccinelle: setup_timer: improve messages from
	setup_timer
Message-ID: <1503493873-673-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Allow messages about multiple timers.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/api/setup_timer.cocci |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/scripts/coccinelle/api/setup_timer.cocci b/scripts/coccinelle/api/setup_timer.cocci
index eb6bd9e..b5ab031 100644
--- a/scripts/coccinelle/api/setup_timer.cocci
+++ b/scripts/coccinelle/api/setup_timer.cocci
@@ -104,11 +104,9 @@ position j0, j1, j2;
 )
 
 @match_function_and_data_after_init_timer_context
-depends on !patch &&
-!match_immediate_function_data_after_init_timer_context &&
- (context || org || report)@
+depends on !patch && (context || org || report)@
 expression a, b, e1, e2, e3, e4, e5;
-position j0, j1, j2;
+position j0 != match_immediate_function_data_after_init_timer_context.j0,j1,j2;
 @@
 
 * init_timer at j0 (&e1);
@@ -124,13 +122,12 @@ position j0, j1, j2;
 * e1 at j2.function = a;
 )
 
- at r3_context depends on !patch &&
-!match_immediate_function_data_after_init_timer_context &&
-!match_function_and_data_after_init_timer_context &&
- (context || org || report)@
+ at r3_context depends on !patch && (context || org || report)@
 expression c, e6, e7;
 position r1.p;
-position j0, j1;
+position j0 !=
+  {match_immediate_function_data_after_init_timer_context.j0,
+   match_function_and_data_after_init_timer_context.j0}, j1;
 @@
 
 * init_timer at j0@p (&e6);
