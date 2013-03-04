From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 4 Mar 2013 11:10:12 +0100 (CET)
Subject: [Cocci] Addition of source code documentation generation to the
 build system?
In-Reply-To: <5133B0BF.8000608@users.sourceforge.net>
References: <5133B0BF.8000608@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1303041106480.1984@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 3 Mar 2013, SF Markus Elfring wrote:

> Hello,
>
> I try to generate some documentation from the source files of your current software.
>
> elfring at Sonne:~/Projekte/Coccinelle/lokal> MY_DIR=../Probe/Doku/ &&
> MY_NAMES=${MY_DIR}file_name_list11.txt && find . \( -name '*.ml' -o -name
> '*.mli' \) -a ! -name 'myocamlbuild.ml' -type f -fprint0 $MY_NAMES &&
> ocamldoc.opt -d ${MY_DIR} -I commons -I commons/ocamlextra -I
> commons/ocollection -I globals -I engine -I parsing_c -I parsing_cocci -I ctl -I
> ocaml -I ocamlsexp -I python -I popl09 -I extra -I /usr/local/share/menhir -I
> bundles/pcre -I bundles/pycaml -dot -o ${MY_DIR}my_graph.gv -html $(sed 's/\x0/
> /g' $MY_NAMES)
>
>
> I get a couple of error messages because my approach is incomplete so far. I
> stumble on technical challenges here.
> Would you like to suggest an improved way for the construction of include
> directories and file names which should be passed to the command?
> Are there any chances to adapt it to the chosen build configuration?

Maybe you could use find with the -exec argument, if it is acceptable to
work on only one file at a time?  I wouldn't know how to make it sensitive
to the configuration.  I guess one could write some code to parse the
configuration file, but that doesn't seem very appealing.  Perhaps you
could also just look for the ML files that have been compiled, if you do
make clean first.

julia
