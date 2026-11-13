Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB93606A330
	for <cocci@archiver.kernel.org>; Fri, 13 Nov 2026 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=h1IBUhKP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:content-transfer-encoding:message-id:
   references:in-reply-to:to:cc:mime-version:subject:
   reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=AmIyWXOW8er3V1WSmPs2c3/2fWbz8MH3rKzVP6FAerM=;
  b=h1IBUhKP+OFXYdF/y8ulhQjattVujVacXulu2Q3XivasvdGCJkAxXD/k
   /94KP9cDiKmT9LSQz/ynmZqRLwgPCNdD0Q1usjWyDEBUNBGsLjza+Wzie
   gCT73EZiSgMOn+sSNVEBH9UYMF9wbwiCZ5aN4DLtAjNTRQ/DPMo9n3gOx
   s=;
X-CSE-ConnectionGUID: 1Y8mB1o/ROig2dYq6FSdeQ==
X-CSE-MsgGUID: SrFolN8TT8iToE7yltCyUA==
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
   d="scan'208";a="305341352"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Nov 2026 19:05:53 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 07F4680EE4; Fri, 13 Nov 2026 19:05:53 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 1F660805EE
	for <cocci@sympa.inria.fr>; Fri, 13 Nov 2026 17:08:40 +0100 (CET)
X-CSE-ConnectionGUID: WGh618ZwTNqf+OhzaGhMsQ==
X-CSE-MsgGUID: HSh/kVc1TAOLkymy3KQd/w==
IronPort-SDR: 6af73607_qh7r7UdLgiVva0fPqYwEND5SxRTppkhmMfEF0I+qXV09KyP
 pZj8NEVdL87QlaiazkD2/2bHY7xaL1gaAOkLmwA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ECAwAVNfdqgy+fayhaHgEBCxIMggULgW5TFiwBgSwwB?=
 =?us-ascii?q?1GEWINNAQGFK4h6g3WYWyqBK4E/Pw8BAwELAQFRBAEBAQIEhH4CjiEgBgEEM?=
 =?us-ascii?q?AkOAQIEAwIDAQEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBAQE5B?=
 =?us-ascii?q?w47hk8NjBoBgSReSAEBAQEBAQEBAQEBAQEBAQEBAQEBARQCCGMBHwIBAxIRH?=
 =?us-ascii?q?QEBNwEPJQImAgIxFRAGARIigmCCJQRMBAKvSHMCAosVgTKBAYIMAQEGgmrZS?=
 =?us-ascii?q?4FoAQIJCQEKAYEKLoV0gm4BgXGECDsJhDk2gVVEgRWDaogfgmqCJnoSl3cJP?=
 =?us-ascii?q?4ECHANZLAFVEw0KCwcFY1IzAyAKCxISGBUCFB0SDwQWMh1wDCcSLBcvWBsGB?=
 =?us-ascii?q?YEccxQEE4ESgQUJVIErKF0BIYEITgEDAoEhAgaCS4IAAgFJQQ4HRVMJJUMSR?=
 =?us-ascii?q?yQiCBIJARMaLAqBGjU8CSY/FQxnCxoFYQgCDQx0ORAwHiQvBRomPhsKgQ4FG?=
 =?us-ascii?q?A1IESw3Bg8ZBD0BbgeSeIMDEoEOASOBDRuYOYwogTahSDQHhCOBYAgMoAUyq?=
 =?us-ascii?q?nIumFojo0IOhSYCBAIEBQIRAQEGgWg6gVwzGiODN1ADGQ+OIgkQCYNgjz0Bv?=
 =?us-ascii?q?nx4PQIHAgcOAwuSHIFMAQE?=
IronPort-PHdr: A9a23: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
 USqgIVwJ3Rn5wP9fPjp9QfldtCVH0tdebM=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:1pDuJaM67kR+N8BcTtKjsMiBIKoaSvp037BL7TESdfUxSKelfq
 +V7ZAmPHPP6Qr5O0tQ+uxoRpPwJE80nKQdieN9AV7FZmnbUQCTQ72Kg7GP/9SZIUPDytI=
X-Talos-CUID: 9a23:Ln/CU2FfbfKFp3QPqmJY205KQ5AXbUH71XmTBE+qAElpbaasHAo=
X-Talos-MUID: 9a23:6r5p2wao2r6jMOBTlwTswzJcP55UyoOKC1EIgM4lgsXDKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,211,1787004000"; 
   d="scan'208";a="305324893"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEQlDubAyHMwef7E0zRQe4JgOXx4t7iYb/qbe?=
 =?us-ascii?q?8hZMgj+uR4QXthMEkFJGqf7CHlH5Ygyh/3DzlDlpQzd3lwvNiZB3aMAz?=
 =?us-ascii?q?23aA9kULAtP5TLCkmsTddxa8DrZhDM23wns2gS3SVoFrbPiMYUF8pnvA?=
 =?us-ascii?q?LSVkU2Cp78MdlyWwE+Dch6XA=3D=3D?=
