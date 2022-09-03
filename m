Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391E7ECAAD4
	for <cocci@archiver.kernel.org>; Sat,  3 Sep 2022 09:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ZME0HW9Num78e+JglFQzbQufETlfaktBo0/64FaO2ZA=;
  b=giBSEWojvNJ9Kuln/c7SoiXJhXpMuLuhJWzCPArxIWiFMVbrL1w0dJ4A
   uMf6jW+rrJyLw3JK1hvO0fXIY7KHl7zwXg+9Ry/sNcBBLvQGePK+aoemp
   QUczocWPbCKp+cpRI/zXm+gfhBfVlIp1graPP9pwqyYXz03mkn84Vn/uE
   Y=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.93,287,1654552800"; 
   d="scan'208";a="51140898"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Sep 2022 11:39:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DBE20E7799; Sat,  3 Sep 2022 11:39:19 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0B6DEE7799
	for <cocci@sympa.inria.fr>; Sat,  3 Sep 2022 11:39:16 +0200 (CEST)
IronPort-SDR: 7naKD+txg8Y4487JH6sVkGBWDe2xXtZI7Wpf/3Py2vUK0ZdFfq2t2CNUYfnYr8lpeptIONvFPa
 MRdP8M/kp+OSDwLbtkox04pbfj5ccUbMd1Wb1pK+6Jt9mdkCyUYIwoND3f8+JqeW7s0u58GWmR
 Z4Ltkmypljq1wgEsBeQ+/7nDAAPnfwCSF2YM0juZcJHFTKvuxnQVfGt2PPafs6QgxPA0S02yWJ
 kaR2eh87PXTNzAvgpTDQ55/SedGe+ztr/GZ2ET3J4ZJ/Fq5IS/YwVD6jDG3LBKLwrHz+pHshhy
 6WFADguyezmywiSB63nMcWab
