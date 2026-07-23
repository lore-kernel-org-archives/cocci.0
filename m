Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F28EC53209
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=POBnk8e7cjMk5Mm303buRI06BRywbPO3M0j5oTpXzt4=;
  b=bfNx8ro2gBcAnXQt3BLM1ykZ+Djdq8R4Z9SSXXxTEFkUQKd8LqNqjMFj
   XsH5KVYdpvVAMqHnvHD3MxYg8JPsNvWGf/Pr9YtB13efZBgO6UIclVabt
   5WehhvjUYhL1RfudvGVOWsHrdgnMKb4UXhFzYPqvdGroVnlf4z80ZbHmt
   k=;
X-CSE-ConnectionGUID: Pv1GySgcRpiE3+iU/2bTrw==
X-CSE-MsgGUID: 9ZVCRWs6SludagJdtFsPEw==
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
   d="scan'208";a="287733341"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:06 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 0C764803D0; Fri, 24 Jul 2026 10:54:06 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7D25D819F5
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:46:26 +0200 (CEST)
X-CSE-ConnectionGUID: G8UsWpuAR1S8Kyf6SfDEXQ==
X-CSE-MsgGUID: 5PNAv4sVStyr4ELTu3fErg==
IronPort-SDR: 6a626182_+HXHdSbv8H6aADjc66dJIpSj7YjYlrO88q06sazMLXek2sO
 49n4s3nRva/Tftm1a1spb4nrP28wzkrBAm7vXCw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HEBABZYGJqfCnYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKSIoE/PQIPAQMBCwEBTwIEAQEBAgQ4hEYCjWACHgcBBDAJDgECBAMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABASIZBw4SKYZPDUkBEAEEA?=
 =?us-ascii?q?QGCAQGBJGECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBBQIsXwIBAxIgAQ0BGx0BAwwGEDsgAhEBBQEcBgESIoJggiMBBhABAzcCA?=
 =?us-ascii?q?bZXgQJCjFIFAhaBAYINBtpoChkoDXWBYwECAgcJAQoBAYE3AYR3Kl0DgjqFI?=
 =?us-ascii?q?3WEAnongRiBEIR+gh+COYYwBIMukioBBwcfEggBHAYIAgJIFRIDBAMEBAECC?=
 =?us-ascii?q?xMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCDBQKKCISAikKAyoLEg8DD?=
 =?us-ascii?q?QYFFQEIBgICBAQCBAwCCQICBQMEAgQNAwQBAQgCAi0DAQMZCAkIAgsFERgMC?=
 =?us-ascii?q?wUCMQMPAQkDHwMUGwhFCAYWARoHBQYLNxUFDBEBAhsCIQQdEQgDARgEBAIBC?=
 =?us-ascii?q?wMBAwEVBAgJBAwCEAoSFQMOAwcPAg0HLgsDAg4CCQgMFwICAgYCAwMDCgECA?=
 =?us-ascii?q?QEBAQEBAQgDAwMCAxkHBgMEBAEEBAMDAgMFAQMDAwUCAgoGCQEBAQEDAgIIA?=
 =?us-ascii?q?wcDCgkCBQMbAxwGAQICAwIBAgMGAwcIAw0DBAIDAwMEAQICAQEBAgMBAwMEA?=
 =?us-ascii?q?wEDAwIBAwcCAgMDAwsBAgMDAwUDBQEFAwUCAgMFBQMFAgIKAgMDAwIBAwIcA?=
 =?us-ascii?q?wgDBgMSARADAwYBAwcDBwIEAwgEAwYCAwgDAwIJCAMWBgMDAwMFAQICAgMFA?=
 =?us-ascii?q?wMDCAgEAwMEAgIDDAIGAwMDAgMDBQMDBwIEAgMGAwMDAQMDBQECBwIDBwIBC?=
 =?us-ascii?q?wsIAwIEAgkHCQcBAgMLBAIEBgQNCQQCBAICDwQEBQMDBwEBAgECCAUGAwICE?=
 =?us-ascii?q?QUICgUGAgICHQMhAQMPBgEJBQIBBQ4HBQICChIDBgIDBAUFAQMBCgELAQECA?=
 =?us-ascii?q?wMFBQMDBQcBAgQCBwMDAwQDAwMDAQECAgQGBAMCAwcDAwMDAwQDBQUDAgUCB?=
 =?us-ascii?q?AMFAwcCAwMCAQUKAQQFBAoBAwMDAwUFAwICAwMEAQIEBgMEAgMBAggEBgUDA?=
 =?us-ascii?q?wMFAgMDAgICAwMFAQUCAwMDBAMDAwgHBQMDBQIJAwMJAwMLAgIDIQIFAwMDA?=
 =?us-ascii?q?wYDBwMDBAMDAwcHAgMCAwcDAgUCBwUDAwUDBgEDAgEDAwgLGAMLCQgHDAE8D?=
 =?us-ascii?q?AcKJAQEDCoBBg4UBQQlGWcHBwKNaCOBTnIBgQ57gS2BUQEBAZITkjugIUkeC?=
 =?us-ascii?q?QEGAmCBZ4EKFQovm1+FfBozl1OTGZkII5FwkkeEPgIKBwcRJBKBMjqBXDMaI?=
 =?us-ascii?q?4EBbYFJUAMZD44tFoNgzBU1NT4BBwIHDwKBc4N2iSqBIIErSYFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 E4=
