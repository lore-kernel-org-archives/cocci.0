Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6122CD6E71
	for <cocci@archiver.kernel.org>; Wed, 11 Oct 2023 13:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0nLtVZBK2uK1oS5PxAZ18Ukh96EKOU5KZtz6GTGg+8k=;
  b=F8q+h2zsb7gwLdS/+rYJG3QBR/IlJOBLgqoPwTywIk1zS1cbU/IVfJEM
   zdooYXbzLY4v1Q0LYqqt0K1oC3DqK27fADek2JR/J9Y8RnLsAWDdsEkIY
   YnF3heldiOQH3bYvmfIiT+DdRoTPZ2ANizjJMsJ+c/iiRExrrX8pfQ5oG
   8=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@axis.com
X-IronPort-AV: E=Sophos;i="6.03,216,1694728800"; 
   d="scan'208";a="130689282"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Oct 2023 15:49:45 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CCBECE0CE1; Wed, 11 Oct 2023 15:49:44 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9F9E6E00BA
	for <cocci@sympa.inria.fr>; Wed, 11 Oct 2023 15:19:16 +0200 (CEST)
IronPort-SDR: 6526a0d3_iEO+8ZgxXsLGh4bnNxgLCi8sFfx6G0iLeQN3qzAE6npGFOT
 UEMqzPzK4bDCHHcgSeipTbkX/mQ+QcTzikk9u7w==
X-IPAS-Result: =?us-ascii?q?A0GGAgAgoCZl/ywNayhagQmBT4FmUoFRLwdQhFODTQEBh?=
 =?us-ascii?q?S2IYwOEO5lAgX4PAQMBDUQEAQEDBIUAAocSIAYBAzEJDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEDAQEFAQEBAgEBAgQFAQKBBhOFaA2CNysBgR2BHgEBAQEBAQEBAQEBA?=
 =?us-ascii?q?R0CCGEBHwEBAQMSERUIAQE3AQ8LGAICJgICMiUGEwIBAR6CXIJfBAKoDgGBQ?=
 =?us-ascii?q?AICiyCBMoEBggkBAQYEBLEOgV8JCQGBEC6ICgGKBjaBVUSBPAyBCYFvPoRcg?=
 =?us-ascii?q?0KCaIFagh6FPQMCAjIJghuCel+COgOIKl8iBUJwGwMHA4EDECsHBDIbBwYJF?=
 =?us-ascii?q?hgVJQZRBC0kCRMSPgSBZ4FRCoEGPw8OEYJDIgIHNjYZS4JbCRUMNU12ECsEF?=
 =?us-ascii?q?BeBEwRqHxUeNxESFw0DCHYdAhEjPAMFAwQ0ChUNCyEFVwNHBkwLAwIcBQMDB?=
 =?us-ascii?q?IE4BQ8eAhAaBg4pAwMZTQIQFAM7AwMGAwsxAzBXSwxZBG0hEwQOAxkrHUACA?=
 =?us-ascii?q?QttPTUJCxsGPgInnRqCagGBDSQoYwJAQKQaoHY0B4QPgVkGDJ8iBg8EL4QBj?=
 =?us-ascii?q?HCVRYMwmDqjP4RlAgQCBAUCDgEBBoFjPYFZTSODN08DGQ+SGI97QDQ7AgcLA?=
 =?us-ascii?q?QEDCYkigikBAQ?=
IronPort-PHdr: A9a23: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
 A==
IronPort-Data: A9a23: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
 jZUo/dcuTLYtxmxCZGVh+Vj/84hNpnK
IronPort-HdrOrdr: A9a23:/Qui76N0zch7DMBcTjejsMiBIKoaSvp037BK7StMoG9uE/Bw8P
 re58jztCWE7Ar5N0tMpTntAtjjfZqYz+8R3WBzB9uftWvd0ldARbsKhbcKgQeQeBEWndQy6U
 4PSchD4ZHLYmRSvILA+hCxF9tl6NOb8Kau7N2ut0tFfEVQcbhp6wo8MhqWDkEzZAQuP+teKL
 OsovFcvjKldDAsYt+lCmJtZZmlm/T70Kj+aRoKQyUq8hWKkFqTmcfHLyQ=
