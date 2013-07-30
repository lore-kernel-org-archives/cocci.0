From: volanschi@metaware.fr (Nic Volanschi (R&D))
Date: Tue, 30 Jul 2013 14:36:32 +0200
Subject: [Cocci] transforming non-pointer arguments in a call
Message-ID: <1375187792.3200.33.camel@zamolxis.metaware.tm.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi list,

I'm trying to implement a transformation over the actual arguments
passed in a function call, ensuring that all variables are pointers: for
every variable argument that is not a pointer, a '&' operator should be
added.

For instance, in the following C file:

#include <stdio.h>
#define ISRT "insert"

int ctdli() {}

typedef struct {int i; int j;} COMPLEX;

int main() {
  int n = 3;
  COMPLEX *strp;
  COMPLEX str;
  ctdli();
  ctdli("none");
  ctdli(1);
  ctdli("insert", 2, 3.0);
  ctdli(3, "insert", 2, 3.0);
  ctdli(n, "insert", 2, 3.0);
  ctdli(n+1, "insert", 2, 3.0, "quatre");
  ctdli("insert", 2, 3.0);
  ctdli("insert", str, 2, 3.0);
  ctdli(3, "insert", 2, str, 3.0);
  ctdli(n, "insert", 2, 3.0, str);
  ctdli(ISRT, 2, str, str);
  ctdli("insert", strp, 2, 3.0);
  ctdli(n-1, "insert", 2, strp, 3.0);
  ctdli(n, "insert", 2, 3.0, strp);
  ctdli(2, "insert", strp, strp);
  ctdli("insert", str, strp, 3.0);
  ctdli(3, "insert", strp, str, 3.0);
  ctdli(n, "insert", strp, 3.0, str);
  printf("hi\n");
}

the following calls should be changed:

-  ctdli(n, "insert", 2, 3.0);
+  ctdli(&n, "insert", 2, 3.0);
   ctdli(n+1, "insert", 2, 3.0, "quatre");
   ctdli("insert", 2, 3.0);
-  ctdli("insert", str, 2, 3.0);
-  ctdli(3, "insert", 2, str, 3.0);
-  ctdli(n, "insert", 2, 3.0, str);
-  ctdli(ISRT, 2, str, str);
+  ctdli("insert", &str, 2, 3.0);
+  ctdli(3, "insert", 2, &str, 3.0);
+  ctdli(n, "insert", 2, 3.0, &str);
+  ctdli(ISRT, 2, &str, &str);
   ctdli("insert", strp, 2, 3.0);
   ctdli(n-1, "insert", 2, strp, 3.0);
   ctdli(n, "insert", 2, 3.0, strp);
   ctdli(2, "insert", strp, strp);
-  ctdli("insert", str, strp, 3.0);
-  ctdli(3, "insert", strp, str, 3.0);
-  ctdli(n, "insert", strp, 3.0, str);
+  ctdli("insert", &str, strp, 3.0);
+  ctdli(3, "insert", strp, &str, 3.0);
+  ctdli(n, "insert", strp, 3.0, &str);

I tried the following rule to do this:

@@ idexpression *ptr; idexpression e; @@
 ctdli(...,
(
 ptr
|
-e
+&e
)
  , ...)

This rule correctly changed the first 4 calls above, but not the last 3
ones: whenever the call contains at least one pointer argument (strp),
the other non-pointer arguments (str) are no more changed.

Is this a bug or a feature?
If it is a feature, somehow related to the semantics of "...", how can I
transform every non-pointer variable argument to a pointer?
Nic.
