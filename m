Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A754C433EF
	for <cocci@archiver.kernel.org>; Wed, 23 Feb 2022 20:54:20 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,391,1635199200"; 
   d="scan'208";a="22912716"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Feb 2022 21:54:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D66F9E015F; Wed, 23 Feb 2022 21:54:18 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9391FE00A8
	for <cocci@sympa.inria.fr>; Wed, 23 Feb 2022 21:45:40 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=morgangreen@hotmail.com; spf=Pass smtp.mailfrom=morgangreen@hotmail.com; spf=Pass smtp.helo=postmaster@NAM10-MW2-obe.outbound.protection.outlook.com
IronPort-SDR: 6HSzM/w7irad+nCf2PSKfsM05p5QI0HF7Qks/oIsoAT8+YZO0lwUwHiwdW475E/RHMxqH7Clgm
 2t6D4+qHFABGJgaY8cf0my59i3trl9IjcaKAmrTUf7IsNLNd5j6C7W/i4Nx4KWCPJLBra4fMfU
 l9VT5XLXn14H0IH04NFSznukSEQ1pyKqeDsmi6j86Jcp0PF4OOdTbRFMy8gnQBoSFLcZvf7PR5
 Yr5msHWLEH7BU6O3FdhN27NRWgOhHmVEjKPizZJ7Q1jzIvZfPnvvrEx6kDinjchwTmGIbRgZ17
 4BC5zRpsnX/ulmWLf6mJVRzN
X-IPAS-Result: =?us-ascii?q?A0AiBgBMnBZihxAqXChaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VoCMYEfKC6BRhAnAwdLhFSDSwEBhTmIFIMBiCKBBJA0gXsLAQMBCwEBEgEuB?=
 =?us-ascii?q?AEBhQcChA0fBgEERwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgMEARMBA?=
 =?us-ascii?q?QEMDQkFCAoHDhAFZmVdAYFOAYFYBgMxDUABEAGBYykBg2MBAQEBAgESEQ8BB?=
 =?us-ascii?q?QgBAQUyAQQLCxgCAiYCAjIlBg0IAQEEGoJigmUBAw0iAqB3AYE6AgKKHXqBF?=
 =?us-ascii?q?QUBFoEBgggBAQY6hA0BIygDcYFbCQkBgQYsAYFcjGZDgUlEgViBZoEBPoddN?=
 =?us-ascii?q?4IulXIKMByBAIEdoCmCE54JXoJzDwGBLwueOBWZWY49lk6mSgIEAgQFAg4BA?=
 =?us-ascii?q?QY1gVUBgWszGiNQgmlOAQIBAQENAQIBAQMBAgEBAQkBAQEBjh0MDQmDUIp/I?=
 =?us-ascii?q?TM4AgYBCgEBAwmHQ4wJAQE?=
