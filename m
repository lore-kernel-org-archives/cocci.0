Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ADC606A327
	for <cocci@archiver.kernel.org>; Fri, 13 Nov 2026 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=C37E/mPj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:content-transfer-encoding:message-id:
   references:in-reply-to:to:cc:mime-version:subject:
   reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=PAgyl1z3BX/174oXHaAPVKJIvoVNY26JiPctkSWgA6Q=;
  b=C37E/mPjiSJOkm60sx9Uqstbs6oZur29seZfSMoOZGgVHrx/BOBJKbu/
   IfIkWDzVoZ14S20Dg0SzOLj8PwlZOR6tQ2RFjvhwklb+ypNuMnaaoMGQH
   lGm86zaKrMtsz+rbRYGK50ggoWe6T8NGDlFW50BM8zYdfCQ/mau7wOv6k
   0=;
X-CSE-ConnectionGUID: 5RvEoHuNStSWj/uDtu9nmQ==
X-CSE-MsgGUID: FbOm1YnFTh6RE4xCG9mMYA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,212,1787004000"; 
   d="scan'208";a="305341373"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Nov 2026 19:05:54 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 2F3CC80F65; Fri, 13 Nov 2026 19:05:54 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 1B0C9801C6
	for <cocci@sympa.inria.fr>; Fri, 13 Nov 2026 17:09:11 +0100 (CET)
X-CSE-ConnectionGUID: cAOrCUGxT9aDDnwB8slu7A==
X-CSE-MsgGUID: +s34+V15Q8C6QGvrRSiqzQ==
IronPort-SDR: 6af73626_FGg+JXVMFyLIfbfrI4Vs47VHaGEKGbY+no+PgmwbWmViWrB
 GmYlSQAki3hlQP0REs/3Xbflg02sgXEUs14EYXw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EEAwAVNfdqgyaiayhaHgEBCxIMggULgW4qKRYsAYEsM?=
 =?us-ascii?q?AdRhFiDTQEBhSuIeoN1mFsqgSuBPz8PAQMBCwEBUQQBAQECBIR+Ao4hIAYBB?=
 =?us-ascii?q?DAJDgECBAMCAwEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABAQEBO?=
 =?us-ascii?q?QcOO4ZPDYwaAYEkXkgBAQEBAQEBAQEBAQEBAQEBAQEBAQEUAghjAR8CAQMSC?=
 =?us-ascii?q?AkEGQEBNwEPJQImAgIxFRAGARIigghYgiUETAQCr0hzAgKLFX8zgQGCDAEBB?=
 =?us-ascii?q?oJq2UuBaAECCQkBCgGBCi6FdIJuAYFxhAg7hEI2gVVEgRWDaogfgmqCJnoSg?=
 =?us-ascii?q?lyFOo9hCT+BAhwDWSwBVRMNCgsHBWNSMwMgCgsSEhgVAhQdEg8EFjIdcAwnE?=
 =?us-ascii?q?iwXL1gbBgWBHHMUBBOBEoEFCVSBKyhdASGBCE4BAwKBIQIGgkuCAAIBSUEOB?=
 =?us-ascii?q?0VTCSVDEkckIggSCQETGiwKgRo1PAkmPxUMZwsaBWEIAg0MdDkQMB4kLwUaJ?=
 =?us-ascii?q?j4bCoEOBRgNSBEsNwYPGQQ9AW4HkniDDgcBgQ5/gWk6kmwIg26NXqFINAeEI?=
 =?us-ascii?q?4FgCAygBTKqci6YWiOjaIUOAgQCBAUCEQEBBoFoOoFcMxojUIJnUAMZD44iC?=
 =?us-ascii?q?QMNCYNgjz0Bvnx4PQEBBwIHDgMLgWiQNIFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:eavzlqyli05P//V4QdP3KrPxMOgkLtp133Aq2lEZdPULSKGlfp
 GV9sjziyWetN9IYgBapTiBUJPwIk80hqQFm7X5XI3SETUO3VHFEGgM1/qE/9SNIUzDH6tmpN
 9dmstFeZHN5DpB/KDHCWCDer5OruVvsprY/Ns2pE0dLz2CHpsQizuRfTzrd3GeKjMnObMJUL
 aM7MtOoDStPU8Qctm6AXc9We3Crc3glZ7tYxIKbiRXpzWmvHeN0vrXAhKY1hARX3dk2rE561
 XIlAT/++GKr+y74gW07R6T071m3P/ajvdTDs2FjcYYbh/2jByzWYhnU7qe+BgoveCU7kowmt
 WkmWZhAy0z0QKTQoiGm2qp5+DS6kdr15Yk8y7evZLXm726eNv9MbsGuWsWSGqB16NqhqAA7E
 sC5RPki3MQN2KPoM213am2azh60kWzunYsiugVkjhWVpYfcqZYqcgF8FpSC4poJlOz1GmJKp
 gcMCjw3ochTbqhVQGRgkB/hNi3GngjFBaPRUYP/sSTzjhNhXh8i08V3tYWkHsM/I80D8As3Z
 WPDo140LVVCsMGZ6N0A+kMBcOxF2zWWBrJdGafO07uGq0LM2/E75T3/LI27ue3f4Fg9up4pL
 3RFFdD8WIicUPnDsODmJVN7xDWWW24GS/gz8lPjqIJzYEUhICbRRFrZGpe4/dI+c9vfPEzc8
 zDSa5+Erv+KmvhFcJF0xDzUYRTL35bXc0PttwnH1aV5tjON5SCjJ2oTN/DYKbrETgpHmfkRn
 MFQTjoPc1FqkytUnT8jBW5YQKZRnDC
X-Talos-CUID: 9a23:PC+9m2M5J/6Ine5DUwBA7mUpNdAZI3Tx4HHPCR+jDXs2YejA
X-Talos-MUID: =?us-ascii?q?9a23=3AAZ6u4g8ZU069q8Pt1QypnVuQf4RzuPjtNhlQqMU?=
 =?us-ascii?q?t5fCrKzZKADaEng3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,211,1787004000"; 
   d="scan'208";a="305325017"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDF7i/cXCHuinrW41QFVTlDjPhVRIdn6jHhyvN?=
 =?us-ascii?q?Fu4hL3sLUY9Ra6I117AEklyFDu71Axc0szS9vIE1htyIXFC7vg5xgPW0?=
 =?us-ascii?q?Sb5fzXMbR9cH5b6Lvs6mJGM1JCZTsQAKvoNtl1EV2lO1zDWcriE0zDY5?=
 =?us-ascii?q?cfw/WyXw/QcuOoQvnGmOCsXA=3D=3D?=
