Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD81C282D9
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject:
   reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=SKX07W8SRtkDrJq0irDhiuj6C2dgheStIzozI4qWiPY=;
  b=vhio3xRDmQrQ0rd3fcAO2DQogViflpoQrnNzAk9rTrFBAn6vKsXsm4tB
   zxgrTwmYrfVLiFH4e+r6WYqPw4UR8ZlrqkDmtHW+4SnqCsZ6LUdZAe5aS
   wRPs8Pe46gVSBS6NApuMN1I0SBBt/yDRmpOWa16lX2GyhExiiukX966qi
   k=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@sharedspace.onmicrosoft.com
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211070334"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:59:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9340DE1782; Tue,  4 Mar 2025 10:58:47 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BC7E0E0260
	for <cocci@sympa.inria.fr>; Tue,  4 Mar 2025 02:34:05 +0100 (CET)
IronPort-SDR: 67c6588d_EkVs6InxR3wHE1Xu19alUyHHtGzMCR6TJalHBbba9MgDFYR
 1u9jtxaCnMQ4hT+FrlIWw9llLA7DX+UKKbktUxA==
X-IPAS-Result: =?us-ascii?q?A0ENAAB1V8Znjy2aR9haHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYFxUmJ3MQcISIRWg0wDhE5fiHQDmDiEBoFWgSUDGE0BAwELAkQEA?=
 =?us-ascii?q?QEDBIIMgnQYin8CHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEBAQEBOQVJhXsNgmIBgSReSAEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RQCDSg2AQEdAQEBAQIBEhEEDQwBAREmAQ8CAQgUAQMCAgUhAgICDSIVEAIEA?=
 =?us-ascii?q?Q0FIoJggjEDDiMDAQKhLwGBFQEWPwIoAUABAQIJgQuJFXp/M4EBggwBAQYEB?=
 =?us-ascii?q?NsfGGGBZQmBGi4Bg3uBcIJjAYFshDqDQnonD4FVRIQHOD6EQgGDW4JpgjOBa?=
 =?us-ascii?q?QGDPahbCT8KexwDWSwBVRMNCgsHBWRFEDgDIAoLDAsSHBUCFA0PAQ8GEARqB?=
 =?us-ascii?q?TRBOoILaUk6Ag0CNYIeJFiCK4IXgjeEPYRAgkFRgkKCEXFsAwMWDwGCMG95H?=
 =?us-ascii?q?IR5hGsdQAMLGA1IESw3Bg4bBj0BbgegezqEISABUiEQCkwmgU42kwyDfY9sn?=
 =?us-ascii?q?x00B4QegWMMoCaqVi6HZZBqIqQohD0CBAIEBQIPAQEGgWc6gVwzGiODN08cD?=
 =?us-ascii?q?44hDBaDWI89AbkERTM8AgcBCgEBAwmQHIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:toMMs6kyDb0vh6x/+KjRC6zeOg7pDfPRiWdD5ihNYBxZY6Wkfp
 +V/MjzhCWUtN9OYh8dcIi7Sde9qXO1z+8S3WGIVY3SHDUOy1HYXb2KirGSgAEIeheOt9K1sJ
 0KAstD4bLLfCJHZKrBkW2F+pMbsaa6GcOT9KXjJhVWPHxXgshbhm8Xe2Trd3GeBjM2eabRf6
 Dsn/av0gDQAkj/Gf7LfkXtMdKzwOHjpdbNWzJDLRgh7wWFkDOv75DHMzXw5H0jegIK640PtU
 zenSLExojLiZyGIxnnu1P73tBzop/M29FDDMuDhow8LSjtsB+hYMBMSqCPpzc8pcCo8RIPnM
 PXqxktEsxv4zeJF1vF5SfF6k3F6nID+nXiwViXjT/KptH4fiszD45slJ9UaRzQ7msnpZVZ3L
 hQ12yUmpJLBVfrnTj75fLPSxZ2/3DE5EYKoKo2tThyQIEeYLheocg050VOCqoNGyr89cQODP
 RuJNu03ocRTXqqK1Ti+kV/yt2lWXo+Wj2cRFIZh8CT2z9K2Fhk0kojwtAFlHtozuNld3AE3Z
 WdDk1brsAVciYkV9MhOA7He7rqNoX5e2OWDItVGyW5KEhIAQOSl3e92sRE2AjjQu168HJ1ou
 WHbLoQjx9GR2vxBMePxZtW7xvKXGKxNA6dg/129tx3vKbxS6HsNjDGQFcyk9G4q/FaGcHDXe
 2vUagmT8MKvQPVaPR0NiDFKtNvwEMlIYAok8d+X0jLrtPAK4XsuOCeePHPJKD1GTJhXm/kGH
 MMUDX6Oc0FtymQKzHFqQmUX2modl30/Jp2HqSf9+8PyJIVPokJtgQOk1y26syCNDUHuK0re0
 l1Jq/hj8qA1CaL1HeN638sNgtWD05T7rmlW3RWpRUSO0exaroHs8X3QxEY4JJGHG42cyr7Kn
 8om70sw9PCE3W5/1FUN+6a
