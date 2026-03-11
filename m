Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12031049525
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=M1zX9+PPku/ezMDAwbUGLL4E51fSgV56iroRvGjTTG0=;
  b=BEMELfy2XM8mOL3/YhGrIi5D3cWw9v9qCrIN2VXh1JOyQknySFwKgrG7
   sTWm0ppYbcZPHMXtA2+ySHnbyn0EQap2knSnRbbSgW8txAwFC7JVVqh8S
   XqEapyB820w2J9UDU4It1kLlY0/Js8PQwc3y4VeMmImEBUohZB/MIFUXc
   g=;
X-CSE-ConnectionGUID: Gjaanhu9S++0brzUAs0NgA==
X-CSE-MsgGUID: q30hEa2MTKi+G+BN87kCTA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267246527"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:45 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 9F831818D2; Wed, 11 Mar 2026 10:46:45 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id F1301818A8
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 10:26:24 +0100 (CET)
X-CSE-ConnectionGUID: VnqHjOmFTy69bPfWaLiTVw==
X-CSE-MsgGUID: tzF51qA1RIyGDuE2ilmuMQ==
IronPort-SDR: 69b13540_JcTgUpB4zSE5L9ZZf58JZ+5AuPynvt+9B0AN6IUlhd7MP0C
 +kFrsNQxAPqRJzzqdOYlRvLHTXScrzVvKu0JbDA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EZAQAINLFpjwtBr8ZaHgEBCxIMQIFFC4FuU4FoMQRUh?=
 =?us-ascii?q?FiDTAOOJQOBE5tcgSuBQDUIAg8BAwELAQEuIAECBAEBAwSFAAIWjQ0CHgcBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBAQEBO?=
 =?us-ascii?q?QVJhk8NgmIBgSReBwk4AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQINXgEeA?=
 =?us-ascii?q?QEBAQMBEREEDQwBATcBCwQCAQgOAwQBAQMCJgICAiUKFQgIAgQBDQUIGoJgg?=
 =?us-ascii?q?iMBBkoDAQICoi8BgT0Ciip6fzOBAYIMAQEGBATeCQkJAQoBgQouhTyDFwEBg?=
 =?us-ascii?q?XCCSoEgARmEAHongWVDgRVCgjA4PoQKOxWDRDqCL4M0jE2GVglJeBwDWSwBV?=
 =?us-ascii?q?RMXCwcFYUIQMwMgCi8tAhQNEBIPBBYFLR1wDCcSDx0XFB9YGwcFEiEqB4FBe?=
 =?us-ascii?q?IFmGw+GaHkDLl4aDiICKBIDMgQjgQYLWgWCLAIcAwttPTcGDhsDBDp7BY1rP?=
 =?us-ascii?q?YIUHwEBgQ2BBz18GJM3g3WvVgMEA4QcmVyIMheqay6HZZBzIqh0AgQCBAUCE?=
 =?us-ascii?q?AEBBoFoOoFccIM3TwMZD44hDA0JHINCjz0BuWxFMzwCBwsBAQMJhUYBAYwiN?=
 =?us-ascii?q?IFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:GkAinKEcVo6JFTBKpLqE1MeALOsnbusQ8zAXPjNKOHpom6uj5r
 qTdZUgpGTJYFR4Yh0dcLW7V5VoLkmsl6KdjbNhWotKPzOW3VdATrsSjrcKqgeIc0aVm4886U
 4KSdkHNDSfNykCsS+32njdLz/++re6zJw=
X-Talos-CUID: =?us-ascii?q?9a23=3AcwjrXGl55ueHzzIvdhvzPbO2i+XXOUPb1VfSBEq?=
 =?us-ascii?q?WNXc3GbetR2CZ3KJYrdU7zg=3D=3D?=
