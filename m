From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 17 Mar 2014 22:51:07 +0100
Subject: [Cocci] Cooperation with OCaml batteries?
In-Reply-To: <alpine.DEB.2.10.1403171744330.2149@hadrien>
References: <53276BDF.7060905@users.sourceforge.net>
 <alpine.DEB.2.10.1403171744330.2149@hadrien>
Message-ID: <53276E4B.2010702@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Would you like to help in resolving any corresponding system configuration
>> challenges for such software?
> 
> No, I personally would not.

Thanks for your quick feedback.


> If you make an effort in this direction, you could contribute patches.

I have tried out a small SmPL script which contains the expression "open
Batteries" besides others which might become more interesting.

elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch --sp-file
list_file_name_lengths2.cocci ../Probe/f-ptr-test1.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
Using native version of ocamlc/ocamlopt/ocamldep
Extra OCaml packages used in the semantic patch: batteries
ocamlopt.opt -shared -o /tmp/list_file_name_lengths2ce667d.cmxs -g -I
/usr/lib64/ocaml -I /home/elfring/.opam/system/lib/batteries -I
/usr/local/share/coccinelle/ocaml /tmp/list_file_name_lengths2ce667d.ml
Compilation OK!
Loading /home/elfring/.opam/system/lib/batteries/batteries.cmxs...
error loading shared library:
/home/elfring/.opam/system/lib/batteries/batteries.cmxs: undefined symbol: camlLazy
Fatal error: exception
Yes_prepare_ocamlcocci.LinkFailure("/home/elfring/.opam/system/lib/batteries/batteries.cmxs")


Regards,
Markus