IronPort-PHdr: A9a23:KHq9zx0vrS7oOubcsmDONg0yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BaFo6Q1xwaSA83y0LFts6LuqafuWGgNs96qkUspV9hybSIDktgchAc6AcSIWgXRJf/uaDEmT
 owZDAc2t360PlJIF8ngelbcvmO97SIIGhX4KAF5Ovn5FpTdgsipyey+4ZnebxlHiDagb75/L
 Qi9oBnMuMURnYZsMLs6xAHTontPdeRWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjT
 bxFFzsmKHw65NfqtRbYUwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr0vRz+s8
 7lkRwPpiCcfNj427mfXitBrjKlGpB6tvgFzz5LIbI2QMvd1Y6HTcs4ARWdZUMlfSjJPAo28Y
 YQNE+UPMulXopLhp1YNsReyGRWgCe3txzJOm3T43bc60+MkEQze2wIgGMgOsHvOo9XzKawcU
 Pq1w7fWwjXFcvhb3jL96I/SchAuu/6MW71wcdDPxkYxEQPIlVWQqYv5PzOQzOsNsmyb4/B8W
 uKojm4qsgd8qSWgyckwkIfGnJ4Vykza+iVjxoY4PcC0RFJ4bNOmDpdduCOXOpd2TM8+XW1lu
 SY3x7IbtJKlciYExooqywLbZvGafYaE/h3tWeKeLzp2in9oZK+zigi0/EO9yeP8TtG53VlWo
 iZfltTAqGoB2hPN5sSdV/dw/1+t1SiO2gzP5OxJJF04mbbAJJMgx7M9lZ8evEbAEyLznUj6k
 a2be0M58eay8evneK/pppqEOo90lA7+NqMul9SnD+kkNQYCQnSX9f272rLj40H1WbJKgeYon
 aXDt5DaONgbqbW+Aw9I1IYs9gyzDy+80NQfgXkIMk5KeA6Gj4juPVHCOvf4Deqjg1Solzdrw
 PPGMqf9DZXKK3jPiLbhfbBj5E5A0Ac+wsxT64hQB70fOv7+VVH9uMbFAhI4KwC0xvzoCNR51
 oMQQ2KPBaqZPbvXsV+P/OIvLPODZIkauDbnNfcq+fjugGQ5mV8aYamp2IEYaHG8Hvh8P0qZZ
 n/sjs8HEWgRpgU+VvDliEWeUT5PYHa/R7ww6ikhCI26FYfDWpytgLuZ0Se/BJJXaHpJClSIE
 XrzdoSEWvIMZzmIIsB7iDAEVL6hS5Ug1R60rgP6xaBnIvLO+iIErZLjyMR15+rLmB4u8jx7E
 9iS02CWQmFvnmIIQic207plrUx8zFeDy6l4jOZCGdxd/fMaGjs9YLzBy+1zQ/T7RQvFep/dS
 kuiQ9zgBTguR9Y1694IeUd0Xdu42EPtxS2vVpoSjbOCAtQb6K/R2TClIsFnxH/A27Msgl8OQ
 sxTMGSnguh08A2FVN2BqFmQi6v/LfdU5yXK7mrWiDPW5CmwMSZ1WKTBBzUEY1fO6M7+7QXER
 qOvDrIuNk1Az9SDI+1EcI6hlk1IEdHkPtmWeGetgyGoHx/dw7SWY4PsdH8Q0SP1CE8YlgkS+
 TCNMg1tTjy5rTfmBSd1XUnqf1uq9OB/rH2hSUphygaQYERn2KC49xg9hfuATvoS2vQPvyJy4
 y5sEgOF1snNQ8GFuxInfKhYZoYl50xb0GvCqwFnFrqJCvk6w3shKUFwtU6o0AhrAIJdl8Rst
 Gkt0Ad5NaOf1hVGai+c2pfzfLbQLwEe5TiJbKjbkhHb2deSoOIU7egg7k/kt0evH1Yj9HNu1
 59U1WGd79PEFlhaV5W5SUsx+xVgwtOSKiAg+4PZ02FtOqioo3fD3dwuHu4s1heneZ9WLqqFE
 Ab4F8BSCdKpLaQmnF2gbxRMO+43luZ8OsS8ePKA17SmMeBInDW6iG1G5MZ21UfNvytwR+jU3
 ooUlumC11jPXDP9gVG998HvzNwcI2BIWDblj3G6V+szLuVocI0GCHmjOZiyz9R63dv2XmJAs
 USkDBUA0dOofhybaxr82xdR3AIZuy/C+2PwwjpqnjUutqfa0jbJxrGocR0dNWdNS3NvgFHEI
 Y+oitkbWA6jaA1jx37HrQ7qgrNWoqhyNTyZREBScCHwIHtvX62Ytr2eZsdO7NUjtiAdA4HeK
 RiKD7X6pRUdySbqGWBTkSs6ez+dsZL8hxVmiWiZIR6ftVLhcNprjVfa7d3YH7tK2yYeATN/g
 n/RD0S9ON+g+ZOVkY3Cu6awTTDpWppWeCjthYSO0UnzrWhtGxK2mf+pl9DhOQg9zSry1t0sX
 iLN5BrxeYjk0a2mPPkvIhEuVQW6t5A8Q982m5B4nJwK3HkGmpiZmBhP2Xz+N9lWw+O2bXYAQ
 yIK38+A5QHk3EN5KXfaj4n9V3ib3o5gf4zmOiVHgGRhtYYTVvTxjvQMhyZ+r1umoBiEZPF8m
 m1Y0v4y8DsAhOpPvgMxzyKbC7RUHE9CPCWqmQ7birL25KhRemurdqC9kURkmtX0RrSFuA5VX
 nnjd5okNS938sB2MVaK23r2oNKBGpGYfZcIuxuYng2Vxe1SMp04kPUQiCdhEWL6oXgsyup9h
 htrl8Lf3sDPOyBm+6S3BQRdPzv+apYI+z3juq1Zm96fw4GlGpgyUiVORpbjSuikVS4Drfmyf
 RjbCyUy8z3IfNiXVR/a8kptqGjDVoymJ23CbmdM1s1sHVGcPBAN3FhSDW98xthhUVn3jM35L
 BUlvnZIvgG+8l0Ujbs2Unu3GmbH+FX1MHFtEMDZdFwOqVger0bNbZ7Htr41Q34eptv561XSY
 m2DOVYSBDlQCBXdXgLtYuH2t4uHr7j9ZKL2LuOQM++H8bUMDq7Rl5zzitA0rXHQZo2OOHJmE
 vE2iFFbU3w/A97ehzgEVy0QkWTKctKfoxC/vCZwq6XduLyuUQbrr+NjEpNqOM50s1CziKaHb
 auLgTphbCxf3dUKzGPJz74W2BgTjTtvfn+jC+ZIuSnIRaPW0qhZanxTIzt0L9dN5rkg0xNlH
 +f+04uw84Eiy/k/BhFCSEDrndyvaYoSOWahOVjbBUGNcrObOTnMxMKxaqS5LN8YxOlZrBy/v
 z+HHlSrYmzFxmOvC0rpaL8EhTrTJBFEvYChbhthQXPuSt7rcFzzMdN6iyE33axhhn7OMj15U
 3A0eEdMo7uMqCJA16knXT0bqCY/a7DayEP7p6HCJ50bsOVmGHFxnuNeujEhzqdNqTtDT7pzk
 TfTqdhnpxenlPOOw3xpSkkryH4DiYSVsEFlIaic+INHXCOO+RUX4myWBA4Hqt1NCtrzvqlRz
 p7Ek6e5e1Igu5rEuNARAcTZMpfNKH06LR/gAyLZFiMjZBvybST6uBYYl/ufsHqIspI9t57g3
 oIUTaNWX0A0EfVcDVl5GNsFI9F8WTZuwtv5xIYYoHG5qhfWXsBTuJvKA+mTDfvYIzGclbBYZ
 hEMzOCwPcEJO4b8wUAndkhikdGABR/LRd4U6H4EDEd8sABX/XN5VGF2x0/1dlbn/ioIDfDt1
 h8u1lkiOaJ8rnG0pQ9wfweCpTNswhVp34y93nbJNma2dfnVP8keCjKo5RVrdMqjG0AtK1X1x
 BAsNS+YFesJ0/08KiYzzleb4MQHGOYCH/dNOEZCnKjONft0iQwO+GL7lSolraPEEcUwzgJyK
 Mz19isS1V47N4xnYvCAbKtPxVxNiq/cpTem2qYp2ggCKk0R8WSUPikVpEgPMbpgLC2tm44ko
 UmLnz8JEIDtf9wDh6sys2YCYaGHxS+m1KNfIEesMeDZN7mep2XLic+PRBU3y18MkE5Gu7Nx1
 JV6G6J7f0Ao0L6YFhBPPs3He1g9hy969H/PeC+PtaPGxpcnZ+2A
