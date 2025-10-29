Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F62CCF9EE
	for <cocci@archiver.kernel.org>; Wed, 29 Oct 2025 16:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=bc0QzzoKZWLvucTt/iHroS+l5c8OdL5hT6fkSg2rEhA=;
  b=UfB+oTD7zsHyfhV/eZ+y4r0FEvbT5lM2dGpv7Aa9SztQzJXgmxWVfSNr
   RKi+EijGWOdqMrMI5pG6qyw34x4/f62fpxgV0FpVnfTUXBbRnQ4h36neD
   Irk89WRjflGUF9t1ArGtlVpufoC76k+iG3T+X4yQUvu/FyAbXHHf+efXg
   o=;
X-CSE-ConnectionGUID: Mxp/B+owSGyI4q07JGFdKw==
X-CSE-MsgGUID: 0rlvLfG9RVOVi9hOG0zJMw==
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
   d="scan'208";a="246728159"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Oct 2025 17:48:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C2C64E0264; Wed, 29 Oct 2025 17:48:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1540CE0171
	for <cocci@sympa.inria.fr>; Wed, 29 Oct 2025 15:00:02 +0100 (CET)
X-CSE-ConnectionGUID: pSE7SGxaSXeu2Jgu2G9Cjg==
X-CSE-MsgGUID: LvJ1XkKkRySqSTrstKxXSg==
IronPort-SDR: 69021de1_ca7Cfr2zVzdVG0t7p5+c+HhSrTmhQv7Nyy8Zj6XKGd7gnbH
 WvmT5RfuOGWZZKNF6HygwTNWyd4jO+EYIbOdnjg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EHAwBQHAJpgSQ0ZTRaHgEBCxIMQIM+UkABQV8yB1EEh?=
 =?us-ascii?q?FGDTQEBhSyIeAOEO5gKgxU/DwEDAQsCPRQEAQEDBIUAAoxTIAYBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDjuGTw2CYgGBJ?=
 =?us-ascii?q?F5IAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQINXgEfAQEBAxIRHQEBNwEPC?=
 =?us-ascii?q?xgCAiYCAjElBgESAgEBHoJgAYIkBEsEAg6kfgGBQAICiyOBMoEBggwBAQYEB?=
 =?us-ascii?q?NwdgWQDBgkBgRIuhW2CZAGGJ4Q9QoINgTyDAz6IHoJpgiaBDoYniDOJdVJ4H?=
 =?us-ascii?q?ANZLAFVExcLBwWBIBAzAyo0LSNLBS0dcAwoEhAfEAgRYFRAg0kPDAZoDwaBE?=
 =?us-ascii?q?hlJAgICBQJCOoFoBQEcBh8SAgMBAgI6Vw2BdwICBIIefoIVD4hwAgELbT03B?=
 =?us-ascii?q?gMLGwY9lCeENiAwgRVNHKRnoDuBPoQmgWSKOpU+Bg8EL6prLphYIotsgXqWG?=
 =?us-ascii?q?YR1AgQCBAUCEAEBBoF/I4FcTSMVgyJPAxkPjiGEAIUTxmtCNAI6AgcLAQEDC?=
 =?us-ascii?q?ZIea2ABAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:y4aCL6munL01hFJ7H9xBR7bVy6XpDfIb3DAbv31ZSRFFG/Fwz/
 re+MjzpiWE7wr5OUtQ4uxoV5PhfZqxz/NICMwqTNKftWrdyRGVxeNZnOjfKlTbckWUnNK1l5
 0QEZSWY+eeMbEOt6fHCX6DferIruPqzEniv5a5854kd3ASV0hP1XYANjqm
X-Talos-CUID: 9a23:ekX8oG/TpZmRn/gXVB+Vv1YvN58eXW3U90fdPhWaBnszZ+y+S1DFrQ==
X-Talos-MUID: 9a23:20hylwkn9OABy5TOqZBjdnpGKuUx06eNC3ocqow9h9OfKQ9gCwyS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,264,1754949600"; 
   d="scan'208";a="129407427"
X-MGA-submission: =?us-ascii?q?MDHQfA4y/pw7VK0bqujrsrOi+wJDB/7YLH2QvD?=
 =?us-ascii?q?TrOOp9KeNd5m6litX8umZY6fnAxqjJ6igTneytr2O9Z5s2RZ1laN9w6O?=
 =?us-ascii?q?nT8tHA/jDMRSvG1zYbp4abw7/ojXK8CoAfeTv0xcqYsa5si8wz5bVNX5?=
 =?us-ascii?q?5vfJz+wO1E/zgdsWJkydqVmA=3D=3D?=
