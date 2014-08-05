From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 5 Aug 2014 22:11:54 +0200 (CEST)
Subject: [Cocci] Goto Directionality?
In-Reply-To: <1407269090.1507.22.camel@QNXWS8653-PC>
References: <1407269090.1507.22.camel@QNXWS8653-PC>
Message-ID: <alpine.DEB.2.02.1408052207580.2047@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 5 Aug 2014, Mitchell Cuddie wrote:

> Hi Julia,
> 
> I am attempting to create a patch to identify the direction of a goto
> statement.(i.e. label before/after goto)
> 
> but the patch matches both?
> 
> In my eyes a should match but b should not
> 
> Cheers,
> 
> Mitchell
> 
> 
> @r @
> identifier i;
> position p;
> @@
> * i at p:
> ...
> * goto i;

... follows the possible execution paths in the program.  It has no notion 
of up or down.  b and goto b are matched because of the goto a, which 
makes a loop around the b code.

Perhaps just taking into account the line number of the label and the goto 
is good enough?  There could be problems for the case where there is a 
goto from one if branch to another, but that seems like quite unpleasant 
code.

julia

> diff = 
> --- test.c
> +++ /tmp/cocci-output-22798-0e39f1-test.c
> @@ -7,15 +7,11 @@ main()
>         int b = 0xF0F0F0F0;
>         void *a = &b;
>         size_t c = (size_t)a;
> -a:
>         printf("%"PRIxPTR"\n", (uintptr_t)a);
> -goto b;
>         printf("%zu\n", c);  // prints as unsigned decimal
>         printf("%zx\n", c);  // prints as hex
>         printf("%zd\n", c);  // prints as signed decimal
> -b:
>         printf("%%\n");
> -goto a;
>         printf("%% %s", "cat\n");
>  
>         return 0;
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
