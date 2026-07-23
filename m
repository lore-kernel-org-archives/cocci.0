Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953CAC531FC
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OFWWMcPCcMgyyaWxMapaPQ6yr5T+tvoKVuXbzZSZnOI=;
  b=p3kp7VofiqFx2P8xP3bI2qg4LIAMFrrWGG7JjWx2+S/sEl1vCWeKkBXA
   6/8PufjU70a3rQeifqx3Sgdx0H4nyPiohp59NPt29/suBuhCLHArcYTcz
   tgVa6VwKa6dSMC0ALnQiK9eaei6HY5uJ+AO9yn+pu0o4gXzOfMPo6q4Us
   I=;
X-CSE-ConnectionGUID: QJ8KBlS5TuWB7E6/Ztps3A==
X-CSE-MsgGUID: dhfSbk+tRMehz5pJ/EG7uw==
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
   d="scan'208";a="287733031"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:53:52 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 4CF1B80428; Fri, 24 Jul 2026 10:53:52 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 5C011819F5
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:46:02 +0200 (CEST)
X-CSE-ConnectionGUID: eOkk6ZrZTfS3WmbKWZWCGQ==
X-CSE-MsgGUID: eLbzq4FGS7a60mYgTBr64g==
IronPort-SDR: 6a626169_TXaKuzAUynARjSygKIsgQOvZAfcXLAYFLTnLN3aWfS5BawO
 tpWHtirDCXug/g0nt5X+SrR4AS9o0OI5WFy5VtA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GqBABZYGJqfDbYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?pIigT89Ag8BAwELAQFPAgQBAQECBDiERgKNYAIeBwEEMAkOAQIEAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDhIphk8NSQEQAQQBA?=
 =?us-ascii?q?YIBAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEFAixfAgEDEggNCwENARsdAQMMBhA7IAIRAQUBHAYBEiKCYIIjAQYQAQM3A?=
 =?us-ascii?q?gG2V4ECQow8FgUCFoEBgg0G2mgKGSgNdYFjAQICBwkBCgEBgTcBhHcqXQOCO?=
 =?us-ascii?q?oUjdYQCeieBGIEQgRWDaYIfgjmGMASDLot6hjABBwcfEggBHAYIAgJIFRIDB?=
 =?us-ascii?q?AMEBAECCxMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCDBQKKCISAikKA?=
 =?us-ascii?q?yAKCxIPAw0GBRUBAQcGAgIDAQQCBAwCBAUCAgUDAQMCBAYEAwMEAQEIAgItA?=
 =?us-ascii?q?wEDGQgJCAILBREYDAsFAgonAw8BCQMfAxQbCEUIBhYBGgcFBgs3FQUMEQECG?=
 =?us-ascii?q?wIhBB0RCAMBGAQCAgIBCwMBAwEVBAgJBAwCEAoSFQMOAwcPAg0HLgsDAg4CC?=
 =?us-ascii?q?QgMFwICAgYCAwMDCgECAQEBAQEBAQgDAwMCAxkHBgMEBAEEBAMDAgMFAQMDA?=
 =?us-ascii?q?wUCAgoGCQEBAQEDAgIIAwcDCgkCBQMbAxwGAQICAwIBAgMGAwcIAw0DBAIDA?=
 =?us-ascii?q?wMEAQICAQEBAgMBAwMEAwEDAwIBAwcCAgMDAwsBAgMDAwUDBQEFAwUCAgMFB?=
 =?us-ascii?q?QMFAgIKAgMDAwIBAwIcAwgDBgMSARADAwYBAwcDBwIEAwgEAwYCAwgDAwIJC?=
 =?us-ascii?q?AMWBgMDAwMFAQICAgMFAwMDCAgEAwMEAgIDDAIGAwMDAgMDBQMDBwIEAgMGA?=
 =?us-ascii?q?wMDAQMDBQECBwIDBwIBCwsIAwIEAgkHCQcBAgMLBAIEBgQNCQQCBAICDwQEB?=
 =?us-ascii?q?QMDBwEBAgECCAUGAwICEQUICgUGAgICHQMhAQMPBgEJBQIBBQ4HBQICChIDB?=
 =?us-ascii?q?gIDBAUFAQMBCgELAQECAwMFBQMDBQcBAgQCBwMDAwQDAwMDAQECAgQGBAMCA?=
 =?us-ascii?q?wcDAwMDAwQDBQUDAgUCBAMFAwcCAwMCAQUKAQQFBAoBAwMDAwUFAwICAwMEA?=
 =?us-ascii?q?QIEBgMEAgMBAggEBgUDAwMFAgMDAgICAwMFAQUCAwMDBAMDAwgHBQMDBQIJA?=
 =?us-ascii?q?wMJAwMLAgIDIQIFAwMDAwYDBwMDBAMDAwcHAgMCAwcDAgUCBwUDAwUDBgEDA?=
 =?us-ascii?q?gEDAwgLGAMLCQgHDAE8DAcKJAQEDCoBBg4UBQQlGWcHBwKNaCOCQAGBDoIoN?=
 =?us-ascii?q?YEcAQEBkgkJAQeSNIE4nmlJHgkBBgJggWeBChUKL5tfhXwaM5dTkxmZCCORc?=
 =?us-ascii?q?JJHhD4CCgcHESQSgTI6gVwzGiOBAW2BSVADGQ+OLRaDYI89AbxXNTU+AQcCB?=
 =?us-ascii?q?w8CgXODdokqgSCBK0mBTAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 U7Keg==
