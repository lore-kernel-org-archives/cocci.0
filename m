From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 20 Jul 2015 14:55:24 +0200
Subject: [Cocci] Finding designated initialisers with SmPL
In-Reply-To: <alpine.DEB.2.10.1507201335030.2475@hadrien>
References: <55A62135.90206@users.sourceforge.net>
 <alpine.DEB.2.10.1507150629540.2670@hadrien>
 <55AA3B1F.5020807@users.sourceforge.net>
 <alpine.DEB.2.02.1507181351130.2042@localhost6.localdomain6>
 <55ACDC1C.1040005@users.sourceforge.net>
 <alpine.DEB.2.10.1507201335030.2475@hadrien>
Message-ID: <55ACEFBC.1000101@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> In any case, what you want is
> 
> identifier i;
> 
> and then struct i structure_var = { ... .element = allocation(...) ... };

Thanks for your hint.


@show_designated_initialisers@
field element;
identifier allocation, structure_type, structure_var;
@@
 <+...
*struct structure_type structure_var = { ... .element = allocation(...) ... };
 ...+>


elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt -sp-file show_unstored_return_values2.cocci unchecked_return_values1.c
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
327 328
Fatal error: exception Failure("minus: parse error: \n = File \"show_unstored_return_values2.cocci\", line 17, column 46,  charpos = 327\n    around = '.', whole content =   struct structure_type structure_var = { ... .element = allocation(...) ... };\n")


How should this small SmPL example be improved further?
http://en.cppreference.com/w/c/language/struct_initialization

Regards,
Markus
