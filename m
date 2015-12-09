From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 9 Dec 2015 11:15:38 +0100 (CET)
Subject: [Cocci] Finding labelled statements with SmPL
In-Reply-To: <5667F25B.1080901@users.sourceforge.net>
References: <5667F25B.1080901@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1512091114520.2491@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

A label has to be an identifier.  A sequence of all capital letters is
also an identifier.

julia

On Wed, 9 Dec 2015, SF Markus Elfring wrote:

> Hello,
>
> I have tried another small SmPL script out.
>
> @label_used@
> identifier target, work;
> type return_type;
> @@
>  return_type work(...)
>  {
>  ... when any
> *target:
>  ... when any
>  }
>
>
> Test example:
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/drivers/block/skd_main.c
>
> elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt show_labels1.cocci ~/Projekte/Linux/next-patched/drivers/block/skd_main.c
> ?
> @@ -778,7 +778,6 @@ static void skd_request_fn(struct reques
>                         continue;
>                 }
>
> -skip_sg:
>                 scsi_req->hdr.sg_list_len_bytes =
>                         cpu_to_be32(skreq->sg_byte_count);
>
> ?
> @@ -5114,10 +5094,8 @@ err_out_iounmap:
>         if (skdev->pcie_error_reporting_is_enabled)
>                 pci_disable_pcie_error_reporting(pdev);
>
> -err_out_regions:
>         pci_release_regions(pdev);
>
> -err_out:
>         pci_disable_device(pdev);
>         return rc;
>  }
>
>
> It seems that only jump labels are found by the shown source code analysis
> approach so far.
> http://en.cppreference.com/w/c/language/goto
>
> Does an enumeration symbol like "SKD_IRQ_MSIX" fit to the properties of
> a C identifier?
>
>
> I imagine that case labels could also be matched by such a simple search pattern.
> http://en.cppreference.com/w/c/language/switch
> http://c0x.coding-guidelines.com/6.8.1.html
>
> @label_used@
> expression label;
> identifier work;
> type return_type;
> @@
>  return_type work(...)
>  {
>  ... when any
> *label:
>  ... when any
>  }
>
>
> elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt show_labels2.cocci ~/Projekte/Linux/next-patched/drivers/block/skd_main.c
> init_defs_builtins: /usr/local/lib64/coccinelle/standard.h
> 115 116
> Fatal error: exception Failure("minus: parse error: \n = File \"show_labels2.cocci\", line 9, column 6,  charpos = 115\n    around = ':', whole content = *label:\n")
>
>
> Would you like to clarify these observations?
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
