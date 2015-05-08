From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 8 May 2015 20:12:28 -0300
Subject: [Cocci] Installing Coccinelle 1.0.0 on Ubuntu 14.04
Message-ID: <CAOMZO5DOr4Nz4gKkvkVKak3puk_Savmt3YmuDdnctufmixoYgg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I am trying to install Coccinelle 1.0.0 (retrieved from the git) on a
Ubuntu 14.04 PC and I am getting the following error:

make[4]: Entering directory `/home/fabio/coccinelle'
make[5]: Entering directory `/home/fabio/coccinelle/bundles/parmap'
cd parmap-1.0-rc5-patched && \
      make && \
      cd ..
make[6]: Entering directory
`/home/fabio/coccinelle/bundles/parmap/parmap-1.0-rc5-patched'
/usr/bin/ocamlbuild -j 10 -use-ocamlfind  parmap.cma  parmap.cmxa
parmap.cmxs parmap.a
Finished, 1 target (0 cached) in 00:00:00.
Finished, 23 targets (0 cached) in 00:00:00.
make[6]: Leaving directory
`/home/fabio/coccinelle/bundles/parmap/parmap-1.0-rc5-patched'
mv parmap-1.0-rc5-patched/_build/* .
make[5]: Leaving directory `/home/fabio/coccinelle/bundles/parmap'
make[4]: Leaving directory `/home/fabio/coccinelle'
make[4]: Entering directory `/home/fabio/coccinelle'
make[5]: Entering directory `/home/fabio/coccinelle/commons'
make[5]: Nothing to be done for `all'.
make[5]: Leaving directory `/home/fabio/coccinelle/commons'
make[4]: Leaving directory `/home/fabio/coccinelle'
make[4]: Entering directory `/home/fabio/coccinelle'
make[5]: Entering directory `/home/fabio/coccinelle/globals'
/usr/bin/ocamlc.opt -g  -I ../commons -I /usr/lib/ocaml/pcre -c regexp_pcre.ml
File "./regexp_pcre.ml", line 22, characters 32-43:
Error: Unbound module Pcre
make[5]: *** [regexp_pcre.cmo] Error 2
make[5]: Leaving directory `/home/fabio/coccinelle/globals'
make[4]: *** [globals.all] Error 2
make[4]: Leaving directory `/home/fabio/coccinelle'
make[3]: *** [subdirs.all] Error 1
make[3]: Leaving directory `/home/fabio/coccinelle'
make[2]: *** [byte] Error 2
make[2]: Leaving directory `/home/fabio/coccinelle'
make[1]: *** [all-dev] Error 2
make[1]: Leaving directory `/home/fabio/coccinelle'
make: *** [all] Error 2

Any ideas on how to solve this?

Thanks,

Fabio Estevam
