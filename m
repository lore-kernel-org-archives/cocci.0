Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EE8C369D5
	for <cocci@archiver.kernel.org>; Thu, 24 Apr 2025 15:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=p8/gLHYIIBDXwab+DrY1rc98eAMI2ts8Ml0d5JaX2t4=;
  b=QK+LTYEmPA6fm/hC8/8A1qB7r7zNZWwWpg46hdepvYu1IsKhEsJ0QHGy
   w4EWtHC1S4EY5ZnNT9D/6LtR9Oki1NYAajYTu+OMpDAFbnA4eytXDg+xq
   6ssAOUKfGJnJ6OK3K2mLzum7lEyiEXuug1BMXdM0r2SLfLKaexaxexH1i
   8=;
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
X-IronPort-AV: E=Sophos;i="6.15,236,1739833200"; 
   d="scan'208";a="219323939"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Apr 2025 17:24:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F3535E007A; Thu, 24 Apr 2025 17:24:39 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0695EE007A
	for <cocci@sympa.inria.fr>; Thu, 24 Apr 2025 17:24:34 +0200 (CEST)
IronPort-SDR: 680a57ad_7/JXg1Zbrsnto9WQD7/aMsqMniV2rWFfCLgxKuh2T3Ukzu1
 OuyyviHdLFoBY2vsemjBK98bfu68A6xkB2YjWQA==
X-IPAS-Result: =?us-ascii?q?A0EDAABaVgpojxRBr8ZaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAQGBcFJ9XDEEU4ghA4RNhzQzgW4Di2ORBYErg?=
 =?us-ascii?q?UAzCw8BAwELAQEuCwgBAgQBAQMDAYUAAosuAh4HAQQwCQ4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQEBATkFDjuFew1JAQEECwGCBwGBJ?=
 =?us-ascii?q?F4HCTgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QINXgEBHQEBAQEDAREoBgEBNwELBAIBCA4DBAEBAR4QIAcKHQgCBAENBQgag?=
 =?us-ascii?q?mABgjADMQMBBAykbwGBQAKKK3iBNIEBggwBAQYEBNsfDYJRAwYJAYE/AYgxH?=
 =?us-ascii?q?gGFbIN9eieBA2JDgRVCeYFvPoIfgiYFMYNdgi+DSIJ2h3CMTYcSUnscA1ksA?=
 =?us-ascii?q?VUTFwsHBYEmQwMqNDEjSwUuHYJOhSWCEYFcAwMjgxN2HIRmhFItT4MvggNoF?=
 =?us-ascii?q?R1AAwttPTcUGwUEgTUFlU+BOYIzAYEOLIEYa5NwgxcBrxtxBwOEG4wZjTmBf?=
 =?us-ascii?q?4YuF6pXmH4ijWSEB5FXGIUOAgQCBAUCEAEBBoFnOoFccIM3TwMZD44hDA0Jg?=
 =?us-ascii?q?16BPsJeRTMCOgIHCwEBAwmFRgEBhEuBQIRJgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:SDKjUq18wKsPV705xL3OIQqjBcNxeYIsimQD101hICG9Lfbo7P
 xGzc5rrSMc1gxhIU3IwerwTpVpQRvnhOBICPoqTP6ftW7dyS2VxeBZnMzfKljbcBEWmdQtp5
 uIH5IOdOEYSGIK+voSgzPISurIouP3hZxA7N22pxkdKHAPGsYQiXYCe3um+w9NNX177PICZc
 mhD6F81kudkAEsH7eG7w4+Lpj+TrPw5e3bSC9DLSQKrCOJijSl4qP7FR+34jcyOgkkoIsKwC
 zuqSC8wr+snc2a53bnug/uBtNt6bjcI914aKP86PQ9G3HJsEKFdY5hU7qNsHQeu+e08msnl9
 HKvlMJI9lzw2m5RBDsnTLdny3blBo+4X7rzlGVxVH5p9bieT48A81dwapEbxri7VY6tt0U6t
 MR44vZjesMMfrzplWg2zH6bWA0qqNymwt9rQcntQ0DbWLZUs4BkWVQxjIELH5KJlOz1GluKp
 gkMCib3ocFTbrSVQGSgkB/hNOrRXg9BRGAXwwLvdGUySFfmDRjw1If39F3pAZDyHsRcegF2w
 3/CNUqqJheCssNKa5tDuYIRsW6TmTLXBLXKWqXZVDqDrsONX7Bo4P+pOxd3pDvRLUYiJ8p3J
 jRWlJRsmA/P0roFM2VxZVOthTAWn+0UzjhwtxXo5J5prr/Trz2NjDrciFqr+Kw5/EERsHLUf
 e6P5xbR/flMGv1AI5MmxbzXpFDQENuEfH9euxLFW5mjvi7ZbEC7NarPco7DICdXQoZZg==
