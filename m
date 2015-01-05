From: Emilian.Medve@Freescale.com (Emil Medve)
Date: Mon, 5 Jan 2015 15:30:18 -0600
Subject: [Cocci] Error: Unbound value Common.union_set
Message-ID: <54AB026A.50909@Freescale.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,


I'm seeing the following errors:

> File "/tmp/ocaml_cocci_cfd8ea.ml", line 21, characters 23-39:
> Error: Unbound value Common.union_set
> File "/tmp/ocaml_cocci_0b6504.ml", line 21, characters 23-39:
> Error: Unbound value Common.union_set
> Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_cfd8ea.ml")
> Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_0b6504.ml")
> File "/tmp/ocaml_cocci_5c8de6.ml", line 21, characters 23-39:
> File "/tmp/ocaml_cocci_bb345d.ml", line 21, characters 23-39:
> Error: Unbound value Common.union_set
> Error: Unbound value Common.union_set
> Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_bb345d.ml")
> Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_5c8de6.ml")
> File "/tmp/ocaml_cocci_84f1b1.ml", line 21, characters 23-39:
> File "/tmp/ocaml_cocci_e0436a.ml", line 21, characters 23-39:
> Error: Unbound value Common.union_set
> Error: Unbound value Common.union_set
> Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_e0436a.ml")
> Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_84f1b1.ml")
> File "/tmp/ocaml_cocci_f46b5a.ml", line 21, characters 23-39:
> Error: Unbound value Common.union_set
> Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_f46b5a.ml")
> File "/tmp/ocaml_cocci_a89bea.ml", line 21, characters 23-39:
> Error: Unbound value Common.union_set
> Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_a89bea.ml")

Here is the context and a few relevant version numbers:

> make coccicheck MODE=report M=...
> $ git describe --abbrev=0
> v3.19-rc2
> $ spatch --version
> spatch version 1.0.0-rc23 with Python support and with PCRE support
> $ ocaml -version
> The OCaml toplevel, version 4.02.1

Any advice? Need extra information?


Cheers,
