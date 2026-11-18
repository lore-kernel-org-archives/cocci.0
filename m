Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758660A260B
	for <cocci@archiver.kernel.org>; Wed, 18 Nov 2026 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=B6h23tK7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:content-transfer-encoding:message-id:
   references:in-reply-to:to:cc:mime-version:subject:
   reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=EMxCf5BueSrlO7Xzin/Rn/Cv72q8BN9/quFhEAe1q1M=;
  b=B6h23tK7Blt1c2omdP08UHeZ+rZhHOuXfDE9RDKVXXzupjYo5idJrDpx
   jNpHMdMbcbL+/x+XlKqC7QGGYy92xtTvueZJgoT7sAD6gWHKiV1RHAUyR
   /rQE50EbPG8pkfcH8fk9Gu54v4FuPpCIjw5uBRpneM5+wV+HXoIgDyAUj
   w=;
X-CSE-ConnectionGUID: zaxmQvGyRd+n7qCQuXJcXw==
X-CSE-MsgGUID: GA9xWZqaR9SnsQNYI/qSYg==
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
   d="scan'208";a="306145597"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Nov 2026 16:31:05 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8237882239; Wed, 18 Nov 2026 16:31:04 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id E856381353
	for <cocci@sympa.inria.fr>; Wed, 18 Nov 2026 13:06:59 +0100 (CET)
X-CSE-ConnectionGUID: GmWAQpdARNW9Un8H76Lm/A==
X-CSE-MsgGUID: Lwg98a34RBWxa1Vz0zx3sA==
IronPort-SDR: 6afd94e0_9f61M86lE8tqIXJuR2kVV520axmCU/CWBx0OemvyP7B5gJK
 CA9I7MWFn/KojjNp1Vtb+SkZQ+CVwr0p0hnGCPQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HZBABKlP1qgRNUZTRaHgEBCxIMggULgW4qKRYsAYEsM?=
 =?us-ascii?q?AdRhFiDTQEBhSuIeoEWgl+ZC4ErgT8/DwEDAQwBUQQBAQECBIR+Ao4iIAYBB?=
 =?us-ascii?q?DAJDgECBAMCAwEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABATsHD?=
 =?us-ascii?q?juGFQEHMg2MGgGBJF5IAQEBAQEBAQEBAQEBAQEBAQEBAQEBFAIIYwEfAgEDE?=
 =?us-ascii?q?ggBCAQZAQE3AQ8lAiYCAjEVEAYBEiKCCFiCJQRMBAKvWXMCAosVfzOBAYIMA?=
 =?us-ascii?q?QEGgmrZS4FoAQIJCQEKAYEKLoV0gm4BgXGECDuEQjaBVUSBFYJ0dogfgmqCJ?=
 =?us-ascii?q?noSglYJhTGQIQk/gQIcA1ksAVUTDQoLBwVjUjMDIAoLEhIYFQIUHRIPBBYyH?=
 =?us-ascii?q?XAMJxIpFy9YGwYFgRxzFAQTgRKBAwlUgSsoXQEhgQhOAQMCgSICBoJLggACA?=
 =?us-ascii?q?UlBDgdFUwklQxJHJCIIEgkBExosCoEaNTwJJj8VDGcLGgVhCAINDHQ5EDAeJ?=
 =?us-ascii?q?C8FGiY+GwqBDCcfHggYDUgRLDcGDxkEPQFuB5MzghwKawcBFUQhFC9MBIE5H?=
 =?us-ascii?q?xE6kmwBB4NujCiBNqFINAeEJIFgCAygBTKEBJQaklQumFojo2iFDgIEAgQFA?=
 =?us-ascii?q?hEBAQaBaDqBXDMaI1CCZ1ADGQ+HK4Q9gjoJAgEWg2CPPQG8R3g9AQEHAgcOA?=
 =?us-ascii?q?wuBaJACLQWBTAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:kYCYnKPCYPk1KMBcT6b255DYdb4zR+YMi2TDiHodOHhom52j/b
 HKoB1E73SE6gr5nUtQ/+xo9pPwM080kqQFnrX5XI3SIDUO3VHFXeZfBOTZskfd8kHFh5VgPO
 JbAthD4b7LfC5HZLjBkXeFOvEn7dmc+qWhhePT1B5WPEtXgshbhm8XZHf5YzQGPDWqHaBYKH
 Pf3Ls3m9PJQwVhUi3RPAh5YwGsnay5qHqwCiR2cyLP3DP+zw+A2frXAhKY1hARX3d1x6s+8W
 /Kqgr95q+ymfC2wB3R2gbontRrcZbau4N+7APlsLlVFhzcziKTIKhxUbyLuz445Mmp9VYRid
 HJ5zMtJd565X/9dny85UKF4Xi77B8er1vZjXOIi3rqpsL0ABo8Fsp6nIpcNj/U8VApst1Q2L
 9Cm0iZq51UJxXdmzmV3amSazha0m6P5VYym+8aiHJSFaMYdb9qtIQauHhYFZ8RdRiKpLzORI
 NVbf301bJzSxe3fnrZtm5gzJiHRXIoBCqLRUAEp4i8zyVWtGoR9TpK+OUv2lM7sL4tQZhN4O
 rJdo5ykqtVc8MQZaVhQM8cXMqMDHDXSx6kChPDHb3eLtBUB5vxke+o3Fx13pD0RHUw9upvpH
 0VaiIIiYYwE3ieRPFmkqc7sWGZfI16NQ6dj/223KIJ8oEVntLQQGq+oWAV4o+dSsokc4Tmso
 6ISedr6t/YXC3T8NVyrlTDs287EwhRbCXj0uxLFG5m5Pi7d7HCp6jQcfrYJqHgGzY8Wm/5H2
 AEQCX+Kax7nwuWZkM=
