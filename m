Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062D81049523
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/ef+jK0YkTsaCNho9PZIEWOi4UpNIRGBY/ukEGrwSAI=;
  b=rADUbssI1wGRLlxsCwNndLvqWSMFCtoS3dtR2lUI7PpkMQ5JNfKviitA
   8C5QRmIxrsS7IjrFVcfBNNO5JACtk1r/fCqCtszZRRjaeD0cwmNSem1GI
   ZbuC9LHoFnhgRl4g4WjqUb2MHBU0JJNEBVZo/M9cEZXGkXQCi7qvCoRoD
   8=;
X-CSE-ConnectionGUID: rhkLozUARkS8/NDI8UMy3w==
X-CSE-MsgGUID: JnIMDW+aSzy4I8EReyALDA==
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
   d="scan'208";a="267246037"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:23 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id AD556818D5; Wed, 11 Mar 2026 10:46:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 18186800CB
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 09:19:36 +0100 (CET)
X-CSE-ConnectionGUID: tFg3nnqJRquamZxhVEeNag==
X-CSE-MsgGUID: 4/NmPyQ5QgW3jnrjhvCZDg==
IronPort-SDR: 69b12599_I1digmvpGQp+YuqCstJ6kWZFy+Mno4pLxY7V88GhK2fi6wj
 waoXzwQ6wyWFRu8zexzEs91XyvNBtOKWJSQrX3w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EZAQDQJLFpjw5Br8ZaHgEBCxIMQIFFC4FuU4FoMQRUh?=
 =?us-ascii?q?FiDTAOOJQOBE5tcgSuBQDMKAg8BAwELAQEuIAECBAEBAwSFAAIWjQ0CHgcBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBAQEBO?=
 =?us-ascii?q?QUOO4ZPDYJiAYEkXgcJOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BH?=
 =?us-ascii?q?gEBAQEDARERBA0MAQE3AQsEAgEIDgMEAQEDAiYCAgIlChUICAIEAQ0FCBqCY?=
 =?us-ascii?q?IIjAQZKAwECAqFwAYE9Aooqen8zgQGCDAEBBgQE3gkJCQEKAYEKLoU8gxcBA?=
 =?us-ascii?q?YFwgkqBIAEZhAB6J4FlQ4EVQoIwOD6ECjsVg0Q6gi+DNIxNhlYJSXgcA1ksA?=
 =?us-ascii?q?VUTFwsHBWFCEDMDIAovLQIUDRASDwQWBS0dcAwnEg8dFxQfWBsHBRIhKgeBQ?=
 =?us-ascii?q?XiBZhsPhmh5Ay5eGg4iAigSAzIEI4EGC1oFgiwCHAMLbT03Bg4bAwQ6ewWNa?=
 =?us-ascii?q?z2CFB8BAYENgQc9fBiXLK9WAwQDhByZXIgyF6prLodlkHMiqHQCBAIEBQIQA?=
 =?us-ascii?q?QEGgWg6gVxwgzdPAxkPjiEMDQkcg0KPPQG5cEUzPAIHCwEBAwmFRgEBjCI0g?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 t3SRDNKNBgRlgiovfkxDBoPk+tf6iEz1g/FGwEU
IronPort-HdrOrdr: A9a23:2zZHbKEPhNiUJ3tTpLqFkpHXdLJyesId70hD6qkvc3Zom52j/P
 xGws5y6faUskdjZJhEo6HiBEDuewK6yXcY2/hoAV7AZniBhILLFvAc0WKK+VSMdxEW2dQtsZ
 uIGJIOceEYY2IK9vrS0U2RNusN+/2m1IyW3tHfyB5WPHNXQpAlxxxiBgHeKUFuQhJabKBJaa
 a0145uvCCtfjArdcy6AXkDUYH41qH2fNqPW29iO/ZsgDP+7w9BgdTBYmKlNvd3aUIw/V50yx
 m0ryXJop6utPmnxgSZ/WfO9Zg+orXc4+oGP8CKgtUYMXHXgACyaO1aNIGqjXQPrOam9Vow1O
 PBuAgtJON673+5RBDFnTLdnzLt1z4y52Sn80aRhRLYwPDRdXYBB8BcgYpYd1/Y5iMb3O1B7A
 ==
