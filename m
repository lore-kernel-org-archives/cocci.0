From: kborer@cpan.org (Kris Borer)
Date: Sun, 12 Jul 2015 13:20:13 -0400
Subject: [Cocci] binary operator matching on v1.0.1
In-Reply-To: <alpine.DEB.2.10.1507111837110.6791@hadrien>
References: <CAMy_N609w3sYYyn54z4MTzPifpZVSaZ7gDPGPCcxajdbw=hhOA@mail.gmail.com>
 <alpine.DEB.2.10.1507111837110.6791@hadrien>
Message-ID: <CAMy_N61Ce4jvQnrXMEvPPJrC_9sdJ3nuL3xmU8RyaWpOYoaUdA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Thank you for your help. After applying both patches, my previous test
cases work. However, I have a new case where binary operators do not seem
to work as expected.

bash> cat binop3.c
struct dog { int age; };

void main() {
    int i = 0;
    struct dog spot = {2};
    struct dog* spot_p = &spot;
    if( spot_p->age && (i = spot_p->age) < 3 ) {
        i = 1;
    }
}
bash> cat binop3.cocci
@@
identifier i, i2;
expression E1, E2;
constant c;
binary operator b;
@@

+ if( E1->i ) {
+      i2 = E2;
+     if (i2 < c) {
- if( E1->i && (i2 = E2) < c ) {
  ...
- }
+     }
+ }
bash> spatch --sp-file binop3.cocci binop3.c
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
warning: rule starting on line 1: metavariable b not used in the - or
context code
HANDLING: binop3.c
diff =
--- binop3.c
+++ /tmp/cocci-output-8451-cce009-binop3.c
@@ -4,7 +4,10 @@ void main() {
     int i = 0;
     struct dog spot = {2};
     struct dog* spot_p = &spot;
-    if( spot_p->age && (i = spot_p->age) < 3 ) {
-        i = 1;
+    if (spot_p->age) {
+        i = spot_p->age;
+        if (i < 3) {
+            i = 1;
+        }
     }
 }
bash> cat binop4.cocci
@@
identifier i, i2;
expression E1, E2;
constant c;
binary operator b;
@@

+ if( E1->i ) {
+      i2 = E2;
+     if (i2 b c) {
- if( E1->i && (i2 = E2) b c ) {
  ...
- }
+     }
+ }
bash> spatch --sp-file binop4.cocci binop3.c
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
HANDLING: binop3.c
bash> diff binop3.cocci binop4.cocci
10,11c10,11
< +     if (i2 < c) {
< - if( E1->i && (i2 = E2) < c ) {
---
> +     if (i2 b c) {
> - if( E1->i && (i2 = E2) b c ) {


Thanks,

Kris
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150712/ed3b2fa5/attachment.html>
