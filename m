From: akos.pasztory@gmail.com (Akos PASZTORY)
Date: Thu, 1 May 2014 13:10:04 +0300
Subject: [Cocci] changing all arguments in a call
Message-ID: <CAJwHcF6jDP9-L2DcBUKWkLAAvkoJvehaXq4ko-289pokV75e9Q@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

what did I mess up below?
I was trying to mangle all arguments of a call but the last one is not handled:

$ cat bug.c
void foo() {
    bar(a,b,c);
}
$ cat bug.cocci
@@ expression e; @@
bar(...,
- e,
+ XYZ(e),
...)
$ spatch --sp-file bug.cocci bug.c
init_defs_builtins: /usr/share/coccinelle/standard.h
HANDLING: bug.c
diff =
--- bug.c
+++ /tmp/cocci-output-27316-d0cede-bug.c
@@ -1,3 +1,3 @@
 void foo() {
-    bar(a,b,c);
+    bar(XYZ(a), XYZ(b), c);
 }
$ spatch --version
spatch version 1.0.0-rc21 with Python support and with PCRE support
