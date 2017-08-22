From: keescook@chromium.org (Kees Cook)
Date: Tue, 22 Aug 2017 16:54:00 -0700
Subject: [Cocci] [PATCH] coccinelle: Improve setup_timer.cocci matching
Message-ID: <20170822235400.GA92944@beast>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This improves the patch mode of setup_timer.cocci. Several patterns were
missing:
 - assignments-before-init_timer() cases
 - limiting the .data case removal to the struct timer_list instance
 - handling calls by dereference (timer->field vs timer.field)

Running this on the current kernel tree produces a large diff that I
would like to get applied as the first step in removing the .data
field from struct timer_list:

 208 files changed, 367 insertions(+), 757 deletions(-)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/coccinelle/api/setup_timer.cocci | 129 +++++++++++++++++++++++++------
 1 file changed, 105 insertions(+), 24 deletions(-)

diff --git a/scripts/coccinelle/api/setup_timer.cocci b/scripts/coccinelle/api/setup_timer.cocci
index eb6bd9e4ab1a..bc6bd8f0b4bf 100644
--- a/scripts/coccinelle/api/setup_timer.cocci
+++ b/scripts/coccinelle/api/setup_timer.cocci
@@ -2,6 +2,7 @@
 /// and data fields
 // Confidence: High
 // Copyright: (C) 2016 Vaishali Thakkar, Oracle. GPLv2
+// Copyright: (C) 2017 Kees Cook, Google. GPLv2
 // Options: --no-includes --include-headers
 // Keywords: init_timer, setup_timer
 
@@ -10,60 +11,123 @@ virtual context
 virtual org
 virtual report
 
+// Match the common cases first to avoid Coccinelle parsing loops with
+// "... when" clauses.
+
 @match_immediate_function_data_after_init_timer
 depends on patch && !context && !org && !report@
 expression e, func, da;
 @@
 
--init_timer (&e);
-+setup_timer (&e, func, da);
+-init_timer
++setup_timer
+ ( \(&e\|e\)
++, func, da
+ );
+(
+-\(e.function\|e->function\) = func;
+-\(e.data\|e->data\) = da;
+|
+-\(e.function\|e->function\) = func;
+-\(e.data\|e->data\) = da;
+)
+
+ at match_immediate_function_data_before_init_timer
+depends on patch && !context && !org && !report@
+expression e, func, da;
+@@
 
 (
+-\(e.function\|e->function\) = func;
+-\(e.data\|e->data\) = da;
+|
+-\(e.function\|e->function\) = func;
+-\(e.data\|e->data\) = da;
+)
+-init_timer
++setup_timer
+ ( \(&e\|e\)
++, func, da
+ );
+
+ at match_function_and_data_after_init_timer
+depends on patch && !context && !org && !report@
+expression e, e2, e3, e4, e5, func, da;
+@@
+
+-init_timer
++setup_timer
+ ( \(&e\|e\)
++, func, da
+ );
+ ... when != func = e2
+     when != da = e3
+(
 -e.function = func;
+... when != da = e4
 -e.data = da;
 |
+-e->function = func;
+... when != da = e4
+-e->data = da;
+|
 -e.data = da;
+... when != func = e5
 -e.function = func;
+|
+-e->data = da;
+... when != func = e5
+-e->function = func;
 )
 
- at match_function_and_data_after_init_timer
+ at match_function_and_data_before_init_timer
 depends on patch && !context && !org && !report@
-expression e1, e2, e3, e4, e5, a, b;
+expression e, e2, e3, e4, e5, func, da;
 @@
-
--init_timer (&e1);
-+setup_timer (&e1, a, b);
-
-... when != a = e2
-    when != b = e3
 (
--e1.function = a;
-... when != b = e4
--e1.data = b;
+-e.function = func;
+... when != da = e4
+-e.data = da;
 |
--e1.data = b;
-... when != a = e5
--e1.function = a;
+-e->function = func;
+... when != da = e4
+-e->data = da;
+|
+-e.data = da;
+... when != func = e5
+-e.function = func;
+|
+-e->data = da;
+... when != func = e5
+-e->function = func;
 )
+... when != func = e2
+    when != da = e3
+-init_timer
++setup_timer
+ ( \(&e\|e\)
++, func, da
+ );
 
 @r1 exists@
+expression t;
 identifier f;
 position p;
 @@
 
 f(...) { ... when any
-  init_timer at p(...)
+  init_timer at p(\(&t\|t\))
   ... when any
 }
 
 @r2 exists@
+expression r1.t;
 identifier g != r1.f;
-struct timer_list t;
 expression e8;
 @@
 
 g(...) { ... when any
-  t.data = e8
+  \(t.data\|t->data\) = e8
   ... when any
 }
 
@@ -77,14 +141,31 @@ p << r1.p;
 cocci.include_match(False)
 
 @r3 depends on patch && !context && !org && !report@
-expression e6, e7, c;
+expression r1.t, func, e7;
 position r1.p;
 @@
 
--init_timer at p (&e6);
-+setup_timer (&e6, c, 0UL);
-... when != c = e7
--e6.function = c;
+(
+-init_timer at p(&t);
++setup_timer(&t, func, 0UL);
+... when != func = e7
+-t.function = func;
+|
+-t.function = func;
+... when != func = e7
+-init_timer at p(&t);
++setup_timer(&t, func, 0UL);
+|
+-init_timer@p(t);
++setup_timer(t, func, 0UL);
+... when != func = e7
+-t->function = func;
+|
+-t->function = func;
+... when != func = e7
+-init_timer at p(t);
++setup_timer(t, func, 0UL);
+)
 
 // ----------------------------------------------------------------------------
 
-- 
2.7.4


-- 
Kees Cook
Pixel Security