Received: from mail-francecentralazon11013038.outbound.protection.outlook.com (HELO PA4PR04CU001.outbound.protection.outlook.com) ([40.107.162.38])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 17:09:10 +0100
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XQfdHjq9MjSzJgAESLJy95Moy5nDDc0+9oEvKLQzBaJRrgpNHrKTTxqLNqmBR2t2Z+WH2OQwDNkS7jHcmjBNBgLrHFq2ZeImP2t0xDCt0BOXBL+wybUxD3Y4C+goDj2ydo/2pnPvS0f2Wx0dyTrl8/8zCh0WnsjS/7OyqMuwfisA9gWphcJVVPp62vvpfmut3uMvKSKECIll1eNDztD+Z5BgsEZ8AMWsSKvwYoyGIsTHlISZvR2w0bc0ybP7r1w2x7bAJUGgowlD2MafgAPn9K65KkMivrtTzhY4ooAUk9E2jR/M0FNWt+5QGzr1CY2GHuAafVG7vD6rd2rR92KZvQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAgyl1z3BX/174oXHaAPVKJIvoVNY26JiPctkSWgA6Q=;
 b=xv9bp0olvaHciAT5ywyKyu2tTLDrkvaHrOx1PMivy00DqEtN2MtPhJFzngowZzY95nrJIkcU/A9fyzrUzif7xxBOLmornrHgTg87rROPIzfMNBXs0JiyMhtrt5eJCB98wP5SO5iEZQDhMlARfFHadKppQxtYOXgNegu+RUuK1N14uulVJ9ZiUYHcq4dTp35HxRYZW2GCGqVo79ZbCR08+zUH2HS6VP6SDqaFSjqJkakixJzNDT3IeoC5GBXfatavmryvz9oJe9RMngOjg42rLzKsQsOo1omZPeDIs36rPKCqZkS+Bc0P2UoKuwRCNKfmwLPD2W2IV8q/bOab2tAsfw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
Received: from DU7P195CA0021.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::31)
 by VI0PR08MB11042.eurprd08.prod.outlook.com (2603:10a6:800:257::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 16:08:52 +0000
Received: from DU2PEPF00028D03.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::11) by DU7P195CA0021.outlook.office365.com
 (2603:10a6:10:54d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Fri,
 13 Nov 2026 16:08:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D03.mail.protection.outlook.com (10.167.242.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 13 Nov 2026 16:08:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m68VmRcC12DQumeeVN7ZidLfuiF5OQcuTKTQIWBeAQmLm7A2isxKhzo3XCke9hjNrDEO7Tt7l9GtZHT23fBDgCgzcqCKWPVVdHsojfpIvsEQhtlbLRhYaL+q+dnQF/z3cblFoqac5VGw5eTED/RTO9GyuYz+FJskEvxa7se09NVcPzZHHGh44NggD7dyYRb7/4LnIWzEskNVRZzrg4uYUXQAa8JifsxFByZxOeFmYcEUGhkIk5mgXPJ5pTRoLrJ7QnRC43l1Nsi3mHam7yxrWGrXnHTdEdQ+ArDj7pGXKpwo3ikczyNvaktdz8467xhTs4E5YKJTMGQ0onQvdnBA/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAgyl1z3BX/174oXHaAPVKJIvoVNY26JiPctkSWgA6Q=;
 b=YFpA+48Pyy+74vIw3X1r2BKviTXunn5Reef1Xfpj6ciB7At7NHT3JJUig63u2mgRP/zlXwnwJhofgpCbXeZRi54Uj9g8+ZORrRnCJfIFVkzSa2BsF3LgjEL0Ntgm0Tqn4G5Rp8a5LuhDWAgm7keIxDusN6rBV9tuWhi3GndS8mRYAe2VotRchu3Zd41hD67b1yZcoTHuROptZ2cB8C+w4EVnXbuwCRKmz2glXmF4nRklE0SI87FRQCv6z2jgHf9L00pVJLsp3+sgJ/BmcG8rT9FddsvlFsK/rxWcYeu1BAe7JPhVVjUOxezfUoyaY/s998t99LcEGlkGK4Op19uIfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 (2603:10a6:20b:629::15) by AMDPR08MB11367.eurprd08.prod.outlook.com
 (2603:10a6:20b:717::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 16:08:03 +0000
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c]) by AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c%6]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 16:08:03 +0000
From: Bence Csokas <bence.csokas@arm.com>
Date: Fri, 13 Nov 2026 17:07:32 +0100
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-offsetof-v3-2-714df7053893@arm.com>
References: <20261113-offsetof-v3-0-714df7053893@arm.com>
In-Reply-To: <20261113-offsetof-v3-0-714df7053893@arm.com>
To: Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>, Zack Rusin <zack.rusin@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Selvin Xavier <selvin.xavier@broadcom.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Chengchang Tang <tangchengchang@huawei.com>, 
 Junxian Huang <huangjunxian6@hisilicon.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
 Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>, Nilesh Javali <njavali@marvell.com>, 
 GR-QLogic-Storage-Upstream@marvell.com, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, 
 Nicolas Palix <nicolas.palix@imag.fr>
Cc: Bence Csokas <bence.csokas@arm.com>, linux-hardening@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, intel-gfx@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
 linux-wireless@vger.kernel.org, chrome-platform@lists.linux.dev, 
 linux-scsi@vger.kernel.org, cocci@inria.fr
