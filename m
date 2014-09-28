From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Sun, 28 Sep 2014 18:16:29 +0200
Subject: [Cocci] problem with Hashtbl in badzero.cocci
Message-ID: <20140928161629.GA23825@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


HI !

 make coccicheck in 3.16++
 is failing on Debian 7.6 with

make coccicheck MODE=report -C /usr/src/linux-stable/ M=/usr/src/read_msr
make[1]: Entering directory `/usr/src/linux-stable'

Please check for false positives in the output before submitting a
patch.
When using "patch" mode, carefully review the patch before submitting
it.

644 647
Fatal error: exception Failure("scriptmeta: parse error: 
 = File "./scripts/coccinelle/null/badzero.cocci", line 22, column 0,
charpos =
 644
    around = 'let', whole content = let negtable = Hashtbl.create 101
")
make[1]: Leaving directory `/usr/src/linux-stable'

built spatch from source:
  $ git clone https://github.com/coccinelle/coccinelle
  $ git tag -> git checkout -b build coccinelle-1.0.0-rc21
  $ apt-get install python2.6-dev libpycaml-ocaml-dev \
          libmenhir-ocaml-dev menhir ocaml-native-compilers \
          ocamlduce camlp4-extra ocaml-findlib pkg-config \
          texlive-fonts-extra
  $ ./configure --with-python --with-menhir
  $ make all
  $ make install

  $ spatch --version
    spatch version 1.0.0-rc21 with Python support and with Str regexp support 

is this a ocaml version issue ? or did I screw up something in the 
config/build ?

thx!
hofrat