Received: from mail-norwayeastazon11013047.outbound.protection.outlook.com (HELO OSPPR02CU001.outbound.protection.outlook.com) ([40.107.159.47])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 17:08:39 +0100
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=jNr1j18ba3cOgFbAPIsH9aYLc7EZcfBSc2W7E/LDwmaOVWdiE7U80Bh2VpOI/6scHMQcrTPEITXqFj45qdpG+SHKIwYgksbtk+RIBoJtTiBK7RcZV7/YZFIpH8T8BtO5l77467pPcrcDQ+2mYrlY8LTnVumtNSV6Dhf7daXuerR4xmUgMmpRc2sIe2eokaI/81vjvuuuRkwpWGPJBu5QnN+5tDuPduv2HdYIzh4jMA8U3t7+hrQ75ivgbApOnFZLR9DD+TpR/zwdSc5VJvW+LmBUbY5OeaSEYMlIjOCsheL2hbDbbmBzer+b1CQxhhJMqcdy4qmedagoxF1v9uucVA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmIyWXOW8er3V1WSmPs2c3/2fWbz8MH3rKzVP6FAerM=;
 b=g/R4FNKmYHN+Y9wWEcy9GemMc3p7LMhf6YKI3Vd3qIWS7kgkYpNY+JRYwZ3K6l2yYrSNn/VrVc/BOeYO8ZhQ1CzioyNS3c0gwr+HoiKJeHz7Q7GifAQArmff6qPWVUQyE+ziYkHziQcvyirsZj2acJsWgQfdeUtgUM3aXPOvu+YSEpDfFfjd0V9ra3z9GHVqwnwSH5ceOIb5gpn9Rp+9ZQsFjOdog2ZRrK3LkICE4KDMXJOvixvKkQ4e2VPn+omX14zgd4ZL3D9ULBk3lxEPGP5sSjlxn8b/xGWC1PyR2vfeAQkVwoD+zUxY5x00uxNl7Dv2cCy2vd0JbKS3Iz80sA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
