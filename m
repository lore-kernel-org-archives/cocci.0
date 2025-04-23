Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815A1C369CB
	for <cocci@archiver.kernel.org>; Wed, 23 Apr 2025 16:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=zlXdCX07iWnHjZpFQP7nJiws80IrKxlljalxc3exK2M=;
  b=GRqVYeRTsLBBY2dgV29V/khcC5oXr8SgjCg7yNbBKtL2cB6OJWWgLG53
   EwT6aL4jtd0bVN9xIqjzqh5aOGGwEQ9/WmUzvzUQFR/UCBaLIXOrZznHv
   PEXTrdI4tnGYsie8JJcjj78OhgojLyLvSGTA4/uRUQj6EG3bdvel8XydU
   w=;
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
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="219156414"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2025 18:55:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 33D05E0264; Wed, 23 Apr 2025 18:55:01 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0F7DCE007A
	for <cocci@sympa.inria.fr>; Wed, 23 Apr 2025 18:54:58 +0200 (CEST)
IronPort-SDR: 68091b61_G/vfluAdzgJywJpfX3+OCfip8gaJsNNBRx8szT/je4mCMu4
 jBn8VfkzxzDxxyjlrNoRIVD5VItqn41fZ3gyPsg==
X-IPAS-Result: =?us-ascii?q?A0EDAABFGglogxCjxsBaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAQGBcFJ9XDEEU4ghA4RNhzQzgW4Di2ORBYErg?=
 =?us-ascii?q?UAzCw8BAwELAQEuCwgBAgQBAQMBAgGFAAKLLQIeBwEEMAkOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBARABAQUBAQECAQECBAYBAhABAQEBOQcOO4V7DUkBEAGCBwGBJF4HC?=
 =?us-ascii?q?TcBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECD?=
 =?us-ascii?q?V4BAR0BAQEBAwERKAYBATcBCwQCAQgRBAEBAR4QIAcKHQgCBAENBQgagmABg?=
 =?us-ascii?q?jADMQMBBAylFAGBQAKKK3iBNIEBggwBAQYEBIEA2h8NglEDBgkBgT8BiDEeA?=
 =?us-ascii?q?YVsO4NCeieBA2JDgRVCeYFvPoIfgiYFMYNdgi+DSIJ4h3GTUVJ7HANZLAFVE?=
 =?us-ascii?q?xcLBwWBJkMDKjQxI0sFMB2CV4UlghGBXAMDI4MTdByEaIRSLU+DL4IDaAYdQ?=
 =?us-ascii?q?AMLbT03FBsFBIE1BZVKgTmCMwGBDiyBGGuTcIMXAa8bcQcDhBuMGY05gX+GL?=
 =?us-ascii?q?heqV5h+Io1khAeRb4UOAgQCBAUCEAEBBoFnOoFccIM3TwMZD4ZBh2AMDQmDX?=
 =?us-ascii?q?oE+hju6GkUzAjoCBwsBAQMJhUYBAYRLhgmBSwEB?=
IronPort-PHdr: A9a23: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
 3PgLpv5K5geMsvw3EkwMzFH
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:3B9qJ6uwCXpZdOBik6uenmde7skDpdV00zEX/kB9WHVpm5Sj5q
 eTdPRy73DJYUUqKRcdcLG7SdS9qBznhP1ICOUqUItKGTOW3FdAT7sSkbcKoQeQeREWn9Q1vc
 wLT0E9MqyUMbEQt6jHCXyDc+rIt+PnzEnHv4vjJjxWPHhXgulbnn9EIxfeGVZxQAlbAd48Dp
 Sd66N81kGdkFosH76GOkU=
X-Talos-CUID: =?us-ascii?q?9a23=3Ayc9u82sOd5f1aG+f2Sni9gr16IsocWKE0lb3BXW?=
 =?us-ascii?q?fGFxXQbiXclqMyf57xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AX62dBQ+IJy3MaLfVF7+wXQGQf/04wfyXUEpTqJw?=
 =?us-ascii?q?H+I6+CzdLfB2fhg3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="219156400"
