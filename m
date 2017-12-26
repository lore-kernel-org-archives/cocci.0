From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 26 Dec 2017 18:39:07 +0100
Subject: [Cocci] [PATCH] Coccinelle: kzalloc-simple: Add more zero
 allocating functions
In-Reply-To: <1514116040-9815-1-git-send-email-himanshujha199640@gmail.com>
References: <1514116040-9815-1-git-send-email-himanshujha199640@gmail.com>
Message-ID: <901a0b77-39c7-1284-1229-c436e0836779@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> We already have zero memory allocator functions to set the memory to
> 0 value instead of manually setting it using memset.

Thanks for your extension of this script for the semantic patch language.

Will this update suggestion get any better chances than the approach
?Script to replace allocate and memset with zalloc functions??
https://systeme.lip6.fr/pipermail/cocci/2016-August/003510.html


> +/// Use zeroing allocator rather than allocator followed by memset with 0

Do you find the shown function name list complete now?

Did you omit a name like ?kvm_kvzalloc? intentionally?


How do you think about the possibility to analyse relevant source files for
functions with the mentioned property?


> +(
> +- x = kmalloc(E1,E2);
> ++ x = kzalloc(E1,E2);
> +|

You suggest to use another application for the SmPL disjunction.
How do you think about to refactor this specification a bit like the following?

+(
+ x = 
+-    kmalloc
++    kzalloc
+            (E1, E2);
+|



> +|
> +- x = (T *)kmalloc(E1,E2);
> + x = kzalloc(E1,E2);
> +|

Why do you find it appropriate to omit a cast at this place while it is
preserved at other places?

Regards,
Markus