X-Talos-CUID: 9a23:FmhlRGDD9SR7kAb6EzVJ+xUSHNkHSGTAxXLiM0+GJGtPQbLAHA==
X-Talos-MUID: 9a23:RFafmApe41uy2f+TTw8ez20lEsJQ8p3zMU8yypcAocuEKwdCFzjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267220736"
X-MGA-submission: =?us-ascii?q?MDEQ5ujpksHYFpgQ1XibvdD4vNEr2qEdL/ijw+?=
 =?us-ascii?q?cDoMF8Pd839txwsXkDMUJI9kYcv6L0kvYVhJvbzwyqtnX+yiD4WTlGMV?=
 =?us-ascii?q?QFDP++FwuD0XQVlpuz55VnnCrVWt74pJP1v0CYosSgHz2uyDiy+hy/YL?=
 =?us-ascii?q?AbvzmhZ/3WbpfXuK3oFA+JBw=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 09:19:36 +0100
X-CSE-ConnectionGUID: w+zHMa1mTHWL6Lls0xLT+Q==
X-CSE-MsgGUID: gdwqVRTaSduomzaYbXEQuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="78133105"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="78133105"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:19:33 -0700
X-CSE-ConnectionGUID: 5S9cH0XpR8WSgUZGhQWMXg==
X-CSE-MsgGUID: vsD02ZUFQyedQpUuP67l8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="216669451"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:19:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 01:19:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 01:19:30 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.67) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 01:19:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6x7DOxwYL2URrNljXUye9/pkkJEgGvMluK0lJvrxOuC0xbXj7FAX30FaacLX8YhZ0OPHvObfLJMQO/2SN+g35yiqaoD0NRLoUjVpE+2Q20auqMH/3eN8vNqeXNA0qqon9XPsaIe92fDZVh+Mg1UkmBsd9SsRDy4gIp0tNH66nGK1sHczu/E46/iEpMu3OTnw5VrTffX0fgcASGq/Ie7EXqV/nMY/jUbQKm5RmjvL6qjRWcWKx6ViJTBK/cyTXPT4S2tdWggG498XtLIIpii+AJvy2fTLtiYSBf15Q9eG3T+Ca0gqQjmJsGaeiN50sqItyfsZKYw9iiBzpM1lzZGkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ef+jK0YkTsaCNho9PZIEWOi4UpNIRGBY/ukEGrwSAI=;
 b=H0VSauvRFB1tI8e0jq/4o+oqrWBjsBXRh7ExZegW3lLMuyS/pJ8v4XumtQgojS1iLuwQTGOV+prn9tIE9yLvCiPKb0LgzbgzTM91/8bsXzhSMk92RR9XdGex53qyRcZXOcTP8vXLmFmQINKNoLGDVP5PXaQO/TMnuutqnu9OmCV1ulxV7byf9gzFy0GUcZG79usH9ZV1Iv++LyV/eXJAJeavY0sG/e2QjPhRrgpLP4eMPT0EII6zOos+2wm5EvsoXAp/yqRiVl/sKShbUTDOq+/0mmlp5E5Wj0FJ/f3VGv3eIPxXujghHwmOa0nhwqTjYIAM2NmfqC6EEZaXDgxY6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV8PR11MB8510.namprd11.prod.outlook.com (2603:10b6:408:1e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 08:19:22 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 08:19:22 +0000
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
CC: Phillip Lougher <phillip@squashfs.org.uk>
Thread-Topic: [Intel-wired-lan] [PATCH 13/61] squashfs: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Index: AQHcsKKX2fg+jweOV02/w33fa6lR77Wo/jSg
Date: Wed, 11 Mar 2026 08:19:22 +0000
Message-ID: <IA3PR11MB89862A758B9D064ED69DDEFAE547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-13-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-13-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV8PR11MB8510:EE_
x-ms-office365-filtering-correlation-id: e8b0c821-2d3f-4cc9-93af-08de7f46e668
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021|921020|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: hyIuLUdmPyLzFfo/AMlIgUhhPpxXs27MqgAcsjs3Lri9dZWGQ5+fJQ1xWd8ZICk+wRis9iHYgsfZNVJ7jkWWDmFCNCV8kgbZKJlJfRNFyAspZsHjUK8GuRP2mfAL52msAf5GSElgzxcXii8zigcZ2ryUL7j8/4SNLIl5VyYkLT1yroOARCGG/WEyuf4tG/uc2H3MEDJhclHNB0LS7X6mxBbL5fB9NvyIP4lyNKMBwNKVFM3Mjaf+9wFkQBlnfH/Iix3qoDyr0Db1QFfhi/8Tab8b3B1mrEdPW85Kxuriria1pFrWGRUraaG6oRMtPONRUwJnepMR0AWDZSDUF9rzHGvvg5owyPeXf9trGZR2wey3G3QSzs216LtP6d955vO8Msnp92wZz174C+XkIsNGJCupjXktimz09COEuUYxgEwEVnxrAU/iX+PUqnoLZJolB97WMvzkGwqGt0NDJfKP5Y9eqiVm4RUn7IVxfXSvypR+l+Br036/OsOWsR0WvlwkZ7HZQmZwEOIGhD6MEQQIVSgYUhE5yDNKNX1tpNmVNxzMy+dB9deYm2IYTdcC0Ugc/mJu36P8u3i1vhrRrRtXVxmaeREovrXHsz/DzvxYsAWq/oBYKm2+FhLXVAyqOyF5qH/bLfCZijH0D1Bv4+iOy0u7ONlVBTxbOr5Y9JwqqH9p7jkhWALVMfPuloIvXuVs1JpzFIWvYpe755VYqBYIpVEaNwBvF9ONxe7vaRpvSfgCEtGZ+lgB7Cj2x5eqwIAqFLvGI1zZ1oGsiYpofTLbJlkPqlbZe1keXc5yayewRg43f8P95QMeCWPzC5G7dys2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWRZSndyN3p6MVJLdm8wQWtCdUs5MzFPRTJMOUFSK1hTVGFzM3phb0d3cyto?=
 =?utf-8?B?bU9zV2k5UlJNUVVCZzFhd2gvdEpicW95VFFqY1pxcTRCNjU5ZzNKRWtQMktN?=
 =?utf-8?B?MFl6ai8xbUR2Y3I2SjlwRmQ3aXNDTXZRNmZ5eWo5b0dndEI5eG1NNXZxYzg5?=
 =?utf-8?B?Szl1U0MvTit4bkRMeW5WZmZlYkQrRzVBVjZocnVqQytGY3RFVmVnNkVwTity?=
 =?utf-8?B?NE00YTNXYjAydXZtQ3I3NFE2MnNlZ2pxb3U2MmkwcC9haUk2ZGZlbEZFMWl2?=
 =?utf-8?B?eHRuaDlzU1ZGUWg1UlhlaXcvZnZNZTZISVdCSUgrMVB3eGt3MGhjUGxjZ05i?=
 =?utf-8?B?a25ZNmR6bDBOenBaaHhvcDVSdWRFb0k5MWRML1VTZlVwRkhRTE5Idk1rN3lD?=
 =?utf-8?B?MndNazNEbFo5UXRiQ3FOcFRqUXl3ZE5lOUdKWUo3Y1VVVEFodXowMUFXNWl3?=
 =?utf-8?B?bG16S1pGMjdJNzBmd2U3a3BvS3Y3b1FrMkcrcEJIY2o1QUYxbDRseFZ6bS9n?=
 =?utf-8?B?UkxJWnoxMXBETlRlaGpjR1J2d2NwYkdYejZMSDEzY1lrQzRkSllpeVE1TmYr?=
 =?utf-8?B?bWd3RWh6MHhLM1dYblFaNkNsTnNoQUs2eThTZUs3dGJRUlkvUUxwcEg0WUZs?=
 =?utf-8?B?Sm0vMWxIUExwV2tjR1dxMlROZkJnTWxVWisxK0V2SHZtU3Mrb1gzRVF0aDhL?=
 =?utf-8?B?ZTdtSUh4cS9zbFpjeFF4OW03U3NsV1FUcmdZRjRHWWlMK0ZKVnRrd2ZSVUpw?=
 =?utf-8?B?bGlJWUN3TnhVOE9iZzNMT3RWRE1OR2xES1dZcDJ6alBmOGxMcTg5QittRUha?=
 =?utf-8?B?UXVCS1Nka2wrM2NKcFVLaXc4OEgyUzhVRU1ydGJkMXp1V2RQdGc4NGUvdUI1?=
 =?utf-8?B?d3ZMdWFpREdIdUxHSEtlSXgzazV0eG52QjY0QTdaNXRKam4vWGdvcTNPeDhQ?=
 =?utf-8?B?alVQQTlhYnRkMWE4ZGlQYnUyUm16N2hpaVdRbGNEVUZXakhDR1NkcVhtSjhl?=
 =?utf-8?B?QzkzajRsYlZEQ0JyV25USVpzMG5hSHRQMFpWWi9KMXBMSEVRbjQvTU1pUlJl?=
 =?utf-8?B?SDFHOElpemRwUUF4NjN0dkhhYitKRUNKWmh0VkhJRDRzTUpnMGRsZzdmU0RT?=
 =?utf-8?B?WVlNSi9HaDZRVnQ5Nnp1aWFFcGZFUVQ2aG43d2lMWHlhdFJlUEYvVlBybTBG?=
 =?utf-8?B?cVdkMmg2aVNkSzg2azBLSXRkWjJ4cXJsN3g2Wk1hTmhxODhscStUMC9QbUs5?=
 =?utf-8?B?TFNhRTg0bXo4ckh5ajRQVmd3ZERrelByN28yRm9GRFBTSUhnZ0tHZ0FyOWxw?=
 =?utf-8?B?MGV4ckdXaTFVdmRpbTBsNHNycGN1a20rU09MRWJibXVCYXhWanQxZ3gyaml1?=
 =?utf-8?B?YnYyMWtrQXhDaXBBWm85eERWOXloRUQ0RU16M0dhRFZucmJyZm9qWC8zdTBL?=
 =?utf-8?B?MUZaM3dCSE16a3lxcjVSeGFCdUo3M1RaSUxzTnJ6MVFiUUpWYXltSFhsN2dD?=
 =?utf-8?B?YWdTZ2R2VVR5KzlVRGZCVkZJVm9IU0poOFhaVm1pOTBzUThmak5aUmlNMERz?=
 =?utf-8?B?aEVnS1FqZEFDMGo5dE9VaG5RUFBhZEp1M0cvdWllaytEVFU3WUgrTnBFQlRN?=
 =?utf-8?B?MXNiVXljL0JIQ1BRVkJKTUZrakprM0Y3TnB1Rmw0YzBLdTNCTEpGb0IrSnkw?=
 =?utf-8?B?OE10NlZHS1BoLzVmQ0ZKdlRjWXg5WWRpY09hT3pURVlPQldSaXd1ZDlpUXU5?=
 =?utf-8?B?MjFFT2RCMDEzUXA0L2V3VmpmZTA4RURUOG5heFQ3dlBoKzFTbnFvRXcvNGE3?=
 =?utf-8?B?RDJTbHdPV2ZDWU5MYXhaTTMvQ1RQUmJveXVraWoydjFjSGhranJWVmJHYUFN?=
 =?utf-8?B?ajNYRm1UaEo3MHdqSFJFcjc1Qlp2eFE1bGRHUWhiRzg5V25RU0RGWDVGeVhj?=
 =?utf-8?B?d0hMeG90Ylo0aE5MSkUrZUtDMU5QTTBheDVVZndEeGdYcTlCbGVLa3VTRFNL?=
 =?utf-8?B?TFcxZTBpMVFxRmF3dVpjZnVkRnozUUQydnBuem4vUkpSQ2xYMUhLTDZvazlv?=
 =?utf-8?B?SWdhNGtudFhKZStXaWFERXNlQWtMTnJJNU51WnZKb05HNHJPSU9UeWQ3TXE0?=
 =?utf-8?B?bDREektPd2grVHUwU2YyTXhWNzZKeXdwQnU3YjdJKzJ5dlJmbkhwdHJ0MHli?=
 =?utf-8?B?V09CQjZ5UDh5ZUwrZkFiN0R6VGNJWWtLbkx6WFRHRlZJZEpkb3h0YWtuTmtE?=
 =?utf-8?B?NWk1L0s0WG16OVZnTGJ6cEZhNW5HU3NtWGVSU3Q4Q3R4ZEs5KzdZajZzZnBp?=
 =?utf-8?B?cU1zMHVWZjBMbGM2eGdDYXp5MmlId2ZINlFmQ1N2Tm1jUHo0bWJ2b2xVd2dF?=
 =?utf-8?Q?qzpiEgWXQIGOWACY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: P0Tryjjgi7r5Sa0dlJeJhxUWOQBz8cPKEFEztYoIPr4G9+CoOlxKVru1o9mOIJtLJTY8Te8NA1zDRylwrIJ8bEp9UvPbQY3P7wrnmq41gcDMf0KideWh7G3rBfeh4eusiMFtOni/PI1ZCcuU7kkjtwBleS6siQ0a1Rv86ZTPBRp2FdISTmJLmkDC7KRDl3GmMiwpkTbJFJ7/0QuSkCIUlmrscye0PIOC9mWlgNEE1LMhsArZCWgtD7EsRjD0lmgKJ46qBspyG8JcAnk7wYrD57fKY38r2tUvYJA9hM+vSpC0o+LODVBGEyovjgeGID60S25IUFIu1VtmqFyYsdFWGA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b0c821-2d3f-4cc9-93af-08de7f46e668
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 08:19:22.2770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v/8DqgpKLoEvRkW7zxyEgNR2f6Ove8R3jDy9/Bed5FvhwcoXhnWgJFh0D0pbQpAo9gEO552WAVc460NALCUO8gCA2vIi8cOsqM+scnMQn2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8510
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [Intel-wired-lan] [PATCH 13/61] squashfs: Prefer
 IS_ERR_OR_NULL over manual NULL check
Reply-To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 3398
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/JacTIM9uilrWsrhxRK0l2w>

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
bS5kZT4NCj4gQ2M6IFBoaWxsaXAgTG91Z2hlciA8cGhpbGxpcEBzcXVhc2hmcy5vcmcudWs+DQo+
IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCAxMy82MV0gc3F1YXNoZnM6IFByZWZl
cg0KPiBJU19FUlJfT1JfTlVMTCBvdmVyIG1hbnVhbCBOVUxMIGNoZWNrDQo+IA0KPiBQcmVmZXIg
dXNpbmcgSVNfRVJSX09SX05VTEwoKSBvdmVyIHVzaW5nIElTX0VSUigpIGFuZCBhIG1hbnVhbCBO
VUxMDQo+IGNoZWNrLg0KPiANCj4gQ2hhbmdlIGdlbmVyYXRlZCB3aXRoIGNvY2NpbmVsbGUuDQo+
IA0KPiBUbzogUGhpbGxpcCBMb3VnaGVyIDxwaGlsbGlwQHNxdWFzaGZzLm9yZy51az4NCj4gQ2M6
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcCBI
YWhuIDxwaGFobi1vc3NAYXZtLmRlPg0KPiAtLS0NCj4gIGZzL3NxdWFzaGZzL2NhY2hlLmMgfCAy
ICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9mcy9zcXVhc2hmcy9jYWNoZS5jIGIvZnMvc3F1YXNoZnMvY2FjaGUu
YyBpbmRleA0KPiA2N2FiZDRkZmYyMjIyMzVlNzVkOGMyYjEwZDVlOWI4MTFkNmUzOGQ4Li44ODg4
Y2MwMjk2NmUyZTMzMjEwYzg3MmM3MzMyDQo+IDA1ZDRjNTgxZWNjOSAxMDA2NDQNCj4gLS0tIGEv
ZnMvc3F1YXNoZnMvY2FjaGUuYw0KPiArKysgYi9mcy9zcXVhc2hmcy9jYWNoZS5jDQo+IEBAIC0x
OTgsNyArMTk4LDcgQEAgdm9pZCBzcXVhc2hmc19jYWNoZV9kZWxldGUoc3RydWN0IHNxdWFzaGZz
X2NhY2hlDQo+ICpjYWNoZSkgIHsNCj4gIAlpbnQgaSwgajsNCj4gDQo+IC0JaWYgKElTX0VSUihj
YWNoZSkgfHwgY2FjaGUgPT0gTlVMTCkNCj4gKwlpZiAoSVNfRVJSX09SX05VTEwoY2FjaGUpKQ0K
PiAgCQlyZXR1cm47DQo+IA0KPiAgCWZvciAoaSA9IDA7IGkgPCBjYWNoZS0+ZW50cmllczsgaSsr
KSB7DQo+IA0KPiAtLQ0KPiAyLjQzLjANCg0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9u
b3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0K
