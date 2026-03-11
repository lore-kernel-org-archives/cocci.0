Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312EF1049516
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=cyKspt4RQZA4WPrUM7YTnCuz9AcvIkjZ2vzIJ7xgo4Q=;
  b=qeZA5EVc0cWSXizwbyg5xxsTSsTeCQjiv5/p0TVs/6oarCG3jabGNaw0
   W0Z6lfTuCjA/Uo/bUX2Pf6O0nkaAj2dLhIcdMLj0jfvDKBT61EiDEL4+5
   nlRvKX0HJXAN0hw0AZinv3E5t043AkabS5mS26d1S9Anhx4CX+qoYUKnv
   U=;
X-CSE-ConnectionGUID: rB/Z48nyQKmzaArzt5rqsg==
X-CSE-MsgGUID: m4+8yBzfQKi9SsEkft/UGA==
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
   d="scan'208";a="267246490"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:43 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id B61AB818D1; Wed, 11 Mar 2026 10:46:43 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id A5D9F818AD
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 10:26:07 +0100 (CET)
X-CSE-ConnectionGUID: LgW0aVkERwCH8thudFLHZQ==
X-CSE-MsgGUID: ce5GEy4uT3yYInrmonAW4g==
IronPort-SDR: 69b1352e_RZLj7WRIcgErLx4bhS2e5NOh3JsuWKmFedKekjqg+QQn7ay
 KCAbdniN5N/k0TxbMwoA68ao9EQ1BeFTSscrY7Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EZAQAINLFpjwpBr8ZaHgEBCxIMQIFFC4FuU4FoMQRUh?=
 =?us-ascii?q?FiDTAOOJQOBE5tcgSuBQDUIAg8BAwELAQEuIAECBAEBAwSFAAIWjQ0CHgcBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBAQEBO?=
 =?us-ascii?q?QVJhk8NgmIBgSReBwk4AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQINXgEeA?=
 =?us-ascii?q?QEBAQMBEREEDQwBATcBCwQCAQgOAwQBAQMCJgICAiUKFQgIAgQBDQUIGoJgg?=
 =?us-ascii?q?iMBBkoDAQICoi8BgT0Ciip6fzOBAYIMAQEGBATeCQkJAQoBgQouhTyDFwEBg?=
 =?us-ascii?q?XCCSoEgARmEAHongWVDgRVCgjA4PoQKOxWDRDqCL4M0jE2GVglJeBwDWSwBV?=
 =?us-ascii?q?RMXCwcFYUIQMwMgCi8tAhQNEBIPBBYFLR1wDCcSDx0XFB9YGwcFEiEqB4FBe?=
 =?us-ascii?q?IFmGw+GaHkDLl4aDiICKBIDMgQjgQYLWgWCLAIcAwttPTcGDhsDBDp7BY1rP?=
 =?us-ascii?q?YIUHwEBgQ2BBz18GJcsr1YDBAOEHJlciDIXqmsuh2WQcyKodAIEAgQFAhABA?=
 =?us-ascii?q?QaBaDqBXHCDN08DGQ+OIQwNCRyDQo89AblsRTM8AgcLAQEDCYVGAQGMIjSBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:owTdJK58HIcMtAlZngPXwPTXdLJyesId70hD6qkDc20yTiX+rb
 HVoB17726OtN5yMEtNpTnkAsa9qBznhPxICOUqTNCftWrdyQ6VxeNZnOjfKlTbckWUnIM9tZ
 uIGJIOcOEYY2IK9PoSrDPId+rIH+PozJyV
X-Talos-CUID: 9a23:8bIf2mCXxAWCndz6Ew1oyxYdJMMISGL27CfMI1K0J0JJeoTAHA==
X-Talos-MUID: 9a23:ztgQQwjr5tdtwkQIlnTAFcMpP8o1zIm/VF0xyoQ3ms+eMCt2EgjBg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="141009608"
X-MGA-submission: =?us-ascii?q?MDFDDDs+Iobv4tIPbRRwIpeFETTBRNObNj6w46?=
 =?us-ascii?q?iqC+/JXm2XFECuInH7+K5mDaji2wj7WeuP/R3YL04lNWVp+rT7wX5eWe?=
 =?us-ascii?q?H7ybvJlV2U6DPFLdn03rA1sVk/h8LqDSCIezljRXI2aBKxoaz7+asWlQ?=
 =?us-ascii?q?RmPDWORu85NZvoTHyk259PmQ=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.10])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 10:26:06 +0100
