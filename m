From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 17 Jun 2015 17:07:40 -0700 (PDT)
Subject: [Cocci] Discrepancy when using -j with path assumptions
In-Reply-To: <20150617234918.GJ11147@wotan.suse.de>
References: <CAB=NE6WXj88ZbEToE3SVpDXejiMOF=kRq9BMgGHMM96EtZFsdw@mail.gmail.com>
 <20150617234918.GJ11147@wotan.suse.de>
Message-ID: <alpine.DEB.2.10.1506171707190.2578@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 18 Jun 2015, Luis R. Rodriguez wrote:

> On Wed, Jun 17, 2015 at 04:43:11PM -0700, Luis R. Rodriguez wrote:
> > If I use this SmPL rule:
> >
> > mcgrof at drvbp1 ~/build/backports-20150525-ignore-all (git::master)$ cat
> > 0019-usb_driver_lpm.cocci
> > @@
> > identifier backport_driver;
> > @@
> > struct usb_driver backport_driver = {
> > +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
> >         .disable_hub_initiated_lpm = 1,
> > +#endif
> > ...
> > };
> >
> > And use it without -j, and later with -j, the -j option fails:
> >
> > mcgrof at drvbp1 ~/build/backports-20150525-ignore-all (git::master)$
> > spatch --sp-file 0019-usb_driver_lpm.cocci --in-place
> > --recursive-includes --relax-include-path --use-coccigrep --timeout
> > 120 --dir drivers/net/wireless/ath/ath9k/
> >
> > For example works but if I add '-j 32' it complains about not finding
> > the file 0019-usb_driver_lpm.cocci.
>
> Sorry the error is:
>
> Fatal error: exception Sys_error("0019-usb_driver_lpm: No such file or directory")
>
> So it seems the extension is forgotten in some situatin when using -j.

OK, it's possible.  I'll check.  Thanks for the report.

julia

>
>  Luis
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
