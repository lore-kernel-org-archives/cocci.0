Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC85C531FA
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kxRvmx1wxGvV8pBQOXsif8sDMDGk8D/ZvwH0veNhWow=;
  b=rH9Wf0Z2Znx5L0G60c8vA4z3XJVR1XrywKt3BnwmOAT3+2U3J591/ITe
   G7ZBloqKCINdJqmX5qliEaO2ci8+nr1E/WlF22XSm5Xtj2PR8fYXFo/Sw
   /CEc4dU4ROYQHvwGqOl+42KbLPx4NfLwOquwjXng+4MPe1tdqpxQlpXLw
   A=;
X-CSE-ConnectionGUID: tj2sYiugQOCpM6z0OIjuOQ==
X-CSE-MsgGUID: dDuTl9ZUSB+AUXOJCtgbag==
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
   d="scan'208";a="287733281"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:04 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id E61848040A; Fri, 24 Jul 2026 10:54:03 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 74FBB81964
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:46:24 +0200 (CEST)
X-CSE-ConnectionGUID: vBCrJhrRQDyRWM5me8UhMg==
X-CSE-MsgGUID: cYD0uhVKSI+bBr0gxsUP0Q==
IronPort-SDR: 6a626180_um3q+MrYG18OJf8aT8SOOfsqunR+m2qhCyIwFCuBhG3V4eI
 L+NazSA7EeC2mpSyllMWPIWYI5PsCwcu8gkgWEQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HFBABZYGJqfCzYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKSIoE/PQIPAQMBCwEBTwIEAQEBAgQ4hEYCjWACHgcBBDAJDgECBAMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABASIZBw4SKYZPDUkBEAEEA?=
 =?us-ascii?q?QGCAQGBJGECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBBQIsXwIBAxIVCwENARsdAQMMBhA7IAIRAQUBHAYBEiKCYIIjAQYQAQM3A?=
 =?us-ascii?q?gG2V4ECQow8FgUCFoEBgg0G2mgKGSgNdYFjAQICBwkBCgEBgTcBhHcqXQOCO?=
 =?us-ascii?q?oUjdYQCeieBGIEQhH6CH4I5hjAEgxwSkioBBwcfEggBHAYIAgJIFRIDBAMEB?=
 =?us-ascii?q?AECCxMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCDBQKKCISAikKAyAKC?=
 =?us-ascii?q?xIPAw0GBRUBAQcGAgIDAQQCBAwCBAUCAgUDAQMCBAYEAwMEAQEIAgItAwEDG?=
 =?us-ascii?q?QgJCAILBREYDAsFAgonAw8BCQMfAxQbCEUIBhYBGgcFBgs3FQUMEQECGwIhB?=
 =?us-ascii?q?B0RCAMBGAQCAgIBCwMBAwEVBAgJBAwCEAoSFQMOAwcPAg0HLgsDAg4CCQgMF?=
 =?us-ascii?q?wICAgYCAwMDCgECAQEBAQEBAQgDAwMCAxkHBgMEBAEEBAMDAgMFAQMDAwUCA?=
 =?us-ascii?q?goGCQEBAQEDAgIIAwcDCgkCBQMbAxwGAQICAwIBAgMGAwcIAw0DBAIDAwMEA?=
 =?us-ascii?q?QICAQEBAgMBAwMEAwEDAwIBAwcCAgMDAwsBAgMDAwUDBQEFAwUCAgMFBQMFA?=
 =?us-ascii?q?gIKAgMDAwIBAwIcAwgDBgMSARADAwYBAwcDBwIEAwgEAwYCAwgDAwIJCAMWB?=
 =?us-ascii?q?gMDAwMFAQICAgMFAwMDCAgEAwMEAgIDCgICBgMDAwIDAwUDAwcCBAIDBgMDA?=
 =?us-ascii?q?wEDAwUBAgcCAwcCAQsLCAMCBAIJBwkHAQIDCwQCBAYEDQkEAgQCAg8EBAUDA?=
 =?us-ascii?q?wcBAQIBAggFBgMCAhEFCAoFBgICAh0DIQEDDwYBCQUCAQUOBwUCAgoSAwYCA?=
 =?us-ascii?q?wQFBQEDAQoBCwEBAgMDBQUDAwUHAQIEAgcDAwMEAwMDAwEBAgIEBgQDAgMHA?=
 =?us-ascii?q?wMDAwMEAwUFAwIFAgQDBQMHAgMDAgEFAwEGAQQFBAoBAwMDAwUFAwICAwMEA?=
 =?us-ascii?q?QIEBgMEAgMBAggEBgUDAwMFAgMDAgICAwMFAQUCAwMDBAMDAwgHBQMDBQIJA?=
 =?us-ascii?q?wMJAwMLAgIDIQIFAQIDAwMGAwcDAwQDAwMHBwIDAgMHAwIFAgcFAwMFAwYBA?=
 =?us-ascii?q?wIBAwMICxgDCwkIBwwBPAwHCiQEBAwqAQYOFAUEJRlnBwcCjWgjgU5xAQGBD?=
 =?us-ascii?q?oIogVEBAQGkTqAhSR4JAQYCYIFngQoVCi+bX4V8GjOXU5MZmQgjkXCSR4Q+A?=
 =?us-ascii?q?goHBxEkEoEyOoFcMxojgQFtgUlQAxkPji0Wg2DMFTU1PgEHAgcPAoFzg3aJK?=
 =?us-ascii?q?oEggStJgUwBAQ?=
