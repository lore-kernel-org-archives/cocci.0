From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 02 Mar 2013 22:02:37 +0100
Subject: [Cocci] 1.0.0-rc16: Further fine-tuning for the build system?
Message-ID: <513268ED.5070703@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I try to regenerate your current software from the Git repository on my openSUSE
system. I stumble on the following issue.

elfring at Sonne:~/Projekte/Coccinelle/Bau> ../lokal/configure --enable-opt
--enable-ocaml --enable-python --enable-release
configure: loading site script /usr/share/site/x86_64-unknown-linux-gnu
configure: configuring coccinelle 1.0.0-rc15 in
/home/elfring/Projekte/Coccinelle/Bau
...
configure: configuring package menhirLib
checking for OCaml findlib package menhirLib... not found
configure: OCaml package menhirLib is not available
checking for a bundled substitute of menhirLib... not available
configure: error: OCaml package menhirLib is required. Please make sure it is
available.


This library is installed under the directory "/usr/local/share/menhir" and is
found if I let the configuration script run while the source "lokal" is also the
working directory.
Would you like to adjust any configuration checks to support an
"out-of-source-tree build"? (How do you think about to store generated files in
a separate directory hierarchy here?)
https://github.com/coccinelle/coccinelle/blob/abad11c5570b7b9bbae5ff92b3050cf68fe3fd14/configure.ac#L146

Regards,
Markus