IronPort-Data: A9a23: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
 FhDXBMbHK8IgVrub13kpg==
IronPort-HdrOrdr: A9a23:jP4IXKvCtPspxN332QUNew707skCo4Mji2hC6mlwRA09TyXGra
 2TdaUgvyMc1gx7ZJjvo6HmBEDyewK4yXcT2/hqAV7CZnichILMFu1fBOTZowEIdxeOj9K1kJ
 0QC5SWa+eAfGSS7/ya3ODQKb9Jr7e6GeKT9IHjJh9WPH5XgspbnmVE42igYylLrUV9dPkE/M
 323Ls6mxOQPVAsKuirDHgMWObO4/XNiZLdeBYDQzoq8hOHgz+E4KPzV0Hw5GZWbxp/hZMZtU
 TVmQ3w4auu99m91x/nzmfWq7BbgsHoxNdvDNGFzuIVNjLvoAC1Y5kJYcz1gBkF5MWUrHo6mt
 jFpBkte+5p7WnKQ22zqRzxnyH9zTcH8RbZuBKlqEqmhfa8aCMxCsJHi44cWADe8VAcsNZ117
 8O936FtqBQEQjLkE3GlpL1vilR5wWJSEcZ4KAuZj1kIMAjgYZq3MAiFA48KuZAIMqSg7pXYN
 WGQvuspMq+SmnqHUwxjlMfs+BEYU5DaytuYnJyzvB9gAIm60yQoSYjtbIidzE7hdoAo0Yv3Z
 W4DphV
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,391,1635199200"; 
   d="scan'208";a="22912311"