X-Talos-CUID: =?us-ascii?q?9a23=3AnL17TWrFLb+Si8/WbK6f5r3mUfxmMUbklWjuGGq?=
 =?us-ascii?q?TM3tLQae6eHLT55oxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A6mCsow9y7J5FkZ+5mZtPZn6Qf55o8oiyOWoiq7E?=
 =?us-ascii?q?PgY6iNQhBER6shw3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,216,1694728800"; 
   d="scan'208";a="130680680"
X-MGA-submission: =?us-ascii?q?MDEdSTet4HOfGlJ7R9zPblJauM9qPKYmJSSyIA?=
 =?us-ascii?q?TNCEsRRBHNTNGy9jwBHg68GaGBeqpGHk7TCe+s1goNkGxNW1pJCZ+7O+?=
 =?us-ascii?q?ie6AsxTzB8dHBaDNd9WetApuEA/a9YuXaUn16taUMoLzSOcCs8J9w6au?=
 =?us-ascii?q?1vIhfbS/4nrctRBszzQZVGcw=3D=3D?=
Received: from mail-he1eur01on2044.outbound.protection.outlook.com (HELO EUR01-HE1-obe.outbound.protection.outlook.com) ([40.107.13.44])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 15:19:14 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPb6CSznNFmTGyLZ/VMcBGdM8IZIstMcoFSIFB1YVGuCJfz5GL42WuuS424FqmkM1oqr2MDiFdq/QQR3+36t9MCfx1/z2sidsNtuNAU5uVQXWK5ghRL2jkwNbQXnls8zfHF/PhJDhUnmDFOWbrKJZIrIl4oZXj4kIoDaiMUcsKyF3vo6y18yhRhpa6vybIw9wnvts/0dZWD3Ii11wepQC7LeSeItXnK/DJzftEJjABU0lPzAbET+4jkAEN2YjKipYjaz3O6eyW7RNPwSP8heMdp0HzHmlqprIuHdNMySBNoA93U4W66XKd6uEroRQ9KcNOf+jBYUypPEfU9s2+ymAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nLtVZBK2uK1oS5PxAZ18Ukh96EKOU5KZtz6GTGg+8k=;
 b=KBoO6vySL4wcWI4cRds6a3oq75Bx23NeaJ3TV1z0Dyn0J/8jN+UFLPkAsPAvWh9bGzenOurp6tpBdPPvnYcl0v7FCIlUGs1wnrhRCH3XP61Q6jbvglffDxytA2CdU94NqxQno/ZYc72TWHckg8GdRdBSjcq28b+w4KAZJP3fQnMGDOHhYHwS3kxg8ObOyRPE/E7a1nGFJ6WNPOKbOcKvnt6PLfi3ptniBGSMP0kqM58E2lEvkYt4PZHFQi4F/KCYSUCLCX52PVq/gkelzRIgPcRuzfAa4MSnAD7ZoubQZ6SDIjb2d6IDfJiPDlxow6Qb5AjQXTnknpyhh04bDwGD6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nLtVZBK2uK1oS5PxAZ18Ukh96EKOU5KZtz6GTGg+8k=;
 b=OIyjPU8RTmVZLbBYqWWP7zH2CQu9XEVcUxb+y//akNmGSHErIBBwX9sHVZGoPF2Zd2TCsblnwYJ+3Yy277oTmTgvQet6rq/ZeOTHg6fRxwW11vBAzarSzLdhs48xEpZqS2dtcSYUhWlUh2jb3Ss9sO4h0U5CODVhq9G09/mKHmo=
