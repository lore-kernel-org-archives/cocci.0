Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAE5C61CE8
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 15:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VilFKdtSOBgvUc3rc7dvYRHMkHt8LlZcGW8i7Mwlsqk=;
  b=RFFYz5HSytwY7rsWHX3ebHfqbzbGcIp4Ul0x3jRIl60H2VWNNT1sfVv+
   A/KdvXOgyfKYS91JX8M3W4aAu/LvvdBu096MR7luiAErS94BxBj8BfRZx
   OWAKWxmbsspLQnWdVAYYGL2QGXLCj8SxvLY7OuitgGT5bNndApbox2auu
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226928564"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 17:54:55 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 22970E02E4; Thu, 12 Jun 2025 17:54:55 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A4CD3E0131
	for <cocci@sympa.inria.fr>; Thu, 12 Jun 2025 17:54:53 +0200 (CEST)
IronPort-SDR: 684af84c_4yrZZHM847z3LQ0At8n5H02LzsGLe+fBnndsVj4hO4zDt2g
 3lYauzwMSXbuSzLBZML1KBlVpdlYOxayoGbm6gQ==
X-IPAS-Result: =?us-ascii?q?A0ERAABR90pojxJBr8ZaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAQGBcFKBAFwxBFSEVYNMA4RNh2eBcZxBKoErgUA9Ag8BAwELAQE3F?=
 =?us-ascii?q?wECBAEBAwSFAAIWi1ECHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEBAQEBOQVJhXsNSQEQAYIHAYEkXgcJOAEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBARECDV4BAR0BAQEBAxIREQwBATcBCwQCAQgRBAEBAwImA?=
 =?us-ascii?q?gICLxUICAIEAQ0FCBEJgmABgiEBBhEDMgMBAgIMpEIBgUACiit6gTKBAYIMA?=
 =?us-ascii?q?QEGBATbISKCPQMGCQGBES4BiE8BgW2EOoNCeieBA2JDgVeCNzE+gmECgSc7B?=
 =?us-ascii?q?TODITqCL4IogRahHglJeBwDWSwBVRMXCwcFXkJDAyo0MSMPPAUtHYINhRkfg?=
 =?us-ascii?q?XOBWQMDFhCCJIFeHIRlhEkrT4MigRIBbGVBg2ESDAZyDwZHQAMLbT03FBsFB?=
 =?us-ascii?q?Dp7BZd/hSqBGC0MmAWvSQcDhBuMHZVsF6phmQQiiwOCYpV4hQ4CBAIEBQIQA?=
 =?us-ascii?q?QEGgWg6gVxwgzdPAxkPjiEZJYNCt1dFMzwCBwEKAQEDCYVGAQGFO4R4NIFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 /4gwLXkIIBVPYr+iRQKVw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:nCHo4akwzmO+8H/YhcasaRomAlHpDfNdiWdD5ihNYBxZY6Wkfp
 +V7Y8mPE7P+U4ssS8b6Km90fG7MAXhHZ4c2/huAV7QZniuhILOFvAl0WKC+UymJ8SazIVgPM
 hbAtpD4bHLfCRHZIPBkX6F+rUbsYC6GcKT9JLjJh5WJGkFGsQQi3Yfe2DraDwKeOAFP+tMKH
 P13LsVm9PKQwVnUi3PPAh3YwG1nay6qHuJW294OzcXrCO1oXeD7rn8HxKE3hEYfQ9u7N4Zmw
 n4uj28zJ+O99WgxDHh90K71fk3pDKn8KohOCWLsKR7W1fRozftQL4kd6yJvTgzru3qwk0tis
 PwrxApONk2w2/Nf0muyCGdgzXI4XIL0TvP2FWYiXzsrYjSXzQhEfdMgopfb1/w91cghtdhy6
 hGtljp7Ka/TCmwxhgV1eK4Cy2CpXDE/kbKVtRj0UC3ZLFuNYO5a7ZvrX+9Xq1wTB4So7pXWN
 WGRPusr8q+N2nqPUwx91MfiuCETzA9GAyLTVMFvdHQ2z9KnGphx09d38AHmGwcnahNCaWsyt
 60cpiAros+DfM+fOZ4HqMMUMG3AmvCTVbFN3+TO03uEOUCN2jWo5D67b0p7KXyEaZ4iKcaid
 DEShdVpGQyc0XhBYmH24BK6AnERCG4US72ws9T6pBlsvn3RabtMyeEVFcy+vHQ5sk3E4neQb
 K+KZhWC/jsIS/nHptIxRT3X91IJXwXQKQuy5cGspK104z2w6HRx6PmmazoVffQ+B4fKy/CPk
 c=
