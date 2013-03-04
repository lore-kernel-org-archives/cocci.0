From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 4 Mar 2013 16:47:44 +0100 (CET)
Subject: [Cocci] 1.0.0-rc16: Further fine-tuning for the build system?
In-Reply-To: <5134C06D.4070906@users.sourceforge.net>
References: <513268ED.5070703@users.sourceforge.net>
 <alpine.DEB.2.02.1303022218010.2033@localhost6.localdomain6>
 <51348708.1000005@users.sourceforge.net>
 <alpine.DEB.2.02.1303041334270.1984@hadrien>
 <5134C06D.4070906@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1303041645030.1984@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 4 Mar 2013, SF Markus Elfring wrote:

> > I don't know what strategy ocamlfind follows, in detail.  Perhaps it would be
> > more reasonable to take up the problem with them, since it is a general problem?
>
> I have repeated the following command once more.
>
> Sonne:/home/elfring/Projekte/Menhir/20130116 # make -j6 PREFIX=/usr/local install
>
>
> Now I get an expected result.
>
> elfring at Sonne:~/Projekte/Coccinelle/Bau> ocamlfind query menhirLib
> /usr/lib64/ocaml/site-lib/menhirLib
>
>
> It seems that I was affected by a "questionable" installation order. I am
> curious on improvements also for this software library.
> http://pauillac.inria.fr/~fpottier/menhir/
>
> Does it eventually need better configuration checks?

My impression is that the menhir developers have very few or no resources
to devote to the project now, so probably they are not interested in
making any improvements in this direction.

> But I notice another surprise.
>
> elfring at Sonne:~/Projekte/Coccinelle/Bau> ../lokal/configure --enable-opt
> --enable-ocaml --enable-python --enable-release
> configure: loading site script /usr/share/site/x86_64-unknown-linux-gnu
> configure: configuring coccinelle 1.0.0-rc15 in
> /home/elfring/Projekte/Coccinelle/Bau
> ...
> checking for OCaml findlib package menhirLib... found
> configure: verifying optional features
> checking for menhir... /usr/local/bin/menhir
> ...
> checking python version... 2.7 found
> configure: python major version: 2
> configure: looking for the corresponding python library
> checking for PYTHON... no
> ../lokal/configure: line 15081:
> /home/elfring/Projekte/Coccinelle/Bau/setup/fake-subst.sh: No such file or directory
> configure: error: the python scripts feature is enabled but the pkg-config
> python library is not found
>
>
> How should this error message be resolved?
> https://github.com/coccinelle/coccinelle/issues/9

Maybe you have python but not the developer libraries?

julia
