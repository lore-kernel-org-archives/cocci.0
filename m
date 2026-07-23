Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558DBC531FA
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+53O0vXfEk/QFHYiZ5anDwDOO58yxuSoKuAHDn4vUGA=;
  b=SWLMlksjc2aqDz/aFa3caDk5+x9jdf/qEC5Mj2Ixqr2p4WDoWYysWbxg
   pRVmOCm0jNG1vCq9TWiEtmbVAQxFMp2PgqFYcLDj8Pj7MSbpBquOkmhSM
   ITRCN9Ofr9nFYQM1QzbOMmxPos4jEdb5pK3KGfxermWHh+vMHF5tLbYNV
   g=;
X-CSE-ConnectionGUID: tWKIyUG7TBe2KkXkYxCEYQ==
X-CSE-MsgGUID: Psl8+FUKSv+wm7itiNHmwA==
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
   d="scan'208";a="287733599"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:17 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id DA9E4803C8; Fri, 24 Jul 2026 10:54:16 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 40C76819A4
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:46:46 +0200 (CEST)
X-CSE-ConnectionGUID: cVY40w+MSSqonv0GUvG/eg==
X-CSE-MsgGUID: NDDwqUmZTJWUDB4SuFijFA==
IronPort-SDR: 6a626195_tAhf3GiwO+5ldZY3OgVQge4C5mEMBfVmKRnHqR0+ExaEa1q
 kUnyYZFlyjl9fZKL3xwZL3HNmN7ge+Bz2HMDikw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0G9BgBZYGJqfDLYVdFaglkCghYpFoFTMwRUlQcGim+CG?=
 =?us-ascii?q?TACkiKBPz0CDwEDAQsBAU8CBAEBAQIEOAaEQAKNYAIeBwEEMgcOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDhIphk8NSQEQA?=
 =?us-ascii?q?QQBAYIBAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEFAixfAgEDEhULAQ0BGx0BAwwGEDsgAhEBBQEcBgESIoIIWIIjAQYQA?=
 =?us-ascii?q?QM3AgG2V4ECQow8FgUCFoEBgg0G2mgKGSgNdYFjAQICBwkBCgEBgTcBhHcqX?=
 =?us-ascii?q?QOCOoUjdYQCeieBGIEQgRWDaYIfgjmGMASDLpIqAQcHHxIIARwGCAICSBUSA?=
 =?us-ascii?q?wQDBAQBAgsTCQMDAg4CCAMCCAYZAT8SBBMCCAMGBAsHBR8KAgwUCigiEgIpC?=
 =?us-ascii?q?gMqCxIPAw0GBRUBCAYCAgQEAgQMAgkCAgUDBAIEDQMEAQEIAgItAwEDGQgJC?=
 =?us-ascii?q?AILBREYDAsFAgonAw8BCQMfAxQbCEUIBhYBGgcFBgs3FQUMEQECGwIhBB0RC?=
 =?us-ascii?q?AMBGAQEAgELAwEDARUECAkEDAIQChIVAw4DBw8CDQcuCwMCDgIJCAwXAgICB?=
 =?us-ascii?q?gIDAwMKAQIBAQEBAQEBCAMDAwIDGQcGAwQEAQQEAwMCAwUBAwMDBQICCgYJA?=
 =?us-ascii?q?QEBAQMCAggDBwMKCQIFAxsDHAYBAgIDAgECAwYDBwgDDQMEAgMDAwQBAgIBA?=
 =?us-ascii?q?QECAwEDAwQDAQMDAgEDBwICAwMDCwECAwMDBQMFAQUDBQICAwUFAwUCAgoCA?=
 =?us-ascii?q?wMDAgEDAhwDCAMGAxIBEAMDBgEDBwMHAgQDCAQDBgIDCAMDAgkIAxYGAwMDA?=
 =?us-ascii?q?wUBAgICAwUDAwMICAQDAwQCAgMMAgYDAwMCAwMFAwMHAgQCAwYDAwMBAwMFA?=
 =?us-ascii?q?QIHAgMHAgELCwgDAgQCCQcJBwECAwsEAgQGBA0JBAIEAgIPBAQFAwMHAQECA?=
 =?us-ascii?q?QIIBQYDAgIRBQgKBQYCAgIdAyEBAw8GAQkFAgEFDgcFAgIKEgMGAgMEBQUBA?=
 =?us-ascii?q?wEKAQsBAQIDAwUFAwMFBwECBAIHAwMDBAMDAwMBAQICBAYEAwIDBwMDAwMDB?=
 =?us-ascii?q?AMFBQMCBQIEAwUDBwIDAwIBBQoBBAUECgEDAwMDBQUDAgIDAwQBAgQGAwQCA?=
 =?us-ascii?q?wECCAQGBQMDAwUCAwMCAgIDAwUBBQIDAwMEAwMDCAcFAwMFAgkDAwkDAwsCA?=
 =?us-ascii?q?gMhAgUDAwMDBgMHAwMEAwMDBwcCAwIDBwMCBQIHBQMDBQMGAQMCAQMDCAsYA?=
 =?us-ascii?q?wsJCAcMATwMBwokBAQMKgEGDhQFBCUZZwcHAo1oI4JAAYEOgTB4DoFDAQEBk?=
 =?us-ascii?q?hKSPKAhSR4JAQYCYIFngQoVCi+bX4V8GjOXU5MZmQgjkXCSR4Q+AgoHBxEkE?=
 =?us-ascii?q?oE5DiWBXDMaI4EBbYFJUAMZD44tFoNgzBU1NT4BBwIHDwKBc4N2a4g/gSCBK?=
 =?us-ascii?q?0mBTAEB?=
