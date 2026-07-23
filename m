Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB02C531F9
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/ZyPlyAUxTK8Vz/tunABGXVD0bibLKDl8Em93+X7p/Y=;
  b=Pg9Mrfppf16Rn73AWKptSOafXbINwd6hgIR158XfQgfDsuZAiz3ayujq
   yHxBnb6Q7S0FUjh8sVDe6ij5cK6VzSRYRcAv1r/OM4raE2/2CwUsqe9vl
   4lmkiSfof7Q1CLnEgEfu66LZ8QRS/KOMRKLtVJwzyLOUPF4/tmbEtheTU
   c=;
X-CSE-ConnectionGUID: c2splSXWRraRlm9M/ytBiw==
X-CSE-MsgGUID: O7djpmc7SMSX2km9Mn4zzA==
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
   d="scan'208";a="287733569"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:15 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 0F6898040C; Fri, 24 Jul 2026 10:54:15 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 05C1181964
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:46:44 +0200 (CEST)
X-CSE-ConnectionGUID: 6g+5d+iGQPmK4YE5qcXirA==
X-CSE-MsgGUID: AvZEg0rRQXOoUvisyQ6H1w==
IronPort-SDR: 6a626193_0h2d8h/JC02C4jqBI9wpTBvw1PMtXIMs+FN+kj+hmHEnIBO
 OpbjK2tCDukvCMKR32hS1oI/M7EVOA+rc+3NdDg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E8CABZYGJqgTPYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKSIoE/PQIPAQMBCwEBTwIEAQEBAgQ4hEYCjWACHgcBBDAJDgECBAMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABASIZBw47hk8NSQEBBAsBB?=
 =?us-ascii?q?AEBggEBgSRhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQUCLF8CAQMSFQsBDQEbHQEDDAYQOyACEQEFARwGARIigmCCIwEGEAEDN?=
 =?us-ascii?q?wIBtleBAkKMPBYFAhaBAYINBoJq134KGSgNdYFjAQICBwkBCgEBgTcBhHcqX?=
 =?us-ascii?q?QOCOoUjdYQCeieBGIEQhH6CH4I5hjAEgy6SKgEHBx8SCAEcBggCAkgVEgMEA?=
 =?us-ascii?q?wQEAQILEwkDAwIOAggDAggGGQE/EgQTAggDBgQLBwUfCgIMFAooIhIrCgMqC?=
 =?us-ascii?q?xIPAw0GBRUBCAYCAgQEAgQMAgkCAgUDBAIEDQMEAQEIAgItAwEDGQgJCAILB?=
 =?us-ascii?q?REYDAsHMQMQCQMfAxQbCEUIBhYBGgcFBgs3FQUMEQECGwIhBB0RCAMBGAQEA?=
 =?us-ascii?q?gELAwEDARUECAkEDAEBEAoSFQMOAwcPAg0HLgsDAg4CCQgMFwICAgYCAwMDC?=
 =?us-ascii?q?gECAQEBAQEBAQgDAwMCAxkHBgMEBAEEBAMDAgMFAQMDAwUCAgoGCQEBAQEDA?=
 =?us-ascii?q?gIIAwcDCgkCBQMbAxwGAQICAwIBAgMGAwcIAw0DBAIDAwMEAQICAQEBAgMBA?=
 =?us-ascii?q?wMEAwEDAwIBAwcCAgMDAwsBAgMDAwUDBQEFAwUCAgMFBQMFAgIKAgMDAwIBA?=
 =?us-ascii?q?wIcAwgDBgMSARADAwYBAwcDBwIEAwgEAwYCAwgDAwIJCAMWBgMDAwMFAQICA?=
 =?us-ascii?q?gMFAwMDCAgEAwMEAgIDDAIGAwMDAgMDBQMDBwIEAgMGAwMDAQMDBQECBwIDB?=
 =?us-ascii?q?wIBCwsIAwIEAgkHCQcBAgMLBAIEBgQNCQQCBAICDwQEBQMDBwEBAgECCAUGA?=
 =?us-ascii?q?wICEQUICgUGAgICHQMhAQMPBgEJBQIBBQ4HBQICChIDBgIDBAUFAQMBCgELA?=
 =?us-ascii?q?QECAwMFBQMDBQcBAgQCBwMDAwQDAwMDAQECAgQGBAMCAwcDAwMDAwQDBQUDA?=
 =?us-ascii?q?gUCBAMFAwcCAwMCAQUKAQQFBAoBAwMDAwUFAwICAwMEAQIEBgMEAgMBAggEB?=
 =?us-ascii?q?gUDAwMFAgMDAgICAwMFAQUCAwMDBAMDAwgHBQMDBQIJAwMJAwMLAgIDIQIFA?=
 =?us-ascii?q?wMDAwYDBwMDBAMDAwcHAgMCAwcDAgUCBwUDAwUDBgEDAgEDAwgLGAMLCQgHD?=
 =?us-ascii?q?AE8DAcKJAQEDCoBFBQFBCUZZwcHAo1oI4JAAXoUgiiBUQEBAaROoCFJHgkBB?=
 =?us-ascii?q?gJggWeBChUKL5tfhXwaM5dTkxmZCCORcJJHhD4CCgcHESQSgTI6gVwzGiOBA?=
 =?us-ascii?q?W2BSVADGQ+SI8wVNTU+AQcCBw8CgXODdoJOhlyBIIErSYFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 J8ve1aw3g==