IronPort-HdrOrdr: A9a23:Mxb+H6m+7Ztw7/xb8K7tFxk9WojpDfII3DAbv31ZSRFFG/FwWf
 re+cjzsiWE9Qr5PUtLpTnuAtjmfZqxz+8X3WBVB8bbYOCEghrTEGgB1/qF/9SIIUSXnY5gPO
 VbAtND4bXLbGSS5vyKhDVQfexQouWvweSHgaPxwR5WIj2CqJsN0+66MGum+zVNNXB77FMCeq
 ah2g==
X-Talos-CUID: 9a23:/8JYkmCgrTVIwPD6EyRA901KKNoXTnPml0jVKWyHO1lCZ4TAHA==
X-Talos-MUID: 9a23:Fb92dwoQhk8nDWQsR+AezzxGPtVxv4qBMx8Ez80Disa4HzYuZzjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152815230"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDH29H3hMaZTr/mjVhMj1cBSkLsQrNzW1HoCdJ?=
 =?us-ascii?q?Xud+XIPXC3BNtfFsLvRksugyL8TKoZ9Hp3pSK1Op1h/eOIXpp/4ZiZ/0?=
 =?us-ascii?q?kvDb24gOv82jY929rgJCkYNCbf3FShlpsfc2dwX5z5wCKAczpKV2/zmV?=
 =?us-ascii?q?tMTIe8Y45TtNEUijXf1pT3mQ=3D=3D?=
Received: from mail-pj1-f54.google.com ([209.85.216.54])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:46:02 +0200
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso853031a91.3
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832359; x=1785437159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OFWWMcPCcMgyyaWxMapaPQ6yr5T+tvoKVuXbzZSZnOI=;
        b=WAjI707+vbo8BckTX4XmZ1C0cc8ey03ozvdu2R8fSUmKEaN4arVO3ghNxLZspktw++
         YKKMpP7v+Mmh1dlNNroxxbuKnJYAsRkcPh7lRmEvJS13Zzlu8AkbVtZEL0r8ZUTKY3tu
         G89+7SsWNray7R5KsKkxPZY3BP2rTiVXaS2DOtiGEY2d1OUbp45Z7p5cJRw+Y+STf/QI
         iuF6efU2aNaFoIp6WMuzj4aG9B4N4bggY9O/LsR+COB4EoUjssNbDYmF66ttt84x29LV
         BZ0Z+8Osav9mRlZ2tRl2FDsZQtFz+n288De3jMc9HEZpLAQgkJzYWY/45sOIri+IDWWj
         z1EA==
X-Gm-Message-State: AOJu0YxSkak0vuECM+0Uc8k356mYxKGNsJXe+Q+uuwsNwq2NO2aH8e7J
	1+3awvq2aqV/9iiN4MfqGiAhQ87yFyOTaIQO7YbNta/nd2kfP7fYaio6
