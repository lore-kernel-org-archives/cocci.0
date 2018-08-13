From: himanshujha199640@gmail.com (Himanshu Jha)
Date: Mon, 13 Aug 2018 16:16:38 +0530
Subject: [Cocci] [PATCH v2] docs: dev-tools: coccinelle: Update documentation
Message-ID: <20180813104638.7935-1-himanshujha199640@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

* Fix install instruction by adding `./autogen` command
  before `./configure`.
* Add link to a more detailed installation instruction.
* Add link to SmPL grammar documentation.
* Add single space after ',' to slightly improve readability.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---

v2:
   - instruction -> instructions
   - Or Github at: -> Or from Github at:

 Documentation/dev-tools/coccinelle.rst | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 94f41c290bfc..aa14f05cabb1 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -30,18 +30,29 @@ of many distributions, e.g. :
  - NetBSD
  - FreeBSD
 
-You can get the latest version released from the Coccinelle homepage at
+Some distribution packages are obsolete and it is recommended
+to use the latest version released from the Coccinelle homepage at
 http://coccinelle.lip6.fr/
 
-Once you have it, run the following command::
+Or from Github at:
 
-     	./configure
+https://github.com/coccinelle/coccinelle
+
+Once you have it, run the following commands::
+
+        ./autogen
+        ./configure
         make
 
 as a regular user, and install it with::
 
         sudo make install
 
+More detailed installation instructions to build from source can be
+found at:
+
+https://github.com/coccinelle/coccinelle/blob/master/install.txt
+
 Supplemental documentation
 ---------------------------
 
@@ -51,6 +62,10 @@ https://bottest.wiki.kernel.org/coccicheck
 
 The wiki documentation always refers to the linux-next version of the script.
 
+For Semantic Patch Language(SmPL) grammar documentation refer to:
+
+http://coccinelle.lip6.fr/documentation.php
+
 Using Coccinelle on the Linux kernel
 ------------------------------------
 
@@ -223,7 +238,7 @@ Since coccicheck runs through make, it naturally runs from the kernel
 proper dir, as such the second rule above would be implied for picking up a
 .cocciconfig when using ``make coccicheck``.
 
-``make coccicheck`` also supports using M= targets.If you do not supply
+``make coccicheck`` also supports using M= targets. If you do not supply
 any M= target, it is assumed you want to target the entire kernel.
 The kernel coccicheck script has::
 
-- 
2.17.1
