Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709D5C02193
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=UzhQoZarILBz7uAM7J+FuS6diMIj1hxFZhX5D4QQPlg=;
  b=BGy4UKG0U0rqOxFrrzqH7CI8ye36JqWepXQtdhkDGAr9olDRf16B5Gut
   nQy3naiku6ziK+zSuykV1J2jXDHVRlEBnnuToCMQ8+3pQ7l5FwcCQ54U2
   lvTgCb7wfMgLAKWzATXfWfDzVdlQgDNmrnFp6dJpeStZiYx/5Y29UsrmJ
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@sony.com
X-IronPort-AV: E=Sophos;i="6.13,240,1732575600"; 
   d="scan'208";a="205325320"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 43052E0DA3; Tue, 28 Jan 2025 10:13:07 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 52CDEE007A
	for <cocci@sympa.inria.fr>; Fri, 24 Jan 2025 20:59:38 +0100 (CET)
IronPort-SDR: 6793f129_n1+32ThScvKaHly5im+FJUkzhRjAcBrUGzauv4eHAiPv49g
 vIV7uwf7Kxeqx+ufwPHyEmRCWHqyddiFgXw/bwA==
X-IPAS-Result: =?us-ascii?q?A0EYAABj75Nngwu3hLlAGhwBAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?IE/BwEBCwGBcVJiARqBDQQLSIRWg0wDhE5fhlKCIQMwkRqMToFAPg8BAwELA?=
 =?us-ascii?q?QExEwQBAQMEggyCdAIWil4CHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQEBATkHDjuFew2CYgGBJF5IAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBFAIIBV4BAR0BAQEBAxIREQwBAR0aAQsEAgEIFQMCAiYCAgIvFRACB?=
 =?us-ascii?q?AENBQgMBweCXwGCZAMBA6tDQ2cLAR5ZAUgCVkKJEgEBAXiBMoEBggwBAQbeA?=
 =?us-ascii?q?wMGgRouAYhNAYFsg38bhFwngWVDgRVCgmg+gVKCcxWDRDqCL4IcYoEpAYIzg?=
 =?us-ascii?q?QyLEYE9hEGEZz6KDglJexwDWSwBVRMXCwcFZEVIA4ESI4EmBTUKNzqCDWlJN?=
 =?us-ascii?q?wINAjWCHnyCK4IfgjuERYRThVuCFIFlAwMWEYI1cnsfgTAdQAMLbT03FBsFB?=
 =?us-ascii?q?Dp7BZweATyDfQIsYiuBBQwHCDpFGAQ8kkCDTwFJjBSjIwcDhBuMGJVkF4QEj?=
 =?us-ascii?q?QaVe4NOmHwijWKVUAsLhRkCBAIEBQIPAQEGgWc6gVxwUIJnTwMZD44hDA0JF?=
 =?us-ascii?q?oNChRTBOUUzPAIHAQoBAQMJkCKBSwEB?=
IronPort-PHdr: A9a23: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
 fI/riuSrHDdNCaQ6t/mI1FTjPQ=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:3+t2ZKClsEgW/ArlHemY55DYdb4zR+YMi2TDtnoRdfUxSKfzqy
 nApoV56faZslsssQgb6La90fC7MArhHP1Oj7X5X43PYOCOggLBEGkJhbGSuwEIcBeQygcy78
 ddm6QXMqyTMbB25fyKhzVRGb4bsby6GK/Bv5a780tQ
X-Talos-CUID: 9a23:AW6PZmMgQLABGe5DYzM990JXSsEZclLS/lv5GBaeMkFpcejA
X-Talos-MUID: =?us-ascii?q?9a23=3ALHMquww37iE1kQ8bSujjVy0XQuGaqJ+uWWUTy8U?=
 =?us-ascii?q?qgvmrNwtSJ2qsniu7RYByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,232,1732575600"; 
   d="scan'208";a="204930772"
X-MGA-submission: =?us-ascii?q?MDGGaS0Isl65cub17kzoRJeZs9po3RrK7DRPr1?=
 =?us-ascii?q?S8T/SVQOgW4Ssto8zbMTVGUpHyOZlqKEKXHvrHaeJ/9Q9CfzYaKcYFGx?=
 =?us-ascii?q?2H7xHZvFNA/8Qnmx9m1i/w9lwPuva9cNqf7tSnedpeE1/thc/xp3TQqI?=
 =?us-ascii?q?z84lbjMxHTuNGiAmsiE+kJnA=3D=3D?=
