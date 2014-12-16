From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 16 Dec 2014 15:51:23 +0100 (CET)
Subject: [Cocci] 1.0.0-rc23 release - Menhir updates
In-Reply-To: <549014AD.8090807@users.sourceforge.net>
References: <alpine.DEB.2.10.1412111413400.2600@hadrien>
 <549014AD.8090807@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1412161550530.4299@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 16 Dec 2014, SF Markus Elfring wrote:

> > - Some parsing and pretty printing improvements.
>
> Dear Julia,
>
> I have installed the current parser generator "Menhir 20141215"
> on my openSUSE Tumbleweed system a moment ago.
>
> The corresponding build works a bit longer for your software
> when I try a configuration variant out with the simple command
> "./configure --enable-release".
> Unfortunately, I stumble on another surprise then.
>
> elfring at Sonne:~/Projekte/Coccinelle/1.0.0-rc23> LANG=C make all
> ...
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -I /usr/lib64/ocaml/menhirLib -c parser_cocci_menhir.ml
> File "parser_cocci_menhir.ml", line 1879, characters 8-321:
> Error: The record field MenhirLib.EngineTypes.stack is not mutable
> Makefile:126: recipe for target 'parser_cocci_menhir.cmx' failed
> make[6]: *** [parser_cocci_menhir.cmx] Error 2
> make[6]: Leaving directory '/home/elfring/Projekte/Coccinelle/1.0.0-rc23/parsing_cocci'
> Makefile:82: recipe for target 'all.opt' failed
> ...
>
> How should this implementation detail be resolved?
>
> Do I need to reuse an older Menhir software library here?

I haven't tried the new version of menhir.  Thanks for the warning.
Perhaps you can use the old version for the moment.

julia
