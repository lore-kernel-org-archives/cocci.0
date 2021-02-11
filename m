Return-Path: <SRS0=IHaO=HN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7C0C433DB
	for <cocci@archiver.kernel.org>; Thu, 11 Feb 2021 22:37:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6437464DCD
	for <cocci@archiver.kernel.org>; Thu, 11 Feb 2021 22:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6437464DCD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11BMbZVb027161;
	Thu, 11 Feb 2021 23:37:35 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 66F6577EB;
	Thu, 11 Feb 2021 23:37:35 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 97DC274AF
 for <cocci@systeme.lip6.fr>; Thu, 11 Feb 2021 23:25:34 +0100 (CET)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11BMPYs2017453
 for <cocci@systeme.lip6.fr>; Thu, 11 Feb 2021 23:25:34 +0100 (CET)
Received: by mail-ot1-f43.google.com with SMTP id q4so6703847otm.9
 for <cocci@systeme.lip6.fr>; Thu, 11 Feb 2021 14:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=59hf+6O4K21P81t02yR2JJsizjTVRLh6ZVSrQljA/sc=;
 b=Fj1NSEFA1eTDWJKImnl+fuqJf/IsfPb3Fd13r1KiSNWfRq8udEmOor0fx/aS4R6AFU
 5Kx6SySlkriowl4PN5T3yz7N78nhlb7jUnCQDp9Si/fmqWaVoVTS5hZUsY/o/wpaqsln
 vr2DOGpRIccXkY+VQcRHktC3IQMMi4AniLG8zFfne2ybe8w4+La63+jD3L5sXPk0HgZH
 yEIDVXckpFHcpeYAIhKS8RhE0yN62wOPdu3SAT77FPKiFfCZtSFp0Jd0olB1jK99cy0C
 HKhFr1AsfBSXhWewV+vnc1FseqLpMM1Z/61SzFTM60cnusdYZfqOw6KCKNS9ABlVuYe5
 oL3A==
X-Gm-Message-State: AOAM532CGveb0WjOqe/1+5CALJtlFQuqofOuvpTVFIkyTCDTgD/kG51y
 z/63PnwOB5tV1RJXXJkCTg==
X-Google-Smtp-Source: ABdhPJyoVcKGRF5I+pIki+Oo8A5jCC9o1Ifs/C5d7kBMPZRLIA+fMwLf/LFw7mtzzAZNV7Q3EHU3YQ==
X-Received: by 2002:a9d:605a:: with SMTP id v26mr136880otj.275.1613082333675; 
 Thu, 11 Feb 2021 14:25:33 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id j25sm978030otn.55.2021.02.11.14.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Feb 2021 14:25:32 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
Date: Thu, 11 Feb 2021 16:25:26 -0600
Message-Id: <20210211222526.1318236-3-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210211222526.1318236-1-robh@kernel.org>
References: <20210211222526.1318236-1-robh@kernel.org>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 11 Feb 2021 23:37:35 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 11 Feb 2021 23:25:34 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Thu, 11 Feb 2021 23:37:32 +0100
Cc: Felipe Balbi <balbi@kernel.org>, Michal Marek <michal.lkml@markovi.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>,
        Patrice Chotard <patrice.chotard@st.com>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, cocci@systeme.lip6.fr,
        linux-arm-kernel@lists.infradead.org
Subject: [Cocci] [PATCH 2/2] driver core: platform: Drop
	of_device_node_put() wrapper
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

of_device_node_put() is just a wrapper for of_node_put(). The platform
driver core is already polluted with of_node pointers and the only 'get'
already uses of_node_get() (though typically the get would happen in
of_device_alloc()).

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/base/platform.c   | 2 +-
 include/linux/of_device.h | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 95fd1549f87d..c31bc9e92dd1 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -571,7 +571,7 @@ static void platform_device_release(struct device *dev)
 	struct platform_object *pa = container_of(dev, struct platform_object,
 						  pdev.dev);
 
-	of_device_node_put(&pa->pdev.dev);
+	of_node_put(&pa->pdev.dev->of_node);
 	kfree(pa->pdev.dev.platform_data);
 	kfree(pa->pdev.mfd_cell);
 	kfree(pa->pdev.resource);
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index d7a407dfeecb..1d7992a02e36 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -38,11 +38,6 @@ extern int of_device_request_module(struct device *dev);
 extern void of_device_uevent(struct device *dev, struct kobj_uevent_env *env);
 extern int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env);
 
-static inline void of_device_node_put(struct device *dev)
-{
-	of_node_put(dev->of_node);
-}
-
 static inline struct device_node *of_cpu_device_node_get(int cpu)
 {
 	struct device *cpu_dev;
@@ -94,8 +89,6 @@ static inline int of_device_uevent_modalias(struct device *dev,
 	return -ENODEV;
 }
 
-static inline void of_device_node_put(struct device *dev) { }
-
 static inline const struct of_device_id *of_match_device(
 		const struct of_device_id *matches, const struct device *dev)
 {
-- 
2.27.0

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