X-MGA-submission: =?us-ascii?q?MDE/iE/KDldCKfV2AGQfwWneuOmVFC5/uA7zW9?=
 =?us-ascii?q?1wfUZU1Rsdvh/yxFh3D9ZrX193chLVUhrqMPUBP/8dEWKpFaZUP4+O3+?=
 =?us-ascii?q?DZIFIsHGFPYn09CQjTtIfmcoKu2aitg0YzT/WDz9rvnKRpvRAw4KTvIT?=
 =?us-ascii?q?SiRb9BcjjJJfFU+MjzLDJixQ=3D=3D?=
Received: from mail-mw2nam10olkn2016.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([40.92.42.16])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 21:45:39 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNDb1TyhNlUINBxMj/Gi+0rQ8DK6kC5Z5qGXgxY7FrS1DrtYdI0lrj0p0LvB/gi5XYzx/lJzN1hP4L9XjNJRebNv7XNSX+UMeYLgYH8AtAIlQ7SIOvSHxKn9QOgfDkAeXPdPALpJ9Qh+5NZ3xpKhDsLDOFRRCb91RmALFW5ygGWf6d73FSBJCAREjDoV2phOYHrQaf3adkOqtn6/ItZqnLyDIZ6bgXCPC7jEghfMu6o7hhoejSBRFdabM6N5nvYmaHQsoDSFVYeEFkUdWQuSfYjykzHgX7kZqcOU7lW3kYNPUKcsfbfuQXMs2BwNaAqybRMhiz6ireTeIZmW17rNdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXwYOQ1wfWaxt2Pgw5b6FQ0wklri3kCCsyBeChJ3VOM=;
 b=fh/zYRvYZMG7ACxBCTjK9PGmo/y1LNmjbQk9CfRGw5qCv80aRF+C7WYu1dprZnnH7ZyaGCGfJHImQg8UO8hiWuOYhpxL/3t5yCyajSYVD4IDGHKHI4iDz1d9fTWUmyHMemMtmIpqfatWLv/OQkZSQz2OrEMDc/di36K3aQWIj0zO9o20ycIsg/yAhx/+SRnv/FnQ2BbNoU633ZIqz+M1M4q8eXWylRmCvUk3f2jwKNm8bsoKNKDGgx6UukqcikrW2xGEbc2VQ/Vm7c2J1jq0MkQnKH00fBkjHSCzjcPLVne2Z/D1g0F4MUnfQXpjwAvY9yR8TcshHw6TqEyNqyyFWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXwYOQ1wfWaxt2Pgw5b6FQ0wklri3kCCsyBeChJ3VOM=;
 b=XNRGtm5eQlB0ruKCFgUFjIGn2mTbFN/Y8UWmtkY8i6g6I6moURlZPFb77ceHw3IAEwfk9H9osJofuBnmxmlfl0Zgr/TNRNXt0RnFXPHJmrlSxkWDbcZYRtn3tgqltaV5IxK0q/QfXWBz4d+EvkPC2q2Q2je0YO5KBL1iKLgLuQz5WU7/XDkklxq4agwKKc9FI6uGQ1wJTY5EGG70M7aaT5OC0QhL9P7leafmqh6GXHX+wWL71DyM8tF85B0kpOc7/3Ya9yGvgE6prqBqqqI31+vmCrSKuJjq13S4YEMgDTWuo/z2qGwIqdCp+zuGBLISjKP7ggYbPys/1xOpzL/j0g==
