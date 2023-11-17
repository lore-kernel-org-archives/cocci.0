Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52301C4167B
	for <cocci@archiver.kernel.org>; Mon, 27 Nov 2023 19:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=G0c8C2TS2GEJJgPc6hKSMwhBS4S3clNHQiSd9/E+Icc=;
  b=A0tFm2R+EF6a1AmwyVBpdigboosiQhyq9Obxv/kNRZ5rU6L0PKsTFZQR
   uT6oyIrVKsCIZVnBdJf24CNoSutrDPTAzf6LnqukOlOf90fY6muIh091h
   RBNwTY+LPmmasQKS/m1IQE3EVyOpJWTmTEnDqTso/+nxODH/EVIxZWqXc
   s=;
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
X-IronPort-AV: E=Sophos;i="6.04,231,1695679200"; 
   d="scan'208";a="138855364"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Nov 2023 20:56:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 02A81E0CCC; Mon, 27 Nov 2023 20:56:21 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3A88AE0CCA
	for <cocci@sympa.inria.fr>; Fri, 17 Nov 2023 17:36:50 +0100 (CET)
IronPort-SDR: 655796a1_T7F7qtj6yLr+p6lVvIVTHv2fGas636fCoJr7h4kaNUHTn4f
 HGgcimpOEO0aFOoTswnkEvqKB6wK9EULoSMdpeg==
X-IPAS-Result: =?us-ascii?q?A0EWAADvlVdlhzr3ayhaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYFmUoFRLwdQhFODTQEBhE5fiGMDhDuZQ4INAQMBDUQEAQEDBIwqI?=
 =?us-ascii?q?AYBAzEJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBASIXB?=
 =?us-ascii?q?w4QJ4VoDYJcAYEcgR4BAQEBAQEBAQEBAQEdAghhAQEeAQUSEQQLAQUIAQE3A?=
 =?us-ascii?q?Q8JAhgCAiYCAjIlBgESAgEBHoJegl8EApAQj04BgUACAosgfzOBAYIJAQEGB?=
 =?us-ascii?q?ASxD4FfCQkBgRAuAYgMAYoOQoFJRIEVJwuBCYFvPoQKFwEBg3uCaINvhHo8B?=
 =?us-ascii?q?QIygiKCdV2ONl0iBUJwGwMHA38PKwcELRsHBgkUGBUjBlEEKCQJExI+BIFhg?=
 =?us-ascii?q?VEKgQI/Dw4Rgj0iAgc2NhlIglsVDDRKdhAqBBQXgREEahsTHjcREhcNAwh0H?=
 =?us-ascii?q?QIRIzwDBQMEMwoSDQshBRRCA0UGSQsDAhoFAwMEgTYFDR4CEBoGDCcDAxJNA?=
 =?us-ascii?q?hAUAzsDAwYDCzEDMFVEDFEDax8WIAk8DwwfAhseDSclAjJCAwkKBRICFgMkF?=
 =?us-ascii?q?gQ2EQkLLQMxBiAEDgMZKx1AAgELbT01CQsbBj4CJ6J7AgkGAQFXIxMBJV5AZ?=
 =?us-ascii?q?RYMEgySeIMAkA+fFoQXgV+fLwYPBC+EAYxzhnOOXINCLodIkEogqAsCBAIEB?=
 =?us-ascii?q?QIOAQEGgWM6SYETTSMVgyJPAxkPjiCDeI96QTQ7AgcBCgEBAwmIbjSBQAEB?=
IronPort-PHdr: A9a23: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
 QQTYoF9ahnt5V5WCg==
IronPort-Data: A9a23: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
 Q==
