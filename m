From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Wed, 24 Dec 2014 09:57:52 +0100
Subject: [Cocci] RFC - simple scanners and matching macros
In-Reply-To: <alpine.DEB.2.02.1412232152190.2035@localhost6.localdomain6>
References: <20141223152045.GA6138@opentech.at>
 <alpine.DEB.2.10.1412231647160.2480@hadrien>
 <20141223162956.GA17482@opentech.at>
 <alpine.DEB.2.10.1412231745470.2480@hadrien>
 <20141223170255.GA29990@opentech.at>
 <alpine.DEB.2.10.1412231810140.2480@hadrien>
 <20141223173331.GA17709@opentech.at>
 <alpine.DEB.2.10.1412231902240.2480@hadrien>
 <20141223192852.GA19928@opentech.at>
 <alpine.DEB.2.02.1412232152190.2035@localhost6.localdomain6>
Message-ID: <20141224085752.GA16334@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 23 Dec 2014, Julia Lawall wrote:

> 
> 
> On Tue, 23 Dec 2014, Nicholas Mc Guire wrote:
> 
> > On Tue, 23 Dec 2014, Julia Lawall wrote:
> > 
> > > > Fatal error: exception Failure("meta: parse error:
> > > >  = File "false_declare_completion.cocci", line 27, column 14,  charpos = 511
> > > >     around = 'DECLARE_COMPLETION', whole content = declarer name DECLARE_COMPLETION;
> > > > ")
> > > > ...
> > > 
> > > OK, it's not super intuitive, but the problem is that it wants declarer
> > > names, like typedefs, to be declared once and only once.  And in deciding
> > > about this, it doesn't take into account the dependencies on virtual
> > > rules.  So if you use -D patch, then it complains about a declaration in a
> > > case that says depends on !patch.  And if you remove the declarer name
> > > declaration in the latter rule, when you use eg -D report, it takes into
> > > account the declaration in the previous, but disabled, -D patch rule.
> > > 
> > > So if you drop the second declarer name declaration, everything will be
> > > fine.
> > > 
> > > The fact that declaring a typedef, declarer name, or iterator name once
> > > was good enough was supposed to make things easier, but it seems to just
> > > make things confusing.  Maybe I should get rid of this feature, or at
> > > least not complain about redeclarations that are consistent with the
> > > previous one.
> > >
> > it did not complain - but something seems to be going wrong now it
> > consumes 100% CPU on all avaialble cores for about 8 minutes and
> > finds no match
> > 
> > hofrat at debian:/tmp/linux-next$ time make coccicheck COCCI=false_declare_completion.cocci MODE=report
> > 
> > Please check for false positives in the output before submitting a patch.
> > When using "patch" mode, carefully review the patch before submitting it.
> > 
> > 
> > real    8m9.438s
> > user    33m6.005s
> > sys     0m10.277s
> > 
> > about the same in MODE=patch, the other cocci file over the same tree ran
> > 
> > real    0m48.492s
> > user    2m26.627s
> > sys     0m1.933s
> > 
> > an example file where I had expected it to trigger is
> > drivers/scsi/aha152x.c - but it did not.
> > 
> > cut down testcse would be:
> > 
> > test.c:
> > static int aha152x_device_reset(Scsi_Cmnd * SCpnt)
> > {
> >         struct Scsi_Host *shpnt = SCpnt->device->host;
> >         DECLARE_COMPLETION(done);
> >         int ret, issued, disconnected;
> >         unsigned char old_cmd_len = SCpnt->cmd_len;
> >         unsigned long flags;
> >         unsigned long timeleft;
> >         /* snippet from drivers/scsi/aha152x.c */
> > }
> > 
> > test.cocci:
> > @e@
> > expression cmp;
> > identifier f;
> > declarer name DECLARE_COMPLETION;
> > position p;
> > @@
> > 
> > f(...) {
> >   <...
> > - DECLARE_COMPLETION at p(cmp);
> > + DECLARE_COMPLETION_ONSTACK(cmp);
> >   ...>
> > }
> > 
> > which should trigger if I did not do something foolish again
> > but it did not:
> > 
> > hofrat at debian:/tmp/linux-next$ spatch --sp-file test.cocci test.c
> > init_defs_builtins: /usr/local/share/coccinelle/standard.h
> > HANDLING: test.c
> 
> It works fine for me.  What version of Coccinelle do you have?
>

hofrat at debian:/tmp/linux-next$ spatch --version
spatch version 1.0.0-rc21 with Python support and with Str regexp support 

will update to rc23 and retest - can this be a config/python version issue ?
python version is 2.7.3 (Debian 7.6)
 
> For the performance problem, could you send the current semantic patch 
> again, so I could be sure to be testing the right thing?
>
files where this situation exists in linux-next (3.18.0) and which should
trigger are:

 drivers/macintosh/ams/ams-pmu.c        line 52
 drivers/misc/sgi-gru/grukservices.c    line 1044
 drivers/scsi/aha152x.c                 line 1055
 drivers/usb/gadget/udc/fsl_qe_udc.c    line 2630
 drivers/usb/gadget/udc/fsl_udc_core.c  line 2529


the non-working semantic patch below:

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
  <...
- DECLARE_COMPLETION@p(cmp);
+ DECLARE_COMPLETION_ONSTACK(cmp);
  ...>
} 

@ep depends on !patch && (context || org || report)@
expression cmp;
identifier f;
position p;
@@

f(...) {
  <...
* DECLARE_COMPLETION@p(cmp);
  ...>
} 

@script:python depends on org@
p << ep.p;
@@

msg="WARNING: possible incorrect use of DECLARE_COMPLETION"
coccilib.org.print_todo(p[0], msg)

@script:python depends on report@
p << ep.p;
@@

msg="WARNING: possible incorrect use of DECLARE_COMPLETION"
coccilib.report.print_report(p[0], msg)

thx!
hofrat
