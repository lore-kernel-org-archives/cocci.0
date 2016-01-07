From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 07 Jan 2016 10:36:51 +0100
Subject: [Cocci] [PATCH v7] coccinelle: tests: unsigned value cannot be
	lesser than zero
In-Reply-To: <alpine.DEB.2.10.1601051512010.2521@hadrien>
References: <alpine.DEB.2.10.1601051512010.2521@hadrien>
Message-ID: <1452159411-3216-1-git-send-email-a.hajda@samsung.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Unsigned expressions cannot be lesser than zero. Presence of comparisons
'unsigned (<|<=|>|>=) 0' often indicates a bug, usually wrong type of variable.
The patch beside finding such comparisons tries to eliminate false positives,
mainly by bypassing range checks.

gcc can detect such comparisons also using -Wtype-limits switch, but it warns
also in correct cases, making too much noise.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
v6: improved range check detection (according to Julia suggestion)
v5: improved range check detection
v4: added range check detection, added full check in case value holds a result
    of signed function
v3: added bool type
v2: added --all-includes option
---
 .../tests/unsigned_lesser_than_zero.cocci          | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci

diff --git a/scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci b/scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci
new file mode 100644
index 0000000..8fa5a3c
--- /dev/null
+++ b/scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci
@@ -0,0 +1,75 @@
+/// Unsigned expressions cannot be lesser than zero. Presence of
+/// comparisons 'unsigned (<|<=|>|>=) 0' often indicates a bug,
+/// usually wrong type of variable.
+///
+/// To reduce number of false positives following tests have been added:
+/// - parts of range checks are skipped, eg. "if (u < 0 || u > 15) ...",
+///   developers prefer to keep such code,
+/// - comparisons "<= 0" and "> 0" are performed only on results of
+///   signed functions/macros,
+/// - hardcoded list of signed functions/macros with always non-negative
+///   result is used to avoid false positives difficult to detect by other ways
+///
+// Confidence: Average
+// Copyright: (C) 2015 Andrzej Hajda, Samsung Electronics Co., Ltd. GPLv2.
+// URL: http://coccinelle.lip6.fr/
+// Options: --all-includes
+
+virtual context
+virtual org
+virtual report
+
+ at r_cmp@
+position p;
+typedef bool, u8, u16, u32, u64;
+{unsigned char, unsigned short, unsigned int, unsigned long, unsigned long long,
+	size_t, bool, u8, u16, u32, u64} v;
+expression e;
+@@
+
+	\( v = e \| &v \)
+	...
+	(\( v at p < 0 \| v at p <= 0 \| v@p >= 0 \| v at p > 0 \))
+
+ at r@
+position r_cmp.p;
+typedef s8, s16, s32, s64;
+{char, short, int, long, long long, ssize_t, s8, s16, s32, s64} vs;
+expression c, e, v;
+identifier f !~ "^(ata_id_queue_depth|btrfs_copy_from_user|dma_map_sg|dma_map_sg_attrs|fls|fls64|gameport_time|get_write_extents|nla_len|ntoh24|of_flat_dt_match|of_get_child_count|uart_circ_chars_pending|[A-Z0-9_]+)$";
+@@
+
+(
+	v = f(...)@vs;
+	... when != v = e;
+*	(\( v at p <=@e 0 \| v@p >@e 0 \))
+	... when any
+|
+(
+	(\( v at p < 0 \| v@p <= 0 \)) || ... || (\( v >= c \| v > c \))
+|
+	(\( v >= c \| v > c \)) || ... || (\( v at p < 0 \| v at p <= 0 \))
+|
+	(\( v@p >= 0 \| v at p > 0 \)) && ... && (\( v < c \| v <= c \))
+|
+	((\( v < c \| v <= c \) && ... && \( v@p >= 0 \| v at p > 0 \)))
+|
+*	(\( v at p <@e 0 \| v@p >=@e 0 \))
+)
+)
+
+ at script:python depends on org@
+p << r_cmp.p;
+e << r.e;
+@@
+
+msg = "WARNING: Unsigned expression compared with zero: %s" % (e)
+coccilib.org.print_todo(p[0], msg)
+
+@script:python depends on report@
+p << r_cmp.p;
+e << r.e;
+@@
+
+msg = "WARNING: Unsigned expression compared with zero: %s" % (e)
+coccilib.report.print_report(p[0], msg)
-- 
1.9.1
