From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 01 Oct 2014 16:06:56 +0200
Subject: [Cocci] [coccicheck PATCH 3/5] Deletion of unnecessary checks
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
Message-ID: <542C0A80.3090207@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>> If you are convinced that dropping the null tests is a good idea, then you 
>>> can submit the patch that makes the change to the relevant maintainers and 
>>> mailing lists.

>From f4608fceec40b2b94aa9b4abe3bbb6d98ed5eed9 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 5 Mar 2014 18:58:30 +0100
Subject: [PATCH 3/5] Addition of a SQLite script for a text file import

A script was added so that a text file which was previously generated can be
imported into a SQLite data base table.
http://sqlite.org/sqlite.html

The shown file name can be adjusted by a make file for example.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 .../coccinelle/deletions/handle_function_list_template.sqlite    | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644
scripts/coccinelle/deletions/handle_function_list_template.sqlite

diff --git a/scripts/coccinelle/deletions/handle_function_list_template.sqlite
b/scripts/coccinelle/deletions/handle_function_list_template.sqlite
new file mode 100644
index 0000000..bec366c
--- /dev/null
+++ b/scripts/coccinelle/deletions/handle_function_list_template.sqlite
@@ -0,0 +1,9 @@
+create table positions(function text,
+                       data_type text,
+                       parameter text,
+                       source_file text,
+                       line integer,
+                       column integer);
+.separator "|"
+.import list_input_pointer_validation1.txt positions
+.header OFF
-- 
1.9.0
