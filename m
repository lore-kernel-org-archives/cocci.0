From: christophe.leroy@c-s.fr (Christophe LEROY)
Date: Wed, 12 Oct 2016 11:57:41 +0200
Subject: [Cocci] Error: This expression has type t but an expression was
 expected of type, string option option
Message-ID: <4a34076e-3fd3-33ea-0ff8-b18e0bc39439@c-s.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi

I'm trying to compile coccinelle on a CentOS 6 system, and I'm facing 
the following compilation error.

I have the following version of ocaml: ocaml-3.12.0-21.el6.i686

What can be done to solve this issue ?

/usr/bin/ocamlc.opt -unsafe -I pyml-current -custom -cclib -lpyml_stubs 
-c pyml-current/py.ml -o pyml-current/py.cmo
File "pyml-current/py.ml", line 500, characters 11-15:
Error: This expression has type t but an expression was expected of type
          string option option
make[6]: *** [pyml-current/py.cmo] Erreur 2
make[6]: quittant le r?pertoire ? /root/coccinelle-1.0.6/bundles/pyml ?
make[5]: *** [all.opt] Erreur 2
make[5]: quittant le r?pertoire ? /root/coccinelle-1.0.6/bundles/pyml ?
make[4]: *** [/root/coccinelle-1.0.6/bundles/pyml/.opt] Erreur 2
make[4]: quittant le r?pertoire ? /root/coccinelle-1.0.6 ?
make[3]: *** [subdirs.opt] Erreur 1
make[3]: quittant le r?pertoire ? /root/coccinelle-1.0.6 ?
make[2]: *** [opt-compil] Erreur 2
make[2]: quittant le r?pertoire ? /root/coccinelle-1.0.6 ?
make[1]: *** [all-release] Erreur 2
make[1]: quittant le r?pertoire ? /root/coccinelle-1.0.6 ?
make: *** [all] Erreur 2

Christophe