X-Talos-CUID: 9a23:wsAAeWzxXwj07mmdvPiKBgU7H/8MS2XR5U32HB6FDzZJF+OxTBi5rfY=
X-Talos-MUID: 9a23:IBjzswauGxjZkuBTkyDj1WFrb5tSyZu+ARkzg80Uq5KfHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,219,1787004000"; 
   d="scan'208";a="163091885"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFli/GwhaESDAYo7w52p0L8dPWsNDBv6bO5YW?=
 =?us-ascii?q?m8SLoODz/zTs6Sv5nha2DMlFj4KPVuQcs6RCb5mz6EGYKMjR6KR47jVT?=
 =?us-ascii?q?FMkpfXu+JdkDaByFbCoDanQqHauT/CnzZTlGqakbFbRzMYhez6gBleK5?=
 =?us-ascii?q?tbiwmcgaIc/b2ruCLLFUY9GQ=3D=3D?=
Received: from mail-northeuropeazon11010019.outbound.protection.outlook.com (HELO DB3PR0202CU003.outbound.protection.outlook.com) ([52.101.84.19])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 13:06:56 +0100
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JodiwIbdbL1X33O/NdBYfM+Z/igPdOUFr6A47nxLEseVMg6RrvW13hlc754wy5MTIqxdoOjEgr0Fz5B9QHkXJfuwmDmqcMBsUdGHC5subTVool0S3Afa0DqSS1O8AAWHnnruoRokIlJI/2JR2RCh4Qzsf5p578nBvIPc3sUtrAITOAqkX+bfaS7gb+VIhn/brNwrWjclbuwYcJViIu8pReVlKaFg3wcpoYs2D2NSpj6Mfmq5vkwFYNUr/MU/OJQIRQzSJcK13mWI8/azCnDzLqLJ9tY2r5ShmKsoluttIedTOVWhyflaNoUedxw1JyKwuisefj7gXyv5ii+/rF6lbw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMxCf5BueSrlO7Xzin/Rn/Cv72q8BN9/quFhEAe1q1M=;
 b=CxQ76vO1qFIkM3aUV81bp8atNnbJ/JxwmXas4+9AyuRdrYHdP9TEHfrza42C4vhRSKJ/VCvIuyswCjcSr22hFvluArYKg7rmcU0Kv6DFF0/3BmnONX10y7FWG1p6XFkZ2kq7AWzPfcSXMVsfhOhHMZqtZHCueoSO9Wirtdng1OuF50hb21lcJK8d9nRGm40owp9oKVoAu+rZCdjfYGcT8R7G9F4dTbdxtZIB5lA1oJfUx2pGvauugemg9BPbUegRgiXpSkNjivB55Obwf+AcjlYd2hIBB+ZGbh6Eqsnyyvn7piU8rhKFLLqRYbM6FnXFAkRsFnPSMUNlnOk5Jc2vnQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
