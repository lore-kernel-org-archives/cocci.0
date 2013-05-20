From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 20 May 2013 19:47:20 +0200
Subject: [Cocci] isomorphism with unlikely
In-Reply-To: <20130520173406.GB5890@katana>
References: <20130520173406.GB5890@katana>
Message-ID: <519A61A8.7010402@metafoo.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 05/20/2013 07:34 PM, Wolfram Sang wrote:
> Hi,
> 
> using 1.0-rc16 from debian, I use the following semantic patch:
> 
> @@
> expression r, p, n;
> @@
> 	r = platform_get_resource(p, IORESOURCE_MEM, n);
> 	...
> (
> -	if (!r) { ... }
> |
> -	if (unlikely(!r)) { ... }
> |
> -	if (unlikely(r == NULL)) { ... }
> )
> 
> and running against the latest kernel tree (~3.10-rc1):
> 
> spatch --sp-file unlikely_iso.cocci ~/Kernel/linux/drivers/net/ethernet/renesas/sh_eth.c
> 
> gives me a match:
> 
> -	if (unlikely(res == NULL)) {
> ...
> 
> Note that I have two alternations with 'unlikely' because using '!r'
> alone will not give me a match. I guess the isomorphism is skipped for
> some reason when used as an argument of unlikely. If so, is it possible
> to enforce it somehow? Or would it be even better to make 'unlikely' an
> isomorphism itself, so that the semantic patch doesn't need to know
> anything about 'unlikely'?
> 

There is already an isomorphism for unlikely. But it is in one direction
only, so 'unlikely(E)' in your cocci script will also match 'E', but 'E'
wont match 'unlikely(E)'.

So in your case the script could be reduced to:

> @@
> expression r, p, n;
> @@
> 	r = platform_get_resource(p, IORESOURCE_MEM, n);
> 	...
> -	if (unlikely(r == NULL)) { ... }

Btw. if you use 'statement S;' and 'if(...) S' instead of '{ ... }' you'll
also be able to match if there is only a single statement without brackets
after the if.

- Lars
