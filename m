Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8947606A323
	for <cocci@archiver.kernel.org>; Fri, 13 Nov 2026 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=Kdsw/x+c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:message-id:content-transfer-encoding:to:cc:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=OFmn5D1w/9s9cA7yHY4Wcn1s0toNXyKoWVPSKmaAm1M=;
  b=Kdsw/x+celCn39ZSRkHRa3O16/NhsWqk3boZBfwLLys4hfVCDAPR/+bG
   POFkjsVGBL2n6AAKzrEXEpdpNW6I0cLBN5Mr1W4zIDbXrStYmXSc8ZGaJ
   k82+TAito19fPZIrb/KnQ/thevWmDz2NQ3Unnxe5AnGH8mJzd7ek+yMYr
   0=;
X-CSE-ConnectionGUID: r++lPtCRRU62uX5oSpTivA==
X-CSE-MsgGUID: p8Sg7baJRx+5i+Hm95W9KA==
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
   d="scan'208";a="305341309"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Nov 2026 19:05:42 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id AADD280524; Fri, 13 Nov 2026 19:05:42 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id A4A02805EA
	for <cocci@sympa.inria.fr>; Fri, 13 Nov 2026 17:08:39 +0100 (CET)
X-CSE-ConnectionGUID: 0XhLX8OYShSEy8FL3zMEvg==
X-CSE-MsgGUID: huWVlnJfTfmrC3B471mXpg==
IronPort-SDR: 6af73605_fPQVLiYuuvdEjbzEAl/NXCsVkzBYjmwDI+jbMfBknq62nZX
 Q4q9qT7oi9fDNqU9aoXz8xF2jcocvDhBjUJcxqw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EdAjOXNPdqgRBTZTRagRWBRIFuU0IBSIEUB1GEWINNA?=
 =?us-ascii?q?QGFK4h6i2iMW4QNKoErgT81Cg8BAwELAQEuDxQEAQEBAgEDhH5RFY09HwcBB?=
 =?us-ascii?q?DIHDgECBAMCAwEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABATsHD?=
 =?us-ascii?q?juGTw2MGgEzcV5HAQEBAQEBAQEBAQEBAQEBAQEBAQEBARQCCAVeASEBBBERD?=
 =?us-ascii?q?wENAQE3ATQCJgIiBwoVFgESIoJgAYIkBBIDNwQCDgUBrzVzAgKKG3qBMoEBg?=
 =?us-ascii?q?gwBAQaBCYFh2EwNcoFrAwYJAQuBCi6FdIJOIAGBcYF4ghA7hEI2gVVEhx6CD?=
 =?us-ascii?q?oNygmqBEoEUgQyCXIlWi0UJP4ECHANZLAFVEw0KCwcFY1IzAyAKCxISGBUCF?=
 =?us-ascii?q?B0SDwQWMh1wDCcSLBcvWBsGBYEccxQEE4ESgQUJVIErKF0BIYEITgEDAoEhA?=
 =?us-ascii?q?gaCS4IAAgFJQQ4HRVMJJUMSRyQiCBIJARMaLAqBGjU8CSY/FQxnCxoFYQgCD?=
 =?us-ascii?q?Qx0ORAwHiQvBRomPhsKgQ4FGA1IESw3Bg8ZBD0BbgeSeIMUAYEPKyIugUOTW?=
 =?us-ascii?q?INurmk9NAeEI4FgCAyKMI0+ggCGFzKqci6YWiOLbYF6hAqGFpBvAgQCBAUCE?=
 =?us-ascii?q?QEBBoFvATKBXDMaI1CCZ1ADGQ+SJINSi2sBvnx4AjsCBwIHAQwBAwuGRosjM?=
 =?us-ascii?q?4FMAQE?=