Received: from DUZP191CA0011.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::9) by
 GV2PR08MB7930.eurprd08.prod.outlook.com (2603:10a6:150:ab::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Wed, 18 Nov 2026 12:06:35 +0000
Received: from DU2PEPF00028D08.eurprd03.prod.outlook.com
 (2603:10a6:10:4f9:cafe::3c) by DUZP191CA0011.outlook.office365.com
 (2603:10a6:10:4f9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 12:06:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D08.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 18 Nov 2026 12:06:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sME3gWBqYU8O/YISeQ6aVfIHuRYNyqA+i8hQ+vx/+cpGXnFWFyts4oaSAVc1/ujY0huFZwY23wokaYHySMIn1l0lv950rGESeRoznvPUG/YSPYv/T6j8ZrXKg0bG3vXGoR3PRysgoAwxx5eJACBvBBAhKYVMw23r5IRXSMASeUzRLibEixxmF/zeEu94+2ICVhoOmyh6xOZPp4a70e4vGPmp0rSKQ6KiS/2dTlxY1kDEJjgmkq/Cd/NALpGRw+VPOI7t1GOgTCrrapyQt210E2wJ5wVl18nbFbdKM8W0m+FjJe3w5lQUOz+l3+DzrFo53TMEEQ5GwtpC/08+L4+8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMxCf5BueSrlO7Xzin/Rn/Cv72q8BN9/quFhEAe1q1M=;
 b=Qvwg4wzXxR1w0vxGtAcWr1fMwxZdPMZO2J1i5k3PG14/9kzfSoUFpyFzIuPd0EMoXebZ08Du4dRGDxC2QpEKUnOzOmuxnIQ8gEjXQTM7nErKB2x24CatcaXZvdrs4iT/JzwTiPn00FWLOl7wt0lJzA62HXCaUpIP2QU7jrp5w3IaLzCx3PAG29U705PwWaDkNgDr3yp9BVxUS2KgiHPGtQCfTOwHOmdPi4eW2LtwFsJWsbgDEyBHKwKRq1O0R6u3BjQimkKRhsoeo1jiCKuwUnq7ewfz9H35VNJpLSl+RyCDTPN2LFf8IY00TaktpUAH40UCtWfLnw5XoayZpzp0TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 (2603:10a6:20b:629::15) by PAXPR08MB6352.eurprd08.prod.outlook.com
 (2603:10a6:102:150::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 11:50:43 +0000
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c]) by AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 11:50:43 +0000
From: Bence Csokas <bence.csokas@arm.com>
Date: Wed, 18 Nov 2026 12:50:09 +0100
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-offsetof-v4-2-95b385c10b22@arm.com>
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
	AS8PR08MB10291:EE_|PAXPR08MB6352:EE_|DU2PEPF00028D08:EE_|GV2PR08MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: b207b19a-7186-42cf-0b90-08df456c63fb
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|261009223027099003|6133799003|22082099003|18002099003|261009220027099003|261009221227099003|261009221727099003|261009223327099003|3023799007|921020|56012099006|260925021911599003|260925021311599003|11063799006|261102130727099003|261026140227099003|261026130827099003|260925022911599003|261102123227099003|261028144727099003|261021133027099003|261026135527099003|261022075727099003|261022115727099003|261021130227099003|261021123027099003|261026121527099003|261021135927099003|261021121427099003|261022113327099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original:
 +6kk4bo2/u5ZPiMOHHEn1/r6y2ZuscVxBTLVqKvX9bgLCBqzgW0jhnczworDW8/FSFAUyvcj0GwnZBhjr/xLEaYmK6drLPThIv3WhkA7kRNmizMvxhvfvYFl/jWYFz3siWkNj+2lhdX3z9yC1XgEBj8vXoKv5fewaGZmDWNdhqBzkRpdaxAMGS8uKz/MPyfSCwI1bflS4f8mHcVsjEaHZIT8dqxq94cCmK7vIWTy1AUmgWhLveZ9gW4aGtyVw7gC909vEdQGAXE2pol2XhqnijUORtNQwVTCgsgpFmhSbC1jSIRcCKwckp6t1VMVxltupsrVkYq6bapwpjUGpljlHLf44SYSHs9Z/CuXwArphGx6fZseafV9iXzUHehq3bDUV2J5aKMz7r1+b4e+Rr/35Fe+EKbdt95S3LRug5hunWHXLaNx+NiNDTGG8iCSSc7jfWwUeYTBFIOJ9SpRYMYZStW4Kn2A5VjaguEU7RzxZhPkpKVqaKxzc2Ix1TOFtOsqQAOTiDFuvCFHsIkqsUlX7Rh6GtxMzI0EUJn11S8NaByLFUomo1U4yHoxiINaWyfNtsdZYgHOeSjNCtn3K3PEuuPwN5i8ZaPAzt9WVgJAzXNMFFJM5GwckqxTLFWket+btKLd11zAf0T+iYKOp93YICtOo+JCU0VkoavQW7TZy1hhwxhgf6vWn4yuyhr+nd5IKESh1MN2yoW23DI9flYeBQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB10291.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261009223027099003)(6133799003)(22082099003)(18002099003)(261009220027099003)(261009221227099003)(261009221727099003)(261009223327099003)(3023799007)(921020)(56012099006)(260925021911599003)(260925021311599003)(11063799006)(261102130727099003)(261026140227099003)(261026130827099003)(260925022911599003)(261102123227099003)(261028144727099003)(261021133027099003)(261026135527099003)(261022075727099003)(261022115727099003)(261021130227099003)(261021123027099003)(261026121527099003)(261021135927099003)(261021121427099003)(261022113327099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 jY+ETkstkVcIxb+BpHawTYvIByFrx9d63WiolDHTDZ0dDly1CXEWgFkoRu9BnjQd1Bs7lVBXeiTb6MY64PjW0xjC55ZMJqizrW3y2hGaLUwnOLsPPbdytR8fgZCHnfUVnbVJwTgq9u/kYhEMVCJs7KL9LKPMdATazhP/xgRvDm8UVrrCx79f7QL5/ogK7hZF24y9ZaDVll6svaZGK+s41sQxNgavEhig496mwPwK3Eo9HOtC1etxv8BPNYR5wNaQnDFx2uK0ebsLMNxgulkCrvsgdq96tuuXECvw9InVp5LC0KmwEt7EheHODnKT44OxjUg2+hxa+sR/vW65hYewSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6352
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e2a93ea1-a2c7-42f5-0362-08df456a2cb4
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|376014|7416014|35042699022|1800799024|23010399003|82310400026|36860700016|921020|10067099003|260925021311599003|261026121527099003|260925022911599003|260925021911599003|11063799006|56012099006|261026135527099003|261026130827099003|261028144727099003|261026140227099003|261022113327099003|261022115727099003|261021130227099003|261021133027099003|261021135927099003|261021123027099003|261022075727099003|261022105027099003|261021121427099003|261102130727099003|261102123227099003|261009220027099003|261009223327099003|261009221727099003|261009223027099003|261009221227099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	gGVAlM/dFf+2DJT8grXbJZpy5Gwdshno/tSrffcQsHg1OnYpUAJ6Ts1cUabAu5ced1Ym8z0wkHk9PonEQZfRBG93GFp6aEzfticjJMEwrDl2Pd3KQ4UgZG1zfU9qes2N9PSlX3WeqbBueOgwdcCfN1wV9WAWq/PqdFZXM7yz8Orohwx3ZHE6woTpvXzKUoJEntsWSpguzngpZWg0W31N4oPnxDmvps54pn350VCg7nfwgleVKgqUNiDOMK/jzduBqxoAW37YvwTCL8IDVEkho6+4IEaJpgXaPr+2M4OJUUP8FbtnRL/VDofQkbJs6dt1neVoyW/rzs/ZAOZlsR1oHdLJFtMof3frm8zh0daej9u9h9chORxatHUbR9Vt3pqVjXpvDGRACI4MkoBMEZokwt0fXnlW00Pe1yHjAboJdl1Fc6T7a2xQhDGduqf4nVhy8EnHcs+9ufC/yvQDxrlNftsqW2eXOIGo3Nj6fQXhqGWAMRyw5OMca88jmGn+JhF5x7vxoN0Ia4zG+jP7NdhZGj8nfDo3rCrH/igw+oUy5M3n/HUSd/LKm3/EwlZPyecqZCgz5gCvybVJNwZ01Ui4/6toKj9bzUx7Me0ROgbcqNCJ2czMOGjLGCK1OqWEiAoETmE43+yFCFOXkQuU2eXYUDJxWbJU9RRGOKu9OkOQN0dHilpH7NZ9/SjcblBUpFTev+Ek/Caz/w/vg/ZdbCw7uQbD4rU/WcLx+zBdqCEBqUrHRFEFp+ih8vjENS9BLWHH
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(14060799003)(376014)(7416014)(35042699022)(1800799024)(23010399003)(82310400026)(36860700016)(921020)(10067099003)(260925021311599003)(261026121527099003)(260925022911599003)(260925021911599003)(11063799006)(56012099006)(261026135527099003)(261026130827099003)(261028144727099003)(261026140227099003)(261022113327099003)(261022115727099003)(261021130227099003)(261021133027099003)(261021135927099003)(261021123027099003)(261022075727099003)(261022105027099003)(261021121427099003)(261102130727099003)(261102123227099003)(261009220027099003)(261009223327099003)(261009221727099003)(261009223027099003)(261009221227099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KXzEjHQvLQQwZERxkgxIGD/ooXvXavKRcQhrEFFBx9mh8pd60GDOIGP7BM6nD6q88yDxJS1PZpXlk7f2Z7CrNH9FEVgOS7T+axCkcFcmVJOjTStTmWWx25QOwmYTtrhoLav40iHxKNE1SEDnp0d4zywCYJfT1LqQRBArow1D8+OQv8z/blK6QtLvUNOP8mPKOxXU/TBPwf8u3rO4d6Hd0k8jKnN8Igyv9bGSFHTcjDNRLY1B/3oISnYcXCBAKuCihukPJj41R1EqqiuQ+7nJC8sXIgl6uf+UnZwySgm8JDf7tmG/BOfpNFdkiXs3wnSei4v0mb/ZSySImd59AplcOhkBHtzug/LbTlXiFYF+BDgQxmipK2mPO6fmDP5WqkNothykdE/VUrf0BJVqJ801/41BCAO1fOrHi63UrQ7LUGl85XqTSi5rb7bCVX3PdttG
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 12:06:34.5282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b207b19a-7186-42cf-0b90-08df456c63fb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7930
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v4 2/2] treewide: Use struct_offset()
Reply-To: Bence Csokas <bence.csokas@arm.com>
X-Loop: cocci@inria.fr
X-Sequence: 3813
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/KpAdmBjDzNW3o7nwcZ-ydw>
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
 drivers/gpu/drm/drm_edid.c                         | 28 ++++++++++++----------
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
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c |  5 ++--
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
 fs/readdir.c                                       |  2 +-
 fs/smb/client/cifssmb.c                            |  4 ++--
 fs/smb/client/reparse.c                            |  3 ++-
 fs/xfs/scrub/attr.c                                |  4 ++--
 fs/xfs/scrub/attr_repair.c                         |  4 ++--
 fs/xfs/scrub/dir.c                                 |  4 ++--
 fs/xfs/scrub/dir_repair.c                          |  4 ++--
 kernel/futex/core.c                                |  3 ++-
 net/bpf/test_run.c                                 |  2 +-
 net/ipv4/ip_output.c                               |  4 ++--
 net/ipv4/udp.c                                     |  4 ++--
 net/ipv6/udp.c                                     |  4 ++--
 net/key/af_key.c                                   |  2 +-
 net/mac80211/agg-rx.c                              |  3 +--
 net/mac80211/agg-tx.c                              |  3 +--
 net/mac80211/parse.c                               |  2 +-
 net/mac80211/tdls.c                                |  4 ++--
 net/wireless/nl80211.c                             |  2 +-
 net/wireless/reg.c                                 |  2 +-
 net/wireless/scan.c                                |  2 +-
 security/landlock/net.c                            |  4 ++--
 sound/usb/mixer_scarlett2.c                        |  2 +-
 51 files changed, 99 insertions(+), 98 deletions(-)

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
index b8f882a17c8f..e7dcaa1f2f58 100644
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
@@ -3251,7 +3251,9 @@ drm_gtf2_hbreak(const struct drm_edid *drm_edid)
 
 	drm_for_each_detailed_block(drm_edid, find_gtf2, &descriptor);
 
-	BUILD_BUG_ON(offsetof(typeof(*descriptor), data.other_data.data.range.formula.gtf2.hfreq_start_khz) != 12);
+	BUILD_BUG_ON(struct_offset(descriptor,
+				   data.other_data.data.range.formula.gtf2.hfreq_start_khz
+		    ) != 12);
 
 	return descriptor ? descriptor->data.other_data.data.range.formula.gtf2.hfreq_start_khz * 2 : 0;
 }
