From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 19 Feb 2013 22:54:41 +0100 (CET)
Subject: [Cocci] [Coccinellery] drop_continue/cont.cocci broken ?
In-Reply-To: <5123E41C.30603@gmail.com>
References: <5123E41C.30603@gmail.com>
Message-ID: <alpine.DEB.2.02.1302192252320.2092@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

My recollecton is indeed that this rule does not work properly.  There is 
no control flow from the continue to the following brace, so it doesn't 
get removed.

I will change the rule so that it doesn't make any changes, just prints 
out a warning message.

Thanks for the report.

julia

On Tue, 19 Feb 2013, Cyril Roelandt wrote:

> Hi!
> 
> I think the drop_continue/cont.cocci script is broken. Here is a simple
> semantic patch extracted from it:
> 
> 
> $ cat foo.cocci
> @@
> statement S;
> @@
> for (...;...;...) {
>   ...
>   if (...)
> - {
>     S
> -   continue;
> - }
> }
> 
> 
> A simple C file:
> 
> $ cat continue.c
> static void
> foo(int max)
> {
> 	int i;
> 	for (i = 0; i < max; i++) {
> 		do_stuff();
> 		if (i == 42) {
> 			do_stg_else();
> 			continue;
> 		}
> 	}
> }
> 
> $ spatch -sp_file foo.cocci continue.c --debug --verbose-parsing
> init_defs_builtins: /home/cyril/opt/spatch/share/coccinelle/standard.h
> -----------------------------------------------------------------------
> processing semantic patch file: foo.cocci
> with isos from: /home/cyril/opt/spatch/share/coccinelle/standard.iso
> -----------------------------------------------------------------------
> @@
> statement S;
> @@
> for (...;...;...) {
>   ...
>   if (...)
> - {
>     S
> -   continue;
> - }
> }
> 
> warning: iso braces1 does not match the code below on line 4
> {
>   ...
>   if (...) {
>     S
>     continue;
>   }
> }
> braces must be all minus (plus code allowed) or all
> context (plus code not allowed in the body) to match:
> {
>   ...
>   if (...) {
>     S
>     continue;
>   }
> }
> HANDLING: continue.c
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
>      transformation info returned:
>           transform state: 18
>                with rule_elem: -{
> 
>                with binding: []
>           transform state: 20
>                with rule_elem: -continue-;
>                with binding: []
>      binding out = []
>      transform one node: 20
>      transform one node: 18
> PB: found closing brace alone in fuzzy parsing
> ERROR-RECOV: end of file while in recovery mode
> parsing pass2: try again
> ERROR-RECOV: end of file while in recovery mode
> parse error
>  = File "/tmp/cocci_small_output-5101-1385aa.c", line 11, column 0, charpos =
> 118
>     around = '}', whole content = }
> badcount: 1
> bad: 	}
> BAD:!!!!! }
> ALREADY AT END
> -----------------------------------------------------------------------
> Finished
> -----------------------------------------------------------------------
> PB: found closing brace alone in fuzzy parsing
> ERROR-RECOV: end of file while in recovery mode
> parsing pass2: try again
> ERROR-RECOV: end of file while in recovery mode
> parse error
>  = File "/tmp/cocci-output-5101-f0bc97-continue.c", line 11, column 0,
> charpos = 118
>     around = '}', whole content = }
> badcount: 1
> bad: 	}
> BAD:!!!!! }
> ALREADY AT END
> diff =
> --- continue.c
> +++ /tmp/cocci-output-5101-f0bc97-continue.c
> @@ -4,9 +4,8 @@ foo(int max)
>  	int i;
>  	for (i = 0; i < max; i++) {
>  		do_stuff();
> -		if (i == 42) {
> +		if (i == 42)
>  			do_stg_else();
> -			continue;
>  		}
>  	}
>  }
> Check duplication for 1 files
> 
> 
> 
> 
> There is a missing closing brace in the resulting code. I can reproduce this
> with both 1.0-rc12 (packaged in Debian) and 1.0-rc16. The same thing happens
> when using "*" instead of "-", and when using the "break" keyword instead of
> the "continue" keyword.
> 
> 
> WBR,
> Cyril Roelandt.
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
