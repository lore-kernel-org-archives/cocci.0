From: standby24x7@gmail.com (Masanari Iida)
Date: Sun, 17 Jul 2016 07:25:35 +0900
Subject: [Cocci] [bug-cocci][PATCH 1/2] Fixed: typo in pycocci.1
Message-ID: <20160716222536.29172-1-standby24x7@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This patch fix 3 typos found in docs/pycocci.1
---
 docs/pycocci.1 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/pycocci.1 b/docs/pycocci.1
index 8d94d23aae0c..46d500f56a9a 100644
--- a/docs/pycocci.1
+++ b/docs/pycocci.1
@@ -81,7 +81,7 @@ can typically display differences better.
 default given that at least for Linux kernel development some C files tend to
 include headers in paths only specified by a target's Makefile through
 utilities such as subdir-ccflags or ccflags-y making it difficult to ensure
-all required header files are read by Coccinelle. We are agressive with
+all required header files are read by Coccinelle. We are aggressive with
 headers search and inclusion.
 
 A default timeout of 120 seconds is used by default. Not using a timeout
@@ -188,7 +188,7 @@ used to apply the <SmPL-patch.cocci> ("pycocci-smpl-8-random-chars"). \fBpycocci
 display name of the newly created branches and finally provide the
 output of \fBgit diff --stat <pycocci-patch-8-random-chars>..<pycocci-smpl-8-random-chars>\fP. You should see
 no changes, and therefore a \fBperfect SmPL patch equivalence\fP, when the diffstat
-on the ouput shows no changes. The way to interpet a positive diffstat is that
+on the output shows no changes. The way to interpret a positive diffstat is that
 the <SmPL-patch.cocci> is introducing more changes than the patch series. The
 way to interpret a negative diffstat is that the <SmPL-patch.cocci> is lacking
 some changes in place on the patch series. \fBpycocci\fP will use \fBgit rev-parse --toplevel\fP
-- 
2.9.2.277.g2949358