@@ -3263,7 +3265,7 @@ drm_gtf2_2c(const struct drm_edid *drm_edid)
 
 	drm_for_each_detailed_block(drm_edid, find_gtf2, &descriptor);
 
-	BUILD_BUG_ON(offsetof(typeof(*descriptor), data.other_data.data.range.formula.gtf2.c) != 13);
+	BUILD_BUG_ON(struct_offset(descriptor, data.other_data.data.range.formula.gtf2.c) != 13);
 
 	return descriptor ? descriptor->data.other_data.data.range.formula.gtf2.c : 0;
 }
@@ -3275,7 +3277,7 @@ drm_gtf2_m(const struct drm_edid *drm_edid)
 
 	drm_for_each_detailed_block(drm_edid, find_gtf2, &descriptor);
 
-	BUILD_BUG_ON(offsetof(typeof(*descriptor), data.other_data.data.range.formula.gtf2.m) != 14);
+	BUILD_BUG_ON(struct_offset(descriptor, data.other_data.data.range.formula.gtf2.m) != 14);
 
 	return descriptor ? le16_to_cpu(descriptor->data.other_data.data.range.formula.gtf2.m) : 0;
 }
@@ -3287,7 +3289,7 @@ drm_gtf2_k(const struct drm_edid *drm_edid)
 
 	drm_for_each_detailed_block(drm_edid, find_gtf2, &descriptor);
 
