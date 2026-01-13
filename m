Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B905D2ED12
	for <cocci@archiver.kernel.org>; Tue, 20 Jan 2026 10:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=aGLAKKK0zXGzO+NiIeCvB2qY4/agp8GMk1nXi7aVci0=;
  b=dnm+EtedflhvqpCeoB7RDcZ9W4Y6bvVNMkbcn4UzHi/8RIyldbyn5CMk
   FyzXxGDzABHSiPSQm8RKUA7aP620f/XkvTtIGPUJ1Jk//ej5cfbYmvrMO
   v4PnqSl58/lki4XS+OZOvfmtuK59eyQwVwZOnvA8fDFGGSyB7MHUSqt3x
   U=;
X-CSE-ConnectionGUID: oV+kAxz+RiytfDzrI30heg==
X-CSE-MsgGUID: iMx6md31S9yKidL3P7wM+Q==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,240,1763420400"; 
   d="scan'208";a="259430524"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jan 2026 11:48:44 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id C9C2383A05; Tue, 20 Jan 2026 11:48:44 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 0624C82C13
	for <cocci@sympa.inria.fr>; Tue, 13 Jan 2026 11:05:13 +0100 (CET)
X-CSE-ConnectionGUID: 2SwjsVaiTjybFzfOjp0k7Q==
X-CSE-MsgGUID: Ej0380vKRHC2OAYqVufZ3g==
IronPort-SDR: 696618d8_9H8RSNCtYgkCRl1nLe6AZxmHUq3KWfyslvf7eqVbcuuyxMx
 GnQM2cWTI9ZYTpPMDWtsrANkY17+iIrbbcCy+fw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E9AADSF2ZpgSPJXShaHQEBAQEJARIBBQUBQIE+BgELA?=
 =?us-ascii?q?YFtU0EBRWAyB1EDhFWDTQEBhSyIfIQ7lAGECYFVgUA/DwEDAQsCSgcEAQEDB?=
 =?us-ascii?q?IIMgWBORgKMbiAGAQQyBw4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBOwcOO4ZPDYJiAYEkXgYJOQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RQCDV4BAR4BAQEDEhEPAQ0BATcBDwsYAgIfBwICMSUGAQoIAgEBHoJgAYIkB?=
 =?us-ascii?q?EsEAg6fLAGBQAICiyOBMoEBggwBAQYEBNwhgWYDBgkBC4EKLgGFbYJlAYVvO?=
 =?us-ascii?q?4Q9NoFVRIE8gwM+gkoXBBiFIYJpgiaBDowgh35SeBwDWSwBVRMXCwcFgSMQM?=
 =?us-ascii?q?wMgCi8tAhQNDwESDwQWBS0dcAwnEg8dFxMfWBsHBRMjgUIFARwGHBICAwECA?=
 =?us-ascii?q?jpTDIF2AgIEghB7gWYbD4cjgQAFLm8aDiICLhgiAgELbT03BgMLGwQ9kCqEA?=
 =?us-ascii?q?AErgU2mUKBdNAeEH4FeBgyKLpU/BhMvhASNE5lULodlkHMigjaJN4F6mw0CB?=
 =?us-ascii?q?AIEBQIQAQEGgW8HLIFcMxojUIJnEg0wAxkPjiE+g0KFE4oqAa9mPDQCAQEML?=
 =?us-ascii?q?AIHAQoBAQMJkh6BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vRAI5TzOahdFH1s5Q==
IronPort-HdrOrdr: A9a23:RwUJlqzP3ERf7ORj3By0KrPwB71zdoMgy1knxilNoG9uA6mlfq
 eV7Y0mPH7P+VAssRQb9OxoV5PufZqxz+8Q3WBVB8bEYOCEggWVxeNZgbcKqgeIc0aVygce79
 YDT0EUMr3N5DZB/KXHCUWDcuoI8Z2syuSTnO/bi01xRRx3cchbnn9ENjo=
X-Talos-CUID: 9a23:3kCIWW6h1bMNsOViBtssrnULGNsbe3zhzmbaDV22LmRxEL7KcArF
X-Talos-MUID: 9a23:F48d/AtJrWSxNTqqT82nqTM6b5cw/YeUKGtXtrw3oveZOx4rNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="135827009"
X-MGA-submission: =?us-ascii?q?MDFQ4aTccHgMb9Pj2xKXnabxcJCwRy3hO7kMna?=
 =?us-ascii?q?0GXQIz6oULmqkMYKYKzKEQwFzTpXT+UXLj1PXj6OSpM9ck27AfxwLcy0?=
 =?us-ascii?q?8V14Puws0rsRH68PoAKnY53HuWx1qlwfwCu8FIO/j5EFvsaQL2QkSaHr?=
 =?us-ascii?q?nZX467bF+rIsr2w33PzZak8A=3D=3D?=
