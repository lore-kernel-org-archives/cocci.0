Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA4260A2600
	for <cocci@archiver.kernel.org>; Wed, 18 Nov 2026 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=ZkckorTT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:message-id:content-transfer-encoding:to:cc:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=sBiLiVHJZt1pubTAm+ktmHAi06mJEUhVPswX+ta/qkI=;
  b=ZkckorTTEFiUYgvrL+yGQgxrWDLy7/XrfQ0IKG7KnEu99JlVxFgituaF
   DOQA2vZ5SP0UhoOX2Ljo1BFl8D+p7xc7oKqFD3WIL+5jGtpTdpBcs32qK
   zLhcWVS0EcfKzvXFnAGFrpV8Dvp1mOThWDYlwFo4b53MiMlVtBiadOAcu
   M=;
X-CSE-ConnectionGUID: deMn7ux9S625lAFc+VjMCQ==
X-CSE-MsgGUID: /BZ5ObUDQFOiev+SkP5iSQ==
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
   d="scan'208";a="306145559"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Nov 2026 16:31:03 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 4C2178223E; Wed, 18 Nov 2026 16:31:03 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id E835C81B9D
	for <cocci@sympa.inria.fr>; Wed, 18 Nov 2026 12:51:34 +0100 (CET)
X-CSE-ConnectionGUID: 5JeXMCYyRl6EHooESLr5Ag==
X-CSE-MsgGUID: m+QEoQTUSLOeOC1EbWjJfw==
IronPort-SDR: 6afd9145_p8jl0obFS85ZEmforaSWFhbCQOKxfi8Kmy7jdMifi/quPG6
 T3aN6myKyuxOu3eaOy0XiR1xhk+v5vUDwcHxMxw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EKAjPikP1qgzGCayhagRWDMlNCAUiBFAdRA4RVg00BA?=
 =?us-ascii?q?YUriHqLaIxhhA0qgk8DGDgHDwEDAQsBAS4PFAQBAQECAQOEflEVjT4gBgEEN?=
 =?us-ascii?q?BMBAgQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBATkHD?=
 =?us-ascii?q?juGTw2MGgEzcV5HAQEBAQEBAQEBAQEBAQEBAQEBAQEBARQCCAVeASEBBBERD?=
 =?us-ascii?q?wENAQE3ATQCJgIiBwoVFgESIoJgAYIkBBIDNwQCDgUBr1xzAgKKG3qBMoEBg?=
 =?us-ascii?q?gwBAQaBCYFh2EwNcoFrAwYJAQuBCi6FdIJOIAGBcYF4ghA7hEI2gVVEhx6CD?=
 =?us-ascii?q?oNygmqBEoEUgQyCVolWjAUJP4ECHANZLAFVEw0KCwcFY1IzAyAKCxISGBUCF?=
 =?us-ascii?q?B0SDwQWMh1wDCcSKRcvWBsGBYEccxQEE4ESgQMJVIErKF0BIYEITgEDAoEiA?=
 =?us-ascii?q?gaCS4IAAgFJQQ4HRVMJJUMSRyQiCBIJARMaLAqBGjU8CSY/FQxnCxoFYQgCD?=
 =?us-ascii?q?Qx0ORAwHiQvBRomPhsKgQwnHx4IGA1IESw3Bg8ZBD0BbgeTM4MXAYEOASsiL?=
 =?us-ascii?q?oEtFhmTP4Nurmk9NAeEJIFgCAyKMI0+ggCGFzKqci6YWiOLbYF6hAqGFpBvA?=
 =?us-ascii?q?gQCBAUCEQEBBoF/IzyBIDMaI1CCZ1ADGQ+OO4Npg1KLawG8CXgCDC8CBwIHA?=
 =?us-ascii?q?QwBAwuGRosjM4FMAQE?=
IronPort-PHdr: A9a23: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
 o/t33uwr8M=
IronPort-Data: A9a23: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
 AovgI2tT5F6edcqSfSSdhjWm7BfPfwsKA==
