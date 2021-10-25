Return-Path: <SRS0=o+tk=PN=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1793EC4332F
	for <cocci@archiver.kernel.org>; Mon, 25 Oct 2021 19:42:51 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C716124D
	for <cocci@archiver.kernel.org>; Mon, 25 Oct 2021 19:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 59C716124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=seco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3ANsP9T6KszXIXSd94FE+Rx5QlxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHDq1mgi0GdVxmpMXWyDMvyPN2D1c49wa9zko0oF7cPWm4NqS1BcGVNFHysb8?=
 =?us-ascii?q?5KdbTi6Bh6tZH3KdpWroHqKXqzyU/GYRCwPZiKa9kjF3oTJ9yEmjPjQHOekUoY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWHULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIsi?=
 =?us-ascii?q?0l67yNEwMWL/bewaU4pZUc/H40l4T/WprjPx9baREAatUo2zhc9RZw9JGvp31T?=
 =?us-ascii?q?hgvM7fkmeIHUhAeHTsW0ahupOaceCnn2SCU5wicG5f2+N1lC0o9PKUR4O13AH9?=
 =?us-ascii?q?D77obJSoLYxTFgPi5qJqxS/J3l8otBMbuNYIb/HpnyFnxBvErR53Fa6rP7N5cm?=
 =?us-ascii?q?jw3g6hmEf/YIchfdjtraBXJZgZnNVIeCZZ4l+Ct7lHzeiNZpEmSo6Y57Gz7wwl?=
 =?us-ascii?q?40byrO93QEvSGSINOmVuKryTN+H70BA0bMvSQzDOE9jSngeqntSjgRYYWBZW38?=
 =?us-ascii?q?fllhFDVzWsWYDUcWF22rfi6lma+VtNZJgoO/SEttsAa/0isScLVXR2zpHmDpVg?=
 =?us-ascii?q?XXN84O+Ez7gCAzuzQ7hSSD24DZjpAbtU8s4kxXzNC/lSJhdLyGTt3sPufTn+d8?=
 =?us-ascii?q?6idqT+/IwARLGkIZDNCRgwAi+QPCqlbYgnnVsxkHOuxj8bpFCrtmmDMrS4khrx?=
 =?us-ascii?q?Vg9Rj6klyxnif6xrEm3QDZlRdCt3rY1+Y?=
X-IronPort-AV: E=Sophos;i="5.87,181,1631570400"; 
   d="scan'208";a="413190"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Oct 2021 21:42:49 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 49558E0018; Mon, 25 Oct 2021 21:42:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D79A8E0015
	for <cocci@sympa.inria.fr>; Mon, 25 Oct 2021 21:42:44 +0200 (CEST)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=sean.anderson@seco.com; spf=Pass smtp.mailfrom=sean.anderson@seco.com; spf=Pass smtp.helo=postmaster@EUR05-AM6-obe.outbound.protection.outlook.com