Received: from AS1PR02MB10348.eurprd02.prod.outlook.com
 (2603:10a6:20b:473::13) by PA4PR02MB6894.eurprd02.prod.outlook.com
 (2603:10a6:102:f6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 13:19:04 +0000
Received: from AS1PR02MB10348.eurprd02.prod.outlook.com
 ([fe80::31ee:1e73:e80b:d9ce]) by AS1PR02MB10348.eurprd02.prod.outlook.com
 ([fe80::31ee:1e73:e80b:d9ce%4]) with mapi id 15.20.6838.040; Wed, 11 Oct 2023
 13:19:04 +0000
Message-ID: <d6ab6509-9969-4f36-96fe-b6ce6bc74b73@axis.com>
Date: Wed, 11 Oct 2023 15:19:02 +0200
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
 linux-kernel@vger.kernel.org, kernel@axis.com
References: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com>
 <20231003-coccicheck-v1-2-07d2d900a52a@axis.com>
 <alpine.DEB.2.22.394.2310072140340.36842@hadrien>
 <5c76da14-e34e-afbd-4265-493c66e0bc60@axis.com>
 <b37c26-154a-2db9-4944-26a8aa8af7af@inria.fr>
Content-Language: en-GB
From: Anton Eliasson <anton.eliasson@axis.com>
In-Reply-To: <b37c26-154a-2db9-4944-26a8aa8af7af@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0004.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::18) To AS1PR02MB10348.eurprd02.prod.outlook.com
 (2603:10a6:20b:473::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR02MB10348:EE_|PA4PR02MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 031c0a5d-e905-4071-fb31-08dbca5ca43e
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cvfJ/M+NKcv+LMrpbaoFppRJ2MBlc/LcsFIXEDybWAu1wHw746WHLYtV+sCOpNLILLhvhb5Nv8pV0lJJqQNeC6SG9LY27I2v8CJ48fI19GMS9hkPzEMjgvjakUPSNq50eKJm7Q3dwvED3pY5sulpcXsRnynUhG9nVCL0O8jO6QX9SuVbBLuL1jA7rmNfRCndx+pa5ORSHOW6leijK8tkkfM1/gup8Vua0sttO+0nc7fKQHYWidR5l9y9UCFpiprnF4T3VCAKmad/UiZHAX0ebHCbDulFt6cimneFjq/PKYRSm9RRaDUTFmWdSgwHecThC8UDR6+86QFa1ZCYgy2qRx7S+V0FGxpp4sNyPPN9RieCgA2zK9a8Hoopd52SBpEex27HwnF6yuERvQh7fIlJ6hle2eRttTinZixjJi7MZOt/cLDUgEa9qSnhh9hposAM+HpbmtAMJYVXLP8nFCttGJIjinVzlcx41d9axdv+8zE6q6X5CGLRfYjbN/E9zSoIREk8lv9JPoalAnUzftuRhr/ahnLEDGE93xKPFYIJgaOXiBsozPAoEcCm5G37ORv9oEORoDV4Af/JwKrZTyKct7Rf+YqIlQb/00e1f2N0UOmNX4okHLo0mk7oSoGDTitVaupM3o7gJvsdNzYbQNrqIg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR02MB10348.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(107886003)(66899024)(2616005)(478600001)(36756003)(6512007)(6486002)(6506007)(86362001)(31696002)(38100700002)(8676002)(66946007)(6916009)(316002)(44832011)(4326008)(41300700001)(8936002)(2906002)(5660300002)(66556008)(66476007)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eG5aRDZJV3NBK0hLREx1VS8rNEZvazhZU3U2NTdSS25aTmRNT0pxNXI2czJV?=
 =?utf-8?B?UFhTNUdFMTcza3BGcFVuZlF5clErNVpnQ1NjSVR0THlpMWdqUGd3NFdtb3NI?=
 =?utf-8?B?NEwyOWVwU2VvbXJsdUVNWWdkRnZEUkt1elhXYWNkNzdmc2lMOXVoVWU1MU1m?=
 =?utf-8?B?WG52aGxiNHE1MVdTWGhRNVd3S2pUYU54K2kwV1dYNXVLN2sxeGM1eFdjSGpK?=
 =?utf-8?B?V2NES1AyUk5NUUd6TnNtUjREZUd1aWV0WVVlZVVDRHpHeVpXakxPbi9qc0du?=
 =?utf-8?B?MGRjQ2pHc05tcitsL3piSklmam5LdmJBcU1abW9FZ2VmN2c0YUJCZTFUc2NH?=
 =?utf-8?B?Mk51L1ZMRGs1WGZFQUtNWnNLbSsyaU41Nzk0c25nMnpYRytvN3ExYjA2cFZP?=
 =?utf-8?B?ODd1R0JCNzJYN2J5a0VZaXE2WVJEZVlTc3UzSjRxM0RDaFNOL3BuMEJnVi9X?=
 =?utf-8?B?Uzlub0M0alhiQ3c4NDFOYmJ4Rm1PMW1NeHl4TVVsWGg0NFFqK3Z2L1JLcWo0?=
 =?utf-8?B?MFl2WjR5Q3hHeGJBcjVNZ3llU2hBcGxDWUhkNlg3NXZqbGJFdkFaVHc0cGdn?=
 =?utf-8?B?Mi9VTmZGS2YxbVU5NTZPSHlCWWVyYnJLUXNEeFdPb0lTZkVjTWJSNTVreWNB?=
 =?utf-8?B?MzFCeTFsUnkybUU5TmdZYVFhaFZYdkZPeExCRnVoZzNBU3pCWXBTVGQ0ZEVw?=
 =?utf-8?B?VzFQeTMyMlEwY3IzSWdtdFArZ0lLNDJGanlyL1RsQSt2aUxDZmRRZkprN1VT?=
 =?utf-8?B?dUI3K29HNTNCcEpxdGgwc2Q1enFjWGJyS25FT0xvZWhCS3BEYVhGQksvOWs1?=
 =?utf-8?B?aTh1LzdSODRvZS8xTGlZdjdvM0pnMXF3ZFVFWGNOYjRCTU12U0FXMTJSTWVK?=
 =?utf-8?B?dkVFbmxFQmtXdDRqelZ3V2c2dGQrWDJZOHVZM2pxMmhKNFB3RklFSVY3MWdV?=
 =?utf-8?B?TnFXbHNKajFjU1FsVEIrcGtkTGUwUDFhQkxxMVZiSnFyQkpYSW96WElpeVRH?=
 =?utf-8?B?UHpXZVFTdFFQY0Vyck9IM1cwUnB3L3gzTHJBcnFYblByaUJsb1dqM2ZtVEQ0?=
 =?utf-8?B?bUlVa3dkc0h6TUQyTkRFWSs5MG1MNUN6d3c2NE0rTXNvY2RFTjlwOGVCMlFh?=
 =?utf-8?B?MzdNdUtWUDJDWm9ZbUszS0plNkVlajFsbkZsaXRpVlB1d3p5cjF3TEorcExp?=
 =?utf-8?B?U3FjV3o0S0NZMHhlS3J0U3V0d0xhQWZhelBWTHJZdEJDbEExQjlLQzFPdWR3?=
 =?utf-8?B?WVZTZm9VWDNFUG9NT1J5NWxIQWkwa3VrR0hySVJlVTROcE01MFFQMHhlUG8x?=
 =?utf-8?B?d0FZeTdLbnkyemFkYmd6U0ljU1BWNythYU9nMmZ1SzBvWTdiSjBQWUI4Vk1z?=
 =?utf-8?B?cXVHOEpDRlhiYkdES0xCNjhZSzYwUFBlaHd6R1k2Y3VTQnVTS0pNL0hnM3Zp?=
 =?utf-8?B?VDhiY2dqR3dGc09YQUdDbVNnL0swMWc1cENmQWFOb2VCTTVFeXM2NHRNRFp0?=
 =?utf-8?B?eS80blZYaVh0NHRYOFc2bmJQbm9SQnRWM0ZZNmRRWi9WcWhaTmFsL2cxN01i?=
 =?utf-8?B?clRyUEFoU00vSkl0Tkx5VW9LVWR4UU50KzdJZTN1V0ZpWHhuV0kvb3B1ZmFD?=
 =?utf-8?B?ZzNWZk5yQmNCL2ExcmJLYlUzY2tlaFlTWjdQTGZpOVJ6YXVScUdmQ2xBdWpJ?=
 =?utf-8?B?d1Y5MkU0dFZHRXZ4M0JBQlRldlVzZ2oxTlpxaWRqcHRCOEdSck5Iai9pV3pQ?=
 =?utf-8?B?YysrZldaMHM4OW96ZmZiTmZLeWpydzNjOXlZWEJXb2orNU81bjdIWnVVZzd3?=
 =?utf-8?B?ZlRDUTZ0UmJtQXNWQ3V5QzZ3bEFNK2JPSTVRQVpxM3VRZmQvM1ZUUW1iYmll?=
 =?utf-8?B?SXUvYnREdTVKZVlWai93Ri9PWm5oUVFaTVFyMnhoZTZpVjlTWnBXRUZvTytY?=
 =?utf-8?B?VFRBMU11V29sMEVLbHgyd0NVQjVjQ2t1dk9udk5CUlRrUDBnSGJrUm5kS09p?=
 =?utf-8?B?ODhYcTJqK0VRQjlobElxZU1ISVpPbm9FelFBVU1ydk0vUjVPN1FBYzQyYTNC?=
 =?utf-8?B?TXM0M3c4M0laVWJ4NnBVL1EvUnNDdDk4bHVBQVkwMmNzQ3FGL0RTV0hGT2FZ?=
 =?utf-8?Q?P7+4=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031c0a5d-e905-4071-fb31-08dbca5ca43e
X-MS-Exchange-CrossTenant-AuthSource: AS1PR02MB10348.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 13:19:04.6904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1o4JGQuVN/6i7ZfeSRXQGIaNk39ydQJnTxVu2MuX1dQl/T5NntZqpQJIXmmn7hWD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6894
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 2/2] scripts: coccicheck: Separate spatch stdout
 and stderr
