From: wpdster@gmail.com (Patrick Doyle)
Date: Wed, 16 May 2018 09:48:19 -0400
Subject: [Cocci] Need help compiling coccinelle on Ubuntu 16.04
Message-ID: <CAF_dkJCyP-2Yc-fynAGWp5D7YZP5ybaLXrYK4EHc_Z7XSP9kiA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

TherI just tried compiling coccinelle on a Ubuntu 16.04 system, having
installed all the dependencies that seem to make sense, and it fails
to compile.

I need to use a version of spatch >= 1.0.6 for another project, and
the version supplied with Ubuntu is 1.0.4.

So I:

$ git clone https://github.com/coccinelle/coccinelle.git
$ cd coccinelle
$ ./autogen
$ ./configure --prefix=/home/wpd/local
$ make

and that fails with

...
cp /usr/lib/ocaml/parmap/parmap.cmi ocaml/parmap.cmi
cp /usr/lib/ocaml/parmap/parmap.cmx ocaml/parmap.cmx
cp: cannot stat '/usr/lib/ocaml/parmap/parmap.cmx': No such file or directory
Makefile:620: recipe for target 'ocaml/parmap.cmi' failed
make: [ocaml/parmap.cmi] Error 1 (ignored)
rm parsing_cocci/lexer_cli.ml parsing_cocci/parser_cocci_menhir.ml.d
tools/spgen/source/spgen_lexer.ml
parsing_cocci/parser_cocci_menhir.mli.d parsing_cocci/lexer_script.ml
parsing_cocci/lexer_cocci.ml parsing_c/lexer_c.ml

I have installed libparmap-ocaml-dev:

$ apt search libparmap-ocaml-dev
Sorting... Done
Full Text Search... Done
libparmap-ocaml-dev/xenial,now 1.0~rc7-1 amd64 [installed]
  small OCaml library allowing to exploit multicore architectures

and /usr/lib/ocaml/parmp shows:

$ ls -l /usr/lib/ocaml/parmap
total 312
-rw-r--r-- 1 root root   2379 Jan 18  2016 bytearray.cmi
-rw-r--r-- 1 root root   1615 Jan 18  2016 bytearray.mli
-rw-r--r-- 1 root root   5218 Jan 18  2016 libparmap_stubs.a
-rw-r--r-- 1 root root    219 Jan 18  2016 META
-rw-r--r-- 1 root root 117954 Jan 18  2016 parmap.a
-rw-r--r-- 1 root root  27116 Jan 18  2016 parmap.cma
-rw-r--r-- 1 root root   5814 Jan 18  2016 parmap.cmi
-rw-r--r-- 1 root root   1898 Jan 18  2016 parmap.cmxa
-rw-r--r-- 1 root root 106712 Jan 18  2016 parmap.cmxs
-rw-r--r-- 1 root root  10472 Jan 18  2016 parmap.mli
-rw-r--r-- 1 root root    906 Jan 18  2016 parmap_utils.cmi
-rw-r--r-- 1 root root    270 Jan 18  2016 parmap_utils.mli
-rw-r--r-- 1 root root    363 Jan 18  2016 setcore.cmi
-rw-r--r-- 1 root root    207 Jan 18  2016 setcore.mli

There are parmap.cmxa and parmap.cmxs files, but no parmap.cmx file.

I am stuck here (and clearly ignorant of what I am doing).  Any help
would be appreciated.

Thank you.

--wpd
