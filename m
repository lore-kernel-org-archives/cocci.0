Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A3AC531FC
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vcxLMkMQkwFPgPh32AUwe5n1PBUGwnayfW8DiD3NhNU=;
  b=Ewnna/YAUbGk1eQtgrmS0fXQ0GTJavaxiImG7VEu2txSERQtaUmRxpWj
   eq6gAmg0YRI9M8yyDRDHmbap1v4hRRkqbtAV+txTklG/fytiDgRtEys+z
   SVt8tpjnpWyGArvZPmR63OuqxtfCFLxE4X+x5QCw4ViU0IYWjYvGg+QSE
   Q=;
X-CSE-ConnectionGUID: zVDBQKMAQVaHyNbNhWNtaA==
X-CSE-MsgGUID: AcX9n11nRQWANZf60bRapg==
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
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287733756"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:24 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id D98DA80100; Fri, 24 Jul 2026 10:54:23 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 0366A81964
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:46:55 +0200 (CEST)
X-CSE-ConnectionGUID: L4/534uNSHSMFQu94ZdOLQ==
X-CSE-MsgGUID: FdyexnwbTVyvcYmfaBi6Zw==
IronPort-SDR: 6a62619e_CklXcyeEpUhBbCiKc45BgRuv/fz6hZsg0lKgQ0tggEOgron
 qAxEJwLeKZG7gM5au12X6PxjLshs198hk5Zv/5g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HGBABZYGJqfCnYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKHU4pPgT89Ag8BAwELAQFPAgQBAQECBDiERgKNYAIeBwEEMAkOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDhIphk8NSQEQA?=
 =?us-ascii?q?QQBAYIBAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEFAixfAgEDEhULAQ0BGx0BAwwGEDsgAhEBBQEcBgESIoJggiMBBhABA?=
 =?us-ascii?q?zcCAbZXgQJCjDwWBQIWgQGCDQbaaAoZKA11gWMBAgIHCQEKAQGBNwGEdypdA?=
 =?us-ascii?q?4I6hSN1hAJ6J4EYgRCBFYNpgh+COYYwBIMukioBBwcfEggBHAYIAgJIFRIDB?=
 =?us-ascii?q?AMEBAECCxMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCDBQKKCISAikKA?=
 =?us-ascii?q?yAKCxIPAw0GBRUBAQcGAgIDAQQCBAwCCQICBQMBAwIEBgcDBAEBCAICLQMBA?=
 =?us-ascii?q?xkICQgCCwURGAwLBQIKJwMPAQkDHwMUGwhFCAYWARoHBQYLNxUFDBEBAhsCI?=
 =?us-ascii?q?QQdEQgDARgEAgICAQsDAQMBFQQICQQMAhAKEhUDDgMHDwINBy4LAwIOAgkID?=
 =?us-ascii?q?BcCAgIGAgMDAwoBAgEBAQEBAQEIAwMDAgMZBwYDBAQBBAQDAwIDBQEDAwMFA?=
 =?us-ascii?q?gIKBgkBAQEBAwICCAMHAwoJAgUDGwMcBgECAgMCAQIDBgMHCAMNAwQCAwMDB?=
 =?us-ascii?q?AECAgEBAQIDAQMDBAMBAwMCAQMHAgIDAwMLAQIDAwMFAwUBBQMFAgIDBQUDB?=
 =?us-ascii?q?QICCgIDAwMCAQMCHAMIAwYDEgEQAwMGAQMHAwcCBAMIBAMGAgMIAwMCCQgDF?=
 =?us-ascii?q?gYDAwMDBQECAgIDBQMDAwgIBAMDBAICAwwCBgMDAwIDAwUDAwcCBAIDBgMDA?=
 =?us-ascii?q?wEDAwUBAgcCAwcCAQsLCAMCBAIJBwkHAQIDCwQCBAYEDQkEAgQCAg8EBAUDA?=
 =?us-ascii?q?wcBAQIBAggFBgMCAhEFCAoFBgICAh0DIQEDDwYBCQUCAQUOBwUCAgoSAwYCA?=
 =?us-ascii?q?wQFBQEDAQoBCwEBAgMDBQUDAwUHAQIEAgcDAwMEAwMDAwEBAgIEBgQDAgMHA?=
 =?us-ascii?q?wMDAwMEAwUFAwIFAgQDBQMHAgMDAgEFCgEEBQQKAQMDAwMFBQMCAgMDBAECB?=
 =?us-ascii?q?AYDBAIDAQIIBAYFAwMDBQIDAwICAgMDBQEFAgMDAwQDAwMIBwUDAwUCCQMDC?=
 =?us-ascii?q?QMDCwICAyECBQMDAwMGAwcDAwQDAwMHBwIDAgMHAwIFAgcFAwMFAwYBAwIBA?=
 =?us-ascii?q?wMICxgDCwkIBwwBPAwHCiQEBAwqAQYOFAUEJRlnBwcCjWgjgkABgQ2CKYFRA?=
 =?us-ascii?q?QEBpE6gIUkeCQEGAmCBZ4EKFQovm1+FfBozl1OTGZkII5FwkkeEPgIKBwcRJ?=
 =?us-ascii?q?BKBMjqBXDMaI4EBbYFJUAMZD5IjzBU1NT4BBwIHDwKBc4N2iSqBIIErSYFMA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 weFnmkaEFU=