X-IPAS-Result: =?us-ascii?q?A0DSBgDfHxNjfzHaVdFagQmBT4IkgQFWLgRQhE6IfogSn?=
 =?us-ascii?q?RyBaAsBAwELAQE5BwIEAQE+AYQCRQKEZAIdBwEEMwYOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQMBAQUBAQECAQECBAQBEwEBGAkZBw4OBWABYQMBRIFPgXQLAzENgjUig?=
 =?us-ascii?q?2wCAQMSEQQLAQ0BGx0BAwwGEA8CERUCAiECEQEFARwZIoJbAYJsAQMwAwQMn?=
 =?us-ascii?q?jCBBEKLMn8WBReBAYIJBoFBAYEfgW4KGSgNZwOBWQIBBgkBCH8thnuDcIQ4e?=
 =?us-ascii?q?iccgUlEglGBPoMOQgKBGVwqgxeCZQSDbByOMIRtBAUUDwMDAiADCQQHBSweA?=
 =?us-ascii?q?gkDIxEDCxAIBw0BFikGBQEBDAIBBAEFAwEEBQMHAgEFBgIJAwMJAwEBBQEDB?=
 =?us-ascii?q?AMDAwIHAwECDAQIAwMCAwQCAgICAQMCBwUIBAIHAgICAQICBgIBAwkBAgMFA?=
 =?us-ascii?q?gIJCwEEAgIDAQMBAQIIBAkEAgMEAgEBAwIBAgIBBQIOBQEBAQECBQECAwEGB?=
 =?us-ascii?q?wIIAg4OCgEDAwMCAgUCAgECAwINAQEEAgECAQIGAQMBAgIDAQMBAgIDAgYJA?=
 =?us-ascii?q?gQBBQMDAgIDAQEFDgUCBAIBAgYFAgEBAQQBAwQEBgICAQMDAg4CBAEEAQIBA?=
 =?us-ascii?q?SMDBAIDAQMXAQIBAgMDAwQGBwUCAQITAQIBAQEFAQIBAQMEBAcJAwICBAMDB?=
 =?us-ascii?q?QEBAgMCAQEBBwwCAgISAhMDAQYBDgUUAwIEAgIBAgIKAwECAgEDAgkCAQIBB?=
 =?us-ascii?q?SADAQEPJAEBAgICAgMEBwIBBAYDDQICAQEBBQYNAwIDCAEMAgcDAgEDBQICB?=
 =?us-ascii?q?AECBAoJAQICAQIEBQcCAQgGBQ0FCQsBAQIBAwcEAxECBQMFBQMDAgEGBAUCA?=
 =?us-ascii?q?wECAQEDBAEDBAYBAQIDAgIBBgICAQEDAwQDAQIGAgIHAgMCAQQCAwMBAQEEA?=
 =?us-ascii?q?gICAgIDAwgDAggHBQEGAQIBBAMCAgECBwEEAQgCAQMDBQMEAQoPAwUDAQMDA?=
 =?us-ascii?q?hQKBQEDCAYJAgQFAgUDAgQCAwMCAggDAgQDAgsDBQQCBxMHAgMCAgUCAgICA?=
 =?us-ascii?q?gUEAwECAgICAgIFAgQCAQUBAgIBAgICBAECAgcEAgMBAwQOBAMCAgcBAgIBB?=
 =?us-ascii?q?gIHAwECAQQDAQEEAgQBAgUCBAEDAQIGAgQDCgIDAgICBggDAwwJAgMFAgQBA?=
 =?us-ascii?q?QIHBAICCwEGAgcCAgMQAQMCAQQFBQMDAwkCAgMCBAICCgEBAQECAgEFBQIEB?=
 =?us-ascii?q?w8CAgIEAgICAQMCAgEBAgIFBAkSAQECAwYEBgUDAggYAQYCAgEBAgIDAwIGA?=
 =?us-ascii?q?gECCAIEAQQFAgECAgICBAEDBgIDAQECAQICAwMCAwIEAwMBAgECAgIDAgICA?=
 =?us-ascii?q?wICARACBgYBAgICAgICAgIBAgEFAQIBAgQCBwIEAwIBAgIFAgICAwEBBgIEC?=
 =?us-ascii?q?wEDAgcGAQMCBwUCAwEEAwQDAwUGBQwIAQUBAwEhAwICCAIHAgEGBQEPAwICA?=
 =?us-ascii?q?wICAQQKAgMFAgQCAQQJBwIEAQIJAwMGAgcFGAECAgcEDAoCAgIFBgIEAQECA?=
 =?us-ascii?q?wECAgECAwQCAwIEBQEFAgECBQQCAgEBAgUCDAECAQcGAgcDAgICAwEEAgECA?=
 =?us-ascii?q?QMDAgMBAQEDBgYFBgQCAwMGAgICBgICAwISAwkCBgMCBAENDgUEBwgBAgEBA?=
 =?us-ascii?q?gcCBAIHCQIOAgEGAQcCAgMCAgECAQICAQYEBwEDAgICAgICBQgFAwQFAgNNl?=
 =?us-ascii?q?XKCD4EOASsigX1WkiODDYskn3tuYYJ7iy2Od4VqGjKWZpIQlweNOYNjkRBlh?=
 =?us-ascii?q?CcCCgcGECMSgUIkgVtNIxU7MYI2TgECAQEBDQECAQEDAQIBAgkBAQKOKAEWg?=
 =?us-ascii?q?1CBPokiPzQLMAIGAQoBAQMJhUaFDAEB?=
IronPort-PHdr: A9a23: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
 9yJn6X2em4qzg==