X-Gm-Gg: AR+sD13Y7V/d1ZoESEUKaa8Izlo9HfJ//2DpzqAifYt59sY8TcouaQq88pRyXlCNQxm
	dBeQk92hjVzKCGG9pGbocLBGGVBDHmhTJUrXjy6m63eqjR6C/kjLDjEZKO+4MlET7ldfEKk+WVI
	YA01EbsR500fcf39dtarhjwvdEUDnfD6YA5ISGralBuEb31PNlPM6hh/32NbN2pZyiJb7h5ui6j
	dou5n8INmqXNCQgy5ij9DiDX9Q3lVMyXmc7jVZvGUJ4EciX3OnlXFCTiQO4xztXHyKYLFnHwOJ/
	rof5jhSznlPDRifN/yfk42+BuPdqomp512cAMVIzhTqTGTuP3DU2/h0zS4KgORyG4CYdPAhI3gh
	7WlCX+hvwAsiMjCbSi9tUCoouqJS9V0T78PEV+ebvGq5YwSP603YO2fH/AKNEl6aWg82Blnom
X-Received: by 2002:a17:90b:55c3:b0:38d:fda6:4873 with SMTP id 98e67ed59e1d1-38ec64f19b0mr4395595a91.10.1784832359386;
        Thu, 23 Jul 2026 11:45:59 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:45:58 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kenneth Feng <kenneth.feng@amd.com>
Cc: cocci@inria.fr,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:04 +0900
Message-ID: <20260723184538.3888637-3-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 02/36] drm/amd: remove conditional return with no
 effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3599
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/qyPzZZlfeKM2P1C7AcApWQ>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |  6 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  6 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  6 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  6 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  6 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  6 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  6 +---
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |  6 +---
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |  6 +---
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |  6 +---
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |  6 +---
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    | 32 +++++++------------
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  6 +---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  6 +---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  6 +---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  6 +---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 19 ++++-------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  7 ++--
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  7 ++--
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  6 +---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 19 ++++-------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  6 +---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 10 ++----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  6 +---
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 19 ++++-------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  6 +---
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    |  9 ++----
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 16 ++--------
 28 files changed, 60 insertions(+), 192 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 65b8497ad5f0..c64c79db3016 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4482,11 +4482,7 @@ static int gfx_v7_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = gfx_v7_0_cp_resume(adev);
-	if (r)
-		return r;
-
-	return r;
+	return gfx_v7_0_cp_resume(adev);
 }
 
 static int gfx_v7_0_hw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1cad6dc9476e..5baacf86facb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1614,11 +1614,7 @@ static int gfx_v9_0_init_microcode(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	r = gfx_v9_0_init_cp_compute_microcode(adev, ucode_prefix);
-	if (r)
-		return r;
-
-	return r;
+	return gfx_v9_0_init_cp_compute_microcode(adev, ucode_prefix);
 }
 
 static u32 gfx_v9_0_get_csb_size(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 9512fef81d84..22b48f4232b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -599,11 +599,7 @@ static int gfx_v9_4_3_init_microcode(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	r = gfx_v9_4_3_init_cp_compute_microcode(adev, ucode_prefix);
-	if (r)
-		return r;
-
-	return r;
+	return gfx_v9_4_3_init_cp_compute_microcode(adev, ucode_prefix);
 }
 
 static void gfx_v9_4_3_mec_fini(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 6fe3d3d56c40..4dac16bb330c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1537,11 +1537,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
-	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
-	if (r)
-		return r;
-
-	return r;
+	return amdgpu_sdma_sysfs_reset_mask_init(adev);
 }
 
 static int sdma_v4_4_2_sw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 1ca0e7f65442..5192fe097385 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1440,11 +1440,7 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
-	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
-	if (r)
-		return r;
-
-	return r;
+	return amdgpu_sdma_sysfs_reset_mask_init(adev);
 }
 
 static int sdma_v5_0_sw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 81f1e9882177..4ddb8277c37d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1358,11 +1358,7 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
-	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
-	if (r)
-		return r;
-
-	return r;
+	return amdgpu_sdma_sysfs_reset_mask_init(adev);
 }
 
 static int sdma_v5_2_sw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index cf3d2997fff8..d41e3720020f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1406,11 +1406,7 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
-	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
-	if (r)
-		return r;
-
-	return r;
+	return amdgpu_sdma_sysfs_reset_mask_init(adev);
 }
 
 static int sdma_v6_0_sw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 8a9ba2276275..004a8ce8eedc 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -128,11 +128,7 @@ static int uvd_v4_2_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_uvd_resume(adev);
