From: asmadeus@codewreck.org (Dominique Martinet)
Date: Fri, 13 Jul 2018 03:14:43 +0200
Subject: [Cocci] [PATCH 01/18] coccinelle: change strncpy+truncation to
	strlcpy
Message-ID: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Besides being simpler, using strlcpy instead of strncpy+truncation
fixes part of the following class of new gcc warnings:

    drivers/gpu/drm/i915/intel_tv.c: In function ?intel_tv_get_modes?:
    drivers/gpu/drm/i915/intel_tv.c:1358:3: error: ?strncpy? specified bound 32 equals
    destination size [-Werror=stringop-truncation]
       strncpy(mode_ptr->name, input->name, DRM_DISPLAY_MODE_LEN);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    cc1: all warnings being treated as errors

Note that this is not a proper fix for this warning (and not all of the
occurences give the warning either - the strings are not always static).
The warning was intended to have developers check the return code of
strncpy and act in case of truncation (print a warning, abort the
function or something similar if the original string was not nul
terminated); the change to strlcpy only works because gcc does not
handle the function the same way.

Suggested-by: Ville Syrj?l? <ville.syrjala@linux.intel.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---

Running this fixes 30 occurences of the problem in 17 different
components of the kernel, and while the produced patches are fairly
straight-forward I'm not sure who I should expect to pick this up as
it is sent as a series.
I expect each maintainer will pick their share of the patchs if they
agree with it and the rest will just be dropped?

 .../coccinelle/misc/strncpy_truncation.cocci  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 scripts/coccinelle/misc/strncpy_truncation.cocci

diff --git a/scripts/coccinelle/misc/strncpy_truncation.cocci b/scripts/coccinelle/misc/strncpy_truncation.cocci
new file mode 100644
index 000000000000..28b5c2a290ac
--- /dev/null
+++ b/scripts/coccinelle/misc/strncpy_truncation.cocci
@@ -0,0 +1,41 @@
+/// Use strlcpy rather than strncpy(dest,..,sz) + dest[sz-1] = '\0'
+///
+// Confidence: High
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual context
+virtual report
+virtual org
+
+ at r@
+expression dest, src, sz;
+position p;
+@@
+
+strncpy at p(dest, src, sz);
+dest[sz - 1] = '\0';
+
+ at script:python depends on org@
+p << r.p;
+@@
+
+cocci.print_main("strncpy followed by truncation can be strlcpy",p)
+
+ at script:python depends on report@
+p << r.p;
+@@
+
+msg = "SUGGESTION: strncpy followed by truncation can be strlcpy"
+coccilib.report.print_report(p[0],msg)
+
+ at ok depends on patch@
+expression r.dest, r.src, r.sz;
+position r.p;
+@@
+
+-strncpy@p(
++strlcpy(
+  dest, src, sz);
+-dest[sz - 1] = '\0';
-- 
2.17.1