IronPort-PHdr: A9a23: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
 +SPzjI=
IronPort-Data: A9a23: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
 avLelaw
IronPort-HdrOrdr: A9a23:3pO7oaGsvMBh1RIMpLqEzMeALOsnbusQ8zAXPo5KOHlom6uj5r
 2TdZEgvyMc5wxhP03I9erwW5VoBEmsjaKdgrNhR4tKPjOW3ldARbsKheCD/9SjIVyEygc078
 ZdmsNFebnN5DZB/KTHyTj9PdJl7tfvys+VbCTlo0uFjzsGV0gZ1XYBNu9TKCNLeDU=
X-Talos-CUID: =?us-ascii?q?9a23=3AM4omkWoenRytKzG7vqiDHF7mUd4PWWf/zG3qGmO?=
 =?us-ascii?q?pM1lMFbiYGWKQ3awxxg=3D=3D?=
X-Talos-MUID: 9a23:Hq7A6AuAaiQ6jJWGg82njwBObNpo3YeVKQMHu49etNmfCBQoAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152815254"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGk2CdTdyaX8aj7e3ehd+eKZ71B8YPn4sFd6d?=
 =?us-ascii?q?5KbVCob0SldCtCffewrR7mmIxMlWWKJEnS8aA0F8JhB88Zay3nfdqgr+?=
 =?us-ascii?q?WI+VB4xEwlgIHjx+f2E+KSBxV6Q9VBifgWPkLB760WXrrLRHqv0BKWpm?=
 =?us-ascii?q?ZvhSjurH+4L4ydbB+vr/41yQ=3D=3D?=
Received: from mail-pj1-f44.google.com ([209.85.216.44])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:46:24 +0200
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38511175ad3so736236a91.2
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832382; x=1785437182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kxRvmx1wxGvV8pBQOXsif8sDMDGk8D/ZvwH0veNhWow=;
        b=N5mUSS8Bhcy9Z7yzLHe7j/YTcFlCiHGbiPd6+tCcbvUSomtqZZUyFZt8w3E/JWpLbZ
         xSxc/ZTJr/36ySD8vZqcGmFEcvTZoSzvEGIx/3Yx7IIAa4kkGmlxKEzL+BSMT0qkza48
         nAXzei9co0wV4rlFJu7e2DgAhw/NKWP01wvpalChjA5zYlvKcNPYw6hZ0qK7rqvEoIVY
         ANFRdLx1XHITLTMFqkruItjpdYb2vwLlaM1f2mhe+s6CrlXCfzp9Yb7oDHWnCn+A7nqI
         N2540HGe/ldYbnCVPTZLipmDoo91l7t1e988AOYuDbZXNYuuZlpRKhKTOsthtP4B7UZM
         7CBQ==