IronPort-HdrOrdr: A9a23:a+cx8KBlK8F+Z43lHeijsseALOsnbusQ8zAXPh9KJG0wTiXIra
 re+cjziyWe+VQssbQb6La90We7MAHhHPlOkPcs1NaZLXbbUQ6TQPAE0WKM+UycJ8STzJ8n6U
 4CSdkJNDSPNykHse/c5iS5CdwkyNmC/LvAv5aV854Fd2gDBM8QjHYBe36m/1VNJDWubaBJY6
 Z0jfA33QZIF05nHfiTNz0vAqz/vNXAlpLgb3c9dm8awTjLpzKh77D3Vzi0ty1uIw+mltwZgB
 z4ejjCl+eemsD+5g7X1mfV4ZgTo93819tFCvWLj8geOh/shgyraIkJYczDgNl5mpD21L7k+O
 O84isIDoBW0Tf8b2u1qRzi103J1ysv0WbrzRu9jWH4qcL0aTomA44Z7LgpKCfx2g4FhpVRwa
 hL12WWu95+Cg7Bpj3045ztWwtxnkS5jHI+mao4jmBZU6EZdLhNxLZvp399IdMlJmbX+YonGO
 5hAIX14+tXS0qTazTjsmxm0LWXLzgO9kPteCk/k/3Q9wITsGFyzkMeysBatGwH7ogBR55N4P
 mBGrh0lZlVJ/VmPp5VNaMke4+aG2bNSRXDPCa5OlL8DpwKPHrLttre/Kg13ue3Y5YFpaFCyK
 gpaGko51LaRnieV/Fmnac7rSwleV/NAQgFH/sutqSQudXHNffW2GO4ORNexvdJZZ0kc4jmss
 2ISdpr6yWKFxqoJW945Xy7Z3BsEwhWbCRsgKdPZ7uvmLOMFmS4jJ2DTB4kTICdXwrNrQvEcz
 Q+tX7IVZh9x1HuUH71ihrLV3nsY0zy+o9qFrTG8+V78vlHCrFx
X-Talos-CUID: =?us-ascii?q?9a23=3A3T4BKGnDjL9CbkEn912PvmHYiMbXOSD/wUf1CH6?=
 =?us-ascii?q?pM2I3ZZ2STnKr3Lk5usU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ATiddAwycAIwiBCecyCUeIgug1FOaqKHtMW0KqKk?=
 =?us-ascii?q?7gO2jOAtbYhqXszaVTJByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,219,1787004000"; 
   d="scan'208";a="163090275"
X-IronPort-Outbreak-Status: No, level 1, Phish - Phish
X-MGA-submission: =?us-ascii?q?MDEHz7hwOYBqeVfuDSONpS6TrZVxqgP0QHMVyO?=
 =?us-ascii?q?dEnAfJex3ooJm8NwC/bWP9rFv9Xxd5JWX2nU0Et8QTU8u5XHbk9nkU5H?=
 =?us-ascii?q?i/nhOESWnTHxmxsbbxwToFdrmTwTjx8CW8wtECpoa6uVtPq0ggMVR1UY?=
 =?us-ascii?q?URuO109rGXyJ2TqakAWcov8w=3D=3D?=
Received: from mail-francesouthazon11011049.outbound.protection.outlook.com (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.49])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 12:51:34 +0100
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xhdpbBYIqZhMhoiLF8A8/LCE7UBz/edZZOE4JzwmCi+dWmyTAN/O1EAgCOHjN8IExrCY/nX6uRDMkspyQ1JojR8jJxaBNSYDBiD98w63N13p2io1JkP6vPsh0TGsVNkn6bn+swsOstDPcKEIqsgptCgInZR4O58qx02QhC77+wofx31CmBmEnYm5vnHBrsMng0k44PV2U6BBwhrQAilo0k1cppcjBTmrMiPWT2xDLjRS1Jpm0GqEfETPd8ttbUG/m69srqLIiQVTl66dqBKvA/EPJWrwFwMImpAaVTSlJdZfEKLsKGtDw47l99dH/+SP+5Z950Rg1cnQbWIQ/K1reg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBiLiVHJZt1pubTAm+ktmHAi06mJEUhVPswX+ta/qkI=;
 b=FpSZDOrdGx23/0/nY2TvKFXb3K9ZpnAIQifPfhx/5otkixLl4FAB+gtBRB5spokpbbCeV7xxUVFxhBwnpdKVTQ/5rMaTrgDP/cG5v3kHHCAD0aiHwzDUqs1D7rFpSbCJbXlTQ4qpZ+kwnZO0AjVOMxvlQlsPBLXyYJdXRDE9Y6JlxqaXMCPyI1cbc/3b147YD2UQTaQBwwWjkZWfbpHbqbIxW9x9S+et+00ipcYXipA3iSjK8RAl199Vgzz/EhweBXHaKdyABGEDWnNvec7XmW654x8H+t0dciaekrAS+hLaiamtrPY7/wnfRM58rSh+wLKsT6Lw1X0FLOlr9uHjAw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
