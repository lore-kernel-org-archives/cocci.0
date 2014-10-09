From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 9 Oct 2014 15:07:00 +0200 (CEST)
Subject: [Cocci] can't match a simple line?
In-Reply-To: <543685EC.6090109@redhat.com>
References: <20141009123201.GA1666@katana> <543685EC.6090109@redhat.com>
Message-ID: <alpine.DEB.2.10.1410091506010.2369@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 9 Oct 2014, Michael Stefaniuc wrote:

> On 10/09/2014 02:32 PM, Wolfram Sang wrote:
> > Hi,
> >
> > this is so simple yet I don't see what I do wrong?
> >
> > $ spatch --version spatch version 1.0.0-rc22 with Python support
> > and with PCRE support
> >
> > (from Debian but same with rc21):
> >
> > The rule 'test.cocci':
> >
> > @@ @@ - 	module_platform_driver(...);

Is this a normal program statement, or is it something at top level.  In
the latter case, you would need a "metavariable" declaration

declarer name module_platform_driver;

julia


> >
> > The command line:
> >
> > spatch -sp_file test.cocci drivers/i2c/muxes/
> >
> > No removals?
> >
> > init_defs_builtins: /usr/share/coccinelle/standard.h HANDLING:
> > drivers/i2c/muxes/i2c-arb-gpio-challenge.c (ONCE) Expected tokens
> > module_platform_driver
> > Skipping:drivers/i2c/muxes/i2c-mux-pca954x.c HANDLING:
> > drivers/i2c/muxes/i2c-mux-pinctrl.c HANDLING:
> > drivers/i2c/muxes/i2c-mux-gpio.c
> > Skipping:drivers/i2c/muxes/built-in.mod.c
> > Skipping:drivers/i2c/muxes/i2c-mux-pca9541.c
> >
> > It should match, or?
> Only if it can parse the blocks containing that code. What is spatch
> --parse-c saying for the affected files?
>
> bye
> 	michael
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