X-Talos-CUID: =?us-ascii?q?9a23=3AdImqnmvATwDYJAjolwmS/d7F6IsPSVeNwFPffHO?=
 =?us-ascii?q?aU0BER/6QY23KxIhNxp8=3D?=
X-Talos-MUID: 9a23:ik1/GwmDAWnow2iQe7QFdnpIH/hEvoSgInovlM4CntSaMXx5HRK02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,236,1739833200"; 
   d="scan'208";a="115101428"
X-MGA-submission: =?us-ascii?q?MDEfuEEhSXURRuGE0iwp9qD7PYsnADiq/f0wt+?=
 =?us-ascii?q?7fYBscJNhgiGnsC2vJBfHBaumVVh4McHKHDqLUX6gcbW94X+OWrbb2N3?=
 =?us-ascii?q?9cr7IJ7vctIqn0KWnLFAnshk6qut57/AmGURNMBn/N6O3Q/UFUSRSMWz?=
 =?us-ascii?q?oayM8ArBmLBHNzp+rdGywJUw=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.20])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 17:24:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745508267; x=1777044267;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i1XKhiqyh9lSJQx4mSw3v8TUM1/CY/MQ6wOMZ7Mjt6c=;
  b=ZzZEZkoezTQpO9bPWwhj+Eg8tw4rPSVF0joGgfCJscaIWKJ6DRVdi/3s
   qZWzC3v/zLgPWmsaZiNMg5vCOOF5NFfUmLStjZGPcUaFCKyHOGOS9e/pS
   /SiuOQZuH19/xH7gAsGsAKQz9jA19UOouJlbKYRJUDCzbz8d7Q+UKzL8y
   +q/6KnuOGBQFErWePJte2Z1VIkTJ4lTd3ho1sCntrRe0Mbq31eIqjullS
   1qLaI24C5Qky6zqANc04Za3aM1S88MfMZ75yqorckHVlvw0P7n9qK2GNS
   lLEnaZN2/2ZlocQkej15K6VXXdj6uuhTVpUgucqeV9H17gymaJMDPUmaf
   Q==;
