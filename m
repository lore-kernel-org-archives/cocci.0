Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F89C531FA
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=QiNsXajlQRLTmIS3RzF6Ciae3Ovg515LecRLWPQA57w=;
  b=qOQflW/69qnvki7xmPGtLS8e6RutmQTILnzIthxn+RAhtA/QqVnDfHoJ
   tsVzwiDQaq/c9RSMfg27K6GNkRWXc37kdA5f1UC6ydD4LkNZmbFllshDF
   4mnE7ksBsZX5LnZeg8Ta/iShdLTpR5nztt5BB95m5NHAsDyevXA9PWKuS
   I=;
X-CSE-ConnectionGUID: Zo311KuUQTK2NHjZ0ZmKAg==
X-CSE-MsgGUID: KymNFri4SgiDEQumQo5nGQ==
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
   d="scan'208";a="287733195"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:00 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id C6DC7803FA; Fri, 24 Jul 2026 10:53:59 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id F335F81331
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:46:17 +0200 (CEST)
X-CSE-ConnectionGUID: GrPbgyT7Tu23TEgk0P+DHA==
X-CSE-MsgGUID: U5wqjZ9aR8mWUJPJ0eanOg==
IronPort-SDR: 6a626179_zQqAVwzyNv47UTYNLiNc5n4URrimk67ooq5tJrVS1EZyGC2
 t1WfOD2tIYMT3v7Xi0gZlhG0MeHYVZwZzZbn/EQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HGBABZYGJqfC3YVdFaglkCgj8WgVMzBFSVBwaBPokxg?=
 =?us-ascii?q?hkwApIigT89Ag8BAwELAQFPAgQBAQECBDiERgKNYAIeBwEEMAkOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDhIphk8NSQEQA?=
 =?us-ascii?q?QQBAYIBAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEFAixfAgEDEhULAQ0BGx0BAwwGEDsgAhEBBQEcBgESIoJggiMBBhABA?=
 =?us-ascii?q?zcCAbZXgQJCjDwWBQIWgQGCDQbaaAoZKA11gWMBAgIHCQEKAQGBNwGEdypdA?=
 =?us-ascii?q?4I6hSN1hAJ6J4EYgRCBFYNpgh+COYYwBIMukioBBwcfEggBHAYIAgJIFRIDB?=
 =?us-ascii?q?AMEBAECCxMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCDBQKKCISAikKA?=
 =?us-ascii?q?yAKCxIPAw0GBRUBAQcGAgIDAQQCBAwCBAUCAgUDAQMCBAYEAwMEAQEIAgItA?=
 =?us-ascii?q?wEDGQgJCAILBREYDAsFAgonAw8BCQMfAxQbCEUIBhYBGgcFBgs3FQUBCxEBA?=
 =?us-ascii?q?hsCIQQdEQgDARgEAgICAQsDAQMBFQQICQQMAhAKEhUDDgMHDwINBy4LAwIOA?=
 =?us-ascii?q?gkIDBcCAgIGAgMDAwoBAgEBAQEBAQEIAwMDAgMZBwYDBAQBBAQDAwIDBQEDA?=
 =?us-ascii?q?wMFAgIKBgkBAQEBAwICCAMHAwoJAgUDGwMcBgECAgMCAQIDBgMHCAMNAwQCA?=
 =?us-ascii?q?wMDBAECAgEBAQIDAQMDBAMBAwMCAQMHAgIDAwMLAQIDAwMFAwUBBQMFAgIDB?=
 =?us-ascii?q?QUDBQICCgIDAwMCAQMCHAMIAwYDEgEQAwMGAQMHAwcCBAMIBAMGAgMIAwMCC?=
 =?us-ascii?q?QgDFgYDAwMDBQECAgIDBQMDAwgIBAMDBAICAwoCAgYDAwMCAwMFAwMHAgQCA?=
 =?us-ascii?q?wYDAwMBAwMFAQIHAgMHAgELCwgDAgQCCQcJBwECAwsEAgQGBA0JBAIEAgIPB?=
 =?us-ascii?q?AQFAwMHAQECAQIIBQYDAgIRBQgKBQYCAgIdAyEBAw8GAQkFAgEFDgcFAgIKE?=
 =?us-ascii?q?gMGAgMEBQUBAwEKAQsBAQIDAwUFAwMFBwECBAIHAwMDBAMDAwMBAQICBAYEA?=
 =?us-ascii?q?wIDBwMDAwMDBAMFBQMCBQIEAwUDBwIDAwIBBQMBAwIBAQQFBAoBAwMDAwUFA?=
 =?us-ascii?q?wICAwMEAQIEBgMEAgMBAggEBgUDAwMFAgMDAgICAwMFAQUCAwMDBAMDAwgHB?=
 =?us-ascii?q?QMDBQIJAwMJAwMLAgIDIQIFAQIDAwMGAwcDAwQDAwMHBwIDAgMHAwIFAgcFA?=
 =?us-ascii?q?wMFAwYBAwIBAwMICxgDCwkIBwwBPAwHCiQEBAwqAQYOFAUEJRlnBwcCjWgjg?=
 =?us-ascii?q?U4eVAGBDnuBLVGBAAEBAaROoCFJHgkBBgJggWeBChUKL5tfhXwaM5dTkxmZC?=
 =?us-ascii?q?CORcJcFAgoHBxEkEoEyOoFcMxojgQFtgUlQAxkPji0Wg2CPPQG8VzU1PgEHA?=
 =?us-ascii?q?gcPAoFzg3aJKoEggStJgUwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:x17jiqtqTvLqzk51jbwv26Xt7skDUtV00zEX/kB9WHVpmwKj5q
 WTdZMgpGLJYVMqMk3I9urwX5VoLUmslqKdpLNhRYtKPzOWwldATrsSi7cKqgeIc0afygce79
 YaT0EXMrzN5DNB/KLHCWeDYrQd6ejC3qTtq+m29RhQpMJRB52ILT0VNu/iKDwOeOCOP/QEKK
 Y=
