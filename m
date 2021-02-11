Return-Path: <SRS0=82Xq=HP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A10C433DB
	for <cocci@archiver.kernel.org>; Sat, 13 Feb 2021 21:38:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD1F64E3F
	for <cocci@archiver.kernel.org>; Sat, 13 Feb 2021 21:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD1F64E3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11DLc6OP019174;
	Sat, 13 Feb 2021 22:38:06 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1860574AF;
	Sat, 13 Feb 2021 22:38:06 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 19A0077AC
 for <cocci@systeme.lip6.fr>; Fri, 12 Feb 2021 00:27:52 +0100 (CET)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11BNRowA028449
 for <cocci@systeme.lip6.fr>; Fri, 12 Feb 2021 00:27:51 +0100 (CET)
Received: by mail-ot1-f54.google.com with SMTP id k10so6857176otl.2
 for <cocci@systeme.lip6.fr>; Thu, 11 Feb 2021 15:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1LjpgA7tiF9kF4NWWgBGZv/yfZD76E+O6IzMfolNrhI=;
 b=dSBq/pjrv5oZLS/iQjMR34K8ef1CPJ3wXUoarxHlmvjQsevGtInarzXIO4wlIY/rzO
 NNJw1SOx4YceBa0hYinfiLra1W+v/z2n2LYH7iIOCB3wFodngwpnAEcxYCYwFge+pccE
 AnI996yivLAdcCQBpaEt3rg6EnvvsCaDnlZKmzWFoYClCE3MVss8Sji3RWmM3KCyQWPq
 YmW3Qf6+lJPIThycNnwyHhDSUtvxsvngeFz2s4GtaQi9x9eWmZDaj/SnRYiTDyyhkig/
 5c5acCQRx6QuO3oQcyOZom8S4MlqLka1yu/KfgQWNG8/z8aA0IP7haIExUl4VP2WB1+S
 Mybw==
X-Gm-Message-State: AOAM531nZ2Cav3gx2lpSRMo6h4AKvAy7wDAeumGe3dMKAHtoXevzDdAA
 BX+K7aJqsJGG6eqWMC7qdA==
X-Google-Smtp-Source: ABdhPJzzrST9kvv3AkVN3oDgJ7rYWtqJYXycBW1mTioCcuYcJpNSC7VHw0MA7N+JhUlgaKQBsRlBPA==
X-Received: by 2002:a9d:7a81:: with SMTP id l1mr289355otn.180.1613086070567;
 Thu, 11 Feb 2021 15:27:50 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id s18sm1283922oih.53.2021.02.11.15.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Feb 2021 15:27:49 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
Date: Thu, 11 Feb 2021 17:27:44 -0600
Message-Id: <20210211232745.1498137-2-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210211232745.1498137-1-robh@kernel.org>
References: <20210211232745.1498137-1-robh@kernel.org>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 13 Feb 2021 22:38:06 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 12 Feb 2021 00:27:51 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sat, 13 Feb 2021 22:38:04 +0100
Cc: Felipe Balbi <balbi@kernel.org>, Michal Marek <michal.lkml@markovi.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>,
        Patrice Chotard <patrice.chotard@st.com>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, cocci@systeme.lip6.fr,
        linux-arm-kernel@lists.infradead.org
Subject: [Cocci] [PATCH v2 1/2] of: Remove of_dev_{get,put}()
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

of_dev_get() and of_dev_put are just wrappers for get_device()/put_device()
on a platform_device. There's also already platform_device_{get,put}()
wrappers for this purpose. Let's update the few users and remove
of_dev_{get,put}().

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Gilles Muller <Gilles.Muller@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-usb@vger.kernel.org
Cc: cocci@systeme.lip6.fr
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Fix build
---
 arch/powerpc/platforms/pseries/ibmebus.c |  4 ++--
 drivers/net/ethernet/ibm/emac/core.c     | 15 ++++++++-------
 drivers/of/device.c                      | 21 ---------------------
 drivers/of/platform.c                    |  4 ++--
 drivers/of/unittest.c                    |  2 +-
 drivers/usb/dwc3/dwc3-st.c               |  2 +-
 include/linux/of_device.h                |  3 ---
 scripts/coccinelle/free/put_device.cocci |  1 -
 8 files changed, 14 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index 8c6e509f6967..a15ab33646b3 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -355,12 +355,12 @@ static int ibmebus_bus_device_probe(struct device *dev)
 	if (!drv->probe)
 		return error;
 
-	of_dev_get(of_dev);
+	get_device(dev);
 
 	if (of_driver_match_device(dev, dev->driver))
 		error = drv->probe(of_dev);
 	if (error)
-		of_dev_put(of_dev);
+		put_device(dev);
 
 	return error;
 }
diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index c00b9097eeea..471be6ec7e8a 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -38,6 +38,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_net.h>
 #include <linux/of_mdio.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 #include <asm/processor.h>