-	if (r)
-		return r;
-
-	return r;
+	return amdgpu_uvd_resume(adev);
 }
 
 static int uvd_v4_2_sw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 454f109cbb2e..52700e9048f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -121,11 +121,7 @@ static int uvd_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_uvd_resume(adev);
-	if (r)
-		return r;
-
-	return r;
+	return amdgpu_uvd_resume(adev);
 }
 
 static int uvd_v5_0_sw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 46222fc30be6..3760a06d8ef2 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -484,11 +484,7 @@ static int uvd_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_virt_alloc_mm_table(adev);
-	if (r)
-		return r;
-
-	return r;
+	return amdgpu_virt_alloc_mm_table(adev);
 }
 
 static int uvd_v7_0_sw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index ee445d8abe47..a2f908f86df3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -491,11 +491,7 @@ static int vce_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	r = amdgpu_virt_alloc_mm_table(adev);
-	if (r)
-		return r;
-
-	return r;
+	return amdgpu_virt_alloc_mm_table(adev);
 }
 
 static int vce_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index b763fdf43c60..0d241002df82 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -1075,16 +1075,12 @@ static int kv_populate_samu_table(struct amdgpu_device *adev)
 	if (ret)
 		return ret;
 
-	ret = amdgpu_kv_copy_bytes_to_smc(adev,
-				   pi->dpm_table_start +
-				   offsetof(SMU7_Fusion_DpmTable, SamuLevel),
-				   (u8 *)&pi->samu_level,
-				   sizeof(SMU7_Fusion_ExtClkLevel) * SMU7_MAX_LEVELS_SAMU,
-				   pi->sram_end);
-	if (ret)
-		return ret;
-
-	return ret;
+	return amdgpu_kv_copy_bytes_to_smc(adev,
+					   pi->dpm_table_start +
+					   offsetof(SMU7_Fusion_DpmTable, SamuLevel),
+					   (u8 *)&pi->samu_level,
+					   sizeof(SMU7_Fusion_ExtClkLevel) * SMU7_MAX_LEVELS_SAMU,
+					   pi->sram_end);
 }
 
 
@@ -1134,16 +1130,12 @@ static int kv_populate_acp_table(struct amdgpu_device *adev)
 	if (ret)
 		return ret;
 
-	ret = amdgpu_kv_copy_bytes_to_smc(adev,
-				   pi->dpm_table_start +
-				   offsetof(SMU7_Fusion_DpmTable, AcpLevel),
-				   (u8 *)&pi->acp_level,
-				   sizeof(SMU7_Fusion_ExtClkLevel) * SMU7_MAX_LEVELS_ACP,
-				   pi->sram_end);
-	if (ret)
-		return ret;
-
-	return ret;
+	return amdgpu_kv_copy_bytes_to_smc(adev,
+					   pi->dpm_table_start +
+					   offsetof(SMU7_Fusion_DpmTable, AcpLevel),
+					   (u8 *)&pi->acp_level,
+					   sizeof(SMU7_Fusion_ExtClkLevel) * SMU7_MAX_LEVELS_ACP,
+					   pi->sram_end);
 }
 
 static void kv_calculate_dfs_bypass_settings(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 012227c70600..50973f92ccbf 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -6989,11 +6989,7 @@ static int si_set_temperature_range(struct amdgpu_device *adev)
 	ret = si_thermal_set_temperature_range(adev, R600_TEMP_RANGE_MIN, R600_TEMP_RANGE_MAX);
 	if (ret)
 		return ret;
-	ret = si_thermal_enable_alert(adev, true);
-	if (ret)
-		return ret;
-
-	return ret;
+	return si_thermal_enable_alert(adev, true);
 }
 
 static void si_dpm_disable(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f4e817885e54..9c2eb6431727 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1922,11 +1922,7 @@ static int smu_start_smc_engine(struct smu_context *smu)
 	 * Send msg GetDriverIfVersion to check if the return value is equal
 	 * with DRIVER_IF_VERSION of smc header.
 	 */
-	ret = smu_check_fw_version(smu);
-	if (ret)
-		return ret;
-
-	return ret;
+	return smu_check_fw_version(smu);
 }
 
 static int smu_hw_init(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index db5db2c9c8e8..0dd2dbbfb2cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -540,11 +540,7 @@ static int arcturus_setup_pptable(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = arcturus_check_powerplay_table(smu);
-	if (ret)
-		return ret;
-
-	return ret;
+	return arcturus_check_powerplay_table(smu);
 }
 
 static int arcturus_run_btc(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 8feea44f3ca0..48af342aa549 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -484,11 +484,7 @@ static int navi10_setup_pptable(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = navi10_check_powerplay_table(smu);
-	if (ret)
-		return ret;
-
-	return ret;
+	return navi10_check_powerplay_table(smu);
 }
 
 static int navi10_tables_init(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index a889d846e9c5..8f35ddaabe88 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -528,12 +528,10 @@ int smu_v11_0_notify_memory_pool_location(struct smu_context *smu)
 					  address_low, NULL);
 	if (ret)
 		return ret;
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramSize,
-					  (uint32_t)memory_pool->size, NULL);
-	if (ret)
-		return ret;
-
-	return ret;
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_DramLogSetDramSize,
+					       (uint32_t)memory_pool->size,
+					       NULL);
 }
 
 int smu_v11_0_set_min_deep_sleep_dcefclk(struct smu_context *smu, uint32_t clk)
