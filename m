Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EEAC531F9
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=mTuJvAzG5mLe5AUB4aEimify+WXcEx2MLUBwrRB2paE=;
  b=Bx0pZQ/9/0V/+4J1nhKMAp0WAyjbgpIEvcLRRUJq5CgPln4Z6+gwPG4y
   0UnchqA+F14UhZr9BzQ5Qp+gBtWkUR5kzWgoIlwlQawXfTQBwFR2cVCmt
   6P5shaL8staeozQ0z+BuCIc1MHTgodUehUze4e4yDsrmUpq3xKjqEnkF7
   0=;
X-CSE-ConnectionGUID: unbb/wGTQumyBG0mfDpNHw==
X-CSE-MsgGUID: rAWZhqcIRLe2UYhd9DZVPA==
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
   d="scan'208";a="287733241"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:02 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 5405E803FA; Fri, 24 Jul 2026 10:54:02 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id BBD1481964
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:46:21 +0200 (CEST)
X-CSE-ConnectionGUID: RkDbNGwdScG0eN9r0ojX0Q==
X-CSE-MsgGUID: oAVTDDw6RpCYvRadMY6L/A==
IronPort-SDR: 6a62617d_o9AhxyYj/fItfXzMrE41elERjidb6PBG17PyTI2mtdQYL2e
 xQjql10ujiCipnf4W8irY+hiGyoxZIzZU+Vj+rA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FACABZYGJqfC7YVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKHU4pPgT89Ag8BAwELAQFPAgQBAQECBDiERgKNYAIeBwEEMAkOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDhIphk8NSQEBB?=
 =?us-ascii?q?AsBBAEBggEBgSRhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQUCLF8CAQMSFQsBDQEbHQEDDAYQOyACEQEFARwGARIigmCCIwEGE?=
 =?us-ascii?q?AEDNwIBtleBAkKMPBYFAhaBAYINBtpoChkoDXWBYwECAgcJAQoBAYE3AYR3K?=
 =?us-ascii?q?l0DgjqFI3WEAnongRiBEIR+gh+COYYwBIMukioBBwcfEggBHAYIAgJIFRIDB?=
 =?us-ascii?q?AMEBAECCxMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCDBQKKCISAikKA?=
 =?us-ascii?q?yAKCxIPAw0GBRUBAQcGAgIDAQQCBAwCBAUCAgUDAQMCBAYEAwMEAQEIAgItA?=
 =?us-ascii?q?wEDGQgJCAILBREYDAsFAgonAw8BCQMfAxQbCEUIBhYBGgcFBgs3FQUMEQECG?=
 =?us-ascii?q?wIhBB0RCAMBGAQCAgIBCwMBAwEVBAgJBAwCEAoSFQMOAwcPAg0HLgsDAg4CC?=
 =?us-ascii?q?QgMFwICAgYCAwMDCgECAQEBAQEBAQgDAwMCAxkHBgMEBAEEBAMDAgMFAQMDA?=
 =?us-ascii?q?wUCAgoGCQEBAQEDAgIIAwcDCgkCBQMbAxwGAQICAwIBAgMGAwcIAw0DBAIDA?=
 =?us-ascii?q?wMEAQICAQEBAgMBAwMEAwEDAwIBAwcCAgMDAwsBAgMDAwUDBQEFAwUCAgMFB?=
 =?us-ascii?q?QMFAgIKAgMDAwIBAwIcAwgDBgMSARADAwYBAwcDBwIEAwgEAwYCAwgDAwIJC?=
 =?us-ascii?q?AMWBgMDAwMFAQICAgMFAwMDCAgEAwMEAgIDCgICBgMDAwIDAwUDAwcCBAIDB?=
 =?us-ascii?q?gMDAwEDAwUBAgcCAwcCAQsLCAMCBAIJBwkHAQIDCwQCBAYEDQkEAgQCAg8EB?=
 =?us-ascii?q?AUDAwcBAQIBAggFBgMCAhEFCAoFBgICAh0DIQEDDwYBCQUCAQUOBwUCAgoSA?=
 =?us-ascii?q?wYCAwQFBQEDAQoBCwEBAgMDBQUDAwUHAQIEAgcDAwMEAwMDAwEBAgIEBgQDA?=
 =?us-ascii?q?gMHAwMDAwMEAwUFAwIFAgQDBQMHAgMDAgEFAwEDAgEBBAUECgEDAwMDBQUDA?=
 =?us-ascii?q?gIDAwQBAgQGAwQCAwECCAQGBQMDAwUCAwMCAgIDAwUBBQIDAwMEAwMDCAcFA?=
 =?us-ascii?q?wMFAgkDAwkDAwsCAgMhAgUBAgMDAwYDBwMDBAMDAwcHAgMCAwcDAgUCBwUDA?=
 =?us-ascii?q?wUDBgEDAgEDAwgLGAMLCQgHDAE8DAcKJAQEDCoBBg4UBQQlGWcHBwKNaCOCQ?=
 =?us-ascii?q?AGBDoIogVEBAQGSCZJFgTieaUkeCQEGAmCBZ4EKFQovm1+FfBozl1OTGZkII?=
 =?us-ascii?q?5FwlwUCCgcHESQSgTI6gVwzGiOBAW2BSVADGQ+SI489AbxXNTU+AQcCBw8Cg?=
 =?us-ascii?q?XODdoJOhlyBIIErSYFMAQE?=
IronPort-PHdr: A9a23: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
 BcpENPvvDtjre65jlnY9piYLGb/Z4wKhw==
