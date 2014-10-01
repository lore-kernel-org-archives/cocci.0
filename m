From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 01 Oct 2014 16:06:30 +0200
Subject: [Cocci] [coccicheck PATCH 1/5] Deletion of unnecessary checks
 before specific function calls
In-Reply-To: <542BFB2C.5070609@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <542BFB2C.5070609@users.sourceforge.net>
Message-ID: <542C0A66.8000009@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>> If you are convinced that dropping the null tests is a good idea, then you 
>>> can submit the patch that makes the change to the relevant maintainers and 
>>> mailing lists.

>From 48c9c4f61a7d7ea98538e02631a981a429281005 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 5 Mar 2014 18:15:34 +0100
Subject: [PATCH 1/5] Addition of a semantic patch file for showing unnecessary
 checks before a few known functions

This semantic patch pattern tries to find source code places where a check
is performed for an expression that is passed to a function (like "kfree")
which checks this single parameter itself for usability.
Redundant value or pointer checks can be avoided here.

The pattern contains a special comment in a regular expression for a SmPL
constraint which supports extensions.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 .../deletions/delete_unnecessary_checks_template1.cocci     | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644
scripts/coccinelle/deletions/delete_unnecessary_checks_template1.cocci

diff --git
a/scripts/coccinelle/deletions/delete_unnecessary_checks_template1.cocci
b/scripts/coccinelle/deletions/delete_unnecessary_checks_template1.cocci
new file mode 100644
index 0000000..b092051
--- /dev/null
+++ b/scripts/coccinelle/deletions/delete_unnecessary_checks_template1.cocci
@@ -0,0 +1,13 @@
+ at Delete_unnecessary_checks@
+expression x;
+identifier release =~ "^(?x)
+(?:
+   (?:kz?|slob_)free
+|
+   (?:
+# Alternation placeholder
+   )
+)$";
+@@
+-if (x)
+    release(x);
-- 
1.9.0
