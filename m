From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 21 Feb 2014 23:27:02 +0100 (CET)
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <5307CAA2.8060406@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 21 Feb 2014, SF Markus Elfring wrote:

> Hello,
> 
> I have tried the following short semantic patch out on a source file directory
> for Linux 3.13.1.
> 
> @Remove_unnecessary_pointer_checks@
> expression x;
> @@
> -if (x)
>     kfree(x);
> 
> 
> Some update candidates were found. I imagine that this search pattern can be
> extended a bit more.

Not sure what you mean by extended.  There are indeed some other functions 
in Linux that perform NULL tests before doing anything, and thus they 
don't really need a null test around them.  Actually, it could be possible 
to find such functions using Coccinelle.

On the other hand, I think that one should study the code carefully before 
making such a change.  There are several ways to make error handling code.  
One is to have one label at the end of the function, to have all error 
cases jump to there, and then to have if tests to decide what should be 
done.  Another way is to have lots of labels, and jump directly to the 
right place, without any tests.

I think that the second way is nicer.  So in removing such an if, one can 
consider whether the code could be further improved by adding more labels, 
and jumping to the right place directly, rather tha executing unnecessary 
code.

> How do think about the applicability of corresponding changes for current kernel
> source code?
> What will be a good way to discuss such fixes on other mailing lists eventually?

If you want to propose Linux related fixes, you may want to look at the 
kernel janitors mailing list.

http://vger.kernel.org/vger-lists.html#kernel-janitors

julia