IronPort-HdrOrdr: A9a23:d3cpVKloBIL5PT71MAhYPCFN35rpDfI/3DAbv31ZSRFFG/Fw9v
 re/sjzsCWetN9/YgBFpTntAsi9qBDnhP1ICPcqTNKftWDd0QPDQb2Ki7GD/9SKIULDH4BmuZ
 uIC5IRNOHN
X-Talos-CUID: =?us-ascii?q?9a23=3AuRdSoWgLeK7dLSX3iWix5aYahzJuLHKekXuTImC?=
 =?us-ascii?q?BMWNKFIy4FEabyKJ+up87?=
X-Talos-MUID: =?us-ascii?q?9a23=3A3PwD5QwCMmjRUuMnZO3+QFAybdGaqI2wOm0CyY8?=
 =?us-ascii?q?8gvmjMhFuOiyMtWqXG5Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="287666975"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHrFoQ20kuiaeKTs3Z5j7hgoJJj91ub0WN2PR?=
 =?us-ascii?q?QMKemHeZwTR2dq+r0pYFfhiOjwZQshTloxX/Q0n9jskF9rolu40CXoUl?=
 =?us-ascii?q?B0KwjJgFuliO1UX6DFbxbdGkECqkP0t9mShCFKLEsJ53C34Q6so3O0+4?=
 =?us-ascii?q?P7G9yzlG3txqo3s8mw3cZYvw=3D=3D?=
Received: from mail-pj1-f51.google.com ([209.85.216.51])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:46:43 +0200
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e347638adso1158636a91.0
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832402; x=1785437202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ZyPlyAUxTK8Vz/tunABGXVD0bibLKDl8Em93+X7p/Y=;
        b=hWTIDQ2WcVb55VjPLlDWhvkLtfYcpQ4JGx/M3kM8/GFw1ncqVcIh/sh3VkDIROfSwE
         QCJJ1zuSlzft9Pm8zXoiOL2DBza/kJ7zh07tGB6ToctUhM8ZFqwi3M11ph6MqfpOMmuk
         VF9XzHmqR3GifVbhIcD+cMv9sKS2Eddif2Yr3sbm3orIt5+nH4IEX33uuanj2j9rjBtf
         dIaR3TWoGUc4jwfQMcIJOOYqQWLGs//1rEqVDz2DfE6H68hPjVerLDkDuWCt6y5NUwtz
         dOGyWG6F0t6MNbAqv4iu4j6u2jRKpwQ7PsTsaDsARcP7t+Fi6jCYEf3GDN13LBfHU0j2
         FPXg==
X-Gm-Message-State: AOJu0YzUE/fMqvHAtamQQ4nPBBBij5lPa7J73JJIfr0Tnj7CBNjLnDCb
	gl7ioNI5IQ+tq7pEfvsXXOTizKZd+YooCt5x5ycuh9X1l9Jw//O+JdlD