X-Talos-MUID: 9a23:oRwiegV9u7wNifnq/CP+qmw7Le4x2YW/J2wQvM8Hv8yZEBUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="141009674"
X-MGA-submission: =?us-ascii?q?MDHFQmHd4/T9BFOQRAUye9OaqEFDkEzzbNYCWe?=
 =?us-ascii?q?HY2t9PH8bfSuWJX4EezoItNOHUBKegFC2jXWM176FsyW065LPUA9XVWa?=
 =?us-ascii?q?wUD9p/hhQf9F4FfW5BVtva03ZTJQeJ7Y3mP4crLQzxrJT6MCchfeREdw?=
 =?us-ascii?q?LDp28vU5JIFdJaAxOUvL8zdQ=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 10:26:23 +0100
X-CSE-ConnectionGUID: S1xb1i4PSaqhhYWM/dcynA==
X-CSE-MsgGUID: bM/KmduVTMqDOIVdUhsT3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="84607313"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="84607313"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:26:22 -0700
X-CSE-ConnectionGUID: LMXY3nXATmyMWa3R/nchBw==
X-CSE-MsgGUID: ZqQVSMjVSvKtafNEdG+NQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="219652696"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:26:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:26:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:26:20 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:26:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHcSIfijcpH/6CRWMoLgzcpmerxymuEMU/11u9hBUq2RgCQMKONwbAgtuf0TdXeO63j5A8VJC6nUdOYYCur5CfY5FYoXgbr7ioY00VVV+VB58/wHGUJl3bqccJI4DCEvob5sH6S/Fy0nnIF1YtmGcV0+VKD7oDaxIUwQaEMQH4wJNGRLRFCfV636zxyF2xgp7COoqDZA19iQ2TZBkxmWvjfPYM1xuo41el2q9p6RMtkvzUYzsfu00hMxgCPcwmTveaou4d7Qr/Y2dqMmeoNA+XTaJJD7tMJwvDYg4tIWmHnWMLhLTNBNmR8ikJa8V3ZhUmsq0ckFPMpOZX9RO5b04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1zX9+PPku/ezMDAwbUGLL4E51fSgV56iroRvGjTTG0=;
 b=fh9Osd/t6LBSLRVXWch8QVmPLCtnKal2mEVH6UDjD2cX4NQlByAFShJXQxewu5aMe35/KS4KDzu211/10FanESnm2hIp87g1Hq7+qhPEG1q2VlydaVQUPm2WgH6I89aZz6BMAg4N6j15BBsnKXDa+FRkfyRjsEvB+s1w/6Y5MwXQEAmx+1DjPja6bR6taNNdghLIKjqfSJnrnIXplza9ssBNfxvdv+SRWyRF2rIzVoSyPxrvtnOoJqmg8r9O1D3KmAuta3L0tUuglPVZww+IYMTdvPjWg8LlIDJrf3wxRQcbGOTLfBAP9G7o7/5a984Z1a1XF9IfSnxKE6TisQsp9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6836.namprd11.prod.outlook.com (2603:10b6:510:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 09:26:18 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:26:17 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Philipp Hahn <phahn-oss@avm.de>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "apparmor@lists.ubuntu.com"
	<apparmor@lists.ubuntu.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "cocci@inria.fr"
	<cocci@inria.fr>, "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>, "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-leds@vger.kernel.org"
	<linux-leds@vger.kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "linux-sh@vger.kernel.org"
	<linux-sh@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ntfs3@lists.linux.dev"
	<ntfs3@lists.linux.dev>, "samba-technical@lists.samba.org"
	<samba-technical@lists.samba.org>, "sched-ext@lists.linux.dev"
	<sched-ext@lists.linux.dev>, "target-devel@vger.kernel.org"
	<target-devel@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "v9fs@lists.linux.dev"
	<v9fs@lists.linux.dev>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>
Thread-Topic: [Intel-wired-lan] [PATCH 50/61] iommu: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Index: AQHcsKKKsLw8ffVSJ0afYyGoGNmoEbWpEOYQ
Date: Wed, 11 Mar 2026 09:26:17 +0000
Message-ID: <IA3PR11MB898657C50235115E4008890FE547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-50-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-50-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6836:EE_
x-ms-office365-filtering-correlation-id: 96cac31b-82e0-4d79-7e67-08de7f503fe3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: L7AbhlILyxI6R8isGXcs2nyf2NNr0nZWS5k6L2IPzei04OuUfC1rIwLyClFyZ5je9ovWr/B1dafcS/kw7EJGerupbSOfwkAgOlGEpAwElfESJ/7GopwVGvFcM+uyrVGr8X4e62KV1J8AxGQqeRIfts3e51/x+lgsXn71Vs1qi+JL64U3u39q2K8GxJjJo0c7fkXQtNWIokNjRzXju6WLbhWVeKBrHbc8Honxw7SmCB0Bsj7ub9bACNgcuNtLXqQdMtKtzinrs348pVo/DKURLNMhZ/6zJSajZ6frL29TDE0k9BJd4y0kVRawVUEglESCQzbF9gFlZQhHmsJtLQcYLoF0YroTs7br5hAxzlK6Y86xNF+zZU2Z+YzNnzmnNt7cEyempZ7l/ucsfDbei1UxvzVICOE9MPYzamJXDR1lQRI8ScrSGrHeN9GUsdQvSVzFWGLMPMfAUYsmkJE9X5SDvC5p9+mJGDlrlaXtFNx1Y9sHSFdheSExL2PrnFgZ8BPkkF0NjEq1788KeQQifnN5WsCYRhSKLLdquuRAWg8zOHCuRjzrN8E7kRrPcnH9uOBkIj1G7cgJRsE4gjmo5hlMfjAUmcfKL/55e9kqsLLdQmYzUlm5KqsI25hYnls1PIttxskmnImEAy3x4OBQJHXFaSbgz/w2Nv6+5DNji7RlZY1ZXPBdfmkJua64pNZ0O8NEKZFY5vn7rJOXWEcTtWe0N3xSHV98d2yqC+uGv/HCkYZIJoJgDsvaqEgWpxkbClxSf0MTGF/Ns2XNYb1m8iu2CMxUIYRVgz8mBRjPM1q30T8QkhQGtw5toaNHkrdf3bHo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXFvK05adWp3aElIbVZCeElSdmVDdWY3cy9uQ2UwWVNzL0luQ2h2clVReEJi?=
 =?utf-8?B?UFp6UU81bXpsYmxnMEE2c3MzT3BVaTRIOXVIb0dsamVBcUY5cFdnVHFyYWFZ?=
 =?utf-8?B?MFZiUDFNUVdFSFJ5YU1HZVZtL1dOcWNyYkV5VGNnT08rSzZRUWxHcUVSbEZm?=
 =?utf-8?B?Q3ZGelRHZ0ZuZ05vT2JuVWtabXA1VEp0NVFqT1JIc1RCQXF3bVVwa3ZkdmdL?=
 =?utf-8?B?UGpjb3NOWmViOWY5a3lrNDdZZlhaaU81VzZBT0dYWHJBcVZGYlQ4dEZzR3ZU?=
 =?utf-8?B?NkF1ellaVkdLNWhUUTh1VSsvdG9xZjFxRnhyY0l5WEhUdTlnaXJ1TldKNE9o?=
 =?utf-8?B?TFR6OE5YZFJsekhQQ21PNDBMcVFaSmdLUFFsNVZkMlBVNDVyUldCSGYwY3ZG?=
 =?utf-8?B?ZGVicnM3WStiazBUTHozdjV0em4ycHhDbG12ZmdpbGZvaE5sSTE1MXIvSGR3?=
 =?utf-8?B?djZwZzFJWm4rNmlmMjh3YkJGVURGclpXZVgyMzFtalYyOXA2Y0w1TnRIc2ZZ?=
 =?utf-8?B?QzhXVVFKS3NQT1VpREFoVjdyNTdmTTFWZDVFMTNueGI3dE43a3ZMU1ZJb290?=
 =?utf-8?B?WkxkQVBVSnJKajd2MDN3MytyUlBiN3FKWlZJZERxaUVTeXhZSExzL3dpZEZx?=
 =?utf-8?B?aEhkekFPMjkzcWlQNmNBWVBHM08xRVpRRWROU1ExV1NrN0FaSWtVOUk2Kzht?=
 =?utf-8?B?bld1OXlOTC9JOFZwMXZrSHNsOFVUVFNnUG5DMnR2TGgrT0xSdGY2d2FzOXJt?=
 =?utf-8?B?OVBoU2lMQzVONmF6WXhUVmpHNXhvL3dITXRiamJLQ0FEcGdBRlVISmNkR0lr?=
 =?utf-8?B?VGwxWWZOOFBHWHQ0MmF5eE1jQStpbmNPclZyaXJJbU5meWFNQjh1WnZoa2w0?=
 =?utf-8?B?cnUzalUxS1l4RXpMcEdEUjlUY3lzSGlYVmNWZTNkeDZxRTdsZGxxeEk0LzEw?=
 =?utf-8?B?K0l3VkZmVGFGclJWeFNZb21SU1R5RmU0V1FwcXVUR2p6bE1vNlZSWTYvdHBx?=
 =?utf-8?B?MXc0SXFQU2hHeWlEdmlZS24wRlhjNTR3eXlxK3BxUEJObGJ2WG5BdWovNUZS?=
 =?utf-8?B?Mk5ic1Rxa0F3bnVORk9EbWRtczFYUmdIWTM1TlJCWEJMRVRXUDdmQ3ZFUG1p?=
 =?utf-8?B?cFVXeTJCd29tRjhnRGNLWDNybTZTdlgzQnpSd3NwTDZRcFE1Q285dHg3K3dl?=
 =?utf-8?B?SEJoK3YvNC9YUmx0NVFBcTJQVlNxWC9ldUlQRzUvUExLVFQ5OTU1d3I1eG5x?=
 =?utf-8?B?THpRVmF2ZW5ScVJnaGZiWithVVI4ejViTVcvT2NlTXRnK3V1OXloR0JOV1JL?=
 =?utf-8?B?UDZ1VlhHV04zVUpKQW5NQWJOUVFkZzRtRmlydU1RdnJudUYwQnRKVXhXYVlM?=
 =?utf-8?B?dkpJcjZUMm5XaEVrMW5sNVoxZTVJb0RJRnY3cUN4bThMTG9KdDE5S2hRWUhH?=
 =?utf-8?B?Nm1samhiL2RvV3VrVE5mU3lGZUV4M0pRVWJyS1g1Rk5JVkd2OWJyVkRwai81?=
 =?utf-8?B?VXdQL2FWTm1RUENUcXd6czhobFdqWG9SZUhkV3N4RXExZ2xiblIwdzdXU3JV?=
 =?utf-8?B?TDF2bmxQKzZ1dlZhQTlBMjk1RjgyWXlyd0RHNjFMd3lac2VPUkl6bWlIQ3VH?=
 =?utf-8?B?OE1OaUl5K1RiazF0ZGhBd0RmTTFtdkNMdDR6dHI0eFU0cG9DV2RXVGUyMHlY?=
 =?utf-8?B?dFlyWmpCSnpzWi9hMWlyYUxwb3F1QjhzYU9tMEhZVjltTGxzMzJ6Y1MzRElh?=
 =?utf-8?B?QzB0U1lJaVI5ekM1NUtsTVYxMWJkN0JkdkpvUzRmdHVUQ0wvRHJrZ09jY0xV?=
 =?utf-8?B?NlhtNFdjeUhVTWdCTFBqbndVWWRqdUpTanlCZjRILy95b05DS2VlRHArcU1K?=
 =?utf-8?B?aXV0Q2VldDFmS20yTnVyZFdoQVpSQlFKV3M1am9HcHNhTkRKeC9XR3BiZEhn?=
 =?utf-8?B?Tk9BVW5UY1pUUFBJNHhLMm5UUC9FR3REMmI1eTZrQno1NEFIcW9lSnBrTFl3?=
 =?utf-8?B?eFcvN1dHbVVWNEUvWlkvWldkdkZ0QU5KTFB4ZVNUN25MWm84N3lPZUV2cU1s?=
 =?utf-8?B?T0Q4SmNPL3Bna1EwTlh6VnJXdzRibGFBRjJyeVFJYXdFck0yQmFzU0xDbnVq?=
 =?utf-8?B?Wk5md3JQUng4VURmQ3NNdmlrNlZKM2d2MFMzcTY5RVNEdzI1VGdIY2R6RS93?=
 =?utf-8?B?QzVYQTY0dVNhRTF0WVM3M1p0U09YM2VEL1dBK3JtYjBrRGQ5Nzk2RzFuQ3Ra?=
 =?utf-8?B?RWNPL3pFOGpKa1hISGJ3QU5UOXkzK1NtOFVZbGt5T1ZQaWRrNCtLUjlWdE1x?=
 =?utf-8?B?UEpCbmZVOUpLZFVTRzZ0cjlkWlBlZmVPRDdQNnRQdjJaOXpuczlsUklmbHhP?=
 =?utf-8?Q?8Tc2j9aiEyVh+eMg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ij9suR4+gfmfb75J72t3lGk74ceQ1dJA8Vk3YjNrzse2pltTXluRMto0A6PWt4MZCYpbGych7s9ipx4+D56FRlB0vIFbWQ9Ahqe5rQcmEi+hykaQd0SP6ZyeixwJ0B4kTGFqz+CQIMbIjWAURGPGeLqo6NSAO4nfWrghPgt32SHnGt/Pys8KCPXtUobyk26FzdDNfIp0fO0Co2lFE0Ptu7x90qqtcAV+LgseI9xwKfUhYgUbgyRVMX2xxQ8ncRk3QjFjQ1cSGDOyW4N+AQLyvybZN84FEG21l3UPxubJVvVn+4fMw3QB4h3zo/AURY1iqcrpPzZcNDGlu04uUt/DCA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cac31b-82e0-4d79-7e67-08de7f503fe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:26:17.9098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DKRoUTqSMgB7X+QiLzdNcDatHXI4GweH+7eYdOWlw+0DQhKehh0ceQgtCK4BL/RkhQUR0hD9OmNngsUP77xKwyRvxiR3TL2zy2CeBb7eKNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6836
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [Intel-wired-lan] [PATCH 50/61] iommu: Prefer
 IS_ERR_OR_NULL over manual NULL check
Reply-To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 3411
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/53xTLecQ8slC7vlFg90Ohw>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgUGhp
bGlwcCBIYWhuDQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDEwLCAyMDI2IDEyOjQ5IFBNDQo+IFRv
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgYXBwYXJtb3JAbGlzdHMudWJ1bnR1LmNv
bTsNCj4gYnBmQHZnZXIua2VybmVsLm9yZzsgY2VwaC1kZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IGNv
Y2NpQGlucmlhLmZyOyBkbS0NCj4gZGV2ZWxAbGlzdHMubGludXguZGV2OyBkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnOw0KPiBnZnMyQGxpc3RzLmxpbnV4LmRldjsgaW50ZWwtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgaW50ZWwtd2lyZWQtDQo+IGxhbkBsaXN0cy5vc3Vvc2wub3Jn
OyBpb21tdUBsaXN0cy5saW51eC5kZXY7IGt2bUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtYmxvY2tAdmdlci5rZXJuZWwub3Jn
Ow0KPiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBsaW51eC1idHJmc0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiBjaWZzQHZnZXIua2VybmVsLm9yZzsgbGludXgtY2xrQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtDQo+IGVyb2ZzQGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LWV4dDRA
dmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWdwaW9Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gaHlwZXJ2QHZnZXIua2VybmVsLm9yZzsg
bGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtbGVkc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBtZWRpYUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LW1pcHNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7
DQo+IGxpbnV4LW1vZHVsZXNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgtDQo+IG5mc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW9tYXBAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj4gcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXBtQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHJvY2tjaGlwQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxp
bnV4LXMzOTBAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gc2NzaUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LXNjdHBAdmdlci5rZXJuZWwub3JnOyBsaW51eC1zZWN1cml0eS0NCj4gbW9kdWxlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtc2hAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gc291bmRA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29t
Ow0KPiBsaW51eC10cmFjZS1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC11c2JAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj4gd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnOw0KPiBudGZzM0BsaXN0cy5saW51eC5kZXY7IHNhbWJhLXRlY2huaWNhbEBs
aXN0cy5zYW1iYS5vcmc7IHNjaGVkLQ0KPiBleHRAbGlzdHMubGludXguZGV2OyB0YXJnZXQtZGV2
ZWxAdmdlci5rZXJuZWwub3JnOyB0aXBjLQ0KPiBkaXNjdXNzaW9uQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldDsgdjlmc0BsaXN0cy5saW51eC5kZXY7IFBoaWxpcHAgSGFobg0KPiA8cGhhaG4tb3NzQGF2
bS5kZT4NCj4gQ2M6IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPjsgV2lsbCBEZWFjb24g
PHdpbGxAa2VybmVsLm9yZz47DQo+IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+
DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCA1MC82MV0gaW9tbXU6IFByZWZl
ciBJU19FUlJfT1JfTlVMTA0KPiBvdmVyIG1hbnVhbCBOVUxMIGNoZWNrDQo+IA0KPiBQcmVmZXIg
dXNpbmcgSVNfRVJSX09SX05VTEwoKSBvdmVyIHVzaW5nIElTX0VSUigpIGFuZCBhIG1hbnVhbCBO
VUxMDQo+IGNoZWNrLg0KPiANCj4gQ2hhbmdlIGdlbmVyYXRlZCB3aXRoIGNvY2NpbmVsbGUuDQo+
IA0KPiBUbzogSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRlcy5vcmc+DQo+IFRvOiBXaWxsIERlYWNv
biA8d2lsbEBrZXJuZWwub3JnPg0KPiBUbzogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJt
LmNvbT4NCj4gQ2M6IGlvbW11QGxpc3RzLmxpbnV4LmRldg0KPiBDYzogbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwIEhhaG4gPHBoYWhuLW9zc0Bh
dm0uZGU+DQo+IC0tLQ0KPiAgZHJpdmVycy9pb21tdS9vbWFwLWlvbW11LmMgfCAyICstDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lvbW11L29tYXAtaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvb21hcC1p
b21tdS5jDQo+IGluZGV4DQo+IDgyMzFkN2Q2YmI2YTkyMDIwMjU2NDM2MzlhNmIyOGU2ZmFhODQ2
NTkuLjUwMGE0MmI1N2E5OTc2OTZmZjM3Yzc2ZjAyOGENCj4gNzE3YWI3MWQwMWY5IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2lvbW11L29tYXAtaW9tbXUuYw0KPiArKysgYi9kcml2ZXJzL2lvbW11
L29tYXAtaW9tbXUuYw0KPiBAQCAtODgxLDcgKzg4MSw3IEBAIHN0YXRpYyBpbnQgb21hcF9pb21t
dV9hdHRhY2goc3RydWN0IG9tYXBfaW9tbXUNCj4gKm9iaiwgdTMyICppb3BnZCkNCj4gICAqKi8N
Cj4gIHN0YXRpYyB2b2lkIG9tYXBfaW9tbXVfZGV0YWNoKHN0cnVjdCBvbWFwX2lvbW11ICpvYmop
ICB7DQo+IC0JaWYgKCFvYmogfHwgSVNfRVJSKG9iaikpDQo+ICsJaWYgKElTX0VSUl9PUl9OVUxM
KG9iaikpDQo+ICAJCXJldHVybjsNCj4gDQo+ICAJc3Bpbl9sb2NrKCZvYmotPmlvbW11X2xvY2sp
Ow0KPiANCj4gLS0NCj4gMi40My4wDQoNClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92
IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg==
