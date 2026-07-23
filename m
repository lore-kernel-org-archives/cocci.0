Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E2DC531FA
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qd/dKHIuRS/CtItZlX4/17nIeCWsz+xndXH+6leeAfQ=;
  b=EWBjrDhYiNjtQWf9iN5ZDXEaFGIBMYzD/zUmz0r9ICMOswig9FpR2nVK
   W8/m+KA4KW4SUo4KJcyZWroNRbxlfOgGUYWoOSZVEUfFHFtkx+Pn/YyRq
   X/anFtYajYZyx1DJ4nZanEvBiyrcP2mik2s8WEEw50zSJCensVKJo1v3U
   E=;
X-CSE-ConnectionGUID: 5U1bYuduSxOrnrAO4VJRIg==
X-CSE-MsgGUID: 5I/eH0fYQ0+Frb5oBWnI1Q==
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
   d="scan'208";a="287733094"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:53:55 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 5EF8A804DC; Fri, 24 Jul 2026 10:53:55 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 9331C81331
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:46:06 +0200 (CEST)
X-CSE-ConnectionGUID: Cym1mK2EQku9idNum3aKyA==
X-CSE-MsgGUID: 5hI1XtuGTiqf/ZHkmsUpMg==
IronPort-SDR: 6a62616e_JSA/H39o/P5VvbYKgdpgFauRmZdqCELT+hFiJfGk8d4HRBM
 4vpCeKRufmTxoni5UEriO+X0mPeImd3B2MIs7Og==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HFBABZYGJqgTTYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKHU4pPgT89Ag8BAwELAQFPAgQBAQECBDiERgKNYAIeBwEEMAkOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDjuGTw1JARABB?=
 =?us-ascii?q?AEBggEBgSRhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQUCLF8CAQMSFQsBDQEbHQEDDAYQOyACEQEFARwGARIigmCCIwEGEAEDN?=
 =?us-ascii?q?wIBtleBAkKMPBYFAhaBAYINBtpoChkoDXWBYwECAgcJAQoBAYE3AYR3Kl0Dg?=
 =?us-ascii?q?jqFI3WEAnongRiBEIR+gh+COYYwBIMcEpIqAQcHHxIIARwGCAICSBUSAwQDB?=
 =?us-ascii?q?AQBAgsTCQMDAg4CCAMCCAYZAT8SBBMCCAMGBAsHBR8KAgwUCigiEgIpCgMgC?=
 =?us-ascii?q?gsSDwMNBgUVAQEHBgICAwEEAgQMAgkCAgUDAQMCBAYHAwQBAQgCAi0DAQMZC?=
 =?us-ascii?q?AkIAgsFERgMCwUCCicDDwEJAx8DFBsIRQgGFgEaBwUGCzcVBQwRAQIbAiEEH?=
 =?us-ascii?q?REIAwEYBAICAgELAwEDARUECAkEDAIQChIVAw4DBw8CDQcuCwMCDgIJCAwXA?=
 =?us-ascii?q?gICBgIDAwMKAQIBAQEBAQEBCAMDAwIDGQcGAwQEAQQEAwMCAwUBAwMDBQICC?=
 =?us-ascii?q?gYJAQEBAQMCAggDBwMKCQIFAxsDHAYBAgIDAgECAwYDBwgDDQMEAgMDAwQBA?=
 =?us-ascii?q?gIBAQECAwEDAwQDAQMDAgEDBwICAwMDCwECAwMDBQMFAQUDBQICAwUFAwUCA?=
 =?us-ascii?q?goCAwMDAgEDAhwDCAMGAxIBEAMDBgEDBwMHAgQDCAQDBgIDCAMDAgkIAxYGA?=
 =?us-ascii?q?wMDAwUBAgICAwUDAwMICAQDAwQCAgMMAgYDAwMCAwMFAwMHAgQCAwYDAwMBA?=
 =?us-ascii?q?wMFAQIHAgMHAgELCwgDAgQCCQcJBwECAwsEAgQGBA0JBAIEAgIPBAQFAwMHA?=
 =?us-ascii?q?QECAQIIBQYDAgIRBQgKBQYCAgIdAyEBAw8GAQkFAgEFDgcFAgIKEgMGAgMEB?=
 =?us-ascii?q?QUBAwEKAQsBAQIDAwUFAwMFBwECBAIHAwMDBAMDAwMBAQICBAYEAwIDBwMDA?=
 =?us-ascii?q?wMDBAMFBQMCBQIEAwUDBwIDAwIBBQoBBAUECgEDAwMDBQUDAgIDAwQBAgQGA?=
 =?us-ascii?q?wQCAwECCAQGBQMDAwUCAwMCAgIDAwUBBQIDAwMEAwMDCAcFAwMFAgkDAwkDA?=
 =?us-ascii?q?wsCAgMhAgUDAwMDBgMHAwMEAwMDBwcCAwIDBwMCBQIHBQMDBQMGAQMCAQMDC?=
 =?us-ascii?q?AsYAwsJCAcMATwMBwokBAQMKgEGDhQFBCUZZwcHAo1oI4JAAYEOgiiBUQEBA?=
 =?us-ascii?q?aROoCFJHgkBBgJggWeBChUKL5tfhXwaM5dTkxmZCCORcJJHhD4CCgcHESQSg?=
 =?us-ascii?q?TI6gVwzGiOBAW2BSVADGQ+SI489AbxXNTU+AQcCBw8CgXODdokqgSCBK0mBT?=
 =?us-ascii?q?AEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 U/KelY=
