From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 10 Jun 2017 19:43:29 +0200
Subject: [Cocci] Replacing suffix rules in make scripts?
Message-ID: <020f8c95-fcaa-d47e-410b-7fb633fefa09@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I have achieved a bit of progress with one experiment for build script adjustments.
I would like to try further changes out. Unfortunately, I stumbled on an error
message like the following from the program ?GNU Make 4.2.1-1.7? then.

?
/usr/bin/ocamlopt.opt ?
File "cocci.ml", line 1:
Error: Could not find the .cmi file for interface cocci.mli.
make[3]: *** [Makefile:533: cocci.cmx] Error 2
?


It seems that the following code is relevant in this use case.

?
.ml.cmo:
	$(OCAMLC_CMD) -c $<
.mli.cmi:
	$(OCAMLC_CMD) -c $<
.ml.cmx:
	$(OCAMLOPT_CMD) -c $<
?


Other documentation provides this information:
??
Suffix rules cannot have any prerequisites of their own.
??


So I get the impression that an other build approach will be safer there.
How do you think about to add a dependency specification so that interface
descriptions will be always compiled before the corresponding OCaml code?

Regards,
Markus