IronPort-PHdr: A9a23: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
 xX+W3x61QuYlxFtojNjqtqI5cUhYo66PJR8rhc=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:rQWeXqMpBpreJMBcT93255DYdb4zR+YMi2TDiHoddfUFSKalfp
 6V98jzjSWE8wr4WBkb6LO90dq7MAnhHP9OkMQs1NKZMDUO11HYS72KgbGC/9SkIVyHygc/79
 YtT0EdMqyXMbESt6+Tj2eF+pQbsaC6GcuT9IXjJgJWPGVXgtZbnmJE42igcnFedU1rFJA5HJ
 2T6o59oSa8eXMYV8K/BnMUdenOrd/GmfvdEFE7Li9izDPLoSKj6bb8HRTd9AwZSSlzzbAr9n
 WAuxDl54242svLiyP05iv21dB7idHhwtxMCIinkc4OMAjhjQ6uecBIR6CChjYou+uigWxa0O
 Uk4i1QfPib2UmhO11dkiGdnzUIFwxerEMK/GXow0cLZ/aJAg7SRfAx3L6xOSGplnbI9OsMrJ
 6jmVjp+aa/RCmw4xjV9pzGUQpnmVGzpmdnmekPj2ZHWY9bc7NJq5cDlXklWKvosxiKm7zPPd
 Meev003swmOG+yfjTcpC1i0dasVnM8ElOPRVUDoNWc13xTkGpix0UVycQDljNYnahNAaVs9q
 DBKOBlhbtORsgZYeZ0A/oAW9K+DijITQjXOGyfLFz7HOUMOm7LqZTw/LIpjdvaM6Ag3d83gt
 DMQVlYvWk9dwbnDtCPxoRC9lTXTGC0TV3Wu7ZjDlhCy8nBrZbQQF2+oQoV4rWdSt0kc7zmcu
 f2JJVXDfOmIGfyFYxV3wv4H5RTMnUVTYkQoJIgX0+Wy/i7WLHCp6jGd/bcKP7oC3ItXX7+GG
 IKWHz+I81K60ynM0WI9STsZw==
X-Talos-CUID: 9a23:lXO9w2B7UKFUeJP6E3FX9GokSucUSX3m4WaADWvjG0NEVrLAHA==
X-Talos-MUID: 9a23:A7yJQgjnNxd8UgmTX08XyMMpNNpX3aCoKk4xn5AckJKuaXMpPgeFg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,211,1787004000"; 
   d="scan'208";a="162591911"
X-IronPort-Outbreak-Status: No, level 1, Phish - Phish
X-MGA-submission: =?us-ascii?q?MDEY6CfKQG1uSiYf8p/TuLLd1aHEmo5tmFAV2i?=
 =?us-ascii?q?HOPC3ZuXiHuwmRqvJUjlXM82u2FKCSxwL6kUOb9N7dZXdXrI3QywiYxV?=
 =?us-ascii?q?a0gPh2Xvf0B/+E+yedl9w/k4WkB0XL8WXua7h+iXOc28jSvgMqmz3OX8?=
 =?us-ascii?q?+dWjVob+k6w/1V/nq99NFsKg=3D=3D?=
Received: from mail-swedencentralazon11013016.outbound.protection.outlook.com (HELO GVXPR05CU001.outbound.protection.outlook.com) ([52.101.83.16])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 17:08:36 +0100
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=U+xc/Q3omfwsEnYC9DslNPFow6NBD6IwHzUdTboDIMCEltQbuAGrTSQexQQ3m0ntbuv5Y+8sejAS3yLxLKPfugajW1yiFaBXWT9CmDayN6B9MJlXOqlng0SD2D7VsdjmSX6H8cPNxwSBirb2tNnITWhHPqL60bUAAh9BqnbWCTAsXsWLMSQVd3QDGMyd9ylWxdgyE7aBHhWmv0bDc/2NTJphXn4oNfJJWlljdPJukjh27Si4RyQM1LQaxBUo0ObKByhoYqosbUByMbPj+YvRugpW/CrHHGVOfpVu89i/I2ohXV963sUHtGMn7266Sh8UE1IUWaSvyIoaaelCNpG7KA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFmn5D1w/9s9cA7yHY4Wcn1s0toNXyKoWVPSKmaAm1M=;
 b=y8AUhkVFxCaUv+NrC+WbATepwZqRj6UvK1jr+4u/Eab2KjRDVqHScXdJXFNHtZYVJ4GZvSeintc6+B7syD0mtkrQetw2CHE8+xHct8cW9rC7H/0ciNGcbn2R19G81oNWd/cB0Ju1ryRftuXbY190ZZtyHwHCT02OITaNb3bVwVT8atmgMsLbKKUvvmcKxGuo7PpwudoohxjeVuPi1UbPEPA6qekwAG5mQS9iAxxl8GUgrHrwl49B6VrpYdmGFu+aV7idX0iKgr1Ag7SKHSIYgmFEvTrMBZ+oAOkrERD+VQ2WtJuW5+GrC0/1u7quw9R14IsFF7XasKB12Ryr7l1EjA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