Received: from PAZP264CA0239.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:238::10)
 by DU0PR08MB8953.eurprd08.prod.outlook.com (2603:10a6:10:464::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 16:08:34 +0000
Received: from ZR1PEPF0000E6B3.eurprd05.prod.outlook.com
 (2603:10a6:102:238:cafe::6) by PAZP264CA0239.outlook.office365.com
 (2603:10a6:102:238::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Fri, 13
 Nov 2026 16:08:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E6B3.mail.protection.outlook.com (10.167.241.90) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 13 Nov 2026 16:08:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIevjqXP6rqYn6SPz/EzFNTbRKsy0SWeA89BnxWfAMIKKJ3FwLOqxZZ9Gnb1vvKb37qVxQzJa2beOCjMQIQDT8x1ZdNrQhnyGjpAR8zPIUXsSwFU7N5ToD313A+PVCATf9BceQTJWVExDu9VVMaTvNxVp9IutHJtBM+e7d3ZE24KjgObHWE6kR5KNY4g1j2K9onHYy42eScACE3avCqdfg1hTGibAf4d/q11jjwkh7/KKtouzJKPI6H73yxG6xfiFAO1oGNg6olgPHqaXyOODECq4wqZGSiRwUu5/uGhXm0Mi2yF5HWi34vF7lKz3CQPAOHfFkcN+SwRUrmS+RUEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmIyWXOW8er3V1WSmPs2c3/2fWbz8MH3rKzVP6FAerM=;
 b=rCg3K/UFSaOgX9MfvXQGt+lt0YOpiPVwf4tM2itV4wB6kwymPdBW8gs4Eygt/WB8pwnWym/8bGCgApEnlF2EnO1K59LHQ5II3af2p60Ji4Ur30/TFJ2pqGVBCZvxZjUl2SKpNmLKDJYNS2VzkgrFovCnURciDnTVgZ3bDIhB3HMYl3fxZUYFtSbtOZKndquiAU8zj1BzM7cQFLRNhjzERA62ZPUm3/ySrhtM8fyVEwZUoX31m+GTMnV9NxotomcqQbPBFEmAn+z+7E6d15ej2CpH7o/BX2b8l7KwNG9Mi4j7yw3CLCP00//SHeapJn9H4kvk5ir5f2LCXq4fmu4J1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 (2603:10a6:20b:629::15) by AMDPR08MB11367.eurprd08.prod.outlook.com
 (2603:10a6:20b:717::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 16:07:56 +0000
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c]) by AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c%6]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 16:07:56 +0000
From: Bence Csokas <bence.csokas@arm.com>
Date: Fri, 13 Nov 2026 17:07:31 +0100
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-offsetof-v3-1-714df7053893@arm.com>
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
	AS8PR08MB10291:EE_|AMDPR08MB11367:EE_|ZR1PEPF0000E6B3:EE_|DU0PR08MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: e7851625-21ca-4637-601e-08df41a05cd8
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|10067099003|11063799006|56012099006|261026140227099003|261022105027099003|261028144727099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 cgohRSNMpMKBbobTSm55F8mEQA0JGbcOuUJWYft1s5vIZRQYAyUnlssiqYW/Y/8/IP3EaqTkHT0u1ZY7MQ0Gpvp0hAM6uI8qulrClo/dWuKA9rYWaQoZUgHgRV3OqUZozidtIpexh0jfGn5e7P0ZRH6AzvyfYWgxcbOMuIgHHQoWv8qIHw7RbN7r21TI6TgBlRGp0622nz5d74Q2B07zuEXSd08DyY7wWph1PZuK89e6fhs6I4zPjS8j0HoOk1jj7vC0DpIM/xIjdoyLLjPTXZBpSqKNbRL0XibZg56oPfQgGnlD3H3BrTfssvZXt9Lt6LwFPQDtB5a6Jf3FtoUZ/gBw98e67PK2V83TvNOXFGKOQa+MkqZApBtKWudN37GcI9m9M6bVieuMlGvNvSwQyUJo4wnvayBn2yBiKl5qvzubksMP77hSJR2LchW3tFzRl4UYrF0QhHaQ0IAKjl/JvSdLtWwuu+PuMX2HOH0edazkVmY6Ll9nZXJ1ndR8WIhnhInRIumNNRaQwAHjv2te9ic6d1ajeosK7CGKlwdNdXhiqasNYXJDr4wXB9H2+05MC1C793P23RQZPL+HbeU3RkVCiOwO4xeCOpN6R1DlmWOf5p3vHDstMZCL+GUO3ycfk1tPFZVkueBjYw+U+BZeViIDXytKAL3ImaYcA7rX7ty6dpdXxoVWOQfKpgBkaXmty5UNM9psNvVrhzzCDxiKhw==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB10291.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(10067099003)(11063799006)(56012099006)(261026140227099003)(261022105027099003)(261028144727099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Aeso0tWjR1NsAQGcOTTwej4iNXR1YuqhFw3PAejSIEQw4yJJoNiRcwxWjpbMmJIFJSsUQvz6pGmFneue8MkPridAuIaHhdkRxwbajg5UQWcEeEiv2HPqqs/Hz1MNFQHcH9yq0qxbFoWMPECJNr5lThj/IqhXYdQS9VnevjLGvVtGDyh8gw0yLAPDbMiWVyBWoWlZy7HjX8Y54BhFRl8x9/+9Zt3pSFY0dMxwsWIbgflQVr64in3i+VWFiSGTr/DL+pB3IyzkAYei+90blv9pnTC9HRpGxmb/rYybsyjzpPyBb9xnad+nvHLo7Z/Zhs23ftQjsKZlOLGCGjTKOZ5JYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11367
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 ZR1PEPF0000E6B3.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	bca17853-6648-467b-4fd7-08df41a047f0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|23010399003|36860700016|14060799003|35042699022|18002099003|22082099003|261009223027099003|921020|11063799006|56012099006|261102123227099003|261026140227099003|261022105027099003|261021121427099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	V8G06R5g7VcOBKdBTL7kJu9KxTnO3ar6K22gM9qG6mktnngjFyt6WyLjX+Tl/VcjidS+XG1pk2C+0ZEM14SHWnJ50UtHZEDo0xUK+H4ebtnOTZPr5ShWBGV0gu5jdgG++oC6fxf9+WjVxZh1Bp5KHcevI3VbvQegxbbocOn6he01p9c0EQP0+1jWTo0T+0y5RSC29QrdoiRHpjx6npvh3vvN1+geOl2JsRmm/XFAVljtzwOQe/4xAlQPnbNhQNL4n6EJ3aJAlr0IGCyjjKXQjA4onFcGFOE6nXdAsyRjq69MC9JYPwhADG8UTHbqJ4BGmsLblvUfv2jtoXOWmaaRfziG0a9rcwP//7sAlQ7gcFHa3QLeEfDj0Vz/dcBclcechhGQ08ebC2zzdyjwq5fgLqmUjJqf0N9LBJ9KZ9tIyFNO3CadhqPolyQlkAGUfTakVhaGvgdfnmOrXyh7zQhfhsVdTVnMm1+kETTwWxfZjhYm2j5ldhAJzbIqbVAgqSx9nQeDG3jyraBNPeUNzLvLLbjlh4vciDQlIH1JbHq8BQdP6UoTgvZ16xU4qTMSdgfo3ZXMQ27DlfApFEL7llZCMcELsCZ91nCz94wD+YL3S2zjGwkjyzkzrkSx577TmUW+j/kdQtYoyT+ns1hHRTXtvCWmnw1k+UXb7SQuB3S/7Pf6TO/nyzH4gOG0s8LH1a0+G+5RuOkt5z5tAlkE9UqXvrHOXTovVheUOisLlpf9U/U=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(23010399003)(36860700016)(14060799003)(35042699022)(18002099003)(22082099003)(261009223027099003)(921020)(11063799006)(56012099006)(261102123227099003)(261026140227099003)(261022105027099003)(261021121427099003)(261028144727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fKFwNGQ2bhlX06xulrVnoYORD29BbO3GhAqD5xtPdosQEM/plOdJQd16ZvL6w9CriASQ2Bvi3/ncfywo5ZYH2Liaq2WSaq65eeNGYU58hkNFCbqDYkhXncFTviBaDiaJ14fgxjHp9BdwqhhW2WXAFw+/j8GkEzSzHztTCdY3VgGzsuU1UBfxurBzsfbGt0fcCFaXMCUKFsDdxbj79S0LS1dqrU3Sk7cPgKeF3Lbx9YPCCoCLX96VvaQcKPys1BWrpKn63+eco23QxU3MnQlZYXdirIPDJoB3ZyDTO81WMlKo7cz7dAXUic4Gv+Jr49vnTgrGFlaFVsiGD8WXrfYTHkyG/j5WyyOFoiBKfd6P9Xn16GCdrPlHpggcyZ9Mhc5/9j0jpvbAa9OttQHvXzwE1m7Cq8z5+aYKdBOVwdjbHVqWwlOZrt6CCsrfoICEieb/
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:08:31.0874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7851625-21ca-4637-601e-08df41a05cd8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E6B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8953
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v3 1/2] overflow: Add offsetofend() variant of
 struct_offset()
