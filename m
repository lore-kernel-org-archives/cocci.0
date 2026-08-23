Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D303C61CE2
	for <cocci@archiver.kernel.org>; Mon, 24 Aug 2026 07:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=UoBB3bNXIiZjntcTBcSPE8cc8h15Gliv3FpuekqaQQg=;
  b=lEHImarH4yqHhakYlY3RAuLWFWJUwpC6UNiCC4xOH0pDoXhkiQka2hcw
   HZoGhtOPA5orMC2B49KhU/YoBWgLnxeh2PW8Zx4OQcmr5ufmSfvrQ9e/Z
   1W8vdcqxIP9gwMA7hCoGPm4UgZ1VSm2tgmQzceJ3W/R/fzBJ1+bIswyYV
   k=;
X-CSE-ConnectionGUID: cmu+b6MGQbacVCVWibtrVw==
X-CSE-MsgGUID: pxlK6QUKRgCqj2XsFYDecg==
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
   d="scan'208";a="291207218"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Aug 2026 09:35:20 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id BB75F81646; Mon, 24 Aug 2026 09:35:20 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 8DF4D805B3
	for <cocci@sympa.inria.fr>; Sun, 23 Aug 2026 18:19:17 +0200 (CEST)
X-CSE-ConnectionGUID: TNNnMHKJQoWLhXBXNPrgxw==
X-CSE-MsgGUID: qUJYG+IlR2K0xF6fYEugbQ==
IronPort-SDR: 6a8b1d69_5jqSFx8zhQ9vfCRIvWzeXQrEbGeOtCKvq/HTZF/1nFdvzPi
 RIKJWI62tLVqBWkDYe/FTbG/RzOBFWqngLJ0eLw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ElBwBAHYtqga3SVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKHUwOEboVegT89Ag8BAwELAQFPAgQBAQECBDqERAKNbQIeBwEEMgcOAQIEA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDjuGTw1JA?=
 =?us-ascii?q?RABBAEBggEBgSRhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQUCLF8CAQMnCwENARsdAQMMBhA7IAIRAQUBHAYBEoMCgiMBBhABA?=
 =?us-ascii?q?zcCAbFPjHAWBQIWgQGCDQaCatgAChkoDXWBYwECAgcJAQoBAYE3AYR3Kl0Dg?=
 =?us-ascii?q?jyFI3aEAnongRiBEIR+gh+COYYwBIIigQyTWAEHBx8SCAEcBggCAkgVEgMEA?=
 =?us-ascii?q?wQEAQILEwkDAwIOAggDAggGGQE/EgQTAggDBgQLBwUfCgIMFAooIhIrCgMqC?=
 =?us-ascii?q?xIPAw0GBRUBCAYCAgQEAgQMAgkCAgUDBAIEDQMEAQEIAgItAwEDGQgJCAILB?=
 =?us-ascii?q?REYDAsHMQMQCQMfAxQcCEUIBhYBGgYFBgs3FQUMEQECGwIgBB0RCAMBGwQCA?=
 =?us-ascii?q?QkDAQMBFQQCFAodAgYIDBcCAgIGAgMDAwoBAggDAwMCAxkHBgMEBAEEBAMDA?=
 =?us-ascii?q?gMFAQMDAwUCAgoGCQEBAQEDAgIIAwcDCgkCBQMbAxsFAQICAwIBAggDBwgDD?=
 =?us-ascii?q?QMEAgMDAwQBAgIBAQECAwEDAwQDAQMDAgEDBwICAwMDCwECAwMFAwMFBQICB?=
 =?us-ascii?q?QUDBQICCgIDAwMCAQMCHAgDBgMSARADAwYBAwcDBwIEAwkCCAMDCAgDFwMDB?=
 =?us-ascii?q?QECAgQDAwgIBAMDBAICAwwFAwIDAwUDAwcCBAIEAwMBBQECBwIDBwIBGAMCB?=
 =?us-ascii?q?AgHBwUCCwQCCAQNCQQCBAICDwQGAwMHAQECAQcFBgMCAhABCAoFBgICAhwDH?=
 =?us-ascii?q?QEDDwYBCQUCAQUOBwUCAhgDBgIDBgUBAwEKCwEBAgMKAQIEAgUDAwEDAgMCB?=
 =?us-ascii?q?gMDAgUFBQMJBwUOCQEDAwYFAgIDAgMBAggEBgUDAgIDBQEEAwQDCgMCCAMDC?=
 =?us-ascii?q?AMLAhoCBQMDAwYJAwcHAgMHAwIFAgcFAwMFAwYBAwIBAwMICxUlAwEFAwMCA?=
 =?us-ascii?q?QMCBQMDGAICBAUDAwMDAwMIBAICAQcGBAICAgEFBQUEBQYCBAMIAQEFAwMKD?=
 =?us-ascii?q?QECBwwDDAYDBwMDBAQDAgUMAgIEAQcGBwcJBwMCAwgBAQsEAQMDCgMDBQIBA?=
 =?us-ascii?q?QcFAwYDBwIDAwMFBAUDAgsDBwICAwMDAikBAQEDAwMDAwQDAQMBAwMHAwUDA?=
 =?us-ascii?q?g4CCAEECQMCBgMHBgMECwkIBwwBPAwHCiQEBAwqARQUBQQlGWcHBwKOXR+CT?=
 =?us-ascii?q?AGBDhSDZgEBAaROi3uUJkkeCQEGAmGBZ4EKFQovm2CFfBozl1OTGS6HZpB0I?=
 =?us-ascii?q?5FwkkeEPgIKBwcRJBKBOQMwgVwzGiOBAW2BSVADGQ+SI8woNTU9AQEHAgcOA?=
 =?us-ascii?q?wuBaIN2iSqBIIErSYFMAQE?=
