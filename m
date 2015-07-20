From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 20 Jul 2015 22:38:34 +0200 (CEST)
Subject: [Cocci] Finding designated initialisers with SmPL
In-Reply-To: <55AD58A7.6030507@users.sourceforge.net>
References: <55A62135.90206@users.sourceforge.net>
 <alpine.DEB.2.10.1507150629540.2670@hadrien>
 <55AA3B1F.5020807@users.sourceforge.net>
 <alpine.DEB.2.02.1507181351130.2042@localhost6.localdomain6>
 <55ACDC1C.1040005@users.sourceforge.net>
 <alpine.DEB.2.10.1507201335030.2475@hadrien>
 <55ACF739.4020802@users.sourceforge.net>
 <alpine.DEB.2.10.1507201828130.2475@hadrien>
 <55AD58A7.6030507@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1507202238110.2082@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 20 Jul 2015, SF Markus Elfring wrote:

> >> *struct structure_type structure_var = { ... .element = allocation(...) ... };
> > 
> > You need a comma after the ...s representing structure field declarations.
> 
> Do I overlook another needed implementation detail here?
> 
> 
> @show_designated_initialisers@
> field element;
> identifier allocation, structure_type, structure_var;
> @@
>  <+...
> *struct structure_type structure_var = { ..., .element = allocation(...), ... };
>  ...+>

Element should be an identifier.

julia

> 
> 
> elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt -sp-file show_designated_initialisers1.cocci unchecked_return_values1.c
> init_defs_builtins: /usr/local/lib/coccinelle/standard.h
> 157 164
> Fatal error: exception Failure("minus: parse error: \n = File \"show_designated_initialisers1.cocci\", line 6, column 47,  charpos = 157\n    around = 'element', whole content = *struct structure_type structure_var = { ..., .element = allocation(...), ..., };\n")
> 
> 
> Regards,
> Markus
> 
> 
