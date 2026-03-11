Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E551049521
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=m4nrxJrptq9qjGF+s6HBpmfa9vqvfEDymQUIf7o+O44=;
  b=Z6hwaRH7sok7bwHCIHYlQzFRg0dy04PPT3WtayAnAQaCGLFp2aeS9IH2
   zMBENsogrl2OgBa8KWPrjWGx6SUgtXtxc6avD1YlS/noun4BR6WgXIrrD
   jERKS2CQdIqDlECVqDQ0CjmFeb+cICERZm7DpSRXbNs7f8IPK+FonuexG
   U=;
X-CSE-ConnectionGUID: bY2SgMnJRWewuemomXCEpw==
X-CSE-MsgGUID: tRqsi5oHT6SspMFmX/5Ezg==
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
   d="scan'208";a="267246569"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:47 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 9539D818D1; Wed, 11 Mar 2026 10:46:47 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 3148F818A8
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 10:26:45 +0100 (CET)
X-CSE-ConnectionGUID: PsKR5QWVTzq+cMAJch5Diw==
X-CSE-MsgGUID: W4ZltrQOTLeiDXQel9Bs+w==
IronPort-SDR: 69b13554_kioTPL0L0mFAII7uJkGKB+aO78t/VOYXtU9OZEXoagNpsmV
 5Cq+pUZXrmj3HxI1xrtYzVQ4anXFxaCMNjvLnRw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ETAAAINLFpjwxBr8ZaHQEBAQEJARIBBQUBQIE8CAELA?=
 =?us-ascii?q?YFtU4FoMQRUhFiDTAOETYlYA4ETm1yBK4FANQgCDwEDAQsBAS4gAQIEAQEDB?=
 =?us-ascii?q?IUAAhaNDQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQEBAQE5BQ47hk8NgmIBgSReBwk4AQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEQINXgEBHQEBAQEDARERBA0MAQE3AQsEAgEIDgMEAQEDAiYCAgIlC?=
 =?us-ascii?q?hUICAIEAQ0FCBqCYIIjAQZKAwECAqIvAYE9Aooqen8zgQGCDAEBBgQE3gkJC?=
 =?us-ascii?q?QEKAYEKLgGFO4MXAQGBcIJKgSABGYQAeieBZUOBFUKCMDg+hAo7FYNEOoIvg?=
 =?us-ascii?q?zSMTYZWCUl4HANZLAFVExcLBwVhQhAzAyAKLy0CFA0QEg8EFgUtHXAMJxIPH?=
 =?us-ascii?q?RcUH1gbBwUSISoHgUF4gWYbD4ZoeQMuXhoOIgIoEgMyBCOBBgtaBYIsAhwDC?=
 =?us-ascii?q?209NwYOGwMEOnsFjWs9ghQfAQGBDYEHPXwYlyyMJ6MvAwQDhByZXIgyF6prL?=
 =?us-ascii?q?odlkHMiqHQCBAIEBQIQAQEGgWg6gVxwgzdPAxkPjiEZJYNCjz0BuWxFMzwCB?=
 =?us-ascii?q?wsBAQMJhUYBAYwiNIFLAQE?=
IronPort-PHdr: A9a23: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
 A==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:9dwcnqhHEPFNl01sjI9UHsvd2XBQXuYji2hC6mlwRA09TyXqrb
 HJoB19726PtN9xYgBapTjjUJPtfZq4z/FICOYqTNWftWXdyQyVxeJZnO7fKl/bak7DH4dmvM
 8KGcUeaOEYZmIK9foSjjPIaurIjOP3lJxAWt2x80tQ
X-Talos-CUID: =?us-ascii?q?9a23=3AoWoWm2mydwrck6ndejbedM6WQtHXOUXG702NGnC?=
 =?us-ascii?q?GNXRwC7awYH2b+P5IktU7zg=3D=3D?=