X-Talos-CUID: 9a23:/DznimyB0bPgXfU+auWKBgU7APgvfWzhk0vNeRSEJGlqEIXWZX+5rfY=
X-Talos-MUID: 9a23:pS0nuQYGAZMB9+BTimLznTNQZc5Ss6GRNWI1s80Lss+jOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="287666903"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHrrau5bQoTfvC5HsfWDvNP6VamC6RMIhxYM9?=
 =?us-ascii?q?wrl6mnSmjseBLA1J5I+NZ7keSnv5iAHauYUJeRXhVCtD8ejxsm9TsLwk?=
 =?us-ascii?q?TANk+TQ4dcX68xG7FKqzcoUbyabmHXMrIXtnw50geOrJgWYqAn+dtaAl?=
 =?us-ascii?q?n5GP1vpRjSA3d+MXalpOJP6g=3D=3D?=
Received: from mail-pj1-f45.google.com ([209.85.216.45])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:46:17 +0200
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38175907a56so634850a91.0
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832376; x=1785437176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QiNsXajlQRLTmIS3RzF6Ciae3Ovg515LecRLWPQA57w=;
        b=eT0l8d9xvx8FioCitWR5ndjdIqiR3ECpUfarZqbAtmBfFRsd3gDKjDb+oW7RRpbW9q
         e15xARov9SxQoaVd+1wOrYUJnR6VM+xJrIqzFFEsyW/1lscKV8vmOiLGIn3pTQ1ZDisB
         bAsOJ/k2NhAppvV5BKmlc2LRc6CGfCe9OYF2wx+yPOG3Dl3uLwsRjq2wS9U8AHtyEcnC
         DFKp/ZvOsBIUBrcRjfXwANl1XB7xmUujrUmjvGHaNysEUJb+U2oyJXR3SeqQgiHgF7Pb
         j3N8vmzL32FAnXfkZlL22m+UzW4eiCMzDaQ3hJ+dtsptpeyIe9p0+PKt78E3V4CAup1Q
         r1Zg==
X-Gm-Message-State: AOJu0Ywz98NthSwRNhsQ3en0zrmVilwGHth3marh1G8OCvuhq9NqDCyX
	0L3skhIM3clCSRPnYc8yHPQNekpjapur+I8OId5kMCh/gGR2HjAudLOf
X-Gm-Gg: AR+sD13EnMhQK7aeDirf7AIf5AHz3Shp+vu49SfoGcwEx6/jTgwuSYHoDHJP+WE9CMI
	Q8OELaZ4/P2fnFegg2ydjhcYk7sm6bwOzRo4K7hBjPqEDC4rTjEBwKWI+7JwenP5tYwaJvqdPMb
	GQQrYu6zL/Qyi1LOXYYZo+qBBeQSpwAsmLB4N8J+yxc7jqX0dK6s+7eM8uY9gv/nYLp+keuj09k
	GsgND203csLSoRTcqX0+zT8G+XmTSGj2lE0sSPd9WJ7MrjsT2WLYhNM0PkwNNoI3UwwCWhuxOSZ
	vm6BNaicc5x1Tdmog3HFpbjod17nbVG2FnDEcUOiYTBjFYrPpxKuw0lWAd6iOQln1xA/CwQ8Poz
	47FGc3uklEdCDc85ofwkenntTDbgpS/tWi+6cBSIV+k2JJVFGu33s/mae52bmYx925dwb4tuF
X-Received: by 2002:a17:90b:4d83:b0:38e:4f42:d0d6 with SMTP id 98e67ed59e1d1-38ec8461966mr2882664a91.12.1784832375589;
        Thu, 23 Jul 2026 11:46:15 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:15 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sukhdeep Singh <sukhdeeps@marvell.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Manish Chopra <manishc@marvell.com>,
	Rahul Verma <rahulv@marvell.com>,
	Shahed Shaikh <shshaikh@marvell.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: cocci@inria.fr,
	GR-Linux-NIC-Dev@marvell.com,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:09 +0900
