From: Thierry.Martinez@inria.fr (Thierry Martinez)
Date: Fri, 08 Jul 2016 15:22:52 +0300
Subject: [Cocci] Checking build dependencies for "Menhir"
In-Reply-To: <trinity-8ac09448-d240-4749-abb6-a492eca97242-1467977569565@3capp-webde-bs29>
References: <64de7df6-acd6-7ddf-efc7-b4055203211c@users.sourceforge.net>
 <ow4h9c1qfm3.fsf@mbp-thierry.rsr.lip6.fr>
 <adef0045-4d3b-8e8c-9f5d-bf00de66c722@users.sourceforge.net>
 <ow4furkqwl3.fsf@mbp-thierry.rsr.lip6.fr>
 <trinity-8ac09448-d240-4749-abb6-a492eca97242-1467977569565@3capp-webde-bs29>
Message-ID: <ow4bn28qpyb.fsf@mbp-thierry.rsr.lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Markus:
> Is the bundled Menhir version currently required for a working
> Coccinelle software?

No, you can use a more recent version of Menhir if you want.

The reason of having an old version of Menhir in the bundles is that the
newer versions of Menhir require OCaml 4.02 (for "match exception"), and
we would like to keep the compatibility with OCaml 4.01 (or even 3.12).

> I imagine that there are further challenges to consider for the safe
> dependency resolution of involved libraries.
> * Which releases can be picked up and finally used from special directories?
> * Will any more fine-tuning be needed for corresponding directory
> selection?

I don?t know if dependencies can be made more precise between the
Coccinelle code and bundled libraries.

In the current settings, you may have to run "make clean" or even "make
distclean" after a "git pull" to get a successful build (or else, there
is effectively a bug).  I think it is not too demanding, but I agree
that we should write more clearly in the commit message when cleaning is
required.

-- 
Thierry.

SF Markus Elfring (2016/07/08, 14:32 MSK)?:
>> > /usr/bin/ocamlc.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -I /home/elfring/Projekte/Coccinelle/20160205/bundles/menhirLib/ -c parser_cocci_menhir.mli
>> > File "parser_cocci_menhir.mli", line 262, characters 10-56:
>> > Error: Unbound module MenhirLib.IncrementalEngine
>> 
>> Your parser_cocci_menhir.{ml,mli} have been generated with a version of
>> Menhir more recent than the one that is bundled by Coccinelle.
>
> Thanks for your explanation.
>
> Is the bundled Menhir version currently required for a working Coccinelle software?
>
>
>> You can just safely remove parsing_cocci/parser_cocci_menhir.{ml,mli}
>> files (or just run make distclean) and try to run make again.
>
> I imagine that there are further challenges to consider for the safe
> dependency resolution of involved libraries.
> * Which releases can be picked up and finally used from special directories?
> * Will any more fine-tuning be needed for corresponding directory selection?
>
> Regards,
> Markus
