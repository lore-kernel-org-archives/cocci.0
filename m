From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 20 Jul 2015 18:28:41 +0200 (CEST)
Subject: [Cocci] Finding unstored return values with SmPL
In-Reply-To: <55ACF739.4020802@users.sourceforge.net>
References: <55A62135.90206@users.sourceforge.net>
 <alpine.DEB.2.10.1507150629540.2670@hadrien>
 <55AA3B1F.5020807@users.sourceforge.net>
 <alpine.DEB.2.02.1507181351130.2042@localhost6.localdomain6>
 <55ACDC1C.1040005@users.sourceforge.net>
 <alpine.DEB.2.10.1507201335030.2475@hadrien>
 <55ACF739.4020802@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1507201828130.2475@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 20 Jul 2015, SF Markus Elfring wrote:

> > In any case, what you want is
> >
> > identifier i;
> >
> > and then struct i structure_var = { ... .element = allocation(...) ... };
>
> Thanks for your hint.
>
>
> @show_designated_initialisers@
> field element;
> identifier allocation, structure_type, structure_var;
> @@
>  <+...
> *struct structure_type structure_var = { ... .element = allocation(...) ... };

You need a comma after the ...s representing structure field declarations.

julia

>  ...+>
>
>
> elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt -sp-file show_designated_initialisers1.cocci unchecked_return_values1.c
> init_defs_builtins: /usr/local/lib/coccinelle/standard.h
> 155 156
> Fatal error: exception Failure("minus: parse error: \n = File \"show_designated_initialisers1.cocci\", line 6, column 45,  charpos = 155\n    around = '.', whole content = *struct structure_type structure_var = { ... .element = allocation(...) ... };\n")
>
>
> How should my small SmPL example be improved further?
>
> http://en.cppreference.com/w/c/language/struct_initialization
>
> Regards,
> Markus
>
