From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Thu, 18 Jun 2015 01:49:18 +0200
Subject: [Cocci] Discrepancy when using -j with path assumptions
In-Reply-To: <CAB=NE6WXj88ZbEToE3SVpDXejiMOF=kRq9BMgGHMM96EtZFsdw@mail.gmail.com>
References: <CAB=NE6WXj88ZbEToE3SVpDXejiMOF=kRq9BMgGHMM96EtZFsdw@mail.gmail.com>
Message-ID: <20150617234918.GJ11147@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Jun 17, 2015 at 04:43:11PM -0700, Luis R. Rodriguez wrote:
> If I use this SmPL rule:
> 
> mcgrof at drvbp1 ~/build/backports-20150525-ignore-all (git::master)$ cat
> 0019-usb_driver_lpm.cocci
> @@
> identifier backport_driver;
> @@
> struct usb_driver backport_driver = {
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
>         .disable_hub_initiated_lpm = 1,
> +#endif
> ...
> };
> 
> And use it without -j, and later with -j, the -j option fails:
> 
> mcgrof at drvbp1 ~/build/backports-20150525-ignore-all (git::master)$
> spatch --sp-file 0019-usb_driver_lpm.cocci --in-place
> --recursive-includes --relax-include-path --use-coccigrep --timeout
> 120 --dir drivers/net/wireless/ath/ath9k/
> 
> For example works but if I add '-j 32' it complains about not finding
> the file 0019-usb_driver_lpm.cocci.

Sorry the error is:

Fatal error: exception Sys_error("0019-usb_driver_lpm: No such file or directory")

So it seems the extension is forgotten in some situatin when using -j.

 Luis