X-CSE-ConnectionGUID: c35C/ZG1Q9+zMvzvt/SO1w==
X-CSE-MsgGUID: g6gLQAo2RWCntLjfXHfwZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="46864671"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="46864671"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:24:14 -0700
X-CSE-ConnectionGUID: X4chSc92SseO7WUEHG++BQ==
X-CSE-MsgGUID: tZ3w1560QdSla1JuKd11FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="169862474"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:24:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:24:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 08:24:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 08:24:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWOhKoMgcc1sWCCFUu7fdilvKo5X9oPJt7xoqyYHaCO4errH9A0U5lHHg0i684pWMNvUZexCK641Smc5VwGvljiBWMky5fPu2wTYml0/rpbVnLUBcKnfeXTf4mSP9yfSafVXzVJ2aoY1Fe9z+sqAyw6cxu2Sz+DGw39Xwd9PBts1B5UVEYPM8Qv6GZ0+bk3AecRdzTipj25TKu1Zh+1kvpo7S1juiro6vboUXoMB+Y5csDeN7vqdqTGyih9zx0GYxqcuPC/uirXBr77kNwY1T91B2HYP2j0Lt55X9jKJ8tATt0T1gXg0eboEBbST4wE+OlI4cbDtzgroQaYbssh5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8/gLHYIIBDXwab+DrY1rc98eAMI2ts8Ml0d5JaX2t4=;
 b=v6Z9mTBnpAVQCIZEnoTYGxHaNvYVr8yx/bNPEZZiSDR14TxWvMwWO7bL8kHzHeHGkLmkdGeobItIl734HS6yK4qJCw0Q1XxUicqKoWH+D8Fugm/u0o4v20rEx7NQOPRtzgMIC8jY+IXxXnkuFiikNHfooFLc34CDzWW3SVTPqHYlXByprZ6UgMTiMwXhkoKeP6p1WLcfKXOCohY/NUMMerQp5dBsezqY0lujYDHLClOIk8ug4+ny/QoIqyRQtczZWz6PyvdhtrfxPVFjUPu7J6zcmZ0eUh9BExnaIVexLctLRwSag+gEiWb+OST05Pq+r44htMMday2RfK4TkcgRvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SA1PR11MB7085.namprd11.prod.outlook.com (2603:10b6:806:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Thu, 24 Apr
 2025 15:24:08 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%3]) with mapi id 15.20.8655.025; Thu, 24 Apr 2025
 15:24:08 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Jie Luo <quic_luoj@quicinc.com>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>
CC: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Julia Lawall <Julia.Lawall@inria.fr>, "Nicolas
 Palix" <nicolas.palix@imag.fr>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cocci@inria.fr" <cocci@inria.fr>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"quic_kkumarcs@quicinc.com" <quic_kkumarcs@quicinc.com>,
	"quic_linchen@quicinc.com" <quic_linchen@quicinc.com>,
	"quic_leiwei@quicinc.com" <quic_leiwei@quicinc.com>,
	"quic_suruchia@quicinc.com" <quic_suruchia@quicinc.com>,
	"quic_pavir@quicinc.com" <quic_pavir@quicinc.com>
Thread-Topic: [cocci] [PATCH v3 3/6] arm64: tlb: Convert the opencoded field
 modify
Thread-Index: AQHbtCzwqS29KFwsakalRi4XUJvnbbOoH9IAgAkbb4CAAbUNYA==
Date: Thu, 24 Apr 2025 15:24:08 +0000
Message-ID: <PH0PR11MB50957B606B76490E205923F8D6852@PH0PR11MB5095.namprd11.prod.outlook.com>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
 <20250417-field_modify-v3-3-6f7992aafcb7@quicinc.com>
 <aAFEOr_PnZRH2ocR@shell.armlinux.org.uk>
 <2b7ca78e-18f8-41bf-979d-8d502f6f8fe1@quicinc.com>