X-Talos-CUID: =?us-ascii?q?9a23=3AGBUu0WqPbFZeMDZ6RLmVllnmUdJ8QnHB5VLKHxK?=
 =?us-ascii?q?5WX81caWFZUO+0rwxxg=3D=3D?=
X-Talos-MUID: 9a23:YuiiLwlCh7NEyfekOsEWdnppPeJ1wYOtDHldurEFuvWIazZMPjmk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="210982880"
X-MGA-submission: =?us-ascii?q?MDHQIUSzk8K04ZMdxbEgIe6U4BGy/EDXmX2Hme?=
 =?us-ascii?q?zye2ISjUixDYRuXDHpAY8m0011qkYp6Tsdu7dfLVjFyt9Z4NMcV4W7Xr?=
 =?us-ascii?q?najSePLte2Fm5MHD4h1aqwcWyffdOgWD08emaglwuBKc4ZkOzXnREJ5v?=
 =?us-ascii?q?b5PS607+4XvlUVIiH7Mw+C6Q=3D=3D?=
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 02:34:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741052044; x=1772588044;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SKX07W8SRtkDrJq0irDhiuj6C2dgheStIzozI4qWiPY=;
  b=FJuGnkbOLnUdmsfGkpg6P5s8xtTTklHcYYTiiybAv7ji0nprjKXVozRb
   ql03tmVJx1XQ+T4WCEvkv4LHXoyD/iYie+U2E2A6W+zAO87bN+dyMWuur
   caI2i7NJYx5SLEnJJnM6GLBCFMglkWV0fOVtYcRIg74DRUq2Bfcn58qFi
   pp/afrSzagQmYIK1FmtqxINuXWIN1hZPJZD9kKw75MoTdLEk9K0up5Xlj
   vYiiNvmtPyIS6pKCIo6Tkww71aEYhDcuvTM9B60fjCuDRFdmeNxIyA3tk
   JOU81zNpSmrRS8dO41iemrO1Pt552EZ54CClCBo8oii1KJipAmcQ7ndao
   g==;
X-CSE-ConnectionGUID: 8PGhWRTASe+IwxtuhgkziQ==
X-CSE-MsgGUID: TnrBpNrHS6K3FYEncs5+SA==
X-IronPort-AV: E=Sophos;i="6.13,331,1732550400"; 
   d="scan'208";a="39960808"
