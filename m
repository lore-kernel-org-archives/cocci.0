From: kborer@cpan.org (Kris Borer)
Date: Thu, 23 Jul 2015 17:56:42 -0400
Subject: [Cocci] if conditions
Message-ID: <CAMy_N60PKB7DYD5-s+pAHRAnpPFqLFGRAquYbP_HOtKCAW4aTQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I have a working semantic patch, but was wondering if there was a way to
avoid some repetition. I am trying to match a number of if-statements, but
only care about the first condition of each. Is there a way to match an
arbitrary number of additional conditions? I tried using dots and various
metavariables without success. Any advice would be appreciated.

bash> cat conditions.c
void main(){
    int x = 0;

    if ( (x = 0) != 0 ) {
        x = 1;
    }

    if ( (x = 0) != 0 && x < 0 ) {
        x = 1;
    }

    if ( (x = 0) != 0 && x < 0 && x > 1 ) {
        x = 1;
    }
}
bash> cat conditions.cocci
@k1@
identifier i;
expression E;
statement S, S2;
constant c;
binary operator b;
@@

+ i = E;
  if (
- (i = E)
+ i
  b c) S else S2

@k2@
identifier i;
expression E, E2;
statement S, S2;
constant c;
binary operator b, b2;
@@

+ i = E;
  if ( (
- (i = E)
+ i
  b c) b2 E2) S else S2

@k3@
identifier i;
expression E, E2, E3;
statement S, S2;
constant c;
binary operator b, b2, b3;
@@

+ i = E;
  if ( ( (
- (i = E)
+ i
  b c) b2 E2) b3 E3) S else S2

bash> spatch --sp-file conditions.cocci conditions.c
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
HANDLING: conditions.c
diff =
--- conditions.c
+++ /tmp/cocci-output-6769-da5e98-conditions.c
@@ -1,15 +1,18 @@
 void main(){
     int x = 0;

-    if ( (x = 0) != 0 ) {
+    x = 0;
+    if (x != 0 ) {
         x = 1;
     }

-    if ( (x = 0) != 0 && x < 0 ) {
+    x = 0;
+    if (x != 0 && x < 0 ) {
         x = 1;
     }

-    if ( (x = 0) != 0 && x < 0 && x > 1 ) {
+    x = 0;
+    if (x != 0 && x < 0 && x > 1 ) {
         x = 1;
     }
 }

Thank you,

Kris
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150723/87b3929a/attachment.html>