IronPort-Data: A9a23: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
 E4bn1ew3l0=
IronPort-HdrOrdr: A9a23:VcyeP64bI+1J/dSI+QPXwNvXdLJyesId70hD6qkRc202TiX8ra
 uTdZsgpHvJYVoqOU3I+urwW5VoP0mskKKdiLN5Vd3OYOCBgguVxepZgrcKrQeNJ8SHzIBg6Z
 s=
X-Talos-CUID: 9a23:84cC4G0bR6M2452liUdYXLxfPpxiLyaB0VHrA3SdJ190GeGnRXi0wfYx
X-Talos-MUID: 9a23:QGckvggywlBUmQElBpZC8MMpGst57rSoF0oxr4QYsPiBOyVaOmmvk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="287667002"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDE2lP2Z3SJjlgYmSzrYTmBRJq3cvt4LriFr5/?=
 =?us-ascii?q?IFtwzaEpCkODmT8LrfFBXh5DHqEkqwFKisXQlRGNaNuyO+TB3R5Qjxc4?=
 =?us-ascii?q?L2IDx2YqdViMdDlkDDrrN/tR4I+UgJ7+CBTRJXwsp6lNBSZZO9F25krY?=
 =?us-ascii?q?0GRHuJHjEaYJvfmwQMXyrh0A=3D=3D?=
Received: from mail-pj1-f41.google.com ([209.85.216.41])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:46:54 +0200
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e58034d05so988806a91.2
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832413; x=1785437213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vcxLMkMQkwFPgPh32AUwe5n1PBUGwnayfW8DiD3NhNU=;
        b=Zozp280FGmWerABc1q/hAwDEZZiX60iyfhZufq18Y1vOb4DcWWCwbuhj+NRr7uSvwr
         H703lMIYuN0v9UnLX4IN2k0gqzuBPlb7xLOk55gw3MR/6F2PZ1NKcpaG1Zg99mkeHLRk
         4PsgpvzzTEFrCwha3UIZuuGGPRSDo7nfzJkhfOThQufYbM8L81TMjU6jm2ftQ/AMnjaW
         vRC1gEMp8GuE0S4Mn5iXeasZRallnYvc1VWxgph/GKkJxupt4zSwS+oTbuRE+nYBaEbF
         c1NBmUYRoU/RdJ1V0YP5KqO7Se0BOQ3tsCVAH1rAGjku1Ob9VKdORc/HK7i4VvO6VjIj
         EpEw==
X-Gm-Message-State: AOJu0YwzDfWshk/PvL5VunZpYxeUZDEXSHpXvPMebcqI+jR2Zqm1KHjS
	53bbpMWXF6+x+od4OQBr6gWvO73ejhovVI2RmA+rfV0G/OLQgU2PLSv2
X-Gm-Gg: AR+sD10gtawVvVUP+gk2c92zOEDHHuCu9QzAHunV/6dLUoz1SyDKvpDPKcEn+y1sQag
	TiZqJF0/VYYs2kfWrN5ndfJX1I1hs1YEDjovGhMjFcn42SvU1dw9zjiiX+iNReRxseIfgr/49w1
	rfc4kNYep1M7kMurD7m0Zm/uXsAqkW0lxDjktKZyB7j/vrKtB0tqzTMk/4GvkSz3h+Y1KcnJ//Q
	iDBvjZLeeBIcrIIYWMaeJf7a6rXnQIRHNVYEuLl9NAjtl0/NVRidoYrQVf5VwvhdToGWhpTXo0L
	emrjUakrYIlWcpVfqU/ldMqAfyDrJtSMC8oAE8K+brk5rM8OFxHLP69WHd8hxVfg5vnyY701BoC
	N9zcoKvK5h0OWfvV1j9l50S2ONi4LJqBl9wVqXDVuzKZwe0QdUGVjFmswsfLSugeg47e7oIFq
X-Received: by 2002:a17:90a:e7c5:b0:38e:895f:25fc with SMTP id 98e67ed59e1d1-38ec6a9b239mr3870068a91.38.1784832412757;
        Thu, 23 Jul 2026 11:46:52 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:52 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:23 +0900
Message-ID: <20260723184538.3888637-22-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 21/36] RDMA/ocrdma: remove conditional return with
 no effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3618
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/skKONIKWCLbi0zMElnCeXg>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index cfe3d19b73b3..017b3660173e 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -1749,11 +1749,8 @@ static int ocrdma_copy_srq_uresp(struct ocrdma_dev *dev, struct ocrdma_srq *srq,
 	status = ib_respond_udata(udata, uresp);
 	if (status)
 		return status;
-	status = ocrdma_add_mmap(srq->pd->uctx, uresp.rq_page_addr[0],
-				 uresp.rq_page_size);
-	if (status)
-		return status;
-	return status;
+	return ocrdma_add_mmap(srq->pd->uctx, uresp.rq_page_addr[0],
+			       uresp.rq_page_size);
 }
 
 int ocrdma_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init_attr,
-- 
2.43.0

