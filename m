Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC71C531FC
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=MvMxjqNvpASivPiDAcPmI8PwBsKAarLbQdQ8wRHMWv0=;
  b=r7f2P/tx+ZCGWnF4nVDZm2v568R3gmI4xqRsyzTsMNq9notYhF0OWulH
   8vPUI6dVjCksShVf9gbxvy+0AiVQ6bUJ+WWnL2o8QTj8mnHW+jVP4/6Hr
   elE51I52LcIzcvslGAwZaLvGnLAnegFUmzVurdcRVggnxPj/a/2/LdQov
   Q=;
X-CSE-ConnectionGUID: lW141QEhSKmij2qH9Sb7wg==
X-CSE-MsgGUID: HD0KD3vWSC2KAL7TZNTSnw==
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
   d="scan'208";a="287733642"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:19 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id EF3DE80411; Fri, 24 Jul 2026 10:54:18 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id D1BB7819A4
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:46:48 +0200 (CEST)
X-CSE-ConnectionGUID: g1lDyBQuR9OKZFijfI5ziw==
X-CSE-MsgGUID: omzWDfUxQzyoV0REwlHPjQ==
IronPort-SDR: 6a626198_lNkZssBItD42wqoZMZC2cru1BdB3iVwmwILfKFSWFrvUXlO
 QNDi70AvDpcPRZlxoZt9lsB0Mx/uy1iTCgriOfg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HEBABZYGJqfCzYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKSIoE/PQIPAQMBCwEBTwIEAQEBAgSEfgKNYAIeBwEEMAkOAQIEAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDhIphk8NSQEQAQQBA?=
 =?us-ascii?q?YIBAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEFAixfAgEDEhULAQ0BGx0BAwwGEDsgAhEBBQEcBgESIoJggiMBBhABAzcCA?=
 =?us-ascii?q?bZXgQJCjDwWBQIWgQGCDQbaaAoZKA11gWMBAgIHCQEKAQGBNwGEdypdA4I6h?=
 =?us-ascii?q?SN1g10leieBGIEQhH6CH4I5hjAEgxwSkioBBwcfEggBHAYIAgJIFRIDBAMEB?=
 =?us-ascii?q?AECCxMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCDBQKKCISAikKAyAKC?=
 =?us-ascii?q?xIPAw0GBRUBAQcGAgIDAQQCBAwCBAUCAgUDAQMCBAYEAwMEAQEIAgItAwEDG?=
 =?us-ascii?q?QgJCAILBREYDAsFAgonAw8BCQMfAxQbCEUIBhYBGgcFBgs3FQUMEQECGwIhB?=
 =?us-ascii?q?B0RCAMBGAQCAgIBCwMBAwEVBAgJBAwCEAoSFQMOAwcPAg0HLgsDAg4CCQgMF?=
 =?us-ascii?q?wICAgYCAwMDCgECAQEBAQEBAQgDAwMCAxkHBgMEBAEEBAMDAgMFAQMDAwUCA?=
 =?us-ascii?q?goGCQEBAQEDAgIIAwcDCgkCBQMbAxwGAQICAwIBAgMGAwcIAw0DBAIDAwMEA?=
 =?us-ascii?q?QICAQEBAgMBAwMEAwEDAwIBAwcCAgMDAwsBAgMDAwUDBQEFAwUCAgMFBQMFA?=
 =?us-ascii?q?gIKAgMDAwIBAwIcAwgDBgMSARADAwYBAwcDBwIEAwgEAwYCAwgDAwIJCAMWB?=
 =?us-ascii?q?gMDAwMFAQICAgMFAwMDCAgEAwMEAgIDDAIGAwMDAgMDBQMDBwIEAgMGAwMDA?=
 =?us-ascii?q?QMDBQECBwIDBwIBCwsIAwIEAgkHCQcBAgMLBAIEBgQNCQQCBAICDwQEBQMDB?=
 =?us-ascii?q?wEBAgECCAUGAwICEQUICgUGAgICHQMhAQMPBgEJBQIBBQ4HBQICChIDBgIDB?=
 =?us-ascii?q?AUFAQMBCgELAQECAwMFBQMDBQcBAgQCBwMDAwQDAwMDAQECAgQGBAMCAwcDA?=
 =?us-ascii?q?wMDAwQDBQUDAgUCBAMFAwcCAwMCAQUKAQQFBAoBAwMDAwUFAwICAwMEAQIEB?=
 =?us-ascii?q?gMEAgMBAggEBgUDAwMFAgMDAgICAwMFAQUCAwMDBAMDAwgHBQMDBQIJAwMJA?=
 =?us-ascii?q?wMLAgIDIQIFAwMDAwYDBwMDBAMDAwcHAgMCAwcDAgUCBwUDAwUDBgEDAgEDA?=
 =?us-ascii?q?wgLGAMLCQgHDAE8DAcKJAQEDCoBBg4UBQQlGWcHBwKNaCOCQAGBDoIogVEBA?=
 =?us-ascii?q?QGSCZJFgTieaUkeCQEGAmCBZ4EKFQovm1+FfBozl1OTGYgEkQQjkXCSR4Q+A?=
 =?us-ascii?q?goHBxEkEoEyOoFcMxojgQFtgUlQAxkPkiOPPQG8VzU1PgEHAgcPAoFzg3aJK?=
 =?us-ascii?q?oEggStJgUwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 b7Kq7Ox3l2r