IronPort-PHdr: =?us-ascii?q?A9a23=3AK0lD/xdx/GtZs6n+q2d6sR66lGM+NN7LVj580XL?=
 =?us-ascii?q?Ho4xHfqnrxZn+JkuXvawr0AWRG9SCoK8bw8Pt8InYEVQa5piAtH1QOLdtbDQiz?=
 =?us-ascii?q?fssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBBr/KRB?=
 =?us-ascii?q?1JuPoEYLOksi7ze+/94PPbwlSgDexfLx+IRW0oA7MqsQYnIxuJ7orxBDUuHVIY?=
 =?us-ascii?q?eNWxW1pJVKXgRnx49q78YBg/SpNpf8v7tZMXqrmcas2S7xYFykmPHsu5ML3rxn?=
 =?us-ascii?q?DTBCA6WUaX24LjxdHGQnF7BX9Xpfsriv3s/d21SeGMcHqS70/RDKv5LppRhD1k?=
 =?us-ascii?q?icKLyA3/mHKhMJzgqxUrg6uqRNwzIPPfIGYNuBzcr/Bcd4UR2dMWNtaWSxbAoO?=
 =?us-ascii?q?7aosCF/cPMvhCoIn7ulADsR2+ChSyC+P10T9IgXn21rA93uQ6Dw7JxgogE8gUv?=
 =?us-ascii?q?3TSsdr6Kr0SUfuyzKnO1jjDdO1Z1iv66ITSbh8hpvSMUKt2fMHMxkYhCxnLgU+?=
 =?us-ascii?q?MqYz5ITyVzOINvnCU4ed8WuyhhHIrphx/rzWywsoihIfEi4wUx13K9St0wpo5K?=
 =?us-ascii?q?N2lRUN5YdOqEJteujyHO4V2TM0vXmJltSk6xLAGv5OwYSYEyJMixxHFavyHdZC?=
 =?us-ascii?q?F4hz5VOmPPzh4gnVld6+hiBqo90iv1PH8WtO10FZRqCdOj9rCtmgV2hHc9sSLU?=
 =?us-ascii?q?OZx8luj1DqVyQzf9PtILEI3mKbDK5Mt3qQ8mocXvEnDBCP7m1v6gLWLekgm5+S?=
 =?us-ascii?q?l7fnsbK/8qZ+GLYB0jxnzMqQwlcy7BuQ1KgcAUGaH9+ig1LDv5FH0TrJLg/Evl?=
 =?us-ascii?q?anWq47VKd4cpq6kHw9ayYEj6wu5Dzi7ytgYhWMHLFVZeB2Zk4fpJ1DOIPf+Dfu?=
 =?us-ascii?q?lhFSsjStrx/TBPr3mAZXBNGTMkLDkfbpl6k5czhQ8zcxH6p9bFr0NOu//VlPzu?=
 =?us-ascii?q?dDCEBM1LRa4zuTkBdll04MRQ2OPAquXMKPItl+I4/oiI/KSa4APvjbxMeIq5/j?=
 =?us-ascii?q?zgnAng18dZq6p3Z0MZXCjAPtpP0KZbWDwjdcGFGcGphA+Q/DyiF2eTT5TYG6/U?=
 =?us-ascii?q?L475j4nFI2mDJzORputgbyExCe0BIdaZmFAClCWEHfnbZ+IW/kWaHHaHsg0mTs?=
 =?us-ascii?q?PXrmJSok71BjouhWp5aBgK7/v9yQe/bvl2NVv/OrV3UUp+DVySc2b32yXVGZyt?=
 =?us-ascii?q?ngFTDhw16d69x8ugmyf2LR11qQLXedY4OlEB19S3XH01OFxDJb5XQeTJ79hqX6?=
 =?us-ascii?q?Lf+/+XHQYa4x0xNUDJUFgB9+lkxbPmTKwBKMYnKCKA5py9b/A23/2JIB2zHOUj?=
 =?us-ascii?q?cHJanE9T8BIc2ahg/wnnzU=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AozRfBa/2ZrG2TgRWbUBuk+A/I+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZhyYlFPBw8Pre4MjztCWE9Qr5N0tApTntAtjlfZr8z+8N3WBVB8bGYOCEgh?=
 =?us-ascii?q?rTEGgB1/qA/9SIIUSXnYQxusldmsNFaOEYY2IK6vrS0U2RFNs6xtmLtISln/3X?=
 =?us-ascii?q?wXsobSwCUdAD0+4CMHfhLqQMfng/ObMJUKGR4cJbqyHlQGkYYoCAH3EAZeLEvN?=
 =?us-ascii?q?GjruOZXTc2QyUq7wGSgSjt0aP1H1yjxx8baS5G3LtKyxm7r+Un3Mmej80=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0C5AQASaxphh04WayhagQmBWYFTUX5ZJ?=
 =?us-ascii?q?kOER4NJAQGFOYVpglOESI0+A4hhgS6BJQNUCwEDAQ0xEAQBAYUYgjcfBgEEMAk?=
 =?us-ascii?q?OAQIEFQEBBQEBAQIBAwMEARMBAQEBCw0OCDokhWgNgjUihAQRFQgBATg0AiYCN?=
 =?us-ascii?q?DgIAQEegk8BglUDLwECmyIBgToCixmBMYEBggcBAQYEBIJRgl0YWoFaCQkBgQY?=
 =?us-ascii?q?qgn6GA4RyN4FVRIE8DIhBgkqCZIRCoz+dTS0HgyuBMQYLiHuUAAYPBSaDUwGSC?=
 =?us-ascii?q?ZEYihqGQapSAgQCBAUCDgEBBoFgZoEuTSODOQlHGQ6OOYNZhFmGIScwOAIGCwE?=
 =?us-ascii?q?BAwmJdQEB?=