IronPort-HdrOrdr: A9a23:C0yiM6yUQzy3xx64Cvf5KrPxz+skLtp133Aq2lEZdPULSKGlfp
 GV9sjziyWetN9wYh4dcB67Sc+9qADnhPpICO4qTMqftWjdyRGVxeRZgbcKrAeQeBEWmtQtrZ
 uINpIOc+EYbmIK8/oSgjPZLz9I+rDunsGVbKXlvg5QpGlRGt5dBmxCe2Om+yNNNW577NYCZf
 ihDp0tnUvdRZ1bVLXzOpFDNNKz1eHjpdbDW1orFhQn4A6BgXeB76P7KQGR2lM7XylUybkv3G
 DZm0ihj5/T+M2T+1v57Sv+/p5WkNzuxp9qA9GNsNEcLnHJhhyzbIpsdrWetHQeof2p6nwtjN
 7Qyi1Qd/hb2jf0RCWYsBHt0w7v3HIH7GLj80aRhT/ZrcnwVFsBer58rLMcViGcx1srvdl63q
 4O9XmerYBrARTJmzm4z8TUVjlx/3DE7kYKoKo2tThyQIEeYLheocg050VOCqoNGyr89cQODP
 RuNsfB//xbGGnqI0wxhlMfgeBEY05DXitvGiM5y4+oOnlt7T1EJnIjtYIidixqzuN+d3FGj9
 60R5iA2os+C/P+VpgNd9vpcfHHe1Alfii8QF56AW6XY53vaEi93aIfpo9Frt2XRA==
X-Talos-CUID: 9a23:fCWHLGHgiAtDuYmRqmJp5BUvE4MXUUH6wXjCc1bpCThlb4CKHAo=
X-Talos-MUID: 9a23:DmR9OwgNogZFAeRsnjc6b8MpDsRE2omKI0M3k7oD5+udOBMgBw2ig2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,206,1695679200"; 
   d="scan'208";a="71828756"
X-MGA-submission: =?us-ascii?q?MDEHZ8GRCU9QwAo2GXYcSGrmkKPHb8nlSEGIRc?=
 =?us-ascii?q?XMknvtRNfjYcuaHFiFgXQeJWpVRQBegaWbHxD+M0tlyPm9A8PVPSbZ14?=
 =?us-ascii?q?fXgnZRzu9MA4GUd7ZzOnfXgaruCOtVk/BVEbiexUIAoqKYTqlWY9krpv?=
 =?us-ascii?q?n/1JzSoHQTHN2GSCL8TLXHrw=3D=3D?=
Received: from mail-am0eur02on2058.outbound.protection.outlook.com (HELO EUR02-AM0-obe.outbound.protection.outlook.com) ([40.107.247.58])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 17:36:49 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZQJYiLEiy6N2UddRfy0a2ZR9jBHeyqHz+yJlaJ0gIl8k/bOeXzteqDjhx414/l2PjcWWP5Bkd+wxxaukqXKOoKhIzrBi7STdA524vpjLNqKurxvCeGFH0P8/hpAZaS/mFyzsgm5OMGQPXzatg36A1a/B3TkOF5wYzWFJTTpHh0sEtqm6TY00h8/jyXPBg3wscvjCRMlL/pB5dDRHkePcEmwdwUPp0YD+ehP+FXBrCsiRGDTnLEmCEFZSJJdBV+7Htd3igmbcSRkmrVbIEbCttvVhaM+KGggWM/23CRnZ8HLIa5eRPFkt8lCE/yunAcSGsx8oJV5Fa5QPkne9Ep0Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0c8C2TS2GEJJgPc6hKSMwhBS4S3clNHQiSd9/E+Icc=;
 b=ii9mbbfHgmZyvcAVuL+j0fr+JibG4w1zeyGgiTEAvOL19mFrhxjxEUQrZ685z2rntBJIbIP3QMTZrJbvH7lJ04BDxoCgaIGIer7MLwbM2GP3XUHYNt78KZ4LmPxDie/rgK4QUC1e5evtGyrWy+K4+ss3RKKYFe+Tf3T5BucXg0JkDMG+DknYTiMLnn2tJqRuvfHZrlA7ofYD2Bu2Wt+x2KUMDPUDSx9c4/WXiMJ8CdxFeNQpu0HR5ZSvbTE3OZ/7ka/IjenVy8UDSb9P9I4DhnplesDMZgwItnjwim2cNOeDhTdS1a+SBkjfMFctRc8WPlBc8gxYStrTWew8JKjROg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0c8C2TS2GEJJgPc6hKSMwhBS4S3clNHQiSd9/E+Icc=;
 b=KtfrHs7PwRXqq6prRc97j0QAHQbbgOY5H5cL2TwCwcJxLTuraiNMmKJ05hAYwC5fjUyikoligLIbHVbDR6CELKTSVWyrHSQDhvdbdoCk7aT4Zq45KBaUESRhZmkUZdhWvJ4U+wr3uA6WNw2EkQn7fp85fI3mVOXV437sx1hkjdI=