X-MGA-submission: =?us-ascii?q?MDHAnqV1i+yDS7VwncXI/twjl5vmvlQItzPRwf?=
 =?us-ascii?q?SuyMs9RpD9w68jtoyKJJc33cPakbsAmPRJi8CUsj1quGTXqenI4/UKf5?=
 =?us-ascii?q?VdwbwmB975m2a++8xZHgDUvGN9H+vQ9u3z1VHfHPBfDCZ9w/jd6ri5As?=
 =?us-ascii?q?CyJzFTuIjI1OPTA9pZ5dam2A=3D=3D?=
Received: from mgamail.intel.com ([192.198.163.16])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 18:54:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745427297; x=1776963297;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hJt002X7BbFgoryZuiyMn2QR9sk1z/bRfNGyX/2cMH0=;
  b=a8mC7isiWPRaAa9/lFVa8eHbddv+kzpSOgZM0kmKrUvbqE1lAZF4jb4Q
   BxWmZ9eREZpQUB+gvtIOHZpVjWbguyLu+dvVEZYUtALcTyc2z+FX8xpLS
   QQ+g5rFrqxx7aCUVFmT41wh9uVu2i1xe66TpKj0l2yIWOeaLa3wi7cDfW
   bmvVAdDkq4ZtvoY5/WimGCfAThnREIg9i0Svd+9k+xh2xs0xcbzlJZeRI
   YXyxSOb+lFPKEVzvZncrPi5OR/r5Po3IPzMCqEp78xEd8sOzead+sYV4n
   RE3QpRaPlUKRFJnHhGLhUTAfIoqB+EsuaBCqzgWHe1PE6ZNeRQp9w5cuI
   A==;