Received: from mail-westusazlp17010001.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.1])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2025 09:34:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPKBjaikiWECxhqlCeAU12D0+rEUGQ7p/4unBAtJzlGFxMUtJvLv6+lWRZne6eaWCX2IqmtTKQUNfa1XVghxhtNX0Q97Zrzq8pRhKOdobOiQnwsl4GRRYt7VBE5tZ2CjFRnfQb8Eo/pH3RTWrIAxG7IvXZ03MY6RobS3KoTp7QJ2PUwxzpN/1+9LeuRGzl3w/uIL4Y7Du87JTzl87YNZTI58GchAxVjTM0M/7WUEbFVVHyDU2+GMVX/eNjzDB+0PAk6caK/9yu11L7xKwG3o8gPh297Bbn5Zh4k9NmNi7tbekdnYTSGpRRENTIeUVDD2G673WsbCBYzXb50XqoUC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKX07W8SRtkDrJq0irDhiuj6C2dgheStIzozI4qWiPY=;
 b=haFENeyW97T8/SKL5XKUTs0qXJV12FrZqM8nSej8mh636gfe7U5RHDSW7lqx+t1ElCX7CNZ2d1UYKV/msTZcLtOh6nKO0WjVfFAjU9s/7HsYxSCX5qYC3tMpvbFRwi3vSt5DmxXAY1D/Id7xUAveIUXjP/RA1skhxN7qFf/blgHaldV24vPwpnQCPL26IJCvzsnEvGWo/XPyNZjDFvMuz3UVbjegC9VlxoE4hQRJoD5TIfvPA6XuQjccHoDY4KcTdAZvvAguAFyh7d2F7TLmnpwmoqFShZv/9mR0H/Laa99+QEK64Ak+knztOCSHDWkHKbLjXuy4/ETL/b1FCpoqew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKX07W8SRtkDrJq0irDhiuj6C2dgheStIzozI4qWiPY=;
 b=DQLdtq/BW3FmObL+qAFXUw982mRN5pB3KxdmhZDf9elJ7sgGSDZq7DFFyYwpC7euOLFOGQUizOJA/D59VgYaYLwrbJ3AKAzI/hPfVU8lEcCWvFoPQDRdh3tGp/YmYqglZWONaITKRU3HuyPKkMY2962coPS7PdHQCuItsjRT9NM=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DS1PR04MB9276.namprd04.prod.outlook.com (2603:10b6:8:1ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 01:34:01 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%3]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 01:34:00 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Markus Elfring <Markus.Elfring@web.de>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, Chris Mason <clm@fb.com>, David Sterba
	<dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
CC: "cocci@inria.fr" <cocci@inria.fr>, LKML <linux-kernel@vger.kernel.org>
Thread-Topic: [PATCH RESEND] btrfs: Fix exception handling in
 relocating_repair_kthread()
Thread-Index: AQHbjHtQuR0QMDeWAUOPbIm1biAX8bNiMgqA
Date: Tue, 4 Mar 2025 01:34:00 +0000
Message-ID: <D873FT11P5M6.JLH3TCARWATJ@wdc.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <cebfc94f-8fdb-4d5c-56ee-4d37df3430a1@web.de>
 <09fe60d4-8eda-42bf-b2d4-ada265a09ce5@web.de>
