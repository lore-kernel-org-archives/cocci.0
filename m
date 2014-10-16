From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Thu, 16 Oct 2014 14:13:44 +0200
Subject: [Cocci] Coccinelle rules for module_pci_driver
Message-ID: <543FB678.7000206@free-electrons.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

Thank you very much for your very useful tutorial at ELCE/Linux Con!

I continued to work on my rules to detect opportunities to use the
module_pci_driver macro in the Linux kernel.

I created multiple rules as you suggested, and here's where I stand:

>>>

// Find opportunities to use module_pci_driver(a)

@ rule1 @
identifier f1, ret;
struct pci_driver a;
@@

- int f1(void) {
- int ret;
- ret = pci_register_driver(&a);
- return ret;
- }

@ rule2 @
identifier f2;
identifier rule1.f1;
struct pci_driver rule1.a;
@@

- void f2(void) {
- pci_unregister_driver(&a);
- }

@@
declarer name module_init;
declarer name module_exit;
declarer name module_pci_driver; // this is top-level: not instantiated in a function
identifier rule1.f1;
identifier rule2.f2;
struct pci_driver rule1.a;
@@

- module_init(f1);

- module_exit(f2);

+ module_pci_driver(&a);

>>>

My rules work at least partially (tests on the latest mainline kernel):

>>>

spatch --sp-file exmodule.cocci --dir ../linux/drivers/scsi/arcmsr/arcmsr_hba.c 
init_defs_builtins: /usr/share/coccinelle/standard.h
warning: rule2: inherited metavariable f1 not used in the -, +, or context code
HANDLING: ../linux/drivers/scsi/arcmsr/arcmsr_hba.c
     (ONCE) already tagged but only removed, so safe
diff = 
--- ../linux/drivers/scsi/arcmsr/arcmsr_hba.c
+++ /tmp/cocci-output-7658-d2f178-arcmsr_hba.c
@@ -1280,18 +1280,6 @@ static void arcmsr_shutdown(struct pci_d
 	arcmsr_stop_adapter_bgrb(acb);
 	arcmsr_flush_adapter_cache(acb);
 }
-
-static int arcmsr_module_init(void)
-{
-	int error = 0;
-	error = pci_register_driver(&arcmsr_pci_driver);
-	return error;
-}
-
-static void arcmsr_module_exit(void)
-{
-	pci_unregister_driver(&arcmsr_pci_driver);
-}
 module_init(arcmsr_module_init);
 module_exit(arcmsr_module_exit);

>>>


While the first 2 rules found what they were supposed to, the third rule
doesn't produce the intended effect, i.e. replacing module_init|exit by
module_pci_driver.

I know I'm not caching all possible cases (multiple ways of testing the
return value of pci_register_driver), but I'd least I'd be happy if I
could make this first case work :)

Once everything works, I will create rules for the various bus types in
the Linux kernel (usb, i2c, platform...).

Thanks again,

Cheers,

Michael.

-- 
Michael Opdenacker, CEO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
+33 484 258 098
