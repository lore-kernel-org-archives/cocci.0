From: chrubis@suse.cz (Cyril Hrubis)
Date: Wed, 4 Feb 2015 09:39:00 +0100
Subject: [Cocci] broken comments handling
Message-ID: <20150204083900.GA2093@rei.scz.novell.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi!
I've found potentialy harmful bug while using spatch, see below.

bug.c:
int a; /* This is comment for a */
int b; /* This is comment for b */

bug.cocci:
@@ @@
-int b;

spatch-23 bug.cocci bug.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
warning: line 2: should b be a metavariable?
HANDLING: bug.c
diff =
--- bug.c
+++ /tmp/cocci-output-2227-08362d-bug.c
@@ -1,2 +1 @@
-int a; /* This is comment for a */
-int b; /* This is comment for b */
+int a; /* This is comment for b */

The comment for a is removed and replaced with the comment for b, which may
lead to serious confusion.

-- 
Cyril Hrubis
chrubis at suse.cz