X-CSE-ConnectionGUID: 1RUQdSQDREiDQOu1Bc6ZmA==
X-CSE-MsgGUID: ZkrWbmmVSb6krP3WRfGLMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="34647557"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="34647557"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:54:54 -0700
X-CSE-ConnectionGUID: 21y+VRHoT9Wx19esdOEA9g==
X-CSE-MsgGUID: lPKb1lo5STe2FURaqt6QdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="155583950"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:54:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 09:54:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 09:54:52 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 09:54:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7RTyF/RIGSxjhb1wgF4Amo/+ndOMOxU230DZ+gECGRu5HS5BIQProXsBAhwVSe8aneX8RaO0PutRReJB8LOBUeB0tdQVlLhxR5960ru2G+gawH6SvX8GWhtYE+OZMMvaAcxRtbnRYZo0CP6OJLLbYbRRjgnchwpIGx2HGuM4A18EBxm38cyUBUzYQBqEkeaMOPzjphkCuDc73gWDT8T1EADdU+doYu0NOX5XCTgGVLDI8C+YDY8hjZYT3uHuS9stQVebVWWD6rjatQbYpk9FFA+a1h264OwpkyE71uY2VQT7HXxIJCUxznJuByhgg78FiSx0DM8rT55ywYt2uthqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlXdCX07iWnHjZpFQP7nJiws80IrKxlljalxc3exK2M=;
 b=pI6e/6q+vpzVKkzBoyZ3JBA6Z4ODCrgJeLrviXyNtSAjf3NMPtXwMwW3oiSnkSMO82CgtJgmTpGVRQYArbCSzOC3h9ZZyj99DdsZYF7QV2tZBQvydvBk2zwKD+NqZQFGckd31MQc9xX5VEOx63K3rzfHr0ziEmDMjaqenMB6CXwvqDpYsxdcMjZHxSG54f9h3eF8ibkgphu/89qUZZSpAq4E5aBjBtw5FOuhH4OAFaNczvn/FNHq085W/ESM40qoc/xYEmRKRloHb2alCZyRjjQnCvS5E5cvZqinDcQrVXtMVJfNLhpQMpUA8p6IK8MRHj4WPaKaX2aEx1t4Tz0sZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB4964.namprd11.prod.outlook.com (2603:10b6:303:9e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Wed, 23 Apr
 2025 16:54:49 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8655.025; Wed, 23 Apr 2025
 16:54:49 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Luo Jie
	<quic_luoj@quicinc.com>
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
Thread-Index: AQHbtCzwqS29KFwsakalRi4XUJvnbbOoH9IAgAlX/7A=
Date: Wed, 23 Apr 2025 16:54:49 +0000
Message-ID: <CO1PR11MB5089C0773E3AEAD4BB0A1AFFD6BA2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
 <20250417-field_modify-v3-3-6f7992aafcb7@quicinc.com>
 <aAFEOr_PnZRH2ocR@shell.armlinux.org.uk>
In-Reply-To: <aAFEOr_PnZRH2ocR@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|CO1PR11MB4964:EE_
x-ms-office365-filtering-correlation-id: 19c76e5c-80f5-4778-b522-08dd82878f52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?qIE++vV/Df1p+4CAMmsisJy5hv3JRBAjC6UjQ9S2R4ttlz8EndphGfZc+pzD?=
 =?us-ascii?Q?alABT9lGKmUhKKRSaUSfZxY4N2NzYimiXNXOUqmM7Kroq1HKH4oepP1IuNGX?=
 =?us-ascii?Q?gaoe4l2vwbhsG3nrX3KnSxQX6ozC0Xnd2H+tfz+pj0SSoPUwvE6hbFEhjuiM?=
 =?us-ascii?Q?8BJiDyjdkYO4yKf2iEAfGVK31BlZ20f8WUw6Wq1on2AncJzHcW4acUeY/u0h?=
 =?us-ascii?Q?TbjYSzNzC8JvVCcY3TIbK55Nc/iaNFzrSy3I2QyWWY9kMyI6g/cLHPtoZ6jW?=
 =?us-ascii?Q?/+n4PhrLXACpKEAg5BwGAg0CMhO25eDbdpWkfB2iX3gseYkc68keraXmOQA2?=
 =?us-ascii?Q?dSLKPkZ9Rv4W8Kf4rc9t2cCMpffG5xEPYx8DsLqo7wFeJcbztCXp/fNbjHmB?=
 =?us-ascii?Q?nyno7kw6bjQiBXUc5iyPgUOP6mccf+RMey1F5LwfWBUcoeLqZngbgun6GW/O?=
 =?us-ascii?Q?hNZs4v1PVrm/NGXnx/aSwT+6uZ9RmKZnBY0kZKc4KyGur55/N8/54Uw4AnG6?=
 =?us-ascii?Q?TptxzXXF4Bz/eS2q/hFEbOSeFYUU0WQA7n0Q1CCu9hKHP5ivK2c20UFyWxIa?=
 =?us-ascii?Q?OkYnquYGOM5/vTdjqnjratlzM8uQJzq4knrVj0TqKSLc/sNWhtYC6tePhpJp?=
 =?us-ascii?Q?4H9DVFliommLjaqrqeK2sucgQop84FwFBgpAhdgdRz5gCfkdAoBrHAUlDj8S?=
 =?us-ascii?Q?cBhvOrzXRVhmeMnakdBGDFNRpyhNcZFd/BjMa72iTPQ1fQ0LmbLin5D787rD?=
 =?us-ascii?Q?tPWn6JKMy/aPtyFxLZSnnFrl6IfNfMU3mhRwm8xY02QR8RxEaM2oDy+hV78n?=
 =?us-ascii?Q?CClfsXXEpSLvD2r2vgm0Q4uj57te1pBMzIURkygWjs90UUlMewH4zVx2CwjW?=
 =?us-ascii?Q?sQPPKtLHJsVKoSoE3C9KJf45c9paNuZT6g/L1dA71VorV9d0VJ0FTexmLH/4?=
 =?us-ascii?Q?b+Sx/0s1a55H4WJ9K/id5eI7jxTsWvxnvR4QihoAI7F6KFIrRub2Dp61uq+u?=
 =?us-ascii?Q?RBaZw6l6w3LiOmNiBAuRS0NPejZQ/ryytops6VvS00ePJntjbVghxmAS8OSL?=
 =?us-ascii?Q?/WuN/TrlDYtCIG515Td03/ZvDSOtO8u1v1Fj19Yqjh297T1lxk/0jW5OK07a?=
 =?us-ascii?Q?b6g9N1xCV1jCmcV2GunG9gl0jPmFiFW41x2B/OHvHnnQvUFxzWLGQc/5RmfM?=
 =?us-ascii?Q?Js+aJ/U1duTHjy/e15yfbDFkK/S6j644OBuMiwwHk2YHJCOx65HWZHrkMz7D?=
 =?us-ascii?Q?2yZv4RsMzUZfl7p8jzkZNz39H3znT8/ZeVPpzr5XlThQc5E3suB8QmnSXg3x?=
 =?us-ascii?Q?vSNNBIV6OxnhwKrw8WqLHLT6QSPh60qHziH/RVXpja90cQaVS88rL2P6lFhy?=
 =?us-ascii?Q?uxRDzRWnWqjclNQkQAzNznEfaNfrvYZFqmbVyQ0i3+KbDHJRVQx9QECN9a3z?=
 =?us-ascii?Q?Sa4Lkrii2Yw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V2g81FA3otGQLU65kArODHqUFZwkjPyUcwW8SxKymL5a0JUm8vFG31bIw9r6?=
 =?us-ascii?Q?z1MFlYLKdqVcG6dnvhZmkFRwl28aJw5+UzApzwakUW/j4rFsO4v150QP9tGV?=
 =?us-ascii?Q?XU0MBhR/I2DKLpTpTRL3drq5q0zAtjRaBJsVYHH4v2FsRTPKTRqrT2slLj6A?=
 =?us-ascii?Q?Vdwp5XFFasdKVyV5CaICqk/O/nBxpbMWawtzob9f+9dZKJucVxJRk3ZGvKgB?=
 =?us-ascii?Q?6O+tz7SmAr+q88iRS00yHTP4uGds0vxOCGrHIG2sTdYj7uldyG110zNgPl8o?=
 =?us-ascii?Q?A6ocrdC4K++VSq5j7qcz7TLHCJPh/gDDMIvdle6epPWPcVSHstI2mtvlakI7?=
 =?us-ascii?Q?4UCORuW0yE2YsJXX5Nu6vR3xhOHZESpUqqeIE3V8J1W14dS4WUpYQEsBZNuh?=
 =?us-ascii?Q?qlgZ5GqGds0EC3x1qvdiXnNGtO47MXofrqtt2MNGSJikfmToXKXHapz24QUt?=
 =?us-ascii?Q?cvKs637+1PLvYGVAqy8ihOTqoBttDLwFXG+SJn2fWSV2VGLWmGClp5j6WrMZ?=
 =?us-ascii?Q?eDs/rMLAqMQttZYqiEaVbjIIXzeI8erI6LGe94wpcd7lHsZ6pQpx690+OwM6?=
 =?us-ascii?Q?hxBxrpfDm/hAfoUyUL9jgpHZZnUIsVPqTNy4oc1VG5Fzn31AmQtngnw8aiwF?=
 =?us-ascii?Q?nZ2RaX4pcTPgONkOhR0JUx16OigtfDuykV8CLvxtYEQtU6TqMbVqPIoGhgFC?=
 =?us-ascii?Q?e9KyPsue8DajpS3Fno6wlzhjAktnN6KhaTzeVhxlzREJ+IjpjWNETJh9upTi?=
 =?us-ascii?Q?/CsPItqhG/TZWiRGYuLIC7mH6thSUxUfIFsfmqKrydKIltgTlA5MEQkH5Dr5?=
 =?us-ascii?Q?CHzYU2g8NClPYZ/1JGoEWoioLE4LhMRlGDSpi2pPtqI8cutmgpoZfw/9JaOG?=
 =?us-ascii?Q?otOMgcnd52LkwS+Z+YBtZ+xS4rNHxQVM3vMET2PuW/oAapTlVFmnvxFVtyaD?=
 =?us-ascii?Q?QUsnxcl8Y9LWFUe3QxaUxGy/jLHsZ9n35s+VnUpMezWyH9TrBPIDM/iM5jm4?=
 =?us-ascii?Q?SDXsxfBi/YjI3epsG2fLyZHyUo98l8vp1uU4cK1YVFYcZX4cgAKazCtr1cWC?=
 =?us-ascii?Q?Bq/DOoTLkDr3Lchvwck2NBqF+rt29WbR0tGd5pARugj5DXOV5Xo1r68mltv1?=
 =?us-ascii?Q?VTwYCRvA8MmSKRHT1R3xN5xy3+ISxiSRfAunaRsDlteR+vrAVGelI6CmQ+V7?=
 =?us-ascii?Q?Jzb2X9rsC5wvR2V8tutOHymEZikZurWviZpz5lDw2z4Yr6F5shYVqFB0ACTS?=
 =?us-ascii?Q?pxDx8JgY9/G644Iea8FHXhGTncwlQoDexcqGeCC6oeXVbi4yiw8qoY+BDFaK?=
 =?us-ascii?Q?WW7k46QPid8OCGmQ3jK18eDruEihrFeEaRPpQaMKw2I1p0wM6GOOma/HmreN?=
 =?us-ascii?Q?KXu/RAVOkOzEfLaQL6c8lc5l+61TwBccMJ3JaE+OylFylT2g6CSKy3gWvSw3?=
 =?us-ascii?Q?twp9gicdFhQDUw0GQHHDjQ0Niv+AkWMQZtLvenNKrp16vcdQO4L/kwJYyD+1?=
 =?us-ascii?Q?g+spQsmEcXGYY2G7piRs66o5gbqiQD9JaisAhh0gyfDg9ET/l1TROU49FqPS?=
 =?us-ascii?Q?JWyyCY1qezsQjlz60+q664+BkmKCCEjU9+eLB1JL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c76e5c-80f5-4778-b522-08dd82878f52
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 16:54:49.2831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /K4hZQdpBNtob6cKgh+RDtaoaH/3raBOtPO+IHmYp7MkWzcG7REBuJ7ljJVmUkZezqjU9e34vDEC7zlFqmg44vh1BwmInXlWfIQeBMWEKMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4964
X-OriginatorOrg: intel.com
Subject: RE: [cocci] [PATCH v3 3/6] arm64: tlb: Convert the opencoded field
 modify
Reply-To: "Keller, Jacob E" <jacob.e.keller@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2709
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/CO1PR11MB5089C0773E3AEAD4BB0A1AFFD6BA2%40CO1PR11MB5089.namprd11.prod.outlook.com>



> -----Original Message-----
> From: cocci-request@inria.fr <cocci-request@inria.fr> On Behalf Of Russel=
l King
> (Oracle)
> Sent: Thursday, April 17, 2025 11:11 AM
> To: Luo Jie <quic_luoj@quicinc.com>
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
> On Thu, Apr 17, 2025 at 06:47:10PM +0800, Luo Jie wrote:
> > Replaced below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
> > - reg &=3D ~MASK;
> > - reg |=3D FIELD_PREP(MASK, val);
> > The semantic patch that makes this change is available
> > in scripts/coccinelle/misc/field_modify.cocci.
> >
> > More information about semantic patching is available at
> > https://coccinelle.gitlabpages.inria.fr/website
> >
> > Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> > ---
> >  arch/arm64/include/asm/tlbflush.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/tlbflush.h
> b/arch/arm64/include/asm/tlbflush.h
> > index eba1a98657f1..0d250ef4161c 100644
> > --- a/arch/arm64/include/asm/tlbflush.h
> > +++ b/arch/arm64/include/asm/tlbflush.h
> > @@ -112,8 +112,7 @@ static inline unsigned long get_trans_granule(void)
> >  	    level >=3D 0 && level <=3D 3) {					\
> >  		u64 ttl =3D level & 3;					\
> >  		ttl |=3D get_trans_granule() << 2;			\
> > -		arg &=3D ~TLBI_TTL_MASK;					\
> > -		arg |=3D FIELD_PREP(TLBI_TTL_MASK, ttl);			\
> > +		FIELD_MODIFY(TLBI_TTL_MASK, &arg, ttl);			\
>=20
> This could equally be:
> 		arg =3D u64_replace_bits(arg, ttl, TLBI_TTL_MASK);
>=20
> which already exists, so doesn't require a new macro to be introduced.
>=20

I had been looking for something like this the other day but was grepping f=
or "FIELD_REPLACE" and similar which didn't find things.. Neat to know it e=
xists already :D

> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
