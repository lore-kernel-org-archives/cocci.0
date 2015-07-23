From: kborer@cpan.org (Kris Borer)
Date: Thu, 23 Jul 2015 08:17:40 -0400
Subject: [Cocci] comment indentation
Message-ID: <CAMy_N63kc-dysJ3TS37Ju3+EqLtDqv50SyN31Poy3qTEprW=Xw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I noticed a case where a comment seems to be incorrectly indented after
transformation. Any advice would be appreciated. This is on v1.0.1 + 4
patches.

bash> cat comment.c
void main() {
    int x = 0;

    if( x ) {
        x = 1;
    } else if ( x = 1 ) {
        // set x
        x = 1;
    }
}
bash> cat comment.cocci
@@
identifier i;
expression E;
statement S1, S2;
@@

+ i = E;
  if (
- (i = E)
+ i
  ) S1 else S2

bash> spatch --sp-file comment.cocci comment.c
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
HANDLING: comment.c
diff =
--- comment.c
+++ /tmp/cocci-output-7478-e7a9c5-comment.c
@@ -3,8 +3,11 @@ void main() {

     if( x ) {
         x = 1;
-    } else if ( x = 1 ) {
-        // set x
+    } else {
         x = 1;
+        if (x) {
+        // set x
+            x = 1;
+        }
     }
 }


Thank you,

Kris
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150723/af5dd712/attachment.html>