X-Gm-Gg: AR+sD10bW8ccCe1k04jRmFI5AdJ8VE1DMX6XM+dBbDOKF2WvkJSF0EPTVsiTXN8h69p
	YZw9GBG9e2WxbubiujB8bLPbVWIel8N4DFt3CsbswKbhq5oL7tAFabbChBlat10YVExEFjwv/WI
	Rb4pqbXanQ4+2O+ZN307+PEK0yFlpFJdGE8ypegM600Tcvx6KVFaVZ8WPxsIq1rgYaM+dvwETM9
	k6rsiqeQOfGTIqf6LZJmTYz2x5FdZ234WsPdopbxtfdA9Bv6ACULG7l1JRWQNG5lOLnTD8zNBS3
	8fMTy8QqeLnUwFRdtvIS/F4eiwbxh959G4ivaRllYwOXkcmd+dU/ZjYPvgiB0AiA/RBNW8LEENM
	104dewqx7dSluGrqcHiQcuU3ai4dfrs2ayhab5jAZLe9cJeCzSQ6Pif0qRvIxc7m5pvd3JIUt
X-Received: by 2002:a17:90b:1847:b0:381:a766:efcc with SMTP id 98e67ed59e1d1-38ec642bd8dmr4696955a91.14.1784832401698;
        Thu, 23 Jul 2026 11:46:41 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:41 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: cocci@inria.fr,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:18 +0900
Message-ID: <20260723184538.3888637-17-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 16/36] Input: remove conditional return with no
 effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3613
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/ncl9G3uKN-ZTiIbBtTLGAw>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/input/keyboard/pmic8xxx-keypad.c | 8 +-------
 drivers/input/mouse/synaptics_i2c.c      | 6 +-----
 drivers/input/rmi4/rmi_smbus.c           | 7 +------
 3 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/input/keyboard/pmic8xxx-keypad.c b/drivers/input/keyboard/pmic8xxx-keypad.c
index 35d1aa2a22a5..c916e80e2f58 100644
--- a/drivers/input/keyboard/pmic8xxx-keypad.c
+++ b/drivers/input/keyboard/pmic8xxx-keypad.c
@@ -462,15 +462,9 @@ static int pmic8xxx_kp_enable(struct pmic8xxx_kp *kp)
 
 static int pmic8xxx_kp_disable(struct pmic8xxx_kp *kp)
 {
-	int rc;
-
 	kp->ctrl_reg &= ~KEYP_CTRL_KEYP_EN;
 
-	rc = regmap_write(kp->regmap, KEYP_CTRL, kp->ctrl_reg);
-	if (rc < 0)
-		return rc;
-
-	return rc;
+	return regmap_write(kp->regmap, KEYP_CTRL, kp->ctrl_reg);
 }
 
 static int pmic8xxx_kp_open(struct input_dev *dev)
diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index d4cf982f1263..85e37e2ce45b 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -257,11 +257,7 @@ static s32 synaptics_i2c_reg_set(struct i2c_client *client, u16 reg, u8 val)
 	if (error)
 		return error;
 
-	error = i2c_smbus_write_byte_data(client, reg & 0xff, val);
-	if (error)
-		return error;
-
-	return error;
+	return i2c_smbus_write_byte_data(client, reg & 0xff, val);
 }
 
 static s32 synaptics_i2c_word_get(struct i2c_client *client, u16 reg)
diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 6de68c602558..3160714a514a 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -177,13 +177,8 @@ static int smb_block_read(struct rmi_transport_dev *xport,
 	struct rmi_smb_xport *rmi_smb =
 		container_of(xport, struct rmi_smb_xport, xport);
 	struct i2c_client *client = rmi_smb->client;
-	int retval;
 
-	retval = i2c_smbus_read_block_data(client, commandcode, buf);
-	if (retval < 0)
-		return retval;
-
-	return retval;
+	return i2c_smbus_read_block_data(client, commandcode, buf);
 }
 
 static int rmi_smb_read_block(struct rmi_transport_dev *xport, u16 rmiaddr,
-- 
2.43.0