Reply-To: Bence Csokas <bence.csokas@arm.com>
X-Loop: cocci@inria.fr
X-Sequence: 3805
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/UvX_etfPzK7swbknUSe4BQ>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Many call sites of offsetofend() use it for the purpose of pointer
artihmetic. Thus, a common usage pattern is:

  offsetofend(typeof(*ptr), member)

Capturing this in one macro helps keep lines short and terse, while
still making the purpose clear. It also helps discourage spelling out
the type name on every callsite, leading to more maintainable code.

A similar struct_offset() macro already exists, so add an offsetofend()
variant in the same spirit.

Signed-off-by: Bence Csokas <bence.csokas@arm.com>
---
 include/linux/overflow.h                     | 12 ++++++++++++
 scripts/coccinelle/api/struct_offsetof.cocci | 14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index d0f04436343e..c029d68daeca 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -464,6 +464,18 @@ static __always_inline size_t __must_check size_sub(size_t minuend, size_t subtr
  */
 #define struct_offset(p, member) (offsetof(typeof(*(p)), member))
 
+/**
+ * struct_offsetofend() - Calculate the end of a member within a struct
+ * @p: Pointer to the struct
+ * @member: Name of the member to get the end offset of
+ *
+ * Calculates the offset of the end of a particular @member of the structure
+ * pointed to by @p.
+ *
+ * Return: number of bytes to the end of @member.
+ */
+#define struct_offsetofend(p, member) (offsetofend(typeof(*(p)), member))
+
 /**
  * __DEFINE_FLEX() - helper macro for DEFINE_FLEX() family.
  * Enables caller macro to pass arbitrary trailing expressions
diff --git a/scripts/coccinelle/api/struct_offsetof.cocci b/scripts/coccinelle/api/struct_offsetof.cocci
new file mode 100644
index 000000000000..6cbc5596d673
--- /dev/null
+++ b/scripts/coccinelle/api/struct_offsetof.cocci
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use struct_offsetof() family of macros
+///
+// Confidence: High
+@@
+expression ptr, member;
+@@
+- offsetof(typeof(*ptr), member)
++ struct_offset(ptr, member)
+@@
+expression ptr, member;
+@@
+- offsetofend(typeof(*ptr), member)
++ struct_offsetofend(ptr, member)

-- 
2.56.1

