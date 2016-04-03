From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 3 Apr 2016 07:30:16 +0200 (CEST)
Subject: [Cocci] Insert statement before every return point
In-Reply-To: <20160403063412.GA2982@hird.mnieto.com.ar>
References: <20160403063412.GA2982@hird.mnieto.com.ar>
Message-ID: <alpine.DEB.2.02.1604030728030.2018@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 3 Apr 2016, Diego Nieto Cid wrote:

> Hello,
> 
> I'm new to Coccinelle and there's a patch I wrote that doesn't
> work as I expected.
> 
> The purpose of the patch is to implement a toy stack smashing
> protector by inserting a local variable with a unique name, by
> using 'fresh identifier', in every function and checking its
> value before returning.
> 
> The patch is the followig:
> ----8<----8<----8<----8<----8<----8<----
> @@
> identifier fn;
> fresh identifier canary = "canary_";
> @@
>  fn (...)
>  {
> +  int canary = 0xdeadbeef;
>    ...
> +  if ((canary ^ 0xdeadbeef) != 0)
> +      DIVIDE_BY_ZERO;
>   return ...;
>  }

I'm not sure why it doesn't work on your example.  However it sems to work 
better like this:

@@
identifier fn;
fresh identifier canary = "canary_";
@@
 fn (...)
 {
+  int canary = 0xdeadbeef;
   <...
+  if ((canary ^ 0xdeadbeef) != 0)
+      DIVIDE_BY_ZERO;
  return ...;
  ...>
 }

This just makes the change whereever it is relevant, regardless of 
control-flow.  It seems to even work in the case of an implicit return at 
the end of the function, when the function has a void return type.

julia




> ---->8---->8---->8---->8---->8---->8----
> 
> I tried it on a simple function, like the one below:
> 
> ----8<----8<----8<----8<----8<----8<----
> int fn (int a, int b)
> {
> 	if (a > b)
> 		return a - b;
> 	return 0;
> }
> ---->8---->8---->8---->8---->8---->8----
> 
> and got the expected result. The generated patch follows.
> 
> ----8<----8<----8<----8<----8<----8<----
> init_defs_builtins: /usr/lib/coccinelle/standard.h
> HANDLING: branch.c
> diff = 
> --- branch.c
> +++ /tmp/cocci-output-3058-7f8e45-branch.c
> @@ -1,6 +1,12 @@
>  int fn (int a, int b)
>  {
> -	if (a > b)
> +	int canary_0 = 0xdeadbeef;
> +	if (a > b) {
> +		if ((canary_0 ^ 0xdeadbeef) != 0)
> +			DIVIDE_BY_ZERO;
>  		return a - b;
> +	}
> +	if ((canary_0 ^ 0xdeadbeef) != 0)
> +		DIVIDE_BY_ZERO;
>  	return 0;
>  }
> ---->8---->8---->8---->8---->8---->8----
> 
> But as soon as I add an elseif branch the patch stops working.
> Here are the code
> 
> ----8<----8<----8<----8<----8<----8<----
> int fn (int a, int b)
> {
> 	if (a > b)
> 		return a - b;
> 	else if (b > a)
> 		return b - a;
> 	return 0;
> }
> ---->8---->8---->8---->8---->8---->8----
> 
> and 'spatch --debug' output:
> 
> ----8<----8<----8<----8<----8<----8<----
> init_defs_builtins: /usr/lib/coccinelle/standard.h
> -----------------------------------------------------------------------
> processing semantic patch file: ssp.cocci
> with isos from: /usr/lib/coccinelle/standard.iso
> -----------------------------------------------------------------------
> @@
> identifier fn;
> fresh identifier canary = "canary_";
> @@
>  fn (...)
>  {
> +  int canary = 0xdeadbeef;
>    ...
> +  if ((canary ^ 0xdeadbeef) != 0)
> +      DIVIDE_BY_ZERO;
>    return ...;
>  }
> 
> HANDLING: elseif.c
> -----------------------------------------------------------------------
> let's go
> -----------------------------------------------------------------------
> -----------------------------------------------------------------------
> -----------------------------------------------------------------------
> rule starting on line 1 = 
> -----------------------------------------------------------------------
> dependencies for rule rule starting on line 1 satisfied:
> binding in = []
> binding relevant in = []
> -----------------------------------------------------------------------
> Finished
> -----------------------------------------------------------------------
> Check duplication for 1 files
> ---->8---->8---->8---->8---->8---->8----
> 
> I don't understand why introducing an 'else if' clause is causing the
> semantic patch to skip over the function.
> 
> Anybody knows what's happenig and how to fix it?
> 
> Thanks,
> Diego
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
