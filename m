From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 19 Mar 2016 18:44:25 +0100 (CET)
Subject: [Cocci] Remove remove unnecessary parentheses.
In-Reply-To: <BB81FEEF-74ED-49CB-BE29-AEB0DBDBB3A2@pfsw.com>
References: <A448EE81-8601-4EEA-BBA3-1EED4927F338@pfsw.com>
 <alpine.DEB.2.02.1603121018580.2055@localhost6.localdomain6>
 <BB81FEEF-74ED-49CB-BE29-AEB0DBDBB3A2@pfsw.com>
Message-ID: <alpine.DEB.2.02.1603191843390.2259@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I just noticed that if I remove the "disable paren" (not sure why it was there from the start) from parens.cocci it works:
> 
> $ spatch --sp-file parens.cocci --in-place test.c
> init_defs_builtins: /usr/share/coccinelle/standard.h
> HANDLING: test.c
> diff = 
> --- test.c
> +++ /tmp/cocci-output-7860-490fa0-test.c
> @@ -1 +1 @@
> -assert((flags & VERBOSE));
> +assert( flags & VERBOSE);

The space problem is now fixed in the github version.

julia
