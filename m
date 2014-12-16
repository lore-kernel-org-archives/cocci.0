From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 16 Dec 2014 12:17:01 +0100
Subject: [Cocci] 1.0.0-rc23 release - Menhir updates
In-Reply-To: <alpine.DEB.2.10.1412111413400.2600@hadrien>
References: <alpine.DEB.2.10.1412111413400.2600@hadrien>
Message-ID: <549014AD.8090807@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> - Some parsing and pretty printing improvements.

Dear Julia,

I have installed the current parser generator "Menhir 20141215"
on my openSUSE Tumbleweed system a moment ago.

The corresponding build works a bit longer for your software
when I try a configuration variant out with the simple command
"./configure --enable-release".
Unfortunately, I stumble on another surprise then.

elfring at Sonne:~/Projekte/Coccinelle/1.0.0-rc23> LANG=C make all             
...
/usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -I /usr/lib64/ocaml/menhirLib -c parser_cocci_menhir.ml
File "parser_cocci_menhir.ml", line 1879, characters 8-321:
Error: The record field MenhirLib.EngineTypes.stack is not mutable
Makefile:126: recipe for target 'parser_cocci_menhir.cmx' failed
make[6]: *** [parser_cocci_menhir.cmx] Error 2
make[6]: Leaving directory '/home/elfring/Projekte/Coccinelle/1.0.0-rc23/parsing_cocci'
Makefile:82: recipe for target 'all.opt' failed
...

How should this implementation detail be resolved?

Do I need to reuse an older Menhir software library here?

Regards,
Markus
