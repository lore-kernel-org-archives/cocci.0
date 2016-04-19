From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 19 Apr 2016 21:15:54 +0200 (CEST)
Subject: [Cocci] coccinelle: bool if (foo) return true; else return false;
In-Reply-To: <1461093152.1917.26.camel@perches.com>
References: <1460828078-5224-1-git-send-email-dave@stgolabs.net>
 <1460833453.19090.79.camel@perches.com>
 <1460836099.19090.82.camel@perches.com>
 <alpine.DEB.2.02.1604170743060.2068@localhost6.localdomain6>
 <1460881671.19090.90.camel@perches.com>
 <alpine.DEB.2.02.1604171337450.2034@localhost6.localdomain6>
 <1460908959.19090.95.camel@perches.com>
 <alpine.DEB.2.02.1604171944500.2004@localhost6.localdomain6>
 <1460915801.19090.100.camel@perches.com>
 <alpine.DEB.2.02.1604172001410.2004@localhost6.localdomain6>
 <1461093152.1917.26.camel@perches.com>
Message-ID: <alpine.DEB.2.02.1604192115300.2054@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 19 Apr 2016, Joe Perches wrote:

> There's ~150 of these in the kernel.
> 
> Maybe there's use for this conversion to be added
> to?scripts/coccinelle/misc/boolreturn.cocci or in
> a separate file.
> 
> $ cat booltruefalse.cocci
> @@
> identifier fn;
> expression e;
> typedef bool;
> symbol true;
> symbol false;
> @@
> 
> bool fn ( ... )
> {
> <...
> -	if (e) return true; else return false;
> +	return e;
> ...>
> }
> 
> @@
> identifier fn;
> expression e;
> @@
> 
> bool fn ( ... )
> {
> <...
> -	if (e) return false; else return true;
> +	return !e;
> ...>
> }

Thanks for the suggestion.  I will take care of it shortly.

julia