IronPort-PHdr: A9a23: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
 Zz16nwdg0Rsa9k6IaGWL61MnAA4uw==
IronPort-Data: A9a23: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
 E4bn1ew3l0=
IronPort-HdrOrdr: A9a23:HaSypakR2BEfhK+3Ooi3l5ks2nvpDfII3DAbv31ZSRFFG/FwWf
 re+cjzsiWE9Qr5PUtLpTnuAtjmfZqxz+8X3WBVB8bbYOCEghrTEGgB1/qF/9SIIUSXnY5gPO
 VbAtND4bXLbGSS5vyKhDVQfexQouWvweSHgaPxwR5WIj2CqJsN0+66MGum+zVNNXB77FMCeq
 ah2g==
X-Talos-CUID: =?us-ascii?q?9a23=3AGRreYGmFYGZjRZnwdmVggtmDqkzXOXbj/SuIPAy?=
 =?us-ascii?q?dMl1wT7uLEXCt5owjnsU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A7xtF/AwiOQZ9Yh/WNpAxNrpdpgWaqIKCJF8UrJA?=
 =?us-ascii?q?0h+u7CABaZwyAojW1bKZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152815277"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGxMbZhbgycgo6yh19ZumG/oTpxl+OQ/kGaQc?=
 =?us-ascii?q?2qcc+vCJ6WpwbGkML2byVvdi3bQ5S+NqvJvvqQNJFOfBfzTTF06+FNss?=
 =?us-ascii?q?har7JTBYlQASCNreGiLpdPPNGyI7QGGNsIRB+ZsiToVdkaDrIVyhoSX4?=
 =?us-ascii?q?IaKdH4yJ2VwAMuQLVlVcPRHA=3D=3D?=
Received: from mail-pj1-f50.google.com ([209.85.216.50])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:46:46 +0200
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so799123a91.0
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832404; x=1785437204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+53O0vXfEk/QFHYiZ5anDwDOO58yxuSoKuAHDn4vUGA=;
        b=LJs2IIze2C3402B/Wgoa6cFi2j7hrX5pBNpu3PmEeiLWj7gv78WuL1L8SvWCboeyyZ
         aAHtkGxAVT0jXgXDl5uHsdGsrDSKZUSmD/nO3eFv0WVtmHPbFgx+35GMPsengIDu5nnc
         ZebRp0EnatSBeWwy2b/hDEmsewY3zozUdgGQFXLf+h22RSzBfFbWoHH0hvxf6bM6jDJl
         grKkBIft+10YMkvPVPtOyo0MMCLPciWp+NfSU/8jvwXKDDJFfEo+wqCo35HHi7A3/RH1
         X/e17X1e+f8kKaRxhWqvqgmdJwpE0EmMDz8UealVtMrgqkM0DAyOhE6qzTfUwXDxAIhq
         /xzw==
