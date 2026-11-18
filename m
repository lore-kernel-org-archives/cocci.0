Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39191606A33D
	for <cocci@archiver.kernel.org>; Wed, 18 Nov 2026 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=DlVO8ggY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:content-transfer-encoding:message-id:
   references:in-reply-to:to:cc:mime-version:subject:
   reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=IqbuGqCWt2nz9c0tRPpSBgmY7a/a3DtoKICs8nKgOvw=;
  b=DlVO8ggYhUr/j52kVnj2L3VbZBwvP5sUfXu6V4N5zRkmGqVy5ZOETjRU
   b4d1Gce8IOmw8bztGGYSOhB6xhry9BcUOaMmxPIE1nDXKh8irv9qT5G2J
   Mw++3FP0wc7I9zN71qtrNaI0cWHBhFeKWQKSkG+PFJG13TqJGRfwJ/kWo
   E=;
X-CSE-ConnectionGUID: Nwe2kSXRRE25R7oLD+EhWA==
X-CSE-MsgGUID: o/VRdFZcTaCuL56h10KG2Q==
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
X-IronPort-AV: E=Sophos;i="6.27,219,1787004000"; 
   d="scan'208";a="306145513"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Nov 2026 16:31:02 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 3BF5282225; Wed, 18 Nov 2026 16:31:02 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 97FF68131A
	for <cocci@sympa.inria.fr>; Wed, 18 Nov 2026 12:51:31 +0100 (CET)
X-CSE-ConnectionGUID: a0KEgXiOQVeUP5i/ctw/PA==
X-CSE-MsgGUID: qiz5nguFQ+6lVvwUQF1otQ==
IronPort-SDR: 6afd9143_KC4n1k4a/BU0xb58KM+jL8J5AM3bk4h/uZg/FPdFuqidn8F
 76wM7kv7wJXAFdZIYShPFvs3p1y7YuxLRnkRLEg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GSBwDikP1qgTZIZTRahEdTFiwBgSwwB1GEWINNAQGFK?=
 =?us-ascii?q?4h6g3WYYSqCaj8PAQMBCwEBUQQBAQECBIR+Ao4iIAYBBDQTAQIEAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBOwcOO4ZPDYwaAYEkXkgBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEUAghjAR8CAQMSER0BATcBDyUCJgICMRUQB?=
 =?us-ascii?q?gESIoJggiUETAQCr3BzAgKLFYEygQGCDAEBBoJq2UuBaAECCQkBCgGBCi6Fd?=
 =?us-ascii?q?IJuAYFxhAg7CYQ5NoFVRIEVg2qIH4JqgiZ6EpgxCT+BAhwDWSwBVRMNCgsHB?=
 =?us-ascii?q?WNSMwMgCgsSEhgVAhQdEg8EFjIdcAwnEikXL1gbBgWBHHMUBBOBEoEDCVSBK?=
 =?us-ascii?q?yhdASGBCE4BAwKBIgIGgkuCAAIBSUEOB0VTCSVDEkckIggSCQETGiwKgRo1P?=
 =?us-ascii?q?AkmPxUMZwsaBWEIAg0MdDkQMB4kLwUaJj4bCoEMJx8eCBgNSBEsNwYPGQQ9A?=
 =?us-ascii?q?W4HkzODBhKBDgEjDIEBG5g5jCiBNqFINAeEJIFgCAygBTKqci6YWiOjQg6FJ?=
 =?us-ascii?q?gIEAgQFAhEBAQaBfyOBXDMaI4M3UAMZD44rGYNgjz0BvAl4PQIHAgcOAwuSH?=
 =?us-ascii?q?IFMAQE?=
IronPort-PHdr: A9a23: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
 rS9o249gzKelP55aPzNHmqUuKJuNEI=
IronPort-Data: A9a23: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
 tsNRB75nmB6fwcIadWzWjr3a7BH7Qws+aH4bx0V