Received: from DS7PR19MB5853.namprd19.prod.outlook.com (2603:10b6:8:78::17) by
 BN0PR19MB5264.namprd19.prod.outlook.com (2603:10b6:408:153::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 20:45:36 +0000
Received: from DS7PR19MB5853.namprd19.prod.outlook.com
 ([fe80::b0a1:26e0:7bde:f54]) by DS7PR19MB5853.namprd19.prod.outlook.com
 ([fe80::b0a1:26e0:7bde:f54%7]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 20:45:36 +0000
Message-ID:
 <DS7PR19MB5853B84D171CA6442455C92CAC3C9@DS7PR19MB5853.namprd19.prod.outlook.com>
Date: Wed, 23 Feb 2022 12:45:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Julia Lawall <julia.lawall@inria.fr>
Cc: "cocci@inria.fr" <cocci@inria.fr>
References: <DS7PR19MB5853948767791AEA2E6E290FAC3C9@DS7PR19MB5853.namprd19.prod.outlook.com>
 <alpine.DEB.2.22.394.2202230917570.2977@hadrien>
From: Morgan Green <morgangreen@hotmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2202230917570.2977@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [0j/6662WI8D90Odgxz1wDnehir+oEDyt]
X-ClientProxiedBy: SJ0PR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::13) To DS7PR19MB5853.namprd19.prod.outlook.com
 (2603:10b6:8:78::17)
X-Microsoft-Original-Message-ID:
 <355a18f7-a91a-138f-0f89-f440dbebe9b8@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cc50872-9700-479b-01bd-08d9f70d715d
X-MS-TrafficTypeDiagnostic: BN0PR19MB5264:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4tDFQe115G2So3JNq40I6qEZQbBVRF0/O/ybESP+z/8I4/p7qHAX6w8sboTtZIGmAJ2ZwqPRYJz5Hjp9mln6PdKeZSczqyPFOs4nDlHpE+wPv9UrQBwsm6KxgVqrkPpQFlpc+VmxlNmjkaokxthab6A6NnBVJGpPNCAIHbowp87/X8RtWEu920BR8yQI6yhKTD0nb+nsluXH0HKBZTwq9qFvQQqx+LqR45u2mk0vm0RSQ3XJ25pgp68IIK0mwMEk+PeIKKtimV0itDWObw9HNnUo852Ca7rH5qLtSJb43MXMa3xcxA6sWiGyrUYvY/GzjPYCl1eh/3cngRxFycTB8te8HSwkmT59tAXlVS0MzH8vEw+/m+mFHuXRBceem1PKyBBFzDcz0AOtxxLSJQLywBLmbsgdjH+/W2pcYy0CEgyZ2fR9pxwdlqzliDK9ONr+kEEskLLWHTiHGmTMjVqfFXrI9/O1z0lw8w+1Fo9Ynd3GuaqMR57NBeLfZJ3Lf6OC1Mmt6vB2gKhREmSkSKfuIfDYl1vyCAMctMw8qPZ052WT0HkmSKKrP61pivx853Wj5KV0Rri4NJGdWOIIKBVsPg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFM0aENKMVE0RDVHYUxNSGhmdnhweDhSVGZlVzUzRERCQTZMM1cybGFnanA4?=
 =?utf-8?B?YVYwZFN1RDEramtNSjJvcjhXMnZFVXdvbVArY0xGOTR2L1pLQUJqUjNtWllN?=
 =?utf-8?B?SmtkeXhjREdnNWpLTEtlMnN6NUduMzl5UkdlNm9LMjJjYXVqVVVGWDNBVkh1?=
 =?utf-8?B?VW9Yc1JZZFFuWi90TUgzQXovNDhJV0NKZWtJQUV3K1l1YXFUKzZ1UzI2dnhv?=
 =?utf-8?B?RFk5d2drTi9ZL1BTQmx3alJJdE5qSWVVa0xiMkV0U3FhT3BiWm12YVNlTmdD?=
 =?utf-8?B?dzQrekZoRFJxbjJCL2djc3pSVW91dEp5a1RIa0F0b2sxZGltQ2dOWWxyeXl5?=
 =?utf-8?B?VkVuV2lIWFVISHNjMk95OS8xMkxTYkNyMzlYN2h2VnF3TWd6UWJEV0hEOVdx?=
 =?utf-8?B?SGs3SFFiWWFlWkJFU21Vb0VnMXJPK1pKc1BqeEsxY0ZkaWF3MHo3d1d6cE5t?=
 =?utf-8?B?VDNtQVlnSWpqUlpKRHZRN1ZWZW5kTTZ3dnk0aHNxQThYc1JpS1FRdVVEcTND?=
 =?utf-8?B?c01jczNNTTBWMWxFWWlJR3ZQcmpDb05YTTVlMW5pQk5maW5uQ3lVSHhRUHE2?=
 =?utf-8?B?NlZsbnZKeXpTR1BiSVFOSDk0Wi9GSlZ0NXNtbGhCM05iZDF1cFhZNS9XMzBs?=
 =?utf-8?B?RVFsMDY5SE1Oa2xlMEpNb2Y5UHdYaktoN25DS0JzWVBLaGc1QnRWR1puMktr?=
 =?utf-8?B?MUE3K0JwcURzMmNPdzBJWlJBMnNocWtXdXZCbzY2dWw3K1h0Y0p0VTZMWHh0?=
 =?utf-8?B?T2ZoN1lXTUNCcERaa05RRlFteENhUU44L2VsUWptNmlRSnowdFg2dm9wOXJL?=
 =?utf-8?B?RGdtNjFzUmZIeXhGdFBwZjRpdWZEUWJaYWd2UDYyRm4vZzVESFRIODlla0pI?=
 =?utf-8?B?SlorWDZ0M05udTRValpIUkJSbGxFZWZtRVNYaDBPWVNuek90V0kwQ1hkc0Zr?=
 =?utf-8?B?UHlzWWRMOTlSYlA2NWtLN095anZjVE5VdkFSaDBTK1dxVkcxN2V0TTdJWjdM?=
 =?utf-8?B?dVlDNEl5NWlSeElWdk8ya0VhWWxDVlhBOGhlS2JjTE5aZUdNNTVCVTEwcmxL?=
 =?utf-8?B?anVSY0djNHpQd1FUTzNxZDNsR2YzVlN3cEZuNHAxUWpkQmlKVEVubTVxWHhU?=
 =?utf-8?B?Z0owREVZdXpBaWFRTEtBYmdzZlpldXFOd0QzajFRMkp2N0VRakpROUt4RFQy?=
 =?utf-8?B?V1VjYUFUbzZlMDdqeDlwbXNxaFNVRDFBQTAvVDZnaVN2VFlzVUh1NGZKZjZh?=
 =?utf-8?B?eXY1SmtvUUZ1WnZJZ3VLZXBIYkJsdnpYK1d6L0RVdjNDVEx4Zz09?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e7757.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc50872-9700-479b-01bd-08d9f70d715d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5853.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 20:45:36.2580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR19MB5264
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] C++ support
Reply-To: Morgan Green <morgangreen@hotmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 149
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/DS7PR19MB5853B84D171CA6442455C92CAC3C9%40DS7PR19MB5853.namprd19.prod.outlook.com>

