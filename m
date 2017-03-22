From: sebald.ziegler.cocci@ikolus.de (sebald.ziegler.cocci at ikolus.de)
Date: Wed, 22 Mar 2017 15:28:41 +0100
Subject: [Cocci] Problems with adding code after macro definitions
Message-ID: <8873570.AgTeYTv5Np@detux>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I try to use coccinelle for some kind of Macro instrumentation.
One important step is to define a wrapper for a macro after the original macro definition.
This is attempted in the rule: macro_wrapper_int_MAX_int_int
But I cannot get it to work - see the ???.
All other rules work as intended.

So the question is: What is the right way to specify the macro definition after which something should be added?
Is it at all possible to only use the name of the macro and some wildcard (as opposed to using macro name and its definition).

@script:python macros@
macro_wrapper_int_MAX_int_int_str;
@@
coccinelle.macro_wrapper_int_MAX_int_int_str = '({printf("MAX\\n"); MAX(p0, p1); })'

@macro_wrapper_int_MAX_int_int@
identifier macros.macro_wrapper_int_MAX_int_int_str;
@@
#define MAX(x,y) ???
+#define macro_wrapper_int_MAX_int_int(p0, p1) macro_wrapper_int_MAX_int_int_str

@macro_replacer_macro_wrapper_int_MAX_int_int@
int P0;
int P1;
@@
-MAX(P0, P1)
+macro_wrapper_int_MAX_int_int(P0, P1)

C program:
$ cat test.c
#define MAX(x,y) ((x>y)?x:y)
#include <stdio.h>
int main(int argc, char** argv) {
        int a=5;
        int b=7;
        int d=MAX(a,b+4);
        return d;
}

Any hints and information is greatly appreciated!

Thanks,
Sebald