@@ -2390,11 +2391,11 @@ static int emac_check_deps(struct emac_instance *dev,
 
 static void emac_put_deps(struct emac_instance *dev)
 {
-	of_dev_put(dev->mal_dev);
-	of_dev_put(dev->zmii_dev);
-	of_dev_put(dev->rgmii_dev);
-	of_dev_put(dev->mdio_dev);
-	of_dev_put(dev->tah_dev);
+	platform_device_put(dev->mal_dev);
+	platform_device_put(dev->zmii_dev);
+	platform_device_put(dev->rgmii_dev);
+	platform_device_put(dev->mdio_dev);
+	platform_device_put(dev->tah_dev);
 }
 
 static int emac_of_bus_notify(struct notifier_block *nb, unsigned long action,
@@ -2435,7 +2436,7 @@ static int emac_wait_deps(struct emac_instance *dev)
 	for (i = 0; i < EMAC_DEP_COUNT; i++) {
 		of_node_put(deps[i].node);
 		if (err)
-			of_dev_put(deps[i].ofdev);
+			platform_device_put(deps[i].ofdev);
 	}
 	if (err == 0) {
 		dev->mal_dev = deps[EMAC_DEP_MAL_IDX].ofdev;
@@ -2444,7 +2445,7 @@ static int emac_wait_deps(struct emac_instance *dev)
 		dev->tah_dev = deps[EMAC_DEP_TAH_IDX].ofdev;
 		dev->mdio_dev = deps[EMAC_DEP_MDIO_IDX].ofdev;
 	}
-	of_dev_put(deps[EMAC_DEP_PREV_IDX].ofdev);
+	platform_device_put(deps[EMAC_DEP_PREV_IDX].ofdev);
 	return err;
 }
 
diff --git a/drivers/of/device.c b/drivers/of/device.c
index aedfaaafd3e7..9a748855b39d 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -33,27 +33,6 @@ const struct of_device_id *of_match_device(const struct of_device_id *matches,
 }
 EXPORT_SYMBOL(of_match_device);
 
-struct platform_device *of_dev_get(struct platform_device *dev)
-{
-	struct device *tmp;
-
-	if (!dev)
-		return NULL;
-	tmp = get_device(&dev->dev);
-	if (tmp)
-		return to_platform_device(tmp);
-	else
-		return NULL;
-}
-EXPORT_SYMBOL(of_dev_get);
-
-void of_dev_put(struct platform_device *dev)
-{
-	if (dev)
-		put_device(&dev->dev);
-}
-EXPORT_SYMBOL(of_dev_put);
-
 int of_device_add(struct platform_device *ofdev)
 {
 	BUG_ON(ofdev->dev.of_node == NULL);
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 79bd5f5a1bf1..020bf860c72c 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -687,7 +687,7 @@ static int of_platform_notify(struct notifier_block *nb,
 		pdev_parent = of_find_device_by_node(rd->dn->parent);
 		pdev = of_platform_device_create(rd->dn, NULL,
 				pdev_parent ? &pdev_parent->dev : NULL);
-		of_dev_put(pdev_parent);
+		platform_device_put(pdev_parent);
 
 		if (pdev == NULL) {
 			pr_err("%s: failed to create for '%pOF'\n",
@@ -712,7 +712,7 @@ static int of_platform_notify(struct notifier_block *nb,
 		of_platform_device_destroy(&pdev->dev, &children_left);
 
 		/* and put the reference of the find */
-		of_dev_put(pdev);
+		platform_device_put(pdev);
 		break;
 	}
 
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index eb51bc147440..eb100627c186 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1286,7 +1286,7 @@ static void __init of_unittest_platform_populate(void)
 			unittest(pdev,
 				 "Could not create device for node '%pOFn'\n",
 				 grandchild);
-			of_dev_put(pdev);
+			platform_device_put(pdev);
 		}
 	}
 
diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index e733be840545..b06b7092b1a2 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -274,7 +274,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
 
 	dwc3_data->dr_mode = usb_get_dr_mode(&child_pdev->dev);
 	of_node_put(child);
-	of_dev_put(child_pdev);
+	platform_device_put(child_pdev);
 
 	/*
 	 * Configure the USB port as device or host according to the static
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 937f32f6aecb..d7a407dfeecb 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -26,9 +26,6 @@ static inline int of_driver_match_device(struct device *dev,
 	return of_match_device(drv->of_match_table, dev) != NULL;
 }
 
-extern struct platform_device *of_dev_get(struct platform_device *dev);
-extern void of_dev_put(struct platform_device *dev);
-
 extern int of_device_add(struct platform_device *pdev);
 extern int of_device_register(struct platform_device *ofdev);
 extern void of_device_unregister(struct platform_device *ofdev);
diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle/free/put_device.cocci
index 120921366e84..f09f1e79bfa6 100644
--- a/scripts/coccinelle/free/put_device.cocci
+++ b/scripts/coccinelle/free/put_device.cocci
@@ -21,7 +21,6 @@ id = of_find_device_by_node@p1(x)
 if (id == NULL || ...) { ... return ...; }
 ... when != put_device(&id->dev)
     when != platform_device_put(id)
-    when != of_dev_put(id)
     when != if (id) { ... put_device(&id->dev) ... }
     when != e1 = (T)id
     when != e1 = (T)(&id->dev)
-- 
2.27.0

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