X-IPAS-Result: =?us-ascii?q?A0C5AQASaxphh04WayhagQmBWYFTUX5ZJkOER4NJAQGFOYV?=
 =?us-ascii?q?pglOESI0+A4hhgS6BJQNUCwEDAQ0xEAQBAYUYgjcfBgEEMAkOAQIEFQEBBQEBA?=
 =?us-ascii?q?QIBAwMEARMBAQEBCw0OCDokhWgNgjUihAQRFQgBATg0AiYCNDgIAQEegk8BglU?=
 =?us-ascii?q?DLwECmyIBgToCixmBMYEBggcBAQYEBIJRgl0YWoFaCQkBgQYqgn6GA4RyN4FVR?=
 =?us-ascii?q?IE8DIhBgkqCZIRCoz+dTS0HgyuBMQYLiHuUAAYPBSaDUwGSCZEYihqGQapSAgQ?=
 =?us-ascii?q?CBAUCDgEBBoFgZoEuTSODOQlHGQ6OOYNZhFmGIScwOAIGCwEBAwmJdQEB?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397329689"
X-MGA-submission: =?us-ascii?q?MDH1OBJntz/1qu78t8qYR79pd9CdG06kk7NN4h?=
 =?us-ascii?q?3EcGvy6c2xp3h9lEVY8uDwuGuk8Jko8nD/KamYJ/8MahlkY8e4F7u5GF?=
 =?us-ascii?q?61n0DVGgmZXWXRXcWVMoCk3DSvdfO7aHI+HGWzE+vMSn1enZoUJYL90W?=
 =?us-ascii?q?30o3J6POHY4XJ2ddXskfDpdA=3D=3D?=
