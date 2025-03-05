Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A259EC28B23
	for <cocci@archiver.kernel.org>; Thu,  6 Mar 2025 09:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=UQbUit+5zZWvM3SlWjrJzXkwH86fS/D5nSszFoJyIuw=;
  b=HJRBfFQVw/hFsYD8UZ3uSdqXMrhh3TqgUyE7ZM2QafLlytEXLba0Yy5x
   FdGYnbdgwI5BgSI+kahvOIFbnRp7SzgrDQfaZwFKnHmPdvvzTPgwgLlwo
   HlmDH2zkLOW8YbHMIH0St4PQnKhl5z2RkOtkEi2JxXeRknolvtCcRQ6B2
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.14,225,1736809200"; 
   d="scan'208";a="211491999"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2025 10:10:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2D7EFE0D21; Thu,  6 Mar 2025 10:10:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C951DE0260
	for <cocci@sympa.inria.fr>; Wed,  5 Mar 2025 08:41:42 +0100 (CET)
IronPort-SDR: 67c80037_cXosJ3eH84PtIf+DciPDCVM/l7wioHz7eJnQd0ISM3kNcJO
 XdlRTImVGYOCT5I55k1u5I7F3AZX7ueVqgdjlPg==
X-IPAS-Result: =?us-ascii?q?A0ESAAAd/8dnjxBBr8ZaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YFxUoFZMQRThFaDTAOETqIOhAYqgSyBQD4PAQMBCwEBQQECBAEBAwSFAAIWi?=
 =?us-ascii?q?wACHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBA?=
 =?us-ascii?q?QEBOQUOO4V7DYJiAYEkXgcJOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECD?=
 =?us-ascii?q?V4BAR4CAQMSEREMAQE3AQ8CAQgaAiYCAgIvFRACBAENDRqCYIJlAwEEom0Bg?=
 =?us-ascii?q?UACiyWBMoEBggwBAQYEBN19CQkBgRAuAYhOAYFsg38bIINCeieBZUOBV4JoP?=
 =?us-ascii?q?oRFg1k6gi+CM0WDe2eaBo5cCUl7HANZLAFVExcLBwVkRRAzAyAKNDECFA0PE?=
 =?us-ascii?q?AYQBGoFNAo3OoILaUk6Ag0CNYIeJFiCK4IXgjeEPYRCgj9RgkKCEXFvAwMWE?=
 =?us-ascii?q?IIwb3cchEM7hHIdQAMLbT03Bg4bBQQ6ewWhKIR/gUNSmDuvPgMEA4QboX4Xg?=
 =?us-ascii?q?3ABpmYuh2WQayKoZwIEAgQFAg8BAQaBZzqBXHCDN08DGQ+OIRmDYchwRTM8A?=
 =?us-ascii?q?gcLAQEDCYVGAQGKVIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 QAIeIyPfK13pYMd3yqtl7651Sz1ZA/S8gg=
IronPort-HdrOrdr: A9a23:i44R2qpcu+BICiVYFsw7ry4aV5qIeYIsimQD101hICG9vPb4qy
 nIpoV86faUskd3ZJhEo7q90ca7LE80maQY3WBVB8bAYOEJ0FHYUL2KrrGSvgEJIkXFh5FgPN
 5bAtZD4YTLfClHZKTBgDVQYuxQpOVvq5rY/Ns2pk0FJWpXguNbnmVE42CgfXGeLzM2YKbReq
 Dz2iNvnUvRRV0nKuq6G1gYVKz5q9XQkpWOW299OzcXrCePkBK14/rAHxKZxxcTVC4n+8ZYzU
 H11yL4+4S+uLWBxhXdzm/e6IkTsNbt0ddYHqW3+7ooAwSppAa0RZhrH4ePuz04u4iUmS4Xud
 TBuQohOMxv63XXZAiO0GjQ5zU=
