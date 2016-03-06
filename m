From: nicstange@gmail.com (Nicolai Stange)
Date: Sun,  6 Mar 2016 13:24:59 +0100
Subject: [Cocci] [PATCH v5 4/8] debugfs,
	coccinelle: check for obsolete DEFINE_SIMPLE_ATTRIBUTE() usage
In-Reply-To: <1457267103-28910-1-git-send-email-nicstange@gmail.com>
References: <1457267103-28910-1-git-send-email-nicstange@gmail.com>
Message-ID: <1457267103-28910-5-git-send-email-nicstange@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

In order to protect against file removal races, debugfs files created via
debugfs_create_file() now get wrapped by a struct file_operations at their
opening.

If the original struct file_operations are known to be safe against removal
races by themselves already, the proxy creation may be bypassed by creating
the files through debugfs_create_file_unsafe().

In order to help debugfs users who use the common
  DEFINE_SIMPLE_ATTRIBUTE() + debugfs_create_file()
idiom to transition to removal safe struct file_operations, the helper
macro DEFINE_DEBUGFS_ATTRIBUTE() has been introduced.

Thus, the preferred strategy is to use
  DEFINE_DEBUGFS_ATTRIBUTE() + debugfs_create_file_unsafe()
now.

Introduce a Coccinelle script that searches for
DEFINE_SIMPLE_ATTRIBUTE()-defined struct file_operations handed into
debugfs_create_file(). Suggest to turn these usages into the
  DEFINE_DEBUGFS_ATTRIBUTE() + debugfs_create_file_unsafe()
pattern.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 .../api/debugfs/debugfs_simple_attr.cocci          | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci

diff --git a/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci b/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
new file mode 100644
index 0000000..85cf540
--- /dev/null
+++ b/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
@@ -0,0 +1,67 @@
+/// Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
+/// for debugfs files.
+///
+//# Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
+//# imposes some significant overhead as compared to
+//# DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().
+//
+// Copyright (C): 2016 Nicolai Stange
+// Options: --no-includes
+//
+
+virtual context
+virtual patch
+virtual org
+virtual report
+
+ at dsa@
+declarer name DEFINE_SIMPLE_ATTRIBUTE;
+identifier dsa_fops;
+expression dsa_get, dsa_set, dsa_fmt;
+position p;
+@@
+DEFINE_SIMPLE_ATTRIBUTE at p(dsa_fops, dsa_get, dsa_set, dsa_fmt);
+
+ at dcf@
+expression name, mode, parent, data;
+identifier dsa.dsa_fops;
+@@
+debugfs_create_file(name, mode, parent, data, &dsa_fops)
+
+
+ at context_dsa depends on context && dcf@
+declarer name DEFINE_DEBUGFS_ATTRIBUTE;
+identifier dsa.dsa_fops;
+expression dsa.dsa_get, dsa.dsa_set, dsa.dsa_fmt;
+@@
+* DEFINE_SIMPLE_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
+
+
+ at patch_dcf depends on patch expression@
+expression name, mode, parent, data;
+identifier dsa.dsa_fops;
+@@
+- debugfs_create_file(name, mode, parent, data, &dsa_fops)
++ debugfs_create_file_unsafe(name, mode, parent, data, &dsa_fops)
+
+ at patch_dsa depends on patch_dcf && patch@
+identifier dsa.dsa_fops;
+expression dsa.dsa_get, dsa.dsa_set, dsa.dsa_fmt;
+@@
+- DEFINE_SIMPLE_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
++ DEFINE_DEBUGFS_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
+
+
+ at script:python depends on org && dcf@
+fops << dsa.dsa_fops;
+p << dsa.p;
+@@
+msg="%s should be defined with DEFINE_DEBUGFS_ATTRIBUTE" % (fops)
+coccilib.org.print_todo(p[0], msg)
+
+@script:python depends on report && dcf@
+fops << dsa.dsa_fops;
+p << dsa.p;
+@@
+msg="WARNING: %s should be defined with DEFINE_DEBUGFS_ATTRIBUTE" % (fops)
+coccilib.report.print_report(p[0], msg)
-- 
2.7.2
