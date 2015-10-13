From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Tue, 13 Oct 2015 13:19:32 -0700
Subject: [Cocci] Compiling latest coccinelle with opensuse
Message-ID: <CAB=NE6XEE0zMpt7HBfEmxg1fDk4AqgfJ9F5oa_h0uMe4tCuzVQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I'm trying to build coccinelle to use on opensuse for a cocci file
with iteration support. I'm using the latest and greatest (inria git).

After ./autogen and and then configuring with --enable-release:

configure flags:  --enable-release
findlib:          /usr/bin/ocamlfind (an actual version is strongly recommended)
menhir:           /usr/local/bin//menhir (should be an optional tool)
menhirLib module: yes (for local package use --disable-menhirLib)

ocaml scripting:  yes (overridable with --enable-ocaml)
python scripting: yes (overridable with --enable-python)
pycaml module:    local (for local package use --disable-pycaml)

pcre regexes:     local (overridable with --enable-pcre-syntax)
pcre module:      local (for local package use --disable-pcre)
pcre library:     yes (requires the dev version of libpcre)

release config:   yes (strongly recommended to be 'yes', overridable
with --enable-release)
optimized spatch: yes (overridable with --disable-opt)

My build fails with:

/usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra
-I ../globals -I /usr/lib64/ocaml/menhirLib -c parser_cocci_menhir.ml
File "parser_cocci_menhir.ml", line 1:
Error: The files /usr/lib64/ocaml/obj.cmi
       and /usr/lib64/ocaml/menhirLib/menhirLib.cmi
       make inconsistent assumptions over interface Obj
Makefile:90: recipe for target 'parser_cocci_menhir.cmx' failed
make[6]: *** [parser_cocci_menhir.cmx] Error 2
make[6]: *** Waiting for unfinished jobs....
make[6]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle/parsing_cocci'
Makefile:61: recipe for target 'all.opt' failed
make[5]: *** [all.opt] Error 2
make[5]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle/parsing_cocci'
Makefile:202: recipe for target 'parsing_cocci.opt' failed
make[4]: *** [parsing_cocci.opt] Error 2
make[4]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle'
Makefile:196: recipe for target 'subdirs.opt' failed
make[3]: *** [subdirs.opt] Error 1
make[3]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle'
Makefile:167: recipe for target 'opt-compil' failed
make[2]: *** [opt-compil] Error 2
make[2]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle'
Makefile:147: recipe for target 'all-release' failed
make[1]: *** [all-release] Error 2
make[1]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle'
Makefile:125: recipe for target 'all' failed
make: *** [all] Error 2


If I try to disable ocaml scripting with:

./configure --enable-release --disable-ocaml

My build still fails with:

/usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra
-I ../globals -I /usr/lib64/ocaml/menhirLib -c parser_cocci_menhir.ml
File "parser_cocci_menhir.ml", line 1:
Error: The files /usr/lib64/ocaml/obj.cmi
       and /usr/lib64/ocaml/menhirLib/menhirLib.cmi
       make inconsistent assumptions over interface Obj
Makefile:90: recipe for target 'parser_cocci_menhir.cmx' failed

If I disable good 'ol mehir as well with:

./configure --enable-release --disable-ocaml --disable-menhirLib

it does not seem to disable menhir:

Summary

configure flags:  --enable-release --disable-ocaml --disable-menhirLib
--disable-menhirlib
findlib:          /usr/bin/ocamlfind (an actual version is strongly recommended)
menhir:           /usr/local/bin//menhir (should be an optional tool)
menhirLib module: local (for local package use --disable-menhirLib)

ocaml scripting:  no (overridable with --enable-ocaml)
python scripting: yes (overridable with --enable-python)
pycaml module:    local (for local package use --disable-pycaml)

pcre regexes:     local (overridable with --enable-pcre-syntax)
pcre module:      local (for local package use --disable-pcre)
pcre library:     yes (requires the dev version of libpcre)

release config:   yes (strongly recommended to be 'yes', overridable
with --enable-release)
optimized spatch: yes (overridable with --disable-opt)

I checked configure.ac but can't see why disabling menhirLib won't work.

If I nuke my local menhir, then:

./configure --enable-release --disable-ocaml

Summary

configure flags:  --enable-release --disable-ocaml
findlib:          /usr/bin/ocamlfind (an actual version is strongly recommended)
menhir:           /home/mcgrof/devel/coccinelle/setup/fake-menhir.sh
menhir (should be an optional tool)
menhirLib module: yes (for local package use --disable-menhirLib)

ocaml scripting:  no (overridable with --enable-ocaml)
python scripting: yes (overridable with --enable-python)
pycaml module:    local (for local package use --disable-pycaml)

pcre regexes:     local (overridable with --enable-pcre-syntax)
pcre module:      local (for local package use --disable-pcre)
pcre library:     yes (requires the dev version of libpcre)

release config:   yes (strongly recommended to be 'yes', overridable
with --enable-release)
optimized spatch: yes (overridable with --disable-opt)

then I get:

/home/mcgrof/devel/coccinelle/setup/fake-menhir.sh menhir --ocamlc
"/usr/bin/ocamlc.opt" --ocamldep "/usr/bin/ocamldep" --table --base
parser_cocci_menhir parser_cocci_menhir.mly
error: the file parser_cocci_menhir.ml is needed, which requires
preprocessing by menhir to obtain it from parser_cocci_menhir.mly.
However, menhir is not enabled.
error: the file parser_cocci_menhir.ml is needed, which requires
preprocessing by menhir to obtain it from parser_cocci_menhir.mly.
However, menhir is not enabled.
make[3]: *** No rule to make target 'parser_cocci_menhir.ml', needed
by 'depend'.  Stop.
make[3]: Leaving directory '/sda3/home/mcgrof/devel/coccinelle/parsing_cocci'
Makefile:566: recipe for target 'depend' failed

  Luis
