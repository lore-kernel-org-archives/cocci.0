Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B22C5DF9D
	for <cocci@archiver.kernel.org>; Mon, 24 Aug 2026 07:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=s3n1DQHzIkJiFiHuoIoWcv0Jg+clLFAjmRBPeTBQ2Ak=;
  b=WmEPtux2PP/Bn0YkdGMc3+9Ibe8d542KnZ7ct3aGq5QR5oHK5qaO2+I2
   d8v5vSwXxelee54tPrnBLPnC7jZqWFrK5HBug85+KdxpJsRQCO795YWOa
   kVZqNi7rGrRu2UERvTC0LV0wR2c/R8umzn/KzC5+XO02OlneKu2XjF4nj
   c=;
X-CSE-ConnectionGUID: WBAL7TjzT6yeuVq9Wt1V8A==
X-CSE-MsgGUID: a7WNHiZCRfWZ1fnFFUrrpQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,240,1779141600"; 
   d="scan'208";a="291207183"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Aug 2026 09:35:19 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 45AA581647; Mon, 24 Aug 2026 09:35:19 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2AFEA805B3
	for <cocci@sympa.inria.fr>; Sun, 23 Aug 2026 18:18:51 +0200 (CEST)
X-CSE-ConnectionGUID: OPiPD4agQLy6ZpcgjfXHNg==
X-CSE-MsgGUID: G6Me3aVITDaWfJMYI6kMUA==
IronPort-SDR: 6a8b1d6a_8FN2w7zjfytcL12JZ9yKTek0RFT0puuHsBXEDJajJU1UxGc
 4m0EZ11KwDvZCpcQ2iFwQ5k7FOlTnMa99emcDJg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GCBQDEHItqfLbSVdFaHgEBCxIMggULAoI/FoFTMwRUl?=
 =?us-ascii?q?QcGim+CGTACh1MDikyBPz0CDwEDAQsBAU8CBAEBAQIEOoREAo1tAh4HAQQwC?=
 =?us-ascii?q?Q4BAgQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEiGQcOE?=
 =?us-ascii?q?imGTw1JARABBAEBggEBgSRhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQUCLF8CAQMyAQ0BGx0BAwwGEDsgAhEBBQEcBgESgwKCI?=
 =?us-ascii?q?wEGEAEDNwIBsU+NBgUCFoEBgg0GgmrYAAoZKA11gWMBAgIHCQEKAQGBNwGEd?=
 =?us-ascii?q?ypdA4I8hSNtCYQCeieBGIEQgRWDaYIfgjmGMASCIoEMk1gBBwcfEggBHAYIA?=
 =?us-ascii?q?gJIFRIDBAMEBAECCxMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCDBQKK?=
 =?us-ascii?q?CISKwoDKgsSDwMNBgUVAQgGAgIEBAIEDAIJAgIFAwQCBA0DBAEBCAICLQMBA?=
 =?us-ascii?q?xkICQgCCwURGAwLBzEDEAkDHwMUHAhFCAYWARoGBQYLNxUFDBEBAhsCIAQdE?=
 =?us-ascii?q?QgDARsEAgEJAwEDARUEAhQKHQIGCAwXAgICBgIDAwMKAQIIAwMDAgMZBwYDB?=
 =?us-ascii?q?AQBBAQDAwIDBQEDAwMFAgIKBgkBAQEBAwICCAMHAwoJAgUDGwMbBQECAgMCA?=
 =?us-ascii?q?QIIAwcIAw0DBAIDAwMEAQICAQEBAgMBAwMEAwEDAwIBAwcCAgMDAwsBAgMDB?=
 =?us-ascii?q?QMDBQUCAgUFAwUCAgoCAwMDAgEDAhwIAwYDEgEQAwMGAQMHAwcCBAMJAggDA?=
 =?us-ascii?q?wgIAxcDAwUBAgIEAwMICAQDAwQCAgMMBQMCAwMFAwMHAgQCBAMDAQUBAgcCA?=
 =?us-ascii?q?wcCARgDAgQIBwcFAgsEAggEDQkEAgQCAg8EBgMDBwEBAgEHBQYDAgIQAQgKB?=
 =?us-ascii?q?QYCAgIcAx0BAw8GAQkFAgEFDgcFAgIYAwYCAwYFAQMBCgsBAQIDCgECBAIFA?=
 =?us-ascii?q?wMBAwIDAgYDAwIFBQUDCQcFDgkBAwMGBQICAwIDAQIIBAYFAwICAwUBBAMEA?=
 =?us-ascii?q?woDAggDAwgDCwIaAgUDAwMGCQMHBwIDBwMCBQIHBQMDBQMGAQMCAQMDCAsVJ?=
 =?us-ascii?q?QMBBQMDAgEDAgUDAxgCAgQFAwMDAwMDCAQCAgEHBgQCAgIBBQUFBAUGAgQDC?=
 =?us-ascii?q?AEBBQMDCg0BAgcMAwwGAwcDAwQEAwIFDAICBAEHBgcHCQcDAgMIAQELBAEDA?=
 =?us-ascii?q?woDAwUCAQEHBQMGAwcCAwMDBQQFAwILAwcCAgMDAwIpAQEBAwMDAwMEAwEDA?=
 =?us-ascii?q?QMDBwMFAwIOAggBBAkDAgYDBwYDBAsJCAcMATwMBwokBAQMKgEUFAUEJRlnB?=
 =?us-ascii?q?wcCjl0fgk2BDhSDZgEBAaROi3uUJkkeCQEGAmGBZ4EKFQovm2CFfBozhASTT?=
 =?us-ascii?q?5MZLphaI4I2jzqSR4Q+AgoHBxEkEoEyOoFcMxojgQFtgUlQAxkPjiGEAswoN?=
 =?us-ascii?q?TU9AgcCBw4DC4VeiSqBIIErSYFMAQE?=