IronPort-HdrOrdr: A9a23:6tECaak6tFml/1am6rA3/pEtWuDpDfII3DAbv31ZSRFFG/FwWf
 re+cjzsiWE9Qr5PUtLpTnuAtjmfZqxz+8X3WBVB8bbYOCEghrTEGgB1/qF/9SIIUSXnY5gPO
 VbAtND4bXLbGSS5vyKhDVQfexQouWvweSHgaPxwR5WIj2CqJsN0+66MGum+zVNNXB77FMCeq
 ah2g==
X-Talos-CUID: =?us-ascii?q?9a23=3A2a81GWltw/crmb2K+mm+Ydj6kMrXOXKEyFvBCXa?=
 =?us-ascii?q?lMzdOa4+7SF2e2f52ktU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AQ5/hkQ3HhsQFKs29eBs3Z5czezUj5KG8N2wDrIU?=
 =?us-ascii?q?/qdiDC3RKFiiZrAy1e9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152815280"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFyGYZksriGmQiU0AIxgjFWfcpESjOrbDvpBP?=
 =?us-ascii?q?sOeaCihsFP7HtNiF9+0seoCcNGE1OlxlL03aE0W7vB3kGGPoRBPKZ1C1?=
 =?us-ascii?q?gQhqLdtxgo5dJ/7JbMkRcIgn56RNF8yhPk3Rvxba0qJn9RjA32/vqFLT?=
 =?us-ascii?q?gGq7l138RbYtoLyU0mPkQEmg=3D=3D?=
Received: from mail-pj1-f44.google.com ([209.85.216.44])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:46:48 +0200
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so944721a91.0
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832406; x=1785437206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MvMxjqNvpASivPiDAcPmI8PwBsKAarLbQdQ8wRHMWv0=;
        b=GbpGhFLKqKQA7gRorIX5+IRFGnm3IoQJc3ej5s4/uI0AZkzozk8MGvyf+8FtWCJooy
         gH8/7xrxm7DUJnS5HI1F6DzmlVlmhVd+F8FDMt1ebpPYlt6XaxD8MozA5MX4vL4kHmEX
         pY8HZax05c0OcFpOTEt2Zr4VQXPK9hKCfU9ZR6582CKWK4mDtJUl21/jfO45Oz0P4vkO
         beOXf/Hpy3B4beFgGwIP0HwXZZTARW3OL5/GN1+fzyCvm2NntP4LgMuJGEBwoohx99Ty
         buTgi15NPw47jOrklgdE2g9jCjOxOsBs7mvJ6B+odC5WUOWuglkPtAiRGiTt600AlYW7
         jfUw==
