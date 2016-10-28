From: mylesgw@google.com (Myles Watson)
Date: Fri, 28 Oct 2016 15:52:23 -0700
Subject: [Cocci] Newbie questions: Missing comments, attribute parsing
Message-ID: <CAFO6UKWH418v7BZsYarycrv-BvFdxLuZZgJzX78-kReMQgvo2w@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

1. Missing comments:

I was using this cocci file to remove uses of the UNUSED macro, and noticed
that it also removes comments around the macro.

2. Attribute parsing:
I know that GETRIDOFTHISCOMMA, is a hack, but I couldn't figure out how to
add UNUSED_ATTR to the declaration.

Thanks,
Myles

output:
$ spatch --version
spatch version 1.0.0-rc19 with Python support and with PCRE support

...

with isos from: /usr/share/coccinelle/standard.iso
-----------------------------------------------------------------------
@r1@
identifier arg;
identifier fn;
type t;
parameter list[n] P;
@@

fn(P, t arg) { ...
 UNUSED(arg);
 ...
 }

@depends on r1@
identifier r1.arg;
identifier r1.fn;
type r1.t;
parameter list[r1.n] r1.P;
typedef UNUSED_ATTR;
@@

fn(P,
- t arg
+ UNUSED_ATTR GETRIDOFTHISCOMMA, t arg
 ) { ...
-UNUSED(arg);
 ...
 }


HANDLING: test.c
-----------------------------------------------------------------------
let's go
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
r1 =
-----------------------------------------------------------------------
dependencies for rule r1 satisfied:
binding in = []
binding relevant in = []
     transformation info is empty
     binding out = [r1.fn --> id SomeFunc;r1.P --> <<paramlist>>;r1.n --> 0;
                   r1.t --> int;r1.arg --> id foo]
-----------------------------------------------------------------------
rule starting on line 13 =
-----------------------------------------------------------------------
dependencies for rule rule starting on line 13 satisfied:
r1 satisfied
binding in = [r1.P --> <<paramlist>>;r1.arg --> id foo;r1.fn --> id
SomeFunc;
             r1.n --> 0;r1.t --> int]
binding relevant in = [r1.P --> <<paramlist>>;r1.arg --> id foo;
                      r1.fn --> id SomeFunc;r1.n --> 0;r1.t --> int]
     transformation info returned:
          transform state: 1
               with rule_elem: r1:fn(r1:P-r1:t
                                       >>> UNUSED_ATTR GETRIDOFTHISCOMMA,
                                           r1:t r1:arg
                                      -r1:arg)
               with binding: [r1.P --> <<paramlist>>;r1.arg --> id foo;
                             r1.fn --> id SomeFunc;r1.n --> 0;r1.t --> int]
          transform state: 6
               with rule_elem: -UNUSED-(-r1:arg-)-;
               with binding: [r1.P --> <<paramlist>>;r1.arg --> id foo;
                             r1.fn --> id SomeFunc;r1.n --> 0;r1.t --> int]
     binding out = []
     transform one node: 6
     transform one node: 1
*5: ERASING_COMMENTS: /* to be implemented */*
-----------------------------------------------------------------------
proto for rule starting on line 13 =
-----------------------------------------------------------------------
dependencies for rule proto for rule starting on line 13 satisfied:
rule starting on line 13 satisfied
binding in = [r1.P --> <<paramlist>>;r1.arg --> id foo;r1.fn --> id
SomeFunc;
             r1.n --> 0;r1.t --> int]
binding relevant in = [r1.P --> <<paramlist>>;r1.arg --> id foo;
                      r1.fn --> id SomeFunc;r1.n --> 0;r1.t --> int]
-----------------------------------------------------------------------
Finished
-----------------------------------------------------------------------
diff =
--- test.c
+++ /tmp/cocci-output-7586-ec1ff0-test.c
@@ -1,8 +1,5 @@
-bool SomeFunc(int foo)
+bool SomeFunc(UNUSED_ATTR GETRIDOFTHISCOMMA, int foo)
 {
-    UNUSED(foo);
-
*-    /* to be implemented */*
     return true;
 }

Check duplication for 1 files
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20161028/d977d6f3/attachment.html>
