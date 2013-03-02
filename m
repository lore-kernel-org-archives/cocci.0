From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 2 Mar 2013 22:18:33 +0100 (CET)
Subject: [Cocci] 1.0.0-rc16: Further fine-tuning for the build system?
In-Reply-To: <513268ED.5070703@users.sourceforge.net>
References: <513268ED.5070703@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1303022218010.2033@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 2 Mar 2013, SF Markus Elfring wrote:

> Hello,
> 
> I try to regenerate your current software from the Git repository on my openSUSE
> system. I stumble on the following issue.
> 
> elfring at Sonne:~/Projekte/Coccinelle/Bau> ../lokal/configure --enable-opt
> --enable-ocaml --enable-python --enable-release
> configure: loading site script /usr/share/site/x86_64-unknown-linux-gnu
> configure: configuring coccinelle 1.0.0-rc15 in
> /home/elfring/Projekte/Coccinelle/Bau
> ...
> configure: configuring package menhirLib
> checking for OCaml findlib package menhirLib... not found
> configure: OCaml package menhirLib is not available
> checking for a bundled substitute of menhirLib... not available
> configure: error: OCaml package menhirLib is required. Please make sure it is
> available.
> 
> 
> This library is installed under the directory "/usr/local/share/menhir" and is
> found if I let the configuration script run while the source "lokal" is also the
> working directory.
> Would you like to adjust any configuration checks to support an
> "out-of-source-tree build"? (How do you think about to store generated files in
> a separate directory hierarchy here?)
> https://github.com/coccinelle/coccinelle/blob/abad11c5570b7b9bbae5ff92b3050cf68fe3fd14/configure.ac#L146

I'm not completely sure what you are proposing.  Perhaps you could just 
make a patch that does what you want?

julia
