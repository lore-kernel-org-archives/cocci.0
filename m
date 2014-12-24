From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 24 Dec 2014 10:27:07 +0100 (CET)
Subject: [Cocci] RFC - simple scanners and matching macros
In-Reply-To: <20141224085752.GA16334@opentech.at>
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
 <20141224085752.GA16334@opentech.at>
Message-ID: <alpine.DEB.2.10.1412241022390.2414@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> will update to rc23 and retest - can this be a config/python version issue ?
> python version is 2.7.3 (Debian 7.6)

I have Python 2.7.5+

> > For the performance problem, could you send the current semantic patch
> > again, so I could be sure to be testing the right thing?
> >
> files where this situation exists in linux-next (3.18.0) and which should
> trigger are:
>
>  drivers/macintosh/ams/ams-pmu.c        line 52
>  drivers/misc/sgi-gru/grukservices.c    line 1044
>  drivers/scsi/aha152x.c                 line 1055
>  drivers/usb/gadget/udc/fsl_qe_udc.c    line 2630
>  drivers/usb/gadget/udc/fsl_udc_core.c  line 2529

I tried these files in their linux-next versions with the -D report option
and got an answer more or less immediately (2 seconds).  An example command
line is:

spatch --sp-file dc.cocci -D report /var/linuxes/linux-next/drivers/scsi/aha152x.c

Does this work for you?

julia

>
> the non-working semantic patch below:
>
> /* check for incorrect DECLARE_COMPLETION use within a function
>  *
>  * Options:  --no-includes --include-headers
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
> declarer name DECLARE_COMPLETION;
> position p;
> @@
>
> f(...) {
>   <...
> - DECLARE_COMPLETION at p(cmp);
> + DECLARE_COMPLETION_ONSTACK(cmp);
>   ...>
> }
>
> @ep depends on !patch && (context || org || report)@
> expression cmp;
> identifier f;
> position p;
> @@
>
> f(...) {
>   <...
> * DECLARE_COMPLETION at p(cmp);
>   ...>
> }
>
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
> thx!
> hofrat
>