IronPort-Data: A9a23:OwgJ261/0PHaei7h5vbD5ch3kn2cJEfYwER7XKvMYLTBsI5bpzNRn
 GdKDW/XOv7eYmrxKN12O4vloEkE7J7Uy4BjGwZs3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOHNIQMcacUsxLbVYMpBwJ1FQywIbVvqYy2YLjW1LV4
 ouoyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt4lg4
 tdTv4yqdRZ3boLrydomeCZHAj4raMWq+JefSZS+mcmazkmDfnm1hvsyXQc5OooX/usxCmZLn
 RAaAGpVP1bT2qTsmeL9FrgEascLdKEHOKsdpnZiyzjDJfkjSJHHBa7N4Le02R9t35kSRaaBN
 qL1bxJ9QwjcYFp0MG1HEZUTm6Stpn38bwZx/Qf9Sa0fujCPlmSdyoPFO93ecd2iXtRQhk/ep
 2Tc/m2/DAtyCTCE4T+M83bpi+2W2C2nCcQdE7q38vMsi1qWroAONPEIfQKqi/ungF6kZ8MBe
 2MzqxQVhpct5VP+G7ERQCaEiHKDuxcdXf9ZHOs79ByBx8LoD+CxVjhsotlpOIxOiSMmedA5/
 gTWwI6xVFSDpJXQGC3NrO7Fxd+nEXFNdTdqWMMScecSDzDeTGwbixvOSpNuEvfwgIGkXz73x
 D+OoW41gLB7YS83O0eTrAivb9GE/MChousJCuP/ADzNAuRROtPNWmBQwQKHhcus1a7AJrV7g
 FAKmtKF8McFBoyXmSqGTY0lRe/3va/Za2GG3wU/QvHNEghBHVbzLei8BxkudC9U3josJFcFn
 WeI5FsJvMILVJdURfYuO9/oYyjV8UQQPY29Cqq8gitmbZ92ewuKlByClmbBt10BZHMEyPllU
 b/CKZjEJS9DVcxPkWTrL89AjudD7n5kmQv7G8ugpzz5iur2WZJgYe1aWLd4Rrtpsv3sTcS82
 4o3CvZmPD0FC7egO3OMrdFDRb3IRFBiba3LRwVsXrbrCmJb9KsJUpc9GJstJN5ombp7jODN8
 i3vU0NU0gutinjOKAHMYXdmMeu9UZF6pHM9HCotIVf4gyh5MdjztP8SJ8ktYL0q1O1/1vorH
 fQIfsO3BP4QGDnK/jIqa4bw8d55fxOxiAPSZCeoOWBtf5NpSwHT1MXjew/jqHsHAiat5Jkxp
 rSh0kXQRp9aH1ZuC8PfafSOyVKtvChFyLgiAReQetQKIRfi6olnLSD1n8QbGcBUJEWR3Cae2
 iaXHQwc+rvAroozx9/D2vKJooKvJO1hRxYIEmTe64G2AinU5G+Ux4FNDbSTdjfHWWKooaiva
 LkHz/z4N/Fbzl9Gv5AmSORuxKM6otbt/vpUklUiE3LMYFCmTLhnJyDej8VIs6RMwJ5fuBe3C
 h3ToIgEYe3RNZO3CkMVKSokcv+HiaMelA7U4KlnO079/iJ2oOeKXBkAJRWKkyABfrJ5PJl/m
 rUksc8SrgG9018kbofAgSdT+GCBaHcHVvx/5J0dBYbqjCsty01DMcOAUH6ouMnXZoUeKFQuL
 x+VmLHG2+ZWyH3EfidhDnPKx+dc2ckDtR0iIIXu/LhVdgcpR8Pb3SG9NRwyRwVRixhFiqd9Z
 jktOEpyKqGDuTxvgaCvmoxq9x5pXHWkFo7ZkjPlV1E1i2GnU2XMKCs2PuPlEIUx7TdHZjYCl
 F2H4D+NbNspFf0dGgM9XEdkr7roStkZGsguXiy4N5ztIqTWqgYJTkNjiaTkZvcn7Q4MaJX7m
 NRX
IronPort-HdrOrdr: A9a23:IR3w8apgmJ9k86W4dGwo4gYaV5oIeYIsimQD101hICG9vPbo8v
 xG+85rqSMc6QxhJU3I/OrrBEDuewK6yXcY2/hzAV7mZnifhILKFvAZ0WKd+UyHJ8SWzIc0vs
 ddmupFeabN5DBB7PoSizPId+rIruP3kpxARt2z856ud2xXgm1bgDuRcjzra3GejTMpOaYE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,287,1654552800"; 
   d="scan'208";a="51140879"
X-MGA-submission: =?us-ascii?q?MDGzjPk9mtMLteUH4irWKNIFz5hziq3B2FP0HA?=
 =?us-ascii?q?qJjtZ1xdg+vTIXVgicUA4jUl0RwXqrDf7nItPj2jqGCSxdh50plrUV9X?=
 =?us-ascii?q?3uMSrngBaWy8T6fKa6cY6Z58PvQJ+AKtzkIAM0ywUTBG53Ns9g/QZ3uR?=
 =?us-ascii?q?Vjpo6EZ6O/bKr9ZSahEI/+sA=3D=3D?=