In-Reply-To: <09fe60d4-8eda-42bf-b2d4-ada265a09ce5@web.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DS1PR04MB9276:EE_
x-ms-office365-filtering-correlation-id: 4930b6d3-67b5-4338-6058-08dd5abca3cb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bFlCUFFPbmp0T0I1MVl5UzNkQStieXBRd25qMUNFYmxYb1cwcnVsbTExWG80?=
 =?utf-8?B?eHc0aHhRK2p3RTF4cVlVWXZTTnVvc244dUJkbHdKdmgyYThwMEhob0FLZ2Vu?=
 =?utf-8?B?bGhmYTZpakljVHFnT21zSXlCRjhsdWljSDdkMy93LzdUQXJOSDRLcUJwRWFM?=
 =?utf-8?B?OXRYMkFweFQ2MGdHcklSZ0NNSWNBQ0xrL2dXbDJwUXB1UFNWSGFlbnZVU2ZN?=
 =?utf-8?B?UVZuSUV1VGRrUTE2eVkxZUlFMk5kRDhQKzNsY09YQmJ0Qlk2VEpUZTZMNlNH?=
 =?utf-8?B?QUdTUWFvUW50MmtYcnRSLzNqVCsxMXFJakltYlZraW1zQktIQ3l5VUNsN1E2?=
 =?utf-8?B?eVlta0Z2NVFFWmsvS3VZYUxJSllYL0p2UUlCWmFJM1U4UWUrTmRqYjJqaFR1?=
 =?utf-8?B?YUZVVisvNDZURTJVMUlab0Q4a1YwMC9LeEx6VWRqVTZNcmErQXFvL0ZHcWdh?=
 =?utf-8?B?T3RrMFpGWG5hT0dSdk41MWZTa2FyNmJiaVNiZkJ3UnNsb0MwalFMQk85NWxt?=
 =?utf-8?B?OHhkbWN2NTJMUzBSUHNvZzdWSzZYem1YMVhTbURCWjMxMzgvQXQ0UkxYWXA2?=
 =?utf-8?B?eDFOcGMyQ0JjM2RlZFREM3ZhVXRXRkU5cy8zM1RBa0hhK2d1dGJWZ0FZL0FT?=
 =?utf-8?B?emZiYnR5Q2tGeWFOQnJ2UjZRaXhZRTlKTjlFSFFrZVFZTzUxRGtLUUZpYmhI?=
 =?utf-8?B?WGI4YTZpS3FMQzduS0QxTVR3L0czNmF3V3owcEVnSlFpYnY5RmpUZWRXUXlv?=
 =?utf-8?B?OTVaVVlsSXBnSUZsZ1d3aE5nemIrTVNNRGgyMHFLR0tvSkJDYlVVS3loWm54?=
 =?utf-8?B?RW1TVnFLSld4YmxreGRMRXBkV0RVNExlWXV4cndtRHRxekFsQUFWQzRGK3p0?=
 =?utf-8?B?Q0kvL1JKRUtxMXRwZTdpaG5vT0lTZkhuTVpwS1lhYWtaY0xuRzhBT01rVkc5?=
 =?utf-8?B?SmhjY1RWcDZCeGc5cFdQbm9NNlFFcCtDajdpUkxadCtKNStSaExzczBjYUlO?=
 =?utf-8?B?QXhpdEc5ZzlxNS9MbGsvSHN6eEZpbDhGYmhQcm9KdUtQRmU2dlJQM0lFWjRp?=
 =?utf-8?B?dmJrZXFiaTkwUUNWUWtDSXdSd21NQjNFQVNIYWpKZUxaNWpxWTU5WHl3RlJZ?=
 =?utf-8?B?d3QvMDBiNHBqSUZNSENmaElYdHJrUFFnYkVHeHBjVy9xT2l1RWorWm9iRU9O?=
 =?utf-8?B?a3dHSUJvVXpwZ3Q1S0N0OHRZSmoyT0hDS0U3aXBuUmQ2UUtrdEZJaHo5cDRD?=
 =?utf-8?B?ZStpRThseDlGZjgxWTd0MzBLUVZLRkt5am92NVdabVN4dVhvNHJXcXpJSU9P?=
 =?utf-8?B?ZEliZzJxSXB5eUdiUUtrVmhybXRRMkxHZnJrVGVhWER3dzc2R2FPZUlVdHRy?=
 =?utf-8?B?cE16YWJISi9wRVBCWWhtOVZMYXlTMFIyNXRKZ2UwZDJTcjRtc2oyU1NBTGNZ?=
 =?utf-8?B?ekRuNmEvUG1WSW9OZ011YXNuZXFTSkdyU1I4eVlOTnBFRlZ2UmdPY3QxZnBE?=
 =?utf-8?B?NmFUc1Q3NTlGZVdNSU1OZisyMW5qNWtqRmozcHE1cnNvVTZUcWlNR3hGOW1K?=
 =?utf-8?B?dDNOZVljSW9DU3ZxSkFoRHB1a2gzWldVaHlZWTh4b0RVMnFUQnFRTFd0eG42?=
 =?utf-8?B?UVVSZVpYVVFjZ2psZHlSNU0rOTJMZmVQcGpyTGhDUmpsbjBsMXN3ZGJSNndY?=
 =?utf-8?B?UXU5WjFOUmZMUWZOUU5jYW1MUDgvUkxJOW5jVFZJTWhvdGZCQjcxYnVDRitT?=
 =?utf-8?B?ZzFMdjZVM1VyUVhJdzMzaU05NEZZcHRoWE9yR0lWelFFMXJneFIxWlUyRXV6?=
 =?utf-8?B?clVMSEwyVjc4RlkwY013T2xnTUZGSXdpZWFyRG5nRXh6ZlN0NzdRdFlLNjlv?=
 =?utf-8?B?WUdXY2xDK2V3b1R2VE1pd2VQaUxqdGZiVTJDQVRzcmdVcVhqTkxmWHArYzh1?=
 =?utf-8?Q?rcc71oF3KCDdSrL1piPLSzDfpLVfbrMS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmVzckt6ZkdkTlgwSlRyclh3bzU2YXBXQk1sc05RVVg5ak1Odm5oQnR1d3pZ?=
 =?utf-8?B?TWxzOWpMVVpneVBMY0dkRVhHalpzcDc0SlJMUUdJYnI5cndkMzZwc2t4Si9y?=
 =?utf-8?B?cjA1SnBjVTdzVWZ4MnlYWHdoVGtIU2ZQcWNrWUoxNEhaNGZTaUlxd29tQU1U?=
 =?utf-8?B?YUpOdUVSMEFWd1hJZFJSZ3ptdXdSVUhFVWVJdnRBZ04wV0NTQzIzUnVmbStk?=
 =?utf-8?B?YkdIb2FqbFhJbnVudjhIOG5DKzQ3M2t2VVdXdEZhTXhaTzgvLzBONjE0RjJF?=
 =?utf-8?B?Qmk3ZGZFUWFCNWZJaVUzYjdVUlJ5WC82VUtjZUROdG1ZNUw2Z2VsREczMFYy?=
 =?utf-8?B?TVc2VVUzRnlhUERaVnAyMkZVTXNDVTV1OTBPaDI5MXg2NG5yWTBaNTBSZEcy?=
 =?utf-8?B?UVI5bEtLOUxGRkV0V3BXZWNLaUFZeFdmSUlzSkJqWDJtVUluUHAwQVh5TWFC?=
 =?utf-8?B?QjM5bFBQbWtTU05uVGVVN3oyaDZtZEgycHR1UU1ZSGU2QXdDYzczRG5YdTNN?=
 =?utf-8?B?cnh3T09HUHdnZkh0QUtoQnk4K2NBRXRlMnlTUjgzU3lBS3ovY2tjQTl0R3ZL?=
 =?utf-8?B?MFlRUURUNDk2cTlFOFNnZDlFMU1sV05QYXZveGQ2azcyMy9QSXFpblVJTmxU?=
 =?utf-8?B?aDNiY0FxZTJHaUgrZ2JmUlNuMitPeFJwN1NPVUw2aXcyS3ZqR2x6QVpXS08r?=
 =?utf-8?B?T0tBcFFWcm9Nby91M3NKMEFjbVlVTnJlN1YvYml2QTFjUGFIUlRZVDBFTjVm?=
 =?utf-8?B?OVhIVW9WT1N3UzFkM0xjZDhkVUZvQm9oSnBQSUQ0NTduUE9YRjBVS3RvME1C?=
 =?utf-8?B?TWVEV2pLUlR2YU43Qm9zY3NBVTlkVHJiWmdFSkpGR1ZnVERyQVFJN1FHWnQy?=
 =?utf-8?B?UGMwaUpJM1NjazhHN29DclFuMGRmMWxlbjd0T0FnN00zRkc4U3FJekcvNTdp?=
 =?utf-8?B?QjlMdjg0WFVtZDBPWnU0em9JVElLNnEwV1IvOEhERk1SQW8wdnBpcUxtMGhp?=
 =?utf-8?B?V1FnUXAwVEJMZkRpdXdPaFQzRzMwbmVUNmROK3IzOFNsbmxXTFoxUWhRVUNx?=
 =?utf-8?B?bGZtVXZKZUN2Nmk4eDdnL2FuS0doQ1IvYnl6UHhNam5ROE1saCtOdjcvT2oz?=
 =?utf-8?B?TXluM0NneUVzRGVFcDRRcnpCN0F4UktLT29zcno4NHFhRk15VEw5b3lFeXZT?=
 =?utf-8?B?bWhpMU41Q2RHK1RxNlRPVU8rOHU4WmFiZkt4UnJXaDIya2JiaTg1UzZ4U2h6?=
 =?utf-8?B?S2lwVSs2cjVpTWdyV2NKZlg5MlhOZXAxUjQ0UkZOZWVkdWNvTnZnMTZ6M2ls?=
 =?utf-8?B?a3QvWXBnWWo1UFk1MUpGQno5TStzemNnRFcrL0k2K3h4Q09xbHZrWGU0bGh4?=
 =?utf-8?B?M0pCNEw5ZDNkOExtdDFtTUVmSURnbzJJWnNLL1grZXdCaStqRENSSlNSOW1S?=
 =?utf-8?B?RVRpYkFvbmpCT3ZWRGlTWkhHSkZZYWdOV2JrbFpmcHZPMjhPMEduNVB3ZHRx?=
 =?utf-8?B?R3RWci92eVpodUg3NEh4c3QrbGEvQk9tbllDNk1wd2p6Q3ZXMThvMlFmeFVn?=
 =?utf-8?B?Tk9idHlEdkxid0Y1K1VPTHRQelFsK0VtSUlRYnQ3dGZtd1lKaS9YNUJ4WVVV?=
 =?utf-8?B?RVByeWNWQzJhb29aTmdIM2V5QmxTM0JHSVgzbFM1akJ3clhWNTEvbHNENWx0?=
 =?utf-8?B?TlpYZTNIY1N3dGs3TDVwU2xuQy9sUzVCM0FsczhXV1JVT0orZm5mTFhkK2JG?=
 =?utf-8?B?VkJ2dk5mR1B1Z3ZpRnhSMk9kZ0oybnJRTlg2ZXJValZNMDVMRWsyNmt5VHhU?=
 =?utf-8?B?R0RDdDVQMkhFaDQ5T0wvdk9pR0IrdWg3YVBPenN0Q1FpdVIzU2RiT3NHM0tL?=
 =?utf-8?B?NG9ybXdYaVFXL1RmbWdHYmptelVTK1hIb1c0dTFlNHB6eTVkUzdMNGNhMlRP?=
 =?utf-8?B?UFI1bGFUaHBQZnZROGlFM1lWN05MK1AzWHN1d0ZKeGZWVXo0R1BjcUNjeVI1?=
 =?utf-8?B?cFVMOU50VFpuLzVaSWRqdU9SYnVheWlXb1IyTC80RVo4bWduck5ZdGdDTUEz?=
 =?utf-8?B?djNWK0J6bC9FSFh1RGRTZlNIWWlpOVdwOVNTY0V5dlpGeHZHUGhkRnNVRDlJ?=
 =?utf-8?B?L1lpVVBjd2tHa1hTOWZUdnhiT3BuMGhBMWxoUVJ1L1dpUjFxRHNGVE04YThD?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A12821B04B157479A0734E41E275ED1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	35sfCkaKFp1tplWFn21qwN/ChL7KZVCfzqzBBWbMPQ05QMX6jnc/cfDyo7de+w+ChM0uP4TrOW5vVkYssq5JO5awbtyDQrNUcn94kNx/IpQJFXEzZ60dDFUpgDfbpFovuj5nmfwqxRzvg+NsKXdLVmpM69JQL9ifiB+jhGazAcrv7CMIZ8IiExfYpAQ62nz5qp+ier6mnLPbjBRjC/0MvLjIyJf49MoLSIjfU9+EneJeHyL4e1r58KypFhLy1/T29C5nX9DcvxNpC/gfUiOrg8vs3n3Vovye+kEZyAWLIXYgLVuqPoN4oecgff4qAJmqKtMo1drXA61kEDwN3dtsZjwYNdcqE9ndivr5hOCRq74EAI5nU2hJhXx+tryYgICIggM61Vy8gO90DgbnqlwrvbPttRSGE6SNwxhy8L01yGzAZIxCii/FQxIjch8T79LqwfpnbbvIHYxSXgqNU7bGgXxi9NDa99LhFbSStxKz25uzEdPgxMS7Vg4nQXQqTAxd9R8ASjIfYgNpbwwVUA5q+wzVFlpW/8Kg0L4XeECsv0vUId8zyLNTS4OLQJODyBuOQgO1Z75GUhgW6nbq5zODB2dkioqZdBxqXI19KgKje36V8DRnjxOtiFZ7o4Zr4u5z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4930b6d3-67b5-4338-6058-08dd5abca3cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 01:34:00.4601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OTVrqKkjch3GCzaNRfgTx8Z17g67Npgo8lsEwQMNOp7bdLRRuNFppdyRNU2sm+bqtufWREjyf/HlCz3OzcatNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9276
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH RESEND] btrfs: Fix exception handling in
 relocating_repair_kthread()