X-Talos-CUID: =?us-ascii?q?9a23=3AgQ6V12qUA3wouhQ9+SvmWZPmUeAOcT7BlFGPGR+?=
 =?us-ascii?q?TB2guZYGYS3Ov1Joxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A7EXFNwzyI5fFQ2JWdWvk5jbV9HSaqKf1Fn4Pu84?=
 =?us-ascii?q?YgcfeH2sqZynFjwSxU4Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="118920282"
X-MGA-submission: =?us-ascii?q?MDGWZjAhm9H3VfiibkTOLJMyND8xH02zah8EiQ?=
 =?us-ascii?q?aTe+f3afvPxqsoLUYivNfT8aqU6lkKFwREMbBYSuGrqe2DBSm1LmJAWV?=
 =?us-ascii?q?8ZWPSmi4V+9vXgFSE3QuP4za2vWIXmIKD2Qs+qNEct0ER98dS7BGn4Vb?=
 =?us-ascii?q?BX3XV07w3IT8MgYrqqN5NtwQ=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.18])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 17:54:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749743693; x=1781279693;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VilFKdtSOBgvUc3rc7dvYRHMkHt8LlZcGW8i7Mwlsqk=;
  b=ZnEwflMiRQlShyJJiugUrIFVBsqaHu4Y9b72hHowgQAMbbL6uwwv4bhT
   B19XalArVDYuRZHURZaaToXzgXBac1yiS68n16vYvkS1iNkw6YRKdjlcY
   9JYGpXdffsO8K7gah0MYmshkvBPVOiS3UBqIz70FR7QmuR/1Fkbi2HTD7
   PhCP9CQbFcV+mnzd3WdEtlqwR4aT+K2X3VqpPurIUxiT5Ap23IBIYdHvR
   IfKCbLH1Dbr9rVWzRwe+xnthNJFUfMlvwIwDYSyaMhGMsyEBo/EOQjrb2
   bgKUH8xpirpAGs906XneWLoPhr7GivZ6HQRNG03OZp/MdrfX3LZRGuDpq
   Q==;
X-CSE-ConnectionGUID: +ni0NRE5TTKQsBT0lso3OA==
X-CSE-MsgGUID: oA8COdysQiGrpmkPA0VLHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="52074726"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="52074726"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 08:54:12 -0700
X-CSE-ConnectionGUID: 7NV1Q+b7Q4e/G16X4HzwzA==
X-CSE-MsgGUID: IVLZ63ZXTHuiEG67AxOr+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="147556116"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 08:54:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 08:54:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 08:54:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.48)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 08:54:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1orUsPPuJ2tnJsrRM+bW6ENq8Tr4WKP4QkxbGhRzv2zUcYafXIdmLDML4vED2uAolabXZVsbNJ/OVsD4e9gYLk6nLaKsHeJeLzxbCRkOWsF8QhfRMFOLNYpeww0OjugSr/s8mLHURkj0QTFwGDiELnlFQaAE7dGAEffpFNoW+T19qLaZ4jAUVH2Q5vlRHvhCQ2NQMrR+JGC5mbxIsrRTjHyZ5lQ9+CDuaVcNGgAwmw11Lr49p8GOCEQ1ARlTahIRuebPAXvsBY1SoDFC4ebpS+1O7wuj5DOpOgWUXN+IcBL/ghgttGvYMLhcVyct1KOhhH4WX0jYukZLZ17Dj0TXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VilFKdtSOBgvUc3rc7dvYRHMkHt8LlZcGW8i7Mwlsqk=;
 b=qza3N1RR0pvQgqak7M7XfxEd5w3zoNAC7+rXSK6orWEfa2ynEcbehyUKY3nPmj6lyFAxUdqfUdAx+pMUP0tSAaSxt6xP3c/LE4DARWDyvNki6Q6ch6mEiYZOuQ+kbKoxB67vP0B2rtkSLszwecT5sbAzQyEETB8ov5n+QhJ51cNlljzrDBpLqVXexBWHaB7sR3WfE8xVobsDNdVwhpNgIIrT85xdaV6I2QTbV4tsIRPo7KcFy404IUcDIk+aEaWqEqXPIBv6mWH3kc/BJxlIeNbHPwLUiqMfe2MGytHDYGGXEMieFlKVI8QtP7c9Iqfx8JQO/ugKUtuKdZrIhD/KZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by PH8PR11MB7095.namprd11.prod.outlook.com (2603:10b6:510:215::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Thu, 12 Jun
 2025 15:54:10 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%6]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 15:54:09 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Julia Lawall <julia.lawall@inria.fr>, Markus Elfring
	<Markus.Elfring@web.de>
