Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28CFCAC5BB
	for <cocci@archiver.kernel.org>; Sun, 28 Sep 2025 13:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Vas0fL30w6ZfUzmoHh6sgiioSdO0kLdEwYJ3Crcs4is=;
  b=Eqdjfqx7vi03xSdpvop828AcjM43K1aUBBOp9HS3W03yczhNC9WXqPnq
   7oF68Sc/qiBLA+RdNG1sF5J9TuPOWL4pa8TII4I29Qejri5+X9Md8/IBP
   mJ3Yb5zUsdH4mqc9Lvj3woVXe7nXK1ykbCvcz1vhsBwWNAi4/MqoT1snD
   s=;
X-CSE-ConnectionGUID: zWbXhsDxT42P2MP40Wa7xA==
X-CSE-MsgGUID: GIp8ZD4DQDSRUpXo5D2v1A==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@Nvidia.com
X-IronPort-AV: E=Sophos;i="6.18,299,1751234400"; 
   d="scan'208";a="241375731"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Sep 2025 15:36:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BFB72E0B0D; Sun, 28 Sep 2025 15:36:35 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 61846E0171
	for <cocci@sympa.inria.fr>; Sun, 28 Sep 2025 13:40:32 +0200 (CEST)
X-CSE-ConnectionGUID: j4FodinqQ92kMbdzNq+CFA==
X-CSE-MsgGUID: b6rxEZZ4R++CZPbM6VU6Zg==
IronPort-SDR: 68d91eb0_IJB8m7cocEbNBG+R0+jR7erbISqfiZz2L/AjM1GWBsc66ak
 lkUwrumCIt5W6jUVkmJ6a6xfplUCv4LCnU4yPPg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EEAADIHdlojz3JayhaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYFtUkABQVsyB1GEVYNNAQGETV+IdgOEO5gKgVWBQD8PA?=
 =?us-ascii?q?QMBCwI9FAQBAQMDAYUAAoxHIAYBBDAJDgECBAEBAQEDAgMBAQEBAQEBAQENA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQEBAQEBOQUOO4ZPDYJiAYEkXkgBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQINXgEBHQEBAQECARIRB?=
 =?us-ascii?q?AsBDQEBNwEPCxgCAiYCAjElBgEUAQEegmABgiQEJCYEAg6nQQGBQAICiil6f?=
 =?us-ascii?q?zOBAYIMAQEGBATcHYFkAwYJAYERLgGFa4JkAYVsO4Q8QoINgTwLgng+iB6Ca?=
 =?us-ascii?q?YImRFKEDoIohD8BhTuOM1J4HANZLAFVExcLBwWBIBAzAyAKNDECFA0QEg8EF?=
 =?us-ascii?q?gUtHXMMKBJlhBSDWUUrT4IccoEAdFdBg1MRDQZrDwaBFRlJAgICBQIsFz6Ba?=
 =?us-ascii?q?wUBHAYfEgIDAQICOlcNgXgCAgSCL4ESgg8LQAIBC209NwYDCxsGPZgzYgiDa?=
 =?us-ascii?q?iOBXy8FKjqSf4MYAY8Li32VF4QmgWSKOpU+Bg8BAy+EBI0TmVQumFgijWaWG?=
 =?us-ascii?q?YR1AgQCBAUCEAEBBoFoOoFcTSMVO4JnTwMZD44hDA0JHINCgT6NfwG4VkE0A?=
 =?us-ascii?q?joCBwEKAQEDCZIegUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:CbRyH6z1XUgUHwQQOwTYKrPxwOskLtp133Aq2lEZdPULSKGlfp
 GV9sjziyWetN9wYh4dcB67Sc69qADnhOZICO4qTMqftWjdyRGVxeRZgbcKrAeQeBEWmtQtrJ
 uINpIOc+EYbmIK8/oSgjPZLz9I+rDunsGVbKXlvhFQpGlRGt5dBmxCe2Om+yNNNW177NYCZf
 ihDp0tnUvdRZ1bVLXMOlA1G8z44/HbnpPvZhALQzYh9Qm1lDutrJr3CQKR0BsyWy5Ghe5Kyx
 mMryXJooGY992rwB7V0GHeq7xQhdva09NGQOiBkNIcJDnAghuhIK5hR7qBljYop/zH0idirP
 D85zMbe+hj4XLYeW+45TPrxgnbyT4rr0TvzFeJ6EGT1PDRdXYfMY5slIhZehzW5w4Lp9dnyp
 9G2Gqfqt5+EQ7AtD6V3amFazha0m6P5VYym+8aiHJSFaEEbqVKkIAZ9ERJVL8dASPB7pw9Gu
 UGNrCQ2B9vSyLVU5nlhBgv/DT1NU5DXituA3Jy8PB96gIm00yQlCAjtY8idnRpzuNOd3AL3Z
 WHDk1SrsA8ciYnV9MNOA4/e7rGNoXse2O5DIvAGyWRKEhAAQOHl6LK