Reply-To: Naohiro Aota <Naohiro.Aota@wdc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2519
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/D873FT11P5M6.JLH3TCARWATJ%40wdc.com>

T24gVHVlIE1hciA0LCAyMDI1IGF0IDU6MzEgQU0gSlNULCBNYXJrdXMgRWxmcmluZyB3cm90ZToN
Cj4gRnJvbTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0Pg0K
PiBEYXRlOiBXZWQsIDIyIE1hciAyMDIzIDIwOjEwOjA5ICswMTAwDQo+DQo+IFRoZSBsYWJlbCDi
gJxvdXTigJ0gd2FzIHVzZWQgdG8ganVtcCB0byBhbm90aGVyIHBvaW50ZXIgY2hlY2sgZGVzcGl0
ZSBvZg0KPiB0aGUgZGV0YWlsIGluIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgZnVuY3Rpb24N
Cj4g4oCccmVsb2NhdGluZ19yZXBhaXJfa3RocmVhZOKAnSB0aGF0IGl0IHdhcyBkZXRlcm1pbmVk
IGFscmVhZHkgdGhhdA0KPiBhIGNvcnJlc3BvbmRpbmcgdmFyaWFibGUgY29udGFpbmVkIGEgbnVs
bCBwb2ludGVyIGJlY2F1c2Ugb2YNCj4gYSBmYWlsZWQgY2FsbCBvZiB0aGUgZnVuY3Rpb24g4oCc
YnRyZnNfbG9va3VwX2Jsb2NrX2dyb3Vw4oCdLg0KPg0KPiAqIFRodXMgdXNlIG1vcmUgYXBwcm9w
cmlhdGUgbGFiZWxzIGluc3RlYWQuDQo+DQo+ICogRGVsZXRlIGEgcmVkdW5kYW50IGNoZWNrLg0K
Pg0KPg0KPiBUaGlzIGlzc3VlIHdhcyBkZXRlY3RlZCBieSB1c2luZyB0aGUgQ29jY2luZWxsZSBz
b2Z0d2FyZS4NCg0KU2luY2UgdGhpcyBmdW5jdGlvbiBpcyBsb2NhbCB0byB0aGUgem9uZWQgZmVh
dHVyZSwgY291bGQgSSBoYXZlICJ6b25lZDogIg0KYWRkZWQgdG8gdGhlIHN1YmplY3QgbGluZT8N
Cg0KT3RoZXIgdGhhbiB0aGF0LCBpdCBsb29rcyByZWFzb25hYmxlIHRvIG1lLg0KDQpSZXZpZXdl
ZC1ieTogTmFvaGlybyBBb3RhIDxuYW9oaXJvLmFvdGFAd2RjLmNvbT4NCg0KPg0KPiBGaXhlczog
ZjdlZjUyODdhNjNkICgiYnRyZnM6IHpvbmVkOiByZWxvY2F0ZSBibG9jayBncm91cCB0byByZXBh
aXIgSU8gZmFpbHVyZSBpbiB6b25lZCBmaWxlc3lzdGVtcyIpDQo+IFNpZ25lZC1vZmYtYnk6IE1h
cmt1cyBFbGZyaW5nIDxlbGZyaW5nQHVzZXJzLnNvdXJjZWZvcmdlLm5ldD4NCj4gLS0tDQo+ICBm
cy9idHJmcy92b2x1bWVzLmMgfCAxMyArKysrKystLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZnMvYnRy
ZnMvdm9sdW1lcy5jIGIvZnMvYnRyZnMvdm9sdW1lcy5jDQo+IGluZGV4IDZkMDEyNGI2ZTc5ZS4u
ZGUxMWFkNmM4NzQwIDEwMDY0NA0KPiAtLS0gYS9mcy9idHJmcy92b2x1bWVzLmMNCj4gKysrIGIv
ZnMvYnRyZnMvdm9sdW1lcy5jDQo+IEBAIC04MDk2LDIzICs4MDk2LDIyIEBAIHN0YXRpYyBpbnQg
cmVsb2NhdGluZ19yZXBhaXJfa3RocmVhZCh2b2lkICpkYXRhKQ0KPiAgCS8qIEVuc3VyZSBibG9j
ayBncm91cCBzdGlsbCBleGlzdHMgKi8NCj4gIAljYWNoZSA9IGJ0cmZzX2xvb2t1cF9ibG9ja19n
cm91cChmc19pbmZvLCB0YXJnZXQpOw0KPiAgCWlmICghY2FjaGUpDQo+IC0JCWdvdG8gb3V0Ow0K
PiArCQlnb3RvIHVubG9jazsNCj4NCj4gIAlpZiAoIXRlc3RfYml0KEJMT0NLX0dST1VQX0ZMQUdf
UkVMT0NBVElOR19SRVBBSVIsICZjYWNoZS0+cnVudGltZV9mbGFncykpDQo+IC0JCWdvdG8gb3V0
Ow0KPiArCQlnb3RvIHB1dF9ibG9ja19ncm91cDsNCj4NCj4gIAlyZXQgPSBidHJmc19tYXlfYWxs
b2NfZGF0YV9jaHVuayhmc19pbmZvLCB0YXJnZXQpOw0KPiAgCWlmIChyZXQgPCAwKQ0KPiAtCQln
b3RvIG91dDsNCj4gKwkJZ290byBwdXRfYmxvY2tfZ3JvdXA7DQo+DQo+ICAJYnRyZnNfaW5mbyhm
c19pbmZvLA0KPiAgCQkgICAiem9uZWQ6IHJlbG9jYXRpbmcgYmxvY2sgZ3JvdXAgJWxsdSB0byBy
ZXBhaXIgSU8gZmFpbHVyZSIsDQo+ICAJCSAgIHRhcmdldCk7DQo+ICAJcmV0ID0gYnRyZnNfcmVs
b2NhdGVfY2h1bmsoZnNfaW5mbywgdGFyZ2V0KTsNCj4gLQ0KPiAtb3V0Og0KPiAtCWlmIChjYWNo
ZSkNCj4gLQkJYnRyZnNfcHV0X2Jsb2NrX2dyb3VwKGNhY2hlKTsNCj4gK3B1dF9ibG9ja19ncm91
cDoNCj4gKwlidHJmc19wdXRfYmxvY2tfZ3JvdXAoY2FjaGUpOw0KPiArdW5sb2NrOg0KPiAgCW11
dGV4X3VubG9jaygmZnNfaW5mby0+cmVjbGFpbV9iZ3NfbG9jayk7DQo+ICAJYnRyZnNfZXhjbG9w
X2ZpbmlzaChmc19pbmZvKTsNCj4gIAlzYl9lbmRfd3JpdGUoZnNfaW5mby0+c2IpOw0KPiAtLQ0K
PiAyLjQwLjANCg==
