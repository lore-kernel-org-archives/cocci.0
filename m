From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 23 Dec 2014 17:48:38 +0100 (CET)
Subject: [Cocci] RFC - simple scanners and matching macros
In-Reply-To: <20141223162956.GA17482@opentech.at>
References: <20141223152045.GA6138@opentech.at>
 <alpine.DEB.2.10.1412231647160.2480@hadrien>
 <20141223162956.GA17482@opentech.at>
Message-ID: <alpine.DEB.2.10.1412231745470.2480@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > > first working case:
> > > ===================
> > >
> > > @c@
> > > expression cmp;
> > > position p;
> > > @@
> > >
> > >  init_completion at p(cmp)
> > >
> > > @d@
> > > expression E,c.cmp;
> > > identifier f;
> > > position c.p,p1;
> > > @@
> > >
> > >   init_completion at p(cmp)
> > >   ...
> > > (
> > >   E = cmp
> > > |
> > >   E = &cmp
> > > |
> > >   f(..., cmp,...)
> > > |
> > >   f(..., &cmp,...)
> > > )
> > >   ...
> >
> > Perhaps you want <+... ...+> here, if these assignments or function calls
> > could occur more than once?
>
> fixed.
>
> >
> > > - init_completion at p1(cmp)
> > > + reinit_completion1(cmp)
> > >
> > >
> > > 2nd working case:
> > > =================
> > >
> > > @c@
> > > expression cmp;
> > > position p;
> > > @@
> > >
> > >  init_completion at p(cmp)
> > >
> > > @d@
> > > expression E,c.cmp;
> > > identifier f;
> > > position c.p,p1;
> > > @@
> > >
> > >   init_completion at p(cmp)
> > >   ... when != E = cmp
> > >       when != E = &cmp
> > >       when != f(..., cmp,...)
> > >       when != f(..., &cmp,...)
> > > - init_completion at p1(cmp);
> >
> > OK.  If you allow there to be none of these calls in between, then you
> > could merge these two rules, and change <+... ...+> to <... ...>.  But I
> > am not really sure what is the goal of these constraints at all.  Why not
> > just:
> >
> > init_completion at p(cmp)
> > ...
> > init_completion at p1(cmp)
> >
>
> because that would match cases like
>
>  init_completion(cmp)
>  wait_for_completion(cmp)
>  init_completion(cmp)

Doesn't this match the "first working case" rule?

> and that is not a double init but a reinit
> So the intent of the construct is to catch
> cases like:
>
> +++ b/drivers/scsi/qla4xxx/ql4_os.c
> @@ -8672,7 +8672,6 @@ static int qla4xxx_probe_adapter(struct
>         init_completion(&ha->disable_acb_comp);
>         init_completion(&ha->idc_comp);
>         init_completion(&ha->link_up_comp);
> -       init_completion(&ha->disable_acb_comp);
>
> where nothing was done with the completion object between the
> calls - so this should not be changed to a reinit_completion but dropped.
>
> > >
> > > the not-working case:
> > > =====================
> > > @e@
> > > expression cmp;
> > > identifier f;
> > > position p;
> > > @@
> > >
> > > f(...) {
> > >   ...
> > > - DECLARE_COMPLETION at p(cmp);
> > > + DECLARE_COMPLETION_ONSTACK(cmp);
> > >   ...
> > > }
> >
> > You need to add
> >
> > declarer name DECLARE_COMPLETION;
> >
> > among the metavariables.
> >
> tried it as you suggested - but that fusses:
>
> hofrat at debian:/tmp/linux-next$ make coccicheck COCCI=false_declare_completion.cocci MODE=patch
>
> Fatal error: exception Failure("meta: parse error:
>  = File "false_declare_completion.cocci", line 15, column 0,  charpos = 295
>     around = 'declare', whole content = declare name DECLARE_COMPLETION;
> ")

declarer name, with an "r" a the end, not declare name.

>
> spatch version is
> hofrat at debian:/tmp/linux-next$ spatch --version
> spatch version 1.0.0-rc21 with Python support and with Str regexp support
>
> The complete cocci script is below
>
> /* check for incorrect DECLARE_COMPLETION use within a function
>  *
>  * Options: --no-includes  --include-headers
>  */
> virtual context
> virtual patch
> virtual org
> virtual report
>
> /* flag incorrect initializer*/
> @e depends on patch && !(context || org || report)@
> expression cmp;
> identifier f;
> declare name DECLARE_COMPLETION;
> position p;
> @@
>
> f(...) {
>   ...
> - DECLARE_COMPLETION at p(cmp);
> + DECLARE_COMPLETION_ONSTACK(cmp);
>   ...

Actually, there should be <... ...> here too.  Otherwise, you will allow
only one DECLARE_COMPLETION in the function.

> }
>
> @ep depends on !patch && (context || org || report)@
> expression cmp;
> identifier f;
> declare name DECLARE_COMPLETION;
> position p;
> @@
>
> f(...) {
>   ...
> * DECLARE_COMPLETION at p(cmp);
>   ...
> }

Same here.

julia

> @script:python depends on org@
> p << ep.p;
> @@
>
> msg="WARNING: possible incorrect use of DECLARE_COMPLETION"
> coccilib.org.print_todo(p[0], msg)
>
> @script:python depends on report@
> p << ep.p;
> @@
>
> msg="WARNING: possible incorrect use of DECLARE_COMPLETION"
> coccilib.report.print_report(p[0], msg)
>
>
