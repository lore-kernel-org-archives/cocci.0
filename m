Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CB8CCF9F8
	for <cocci@archiver.kernel.org>; Wed, 29 Oct 2025 17:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=U2AdUitOoTbWDTZcjO6iWZyfNYO+vvqc3Me1ZjXiejU=;
  b=gcUS9WOzeY+ThJGdfG9MjPNNA4ZZfWK+lc/eY73p/uXmJP58158PMeIi
   kkpNefTYoMkGJKD76m5m4rO5np17Z8OVhsCn3Zlk5YbU2rzgysmU9jr/L
   Kkhv772C+lDjypPvhzlTgZXAV9NHQBcZFPs6aSWa9FFhZ6wQTXwOyRlh6
   c=;
X-CSE-ConnectionGUID: RkQTMt/gTk+AeQFOwgxhVg==
X-CSE-MsgGUID: RvIbt4KcRKCjNRgBbfAsZg==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@Nvidia.com
X-IronPort-AV: E=Sophos;i="6.19,264,1754949600"; 
   d="scan'208";a="246735215"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Oct 2025 18:37:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 29A3BE0CE5; Wed, 29 Oct 2025 18:37:55 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 07961E0171
	for <cocci@sympa.inria.fr>; Wed, 29 Oct 2025 18:35:39 +0100 (CET)
X-CSE-ConnectionGUID: YQna2rlGReOA/A+z9UMtbw==
X-CSE-MsgGUID: n8k1clJJQLa7GF9DyAKnpA==
IronPort-SDR: 6902506a_PhgZsaAiO3yaL9y5XNRxcWEwfgR1vsnvqS5jKPcD3rUfwNP
 5wTNGOvKO0NJG0DPqi9K2EHLBzUMevtFv2yQqmw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EWAABUTwJpgSo4ZTRaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwHAQELAYFtUkABQV8yB1EEhFGDTQEBhE1fiHgDhDuZX4FAPw8BAwELAj0UB?=
 =?us-ascii?q?AEBAwSFAAKMVCAGAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBOwcOO4ZPDYJiAYEkXkgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QERAg1eAQEdAQEBAQIBEhEdAQE3AQ8LGAICJgICMSUGEwIBAR6CYAGCJAQkJ?=
 =?us-ascii?q?wQCDqVLAYFAAgKKKXqBMoEBggwBAQYEBNwdgWQDBgkBgRIuAYVsgmQBimRCg?=
 =?us-ascii?q?g2BPIIBgQI+iB6CaYImgQ6GJ4gzigBSeBwDWSwBVRMXCwcFgSBDA4ELI0sFL?=
 =?us-ascii?q?R2BJCIfEAgRYFRAg0kPDAZoDwaBEhlJAgICBQJCOoFoBhwGHxICAwECAjpXD?=
 =?us-ascii?q?YF3AgIEgh5+ghUPiHwCAQttPTcJCxsGPZQrghqBehoIIDCBFRk0ARuWQY4mi?=
 =?us-ascii?q?16UXYE+hCaBZIo6lT4GDwQvqmsumFiMDoF6lhmEdQIEAgQFAhABAQaBaDqBX?=
 =?us-ascii?q?E0jFYMiTwMZD44hhACFE8ZlQjQCOgIHCwEBAwmSHmtgAQE?=
IronPort-PHdr: A9a23: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
 syBt9XVmTmNFfHt
IronPort-Data: A9a23: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
 gSRD7MC6Ihp5ayfNHB6CenExn6pbk8xMg==
