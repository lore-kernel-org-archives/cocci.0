From: ralphs@netwinder.org (Ralph Siemsen)
Date: Sat, 5 Apr 2014 15:32:59 -0400
Subject: [Cocci] Trivial question about renaming prototypes in .h files
In-Reply-To: <alpine.DEB.2.02.1404051944510.2029@localhost6.localdomain6>
References: <20140405155421.GA20098@harvey.netwinder.org>
 <alpine.DEB.2.02.1404051944510.2029@localhost6.localdomain6>
Message-ID: <20140405193259.GA10489@harvey.netwinder.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

Thank you very much for your reply.

On Sat, Apr 05, 2014 at 07:47:23PM +0200, Julia Lawall wrote:
> 
> I'm not sure to understand what you are trying to do.  This replaces one 
> expression by another.  There are no expressions in a function prototype.

I was trying to rename a function, globally within a project. The code
came from http://coccinelle.lip6.fr/docs/main_grammar.pdf on page 14.

By the way, the HTML version of the same document seems to have some
extraneous symbols such as @M which results in syntax errors from spatch.
http://coccinelle.lip6.fr/docs/main_grammar013.html#toc1

> If you want to rename the function foo to bar, then you would write:
> 
> @@
> @@
> 
> - foo
> + bar
>     () { ... }
> 
> This should update any prototype of the function as well.

Thanks, that helps. I'll have to study some more to understand why that
works. In particular, I would not have expected {...} to match against
a function prototype, which just has ";" in that position. Perhaps that
is handled by one of the standard isomophisms?

I have also found that the .h files are only patched correctly when I
list them explicitly on the command line. Seemingly as a result of this,
the --dir option does not work for processing .h files:

spatch --sp-file rename.cocci test.c test.h   # works correctly, both .c/.h
spatch --sp-file rename.cocci test.c          # works correctly, only .c
spatch --sp-file rename.cocci test.h          # no patch is emitted
spatch --sp-file rename.cocci --dir .         # only patches .c
spatch --sp-file rename.coccy --dir . --include-headers # only patches .c

The above tests were done with 1.0.0-rc20 binary from your website. The
files test.c and test.h are trivial, attached just for reference.

Cheers,
-Ralph
-------------- next part --------------
#include <stdio.h>

int foo(int num)
{
	return printf("Hello %d\n", num);
}

int main(int argc, char **argv)
{
	foo(argc);
	return 0;
}
-------------- next part --------------
int foo(int num);
-------------- next part --------------
@@
@@

-foo
+bar
   (int num) { ... }