@@ -1378,13 +1376,8 @@ int smu_v11_0_register_irq_handler(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-				SMU_IH_INTERRUPT_ID_TO_DRIVER,
-				irq_src);
-	if (ret)
-		return ret;
-
-	return ret;
+	return amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
+				 SMU_IH_INTERRUPT_ID_TO_DRIVER, irq_src);
 }
 
 int smu_v11_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 016a5c893fee..3350ea1bea24 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1368,11 +1368,8 @@ static int vangogh_set_peak_clock_by_device(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = vangogh_set_soft_freq_limited_range(smu, SMU_DCLK, dclk_freq, dclk_freq, false);
-	if (ret)
-		return ret;
-
-	return ret;
+	return vangogh_set_soft_freq_limited_range(smu, SMU_DCLK, dclk_freq,
+						   dclk_freq, false);
 }
 
 static int vangogh_set_performance_level(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 2b011610e3c7..85f77754a0c0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -893,11 +893,8 @@ static int renoir_set_peak_clock_by_device(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = smu_v12_0_set_soft_freq_limited_range(smu, SMU_UCLK, uclk_freq, uclk_freq, false);
-	if (ret)
-		return ret;
-
-	return ret;
+	return smu_v12_0_set_soft_freq_limited_range(smu, SMU_UCLK, uclk_freq,
+						     uclk_freq, false);
 }
 
 static int renior_set_dpm_profile_freq(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index cd7bf36673cb..2a74bb8a7b78 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -533,11 +533,7 @@ static int aldebaran_setup_pptable(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = aldebaran_check_powerplay_table(smu);
-	if (ret)
-		return ret;
-
-	return ret;
+	return aldebaran_check_powerplay_table(smu);
 }
 
 static bool aldebaran_is_primary(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 4f10bce36756..a2b0a2f23916 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -583,12 +583,10 @@ int smu_v13_0_notify_memory_pool_location(struct smu_context *smu)
 					      address_low, NULL);
 	if (ret)
 		return ret;
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramSize,
-					      (uint32_t)memory_pool->size, NULL);
-	if (ret)
-		return ret;
-
-	return ret;
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_DramLogSetDramSize,
+					       (uint32_t)memory_pool->size,
+					       NULL);
 }
 
 int smu_v13_0_set_driver_table_location(struct smu_context *smu)
@@ -1281,13 +1279,8 @@ int smu_v13_0_register_irq_handler(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-				SMU_IH_INTERRUPT_ID_TO_DRIVER,
-				irq_src);
-	if (ret)
-		return ret;
-
-	return ret;
+	return amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
+				 SMU_IH_INTERRUPT_ID_TO_DRIVER, irq_src);
 }
 
 int smu_v13_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 4ce1429cf57b..0ca404ccb4a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -463,11 +463,7 @@ static int smu_v13_0_0_setup_pptable(struct smu_context *smu)
 			return ret;
 	}
 