CC: "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: [cocci] Checking another deletion of redundant null pointer
 checks (with SmPL)?
Thread-Index: AQHb2h6FYMmpkwj9cEuTz7Ot/nFAZ7P/gGgZgAAtntA=
Date: Thu, 12 Jun 2025 15:54:09 +0000
Message-ID: <PH0PR11MB5095C3973BFA25B12C97E2A4D674A@PH0PR11MB5095.namprd11.prod.outlook.com>
References: <90822099-5434-4421-a611-785511926ecb@web.de>
 <alpine.DEB.2.22.394.2506101739440.4658@hadrien>
 <9eeab48f-1bc7-4395-b998-6a49330cfc2b@web.de>
 <45eb943d-1ae3-439c-8b05-7c355a54c48d@web.de>
 <cc827ab9-6e22-89f2-2e79-a844c7e1f1a2@inria.fr>
In-Reply-To: <cc827ab9-6e22-89f2-2e79-a844c7e1f1a2@inria.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5095:EE_|PH8PR11MB7095:EE_
x-ms-office365-filtering-correlation-id: 08e7f5e3-7406-4d8c-50e5-08dda9c95eae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TnJLa3l0ZVRLUzZjWit0eit2dVFrMjZvVC9qR2lYamVEalk0UHplREVGclUw?=
 =?utf-8?B?RHFWSUZrSE1sODB3bkNEVXh3ZWx4bTJkUG1qTmVMSUIySkNkMVdubk9OdmZ5?=
 =?utf-8?B?ekVCWURQZTFtOUlkcTk2ZGtNdElOMDJoMWFxenJPZ3VKMXVWZEgrWFQ5ZTlB?=
 =?utf-8?B?UG1FT0I5WkF4RVBZck9oKytmSEU5N3BtakhrQ0xlbFBCWWN3alFXdkhvUi93?=
 =?utf-8?B?VG9KLzhVM2hITDRJZlVoMG1qbzdpVDFMaTZJQjRyWkpDYmVINmc5QkYwbWFG?=
 =?utf-8?B?MWx2VUwyTGpGd0xRTHhTUDJMUU1DTW1HcGRFeFAxblhzUUZEdmczOXVqOTds?=
 =?utf-8?B?bjFHOHZ3YTRYS0JjRktYaEZaSDZpYkV4bTYzRGs1eUJjTkR5UDZ0MmhRblJB?=
 =?utf-8?B?azdNUnRreUt1YUJXWWVpL2taN0k1U2k1Ui9pVXhzNTNpNm5wYUtsTnd2cWdI?=
 =?utf-8?B?VFFoYk1JV1lPQVVNbDZuUzBhU2VJdSthVmJCSllTbFB5Nk5QbW1CMmhOdlVu?=
 =?utf-8?B?Si90ZFo3U1ZUejQvVEhiRDU4UHNqUmZvV0EzRjZZZGt3SkhoQ3NxTDdWRkxP?=
 =?utf-8?B?WU56dTZCN0ZkaHRxd1hYVzF6bjlZaStWdGNFWEswUVZEMHBYY0laK3FkcmFx?=
 =?utf-8?B?eXZ4K1Izbkh4OEpsUGVXeVFjYmxDV2hnRHk0TjdqbFhUUUhJUHhCZURlQ01D?=
 =?utf-8?B?cUlCVkJ1VXlFTlgxaVIrdkcyaDI3V2hEU0I2Tlp0V3c3aytJQVJqSG1xZDBy?=
 =?utf-8?B?SHZ6MW1CbE42WHJwUG5zK3FnN0NpRGx2NTNBcGF6TnVYdHM1cVFmUnI2Z2Za?=
 =?utf-8?B?UTNid0FYZElnUUZha1c2S1M2cG5SYXhqeGNwam9VVTN4OHA5LzVaR0ZLbnNW?=
 =?utf-8?B?bXVDVkN3ejFiVG1UV1BDRVRzaXhxaEVoM0VrWkdpR2N0VUcycUZwTkVFQi9Q?=
 =?utf-8?B?WDhvc3E3R1FsL2xORGhrMG0vZkdvU24wSUxmeStRTVVEcDVmRWh0RzZxb1ZF?=
 =?utf-8?B?eW9UUGtMTTgyMm50RkZlTForOVhvelg0S0swRXRHYTZrb1U1MXBrY3hmalAz?=
 =?utf-8?B?SDZnc0hoM0NsVVpmVkQ4MnVyZVFDemNFNGhVYjI1Uzdqa3N4SWcxcjdnbG00?=
 =?utf-8?B?ZnFvQkE3UE1ZdVdNUkNHdVdQRmF4ajc0RzJQYTcwTER1UW93TXlTRktoT0E5?=
 =?utf-8?B?Z2xBSTV6TkRVV2xEclJBNktUWmxHSWdTRlRMRWpsNkxBMUZycW1SZlo3eXh0?=
 =?utf-8?B?b2p1VjEzK1JyeXlXUnluYUlnWlVWYlBDdm1NVTZ1bXpZd1IxdkV2WjY2M3ov?=
 =?utf-8?B?NzNTZmcxNnpMZ1luWmVhRnBWc2pucGlhK2xpekFjUFBCS045ZTdFVzVtUkcw?=
 =?utf-8?B?TmpVS1ZFT2RmeWdsQ00wbE9CYVJaL0ZBaWRYUE1aUWhRdFM3QkQ1WkxPSmUz?=
 =?utf-8?B?VzEvRlBvc08zNGV3TFNhejZEMWRYUVNqTnNadldmaDNOR290V0ZzaTdTalM2?=
 =?utf-8?B?dUVDa3hoY2RkVEdGb2JpcjRKbHFPSVlJV0sxSllzZDZCbnZQQ245c0JCU2Zh?=
 =?utf-8?B?RGdtUk41Z3pMandUMTVrbTN0cXZTSVZLajBiRlBiRGVBNTdid2g2SzU3KzFQ?=
 =?utf-8?B?dyt0bXpFVFQwZWhkMU5BT08wQ3ROQ0llZHVxdVovWWVZZ0FTSUhxbzlCL1Q2?=
 =?utf-8?B?bkFHRE1kOGlmV25UdWRDV0FPaXhCYlQxTjU5VFdRSFZkV1hkeTREK3BkZ0pU?=
 =?utf-8?B?ejI3eWp3UXhiRnZnSnhVYzFzWExvZTNmYVdHRjkvU2FOdEFJMXJjOXF3c2Y2?=
 =?utf-8?B?MVZnYVlVTlR2Y0xQNWZva0ZibEVXSUF3R0RvRU9KRFNiVndZbHlwcEdub1hE?=
 =?utf-8?B?Z3ZET0FQaVRSb3VoMkJzQzZFTUx3azlta21CUnlVM1NWODFYbG83Wng5NDdo?=
 =?utf-8?B?TEd6VHNWMzlJOUVBNXZqYy8vOUVrRE1ianJTSnZlbXJHV1lURTkrbFFycUhT?=
 =?utf-8?Q?K1EZKJUyjxaftXyybebE/Lr3xn78AU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1ZmQTJaK0t0ZVpPSkFmMWtBdHJBWW1tWFplanBpdldSY3NiZEF1a3NzN1I5?=
 =?utf-8?B?N3k2QlV4ZUVGeWE2Wk9QWEpqVVd5L3haaVh4U3NVSzEvc3FjeU1PZVhHNDlo?=
 =?utf-8?B?OTJxVG0xdVEwdlNXbWY5Q0NNMVd2V0VVSlVnZU9rdllpemhSYmZ2bXpEdSt4?=
 =?utf-8?B?U3hUNXBkWEtJVVl3bzA0ZTNoSCtGZ2hzZFJmdjYxcFVKaTdhZWg1SEtnZU5t?=
 =?utf-8?B?d3Bjek1Qdk1YNnV2WEE5RU1NblVVWVpkdXdZd2lGaWMwTEV1NTVuY0IzTkhz?=
 =?utf-8?B?K0d5WU9icHJuU2ZoNWtadSsrTS9nckZJMWtmY0pqWkJuRGRRYXpJc09KUHM3?=
 =?utf-8?B?Z2J0cTdsdXd5R3BYWm56SndYYmh4Njg4cVhDcm1meEQyYzBVNXJyemx0dy9Q?=
 =?utf-8?B?VkxKcDJvMjhHMnFqV1ZVRHVsSEF0MlVaNTRTbjRNbSs0TEI0MlA0ZUxzMzRD?=
 =?utf-8?B?RVBiTWRkSE5HVTExQUk4U1dLb0QyMGUwdUxYa3JoNElVbXRYOTBob2VtTUVR?=
 =?utf-8?B?VUtPcTd0SDJzMFJxM2x6aXc5a0h1UWRENExOMmp5enkraXdrV0hjcEt6QXFs?=
 =?utf-8?B?Yzh1L1p2c1NMSEp3bXRCaUROdjFmMmJUU3dZNnI3cVU0enJIcXdCUlY3blI0?=
 =?utf-8?B?WTFZREoyVjBXZGdGMHpEL25HV0xRUUJBTGFKWWN6clJOekN4Y0tWTW9ranhX?=
 =?utf-8?B?SzdwcFh5Wk14U0RWZnF4TXNDdE8yL3JmbG92RjZEVUlRQXdFQXMwaytMMlRZ?=
 =?utf-8?B?cVE1aEZ2clZLdFFLWjZta28wN3ZCbUZyVk9WakxtOE1zWHRsT0wrU0JDTmg0?=
 =?utf-8?B?ZzZRNzg1NzBncmtqN1RnYkpvb1VkaHVuenBybFV2NlhGVlJnVm96dERyaXR3?=
 =?utf-8?B?Sjh1UmlLYmcvc3crK0xUbC9iQzZmSHQ4NVNJOXlNOElKOTBnN3ZKU2NHTHZM?=
 =?utf-8?B?Z3UvWVZoZTJiUUM4cUVhZFJ4S1NZVis5cFNkV0hWUHQyOGU3YXpRbXE5TmlR?=
 =?utf-8?B?dEdDTUQySVJkOUloc3o0czEyM1M2M0lRNVI1L0pnUk1xZXBGaTY5VTRrSUxB?=
 =?utf-8?B?QmVzU1BOU0VFd0xyYVB5a29JNFBwbUpUYWIxTVgxY0dIaDFXcU5qSlU5L2NO?=
 =?utf-8?B?ZW1YMFR6UXRuMU12T3ZaaWxKaGNGb3NmSEY3YytzelZvd1RNUDZhNWFEa25V?=
 =?utf-8?B?VU00Yno0VGFBZElLOUVRMFlHelJmY3FiclRzaElZSXRGZzdxUVNCQmE2blcr?=
 =?utf-8?B?SnRDU0JoUFM2QUt2QkJpMUZnMEU0THJUV2g3dGZIUEg3eU5qOVA5a1VpS3dq?=
 =?utf-8?B?Vy9JbVJKMC8yZTRoMmE2Mm1idVdETDBmdnFBNkV2eGJ6R1pCeU9WSE9CS2N2?=
 =?utf-8?B?eXNBNGcxcTlaelVUNTRaKzhoTlh3UUpRSU5UaHl6TytmSk5ic1YyK3RScVh5?=
 =?utf-8?B?Sk9yZVhvTnp6WnhFS1F3eCtnSHJaSmN0Q0xDYWFXaEUzMlhjNmRzTmNvQjk2?=
 =?utf-8?B?aThFdFNXQXRMMVlVam1EeWpsTHFuM2tlODNVdHdBaVU4c002Y3lHTHVOcFhu?=
 =?utf-8?B?TE8wNnRMVDdBbm5wRGdMMUlldko2b3R6VDhRNTh0ejNVeHpLbkpOYUlZOEM2?=
 =?utf-8?B?WnlJQ2kwWHY1WFhVNDFHTks0NTRXQnFUSGJ6RzRQTHc1cVRMVUlhY1pybFgv?=
 =?utf-8?B?MkVJZVNWYkEySnN2bit1eHoweTk3V3VkN05LeFFtWDk4U2lCNEN5c0VGOE0z?=
 =?utf-8?B?dXMxL0o2SzhjWjdhRUIwOFJUS2pTdFhHY0UvQWhMUnhsemVqRThQcEp6em9h?=
 =?utf-8?B?cUg3bWp0VVAyaEZ6aGx3YjJ4UERJaktaOTg4UzBscm9iZytLTERPcW92Y0pi?=
 =?utf-8?B?cytteU5oR1VPdkxnQ1VuOTNWdkhpNXU3dlpGdi9od3J4N3NVRy9WUkQvY25x?=
 =?utf-8?B?a3BCNGFQMGdBU3ViNTgzdzZIaWsyV0tZYm03MXAydEtubGpKUkI4Y3A1SS9P?=
 =?utf-8?B?TUtYOWY0K1AzN0NpcmhKZ0FTMUR6NkVxK3JpUm1sSDJuQ2NvK3RmSlJ2RG0x?=
 =?utf-8?B?blZOWEtuRGw2VzlRM1lNZE1IYzBMRUpsOEJyMUlycnpucy9oZTdVNGhjM205?=
 =?utf-8?Q?CzCVI64XnmRBawELhj2dQKjih?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e7f5e3-7406-4d8c-50e5-08dda9c95eae
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 15:54:09.7988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhW8G2n6Nme4xu1fZaGYZz9Bu2Ou/OchvggXBIupgNIbASz3eicWiVAw40Xj/hMo6SrVa++m6W+C1AdXGqjpgyvBbsuROF8i/GmUD+mSKu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7095
X-OriginatorOrg: intel.com
Subject: RE: [cocci] Checking another deletion of redundant null pointer
 checks (with SmPL)?
