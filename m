From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 28 Oct 2014 21:19:22 +0100 (CET)
Subject: [Cocci] Parsing errors in several headers
In-Reply-To: <544FED2B.2030305@dumbbell.fr>
References: <544FDF5C.6040009@dumbbell.fr>
 <alpine.DEB.2.10.1410281930130.2567@hadrien> <544FE5AD.60208@dumbbell.fr>
 <544FEA20.4030400@users.sourceforge.net> <544FED2B.2030305@dumbbell.fr>
Message-ID: <alpine.DEB.2.02.1410282118550.2090@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 28 Oct 2014, Jean-S?bastien P?dron wrote:

> On 28.10.2014 20:10, SF Markus Elfring wrote:
> >> Ok, then I must have a problem with my semantic patch, because it
> >> doesn't change anything :) I thought it was because of the parsing error.
> > 
> > Would you like to show your SmPL approach here so that we could help you more
> > eventually?
> 
> Sure! I wanted to add a #define just above a function prototype or the
> function itself.
> 
> Example #1:
>   int foo();
> 
> should become:
>   #define foo BAR(foo)
>   int foo();
> 
> Example #2:
>   int foo() { /* ... */ }
> 
> should become:
>   #define foo BAR(foo)
>   int foo() { /* ... */ }
> 
> Here's the script I used, which worked with example #1:
> 
> ---8<---
> @rule1@
> identifier func;
> @@
> 
> -#define        func    BAR(func)
> 
> @rule2@
> identifier func;
> type ret;
> @@
> 
> +#define        func    BAR(func)
> ret func(...);
> ---8<---
> 
> I can handle example #2 with this one:
> 
> ---8<---
> @rule1@
> identifier func;
> @@
> 
> -#define        func    BAR(func)
> 
> @rule2@
> identifier func;
> type ret;
> @@
> 
> +#define        func    BAR(func)
> ret func(...) { ... }
> ---8<---
> 
> However, I fail to assemble those two patches in a single concise one.

It is not possible.  You need two rules.

julia

> 
> Thank you for offering your help :)
> 
> -- 
> Jean-S?bastien P?dron
> 
> 