X-Talos-MUID: 9a23:xgixawm3t5USEYSVRI72dnpdaPVs/76XL3wpnJQqi/CJMX1aIHSC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="141009774"
X-MGA-submission: =?us-ascii?q?MDGOOvcjElteE2a6nQ3XvVOpROsLnoYKVN9LU4?=
 =?us-ascii?q?QYgGddIZUSj5GQIotHQU1jnviBuuAVVR8x1dvyZ1A7h2dfRzwaLvD8Wp?=
 =?us-ascii?q?CnsOBnUeHTho0f0iLjSJM4DGrRhaXa0gM2mhjmJQDK8ndc6zzvjSlXmr?=
 =?us-ascii?q?fbm1P7lgoXY0Lxcka7zMUm1w=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 10:26:43 +0100
X-CSE-ConnectionGUID: ypwDu55gTwqMNku8l6bXPQ==
X-CSE-MsgGUID: bCdpDBGjQSmUYz4I5JDBig==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85760881"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="85760881"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:26:42 -0700
X-CSE-ConnectionGUID: 0Mvc00UjTyaR49tMurlA5w==
X-CSE-MsgGUID: 6g3dkHLDRdOJkiETBGMAMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="225103701"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:26:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:26:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:26:40 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:26:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIUmwbqBuCkYAHr/gwuMT/vbVyoJqHWc0S7qGkZSE95vriQ1cF1TkGN+a1PULfHbuDyi5DzAqAQ/PNHLIftR7JWBOHqHHT+jY93nxY5ZTaryKln3OoABQnwzl4ngeCG392k2OZCcRE+72NiuMFZgNGV9NuZjzzgtAKJSUl8jY6DJFEy1qNBSO6tQzZgbmelQ97j6UITzZy/WF4mr3LqAeRRhIoK91Gf/AWW++ljiOXiNYHRS0xvC/qW3hLE7seWkIxqqC0ez1Gs6saFyjGmdUV0qDNucOah0DJC0PY+O1yBivIsQu9Rd0Je4acivVundufd1+gxOD6g6HHhdSMq7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4nrxJrptq9qjGF+s6HBpmfa9vqvfEDymQUIf7o+O44=;
 b=aBxZmB6sbegqcdGoKmtlZAOcsGRPJoNprfagE+h604gJAqAH4K6+KucWi6/tq0TarS5X5ug6WwI+Si+VnXJZGApS0Hp/He0BJm3O4i23WnRjIVWfT9fxBljBNaC9feFMVULojEpaixsil7zHJjzk/0Ei5rAY1WtxxlD9gS77inUNlktnOneLWplQNQV5pzR1G/7mz7TJdxJYLzt+Mj/x0RU8p5JaYh9hVbgYF9ieJV6cDINYiTVfqLAr/y19QYfhTWGVROS2hV99XVvqL7Clf7EilkoyJs2OW80ipPvFVFHkn71YZyTAVFDtCuAtCu+i3Ictw5nF52YGMajqU7oSAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6836.namprd11.prod.outlook.com (2603:10b6:510:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 09:26:37 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:26:37 +0000
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
CC: Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>
Thread-Topic: [Intel-wired-lan] [PATCH 54/61] aoe: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Index: AQHcsKKXHKPQgNOZaE+8HrFfa/02l7WpEP8g
Date: Wed, 11 Mar 2026 09:26:37 +0000
Message-ID: <IA3PR11MB898643D5101D44C2BF0A8D7AE547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-54-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-54-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6836:EE_
x-ms-office365-filtering-correlation-id: 3b137b1f-021b-47d3-320e-08de7f504b55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: o9Bm9SPj2ErETACCCJiV1KvRnwRIZWxKp+r2VpCYTLVSrVoOXKHBBMTgWhVUDs2sANIccdbYTu+T62K218GKzN/aip0x72lnux++4JYJqlvh/+DLcxp1aRL+nnl8drAmndk+uoEKXHbjsrmbxKSpxxtM0yAgWpm+ZH5fdEYrQDmjD+U4clF8ZOIY5tdrP8KIkZKPgKHDF2WIQQw3kM6Neq/s19XJeWxmLprxLY7WEQtHIOBisCCjbPmMtmC0XeWKtE2QvujQvu1eudnbidCG6Owrkwkt7IMubEScD7/tiO4a6J8CaXb0tAJspoNXvqrDgBUuAlK6Zij7190dQ21EDY6HvvYrMZdBFum7HkCJ9c9euTvZsC4ESkWBnQwF4/dMWbNVJfHpB8DflELVEpkeDQ3x8Owrq/PTdR3oVwE/JTiZsKFpMvcfjloKUoUgBGjl7cK2eIKjQt6wm7RK6bMDB/1ajwKu+THF+Tg7TIUaB4p7dgM/iryDIosZN5plS1kAqVRyOkEiLAsO6f8ZbiVin+ueU3v211dxC7q+ylCyK3oioWwnNTn0243NE68MUoYZWMHZ5epFt6wq4t7JkSduO6Do/5LSsY9ynWsZnf5QwMmxXVPHYAa35TzmlVv/VQNApQGohJL/bIxrZD1Yl5/NbczocEPnIKZvTZsiZ0x0q0VZUEhP0bHuYPfQD0hUytJsjfviNaEYaOdc2HXjOuGQN4ezE9KU9/LVQB7y+Fu6Rvw+ygYyNvS5uRaazOasfnSyLhp3xd9l9KeyWCukEDFSJ5ns4y3fpZSU1j74TOlT+U4sj+sWuJNFh3Tl8Qe+8c16
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmFhZFRwZVJNNEZKWmhMbFo0K2FpUGZKZjZBa0M1RUJDemJkaitZUUlsWVNG?=
 =?utf-8?B?S2Z2VC9yVHNXcHkxeTdpMGk5OHZLbU1FQys1M0FUOXhkaFVVbWFXZ1doMHlI?=
 =?utf-8?B?SHlqWktRTnBBdzJkZVQ2R21OZ29iNk9mN3pMVjRaZStuZWY0TE53VmZ4Y3A4?=
 =?utf-8?B?TEJ1N09FbFp2WllBZUcrOEVSSHdVN1FQZHQxVkREdnpxVEFMTTVMWmx6c2RC?=
 =?utf-8?B?dWlpNlZwRVRORlh6aGpUSUlnNGsvWGhmWGJDUzZLbUM4ZXpjQ2R4b1NTTlJj?=
 =?utf-8?B?VDNQdWt3THNiZFlYN1AwYS82S2dtRWFhb1BpZUZqZlhydDFab2VINm8rSTM2?=
 =?utf-8?B?djF0MlBqL0x6R0xJbEFoeWlIVG90WjV5VVBtU21oSnE5WjROQ2dyVlFvallu?=
 =?utf-8?B?YngxK09vMFdibjA3T00yaXJuOW5qMTBrRElDQmRJVWdWVytQOEh4a2dLVXZT?=
 =?utf-8?B?NzRISHd2bkZiQnp4N2pUVjRKS0tVSThxeEhPWU1keE5GQTJRZmlLcVl3Vm1x?=
 =?utf-8?B?aGo0R3dpeGo5Z29rNFhsZ1Y2OVdqWTNBYXFpcTh5K2lGZGtqM2pWclViUmEy?=
 =?utf-8?B?RlRZcXI1aFhlY2FIWCt5aFFGU0VQbXM4RmVvYkw5amp3VFlEdlI4WWRRTXdy?=
 =?utf-8?B?VlRrQ2ptWU9Ka2Nrd0xpUHlnR01VQ3cvQ2Q1ZjBhOS8xeENJaUw2R2ZTUzlu?=
 =?utf-8?B?cXlsRDVDL0tUZURUbDA1MnJsT0NYUUc0UUVpTTVSem9QSUpWeXJveHZNUG90?=
 =?utf-8?B?OWsxbEw3ZGJVbFYydUtDUGt4ZE5NZWpBbHFQNnF0RzNLSTdHYmNMQm1UUjJE?=
 =?utf-8?B?Zm14WFRlOVI2V0UyT2NLdnJURmdsNzJtTGt0T3pYOHdCVXo3VjRuTVJEOGpl?=
 =?utf-8?B?a3IwU1U2RXE0SG4vWG1RdmRwZnhFbzZUV0dLRXloQjUwSVJsZzNVam92T05L?=
 =?utf-8?B?ajE0amhwN2hnTzQ4MGRmVWxPcnN4b2ZKUjlTZSs5Y1RHdFovQm04V1ZiRkps?=
 =?utf-8?B?TmxDZXo1bmp0bjNsU25ZZjVwMWpSdS9lWjFtQ3dpQm1jcWJaVG1XV24yOUx5?=
 =?utf-8?B?V3ZxTmtDVVE4RVpyYjR0VngreGp3NUpmOWpFcHpmMnhkWGtCSnE2VUpYMmRp?=
 =?utf-8?B?Y3hGc0c1MkdhUXpIbzhQYTFjaEFNYy9MTzFqb00wbzlNN1JBZzNIMnVKZDZJ?=
 =?utf-8?B?WWhObjJtOU1hT2crV2dGU3U1UFl2K1dlTkpBZW15V1doSUU2bW9tK0NWV01C?=
 =?utf-8?B?N0pGTktIWWxuVjloQnRKdmFuekJxcGsyb3VrU1FINTduVC9IbllqSlNocVZN?=
 =?utf-8?B?eGZQWTdZNGdxelg0UFJSdi9LRjJ3ek9BVm1pem5VREtlMXB2QWQvQXJjRFYv?=
 =?utf-8?B?Y3VqR0VlR1JHeDNBY2NVSHJJUzVyOGZxU0VFbW9LMEF4UHJ3V2pnamRlblpv?=
 =?utf-8?B?VnBkcEdBcDRFeTBIc3hkaUg1ZFdORjdsTXh5SjFsckdibEF5eGtueXVHcW5r?=
 =?utf-8?B?NU5TT3BJL01rVTU3cXMwdmxRN3E2QU9KQjkwMHRFaURCRlR6cVV3N3puZ1o0?=
 =?utf-8?B?R1dKd0FmYjRHVitKMUMrNjY4N2RuTkRuamoxcGtCWUJCMmZkQkovODZZeWxk?=
 =?utf-8?B?WkZtRURoT3NYRDVFcEMzNEp1anIzcUdyWVV0UllXR2NYcXU2SWZvTkNKeVUw?=
 =?utf-8?B?Y2NuNkdhalN4eWEvVFFRS1RzUnIzTDdMM1BRMDZQdXNuRHFmd0I1YUF6OVd1?=
 =?utf-8?B?b0czL0hrMnRwNjg2K1cxL0RwZmozV1lCZUxxWnJJbjdzd2xiTDZiR3M4ZUk0?=
 =?utf-8?B?RkFFV25lZHN2S0JjVXpTbXBjeE0yeVZQN0o4RW5ncXhxcHR1blVWYjhQdTRo?=
 =?utf-8?B?aTgwWTE4aWI5MnRFUlJiYjZDU2U1YWpVdFR4ci9yOUJGMVB6MXMxSGp5dDkz?=
 =?utf-8?B?cERDamNzcS9adzh3WUJ2VGI5cmV4cW9Ma3kwZitISjhwRk93KzdBMWFWVEs1?=
 =?utf-8?B?MnBmdEpxUHNUaGRqVit4YVZvNFFVa20zNEJUVUFuT25IOUllWkhoREZOM1Ny?=
 =?utf-8?B?WEFEL0Q1c1lka0RFZmJVRFpJWjlENzM0N25Nek0xMVlmZ1Iza0Jua2JMWFVX?=
 =?utf-8?B?aXp6NC81UldQNHdLN0lZSXJXRHZob296U3JXb2RMc2grZmI3RmRGR2I0cUh4?=
 =?utf-8?B?MEE4TlpEK05FRzVodEs0bEtua0w5Z0k2ekFSV2ZndTc1YTRJcDUvY1lOSjVy?=
 =?utf-8?B?QVhZUTE0MXdPaXZKWVY1aHh0TEhmV2t2a3VUY3NsdVVkQ3RwazQrVlhRRGJn?=
 =?utf-8?B?enhjSkdsU01ZdHgxWmVQSTR2OGM2c2dQRHlhZkl4SElCZnptQXl6NHo3dCs0?=
 =?utf-8?Q?Yx2xsHvVHigxyfmA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CrOTZb1KRrluE8Hi1qKRD454X4/8qRXPxHi1cqFPQYNvr17f1fATBKuEHUjSG1O0/Hvh6RKs6WeVHUo5EpnlqFyKsFw7LDG/GIpH5YjjRev4xPkZtie/dfZhrv5YkbetTk+MjZ8Asj/daThWAC8Zllg6yxdewJSZ8D4dkiye9+vWa9ukZPFzKvY1+65tMcplIRZvV88n5ehhcwlbn4RZ96lty+38Kp5E+09w1hvWqFY/RAdQprsQK7Zd7WsIAk8a7rlWJL9k8IIDPNrS0kNlcvkQyr9F0pz+zR8rGkj80VM1Nm95YwTUKIV55FRluvP5VKCN51YLe7kXO0zjLjfgrA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b137b1f-021b-47d3-320e-08de7f504b55
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:26:37.1030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AxdWCRDv24cjq1vJ384aXrRsVpA5dEn9LMt6b7ZY4xpRPyA7+lzpYDvdn+c/fLlu4FAozNXPYwAhO263RnUUNdrC+EOY+Cy5UgkT++EsOPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6836
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [Intel-wired-lan] [PATCH 54/61] aoe: Prefer
 IS_ERR_OR_NULL over manual NULL check
Reply-To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 3412
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/n9ryInn83Il90_GteAo7mQ>

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
bS5kZT4NCj4gQ2M6IEp1c3RpbiBTYW5kZXJzIDxqdXN0aW5AY29yYWlkLmNvbT47IEplbnMgQXhi
b2UgPGF4Ym9lQGtlcm5lbC5kaz4NCj4gU3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENI
IDU0LzYxXSBhb2U6IFByZWZlciBJU19FUlJfT1JfTlVMTA0KPiBvdmVyIG1hbnVhbCBOVUxMIGNo
ZWNrDQo+IA0KPiBQcmVmZXIgdXNpbmcgSVNfRVJSX09SX05VTEwoKSBvdmVyIHVzaW5nIElTX0VS
UigpIGFuZCBhIG1hbnVhbCBOVUxMDQo+IGNoZWNrLg0KPiANCj4gQ2hhbmdlIGdlbmVyYXRlZCB3
aXRoIGNvY2NpbmVsbGUuDQo+IA0KPiBUbzogSnVzdGluIFNhbmRlcnMgPGp1c3RpbkBjb3JhaWQu
Y29tPg0KPiBUbzogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPg0KPiBDYzogbGludXgtYmxv
Y2tAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHAgSGFobiA8cGhhaG4tb3NzQGF2bS5kZT4NCj4gLS0tDQo+
ICBkcml2ZXJzL2Jsb2NrL2FvZS9hb2VjbWQuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
YmxvY2svYW9lL2FvZWNtZC5jIGIvZHJpdmVycy9ibG9jay9hb2UvYW9lY21kLmMNCj4gaW5kZXgN
Cj4gYTQ3NDRhMzBhOGFmNGZmMDUxMTNmMzIzNDAyMWVlYzcyODI2NWI0Zi4uYjMxZTUzOWE2NjQz
M2EwYTVkNmU4MTExN2EzMg0KPiBkMTI3MzVmZmMxYmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
YmxvY2svYW9lL2FvZWNtZC5jDQo+ICsrKyBiL2RyaXZlcnMvYmxvY2svYW9lL2FvZWNtZC5jDQo+
IEBAIC0xMjY4LDcgKzEyNjgsNyBAQCBhb2Vfa3RzdGFydChzdHJ1Y3Qga3RzdGF0ZSAqaykNCj4g
DQo+ICAJaW5pdF9jb21wbGV0aW9uKCZrLT5yZW5kZXopOw0KPiAgCXRhc2sgPSBrdGhyZWFkX3J1
bihrdGhyZWFkLCBrLCAiJXMiLCBrLT5uYW1lKTsNCj4gLQlpZiAodGFzayA9PSBOVUxMIHx8IElT
X0VSUih0YXNrKSkNCj4gKwlpZiAoSVNfRVJSX09SX05VTEwodGFzaykpDQo+ICAJCXJldHVybiAt
RU5PTUVNOw0KPiAgCWstPnRhc2sgPSB0YXNrOw0KPiAgCXdhaXRfZm9yX2NvbXBsZXRpb24oJmst
PnJlbmRleik7IC8qIGFsbG93IGt0aHJlYWQgdG8gc3RhcnQgKi8NCj4gDQo+IC0tDQo+IDIuNDMu
MA0KDQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25v
dkBpbnRlbC5jb20+DQo=
