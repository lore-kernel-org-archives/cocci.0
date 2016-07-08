From: Thierry.Martinez@inria.fr (Thierry Martinez)
Date: Fri, 08 Jul 2016 12:59:36 +0300
Subject: [Cocci] Checking build dependencies for "pyml" (and Menhir)
In-Reply-To: <adef0045-4d3b-8e8c-9f5d-bf00de66c722@users.sourceforge.net>
References: <64de7df6-acd6-7ddf-efc7-b4055203211c@users.sourceforge.net>
 <ow4h9c1qfm3.fsf@mbp-thierry.rsr.lip6.fr>
 <adef0045-4d3b-8e8c-9f5d-bf00de66c722@users.sourceforge.net>
Message-ID: <ow4furkqwl3.fsf@mbp-thierry.rsr.lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Markus:
> Did a configuration script become outdated?
> -rwxr-xr-x 1 elfring users 524178 Mar 15 15:30 configure

Yes, the configure.ac script has been changed to handle the change from
Pycaml to Py.ml.

> /usr/bin/ocamlc.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -I /home/elfring/Projekte/Coccinelle/20160205/bundles/menhirLib/ -c parser_cocci_menhir.mli
> File "parser_cocci_menhir.mli", line 262, characters 10-56:
> Error: Unbound module MenhirLib.IncrementalEngine

Your parser_cocci_menhir.{ml,mli} have been generated with a version of
Menhir more recent than the one that is bundled by Coccinelle.

You can just safely remove parsing_cocci/parser_cocci_menhir.{ml,mli}
files (or just run make distclean) and try to run make again.

-- 
Thierry.

SF Markus Elfring (2016/07/08, 08:21 MSK)?:
>>> make[2]: *** @MAKE_pyml@: No such file or directory.  Stop.
>> 
>> Thank you for the report. Does this error continue to happen if you
>> delete the subdirectory autom4te.cache/ and then execute ./autogen,
>> ./configure, etc.?
>
> Did a configuration script become outdated?
> -rwxr-xr-x 1 elfring users 524178 Mar 15 15:30 configure
>
>
> It seems that the desired software build can be continued after another update.
>
> elfring at Sonne:~/Projekte/Coccinelle/20160205> ./autogen && ./configure && LANG=C make
> ?
> /usr/bin/ocamlc.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -I /home/elfring/Projekte/Coccinelle/20160205/bundles/menhirLib/ -c parser_cocci_menhir.mli
> File "parser_cocci_menhir.mli", line 262, characters 10-56:
> Error: Unbound module MenhirLib.IncrementalEngine
> make[6]: *** [Makefile:89: parser_cocci_menhir.cmi] Error 2
> ?
>
>
> How should such a build dependency be resolved?
>
> Regards,
> Markus