IronPort-PHdr: A9a23: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
 Mz0x5ql8w1mZd8xY6fXIfgRpmU=
IronPort-Data: A9a23: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
 U/KelY=
IronPort-HdrOrdr: A9a23:thoAc623aD4ux1zXCjhSqQqjBJYkLtp133Aq2lEZdPWaSL38qy
 nIpoVn6faQslwssR4b6Le90cW7MBDhHNtOkPEs1NSZLXPbUQmTXedfBOLZqlWKexEWtNQtrp
 uIG5IeNDSaNykfsS+V2njbL/8QhPeCtI6n7N2w856vd21XgmNbgjuRcjzra3GejTMpOaYE
X-Talos-CUID: 9a23:Ogwwj2GJdU9JOnASqmJb0mgSP+AGUETa81PQE2WIL15zR62KHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AlVs0mw/c9yGxQnNRHbb3VxGQf95VwZWBS2EJq88?=
 =?us-ascii?q?l49mqayJBFiqShg3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,239,1779141600"; 
   d="scan'208";a="154804267"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEooETJYFDwvrilbwJRumWdZvjbfZfciJj4FW?=
 =?us-ascii?q?1bXBz5/il/TunECjA0A6A5UVDk0JFISxHA52PjTx8hfaKxr7ITpPTsOF?=
 =?us-ascii?q?wJL1qtB4E9hIrOQSva29QBBB27Zi7kPd2WKEC+cUXcPcwdobjVKtJiQ6?=
 =?us-ascii?q?689BH0gNXElUwI2mF4t1/thg=3D=3D?=
