From: kborer@cpan.org (Kris Borer)
Date: Thu, 9 Jul 2015 18:44:10 -0400
Subject: [Cocci] binary operator matching on v1.0.1
Message-ID: <CAMy_N609w3sYYyn54z4MTzPifpZVSaZ7gDPGPCcxajdbw=hhOA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I was able to get some basic binary operator matching working with version
1.0.1, but got stuck with the following example. Any advice would be
appreciated.

bash> spatch --version
spatch version 1.0.1 with Python support and with PCRE support
bash> cat binop.c
void main() {
    int i = 0;
    int j = 0;

    if( (i = j) < 0 ) {
        i = j;
    }
}
bash> cat binop.cocci
@@
identifier i, i2;
statement S;
constant c;
binary operator b;
@@

+ i = i2;
  if(
- (i = i2)
+ i
  <
  c) S
bash> spatch --sp-file binop.cocci binop.c
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
warning: rule starting on line 1: metavariable b not used in the - or
context code
HANDLING: binop.c
diff =
--- binop.c
+++ /tmp/cocci-output-21368-193fad-binop.c
@@ -2,7 +2,8 @@ void main() {
     int i = 0;
     int j = 0;

-    if( (i = j) < 0 ) {
+    i = j;
+    if(i < 0 ) {
         i = j;
     }
 }
bash> cat binop2.cocci
@@
identifier i, i2;
statement S;
constant c;
binary operator b;
@@

+ i = i2;
  if(
- (i = i2)
+ i
  b
  c) S
bash> spatch --sp-file binop2.cocci binop.c
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
Fatal error: exception Failure("not possible 8")
bash> diff binop.cocci binop2.cocci
12c12
<   <
---
>   b


Thanks,

Kris
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150709/34fdfbfd/attachment.html>