X-CSE-ConnectionGUID: wT6QZs0cQTuIkzAX8kJ2gA==
X-CSE-MsgGUID: hAHwySxLSUyPX1Jiu8FXYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="91665794"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="91665794"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:26:04 -0700
X-CSE-ConnectionGUID: LFU5EhHeQjeumOwM0B7MyQ==
X-CSE-MsgGUID: OawEcd+9SG+7pZpl4N5cLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="216681025"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:26:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:26:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:26:01 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.69) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:26:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMnelAnsGLh5mEAtzesRCYmMt3dlbe/7+sd+j1vDC3YROHwbrIhkDxd0+Xx6utnKVfa7n+qBM+wqLN0qEEPQO6lKYauG+1KvJwdLax01tLZZyf6JlCkOMofD3uBMpzs/8oKmQ+5iezXjeMTLFwHwj0kKuhq2I3oW6mYy4zGql6QSi1jXDJbQz39PaIxZ8C1DZuOHA6n8/x45vRpqXGw0qjCJTSXqUACJEN1TWL7zVOWaxHNgKYcQv92836rDdTmPN3nBqNy/QBMTgcX4/d7CN3CwoCzED414/Wf9tP3MyPKL4cy7V9i/TbqYCu0lvC3nVnscZObE8DFPFZgRlcW69w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyKspt4RQZA4WPrUM7YTnCuz9AcvIkjZ2vzIJ7xgo4Q=;
 b=GjlIN/UTpN09nyoNrbsP4m2NtmQT1Ly+FkBlozActzyCraWzuD1nUyJEp+HrS0C20oJk9RcPus48mUW2MDELLubo9aYbyFccc2ANgYjdky85DPnEmsAmPwH2RM6cdLln4Zvl8ojQHxebSljiJVMWyIjnqRh3YDBqJIW9eTgQXioO1CVb2lIzRlLlfUEHbOSjfcY7aIlDwUgCOzhRVMb06PT+9Om6d3qoVamqsPLZarpxSv+Bv6MmevXseYp4id6ZEC9phqppcUUluELbRG7zZBemV4qyBjLO2vfMTrVJL3LsfwShmujm+CNPQzLbDBK/KxrpauxZLWRUoUirtW7YhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6836.namprd11.prod.outlook.com (2603:10b6:510:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 09:25:58 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:25:58 +0000
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
CC: Shuah Khan <skhan@linuxfoundation.org>, Kieran Bingham
	<kieran.bingham@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH 49/61] media: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Index: AQHcsKKJC7wOPu6zykS6DEkPokoDo7WpENMw
