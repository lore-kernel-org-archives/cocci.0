From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Wed, 17 Jun 2015 16:43:11 -0700
Subject: [Cocci] Discrepancy when using -j with path assumptions
Message-ID: <CAB=NE6WXj88ZbEToE3SVpDXejiMOF=kRq9BMgGHMM96EtZFsdw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

If I use this SmPL rule:

mcgrof at drvbp1 ~/build/backports-20150525-ignore-all (git::master)$ cat
0019-usb_driver_lpm.cocci
@@
identifier backport_driver;
@@
struct usb_driver backport_driver = {
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
        .disable_hub_initiated_lpm = 1,
+#endif
...
};

And use it without -j, and later with -j, the -j option fails:

mcgrof at drvbp1 ~/build/backports-20150525-ignore-all (git::master)$
spatch --sp-file 0019-usb_driver_lpm.cocci --in-place
--recursive-includes --relax-include-path --use-coccigrep --timeout
120 --dir drivers/net/wireless/ath/ath9k/

For example works but if I add '-j 32' it complains about not finding
the file 0019-usb_driver_lpm.cocci.

 Luis