Reply-To: "Keller, Jacob E" <jacob.e.keller@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2780
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/PH0PR11MB5095C3973BFA25B12C97E2A4D674A%40PH0PR11MB5095.namprd11.prod.outlook.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY29jY2ktcmVxdWVzdEBp
bnJpYS5mciA8Y29jY2ktcmVxdWVzdEBpbnJpYS5mcj4gT24gQmVoYWxmIE9mIEp1bGlhIExhd2Fs
bA0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAxMiwgMjAyNSA2OjAzIEFNDQo+IFRvOiBNYXJrdXMg
RWxmcmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPg0KPiBDYzogY29jY2lAaW5yaWEuZnINCj4g
U3ViamVjdDogUmU6IFtjb2NjaV0gQ2hlY2tpbmcgYW5vdGhlciBkZWxldGlvbiBvZiByZWR1bmRh
bnQgbnVsbCBwb2ludGVyIGNoZWNrcw0KPiAod2l0aCBTbVBMKT8NCj4gSSBoYXZlIG5vIGlkZWEg
d2hhdCBpcyB0aGUgcHJvZ3JhbSByZywgYnV0IHRoZSBwcm9ibGVtIGlzIGFscmVhZHkgZml4ZWQu
DQo+IA0KPiBKdWxpYQ0KDQpSaXBncmVwLCBodHRwczovL2dpdGh1Yi5jb20vQnVybnRTdXNoaS9y
aXBncmVwDQoNCkl04oCZcyBhIHJ1c3QtYmFzZWQgYWx0ZXJuYXRpdmUgdG8gZ3JlcC4gSXRzIHZl
cnkgZmFzdCwgYWx3YXlzIHJlY3Vyc2l2ZSwgYW5kIGhhcyBhIGJ1bmNoIG9mIG5pY2UgcXVhbGl0
eSBvZiBsaWZlIGZlYXR1cmVzIGZvciBzY2FubmluZyBhcyBpdCB3aWxsIG9iZXkgY29tbW9uIHJl
cG9zaXRvcnkgaWdub3JlcyAoYW5kIGRvZXNuJ3QgYXR0ZW1wdCB0byB0cmF2ZXJzZSBiZWxvdyAu
Z2l0LCAuaGcsIGV0YykuDQoNCg==