X-Mailer: b4 0.15.2
X-ClientProxiedBy: PR3P193CA0037.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:51::12) To AS8PR08MB10291.eurprd08.prod.outlook.com
 (2603:10a6:20b:629::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB10291:EE_|AMDPR08MB11367:EE_|DU2PEPF00028D03:EE_|VI0PR08MB11042:EE_
X-MS-Office365-Filtering-Correlation-Id: 9647526f-ae92-42be-0727-08df41a06757
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|10067099003|11063799006|56012099006|261022075727099003|261022115727099003|261026140227099003|261022113327099003|261026135527099003|261026121527099003|261022105027099003|261026130827099003|261021130227099003|261028144727099003|261021121427099003|261021123027099003|261021133027099003|261021135927099003|261102130727099003|261102123227099003|261009221727099003|261009223327099003|261009221227099003|261009223027099003|261009220027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info-Original:
 NQs8BvfDhuIBAZjELemlLX5YpVW0j0jc54lzcmfFvgzSmTlzy+3UUa3xBmShmo3EPEZTbWaCXLkttCqgXjzN6ufzz4pYcc3iweuNjpdOEVirMSNzd47RAiDzm745QpExM/QyZOCDBKzjiRsjnbcIRPQny3xziWroskDfCwokQscrfKEgxIszCYuQ2g1TcpqSQmbj0ebtbRYeC/TBykJad+8sZ4gtTfJn0pj/iFnTs5H7AU2pep9dLy9XDmpY9x5LHfftZuZ9nKLkjwZ3VqAM7uLo90tKGZd5rXDHP+N4DTgjy/12IgdlalpcfwxpTbyR6eegoYFue9gyI3l9uqO8XAG1/cMVeDA0AYp6ByEeBjpWLnFyA+gxIga7xDtVyGHLrOKUWVO/Yub8uRAl1VxNeyGsLf+Vt2G8DqaJNzOZRIKU9BgqK2pV/vDQcDYqeGvfhWC3cLgiXyZtag4v+WPfqQHo//QGh2HbIUUSHoLmdSfjOBifvn+/C0kHWEPHyw9e1VIDTkro8BVHWRlaSnSvcdEkOwKVQJBQ7mBgAgvfXhiOX9XKS4O48dEz6MelTBz+DCJ24W2Pf0JlXVNAbM14HalNv9QPFFcUMk0MFdGDl4uzntUJxZ2hPyL3fAA6lcCIrSa27AViX5jdkFPpLef1bG6l3DHGO3OWIfUq8ciORch0u5xvFIUSWj0VVXnJznvvW2PtJzQhDN0rGuWF7Hb6eg==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB10291.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(10067099003)(11063799006)(56012099006)(261022075727099003)(261022115727099003)(261026140227099003)(261022113327099003)(261026135527099003)(261026121527099003)(261022105027099003)(261026130827099003)(261021130227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261021133027099003)(261021135927099003)(261102130727099003)(261102123227099003)(261009221727099003)(261009223327099003)(261009221227099003)(261009223027099003)(261009220027099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 mhi8i2+9h+QHSZOrAqdXMu9CVorcup/x3un9Vwj7/vONFZdxoD4J8ocJZA6XL93u6kHiaBkLW1aIYQTDOFx553QgEWxNEsrmGPQRSqR8rV+XSH/e5HiplgR+5fYciKgnJ7zeFh1U81dXmQBinJJJMaDDShfQyC7aJiHhqGFA0KbOLn0MweUPUTzDUgSPJZD3Odfppu7ara4Ut+gAhw7cr8rffBykbWPNr0nRBkPWSsT0qf/z/U8YFwLdrFLd7TBxydLu6YaQzlOtMIqGeppO161SHpT4mjH63iyujWwPoiTZOxi0pBvP+u76kb0+mBq8fSiXF5CeknlKSaFlweSGqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11367
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2b246e76-b7f5-4798-ce1c-08df41a04b82
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|14060799003|35042699022|376014|1800799024|23010399003|82310400026|36860700016|921020|261028144727099003|10067099003|11063799006|261026121527099003|56012099006|261021121427099003|261022113327099003|261021123027099003|261021133027099003|261021130227099003|261026130827099003|261026135527099003|261022105027099003|261022075727099003|261102130727099003|261026140227099003|261021135927099003|261022115727099003|261102123227099003|261009221227099003|261009221727099003|261009223027099003|261009223327099003|261009220027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	AL2KK4x96buz4jvQ4aH9gTtRlcJai9MBNpLT1oG5HYCghqab2IhkHIVroludQj56RM8PbKiOjIPh1tapR+j3Ixo9LceP9/03DMa24zyfmbgx0kcv77khTcmK9vB8yQYWeiv+BqiXqS6Hc7yITKZWOhTmjyizWivQCqRSu4U4ABbbqqq6Im2T6R7xq3bH9PVE2MzLuPbyd1FgoRpoFaFYEj5HZ2xnrXG19C9DqKDbViiyDQKDelTeaw8xYiS6pKA94baO72r1Xhbouv5H2ySqMRSz8ufnfi1tV6h6hj07x1E17GaQyhexgQ/nmhs4b38mGXhyeBP3nQfjtVqYqXcr+MWJWKl/I7/bBlvbcCADZe+oOZGmw2fLsSgw53gQUcBY27Ofn49gukNUZuA8O+O98sEyQvrcyNrsb7aBH9u0bYtI+mix+xKkz8hX6AYvwGJZcFW6FPdHAlmWAOv7Z0/jT4qgcYjje/OfO2oO9rfLWKht3ZxZTgDH07xwWYMPLXJ6pvQuk2M2skvzCVCgpDWxeTnROaeCVkAGwuFWGsp1SjSnUum4Ox1hQP1eFMcrr3TWWWK5uD6XpHcKdPB+mLGcFw5r3gZDjPuLKs+o+PxMwB8YpVd8ggEOOcTsyBxLX3Xr6g07mJnyLGT+sLC1PKTj61bh4/ZESRdPFmP44+byLt05fqQfKrdhyjMwbuLrFPtpWr+4ATcMuwqj1wvjMUGDgIfzoiagIgWV7ajxk/B2n7ct62zh2nG2eMwzbBKhJsiJ
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(14060799003)(35042699022)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(921020)(261028144727099003)(10067099003)(11063799006)(261026121527099003)(56012099006)(261021121427099003)(261022113327099003)(261021123027099003)(261021133027099003)(261021130227099003)(261026130827099003)(261026135527099003)(261022105027099003)(261022075727099003)(261102130727099003)(261026140227099003)(261021135927099003)(261022115727099003)(261102123227099003)(261009221227099003)(261009221727099003)(261009223027099003)(261009223327099003)(261009220027099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JCRPbmwg5RPmKXPx5WnBYxLhoeZhJnz19qeFD7s5Ohc9Mpu4wASuBdHB2014aGooEz78Hvq2WMGSZiiEfJltRweIVgP4PJfPfi6c4D1fyOLXVZOFrn4oQI9+hOu+oISPXW8N8iwEAkWbS54nC/7W4DNJdObA0Geh9d720U7tyAKUggWNBmDHUjQjOrsKcdhboLxLEZTiKxL2AdMTeCoP06vo5ZlWryct5hrbnIYgYVSTjr1XOQrrxqfX+m/rQGrh7Im4f20B7yzG7ntDlD/yFt0nL5PSxT/Hw6UFXc7AW+3DfQxV3Wprj4zzTCpJ1Ce5AD7T5AqhOP2iwpFgGOc5yPW9rRNx8Ll0yhbAoq4dxjEacfyTtnA9169IoqM/vc8qy7DHWoROOjB9ZvbsGLKQvs+oH+HXwuxdWa0wuEYZa6OT7oUneEZ009ugSIrLAp7p
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:08:44.9749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9647526f-ae92-42be-0727-08df41a06757
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11042
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v3 2/2] treewide: Use struct_offset()
Reply-To: Bence Csokas <bence.csokas@arm.com>
X-Loop: cocci@inria.fr
X-Sequence: 3806
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/HkFtJsiMHom_FYykthLP3Q>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Generated with a simple Coccinelle patch found in
scripts/coccinelle/api/struct_offsetof.cocci

Signed-off-by: Bence Csokas <bence.csokas@arm.com>
---
 drivers/bluetooth/btmrvl_main.c                    | 12 +++++-----
 drivers/dma-buf/dma-resv.c                         |  2 +-
 drivers/firmware/arm_scmi/base.c                   |  2 +-
 drivers/gpu/drm/drm_edid.c                         | 26 +++++++++++-----------
 drivers/gpu/drm/i915/gem/i915_gem_object.c         |  4 ++--
 drivers/gpu/drm/i915/i915_active.c                 |  2 +-
 drivers/gpu/drm/i915/i915_sw_fence_work.c          |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c  |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            | 12 +++++-----
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  2 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c            |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_qp.c            |  6 ++---
 drivers/media/usb/uvc/uvc_v4l2.c                   |  4 ++--
 drivers/net/hyperv/rndis_filter.c                  |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c     |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |  2 +-
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c |  5 ++---
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |  2 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |  2 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  2 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  8 +++----
 drivers/net/wireless/virtual/mac80211_hwsim_main.c |  4 ++--
 drivers/platform/chrome/cros_ec_lightbar.c         |  4 ++--
 drivers/scsi/qla2xxx/qla_gs.c                      |  2 +-
 drivers/scsi/qla2xxx/qla_mbx.c                     |  2 +-
 drivers/scsi/qla2xxx/qla_os.c                      |  2 +-
 drivers/scsi/qla2xxx/qla_tmpl.c                    |  4 ++--
 drivers/scsi/scsi_transport_fc.c                   |  2 +-
 29 files changed, 63 insertions(+), 64 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index d449fbdde464..cd98beaf6cb6 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -81,7 +81,7 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 	struct btmrvl_event *event;
 	int ret = 0;
 
-	if (skb->len <= offsetof(typeof(*event), data[0]))
+	if (skb->len <= struct_offset(event, data[0]))
 		return -EINVAL;
 
 	event = (struct btmrvl_event *) skb->data;
@@ -92,7 +92,7 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 
 	switch (event->data[0]) {
 	case BT_EVENT_AUTO_SLEEP_MODE:
-		if (skb->len <= offsetof(typeof(*event), data[2]))
+		if (skb->len <= struct_offset(event, data[2]))
 			return -EINVAL;
 		if (!event->data[2]) {
 			if (event->data[1] == BT_PS_ENABLE)
@@ -107,7 +107,7 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 		break;
 
 	case BT_EVENT_HOST_SLEEP_CONFIG:
-		if (skb->len <= offsetof(typeof(*event), data[3]))
+		if (skb->len <= struct_offset(event, data[3]))
 			return -EINVAL;
 		if (!event->data[3])
 			BT_DBG("gpio=%x, gap=%x", event->data[1],
@@ -117,7 +117,7 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 		break;
 
 	case BT_EVENT_HOST_SLEEP_ENABLE:
-		if (skb->len <= offsetof(typeof(*event), data[1]))
+		if (skb->len <= struct_offset(event, data[1]))
 			return -EINVAL;
 		if (!event->data[1]) {
 			adapter->hs_state = HS_ACTIVATED;
@@ -131,7 +131,7 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 		break;
 
 	case BT_EVENT_MODULE_CFG_REQ:
-		if (skb->len <= offsetof(typeof(*event), data[2]))
+		if (skb->len <= struct_offset(event, data[2]))
 			return -EINVAL;
 		if (priv->btmrvl_dev.sendcmdflag &&
 				event->data[1] == MODULE_BRINGUP_REQ) {
@@ -150,7 +150,7 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 		break;
 
 	case BT_EVENT_POWER_STATE:
-		if (skb->len <= offsetof(typeof(*event), data[1]))
+		if (skb->len <= struct_offset(event, data[1]))
 			return -EINVAL;
 		if (event->data[1] == BT_PS_SLEEP)
 			adapter->ps_state = PS_SLEEP;
diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 2365a6d8ca15..a751a972aea1 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -108,7 +108,7 @@ static struct dma_resv_list *dma_resv_list_alloc(unsigned int max_fences)
 		return NULL;
 
 	/* Given the resulting bucket size, recalculated max_fences. */
-	list->max_fences = (size - offsetof(typeof(*list), table)) /
+	list->max_fences = (size - struct_offset(list, table)) /
 		sizeof(*list->table);
 
 	return list;
diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index a9cea09355ff..12b8cceb3d20 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -340,7 +340,7 @@ static void *scmi_base_fill_custom_report(const struct scmi_protocol_handle *ph,
 	if (evt_id != SCMI_EVENT_BASE_ERROR_EVENT || sizeof(*p) < payld_sz)
 		return NULL;
 
-	expected_sz = offsetof(typeof(*p), msg_reports);
+	expected_sz = struct_offset(p, msg_reports);
 	if (payld_sz < expected_sz)
 		return NULL;
 
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index b8f882a17c8f..b48c06134276 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -3124,9 +3124,9 @@ EXPORT_SYMBOL(drm_mode_find_dmt);
 
 static bool is_display_descriptor(const struct detailed_timing *descriptor, u8 type)
 {
-	BUILD_BUG_ON(offsetof(typeof(*descriptor), pixel_clock) != 0);
-	BUILD_BUG_ON(offsetof(typeof(*descriptor), data.other_data.pad1) != 2);
-	BUILD_BUG_ON(offsetof(typeof(*descriptor), data.other_data.type) != 3);
+	BUILD_BUG_ON(struct_offset(descriptor, pixel_clock) != 0);
+	BUILD_BUG_ON(struct_offset(descriptor, data.other_data.pad1) != 2);
+	BUILD_BUG_ON(struct_offset(descriptor, data.other_data.type) != 3);
 
 	return descriptor->pixel_clock == 0 &&
 		descriptor->data.other_data.pad1 == 0 &&
@@ -3135,7 +3135,7 @@ static bool is_display_descriptor(const struct detailed_timing *descriptor, u8 t
 
 static bool is_detailed_timing_descriptor(const struct detailed_timing *descriptor)
 {
-	BUILD_BUG_ON(offsetof(typeof(*descriptor), pixel_clock) != 0);
+	BUILD_BUG_ON(struct_offset(descriptor, pixel_clock) != 0);
 
 	return descriptor->pixel_clock != 0;
 }
@@ -3207,8 +3207,8 @@ is_rb(const struct detailed_timing *descriptor, void *data)
 	if (!is_display_descriptor(descriptor, EDID_DETAIL_MONITOR_RANGE))
 		return;
 
-	BUILD_BUG_ON(offsetof(typeof(*descriptor), data.other_data.data.range.flags) != 10);
-	BUILD_BUG_ON(offsetof(typeof(*descriptor), data.other_data.data.range.formula.cvt.flags) != 15);
+	BUILD_BUG_ON(struct_offset(descriptor, data.other_data.data.range.flags) != 10);
+	BUILD_BUG_ON(struct_offset(descriptor, data.other_data.data.range.formula.cvt.flags) != 15);
 
 	if (descriptor->data.other_data.data.range.flags == DRM_EDID_CVT_SUPPORT_FLAG &&
 	    descriptor->data.other_data.data.range.formula.cvt.flags & DRM_EDID_CVT_FLAGS_REDUCED_BLANKING)
@@ -3237,7 +3237,7 @@ find_gtf2(const struct detailed_timing *descriptor, void *data)
 	if (!is_display_descriptor(descriptor, EDID_DETAIL_MONITOR_RANGE))
 		return;
 
-	BUILD_BUG_ON(offsetof(typeof(*descriptor), data.other_data.data.range.flags) != 10);
+	BUILD_BUG_ON(struct_offset(descriptor, data.other_data.data.range.flags) != 10);
 
 	if (descriptor->data.other_data.data.range.flags == DRM_EDID_SECONDARY_GTF_SUPPORT_FLAG)
 		*res = descriptor;
@@ -3251,7 +3251,7 @@ drm_gtf2_hbreak(const struct drm_edid *drm_edid)
 
 	drm_for_each_detailed_block(drm_edid, find_gtf2, &descriptor);
 
-	BUILD_BUG_ON(offsetof(typeof(*descriptor), data.other_data.data.range.formula.gtf2.hfreq_start_khz) != 12);
+	BUILD_BUG_ON(struct_offset(descriptor, data.other_data.data.range.formula.gtf2.hfreq_start_khz) != 12);
 
 	return descriptor ? descriptor->data.other_data.data.range.formula.gtf2.hfreq_start_khz * 2 : 0;
 }
@@ -3263,7 +3263,7 @@ drm_gtf2_2c(const struct drm_edid *drm_edid)
 
 	drm_for_each_detailed_block(drm_edid, find_gtf2, &descriptor);
 
-	BUILD_BUG_ON(offsetof(typeof(*descriptor), data.other_data.data.range.formula.gtf2.c) != 13);
+	BUILD_BUG_ON(struct_offset(descriptor, data.other_data.data.range.formula.gtf2.c) != 13);
 
 	return descriptor ? descriptor->data.other_data.data.range.formula.gtf2.c : 0;
 }
@@ -3275,7 +3275,7 @@ drm_gtf2_m(const struct drm_edid *drm_edid)
 
 	drm_for_each_detailed_block(drm_edid, find_gtf2, &descriptor);
 
-	BUILD_BUG_ON(offsetof(typeof(*descriptor), data.other_data.data.range.formula.gtf2.m) != 14);
+	BUILD_BUG_ON(struct_offset(descriptor, data.other_data.data.range.formula.gtf2.m) != 14);
 
 	return descriptor ? le16_to_cpu(descriptor->data.other_data.data.range.formula.gtf2.m) : 0;
 }
@@ -3287,7 +3287,7 @@ drm_gtf2_k(const struct drm_edid *drm_edid)
 
 	drm_for_each_detailed_block(drm_edid, find_gtf2, &descriptor);
 
-	BUILD_BUG_ON(offsetof(typeof(*descriptor), data.other_data.data.range.formula.gtf2.k) != 16);
+	BUILD_BUG_ON(struct_offset(descriptor, data.other_data.data.range.formula.gtf2.k) != 16);
 
 	return descriptor ? descriptor->data.other_data.data.range.formula.gtf2.k : 0;
 }
@@ -3299,7 +3299,7 @@ drm_gtf2_2j(const struct drm_edid *drm_edid)
 
 	drm_for_each_detailed_block(drm_edid, find_gtf2, &descriptor);
 
-	BUILD_BUG_ON(offsetof(typeof(*descriptor), data.other_data.data.range.formula.gtf2.j) != 17);
+	BUILD_BUG_ON(struct_offset(descriptor, data.other_data.data.range.formula.gtf2.j) != 17);
 
 	return descriptor ? descriptor->data.other_data.data.range.formula.gtf2.j : 0;
 }
@@ -3312,7 +3312,7 @@ get_timing_level(const struct detailed_timing *descriptor, void *data)
 	if (!is_display_descriptor(descriptor, EDID_DETAIL_MONITOR_RANGE))
 		return;
 
-	BUILD_BUG_ON(offsetof(typeof(*descriptor), data.other_data.data.range.flags) != 10);
+	BUILD_BUG_ON(struct_offset(descriptor, data.other_data.data.range.flags) != 10);
 
 	switch (descriptor->data.other_data.data.range.flags) {
 	case DRM_EDID_DEFAULT_GTF_SUPPORT_FLAG:
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
index 9e01f8b2079a..598c1271cae1 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
@@ -101,8 +101,8 @@ void i915_gem_object_init(struct drm_i915_gem_object *obj,
 	 * A gem object is embedded both in a struct ttm_buffer_object :/ and
 	 * in a drm_i915_gem_object. Make sure they are aliased.
 	 */
-	BUILD_BUG_ON(offsetof(typeof(*obj), base) !=
-		     offsetof(typeof(*obj), __do_not_access.base));
+	BUILD_BUG_ON(struct_offset(obj, base) !=
+		     struct_offset(obj, __do_not_access.base));
 
 	spin_lock_init(&obj->vma.lock);
 	INIT_LIST_HEAD(&obj->vma.list);
diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
index b2442f05825e..48a773b3cde9 100644
--- a/drivers/gpu/drm/i915/i915_active.c
+++ b/drivers/gpu/drm/i915/i915_active.c
@@ -263,7 +263,7 @@ static struct active_node *__active_lookup(struct i915_active *ref, u64 idx)
 			return it;
 	}
 
-	BUILD_BUG_ON(offsetof(typeof(*it), node));
+	BUILD_BUG_ON(struct_offset(it, node));
 
 	/* While active, the tree can only be built; not destroyed */
 	GEM_BUG_ON(i915_active_is_idle(ref));
diff --git a/drivers/gpu/drm/i915/i915_sw_fence_work.c b/drivers/gpu/drm/i915/i915_sw_fence_work.c
index 366418108f78..c059bb1e9492 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence_work.c
+++ b/drivers/gpu/drm/i915/i915_sw_fence_work.c
@@ -70,7 +70,7 @@ static void fence_release(struct dma_fence *fence)
 
 	i915_sw_fence_fini(&f->chain);
 
-	BUILD_BUG_ON(offsetof(typeof(*f), dma));
+	BUILD_BUG_ON(struct_offset(f, dma));
 	dma_fence_free(&f->dma);
 }
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
index 63aa30f94747..67dab90119bd 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
@@ -1169,7 +1169,7 @@ r535_gsp_shared_init(struct nvkm_gsp *gsp)
 	cmdq->tx.msgCount = (cmdq->tx.size - cmdq->tx.entryOff) / cmdq->tx.msgSize;
 	cmdq->tx.writePtr = 0;
 	cmdq->tx.flags = 1;
-	cmdq->tx.rxHdrOff = offsetof(typeof(*cmdq), rx.readPtr);
+	cmdq->tx.rxHdrOff = struct_offset(cmdq, rx.readPtr);
 
 	msgq = gsp->shm.msgq.ptr;
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index a9136a6523cb..247f6d9b4494 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -2609,12 +2609,12 @@ static int vmw_cmd_dx_check_subresource(struct vmw_private *dev_priv,
 		};
 	} *cmd;
 
-	BUILD_BUG_ON(offsetof(typeof(*cmd), r_body.sid) !=
-		     offsetof(typeof(*cmd), sid));
-	BUILD_BUG_ON(offsetof(typeof(*cmd), i_body.sid) !=
-		     offsetof(typeof(*cmd), sid));
-	BUILD_BUG_ON(offsetof(typeof(*cmd), u_body.sid) !=
-		     offsetof(typeof(*cmd), sid));
+	BUILD_BUG_ON(struct_offset(cmd, r_body.sid) !=
+		     struct_offset(cmd, sid));
+	BUILD_BUG_ON(struct_offset(cmd, i_body.sid) !=
+		     struct_offset(cmd, sid));
+	BUILD_BUG_ON(struct_offset(cmd, u_body.sid) !=
+		     struct_offset(cmd, sid));
 
 	cmd = container_of(header, typeof(*cmd), header);
 	return vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 5301e4f21ade..1662aeebf134 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -780,7 +780,7 @@ int bnxt_qplib_post_srq_recv(struct bnxt_qplib_srq *srq,
 	srqe->wqe_type = wqe->type;
 	srqe->flags = wqe->flags;
 	srqe->wqe_size = wqe->num_sge +
-			((offsetof(typeof(*srqe), data) + 15) >> 4);
+			((struct_offset(srqe, data) + 15) >> 4);
 	srqe->wr_id[0] = cpu_to_le32((u32)next);
 	srq->swq[next].wr_id = wqe->wr_id;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 7dfaa01cda67..df4d57c4e85e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -287,7 +287,7 @@ static int alloc_cq_db(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
 
 	if (udata) {
 		if (has_db &&
-		    udata->outlen >= offsetofend(typeof(*resp), cap_flags)) {
+		    udata->outlen >= struct_offsetofend(resp, cap_flags)) {
 			uctx = rdma_udata_to_drv_context(udata,
 					struct hns_roce_ucontext, ibucontext);
 			err = hns_roce_db_map_user(uctx, addr, &hr_cq->db);
@@ -378,7 +378,7 @@ static int set_cqe_size(struct hns_roce_cq *hr_cq, struct ib_udata *udata,
 		return 0;
 	}
 
-	if (udata->inlen >= offsetofend(typeof(*ucmd), cqe_size)) {
+	if (udata->inlen >= struct_offsetofend(ucmd, cqe_size)) {
 		if (ucmd->cqe_size != HNS_ROCE_V2_CQE_SIZE &&
 		    ucmd->cqe_size != HNS_ROCE_V3_CQE_SIZE) {
 			ibdev_err(&hr_dev->ib_dev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index c6c0dfdbdbc3..e46c6cc1e3ee 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -836,9 +836,9 @@ static inline bool user_qp_has_sdb(struct hns_roce_dev *hr_dev,
 				   struct hns_roce_ib_create_qp *ucmd)
 {
 	return ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB) &&
-		udata->outlen >= offsetofend(typeof(*resp), cap_flags) &&
+		udata->outlen >= struct_offsetofend(resp, cap_flags) &&
 		hns_roce_qp_has_sq(init_attr) &&
-		udata->inlen >= offsetofend(typeof(*ucmd), sdb_addr));
+		udata->inlen >= struct_offsetofend(ucmd, sdb_addr));
 }
 
 static inline bool user_qp_has_rdb(struct hns_roce_dev *hr_dev,
@@ -847,7 +847,7 @@ static inline bool user_qp_has_rdb(struct hns_roce_dev *hr_dev,
 				   struct hns_roce_ib_create_qp_resp *resp)
 {
 	return ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB) &&
-		udata->outlen >= offsetofend(typeof(*resp), cap_flags) &&
+		udata->outlen >= struct_offsetofend(resp, cap_flags) &&
 		hns_roce_qp_has_rq(init_attr));
 }
 
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 644c2f1cd8e6..4cf876f4b7ea 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -1108,7 +1108,7 @@ static int uvc_v4l2_get_xu_mapping(struct uvc_xu_control_mapping *kp,
 static int uvc_v4l2_put_xu_mapping(const struct uvc_xu_control_mapping *kp,
 			struct uvc_xu_control_mapping32 __user *up)
 {
-	if (copy_to_user(up, kp, offsetof(typeof(*up), menu_info)) ||
+	if (copy_to_user(up, kp, struct_offset(up, menu_info)) ||
 	    put_user(kp->menu_count, &up->menu_count))
 		return -EFAULT;
 
@@ -1147,7 +1147,7 @@ static int uvc_v4l2_get_xu_query(struct uvc_xu_control_query *kp,
 static int uvc_v4l2_put_xu_query(const struct uvc_xu_control_query *kp,
 			struct uvc_xu_control_query32 __user *up)
 {
-	if (copy_to_user(up, kp, offsetof(typeof(*up), data)))
+	if (copy_to_user(up, kp, struct_offset(up, data)))
 		return -EFAULT;
 	return 0;
 }
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 962251327506..efebabd1ae04 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1041,7 +1041,7 @@ static int rndis_filter_set_packet_filter(struct rndis_device *dev,
 	set = &request->request_msg.msg.set_req;
 	set->oid = RNDIS_OID_GEN_CURRENT_PACKET_FILTER;
 	set->info_buflen = sizeof(u32);
-	set->info_buf_offset = offsetof(typeof(*set), info_buf);
+	set->info_buf_offset = struct_offset(set, info_buf);
 	memcpy(set->info_buf, &new_filter, sizeof(u32));
 
 	ret = rndis_filter_send_request(dev, request);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 0982e60842b1..01bdc0e9635d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -736,7 +736,7 @@ static void iwl_parse_dbg_tlv_assert_tables(struct iwl_drv *drv,
 	u32 length = le32_to_cpu(tlv->length);
 	u32 addr;
 
-	if (length < offsetof(typeof(*region), special_mem) +
+	if (length < struct_offset(region, special_mem) +
 		     sizeof(region->special_mem))
 		return;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index e2382be8edd7..5faa97a420d8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -625,7 +625,7 @@ void iwl_mvm_rs_fw_rate_init(struct iwl_mvm *mvm,
 	cfg_cmd.sta_id = mvm_link_sta->sta_id;
 
 	lq_sta = &mvm_link_sta->lq_sta.rs_fw;
-	memset(lq_sta, 0, offsetof(typeof(*lq_sta), pers));
+	memset(lq_sta, 0, struct_offset(lq_sta, pers));
 
 	rcu_read_unlock();
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index d1619a229d8f..da0669155a3b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -2939,7 +2939,7 @@ static void rs_drv_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	lockdep_assert_held(&mvmsta->deflink.lq_sta.rs_drv.pers.lock);
 
 	/* clear all non-persistent lq data */
-	memset(lq_sta, 0, offsetof(typeof(*lq_sta), pers));
+	memset(lq_sta, 0, struct_offset(lq_sta, pers));
 
 	sband = hw->wiphy->bands[band];
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c
index 0009a05511af..a5a065275f18 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c
@@ -241,7 +241,7 @@ int iwl_pcie_ctxt_info_v2_alloc(struct iwl_trans *trans,
 	 * optional; old devices _should_ be fine with a bigger size,
 	 * but in simulation we check the size more precisely.
 	 */
-	BUILD_BUG_ON(offsetofend(typeof(*prph_scratch), dram.common) +
+	BUILD_BUG_ON(struct_offsetofend(prph_scratch, dram.common) +
 		     sizeof(prph_scratch->dram.fseq_img) !=
 		     sizeof(*prph_scratch));
 	if (control_flags_ext & IWL_PRPH_SCRATCH_EXT_EXT_FSEQ)
@@ -249,8 +249,7 @@ int iwl_pcie_ctxt_info_v2_alloc(struct iwl_trans *trans,
 			cpu_to_le32(sizeof(*prph_scratch));
 	else
 		ctxt_info_v2->prph_scratch_size =
-			cpu_to_le32(offsetofend(typeof(*prph_scratch),
-						dram.common));
+			cpu_to_le32(struct_offsetofend(prph_scratch, dram.common));
 
 	ctxt_info_v2->cr_head_idx_arr_base_addr =
 		cpu_to_le64(trans_pcie->rxq->rb_stts_dma);
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 3d0c22db30a8..79b4bb78b17a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -6167,7 +6167,7 @@ static void rtl8xxxu_c2hcmd_callback(struct work_struct *work)
 		case C2H_8723B_RA_REPORT:
 			bw = rarpt->txrate.bw;
 
-			if (skb->len >= offsetofend(typeof(*c2h), ra_report.bw)) {
+			if (skb->len >= struct_offsetofend(c2h, ra_report.bw)) {
 				if (c2h->ra_report.bw == RTL8XXXU_CHANNEL_WIDTH_40)
 					bw = RATE_INFO_BW_40;
 				else
diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 945fedcd375b..d1a1a492d146 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -159,7 +159,7 @@ static void rtw_fw_ra_report_iter(void *data, struct ieee80211_sta *sta)
 
 	rate = u8_get_bits(ra_rpt->rate_sgi, RTW_C2H_RA_RPT_RATE);
 	sgi = u8_get_bits(ra_rpt->rate_sgi, RTW_C2H_RA_RPT_SGI);
-	if (ra_data->length >= offsetofend(typeof(*ra_rpt), bw))
+	if (ra_data->length >= struct_offsetofend(ra_rpt, bw))
 		bw = ra_rpt->bw;
 	else
 		bw = si->bw_mode;
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 5220f74d15d2..85b04a610920 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2605,7 +2605,7 @@ static void rtw89_vif_sync_bcn_tsf(struct rtw89_vif_link *rtwvif_link,
 {
 	struct ieee80211_mgmt *mgmt = (typeof(mgmt))hdr;
 
-	if (len < offsetof(typeof(*mgmt), u.beacon.variable))
+	if (len < struct_offset(mgmt, u.beacon.variable))
 		return;
 
 	WRITE_ONCE(rtwvif_link->sync_bcn_tsf, le64_to_cpu(mgmt->u.beacon.timestamp));
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 21b548c63c78..a4b6514a0ce5 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -8067,11 +8067,11 @@ int rtw89_fw_h2c_scan_list_offload_be(struct rtw89_dev *rtwdev, int ch_num,
 
 	if (RTW89_CHK_FW_FEATURE(CH_INFO_BE_V0, &rtwdev->fw)) {
 		ver = 0;
-		elem_size = offsetofend(typeof(*elem), w7);
+		elem_size = struct_offsetofend(elem, w7);
 		used_len = sizeof(*h2c) + elem_size * ch_num;
 	} else if (RTW89_CHK_FW_FEATURE(CH_INFO_BE_V1, &rtwdev->fw)) {
 		ver = 1;
-		elem_size = offsetofend(typeof(*elem), w7);
+		elem_size = struct_offsetofend(elem, w7);
 		used_len = sizeof(*h2c) + elem_size * ch_num;
 	}
 
@@ -8350,10 +8350,10 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 	rtw89_scan_get_6g_disabled_chan(rtwdev, option);
 
 	if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD_BE_V0, &rtwdev->fw)) {
-		cfg_len = offsetofend(typeof(*h2c), w8);
+		cfg_len = struct_offsetofend(h2c, w8);
 		scan_offload_ver = 0;
 	} else if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD_BE_V1, &rtwdev->fw)) {
-		cfg_len = offsetofend(typeof(*h2c), w9);
+		cfg_len = struct_offsetofend(h2c, w9);
 		scan_offload_ver = 1;
 	} else if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD_BE_V2, &rtwdev->fw)) {
 		scan_offload_ver = 2;
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 49ec2948c68a..f1c3938b429a 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -1622,12 +1622,12 @@ static void mac80211_hwsim_write_tsf(struct mac80211_hwsim_data *data,
 	if (txrate)
 		bitrate = txrate->bitrate;
 
-	if (skb->len >= offsetofend(typeof(*mgmt), u.probe_resp.timestamp) &&
+	if (skb->len >= struct_offsetofend(mgmt, u.probe_resp.timestamp) &&
 	    ieee80211_is_probe_resp(hdr->frame_control)) {
 		mgmt->u.probe_resp.timestamp =
 			cpu_to_le64(sim_time + data->tsf_offset +
 				    24 * 8 * 10 / bitrate);
-	} else if (skb->len >= offsetofend(typeof(*mgmt), u.beacon.timestamp) &&
+	} else if (skb->len >= struct_offsetofend(mgmt, u.beacon.timestamp) &&
 		   ieee80211_is_beacon(mgmt->frame_control)) {
 		mgmt->u.beacon.timestamp = cpu_to_le64(sim_time +
 						       data->tsf_offset +
diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index 96dde19b15fa..df2a0dfe7cc3 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -460,7 +460,7 @@ static ssize_t sequence_store(struct device *dev, struct device_attribute *attr,
 	param = (struct ec_params_lightbar *)msg->data;
 	param->cmd = LIGHTBAR_CMD_SEQ;
 	param->seq.num = num;
-	msg->outsize = offsetof(typeof(*param), seq) + sizeof(param->seq);
+	msg->outsize = struct_offset(param, seq) + sizeof(param->seq);
 	msg->insize = 0;
 	ret = lb_throttle();
 	if (ret)
@@ -508,7 +508,7 @@ static ssize_t program_store(struct device *dev, struct device_attribute *attr,
 		 * Bound the payload strictly by the maximum value the structural
 		 * size field can natively support.
 		 */
-		extra_bytes = offsetof(typeof(*param), set_program_ex) +
+		extra_bytes = struct_offset(param, set_program_ex) +
 			sizeof(param->set_program_ex);
 		max_size = min_t(size_t, ec->ec_dev->max_request - extra_bytes,
 				 type_max(typeof(param->set_program_ex.size)));
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 20b1aef455c4..159daefd249e 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -185,7 +185,7 @@ qla2x00_chk_ms_status(scsi_qla_host_t *vha, ms_iocb_entry_t *ms_pkt,
 				    comp_status, ct_rsp->header.response);
 				ql_dump_buffer(ql_dbg_disc + ql_dbg_buffer, vha,
 				    0x2078, ct_rsp,
-				    offsetof(typeof(*ct_rsp), rsp));
+				    struct_offset(ct_rsp, rsp));
 				rval = QLA_INVALID_COMMAND;
 			} else
 				rval = QLA_SUCCESS;
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 59ec5605930b..665c3d628d45 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -3225,7 +3225,7 @@ qla2x00_get_link_status(scsi_qla_host_t *vha, uint16_t loop_id,
 	mbx_cmd_t mc;
 	mbx_cmd_t *mcp = &mc;
 	uint32_t *iter = (uint32_t *)stats;
-	ushort dwords = offsetof(typeof(*stats), link_up_cnt)/sizeof(*iter);
+	ushort dwords = struct_offset(stats, link_up_cnt)/sizeof(*iter);
 	struct qla_hw_data *ha = vha->hw;
 
 	ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x1084,
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 3c412c7fb6fe..8e6a953dc3f7 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -6263,7 +6263,7 @@ void qla24xx_process_purex_rdp(struct scsi_qla_host *vha,
 
 	if (qla25xx_rdp_rsp_reduce_size(vha, purex)) {
 		rsp_payload_length =
-		    offsetof(typeof(*rsp_payload), optical_elmt_desc);
+		    struct_offset(rsp_payload, optical_elmt_desc);
 		ql_dbg(ql_dbg_init, vha, 0x0181,
 		    "Reducing RSP payload length to %u bytes...\n",
 		    rsp_payload_length);
diff --git a/drivers/scsi/qla2xxx/qla_tmpl.c b/drivers/scsi/qla2xxx/qla_tmpl.c
index f96b9eb15126..288239644ac9 100644
--- a/drivers/scsi/qla2xxx/qla_tmpl.c
+++ b/drivers/scsi/qla2xxx/qla_tmpl.c
@@ -7,7 +7,7 @@
 #include "qla_tmpl.h"
 
 #define ISPREG(vha)	(&(vha)->hw->iobase->isp24)
-#define IOBAR(reg)	offsetof(typeof(*(reg)), iobase_addr)
+#define IOBAR(reg)	struct_offset((reg), iobase_addr)
 #define IOBASE(vha)	IOBAR(ISPREG(vha))
 #define INVALID_ENTRY ((struct qla27xx_fwdt_entry *)0xffffffffffffffffUL)
 
@@ -722,7 +722,7 @@ static struct qla27xx_fwdt_entry *
 qla27xx_fwdt_entry_t275(struct scsi_qla_host *vha,
 	struct qla27xx_fwdt_entry *ent, void *buf, ulong *len)
 {
-	ulong offset = offsetof(typeof(*ent), t275.buffer);
+	ulong offset = struct_offset(ent, t275.buffer);
 	ulong length = le32_to_cpu(ent->t275.length);
 	ulong size = le32_to_cpu(ent->hdr.size);
 	void *buffer = ent->t275.buffer;
diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index bec6ca38375b..09ee87ebd5d1 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -570,7 +570,7 @@ fc_host_post_fc_event(struct Scsi_Host *shost, u32 event_number,
 	event->event_code = event_code;
 	if (data_len)
 		memcpy(event->event_data_flex, data_buf, data_len);
-	padding = len - offsetof(typeof(*event), event_data_flex) - data_len;
+	padding = len - struct_offset(event, event_data_flex) - data_len;
 	memset(event->event_data_flex + data_len, 0, padding);
 
 	nlmsg_multicast(scsi_nl_sock, skb, 0, SCSI_NL_GRP_FC_EVENTS,

-- 
2.56.1