In-Reply-To: <2b7ca78e-18f8-41bf-979d-8d502f6f8fe1@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5095:EE_|SA1PR11MB7085:EE_
x-ms-office365-filtering-correlation-id: 97cf7960-5499-489e-7d2b-08dd83440eec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ieRK0i+A3um1ILzk3cw5z2yud10fFS+yYlQGXY+sCnJkPI2BtLgo9DVVo7dE?=
 =?us-ascii?Q?PhK8/cR+3gcL78W6cTxKfSyr3Jz2yftgr4wrt7HmRDymneTtLeKJ/80GFWQ6?=
 =?us-ascii?Q?8kThBzlUq9Z9ppE/oAL57KbKz22Ejl0AzJkthAZw9BL5AyUMANaKIh06QYFP?=
 =?us-ascii?Q?gTYTbcGid0LUnEtvIY/cV0KejcbWa+6iXepUIiQ9GS9fK5R5WhGGA4jJ00n4?=
 =?us-ascii?Q?ChFLKbDa0g19ZeyYe0pMCPsm1axcr5OV/FtlLh9ONIdzEHAItURplQPjC51+?=
 =?us-ascii?Q?ThLMMm2QazQf2rbR51giWZC7OgOqYJ24xGuV95iMnhtatjWXJXeBzoZ5o3P2?=
 =?us-ascii?Q?8R++chvFsDkDbKkS89P+reEPnqcLBJLdVqsqMOTv3pOrxc7rlHW4jgbrBxCJ?=
 =?us-ascii?Q?OFa5U+jEF9E19OV8fOMI37i1wG0okbawgxQc4ZHMFboeZPELTraFaHd9dKGP?=
 =?us-ascii?Q?gMTnXzZvSvPoy1ZgWIwfZmxdV5AD2wpKCZrnMlw1bGAw7qWgUOqfEZZD/pSS?=
 =?us-ascii?Q?hAHKC4uJG+vaIcNveRTPZerteAy6ibKqAdEit6Nw+6q2BzIMj/7gIIl1JoXP?=
 =?us-ascii?Q?wxu/d+0j5g13gjehXl2pOp4a/mEoeuJHsBkQyT8RgpUJDNAW7iQ98PhaCmk6?=
 =?us-ascii?Q?/cNGGDgMecNksONxQt6aRhr4xnp6XRd7h9k9Rdko03y/YFNW94t9H8FcW2Fp?=
 =?us-ascii?Q?xeZfkNavjFtnLewy4Ga09uIknNfsIidRi2OAuw7uEP2N0kFdgRFZFSuSsUhK?=
 =?us-ascii?Q?lV2NVhfvhVasBRdXkcgnnWIRUVyCEAIZLdt7U29WkHfehkw/AKXl3Zl/y/Ea?=
 =?us-ascii?Q?AmfLfz2urf/gTmc9cnqET4WfZ3TfcpdQ47hsfQzHnP1jd23ntIvAhndtflPa?=
 =?us-ascii?Q?TnzqLpZF9rTtSF9zVp5xhUopSca9aUYwxWhnvwtg3MK/yn8pZFxvm2jI/ErO?=
 =?us-ascii?Q?EeERReBQett6LODa4OrKEs8v4hbgGNpTjz9NVyGyLlzXwhMj1az8LFidH02g?=
 =?us-ascii?Q?IWVbOA8UDdD/cZNpZzwGouy97S8CNXu53EvYtX0oMVdI+VQhgNyPg/H0gu9Q?=
 =?us-ascii?Q?+HkSmXvZuKpA6rkryxzjG6OijvJQDSRVp8n4GkeRwb2r6Op4J/q5sUYVxKb8?=
 =?us-ascii?Q?CSbmnJHaRDoFDNIeR2IGThnDBIPfdv35imsCLjYL+g1XJUKkJbIIdJvuQXe7?=
 =?us-ascii?Q?Ll3Y+HNbj9RyPhvDp+ZZiPqbEVE5RXZp2Yjx8NVogDCTOzYtKfP2Tjgay/YA?=
 =?us-ascii?Q?/waDVyxEbkKRGbJSnvKLqKQyU1IA0S0a7DoiVR0PbwaD10Sb293yBztCXKvB?=
 =?us-ascii?Q?oqEh9Ers0wCW+ftQib7U27/NwJ7T+FneuRHU8LkCJMQ7phnx8fCMMgNberRE?=
 =?us-ascii?Q?brDw5wxSgJoNH1aY0GQbNo6ijqa2M/MAnDGQMpaWBveY38dZV8Fp83AwB7qm?=
 =?us-ascii?Q?XIp0iqbJHFU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1vhIy2pkzz87YGb/QyTOeowgP2WOtiQpHGhM4dgszwsLs9YLqcenl/O65Qs6?=
 =?us-ascii?Q?ONXSCnhR9wkgO65ktrogoklRxH8osWzt4Up5Qbeow5sKGux/zRZSJAOxZCCW?=
 =?us-ascii?Q?A7K4Zj2qDpyPl8n12jQa1datNvtkxiYurFKf2r1WG28yKhFFLFM+1RjogmGZ?=
 =?us-ascii?Q?qmWPkIV4Bq24MCB/ZPSvUgzh9+9CTTMUZpUlNvcYARGzc/i7j7XkfgVDjMAi?=
 =?us-ascii?Q?m0i9E+EI/9FkXl7GxsXYyGuor77+1b3rHPrzLtGrKDY9Q3x4Kh/A3SdIT54N?=
 =?us-ascii?Q?pkYQOMHzhmmlRcHVS94db/yfYti9oDjr6+F3GkxsO4GupebFB1tjoqledy4n?=
 =?us-ascii?Q?qrwSqejttR/IcU2iymAWVvh/LU904o7/56VypNp4vDkHnv3Y93KvH3boMNYr?=
 =?us-ascii?Q?zGcWZfQt1kdbjLZrv+O5xjbNhy7u66Ee7q0sxxioyiEOU7692t8qzQzoxJjn?=
 =?us-ascii?Q?wd0gkwSK2yT929mhvexOS496xCGG8rwfD/x4G6SaA/7yLu2+1DlsJpu6TWHa?=
 =?us-ascii?Q?hPzS6GeDtGwquh0kct76JoUtrx62LIvY4nVtMebTNB34pNJpvFMoDRZJK/iG?=
 =?us-ascii?Q?ti/QwtVuAEbCwEMSIzWJ55R170mtETTZvucVxXSSz61j0NI3Zky8j0IwroaM?=
 =?us-ascii?Q?UaRv6puAi8apr6DfXkbp2R8qsth4inQMZZYFSMQVxDIp386vkaGKBsRQ2Vxy?=
 =?us-ascii?Q?jj9PgFB9I3lv7mT0IJXP/J/DJkrnp4RZNRY05v2iIYqA04xElLjEwqNeUk/t?=
 =?us-ascii?Q?mYtIumL5FxfpAgvE9SyYDD/NXmVP3kvC5GwrPpvJfJhHqrgHXhHOqrW1A4Jz?=
 =?us-ascii?Q?sg5G1hcNleUdBftKWTNOcYDmweEauQ0b5Lg3tyrghpHgdv5oHwFTuvD0VjS0?=
 =?us-ascii?Q?EwcFf72XnwGxGX5jnMpd2pYm24nWSgoMtqnk3Rbn46kFDuwrKJXbrHd4sbUJ?=
 =?us-ascii?Q?0zX5XdffWLNnleR+0a0pnyeih/p+rOgpZRy6BuE7nryMvozo6uCq5B6CAYdW?=
 =?us-ascii?Q?VjL6/yJIgM4sybs7wAYU+9toV3fUeHukss818w2a9wAP/yQ+Ctbp6jre5UpM?=
 =?us-ascii?Q?iImF+b8Srl2wLisDcYwgCF+at5p/RMR579owU523eEH524rJxMWpUwKKw511?=
 =?us-ascii?Q?OKVHOmUMEvbSPEsChddOKI4YJhNY/6BRKNbhXG5AExCNgobCnhzaFwoAN6hl?=
 =?us-ascii?Q?tsxq+bbyCn4m2TAQ0ROhzdcJWus+j1zwaPVeqgPmPDoqX+z7xIUfJ3kqEcVu?=
 =?us-ascii?Q?07cfrxS0iL9MCdurEQdJ8uzEtO7HMjuKdoghCiwyjsaYVW86xItPT+PGIyLq?=
 =?us-ascii?Q?gpWZGblTdVQwKNcE5fLYGQZkGm2BECYoOnYx364KpzBnNAxmEc4edk++0pJM?=
 =?us-ascii?Q?WUJpjIb2Befm1y8waIVN2WMB9/lO6MWHj0eQ/EbEePeHB4V5SLC/rJ4SNcG3?=
 =?us-ascii?Q?x00WtvQiMBbW1jWAcqgEHdclA75u4lutFHzlneexx0SjhA1wgEdVpDKhcvep?=
 =?us-ascii?Q?d9L3RcuKIlglfQ0BGcEnusf+gaXN6lEC1c0e/YChkqx1qM669vcaH/kVtpNC?=
 =?us-ascii?Q?70dpHgqnCvdnex7Xdh2D0pbIshuw3GoPeMBd6Lo9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cf7960-5499-489e-7d2b-08dd83440eec
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 15:24:08.7851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R/LfsaZNoJND62+TqlbG0a24kqRM2ijdBbIli1a4bt8mhsFloVVl4wCrep4dTmbHtHFkKXE3roKDBe1LlhsfJnhZw74jRzz9IT2CTUWEpRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7085
X-OriginatorOrg: intel.com
Subject: RE: [cocci] [PATCH v3 3/6] arm64: tlb: Convert the opencoded field
 modify
