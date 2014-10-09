From: mstefani@redhat.com (Michael Stefaniuc)
Date: Thu, 09 Oct 2014 14:56:12 +0200
Subject: [Cocci] can't match a simple line?
In-Reply-To: <20141009123201.GA1666@katana>
References: <20141009123201.GA1666@katana>
Message-ID: <543685EC.6090109@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 10/09/2014 02:32 PM, Wolfram Sang wrote:
> Hi,
> 
> this is so simple yet I don't see what I do wrong?
> 
> $ spatch --version spatch version 1.0.0-rc22 with Python support
> and with PCRE support
> 
> (from Debian but same with rc21):
> 
> The rule 'test.cocci':
> 
> @@ @@ - 	module_platform_driver(...);
> 
> The command line:
> 
> spatch -sp_file test.cocci drivers/i2c/muxes/
> 
> No removals?
> 
> init_defs_builtins: /usr/share/coccinelle/standard.h HANDLING:
> drivers/i2c/muxes/i2c-arb-gpio-challenge.c (ONCE) Expected tokens
> module_platform_driver 
> Skipping:drivers/i2c/muxes/i2c-mux-pca954x.c HANDLING:
> drivers/i2c/muxes/i2c-mux-pinctrl.c HANDLING:
> drivers/i2c/muxes/i2c-mux-gpio.c 
> Skipping:drivers/i2c/muxes/built-in.mod.c 
> Skipping:drivers/i2c/muxes/i2c-mux-pca9541.c
> 
> It should match, or?
Only if it can parse the blocks containing that code. What is spatch
--parse-c saying for the affected files?

bye
	michael