X-Talos-CUID: 9a23:mW2NB2+gkRLF0aE+vnmVv0xINMcpc3vE9SaKIGqyBXRPUf6+Z3bFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AfGCJwg1Y7qR/VBaTCYDElql3UjUj6fq0GG0/o8k?=
 =?us-ascii?q?8+IqvBxR6HmmjsWqFTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,299,1751234400"; 
   d="scan'208";a="241370963"
X-MGA-submission: =?us-ascii?q?MDGaLUzxablnynI2lAUBAgm+QcfUdoPdjhavOB?=
 =?us-ascii?q?zevQJSsjKUmXYB+GXAntLZa/5jtUr1iwIXgbcYzc0loZwIW2lQCLd1TK?=
 =?us-ascii?q?5AzQ/OIYsvpt+Nh3S/57tfORiDFQOmqCEofIPmELftwfGgJzGL4vWokp?=
 =?us-ascii?q?j2gTQrmW1kvHHgdj7JZZSsow=3D=3D?=
Received: from mail-northcentralusazon11013061.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.61])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 13:40:31 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpsRxsBtIaT3bcVNI93rMwuR2c/n01X+C3/XyRs2/ECGMlzTE8KNAXGEX6FKWdFHP26S/UgT60AC12gZSvOoXTsEMJ+bsyU4cqrkZeYZ55FJQmOva4m4x6PPo4K/3JGz9LJtHO+9Kp6GtY8wxbf2hzsoU73Oj4IF4YY7h5Tgj/nt0FzXe/SJHf4l6MYlFSO7+WQUn4jU3kX3ELwyOIgW9y/tGy4FllX36OzTmwRsHzSxYHlEutoRGPPHumQ6N1iV22BO5/6N0AZjzDKE5rML4iL4RoxQDXT+cffupFY78yNCcrRbT8D1aD7wPxby+qyeWGGZMbfstHb4x/30GIJsow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vas0fL30w6ZfUzmoHh6sgiioSdO0kLdEwYJ3Crcs4is=;
 b=eTEvUGOCgD24XPNp8TG/xtDrxZBIalV4YPsLAfiaIMKqT/1fU7FFew/XJGTgE3/oLUll2RC2oiOGiITsi1qkQT2q41jl2oix9vL5UWCNls1GaFC9pCOx0aHm7rLJzgKtZueI5n/NV0twKEJdhaG2wt/BWw12nDPJ/raWDFAX708PAZdzT2wHbsEjxgJPzLTKXhLRkjHH03YV/I0qU9gAn5mH/yvZxI5Rj4pN8awSR5gy/9bN+8u8qGBxsqIKXUJppFoa2nGu62HVp44PnFhjjhKwnyJQ+BfvlXuUEnixd581jbpoFFhXyUMNwbH3tXdTV4Nf2cZkzBkueIKJ0NgN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vas0fL30w6ZfUzmoHh6sgiioSdO0kLdEwYJ3Crcs4is=;
 b=eMipnw4i0blyXTyJgYkIG0Im56ipToRtleTTTGlw3E3TaSrZtqGoTn3W95QMuoCEJSH9kAkpjshHA1ik54k++jDYq/5iJ6pCYRQxrGhkXRj6kerzr98vqSUcHDVZa3Offn4GMol41FnmIph8PeeIsONADIOU44IU94dt/9Lkig2bvZLEk2DrTC6fj2OvW4ccxcYGwyoSFykyb/u0/DPu/xuIU2H1eFmgMdSRbui5jF2XNKXtLZkpoaC+8SE87/TsTV8Y+nWNNqTCPJBbjx9dE7Ev7nKcbQnSswBNDcWwx7dos17ZoF5T2zGPgmzxwpnBOZbhVj6rbAcafCt2GTonMw==
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA0PR12MB8861.namprd12.prod.outlook.com (2603:10b6:208:487::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Sun, 28 Sep
 2025 11:40:26 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9160.015; Sun, 28 Sep 2025
 11:40:26 +0000
Message-ID: <48228618-083b-4cdb-b7df-aa9b7ff0ce92@nvidia.com>
Date: Sun, 28 Sep 2025 14:40:19 +0300
User-Agent: Mozilla Thunderbird
To: Markus Elfring <Markus.Elfring@web.de>, Tariq Toukan <tariqt@nvidia.com>,
 cocci@inria.fr, Alexei Lazar <alazar@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Nicolas Palix <nicolas.palix@imag.fr>,
 Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
 <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
 <48a8dbb8-adf1-475e-897d-7369e2c3f6eb@web.de>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <48a8dbb8-adf1-475e-897d-7369e2c3f6eb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA0PR12MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: c20b565c-c331-4729-c760-08ddfe83d106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXppbnkyMytLc2t1NjJyek8veXpWZVloSkVya0YwVWx4bG9mUkZpM0JISUM2?=
 =?utf-8?B?dGdBU0dYSFhMWUpidzFScGZpTENhYkRycmUvTFhnL1VtRldwSlQxZk9GOUxI?=
 =?utf-8?B?VEI5d2dQa25nMjFqR3FzTmJSVHFNMTZwN0JBUFFoTUJrR2E3QkYxZ1hUam91?=
 =?utf-8?B?U2V5VmJ4cG1LV0c3YzhKeGFTaVhmb1BIUEMrOHRhQWdkS0daak5lY1kwZjZw?=
 =?utf-8?B?RHJydEc2bjg1STIrR3RZb3V3OXhDZS9WZitRQ0JwTlh3aXoxN1FoUjhTNmVE?=
 =?utf-8?B?OGRTSElvamgxSkRMcis0U2hrMThUemNTcVlES0UwLzR0dXpNamV3WnFoMEhT?=
 =?utf-8?B?WEgzSFB3aTNlZGZXbzF5bDF1cHBHTm1PT1MvYWZlSk5NRnFJQy9iRDVQaDZv?=
 =?utf-8?B?NzNnNmJYYmlEcHczYy9kMEtCSTZQRDRqaS95V1lYQWlvNC83U3FjMlhxSURa?=
 =?utf-8?B?TzVZWHN5UjhENGlaUzBGRTBMeWh2dFFXUDdyOTR2bDcyaXpaK1BIaHhyUncr?=
 =?utf-8?B?ejdRRVRwZjNvczZhTFpROTlOcmFtYjMwZ1dPYkd1ell3UVZmZWJUSURnYi9H?=
 =?utf-8?B?WjJqS1c2VzA5Z1ZNVytoeGIyVGtVUXVubk0rdytyaENXbzJQS1h1SDNBRjAy?=
 =?utf-8?B?MUNsWGZFNEJnVUUzTTA1K3BXU0NIaTFVYkpsbG5pdWVnU2Y2aktQWG5yNVFH?=
 =?utf-8?B?eEsrZGhMNGZvMExmbzg0MkdWNG5uaVBOTndKM0lMNDY5UFpMa2ZUMFBWZW0y?=
 =?utf-8?B?MkJKeExDV0NhN1RieGllR0x0QnN4aDJ5TC9pb2VjZ0NXZ0ZoNkUvOHJQd05h?=
 =?utf-8?B?T0dvVXZiWU5MNWZPNWEzY3h4eWxmbU1uRDZVa05OeGZFeldwby8vSDZ1bFJh?=
 =?utf-8?B?NHVlQ1dWRDdsMk1NSXZkaHZYUmdwN2laZTFCTXB5NzVJVHc0dGorNzJwVDJP?=
 =?utf-8?B?RzZqWU1KTGUySDljS2FPNFNucnE0TG1QLzZUMXd2RE9BQXVtM3pLSE16OGJE?=
 =?utf-8?B?ZWNGU0hqdUlTOXNzWGlQTW52YjBXYm1SMHowUXFNWUdEK2lZaHJ6Zng0cGly?=
 =?utf-8?B?UmF1Vkw2SFdJd25UNTgwcFRtemF0RjdIQnZkcjJQaHVKTXZTd1VzelJGRWhh?=
 =?utf-8?B?Y2lYZXljcW5TTWVsbTZrVGErYXE5ZEFmSDRYYWJjTjFpTWlTdVFHVzh2ZHNV?=
 =?utf-8?B?QzQ3ZkQwNXV2THM3SmFQZEV2WEx6Q0VxN3RoNWQyWkVFRG5oQXBMdi9jWlBL?=
 =?utf-8?B?K3ZENmR0K1dmcTZIZUR5RUtEQVNGS3FibVhzZ2pYTWZYL2pSRk8wUy91ZG9L?=
 =?utf-8?B?OVJON2VxQmoxSGFEMFZmNENxcnBKVmdEbE0xM1Ztci8ySlUxYXJrL2xpY3pE?=
 =?utf-8?B?dk5vazg5SFNtdStaYld6UHBSQWYyNnNtT2V1U0Fsc0h1bW9HbE0wNE9vRzVj?=
 =?utf-8?B?b2IwYkVzcC9MU2RBTldULytoNHRkN0c1aktab0hyd3FJS1pWTStMTXN0azZ2?=
 =?utf-8?B?dUkxckVmSElWeWtsL0t4Vkh2Yk9PR1VxUFR4QzhIQWpHRHpMWWZqMFRXTXlK?=
 =?utf-8?B?Y0N1c2JBbzY2cGV2cXRMc3dTRDR5bHdLSTlJNXNuNVVkRXNwdnM4ZThGRngw?=
 =?utf-8?B?blNGQXl4bmRyQUEwRCt4WUszRW82OVY0TDVvbm90VkpsR3ExRkRlbXZGMXlt?=
 =?utf-8?B?RzhjVkh2S1lOemluTzYydlRTQ0lySWJyRkJ2OE5pcGJ5UHFza002czFjY1Q1?=
 =?utf-8?B?NDgybE1hQk8waUlvVEFpbkN2V2l1eERlR0MvRGd1dmlqWU5OZGJMd0NvYS9o?=
 =?utf-8?B?T21pTzQ3WEhiQjlFQkZsdm1KU0tmcExtd3N2d0R3b2NGbWdoU3lVRm9ibVdZ?=
 =?utf-8?B?Y3VmZDVUb3F5Uk9LVXdUVE5WSk82YjVVOURWdFJWWmpxWE9BUEROK3JTdzlK?=
 =?utf-8?B?Sy9mTEZuM3lXSFQ3Z1RZbGVlcTlYRjV4OGQxTTVHT3Iza1ozN21QNGx2MVVM?=
 =?utf-8?B?alpHdjQ4V0pRWEZmRGIwZ09hRGxKUkx1YmdEMjVSc0hCZ2J5MmN2bU9BV2ww?=
 =?utf-8?Q?E2qh1K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a211UU1lbmROb0hvZExuMDk3TC95YmhZOUtya29waXlVVERiUkZXQ2p5Skkx?=
 =?utf-8?B?RHEyQlFQck1DQjBJU0l5UlYxVUF1K1A1NEM5V0t2Y0o5bVVxMzRnR3JNTmpP?=
 =?utf-8?B?WFJRZXlkU0NxSjh6TjZ2Q1pVSVJVMVdHNGJPWGw3MkZicjJEWXp1ZE80clhp?=
 =?utf-8?B?U1JudFVVdFVJMWVRRnN0THUyeWtsNDk1TDQ3YWNjeTVLZHRvY29HdUZhMS9Z?=
 =?utf-8?B?TEpxL2cxQjZ3V0V4WGN5ZkVGZHBhTHh2NUUvQitwTWhYcytMdXJyc2k2SkZM?=
 =?utf-8?B?L0M1ZHJ0azVMZWhLaDZURTg2YjlnM3JQMVI1eFFRMG9LNmwxLzVtbkZ3ZzE3?=
 =?utf-8?B?MUtnZFFySkJHL2d1T0NvSDdqQktlWnpDZkljU2V1NkJVUGtZcmFQOFNZTzlG?=
 =?utf-8?B?ZkM4Sm1CVFdZRU9idWF1MlZHUzhnQ1NkTkIvRklRTC9kditaZDQ0ODg1RjJI?=
 =?utf-8?B?ajJTaERaOEFSQUpLbnNYa0ZhZkxNNk5TMEozWldWckJJL0thQnlJSjBnTmUy?=
 =?utf-8?B?WE1TT2xicFZCTi9zN1N2Nzk1Q1plUVlHQ1hYRmJHUGZZQkMxNExvbzJIRDNl?=
 =?utf-8?B?dTd5WmFidENlZFlwakIySWNvWG02eXNoRytLb1JMU3U3RnY4Rm5kQ09UOVBx?=
 =?utf-8?B?eXZXc3dneGRBQWV0bVJkemlYQzQwK2tUU1RYTWZFaVB1dUE2bng5RGlmQzBH?=
 =?utf-8?B?VmhxaFJLRm5rK1FjNU5WdW5xWHdIcjhhN2V0Vm5qd1BFVlRicnF5VVMrZlUy?=
 =?utf-8?B?QWRQdm5qa1FSajBQYU5Pd1FlMmRLVytxZGREdm5MVGQ2eHNmbUR2clV3ZUo3?=
 =?utf-8?B?UU02by9rVFdDZEdCOVM0eWNiUnFJbmFuYlVCWGcwd3RuR0NubVc0NFlBYnE1?=
 =?utf-8?B?UHVSVVBEck16WHRMVE96TWdxOGEzT0Njc3JadUFBOHBSY3MxM25YSU5EU2p6?=
 =?utf-8?B?Zk9Eall1TFcyL2I2R2puVjdxMGw5UXFRWE1wYUkrTmFvWlZ1Z29yMnlDREI3?=
 =?utf-8?B?L2luNldrZnA5TXJTeDJMN0hneTJ6L3JJL2lyRWxDNllPa0xCOHl2L0NjU0NO?=
 =?utf-8?B?dk54RW44YzZiR1lxYVJNUStwRSs1Wm5zQWNKMGJCVjgwcGlvYWtHN2VhV0hK?=
 =?utf-8?B?ZmFVMzE0aU00azZqUjlwaHZsVm5kMGNtK3NlVFZTMm5waDVqZmRjQVRxaVJU?=
 =?utf-8?B?MzY2RmZOUFhPcUR4Y0pVSVI4ZnJoazhhM3B5aGU4Qlp1SU1RNXNlcnhpOUx5?=
 =?utf-8?B?S0VYT3ZsL2FpVDFXUXJCb0c1QlVRek1LRnBnenkxcWhnbEpxZWpFbEozSFVt?=
 =?utf-8?B?aHRqbDd1ZnFpdm5OV1Bmd0ZLbHJHektzanp4LzFyaVJRS0cwM1FZaHkvN3dh?=
 =?utf-8?B?WnBxc3c0SXQ0UUwwSmxoRDh6bHFrL1kvTWJsMmc4MFZlVk9sRUJNSUVhTDJz?=
 =?utf-8?B?VXNJVlI2RmF3OUpLa3psSEJpdFZzbUZPVzFGSzUya2hHbEowTTR3eDRmSWM2?=
 =?utf-8?B?cnd2aFliSmRJN0pFMmMrQlZMZFFLcWZXdFFWeHBwL29yanU1dGxMTldteTRW?=
 =?utf-8?B?RW14em1Kdm9aQ0gwWFFTbFBsNTNJS3BTbDlxMmV3bnZScWlzMUNsalN6dmxV?=
 =?utf-8?B?TVQxSGFvcktuRDg3VW1kM1daekdZWUE4LzEvNDBtd1BWWGdLMDUxblF6ZUZs?=
 =?utf-8?B?QVlTTDU2Q01GUDZKQVlEV2dXcytFTkRPWHhaeVBGbVcvZ25jeTdYWmZEeWd4?=
 =?utf-8?B?STF1NStYR2xmRFJtMXVMYmlhL0hRaWxxc0hmZmhqTmxDbG5rdHpyc3FzbzQw?=
 =?utf-8?B?SE1ha0QrRk9yTEtPYmRJRW8rTlE4QmFKc0g3VnhDcmQ3azdOZjEwZmNuVFcz?=
 =?utf-8?B?ZFp0cXdRbVM1cm9DSW5kK3dvOXBXRFNxajlzUHpETEE3WlBpS0RZa1RtRE0y?=
 =?utf-8?B?UGsyMG5GeEpaa3VEbU13NHpIUDlZNUFQZXVTeGFwcnVkL2toYnQ2ajA4Tmpi?=
 =?utf-8?B?Z0sxNk1DU0w0ZTVrYk91RXg2dWowSEY0U1pkOWdnSjdxbXZLZ0w0UXVqbzZm?=
 =?utf-8?B?TTQxQ0VnVm13R3FsZGNLaElQZHJZdTExMU5ZVk1UZUNEL0xBQW9lalM2amdX?=
 =?utf-8?Q?CzRPyks+8YwjB2j3g5RdqetFR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20b565c-c331-4729-c760-08ddfe83d106
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 11:40:26.0387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eGGKqnu+57zrw5h22Zb+nSiPhdGijqIa1/HXxcKdqzLN4Jn2knD4zF/YfV5qpD5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8861
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR()
 to %pe candidates
Reply-To: Gal Pressman <gal@nvidia.com>
X-Loop: cocci@inria.fr
X-Sequence: 3048
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/48228618-083b-4cdb-b7df-aa9b7ff0ce92%40nvidia.com>

Hi Markus!

Thanks for the review, forgive for being a total noob at coccinelle,
hence the many questions.

On 25/09/2025 18:07, Markus Elfring wrote:
> …> The script supports context, report, and org modes.
> 
> I suggest to omit this sentence from the description.
> 
> 
> Will the hint “scripts/” be omitted from the patch prefix?

The patch was merged already, so I'm skipping to comments that can be
fixed in a followup patch.

> 
> 
> …> +++ b/scripts/coccinelle/misc/ptr_err_to_pe.cocci
> …> +// URL: https://coccinelle.gitlabpages.inria.fr/website
> 
> I suggest to omit this comment line.

Sure.

> 
> 
> …> +virtual context
>> +virtual org
>> +virtual report
> 
> The restriction on the support for three operation modes will need further development considerations.

I don't understand what you mean?

> 
> 
>> +@r@
>> +expression ptr;
>> +constant fmt;
>> +position p;
>> +identifier print_func;
>> +@@
>> +* print_func(..., fmt, ..., PTR_ERR@p(ptr), ...)
> 
> How do you think about to use the metavariable type “format list”?

I did find "format list" in the documentation, but spatch fails when I
try to use it.

> 
> Would it matter to restrict expressions to pointer expressions?

I tried changing 'expression ptr;' -> 'expression *ptr;', but then it
didn't find anything. Am I doing it wrong?

> 
> 
>> +@script:python depends on r && org@
> 
> I guess that such an SmPL dependency specification can be simplified a bit.

You mean drop the depends on r?

> 
> 
>> +p << r.p;
>> +@@
>> +coccilib.org.print_todo(p[0], "WARNING: Consider using %pe to print PTR_ERR()")
> 
> I suggest to reconsider the implementation detail once more
> if the SmPL asterisk functionality fits really to the operation modes “org” and “report”.
> 
> The operation mode “context” can usually work also without an extra position variable,
> can't it?

Can you please explain?