IronPort-HdrOrdr: A9a23:aQPsC6vVLOMAgApe7GwX4Wko7skCmoMji2hC6mlwRA09TyXGra
 2TdaUgvyMc1gx7ZJhBo7+90We7MBThHO1OkPEs1NCZLXTbUQqTXftfBO7ZrwEIdBeOldK1uZ
 0QCpSWTeeAdmSS7vyKnjVQcexB/DDvysnB64bjJjVWPGdXgslbnnhE422gYyhLrWd9dP4E/d
 anl6h6T23KQwVqUi33PAhyY8Hz4/nw0L72ax8PABAqrCGIkDOT8bb/VzyVxA0XXT9jyaortT
 GtqX2w2oyT99WAjjPM3W7a6Jpb3PPn19t4HcSJzuwYMC/lhAqEbJloH5eCoDc2iuey70tCqq
 iEnz4Qe+BIr1/BdGC8phXgnyHmzTYV8nfnjWSVhHPyyPaJMQ4SOo5kv8Z0YxHZ400vsJVXy6
 RQxV+UsJJREFfpgDn9z8KgbWAnqmOE5V4Z1cIDhX1WVoUTLJVLq5YEwU9TGJAcWArn9YEcFv
 V0Bs203ocaTbqjVQGWgoBT+q3sYpxqdS32AnTq+/blmQS+pUoJgHfxn6ck7zQ9HJFUceg32w
 2LCNUrqFh0dL5kUUtMPpZxfSKJMB28ffvtChPnHb21LtBxB5uKke+93IkI
X-Talos-CUID: =?us-ascii?q?9a23=3ABULor2s9hNRqzY/Ex2yClaRD6IsUS3vUlm3UDHW?=
 =?us-ascii?q?1Lk8uYf6HGGK15Kl7xp8=3D?=
X-Talos-MUID: 9a23:M1ZrEAsEAt7tepkeCc2ngmFhbcxswYaXLElSvrtXl9itFipoEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,264,1754949600"; 
   d="scan'208";a="129429504"
X-MGA-submission: =?us-ascii?q?MDEkn/I0cJL9YVQTmbr4n9EsaPDGZPuqwN5jax?=
 =?us-ascii?q?NVPJLizbUjsZCKE2j5j9aXOIBJ9HYOAqdVGfEq4dDg6ktuzPNSIVHFzk?=
 =?us-ascii?q?OlcRNVb8jH+1whpLW71CdaKKhgMNwe2ZaM4peyqCek2Aw7psQv1gmzYp?=
 =?us-ascii?q?FOBj9C7LIFWUIjiA0JfJhxpA=3D=3D?=
Received: from mail-eastus2azon11010042.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.42])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 18:35:38 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhYuNxVXcnt8DhpwVQFhgwqYkXlutAduRWxnXnxes/XdIvEpA3EoUz3tpbjb6grqv/WYEjbZKFKE1r3x8GhBD9WxsLqu2BSU5wFxC4ZUp7rhFMfj7qb/aG0IjPcA8oZLxIyyV4AFC2j7copP2u73MxvKnVydkOeP4Tnv7jdSJ/fgvjWHppl/e+0McExY2rxT7sq0lcd4yTKIVM9CNzaS8qqux4y2Te+RBPoLa+bSAqZ0lyl8XZPtbdI6+MsNe5kC6PwdAoHauPYNsy+i2LYq1rO3cH5zxCc0He5/TjKi8kQzWjr4A42aqEuVbwXs6ErM1sTixMcaU50itZHoYtMgwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2AdUitOoTbWDTZcjO6iWZyfNYO+vvqc3Me1ZjXiejU=;
 b=lttPYjEyHkyxsSXXgCyCh+27fSx7uL/tMIgTgE8adFQRb0PHPgwqiveDm3XU181ieb4PFMgKpOVs9/ZXNDWtz8ynsAPgn+1Yl6xSkUkG4jYp8bHpLK9I690gidhS1WJZCsF102h+OvaFlwLT1+Q+u/Vnkt02Oit3w8xdLfshBXRMby/fo34vz7YB6kDN/YRYIS0rujyq9wOR4BteP30TYMIxZhx75A/oKGv8ffRBMmenyfzDf7BFxQgd03cZ+EO5d/kqfV2nN+wWr3BYtX1cvVexJMLZqKtgqOcGuI7G4cgXdR8U9WJ29GHQ1NF8tVtiF9AEyxHQRvhADbKzU2QGaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2AdUitOoTbWDTZcjO6iWZyfNYO+vvqc3Me1ZjXiejU=;
 b=VFCf+O5Iupv7gvIVM7KnsZgujz8ezEz/UGL0FxkLQ0Sn0nU2WDQ/g2iHO6j/B2SMnTRAT9tIglXqQrf0jyTVoMY9PkKyNYgYN/nNFXJogzEMjdLdxKljT552HciPd7sby//jpToI2bSWrsDIQywMGcbFM//WTIWMyXcp83s9+JTRJGYmUq65WSE+uxMx0HijC8ZU2MVcbBvhnd+GtI29ga3decCLMK03qeQ6pviKtrjrF6ovJ52D8ZA5bOqHb3xL/K35Yx72Ueyc2CvC+Tv8vYdY68Z3GfyQ7IvtvlLzEGXyS22jDo8ajNU8GOZQ049pOkftIhn6fbMf3p9XeDUw2g==
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 17:35:31 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 17:35:30 +0000
Message-ID: <3b04f763-aaba-41ee-a81f-94195043fd4b@nvidia.com>
Date: Wed, 29 Oct 2025 19:35:25 +0200
User-Agent: Mozilla Thunderbird
To: Johan Hovold <johan@kernel.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, Jakub Kicinski <kuba@kernel.org>,
 Alexei Lazar <alazar@nvidia.com>, Simon Horman <horms@kernel.org>,
 cocci@inria.fr, linux-kernel@vger.kernel.org