Received: from mail-westcentralusazon11013035.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.35])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 11:05:12 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqAjrwiTmUahIYajBMJIhXW3GNnaEuDRevAiSHp5jMBGVzeLnYAfG9KpSJUgTlXfXNJYe1HQMvkcqaDV3PU83RSOqvP25DgAi7QKfS82HzA3YU+VslEDKnH/0OUXQfGUV1s6z1eWpL5K6ztPCW+7kkopwZN5yLbcD8t1aCUwxhJFIc2km7DftbpUqOg95syfziHoTMQ5tVJEuNTGdQlghoJuqzabAtL6XVRyQwVhTVPK/igMy+4GWIEdkmDZq/zHZEuMfl9y7wtzQNWqOthAi1QKGHcS2WcoZOTNVtGZNw/ztDjWqgq8uypbOt0frmn0MeWAA1fh3DVHJ7VbA97eBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGLAKKK0zXGzO+NiIeCvB2qY4/agp8GMk1nXi7aVci0=;
 b=KUDUncJnaoQquJuYIvuP/S83jgiQKx4Mgf4vee8T713/Kr4cP5hC310TCrjN6Y0IGrtWa4m38evRbz3qG5NaV4qdR0FlXRaCB/fOUvmgZsk/Pp1mcYOfAq27AhoQgDcsIKuIer/Q6tDoQ1NQ79TAbzxEqnI5QS9E9MBIKpOJOTU5S0L29hsUGyeU4BXVNcYcxoDuE9mzvCx/Ri98YO7STWtU2L4fFnFpnKfg7Dtua5nWV8VMaO5B9LMMhEi6ItaDYkOEQDYun+Ek2xaCYJZziQc+KmUHEugupdihszXofMsU0chGCRgwaw5r5cTPva6Co6a+H5jV6XvxPYEQLzx0hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from SA1SPRMB0013.namprd12.prod.outlook.com (2603:10b6:806:22b::6)
 by MW5PR12MB5651.namprd12.prod.outlook.com (2603:10b6:303:19f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 10:05:04 +0000
Received: from SA1SPRMB0013.namprd12.prod.outlook.com
 ([fe80::fc4:fa00:c2d9:456a]) by SA1SPRMB0013.namprd12.prod.outlook.com
 ([fe80::fc4:fa00:c2d9:456a%5]) with mapi id 15.20.9499.003; Tue, 13 Jan 2026
 10:05:04 +0000
Message-ID: <7d25b66c-069f-46a3-9bb8-e6732745ab75@amd.com>
Date: Tue, 13 Jan 2026 15:34:57 +0530
User-Agent: Mozilla Thunderbird
To: Markus Elfring <Markus.Elfring@web.de>, Can Peng <pengcan@kylinos.cn>,
 iommu@lists.linux.dev, cocci@inria.fr, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20260112032116.49781-1-pengcan@kylinos.cn>
 <34ed442d-6ebd-4907-a77c-2c08db799411@web.de>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <34ed442d-6ebd-4907-a77c-2c08db799411@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::10) To SA1SPRMB0013.namprd12.prod.outlook.com
 (2603:10b6:806:22b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1SPRMB0013:EE_|MW5PR12MB5651:EE_
X-MS-Office365-Filtering-Correlation-Id: c71d1bf5-793f-49d1-44b3-08de528b38ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjlqbDA3YmxiaDVvNGNwdE5ab2pMYWxvUEl2ZUEzczBFQ1VGaDRkOCtZNzlp?=
 =?utf-8?B?dVRTYzFSYWlVdkt3akZpcWwrRXlPRTBLQ2RreGk4RHVwekdwTmc3bDUzNStx?=
 =?utf-8?B?MXh3WnNqbyswcWZ3V3A5Yit2amtrZGFjUndPRHV0aEM3dGtiVHI3SVAyWTJ6?=
 =?utf-8?B?bmo1MVZhcURON21jZ2xBdlVobUFHWTFjVVR1UU0vbDRENUdLQnhRSnJvN2dy?=
 =?utf-8?B?UlpSZzVNZ2NiUGdVOStmempRdmFXQ2Uzdk1vUHQ0YWw3Uk1sc0JoSEZ0MjA4?=
 =?utf-8?B?WHdZZkFRRTE4VllObVIxOVlmTEJ3MFhjUHpLUXBwODNqQWJQVFBLSmk2aUtR?=
 =?utf-8?B?RTBjZUhhOGlCNS9HVWdjbE5nUzViajZoV1p5Z1NVSThNaGVwUCtPc2dpeFAr?=
 =?utf-8?B?V2p4d1lMdTliVHFyanovTWZTdmFpbWVCeS9BSUtTYmc0bkJmM3lzTU5EalM2?=
 =?utf-8?B?RmdwR0RmV0xpMktUREZ2SjlIc3NhbE9xTU81MjI4elR1SFh5VWZqalB4RzRh?=
 =?utf-8?B?eWxxS0ozSXdCMWRhelBQZ0F4SlBDQm1RV1FSajdiVzJqejZJSTFMbVFJUHVq?=
 =?utf-8?B?RG9BSDNPbnhseTJjQzVCVEhlNG1iZ1ZqYkRVUkNLSmNvZ01mQWRKQldGbUk0?=
 =?utf-8?B?NktPSHprdGlQb0VvVmYrOUpqUTlwZVJOeEs0bE04UHJqenhnYjk4MzhwYWNl?=
 =?utf-8?B?cnlVcmFHb0ZQMXJZSHg4S293ZUNxaHJpVm5kNEdlY0p0NzZIZXdVMWZYdHo2?=
 =?utf-8?B?VHVhZHJJVmdmYUFMQzNiNTE0cFB5c3B4bVowZGVwZkVveUUwUmN1ajdnSnNN?=
 =?utf-8?B?ZURZaUFZSXRBQjhDZnhWbC9PS0JsWTdyMDFnVEVPVnRFeXh5Vzc3YmxxQ0pm?=
 =?utf-8?B?dFVzYlYyMFdhTGgwRG1GdU5CbjRyS241MDFXd0dhVnNrTUpjc0U0dk90MCtz?=
 =?utf-8?B?UHhOZ0xDZTFHc0g2T3ZDaXBSTlFVbGxSdU10WXIwQ3o2WlJjQ0p0L1VxK2Ur?=
 =?utf-8?B?Rmp3MkZPcHYzd1FramVCM2gvSWMzSGFvaDFXZ3hNT2pyNGZBQjUzMUU5RXVh?=
 =?utf-8?B?YUE1bE1yK2ViZnlOdEdjNnlkSitzQUxRK0ltMjM1YWt5andaeVA1NU1mcGoz?=
 =?utf-8?B?WS9BS01DbG5DczY1YldGN0prUExabWpJNHc5bFlWZVArMnBtMk5FbWZHaXZR?=
 =?utf-8?B?bks5SW9uczRNMzBTNkxMcStaeC9ZNDQxMW9HWisrNkdvNU8vbzlxVVpVaGpY?=
 =?utf-8?B?elNnUjkxSW1sOXE0RUczR3lqTjc4Z1k5ZTJacGIxY0NhMXowZE5KNUhpNzdP?=
 =?utf-8?B?TFlaaE1NRW9PT0UwVVZiaURvTjdOSmpnVmdWUit3cjgvaWV5R2xGNlNVS29L?=
 =?utf-8?B?c2RPRUtZazc0UWtnTmZGZ2hMUDkzTjUydEJkYzZqZmxCTFo2d01kR1UyY3FX?=
 =?utf-8?B?UEQ0bnJRZW1MUHllS2xqS1BKK3FGaUlxK0ZKSXhBOHVRNWgyQW8vOU51bktt?=
 =?utf-8?B?MFA1VjQ2UEZZcnlzeXJvR2M1K1owRXdFR2J4OWRVN0pBbEgxMkdvWFA5MW91?=
 =?utf-8?B?M2ZQbmtWbUowRGZMY2tRTUlaVDE1OWVLZjc5NzF3Rmg4Mk5NcUxvQ2hsM2Ft?=
 =?utf-8?B?REhjbmFDL1dKQWcxN083N2pUMXNYR05YT1JPemw3L0RRZk95NkpuZk9zelFl?=
 =?utf-8?B?NTB0NkoyQkR5TEVmQ3A3aDM5MFVTWCtTVWs5U0s4djllUjQ5SmdQRTlMc1hB?=
 =?utf-8?B?Zk14ZnYzVklCYVFWVVVycHRKcFE2anBGcTVhRTh1NkpMWVpHdG1YKzRTZExB?=
 =?utf-8?B?d1ovU0RlcW9sVHdkSXFiSG1lTFl5TGRUKzN0cUN3UzlxMHB2eWVlTjNvS2FG?=
 =?utf-8?B?MGd6eGkza05lMjcxeXJFRjhuQVY3SExVSWdVNDJsR203czJiMCtnSjl4YW9G?=
 =?utf-8?B?T29iTm9Ld3ZSMFFTRTZmS3E5WGtzZTh2b0tHL2YxYW1sT0Fqejh2Rm1xNXFL?=
 =?utf-8?B?SGVJUlZueURBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1SPRMB0013.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTNZQ2h0TFVWUkQrYmp4SDRvUWFjMU9aN001RU9JZ0F0b1dCZGt5WjM1S0ZV?=
 =?utf-8?B?d2NEVW01TkdVRnBDQW9TazlFVVYzczExQ2p1ejRSVDJ5S1Z0dkdGdGtLUnRj?=
 =?utf-8?B?c0t3azlHWGNCNkJzUkl1WDVjcFgxRE92TnZyK2htZE1SRHJWZ3RFTGh2Q0xK?=
 =?utf-8?B?eUpjN3BFTjhxTUxxWUlJbFB2dlMzRzlpWC8rQTRDWjNxZVNyNDNYOVlxSnA2?=
 =?utf-8?B?ZmFUejZKeGZkQXZneXNMYTNKZVRiV0g5L0pzMXdxUTB1bStBenk0UDRDMW5E?=
 =?utf-8?B?UEhUcFl4QlN5bkNRUmVvMzZWNXZHZFA0bDlkeXlUaURtV2xaYkx4Ty9tSEJ3?=
 =?utf-8?B?dkNHdVZQZFZHZlBnQXRkemVGdUUvcTN6aWd0cG5nRGhQUEZTZVkrbk16K092?=
 =?utf-8?B?Um4vNTZRYWw0LzllRXh3TXhIN1RoTDl4T2tjRExYanYwL2taQmJJaFdjT01r?=
 =?utf-8?B?QXhGVkpnenNtS0JHM3VRaUlFajIwbEZ1TGNzTFdVVkJTRXVwVXlpQnVDMFFI?=
 =?utf-8?B?czQ2bGNlc0JIZzFXZWdtMlEvVlNjdytBZjQ0UnJhWENlM3dlckduVlhORmF5?=
 =?utf-8?B?bjl6dzVvRW1UUFFCbm8vUzYvL0JhWmFZRDhvRXd4T2ZWZ1gxY1RtRFpibmRC?=
 =?utf-8?B?SjZNZGFRc0lIeXJUZ09teXpHc0hjWGZwV2h2WTJpckdueTNaR2huWmM4YU5B?=
 =?utf-8?B?a0lnRUs1ZSt6aWpxZCtBalpFa3NMY2tlUngxSXhxN0tIMmV5QXJCQmFQK3pq?=
 =?utf-8?B?Rmh2eStyVCtBc3J1eDVwN3hFSHUrc3RqV1pnZlJ3WFgxazdCODFYN3R6b2cz?=
 =?utf-8?B?NTNnOG85QUY5K1NsNmR0RVp2WUhQR1RmUmZTQzc4ZkEyaUtuSFJYSlRhaVFr?=
 =?utf-8?B?WU01aldhOTlEaFdMTmFYK3BHL3M5TTF1QlpwazZlcmprVVlPWGVqYUNoSmNF?=
 =?utf-8?B?VGJSbDhhN1dGcVFjM0o0dVhHNXFaMGI5VEhCOUFxZEx2RER0dTV5K080R3Fl?=
 =?utf-8?B?UFBuaFhYd3hrVlFpQkxSbTNSR0p4aWxuSEFIbmtCc2pOYjVWeVE2endCQVdy?=
 =?utf-8?B?S2JoeDJYSHBPMFI3K3d0SW9GL1N4ZHZBMVYyUTVlUmVwWXFPQ1djRkNsL2t0?=
 =?utf-8?B?N1BvQ0lhUEZHUFJxUGs0T0t5U2Z6SnBMb0JyWlBYejVTU2RuWjJiRVNGZ2Ji?=
 =?utf-8?B?YU9KdFlad0FmSTJOblRyb0wrOHZ5NzMwS1NHcUlSY1cwOS8wQzNSR0U4WS96?=
 =?utf-8?B?Y1hZWC9RU0hKOHBCZmFTN0Q5WlEyUmtNaFNJZGZ1c1pXUU9XM1VWR0ppNCtn?=
 =?utf-8?B?K3lYc1h1OVo4ZUJoZCtTQVZVVUN6RnQrcFJwYmpuZTB2TnF0TkgwUy94S3Mz?=
 =?utf-8?B?bTdIQllmempNSkw1anFLT0VuQkFkTGxvYkUyV1VxYml2K1ZvaWlVSXZoaWlE?=
 =?utf-8?B?SjQwMUY4MXVaOXNyU01FUFlrNGZVMkFnU3VMcWRQWitRa2Z3Y1FOTWxuc2I2?=
 =?utf-8?B?Ym93OTV1QVo4UFdDd0ZUQS9TMnZ3Y0pQWFUrTWFSTWdKREU2MnBLSFBGNUhL?=
 =?utf-8?B?QlJxc0hwUnFnR1hUV2phcUlCcFVVUlIxci93VDBZcU1Ea0hTRnhtalRubUdS?=
 =?utf-8?B?bjRUOHBlRVpNM1hsM0VLS1dUcnVTQTMrYTNLKzZXSVNtdFBKZkt6RDlkaWZs?=
 =?utf-8?B?M2xTNWtwcm1EbW1ENnhXMFR0T0xMd3hIYW1aZGRNYlkxQ2xiWVNnSjBlc2hP?=
 =?utf-8?B?L0tPTkk0TS9pZUZlVFIzNlNZYW9MT2l3bUI4YXZmYzkxOG0vUmNjdlc0ZGF1?=
 =?utf-8?B?ZHRFQVgyRVA3eVQyQ1MxeFNrWmdpU2prM2xvT0xHTFh6bWFpQjg4ai9uOVpt?=
 =?utf-8?B?dm5SbkVMK01ZMmZ4OERPWDBSZDVsSnNPSGlDWTAyc3RkVkRIelNjK1NFNDZQ?=
 =?utf-8?B?VlpnQVM5YnJsanpUQTUvdTZFOTl2T1NGNjZ0ZDc4S2Rabkdka1VFYnNxYmQx?=
 =?utf-8?B?RlNnZldjTHBpNzFQd2NVNGMvVlkzb1I1YjJUWURFcDBQR0FGbmk2NWtaTDVF?=
 =?utf-8?B?eEpqZHhYc01oUTYwY0E3b21adEI1cWdaeWdmTHg0RDZnV3IyTkRLZSs0SVdC?=
 =?utf-8?B?RVRKMUlzdTNlQnZ1aUUvYUdTWGRKbkdxOWFka2xoZHBidlpsSlFsOTFIRGlM?=
 =?utf-8?B?RE90aVgzNmltT1JMN3l0OG9LWC9paWF3RHQ1V05WTXZ2cThxWEFhV0plb2xq?=
 =?utf-8?B?bDdJd2pESHY4R3dGRjBSejd2YUdoSmxMUlk2TWZsdk1kNGVLTWM0WGlBdGsw?=
 =?utf-8?B?SXpVcStmUWU0QWpXMjVHSzFJNklDL1FNRVpXTEVLaURNamhZZ1huQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71d1bf5-793f-49d1-44b3-08de528b38ea
X-MS-Exchange-CrossTenant-AuthSource: SA1SPRMB0013.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 10:05:04.5028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Js9T3X5g3ExUVm/fi++P1SnZrZU39LO5mM9uHwjD93xbsmKswXB9qklfdUvjHQYCz6EsH05wrwtFbqES/NIYhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5651
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2] iommu: simplify list initialization in
 iommu_create_device_direct_mappings() and iommu_group_show_resv_regions()
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
X-Loop: cocci@inria.fr
X-Sequence: 3285
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/w_wGM7kHtwLe_EY6ftnCOw>

