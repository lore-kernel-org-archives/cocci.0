From: Florian.Pesth@konrad-technologies.de (Pesth Florian)
Date: Mon, 4 Dec 2017 15:34:11 +0000
Subject: [Cocci] Recursive matches / returning lists from scripting code
 back to coccinelle
In-Reply-To: <alpine.DEB.2.20.1712041556361.3129@hadrien>
References: <80bb156f70ad4db195a386716dadfef6@konrad-technologies.de>,
 <alpine.DEB.2.20.1711291217460.3214@hadrien>
 <1de60b4045fc4ec69bfea4838b6ce16a@konrad-technologies.de>,
 <alpine.DEB.2.20.1712041556361.3129@hadrien>
Message-ID: <6d8d0b9c42e64244a9af1c7f689dcaf6@konrad-technologies.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


Von: Julia Lawall <julia.lawall@lip6.fr>
Gesendet: Montag, 4. Dezember 2017 15:58
>>I have this behavior too.? Could you live with the OCaml version in the
>>short term?? You only have to use OCaml when calling add_if_not_present.
>>You can write python scripts if you need to do other things.

Yes, of course! I was just wondering about the python variant. For my purposes the Ocaml variant of add_if_not_present is fine.

> BTW on Ubuntu (16.04.2 LTS) I had some problems compiling coccinelle which could be solved by adding "--disable-parmap" to the configure script. Is this a known issue? I did not need to add this option on OpenSuse.

>> No, it's not a known issue.? Do you have a parmap that was compiled
>> with a different version of OCaml?

I'm not sure about that, this is what the package manager says about parmap (Looks like it is compiled against ocaml 4.02.3?):

~/coccinelle$ apt-cache show libparmap-ocaml
Package: libparmap-ocaml
Priority: optional
Section: universe/ocaml
Installed-Size: 159
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Original-Maintainer: Debian OCaml Maintainers <debian-ocaml-maint@lists.debian.org>
Architecture: amd64
Source: parmap
Version: 1.0~rc7-1
Provides: libparmap-ocaml-d0ym9
Depends: libc6 (>= 2.14), ocaml-base-nox-4.02.3
Filename: pool/universe/p/parmap/libparmap-ocaml_1.0~rc7-1_amd64.deb
Size: 33006
MD5sum: 2517aa1fd6ae67876ccefc3c52521174
SHA1: 30b81be2dff5f51ee220f029f5015c864f3672ca
SHA256: 1825d791f74caf751a34704f996895e4af58e5c3a85be5be8d1a75c0039c12f1
Description-en: small OCaml library allowing to exploit multicore architectures
 Parmap is a minimalistic library allowing to exploit multicore
 architectures for OCaml programs with minimal modifications.
 .
 This package provides the runtime library.
Description-md5: 2d2a4e90ce86065d78033253316fbc51
Homepage: https://rdicosmo.github.io/parmap/
Bugs: https://bugs.launchpad.net/ubuntu/+filebug
Origin: Ubuntu

And about ocaml:

~/coccinelle$ ocaml -version
The OCaml toplevel, version 4.02.3

./configure says:

...
checking for ocamlc... /usr/bin/ocamlc
OCaml version is 4.02.3
OCaml library path is /usr/lib/ocaml
checking for ocamlopt... /usr/bin/ocamlopt
checking for ocamlc.opt... /usr/bin/ocamlc.opt
checking for ocamlopt.opt... /usr/bin/ocamlopt.opt
checking for ocaml... /usr/bin/ocaml
checking for ocamldep... /usr/bin/ocamldep
checking for ocamlmktop... /usr/bin/ocamlmktop
checking for ocamlmklib... /usr/bin/ocamlmklib
checking for ocamldoc... /usr/bin/ocamldoc
checking that the OCaml version is at least 3.12... yes
checking that the OCaml version is at least 4.02... yes
checking for ocamllex... /usr/bin/ocamllex
checking for ocamllex.opt... /usr/bin/ocamllex.opt
checking for ocamlyacc... /usr/bin/ocamlyacc
checking for ocamlfind... /usr/bin/ocamlfind
checking for ocamlprof... /usr/bin/ocamlprof
configure: verifying basic ocaml modules
configure: coccinelle may use external ocaml libraries in /home/v6000d/coccinelle/bundles
...
configure: configuring package parmap
checking for OCaml findlib package parmap... found


make says:
...
OCAMLC    parsing_c/includes.mli
OCAMLOPT  parsing_c/includes.ml
File "parsing_c/includes.ml", line 159, characters 9-22:
Error: Unbound module Parmap
Makefile:390: recipe for target 'parsing_c/includes.cmx' failed
make: *** [parsing_c/includes.cmx] Error 2
rm parsing_cocci/lexer_cli.ml parsing_cocci/parser_cocci_menhir.ml.d parsing_cocci/parser_cocci_menhir.mli.d parsing_cocci/lexer_script.ml parsing_cocci/lexer_cocci.ml

Not sure, if any of this helps.

Best regards,
Florian Pesth
