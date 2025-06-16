Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C3AC7EE39
	for <cocci@archiver.kernel.org>; Sun, 29 Jun 2025 17:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=n0+I7jf3QkRusXt0zFFxpWZmxoB6JXaVjVsCQDbbU+U=;
  b=K4C4alRtBIELCYAVHl8/tbSodt46f62Z22WDsTNp3XX5FMRslxhUtPgp
   0W5oJ3GGcVk2FEVgl/jBtFc7xzVeMIaTyBFN5CoCOdmZS70Lrrgz4W1eq
   X9vRRvxG+HJApMO0nQUA6jE5dmICLNRLQvouKwPPhJJLNmbxSrf8EUGbH
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@amd.com
X-IronPort-AV: E=Sophos;i="6.16,275,1744063200"; 
   d="scan'208";a="229472095"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jun 2025 19:22:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7C487E0157; Sun, 29 Jun 2025 19:22:57 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5F1A0E0131
	for <cocci@sympa.inria.fr>; Mon, 16 Jun 2025 23:22:19 +0200 (CEST)
IronPort-SDR: 68508b0a_olgPScPcU2zDCvYCQ//x+xhE2NNm/fh4vwA1tPgsEt6tfHr
 TEcl5Pey/kJdqZ6Rki3PLbYb7sth1LJ65O2pHWQ==
X-IPAS-Result: =?us-ascii?q?A0EiAAAPilBojz7cayhaHQEBAQEJARIBBQUBQIFBBgELA?=
 =?us-ascii?q?YFxUkABP1syB1EEhFGDTQEBhSyIdgOBE4Mok3+EB4FVgUA/DwEDAQsCRA0EA?=
 =?us-ascii?q?QEDBIIMgnQCi2ggBgEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQEBAQE5BQ47hXsNgmIBgSReSAEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RQCDV4BAR0BAQEBAgESEQQLAQUIAQE3AQQLCxQBAwICJgICMSUGARICAQEeg?=
 =?us-ascii?q?mABgiMEIyQEAg6kCQGBQAICiil6fzOBAYIMAQEGBATcG4FlAwYJAYERLgGFb?=
 =?us-ascii?q?IJkAYVsO4Q8NoFVRIEUASeCAUo4PoRpgzWCaYM+oShSeBwDWSwBVRMXCwcFg?=
 =?us-ascii?q?SAQMwMgCjQUHQIUDQ8BEg8EFgUtHYINgi1Pgh0fgXNwaQMDFg8BgiSBXhyEZ?=
 =?us-ascii?q?YRJK0+DIoEDfGVBg18eBnEPBlRAAgELbT03BgMLGwY9mQWDawYBAVI7ASsXC?=
 =?us-ascii?q?SY1gQJNkw4RkiuBNZ8iNAeEHoFeBgyKLZU7BhMvqmEuh2WQcSKLbIF5mwYCB?=
 =?us-ascii?q?AIEBQIQAQEGgW8NJoFcMxojgzcTPAMZD44hGSWDQoUTiioBqDglNAIBOQIHA?=
 =?us-ascii?q?QoBAQMJkCSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Cg6NC6snrFdiNcoSfSSeBjWSpxrzPz9zUX5bx0=
IronPort-HdrOrdr: A9a23:gX22kaC4ovbAvo/lHehAsceALOsnbusQ8zAXPh9KJCC9I/bzqy
 nxpp8mPH/P5wr5lktQ/uxoS5PwOE80kqQFnLX5XI3SJjUO3VHFEGgM1/qA/9SNIVyHygcZ79
 YaT0EcMqyPMbEZt6bHCWCDer5PoeVvsprY49s2p00dMj2CAJsQijuRZDzrdnGeCDM2Z6bQQ/
 Gnl7Z6TnebCAIqR/X+IkNAc/nIptXNmp6jSRkaByQ/4A3LqT+z8rb1HzWRwx9bClp0sP8f2F
 mAtza8yrSosvm9xBOZ/2jP765OkN+k7tdYHsSDhuUcNz2poAe1Y4ZKXaGEoVkO0aiSwWdvtO
 OJjwYrPsx15X+UVmapoSH10w2l6zoq42+K8y7svVLT5ejCAB4qActIgoxUNjHD7VA7gd162K
 VXm0qEqpt+F3r77WjAzumNcysvulu/oHIkn+JWpWdYS5EiZLhYqpFa1F9JEa0HADnx5OkcYa
 RT5fnnlbhrmG6hHjHkVjEF+q3tYp1zJGbNfqE6gL3b79AM90oJjHfxx6Qk7wU9HdwGOtt5Dt
 //Q9dVfYF1P74rhJ1GdZc8qOuMexjwqEH3QRWvyBLcZeo6B04=