IronPort-HdrOrdr: A9a23:xho7gKqKRlkpcOGlfjE1pTMaV5oPeYIsimQD101hICG9vPbo8v
 xG+85rqCMc7Qx6ZJhOo6HmBEDtewK+yXcx2/hoAV7AZnidhILLFvAF0WKK+VSJcE3DH6xmpN
 xdmsBFaeEYZmIK6foSjjPIceoI8Z2o9OSHi47loEuFjjsHV0ij1WpE436gYzRLrcB9a6YEKA
 ==
X-Talos-CUID: 9a23:LhEeMm1w5mGm3l1/yQBasrxfMdEgK3j+llrpIFLpCGpPVbjOQHyB0fYx
X-Talos-MUID: 9a23:gXMrEAX6BUwxWizq/GLspWhSKNpH36W3Bgc/sZYDoPScECMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="287666864"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFjtD0bIGB8BACY5WC1JZ73oD/Kem+DtMKpsk?=
 =?us-ascii?q?RtWrb76tmBk69ykqgbkusHwTebs0sI+MoalMzCxBx6dOcI21FM7AFg+z?=
 =?us-ascii?q?yeS3XWGznQzfUFugLpoJ8NT2ne8MsieD5R6d7fw9gZbFKrKpwJVRkhNa?=
 =?us-ascii?q?4OP9DXQZd9fLouEGfhdnEskg=3D=3D?=
Received: from mail-pj1-f52.google.com ([209.85.216.52])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:46:05 +0200
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e88b60121so792390a91.3
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832364; x=1785437164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qd/dKHIuRS/CtItZlX4/17nIeCWsz+xndXH+6leeAfQ=;
        b=j38sn4fjO1am9bUz13X1itKRCreN1zK7nDw575BC5pUtj9LUroy+6+c/5juIy6xQOR
         c+zvDr5JW4aZ7V1u7nGRZaJG7k+WeuiOi1tNYQsMAdxn5xi9YHb5xzlXjhxL/s48MDe3
         k84TduRROIkoa1UGQje51ulNYMoJFbmwi+msgEQ5agvQw4VedFZMDV7yGAESU+2v1A5R
         0IG/QYbXjNGqFNbsOmqmc1ntJW+uVYjXQjmEch9nb3y7Xz/9yH0icW7grxz2uDDHKzC/
         7F1JVPcWqlJutVwwlsd0MAszHCU44UZo+STsJ3JTWAQVYtPAmc1y7fPEHzEQ+n3GB/rh
         MZ0g==
X-Gm-Message-State: AOJu0YybkQ2ue8mobxUJtubqKaYtMvbmVNOP4LD1/0JI2Jflee5Edez9
	3gA42OaaM9aQxYTXSjKub+H1P7Weh915cVcnKq3n/HsW65MPOho/0KCk
X-Gm-Gg: AR+sD11VLUQ3fVuSpQhIFhUbSVp9pmJ3uaaYv2m2oLCf97qG6hqVQFCoPFxBiQiOk51
	VPnMEjYCGTHtAqC9qBPXaTj62fpOew1fl2gOnDONa6jhtvJ19bD6N/x/SWeT7srU1Mv3btSLO0X
	0AMjPLA5CD0/noBDd+KAV4WRVeqAHqc3yub15KGmYuGKzCPRqu4CwZ9bYY+eepojXnSYeVUFavZ
	t0Uc2hy/sxJLtHMjWM6ftaV0jMAkhiPpELCVgBRQ41U4OmPsoFng2JblkFsd3Ka0kdqzU4ktm/K
	Lj+DX9g23ofWPakzGfaOMqq43Y8j/XO3zit8pLT1jWcEfav/wglt/fGZdHeN03XOkOTAkw6e0zp
	GiqVjUInpEs178iOY04H52e7sRd12g4Xm61H1M+MNVEEdV+R6Z01oaOgJ5eiaY5n5wRGP60aWjB
	Moyqvex5k=
X-Received: by 2002:a17:90b:57e4:b0:38e:79f:76ad with SMTP id 98e67ed59e1d1-38ec6566203mr4405122a91.23.1784832364154;
        Thu, 23 Jul 2026 11:46:04 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:03 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Ivan Vecera <ivecera@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:06 +0900
Message-ID: <20260723184538.3888637-5-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 04/36] dpll: zl3073x: remove conditional return with
 no effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3601
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/hLlf53rFG5BnqpIg09Lxgw>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/dpll/zl3073x/dpll.c | 6 +-----
 drivers/dpll/zl3073x/out.c  | 8 ++------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index a2a641b8358f..0488ae6ac486 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -2272,11 +2272,7 @@ zl3073x_dpll_init_fine_phase_adjust(struct zl3073x_dev *zldev)
 	if (rc)
 		return rc;
 
-	rc = zl3073x_write_u8(zldev, ZL_REG_SYNTH_PHASE_SHIFT_CTRL, 0x01);
-	if (rc)
-		return rc;
-
-	return rc;
+	return zl3073x_write_u8(zldev, ZL_REG_SYNTH_PHASE_SHIFT_CTRL, 0x01);
 }
 
 /**
diff --git a/drivers/dpll/zl3073x/out.c b/drivers/dpll/zl3073x/out.c
index eb5628aebcee..410d15b96d0b 100644
--- a/drivers/dpll/zl3073x/out.c
+++ b/drivers/dpll/zl3073x/out.c
@@ -85,12 +85,8 @@ int zl3073x_out_state_fetch(struct zl3073x_dev *zldev, u8 index)
 	if (rc)
 		return rc;
 
-	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_PHASE_COMP,
-			      &out->phase_comp);
-	if (rc)
-		return rc;
-
-	return rc;
+	return zl3073x_read_u32(zldev, ZL_REG_OUTPUT_PHASE_COMP,
+				&out->phase_comp);
 }
 
 /**
-- 
2.43.0

