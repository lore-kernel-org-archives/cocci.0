From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Fri,  4 Sep 2015 21:27:51 +0200
Subject: [Cocci] [PATCH v2] coccinelle: misc: move constants to the right
Message-ID: <1441394871-17774-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Move constants to the right in binary operators.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
v2. Add lkml, no other change

 scripts/coccinelle/misc/compare_const_fl.cocci |  171 +++++++++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/var/julia/linuxcopy/scripts/coccinelle/misc/compare_const_fl.cocci b/var/julia/linuxcopy/scripts/coccinelle/misc/compare_const_fl.cocci
new file mode 100644
index 0000000..b5d4bab
--- /dev/null
+++ b/scripts/coccinelle/misc/compare_const_fl.cocci
@@ -0,0 +1,171 @@
+/// Move constants to the right of binary operators.
+//# Depends on personal taste in some cases.
+///
+// Confidence: Moderate
+// Copyright: (C) 2015 Copyright: (C) 2015 Julia Lawall, Inria. GPLv2.
+// URL: http://coccinelle.lip6.fr/
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+ at r1 depends on patch && !context && !org && !report
+ disable bitor_comm, neg_if_exp@
+constant c,c1;
+local idexpression i;
+expression e,e1,e2;
+binary operator b = {==,!=,&,|};
+type t;
+@@
+
+(
+c b (c1)
+|
+sizeof(t) b e1
+|
+sizeof e b e1
+|
+i b e1
+|
+c | e1 | e2 | ...
+|
+c | (e ? e1 : e2)
+|
+- c
++ e
+b
+- e
++ c
+)
+
+ at r2 depends on patch && !context && !org && !report
+ disable gtr_lss, gtr_lss_eq, not_int2@
+constant c,c1;
+expression e,e1,e2;
+binary operator b;
+binary operator b1 = {<,<=},b2 = {<,<=};
+binary operator b3 = {>,>=},b4 = {>,>=};
+local idexpression i;
+type t;
+@@
+
+(
+c b c1
+|
+sizeof(t) b e1
+|
+sizeof e b e1
+|
+ (e1 b1 e) && (e b2 e2)
+|
+ (e1 b3 e) && (e b4 e2)
+|
+i b e
+|
+- c < e
++ e > c
+|
+- c <= e
++ e >= c
+|
+- c > e
++ e < c
+|
+- c >= e
++ e <= c
+)
+
+// ----------------------------------------------------------------------------
+
+ at r1_context depends on !patch && (context || org || report)
+ disable bitor_comm, neg_if_exp exists@
+type t;
+binary operator b = {==,!=,&,|};
+constant c, c1;
+expression e, e1, e2;
+local idexpression i;
+position j0;
+@@
+
+(
+c b (c1)
+|
+sizeof(t) b e1
+|
+sizeof e b e1
+|
+i b e1
+|
+c | e1 | e2 | ...
+|
+c | (e ? e1 : e2)
+|
+* c at j0 b e
+)
+
+@r2_context depends on !patch && (context || org || report)
+ disable gtr_lss, gtr_lss_eq, not_int2 exists@
+type t;
+binary operator b, b1 = {<,<=}, b2 = {<,<=}, b3 = {>,>=}, b4 = {>,>=};
+constant c, c1;
+expression e, e1, e2;
+local idexpression i;
+position j0;
+@@
+
+(
+c b c1
+|
+sizeof(t) b e1
+|
+sizeof e b e1
+|
+ (e1 b1 e) && (e b2 e2)
+|
+ (e1 b3 e) && (e b4 e2)
+|
+i b e
+|
+* c at j0 < e
+|
+* c at j0 <= e
+|
+* c@j0 > e
+|
+* c at j0 >= e
+)
+
+// ----------------------------------------------------------------------------
+
+ at script:python r1_org depends on org@
+j0 << r1_context.j0;
+@@
+
+msg = "Move constant to right."
+coccilib.org.print_todo(j0[0], msg)
+
+ at script:python r2_org depends on org@
+j0 << r2_context.j0;
+@@
+
+msg = "Move constant to right."
+coccilib.org.print_todo(j0[0], msg)
+
+// ----------------------------------------------------------------------------
+
+ at script:python r1_report depends on report@
+j0 << r1_context.j0;
+@@
+
+msg = "Move constant to right."
+coccilib.report.print_report(j0[0], msg)
+
+@script:python r2_report depends on report@
+j0 << r2_context.j0;
+@@
+
+msg = "Move constant to right."
+coccilib.report.print_report(j0[0], msg)
+
