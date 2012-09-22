From: eric@regit.org (Eric Leblond)
Date: Sat, 22 Sep 2012 10:29:15 +0200
Subject: [Cocci] Unwanted space added at end of line
Message-ID: <1348302555.11590.8.camel@ice-age.regit.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I've just wrote a really simple SMPL (attached to the mail). It makes a
modification on the code which is the following:

- if (x == NULL) S1
+ if (unlikely(x == NULL)) S1

The result is semantically correct but there is spaces at end of line as
shown in the example below:

@@ -173,8 +173,8 @@ DefragContextNew(void)
     DefragContext *dc;
 
     dc = SCCalloc(1, sizeof(*dc));
-    if (dc == NULL)
-        return NULL;<- no space
+    if (unlikely(dc == NULL))
+        return NULL;   <- 4 space here 

I've tried to look@coccinelle code but I'm unable to find a way to a
solution.

Am I missing an option ?

BR,
--
Eric Leblond

-------------- next part --------------
@istested@
identifier x;
statement S1;
identifier func =~ "(SCMalloc|SCStrdup|SCCalloc)";
@@

x = func(...)
... when != x
- if (x == NULL) S1
+ if (unlikely(x == NULL)) S1
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 190 bytes
Desc: This is a digitally signed message part
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20120922/52ec3cfa/attachment.asc>
