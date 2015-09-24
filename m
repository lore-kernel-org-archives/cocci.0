From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 24 Sep 2015 14:54:46 +0200
Subject: [Cocci] [PATCH] coccinelle: assign signed result to unsigned
	variable
Message-ID: <1443099286-16559-1-git-send-email-a.hajda@samsung.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Assigning signed function result to unsigned variable can indicate error.
To decrease number of false positives patch looks if after assignment
there is also check for negative values of the result.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
Hi,

This patch tries to catch bugs related to losing possible negative function
results and complements my previous patch[1]. I have found about 20 real bugs
thanks to it. I will post related kernel patches on LKML.

[1]: http://permalink.gmane.org/gmane.linux.kernel/2039591
---
 .../tests/assign_signed_to_unsigned.cocci          | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 scripts/coccinelle/tests/assign_signed_to_unsigned.cocci

diff --git a/scripts/coccinelle/tests/assign_signed_to_unsigned.cocci b/scripts/coccinelle/tests/assign_signed_to_unsigned.cocci
new file mode 100644
index 0000000..ebd3d3a
--- /dev/null
+++ b/scripts/coccinelle/tests/assign_signed_to_unsigned.cocci
@@ -0,0 +1,48 @@
+/// Assigning signed function result to unsigned variable can indicate error.
+/// To decrease number of false positives patch looks if after assignment
+/// there is also check for negative values of the result.
+///
+// Confidence: High
+// Copyright: (C) 2015 Andrzej Hajda, Samsung Electronics Co., Ltd. GPLv2.
+// URL: http://coccinelle.lip6.fr/
+// Options: --include-headers --all-includes
+
+virtual context
+virtual org
+virtual report
+
+ at rs@
+position p;
+typedef bool, u8, u16, u32, u64, s8, s16, s32, s64;
+{char, short int, int, long, long long, s8, s16, s32, s64} vs;
+{unsigned char, unsigned short, unsigned int, unsigned long, unsigned long long, size_t, bool, u8, u16, u32, u64} vu;
+@@
+
+vu at p = vs
+
+ at r@
+position rs.p;
+identifier v, f;
+statement S1, S2;
+expression e;
+@@
+
+*v at p = f(...);
+... when != v = e;
+if ( \( v < 0 \| v <= 0 \) ) S1 else S2
+
+ at script:python depends on r && org@
+p << rs.p;
+@@
+
+msg = "WARNING: Assigning signed result to unsigned variable: %s = %s(...)" % (v, f)
+coccilib.org.print_todo(p[0], msg)
+
+@script:python depends on r && report@
+p << rs.p;
+f << r.f;
+v << r.v;
+@@
+
+msg = "WARNING: Assigning signed result to unsigned variable: %s = %s(...)" % (v, f)
+coccilib.report.print_report(p[0], msg)
-- 
1.9.1
