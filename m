Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F95AC531F9
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ULIJ1Xv9cw+GY9oh3jjJe8v9mZ8WuSVlbfwPasElOsE=;
  b=Mr5ZR5Og3mUqCQby4gMnqcevuyG+jHK9tmO3OOkHDcMl36UuuISIuVcO
   Z6asHNQdyyDtdNt58o5uR8zu+VO+LLl0YspcjdNMfpF9MGlM4ePx6dyiR
   puu4VVa8d+Px/kExsxLW+6N76tU8W1Jm6fhD/JEiKMU5mfZmmjKByzzxw
   s=;
X-CSE-ConnectionGUID: YRRXERZXRsCzvixdhBDy3Q==
X-CSE-MsgGUID: IIp/1zXFS6yHXFnJsE2uKA==
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
   d="scan'208";a="287733951"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:33 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 873FC803D8; Fri, 24 Jul 2026 10:54:33 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 19F8D819A4
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:47:08 +0200 (CEST)
X-CSE-ConnectionGUID: W/r1lqf/QwuMr/vd/ODX5w==
X-CSE-MsgGUID: IDOFs+lBTo+SXSPdC2GITg==
IronPort-SDR: 6a6261ab_5jybuxMdRPB+uWJxFPV/t3El0Q0/JsUnaJvk3OWps7znWlx
 8/zmvP9iHiiHmmDNgWFR5r7IQZATeF64GC9Ho/w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HEBABZYGJqgTTYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKHU4pPgT89Ag8BAwELAQFPAgQBAQECBIR+Ao1gAh4HAQQwCQ4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEiGQcOO4ZPDUkBEAEEA?=
 =?us-ascii?q?QGCAQGBJGECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBBQIsXwIBAxIVCwENARsdAQMMBhA7IAIRAQUBHAYBEiKCYIIjAQYQAQM3A?=
 =?us-ascii?q?gG2V4ECQow8FgUCFoEBgg0G2mgKGSgNdYFjAQICBwkBCgEBgTcBhHcqXQOCO?=
 =?us-ascii?q?oUjdYQCeieBGIEQhH6CH4I5hjAEgy6SKgEHBx8SCAEcBggCAkgVEgMEAwQEA?=
 =?us-ascii?q?QILEwkDAwIOAggDAggGGQE/EgQTAggDBgQLBwUfCgIMFAooIhICKQoDIAoLE?=
 =?us-ascii?q?g8DDQYFFQEBBwYCAgMBBAIEDAIJAgIFAwEDAgQGBwMEAQEIAgItAwEDGQgJC?=
 =?us-ascii?q?AILBREYDAsFAgonAw8BCQMfAxQbCEUIBhYBGgcFBgs3FQUMEQECGwIhBB0RC?=
 =?us-ascii?q?AMBGAQCAgIBCwMBAwEVBAgJBAwCEAoSFQMOAwcPAg0HLgsDAg4CCQgMFwICA?=
 =?us-ascii?q?gYCAwMDCgECAQEBAQEBAQgDAwMCAxkHBgMEBAEEBAMDAgMFAQMDAwUCAgoGC?=
 =?us-ascii?q?QEBAQEDAgIIAwcDCgkCBQMbAxwGAQICAwIBAgMGAwcIAw0DBAIDAwMEAQICA?=
 =?us-ascii?q?QEBAgMBAwMEAwEDAwIBAwcCAgMDAwsBAgMDAwUDBQEFAwUCAgMFBQMFAgIKA?=
 =?us-ascii?q?gMDAwIBAwIcAwgDBgMSARADAwYBAwcDBwIEAwgEAwYCAwgDAwIJCAMWBgMDA?=
 =?us-ascii?q?wMFAQICAgMFAwMDCAgEAwMEAgIDDAIGAwMDAgMDBQMDBwIEAgMGAwMDAQMDB?=
 =?us-ascii?q?QECBwIDBwIBCwsIAwIEAgkHCQcBAgMLBAIEBgQNCQQCBAICDwQEBQMDBwEBA?=
 =?us-ascii?q?gECCAUGAwICEQUICgUGAgICHQMhAQMPBgEJBQIBBQ4HBQICChIDBgIDBAUFA?=
 =?us-ascii?q?QMBCgELAQECAwMFBQMDBQcBAgQCBwMDAwQDAwMDAQECAgQGBAMCAwcDAwMDA?=
 =?us-ascii?q?wQDBQUDAgUCBAMFAwcCAwMCAQUKAQQFBAoBAwMDAwUFAwICAwMEAQIEBgMEA?=
 =?us-ascii?q?gMBAggEBgUDAwMFAgMDAgICAwMFAQUCAwMDBAMDAwgHBQMDBQIJAwMJAwMLA?=
 =?us-ascii?q?gIDIQIFAwMDAwYDBwMDBAMDAwcHAgMCAwcDAgUCBwUDAwUDBgEDAgEDAwgLG?=
 =?us-ascii?q?AMLCQgHDAE8DAcKJAQEDCoBBg4UBQQlGWcHBwKNaCOCQAGBDYIpgVEBAQGkT?=
 =?us-ascii?q?qAhSR4JAQYCYIFngQoVCi+bX4V8GjOXU5MZmQgjkXCSR4Q+AgoHBxEkEoEyO?=
 =?us-ascii?q?oFcMxojgQFtgUlQAxkPkiPMFTU1PgEHAgcPAoFzg3aJKoEggSsXLQWBTAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 avLelaw
