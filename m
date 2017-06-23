From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 23 Jun 2017 17:50:50 +0200
Subject: [Cocci] Replacing suffix rules in make scripts?
In-Reply-To: <alpine.DEB.2.20.1706160829130.3459@hadrien>
References: <020f8c95-fcaa-d47e-410b-7fb633fefa09@users.sourceforge.net>
 <9c2abe52-5ef9-62e0-26ab-f4fc69513257@users.sourceforge.net>
 <alpine.DEB.2.20.1706142255480.3610@hadrien>
 <47632935-6b4f-aeec-2ced-11f5d2f8609b@users.sourceforge.net>
 <alpine.DEB.2.20.1706152233080.3015@hadrien>
 <75d88a53-ace7-3bea-a3b2-bbc100091e78@users.sourceforge.net>
 <alpine.DEB.2.20.1706160802420.3013@hadrien>
 <8acbcd33-5eb7-08d3-c841-734d0359f87b@users.sourceforge.net>
 <alpine.DEB.2.20.1706160829130.3459@hadrien>
Message-ID: <d939c651-82f5-1b74-aeb7-6714275eb678@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The OCaml makefile specifies an order in which the files should be
> compiled in the project.  If you are sidestepping that ordering, then you
> are not doing things in the intended manner.

I hope that some details were clarified to some degree in the meantime.


> There is only an intent to support running make or make opt in the
> subdirectories or at the root.  Perhaps Thierry will put a new make file
> that has some other properties (I don't know which ones) in the future.
> But there is no intent to support anything else at the moment.

I suggest to take also another look around the discussed build scripts.

Example:
https://github.com/coccinelle/coccinelle/blob/cd539cd12ad0674d5a8f4c33f6c21ae00aec8e57/globals/Makefile#L50


Now I wonder about the following test result for my current ?developer rules?.


elfring at Sonne:~/Projekte/Coccinelle/20160205/globals> make clean && LANG=C make --no-builtin-rules V=1 && make clean && LANG=C make --no-builtin-rules -j4 V=1
rm -f ?
/usr/bin/ocamldep -I ../commons -I /home/elfring/Projekte/Coccinelle/20160205/bundles/pcre/ *.mli *.ml > .depend
?
/usr/bin/ocamlc.opt -unsafe -I ../commons -I /home/elfring/Projekte/Coccinelle/20160205/bundles/pcre/ -c flag.ml
?
/usr/bin/ocamlc.opt -unsafe -I ../commons -I /home/elfring/Projekte/Coccinelle/20160205/bundles/pcre/ -a -o globals.cma config.cmo flag.cmo regexp_pcre.cmo regexp.cmo iteration.cmo
rm -f ?
/usr/bin/ocamldep -I ../commons -I /home/elfring/Projekte/Coccinelle/20160205/bundles/pcre/ *.mli *.ml > .depend
?
/usr/bin/ocamlc.opt -unsafe -I ../commons -I /home/elfring/Projekte/Coccinelle/20160205/bundles/pcre/ -c flag.ml
?
/usr/bin/ocamlc.opt -unsafe -I ../commons -I /home/elfring/Projekte/Coccinelle/20160205/bundles/pcre/ -c iteration.mli
make: *** No rule to make target 'flag.cmi', needed by 'iteration.cmo'.  Stop.
?


Why do I get such an error message for a parallel software build attempt
when the specified dependencies worked as expected for the non-parallel
build try before?

Do you get any more ideas on how to explain such a test surprise?

Regards,
Markus