Received: from mail-eastusazon11011036.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.36])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 15:00:00 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grJuv6nbMqp0ZBVRRO9pBrU09pffzGsLwfHFV0Pa2JdVgeeMvQnRwT85IsSz5lf/jiZKPA2w04zjhJpE8ovC9Gc8GMfvQ8t2OSbKd5qbAYcjVRHvx7aZ1sVeL7wz3NlIfbv/KlDZOSdf/rsSkdA5LcnJpF3Q3yJTKho7q3lEFTbDJK8h0aX1SUDVo1cOjwi3wHdf9XJ36oUqZZlPnUpqrI3K3+lKuI/yGbw3jPOJ+iCNsB2G9+wHGKfec4fzCsc7AL0egaFzjmah/OPl+soduUqMoNlUx3NhNj5Hv82GkZbxVHuIlezzMeiSRjud8/k/MLoYzEzuS9jXCbYVUSVXqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bc0QzzoKZWLvucTt/iHroS+l5c8OdL5hT6fkSg2rEhA=;
 b=uANj5Qc27die5eHMUc7zMCRBnrdLU2XYkAHpvQXWxMGJI5fyOsLu/I3faxWLAO0RnrJd7IMiXslMTbVV4q3v49cxBlGoKwnmt3DgUJ797bDvX+Y2BOlVSMDlr6amZurLf0Di8kiiTt+xsOOZk3ZZbCzw9TeQ8i4o01XEMogOeY5WioIMtgL6EdpDRXjLxVTKqy/7/m74p+Ank8JhWOMtnLS47PYVOWOcRiuWq+XRFcn4N9M6zMggspIU+mc/fZVgiOmkuVdrQUd5VKNP5mzVcUIQW7HkNxGodVFmteG8WGhmklSLX3NP69c1TuVlthb9EKL+Uto4orpht0v9ArZ67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bc0QzzoKZWLvucTt/iHroS+l5c8OdL5hT6fkSg2rEhA=;
 b=duHM/toJfw2fGN+3TlpcWSM8zSzW01T2spyp2tcZzdA64ACVifmi0PUWMa2oiN5pNfv5P7RrhNyuJOewfkWdifnoe9bdP+j1ka5GlxTfh2HpdBImoCFqjXrSRRU3HZU2xTTJh77zl2Zztcs5J6QhvI764r861wwpM3fZWx9LIQ/f1zIQaupgrvleZiS0bPtja/iryTlZ6LTFEG04DPPStXKm9RonU6vT8Zqko6fuavCZPaHA0OPj2zjRavbbqi6EB6DzW1a9UJuE3bRwSIVYPXzhaexo1BDfx0KY6Tnr9E1s01JPKGWFx/OHxpMOpxPSYT1zcQU9CJjzk+Pm0vEpjQ==
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 13:59:55 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 13:59:55 +0000
Message-ID: <826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com>
Date: Wed, 29 Oct 2025 15:59:50 +0200
User-Agent: Mozilla Thunderbird
To: Johan Hovold <johan@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>
Cc: Jakub Kicinski <kuba@kernel.org>, Alexei Lazar <alazar@nvidia.com>,
 Simon Horman <horms@kernel.org>, cocci@inria.fr, linux-kernel@vger.kernel.org
