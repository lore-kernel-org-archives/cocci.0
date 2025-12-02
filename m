Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BB7D3B7F4
	for <cocci@archiver.kernel.org>; Tue,  9 Dec 2025 10:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=na5v78OCyeT9zlR5GeRvaaoUwV8EP7IcuCIa4acHer8=;
  b=Z37iTO8dBgzlbeOxijuSRM7ZfCrWP3gcQdo7p/5O7z066+H8FkbgXkU7
   3QF9WrvEqx+aYx5fo9CqRFvYN2+PEe7SyTHXZRzGaWsrt9/lYeiMH+TgB
   O1zIS/HRYLUtumaJLUAh03mdKq59RVRfQ3dXOUSIhuajAL/F09ojo7KXr
   Q=;
X-CSE-ConnectionGUID: kYz1euHqTqipgHECWYtRYQ==
X-CSE-MsgGUID: aYiLPmEyRgS2aLgA2v5Gqw==
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="6.20,261,1758578400"; 
   d="scan'208";a="253494872"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Dec 2025 11:09:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A8886E0CEE; Tue,  9 Dec 2025 11:09:40 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E03D3E0157
	for <cocci@sympa.inria.fr>; Tue,  2 Dec 2025 20:31:42 +0100 (CET)
X-CSE-ConnectionGUID: OzhwzUkBSb6GoBaqDuqy7Q==
X-CSE-MsgGUID: 9j+9FuQaSVy5QpmINkUaRA==
IronPort-SDR: 692f3e9e_Z0a6+vfUOo5IJ03xugPnpycaWco7PmVwlB+PIjg3zEVr/O5
 1lbyr3ILBfA1ptrfhLup6cDz4JVr7K6e5fouJ4Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EdAABzPS9pganSVdFaHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?W1SgWEzBFSMcYlYmD+FXoF9Ag8BAwELAQFPAgQBAQMEhQACjGcCHgcBBDAJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEiGQcOO4ZPD?=
 =?us-ascii?q?YJiAYEkgSYBAQEBAQEBAQEBAQEdAg1+AgEDEhULAQ0BATcBD1EzAQUBHAYTI?=
 =?us-ascii?q?oJggiMBBkoDAaQDgQVCjD0zgQGCDAEBBtwngWQJCQEKgTcBhW2HY3GDfnonG?=
 =?us-ascii?q?4FJRIJQgTd2hCWGYoM0hiKCKwSBVYdNh2lIgR4DWSwBVRMNCgsHBVuBCAM1D?=
 =?us-ascii?q?AsqFW4yHYEjPhhzhF0eZw8GgRGDTwaJEQ+IAYI8IwMLGA1IESw3FBsGPm4Hl?=
 =?us-ascii?q?BxPgiEJBwEVeRtklReDJI8RoQ6EJoFkDJ9nTZdSDJMNLodlkHOkCFCEPQIKB?=
 =?us-ascii?q?wcRJIFEOoFcMxowgypPAxkPjiEMFohxv20iNTwCBwsBAQMJhUMmE4wigUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 JetqzdY1VsmYodrdOrfI61GylUWjaWL7HfA6w==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ta8DyqPWQVnPR8BcTgSjsMiBIKoaSvp037Dk7TEXdfUzSL3mqy
 nKpp4mPHDP+U8ssR0b6LW90ey7MAnhHP1OkPUs1NWZLXHbUQKTRekInOnfKn/balDDH4ZmpM
 RdmsNFebvN5DZB/KLHyTj9PNA63tGd/aykwcvYxWx8VBxnZshbgztRO0K0FglZSmB9a6bR16
 Dy2iOEnVedkLgsD/hTfkN1JNQrbueqqK7b
X-Talos-CUID: 9a23:nBcF2G2USJ6FGMjATwnEF7xfPdIlbW/gz13rKRGXDkxgUZGIUE7PwfYx
X-Talos-MUID: =?us-ascii?q?9a23=3A26ujsg4l77I3XzKxIp2/ENp2xow54ef/Jl00mK4?=
 =?us-ascii?q?4qpS9LSlRHTSghQ6eF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,243,1758578400"; 
   d="scan'208";a="252425149"