Reply-To: Anton Eliasson <anton.eliasson@axis.com>
X-Loop: cocci@inria.fr
X-Sequence: 1255
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/d6ab6509-9969-4f36-96fe-b6ce6bc74b73%40axis.com>

On 10/10/2023 18.11, Julia Lawall wrote:
>
> On Tue, 10 Oct 2023, Anton Eliasson wrote:
>
>> On 07/10/2023 21.41, Julia Lawall wrote:
>>> On Tue, 3 Oct 2023, Anton Eliasson wrote:
>>>
>>>> This helps automating coccicheck runs by discarding stderr and only
>>>> looking at the output of stdout. In report mode the only remaining
>>>> output on stdout is the initial "Please check for false positives"
>>>> message followed by each spatch warning found.
>>> What is getting dropped is the spatch command lines indicating the
>>> semantic patch.  Is this desirable?
>>>
>>> julia
>> It's not ideal but it's the best compromise that I have found. The problem I'm
>> trying to solve is to be able to diff the output of two coccicheck runs and
>> notify the developer if any new warnings were introduced. That requires the
>> output to be stable. spatch is always invoked for each cocci file in the same
>> order. However, the output from each spatch invocation is not stable as it
>> examines each source file in an arbitrary order.
>>
>> My workaround is to sort the output before diffing. The line-by-line sorted
>> output only makes sense if the input is one line per warning found and that is
>> why I try to discard all output except the single line per spatch warning.
>> While the terse output doesn't tell which semantic patch file generated the
>> warning, it does usually contain the offending file, line number and a summary
>> of the issue.
> Why does the command line pose a problem for sorting?
>
> julia

You're right. I was overthinking it. Since the sorted command lines will 
be common for the two runs they will disappear after diffing.

So at this point I don't have any need for this patch. I'll reach out to 
you again if it turns out to be an issue after we have gotten the 
continuous integration check in place. Thanks for the feedback and I'm 
sorry about the noise.


Anton

>
>>
>> Anton
>>>> Signed-off-by: Anton Eliasson <anton.eliasson@axis.com>
>>>> ---
>>>>    scripts/coccicheck | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/scripts/coccicheck b/scripts/coccicheck
>>>> index 95a312730e98..7e7c44125f47 100755
>>>> --- a/scripts/coccicheck
>>>> +++ b/scripts/coccicheck
>>>> @@ -146,8 +146,8 @@ run_cmd_parmap() {
>>>>                    echo $@>>$DEBUG_FILE
>>>>                    $@ 2>>$DEBUG_FILE
>>>>            else
>>>> -                echo $@
>>>> -                $@ 2>&1
>>>> +                echo $@ >&2
>>>> +                $@
>>>>    	fi
>>>>
>>>>    	err=$?
>>>>
>>>> --
>>>> 2.30.2
>>>>
>>>>
>>

