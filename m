From: joe@perches.com (Joe Perches)
Date: Thu, 13 Nov 2014 11:55:29 -0800
Subject: [Cocci] spatch for trivial pointer comparison style?
Message-ID: <1415908529.4223.11.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I added a checkpatch entry for this.
Maybe some cocci test like this would be useful?

@@
type t;
t *p;
@@
-	p == NULL
+	!p

@@
type t;
t *p;
@@
-	p != NULL
+	p

@@
type t;
t *p;
@@
-	NULL == p
+	!p

@@
type t;
t *p;
@@
-	NULL != p
+	p