Date: Wed, 11 Mar 2026 09:25:58 +0000
Message-ID: <IA3PR11MB89861DF7C206BD634B477539E547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-49-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-49-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6836:EE_
x-ms-office365-filtering-correlation-id: c9ed382a-e59f-464c-640e-08de7f503440
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: +h66MB2j2vOXsLZaMH2Eb9pjjcM19YQTG6uM/bPbqnKJKI99df9KIqs9QYBEEAIR3WdzyLC4fz7DgIn9WnSe+EhbqCc6JwetdPXEJxaN+Z96UtWHQvrTThP76ftGAaGTJc5M2KLRc46RdmGHskO2Z+qarm3AyIUGfwOuiLpLsqiKjo4v+HlEYJtRYrhXc3owI7zaRzFeEftfpBZ+cz15SrWYjf/WJHFfXK3IX29T/vsLHaNWNNjGBvcE1Xoe41F1TUeO61BzemC0ghFCnrSpwfWZVQ2x7m6zs425wMWVfpok0Le/M/w+RG9Yd46JoLYYRxb5YRrVaT5iHv8NAsMCjHGsORvP0P/dL6wIgk4TT8s1Tmi2aU5w5zXdgT2N/bzSoaC4AouUEfMWGdEKuF6G049D/Kc/dM5FFvDvFS1rRdB/ZNNPmjTe72OyYvwyqdYJqyuVne+FaG4CsbbKsWuTHF2kz2Nflqalvzm9hgDWmj9qyyDIeyhr3YEeDjJ59bQ2tIeOWIK8BZ36OshnVjOdr2jgHJ+rmIzqnSGkEsUkRYSCo0xeEuMTVk1oxU1ntyKcshAuNRpOQAC9giFYrajphl+bvZmKk8SRmNfWVyb1VQwwvxU3RYcj52WRVJWNS2jut6tOSRuDYQmospdx7wp5f24zdMI2BAZeY5ydGrMcmhF4qWvGs71HYgjdMP6Mutx+2BBUa/Iz7S4yqHiagw4S5/lzQ2MwBhhpTiPgXyY4lewdvBLPHyuMt8Z0AwymRno43q/8w3tFcIoRg7dRI/w5p8lNNSoG9vd/liEKI5uiPYNsBn60fKJ4IUGT/9+sGc1B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SW54aFNRcDZSZURGMlo5UkhvN0RHSVpnZHlsTUJLZkM1a2YxTzVOa29xSVNE?=
 =?utf-8?B?UmcrbTZORk1ZV2h6QTlRdXpiK0lWS2VYZlFSbmlDMVF3ck9TdFczN2FYVjBl?=
 =?utf-8?B?MmpyUERHL0F1NG1nNDF2b2hRWktndWVvWjl5cXc4ZGJxY05NSUh4MmpoYzl2?=
 =?utf-8?B?c0JNNGp4V3NDdkYybGdMUllLZzBBWVRvWDFmMTRHeVVSL1MvSVl1ejV3UmRq?=
 =?utf-8?B?VmdkZG40OFhkdk8wMEpUMkNsR2ZpTkhtNVhtUzhBR1VSQ0VvcGxjNkl2a0Zm?=
 =?utf-8?B?bExiaGhVK1dDYVA2YkR0ZHRRQ1lnWEhaelJuZXFuZUtuS3prUU82OHMzay9O?=
 =?utf-8?B?K01BT3lqRjVhTmRTNlZjUllIc0hMUUdmUksxYS9aclhLV3cvWXBSbE5FQXlV?=
 =?utf-8?B?TElhYUNvZ001NEFraEhJZFpkL2ZDdEF4MkZoMCsvblpCNGg2K1BOVXVJdkkw?=
 =?utf-8?B?TitRSE9NU3IrZDhuNVpHdXZ0Kzg1TVdNYlVWTVRtbWFLMTJQUnJ1WFd2WmI2?=
 =?utf-8?B?T1REUTN6N24rNDdwc0x4U1VQdUxFeUdiT2h6bnUveEEwNEkzazZZWnl4VzQ5?=
 =?utf-8?B?UXpVblYxWE1SdE5PYzltbHo0WFFWdVNkM2xmN0xzcXhZKysvbC8xZUYvcDk0?=
 =?utf-8?B?OVhXWHU4UENwR3gwaHo5MXJsMjYxMmgyRkFFdzFQVXg1czFtcnJmdTUyNXF1?=
 =?utf-8?B?SkNHSUhCREVDdmw4UmhVVGlRZkxxWHcxdHB5WkhXaW84U3QzZ0hSQ09QM1lZ?=
 =?utf-8?B?eWZOd051SEVzTXFlNCtyRHpHUjhja29ZNzlGZnp4cmVFUkg2VGJWSFBJajJE?=
 =?utf-8?B?eitNZlFBTm1hOWdVODBnUWZDM1hFNkJhTmtGazhVbUpBM3c5UkFrZmE1emZ5?=
 =?utf-8?B?R0lZZEZJWWJZK0h6QVhISHhvOGx2N2tlRWFNWjNxQU80aGVYTTI2dzhxaE9N?=
 =?utf-8?B?a3RwVDJCMGhJcGpLUEVyTExsWlNiZkhLUjJOQTJwbG1WTlp2cWdsOEo4SCt5?=
 =?utf-8?B?WnhWMDhaRDFxWWFNMXArbG5TMlRuYkZyZTl6eFF0VHhqeXV2aC9RQVBTNUND?=
 =?utf-8?B?dEV0WUo4bEh0aFo0UXFyNEcyY3czaHladFpJTlJmTVRFNVhoREszVy9QWXhP?=
 =?utf-8?B?bEZGS3BVcklKdTFWZStIOHpxREpFTWNNeXZzVFFrQnZVenRXV1lLajhrbEpu?=
 =?utf-8?B?RjNpa3FQT3ZOVWVVY0w2emlmRGw3MUpxalYzOGk0RFMxQURuNU1rMG0yaGh5?=
 =?utf-8?B?MDY3WCs4N3RQOGJXRFZQRzhob2NFa3FNV0FaN1RHWmpzVGlBUysrTlorb2JT?=
 =?utf-8?B?MXZWNXprUDR0U3M5YmRZa3B4K0lKL1I1RVdrZ1hOVlVYNmdmdVJ2aFVmUzUz?=
 =?utf-8?B?Q29nV0pMWVE0OVI1UkhiSDIvK0paOTZma2RTVkdXL0hJNjNXaFBQZExMbUR4?=
 =?utf-8?B?cEg2b1hpRGtud3lDNFNCN0E4R3JzUmxaLzNoMkhUR3VUVDNzWE5aZmtQOS9U?=
 =?utf-8?B?a283Q0xHbTVtaktqbWZHWkVRK2JPMVJnek5BN3NXK1QzVDE4cnh1cXN1SitF?=
 =?utf-8?B?L2lvcExuYk9KbFNZY3VRbnVtN1F1UjBxWGZLTkNjK2lDTnYzY3NSRmFKT1NL?=
 =?utf-8?B?NFkrZTVMVGpjUHFLMnlocnNtYnpkaDhnM1h0K2w1L01FZXllOEs1bjFPd1lQ?=
 =?utf-8?B?Q0ZvSGFCU2FSTldLaTQ1WXRsaXhxM3BhSk4xeENhaU50cWhpSCt5TUpvVFFz?=
 =?utf-8?B?RDZEL1d2UGt5RStEWjhJL0JqQ1FFSEhBZ0RsU0wrYk1IdTljcVVhKzRJMWsr?=
 =?utf-8?B?UXorc3Q2NkRVcmQ5TXZuVnFKUE9LT0FDaE1IUUVndno3dHBjN0YzdHdPNVFv?=
 =?utf-8?B?Kyt6RWlya3UwVmdMQWR6QnluZnFuMjBPeDhrMFpoak94QW9JaytwTHdyeGRW?=
 =?utf-8?B?N0JlVkVoVXZHQ0xCL2NqaUxLSm51N0VVR2Jnck0zc1kwZU5ndkNyOEZEMkRq?=
 =?utf-8?B?WHJJK3kzL3RxNEl4MHM3OENsdHJjeTYzYiszWVNrSWJKS0U3SWI3L3c1ZE1M?=
 =?utf-8?B?RzJNMzNwdjJoK0ZhTW1DbytmN0V1VUhYT2dGSWtXYUdOWWdiNWQxRytOQmZR?=
 =?utf-8?B?cTF2Vk4xVTc3dk5yR3BRQ0xxbmp5UStlMXh0YWdvdWdObnRua2lvMUI0Y0NF?=
 =?utf-8?B?cGl5aUs0NnZBTlJZdk5JeGtjWGM1bTlIemhCbG1HbUVPb252ZUhOeVBWLzdK?=
 =?utf-8?B?TDl2emN5Nm9ydlpUS0pEbmU2dmJVUDNod0dSalgyU29kSmhLUXI3VnpXQVRV?=
 =?utf-8?B?aVBQUFg0Z3VVL2h0RGlod1Q0ZFJWcy9wQThxZUZGL0R4UzlLZFpUVFJHaDNV?=
 =?utf-8?Q?S0CYujZn+ePJQXsw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SQZePNg7nKAAbDqMZ7dW1KHZ0FFwuCn1Jt76oEzgegnF5SJgaGKEma+2Ac/wYI7p91qOK6NWHvlqijxMpvA1Xza0Jp4lz2KSWF/jDCkOBRpYZfPPob7+/x1rDy3YvjVepeutrQse19LJjPl3wgjksdB6NxWPkcJdKbdr6UtWEumlUyob+dvC7YmHtdOqYRVglVtCv7xN/s/kOoRo7wbnCqfz8YpnB2EAV5EegXbPvG9BeGRclUz1aOXpzB1+3hzmIim2BIiLVIznk4NiitZnWOlJPFzUCAVHh7vcsc5I+DmmrWO2DMt/V/STYZrYLvvBzUlSimeefDhCGuunhuIZNg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ed382a-e59f-464c-640e-08de7f503440
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:25:58.3602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HjZdscLZqaiMLL5IiMuiPhMYno2isL9hRuKVDLo/kqTRKMwOrvrBMcD4bI+ntSh9gHqWiFjs9lRHrj3mUdYG1LDTIMXboOJ3d8OYEwoCxpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6836
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [Intel-wired-lan] [PATCH 49/61] media: Prefer
 IS_ERR_OR_NULL over manual NULL check
