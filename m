From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 03 Mar 2013 21:21:19 +0100
Subject: [Cocci] Addition of source code documentation generation to the
	build system?
Message-ID: <5133B0BF.8000608@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I try to generate some documentation from the source files of your current software.

elfring at Sonne:~/Projekte/Coccinelle/lokal> MY_DIR=../Probe/Doku/ &&
MY_NAMES=${MY_DIR}file_name_list11.txt && find . \( -name '*.ml' -o -name
'*.mli' \) -a ! -name 'myocamlbuild.ml' -type f -fprint0 $MY_NAMES &&
ocamldoc.opt -d ${MY_DIR} -I commons -I commons/ocamlextra -I
commons/ocollection -I globals -I engine -I parsing_c -I parsing_cocci -I ctl -I
ocaml -I ocamlsexp -I python -I popl09 -I extra -I /usr/local/share/menhir -I
bundles/pcre -I bundles/pycaml -dot -o ${MY_DIR}my_graph.gv -html $(sed 's/\x0/
/g' $MY_NAMES)


I get a couple of error messages because my approach is incomplete so far. I
stumble on technical challenges here.
Would you like to suggest an improved way for the construction of include
directories and file names which should be passed to the command?
Are there any chances to adapt it to the chosen build configuration?

Regards,
Markus