X-Talos-CUID: 9a23:ADzLA2O1JWRr0+5DdC922lU5Btkcd3jA90jIO07hJCUwR+jA
X-Talos-MUID: 9a23:EC42HQZAwI02n+BTvGXlgGhiDMdTxbXyGEUc0qst5du1Onkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,222,1736809200"; 
   d="scan'208";a="211242634"
X-MGA-submission: =?us-ascii?q?MDHgo8qIPdZsy8z43/5NuzVa4nhdqey6kLehJ8?=
 =?us-ascii?q?hBebAUNAl2fHf7gHVo9XbZqDbdSE2wJEk3IWSnxzRBtLwLm/ljL09Hop?=
 =?us-ascii?q?r1EQUXpYCMjsmNL3bDp5zxOCP1hKxI5omavXO2CoNucakRM0CVBCd/g5?=
 =?us-ascii?q?CMnL47gpoVUxtHlto/zpmD8Q=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.16])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 08:41:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741160502; x=1772696502;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UQbUit+5zZWvM3SlWjrJzXkwH86fS/D5nSszFoJyIuw=;
  b=lEu1t4zY6lKWHlbvW73NPPkJBfM8OVnk9sAQbLxB1QEuSnDSyGL+a8P0
   qX6TpKVLHws+EMJGS4zgU+1lz9SVWaeiczRfbA/6ltj6ouXCi5FrLz5T0
   ut40qzUCoAEOnCniQFplJQA1ZGTB4pbm27yy8CbGjzZatcRNM/QQMnH0E
   20ornCvxlfr4o4hBjvBTt//QldtOAxBEAKXpNDxkVAzNIwvnkHinzY8UJ
   F5gf3nZ3nHYh4msmaQx0Yh8J240artxAAKYzVHMWqPqS4L+KB0Pb3fzHS
   YpAAAtI7XkxENUj3XBlxEHVRLkSZmSTwvzpMjyQMYc3rBq3rUdi1azDeu
   w==;