Received: from DB8P191CA0030.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::40)
 by PAVPR08MB9209.eurprd08.prod.outlook.com (2603:10a6:102:30a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 16:08:25 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::6b) by DB8P191CA0030.outlook.office365.com
 (2603:10a6:10:130::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Fri, 13
 Nov 2026 16:08:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 13 Nov 2026 16:08:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFlJHGaiadeYi1AaoHU+Iq3wVZrYNzIJ0XxGvoejgZkFz3ZVzQoGPXyvbK2ijab6ldLR2zImB2eRlNqH0QteNpg3Enff7TLuLhwRoV0pfydSg6CMun7gqOgmJy5RiW8cq9sSR4v29g7EUqyOcn1t7ox6ICJjrTTPl+Wictb8ymmCn7AqXd2L6tKmmywwoguwy93EGlz027W3jB+s9RYQzn2PRADxojpJN4+O46Y89LSwhBaZ+AVEkY056p/HLwiJpWHJycOj6LEIZxrndFGoDl8ANnaQlgZzBXHwnbRAUJAbpQsuSLAAYGJsMqBIfqIWRsH5HiKtBcRlvIxQkGYSVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFmn5D1w/9s9cA7yHY4Wcn1s0toNXyKoWVPSKmaAm1M=;
 b=lCej6tIo2YqzNd0clf1CEytJ24wKPpjXuRNooMomUz40WSi/cLUgz7N6l6LvbHqiFmX7MProPiWmy2WC9hbD8aRhfKnQQkBdSXD4eG54eSh1gPyUfWSmRdRR9Ip6SBXlVLbR6SaC8Nlf+dA1hZMbRGmCL69w104LeljiJpKCEN6UfoZ/ax1dZK0lM3D24FZLxtJHe5AVv6NXwhXuLzb5o43qqHqeGm75DpOjGDDDFBZkG8cMEgprachpvDR67HhS7YrxgtZ2JY8o6jPJLqzy6KIt/z3o8GVLxhb8f3dX0aJq09rVjhi4UwPdvnq8lgK0ecIa9RjivITrwlBw4WfYgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 (2603:10a6:20b:629::15) by AMDPR08MB11367.eurprd08.prod.outlook.com
 (2603:10a6:20b:717::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 16:07:51 +0000
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c]) by AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c%6]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 16:07:51 +0000
From: Bence Csokas <bence.csokas@arm.com>
Date: Fri, 13 Nov 2026 17:07:30 +0100
Message-Id: <20261113-offsetof-v3-0-714df7053893@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMI192oC/22OzQ7CIBCEX6XhLIaflraefA/jgcJiMWkxgETT9
 N2FerAHj7M738wsKIC3ENCpWpCHZIN1cxb8UCE1yvkG2OqsESNMUEoa7IwJEJ3BRjApBa87QzT
 K9ocHY19b1OX61eE53EHFwhfHIAPgwctZjeU0yRDBl8doQ3T+vY1ItAT86UsUE1zThptGUQJan
 aWfjspNqLQltsMo22EsY6wVoKHjfS/aH7au6wfYxw++AAEAAA==
