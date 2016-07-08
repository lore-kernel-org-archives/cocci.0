From: Thierry.Martinez@inria.fr (Thierry Martinez)
Date: Fri, 08 Jul 2016 13:25:23 +0300
Subject: [Cocci] Checking build dependencies for "pyml" (and Menhir)
In-Reply-To: <alpine.DEB.2.10.1607081211421.5049@hadrien>
References: <64de7df6-acd6-7ddf-efc7-b4055203211c@users.sourceforge.net>
 <ow4h9c1qfm3.fsf@mbp-thierry.rsr.lip6.fr>
 <adef0045-4d3b-8e8c-9f5d-bf00de66c722@users.sourceforge.net>
 <ow4furkqwl3.fsf@mbp-thierry.rsr.lip6.fr>
 <alpine.DEB.2.10.1607081211421.5049@hadrien>
Message-ID: <ow4eg74qve4.fsf@mbp-thierry.rsr.lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Julia:
> Probably it will be necessary to run autogen and configure again as well.

In the case of make distclean, yes.
If the files parsing_cocci/parser_cocci_menhir.{ml,mli} are just removed, it
should be fine to run make with the current Makefile.

-- 
Thierry.

Julia Lawall (2016/07/08, 13:12 MSK)?:
> On Fri, 8 Jul 2016, Thierry Martinez wrote:
>
>> Markus:
>> > Did a configuration script become outdated?
>> > -rwxr-xr-x 1 elfring users 524178 Mar 15 15:30 configure
>>
>> Yes, the configure.ac script has been changed to handle the change from
>> Pycaml to Py.ml.
>>
>> > /usr/bin/ocamlc.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -I /home/elfring/Projekte/Coccinelle/20160205/bundles/menhirLib/ -c parser_cocci_menhir.mli
>> > File "parser_cocci_menhir.mli", line 262, characters 10-56:
>> > Error: Unbound module MenhirLib.IncrementalEngine
>>
>> Your parser_cocci_menhir.{ml,mli} have been generated with a version of
>> Menhir more recent than the one that is bundled by Coccinelle.
>>
>> You can just safely remove parsing_cocci/parser_cocci_menhir.{ml,mli}
>> files (or just run make distclean) and try to run make again.
>
> Probably it will be necessary to run autogen and configure again as well.
>
> julia
>
>>
>> --
>> Thierry.
>>
>> SF Markus Elfring (2016/07/08, 08:21 MSK):
>> >>> make[2]: *** @MAKE_pyml@: No such file or directory.  Stop.
>> >>
>> >> Thank you for the report. Does this error continue to happen if you
>> >> delete the subdirectory autom4te.cache/ and then execute ./autogen,
>> >> ./configure, etc.?
>> >
>> > Did a configuration script become outdated?
>> > -rwxr-xr-x 1 elfring users 524178 Mar 15 15:30 configure
>> >
>> >
>> > It seems that the desired software build can be continued after another update.
>> >
>> > elfring at Sonne:~/Projekte/Coccinelle/20160205> ./autogen && ./configure && LANG=C make
>> > ?
>> > /usr/bin/ocamlc.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -I /home/elfring/Projekte/Coccinelle/20160205/bundles/menhirLib/ -c parser_cocci_menhir.mli
>> > File "parser_cocci_menhir.mli", line 262, characters 10-56:
>> > Error: Unbound module MenhirLib.IncrementalEngine
>> > make[6]: *** [Makefile:89: parser_cocci_menhir.cmi] Error 2
>> > ?
>> >
>> >
>> > How should such a build dependency be resolved?
>> >
>> > Regards,
>> > Markus
>>
>> _______________________________________________
>> Cocci mailing list
>> Cocci at systeme.lip6.fr
>> https://systeme.lip6.fr/mailman/listinfo/cocci
>>