On 1/12/2026 6:00 PM, Markus Elfring wrote:
>> Changes since v1:
>>  - Extend the cleanup to iommu_group_show_resv_regions() as suggested by
>>    reviewer, applying the same LIST_HEAD() pattern consistently across
>>    the file.
> 
> Thanks for your interest in further code adjustments.
> 
> * I wonder how they fit to the feedback “Applied, thanks.” by Jörg Rödel
>   from 2026-01-10.
>   https://lore.kernel.org/lkml/stpavkxy3sbevk7zmt4kxyecqy5gc6phubvcfutbtnuk7vphlh@a7aimtvk423i/
>   https://lkml.org/lkml/2026/1/10/235

Right. Patch is already applied. @Can, Please rebase patch on top of iommu/next
branch.


> 
> * A shorter summary phrase might become more desirable for this patch variant.
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc4#n687
> 
> * Will development interests grow also for another transformation approach
>   like the following by the means of the semantic patch language (Coccinelle software)?
> 
> 
> @replacement@
> expression e;
> identifier i;
> @@
> -struct list_head i;
>  ... when exists
>      when != i = e
> -INIT_LIST_HEAD
> +LIST_HEAD
>                (
> -               &
>                 i
>                );
> 
> 
>   I determined that 175 source files of the software “Linux next-20260109” contain
>   corresponding update candidates.

Interesting!  Thanks for the stat.

-Vasant