Received: from mail-ej1-f49.google.com ([209.85.218.49])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 11:39:16 +0200
Received: by mail-ej1-f49.google.com with SMTP id y3so8137115ejc.1
        for <cocci@inria.fr>; Sat, 03 Sep 2022 02:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ZME0HW9Num78e+JglFQzbQufETlfaktBo0/64FaO2ZA=;
        b=U1zN6FBdWfEYmMf6ZKr8FiMNF6YMclwQHBjsmQLMQLs4UHz4uLxcFW74zHmUqft+Ja
         IN+sgoK2X1htZn2XLq/CBVbmlTwN5e8dMFwxvg9dMx0tpoAjcuTOP9N7gerUaldDAcqr
         4inl9APfhx2l0qlrY/1se/0hGeGw1kezCNNGSM6Ek+Wt8DJJFhBpR2nDcd4CY29ThBUR
         4iHYjjaYdIim5jpLS+qIgfq22j62Ns+PAbJ3x+s6DY8ScTdBoY2UrsolLtoSu2ziL5wm
         I1XwSkUy5oM1iIQZ5IxC+/94iXzNDvk/fvLr6lHPj0BCtP9KODyqHUhSa274CyvtYLN5
         z+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZME0HW9Num78e+JglFQzbQufETlfaktBo0/64FaO2ZA=;
        b=AAJC49paZIH+yW7yi3ThGaSKvvnMS/qg/5avXVn+yn2mPUnqziwfY4Quc/R4+kCw5E
         XpmcgPiB+5R3+Lw4uy28BpNQcG2uaZbHtR48IyT3zD3hyRPR47i4gLnqz81eJfv0Is4G
         VDokDGiCKRPghQoZmRsTDzGKMU/Or52xb6bHxOHwfT876GtD5LMR/sifJMJ9XpRsutaB
         F+oK38kv+DNQqrPRGZrFlNuSmcxYdPAPCSTyoixpmyCQOQjxNB83SlDwebvOov4MgZko
         B5LmPat7yMBCErPDC2x6+wDSZIODmn7Lw7xuvBl6kgyVlqdd45ZJ2pdBI8z3/NQkY/8u
         /K5w==
X-Gm-Message-State: ACgBeo3MrwENYqbn44ni1vVROC0i1jq4+t3P+Si908UkQrfGlj8NY/IZ
	cApgEPrA8UkKtuvurFr/KhnOGH4+NDw=
X-Google-Smtp-Source: AA6agR6yDzoRadthtbUAIdGutOhN7AHlsq5YfZfQH3Wm8uvNQfeyJ2bDcJ7vu6DPdo8NI2cf8Phvfw==
X-Received: by 2002:a17:907:2c4f:b0:741:5b68:e2d9 with SMTP id hf15-20020a1709072c4f00b007415b68e2d9mr21546850ejc.314.1662197954984;
        Sat, 03 Sep 2022 02:39:14 -0700 (PDT)
Received: from theo.localdomain (ip-89-177-215-237.bb.vodafone.cz. [89.177.215.237])
        by smtp.gmail.com with ESMTPSA id p2-20020a170906b20200b00734bfab4d64sm2350389ejz.25.2022.09.03.02.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 02:39:14 -0700 (PDT)
From: Jan Tojnar <jtojnar@gmail.com>
To: cocci@inria.fr
Cc: Jan Tojnar <jtojnar@gmail.com>
Date: Sat,  3 Sep 2022 11:38:43 +0200
Message-Id: <20220903093843.2579539-2-jtojnar@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220903093843.2579539-1-jtojnar@gmail.com>
References: <20220903093843.2579539-1-jtojnar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH 2/2] Distinguish script-based fresh ids with
 differing args
Reply-To: Jan Tojnar <jtojnar@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 535
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/20220903093843.2579539-2-jtojnar%40gmail.com>

https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/f4db03ee748c13d7661e5048c355863466def08b
started memoizing the fresh identifiers generated by scripts to keep them
consistent across different rules. But it did not account for the script
producing a different result depending on the values of inherited
metavariables passed to it as explicit arguments.

Let’s memoize the script results in a hash map,
one fresh name per each different argument list.

Fixes: https://github.com/coccinelle/coccinelle/issues/283

Signed-off-by: Jan Tojnar <jtojnar@gmail.com>
---
 engine/postprocess_transinfo.ml | 67 ++++++++++++++++++---------------
 tests/id4.c                     |  5 +++
 tests/id4.cocci                 | 23 +++++++++++
 tests/id4.res                   |  5 +++
 4 files changed, 70 insertions(+), 30 deletions(-)
 create mode 100644 tests/id4.c
 create mode 100644 tests/id4.cocci
 create mode 100644 tests/id4.res

diff --git a/engine/postprocess_transinfo.ml b/engine/postprocess_transinfo.ml
index 2a00b797..e226fb13 100644
--- a/engine/postprocess_transinfo.ml
+++ b/engine/postprocess_transinfo.ml
@@ -15,6 +15,14 @@ how we reached a particular match *)
 
 module Ast = Ast_cocci
 
