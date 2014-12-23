From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Tue, 23 Dec 2014 18:33:31 +0100
Subject: [Cocci] RFC - simple scanners and matching macros
In-Reply-To: <alpine.DEB.2.10.1412231810140.2480@hadrien>
References: <20141223152045.GA6138@opentech.at>
 <alpine.DEB.2.10.1412231647160.2480@hadrien>
 <20141223162956.GA17482@opentech.at>
 <alpine.DEB.2.10.1412231745470.2480@hadrien>
 <20141223170255.GA29990@opentech.at>
 <alpine.DEB.2.10.1412231810140.2480@hadrien>
Message-ID: <20141223173331.GA17709@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > > >
> > > > because that would match cases like
> > > >
> > > >  init_completion(cmp)
> > > >  wait_for_completion(cmp)
> > > >  init_completion(cmp)
> > >
> > > Doesn't this match the "first working case" rule?
> > >
> >
> > yes - just not sure if the first case is exhaustive - only
> > if it is would the second rule in the simplified version
> > be correct I believe.
> 
> I mean, wouldn't the first rule match code like:
> 
> > > >  init_completion(cmp)
> > > >  wait_for_completion(cmp)
> > > >  init_completion(cmp)
> 
> and thus make a transformation that is not desired?
>

yes it does and should. That second init_completion is incorrect it should be
 init_completion(cmp)
 ...
 wait_for_completion(cmp)
 ...
 reinit_completion(cmp)

> > tried that first then removed the r assuming it was a typo
> >
> > hofrat at debian:~/git/linux-next$ make coccicheck COCCI=false_declare_completion.cocci MODE=report
> >
> > Please check for false positives in the output before submitting a patch.
> > When using "patch" mode, carefully review the patch before submitting it.
> >
> > 297 298
> > Fatal error: exception Failure("meta: parse error:
> >  = File "false_declare_completion.cocci", line 14, column 32,  charpos = 297
> >     around = '@', whole content = declarer name DECLARE_COMPLETION@;
> > ")
> 
> There seems to be a @ at the end of the declared declarer name.  You can't
> use @ in a metavariable name.
>
sorry not sure how I managed that - gives me the same error though

hofrat at debian:/tmp/linux-next$ make coccicheck COCCI=false_declare_completion.cocci MODE=patch

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

Fatal error: exception Failure("meta: parse error: 
 = File "false_declare_completion.cocci", line 27, column 14,  charpos = 511
    around = 'DECLARE_COMPLETION', whole content = declarer name DECLARE_COMPLETION;
")
...

complete script:
/* check for incorrect DECLARE_COMPLETION use within a function                 
 *
 * Options:  --no-includes --include-headers
 */
virtual context
virtual patch
virtual org
virtual report

/* flag incorrect initializer*/
@e depends on patch && !(context || org || report)@
expression cmp;
identifier f;
declarer name DECLARE_COMPLETION;
position p;
@@

f(...) {
  ...
- DECLARE_COMPLETION at p(cmp);
+ DECLARE_COMPLETION_ONSTACK(cmp);
  ...
}

@ep depends on !patch && (context || org || report)@
expression cmp;
identifier f;
declarer name DECLARE_COMPLETION;
position p;
@@

f(...) {
  ...
* DECLARE_COMPLETION at p(cmp);
  ...
}

@script:python depends on org@
p << ep.p;
@@

msg="WARNING: possible incorrect use of DECLARE_COMPLETION"
coccilib.org.print_todo(p[0], msg)

thx!
hofrat