X-Talos-CUID: 9a23:JPCxiG481zjqJWm6+9ssq1IKPdo7SU/m4nbUPhGUC01LSZCwVgrF
X-Talos-MUID: 9a23:mrru8QRd1ZjFGGJ0RXTHti5nP8NC252PN2ksrI9ZqueqJzRZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,241,1744063200"; 
   d="scan'208";a="119204814"
X-MGA-submission: =?us-ascii?q?MDFOZPHx0aJ9Qmstz5WOv7rMdVJZqNDtjhZRPB?=
 =?us-ascii?q?kM78nE5WRRMHAIdG3KK5MmkpRMQjAwzzWJ1dsr9Fp4uG6VKUlSivvpov?=
 =?us-ascii?q?bk5qdKgb0DBNbqvfeVsE/PJZ6B4rAuvn6r0ibiG3yewLzVvaI4CAN2Fk?=
 =?us-ascii?q?kgo7qKps0OBhyN0bTXWQt44A=3D=3D?=
Received: from mail-co1nam11on2062.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([40.107.220.62])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 23:22:17 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJYcTXRWFHHy0emeaFT4P5i0Vsv8I7WedUg6GaZ6Mb6fzGtbcco+hC3FwdipXYcV80Utk6A8637oVxQhuWwhyIvOlWTkqLAGRSrNm639scdQ74pR8K2qFUTZMNL1Nx2MLLVJRX4pa/3ap40GPy63SaCWoFftIgNsaja0FXC6QY9+Eot0bDIWJgqevO2O6OVdnYHxJ8Ys9tObBNT3BMDnKI3QCDsWgPkBsKUMITiUM8A9Xpwy+I2BcbULFhbPgzs27mx/nWCCWRRHhd2/bn73gTW5OoA5kXFd5ZVhoFikyltVYn+HVF+DK6WRJsSwDzLjn5xKQ0lPiawGmquL3EugRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0+I7jf3QkRusXt0zFFxpWZmxoB6JXaVjVsCQDbbU+U=;
 b=PhDVISIdrMzl4ihAeKYgCfW64LcRDY6V/zyYkD+TWVy3xiwLfK737vjGMowV1Mqd+EufP9aT0lEUSCBF3WQVvFwCcSFfTyg84DrmV53iIIiyukFV5pcBjT3cnQSyGAnOO1oxRT/1iSkWVlGp7WXYDY2qF1DlE9xf/wCbx/PBHV+x+DiCvnT+wY8XxCmaGBlW89D+WxKd8FhSJZCZ0UFZy0p1Hz9443gPdoeVkvczvbYbM1yJ9v3GWBYr0Q1OqrslnXnNtq8fen09+Mh/nOYm07/0u2qmQe+X8yx6mPS4np4S9F4Ek5ZBvtKSKld0IirjY6QpXbwzCFx28IoItAW4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0+I7jf3QkRusXt0zFFxpWZmxoB6JXaVjVsCQDbbU+U=;
 b=GassCnckSIoDm4lXTIkoHtXyyfiGOggsrx4vBtm8Z2pWz53xBtEksiG1Xn1pZwZIrtSq9eJrruKxOZzpDi9wbNIyIXBF9cMw4PwkyhlYLWeajL1swbe+9SBtVkMhC1owNGdsSPmc6ivBjoqif0GqO7Aw/KARF9f4DTRu8KG3/ls=
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SN7PR12MB6840.namprd12.prod.outlook.com (2603:10b6:806:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 21:22:12 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 21:22:12 +0000
Message-ID: <ba89d859-f132-4e7d-ba29-47331e02152a@amd.com>
Date: Mon, 16 Jun 2025 15:22:06 -0600
User-Agent: Mozilla Thunderbird
To: Markus Elfring <Markus.Elfring@web.de>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Roman Li <roman.li@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Tom Chung <chiahsuan.chung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 lkp@intel.com, oe-kbuild-all@lists.linux.dev, llvm@lists.linux.dev,
 cocci@inria.fr, Melissa Wen <mwen@igalia.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <e6656c83-ee7a-a253-2028-109138779c94@web.de>
 <ea0ff67b-3665-db82-9792-67a633ba07f5@web.de>
 <32674bac-92c2-8fc7-0977-6d2d81b3257f@amd.com>
 <da489521-7786-4716-8fb8-d79b3c08d93c@web.de>
 <8684e2ba-b644-44c8-adf7-9f1423a1251d@web.de>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <8684e2ba-b644-44c8-adf7-9f1423a1251d@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::26) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SN7PR12MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: f91f6eb8-3e97-4f22-08ac-08ddad1bdbba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXBjYVBWczIxRTF3bTJsRklpUlZjUmlXRjRDTXhDK3NacTRqNjEwWG5nd0xI?=
 =?utf-8?B?blkrWHNWNmNsOThSVUZ2ZDU4R3R3VjA4UUZDajNxRkFLb3ZaRWFXMlN1SUVG?=
 =?utf-8?B?Q3JoNTN4a25iZHUrQ214cUJpVzljNGk5eXJKZ3VNS0t2ZWdLT0o1SUFmT3I3?=
 =?utf-8?B?TWhpU3BWbG9pR3A5d1NoNnhZZThCdXc1VHdQMWUrUXNxU3U3b2NwZDJVZ1Rj?=
 =?utf-8?B?Nmd6cEo4bWpUMGtjbVdFcVQ5c1RyMEh5QXZ4VkdxamhIdkNvRERET2pQWVQw?=
 =?utf-8?B?Umh1N25TY3plSitRRVRNcU16OGFQRU1HRUlMRWlsWTNzbGJnUCtmVFRDOVA0?=
 =?utf-8?B?Y3J5elJ6MFowOFZoSlFpQnhmOFF0Q3ZpTlRDUnIwRW1WM3BTR28zODJ0L3dH?=
 =?utf-8?B?TVhRc0gvZFVWWEFMeVMxazB2cjJHcDhMcGhFVGhKbWt4Z0N0RTVPSzhXZFp0?=
 =?utf-8?B?RkV2RzdWM2J5SHRicU9kaWlwTFE3K3pMQi83TDVOcDJoZWpmcmNURnlQbEU4?=
 =?utf-8?B?cFBPK2RjS3lmZGltaWkxSEpDOGdGR1psSzRwcDYvak1KMHBFT2p5Z2xHR1lT?=
 =?utf-8?B?dmZBc1pBT0dLWGU0ZVpyOHpNNlpnOXNjSHhGMUM0VFhBUUR3NVpYLy9xU0VD?=
 =?utf-8?B?amhJcG84OFlueEdTejlOS05VczV0MDBTSjlBcWhMZ2FabGtjZGJoYWNpUDBi?=
 =?utf-8?B?NGRqWHlHaFRmWFBMdy90WEJvZ2Yyd1lYKzFDVzVYVTZIRkFTRUVkRmk5NzJr?=
 =?utf-8?B?RExLeUdobFkvNnI2cmlJZXJCM2dCVXM2RjNsQ0QvVkVwWXpiQnRGbFhMYmV1?=
 =?utf-8?B?NXkrMGQxMERMY3BQaTdKMElNOG0vbnhBb0FFK001U09xNVBxdytHbWZUMCtx?=
 =?utf-8?B?Rmh2TUQ3ZllWa3JoZE1hVVFNRUd1Z3kzd2ZlcUZMOVRmNDdGTjlxL3l0WDdH?=
 =?utf-8?B?UkZnVXdWNTE4S3VHdExDOEZ6VE8ydlYxUnl3NERPdFBwQ2poaXRGWGFucHIz?=
 =?utf-8?B?QlJJdXBWTVhBSVZnR3dzUUYzKzg1U21sSEFOTGUvcktaUHVnMlRxaU1ad29K?=
 =?utf-8?B?SHNQSG82NWVJTXp3bWZOS0YvM1RnUU93SHN2VEJzWTk1MlJHSlMzTEROZmNR?=
 =?utf-8?B?TkZLU1dOdyttdEdXUUp2bkkyN3JUMnJQNWJxSjl4Nm95RTVGWkxTYmFiOVpO?=
 =?utf-8?B?NjVQdnVwODk1WjNWdmdNaTZkZ2dLNFV4MXgrRkgxUHhGaTV4aVFQQjZVTFM4?=
 =?utf-8?B?SjVrZ08yckI1dWp1ajFmUzAyVi9mWlhmdGxRQ3RCSXoybmZrbFhlWXR3b1dv?=
 =?utf-8?B?QTN5bTQrbU5pc2NlVHk3b3g0N1RyMkgrWHFnYlhHWlJwamtoRW16azIyYk00?=
 =?utf-8?B?bUFOdldUWCtkTWdNNlV0MExoWWMyK2ovaENpR0FjYVBJYzM3Nlc5QjhhMm5N?=
 =?utf-8?B?YkZQN0puSjF6WTUvdnViVjA3Y0lJeGxhb2RJNXRkQWY0WnIwQ0FoOXgvL2Vw?=
 =?utf-8?B?b0lHNzdrTnRTcFBrclYzeVdBVVlMU2VINFJmZVZVY0RodGZOb28vVStsMkl2?=
 =?utf-8?B?aU1QSCtKdkpnUnRIVDFENElqenZwU0tqeFRNV0VLL0ZJaFFDYnhHMm9CcGs2?=
 =?utf-8?B?dEFRdktybFliMUVwRTB3bk1iSU1wUzNJNGx1bGFKWlpJMDlkS2J4OHlybXNW?=
 =?utf-8?B?NmRpQ21WcnJZa2pEMjA5MHlzaSt0WlFYL2RsVzFvUXF6NXQ4c2lySlc4N2RJ?=
 =?utf-8?B?Nnl2QmRvRURTT25Na3ptaEVFNDdqVDFWNDE0ZSt2Lzg2MEVKc3FNSDFoMjFB?=
 =?utf-8?B?TVZDaWtCU3liV3cyRGJVTmpKamYra1NxbG1jOThuK1Z6RXFuTVpnazhtd1hv?=
 =?utf-8?B?dDRmL2tDdkRQczZIUTdEejM0YnM1RTdHOTNhQWNCRFR5bUZWaVh0VU9KbWtt?=
 =?utf-8?B?N2dsQTQ0STZNQTU2U3JZKzdGeElRTkVteFNoRGQ1OFV3Q1M3UFlDbGNoRy8x?=
 =?utf-8?B?c2h3TmxVOFNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8476.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVRXTnJ6VEVRSG14cXJyMXhZd1M3WTZjazVaTzFaZElvcU1abmNzdzFiMGha?=
 =?utf-8?B?L2pOUXE3dUhSblM0WWowcXNnZFdwRUxia2tRMW92MHpwUG5hU28wZi9UdHNO?=
 =?utf-8?B?eUNzSHoxZXlVOFJNallLNHp0VzN3TmQrOVdFZDl0QzhxRXBJTlY4cDkxc2Vz?=
 =?utf-8?B?R0drdjZvODVHbjUvSkhRcFdxc2Rsb2twQThORUl2c05kZllVOGhrV3FXRElL?=
 =?utf-8?B?UHpzdXM1d01SVTVMc1BSZ0NHNTNYMU1qNC9yTHJFMVV5OGhLNTlQT2xSa0ZH?=
 =?utf-8?B?YjJVY0lOY1ZuZVYvOVd3VmpMek1sbENUUlhCT0VNTnR2dFBKb1VxYlk2Zjgz?=
 =?utf-8?B?eE1GNWU3Z3BMRmNTVG5JTTUxcTNzUGtQL3JERlZvUkRVTUVNVjhDWEFnZ2lO?=
 =?utf-8?B?MHBEK3FoV2hzdVQ3aFlON0FVY2dZRW9KYityYlJoMzFBVVVEVC9UdjAzMjdi?=
 =?utf-8?B?dXA0eUZPaldqWUczSzRQaVJMUmcwMzRtNS9mZ2V2Ri9ralpzeTl1M283NnVZ?=
 =?utf-8?B?d0MrbWZTTVBHR3BlVEFzdG9Oa0x5ZGxZMU83RWhMUWpvMjVqV2h3ZGVmcnQ3?=
 =?utf-8?B?Y1lINWJlVzd4YUFnTHZqV0pTZmk3UXhPckFtck5ydW05VExUSG9ITVd2dG8v?=
 =?utf-8?B?eG9pYi9MNTZLaE5aWHprUEcwakxCQkgvK1NvRjVlbENPSlp0akRWQjVZaktz?=
 =?utf-8?B?WjJyUWVDdzVqci8vUkRYdGxKRGRjaVhJWmhucFBSTXQ0WXovOUR2b0pOSWFH?=
 =?utf-8?B?VE1nK2V0R3NUK2ZEcUUxYmwybitBbDdqQVpKa3Fsb3lIN2lVbSsxdUlEd0hI?=
 =?utf-8?B?SEFETkhHWFE1RnRJdGhFT25vYlZpUFZJUXJKeng0WmVkM0R4cWx2NjlkUmM3?=
 =?utf-8?B?a3VxTVdkSndFRFpEdVNtMm83b1ljSjdFRjlaM3VrdTZ5VHlvbkp3YVA2cGps?=
 =?utf-8?B?NlVwRDFLZFFPcEpncklCbzNjLzBjN0VFY2wrTElUTXlUVnc5Ui85MEZtRWpz?=
 =?utf-8?B?d0hNQ04zN1NwRkc2aEJ1ZURrWERjQlNUcGtLN3NoWWVaMVlZSXBialJOdlVy?=
 =?utf-8?B?bTNIMVE1QnE4dUx3NW0rUDRLU01pNkE0UWIrdm1OUHJOV1BjL3Qxdm5ySnZH?=
 =?utf-8?B?VEFvSUtXNTJCTHFVV2xsRGhNSTZEQ3h0WUFJYlhsWWZ5NGRRZ2h5eXlwa0g2?=
 =?utf-8?B?UCtlTnhVY3V4M1laTElaaGloL3FWR1ZxNUZlNVBudStncENhdTMrVGxCdlE0?=
 =?utf-8?B?dXRMT0hUdkFMVUhDMS9XakFEVmhuclFkaUlUc2Qya0ZSLzdZRzdpNFNraWsr?=
 =?utf-8?B?RUdrakliMjBheDd1cTQrVGJEdnlqS1M0ZURBVzFwdElHVXJWZ21GdlBSZnho?=
 =?utf-8?B?NjlYcThnNlcrUnpOUzlqUXZHa1A0N0YyTld2azJIRFVpNElVeWhtUG5LWGoy?=
 =?utf-8?B?dnd6dmJ1SGIxOEtQZGRCZlJ5Skp4Z0pJbXlvNlN3dTNqN2pQZFJhdDlPZWpM?=
 =?utf-8?B?eGM4TGh1ekJ2bmNEUmFlYWg3OThMWFBBT3ErU0RBRHNpeHlhU1B1Z3ViMEgx?=
 =?utf-8?B?aExnUW1BUDRRQU1pS1ZaL3lZaDdaSUFLU1BpN1VFQ0ttaW1zaGMyYS9tSGl3?=
 =?utf-8?B?dE40NDdQU0NoSHA1WVRUcSs5MWZsQkRrMVVwRWlaeklRSHpGTVltRDFzdHps?=
 =?utf-8?B?QzNaM29uRkhES0tGN25nQWsxbjhTQTNVZVN0K1JZZTltcUNGcDhUazhYc3Rn?=
 =?utf-8?B?NEhSd1VuSnNwR1BNdmduWUMzMm0vamlEYlA5N1JnT0dCa0ZxOWtCbVRqVzVa?=
 =?utf-8?B?TlRJSVMwejFaY0xFb3RqNmxqVzlHcUtZb1dZdGpmcEczV2ZGbmEyWVR6T3pE?=
 =?utf-8?B?TmVsanZqbEhHRFlvS0thRThJdFZLc0tKajZWYzc1eDI3MzU4ZHNJWDE3MmhO?=
 =?utf-8?B?YUZ3cmVLL082cHVybmF2Q0dXZU1SWlkyeC9lTmZ3aVhuNXhUTVR2aFJZclRi?=
 =?utf-8?B?Wk5CTGxzbU1Cek5ldk9nOVd2ZHgxbktQcnM3R2pZazRLaXREQ1J1QVhCV2ZY?=
 =?utf-8?B?WkVnT0p6MHA4TlE1Qlh6ZHIvZkRKU2JyNlVDYzdWbFdlQUhGWEhDT1A2UDFN?=
 =?utf-8?Q?od+ykZKz9Qex0ORcWuyQNQFJ1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91f6eb8-3e97-4f22-08ac-08ddad1bdbba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 21:22:12.0761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3J63Nl9YFLxiaLTiWt3ROc7QennhjzmBYIbVfAQFkSdrpcvht92nZbtQM8zPm8qQzc29gQYQ00APIKTEGFmUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6840
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v3] drm/amd/display: Fix exception handling in
 dm_validate_stream_and_context()