References: <20251029132922.17329-1-johan@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251029132922.17329-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: 8545024e-e356-4573-b50a-08de16f3705a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEs0amQyTDJ6djlvaXdIcFBZMVQzVVhLbWE5RE1ITzZqU1BRb3RjcWhrRGpR?=
 =?utf-8?B?YlNMY25xbE8xQ1hhWVVxYUN5b3BZY3lZZUsxRm5ZSzl5RGRIY3Y2aGcyL0Ns?=
 =?utf-8?B?NnNHYTNVempEaGlMUWhpYkd4YzlxbVo3Q3RldFRwamQ3ZUV2OExYbnpvbUJL?=
 =?utf-8?B?aEx3S1RsQ3k1N0lzV0hKOThia0k2dzJsbE9CajdUYnFweUpQck1wM3RwWUsw?=
 =?utf-8?B?QWNpN0w3dHE3R2NjcEYvZlMvZmpwUWE1Um9Qczd3ZVpTWThBa0loVWRGajE3?=
 =?utf-8?B?WG1JZkRNZHgyLy9yZ3ZKQWd0cjg4YzZEeTZIQ20rRHQ2VjBtZHQ1QUFvOW9k?=
 =?utf-8?B?MEFmSGMvUjJiNVRUc3Q1bjBOZXhXbXNjZ210ZlBaWmRJaWg0R1NCbDRrT1JH?=
 =?utf-8?B?a0dnTmVtcmUraDlaZ2tyMnRpRXRaUHdRR2ZFU2dqNGc4R2N0YTRIQXhycSsz?=
 =?utf-8?B?TGRmNUJ4anU4TE8rTWREWDMweVoxVTJGSjVHRUVBaWNmc3F5WUs3dWpiU1ZO?=
 =?utf-8?B?NTNGTytEV1VuaGwvY2NXVnVROTNsdFNWbVV6dWlpbHVnOUdEelIrNTZtYkhF?=
 =?utf-8?B?SW1pZ2dkbFVmRldYUy9mNFA2L29ZQzVqTWpkNEhyUWRCa0toelRWVlF2eUlL?=
 =?utf-8?B?SkE5TkJjZ0tmUTVzbHdrdXhNSTVvaWpKellIeitJaFRWNWxGZDVVQS9oVlNj?=
 =?utf-8?B?OXdmcVVOWXN5TmJML21qc2l0dzNvSFEvTXphUllrWnNlZEp2NGljK2x3VFU2?=
 =?utf-8?B?SXhNVVhkNjBxL3c4YlBJN3hnL3loTVlmQklPYy9rQVNBbHdFNGNvZ0gvaE1E?=
 =?utf-8?B?ZS80OTFDOEx6Q0trOWg2VnAyUlVmYi94K3NabkpDNk9iNTJiNEhZK2JIa0RF?=
 =?utf-8?B?TTFVVUY5OHZmK2YvMEhQR2o4cmthUGNNdElsVFZYOFlsSC9VbTU0blBzWmJD?=
 =?utf-8?B?TTMrcEtwQ09OMXpaZEk5QmRhRUpTS3FlSXovZEZTUlQ1R1VvRGw5NkJrQ1pa?=
 =?utf-8?B?cHVzMld6NTJwRnIrb3NaSFhJZkliblA4MTVjcEI2SlNKbnFXK1Fack80WGZN?=
 =?utf-8?B?NzlLN2IvUTFwaG80SlUwOHFWV3o3bFNpR1JhaWZvalBVNUdjb1N5dE85UldK?=
 =?utf-8?B?WnpIMm9kQWxXYlJJRTFySnF4QXF4UjM3c2NRcUpBeFZoTnFQVkZhcDNnTkNx?=
 =?utf-8?B?WWUxR0o1MWIxM01TSHRxNnNCWVlwS28xS2VxV1dLOW42Umsxcm1UWFVCR0hz?=
 =?utf-8?B?TjhRZGEwajhQRnMwRzBuYTRNUmlxZzQ5M3BiZGpwWGhYNDNsSmFPZzhVZnp4?=
 =?utf-8?B?WVphUTdhOUJkd214UWdWOHVwNEdNV0wxcDl3eUdsdVZBakg0TU1IMkRqQUo2?=
 =?utf-8?B?WU1kcnZSYVNIQkZtdnEzSzNQMnFkUFVWZ3ozRkQvZmVTKzlLU2R0WnFPTURh?=
 =?utf-8?B?bkV4eFVsZjF0TitTT2VNUVV3dEVoUkxlcVBrRk5MZGxiMjFteGNPZ2lBcW43?=
 =?utf-8?B?c1RyMm96S1BlanNka1pFaGNIcmhUM0Z0RmMzYnBUZ0VCZ1ZXQm9jbVA2VDdI?=
 =?utf-8?B?TmdoeWlnSHBTSU04M3RkN3lZSU1SSERtRGlSRWR4S0FLRkFIVysrUElKcGxI?=
 =?utf-8?B?cVBDcS9jTzZaZGc1NktjWXV5a0lSWmNxRXRBVTZ1WkY0ZW9HN1dMS3pPSjZv?=
 =?utf-8?B?K2xJdEpqcm9rTWRkVmlLTGltVWJrM1lBSVQySWxOOVZaVUJJVVBTRW1qWEky?=
 =?utf-8?B?T2Rpb1Z0RisxQ280WUlZZHQ3VU1vaFhGcWpNWTlDSVNuOWxQWlQyZHArbmpP?=
 =?utf-8?B?WjdERHZBMEdQRWxLdStnalM3RCtZclFVWWY3TTNwcGNpMmJaTktJQWdyckhV?=
 =?utf-8?B?WUtrN1Q2a3c4aFZLd2NxQU1wRHl0Vnhadmw2VzA5dkQzaXZ6RExjM0ZrUUVK?=
 =?utf-8?B?YzlWSUpIVGRFeU4vNjZkU2dSaWZkZml4bWFGMHJsbzdtcW1GZ2d5VWlYdGM0?=
 =?utf-8?B?V2xqcDUvOU9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2JOc1Z0bjdNckRNMWhhVEk4azJibEg3ajU2QVpwNWVaRTJSYVlINGY5S3pR?=
 =?utf-8?B?OExBVksrZDFSZ1g3dkFaR0lNUDZDbzNzdCtsY1lDbEtEaGZEZ2FheklQSUEy?=
 =?utf-8?B?N2F4bS9YRktOcCtuMXJoOEx0dHdtMDI1Z0k2bTBReTQ2QmM2K3hrclluUG1P?=
 =?utf-8?B?dDdpczJnaTc1MXpPdlVCVmphZURzbVFBNmg0OXBkcEN0dlBsNkJSWnE2YjhD?=
 =?utf-8?B?REd1akRnb0JwVVVjVXJ5SGZkKzZVNmZsTmlRUm5pVk9nRG1GY29FZ3liSlh3?=
 =?utf-8?B?THhzUlhNTEh3YWFrdXYzdjBMYmcyS0RIZHg2OUtzNW04MjIvVW9Sa0lzaVJF?=
 =?utf-8?B?UHpkWksvK2pDbzduQW1qbktNaGtLdGlMbU9VZVdOWUVlZ0J4a1MyMFBEZjFq?=
 =?utf-8?B?bzZadzNaci9RVzdzMUdFRG9abkFJM3l2UytpY0diWVl6enRDeUN4eTdZYWlh?=
 =?utf-8?B?L0JCTDk2N040ZEVZZ0dBUmpyQmxTb0FMY3dsZHRzd25wUVJ2WGRiSjVPMW9N?=
 =?utf-8?B?ZDNNeVNiL1ZOQjVhVGF0VjIrdVFFUVg3dW9SM3pKcVBwRzZUVnZIMlRuZTgv?=
 =?utf-8?B?VW8rdkoybmxkYmUwTG9Yd1gwSnR3Lzg4dG1yRThYM3RadUhUckIwVmh6bjRJ?=
 =?utf-8?B?cVB1M0IvdmhlaFlpQTVEaVAvM3dtY0tTN1BRWW5lc3BUdzh4bXpBU1lEQ2tH?=
 =?utf-8?B?ZWxJNGFuTkpweVVkUUt1aDBacWQ1cE9YalUza0Vpbmh3dzFRaUJaVjBscmdy?=
 =?utf-8?B?d3IzVnBFUjZDaHdYRUZTUzBRelJpQnM3dlE4Y1FjaURLVUJGVlUxOWU5bzhN?=
 =?utf-8?B?Vzc3T3pSRFE5ekxpbnB1ZExwcGJ5TUxyZDRQMjR0OHNqWngrRUhPUE5RZDZV?=
 =?utf-8?B?eGdGTXR5TWZXVnVMam9zbFJKUzNFci9QWDRFL0FzcmUySkdvV0J2WnBHYWNS?=
 =?utf-8?B?WWJOd0xMaEhMeVptZW1CRHZaWW1jS0JuQk1ON2MyRjBlRFllWTRxam0rbmhJ?=
 =?utf-8?B?MEpubTZMck81ditGSVk2eWtLTjdXa0MrYzBmMWJYK1NFcEgvTUU2OGkvakVZ?=
 =?utf-8?B?Q1ZYUmZZSGhndjIwc3pueElGVWFQaG1VQVhvTzUrdzFyWFFLMzIybVJDOVA2?=
 =?utf-8?B?M2V2VFQvRXlINFVhYmhqek9BZVFwLzhaazIxNHprZDl0S245b1IyOEVsMTJv?=
 =?utf-8?B?M2N5SzJ3Z3I3dmJrcUh6aWUwQWxxTHVCTXg2TjVSdE9NM1BKaE9udThaUFhz?=
 =?utf-8?B?L045My9EeTMweDlqTmlBS2pnVm1tTXJkbVRzb0ppSlEwV0c5NWsxR29RWGFw?=
 =?utf-8?B?T25KZW5CK1VpK2dGNysyNUtOV05EVWREaUNOaW81LzAxUklvUVpFcW1LNm1T?=
 =?utf-8?B?SWlnOHh1cmNtNHY1eUkzZ2JwSm1CQ25HMTlHYlcwRm5VQTBsTFJDampqOFdy?=
 =?utf-8?B?YVZhQWhxNHhHNUtqdk10WGdjcGRlVm9wd3VNNEw3eTdkZjVGYkFYL2NnYTAw?=
 =?utf-8?B?ZDFnQWl5S0JObGpqSFYvUVYycS83blRKTmhwUFpvZHcvMFFQU0hUSFpjMWZU?=
 =?utf-8?B?UFZYZ0hsbzZZc2xWUlFkeVVrc0l2WU5BTG9qL3ExTUd0dVltaTVac0JoNHls?=
 =?utf-8?B?SzI5aWtTS0FTZFhmazIwR0YybDRKRitsemJmc1dnTWd0a2diaUN2eWxSSU5i?=
 =?utf-8?B?dStRVjI3Nkh0bStaRGZYVDJRZ1pnWWRhVmlId0daWEFIK29GTnViWXB0czU3?=
 =?utf-8?B?SlZzS3RoVXhpaUtIc0s0K1pVQ1RLSlZDeFRhUHVDaHlta1VIZkdTN1lyeFRO?=
 =?utf-8?B?NXVzaUdNVVRPcmJady8zTVNVaU5VK1JYcGttalZZTXpqR09JRGxnSkpmRU1C?=
 =?utf-8?B?YWhINkQ0L1YycmhqODNHeWR2cXFHQlltTmdKeWI2ZWdoaTFhVzBEVFlnSmM2?=
 =?utf-8?B?VFF5VjBZWFdML0ZYL2dHN3hhekF4RHI1UG5qVjJpdnhCOWw5QmxhcDlBYlh5?=
 =?utf-8?B?RHVIdkVPZkJlTEIwV2lodVd2RVlkRU81dk52YThxb0tvcDkzaUg4cC9xYkZq?=
 =?utf-8?B?M3FxR2ZwbTRoOUp4a0h5N0NPazFUYkpuK29HckZXbklJOUxMWXFoTEt6NGp0?=
 =?utf-8?Q?YCck=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8545024e-e356-4573-b50a-08de16f3705a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 13:59:55.4877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPyg2lcaqo0+99SvL094+DLExv45Uhqh7LCL8CSPVHzWF3Qm7+RbY9+wah4Dt3IV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] Revert "scripts/coccinelle: Find PTR_ERR() to
 %pe candidates"
Reply-To: Gal Pressman <gal@nvidia.com>
X-Loop: cocci@inria.fr
X-Sequence: 3107
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/826f2fdb-bad8-44f4-8c8e-9353c3de73cd%40nvidia.com>

Hi Johan,

On 29/10/2025 15:29, Johan Hovold wrote:
> This reverts commit 57c49d2355729c12475554b4c51dbf830b02d08d.
> 
> Using "%pe" to print errnos is in no way mandated and a driver authors
> may chose not to use it, for example, for consistency reasons.
> 
> Drop the recently added cocci script that has gotten the build bots to
> send warning emails about perfectly valid code and which will likely
> only result in churn and inconsistency.
> 
> Link: https://lore.kernel.org/all/aQHi4nUfIlcN1ac6@hovoldconsulting.com/
> Signed-off-by: Johan Hovold <johan@kernel.org>

The test by no means mandates authors to use %pe, as the output says:
WARNING: Consider using %pe to print PTR_ERR()

"Consider" :).

I would consider it best practice to use it, and a few drivers were
converted thanks to this test.

If the issue is with automatic build bots, then maybe this test should
be excluded from them, rather than deleted?