+module ParamsType =
+  struct
+    type t = Ast_c.metavars_binding
+    let compare = Stdlib.compare
+  end
+
+module ParamsMap = Map.Make(ParamsType)
+
 let extra_counter = ref 0
 
 let reset_fresh_counter () = extra_counter := 0
@@ -89,38 +97,37 @@ let process_tree inherited_env l =
                    seed in
                string2val(String.concat "" strings))
         | ((r, n) as fresh, Ast.ScriptSeed(name, lang, params, pos, body)) ->
-            let res = ref None in
+            let res = ref ParamsMap.empty in
             let make_fresh_id env =
-              match !res with
+              let args =
+                List.map
+                  (fun (((rule, name) as meta_name), _) ->
+                    try match List.assoc meta_name env with
+                    | Lib_engine.NormalMetaVal v -> (meta_name, v)
+                    | _ ->
+                        failwith
+                          (Printf.sprintf
+                             "Undesired metavar_binding in line %d"
+                             (snd pos))
+                    with
+                    | Not_found ->
+                        let get_meta_names l =
+                          List.map
+                            (fun (mn, _) -> Ast.string_of_meta_name mn)
+                            l in
+                        let string_of_list l =
+                          "[" ^ String.concat "; " l ^ "]" in
+                        failwith
+                          (Printf.sprintf
+                             "%s: script on variable %s cannot be evaluated in line %d. available: %s\nwanted: %s"
+                             r n (snd pos)
+                             (string_of_list (get_meta_names env))
+                             (string_of_list (get_meta_names params)))
+                          )
+                  params in
+              match ParamsMap.find_opt args !res with
                 Some x -> x
               | None ->
-                  let args =
-                    List.map
-                      (fun (((rule, name) as meta_name), _) ->
-                        try match List.assoc meta_name env with
-                        | Lib_engine.NormalMetaVal v -> (meta_name, v)
-                        | _ ->
-                            failwith
-                              (Printf.sprintf
-                                 "Undesired metavar_binding in line %d"
-                                 (snd pos))
-                        with
-                        | Not_found ->
-                            let get_meta_names l =
-                              List.map
-                                (fun (mn, _) -> Ast.string_of_meta_name mn)
-                                l in
-                            let string_of_list l =
-                              "[" ^ String.concat "; " l ^ "]" in
-                            failwith
-                              (Printf.sprintf
-                                 "%s: script on variable %s cannot be evaluated in line %d. available: %s\nwanted: %s"
-                                 r n (snd pos)
-                                 (string_of_list (get_meta_names env))
-                                 (string_of_list (get_meta_names params)))
-                              )
-                      params in
-                  let args = (fresh, Ast_c.MetaIdVal n)::args in
                   let fresh_id =
                     match lang with
                     | "ocaml" ->
@@ -130,7 +137,7 @@ let process_tree inherited_env l =
                         failwith
                           "languages other than ocaml or python not supported" in
                   let r = string2val fresh_id in
-                  res := Some r;
+                  res := ParamsMap.add args r !res;
                   r in
             (fresh, make_fresh_id)
       )
diff --git a/tests/id4.c b/tests/id4.c
new file mode 100644
index 00000000..bb5f99e3
--- /dev/null
+++ b/tests/id4.c
@@ -0,0 +1,5 @@
+void foo() {
+    Foo *widget;
+    widget->window;
+    widget->parent;
+}
diff --git a/tests/id4.cocci b/tests/id4.cocci
new file mode 100644
index 00000000..2619f09e
--- /dev/null
+++ b/tests/id4.cocci
@@ -0,0 +1,23 @@
+@initialize:python@
+@@
+
+def make_prefix_from_type(type_name):
+    # Get just the type name without surrounding whitespace or pointer asterisk.
+    return type_name.strip().strip("*").strip()
+
+def make_getter_name(prefix, member_name):
+    return prefix + "_get_" + member_name
+
+@r1@
+// Getter on declared variables
+type type_name;
+identifier object_var;
+identifier member_name;
+fresh identifier getter_name = script:python(type_name, member_name) { make_getter_name(make_prefix_from_type(type_name), member_name) };
+@@
+
+type_name object_var;
+<...
+-object_var->member_name
++getter_name(object_var)
+...>
diff --git a/tests/id4.res b/tests/id4.res
new file mode 100644
index 00000000..f529a4d6
--- /dev/null
+++ b/tests/id4.res
@@ -0,0 +1,5 @@
+void foo() {
+    Foo *widget;
+    Foo_get_window(widget);
+    Foo_get_parent(widget);
+}
-- 
2.37.2