Reply-To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 3410
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/aPucqhkSNrd18Pa8rzOcpg>

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
bS5kZT4NCj4gQ2M6IFNodWFoIEtoYW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBLaWVy
YW4gQmluZ2hhbQ0KPiA8a2llcmFuLmJpbmdoYW1AaWRlYXNvbmJvYXJkLmNvbT47IE1hdXJvIENh
cnZhbGhvIENoZWhhYg0KPiA8bWNoZWhhYkBrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBbSW50ZWwt
d2lyZWQtbGFuXSBbUEFUQ0ggNDkvNjFdIG1lZGlhOiBQcmVmZXIgSVNfRVJSX09SX05VTEwNCj4g
b3ZlciBtYW51YWwgTlVMTCBjaGVjaw0KPiANCj4gUHJlZmVyIHVzaW5nIElTX0VSUl9PUl9OVUxM
KCkgb3ZlciB1c2luZyBJU19FUlIoKSBhbmQgYSBtYW51YWwgTlVMTA0KPiBjaGVjay4NCj4gDQo+
IENoYW5nZSBnZW5lcmF0ZWQgd2l0aCBjb2NjaW5lbGxlLg0KPiANCj4gVG86IFNodWFoIEtoYW4g
PHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IFRvOiBLaWVyYW4gQmluZ2hhbSA8a2llcmFu
LmJpbmdoYW1AaWRlYXNvbmJvYXJkLmNvbT4NCj4gVG86IE1hdXJvIENhcnZhbGhvIENoZWhhYiA8
bWNoZWhhYkBrZXJuZWwub3JnPg0KPiBDYzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnDQo+
IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxp
cHAgSGFobiA8cGhhaG4tb3NzQGF2bS5kZT4NCj4gLS0tDQo+ICBkcml2ZXJzL21lZGlhL3Rlc3Qt
ZHJpdmVycy92aW1jL3ZpbWMtc3RyZWFtZXIuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bWVkaWEvdGVzdC1kcml2ZXJzL3ZpbWMvdmltYy1zdHJlYW1lci5jDQo+IGIvZHJpdmVycy9tZWRp
YS90ZXN0LWRyaXZlcnMvdmltYy92aW1jLXN0cmVhbWVyLmMNCj4gaW5kZXgNCj4gMTVkODYzZjk3
Y2JmOTZiN2NhN2ZiZjNkN2I2YjZlYzM5ZmNjOGFlMy4uZGE1YWNhNTBiY2I0OTkwYzA2ZjI4ZTVh
ODgzZQ0KPiBiMzk4NjA2OTkxZTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWVkaWEvdGVzdC1k
cml2ZXJzL3ZpbWMvdmltYy1zdHJlYW1lci5jDQo+ICsrKyBiL2RyaXZlcnMvbWVkaWEvdGVzdC1k
cml2ZXJzL3ZpbWMvdmltYy1zdHJlYW1lci5jDQo+IEBAIC0xNjcsNyArMTY3LDcgQEAgc3RhdGlj
IGludCB2aW1jX3N0cmVhbWVyX3RocmVhZCh2b2lkICpkYXRhKQ0KPiAgCQlmb3IgKGkgPSBzdHJl
YW0tPnBpcGVfc2l6ZSAtIDE7IGkgPj0gMDsgaS0tKSB7DQo+ICAJCQlmcmFtZSA9IHN0cmVhbS0+
dmVkX3BpcGVsaW5lW2ldLT5wcm9jZXNzX2ZyYW1lKA0KPiAgCQkJCQlzdHJlYW0tPnZlZF9waXBl
bGluZVtpXSwgZnJhbWUpOw0KPiAtCQkJaWYgKCFmcmFtZSB8fCBJU19FUlIoZnJhbWUpKQ0KPiAr
CQkJaWYgKElTX0VSUl9PUl9OVUxMKGZyYW1lKSkNCj4gIAkJCQlicmVhazsNCj4gIAkJfQ0KPiAg
CQkvL3dhaXQgZm9yIDYwaHoNCj4gDQo+IC0tDQo+IDIuNDMuMA0KDQpSZXZpZXdlZC1ieTogQWxl
a3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo=
