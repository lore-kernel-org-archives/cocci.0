Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DF1C53214
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OMO2KRomBUijve5D7xBOqgHhJt3kPIgvFbAoFSgbWN8=;
  b=hUHuxOXvdsqHbXRBp/Nz6H9rRqvsWNYrlU5LHE1TAq/cVhrdvq1+Xi13
   iLkN0W6XvLylHwkC5GTMbYnrSP0SHRCzgWnwGKl+1vMbkrJ66aZHeVMVj
   /qeuMrc9Gg9a3BYLto/HLlhrM4ivGDoUqSJ3EyX1Zo0+KNvhDyM+561Tu
   8=;
X-CSE-ConnectionGUID: NEgrROVgRa2l4zx1rx9KHA==
X-CSE-MsgGUID: RXnOcFDUSL6KeQ71c8Gi1g==
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
   d="scan'208";a="287734278"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:48 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 2709580100; Fri, 24 Jul 2026 10:54:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 4A74D81A33
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:47:39 +0200 (CEST)
X-CSE-ConnectionGUID: NFekftBMQXyEBCJ++HVI8g==
X-CSE-MsgGUID: uJOe+T+5TIiqVd4PHxsSPg==
IronPort-SDR: 6a6261b1_ZOg4aT+m2Q338JdysZ2H1UX4/qz8Fs8arn5OEajV6Z1kBp6
 VNHDskXljSlcdML1ap16WUax09ANjJWW/4wK0/g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ElBQBdYWJqfCvYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKHU4pPgT89Ag8BAwELAQFPAgQBAQECBDgGhEACjWACHgcBBDAJDgECBAMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABASIZBw4SKYZPDUkBE?=
 =?us-ascii?q?AEEAQGCAQGBJGECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBBQIsXwIBAxIgAQ0BGx0BAwwGEDsgAhEBBQEcBgESIoJggiMBBhABA?=
 =?us-ascii?q?zcCAbZKgQJCjFIFAhaBAYINBtpoChkoDXWBYwECAgcJAQoBAYE3AYR3Kl0Dg?=
 =?us-ascii?q?jqFI3WEAnongRiBEIR+gh+COYYwBIMcEpIqAQcHHxIIARwGCAICSBUSAwQDB?=
 =?us-ascii?q?AQBAgsTCQMDAg4CCAMCCAYZAT8SBBMCCAMGBAsHBR8KAgwUCigiEgIpCgMqC?=
 =?us-ascii?q?xIPAw0GBRUBCAYCAgMBBAIEDAIJAgIFAwEDAgQNAwQBAQgCAi0DAQMZCAkIA?=
 =?us-ascii?q?gsFERgMCwUCMQMPAQkDHwMUGwhFCAYWARoHBQYLNxUFDBEBAhsCIQQdEQgDA?=
 =?us-ascii?q?RgEBAIBCwMBAwEVBAgJBAwCEAoSFQMOAwcPAg0HLgsDAg4CCQgMFwICAgYCA?=
 =?us-ascii?q?wMDCgECAQEBAQEBAQgDAwMCAxkHBgMEBAEEBAMDAgMFAQMDAwUCAgoGCQEBA?=
 =?us-ascii?q?QEDAgIIAwcDCgkCBQMbAxwGAQICAwIBAgMGAwcIAw0DBAIDAwMEAQICAQEBA?=
 =?us-ascii?q?gMBAwMEAwEDAwIBAwcCAgMDAwsBAgMDAwUDBQEFAwUCAgMFBQMFAgIKAgMDA?=
 =?us-ascii?q?wIBAwIcAwgDBgMSARADAwYBAwcDBwIEAwgEAwYCAwgDAwIJCAMWBgMDAwMFA?=
 =?us-ascii?q?QICAgMFAwMDCAgEAwMEAgIDDAIGAwMDAgMDBQMDBwIEAgMGAwMDAQMDBQECB?=
 =?us-ascii?q?wIDBwIBCwsIAwIEAgkHCQcBAgMLBAIEBgQNCQQCBAICDwQEBQMDBwEBAgECC?=
 =?us-ascii?q?AUGAwICEQUICgUGAgICHQMhAQMPBgEJBQIBBQ4HBQICChIDBgIDBAUFAQMBC?=
 =?us-ascii?q?gELAQECAwMFBQMDBQcBAgQCBwMDAwQDAwMDAQECAgQGBAMCAwcDAwMDAwQDB?=
 =?us-ascii?q?QUDAgUCBAMFAwcCAwMCAQUKAQQFBAoBAwMDAwUFAwICAwMEAQIEBgMEAgMBA?=
 =?us-ascii?q?ggEBgUDAwMFAgMDAgICAwMFAQUCAwMDBAMDAwgHBQMDBQIJAwMJAwMLAgIDI?=
 =?us-ascii?q?QIFAwMDAwYDBwMDBAMDAwcHAgMCAwcDAgUCBwUDAwUDBgEDAgEDAwgLGAMLC?=
 =?us-ascii?q?QgHDAE8DAcKJAQEDCoBBg4UBQQlGWcHBwKNaCOCQAGBDYIpQIERAQEBpE6gI?=
 =?us-ascii?q?UkeCQEGAmCBZ4EKFQovm1+FfBozl1OTGZkII5FwlwUCCgcHESQSgTI6gVwzG?=
 =?us-ascii?q?iOBAW2BSVADGQ+SI489AbxXNTU9AQEHAgcOAwuBaIN2iSqBIIErSYFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:BtCw1KrkfjrUzRFyZNALgooaV5oPeYIsimQD101hICG9vPbo8v
 xG+85rqCMc7Qx6ZJhOo6HmBEDtewK+yXcx2/hoAV7AZnidhILLFvAF0WKK+VSJcE3DH6xmpN
 xdmsBFaeEYZmIK6foSjjPIceoI8Z2o9OSHi47loEuFjjsHV0ij1WpE436gYzRLrcB9a6YEKA
 ==
