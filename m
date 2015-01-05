From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 5 Jan 2015 22:54:43 +0100 (CET)
Subject: [Cocci] Error: Unbound value Common.union_set
In-Reply-To: <54AB026A.50909@Freescale.com>
References: <54AB026A.50909@Freescale.com>
Message-ID: <alpine.DEB.2.02.1501052253220.2025@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 5 Jan 2015, Emil Medve wrote:

> Hello,
> 
> 
> I'm seeing the following errors:
> 
> > File "/tmp/ocaml_cocci_cfd8ea.ml", line 21, characters 23-39:
> > Error: Unbound value Common.union_set

This is really strange.  What semantic patch are you running?

Could you try spatch --sp-file us.cocci us.c

where us.cocci is:

@script:ocaml@
@@

let _ = Common.union_set [1;2] [3] in
Printf.printf "ok\n"

@@
@@

- foo();

and us.c is:

int main () {
  foo();
}

thanks,
julia

> > File "/tmp/ocaml_cocci_0b6504.ml", line 21, characters 23-39:
> > Error: Unbound value Common.union_set
> > Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_cfd8ea.ml")
> > Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_0b6504.ml")
> > File "/tmp/ocaml_cocci_5c8de6.ml", line 21, characters 23-39:
> > File "/tmp/ocaml_cocci_bb345d.ml", line 21, characters 23-39:
> > Error: Unbound value Common.union_set
> > Error: Unbound value Common.union_set
> > Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_bb345d.ml")
> > Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_5c8de6.ml")
> > File "/tmp/ocaml_cocci_84f1b1.ml", line 21, characters 23-39:
> > File "/tmp/ocaml_cocci_e0436a.ml", line 21, characters 23-39:
> > Error: Unbound value Common.union_set
> > Error: Unbound value Common.union_set
> > Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_e0436a.ml")
> > Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_84f1b1.ml")
> > File "/tmp/ocaml_cocci_f46b5a.ml", line 21, characters 23-39:
> > Error: Unbound value Common.union_set
> > Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_f46b5a.ml")
> > File "/tmp/ocaml_cocci_a89bea.ml", line 21, characters 23-39:
> > Error: Unbound value Common.union_set
> > Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_a89bea.ml")
> 
> Here is the context and a few relevant version numbers:
> 
> > make coccicheck MODE=report M=...
> > $ git describe --abbrev=0
> > v3.19-rc2
> > $ spatch --version
> > spatch version 1.0.0-rc23 with Python support and with PCRE support
> > $ ocaml -version
> > The OCaml toplevel, version 4.02.1
> 
> Any advice? Need extra information?
> 
> 
> Cheers,
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