Reply-To: "Keller, Jacob E" <jacob.e.keller@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2720
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/PH0PR11MB50957B606B76490E205923F8D6852%40PH0PR11MB5095.namprd11.prod.outlook.com>



> -----Original Message-----
> From: cocci-request@inria.fr <cocci-request@inria.fr> On Behalf Of Jie Lu=
o
> Sent: Wednesday, April 23, 2025 6:16 AM
> To: Russell King (Oracle) <linux@armlinux.org.uk>
> Cc: Yury Norov <yury.norov@gmail.com>; Rasmus Villemoes
> <linux@rasmusvillemoes.dk>; Julia Lawall <Julia.Lawall@inria.fr>; Nicolas=
 Palix
> <nicolas.palix@imag.fr>; Catalin Marinas <catalin.marinas@arm.com>; Will
> Deacon <will@kernel.org>; Marc Zyngier <maz@kernel.org>; Oliver Upton
> <oliver.upton@linux.dev>; Joey Gouly <joey.gouly@arm.com>; Suzuki K Poulo=
se
> <suzuki.poulose@arm.com>; Zenghui Yu <yuzenghui@huawei.com>; linux-
> kernel@vger.kernel.org; cocci@inria.fr; linux-arm-kernel@lists.infradead.=
org;
> kvmarm@lists.linux.dev; andrew@lunn.ch; quic_kkumarcs@quicinc.com;
> quic_linchen@quicinc.com; quic_leiwei@quicinc.com;
> quic_suruchia@quicinc.com; quic_pavir@quicinc.com
> Subject: Re: [cocci] [PATCH v3 3/6] arm64: tlb: Convert the opencoded fie=
ld
> modify
>=20
>=20
>=20
> On 4/18/2025 2:11 AM, Russell King (Oracle) wrote:
> > On Thu, Apr 17, 2025 at 06:47:10PM +0800, Luo Jie wrote:
> >> Replaced below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
> >> - reg &=3D ~MASK;
> >> - reg |=3D FIELD_PREP(MASK, val);
> >> The semantic patch that makes this change is available
> >> in scripts/coccinelle/misc/field_modify.cocci.
> >>
> >> More information about semantic patching is available at
> >> https://coccinelle.gitlabpages.inria.fr/website
> >>
> >> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> >> ---
> >>   arch/arm64/include/asm/tlbflush.h | 3 +--
> >>   1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm64/include/asm/tlbflush.h
> b/arch/arm64/include/asm/tlbflush.h
> >> index eba1a98657f1..0d250ef4161c 100644
> >> --- a/arch/arm64/include/asm/tlbflush.h
> >> +++ b/arch/arm64/include/asm/tlbflush.h
> >> @@ -112,8 +112,7 @@ static inline unsigned long get_trans_granule(void=
)
> >>   	    level >=3D 0 && level <=3D 3) {					\
> >>   		u64 ttl =3D level & 3;					\
> >>   		ttl |=3D get_trans_granule() << 2;			\
> >> -		arg &=3D ~TLBI_TTL_MASK;					\
> >> -		arg |=3D FIELD_PREP(TLBI_TTL_MASK, ttl);			\
> >> +		FIELD_MODIFY(TLBI_TTL_MASK, &arg, ttl);			\
> >
> > This could equally be:
> > 		arg =3D u64_replace_bits(arg, ttl, TLBI_TTL_MASK);
> >
> > which already exists, so doesn't require a new macro to be introduced.
> >
> Looks like the new macro FIELD_MODIFY() is accepted by Yury, maybe we
> can keep to use FIELD_MODIFY() with this change for better readability?

I'd prefer this version too rather than a pointer that modifies in place. F=
eels like it fits better with the other FIELD macros which don't take point=
ers and return their bits by value.
