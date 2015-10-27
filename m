From: rjones@redhat.com (Richard W.M. Jones)
Date: Tue, 27 Oct 2015 10:14:21 +0000
Subject: [Cocci] version 1.0.3 released
In-Reply-To: <alpine.DEB.2.02.1510262151580.2079@localhost6.localdomain6>
References: <alpine.DEB.2.02.1510262151580.2079@localhost6.localdomain6>
Message-ID: <20151027101421.GA14273@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This version seems to be incompatible with the latest menhir.  In
Fedora we have ocaml-menhir-20151012-1.fc24.x86_64, and I get
this error when compiling:

/usr/bin/ocamlc.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -I /usr/lib64/ocaml/menhirLib -c parser_cocci_menhir.mli
/usr/bin/ocamlopt.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -I /usr/lib64/ocaml/menhirLib -c parser_cocci_menhir.ml
File "parser_cocci_menhir.ml", line 1855, characters 15-48:
Error: Unbound constructor MenhirLib.TableInterpreter.Accept
Makefile:90: recipe for target 'parser_cocci_menhir.cmx' failed
make[6]: *** [parser_cocci_menhir.cmx] Error 2

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
