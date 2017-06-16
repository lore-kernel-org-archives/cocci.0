From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 16 Jun 2017 07:50:15 +0200
Subject: [Cocci] Replacing suffix rules in make scripts?
In-Reply-To: <alpine.DEB.2.20.1706152233080.3015@hadrien>
References: <020f8c95-fcaa-d47e-410b-7fb633fefa09@users.sourceforge.net>
 <9c2abe52-5ef9-62e0-26ab-f4fc69513257@users.sourceforge.net>
 <alpine.DEB.2.20.1706142255480.3610@hadrien>
 <47632935-6b4f-aeec-2ced-11f5d2f8609b@users.sourceforge.net>
 <alpine.DEB.2.20.1706152233080.3015@hadrien>
Message-ID: <75d88a53-ace7-3bea-a3b2-bbc100091e78@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> I am curious on how a dependency for a software interface like ?Visitor_ast0_types?
>> should be expressed for so many source files in a consistent way.
> 
> What problem are you trying to solve?

I would like to achieve something more for the topics which were also registered
in the issue tracker.


> Why do the dependency specifications need improving?

Examples:

elfring at Sonne:~/Projekte/Coccinelle/20160205/parsing_cocci> LANG=C make V=1
/usr/bin/ocamldep *.mli *.ml > .depend
/usr/bin/ocamlc.opt ?
File "_none_", line 1:
Error: Cannot find file flag_parsing_cocci.cmo
make: *** [Makefile:67: cocci_parser.cma] Error 2


elfring at Sonne:~/Projekte/Coccinelle/20160205/parsing_c> LANG=C make V=1
/usr/bin/ocamlc.opt ?
File "includes.mli", line 38, characters 46-60:
Error: Unbound module Ast_c
make: *** [/home/elfring/Projekte/Coccinelle/20160205/common_rules.make:6: includes.cmi] Error 2


These messages indicate reasons why I am also fiddling with the build scripts
for this software again.

Regards,
Markus
