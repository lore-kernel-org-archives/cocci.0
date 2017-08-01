From: ydroneaud@opteya.com (Yann Droneaud)
Date: Tue, 01 Aug 2017 15:04:01 +0200
Subject: [Cocci] Surprising parsing error occuring when casting C string
Message-ID: <1501592641.3791.10.camel@opteya.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I'm wondering why coccinelle seems not to be able to apply simple
semantic patch when code source contains casted C string.

Given simple source file (note the lack of definition for types,
assuming they're somewhere in an included header):

$ cat test.c
static structure_t array[] =
{
        { (pointer_t)"a string", 32 },
        { (pointer_t)DEFINED, 23 }
};

void function(void)
{
        if (!other(1, (pointer_t)"value", 3))
                foo();
        else
                bar();
}

And very simple semantic patch:

$ cat test.cocci
@@
@@
- foo()
+ FOO()

Here's the result:

$ spatch --verbose-parsing --sp-file test.cocci test.c
init_defs_builtins: /usr/lib64/coccinelle/standard.h
HANDLING: test.c
ERROR-RECOV: found sync '}' at line 5
ERROR-RECOV: found sync bis, eating } and ;
parsing pass2: try again
ERROR-RECOV: found sync '}' at line 5
ERROR-RECOV: found sync bis, eating } and ;
parse error 
 = File "test.c", line 3, column 21, charpos = 52
  around = '"a string"',
  whole content =         { (pointer_t)"a string", 32 },
badcount: 4
bad: static structure_t array[] =
bad: {
BAD:!!!!!         { (pointer_t)"a string", 32 },
bad:         { (pointer_t)DEFINED, 23 }
bad: };
ERROR-RECOV: found sync '}' at line 13
parsing pass2: try again
ERROR-RECOV: found sync '}' at line 13
parse error 
 = File "test.c", line 9, column 33, charpos = 164
  around = '"value"',
  whole content =         if (!other(1, (pointer_t)"value", 3))
badcount: 8
bad: };
bad: 
bad: void function(void)
bad: {
BAD:!!!!!         if (!other(1, (pointer_t)"value", 3))
bad:                 foo();
bad:         else
bad:                 bar();
bad: }

Modifying a bit the semantic patch to make "pointer_t" a known type
doesn't help:

$ cat test-typedef.cocci
@@
typedef pointer_t;
@@
- foo()
+ FOO()

$ spatch --verbose-parsing --sp-file test-typedef.cocci test.c
init_defs_builtins: /usr/lib64/coccinelle/standard.h
HANDLING: test.c
ERROR-RECOV: found sync '}' at line 5
ERROR-RECOV: found sync bis, eating } and ;
parsing pass2: try again
ERROR-RECOV: found sync '}' at line 5
ERROR-RECOV: found sync bis, eating } and ;
parse error 
 = File "test.c", line 3, column 21, charpos = 52
  around = '"a string"',
  whole content =         { (pointer_t)"a string", 32 },
badcount: 4
bad: static structure_t array[] =
bad: {
BAD:!!!!!         { (pointer_t)"a string", 32 },
bad:         { (pointer_t)DEFINED, 23 }
bad: };
ERROR-RECOV: found sync '}' at line 13
parsing pass2: try again
ERROR-RECOV: found sync '}' at line 13
parse error 
 = File "test.c", line 9, column 33, charpos = 164
  around = '"value"',
  whole content =         if (!other(1, (pointer_t)"value", 3))
badcount: 8
bad: };
bad: 
bad: void function(void)
bad: {
BAD:!!!!!         if (!other(1, (pointer_t)"value", 3))
bad:                 foo();
bad:         else
bad:                 bar();
bad: }

In other hand, if I modify the source file to have definition for
pointer_t type, and reuse the initial semantic patch, everything is
fine:

$ diff -u test.c test-typedef.c
--- test.c	2017-08-01 14:31:03.773388889 +0200
+++ test-typedef.c	2017-08-01 14:32:15.958502964 +0200
@@ -1,3 +1,5 @@
+typedef unsigned char *pointer_t;
+
 static structure_t array[] =
 {
         { (pointer_t)"a string", 32 },

$ spatch --verbose-parsing --sp-file test.cocci test-typedef.c
init_defs_builtins: /usr/lib64/coccinelle/standard.h
HANDLING: test-typedef.c
diff = 
--- test-typedef.c
+++ /tmp/cocci-output-15390-91b50a-test-typedef.c
@@ -9,7 +9,7 @@ static structure_t array[] =
 void function(void)
 {
         if (!other(1, (pointer_t)"value", 3))
-                foo();
+                FOO();
         else
                 bar();
 }

While I cannot explained why it works, defining "structure_t" type in
source code also makes spatch happy (I belive coccinelle is able to
infer pointer_t is a type):

$ diff -u test.c test-struct.c
--- test.c	2017-08-01 14:31:03.773388889 +0200
+++ test-struct.c	2017-08-01 14:31:29.788430001 +0200
@@ -1,3 +1,11 @@
+struct structure
+{
+        pointer_t p;
+        int i;
+};
+
+typedef structure structure_t;
+
 static structure_t array[] =
 {
         { (pointer_t)"a string", 32 },


$ spatch --verbose-parsing --sp-file test.cocci test-struct.c
init_defs_builtins: /usr/lib64/coccinelle/standard.h
HANDLING: test-struct.c
diff = 
--- test-struct.c
+++ /tmp/cocci-output-15527-0af6db-test-struct.c
@@ -15,7 +15,7 @@ static structure_t array[] =
 void function(void)
 {
         if (!other(1, (pointer_t)"value", 3))
-                foo();
+                FOO();
         else
                 bar();
 }



Why `(pointer_t) "string"' is considered bad, when no proper type is
defined in the current source file ?

As soon as such construct is located in a function, the whole function
get skipped by coccinelle, which is a pity when something has to be
patched in the function.

When applying semantic patches on large code base, it's sad to have to
go through all files to check and apply patch manually.

What can I do to work around this issue ?

Regards.

-- 
Yann Droneaud
OPTEYA