IronPort-Data: A9a23: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
 U/KelY=
IronPort-HdrOrdr: A9a23:mqreq6HYYlcvUyYepLqEzMeALOsnbusQ8zAXPo5KOHlom6uj5r
 2TdZEgvyMc5wxhP03I9erwW5VoBEmsjaKdgrNhR4tKPjOW3ldARbsKheCD/9SjIVyEygc078
 ZdmsNFebnN5DZB/KTHyTj9PdJl7tfvys+VbCTlo0uFjzsGV0gZ1XYBNu9TKCNLeDU=
X-Talos-CUID: 9a23:kitQemG2pP/EDdcMqmJd92IePO86fkbW4y/dBR6iUWFreOWsHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AfpxX7wxVd5zN6paFLZpHln3KBIyaqKOHNnwhvYp?=
 =?us-ascii?q?YgdGvBDJKMju4vWqTBaZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152815249"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHWfzNwgdpN1BODCDyIhpsNj2KZf5zysETgM/?=
 =?us-ascii?q?gAqHo34aHtlR0CwtME5gyCGVIy2zghWX+/4iMneCnyov6GuHGnALdGdx?=
 =?us-ascii?q?dWyhu6ZwU5V9iUCxDUvc2s6gJxMfxBk5E43gusIHYwTC5DlVIiIkkupR?=
 =?us-ascii?q?bwvS5ELoWO8XkWTClwRJYLxg=3D=3D?=
Received: from mail-pj1-f46.google.com ([209.85.216.46])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:46:21 +0200
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dcbade417so1041264a91.1
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832379; x=1785437179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mTuJvAzG5mLe5AUB4aEimify+WXcEx2MLUBwrRB2paE=;
        b=r8XvybUQoevngGFu+P8kz774uJJ+VtnVQzDTVmsxAUkvkdsKeWaJadm/y4ztfXUBuP
         h8FPJqrmq8xpnS1UU8s/T5LRcR3/1y8ud2YySK9uiCb6RgWqmYvgt9gsK4J8yM5M0DzB
         18Yl61Z8QpoW67cJ30X4fpNbirSfEUKDUoZEAhQmeLUGLwyYzWrT1cqa/g1jZhqmmbbt
         ttWGiCBrWSlSRk0gWc4OVrAvPFM5cZtkXeQSAudeKHi0LYcZyj5FEGAVuxzIxRp010wR
         ukEUR7h7gTo9uGWIUGJi2PNfzgOLqYDevteo21Qz9IWAd2Fdt2RCAXmTbktmw7w1TyU4
         aLSw==
X-Gm-Message-State: AOJu0Yz4Ou57opt3dIEr7dtBV2cNou7Py8uBwRyGaZISxd0d8mMbGByO
	1QlJ8yIBkKpENkraGI9Ua8Qe/b67YBNjd7XfmreMnIDOcK6gQrcy69gj
X-Gm-Gg: AR+sD10puTO2rQ7KY8t2eLZumULHa441I6ZKPb0Cqwojtmj96yvjLqoQqLDeQFl9AYu
	40W4WBHf/VBu6NXsQfkJPI1w5alLcFOzZSMGUrrp5Kar5MPz/QENGJcCx8Gq446sNLpvnvM9PKR
	7b+PMeJelfK/IeERlU4XBgk00/2IXnQN/3H4WCf55iXzBWTihaORoeF4Ow7p/Ct0KijNCiCXNM6
	oittucZ4JfXMJnlyFNYmjT2AbXBXwZ2IhIocT8hHhqJpxKuwStGDIM8vnMvC5HmXjahiSglU9Uf
	BjE1igbhoytAx69JZFkfGH+LwHmhVp3bC183s6En96EoBjH91fcYvYGj+3aCtXKdJJ7bQh8w448
	nBvtMBBgONwelC1pz3VGcfiWv9w5RCaeSfx8e4Fs6Hfu3R7Kg+6I0uUd9wtF3ySZyq81TAg4M
X-Received: by 2002:a17:90b:50:b0:37e:a09:2640 with SMTP id 98e67ed59e1d1-38ec64958fcmr4523372a91.7.1784832379247;
        Thu, 23 Jul 2026 11:46:19 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:18 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	UNGLinuxDriver@microchip.com
Date: Fri, 24 Jul 2026 03:45:10 +0900
Message-ID: <20260723184538.3888637-9-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 08/36] net: remove conditional return with no effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3605
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/A_ZQ16Nzku2s-iV71asodg>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/net/phy/microchip_t1.c | 6 +-----
 drivers/net/pse-pd/tps23881.c  | 6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index 62b36a318100..3292b2235c8f 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -1028,11 +1028,7 @@ static int lan87xx_read_status(struct phy_device *phydev)
 	if (rc < 0)
 		return rc;
 
-	rc = genphy_read_status_fixed(phydev);
-	if (rc < 0)
-		return rc;
-
-	return rc;
+	return genphy_read_status_fixed(phydev);
 }
 
 static int lan87xx_config_aneg(struct phy_device *phydev)
diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 49d6389da067..8a3bbd623412 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -1520,11 +1520,7 @@ static int tps23881_i2c_probe(struct i2c_client *client)
 				     "failed to register PSE controller\n");
 	}
 
-	ret = tps23881_setup_irq(priv, client->irq);
-	if (ret)
-		return ret;
-
-	return ret;
+	return tps23881_setup_irq(priv, client->irq);
 }
 
 static const struct i2c_device_id tps23881_id[] = {
-- 
2.43.0