X-Gm-Message-State: AOJu0Ywt7TLVArJYW0OcIe3ER1WyyhcDHbilQONe+pS8hX93sXft7gEO
	FWwYI8HFsV8x53dgtj+5QX/LHR0t60DuU/FR7IebAVHaS2bYmUafjWH3
X-Gm-Gg: AR+sD1096q7ql0WB4ezg4pP1oX4ckxSpIeoNHrqEQUZNV2B3EkiSf5Vg90g61YBHUWn
	cS6LFsX27snnYFt8Cxb3AxAbb0SbVfll0/TlRZlVIInldlkyTx7351yIG1PYazr96tsh2rhcCnp
	WC4bx8mg5SFUImMYhOKZmjj/GdWJ6hzSkaE23wBVHqcdjJ4BRrOuQPIuOu8PtE4EdfyrXLMVmtV
	2XzFnxatNLzTxzKpxj2OFUajti+JwHSRFjBGVAJUmHV/kKyUTa4CqSq3w3auwra7hHv0eLu2uvl
	AcAsp80NEmRu6QP1WeFiW0zgtM6EWfvvMs8NuxccNh9vORI623CE+SJULhJbPbJGi5A+krcmxdn
	Qyn4yz20LNauxf6uGb//2vILmY8/HYTZOup68Y6C7F0di0fznLSaSXImUTqX+XmUUydYpY9ft
X-Received: by 2002:a17:90b:2d10:b0:37f:9cdf:f03e with SMTP id 98e67ed59e1d1-38ec6632b70mr4099341a91.33.1784832403772;
        Thu, 23 Jul 2026 11:46:43 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:43 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: cocci@inria.fr,
	Brian Masney <bmasney@redhat.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:19 +0900
Message-ID: <20260723184538.3888637-18-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 17/36] clk: remove conditional return with no effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3614
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/SPXBwmTBiNlwIMck-6NOeg>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

In the lmk04832 driver, the hardware sequence comments are moved
above the final return by hand.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/clk/clk-cs2000-cp.c |  6 +-----
 drivers/clk/clk-lmk04832.c  | 12 ++++--------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/clk-cs2000-cp.c b/drivers/clk/clk-cs2000-cp.c
index 8800472ba63f..4de581771d7d 100644
--- a/drivers/clk/clk-cs2000-cp.c
+++ b/drivers/clk/clk-cs2000-cp.c
@@ -404,11 +404,7 @@ static int cs2000_enable(struct clk_hw *hw)
 	if (ret < 0)
 		return ret;
 
-	ret = cs2000_wait_pll_lock(priv);
-	if (ret < 0)
-		return ret;
-
-	return ret;
+	return cs2000_wait_pll_lock(priv);
 }
 
 static void cs2000_disable(struct clk_hw *hw)
diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
index 9bf86caad829..f006401c1586 100644
--- a/drivers/clk/clk-lmk04832.c
+++ b/drivers/clk/clk-lmk04832.c
@@ -822,13 +822,6 @@ static int lmk04832_sclk_sync_sequence(struct lmk04832 *lmk)
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(lmk->regmap, LMK04832_REG_SYNC,
-				 LMK04832_BIT_SYNC_MODE,
-				 FIELD_PREP(LMK04832_BIT_SYNC_MODE,
-					    lmk->sync_mode));
-	if (ret)
-		return ret;
-
 	/*
 	 * 9. (optional) if SCLKx_y_DIS_MODE was used to mute SYSREF outputs
 	 *    during the SYNC event, restore SCLKx_y_DIS_MODE=0 for active state,
@@ -843,7 +836,10 @@ static int lmk04832_sclk_sync_sequence(struct lmk04832 *lmk)
 	 *     SYNC pulse to delay the output by some number of VCO counts).
 	 */
 
-	return ret;
+	return regmap_update_bits(lmk->regmap, LMK04832_REG_SYNC,
+				  LMK04832_BIT_SYNC_MODE,
+				  FIELD_PREP(LMK04832_BIT_SYNC_MODE,
+					     lmk->sync_mode));
 }
 
 static int lmk04832_sclk_is_enabled(struct clk_hw *hw)
-- 
2.43.0