IronPort-HdrOrdr: A9a23:opxXjKojACEM9Im03SPRFBwaV5oPeYIsimQD101hICG9vPbo8v
 xG+85rqCMc7Qx6ZJhOo6HmBEDtewK+yXcx2/hoAV7AZnidhILLFvAF0WKK+VSJcE3DH6xmpN
 xdmsBFaeEYZmIK6foSjjPIceoI8Z2o9OSHi47loEuFjjsHV0ij1WpE436gYzRLrcB9a6YEKA
 ==
X-Talos-CUID: 9a23:JxtSzWBHdVh1zfz6EwY3yVUrAt0MSCTmnFTBLRGDB0pEeITAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3A0+sv0wxkkRU06AS7GDAFZHexA62aqPmWLmkTzY4?=
 =?us-ascii?q?4gNWVL3BdHwuA1zqaWIByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152815258"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGnea2VTTYdsdvorD90bOZVhhZipbd/QEGzjc?=
 =?us-ascii?q?C2KY47TLcmLkhdD2QyPLpZkoPUaOpZtJmPD0weyqAwJI4OSmuhrO+Vfc?=
 =?us-ascii?q?r4W+eNjF993AuBAoqPZW+bEugPGAeV2XxYmctt3fhJ3NFFiIaIH4L4qO?=
 =?us-ascii?q?ElZWUpPuJySKZp1sz32goMKg=3D=3D?=
Received: from mail-pj1-f41.google.com ([209.85.216.41])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:46:26 +0200
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so689988a91.1
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832384; x=1785437184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=POBnk8e7cjMk5Mm303buRI06BRywbPO3M0j5oTpXzt4=;
        b=DzvOlEpttbgOs19OV4KILg3ZJ9fhMm30sEYh8IinSd8PR2q6qMwZEpm4krTEOpj+L5
         ruDcHyf+9kmQMl95exCAPOPpT0U5VtkRK8jqjguKNDzH0F1yFc69r3aWlryYLVv8obw+
         sDseg14HqivMmtYXdUcl0d5AgLg4Cd/QXhqwiylvLb3kfbOYMg32Y6tRPuExNgojyW8m
         Qc7EtNA4uU44slIG0c5cd5NQEI0WE4kGnmJpXRNuGO34UV8Aex4vFZcVZnJgvBG2BCVV
         DC6/djne+Ot6/Geu94gl4yX9QgMpyWo6r7ugWdQg1MusnzppOn0/S+9XPG2n87eG4Snk
         JJmg==
X-Gm-Message-State: AOJu0YxezoouefIutrGKB9teFbUgeNgaBUjjdUp7At1yFGzdJ4U+qWk2
	6Wz8KjnMQ5vUWLPe/5oYOo1F61EfJtIxVMEWvsOiC9bQMLvK99jOfti7
