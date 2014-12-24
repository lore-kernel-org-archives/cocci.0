From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Wed, 24 Dec 2014 10:39:17 +0100
Subject: [Cocci] RFC - simple scanners and matching macros
In-Reply-To: <alpine.DEB.2.10.1412241022390.2414@hadrien>
References: <20141223162956.GA17482@opentech.at>
 <alpine.DEB.2.10.1412231745470.2480@hadrien>
 <20141223170255.GA29990@opentech.at>
 <alpine.DEB.2.10.1412231810140.2480@hadrien>
 <20141223173331.GA17709@opentech.at>
 <alpine.DEB.2.10.1412231902240.2480@hadrien>
 <20141223192852.GA19928@opentech.at>
 <alpine.DEB.2.02.1412232152190.2035@localhost6.localdomain6>
 <20141224085752.GA16334@opentech.at>
 <alpine.DEB.2.10.1412241022390.2414@hadrien>
Message-ID: <20141224093917.GA9383@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 24 Dec 2014, Julia Lawall wrote:

> > will update to rc23 and retest - can this be a config/python version issue ?
> > python version is 2.7.3 (Debian 7.6)
> 
> I have Python 2.7.5+
> 
> > > For the performance problem, could you send the current semantic patch
> > > again, so I could be sure to be testing the right thing?
> > >
> > files where this situation exists in linux-next (3.18.0) and which should
> > trigger are:
> >
> >  drivers/macintosh/ams/ams-pmu.c        line 52
> >  drivers/misc/sgi-gru/grukservices.c    line 1044
> >  drivers/scsi/aha152x.c                 line 1055
> >  drivers/usb/gadget/udc/fsl_qe_udc.c    line 2630
> >  drivers/usb/gadget/udc/fsl_udc_core.c  line 2529
> 
> I tried these files in their linux-next versions with the -D report option
> and got an answer more or less immediately (2 seconds).  An example command
> line is:
> 
> spatch --sp-file dc.cocci -D report /var/linuxes/linux-next/drivers/scsi/aha152x.c
> 
> Does this work for you?
>

for the single file it returns more or less imediately but it does not
report any findings

hofrat at debian:/tmp/linux-next$ spatch --sp-file false_declare_completion.cocci -D report drivers/scsi/aha152x.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
HANDLING: drivers/scsi/aha152x.c


if this is as fast as expected is hard to say for a single file
resolution of "time" is not good enough - but it still looks like
its slower than the other two files

hofrat at debian:/tmp/linux-next$ time spatch --sp-file false_declare_completion.cocci -D report drivers/scsi/aha152x.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
HANDLING: drivers/scsi/aha152x.c

real    0m0.362s
user    0m0.352s
sys     0m0.009s
hofrat at debian:/tmp/linux-next$ time spatch --sp-file false_init_compltion.cocci  -D report drivers/scsi/aha152x.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
(ONCE) Expected tokens init_completion
Skipping:drivers/scsi/aha152x.c

real    0m0.067s
user    0m0.062s
sys     0m0.005s

(false_init_compltion.cocci does not/should not trigger on aha152x.c

hofrat at debian:/tmp/linux-next$ time spatch --sp-file false_init_compltion.cocci  -D report drivers/block/aoe/aoecmd.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
HANDLING: drivers/block/aoe/aoecmd.c
drivers/block/aoe/aoecmd.c:1334:1-16: WARNING: possible reinit by init_completion

real    0m0.174s
user    0m0.151s
sys     0m0.012s

thx!
hofrat
