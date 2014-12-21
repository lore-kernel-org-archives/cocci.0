From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 21 Dec 2014 10:53:38 +0100
Subject: [Cocci] how to debug missing match?
Message-ID: <20141221095337.GA1081@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi

with linux kernel v3.18-rc1 and spatch version 1.0.0-rc22 with Python
support and with PCRE support from Debian:

~/Kernel/linux$ spatch -D report --sp-file scripts/coccinelle/api/platform_no_drv_owner.cocci arch/arm/mach-exynos/*.c

produces:

arch/arm/mach-exynos/pmu.c:994:3-8: No need to set .owner here. The core will do it.
diff = 
--- arch/arm/mach-exynos/pmu.c
+++ /tmp/cocci-output-25796-7e6ab9-pmu.c
@@ -991,7 +991,6 @@ static int exynos_pmu_probe(struct platf
 static struct platform_driver exynos_pmu_driver = {
 	.driver  = {
 		.name   = "exynos-pmu",
-		.owner	= THIS_MODULE,
 		.of_match_table = exynos_pmu_of_device_ids,
 	},
 	.probe = exynos_pmu_probe,

But:

~/Kernel/linux$ spatch -D report --sp-file scripts/coccinelle/api/platform_no_drv_owner.cocci drivers/macintosh/*.c

does not result in anything although three drivers should match IMO with
the same pattern as the pmu driver above. Both use
platform_driver_register() and both have the .owner field set.

drivers/macintosh/windfarm_pm112.c
drivers/macintosh/windfarm_pm72.c
drivers/macintosh/windfarm_rm31.c

How can I debug why the match does not occur?

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20141221/7b223621/attachment.asc>