X-Gm-Message-State: AOJu0YyBXqDFkgs8UELjFZzYkMGMhA0m+30xCQcpLUdsV4Ogac6+W9P7
	yQm++2bQwI9thIzzrAzEmf2tzEexPoO49TfyTOWvHgt7wCGLIsl0DeKz
X-Gm-Gg: AR+sD11pvHyz0IRXrP+BFOiuiACrf3eGem7t5jrgK9XA1zfIl6xRHCJKThw9qWXWwgm
	ldxXZbyfYffAqsl6pPkff5zdsr5UshEyPszHutjCdlBVzJlnMJ6TckLuCTeTG0c9h6YX9WZLmrX
	iXTmOZvl8BZLIv+wS/Dh0V6QMMuWrp3z8SYXm+ns8sIVPZrXK6a5UXnd/Q9rCRcDZQ7gHwdQdAN
	C+2fkgWpZgo0RLiu7rOWfF09d3Zd+XiNb5B2RdcNTD7umKwD18mPMePVKi4CEjdiuzqgppfzDtr
	/cy1Of7WBMC2RCV+ISC0XZEkFwysNikNiDwG9SwAA8P7gJ6KxrigUwnLAbZAG2lCDL6gCadUbtf
	4xHnza7rpMoLnfScwrBH6Btd87zXBSJrjcRGt5fEUzoaUwAo41h0uGRNwCMDvqFSBzadWe0Y4mX
	2GDsjci0g=
X-Received: by 2002:a17:90b:53c4:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-38ec64f3415mr4603537a91.14.1784832381937;
        Thu, 23 Jul 2026 11:46:21 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:21 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: cocci@inria.fr,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:11 +0900
Message-ID: <20260723184538.3888637-10-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 09/36] net: intel: remove conditional return with no
 effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3606
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/4hrL3Y69HrKaPLd3jY3PqQ>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 +-------
 drivers/net/ethernet/intel/igb/e1000_i210.c | 6 +-----
 drivers/net/ethernet/intel/igc/igc_phy.c    | 6 +-----
 3 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a04683004a56..0cd0e5597c90 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4864,16 +4864,10 @@ static void i40e_control_rx_q(struct i40e_pf *pf, int pf_q, bool enable)
  **/
 int i40e_control_wait_rx_q(struct i40e_pf *pf, int pf_q, bool enable)
 {
-	int ret = 0;
-
 	i40e_control_rx_q(pf, pf_q, enable);
 
 	/* wait for the change to finish */
-	ret = i40e_pf_rxq_wait(pf, pf_q, enable);
-	if (ret)
-		return ret;
-
-	return ret;
+	return i40e_pf_rxq_wait(pf, pf_q, enable);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/igb/e1000_i210.c b/drivers/net/ethernet/intel/igb/e1000_i210.c
index 9db29b231d6a..784f9a7bcbed 100644
--- a/drivers/net/ethernet/intel/igb/e1000_i210.c
+++ b/drivers/net/ethernet/intel/igb/e1000_i210.c
@@ -756,11 +756,7 @@ static s32 __igb_access_xmdio_reg(struct e1000_hw *hw, u16 address,
 		return ret_val;
 
 	/* Recalibrate the device back to 0 */
-	ret_val = hw->phy.ops.write_reg(hw, E1000_MMDAC, 0);
-	if (ret_val)
-		return ret_val;
-
-	return ret_val;
+	return hw->phy.ops.write_reg(hw, E1000_MMDAC, 0);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
index 4cf737fb3b21..b758a7e0f013 100644
--- a/drivers/net/ethernet/intel/igc/igc_phy.c
+++ b/drivers/net/ethernet/intel/igc/igc_phy.c
@@ -675,11 +675,7 @@ static s32 __igc_access_xmdio_reg(struct igc_hw *hw, u16 address,
 		return ret_val;
 
 	/* Recalibrate the device back to 0 */
-	ret_val = hw->phy.ops.write_reg(hw, IGC_MMDAC, 0);
-	if (ret_val)
-		return ret_val;
-
-	return ret_val;
+	return hw->phy.ops.write_reg(hw, IGC_MMDAC, 0);
 }
 
 /**
-- 
2.43.0