IronPort-HdrOrdr: A9a23:4ZbfuanEY+LwN0ig4q3zvHL8TOHpDfNLiWdD5ihNYBxZY6Wkfp
 +V8YV+6fakslxhPU3Ix+rqScu9qLbnhPhICEcqTMWftW7dyRSVxeBZnPffKljbd1yYygcz79
 YbT0ETMqyKMbE+t7eL3ODaKadX/DD4ytHXuc74yVpsVwtuY6Fl4xwRMHfQLqQefmAvavRJd+
 vkl7J6SiKbGUj/LP7Ld0XtN9Kz0OEj/6iWHCLuaSRXmzVn2liTmcrH+iyjr1UjegIK7aYp8G
 DDnQC83aO+rvG9xCbb0m/Y/75WlNHixtYrPr3NtiFZEES1tu5mDL4RGoGqjXQQmqWC+VwqmN
 7Dr1MJONly0WrYeiWQrQH20wft/T4y4zu6oGXo20fLkIjcfnYXGsBBjYVWfl/w7Fchhsh11O
 Zu03iCv5RaIBvclGDW5sTOVTttik2oyEBSytI7vjh6a88zebVRpYsQ8Ad8F4oBJjvz7MQdHO
 xnHKjnlbprmQfxVRHkl1gq5ObpcmU4Hx+ATERHkNeSySJqkHdwyFZd7NADn18bnahNGKVs1q
 DhCOBFhbtORsgZYeZWH+EaW/a6DWTLXFblLH+SG1L6D6sKUki9+6If2I9Ftt1CRaZ4kqfa2a
 6xD2+wjFRCJ34G3Pf+jaGi8Xj2MSiAtHrWu4IusqSQfNXHNf/W2Ba4ORgTexHJmYRZPiTqYY
 f2BHtoOY6rEYKXI/c94+TfYegVFZBMarxNhj7MM2j+7P4i3eXRx6PmmbDoVefQOCdhUGLyCH
 kZUDLyPcVN6V2xXGPkjBW5YQKnRnDC
X-Talos-CUID: =?us-ascii?q?9a23=3AaDqxi2rt3XAq9LemYFOx9U/mUcl9UVDS/Hb3GnG?=
 =?us-ascii?q?1NF40SfqeVUDXwIoxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A9lsagg4on356zEfWCnnGJf0Vxoxx4rbzDk8Qv6x?=
 =?us-ascii?q?F5c26KzNNAhnEiyiOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,219,1787004000"; 
   d="scan'208";a="306086975"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHzCDPPf7iH7Mee1gCs3VrvNLkUgX09b9gjwF?=
 =?us-ascii?q?ylAifwaU9PouFt6EXkUSPDDvHKIi6qRqLyQG5AYfoZzi2I5oId4mThe3?=
 =?us-ascii?q?QWOsxdDVFrkROoSUw8Aqq7nWjOEvpGuyh4EurocW6Qi6tMZJshFGA4tl?=
 =?us-ascii?q?Jp826jSI9leVQsXDgHZ7YWPQ=3D=3D?=
Received: from mail-westeuropeazon11013054.outbound.protection.outlook.com (HELO AM0PR02CU008.outbound.protection.outlook.com) ([52.101.72.54])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 12:51:31 +0100
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qpdEQ9gwk7LAzFSstXxvUYlXKEupprZtThap7oh2WPYsTyzowws2hOcgZUBl98eH8DvKbwzm0CSE21Ou/4vqNBp+tIQau7B8E2cJTW6ynPsPQoYCqPR9V7+2WrInyooy8Uod3wJWkQ0ptBKMgoh4sp/uvlJzJbW2M76Z5piGkil9VfPbFa8oEzJuOfleFxR/WREsJittkbLOX2ZO+KmRpGoe6KHGT/vZf1gFV4+68euUYhJE2V3r3anM9sPU0vgm59Pqkv+RDKFKaC07ZZj4AF1KMYZzR7QUGS91pVpV6fkxsz/9YTaz93pbdklFIyBtK5903eWmVjke7YrW6QMKNA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqbuGqCWt2nz9c0tRPpSBgmY7a/a3DtoKICs8nKgOvw=;
 b=nOAFmSHHVN678ywskl+1GjJ8ncvkTqd2k4eC725Y9scFll7hqOzWexJk9NeVajpOsRKorbu8/LGu8X3ksLbgP+K/jI0DaDZAFnqOAos0AQTYFkdcp/jd5jzT4cytoiFaBONXzRRL7bPGV6ILa5xHp7UwjBHMEC1pYVsdNsAqaxQKtI9whmFP3o6/YkvUdo70kudJ0pSBVahwAW7ATBXx+lVe4ALu2vwWQ6uh65xH9CAO3hvGPdtOHHbzA3zJlJMSU11OsKw1CogJRTFWPuQnRHjh9sC4yQXFzxyNyLSblyqXVW8glWctoOH5YrLlWHlF6e43yM4DhyJ/UmPqS68ejA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
