From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 22 Feb 2014 09:09:27 +0100
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
Message-ID: <53085B37.6030005@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Not sure what you mean by extended.

I have tried the following search pattern.

@Show_functions_with_input_pointer_validation@
identifier fun, x;
type t;
@@
*fun(..., t* x, ...)
 {
  ...
  if (!x) return;
  ...
 }


Will your current tool version "1.0.0-rc20" find also the kfree() functions?
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/mm/slab.c#n3641

Should I add any variant of "unlikely(ZERO_OR_NULL_PTR(...))" to my filter
pattern eventually?


> If you want to propose Linux related fixes, you may want to look at the 
> kernel janitors mailing list.

Would it make sense to add the shown semantic patches to a specific script
directory?
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/scripts/coccinelle

Regards,
Markus