X-MGA-submission: =?us-ascii?q?MDHUkw0FouiZajbJUAWBOeCOtLDuazBiTv+3hg?=
 =?us-ascii?q?yar4VEDkeUgjH7yZIJglaP3A6aDwM3SKrChntjAbS8qLPtDcDn33Y7GH?=
 =?us-ascii?q?j80JDyjMfxHmFtkW6+TkSMLoUeSmquNYXCeYi7uaNZJbbCceg9ngKcHL?=
 =?us-ascii?q?zEhFaawjdb2Zwst4OthVdcEg=3D=3D?=
Received: from mail-pf1-f169.google.com ([209.85.210.169])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 20:31:42 +0100
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so4074525b3a.2
        for <cocci@inria.fr>; Tue, 02 Dec 2025 11:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764703901; x=1765308701; darn=inria.fr;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=na5v78OCyeT9zlR5GeRvaaoUwV8EP7IcuCIa4acHer8=;
        b=aGK3hzX9eHGhbak2Vo7/0pV57fpfmtQTpN6bw6Z/u+JluQpJE7e3i7x95p1yGY2lA3
         3PNEoarEFeKdQ1pknpTyGjpHU1/TNBSg28qWo7EBxr7eBXsLx8FgOdT4+I3KK369uAw6
         F4BG1n5JNZN7RMpL8NBNz+5JENcYbU+izlzMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764703901; x=1765308701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=na5v78OCyeT9zlR5GeRvaaoUwV8EP7IcuCIa4acHer8=;
        b=F3wXRaSyetqmz/nW/acOijUB6D9Elj4XjENvCaqOadBRA+rtYNBiOKf/338Qs3DELk
         ioRXs3DDKjGKj1iRawvt2XYdgsMA90XS+xTcstDQGm3ZoEh8+fwA6QxoobffA+b7oz/V
         +iSUYpp5AtuLTNDylwYjnqzni+UfXRaMUUA9UJF1i5sLoRwswieAE4ZWAZ7HnWch+1xe
         SKB1LTzEKXz1eP8m817VQ1W+dXaCrhstysmHbkkI57O4tZrlCNFe+Lqa9SL3Uo/ieKLn
         KJ6Zmj8o6eHdieZxuN1q4TYhI2FEA0nAabGe9BxLjZABnDBu7qNQy4WnBjAib1bCCbu2
         F+lg==
X-Forwarded-Encrypted: i=1; AJvYcCVo+xUtHq+Sq6mbhMqYi79KdCpKJ9c01TcWNwrr+PHk/Wd0tK7R77PMTUnZD4KUL31Wc4EE1w==@inria.fr
X-Gm-Message-State: AOJu0Yw4imCjvWO5uTVxYG3gGtx3PLzePW/p2Z9kurxCUTGd8g84ZYEv
	egNtpJtp7p5cj5AvaWzrYW2Uswc5Mv+Ds21hY/NH5xXfkZpH/oG7jcBjBHQM5Lq/KA==
X-Gm-Gg: ASbGnctpjbWrPdG8olaFa9b1bmhcaIlPUrgSHfoxO4n2uOiLj5bCf72NDA4grD8yIyn
	YQ1Rtl0i4JrTaCVISw3ZYFpuwyKKYB8ySzaflJceoyq3Ld4sKTWw21xCQHtguzHil7GgOSVFftT
	jCpn5CCLUyw61xWXrzgfOn03PM7AJQI2046d9BOahtzNWSty86e62bpOELOw0bQbvmpPmsaFQtf
	q+FZxlZSOosBRe7O9d8WN4jyKkwFgXWIkhPUqMARcR3C+Lts+1Tpf5EnrRgXtOIpoK7cj1JRhqy
	Eb5SXizBZjmBbz8FX8o2wOVzeNOTdtRVDiC3z9l4lm3aUQ3YKG9dGMmZymiN7z3bzMshRyBa7Jv
	C3rpu5qmnNAN1xmXJzTA+JCv7ve3OV5qnuRbT0xksORpDIEzZu8oHQY6qZn1pCunSxDxuxVd2iK
	Y1tMCHrGV86JOS+fK7tSbKxU0DwAexpqsfcXEWkhPTV9vfUNd1XBJyYH4oCOH0
X-Google-Smtp-Source: AGHT+IFoyTaQnXdPaLai2dhHok1uu5yke3eT/aKrXaUbt+aHtcAOgACJtFffvCzT1E5Z3FpUKLU+6g==
X-Received: by 2002:a05:7022:4191:b0:119:fb9c:4ebb with SMTP id a92af1059eb24-11cbba47b12mr18529414c88.30.1764703900506;
        Tue, 02 Dec 2025 11:31:40 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:eb2b:1140:65a2:dd2e])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-11dcaee7076sm74258741c88.4.2025.12.02.11.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 11:31:39 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-pm@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	linux-kernel@vger.kernel.org,
	cocci@inria.fr,
	Brian Norris <briannorris@chromium.org>