X-CSE-ConnectionGUID: mz46+UWLQvKcOo8x4YBUEQ==
X-CSE-MsgGUID: nX0YxO90TwegAwfqO8zNDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42233590"
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="42233590"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 23:41:37 -0800
X-CSE-ConnectionGUID: S4sHzSLjQ8aa96ZEGbHlhA==
X-CSE-MsgGUID: 8g4Ihi6SRPyRnv3nLjH4VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="123713217"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2025 23:41:36 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 23:41:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 23:41:35 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 23:41:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETZJDZPzSKBO8z6yoUQtOozwCNuScV8VB84wbOgGPJUHXLfwMYTiEwZ/ziEe7Ag3ym7jcNtl7duRigAviYxxOlaAlfmV6SUbHAF/Etq29Azj+5rKC46cAaIhoqMt1qKpn/cBwwCSlN4kCupytAwGBOuDirYUIWkH2ECSA0d1ZbAZwexoYPwXkuupkmO2Pilc2zTpkYCXVrCfAJgPxVhEBt57VGsTYUqr+Y79E3ncABjIi+9OcbWXfT6RYmPblLqKo7eHCkrsB5vr8kEi5e/Bgr1c5UtVodqNqjy+6uwlo25U6/QSUSPLPgPF9jonuNWdlv/i9vOLsbLgI5mDhB9vow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQbUit+5zZWvM3SlWjrJzXkwH86fS/D5nSszFoJyIuw=;
 b=YdX8wAO8FllC2d+WqPDpSRVAr2V4kzzdC9S3J/UMgPPxJOornJVUIcxVvXDZAw58dVXCPBHvrV5ecpLbh2OpzW/Nyngcd3qhXRmxCaRzOnP0M1S+cQTHwzx1aPaU/e7XzB8Ira6BP8lRW53Rwu+vuhJncm5cSIG1NOWB8jawjYEj9TjB2xBpc1iiMxTG/RU4UKLK1LNT3H/K9n9iMrpM0cXqqXA5ajnc+Pb0oWMoKTUfJL8oHvsYN22LEEh04WnZstDITb0KwfHruU3NklhQyA8rLlSJamf/502mgptmRsaE9rQ3I5vcu3GpGzlt9beEmbJ8qAq93tHwpIlnkEsMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SJ2PR11MB8514.namprd11.prod.outlook.com (2603:10b6:a03:56b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 07:41:25 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 07:41:25 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: "cocci@inria.fr" <cocci@inria.fr>, LKML <linux-kernel@vger.kernel.org>
Thread-Topic: [v2] mei: Improve exception handling in mei_cl_irq_read_msg()
Thread-Index: AQHbjaGo/h7lckMaCEGr+8VcG23btrNkKB7Q
Date: Wed, 5 Mar 2025 07:41:25 +0000
Message-ID: <CY5PR11MB6366E6F52B68E8258EE47F3FEDCB2@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <00589154-00ac-4ed5-2a37-60b3c6f6c523@web.de>
 <b7b6db19-055e-ace8-da37-24b4335e93b2@web.de>
 <MN2PR11MB40930A824DF68F96A93E1B7FE5859@MN2PR11MB4093.namprd11.prod.outlook.com>
 <df3ce733-955b-45f3-98bd-04ddb2200eca@web.de>
 <CY5PR11MB6366D07A7F302780A87160E6EDCB2@CY5PR11MB6366.namprd11.prod.outlook.com>
 <ccdac63a-4a04-4243-9350-05acc23f413b@web.de>
In-Reply-To: <ccdac63a-4a04-4243-9350-05acc23f413b@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|SJ2PR11MB8514:EE_
x-ms-office365-filtering-correlation-id: aa54ba6c-3b70-41f1-5697-08dd5bb92213
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MU9adXlzdTIrRkJyRVlkTmxnZW9hRWxpQU56YUg5RytVS3dBc1FBZy9GL3ph?=
 =?utf-8?B?WDQ1TG9QTCtsYU9GalIySWVJekZmSzBwUDY5cTVXNXd6NWFwZm9xNURiNW5C?=
 =?utf-8?B?K3VuVDZnSlliRS95RDV1NzBacUVOcVMzREdqcXNHVEVVWTFiZ2kvSGxLOEtR?=
 =?utf-8?B?K0NWdWhwV3JUNzNoZzlVYklUWXdWYk53UFlZUXlOMDNMdU0xa1F3NTZEeE80?=
 =?utf-8?B?US83RFdKUmhqZkxDSmhvanFIK1JENmRHTlVMZFREQ2t0V3JlaDdIUzVydlZN?=
 =?utf-8?B?M2xxdEdPVUxQYkZubWlxM2ZNK2ZhbURxWnRuZ3E3Q2hLRitnY2hrSHByYktP?=
 =?utf-8?B?aiszQTc0My9JL0w1NXJqK0NSL3VvT1RCYklNZkJLVFFYd3g5VU4zZW5BV0gw?=
 =?utf-8?B?RStWVXN0Y1kzMjFSZHlSUDZwcjhvWXpwMkVaZHU2amtmaGNvVTIvSDdjWTVN?=
 =?utf-8?B?NGNZUjVyY3N2d1ZwN0tJamtPUkdiRXJBVHJsRXhxR1QvTkNjanhvK2VWNXZ4?=
 =?utf-8?B?eldZWlQ3RU16OGdtMGVBalVKS1F2S0psQWJuTk10Q3JWQ0RQZWNGVkxnQXZ5?=
 =?utf-8?B?UFp5ZGNDM0NYZ1pGZm04dThWWVYraERFbGM3UTJwdFFVOGxmcWNBWGRHKytG?=
 =?utf-8?B?V2s3WTRKekhkSEwwMDQxQUYrdll5QVVOai95VXRVWU9ld0Naa0ZZaGlYL2Zt?=
 =?utf-8?B?Zm54UHYzeTErRU5Ea0dMcFh5dW1sdUpNYTYvbnFVeHpSeUx0VzltaklDZ2ZY?=
 =?utf-8?B?dERMa0pXUzRqSC8xNnllMzhjYTQ3cHNDZlhTdSsrZFl4TWRrMWpUUjZwRlZz?=
 =?utf-8?B?Sk44WEtacnlHY1o3OFJVVWJmZURjUkVwQ0w1d2FEcG1rVkE0TFZJVjVFTHVl?=
 =?utf-8?B?cko1dGhnLzV5dkNrK011dXJsek1lR0I4WFI3MGtScEFBcFZKaGJtYjBVOGEw?=
 =?utf-8?B?UERmWUZpM3Z2MXVsR1l2Z2FZOHg2RGpnYnJQdjB2Tjdna3pvQSsrMVNuRHg2?=
 =?utf-8?B?Q0FjOXNpVGR3ay9TR1lVNnpLRXFSYllEek1CckZTU0RUSlpqWlM0cjM2cmNJ?=
 =?utf-8?B?Ujl2b0NjWUJEM1ovL0JwblRiRHFEcFU0SkpISVFhY0NoR1pXZFhqRlc4bGlw?=
 =?utf-8?B?bXZJWU1IVWQrckM5ZmN4RGpEdHlHQWZxQWdqNk5RNzZQdXpzN2xoWkVwdlhM?=
 =?utf-8?B?ZlJWZXN2clJoajJJdWJGSDYvZW1UdDNjcW1mdy9nb2hhKzY1RWxMU1hPNlVk?=
 =?utf-8?B?SjJmUzh5TmNYclU5U0kxY25YMjlic3lDMGU3T2dSUkM2UzhPM0VSNFhKamx1?=
 =?utf-8?B?ZjdnTlF0WXhEb3ZZRFRqRXJnK0pYUHh5MFFVcmV0NG1nOXErWjBkeXRBbHJv?=
 =?utf-8?B?NTZOMGNlaGpqUk5talE2MmxZWitOK3VrdGt2ZHh5QldkMHpFK3BZcHpUdjZJ?=
 =?utf-8?B?SmUwZHlSaGhXRW5pdzZBZjZMaktERUxoU21sa3oxNXFaTTh0YU5MNVBXM3Vo?=
 =?utf-8?B?UUFsYnpyVjljc1lkV1Y3aGd5V2RGWkFPb2hKanpPbkxmZVg3UXE5Ymg1OVdC?=
 =?utf-8?B?TkhTUjdueXRWc1BocXNadFJVaU1QSDRKdklCdmQ4L0VxWDZjSGtvbk1sd05j?=
 =?utf-8?B?RlVFTzZ3QWJZNnRCSTVJLzdlemM3ZFROZHpBZUhha0M1YVZCR1dtbzI4ZFdx?=
 =?utf-8?B?Qlp3enV6aW1Oa0w1cTlGd3d1TVlna1MyYmtXUzJJN29xNjYzL1lMNTQrTStP?=
 =?utf-8?B?NTdBcGtYR2RJaEorMFBiTDdETXJVK3BoSEt5VDJUKzBMa2luTUlDTGZYZElZ?=
 =?utf-8?B?d0sxSmRrdmlYc0lSOUNSaEY1eVNtYVBrcHVnTHZHUWN6c05lQXNOWjRLdCsw?=
 =?utf-8?B?Q1FlM2txajYvaktLQmNjUjcwcEpTK3BmRUp0bUxZRkdtVFRUV1BHTTVOMXBn?=
 =?utf-8?Q?eGG20btv/6zXazpCkbsSWCs18MD6qFOD?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OC94ZU1YOXo0VE5iUmVma3VQdk4zcXE5Uk5oS0NIMndlUEdBcFpkai8yWkI0?=
 =?utf-8?B?OUF1NVRkdC9XcE4rM1plb0xscVU3K3hmeS95bDRHZ3JxWStjVGFxVXlGUEw4?=
 =?utf-8?B?VXlrTnNJaDJLbDhWbFI0dnZwLzROSExkQmVUNE1IZTZaQmhreGZyUnowZkg3?=
 =?utf-8?B?WFhKeFBzVU1PdytzOWduWGhuYWtrNlVHSDYra2pBdW13RHJ4K1pSQnpyNGtW?=
 =?utf-8?B?NUswZFEwOHJGVWl3VU9wQ0UybHZkbUo5anV0dlV6QWRPMEdhSXY0aHpjK2xR?=
 =?utf-8?B?dUlGWTJXZHVSZloweGlUaXhxNjVZZkpuc0FqT2pvQWkyYVdtRW43T1ZET3NE?=
 =?utf-8?B?bFArMHJzbzA4MWdxaWpITW13d2pkRjlxaE9aYWdJeTJ6Y011N1dUMGFSeE13?=
 =?utf-8?B?aU9QVkwzOThzVXRqU0U5WUZpQ05jWlRQTTJIWjg4cFlscnhuSnd4K3dsMVhq?=
 =?utf-8?B?T25wcTI3NjIvTnRkajNYemJqYlN5Tlc1TFNLa1N4NWQ0b1VMWTNMcmdzM2RK?=
 =?utf-8?B?Rk5KUzRBa0d5d0gwZzJWWlFNTUVLTzdpeTd4UENYR2hXK1JYcXIrOWluNVlF?=
 =?utf-8?B?MU83LzQxREZwMHBvVkxzbzFUbGtyczV1ckVVTlRRaUl5Qnh5R1p1K1Q4eTd6?=
 =?utf-8?B?Tmo5YUlQT2piWmxSL0hBQWJJb0dGbmhkWEVhN2dUdGVCb0lvTGFrRUNjRWVy?=
 =?utf-8?B?NWlraWllUFRwc0lCMGd4L212NkdBWjNRNmdYc1p2cjNPY0NTTGU5UWdidks1?=
 =?utf-8?B?bTFPVU9xR00rMnBEU2lab0ZvVGhQSFlNZmlCN0lpVlEvQkMvMW5ud2Yyc2pJ?=
 =?utf-8?B?cWVINDMyMi9qVXVNNmRVNnh3RTlPdk5MSFFzNFdnN1Zod0UvVUZLRDFidllU?=
 =?utf-8?B?dnNiUEZwOWhxbndMRU9zdXBySU00Vy8rSnVISnFZRTVERm5mRG4zbTNtbmJw?=
 =?utf-8?B?RWxGdkhaV0hJM0MySlpvaEN5NTYwQjlwNWdUUUNLYVNSdllWbzNrQWY3c05q?=
 =?utf-8?B?Y1Z2TkVKNTJpNU5zZzU1eStOWmdQMHo4YnAvNE9VZ00xbVVXTHZySTVqTTEw?=
 =?utf-8?B?RkhEUjE3TWU1R0dTSWF5a3ppQTR2NU9ZbVV0Ui9XM2RyVUJHMjhNZ2M2cGlU?=
 =?utf-8?B?VFlsdDROOHNoc3FzTkFMM1ZESzM5VzlGaW1HZDdhWHBJSEVUL1dZWjNIOS9h?=
 =?utf-8?B?cVlVSEF4K1krQ3d6TGsycWt4NmMzTWI3VFNiYytqNEkvczloR2MxRThSUFZo?=
 =?utf-8?B?Y3NZU0I4ZjA3Ky9CVUJPdXh6ZFRrUmlFTWIwMGsyOXAreE56MHAvbE5mNHB4?=
 =?utf-8?B?TTJzSjFsRFBYd3kwL0dsbEZKZEJXQjVtKzhQdlhLYTBncFg3NmNmdXZFZVY2?=
 =?utf-8?B?a09WRnl6Yzg2Q2l1d3JQb29LYzBJNThkSmsyc0pMcHlYdVJBK0ZqTmpMOWxN?=
 =?utf-8?B?em5Pb0dJbW9pZ2ZyNU9jY2tkY0ZtL3ZRVVBPcmtJTWhHd1N2Zk8xc2N2dkVQ?=
 =?utf-8?B?VHAwMXFSTVNJbmN3T3hyT2dlWURsSlJXdFRQbWpRQWRlTmlSbWV4bWk0Y2c5?=
 =?utf-8?B?SVE1V0pQR1ZybGd4VXVGTVY2YWZuRGFsaHlvZmV0TVM3amtHa09UcU5LdGVi?=
 =?utf-8?B?TlFIb1VlYW40U2ZPV2paVjdaWnJYR3ZjaGJ4Z2c4NUw4RDJ2RFhWUnp5NCtQ?=
 =?utf-8?B?TVhPR1gxbXdaSGhHSFB1bUQ0cHA5cCtBejJGYlNmQVNxVVJwYmZoaXMyQzEx?=
 =?utf-8?B?M3g4dHlSN2JrYkJVWnlKMmFuZ3haMVZlMEl0RkpHSXV5MGlDTzlxS1FBZFBv?=
 =?utf-8?B?bTZ5ajlhR2NVS2xKSkxRYkpJcm56ZFpMdUVUejJ3L1VsTFVTbnV4OUViMU5Z?=
 =?utf-8?B?REpHS2UrVEdCUERQVTUzM0R2eGFyVHdzZFpneXRQN245WmZEdjZSZ3VyUEJu?=
 =?utf-8?B?akVhdy9kdEVyUEZjRzVYeHBaYktVbGFiOW1uRkw5RVNncXlwNGZMMkY4Rjla?=
 =?utf-8?B?aVV1bXI1NnJaeU8rbmRXV3pwT3BRbTZ2eEFEeHY5akdNMjdSUlQ0NWxxd2Ez?=
 =?utf-8?B?WDB4TGlxK3RReW1BWjZ1b3p2TDJ1YjhtMGlUZFdYY1R1VWdkc3YvdkNNRjh1?=
 =?utf-8?Q?RV9AweizVZvzKrU30yDzkyFWX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa54ba6c-3b70-41f1-5697-08dd5bb92213
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 07:41:25.5225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JXqsEBwb18Cy6XcfaKdo22txgG3X9Hg9PJDK4XLY4Q5hA/4PrRjQigKwYusUF9+cWytmXpMM3Pa2LxDt1l1H3rxnBwM94Gvn3f8OWydUj08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8514
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [v2] mei: Improve exception handling in
 mei_cl_irq_read_msg()
Reply-To: "Usyskin, Alexander" <alexander.usyskin@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2561
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/CY5PR11MB6366E6F52B68E8258EE47F3FEDCB2%40CY5PR11MB6366.namprd11.prod.outlook.com>

PiA+DQo+ID4gSW4gZ2VuZXJhbCwgd2h5IG5vdCwgYnV0IHRoZSBsYWJlbCBuYW1pbmcgaXMgYmFk
Lg0KPiA+IEl0IGhpZGVzIHRoZSBvcmlnaW5hbCBpbnRlbnQgdG8gZGlzY2FyZCB0aGlzIG1lc3Nh
Z2UuDQo+ID4gTGV0J3MgcmVuYW1lIGV4aXN0aW5nIGxhYmVsIHRvIGRpc2NhcmRfbm9jYjogYW5k
IGxlYXZlIGEgbmV3IG9uZSBhcyBkaXNjYXJkOi4NCj4gPiBBbHNvLCB0aGUgcGF0Y2ggd2lsbCBi
ZSBzbWFsbGVyIGluIHRoaXMgd2F5Lg0KPiANCj4gRG8geW91IGV4cGVjdCBhIHRoaXJkIHBhdGNo
IHZlcnNpb24gYWNjb3JkaW5nIHRvIHlvdXIgbmFtaW5nIHByZWZlcmVuY2VzPw0KPiANCj4gUmVn
YXJkcywNCj4gTWFya3VzDQoNCkkgcHJlZmVyIHRvLCBhcyB0aGUgY3VycmVudCBwYXRjaCByZWR1
Y2VzIHRoaXMgY29kZSByZWFkYWJpbGl0eS4NCg0KLSAtIA0KVGhhbmtzLA0KU2FzaGENCg0KDQo=