Received: from mx07-001d1705.pphosted.com ([185.132.183.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 20:59:37 +0100
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OJs871024241;
	Fri, 24 Jan 2025 19:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=UzhQoZa
	rILBz7uAM7J+FuS6diMIj1hxFZhX5D4QQPlg=; b=SirZecO0OmuuhbmLC78M+PK
	SQN2uBB9TAVr/IaSImVkADGUkHinnJBj1L0dRApcasPFXP9SgWrENuWj7IQTuwBY
	mMJmBi9Z7hr1qFWdVNYkDEs8dpro3hYEaY2lZkjT4y+4D4PV3r2OFHg7GVq3Gmf7
	1n4SltlMRrUi4GZgnE4UW9W94hhHjbHSGS8xzRBZjwLBZf3i5qvGVURKSD/S5nhf
	UcmYJuhaFb/G2w7AVEB7lU8eesc6g3z0AQcuZbAP979ZmTo9rF6l/K2iziVEoHou
	eQ6ZZsueJp3BkOPmIdV/lFn664E3sY0Z2F0KNn8Taljo1F0H1Q4kNQTB3aGqJtA=
	=
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4485mknyje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 19:59:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7LYqFXPvE8/yzsaa+4b0bU9ps68yZTSEwiRmg/AkfdUMbmrcRT76/quvTO/Cdi34ydBT94LlLpxTC4tEiHPaEktp/hoVkOnXpZFH/a1jBUqrhBbfdaeYWnk8FI6JHkRt3o5aqF0YhZHuX34DP3JMmFoKaj8v+K56uQHzlqtko3fGEo5A7LvEXWd8qyR/qlywrYz3cqvKGYZX4IL3jrcd2GvpJnH+3iyIxmt4meOYZIUetnVeBf4cX06X6qf9IAIxfUlZG0+i2GAKy1TvMOYflzBjxl8aCdqnjL3Pmvp4IdW+99bpgU1HXTZxc0slkuVjvO3oxZyOg4RK5eKtnEmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzhQoZarILBz7uAM7J+FuS6diMIj1hxFZhX5D4QQPlg=;
 b=ClNY+JcWB0TUBOd2aJENFy+8fWDJW/zJGYVZULDrPlSci+COJ8ohKK4G5pzLWKCLsf5AWvBiXySjI0Ur0lbj0VrvhTKqCNXGZzdYQqpAcN15bL0b+9Z//s8QIZuPYqisGOcYZb12RUIJHZn7nRVgU0JlGETbqV9lOCXdvvD3rNYWNWa8dMT8dNWug2/ceVtAYGqwQJLpCuqvVLqTnwoc1hq60v+YAQTlgTBZhHa/WZTw7DJqrMyt1TJLBDgta9Qb0aQS+1SfR1cXOE30256PGvyx3ECbFzlY7JaJb1AfzXpmZ0d6uHYfWjUk/ttlkuG3dIsaDZWka9GHb6NQh2sP0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by MN2PR13MB3759.namprd13.prod.outlook.com (2603:10b6:208:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Fri, 24 Jan
 2025 19:59:05 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197%4]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 19:59:05 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Helen Mae Koike Fornazier <helen.koike@collabora.com>,
        Mauro Carvalho
 Chehab <mchehab+huawei@kernel.org>
CC: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Nikolai Kondrashov
	<Nikolai.Kondrashov@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>,
        =?utf-8?B?Ikxlb25hcmRvIEJyw6FzIg==?= <leobras.c@gmail.com>,
        Vignesh Raman
	<vignesh.raman@collabora.com>,
        kernelci <kernelci@lists.linux.dev>,
        linuxtv-ci <linuxtv-ci@linuxtv.org>,
        dave.pigott <dave.pigott@collabora.com>, mripard <mripard@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kselftest
	<linux-kselftest@vger.kernel.org>,
        gustavo.padovan
	<gustavo.padovan@collabora.com>,
        pawiecz <pawiecz@collabora.com>, spbnick
	<spbnick@gmail.com>,
        tales.aparecida <tales.aparecida@gmail.com>,
        workflows
	<workflows@vger.kernel.org>,
        skhan <skhan@linuxfoundation.org>,
        kunit-dev
	<kunit-dev@googlegroups.com>,
        nfraprado <nfraprado@collabora.com>, davidgow
	<davidgow@google.com>,
        cocci <cocci@inria.fr>, Julia.Lawall
	<Julia.Lawall@inria.fr>,
        laura.nao <laura.nao@collabora.com>, kernel
	<kernel@collabora.com>,
        torvalds <torvalds@linuxfoundation.org>,
        gregkh
	<gregkh@linuxfoundation.org>, daniels <daniels@collabora.com>,
        shreeya.patel
	<shreeya.patel@collabora.com>,
        denys.f <denys.f@collabora.com>,
        louis.chauvet
	<louis.chauvet@bootlin.com>,
        hamohammed.sa <hamohammed.sa@gmail.com>,
        melissa.srw <melissa.srw@gmail.com>, simona <simona@ffwll.ch>,
        airlied
	<airlied@gmail.com>, broonie <broonie@kernel.org>,
        groeck
	<groeck@google.com>, rdunlap <rdunlap@infradead.org>,
        geert
	<geert@linux-m68k.org>,
        michel.daenzer <michel.daenzer@mailbox.org>,
        sakari.ailus <sakari.ailus@iki.fi>
Thread-Topic: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Thread-Index:
 AQHbbZ5NNj+k8kjIAU+QmcCK7MYwsLMlYZkAgAAyrwCAAEQuAIAADEqAgAAX8oCAABGGAIAASLUAgAAA2sA=
Date: Fri, 24 Jan 2025 19:59:05 +0000
Message-ID:
 <MW5PR13MB5632647364D67725756B77FBFDE32@MW5PR13MB5632.namprd13.prod.outlook.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
	<f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
	<20250124081250.GA24731@pendragon.ideasonboard.com>
	<D7AAOSNDJV11.AXVF80Z934BK@kernel.org>
	<298675d0-ba19-4c87-b00d-57a5e31b05b6@redhat.com>
	<b3af62d3565d2d60218520d2ebace6f1a0368c17.camel@collabora.com>
 <20250124162916.38e5c6a0@foz.lan>
 <19499dcc55d.d07a9615183956.5491109771298297030@collabora.com>
In-Reply-To: <19499dcc55d.d07a9615183956.5491109771298297030@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|MN2PR13MB3759:EE_
x-ms-office365-filtering-correlation-id: 100c32be-3b46-49e5-620b-08dd3cb18ec3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?REpGMnlLNGdhRXh0T2YxRmxhaFByeHphRWQ5OWZUazlrZjlxR0xvdDVCelNP?=
 =?utf-8?B?REZZL0RvcDVwSWFZNG0xWXppZncwTWo4YUZETUNpQWN2MllPdWRKOGtsZVMw?=
 =?utf-8?B?T1Q4WHNLbG1Cc1k5UzR3andUWWVMcnVFYlMwd0xrZGxUTTNqSzU1OHhETk1I?=
 =?utf-8?B?U2I3Z1ZvdnFZVHZPTDhrUFpManJaV2tTeUdmMS9OU0x4UHBTMzFGb1pBYk52?=
 =?utf-8?B?V2M5eVZkdlE5ZVNTK1o5MGJVOFR4c3I3YVZUSWI3clJyU21wbVh4OVNzL25N?=
 =?utf-8?B?V0pwVU9ZNWlqVFMxK3ZFZmRXY25HbHJOOUlBWGlQOWRoeHpjY1hNcmVLZ3lF?=
 =?utf-8?B?YU9DYUdPTXp2UlllMGIxeUowVGZMb2wxMWxPbU5nOXJka1FOR2Q3L2txcFpt?=
 =?utf-8?B?S1F5MHNONU5uTjVQUWlEdWNEUkJvS25EUzZLcmF1dWhPMysydTY2NUVYMW1H?=
 =?utf-8?B?b0ExU3d0WDNLL05YMzdmOXlTbG4xck1WQmFVWnUxOGNWbmRQUi9MR0ZwdDhT?=
 =?utf-8?B?ekJrZUg3RWIzRmtBMG1SZkdzU1dFd0dNWkw3Rkk3dFoxTXZ2YXpzcU1WaGtn?=
 =?utf-8?B?WWVWdGlxVU9kUU1MUGRWMWkrcWZvcC9QQi8vd0pIUXZqQS94Y21JeXpjRHRr?=
 =?utf-8?B?SDk2VzYwTHpoS2dRdkp1aWpSS1QzM2Z0MERvY2g5c0N2UExFcFNqNFo0a3li?=
 =?utf-8?B?cDVkcEtySTZTbGRtQnVzL2c1RWdrWGZDeVBHdS9MNEs2bldyTUR6ci9Eb0VB?=
 =?utf-8?B?bkx1bGxoSjhUS29lbUZUSU1mYWZ5QlFnRTFEY3dVaVIxZm5kdXZENkxrbTI3?=
 =?utf-8?B?MVFtTSs3MmpyUWhkZVpPeTZXMUxHRkNNK042aUU1blNrbzJSbmo2OVFqcU5W?=
 =?utf-8?B?bXUzRlhPY0hma014NTNqdFhvZEZNdTBaTDVLd0EvQmFtN2VsTndIcW1zVmdR?=
 =?utf-8?B?US9uR3puYzVDd256VGRpSG02NHF2WHlRVFo0L0RRMnFoZHFlSU5ORk80Vlpa?=
 =?utf-8?B?bUJraHlxYkFFUDk5ODNaeHVUR3VNd1lNcmNvL3VJaHFzNVhxejN6ZHhFYlBp?=
 =?utf-8?B?R2xTOUpybVZSQVdsWE1KV3YyS1ZvWmZwS3lhWjF6OVBmRSsvQ2xBdkpZQUg5?=
 =?utf-8?B?aTdzTjRNTHFIYkFQSkxLNDdDSU5HdGRMTUlLU2VDSkhpbEdEcFQrTFptdStE?=
 =?utf-8?B?MDlxNC80bmlwSkd3NitKckhmcm5BQ0tRMUlqWjFJTUlVZnNEeXUrOU55TlF6?=
 =?utf-8?B?NEN5b1U3SC9vazk4YjZtNWhiZWhpVXhwMjJKK2E3eElBY3dPK1BVb2xEWlJD?=
 =?utf-8?B?N2gyWGwwUWlLNnZHR2xLNnRNanR3aVF6TVUrak1qbm5yK25LVTJDNFlKM0Y0?=
 =?utf-8?B?VmxBbm00TlhMV1RjaDhNL21nK09ySEl2RVRheityVFdyUS85UVY0Q0VvSG53?=
 =?utf-8?B?NUF1MEJXb2J3ajUrVFhmOCtVTmxvVmFXMFR6NEZSWHJkc0djU3JGdm05RXRF?=
 =?utf-8?B?ajIybnl5NXhXMi9nVXBzVXd5dGlqdzhaY3l1SDkrdllDbmtWMGJLMVpHaHV6?=
 =?utf-8?B?SmdjRGtlZHBHYU93ZkducGNuSXBBQUhUL3BkQjJQVWNNSjNrSllsTjg3MHFa?=
 =?utf-8?B?VVA2VzBKbk5PUEV5bzY1bkhZTktZKy9HL1IvTHVEUnFXcTN1ZlFVVmQ2UXVh?=
 =?utf-8?B?dGlmQnNlZUREVDdxTitBTS9ScHY1RklwY05FbjFPRFAveXYrRE1lYU9ld3pk?=
 =?utf-8?B?ekNwUlVNUWR0RDd0Y1ZyN0hnTGNneVFjUHhVZFhWbDlnQ1E5K3pvMW9nTmhF?=
 =?utf-8?B?endwd1NaYnJBMnB6R2hRRDVmTUpkSUZSZStXdGM5ZXhndGR3QzZDWFc3SnE2?=
 =?utf-8?Q?guVdP93gIB4kQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmFCZWsreWNjckpWRkZWQnU1blNvUUNubVJQWEFUSjdXSGx6VzNVakhhS0xP?=
 =?utf-8?B?Q3JXaHg3Nm5kUlF1TDRDTnZSeU1UMWxWMDVTbmlTN2xaei90R0VWSk56aFZ1?=
 =?utf-8?B?ZmFkdStjQkVRU3BUSG13VjVFU3ZkYlFaYitDdURKQUNwUUZqWGtTMUM1em1S?=
 =?utf-8?B?VklxWEd1ajQ5RE1WVDlyWW15SUtjbStCSTVLeEM0UXlwN2s5V29LUXNWYzIz?=
 =?utf-8?B?TklTb2ZoMFlYeUoxSVduYVZnSktQNGVoUFFEN2pKZVN6dFhOcXYxRkd1ZHdC?=
 =?utf-8?B?djRZQUZhQy9Va0w2Zlh4Zk85d1dLK0l5Z1k4V1VRVnNxZFozeGVoQTY5Qy9H?=
 =?utf-8?B?MlBFNVN1NDBqWXgwbDZuZG9ac2d1ZWhUTTlmWTNmSk1nQWM5U1RrOWtVWEdH?=
 =?utf-8?B?VVhpNVg2WTVYaDBEamRia3ZrYThoaWR2ZXpLK2YvRmpBQnNnYXpPV2wxTXgy?=
 =?utf-8?B?dkZYc3IvTFJ6WTB3cmJxVXdTeXNoY2ZodzcwekxOY0diNjhlcnVTdDF5MHZ3?=
 =?utf-8?B?bnNBMkxybzhFckRjWGxUUGIwL05nd3BtUHBrZmtkdW1pSmlYb2hQTG9raU9O?=
 =?utf-8?B?YTR6L2RkZWlHU0gySkxnWldBSENCRXFEZmpVZHk3RVBzZi9oTWZKZU51dFNZ?=
 =?utf-8?B?cGlsQlJEaE1JVHIzczNNbVVJYmZTZEtOZWpIdUhiZTBkR1RkMTFycGVYaHRa?=
 =?utf-8?B?YXUrK0VLZnVjS016MFh1c21KN2UzYzZncDdsK2E0OFRDYk4rY0ZaQzFLVjBV?=
 =?utf-8?B?OUxUcGJ3WE91cTVtc3JQbmV1M1BiYUpMUDQxcHNFS3BZZGx3SDNGMUxQY3JV?=
 =?utf-8?B?VVVCTlNmMy9yVkwwRTFBVFAvYlkzcjB2cXF2bjFDSFFZY2h3SDRQRU5zbUJt?=
 =?utf-8?B?UEVqODVyb1BjMktMUWVBRGtrZTRPVWJGWXVzNmRGaUVTN3FzSEJock9CTjVm?=
 =?utf-8?B?d29Ldm1XNzh2VXBmRDBFT3hMRUtxNU04c3c3c3pZSXVBeWt3Y0t1WEZlSVlo?=
 =?utf-8?B?aFZ1aG5zZk5BUHdsRnp2ZXBYaTNDQXk3RURsWmttdUVzQXZLR2VINitLcjZ2?=
 =?utf-8?B?VnplT1dJR3Nwa3RFL3A2eGtwbndqSHJERktRWWNWUVNhQTVJcmJ2RUZrb1dz?=
 =?utf-8?B?ZVZXZHN2NG9HNFhzTktJMkNGMnhRbmlvSk1lbjVyNVBEaTJ1MXVRT2dwNGhE?=
 =?utf-8?B?bVpSdlVtaENxV0x0bVFmZThZbzVyTkc0akd5YlFKdFBZWWkwUlp5Y1lhZlJI?=
 =?utf-8?B?Z05XMGdrNWg3M2JoQ0tRSmVzTWhxMEJibkUzRnk4YjJ6SUsrWGpscXBaR0J4?=
 =?utf-8?B?ZzNNeTJmWWVBYXJXdzVDWDVMMXZra3BNZXY1Z0RDLzRDRzZRTTRBMTFacDZE?=
 =?utf-8?B?Vk5NSmxNeFQxdHpDU2RHeW96dFNhQ1JEK0tJTEljMXdjMUsxWlAyWXAvSmRE?=
 =?utf-8?B?UWVCK2hxUjRkd3pNVnlUYm9abExZOEpjcEtKL3NYd09ESllROU92eHV2bTZH?=
 =?utf-8?B?Y1o0bW5zOFdKTGh5RlFEdFphVHJXS255Wi9Qd2pBTmhjcHExUVhhMXQvWnVs?=
 =?utf-8?B?bGJRTmtWTHdxSTlaeXphYlZwNjViblFoRUpleUdkMWJ1Y3JnZTE5ZVREdlpZ?=
 =?utf-8?B?cGVYYUtSN1IzQjJJVzc3ZnVGdmFueExSUWl1MjFURFV4YS95RTI0S2JxYU5B?=
 =?utf-8?B?YXR2TE4vbk9ob1piUDNuQk9RYnB4UHF1Nk1ZUFFZMlg2YW83RHlhVWNpMEps?=
 =?utf-8?B?UUtiZUZ4eVRiaWlwNTBualRmOWZza01aM2Rod2s5Uk05ODRDRFU3bHA0Kzhu?=
 =?utf-8?B?V3lzZENudS9RajQrOERhYTRpc0loMmpUOTlRTVRmckY4M2U3YmYzSEM4K2Er?=
 =?utf-8?B?bGNBVUZMQ2hiM0FGdi9SNUtnUGIxSzFxTFN2a213TGxmSlNwVGZlcG9GSVFP?=
 =?utf-8?B?ZG8wRDdJMTB1TTMvWlA0Q3VON0kvY0k2bGhxR0ZmVjFSMFM2a2N1b241ZXpR?=
 =?utf-8?B?VzlNWlBoWlNHVnF0VXlrWEpNNzRPQ3hFVGZZZi9EV3ZJUk0wU1hIRVBWelRZ?=
 =?utf-8?B?VEUzTjg3WkV5c25kdWVLOEVzT01TQlVHcGtjaklmWTBEMUhabytpWUIrQlFu?=
 =?utf-8?Q?Az4A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wxCEV0ud+2u7tWdcS9K2hvzZwT6UXp5+wY6NsAyKspn290WZw60B9WdaaItj9St15zsjHepfFR0uqJ6AyGwR0Ao01A4iWR30Fhy1RSMRcAL+zKWuzaS/jKGFhngomMS95eVZs3pNFUcRD3XDFfSQM/i9KUW+phmxK/nK0H890eMgF0Phat+fjFyzef3lhiOoMU5KektHTrbVSZ+/T2CY8u7z/mzgeJqFnFHxh+UerPR50jafr0EbqXIuTykPl/3HzNiWY7gptyWioZ1ffx6wOnGSXDD4Xq2Vy6IM4r/Bhj4CiZ23ll2AdQqeqMPObaQQW3xSGo1gMEFAzTJG0WvPLFqvtYS6adGdokfNssZuxcj6muaX3D+4b3D1q7Smii3RDMx8QEVsLADwQ9boKcvxuV3uW3Xtn6uDS6YP7f/jKoynpvn4WUt8Xjr3Fbj5X+NCMDiMBLdH7AVZqknEOphfqjR4Ma9hwFGN6+hyDbT4hNyrYBdhCT9NUiLYqmVawdv0ra0r4PqE9oa5mQqneOW4w4Tj+xKQp8VNz9UaU6JpsK0Qh+fEWvGt8zb/giBQQ4bt/itFqFtKquVCtFpEmCgmpuO1wavC60vA0Jn6Yr35KAjMN0Iv2ZiPsj5R9vqrD4Tw
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100c32be-3b46-49e5-620b-08dd3cb18ec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 19:59:05.8475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7UWvFLodch3y1paHApck0JOdqIzkc3oW3JaWzrrXvwglUk0ayYs+WJf81PUDNmli/L8bGO6q7VCQqoIfQNPM+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3759
X-Proofpoint-ORIG-GUID: XQZXGiSRmDtOhD_GTI43tO2GbhhPDVRe
X-Proofpoint-GUID: XQZXGiSRmDtOhD_GTI43tO2GbhhPDVRe
X-Sony-Outbound-GUID: XQZXGiSRmDtOhD_GTI43tO2GbhhPDVRe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_08,2025-01-23_01,2024-11-22_01
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: "Bird, Tim" <Tim.Bird@sony.com>
X-Loop: cocci@inria.fr
X-Sequence: 2260
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/MW5PR13MB5632647364D67725756B77FBFDE32%40MW5PR13MB5632.namprd13.prod.outlook.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVsZW4gTWFlIEtvaWtl
IEZvcm5hemllciA8aGVsZW4ua29pa2VAY29sbGFib3JhLmNvbT4NCj4gSGkgTWF1cm8sDQo+ICAN
Cj4gLS0tLSBPbiBGcmksIDI0IEphbiAyMDI1IDEyOjI5OjE2IC0wMzAwIE1hdXJvIENhcnZhbGhv
IENoZWhhYiAgd3JvdGUgLS0tDQo+IA0KPiAgPiBFbSBGcmksIDI0IEphbiAyMDI1IDA5OjI2OjMz
IC0wNTAwDQo+ICA+IE5pY29sYXMgRHVmcmVzbmUgbmljb2xhcy5kdWZyZXNuZUBjb2xsYWJvcmEu
Y29tPiBlc2NyZXZldToNCj4gID4NCj4gID4gPiBIaSwNCj4gID4gPg0KPiAgPiA+IExlIHZlbmRy
ZWRpIDI0IGphbnZpZXIgMjAyNSDDoCAxNTowMCArMDIwMCwgTmlrb2xhaSBLb25kcmFzaG92IGEg
w6ljcml0IDoNCj4gID4gPiA+IE9uIDEvMjQvMjUgMjoxNiBQTSwgSmFya2tvIFNha2tpbmVuIHdy
b3RlOg0KPiAgPiA+ID4gPiBPbiBGcmkgSmFuIDI0LCAyMDI1IGF0IDEwOjEyIEFNIEVFVCwgTGF1
cmVudCBQaW5jaGFydCB3cm90ZToNCj4gID4gPiA+ID4gPiBHaXRsYWIgYXMgYW4gb3Blbi1zb3Vy
Y2Ugc29mdHdhcmUgcHJvamVjdCAodGhlIGNvbW11bml0eSBlZGl0aW9uKSBpcyBvbmUNCj4gID4g
PiA+ID4gPiB0aGluZywgYnV0IGNhbiB3ZSBwbGVhc2UgYXZvaWQgYWR2ZXJ0aXNpbmcgc3BlY2lm
aWMgcHJvcHJpZXRhcnkgc2VydmljZXMNCj4gID4gPiA+ID4gPiBpbiB0aGUga2VybmVsIGRvY3Vt
ZW50YXRpb24gPw0KPiAgPiA+ID4gPg0KPiAgPiA+ID4gPiBJIGRvbid0IHRoaW5rIHdlIHNob3Vs
ZCBoYXZlIGFueSBvZiB0aGlzIGluIHRoZSBtYWlubGluZSBrZXJuZWwuDQo+ICA+ID4gPiA+DQo+
ICA+ID4gPiA+IE9uZSBhbmdsZSBpcyB0aGF0ICJubyByZWdyZXNzaW9ucyBydWxlIiBhcHBsaWVz
IGFsc28gdG8gdGhlIHNoZW5hbmlnYW5zLg0KPiAgPiA+ID4gPg0KPiAgPiA+ID4gPiBEbyB3ZSBy
ZWFsbHkgc3BlbmQgZW5lcmd5IG9uIHRoaXMgcHJvcHJpZXRhcnkgY3JhcCB0byB0aGUgZXRlcm5p
dHk/DQo+ICA+ID4gPg0KPiAgPiA+ID4gVGhpcyBpcyBub3QgZ2V0dGluZyBpbmNsdWRlZCBpbnRv
IHRoZSBrZXJuZWwgaXRzZWxmLCB0aGUgY29udHJpYnV0ZWQgY29kZSBpcywNCj4gID4gPiA+IG9m
IGNvdXJzZSwgb3Blbi1zb3VyY2UuIEFuZCB5ZXMgaXQgd291bGQgZXhlY3V0ZSBqdXN0IGZpbmUg
b24gdGhlIGZ1bGx5DQo+ICA+ID4gPiBvcGVuLXNvdXJjZSBjb21tdW5pdHktZWRpdGlvbiBHaXRM
YWIuDQo+ICA+DQo+ICA+ID4gPiBJIGRvbid0IHRoaW5rICJubyByZWdyZXNzaW9ucyBydWxlIiBz
aG91bGQgYXBwbHkgaGVyZS4NCj4gID4NCj4gID4gSXQgZG9lc24ndCwgYXMgdGhpcyBpcyBub3Qg
YSBLZXJuZWwgdXNlcnNwYWNlIEFQSS4gSXQgaXMganVzdCBzb21lDQo+ICA+IGZhY2lsaXR5IHRv
IGludGVncmF0ZSBLZXJuZWwgYnVpbGRzIHVzaW5nIGEgQ0kgaW5mcmFzdHJ1Y3R1cmUuIFRoaXMg
Y2FuDQo+ICA+IGNoYW5nZSB3aXRoIHRpbWUgYXMgbmVlZGVkLg0KPiAgPg0KPiAgPiBTdGlsbCwg
b25jZSBwZW9wbGUgc3RhcnQgdXNpbmcgaXQsIGRldmVsb3BlcnMgbmVlZCB0byB0YWtlIHNvbWUg
Y2FyZSB0bw0KPiAgPiBhdm9pZCByZWdyZXNzaW9ucyB0aGF0IHdvdWxkIGNhdXNlIENJIGJ1aWxk
cyB0byBmYWlsIGZvciB0aGUgb25lcyB1c2luZw0KPiAgPiBzdWNoIGZhY2lsaXRpZXMuDQo+ICA+
DQo+ICA+IEFsc28sIGlkZWFsbHksIHRoaXMgc2hvdWxkIGJlIGNvbXBsZXRlbHkgaW5kZXBlbmRl
bnQgb2YgdGhlIEtlcm5lbCB2ZXJzaW9uLA0KPiAgPiBlLmcuIGlmIG9uZSBzZXRzIHVwIGFuIGlu
ZnJhIHVzaW5nIHRoZSB2ZXJzaW9uIHRoYXQgd2FzIHRoZXJlIHdoZW4sIGxldCdzDQo+ICA+IHNh
eSwgS2VybmVsIDYuMTQgaXMgcmVsZWFzZWQsIHRoZSBzYW1lIENJIHNjcmlwdHMgc2hvdWxkIHdv
cmsganVzdCBmaW5lDQo+ICA+IHdpdGggc3RhYmxlIEtlcm5lbHMgYW5kIGV2ZW4gZnV0dXJlIEtl
cm5lbHMuDQo+IA0KPiBPciB5b3UgY2FuIGp1c3QgY29uZmlndXJlIHlvdXIgR2l0TGFiIENJIHRv
IHdvcmsgYW5kIGFuIG9sZGVyIHZlcnNpb24gb2YNCj4gdGhlIHNjcmlwdCBieSBqdXN0IHBvaW50
aW5nIHRoZSByaWdodCB5YW1sIFVSTCBhdCB0aGF0IHZlcnNpb25zIGluIHRoZSBjb25maWdzLA0K
PiBvciBhbSBJIG1pc3Npbmcgc29tZXRoaW5nPw0KPiANCj4gID4NCj4gID4gRHVlIHRvIHRoYXQs
IEknbSBub3QgY29udmluY2VkIHRoYXQgc3VjaCBrZXJuZWwgQ0kgZmlsZXMgc2hvdWxkIGJlDQo+
ICA+IGhvc3RlZCBhdCB0aGUgS2VybmVsIHRyZWUuDQo+ICA+DQo+ICA+IElNTywgdGhpcyBzaG91
bGQgYmUgc3RvcmVkIG9uIGEgc2VwYXJhdGUgcmVwb3NpdG9yeSBob3N0ZWQgYXQNCj4gID4ga2Vy
bmVsLm9yZywgdXNpbmcgU2VtYW50aWMgVmVyc29uaW5nIChodHRwczovL3NlbXZlci5vcmcvKSAt
IGUuIGcuDQo+ICA+IHdoZW4gdGhlcmUgYXJlIGluY29tcGF0aWJsZSBjaGFuZ2VzLCBtYWpvciB2
ZXJzaW9uIG51bWJlciB3aWxsIGJlDQo+ICA+IGluY3JlYXNlZC4NCj4gDQo+IEEga2V5IGJlbmVm
aXQgb2YgaGF2aW5nIGl0IGluLXRyZWUgaXMgdGhlIHRlc3QgZXhwZWN0YXRpb24gbGlzdCwgYXMg
c2VlbiB3aXRoDQo+IERSTS1DSS4gVGhpcyBhbGxvd3MgZGV2ZWxvcGVycyB0byB0cmFjayB0aGUg
c3RhdGUgb2YgZHJpdmVycyBhbmQgcHJvZ3Jlc3Mgb3Zlcg0KPiB0aW1lIGJ5IHNob3dpbmcgd2hp
Y2ggdGVzdHMgYXJlIGV4cGVjdGVkIHRvIHBhc3Mgb3IgZmFpbCBhdCBhIGdpdmVuIHBvaW50IGlu
DQo+IGhpc3RvcnkuIChGcm9tIHdoYXQgSSBzZWUgaW4gRFJNLUNJLCB0aGlzIGFkZHMgYSBjb25z
aWRlcmFibGUgYW1vdW50IG9mIHZhbHVlLikNCj4gUGxlYXNlIGNoZWNrIHRoZSBWS01TIHBhdGNo
IGluIHRoaXMgcGF0Y2hzZXQuDQo+IA0KPiBBbHNvLCBpZiB3ZSBrZWVwIHRoaXMgdG9vbCBvdXQg
b2YgdHJlZSwgSeKAmW0gY29uY2VybmVkIHRoYXQgc3Vic3lzdGVtcyBsaWtlIERSTQ0KPiBhbmQg
TWVkaWEgd2lsbCBjb250aW51ZSBub3QgY29sbGFib3JhdGluZ+KAlGVhY2ggY3VycmVudGx5IGhh
cyBpdHMgb3duIHNvbHV0aW9uDQo+IHdoZW4gdGhlIGJhc2UgY291bGQgYmUgc2hhcmVkIGFuZCBy
ZXVzZWQuIEFsbCBzdGF0aWMgY2hlY2tzLCBidWlsZCBwcm9jZXNzZXMsDQo+IGFuZCBib290IG1l
Y2hhbmlzbXMgYXJlIGZ1bmRhbWVudGFsbHkgdGhlIHNhbWUsIHdpdGggb25seSBtaW5vciBkaWZm
ZXJlbmNlcw0KPiB0aGF0IGFyZSBjdXN0b21pemFibGUuIE90aGVyIHN1YnN5c3RlbXMgY291bGQg
dXNlIGp1c3QgdGhlIGJhc2Ugb3IgYnVpbGQgdGhlaXINCj4gc3BlY2lmaWMgY29uZmlndXJhdGlv
bnMvdGVzdHMgb24gdG9wIG9mIGl0Lg0KPiBIYXZpbmcgaXQgaW4tdHJlZSBzZW5kcyBhIG1lc3Nh
Z2U6ICJZb3UgY2FuIGNyZWF0ZSB5b3VyIG93biBHaXRMYWIgQ0kgcGlwZWxpbmUsDQo+IGJ1dCB3
aHkgbm90IHVzZSB0aGlzIGV4aXN0aW5nIG9uZSwgY29udHJpYnV0ZSB0byBpdCwgYW5kIGNvbGxh
Ym9yYXRlIGZvcg0KPiBldmVyeW9uZSdzIGJlbmVmaXQ/Ii4NCj4gU2luY2UgaXQncyB1bmRlciB0
aGUgdG9vbHMvIGZvbGRlciwgaXTigJlzIGEgaGVscGVyIHRvb2wuDQoNCkFsdGhvdWdoIEkgZG9u
J3QgdXNlIGdpdGxhYiBDSSBmb3IgbXkga2VybmVsIHRlc3RpbmcgKEkgdXNlIEZ1ZWdvKSwgSSd2
ZSBiZWVuDQp3YWl0aW5nIGZvciB0aGlzIHNvIHRoYXQgSSBjYW4gc2VlIGlmIGl0J3MgcG9zc2li
bGUgdG8gbGV2ZXJhZ2UgdGhlIGluZm9ybWF0aW9uDQpjb250YWluZWQgaW4gaXQgZm9yIG15IG93
biBDSSBzeXN0ZW0uICBJIG1heSBub3QgZW5kIHVwIHVzaW5nIHRoZSBpbmZvIG15c2VsZiwNCmJ1
dCBhdCBhIG1pbmltdW0gaXQgd2lsbCBzaG93IG1lIHRoZSBpbmZvIG5lZWRlZCBieSBhbm90aGVy
IENJIHN5c3RlbS4NCg0KSGF2aW5nIHRoaXMgdXBzdHJlYW0gaXMgdXNlZnVsLCBJTUhPLCBldmVu
IGlmIGl0IGp1c3QgcmVmbGVjdHMgYSBzaW5nbGUgQ0kgc3lzdGVtDQpjdXJyZW50bHkgYmVpbmcg
dXNlZC4NCiAtLSBUaW0NCg0KDQo+ICA+ID4gPiBUaGlzIGlzIGZvciBkZXZlbG9wZXJzIG9ubHks
IGFuZCBpcyBhIHRlbXBsYXRlIGZvciBtYWtpbmcNCj4gID4gPiA+IHlvdXIgb3duIHBpcGVsaW5l
IG1vc3RseSwgd2l0aCBwaWVjZXMgd2hpY2ggY2FuIGJlIHJldXNlZC4NCj4gID4gPg0KPiAgPiA+
IFBlcmhwYXMgd29ydGggY2xhcmlmeWluZyB0aGF0IE1lZGlhIGFuZCBEUk0gc3Vic3lzdGVtIGhh
dmUgb3B0ZWQgZm9yIHRoZQ0KPiAgPiA+IEZyZWVkZXNrdG9wIGluc3RhbmNlLiBUaGlzIGluc3Rh
bmNlIGlzIHJ1bm5pbmcgdGhlIE9wZW4gU291cmNlIHZlcnNpb24gb2YNCj4gID4gPiBHaXRsYWIs
IHdpdGggaHVuZHJlZHMgb2YgQ0kgcnVubmVycyBjb250cmlidXRlZCBhbmQgc2hhcmVkIGFtb25n
IG1hbnkgcHJvamVjdHMNCj4gID4gPiAod2hpY2ggaW5jbHVkZXMgTWVzYSwgR1N0cmVhbWVyLCBX
YXlsYW5kLCBQaXBld2lyZSwgbGliY2FtZXJhLCBqdXN0IHRvIG5hbWUNCj4gID4gPiBmZXcpLg0K
PiAgPg0KPiAgPiBJdCBkb2Vzbid0IG1hdHRlciBtdWNoIHdoYXQgZ2l0IGZvcmdlIHNvbWUgcHJv
amVjdHMgYXJlIGN1cnJlbnRseSB1c2luZywgYXMNCj4gID4gdGhpbmdzIGxpa2UgdGhhdCBjb3Vs
ZCBjaGFuZ2Ugd2l0aCB0aW1lLg0KPiAgPg0KPiAgPiBTdGFydGluZyB3aXRoIHN1cHBvcnRpbmcg
anVzdCBvbmUgdHlwZSBvZiBnaXQgZm9yZ2Ugc291bmRzIE9LIHRvIG1lLA0KPiAgPiBidXQgbG9u
ZyB0ZXJtIGdvYWwgc2hvdWxkIGJlIHRvIG1ha2UgaXQgZ2VuZXJpYyBlbm91Z2ggdG8gYmUgdXNl
ZCB3aXRoIGFzDQo+ICA+IG11Y2ggQ0kgZW5naW5lcyBhcyBwb3NzaWJsZSAtIG5vdCBvbmx5IGZv
cmdlcyBkZXZlbG9wZWQgYnkgY29tcGFuaWVzIHRoYXQNCj4gID4gcHJvdmlkZSBwYWlkIHNlcnZp
Y2VzIGxpa2UgR2l0bGFiL0dpdGh1YiwgYnV0IGFsc28gY29tcGxldGVseSBvcGVuDQo+ICA+IHNv
dXJjZSBmb3JnZXMgYW5kIGV2ZW4gSmVua2lucy4NCj4gID4NCj4gID4gVGhhbmtzLA0KPiAgPiBN
YXVybw0KPiAgPg0KPiANCg0K