References: <20251029132922.17329-1-johan@kernel.org>
 <826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com>
 <aQJDIz-8Ow0OmczH@hovoldconsulting.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <aQJDIz-8Ow0OmczH@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0019.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::14) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5d2f6a-d3a9-4623-2cee-08de17118e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlVaVVY1RjdlNkZtRzd0V0pEL0tyQVJEdjFaYk43YTNXZEZBL21kMkh5eEVv?=
 =?utf-8?B?QVlwQWQxQ3Nrc1k5RTErMElPSUJ3Y0tGOTdaQUtVTGl5OWRieGdPU00zWlBH?=
 =?utf-8?B?OUtoaHZRd3libmtweklHWXBwZnVHS2JxYXc3OGtDWDJ0ZXVDVUpMaFNRcktm?=
 =?utf-8?B?cSsxYlVMZ1V4UmZRWEc3WTJVNGlxcGxhVFZ2ZS80N2l6MTRkU3BhaU1nNUdx?=
 =?utf-8?B?RUs1WnJtQUFGdWp0LzJidTRnMTVlVjV1ZlliemNQTFA3UEF3bHNDM3JoL1J0?=
 =?utf-8?B?VGJIbmRidytxSjJBc1Y4aTJrNEdDRXdXeGJyRzZmaUJHQjgvMFQvMi9aNWI4?=
 =?utf-8?B?d0g5azIxRm42c1JzWlhtNDU4N2h3YVNsZCtzOHBFWkFMdytmZ1ZKdDN6QzJa?=
 =?utf-8?B?N2NZV05Yc1p6aGc1VExndnVKZloySFgrTGNHZ1d4TVdMNzJQM2RkZkM4QkJp?=
 =?utf-8?B?akI2VUVDMWhlNHJjS2tGdUJKSFpCdmFiQmpteDJ2SlhYNjFIbk05WkZIa3Za?=
 =?utf-8?B?Nm9KOTVMdjM3eGxQQkM3OTltOU8wQ0tvdi9NbmkzRTgzWFBHeWtMeHRJTHlU?=
 =?utf-8?B?SFZxK1k2SjQ5ZjdlaFhZYmlOYnhpbnBiSjh3ZEhVMUQ2djhIK2M1bmtZRS9S?=
 =?utf-8?B?TXlYcDBkS0dYLzl0WDNNQXJQMHN6YnA1eUdkdXpleFJIZDA5RFRKMkxSZDVX?=
 =?utf-8?B?dTUwVThvckVBd2pqdUFDclhSMWtDOTRMNythcEVYay9CQlhQWWtsbTdncHd4?=
 =?utf-8?B?eGUzdlpBNi9vdy9YTlh2Y3dHaWtxTFVWZ214NjJWUjhCK2c4dHZXc3hHWEZI?=
 =?utf-8?B?bXgyZ2NPYU9qRUxuRG15NXMyRnhmRVYwcisrN3FEUEM4bDVsZW5KeFd1UUI4?=
 =?utf-8?B?OHoxUlJTc0VRNEVzaXVNMnNHcDg1aGFwWTRaU09tdDYveXhLZFJBdmFqOFJj?=
 =?utf-8?B?WGZldkdGeVdtRldWWXZ1RU4zNGtITXZSbkxCSUJFNnFjOG1OZy9zaFlIQmho?=
 =?utf-8?B?VVlkZlVxUlJoVUFMQ1pjYlRocUhBZEp1UEtoNU92Mms1Tm9DQ3prelkvTDY2?=
 =?utf-8?B?Y2U2Q1duQmRndDFkSTVFS21abnFVaU5XYWhzbTZkV0JxU1BDN3gwMk1uVC83?=
 =?utf-8?B?Q3JaWVlhZ0x1bDQzSFFhaGl5b3pIa3dqTyt3V3FhS3hzOE96Y3g1d3BmbTR3?=
 =?utf-8?B?QlFWOEpZak1aamMreDhYS2k0c3Q4TEt4VW5tQXBDVUNvK3dNa3Nvd1M1Z1l5?=
 =?utf-8?B?MXBHN3UrSkJHVkM0YUxFbUFMd1RWTzRPQmlTZjhwYlFtMG1kNVlUK0piWWts?=
 =?utf-8?B?QUlWOCtlcDFPT3liWGFKb3BONWN0d0lLTFJqYVQzVW0zc2VqYmVhQU1PV1RU?=
 =?utf-8?B?NFFxM0VCWkNVUGRjZXZWOUZLM1pDVmdLUEd0VnZsZ3hvc0Q0eVJZd090S2hH?=
 =?utf-8?B?WEsvSnAvWUNta0thU01QS1JuQUpTM3ZuZnRidzhWR3lVTStpUUJMQWVySlBq?=
 =?utf-8?B?dldkcHAyRGZxYUVrMVlxNE5wVEgxYnB0dzhSbktMRWxJcHpRcENWeUFkeTBM?=
 =?utf-8?B?SkdPd0hLUDl6MmdLZUU2V1VPajFaQ1IvNE1kTjBYaGM5cHFYWTlZY3U5elRT?=
 =?utf-8?B?cndIQSt3TkkrQWVLWi9HdG5MdFpKYWp5WmRXWFhTNkx2VW12ODVlVnJjNGF3?=
 =?utf-8?B?MXUveFBxT08yZ0RVSUMyRGZyTVY5Y21hSENmOFRtb3JWUjlHS1dVNXFkcklS?=
 =?utf-8?B?ZTJlRWRxN1d5aTBqaklZRDhITDVtTjNmeGRlbkcwVjkrOEg4Mis3TVlDUGRo?=
 =?utf-8?B?aFZ6WDJMUHpjaGV2MFdZSFpBRlZSZnBLRHg1cWtlYW5KTG96MUFkMXZHSVJj?=
 =?utf-8?B?TzFNN2J1U2ZLK085M0Ezb1Jua1NTTEhJdzZTd0MwYW9RSERkcUtVL2VCdENV?=
 =?utf-8?B?Z1pqbUJaM0MzZEhVc1V3OXRwbWExVUU5cUV3cWF2dkp4aHhHTXJqR1VZaEF2?=
 =?utf-8?B?K1lMczlibU9RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHpLRjNWZ2k1MEVtOVhrR1d3L3lxNmRFaEVjRzlCN252UVQ2SE81NkRUSG1W?=
 =?utf-8?B?QUtZZVp0WkRwM1NLdFJqZTlNM2MzZHNXdDUyUkxEWGc1Q01KRmRxUTF2aVJ3?=
 =?utf-8?B?bVBmN3dFRHIrRFgwZUZPcnpxdUJBdllTaWZEZEN5bnN5UkRyeWtndkFLMTZR?=
 =?utf-8?B?THVheTZkMGVMb25PdEFFc2J6a21OTXJaWmFwTUY0Q2RqL2dCWHNvQnBmeFVF?=
 =?utf-8?B?UE40R0xmNkdwcllaUkdIZ3Z1UXRneXBUWWNoMVhKK0p2andSeEl1TU5zWlpX?=
 =?utf-8?B?dlRuOVptQ3hZUHhMSUszUFdOL0h2TC9na1BmVHBIRlIyUlc5UEZZMTVsa3BR?=
 =?utf-8?B?Q0RLV3h0dmhKeTVjdVRjZWtLRjJ4SUJFbFJxejVKQlIvRDJZYTI2QjJCczJp?=
 =?utf-8?B?ZmpVYUtDU2lkR05BRC8ra0VKNlBZMWpVdVozNFo4SXdDWGsxUmo0d1d3c3E1?=
 =?utf-8?B?aHRDMlRRbDlYZ2x4NDlWZGEwM0xyUzVrYmZjY0JydFQ3NUhlTjliZUdJZGdJ?=
 =?utf-8?B?YnVGVjFlYjkxOTVzSVdnSXhmeEcxK3Z6QlVIc2dqbHZUbVB0NmFtOHBUdmFR?=
 =?utf-8?B?RmxVaEMrL3pEU3JJT0hFRjhQQTNSbGszNHp1dzJkNVJ2T3RSNzdEQys0N0pW?=
 =?utf-8?B?OVNYeGU5UXRCZnN0Q3dCb1RTUmZCL0ZWV21nVVAvMW83djJtTjNEbDNBdGxq?=
 =?utf-8?B?bHB3RDRvU1hHK0JFU1NZQnA4ZUhOL0VmeHFTT3B3TDlNbWZpSE1xZjJ0NFFV?=
 =?utf-8?B?RDRYUlhTaTlZZE84ekFhUWdlWTgrd1FpeU55dm9iOXRtY0hNT215RjZCSFBS?=
 =?utf-8?B?a0FDeWdhWkN0ekh4aXJRU29LR2xvOW93K2NBYytKV090M1QwS0g2cy83Y2Yy?=
 =?utf-8?B?Z1NTWTZVZkJwWUJma2lKc2g2UmRBVGhoMC9ER2xvcGoyTlRXWnpYcngwTFVz?=
 =?utf-8?B?OVFTbE90czFYOHQzejNaZlY2RnFmS2pscE5JdUROT2JsYVZnZG1IaFk0VmpL?=
 =?utf-8?B?aDZhRFpqUlcxRXJXYUN3cnB2aVpuUkZqc1Rtc25qTHdvbGwzbDNLY2tuM29o?=
 =?utf-8?B?bVh2aFZZUktBajh5cVpoNGJ4ZWc5S3c4WjIrcFhua2d2MjVHUHozWGc2L005?=
 =?utf-8?B?cmR1QkRjN0ZQanRXNFkxdUFkNmJ5S3h2VGRrQW42QXg0NVJ6bGNyVFdSN2JB?=
 =?utf-8?B?TkhCbjY4OE1hQnMreTQ3ZGRkcFF5aXVaRXMwTjAzUzQ0OTVjekFsZHZWaVF0?=
 =?utf-8?B?cU9icGlQaXNnWDNSbmNJKzlsVkdNUVlSbDl0R3Y3c2J5Q2J6b3AzVE1KMkh1?=
 =?utf-8?B?Y0dVeHdsU2E2ZEplYUoyejlwM2l3ZDRVWXhGS1EzMy9QMllBNEJGa3krWjh2?=
 =?utf-8?B?bzJKQXlmNUp0T0dJVzBzQ3JZZ1RreFhlanFLTVpaNWE3WTlFN1ViQXR0SDFF?=
 =?utf-8?B?WmRvMEhZck9qUmdLSDRqTHdTb0pWdWVMMmR2Q3grMjhzYTdDOXBVT2JOa0NC?=
 =?utf-8?B?VDNkWFd3MUEySUtjWTVPbXNCYTlpenhMNGRET2s5VGxLYmJSdElib0xkZGlT?=
 =?utf-8?B?YUxaMXdFZlpMTFN4RDQ0ZHJoK3o0TjV5R2hTL2lYL3VJZ1B3QTR1bHdySnhL?=
 =?utf-8?B?V0hFbXh5aXlLSnEra2dwN01DaEJqaWJvU2JwaU5IYVdPZ1k4MFM5TDRjSU1F?=
 =?utf-8?B?SHUwS2pzOFVSalFub0VqNWo5ODlKSFpBcWg3QUxNWGQ2Q2t5dUs0RkF3QzFz?=
 =?utf-8?B?SVg5WlVCUHh4ZHBVSWJPOStrQ3BLZ2o4QS81UGxsZnkvL1FCcW15YjlQcFds?=
 =?utf-8?B?aStIMGkweE5HeHFRd3JBbzROY2xhalhHdzFLN0ovSGdSY2VnSkJoYzZCS3Q5?=
 =?utf-8?B?YUpPUEZhNHdwRWR3aDZPTTlId0h2TkR3UnlPMXBvWWNjSHYxRzVIcmVWbVFL?=
 =?utf-8?B?TW1YaVpYdFg1RFZBT3pBRitOMlFmT1paRlJVcW9GMk8xQVRzT2NJNXBmZXNj?=
 =?utf-8?B?VXRBQm1pWkdvS3NIU2xLODZDemE3enRQUWM2cm8rTGRlaFV0NzFuVXhXT1Qz?=
 =?utf-8?B?TUcxUi8ydXhOVDBxSVNCbE1UM0JabDZONWo5TzZLa3h3ckFMT3RudnJsSzdl?=
 =?utf-8?Q?npH0n7YVMLuWR1xPw3MGqpRgP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5d2f6a-d3a9-4623-2cee-08de17118e5b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:35:30.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKNA1mbwoE5Pwo4YZa9mqZFdQGEJZiktIIVgQS0CG8UROW8wpV6aGy4HOsAwj4vZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] Revert "scripts/coccinelle: Find PTR_ERR() to
 %pe candidates"