On 2/23/22 00:20, Julia Lawall wrote:
> 
> 
> On Wed, 23 Feb 2022, Morgan Green wrote:
> 
>> Thank you for the incredible tool!
>>
>> I'm attempting to use it to clean up a large C++ code base. I'm aware that Coccinelle has minimal C++ support, but decided to try it anyway. The code I'm working with sticks to the basic C++ features so I thought it might be sufficient. It mostly works when I pass --c++ to spatch, but there are a few basic C++ things that cause parse errors:
>>
>> 1) constructor definitions with initializer lists
>> 2) class definitions
>>
>> Class definitions failing to parse prevents functions that are defined inside a class definition from being parsed and it also prevents functions that contain an embedded class definition from being parsed.
>>
>> Here is a minimal C++ source file that demonstrates all the problematic cases:
>>
>> ----
>> class foo {
>>      foo(int val);
>>      void do_nothing() {}
>>      int val;
>> };
> 
> Would it suffice to ignore the "class foo {" and then parse the thing
> inside as normal top-level definitions?
> 

I think that would be sufficient for my purposes. At least it would help. One 
thing to note is that class definitions often look like this:

class foo : bar {
     void func();
};

If the parser ignored everything from "class class_name" to the next '{' and 
then parsed everything to the matching '}' as normal top-level definitions I 
think that would be sufficient for my purposes.

> I see already that you have foo that has no return type.  Is that correct.
> 

Yes, that is correct. Since that function has the same name as the containing 
class it is the constructor for the class. Constructors do not have return 
types. Will that also confuse parsing? I've observed that constructor functions 
that are defined outside of the class definition and do not use initializer 
lists are transformed by coccinelle so it seems that functions declared without 
a return type are generally accepted.

>>
>> foo::foo(int val) : val(val) {}
>>
>> void bar() {
>>      class bar_internal_class {
>>      } local;
>> }
> 
> I think that this would be harder to add.  Currently we don't support
> nested function definitions.
> 

For my purposes it would be fine if classes defined inside of a function were 
ignored entirely (ignore both the "class foo {}" and everything inside the 
braces). I'm very unlikely to need to transform any code in functions that are 
defined inside of a class that is defined inside of another function. However I 
would like to transform code in functions that contain class definitions.

Those changes would be great, but the biggest issue for me is failure to parse 
constructor definitions that use initializer lists. That's the "foo::foo(int 
val) : val(val) {}" from my example. The initializer list part (": val(val)") 
seems to confuse the parser. Ignoring initializer lists would be sufficient for 
my purposes. In other words, if there is a ':' between the ') that ends the 
parameter list and the '{' then ignore the ':' and everything between it and the 
'{'.

Thanks,
Morgan
