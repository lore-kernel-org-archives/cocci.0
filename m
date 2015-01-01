From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 1 Jan 2015 18:33:29 +0100 (CET)
Subject: [Cocci] adding function declarations
In-Reply-To: <54A55D15.5020306@warlich.name>
References: <54A55D15.5020306@warlich.name>
Message-ID: <alpine.DEB.2.02.1501011829330.2060@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Unfortunately, your seemingly simple request raises some issues :)

First, you should apply the patch below to Coccinelle version 1.0.0-rc23 
(the latest version).

Second here is a semantic patch that goes in the right direction, but is 
not perfect:

@@
type T;
identifier f;
parameter list ps;
@@

+static __attribute__((always_inline)) T f(ps);
-static inline T
+static inline T
f(ps) { ... }

For some reason, the semantic patch parser is not allowing me to put 
inline in the prototype.  I will look into it and send another patch.

Also for the following file:

static inline __attribute__((always_inline)) int foo(int x) {
  return x;
}

the output is missing a space before the attribute:

diff = 
--- tests/statinl.c
+++ /tmp/cocci-output-32260-27b877-statinl.c
@@ -1,3 +1,4 @@
-static inline __attribute__((always_inline)) int foo(int x) {
+static__attribute__((always_inline)) int foo(int x);
+static inline int foo(int x) {
   return x;
 }

I will look into this as well.

julia