Received: from mail-am6eur05on2078.outbound.protection.outlook.com (HELO EUR05-AM6-obe.outbound.protection.outlook.com) ([40.107.22.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2021 21:42:43 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVP2+ahKwVlxsoc3XLE9AcYeTkxsNtMTQJ/xU9l72Ioa+lzSL5KCHytCvr3MkwSKldKAVS8bn+PJpaGF05z+MCG4IEdk/TOaRlf7gUxiyDgG6WbPLXvEfHRYHjrxternfQnALOTiJJrG/icO+KtpvFtYMHJH1gnCmjpM4IQbTS7mPldro9dnmRCYZQdME0YVp3M9za/yhmeoTJNrIBw0t5s9GmoO/dTKwXQc3p9Gc/skZ70eqICXnhY27e9bW9kfd55pZEeMxh4LloHNzhhTsOIoVAaadMfHHqZ5bGtd+4VxwCbKgLOye4t683xLUB9vDAEt3ldpMoawGSEtqvN78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs72H5mpHiNkswhNs0mk1g/zU7F+1DNfB50h8u/E1DM=;
 b=g6gbwH1Q95LIC5cAYXfEr2sfXYrlEAiu23QAt93Wr709GCnEE/kjK8c2xI9jrU6vjsWBNBSnBJA9uO0E1wZ4lMQA6YR2VLvdzn1zHXmuCuU+Yb4w9T4U6cjQySfgzDKhJmhlJLm4i/Sghq1EprPO9bLzitIxTlWm70n4QOnLrFCJnCrEbHje29EAewIgbkQoalBYniUSJeof8rr71m5qozCvvrvrR8eIuHi5v9ih3GkGmYbC7+61Hd622k2MFOQMlgtnknFQmLLaYVY7EGejmH5Tzzg5NsWKdM6NgseKw1CeT/HTAr+W1nujEuJJHeovajOz1jP3wGLq5OeXqhYXiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs72H5mpHiNkswhNs0mk1g/zU7F+1DNfB50h8u/E1DM=;
 b=3KmpROf9KcFapSi6g/8vvgpVElpjaK0Oj2ktOwiyWXPvAR9mzBNvrdS5RCaFJpHRlPCA3o4OcGCosubSDqzrac3ZDo32eZ7925Rx6p3ZztCn5dQbD+ToLS007kWv5TomkkwvCWWsgkw6c/VMT7mYyLA5k6/amZmMq4ztjAVJn4k=
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB3516.eurprd03.prod.outlook.com (2603:10a6:5:5::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Mon, 25 Oct 2021 19:42:41 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 19:42:41 +0000
To: cocci@inria.fr
From: Sean Anderson <sean.anderson@seco.com>
Message-ID: <3b48efa4-4bff-0990-8b21-fffc14cd47e1@seco.com>
Date: Mon, 25 Oct 2021 15:42:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:208:256::18) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0013.namprd13.prod.outlook.com (2603:10b6:208:256::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend Transport; Mon, 25 Oct 2021 19:42:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bba711af-5112-4d59-51d7-08d997ef9bcd
X-MS-TrafficTypeDiagnostic: DB7PR03MB3516:
X-Microsoft-Antispam-PRVS:
	<DB7PR03MB35167AFCC641B57D8DB6C94596839@DB7PR03MB3516.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tqVnXZEdyMkMbHystnr3FAcH/fxDjAQvuWpt6oQbiVoEXB6BwyOm8O0rtJQ7y7igz+p9ainQCXSKZJKu8Nzi+DeVvnl0AOIw+RAVDXpJMUpbC9vQU0V8QgQ6iqtL+vaYyBki6jFLho3CmiJ5i8SYvbs3a0gWhXo8RuAqEGl9/HmXblDIlT8amNvqAhSSs/kuGIYBAMFZqu3JqC1ZTlp6cL/EVAT4NQH7lvBx4ZwFhDmS+wqbXlfQ6Z8dmkER8mTzj808vdv7tU7iPUJBMYMLtr8ZA2lawG4B18Vsl/YFxtUgFFDY4QOau+5FJtIWQkq3Od4KLcyyezhc1OiV6gsnStlHd1K+uS7k1UctH1+8B/kofgUQsoT1u9+95NnC94nOzY2csLwKES9vdkeqtjDI/ThCUsqvYPMCz6+NEMqY/LH0aotlCNzPLuVed35F9zyeazFUmB55FXmqQOw0YqT7WkhlHy05XYMqDiCz9frsg2+M18gy2eZfE2vvaDhhxP6Awn1g59rhG6riXzCo8K9VO8L/DiNMGNSWD5+V9NnJ/+OVR0Mi3sGbIvBuTiHbnts+/vYuvO0Uxl0uNLoYDTaXD9sIYWeK3Yg/NTm1Qmc7j5sXsrJTfQXMSi2a2wfso6G4G4C/SC14iCpQr4wO8zU3/urM6HWyVTmwwa97IIegtXpf7YU5m7TR/xej9E8ZsmMvW5qItBu6M3EKO+zThC3LqFz849oEjtYm2S4kQFCWPiCyubLyw5vjSH2PXQntKLNvf9FnnbYqRrpN7+o4MUthQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(31686004)(558084003)(26005)(52116002)(508600001)(8936002)(66946007)(316002)(6666004)(36756003)(5660300002)(16576012)(8676002)(86362001)(38100700002)(38350700002)(6486002)(186003)(31696002)(66476007)(3480700007)(956004)(2616005)(2906002)(66556008)(44832011)(7116003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmlJRDZjL2NEL1hYVUdLZkhwM2svRWZyMDUvRGduZTA5VDNMbmVSNm03cmUz?=
 =?utf-8?B?dER6Tm9LeUljLzBFUlJNeXNGbzBrNjF2VitUT0NhdnI2WnoyUnNpZmsvdTlZ?=
 =?utf-8?B?Ni96Z3grRU1OTTVPcEcwZWNEZWxDeXlmWHhXK3FWb0lmT0VSRkxpSXRqWFhw?=
 =?utf-8?B?UVRtbXkvY1daRHJKeEhJVG9PeFArV05PZnlBVTNLN3RkcXpZQlVBQ1FrZ3NQ?=
 =?utf-8?B?emNkQng4T0VlVStNLzRxVlU5elovZXV0U2ZhVFBZcnFhRENPZjM4cm9RWFVK?=
 =?utf-8?B?VVJScjl6OVZYVFozKytUdmZGVzlrT1BOTWRNdVZ0ZFIxd1d4OHRWendvaFE1?=
 =?utf-8?B?ZGlFRVVjTDhjK1BrOWpjYXV0dkl0RW9LbGlsM1J4RkowbUpFV1dyV1NqZGRa?=
 =?utf-8?B?TjFOLzVZbERyQ2kxdGVEMjhiSHR6aXhMN2VkcDkxWHBqQkVqeVg4QS9jdlRV?=
 =?utf-8?B?T3NURGwyWUpKdmNUOXFnZ202VFFicUVqRXpKMVVDMm9ucHJqeE91SzBKS2Vw?=
 =?utf-8?B?V3NxeFo0NFJMRnF6UTdGNHhIS001WVdYNnIwdkxIMkhacm9mVzFpVVFLM0pT?=
 =?utf-8?B?bUJSRDc2S2p5WWl2TkVZRkVrY21vSm55UGxkc2xralg1ZEJkWGYvanpGNHNM?=
 =?utf-8?B?MkVoME9WcEd3Tk1xOEdGSUd4VDZxUFAxbkpVL0ovVWJpdHBqRTNvSE9uYnVK?=
 =?utf-8?B?ZHNVRGNFNlozQlcyM3NENUZvUDAydGcxVWx0SGdIN0d6QlF4eEhIdmFSVC8w?=
 =?utf-8?B?TUtYVWI2VXZiV1pBY3FsUVFZcVVDUzNYcUlod1lLQVBiRkVlOW8ySWJzQzNj?=
 =?utf-8?B?YTdrQ0J6Zi8xSG9WL2ZrSCtUSDB1VlpjU1owd1c4azJkYjUzdS9BY0U2V1ZQ?=
 =?utf-8?B?RXN4OURVVUhFVTFwcWpySkJLY2M1NWc2SEtKOGdyTVdRTXFIaUJPK3VJVXN6?=
 =?utf-8?B?OW1CZHUrTlBNVUkxUFpyYXdIdVpHNk5uZU1HMGR0dVlTcVJGUWNaNENFUVpZ?=
 =?utf-8?B?NEFpV29ya1VSb0RzcE5OUjluajByUDRheTVxM2RWUlFBU2ZYWCtEWVNDMjVI?=
 =?utf-8?B?V1Z6dEpjbTlBKzBuSDEvL04zaDk2UE9SR0UrY1VVWjhWYTJzMDlCalFEK0hu?=
 =?utf-8?B?Uys2c1F2OU9OeE1mUFdpNHR3ZDJRWjR5aDlMbldvU0l4RlZ5VG9wbTJId25Y?=
 =?utf-8?B?cDJTeTNnOG5HSHFvTE0rdzNkVmJEbnhqa1lTYndZdGlLT01NSWVkVklpbHph?=
 =?utf-8?B?ZGdHWVdwRGxWM2UrdEtGYnFCbER0U2MvLzhCcEVaM0M2dzFGWVBBU0pZSW9y?=
 =?utf-8?B?Sjk2WWZjMTY1T0ZYTWZqSGVaMlpOZGVEMGV0MURvcmhadTdTSWxJMVpscE9E?=
 =?utf-8?B?KzVOYVdQeWgxSXhDRVNheWVpak94NXlOZWYreTU0RTdUd2h4eFBYbEdmL2NW?=
 =?utf-8?B?QUJ2SlhaR1MwU2xYc3YzUzlXTW9aVjJ3RWZ1eGorUjNVRTFhK3NIczJHY2g2?=
 =?utf-8?B?cXpoN0JXZ05wWkNkWFlqSm9tQWhaNFdkSTBhV2JFdkRnUlh0VTQreTQyTjdv?=
 =?utf-8?B?TnBRaTdDS0FoVmkvNllwb2NhdlM4TWJrbDB2V21aTk9sNENjY3NiMVJ4TFMr?=
 =?utf-8?B?Skh4SmVTNWJJZDFFL0hVdXNwT0d2azVCVDZROVM2K0VyY1VqN0Z5cFJjSVhh?=
 =?utf-8?B?dEhBWm9XTXNCeXJ3UjNTMVltbHRTOFNhNytLNk85WEVTN2Y3S01BZVYxOVpa?=
 =?utf-8?B?T0hUS1Zkb0Z1dHNkWkwxNnUrWlhLU2NiMC9iRXBSOHV5SEMvMzBHWGpJZkQ3?=
 =?utf-8?B?QUd3QXh0S2lKVk5ZZHF3SExSbXo0TUlXNng0L0hIbzc5RmJBckNhdUhWTVVB?=
 =?utf-8?B?aE0wQnd3QkVjaitlUXVCWjVHVG9GbWs4OUtjWER0YW90cVdIbDljUjdiMGVy?=
 =?utf-8?B?bnpxb3FFZXZOVHZsaEg1cGt4ZGp4Q3k1ZW9mZG1KbU54b1VldUFHL2pUSkFL?=
 =?utf-8?B?Z3c2UTVFaXBYLzY2dzR2VmpjN29PaytIU3YzL1o2UDRyYy8zcmpFYW5Rc3Rr?=
 =?utf-8?B?c1hlN2V4SUU5SzUyQVV1eTQ5Nm5nN1NKaVlDQ0hjejJlOGVuV25OeHpSQisv?=
 =?utf-8?B?d1Y0NWtqMXN0WnJ5UDgvK0drRllxYzFQY01Ca3h4NXRoVEQ2NHpNYjN4MEtF?=
 =?utf-8?Q?yUhYKHxvGO0PICJKHbCvTGQ=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba711af-5112-4d59-51d7-08d997ef9bcd
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 19:42:41.7507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0fa9tzWg2JMRLRD1Ekk53H9eEt0NMjm8fY9ATO3jvwec9SLl2MdQQpvPALkKb7ydswaGS+9GlTLvvsbcKOTcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3516
Subject: [cocci] IRC channel
Reply-To: Sean Anderson <sean.anderson@seco.com>
X-Loop: cocci@inria.fr
X-Sequence: 38
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/3b48efa4-4bff-0990-8b21-fffc14cd47e1%40seco.com>


Hi,

On the Contact page [1], it says that there is an IRC channel #cocci on
irc.freenode.net. Is this still accurate?

--Sean