Reply-To: Alex Hung <alex.hung@amd.com>
X-Loop: cocci@inria.fr
X-Sequence: 2814
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/ba89d859-f132-4e7d-ba29-47331e02152a%40amd.com>



On 6/10/25 00:10, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 10 Jun 2025 07:42:40 +0200
> 
> The label “cleanup” was used to jump to another pointer check despite of
> the detail in the implementation of the function “dm_validate_stream_and_context”
> that it was determined already that corresponding variables contained
> still null pointers.
> 
> 1. Thus return directly if
>     * a null pointer was passed for the function parameter “stream”
>       or
>     * a call of the function “dc_create_plane_state” failed.
> 
> 2. Use a more appropriate label instead.
> 
> 3. Delete two questionable checks.
> 
> 4. Omit extra initialisations (for the variables “dc_state” and “dc_plane_state”)
>     which became unnecessary with this refactoring.
> 
> 
> This issue was detected by using the Coccinelle software.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506100312.Ms4XgAzW-lkp@intel.com/
> Fixes: 5468c36d6285 ("drm/amd/display: Filter Invalid 420 Modes for HDMI TMDS")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
> 
> V3:
> * Another function call was renamed.
> 
> * Recipient lists were adjusted once more.
> 
> V2:
> * The change suggestion was rebased on source files of
>    the software “Linux next-20250606”.
> 
> * Recipient lists were adjusted accordingly.
> 
> 
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 ++++++++-----------
>   1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 78816712afbb..7dc80b2fbd30 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7473,19 +7473,19 @@ static enum dc_status dm_validate_stream_and_context(struct dc *dc,
>   						struct dc_stream_state *stream)
>   {
>   	enum dc_status dc_result = DC_ERROR_UNEXPECTED;
> -	struct dc_plane_state *dc_plane_state = NULL;
> -	struct dc_state *dc_state = NULL;
> +	struct dc_plane_state *dc_plane_state;
> +	struct dc_state *dc_state;
>   
>   	if (!stream)
> -		goto cleanup;
> +		return dc_result;
>   
>   	dc_plane_state = dc_create_plane_state(dc);
>   	if (!dc_plane_state)
> -		goto cleanup;
> +		return dc_result;

I think the two early returns look fine, but the rest of the changes 
reduces the readability and reusability.

>   
>   	dc_state = dc_state_create(dc, NULL);
>   	if (!dc_state)
> -		goto cleanup;
> +		goto release_plane_state;
>   
>   	/* populate stream to plane */
>   	dc_plane_state->src_rect.height  = stream->src.height;
> @@ -7522,13 +7522,9 @@ static enum dc_status dm_validate_stream_and_context(struct dc *dc,
>   	if (dc_result == DC_OK)
>   		dc_result = dc_validate_global_state(dc, dc_state, DC_VALIDATE_MODE_ONLY);
>   
> -cleanup:
> -	if (dc_state)
> -		dc_state_release(dc_state);
> -
> -	if (dc_plane_state)
> -		dc_plane_state_release(dc_plane_state);
> -
> +	dc_state_release(dc_state);
> +release_plane_state:
> +	dc_plane_state_release(dc_plane_state);

This clean was intended to be reused for now and for future changes, and 
the changes here remove the reusability. Also "cleanup" is commonly used 
already.

>   	return dc_result;
>   }
>   

I guess the intention was to reduce goto statements. If that's the case, 
it would be better to eliminate all goto and then to remove cleanup + 
two checks.

On the other hand, I don't see anything wrong with goto/cleanup approach 
either. Multiple exits in a function do not hurt if managed correctly.


