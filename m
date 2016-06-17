From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Fri, 17 Jun 2016 08:07:15 -0700
Subject: [Cocci] Parallel building on high number of threads failing
Message-ID: <CAB=NE6Wi-QSR=PwGbhLGbycLqYVm6P_EMV3H+b=u=n1Ya2ZthA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Building coccinelle on a 4 core system using 4 threads works well, on
a 32-core system however it fails. Building serially works well on the
system. After autogen, configure, and then make -j 32 I get:

make[6]: Entering directory '/home/mcgrof/coccinelle/bundles/pycaml'
/usr/bin/ocamlopt.opt -I chemoelectric-pycaml-8614105 -cclib
-lpycaml_stubs -ccopt -I/usr/include/python2.7 -ccopt
-I/usr/include/x86_64-linux-gnu/python2.7 -cclib -lpython2.7 -c
chemoelectric-pycaml-8614105/pycaml.ml -o
chemoelectric-pycaml-8614105/pycaml.cmx
make[6]: *** No rule to make target
'chemoelectric-pycaml-8614105/pycaml.a', needed by
'all-opt-build-targets'.  Stop.
make[6]: *** Waiting for unfinished jobs....
make[6]: Leaving directory '/home/mcgrof/coccinelle/bundles/pycaml'
../Makefile.bundles:33: recipe for target 'all.opt' failed
make[5]: *** [all.opt] Error 2
make[5]: Leaving directory '/home/mcgrof/coccinelle/bundles/pycaml'
Makefile:186: recipe for target
'/home/mcgrof/coccinelle/bundles/pycaml/.opt' failed
make[4]: *** [/home/mcgrof/coccinelle/bundles/pycaml/.opt] Error 2
make[4]: Leaving directory '/home/mcgrof/coccinelle'
Makefile:180: recipe for target 'subdirs.opt' failed
make[3]: *** [subdirs.opt] Error 1
make[3]: Leaving directory '/home/mcgrof/coccinelle'
Makefile:163: recipe for target 'opt-compil' failed
make[2]: *** [opt-compil] Error 2
make[2]: Leaving directory '/home/mcgrof/coccinelle'
Makefile:143: recipe for target 'all-release' failed
make[1]: *** [all-release] Error 2
make[1]: Leaving directory '/home/mcgrof/coccinelle'
Makefile:121: recipe for target 'all' failed
make: *** [all] Error 2

So it seems there's a race against chemoelectric-pycaml-8614105/pycaml.a

  Luis
