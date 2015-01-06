From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 6 Jan 2015 11:09:09 +0100 (CET)
Subject: [Cocci] Error: Unbound value Common.union_set
In-Reply-To: <54AB1518.7060209@Freescale.com>
References: <54AB026A.50909@Freescale.com>
 <alpine.DEB.2.02.1501052253220.2025@localhost6.localdomain6>
 <54AB0D0B.3030909@Freescale.com>
 <alpine.DEB.2.02.1501052317500.2025@localhost6.localdomain6>
 <54AB1518.7060209@Freescale.com>
Message-ID: <alpine.DEB.2.10.1501061108440.2402@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

We are looking into it. It seems to be related to the version of ocaml.

julia

On Mon, 5 Jan 2015, Emil Medve wrote:

> Hello Julia,
>
>
> On 01/05/2015 04:19 PM, Julia Lawall wrote:
> > On Mon, 5 Jan 2015, Emil Medve wrote:
> >
> >> Hello Julia,
> >>
> >>
> >> On 01/05/2015 03:54 PM, Julia Lawall wrote:
> >>> On Mon, 5 Jan 2015, Emil Medve wrote:
> >>>
> >>>> Hello,
> >>>>
> >>>>
> >>>> I'm seeing the following errors:
> >>>>
> >>>>> File "/tmp/ocaml_cocci_cfd8ea.ml", line 21, characters 23-39:
> >>>>> Error: Unbound value Common.union_set
> >>>
> >>> This is really strange.  What semantic patch are you running?
> >>
> >> All of them as I'm not using COCCI=... to select some specific single
> >> patch. I'll narrow it down a bit and get back to you
>
> scripts/coccinelle/null/badzero.cocci
>
> > File "/tmp/ocaml_cocci_cc56de.ml", line 21, characters 23-39:
> > Error: Unbound value Common.union_set
> > Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_cc56de.ml")
>
> This is the only patch that seems to produce unexpected results
>
> >>> Could you try spatch --sp-file us.cocci us.c
> >>>
> >>> where us.cocci is:
> >>>
> >>> @script:ocaml@
> >>> @@
> >>>
> >>> let _ = Common.union_set [1;2] [3] in
> >>> Printf.printf "ok\n"
> >>>
> >>> @@
> >>> @@
> >>>
> >>> - foo();
> >>>
> >>> and us.c is:
> >>>
> >>> int main () {
> >>>   foo();
> >>> }
> >>
> >> I'm sure this makes more sense to you then it makes to me:
> >>
> >>> $ spatch --sp-file us.cocci us.c
> >>> init_defs_builtins: /usr/lib64/ocaml/coccinelle/standard.h
> >>> Using native version of ocamlc/ocamlopt/ocamldep
> >>> ocamlopt.opt -shared -o /tmp/ocaml_cocci_e217fe.cmxs -g -I /usr/lib64/ocaml  -I /usr/lib64/ocaml/coccinelle//ocaml /tmp/ocaml_cocci_e217fe.ml
> >>> File "/tmp/ocaml_cocci_e217fe.ml", line 15, characters 6-36:
> >>> Error: Unbound value Iteration.add_pending_instance
> >>> Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_e217fe.ml")
> >
> > Something is completely wrong with your installation.
> >
> > Where did you get your Coccinelle from?
>
> http://coccinelle.lip6.fr/distrib/coccinelle-1.0.0-rc23.tgz
>
> > Did you compile it yourself?
>
> Sort of. This is a Gentoo box. The following self-tests seems to run
> correctly though:
>
> > ./spatch standard.h -parse_c -dir tests/
> > ./spatch -iso_file standard.iso -macro_file_builtins standard.h -testall
> > ./spatch.opt -iso_file standard.iso -macro_file_builtins standard.h -testall
>
>
> Cheers,
>
>
> > Maybe it is an ocaml version problem.  Your version is newer than mine.  I
> > will try to get someone to try with the ocaml version you have.
> >
> > julia
> >
> >
> >
> >>
> >>
> >> Cheers,
> >>
> >>
> >>> thanks,
> >>> julia
> >>>
> >>>>> File "/tmp/ocaml_cocci_0b6504.ml", line 21, characters 23-39:
> >>>>> Error: Unbound value Common.union_set
> >>>>> Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_cfd8ea.ml")
> >>>>> Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_0b6504.ml")
> >>>>> File "/tmp/ocaml_cocci_5c8de6.ml", line 21, characters 23-39:
> >>>>> File "/tmp/ocaml_cocci_bb345d.ml", line 21, characters 23-39:
> >>>>> Error: Unbound value Common.union_set
> >>>>> Error: Unbound value Common.union_set
> >>>>> Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_bb345d.ml")
> >>>>> Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_5c8de6.ml")
> >>>>> File "/tmp/ocaml_cocci_84f1b1.ml", line 21, characters 23-39:
> >>>>> File "/tmp/ocaml_cocci_e0436a.ml", line 21, characters 23-39:
> >>>>> Error: Unbound value Common.union_set
> >>>>> Error: Unbound value Common.union_set
> >>>>> Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_e0436a.ml")
> >>>>> Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_84f1b1.ml")
> >>>>> File "/tmp/ocaml_cocci_f46b5a.ml", line 21, characters 23-39:
> >>>>> Error: Unbound value Common.union_set
> >>>>> Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_f46b5a.ml")
> >>>>> File "/tmp/ocaml_cocci_a89bea.ml", line 21, characters 23-39:
> >>>>> Error: Unbound value Common.union_set
> >>>>> Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_a89bea.ml")
> >>>>
> >>>> Here is the context and a few relevant version numbers:
> >>>>
> >>>>> make coccicheck MODE=report M=...
> >>>>> $ git describe --abbrev=0
> >>>>> v3.19-rc2
> >>>>> $ spatch --version
> >>>>> spatch version 1.0.0-rc23 with Python support and with PCRE support
> >>>>> $ ocaml -version
> >>>>> The OCaml toplevel, version 4.02.1
> >>>>
> >>>> Any advice? Need extra information?
> >>>>
> >>>>
> >>>> Cheers,
> >>>> _______________________________________________
> >>>> Cocci mailing list
> >>>> Cocci at systeme.lip6.fr
> >>>> https://systeme.lip6.fr/mailman/listinfo/cocci
>
