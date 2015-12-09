From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 9 Dec 2015 10:20:27 +0100
Subject: [Cocci] Finding labelled statements with SmPL
Message-ID: <5667F25B.1080901@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I have tried another small SmPL script out.

@label_used@
identifier target, work;
type return_type;
@@
 return_type work(...)
 {
 ... when any
*target:
 ... when any
 }


Test example:
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/drivers/block/skd_main.c

elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt show_labels1.cocci ~/Projekte/Linux/next-patched/drivers/block/skd_main.c
?
@@ -778,7 +778,6 @@ static void skd_request_fn(struct reques
                        continue;
                }
 
-skip_sg:
                scsi_req->hdr.sg_list_len_bytes =
                        cpu_to_be32(skreq->sg_byte_count);
 
?
@@ -5114,10 +5094,8 @@ err_out_iounmap:
        if (skdev->pcie_error_reporting_is_enabled)
                pci_disable_pcie_error_reporting(pdev);
 
-err_out_regions:
        pci_release_regions(pdev);
 
-err_out:
        pci_disable_device(pdev);
        return rc;
 }


It seems that only jump labels are found by the shown source code analysis
approach so far.
http://en.cppreference.com/w/c/language/goto

Does an enumeration symbol like "SKD_IRQ_MSIX" fit to the properties of
a C identifier?


I imagine that case labels could also be matched by such a simple search pattern.
http://en.cppreference.com/w/c/language/switch
http://c0x.coding-guidelines.com/6.8.1.html

@label_used@
expression label;
identifier work;
type return_type;
@@
 return_type work(...)
 {
 ... when any
*label:
 ... when any
 }


elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt show_labels2.cocci ~/Projekte/Linux/next-patched/drivers/block/skd_main.c
init_defs_builtins: /usr/local/lib64/coccinelle/standard.h
115 116
Fatal error: exception Failure("minus: parse error: \n = File \"show_labels2.cocci\", line 9, column 6,  charpos = 115\n    around = ':', whole content = *label:\n")


Would you like to clarify these observations?

Regards,
Markus