-	ret = smu_v13_0_0_check_powerplay_table(smu);
-	if (ret)
-		return ret;
-
-	return ret;
+	return smu_v13_0_0_check_powerplay_table(smu);
 }
 
 static int smu_v13_0_0_tables_init(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 64db62a8d642..b55626f61be7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1893,7 +1893,6 @@ static int smu_v13_0_6_register_irq_handler(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	struct amdgpu_irq_src *irq_src = &smu->irq_source;
-	int ret = 0;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
@@ -1901,13 +1900,8 @@ static int smu_v13_0_6_register_irq_handler(struct smu_context *smu)
 	irq_src->num_types = 1;
 	irq_src->funcs = &smu_v13_0_6_irq_funcs;
 
-	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-				IH_INTERRUPT_ID_TO_DRIVER,
-				irq_src);
-	if (ret)
-		return ret;
-
-	return ret;
+	return amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
+				 IH_INTERRUPT_ID_TO_DRIVER, irq_src);
 }
 
 static int smu_v13_0_6_notify_unload(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 5f23f2e7f401..0cc3ec648521 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -499,11 +499,7 @@ static int smu_v13_0_7_setup_pptable(struct smu_context *smu)
 			return ret;
 	}
 
-	ret = smu_v13_0_7_check_powerplay_table(smu);
-	if (ret)
-		return ret;
-
-	return ret;
+	return smu_v13_0_7_check_powerplay_table(smu);
 }
 
 static int smu_v13_0_7_tables_init(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 2a0c7cde938d..27a3f5d9cba6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -549,12 +549,10 @@ int smu_v14_0_notify_memory_pool_location(struct smu_context *smu)
 					      address_low, NULL);
 	if (ret)
 		return ret;
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramSize,
-					      (uint32_t)memory_pool->size, NULL);
-	if (ret)
-		return ret;
-
-	return ret;
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_DramLogSetDramSize,
+					       (uint32_t)memory_pool->size,
+					       NULL);
 }
 
 int smu_v14_0_set_driver_table_location(struct smu_context *smu)
@@ -911,13 +909,8 @@ int smu_v14_0_register_irq_handler(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-				SMU_IH_INTERRUPT_ID_TO_DRIVER,
-				irq_src);
-	if (ret)
-		return ret;
-
-	return ret;
+	return amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
+				 SMU_IH_INTERRUPT_ID_TO_DRIVER, irq_src);
 }
 
 static int smu_v14_0_wait_for_reset_complete(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 0fbcaf884419..0aec08200038 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -366,11 +366,7 @@ static int smu_v14_0_2_setup_pptable(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = smu_v14_0_2_check_powerplay_table(smu);
-	if (ret)
-		return ret;
-
-	return ret;
+	return smu_v14_0_2_check_powerplay_table(smu);
 }
 
 static int smu_v14_0_2_tables_init(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 046069e93854..cb1602cfab98 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -782,13 +782,8 @@ int smu_v15_0_register_irq_handler(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-				SMU_IH_INTERRUPT_ID_TO_DRIVER,
-				irq_src);
-	if (ret)
-		return ret;
-
-	return ret;
+	return amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
+				 SMU_IH_INTERRUPT_ID_TO_DRIVER, irq_src);
 }
 
 static int smu_v15_0_wait_for_reset_complete(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 227cd86e13e8..b398e1606177 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -318,11 +318,7 @@ static int smu_v15_0_8_fini_smc_tables(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = smu_v15_0_fini_smc_tables(smu);
-	if (ret)
-		return ret;
-
-	return ret;
+	return smu_v15_0_fini_smc_tables(smu);
 }
 
 static int smu_v15_0_8_init_allowed_features(struct smu_context *smu)
@@ -1253,7 +1249,6 @@ static int smu_v15_0_8_register_irq_handler(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	struct amdgpu_irq_src *irq_src = &smu->irq_source;
-	int ret = 0;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
@@ -1261,13 +1256,8 @@ static int smu_v15_0_8_register_irq_handler(struct smu_context *smu)
 	irq_src->num_types = 1;
 	irq_src->funcs = &smu_v15_0_8_irq_funcs;
 
-	ret = amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_MP1,
-				IH_INTERRUPT_ID_TO_DRIVER,
-				irq_src);
-	if (ret)
-		return ret;
-
-	return ret;
+	return amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_MP1,
+				 IH_INTERRUPT_ID_TO_DRIVER, irq_src);
 }
 
 static int smu_v15_0_8_notify_unload(struct smu_context *smu)
-- 
2.43.0