Received: from PA7P264CA0141.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:377::19)
 by PAVPR08MB9081.eurprd08.prod.outlook.com (2603:10a6:102:32a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 11:51:24 +0000
Received: from AM7PEPF00000051.EURPRD83.prod.outlook.com
 (2603:10a6:102:377:cafe::69) by PA7P264CA0141.outlook.office365.com
 (2603:10a6:102:377::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 11:51:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM7PEPF00000051.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.0
 via Frontend Transport; Wed, 18 Nov 2026 11:51:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUeXY69BTlAKGNDN8SunAYKeRtk6Ob+ZDp6FTLuO6f5KbEXMvyJ+t+pX1Qude78sPz0O6nDL203elGh0tiKHHyxQAZId+eyeeWPHssC1lgkDUNNzfC3/AJvyJG1HddRJwdJVCQWsFAr5J0KInpaN3Wso4eWnmbyZY91u5JURJFKUVJCX2C86rw71blsy6to0qVOySXhvA53qHvfPB7EH0WwPftMPvchgrEFLImsyG9p73Ne4ztF8r6Wnj+VZNFD8eqsvCIjQTxrfricNtzMYbE3w/mwDdU/9Qli8ycE3eqdQqd01lATNaqO1XSdtI9xz8U4GHj4XDrD8s5cOnhxYFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqbuGqCWt2nz9c0tRPpSBgmY7a/a3DtoKICs8nKgOvw=;
 b=TWipiO5xrOCjJLFn/bdok1SR/tDO0pR2n/rgPBiIRZhu6ZyA54uQpCzOLjEg+JgnkmBVhusqEtDGg72Vbpf18q+VvwLhtwv6lKFYoowa3NUp1EwKRH/pPzs4k99kLtPsDqJhtzCiD+TM4N9j7mEPFR5Cm0Bzfh+yBeYd5S8Dve/kHR/a76I25+uFrjxTpbCWQeo82Q2H0IkQSJla0HsHC0I5d/cSYNoG/GT4inDXwF4a5lrIeq35DX/qh4v8RoMC8ra13lzdxx2GJ51R+yLS3Li1v1kyTsWdqgjCECcnEgdsc31OqK1lXg8pqVFlyFuQi7NPYdO6RcRLhgjEBShlaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 (2603:10a6:20b:629::15) by PAXPR08MB6352.eurprd08.prod.outlook.com
 (2603:10a6:102:150::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 11:50:37 +0000
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c]) by AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 11:50:36 +0000
From: Bence Csokas <bence.csokas@arm.com>
Date: Wed, 18 Nov 2026 12:50:08 +0100
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-offsetof-v4-1-95b385c10b22@arm.com>
References: <20261118-offsetof-v4-0-95b385c10b22@arm.com>
In-Reply-To: <20261118-offsetof-v4-0-95b385c10b22@arm.com>
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
 Nicolas Palix <nicolas.palix@imag.fr>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Paulo Alcantara <pc@manguebit.org>, Namjae Jeon <linkinjeon@kernel.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, Carlos Maiolino <cem@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, "Geoffrey D. Bennett" <g@b4.vu>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Bence Csokas <bence.csokas@arm.com>, linux-hardening@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, intel-gfx@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
 linux-wireless@vger.kernel.org, chrome-platform@lists.linux.dev, 
 linux-scsi@vger.kernel.org, cocci@inria.fr, linux-fsdevel@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-xfs@vger.kernel.org, bpf@vger.kernel.org, ipsec@lists.linux.dev, 
 linux-security-module@vger.kernel.org, linux-sound@vger.kernel.org
X-Mailer: b4 0.15.2
X-ClientProxiedBy: LO4P265CA0199.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::16) To AS8PR08MB10291.eurprd08.prod.outlook.com
 (2603:10a6:20b:629::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB10291:EE_|PAXPR08MB6352:EE_|AM7PEPF00000051:EE_|PAVPR08MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: a992ce5b-13d6-4fbd-ccff-08df456a44e5
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|261009223027099003|6133799003|22082099003|18002099003|921020|56012099006|11063799006|261026140227099003|261102123227099003|261028144727099003|261021121427099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original:
 6BhwyEBN0Lg9aktbvS5iHc8lYAT0fHx1DruG9WciosaXCcX6u0/b/Fvvoh3EOAp2s+2O33DkPk1vRKLMSZ7PtwTHI51X5Xl6nUYhRy1m2MC+kgHfFcEt02IxkaPmYult17H667VR/I/YbisYvRagZi9LOPU2IF7FBJlX0dF6ssgU4q4iMWlnZncAqfKeFTc9wzc1RRudGy0sW+2B2ue4sqx1uMXf7ird8HTLTmVLH8gm5m29xLpfygyuaN+TYMuI+HTGIxSu2Equ43u9pIBcg1KwDaAnhcYp5kNNzSxMnok/IqMoUEyNPqRKKYeaaHFtQ9T4O5OAjGxpdX2MLe96DSb2Gss1M0r8PdEvptOwvnue+FVWAXPRBlbxEokckKjY3PL7+jxwXomnBWe9bshE9YUCjZdaRINE3O48LXiJ5uzy0LFOKI8vfSJniVeGFiWj+c55dx1w5vVKOjd6s3bF63C5/hf2sZjx6AC51nhsatis80csg6YTK0rdpfNIPyiFDSTv5ebkXnY8MEhA6JKhvAQadFV9ZTgBjizhtavV5Kcy5HLAKqXGWskaicIXdaXOVZMqcI9H3428JoCm4jrNNQmiCo5+QKvZSMdLcSRFIeJd+T8Mi8oGglsBROwRRQjoK8BvJSSQTUlbGuiO6R2kblLYsGcYh3WI9RNs9CoOBIvj3abP6R2mX+m921Olg3QH9JbmuiWZaNZgQnqSoF3u8A==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB10291.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261009223027099003)(6133799003)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(261026140227099003)(261102123227099003)(261028144727099003)(261021121427099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 LiHjjEBvkRpqSleHw0HDwBZeTMAAEaZ68vEYTdxxqqviCKhO9oq+jC7oj38cwnbvwu0qHyUPMdb08V9FgqgrvY7vfUzCFxh6VcrbqGTgdMSWR1eW/Mb0JaFj2uEvsIXKad804Ok68QdB52H9u0aQwnp2C5THiK1hyhJT/UDrg+wE6abZYpucFxm4lUj/BkblMkOZVGjQd9gTLx4ZGPY5//vqz5O5Zn9zXqWqSSs9OUGjen05dbWDLF3dP2iWHE34kLvIfOhvBwAdlljdlW2r3iRftzp+PT36h7ZZt6sUrlDf8S+xtUV5JHTb6pMBVb1TkDRl/YTX3pAgFqxuVWczfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6352
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM7PEPF00000051.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4bf08f80-e327-49df-d188-08df456a28d7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|7416014|376014|14060799003|35042699022|18002099003|6133799003|22082099003|261009223027099003|921020|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	SX+CIW8Xj9fgLGL1XGEJcSMtDGCehjuJx9HfaHr8WiGsfH7XteL/dLIF47r//T1qVe8hMJDItUZR9lBw+NFykGMWTOgtVUHcWoi8CNFqLLvj6ohwAJbg0MsiwXT9ivyT8AJ5RvXD2qNsUaVzjGpE2rqs2cQUcMCfZARtYAbJy2v19QWCh3Ig7aPnKxM+7zeP0OTrOx9CN9Mv4gdvMdv0y9S99NsIE0m4oQ/Nckh5Zl4moc5Xb/TLyIUBhfdMtfsjiZIkebydeno8y2dFjGIRvLPJT49/8Ni93uilqmwoUOLTMGdKJPpcFs3FONjY7mrH736Pis3tzddmEf4e8E6qkDIuPZHEVA+DuCuuaeKGSw/f2LxHh97Hgb3k4UpJL3g0su+xMnegXg99sg3PZujBDraMl59MWfYoIOPwcC2R/9zWlDN4bwNwm+znxhXnyZFc8owvPXHbok33GY/r9x+8QuNFghj+Y0HdgoO+WkmN+RMBtpPKH3KRkBriQQjomz8CVGQlQQ/oro+pNfmbTeO9etuQJgXfR9KHR6vxVBhR1EWeik8hveX9nE7tZ/9uXMDf5ivLOn9jvSxgobNhIZ7noB6vMRDyO/8jvt796wBrRVVfzIVsMaCl63nfbMnla8hCTYnQ4BtDGWI+Appzviy5EB9kiutbychdSBCPqUuKZFQgnEiscgaxGZGhff4qD+xg3L1VtWp5A2oeI1Pg3iaX8frna7wbDqXV9fS1DGwMma0=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(7416014)(376014)(14060799003)(35042699022)(18002099003)(6133799003)(22082099003)(261009223027099003)(921020)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2fNdGa9MwJ76qPRJje8oBm6VNjItqJqyndtx0UP3gAIjzHzRW/EsiThRnUK7UGDDeN7GJcexpDMrlrxa7UKfmLW/rVfCkjYu2SqJiTpE16TW/U5O2uV8+2guq+pDKXDWmqQ31IoRZw77ORdpQW2DqCa5fXteEpkeV6OYnlillX1uel+vly8WT9wAPNY5/4oAKY3/cKGtBT4/67jbsGIk8ahxLxDs+LKiupI/Aw9yt3fPlx2ZCZNEF7sK6MVdz/ploiuC6ZQr/ZYddzCIFcIGoxIQigsxerxlygKzeHTSCLXXMtCml/Ccv5Jw2NvVPZC1LTKQEQ7M4xAiFwwBPONArgzR4YG05aeaGKXJyLRtSP8dtvZV8Ze9mxp4cD/4esYxy/huZ0EQJEn2pNrZ2wRYtPfVLDR5paS3WHrvdsYt9GJqKvVrym/5Q04CKo0+s5FX
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 11:51:23.3230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a992ce5b-13d6-4fbd-ccff-08df456a44e5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM7PEPF00000051.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9081
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v4 1/2] overflow: Add offsetofend() variant of
 struct_offset()
Reply-To: Bence Csokas <bence.csokas@arm.com>
X-Loop: cocci@inria.fr
X-Sequence: 3811
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/dKztZ5wPlV7uxKkzaImBVg>
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
 scripts/coccinelle/api/struct_offsetof.cocci | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+)

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
index 000000000000..5a30647d3787
--- /dev/null
+++ b/scripts/coccinelle/api/struct_offsetof.cocci
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use struct_offset() family of macros
+///
+// Confidence: High
+// Options: --no-includes --ignore ./tools/
+
+virtual patch
+
+@offsetof depends on patch@
+expression ptr, member;
+@@
+- offsetof(typeof(*(ptr)), member)
++ struct_offset(ptr, member)
+@offsetofend depends on patch@
+expression ptr, member;
+@@
+- offsetofend(typeof(*(ptr)), member)
++ struct_offsetofend(ptr, member)

-- 
2.56.1

