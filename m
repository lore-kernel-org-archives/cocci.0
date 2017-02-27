From: sebald.ziegler.cocci@ikolus.de (sebald.ziegler.cocci at ikolus.de)
Date: Mon, 27 Feb 2017 14:04:38 +0100
Subject: [Cocci] Problems: Adding Include directives, Adding ({}) construct
Message-ID: <2728810.xJvpTgCk22@detux>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I am trying to use coccinelle to add an include directive before the other 
includes and one after the includes:

@PreInclude@
@@
+ #include "pre.h"
#include ...


@PostInclude@
@@
#include ...
+ #include "post.h"

this works well if the source file (all includes are always at the top of the 
file) contains more than one include directive. However, if there is only one 
include directive -> only the PreInclude rule is executed.

So for this program:
#include <stdio.h>

int main() {
    return 0;
}

This is the result:
#include "pre.h"
#include <stdio.h>

int main() {
    return 0;
}

So it seems that only one rule can match some code line/code pattern. Am I 
mistaken? What could be an approach that works for both the single include 
directive and multiple include directives case?


Another Question:
With the following rule I want to add a macro definition just above the main 
function:
@macro_square@
@@
+ #define SQUARE(x) ({printf("SQUARE(x)\n"); x*x; })
int main(int argc, char ** argv) {
...
}

If I execute spatch on the program above this error is reported (coccinelle 
version: 1.0.6):
plus: parse error: 
  File "/tmp/testing/test.c-brackets.cocci", line 3, column 21, charpos = 39
  around = '{',
  whole content = + #define SQUARE(x) ({printf("SQUARE(x)\n"); x*x; })

Is this kind of code not supported or did I make a mistake somewhere?

Thank you for any information and hints!

Regards,
Sebald