X-Talos-CUID: 9a23:eejsSW748y3iSnMnItss0mAZGc45WFjk/Gb9CWSaSiVJdpzFRgrF
X-Talos-MUID: 9a23:j/py8Qs8n8ik4uZmtM2nmRNFOYRUoPmSKUEUr5lag+mULhdINGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152815322"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFmiQSv3ySvQChPV9d9y55blKZAuJu0oslQ8w?=
 =?us-ascii?q?oqHsEIj3N7boch+3uJbqOLPC93snGcWw6kRnLi3nP9F93dzLpFLFQvui?=
 =?us-ascii?q?vVqtMbTRxuBeVZQLgCKGYNK59/1om0GSCSjWDSYG4TfQ1T5yzp/Epd6S?=
 =?us-ascii?q?o5l5pP4fqT0AZ2R8N6ONeARA=3D=3D?=
Received: from mail-pj1-f43.google.com ([209.85.216.43])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:47:14 +0200
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso808473a91.0
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832432; x=1785437232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OMO2KRomBUijve5D7xBOqgHhJt3kPIgvFbAoFSgbWN8=;
        b=bNLpuErq5Zppw+nd5apkBxBajT+lvqGsi6dQ7FAa54qj4Y9N0fLkmw5hJ/EqhvAF9K
         gujlTzGG/hNBhTBtt598nQB8NMkSOSknA1YW2sMt/uL78tg39sC5mxY5RVzZngEffbgH
         MeHynyMEeezmloNixzwopEjhYyyVbVryRP6hgfkwJ8H8dJUmkmFOXhjT6EWxgqjeuSfo
         +kgrJ+7UpLQs8dxasYXggelIhQfh2nZZmu/JYX+IC1MQrcf3bxtjisWh4Fg0knpm1G6+
         CrnxswU7tpFOyr5zokRghgfah6qRRyQvI/o5mOUf4OwYmiXtkCxdZOMxspximbBCwilp
         uTQg==
X-Gm-Message-State: AOJu0YyH07uhHPsnSx8JCgETwgWamGz5QNQEiyVyBZSjrwDLh+O2V+UU
	aZVLDux7HDGFc9orRBEHWqkfr/fyLWrg4cmCVdPFOxJUJ9DBcTNMdnMI
X-Gm-Gg: AR+sD101RPiiEy2NqyMWWem3cXQFcAtaHlL9wrxqH23Dt8S/7BE072Jr7I45fUU+TsD
	K8u4+2wrBMN0nTHDAMPIJ/eBhFA6Aeb8sviROU0QK9pPwz+utA6DVRdBRtomhP6mmxb0PYGpHaK
	SsM44LSUKs655MXf1zgEBSeU4gZWAbFcpC9Dk2NwGnVYoaqy5nVblZZ5FTaxYoA1bOU4vdhL9PP
	elrWcbhaxgDkS2i7t5MdC71Wk1WZYCyMyuLmoD5A54U68llpPse6cgpRdFWJd8wlC50xsNftAtf
	CStV/qUTyAHVK/Yf6SkyH7UJNMk6n1cNd1otoLOefKOZEf+uya17nVOq6GFNLBbzKEgUCmU/azD
	+stbHcMvp4jl5pSgVXQnu73Q8OWfi/q3+FNUf/i5d2aAhGWKHt2hIJdBe69ZHcKedX5Twmeq4
X-Received: by 2002:a17:90b:2ecd:b0:381:9028:5945 with SMTP id 98e67ed59e1d1-38ec64dc738mr4624841a91.14.1784832431870;
        Thu, 23 Jul 2026 11:47:11 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:47:11 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	MPT-FusionLinux.pdl@broadcom.com
Date: Fri, 24 Jul 2026 03:45:32 +0900
Message-ID: <20260723184538.3888637-31-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 30/36] scsi: mpt3sas: remove conditional return with
 no effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3633
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/PCEDI1hSENf1KHjI-QVzfA>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 79052f2accbd..791a3c5fbf44 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -8369,11 +8369,7 @@ _base_make_ioc_operational(struct MPT3SAS_ADAPTER *ioc)
 		return r; /* scan_start and scan_finished support */
 	}
 
-	r = _base_send_port_enable(ioc);
-	if (r)
-		return r;
-
-	return r;
+	return _base_send_port_enable(ioc);
 }
 
 /**
-- 
2.43.0