Received: from AS1PR02MB10348.eurprd02.prod.outlook.com
 (2603:10a6:20b:473::13) by DBBPR02MB10793.eurprd02.prod.outlook.com
 (2603:10a6:10:53c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 16:36:46 +0000
Received: from AS1PR02MB10348.eurprd02.prod.outlook.com
 ([fe80::32dc:a85e:a94d:8a7e]) by AS1PR02MB10348.eurprd02.prod.outlook.com
 ([fe80::32dc:a85e:a94d:8a7e%7]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 16:36:46 +0000
Message-ID: <0cee25a2-29f7-4481-8ab9-618f8491bf5b@axis.com>
Date: Fri, 17 Nov 2023 17:36:43 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Julia Lawall <julia.lawall@inria.fr>,
 Anton Eliasson <anton.eliasson@axis.com>
Cc: nicolas palix <nicolas.palix@imag.fr>, cocci <cocci@inria.fr>,
 linux-kernel <linux-kernel@vger.kernel.org>, kernel@axis.com
References: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com>
 <20231003-coccicheck-v1-1-07d2d900a52a@axis.com>
 <978265928.4471013.1698960475973.JavaMail.zimbra@inria.fr>
From: Anton Eliasson <antone@axis.com>
In-Reply-To: <978265928.4471013.1698960475973.JavaMail.zimbra@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0065.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::23) To AS1PR02MB10348.eurprd02.prod.outlook.com
 (2603:10a6:20b:473::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR02MB10348:EE_|DBBPR02MB10793:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a5e188-83ee-4c6e-eb1c-08dbe78b63c9
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kA11kmjbO5CYadlom9GEI7I6sMQvHC8PTuyCaZwlDbXfF+WPGzD+YydKH/bDr7loEfubnjFmg1x6D97N+fWGC3BLjQB1heuEGL6oEjZZ3PMbDD2yWJc78lt1qCpiJ7gOqsXFlD6VZskfdn+ucXK1qXP/WU5qZPMyosMwR/U4s1fBchx38htnq1zUlCFf2mq20YyqRuOqeVgLUvR9HJ5TPq6NweiclwZsWmZ3Q/D/j0LpL+VpIy75Bznrwa1rHrLqvA4YBtCneGR9vqGVuetKL9crPr96IiwBm1rdOkhPTxDdydrX8UVpOtAilICSCgvzzuowbo4lFDypFzZAj40Z4q1q8y9eUCAmpawIE42GXsZTMyYbrP9jUmNDBYYMVrD8jOxbdcH3U4iY3MN9bIx0NteaSKjRwA+RD2yaDA4JR5AwYuQo3dmRICVCawC5ZgKKQLywO9ToyEszpqAAkiQ4w5NWDZeHzd4Hkq76QPL1Gp7KBHQIV0rDgKlfX9Kq1tMeoy/RkIgf/3QRyl2KlGEa1YfpvlbdWj48kj/jo1kNEZv6NaR74FEqePm27lVgRG+FQ+QxBtJ/QcJMdwng3EvvBGdVTwVv77q7LgWA1uowypzyPEI2T2HjHwW/8kTZl2SVmzc+TZxae0tH8VgAKcB0gQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR02MB10348.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2906002)(41300700001)(316002)(107886003)(54906003)(66556008)(66476007)(6636002)(36756003)(8936002)(8676002)(66946007)(110136005)(4326008)(38100700002)(478600001)(31696002)(5660300002)(31686004)(6486002)(83380400001)(26005)(6512007)(66899024)(2616005)(6666004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFU5dndBSDVFYnF2RTA1Y0hNc0sxdGlpVXhqRGpOeHhLMGF5eVQ4bFhxdVox?=
 =?utf-8?B?MHJpM0V3Nmx1TTlCSnZpNlpLVytnVnkzZnpVOGZmUGVWTFd2RU94NmFZeEZu?=
 =?utf-8?B?TC8xS1JnN1dnT3k4QjhydStNZGZFQ1hKUzY2ZHR4a3ErdnVla1ZvTDVhc1hG?=
 =?utf-8?B?TDZjMHAwd2I5QlA2N3cwMFFpQ0xrNDVYQnVZZ0JCUTA0elhjNmhhd0hGa0dH?=
 =?utf-8?B?OHV6QjVrTVNwZm1heSs4TGluU3dVSmtIMk5Xc3VZdDFhK3ZLUndwUDB1RXhJ?=
 =?utf-8?B?R01ObkZBZFE2N1pBclROWHplMC9xeU0xanYxWG9NRFRnNjVOZ2FkazlUT1R4?=
 =?utf-8?B?OSsyaFgwODYxWTBzY0tYY1AxUi9jRXB3ZCtLNW5VaWNhMktIOWZlY1pzcnVq?=
 =?utf-8?B?aldhV0tmMkRWZDQyQ0Y5QzNIMW05U1d1aS9WTGduNWlOc1NHczhyWjVOK0U3?=
 =?utf-8?B?U2hqdjJFbnprNDh4RzBwVHYydjkwZk1JLzMxcW1iaWJOVks5d2dCU3VYTllL?=
 =?utf-8?B?ZW4rbDd4UmRVeVZ2MTBDTjBUM01PRUJPZ0JmaUkzc3FKSGFnQzdjbE5DTFAx?=
 =?utf-8?B?dXJjdDZ0T290WjZxM1B4YWYzNHdPZDdZUnNLWGEwSEpoKzljNStkZmRJUjFJ?=
 =?utf-8?B?YlBXbDdrS0ljSm5LSlE1bkpjV0g3Vng4UTMrblFPV0lvcThjd0Z3RDhFY1h3?=
 =?utf-8?B?aEcxKytXbUpvK3BYSWErZHRjZEJ1a01tV1U2bzM4MHArZVJMVVlyQ2V1NUJ6?=
 =?utf-8?B?Y2cwdzk0RGJIZm9yanRLendud2RQc0Qza0xaSFM5QkxJUDN6d09CV29Rckgv?=
 =?utf-8?B?SWZXbFZFV0thTnFkQVhZSk01VzM0QXNkOHdQQ1RrUk5yVXFpU24yZWZDZnZi?=
 =?utf-8?B?UUR0czRUdTdXU29UOTVLT0lXalhPdjhFY1pDcXVwL0taQTZrSzdzd25UTGxq?=
 =?utf-8?B?SmxPMms0blBsZkYvVFVveTRhUDl6MklncTR1SVN4T1VmSVZiS1NETUV6MHc1?=
 =?utf-8?B?eTNNZTJaUGg2ZnlYQkdpTkJnZy9LYUgyQ1NUTkdsYnVWOW5DWmplUzVpejZj?=
 =?utf-8?B?VjF2aXQ4RjV5eVcrMTI2eW9MekxJTzNQZEgzUFNlNUd4NlFrMk5GRmZYNTlN?=
 =?utf-8?B?T3dkeU1VL0xtS3ZrTmU5WEJCc1FvcElGSS91bXZjOTBBMSsvRzVkZXdoNjI0?=
 =?utf-8?B?TldkdUtPYzIvQ0g1U0VEcGxtK0kvajNiYjBsTU5xZ09leTRuQ21abzRwYisr?=
 =?utf-8?B?MURMUmFJQ0VxblA5eTdNeDJnL3ByWVhpSkRqVEg0OGZzTDZrRzBZUlNvdzlP?=
 =?utf-8?B?ZDZsSlk3Rm9UbkppNjZ4UUIyeFRQTHZFcGRjenlWSmN6bSthcXQzcHlrWEJH?=
 =?utf-8?B?bHZBcm9FTm9lM1QyaE1oRUJ6TXEvOEQva2h0OEczZWx6OC9mZWVPblpmTTN5?=
 =?utf-8?B?QUI0UmZuNGNaK3NiYVlnSHBIUTZHeld2aExzQ1ZmSHFwSCtjZGRKWmloRzVu?=
 =?utf-8?B?Rk5IOEw2QTM2YjZLQ3JqYWhHam5sNnp0VkpmVVEzSVlRWmNRK2J5OFBTUjFY?=
 =?utf-8?B?UHM2SDJsZ3RaL0ZDMFJFSEdiTEJYUWlrNjZMMVJOUmRycTJjWE1xZW1pc1RZ?=
 =?utf-8?B?cWdxVnNRSTdIejVod1NvTXNEa1RCSk1ETm1zWjVnR3ZNSHU1cmw3MFBrdXFN?=
 =?utf-8?B?SHdaeHFBVEZkTWtYVUtkNFlHT0dYVmlMamtTL1ptRjRZTFRkdmg2Wnhtc3Ey?=
 =?utf-8?B?c1liUkRWYWlCbTRJYnhrWHpWc1R5aSs1NU4wS09jSHhRMW5ZWFFmQnp6ckZ1?=
 =?utf-8?B?TkNqM2YwSTBZR3BsaVFOeGxQT0l3RWlsN0dLbUZ3SzF3Rm9QRjd0QXIvOTBs?=
 =?utf-8?B?YWQvcUVFM3VJOG5qK3FwZE05bHdhVnY5UHA3VjFjWDMyQXFpajM1OXRQSG41?=
 =?utf-8?B?SU5TL2dFeUZkWmJjNlpYbCtDSFhvOGdzSzZCcTZnR1hNMU1PclhTZzFTc2VY?=
 =?utf-8?B?bUpES3NxNy9Cb0hFMjNDc2RKZEJ5UFZyaUlseElRMEhleXA4UElCcXZPQmhy?=
 =?utf-8?B?L1lCRGpwRWFZQUZxSWNFVGdjcXR3WFFaMC9xb055WE10Y3MzN1JCRmhlMzMv?=
 =?utf-8?Q?pxstbpwCRqQHo+CtDOjR/4G33?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a5e188-83ee-4c6e-eb1c-08dbe78b63c9
X-MS-Exchange-CrossTenant-AuthSource: AS1PR02MB10348.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 16:36:46.4751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fxeaptECSxqxBj4lBf0A5umjpTADS9DroLrwD1CDnQ5r4OVx61pj7sGprotNxmt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10793
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 1/2] scripts: coccicheck: Return error from
 run_cmd_parmap
Reply-To: Anton Eliasson <antone@axis.com>
X-Loop: cocci@inria.fr
X-Sequence: 1340
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/0cee25a2-29f7-4481-8ab9-618f8491bf5b%40axis.com>

On 02/11/2023 22.27, Julia Lawall wrote:
>
> ----- Mail original -----
>> De: "Anton Eliasson" <anton.eliasson@axis.com>
>> À: "Julia Lawall" <Julia.Lawall@inria.fr>, "nicolas palix" <nicolas.palix@imag.fr>
>> Cc: "cocci" <cocci@inria.fr>, "linux-kernel" <linux-kernel@vger.kernel.org>, "Anton Eliasson" <anton.eliasson@axis.com>,
>> kernel@axis.com
>> Envoyé: Mardi 3 Octobre 2023 16:25:14
>> Objet: [cocci] [PATCH 1/2] scripts: coccicheck: Return error from run_cmd_parmap
>> Exiting on error breaks the chain mode. Return the error instead in
>> order for the caller to propagate it or in the case of chain, try the
>> next mode.
>>
>> Signed-off-by: Anton Eliasson <anton.eliasson@axis.com>
>> ---
>> scripts/coccicheck | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/coccicheck b/scripts/coccicheck
>> index e52cb43fede6..95a312730e98 100755
>> --- a/scripts/coccicheck
>> +++ b/scripts/coccicheck
>> @@ -153,7 +153,7 @@ run_cmd_parmap() {
>> 	err=$?
>> 	if [[ $err -ne 0 ]]; then
>> 		echo "coccicheck failed"
>> -		exit $err
>> +		return $err
>> 	fi
>> }
>>
> I tried disabling OCaml in my version of Coccinelle and then ran make coccicheck with this patch.  But I didn't see any improvement.  On the other hand, it keeps going if I just remove the exit line entirely.  Is that what is wanted?  One can still see the coccicheck failed message.
>
> julia
>
Hi again!

It only makes a difference in chain mode, I think. Without my change 
coccicheck stops after encountering the first semantic patch that 
doesn't support the patch rule (see the console output below). With the 
change coccicheck keeps going with the next semantic patch which is what 
I expect. Do you see a different behavior?

However, I found now that with the change it gets harder to cancel 
coccicheck. A single ctrl-c is no longer enough. I basically have to 
hold down ctrl-c until all the script layers have returned and exited. 
So that's maybe not ideal.

> $ git describe
> v6.6
> $ make coccicheck MODE=chain
> You have selected the "chain" mode.
> All available modes will be tried (in that order): patch, report, 
> context, org
>
> Please check for false positives in the output before submitting a patch.
> When using "patch" mode, carefully review the patch before submitting it.
>
> /usr/bin/spatch -D patch --very-quiet --cocci-file 
> ./scripts/coccinelle/api/alloc/alloc_cast.cocci --no-includes 
> --include-headers --dir . -I ./arch/x86/include -I 
> ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi 
> -I ./arch/x86/include/generated/uapi -I ./include/uapi -I 
> ./include/generated/uapi --include ./include/linux/compiler-version.h 
> --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 14406 files match
> /usr/bin/spatch -D patch --very-quiet --cocci-file 
> ./scripts/coccinelle/api/alloc/pool_zalloc-simple.cocci --no-includes 
> --include-headers --dir . -I ./arch/x86/include -I 
> ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi 
> -I ./arch/x86/include/generated/uapi -I ./include/uapi -I 
> ./include/generated/uapi --include ./include/linux/compiler-version.h 
> --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 44 files match
> /usr/bin/spatch -D patch --very-quiet --cocci-file 
> ./scripts/coccinelle/api/alloc/zalloc-simple.cocci --no-includes 
> --include-headers --dir . -I ./arch/x86/include -I 
> ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi 
> -I ./arch/x86/include/generated/uapi -I ./include/uapi -I 
> ./include/generated/uapi --include ./include/linux/compiler-version.h 
> --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 2146 files match
> diff -u -p a/fs/direct-io.c b/fs/direct-io.c
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -1128,15 +1128,9 @@ ssize_t __blockdev_direct_IO(struct kioc
>      if (iov_iter_rw(iter) == READ && !count)
>          return 0;
>
> -    dio = kmem_cache_alloc(dio_cache, GFP_KERNEL);
> +    dio = kmem_cache_zalloc(dio_cache, GFP_KERNEL);
>      if (!dio)
>          return -ENOMEM;
> -    /*
> -     * Believe it or not, zeroing out the page array caused a .5%
> -     * performance regression in a database benchmark.  So, we take
> -     * care to only zero out what's needed.
> -     */
> -    memset(dio, 0, offsetof(struct dio, pages));
>
>      dio->flags = flags;
>      if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ) {
> /usr/bin/spatch -D patch --very-quiet --cocci-file 
> ./scripts/coccinelle/api/atomic_as_refcounter.cocci --include-headers 
> --very-quiet --dir . -I ./arch/x86/include -I 
> ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi 
> -I ./arch/x86/include/generated/uapi -I ./include/uapi -I 
> ./include/generated/uapi --include ./include/linux/compiler-version.h 
> --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> virtual rule patch not supported
> coccicheck failed
> make[1]: *** [/home/antone/git/linux/Makefile:2005: coccicheck] Error 255
> make: *** [Makefile:234: __sub-make] Error 2