-	BUILD_BUG_ON(offsetof(typeof(*descriptor), data.other_data.data.range.formula.gtf2.k) != 16);
+	BUILD_BUG_ON(struct_offset(descriptor, data.other_data.data.range.formula.gtf2.k) != 16);
 
 	return descriptor ? descriptor->data.other_data.data.range.formula.gtf2.k : 0;
 }
@@ -3299,7 +3301,7 @@ drm_gtf2_2j(const struct drm_edid *drm_edid)
 
 	drm_for_each_detailed_block(drm_edid, find_gtf2, &descriptor);
 
-	BUILD_BUG_ON(offsetof(typeof(*descriptor), data.other_data.data.range.formula.gtf2.j) != 17);
+	BUILD_BUG_ON(struct_offset(descriptor, data.other_data.data.range.formula.gtf2.j) != 17);
 
 	return descriptor ? descriptor->data.other_data.data.range.formula.gtf2.j : 0;
 }
@@ -3312,7 +3314,7 @@ get_timing_level(const struct detailed_timing *descriptor, void *data)
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
index fe590a045d70..279309d008f0 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
@@ -1171,7 +1171,7 @@ r535_gsp_shared_init(struct nvkm_gsp *gsp)
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
index 59ec5605930b..251c95d62fd0 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -3225,7 +3225,7 @@ qla2x00_get_link_status(scsi_qla_host_t *vha, uint16_t loop_id,
 	mbx_cmd_t mc;
 	mbx_cmd_t *mcp = &mc;
 	uint32_t *iter = (uint32_t *)stats;
-	ushort dwords = offsetof(typeof(*stats), link_up_cnt)/sizeof(*iter);
+	ushort dwords = struct_offset(stats, link_up_cnt) / sizeof(*iter);
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
index f96b9eb15126..814988895620 100644
--- a/drivers/scsi/qla2xxx/qla_tmpl.c
+++ b/drivers/scsi/qla2xxx/qla_tmpl.c
@@ -7,7 +7,7 @@
 #include "qla_tmpl.h"
 
 #define ISPREG(vha)	(&(vha)->hw->iobase->isp24)
-#define IOBAR(reg)	offsetof(typeof(*(reg)), iobase_addr)
+#define IOBAR(reg)	struct_offset(reg, iobase_addr)
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
diff --git a/fs/readdir.c b/fs/readdir.c
index f2288841337a..858ee501d4f7 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -22,7 +22,7 @@
 #include <linux/compat.h>
 #include <linux/uaccess.h>
 
-#define dirent_size(dirent, len) offsetof(typeof(*(dirent)), d_name[len])
+#define dirent_size(dirent, len) struct_offset(dirent, d_name[len])
 
 /*
  * Some filesystems were never converted to '->iterate_shared()'
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 68f05a52605f..a777c5ee6dc9 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3200,7 +3200,7 @@ struct inode *cifs_create_reparse_inode(struct cifs_open_info_data *data,
 	io_req->ParameterCount = io_req->TotalParameterCount;
 	io_req->ParameterOffset = cpu_to_le32(0);
 	io_req->DataCount = io_req->TotalDataCount;
-	io_req->DataOffset = cpu_to_le32(offsetof(typeof(*io_req), Data));
+	io_req->DataOffset = cpu_to_le32(struct_offset(io_req, Data));
 	io_req->SetupCount = 4;
 	io_req->SubCommand = cpu_to_le16(NT_TRANSACT_IOCTL);
 	io_req->FunctionCode = cpu_to_le32(FSCTL_SET_REPARSE_POINT);
@@ -5973,7 +5973,7 @@ int CIFSSMBSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	param_offset = offsetof(struct smb_com_transaction2_spi_req,
 				InformationLevel);
 	offset = param_offset + params;
-	data_offset = (char *)pSMB + offsetof(typeof(*pSMB), hdr.Protocol) + offset;
+	data_offset = (char *)pSMB + struct_offset(pSMB, hdr.Protocol) + offset;
 	pSMB->ParameterOffset = cpu_to_le16(param_offset);
 	pSMB->DataOffset = cpu_to_le16(offset);
 	pSMB->SetupCount = 1;
diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index 3a27773186ae..ac6db460a942 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -1042,7 +1042,8 @@ static int parse_reparse_wsl_symlink(struct reparse_wsl_symlink_data_buffer *buf
 				     struct cifs_open_info_data *data)
 {
 	int len = le16_to_cpu(buf->ReparseDataLength);
-	int data_offset = offsetof(typeof(*buf), Target) - offsetof(typeof(*buf), Version);
+	int data_offset = struct_offset(buf, Target) - struct_offset(buf,
+								     Version);
 	int symname_utf8_len;
 	__le16 *symname_utf16;
 	int symname_utf16_len;
diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index f909e2b25158..78e836ef76ee 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -306,7 +306,7 @@ xchk_xattr_local_entry(
 	char				*name_end;
 	unsigned int			namesize;
 
-	name_end = (char *)lentry + offsetof(typeof(*lentry), nameval[0]);
+	name_end = (char *)lentry + struct_offset(lentry, nameval[0]);
 	if (name_end > buf_end) {
 		xchk_da_set_corrupt(ds, level);
 		return 0;
@@ -341,7 +341,7 @@ xchk_xattr_remote_entry(
 	char				*name_end;
 	unsigned int			namesize;
 
-	name_end = (char *)rentry + offsetof(typeof(*rentry), name[0]);
+	name_end = (char *)rentry + struct_offset(rentry, name[0]);
 	if (name_end > buf_end) {
 		xchk_da_set_corrupt(ds, level);
 		return 0;
diff --git a/fs/xfs/scrub/attr_repair.c b/fs/xfs/scrub/attr_repair.c
index 720090895c20..901f9a126e65 100644
--- a/fs/xfs/scrub/attr_repair.c
+++ b/fs/xfs/scrub/attr_repair.c
@@ -294,7 +294,7 @@ xrep_xattr_salvage_local_attr(
 	 * Decode the leaf local entry format.  If something seems wrong, we
 	 * junk the attribute.
 	 */
-	name_end = (char *)lentry + offsetof(typeof(*lentry), nameval[0]);
+	name_end = (char *)lentry + struct_offset(lentry, nameval[0]);
 	if (name_end > buf_end)
 		return 0;
 	value = &lentry->nameval[lentry->namelen];
@@ -348,7 +348,7 @@ xrep_xattr_salvage_remote_attr(
 	 * junk the attribute.  Note that we should never find a zero-length
 	 * remote attribute value.
 	 */
-	name_end = (char *)rentry + offsetof(typeof(*rentry), name[0]);
+	name_end = (char *)rentry + struct_offset(rentry, name[0]);
 	if (name_end > buf_end)
 		return 0;
 	namesize = xfs_attr_leaf_entsize_remote(rentry->namelen);
diff --git a/fs/xfs/scrub/dir.c b/fs/xfs/scrub/dir.c
index d99e2a732723..a90dcc92ca97 100644
--- a/fs/xfs/scrub/dir.c
+++ b/fs/xfs/scrub/dir.c
@@ -364,7 +364,7 @@ xchk_dir_check_entry(
 	unsigned int			advance;
 
 	/* must have namelen */
-	advance = offsetof(typeof(*dep), name);
+	advance = struct_offset(dep, name);
 	if (iter_off + advance >= end) {
 		xchk_fblock_set_corrupt(ds->sc, XFS_DATA_FORK, rec_bno);
 		return -1;
@@ -464,7 +464,7 @@ xchk_dir_rec(
 		int				advance;
 
 		/* must have freetag */
-		advance = offsetof(typeof(*dup), length);
+		advance = struct_offset(dup, length);
 		if (iter_off + advance >= end) {
 			xchk_fblock_set_corrupt(ds->sc, XFS_DATA_FORK, rec_bno);
 			goto out_relse;
diff --git a/fs/xfs/scrub/dir_repair.c b/fs/xfs/scrub/dir_repair.c
index 518e15d93d3b..c7d234b592c2 100644
--- a/fs/xfs/scrub/dir_repair.c
+++ b/fs/xfs/scrub/dir_repair.c
@@ -501,7 +501,7 @@ xrep_dir_recover_entry(
 	int				error;
 
 	/* must have namelen */
-	advance = offsetof(typeof(*dep), name);
+	advance = struct_offset(dep, name);
 	if (offset + advance >= end)
 		return 0;
 
@@ -546,7 +546,7 @@ xrep_dir_recover_data(
 			return error;
 
 		/* must have freetag */
-		advance = offsetof(typeof(*dup), length);
+		advance = struct_offset(dup, length);
 		if (offset + advance >= end)
 			break;
 
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index a240638f69e5..a7ef407e1e93 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -388,7 +388,8 @@ __futex_hash(union futex_key *key, struct futex_private_hash *fph, struct futex_
 	}
 #endif
 
-	hash = jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / sizeof(u32),
+	hash = jhash2((u32 *)key,
+		      struct_offset(key, both.offset) / sizeof(u32),
 		      key->both.offset);
 
 	if (node == FUTEX_NO_NODE) {
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index d6c9dc62182e..519c4de7cfe2 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1613,7 +1613,7 @@ int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kat
 	if (user_ctx->sk)
 		goto out;
 
-	if (!range_is_zero(user_ctx, offsetofend(typeof(*user_ctx), local_port), sizeof(*user_ctx)))
+	if (!range_is_zero(user_ctx, struct_offsetofend(user_ctx, local_port), sizeof(*user_ctx)))
 		goto out;
 
 	if (user_ctx->local_port > U16_MAX) {
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index d42d776af273..0db29c6fd3d3 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -451,8 +451,8 @@ EXPORT_SYMBOL(ip_output);
  */
 static void ip_copy_addrs(struct iphdr *iph, const struct flowi4 *fl4)
 {
-	BUILD_BUG_ON(offsetof(typeof(*fl4), daddr) !=
-		     offsetof(typeof(*fl4), saddr) + sizeof(fl4->saddr));
+	BUILD_BUG_ON(struct_offset(fl4, daddr) !=
+		     struct_offset(fl4, saddr) + sizeof(fl4->saddr));
 
 	iph->saddr = fl4->saddr;
 	iph->daddr = fl4->daddr;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 2e5562f353f8..3dfb60b67fe9 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2526,7 +2526,7 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	hash2 = 0;
 	hslot = udp_hashslot(udptable, net, hnum);
 	use_hash2 = hslot->count > 10;
-	offset = offsetof(typeof(*sk), sk_node);
+	offset = struct_offset(sk, sk_node);
 
 	if (use_hash2) {
 		hash2_any = ipv4_portaddr_hash(net, htonl(INADDR_ANY), hnum) &
@@ -2534,7 +2534,7 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 		hash2 = ipv4_portaddr_hash(net, daddr, hnum) & udptable->mask;
 start_lookup:
 		hslot = &udptable->hash2[hash2].hslot;
-		offset = offsetof(typeof(*sk), __sk_common.skc_portaddr_node);
+		offset = struct_offset(sk, __sk_common.skc_portaddr_node);
 	}
 
 	sk_for_each_entry_offset_rcu(sk, node, &hslot->head, offset) {
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 9dcefa162522..6b396a4eb2b9 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -962,7 +962,7 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	hash2 = 0;
 	hslot = udp_hashslot(udptable, net, hnum);
 	use_hash2 = hslot->count > 10;
-	offset = offsetof(typeof(*sk), sk_node);
+	offset = struct_offset(sk, sk_node);
 
 	if (use_hash2) {
 		hash2_any = ipv6_portaddr_hash(net, &in6addr_any, hnum) &
@@ -970,7 +970,7 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 		hash2 = ipv6_portaddr_hash(net, daddr, hnum) & udptable->mask;
 start_lookup:
 		hslot = &udptable->hash2[hash2].hslot;
-		offset = offsetof(typeof(*sk), __sk_common.skc_portaddr_node);
+		offset = struct_offset(sk, __sk_common.skc_portaddr_node);
 	}
 
 	sk_for_each_entry_offset_rcu(sk, node, &hslot->head, offset) {
diff --git a/net/key/af_key.c b/net/key/af_key.c
index d215b33b7492..20016a2770f7 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -384,7 +384,7 @@ static int verify_address_len(const void *p)
 	int len;
 
 	if (sp->sadb_address_len <
-	    DIV_ROUND_UP(sizeof(*sp) + offsetofend(typeof(*addr), sa_family),
+	    DIV_ROUND_UP(sizeof(*sp) + struct_offsetofend(addr, sa_family),
 			 sizeof(uint64_t)))
 		return -EINVAL;
 
diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 01d6703767c6..72f78c4a58d4 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -493,8 +493,7 @@ void ieee80211_process_addba_request(struct ieee80211_local *local,
 		ieee80211_retrieve_addba_ext_data(sta,
 						  mgmt->u.action.addba_req.variable,
 						  len -
-						  offsetof(typeof(*mgmt),
-							   u.action.addba_req.variable),
+						  struct_offset(mgmt, u.action.addba_req.variable),
 						  &buf_size);
 
 	__ieee80211_start_rx_ba_session(sta, dialog_token, timeout,
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index f3ecdd8601a0..58a13cddee2e 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -990,8 +990,7 @@ void ieee80211_process_addba_resp(struct ieee80211_local *local,
 
 	ieee80211_retrieve_addba_ext_data(sta,
 					  mgmt->u.action.addba_resp.variable,
-					  len - offsetof(typeof(*mgmt),
-							 u.action.addba_resp.variable),
+					  len - struct_offset(mgmt, u.action.addba_resp.variable),
 					  &buf_size);
 
 	buf_size = min(buf_size, local->hw.max_tx_aggregation_subframes);
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index f3c5a9f6ec7c..e5a752e674f7 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -1068,7 +1068,7 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 	bool inside_multilink = false;
 
 	BUILD_BUG_ON(sizeof(empty_non_inheritance) != empty_non_inheritance[1] + 2);
-	BUILD_BUG_ON(offsetof(typeof(*elems_parse), elems) != 0);
+	BUILD_BUG_ON(struct_offset(elems_parse, elems) != 0);
 
 	/* cannot parse for both a specific link and non-transmitted BSS */
 	if (WARN_ON(params->link_id >= 0 && params->bss))
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 8ae01c277fd2..eb2c034493c4 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1767,7 +1767,7 @@ ieee80211_process_tdls_channel_switch_resp(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_tdls_data *tf = (void *)skb->data;
 	bool local_initiator;
 	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
-	int baselen = offsetof(typeof(*tf), u.chan_switch_resp.variable);
+	int baselen = struct_offset(tf, u.chan_switch_resp.variable);
 	struct ieee80211_tdls_ch_sw_params params = {};
 	int ret;
 
@@ -1868,7 +1868,7 @@ ieee80211_process_tdls_channel_switch_req(struct ieee80211_sub_if_data *sdata,
 	enum nl80211_band band;
 	struct ieee80211_tdls_data *tf = (void *)skb->data;
 	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
-	int baselen = offsetof(typeof(*tf), u.chan_switch_req.variable);
+	int baselen = struct_offset(tf, u.chan_switch_req.variable);
 	struct ieee80211_tdls_ch_sw_params params = {};
 	int ret = 0;
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e7dd32880598..9b735caaf2b7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -333,7 +333,7 @@ static int validate_beacon_head(const struct nlattr *attr,
 	unsigned int fixedlen, hdrlen;
 	bool s1g_bcn;
 
-	if (len < offsetofend(typeof(*mgmt), frame_control))
+	if (len < struct_offsetofend(mgmt, frame_control))
 		goto err;
 
 	s1g_bcn = ieee80211_is_s1g_beacon(mgmt->frame_control);
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 5cd3880ee384..4fc1bf251c15 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -707,7 +707,7 @@ static bool valid_country(const u8 *data, unsigned int size,
 	unsigned int i;
 
 	/* make sure we can read len/n_rules */
-	if ((u8 *)coll + offsetofend(typeof(*coll), n_rules) > data + size)
+	if ((u8 *)coll + struct_offsetofend(coll, n_rules) > data + size)
 		return false;
 
 	/* make sure base struct and all rules fit */
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 1c50a16c0e9b..28a46d49de04 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -587,7 +587,7 @@ static int cfg80211_parse_ap_info(struct cfg80211_colocated_ap *entry,
 		bss_params = tbtt_info->bss_params;
 
 		/* Ignore disabled links */
-		if (length >= offsetofend(typeof(*tbtt_info), mld_params)) {
+		if (length >= struct_offsetofend(tbtt_info, mld_params)) {
 			if (le16_get_bits(tbtt_info->mld_params.params,
 					  IEEE80211_RNR_MLD_PARAMS_DISABLED_LINK))
 				return -EINVAL;
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 8fd73cf4bd15..2f4bbd3bfe27 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -93,7 +93,7 @@ static int current_check_access_socket(struct socket *const sock,
 		return 0;
 
 	/* Checks for minimal header length to safely read sa_family. */
-	if (addrlen < (int)offsetofend(typeof(*address), sa_family))
+	if (addrlen < (int)struct_offsetofend(address, sa_family))
 		return -EINVAL;
 
 	/*
@@ -382,7 +382,7 @@ static int hook_socket_connect(struct socket *const sock,
 	 * should never be restricted.
 	 */
 	if (ret == 0 && sk_is_udp(sock->sk) &&
-	    addrlen >= offsetofend(typeof(*address), sa_family) &&
+	    addrlen >= struct_offsetofend(address, sa_family) &&
 	    address->sa_family != AF_UNSPEC)
 		ret = current_check_autobind_udp_socket(sock);
 
diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index ed5fe746d438..6e4f56a06aed 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -9656,7 +9656,7 @@ static long scarlett2_hwdep_write(struct snd_hwdep *hw,
 
 	/* Calculate the maximum permitted in data[] */
 	const size_t max_data_size = SCARLETT2_FLASH_RW_MAX -
-				     offsetof(typeof(*req), data);
+				     struct_offset(req, data);
 
 	/* If erasing, wait for it to complete */
 	if (private->flash_write_state ==

-- 
2.56.1