IronPort-HdrOrdr: A9a23:DsIU/6oMpZKSQs1H/ye0Em0aV5oPeYIsimQD101hICG9vPbo8v
 xG+85rqCMc7Qx6ZJhOo6HmBEDtewK+yXcx2/hoAV7AZnidhILLFvAF0WKK+VSJcE3DH6xmpN
 xdmsBFaeEYZmIK6foSjjPIceoI8Z2o9OSHi47loEuFjjsHV0ij1WpE436gYzRLrcB9a6YEKA
 ==
X-Talos-CUID: 9a23:Arp/j21M4anGEHO3wyXI5LxfJYc/K3nEwjDpPFKdEyF3RPqyZW/N5/Yx
X-Talos-MUID: 9a23:7TvjBwTFMthwq+4GRXTNqBZML4RsyZipS3s9qq0KkJOrFBB/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152815310"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDErIiudgQZrwX4FXMlpCcRcROszlt8MtevgJ3?=
 =?us-ascii?q?6yW9KfYKJuWMQPh+ScC6WKIx4PKc3uhtT+5satWxoMObA0hef8xTnHHF?=
 =?us-ascii?q?B4RmsmmS5PIou4dbelNgwNiNZ2nXuqPZW/CLiVvbmMX6MkkJDVCzRJZW?=
 =?us-ascii?q?CQcezPxX3EZwv6FAClKyH7Uw=3D=3D?=
Received: from mail-pj1-f52.google.com ([209.85.216.52])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:47:08 +0200
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-382ef647e20so1066541a91.1
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832426; x=1785437226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ULIJ1Xv9cw+GY9oh3jjJe8v9mZ8WuSVlbfwPasElOsE=;
        b=itf8htxWC5yKAPd7S8UL19LpZ+qgXsgKXv22vs30JKLcfwSDrYKS2YU8VRJEbbojqb
         mN2rQFdKIpBpMtrgkD9vMq7Rl4XJDu02PuVqz94LusyaamMd2Q9PPqo64lbbOnKQNkKx
         5RzjQULixbgfspH2qbKs3h+HKcC+U1souOivH+zm3iIY98fgrLGbF7q1U8DP1ZWp87fh
         vqQFGctjVPcoa/mM2ipiAZT/exBBFBV9GyJrLmXiTUbC43ClaMca8lzYhjUyTPXn67+B
         p1ZZgRIPcUTUR0v/TQIGns2UNKFX0kA5sIfox+Ic3fcOnrb4C8JYkJxeWwlH+NR9uInN
         Gu0Q==
X-Gm-Message-State: AOJu0YwxYEo1jUxZCwUEtbTpsJYH1kdIUDvNwDdorhyzWO2Z0ncpf80Z
	PsX4xn/ITx1hU5skRkmtgwJWtZJqcW8+6U3vQRm4XL8usofBfGd5EXNU
X-Gm-Gg: AR+sD1188U72a4hvTxwe5nCHrh34//kgHL6Bf2fvPbI1lKqcdgWryWzjBpS9kEprHm8
	+A4BGcD2l1P/eQTlk7diMolJTH3vfbxT5XQQJQ8ZIE6mskneimdNrtZ/qTi5qU1RB9vh/dquSQC
	WfgwH2Zi+g5K9dpiltKxAyuHZ9+5tXI/xy6g/G5DW1CEKo1dV4Azf5fkreotR2EJsV2BYiJBebw
	gg7I/gwKL3yJwhi3RXfRju32pE1kZ1C1TGe0XOjVakbmDCTi+5dlP8eqp1Bmla25WH20SWRhkr/
	LTEPg2lk1NMHr7plBY/un+sF0kP29J+HqfKrpLXYAREum8Fy+sWCwjU2jFjpIeVHN3I/k2IZjhy
	f8OR3+UJXClUbc25IAkYYCdpMhz+HaAKRf/1ovbiRvOP+cj4uTpXJRBvcdTzxbHiXVJi3MpLxuZ
	/trcT9afk=
X-Received: by 2002:a17:90b:518c:b0:38e:b3fd:d582 with SMTP id 98e67ed59e1d1-38ec6657a87mr4132955a91.39.1784832425783;
        Thu, 23 Jul 2026 11:47:05 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:47:05 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Yazen Ghannam <Yazen.Ghannam@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: cocci@inria.fr,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:29 +0900
Message-ID: <20260723184538.3888637-28-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 27/36] RAS/AMD/ATL: remove conditional return with
 no effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3624
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/EmubxFzv-UIdQ5RCwxllfQ>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/ras/amd/atl/map.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/ras/amd/atl/map.c b/drivers/ras/amd/atl/map.c
index 24a05af747d5..4ec9333ef745 100644
--- a/drivers/ras/amd/atl/map.c
+++ b/drivers/ras/amd/atl/map.c
@@ -771,9 +771,5 @@ int get_address_map(struct addr_ctx *ctx)
 
 	dump_address_map(&ctx->map);
 
-	ret = validate_address_map(ctx);
-	if (ret)
-		return ret;
-
-	return ret;
+	return validate_address_map(ctx);
 }
-- 
2.43.0

