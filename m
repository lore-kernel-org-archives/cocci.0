From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 3 Mar 2017 17:19:20 +0100 (CET)
Subject: [Cocci] Problems: Adding Include directives,
 Adding ({}) construct
In-Reply-To: <2728810.xJvpTgCk22@detux>
References: <2728810.xJvpTgCk22@detux>
Message-ID: <alpine.DEB.2.20.1703031718010.3490@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 27 Feb 2017, sebald.ziegler.cocci at ikolus.de wrote:

> Hi,
>
> I am trying to use coccinelle to add an include directive before the other
> includes and one after the includes:
>
> @PreInclude@
> @@
> + #include "pre.h"
> #include ...
>
>
> @PostInclude@
> @@
> #include ...
> + #include "post.h"
>
> this works well if the source file (all includes are always at the top of the
> file) contains more than one include directive. However, if there is only one
> include directive -> only the PreInclude rule is executed.
>
> So for this program:
> #include <stdio.h>
>
> int main() {
>     return 0;
> }
>
> This is the result:
> #include "pre.h"
> #include <stdio.h>
>
> int main() {
>     return 0;
> }
>
> So it seems that only one rule can match some code line/code pattern. Am I
> mistaken? What could be an approach that works for both the single include
> directive and multiple include directives case?

It seems to be a special case for includes.  Includes know whether they
are the first or last include.  But when you add something before or after
an include, it loses this information.  Afterwards, a rule that wants to
add before the first include or after the last one does not apply.

julia

>
>
> Another Question:
> With the following rule I want to add a macro definition just above the main
> function:
> @macro_square@
> @@
> + #define SQUARE(x) ({printf("SQUARE(x)\n"); x*x; })
> int main(int argc, char ** argv) {
> ...
> }
>
> If I execute spatch on the program above this error is reported (coccinelle
> version: 1.0.6):
> plus: parse error:
>   File "/tmp/testing/test.c-brackets.cocci", line 3, column 21, charpos = 39
>   around = '{',
>   whole content = + #define SQUARE(x) ({printf("SQUARE(x)\n"); x*x; })
>
> Is this kind of code not supported or did I make a mistake somewhere?
>
> Thank you for any information and hints!
>
> Regards,
> Sebald
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
