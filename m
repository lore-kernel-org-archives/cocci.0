From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 24 Dec 2014 10:56:23 +0100 (CET)
Subject: [Cocci] RFC - simple scanners and matching macros
In-Reply-To: <20141224095052.GA18250@opentech.at>
References: <20141223170255.GA29990@opentech.at>
 <alpine.DEB.2.10.1412231810140.2480@hadrien>
 <20141223173331.GA17709@opentech.at>
 <alpine.DEB.2.10.1412231902240.2480@hadrien>
 <20141223192852.GA19928@opentech.at>
 <alpine.DEB.2.02.1412232152190.2035@localhost6.localdomain6>
 <20141224085752.GA16334@opentech.at>
 <alpine.DEB.2.10.1412241022390.2414@hadrien>
 <20141224093917.GA9383@opentech.at>
 <alpine.DEB.2.10.1412241042280.2414@hadrien>
 <20141224095052.GA18250@opentech.at>
Message-ID: <alpine.DEB.2.10.1412241054500.2414@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 24 Dec 2014, Nicholas Mc Guire wrote:

> On Wed, 24 Dec 2014, Julia Lawall wrote:
>
> >
> >
> > On Wed, 24 Dec 2014, Nicholas Mc Guire wrote:
> >
> > > On Wed, 24 Dec 2014, Julia Lawall wrote:
> > >
> > > > > will update to rc23 and retest - can this be a config/python version issue ?
> > > > > python version is 2.7.3 (Debian 7.6)
> > > >
> > > > I have Python 2.7.5+
> > > >
> > > > > > For the performance problem, could you send the current semantic patch
> > > > > > again, so I could be sure to be testing the right thing?
> > > > > >
> > > > > files where this situation exists in linux-next (3.18.0) and which should
> > > > > trigger are:
> > > > >
> > > > >  drivers/macintosh/ams/ams-pmu.c        line 52
> > > > >  drivers/misc/sgi-gru/grukservices.c    line 1044
> > > > >  drivers/scsi/aha152x.c                 line 1055
> > > > >  drivers/usb/gadget/udc/fsl_qe_udc.c    line 2630
> > > > >  drivers/usb/gadget/udc/fsl_udc_core.c  line 2529
> > > >
> > > > I tried these files in their linux-next versions with the -D report option
> > > > and got an answer more or less immediately (2 seconds).  An example command
> > > > line is:
> > > >
> > > > spatch --sp-file dc.cocci -D report /var/linuxes/linux-next/drivers/scsi/aha152x.c
> > > >
> > > > Does this work for you?
> > > >
> > >
> > > for the single file it returns more or less imediately but it does not
> > > report any findings
> >
> > I get a result:
> >
> > /var/linuxes/linux-next/drivers/scsi/aha152x.c:1058:1-19: WARNING:
> > possible incorrect use of DECLARE_COMPLETION
> >
>
> with 1.0.0-rc23 I get the expected results ! both report and patch mode
> 1.0.0-rc21 no output.
>
> is it worth rebuilding -rc21 to confirm that its in -rc21 and not
> some local screwup or is this not relevant ?

rc21 had some severe parsing problems, on strings made from multiple
components, like "one" XXX "two".  It could be that the relevant
functions were simply not being parsed.

julia