IronPort-PHdr: A9a23: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
 ZGppnNEnQlkaYxsTUQ1DKVMx1lUwKmJu33wvt0=
IronPort-Data: A9a23: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
 bMbilZhO1yr50E=
IronPort-HdrOrdr: A9a23:eTrgy6nVNeI0mnbGj9AYDlhMvyLpDfP7imdD5ihNYBxZY6Wkfu
 SV7YUmPH7P+UgssR4b6Ku90cO7IU80maQFm7X409+ZLUvbUEXBFvAs0WLJ+UyrJ8XGntQtmZ
 uJmcBFeZPNJH17l9u/3DKceuxQjeVviZrYxNs2rE0dMj2CCZsQkztRLAOXVmBVZC0DP5o2E5
 KA+tFKzgDQAEg/SMG3QkIIQvTZoJnznI/mCCRqO/d90njPsduogISKYSRwty12O1g/osZHgA
 +19X2A2kzEiYDP9vdrulWjqqi/YrPau5J+LfeBkMQTN3HJhhyzbIpsH52u1QpF1t2H01oxnN
 7Q5y0tOMl+8BrqDyKISHDWqnrdOVgVmgLf4G7dqX/qvsziAAgiA84Ev59QbwfCgnBQ2e1U4e
 Zn02mYv50/N2KxoMzCjeK4HC1Cpw6RqXommugDy1leVod2UtVshL1a2EtUFZcGEmbe6Jo7ed
 MeRP00icw2TXqqK0vS+lN3yNjEZAVFIj62BnMJ/vOUyCRN9UoJu3fw3PZyop4bzv0Aood/id
 gs7Z4Y9o1zcg==
X-Talos-CUID: 9a23:OwOug23NlASurzdmLD/ESLxfPfgkSlGBxXjpB17mO35iR7+beX+29/Yx
X-Talos-MUID: 9a23:xnapQgSAwOfM19vXRXTD2hRvb85WwpiCAX8Ds7A3mpeHEBFZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,239,1779141600"; 
   d="scan'208";a="291143719"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFVhcsDujAXKwn0s4NXC7b1ZvPwTzoIxepgYr?=
 =?us-ascii?q?xEOiQKlbjmCKaMexcyTQrbUFAcQX3Qo5Ha58YuItPFa/tfs3I4QZOo3E?=
 =?us-ascii?q?KTXbzrUbrsAEdQuYCcaoi1iYRaaYFTa8QqD7Of87Syj06FVZqEobqYdP?=
 =?us-ascii?q?wMRZXlUJlLWofrJZjOo7+F4A=3D=3D?=