X-Gm-Message-State: AOJu0Yyf43Te6GfIJtKGQ3EcH1QJT7ZYxfcq1O9XUAMbkeQyhD6D1V2W
	RGzmLQ5v/D/uSSlaz3fz6XsOLkTqnMc069mHZL3baNacXidVPQfLcJQM
X-Gm-Gg: AR+sD12fVoWj4vCnF0u5q3RFlnXRqiKxz+CCMQhiVYwt6BAlKWLPIldOOHUggFDDjJL
	qRHEGQVmpWxCeZ+imIKpNZ2bDPAhx9bR0L1H5DzFolYoq4T9AoS2DfE4tgPMbY63RpXJ3svrUCY
	A3UGPc53WOLKnKo9iesuQUh6i0PCR3n8/5AVbr5EfziqmMhOBo+vVVMYKxyyzDKfwxGq9vCNJyR
	0h1kJHV/PNS2QIpXGDFsgWt9PAm3Z9LMG0MQaDUBPT7hJ6fJWo8QkHOYMboPtO3faybkIweqhRL
	CzlnQhfLR7rD/yMb/AbNQJlViFYrJYiyGhUJzouipAl2udfD5M3ZvBjcqzT7hPWe+G0k1WZjc43
	0PnrSz55YeIBX5qSs7DKPWjdD+KSOHQC0V8uzBO7+afMOn/R2y1kYw0aGjcvoLKjA5aKLPUmL
X-Received: by 2002:a17:90b:3904:b0:38e:584f:2515 with SMTP id 98e67ed59e1d1-38ec6aae88emr4263344a91.37.1784832406282;
        Thu, 23 Jul 2026 11:46:46 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:45 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>
Cc: cocci@inria.fr,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qat-linux@intel.com
Date: Fri, 24 Jul 2026 03:45:20 +0900
Message-ID: <20260723184538.3888637-19-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 18/36] crypto: drivers - remove conditional return
 with no effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3615
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/EMehAazZN_IKZ_0t97WEmA>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/crypto/intel/qat/qat_common/adf_gen2_config.c   | 8 ++------
 drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c | 7 +------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen2_config.c b/drivers/crypto/intel/qat/qat_common/adf_gen2_config.c
index c27ff6d18e11..57025bffee73 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen2_config.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen2_config.c
@@ -155,12 +155,8 @@ static int adf_gen2_comp_dev_config(struct adf_accel_dev *accel_dev)
 	}
 
 	val = i;
-	ret = adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC, ADF_NUM_DC,
-					  &val, ADF_DEC);
-	if (ret)
-		return ret;
-
-	return ret;
+	return adf_cfg_add_key_value_param(accel_dev, ADF_KERNEL_SEC,
+					   ADF_NUM_DC, &val, ADF_DEC);
 
 err:
 	dev_err(&GET_DEV(accel_dev), "Failed to add configuration for compression\n");
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c b/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c
index 95f3de3a34eb..1542a110ba37 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c
@@ -235,7 +235,6 @@ int otx2_cpt_lf_reset_msg(struct otx2_cptlfs_info *lfs, int slot)
 	struct otx2_mbox *mbox = lfs->mbox;
 	struct pci_dev *pdev = lfs->pdev;
 	struct cpt_lf_rst_req *req;
-	int ret;
 
 	req = (struct cpt_lf_rst_req *)otx2_mbox_alloc_msg_rsp(mbox, 0, sizeof(*req),
 							       sizeof(struct msg_rsp));
@@ -248,11 +247,7 @@ int otx2_cpt_lf_reset_msg(struct otx2_cptlfs_info *lfs, int slot)
 	req->hdr.sig = OTX2_MBOX_REQ_SIG;
 	req->hdr.pcifunc = 0;
 	req->slot = slot;
-	ret = otx2_cpt_send_mbox_msg(mbox, pdev);
-	if (ret)
-		return ret;
-
-	return ret;
+	return otx2_cpt_send_mbox_msg(mbox, pdev);
 }
 EXPORT_SYMBOL_NS_GPL(otx2_cpt_lf_reset_msg, "CRYPTO_DEV_OCTEONTX2_CPT");
 
-- 
2.43.0

