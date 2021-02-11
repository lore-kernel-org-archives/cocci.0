Return-Path: <SRS0=82Xq=HP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F8BC433DB
	for <cocci@archiver.kernel.org>; Sat, 13 Feb 2021 21:38:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D1464E43
	for <cocci@archiver.kernel.org>; Sat, 13 Feb 2021 21:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D1464E43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11DLc7Kx016038;
	Sat, 13 Feb 2021 22:38:07 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1C52C77F3;
	Sat, 13 Feb 2021 22:38:07 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1EF6074AF
 for <cocci@systeme.lip6.fr>; Fri, 12 Feb 2021 00:27:54 +0100 (CET)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11BNRruN003544
 for <cocci@systeme.lip6.fr>; Fri, 12 Feb 2021 00:27:53 +0100 (CET)
Received: by mail-oi1-f171.google.com with SMTP id 18so8111112oiz.7
 for <cocci@systeme.lip6.fr>; Thu, 11 Feb 2021 15:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ADz3YBOZKFLK6zF24DOxVVKS+J+CretpaVJj7vT++ec=;
 b=NYZ6B/M5GjS5/QmEsV6x36Rtdf0pot+D5jurcY3ZcPvsNDWlRrJiHK07K6GwKNUVbn
 8TEA7sF9NsrQXnBlBkCptS9FLalq4ThAADvQeD5JWELiloCRi/KnpWs1fLQhmIgsTYde
 0c/t+UubnLnSNeHS3o6r91BOOiWoDemopYu9ItJz8g3eWlwmu1QVLOvS6GfkZuGFEMVR
 4RY76lXGVluO+fuZJfvA3qc14sssc93L4T3AeZ6GDPOo11sK/uXedjJNI+iD0isoCuqp
 N9nAOXRpU4dX31kH6YZob8NtNtpQbF/PTHHlSA0Mnv5ZqzTYI7zySNqX5Pv+i9l86Tcx
 QsJg==
X-Gm-Message-State: AOAM532Oj79V0MzRL/Ni7HjfKzv2p6H7zQodjamoujnX6SFGBhEPOsJs
 K+6ewM3LtM0rrbP02k6WHg==
X-Google-Smtp-Source: ABdhPJy+twQqGpwKSav6zIZvsh713BBmGhpUj6WaxgTGWBdNTF041IP+ZozxodSFlnoZb6Znde+AKQ==
X-Received: by 2002:aca:eb13:: with SMTP id j19mr185629oih.10.1613086073175;
 Thu, 11 Feb 2021 15:27:53 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id s18sm1283922oih.53.2021.02.11.15.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Feb 2021 15:27:51 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
Date: Thu, 11 Feb 2021 17:27:45 -0600
Message-Id: <20210211232745.1498137-3-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210211232745.1498137-1-robh@kernel.org>
References: <20210211232745.1498137-1-robh@kernel.org>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 13 Feb 2021 22:38:07 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 12 Feb 2021 00:27:53 +0100 (CET)
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
Subject: [Cocci] [PATCH v2 2/2] driver core: platform: Drop
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
v2:
 - Fix build
---
 drivers/base/platform.c   | 2 +-
 include/linux/of_device.h | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 95fd1549f87d..9d5171e5f967 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -571,7 +571,7 @@ static void platform_device_release(struct device *dev)
 	struct platform_object *pa = container_of(dev, struct platform_object,
 						  pdev.dev);
 
-	of_device_node_put(&pa->pdev.dev);
+	of_node_put(pa->pdev.dev.of_node);
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