Reply-To: Gal Pressman <gal@nvidia.com>
X-Loop: cocci@inria.fr
X-Sequence: 3111
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/3b04f763-aaba-41ee-a81f-94195043fd4b%40nvidia.com>

On 29/10/2025 18:38, Johan Hovold wrote:
> On Wed, Oct 29, 2025 at 03:59:50PM +0200, Gal Pressman wrote:
>> On 29/10/2025 15:29, Johan Hovold wrote:
>>> This reverts commit 57c49d2355729c12475554b4c51dbf830b02d08d.
>>>
>>> Using "%pe" to print errnos is in no way mandated and a driver authors
>>> may chose not to use it, for example, for consistency reasons.
>>>
>>> Drop the recently added cocci script that has gotten the build bots to
>>> send warning emails about perfectly valid code and which will likely
>>> only result in churn and inconsistency.
>>>
>>> Link: https://lore.kernel.org/all/aQHi4nUfIlcN1ac6@hovoldconsulting.com/
>>> Signed-off-by: Johan Hovold <johan@kernel.org>
>>
>> The test by no means mandates authors to use %pe, as the output says:
>> WARNING: Consider using %pe to print PTR_ERR()
>>
>> "Consider" :).
> 
> Right, but it's preceded by a big "WARNING".

Right, I don't mind removing it.

> 
>> I would consider it best practice to use it, and a few drivers were
>> converted thanks to this test.
> 
> Unlike the rest of the misc cocci scripts I skimmed, this one does not
> guard against any bugs. Instead it's pushing for a subjective style
> preference, which is just going to result in churn when the clean up
> crew starts sending mindless conversions of individual printks.

Not all cocci scripts are used for fixing bugs:
err_cast.cocci
memdup.cocci
minmax.cocci
string_choices.cocci

They are used to improve the code.
We can probably agree that for new code %pe is preferable, but I
understand your concerns about the churn of conversions.

> 
> By all means, use %pe for your drivers, but it should not be forced
> upon the rest of us this way.

Agree.
This script helps us for our drivers.

> 
>> If the issue is with automatic build bots, then maybe this test should
>> be excluded from them, rather than deleted?
> 
> It's both; it's the noise the new warnings generate but also the coming
> flood up patches to "fix" them. There are already some 40 commits or so
> in linux-next referencing this script.

It's OK to not like these conversion patches, it's up to the maintainer
to accept/reject them.

For example, I know Jakub dislikes the string_choices.cocci script and
rejects conversion patches. But the script still exists and can be used
in other places in the kernel who might have a different opinion.
