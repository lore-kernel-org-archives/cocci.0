From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 26 Jul 2018 21:38:58 +0200 (CEST)
Subject: [Cocci] Variable number of macro parameters?
In-Reply-To: <8910efc5-eaf2-93d6-a148-c7b06f336dcd@tabi.org>
References: <CAOZdJXWJZxjd7-yOCAvcb7=f+2==arPc4VDQjZh=6BQpZqVZpg@mail.gmail.com>
 <alpine.DEB.2.20.1807262057300.2308@hadrien>
 <8910efc5-eaf2-93d6-a148-c7b06f336dcd@tabi.org>
Message-ID: <alpine.DEB.2.20.1807262138050.2308@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 26 Jul 2018, Timur Tabi wrote:

> On 07/26/2018 01:57 PM, Julia Lawall wrote:
> > > @rule1@
> > > expression x, y;
> > > @@
> > > -DBG_PRINTF((x, y));
> > > +NV_PRINTF(y);
> > Try expression list y;
>
> You mean like this:
>
> @rule1@
> expression x;
> expression list y;
> @@
> -DBG_PRINTF((x, y));
> +NV_PRINTF(y);
>
> That gives me an error:
>
> $ spatch -sp_file ~/sw/dev/gpu_drv/chips_a/nv_printf.cocci osinit.c
> init_defs_builtins: /usr/lib/coccinelle/standard.h
> 60 61
> Fatal error: exception Failure("minus: parse error: \n = File
> \"/home/ttabi/sw/dev/gpu_drv/chips_a/nv_printf.cocci\", line 5, column 16,
> charpos = 60\n    around = 'y', whole content = -DBG_PRINTF((x, y));\n")

OK, I don't think that the notion of double parentheses is fully
supported.  It works with the following:

@@
@@
DBG_PRINTF(
-(
  ...
- )
 );


@rule1@
expression x;
expression list y;
@@
-DBG_PRINTF(x, y);
+NV_PRINTF(y);

julia