Date: Tue,  2 Dec 2025 11:30:25 -0800
Message-ID: <20251202193129.1411419-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
In-Reply-To: <20251202193129.1411419-1-briannorris@chromium.org>
References: <20251202193129.1411419-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 2/3] PM: runtime: Make pm_runtime_barrier() return
 void
Reply-To: Brian Norris <briannorris@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 3251
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/20251202193129.1411419-2-briannorris%40chromium.org>

No callers check the return code, and that's a good thing. Doing so
would be racy and unhelpful.

Drop the return code entirely, so we don't make anyone think about its
complexities.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 Documentation/power/runtime_pm.rst |  6 ++----
 drivers/base/power/runtime.c       | 14 ++------------
 include/linux/pm_runtime.h         |  4 ++--
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 8246df3cecd7..455b9d135d85 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -443,13 +443,11 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
       necessary to execute the subsystem-level resume callback for the device
       to satisfy that request, otherwise 0 is returned
 
-  `int pm_runtime_barrier(struct device *dev);`
+  `void pm_runtime_barrier(struct device *dev);`
     - check if there's a resume request pending for the device and resume it
       (synchronously) in that case, cancel any other pending runtime PM requests
       regarding it and wait for all runtime PM operations on it in progress to
-      complete; returns 1 if there was a resume request pending and it was
-      necessary to execute the subsystem-level resume callback for the device to
-      satisfy that request, otherwise 0 is returned
+      complete
 
   `void pm_suspend_ignore_children(struct device *dev, bool enable);`
     - set/unset the power.ignore_children flag of the device
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 62707738caa4..84676cc24221 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1467,30 +1467,20 @@ static void __pm_runtime_barrier(struct device *dev)
  * Next, make sure that all pending requests for the device have been flushed
  * from pm_wq and wait for all runtime PM operations involving the device in
  * progress to complete.
- *
- * Return value:
- * 1, if there was a resume request pending and the device had to be woken up,
- * 0, otherwise
  */
-int pm_runtime_barrier(struct device *dev)
+void pm_runtime_barrier(struct device *dev)
 {
-	int retval = 0;
-
 	pm_runtime_get_noresume(dev);
 	spin_lock_irq(&dev->power.lock);
 
 	if (dev->power.request_pending
-	    && dev->power.request == RPM_REQ_RESUME) {
+	    && dev->power.request == RPM_REQ_RESUME)
 		rpm_resume(dev, 0);
-		retval = 1;
-	}
 
 	__pm_runtime_barrier(dev);
 
 	spin_unlock_irq(&dev->power.lock);
 	pm_runtime_put_noidle(dev);
-
-	return retval;
 }
 EXPORT_SYMBOL_GPL(pm_runtime_barrier);
 
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 911d7a4d32c1..41037c513f06 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -76,7 +76,7 @@ extern int pm_runtime_get_if_active(struct device *dev);
 extern int pm_runtime_get_if_in_use(struct device *dev);
 extern int pm_schedule_suspend(struct device *dev, unsigned int delay);
 extern int __pm_runtime_set_status(struct device *dev, unsigned int status);
-extern int pm_runtime_barrier(struct device *dev);
+extern void pm_runtime_barrier(struct device *dev);
 extern bool pm_runtime_block_if_disabled(struct device *dev);
 extern void pm_runtime_unblock(struct device *dev);
 extern void pm_runtime_enable(struct device *dev);
@@ -284,7 +284,7 @@ static inline int pm_runtime_get_if_active(struct device *dev)
 }
 static inline int __pm_runtime_set_status(struct device *dev,
 					    unsigned int status) { return 0; }
-static inline int pm_runtime_barrier(struct device *dev) { return 0; }
+static inline void pm_runtime_barrier(struct device *dev) {}
 static inline bool pm_runtime_block_if_disabled(struct device *dev) { return true; }
 static inline void pm_runtime_unblock(struct device *dev) {}
 static inline void pm_runtime_enable(struct device *dev) {}
-- 
2.52.0.158.g65b55ccf14-goog

