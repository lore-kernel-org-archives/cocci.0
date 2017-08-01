From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 1 Aug 2017 16:23:50 +0200 (CEST)
Subject: [Cocci] Surprising parsing error occuring when casting C string
In-Reply-To: <1501597398.3791.12.camel@opteya.com>
References: <1501592641.3791.10.camel@opteya.com>
 <alpine.DEB.2.20.1708011543570.21130@hadrien>
 <1501597398.3791.12.camel@opteya.com>
Message-ID: <alpine.DEB.2.20.1708011623290.21130@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 1 Aug 2017, Yann Droneaud wrote:

> Hi,
>
> Le mardi 01 ao?t 2017 ? 15:46 +0200, Julia Lawall a ?crit :
> > On Tue, 1 Aug 2017, Yann Droneaud wrote:
> >
> > > I'm wondering why coccinelle seems not to be able to apply simple
> > > semantic patch when code source contains casted C string.
> >
> > Fixed.  Take the github version.
> >
> > Basically, Coccinelle makes some inferences during parsin about what
> > maybe a typedef.  That explains the examples you have below about
> > some cases working.  I extended those rules to take some more kinds
> > of constants into account.
> >
>
> It works ! Thanks a lot for this very quick fix.

Thanks for the report :)

julia

>
> $ ../../UPSTREAM/coccinelle/spatch.opt --version
> spatch version 1.0.6-00186-g0acd38eed4e5 compiled with OCaml version
> 4.04.0
> Flags passed to the configure script: [none]
> Python scripting support: yes
> Syntax of regular expresssions: PCRE
>
> $ ../../UPSTREAM/coccinelle/spatch.opt --verbose-parsing --sp-file
> test.cocci test.c
> init_defs_builtins: ../../UPSTREAM/coccinelle/standard.h
> HANDLING: test.c
> diff =
> --- test.c
> +++ /tmp/cocci-output-20045-ee70d9-test.c
> @@ -7,7 +7,7 @@ static structure_t array[] =
>  void function(void)
>  {
>          if (!other(1, (pointer_t)"value", 3))
> -                foo();
> +                FOO();
>          else
>                  bar();
>  }
>
>
> Regards.
>
> --
> Yann Droneaud
> OPTEYA
>
>