X-Gm-Gg: AR+sD10g+9owLBXa2BUr8kXsdbcUuH7DJVmOyNo1qDc3DfnVbNJi2n3SsiRSaIlMEUo
	Kf3C+bFsrzLR1YZgMghvS7lZKC96WxZk4z0B5OUDVJ1qdSD3fhFrAdqtXCj9VWrWeQ8HTO9dGAs
	OmsXOSwW+lXZl/Q/BFLuViEaejkRSoDY4Q0VOkYM+qOcsQ/8mRN0p5sFXxwJc//CPmcJla+eckl
	BsIjPARyJn8Ej6y4u91qFU1OVgrbl4JR+eedQGD2hgCl+MUJSDwC4DNaxt/FpN4YIdQK1KIocPg
	oQEfrfde//dV8vJsBB5g+TG2EJgAe46NPz7XYAvEKzMPAPmra9uey1nn3ykGAlJCedRVO9sr4GG
	mFk012K5DLrUyfOhJEvhel5GsUnKPuEyh01cKVxOxgsC+fa8pB2Vud6SJDX0pztoknLZRAINLvQ
	ko8LlmEWk=
X-Received: by 2002:a17:90b:314e:b0:381:5a08:6291 with SMTP id 98e67ed59e1d1-38ec658fc68mr3549005a91.20.1784832383927;
        Thu, 23 Jul 2026 11:46:23 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:23 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:12 +0900
Message-ID: <20260723184538.3888637-11-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 10/36] wifi: remove conditional return with no
 effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3607
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/bBrWbfcn8jsBN4Ldv1BF3w>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/net/wireless/ath/ath6kl/init.c              | 6 +-----
 drivers/net/wireless/intel/iwlwifi/mvm/link.c       | 6 +-----
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c | 7 +------
 drivers/net/wireless/realtek/rtw89/mac.c            | 6 +-----
 drivers/net/wireless/realtek/rtw89/mac_be.c         | 6 +-----
 5 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/init.c b/drivers/net/wireless/ath/ath6kl/init.c
index 782209dcb782..61fa10d88714 100644
--- a/drivers/net/wireless/ath/ath6kl/init.c
+++ b/drivers/net/wireless/ath/ath6kl/init.c
@@ -1566,11 +1566,7 @@ static int ath6kl_init_upload(struct ath6kl *ar)
 
 	address = MBOX_BASE_ADDRESS + LOCAL_SCRATCH_ADDRESS;
 	param = options | 0x20;
-	status = ath6kl_bmi_reg_write(ar, address, param);
-	if (status)
-		return status;
-
-	return status;
+	return ath6kl_bmi_reg_write(ar, address, param);
 }
 
 int ath6kl_init_hw_params(struct ath6kl *ar)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index b5d252ece2d9..76a548f9aea2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -278,11 +278,7 @@ int iwl_mvm_disable_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (ret)
 		return ret;
 
-	ret = iwl_mvm_remove_link(mvm, vif, link_conf);
-	if (ret)
-		return ret;
-
-	return ret;
+	return iwl_mvm_remove_link(mvm, vif, link_conf);
 }
 
 void iwl_mvm_init_link(struct iwl_mvm_vif_link_info *link)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
index 9b119a51bc30..1ba53e671207 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
@@ -1462,12 +1462,7 @@ static bool _rtl8821ae_init_llt_table(struct ieee80211_hw *hw, u32 boundary)
 			return status;
 	}
 
-	status = _rtl8821ae_llt_write(hw, last_entry_of_txpktbuf,
-				      txpktbuf_bndy);
-	if (!status)
-		return status;
-
-	return status;
+	return _rtl8821ae_llt_write(hw, last_entry_of_txpktbuf, txpktbuf_bndy);
 }
 
 static bool _rtl8821ae_dynamic_rqpn(struct ieee80211_hw *hw, u32 boundary,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 8c395517bd2f..967b42f2b6fb 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1706,11 +1706,7 @@ static int sys_init_ax(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
-	ret = chip_func_en_ax(rtwdev);
-	if (ret)
-		return ret;
-
-	return ret;
+	return chip_func_en_ax(rtwdev);
 }
 
 const struct rtw89_mac_size_set rtw89_mac_size = {
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index f24c119b99f1..b7ba8de9cc78 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -924,11 +924,7 @@ static int sys_init_be(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
-	ret = chip_func_en_be(rtwdev);
-	if (ret)
-		return ret;
-
-	return ret;
+	return chip_func_en_be(rtwdev);
 }
 
 static int mac_func_en_be(struct rtw89_dev *rtwdev)
-- 
2.43.0