X-Change-ID: 20261105-offsetof-f62aa6348f0d
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
	AS8PR08MB10291:EE_|AMDPR08MB11367:EE_|DB1PEPF000509F9:EE_|PAVPR08MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc51c60-4a3c-4582-a8fd-08df41a05850
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|10067099003|11063799006|56012099006|261022075727099003|261022115727099003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|261021121427099003|261021123027099003|261021135927099003|261102123227099003|261009221727099003|261009223327099003|261009221227099003|261009223027099003|261009220027099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 0GqxmAlMIXtyeH7PxXVmri8kRG8z7DrPE99+VFM/M9YhLgxgI43m+DCi64tgSMBPy7Khu2V1mDmNEdB8ylSBOv3lk8ruIJ+kvIBnz01NT42ALaL3J+REErLpZWjD3HckeOOCEY1ZYJGFME3HnlBWnXp5At09pSj+POqMUxC0Ya8pNAcNi867CAU0q2Qe9aQErK1nDs4PceazVWxuHjl2JJvctu5mos/DE+ByBYKzk3KlTvNAMD5BZ4LZ354sJehIjweohNSqA8kutEqLnfb6OUfAeMSgXtG6LYCKnVIO7h0M0uvYR6rIz/+Y+edm3xSYsbfQ4QqA6glRkgo7f4q2LTcBzt/EJCtgopGS/OM2Hf2WeA94XO0ZWxt16X49OehRMM1RSuIgxH3JIXeEZvy0JzbRSazRkQMyoS9n6UaQJtzpClApOpilpc4XMXzAJ9btC1dr+Kog24iZZIj94Z+QLzrCZIrB1iQtqNgNPsb9uLgKjdX/LGjwucbtTgyKa6cOuQV/rbQT+EmTh+ZYI3vzezl5F3j68gzUG8x4C85Yph9rTj4jzqbVM9McUAY6DykP2nRD8JHgNodU5NDhg4MwhhPOSc8gGx9sEG/x+E814i4kOcLpz/lMIF6nUPFENXZDbuVTUQOkITqwcG/TIsZtvmpkmJ9vBmAs/GDmP5doLRg=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB10291.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(10067099003)(11063799006)(56012099006)(261022075727099003)(261022115727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261021135927099003)(261102123227099003)(261009221727099003)(261009223327099003)(261009221227099003)(261009223027099003)(261009220027099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 pxeCfIZBP1VabGwKwB+kksErX+diPKbSFzRb8XWSnkwcYzMkMnS4wLOc6dAqNnnP4HJWUR9wPTF0Ln4CSvbdDYVqvSRH0Q5rZQM7f3J0JEfEKj7tPBQr1B3rBXOiZrTnjTzzuKYLtcQX2rC3TIK1F5rt1HM3iTtqmjl8YgmM4ixsOwNvNOwFoAqkIth2v7Hgcg9wKQecIvO8jmHdRU0P8vcvfaK1XB2ug7DzqhkI8bJ+9xKrJTLHriXqTtyR37XYD+BMerb4qX9wFxpLdtM3c/d8sFFc2rZzKgDH2j/psOHi8Ra4Xj+WFglN2eBk9HnuZQdiee3Hy93cO+euuaFq5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11367
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9cb5beae-4aae-4c78-f29b-08df41a04471
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|35042699022|14060799003|1800799024|23010399003|36860700016|82310400026|921020|10067099003|11063799006|56012099006|261022115727099003|261026121527099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261026140227099003|261021123027099003|261021135927099003|261102123227099003|261009223327099003|261009221727099003|261009221227099003|261009223027099003|261009220027099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	w3oqt/nbwQIBZYgeHjkiGa4X+wBoLJAkrp1/sn/jOnQmFmo9Fs+gzv7UJnWDxL+u0dGqatwtVjWjJ747aNhz9vpL+DNQSU6CUojB7xyKqoPuzKenw1KtHMxHvTJaa/NPNjnK1h/LFsiOwj1c3QucTPtDBe6qZyrSTq4duAsq4TTZRP6Ll8KhghMt6PL6kVlb8/rFFrWq3i2Nj5pYtcx0gyBJ0z4GbTRPM46PKtCIqjvxY0rxGrUUGiwIxcPfe26V9UAeu44ZLE3nLg7fab1y4TvqqUxJENC32kyp6ca9cHfMc3lf73tEIQX9oUbBi4+3e2LbRVEKen/QjMSOIAZiu6EglODZSpywUywm2hk0QalxezcguLngVSLCrCpG0ZyeH3zILXjg7wUkaxj8Fthw+sWv6IK+3xuOtgsVsDBEto48yXvYEKBRJvFKDozNuu8kpB1uVLK+DlD+Zl+WeEukhrYAgH2q02ZiI0XDkNpaKBVriatnAOqIJLI1q/N9nWcevVkypjCvMeyRDHJWt1lI8ImF23y3toQ6RWJtTMKPKFgglQV5EoFGS3NKGh/JM74xnB6cv+/1aLB94nvmrdYoVvMqYcVb3ms39/0wzNaG+AQ0pY9JmFY53x7gPBagy4fEA25qNERKRyjljkv0Nmd06NwFO6Fok6CBkCUA1vri21L5KClUgldY4hpG5Ah5w6+HXlspxGwAqwpG+soSU4pUQQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(35042699022)(14060799003)(1800799024)(23010399003)(36860700016)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(261022115727099003)(261026121527099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261026140227099003)(261021123027099003)(261021135927099003)(261102123227099003)(261009223327099003)(261009221727099003)(261009221227099003)(261009223027099003)(261009220027099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c+Cd+wBN1h8uQDWVDz7lRuAQvZSa1ptb9esLUmYSZrmcRQNMOooq1G0y3onoL43atP18UfTa7RKC3CdrsSRL6tqOVBuPz4Ms8fL42/qlKQSx1lx1XWPSYoag2JKMlQh5k/YgZoQ8NRNNDItPzo6M5n8tGH35BB+6y7Px2jx6aGEsqxPbIW3hAGjTKbyJK2mOM4p//mUbSfxnDE+4cUbJ52vJnVSvFibscE39i3SCCLrzKC3pMyyXQ2MRVwI27rfQyWjQln2OanqzUGMuWSwKdD5AToLSLUWOHbVQsGXd3plfqqqRP7Y5Pn+ihFiyJW+Tx8FYr94Tnl5mLufjH4yDyr8Kb0A1q/i3LFN2c55cTcH4GWiVSaQNzqDGc7HTLJ2GsILTOiuOaBQjihaGFcsmx7Vuck9gnw+YiyHxxhofiJlEsGt+0ZJxDmdNbSn0JMsB
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:08:24.1326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc51c60-4a3c-4582-a8fd-08df41a05850
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9209
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v3 0/2] Add struct_offsetofend() for pointer
 arithmetic
Reply-To: Bence Csokas <bence.csokas@arm.com>
X-Loop: cocci@inria.fr
X-Sequence: 3804
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/vK7-9XujYFkzqh2QuvyZyw>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A common usage pattern for offsetof() is the following:

  offsetof(typeof(*ptr), member)

This is exactly the definition of struct_offset(). Some call sites use
offsetofend() instead of offsetof(). Add this variant, then replace all
call sites with the corresponding macros.

Signed-off-by: Bence Csokas <bence.csokas@arm.com>
---
Changes in v3:
- Add Coccinelle patch to tree instead of just the commit msg
- Fix Sashiko issues in prefix, commit msg and doc-comment
- Link to v2: https://patch.msgid.link/20261112-offsetof-v2-0-276ede839967@arm.com

Changes in v2:
- Use struct_offset() instead of reinventing it
- Rename offsetofendp() to struct_offsetofend()
- Merge the two treewide patches
- Link to v1: https://patch.msgid.link/20261105-offsetof-v1-0-4153f5c10edc@arm.com

To: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>
To: Christian König <christian.koenig@amd.com>
To: Philipp Stanner <phasta@kernel.org>
To: Sudeep Holla <sudeep.holla@kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Jani Nikula <jani.nikula@linux.intel.com>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>
To: Lyude Paul <lyude@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>
To: Zack Rusin <zack.rusin@broadcom.com>
To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
To: Chengchang Tang <tangchengchang@huawei.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Hans de Goede <hansg@kernel.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: Jes Sorensen <Jes.Sorensen@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>
To: Benson Leung <bleung@chromium.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <groeck@chromium.org>
To: Nilesh Javali <njavali@marvell.com>
To: GR-QLogic-Storage-Upstream@marvell.com
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
To: "Martin K. Petersen" <mkp@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
To: Nicolas Palix <nicolas.palix@imag.fr>
Cc: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: arm-scmi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: intel-gfx@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: linux-rdma@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: chrome-platform@lists.linux.dev
Cc: linux-scsi@vger.kernel.org
Cc: cocci@inria.fr

---
Bence Csokas (2):
      overflow: Add offsetofend() variant of struct_offset()
      treewide: Use struct_offset()

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
 include/linux/overflow.h                           | 12 ++++++++++
 scripts/coccinelle/api/struct_offsetof.cocci       | 14 ++++++++++++
 31 files changed, 89 insertions(+), 64 deletions(-)
---
base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
change-id: 20261105-offsetof-f62aa6348f0d

Best regards,
--  
Bence Csokas <bence.csokas@arm.com>