Received: from mail-pf1-f182.google.com ([209.85.210.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 18:18:50 +0200
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84f77cc7302so870602b3a.3
        for <cocci@inria.fr>; Sun, 23 Aug 2026 09:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787501929; x=1788106729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s3n1DQHzIkJiFiHuoIoWcv0Jg+clLFAjmRBPeTBQ2Ak=;
        b=ohj0osYzx7pH/hi4kysZdWiLTiib/0vYlBFT7cdibRiChNj2tvxDQbp+AtERDn6Pcy
         AprJlb9WeHIxcc0o3eIUUNpcTa+mWrbyfkLHcQQDJBO7cr5VTyHvb+kQanJe0yHC1dd9
         SZspNPcQo5G2qOH1Co8TcNNIgf4V9iHpl2WWSXJ5nSwlKrQwXTHU2ifHYJ5kUN03zsLP
         AyFvNDczAA6RlSRiyKcl1NQeaPH0NDvErpOJk4KD80QcFjlXBokiPPubf0vg7G7biYc5
         7GDa1GbyjOxi/h2sPrYVRMogmxyzZ6m7FWI8HTTszpoC5UzujEv1ikNx7y78TGmvmZ+y
         N0Ag==
X-Gm-Message-State: AFuF++n4gxTwTGS16gUN/Klmj9uGA3bAxNQZpSXhWqDu2XYAlEotrL7v
	9XFoLJfT+xeON2NUY+YCpGBSZW527YGnEF4ToGh18TEqpszO6KCcXfC1
X-Gm-Gg: AR+sD123NlhdjdbpdNGIuOt9ZcqsUhSVoiboSaupETrSVznX6xKKbrQZ/OKoqGcxQTg
	wpzlVYHW95++zfbNDh1n/XWMruRep3a4pnmA5cTnRq5RsLqieRUnOWILMJAbrMO/WMwbUyC38ta
	Cmbaxpdja515lx4bMr8vUOcvOcKIBkEZ34rpXs5nOgx1AKsQkjTVs+BWSdXp1eHp603ue3XUryF
	i0h2NkAFK5jFXELtjSUbk06A1VF/ZuXpHteb9AFvYadJhJeAnGcHqK85uONvyaXM+cZcI4634Ab
	tetY0nihMnUkHXHx1Iztqw9UNEnNk6AX9nFyCmDZqq3mfxmysWF+XfiiLVysZT64XPBYx9bwHvI
	520MG6TqdAaT/yO3tQq5oFqUusFbJik4hePd8mJzi5zXsB5AjANhM5GLv5f7JRw1z+njbjLh2st
	ZhpiXRb+rhxUC2moCtesFMq9yge1LnYKGA0d4VT/8VvxZcEhvRSDA0r8iAbqpCwDGQI60=
X-Received: by 2002:a05:6a00:3a1f:b0:845:31a6:d84d with SMTP id d2e1a72fcca58-851f9a9aa4emr30843313b3a.7.1787501929045;
        Sun, 23 Aug 2026 09:18:49 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199dafa1fsm350181a12.3.2026.08.23.09.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 09:18:48 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org
Date: Mon, 24 Aug 2026 01:18:19 +0900
Message-ID: <20260823161826.3805598-8-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823161826.3805598-1-ekffu200098@gmail.com>
References: <20260823161826.3805598-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 7/7] coccinelle: ifnulldev_put: update outdated
 helper names
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3706
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/1R1uWAarT0sBeXhqWWxUCA>

dev_put_track() and dev_hold_track() were renamed to netdev_put() and
netdev_hold() by commit d62607c3fe45 ("net: rename reference+tracking
helpers").

So update the names.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 scripts/coccinelle/free/ifnulldev_put.cocci | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/coccinelle/free/ifnulldev_put.cocci b/scripts/coccinelle/free/ifnulldev_put.cocci
index 2bd2e8fae485..adb08252f98d 100644
--- a/scripts/coccinelle/free/ifnulldev_put.cocci
+++ b/scripts/coccinelle/free/ifnulldev_put.cocci
@@ -23,13 +23,13 @@ expression E;
 |
   dev_put(E);
 |
-  dev_put_track(E, ...);
+  netdev_put(E, ...);
 |
   __dev_hold(E);
 |
   dev_hold(E);
 |
-  dev_hold_track(E, ...);
+  netdev_hold(E, ...);
 )
 
 @r depends on context || report || org @
@@ -38,8 +38,8 @@ position p;
 @@
 
 * if (E != NULL)
-*	\(__dev_put@p\|dev_put@p\|dev_put_track@p\|__dev_hold@p\|dev_hold@p\|
-*         dev_hold_track@p\)(E, ...);
+*	\(__dev_put@p\|dev_put@p\|netdev_put@p\|__dev_hold@p\|dev_hold@p\|
+*         netdev_hold@p\)(E, ...);
 
 @script:python depends on org@
 p << r.p;
-- 
2.43.0

