From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Sat,  8 Oct 2016 17:51:45 +0200
Subject: [Cocci] [PATCH] Coccinelle: flag conditions with no effect
Message-ID: <1475941905-8835-1-git-send-email-hofrat@osadl.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Report code constructs where the if and else branch are functionally
identical. In cases where this is intended it really should be 
documented - most reported cases probably are bugs.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Tested with spatch version 1.0.5

As of 4.8.0 this reports about 90 cases of which the majority looks like
they would at least need additional comments.

Patch is against 4.8.0 (localversion-next is -next-20161006)

 scripts/coccinelle/misc/cond_no_effect.cocci | 64 ++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 scripts/coccinelle/misc/cond_no_effect.cocci

diff --git a/scripts/coccinelle/misc/cond_no_effect.cocci b/scripts/coccinelle/misc/cond_no_effect.cocci
new file mode 100644
index 0000000..006ef65
--- /dev/null
+++ b/scripts/coccinelle/misc/cond_no_effect.cocci
@@ -0,0 +1,64 @@
+///Find conditions where if and else branch are functionally
+// identical.
+//
+// There can be false positives in cases where the positional
+// information is used (as with lockdep) or where the identity
+// is a placeholder for not yet handled cases.
+// Unfortunately there also seems to be a tendency to use
+// the last if else/else as a "default behavior" - which some
+// might consider a legitimate coding pattern. From discussion
+// on kernelnewbies though it seems that this is not really an
+// accepted pattern and if at all it would need to be commented
+//
+// In the Linux kernel it does not seem to actually report
+// false positives except for those that were documented as
+// being intentional.
+// the two known cases are:
+//   arch/sh/kernel/traps_64.c:read_opcode()
+//        } else if ((pc & 1) == 0) {
+//              /* SHcompact */
+//              /* TODO : provide handling for this.  We don't really support
+//                 user-mode SHcompact yet, and for a kernel fault, this would
+//                 have to come from a module built for SHcompact.  */
+//              return -EFAULT;
+//      } else {
+//              /* misaligned */
+//              return -EFAULT;
+//      }
+//   fs/kernfs/file.c:kernfs_fop_open()
+//       * Both paths of the branch look the same.  They're supposed to
+//       * look that way and give @of->mutex different static lockdep keys.
+//       */
+//      if (has_mmap)
+//              mutex_init(&of->mutex);
+//      else
+//              mutex_init(&of->mutex);
+//
+// All other cases look like bugs or at least lack of documentation
+//
+// Confidence: Moderate
+// Copyright: (C) 2016 Nicholas Mc Guire, OSADL.  GPLv2.
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual org
+virtual report
+
+ at cond@
+statement S1;
+position p;
+@@
+
+* if at p (...) S1 else S1
+
+ at script:python depends on org@
+p << cond.p;
+@@
+
+cocci.print_main("WARNING: possible condition with no effect (if == else)",p)
+
+@script:python depends on report@
+p << cond.p;
+@@
+
+coccilib.report.print_report(p[0],"WARNING: possible condition with no effect (if == else)")
-- 
2.1.4