Received: from DU2P250CA0002.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::7) by
 GV1PR08MB10422.eurprd08.prod.outlook.com (2603:10a6:150:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 11:51:10 +0000
Received: from MA3PEPF00000408.eurprd04.prod.outlook.com
 (2603:10a6:10:231:cafe::35) by DU2P250CA0002.outlook.office365.com
 (2603:10a6:10:231::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 11:51:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MA3PEPF00000408.mail.protection.outlook.com (10.167.241.153) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 18 Nov 2026 11:51:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0IPzJGMWGSU92326zf4gjel7617TXbguAPuNMVsuXVoQLz/bCGb245A1KzI3EMD2z3hwQyzq5dkiSJ6J0aZXyWZKVJc+MQypvZ32LL+2rLeIZC99Qc/nk1D0NHIa5NJ6EXER0iEaK29ZIZe9/su9e6vmr8h8+OusCLBRZWlS66gp7IcFZBGzwdhMvs4fPlZhRDdbseuQqLFt8l5l5iClspEQGyDiFNYccHBk7guQYsVuw1cm4JDfyo+RcEW27YYfN1LKsw2fMa3meOI4I7vJPy+TiM4QoeZ7FYJVKXX4bWwwOq5oCkYds0eXwgA9TJ6sqKAVIcjDTsVVU4lp+KOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBiLiVHJZt1pubTAm+ktmHAi06mJEUhVPswX+ta/qkI=;
 b=BV6RIhAY71rWVJ7FfTUURGo/COstLstirD3tfhREVZIEyg+RLPnrR3CUkPbf+B+EzS6bG/MA4doLS6DJ4et0tKxHZkeelN7g1Oqj/RcHVFMXNFW4OICACeMMifENTi0YdobJ3SAzc+KWUClNp7IHsJXuPhiXKwiwVVzIFU0KV48kxIbZGA27AMDwmYUU/8DQ3Cc6cbAn8iKhO6KtFvKZMISBTUi+EjEjsYdJQlvayVkiI7u80WVPgpX8gEc2K6yAYLlIeJv7V2URgWb0e6RPpuyoGkDBYkM2KhWqXsURnXf4Q1dVthLcfqoX3s8Ikr9/8BB2eVxkmex9pYMHyluO1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 (2603:10a6:20b:629::15) by PA4PR08MB5918.eurprd08.prod.outlook.com
 (2603:10a6:102:e7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 11:50:31 +0000
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c]) by AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 11:50:30 +0000
From: Bence Csokas <bence.csokas@arm.com>
Date: Wed, 18 Nov 2026 12:50:07 +0100
Message-Id: <20261118-offsetof-v4-0-95b385c10b22@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPCQ/WoC/23OzQ7CIAwH8FcxnMXwsbHNk+9hPDAoDpMNA0g0y
 95dmAdn4vHf9td2RgG8hYCOuxl5SDZYN+VQ7XdIDXK6ArY6Z8QIE5SSGjtjAkRnsBFMSsGr1hC
 N8vjdg7HPddX58snh0d9AxeLLRC8D4N7LSQ2lNMoQwZfGYEN0/rU+kWhZ8Odeopjgitbc1IoS0
 Ook/XhQbkTlWmIbRtmGscxYI0BDy7tONL+MbxnfMJ5ZQyttGlLztuNftizLGxTLjMU3AQAA
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
	AS8PR08MB10291:EE_|PA4PR08MB5918:EE_|MA3PEPF00000408:EE_|GV1PR08MB10422:EE_
X-MS-Office365-Filtering-Correlation-Id: 27583a47-b603-4aba-ee45-08df456a3bfc
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|366016|261009223027099003|6133799003|18002099003|261009220027099003|261009221227099003|261009221727099003|261009223327099003|3023799007|921020|56012099006|11063799006|261026140227099003|261102123227099003|261028144727099003|261022075727099003|261022115727099003|261021123027099003|261026121527099003|261021135927099003|261021121427099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original:
 oLwuc5b/edBhVMqP8hQFu4yLstH5AtnnXrYm/Li/ikj1YuORIDG6smOeeWJcPZ1XyYqEaBM0VW3GRV0lHSLtE+HG0IQ5bCh7jQeLT1/Qc1hGCazrdUKQiAIuy0CgQKEgS/R7yQYeT32JETtZBOJLTqsRKGp9hlnv1S1lh3hASsM0ml2rW3giVCDr9mHzEPGMzRbqmSBTolnDOsu2SolytM1JfHh2SAKiK82WXQGYAX7IIkFyDNu0/3Pbw2/8YvWqFx455x8ubTue9ji8jxTmVkYg8FqsjZJVZph1PhyMzqL7dRVnhohJHt9aIV7o30rFWk87DD7V60yrZan/GfutZH6cQZninIPnVC/2H63CAx9jIEQP/hE8ZF3O7LvBwAagDcJaUTm2iey+ApD/0zq5OBJnJWUaFAApHVpft4vs2bsNvkjs47PwVd2xIwQr5DyoRbw0LVTiiPND6bSYTWudaIY5Z/v06Lt+QX9j2auoo4N3rDMQjISRXtQJmesuUfk6Vlssouo1emVpL2dYNnBUrEMMvGPmEQqSTBY/TSjKXLRr7FZ6AAAXERUMPwcggHvj5+TCEPdGwLCJQZEYR62HIlekNtqPHF83zskanxIblsxY3PiCH7m5/PnEX8YKr0IconjWmE9n5GYXpSuMGugFXWE3wX1A5cyUycAEO5U1xfU=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB10291.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(261009223027099003)(6133799003)(18002099003)(261009220027099003)(261009221227099003)(261009221727099003)(261009223327099003)(3023799007)(921020)(56012099006)(11063799006)(261026140227099003)(261102123227099003)(261028144727099003)(261022075727099003)(261022115727099003)(261021123027099003)(261026121527099003)(261021135927099003)(261021121427099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 aOXmkKx4aDCJhKDBub4F5KcGjFaYPGczWj5EPgfxxO2F+aO3ocmB91VVJFPKyjaUXs7C09HV842802+7fVLfP3j22xYHr6f0q2YjhJWSw1hTauRX80Ksm+t6/riuTqoxsqe0dS2f3jxdEJpevbryRgdJr3L+FXFvRcTQAElFf/QhDK7D7b1YAjdFgRZvsOGnOol9CpocG4Qiq8Q7kkux8Zbif/x01xCg2lBFS4d4fn+dxM0vo1ELliZjhXgV8sqIsfMjONUlB9wNfVlCJ5Gqm3SniFJA39CztMRkREYji4ty4JcF9kEOmZhsmywzzscyKNi6KgZnf39nRMYT/pIi+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5918
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MA3PEPF00000408.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	10554276-ef6e-4e25-9cf3-08df456a252c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|14060799003|36860700016|376014|35042699022|7416014|18002099003|6133799003|3023799007|921020|11063799006|56012099006|261022115727099003|261022075727099003|261028144727099003|261021121427099003|10067099003|261021123027099003|261009223327099003|261009221227099003|261009221727099003|261009223027099003|261021135927099003|261102123227099003|261009220027099003|261026140227099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	UByHDW+6ud34XAUsC4kFmUPTGFERrvGz5ar4pBklDs/Am3G8TuV/w41VXstQ5dglrjEb4gYDzxflOlxoHu1a2DPpIOFp0FQvx6hKvRA47Edh39TLL2uqL9PFePUC4eOLYTOxOEFQOSlS+s+MgI9j0clLI9Qo0UAGrkGP1vvh+4Dchqp//KX27WHHySY36zh2F7423B6vmvrRBcEyRc94O6PGDoP70k22hI0lp65rv0Gib3N6EpS7V0GwUpV4vJlLJ1UeWuctZJnizY1DF9EtRctLNB4lLWxsooJLCzI9JVR/+VL0Qqw2xvdPIqddZlBXRm+k634M3uzZjWPv6W33aw0Zt8oIHQ7+MEvKsmsb7dg8hdNYJkXXtobmaNjoRHhVICBqqrK7jVT8i7IeqsvkSyKWBt5MTC5mw9SZMKwxD5FlVfoottiwHO+FI4EmP3lCSy7wmwLMtgsxAQIm6YxSkrtEPZlVfkc+P/Ozbxs5K58raZOwINFmZe237keApEJroimp9pizSjXfNhrQJQKK94Q4f4wamw6k+rZNNjFDetwQB0IJqAGHtqs4PM8lhE0qK3TEphN/nzwYAOYcvFauMA2EnUkQ+fwvkLJwpqLbzXPjFpM392URCbZoFPEb0YrSvCW6uTQur8qbXTmVUvpzA3KmO569DdThICL/tWQL2Ollo63USu1p9et6/86f4zGmfYOPJemLEOZnHqYf6IsBJQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(14060799003)(36860700016)(376014)(35042699022)(7416014)(18002099003)(6133799003)(3023799007)(921020)(11063799006)(56012099006)(261022115727099003)(261022075727099003)(261028144727099003)(261021121427099003)(10067099003)(261021123027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009223027099003)(261021135927099003)(261102123227099003)(261009220027099003)(261026140227099003)(261022105027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8ffV1BnqTBarWgYJo7p3qQaITPnp4TcN6T3a1/mzODGxb/VLPVvMEUvbxoseRaEbBH670AP2i9yI+tRxnTBa+bZ0K5HBBj6NFU4x3lq5F19/HIIuKLB8obJ2nAnkq9iu7uomEyqMepvoS0GMAjV6RvuWh6XOGfjyNvXtGNUVFCsMs3Khzmu6HDEXehnEhENpqYowrYK3lkBiu+1LQRo+caw+2R1Gp0ZCkCIeMV5Nd8oLMDWBD+m1Zlue0hedJIuzXnPCz54uNhRsOMrLbEhvj1J6OQUOGD33RR1+qVnwk4iYZrL8mB2BYk6SDZRybZR3gRgQxxtfy2q2O/Ft998LeRhEzI7viHROTCKBasbZVp7x7UyuYQCYWrKXWD0cRhVKtDnM5b0NhAGiBZBhnL8A9y3ZQDCcdpDwdXKdqx+GpeCwybaCzv5cqshGquNbudf1
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 11:51:08.3620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27583a47-b603-4aba-ee45-08df456a3bfc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MA3PEPF00000408.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10422
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v4 0/2] Add struct_offsetofend() for pointer
 arithmetic
Reply-To: Bence Csokas <bence.csokas@arm.com>
X-Loop: cocci@inria.fr
X-Sequence: 3812
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/64xX-BaPH0IYHhZrfZg6UQ>
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
Changes in v4:
- Fix more Sashiko issues
  - Add `virtual patch` to cocci file
  - Skip tools/ directory
  - Remove redundant parens
- Regen treewide patch with coccicheck
  - Except arch/arc, as I can't test that
- Fix (preexisting) style issues in treewide patch too
  - Except for CAMELCASE, which cannot be trivially fixed
- Link to v3: https://patch.msgid.link/20261113-offsetof-v3-0-714df7053893@arm.com

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
To: Alexander Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
To: Paulo Alcantara <pc@manguebit.org>
To: Namjae Jeon <linkinjeon@kernel.org>
To: Ronnie Sahlberg <ronniesahlberg@gmail.com>
To: Shyam Prasad N <sprasad@microsoft.com>
To: Tom Talpey <tom@talpey.com>
To: Bharath SM <bharathsm@microsoft.com>
To: Carlos Maiolino <cem@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
To: Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Darren Hart <dvhart@infradead.org>
To: Davidlohr Bueso <dave@stgolabs.net>
To: André Almeida <andrealmeid@igalia.com>
To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Simon Horman <horms@kernel.org>
To: David Ahern <dsahern@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
To: Mickaël Salaün <mic@digikod.net>
To: Günther Noack <gnoack@google.com>
To: Paul Moore <paul@paul-moore.com>
To: James Morris <jmorris@namei.org>
To: "Serge E. Hallyn" <serge@hallyn.com>
To: "Geoffrey D. Bennett" <g@b4.vu>
To: Jaroslav Kysela <perex@perex.cz>
To: Takashi Iwai <tiwai@suse.com>
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
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Cc: linux-xfs@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: ipsec@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
Cc: linux-sound@vger.kernel.org

---
Bence Csokas (2):
      overflow: Add offsetofend() variant of struct_offset()
      treewide: Use struct_offset()

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
 include/linux/overflow.h                           | 12 ++++++++++
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
 scripts/coccinelle/api/struct_offsetof.cocci       | 18 ++++++++++++++
 security/landlock/net.c                            |  4 ++--
 sound/usb/mixer_scarlett2.c                        |  2 +-
 53 files changed, 129 insertions(+), 98 deletions(-)
---
base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
change-id: 20261105-offsetof-f62aa6348f0d

Best regards,
--  
Bence Csokas <bence.csokas@arm.com>

