From: dmitry.kalinkin@gmail.com (Dmitry Kalinkin)
Date: Sun, 17 May 2015 19:23:30 +0300
Subject: [Cocci] [PATCHv2] coccinelle: api: add vma_pages.cocci
In-Reply-To: <alpine.DEB.2.02.1505171526430.2077@localhost6.localdomain6>
References: <alpine.DEB.2.02.1505171526430.2077@localhost6.localdomain6>
Message-ID: <1431879810-20920-1-git-send-email-dmitry.kalinkin@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This semantic patch replaces explicit computations of vma page count
with explicit function call.

Signed-off-by: Dmitry Kalinkin <dmitry.kalinkin@gmail.com>
---
 scripts/coccinelle/api/vma_pages.cocci | 60 ++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 scripts/coccinelle/api/vma_pages.cocci

diff --git a/scripts/coccinelle/api/vma_pages.cocci b/scripts/coccinelle/api/vma_pages.cocci
new file mode 100644
index 0000000..3e52e11
--- /dev/null
+++ b/scripts/coccinelle/api/vma_pages.cocci
@@ -0,0 +1,60 @@
+///
+/// Use vma_pages function on vma object instead of explicit computation.
+///
+//  Confidence: High
+//  Keywords: vma_pages vma
+//  Comment: Based on resource_size.cocci
+
+virtual context
+virtual patch
+virtual org
+virtual report
+
+//----------------------------------------------------------
+//  For context mode
+//----------------------------------------------------------
+
+ at r_context depends on context && !patch && !org && !report@
+struct vm_area_struct *vma;
+@@
+
+* (vma->vm_end - vma->vm_start) >> PAGE_SHIFT
+
+//----------------------------------------------------------
+//  For patch mode
+//----------------------------------------------------------
+
+ at r_patch depends on !context && patch && !org && !report@
+struct vm_area_struct *vma;
+@@
+
+- ((vma->vm_end - vma->vm_start) >> PAGE_SHIFT)
++ vma_pages(vma)
+
+//----------------------------------------------------------
+//  For org mode
+//----------------------------------------------------------
+
+ at r_org depends on !context && !patch && (org || report)@
+struct vm_area_struct *vma;
+position p;
+@@
+
+  (vma->vm_end at p - vma->vm_start) >> PAGE_SHIFT
+
+ at script:python depends on report@
+p << r_org.p;
+x << r_org.vma;
+@@
+
+msg="WARNING: Consider using vma_pages helper on %s" % (x)
+coccilib.report.print_report(p[0], msg)
+
+@script:python depends on org@
+p << r_org.p;
+x << r_org.vma;
+@@
+
+msg="WARNING: Consider using vma_pages helper on %s" % (x)
+msg_safe=msg.replace("[","@(").replace("]",")")
+coccilib.org.print_todo(p[0], msg_safe)
-- 
1.8.3.1