Message-ID: <20260723184538.3888637-8-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 07/36] net: ethernet: remove conditional return with
 no effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3604
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/kY4EziEkini4XKNL0Mxxbw>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c          | 6 +-----
 drivers/net/ethernet/aquantia/atlantic/aq_macsec.c    | 6 +-----
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c   | 6 +-----
 drivers/net/ethernet/freescale/gianfar.c              | 6 +-----
 drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c    | 7 +------
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c | 6 +-----
 drivers/net/ethernet/renesas/rtsn.c                   | 7 +------
 7 files changed, 7 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 5d05020a6d05..ea89619039d8 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2303,11 +2303,7 @@ static int ena_open(struct net_device *netdev)
 		return rc;
 	}
 
-	rc = ena_up(adapter);
-	if (rc)
-		return rc;
-
-	return rc;
+	return ena_up(adapter);
 }
 
 /* ena_close - Disables a network interface
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c b/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c
index 3ca072360ec7..fd4ee6212234 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c
@@ -735,11 +735,7 @@ static int aq_set_rxsc(struct aq_nic_s *nic, const u32 rxsc_idx)
 	sc_record.valid = 1;
 	sc_record.fresh = 1;
 
-	ret = aq_mss_set_ingress_sc_record(hw, &sc_record, hw_sc_idx);
-	if (ret)
-		return ret;
-
-	return ret;
+	return aq_mss_set_ingress_sc_record(hw, &sc_record, hw_sc_idx);
 }
 
 static int aq_mdo_add_rxsc(struct macsec_context *ctx)
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 33e7a99d3e49..79d4a77f72bd 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -3935,11 +3935,7 @@ static int dpaa2_switch_port_init(struct ethsw_port_priv *port_priv, u16 port)
 	if (err)
 		return err;
 
-	err = dpaa2_switch_port_trap_mac_addr(port_priv, ll_mac, ll_mask);
-	if (err)
-		return err;
-
-	return err;
+	return dpaa2_switch_port_trap_mac_addr(port_priv, ll_mac, ll_mask);
 }
 
 static void dpaa2_switch_ctrl_if_teardown(struct ethsw_core *ethsw)
diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 89215e1ddc2d..cf636fc5aafa 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -2877,11 +2877,7 @@ static int gfar_enet_open(struct net_device *dev)
 	if (err)
 		return err;
 
-	err = startup_gfar(dev);
-	if (err)
-		return err;
-
-	return err;
+	return startup_gfar(dev);
 }
 
 /* Stops the kernel queue, and halts the controller */
diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
index fff8dc84212d..e96a268067f2 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
@@ -2478,7 +2478,6 @@ static int netxen_parse_md_template(struct netxen_adapter *adapter)
 static int
 netxen_collect_minidump(struct netxen_adapter *adapter)
 {
-	int ret = 0;
 	struct netxen_minidump_template_hdr *hdr;
 	hdr = (struct netxen_minidump_template_hdr *)
 				adapter->mdump.md_template;
@@ -2486,11 +2485,7 @@ netxen_collect_minidump(struct netxen_adapter *adapter)
 	hdr->driver_timestamp = ktime_get_seconds();
 	hdr->driver_info_word2 = adapter->fw_version;
 	hdr->driver_info_word3 = NXRD32(adapter, CRB_DRIVER_VERSION);
-	ret = netxen_parse_md_template(adapter);
-	if (ret)
-		return ret;
-
-	return ret;
+	return netxen_parse_md_template(adapter);
 }
 
 
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
index 45ed8705c7ca..47cd9ec665ee 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
@@ -1618,11 +1618,7 @@ static int qlcnic_83xx_check_hw_status(struct qlcnic_adapter *p_dev)
 	if (err)
 		return err;
 
-	err = qlcnic_83xx_check_heartbeat(p_dev);
-	if (err)
-		return err;
-
-	return err;
+	return qlcnic_83xx_check_heartbeat(p_dev);
 }
 
 static int qlcnic_83xx_poll_reg(struct qlcnic_adapter *p_dev, u32 addr,
diff --git a/drivers/net/ethernet/renesas/rtsn.c b/drivers/net/ethernet/renesas/rtsn.c
index ee8381b60b8d..f7beeb73eb16 100644
--- a/drivers/net/ethernet/renesas/rtsn.c
+++ b/drivers/net/ethernet/renesas/rtsn.c
@@ -685,7 +685,6 @@ static void rtsn_set_rate(struct rtsn_private *priv)
 static int rtsn_rmac_init(struct rtsn_private *priv)
 {
 	const u8 *mac_addr = priv->ndev->dev_addr;
-	int ret;
 
 	/* Set MAC address */
 	rtsn_write(priv, MRMAC0, (mac_addr[0] << 8) | mac_addr[1]);
@@ -702,11 +701,7 @@ static int rtsn_rmac_init(struct rtsn_private *priv)
 
 	/* Link verification */
 	rtsn_modify(priv, MLVC, MLVC_PLV, MLVC_PLV);
-	ret = rtsn_reg_wait(priv, MLVC, MLVC_PLV, 0);
-	if (ret)
-		return ret;
-
-	return ret;
+	return rtsn_reg_wait(priv, MLVC, MLVC_PLV, 0);
 }
 
 static int rtsn_hw_init(struct rtsn_private *priv)
-- 
2.43.0

