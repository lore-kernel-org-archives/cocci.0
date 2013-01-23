From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Wed, 23 Jan 2013 19:40:15 -0200
Subject: [Cocci] [PATCH] scripts/coccinelle/misc/memcpy-assign.cocci:
	Replace memcpy with struct assignment
Message-ID: <1358977215-2720-1-git-send-email-peter.senna@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

There are kinds of memcpy() that are error-prone. Its replacement with
a struct assignment is prefered because it's type-safe and much easier
to read. This semantic patch looks for memcpy() that can be replaced by
struct assignment.

Inspired by patches sent by Ezequiel Garcia <elezegarcia@gmail.com>

Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
---
 scripts/coccinelle/misc/memcpy-assign.cocci | 103 ++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 scripts/coccinelle/misc/memcpy-assign.cocci

diff --git a/scripts/coccinelle/misc/memcpy-assign.cocci b/scripts/coccinelle/misc/memcpy-assign.cocci
new file mode 100644
index 0000000..5c1fd75
--- /dev/null
+++ b/scripts/coccinelle/misc/memcpy-assign.cocci
@@ -0,0 +1,103 @@
+//
+// Replace memcpy with struct assignment.
+//
+// Confidence: Moderate
+// Copyright: (C) 2012 Peter Senna Tschudin, INRIA/LIP6.  GPLv2.
+// URL: http://coccinelle.lip6.fr/
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual report
+virtual context
+virtual org
+
+ at r1 depends on !patch@
+identifier struct_name;
+struct struct_name to;
+struct struct_name from;
+struct struct_name *top;
+struct struct_name *fromp;
+position p;
+@@
+memcpy at p(\(&(to)\|top\), \(&(from)\|fromp\), \(sizeof(to)\|sizeof(from)\|sizeof(struct struct_name)\|sizeof(*top)\|sizeof(*fromp)\))
+
+ at script:python depends on report@
+p << r1.p;
+@@
+coccilib.report.print_report(p[0],"Replace memcpy with struct assignment")
+
+ at depends on context@
+position r1.p;
+@@
+*memcpy at p(...);
+
+ at script:python depends on org@
+p << r1.p;
+@@
+cocci.print_main("Replace memcpy with struct assignment",p)
+
+ at depends on patch@
+identifier struct_name;
+struct struct_name to;
+struct struct_name from;
+@@
+(
+-memcpy(&(to), &(from), sizeof(to));
++to = from;
+|
+-memcpy(&(to), &(from), sizeof(from));
++to = from;
+|
+-memcpy(&(to), &(from), sizeof(struct struct_name));
++to = from;
+)
+
+ at depends on patch@
+identifier struct_name;
+struct struct_name to;
+struct struct_name *from;
+@@
+(
+-memcpy(&(to), from, sizeof(to));
++to = *from;
+|
+-memcpy(&(to), from, sizeof(*from));
++to = *from;
+|
+-memcpy(&(to), from, sizeof(struct struct_name));
++to = *from;
+)
+
+ at depends on patch@
+identifier struct_name;
+struct struct_name *to;
+struct struct_name from;
+@@
+(
+-memcpy(to, &(from), sizeof(*to));
++ *to = from;
+|
+-memcpy(to, &(from), sizeof(from));
++ *to = from;
+|
+-memcpy(to, &(from), sizeof(struct struct_name));
++ *to = from;
+)
+
+@depends on patch@
+identifier struct_name;
+struct struct_name *to;
+struct struct_name *from;
+@@
+(
+-memcpy(to, from, sizeof(*to));
++ *to = *from;
+|
+-memcpy(to, from, sizeof(*from));
++ *to = *from;
+|
+-memcpy(to, from, sizeof(struct struct_name));
++ *to = *from;
+)
+
-- 
1.7.11.7