Received: from mail-pf1-f173.google.com ([209.85.210.173])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 18:18:48 +0200
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8486ac3f347so3160160b3a.1
        for <cocci@inria.fr>; Sun, 23 Aug 2026 09:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787501927; x=1788106727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UoBB3bNXIiZjntcTBcSPE8cc8h15Gliv3FpuekqaQQg=;
        b=KoKhho6tk47ed9gIF+ds4ts+JsVDsSjn3LoEYmf+nQRDhI3Kl37Euk3QRcjW/gA7wS
         X+QN136f9zTe6L8IaHTKjBQDkebCjks7QavqU6vBdxQZJub6LxvQrAsmLgNoQrhZSRHE
         EZeVwZxoDMr8rpBB8HVL8ljpUgoBrKRjGIbaEZube22JnmHOpj5BWs26IyhV9ghbQ/LV
         00leSSLpqpzKEmphigxHn20tthHRVoXF0GrskIGSHPDkWJcdTQuV8+9e8g9tzmHrp3iW
         aFoo8JFCJeb4/4QxvmFAPOgPvFFfEM4cEzE/GHN/hBM+oHzF6w5IWLZ3RYuTr3lWuVHC
         2bgw==
X-Gm-Message-State: AFuF++lVtBHuaMtDCfTg6eybiQRx3HvSq/2JE58bBMY+3oeZc1/OolDw
	DXoXIjPxM4G1K1GLOG3e55aIbWDp+e7DkW77PsjF9IS0vrGkO31ZgDCI
X-Gm-Gg: AR+sD10dJCH/zCv3l7+XN+u1/eGivG0KD7T3Ek0bmw6e46JBhBZpsxA7o6qqgeK3nwm
	FE7cr4LoZ1CndPq9NFbspHJZuqBnix/AZVCVIsIniPSDCe2NpohcCnEzXvHQRKiJkzaGRzKym9r
	/0mJhR5yS/HCUK0++57Qoq1ZtLvtsGtSwB0DCnaq5DFB3Q9zMiywhk2yHVcCTCUWyaHKyMkGdqQ
	b/W4g/cX3FbJjZGFykRnya/1LhZwBMNI1C/Yl5trBBIaCh/M6FRzq4FiE9bPeT0Nrbiphbx5SjT
	g1ON0qPDQvIL/OE7z1g0CYFOSzfKrHkwpvv8gJ/Rwv3en7iwGRTSsqQBsIOXLGsDnjLq/GajsDQ
	z8ftPBVcJymf5h0z3K3GoziAx0w4bK4coCCgWkkjgRLt7FDIzkV4hwW0BlGTB9Dw8b/134dzEze
	YFim9qXwCwsge06224pdWHbKJ+ZTeRwbh1AqGk41ue1Y86tx9GLA0mhZ4=
X-Received: by 2002:a05:6a20:487:b0:3cb:d277:5149 with SMTP id adf61e73a8af0-3cd31a8d116mr22136757637.7.1787501926951;
        Sun, 23 Aug 2026 09:18:46 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199dafa1fsm350181a12.3.2026.08.23.09.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 09:18:46 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org
Date: Mon, 24 Aug 2026 01:18:18 +0900
Message-ID: <20260823161826.3805598-7-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823161826.3805598-1-ekffu200098@gmail.com>
References: <20260823161826.3805598-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 6/7] coccinelle: atomic_as_refcounter: drop
 atomic_long_dec_and_lock
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3707
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/LeIT0lLGNl6TV8xp9uNg6Q>

atomic_long_dec_and_lock() has never existed. So drop it from the rules.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 scripts/coccinelle/api/atomic_as_refcounter.cocci | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
index bbe5b2932933..af82b9e094aa 100644
--- a/scripts/coccinelle/api/atomic_as_refcounter.cocci
+++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
@@ -26,8 +26,6 @@ identifier fname6 =~ ".*call_rcu.*";
  atomic_dec_and_test@p1(&(a)->x)
 |
  atomic_dec_and_lock@p1(&(a)->x, ...)
-|
- atomic_long_dec_and_lock@p1(&(a)->x, ...)
 |
  atomic_long_dec_and_test@p1(&(a)->x)
 |
@@ -69,8 +67,6 @@ identifier fname =~ ".*free.*";
  atomic_dec_and_test@p1(&(a)->x)
 |
  atomic_dec_and_lock@p1(&(a)->x, ...)
-|
- atomic_long_dec_and_lock@p1(&(a)->x, ...)
 |
  atomic_long_dec_and_test@p1(&(a)->x)
 |
-- 
2.43.0

