From: kborer@cpan.org (Kris Borer)
Date: Wed, 15 Jul 2015 09:29:15 -0400
Subject: [Cocci] logical not
Message-ID: <CAMy_N63xCDJbVkXnBvPyoDx6AUE37qsYGb5N2WHJWVR+6Zawxg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I am trying to combine two transformations that differ only by a logical
not. I unsuccessfully tried using the ? annotation, disjunctions, and dots.
Any advice would be appreciated. This is on v1.0.1 + 4 patches.

bash> cat bang.c
void main() {
    int x = 0;

    if ( x = 1 ) {
        x = 1;
    }

    if ( ! (x=1) ) {
        x = 1;
    }
}
bash> cat bang.cocci
@@
identifier i;
expression E;
statement S;
@@

+ i = E;
  if (
- i = E
+ i
  ) S

@@
identifier i;
expression E;
statement S;
@@

+ i = E;
  if (
  !
- (i = E)
+ i
  ) S
bash> spatch --sp-file bang.cocci bang.c
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
HANDLING: bang.c
diff =
--- bang.c
+++ /tmp/cocci-output-8392-707d21-bang.c
@@ -1,11 +1,13 @@
 void main() {
     int x = 0;

-    if ( x = 1 ) {
+    x = 1;
+    if (x) {
         x = 1;
     }

-    if ( ! (x=1) ) {
+    x = 1;
+    if ( ! x) {
         x = 1;
     }
 }
bash> cat bang2.cocci
@@
identifier i;
expression E;
statement S;
@@

+ i = E;
  if (
? !
- (i = E)
+ i
  ) S

bash> spatch --sp-file bang2.cocci bang.c
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
Fatal error: exception Failure("opt only allowed for the elements of a
statement list")

Thank you,

Kris
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150715/3ddb3bd5/attachment.html>
