Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC351049516
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NB2nBRc43fDX8zlDL4NBYU+3M2DIhtkp5vKO6YL+b6M=;
  b=nMaukfAHq/eWhjLWTxDWI4VlkSysDMd6COqK/e0+vkFn4yPdJyJli8Ws
   P7lB1x9OO4i5ddbQ7Yoy4fYayv048F5H+mkiidak5Ak/HkV/tAROPpJsy
   GJyRFIl8Iu7ZSATox9ZVwEgabihTUALMFq3YltmCkQlU1oUCidvAYEcBo
   4=;
X-CSE-ConnectionGUID: 3oZOHqz5R5qng0xe9A9xSg==
X-CSE-MsgGUID: rxlBBYQMQeSteYo8Q5TVjQ==
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
   d="scan'208";a="267246352"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:36 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id C5F29818CB; Wed, 11 Mar 2026 10:46:36 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 13A008189F
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 10:23:11 +0100 (CET)
X-CSE-ConnectionGUID: oUTJOUXfTk6VNljVw5CsVQ==
X-CSE-MsgGUID: XfYH5u8tQUelkUKRBmaehQ==
IronPort-SDR: 69b1347e_1MoFpRtLeYuxNOEjWFIADretliaZVSvBfBfqf8anzaKO0L/
 KZ4srbCQWwGKn3SqAqy1Y7PUuzedexT/Drhw4LA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E8AAAINLFpjwlBr8ZaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8EAQELAYFtU4FoMQRUhFiDTAOMBIIhA4ETm1yCUAMYNQgCDwEDAQsBAS4gA?=
 =?us-ascii?q?QIEAQEDBIUAAhaNDQIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBA?=
 =?us-ascii?q?QECAQECBAYBAhABAQEBAQE5BUmGTw2CYgGBJF4HCTgBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQERAg1eAQEdAQEBAQMBEREEDQwBATcBCwQCAQgOAwQBAQMCJ?=
 =?us-ascii?q?gICAiUKFQgIAgQBDQUIGoJggiMBBkoDAQICoi8BgT0Ciip6fzOBAYIMAQEGB?=
 =?us-ascii?q?ATeCQkJAQoBgQouAYU7gxcBAYFwgkqBIAEZhAB6J4FlQ4EVQoIwOD6ERQUQI?=
 =?us-ascii?q?4MhOoIvgzSMTYZWCUl4HANZLAFVExcLBwVhQhAzAyAKLy0CFA0QEg8EFgUtH?=
 =?us-ascii?q?XAMJxIPHRcUH1gbBwUSISoHgUF4gWYbD4ZoeQMuXhoOIgIoEgMyBCOBBgtaB?=
 =?us-ascii?q?YIsAhwDC209NwYOGwMEOnsFjWs9ghQZBgEBTz6BBz18GJZjSYwnoy8DBAOEH?=
 =?us-ascii?q?JlciDIXqmsuh2WQcyKodAIEAgQFAhABAQaBfiQ8gSBwgzdPAxkPjiEMDQkcg?=
 =?us-ascii?q?0KPPQG5bEUzPAIHCwEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:UhBEwqNeYmfkYcBcT9f255DYdb4zR+YMi2TDiHoBMiC9I/bo7/
 xGws5rrCMc0AxhLk3Jmbi7Sde9qADnhNdICO4qTPGftWjdySyVxeRZhrcKrAeQaREWmtQtqZ
 uINpIOf+EYbmIK1PoSgjPIZurIqePvmM7Y4Ja7vhAdK3ARGtxdBkVCe3Km+yVNNVt77PECZe
 uhD7981kmdkAMsH7SG7xc+Lpf+juyOvqjLJTQBABkq4hSPizSH1J7WeiLzvys2Yndk+5tn1X
 LKvTDYy8yY3pGG4y6Z+37Y7pxQltek8d1eGcyKhPESLzXnmiyoaI5iV7DqhkFsnAjp0idIrD
 DLmXtOTqZOwkKUWlvwjQrm2gHm3jprwWTl00WkjXzqptG8bC4mCuJa7LgpKSfx2g4FhpVRwa
 hL12WWu958FhXbhhnw4NDOSlVDile0m3w/iuQe5kYvC7f2KYUh8LD3znklT6voLxiKtrzP19
 MeXf000cwmLW9yqUqp7lWHjubcDUjbVS32CnTq8vblmAS+2koJmnfwjfZv1Eso5dYzTYJJ6P
 /DNbktnLZSTtUOZaY4H+sZR9CrY1a9Ay4kHVjiYWgPLpt3eE7lutry+vE49euqcJsHwN87n4
 nASkpRsSo3d1j1AcOD0ZVX+lSVKV/NGQjF24Vb/dx0q7f8TL3kPWmKT00vidKpp7EaDtfAU/
 i+NZpKC7voLHfoG4xOwwriMqMibEU2QYkQoJI2SliOqsXEJsnjsfHaau/aIP73HTMtSgrEcz
 o+tfjIVYt9B2yQKzDFaULqKj7Qk2TEjN5NLJQ=
X-Talos-CUID: 9a23:WKnxwmwHmdcEnl7ahnaaBgUTJ/wHVUDtwkvTfXGeDWRXV+C+UmGprfY=
X-Talos-MUID: 9a23:5gqmEQsHsoB/7Ia+ic2ntD9TFJp1s7iXNU0JkqglgeOBPCFwAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="141009225"
X-MGA-submission: =?us-ascii?q?MDFzaYG128kbELztxjDe8dNUDAEuxYytMH/ObX?=
 =?us-ascii?q?IK/AcRrXJtmwB+ly8mN9E+gVNMuquTAiobZVbYbwJV5HUyOBxJcGxevd?=
 =?us-ascii?q?EDCXp6Uz1ojY0GszeSVDveEy4Olfx2vztKQwu0Fs6Kg2PF4JADUy4nyz?=
 =?us-ascii?q?4Rd+MJQFPLJyj9tksSdF5GUQ=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.9])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 10:23:09 +0100
X-CSE-ConnectionGUID: 0yuHJfDsSt+gIHLMW1tSdw==
X-CSE-MsgGUID: 89ZvxPvDTHK4BxL4yF4+fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="96899295"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="96899295"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:22:59 -0700
X-CSE-ConnectionGUID: JgNxlRfBS6KCtj1uc15vuA==
X-CSE-MsgGUID: 3z3bFIfTQuSWrDhKNAVhnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220353827"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:22:57 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:22:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:22:55 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.10)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:22:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baDKytEOSuGkPkikYD7+K5e3b064XaUagF8q4zWo7sRLP1x11vxxCZ0aqocLiEvcRwPWXe5NmAi4V60e5wQ242jK60Xlom2m7LiDRCfrqO/giF+QjAotDZJba+hbVhOJjkLM3VawTekdruOcV8QPGq6XLuXxzygetIn4lARS5+PjYAQODAQNeoeM9tLVHNNd6uXTVpCWgv5zZcXOY22kMhohQ2ORDtH8f+fftD3Dpra3gBjm1VffTHnMecQ1QbKmK+sf0qU/GweRNoPR4Jbchgp3J2xy/rYzrSRUxjOZTw3l+5/mVduPjfjn/wYXN93fxX24jg5tzIdZsbXPQfAT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NB2nBRc43fDX8zlDL4NBYU+3M2DIhtkp5vKO6YL+b6M=;
 b=w904wRkk3dEy+6955ivcfDdm519SZfBc5PoypOQOBqhPX/y2QEtd3JxFPwp8SAy+upM81Z/48KwY/MTVwpbA3zCHIBa7vma0VOm/BX43uRXEWRfAEOhvtJnBDOdk/TB+1u0BZpbJNiH2njmsAJayodsYG2VYrZfJ1rUVeDQGUeuxtVNd9MpyX0IIoD2QNvQc0iTzdLRSMQDVD8jB3kU3oj5xl0O9FRM2gFcxrnYX2dZqlT0eGyBrDds+cQ50dAc+23+4t1lVTW6X8IamG0cZpNgo2lHUCE0lzAHfbSP6GxPZKZyR1lqfgSUg/Lj2ItGwfGTAl/hAg9SsopqfrY2Yvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7897.namprd11.prod.outlook.com (2603:10b6:930:7d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 09:22:47 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:22:46 +0000
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
CC: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
	<Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH 30/61] net/sunrpc: Prefer
 IS_ERR_OR_NULL over manual NULL check
Thread-Index: AQHcsKJ0tObOnwx+9kO98VYqVZZsnrWpD+kw
Date: Wed, 11 Mar 2026 09:22:46 +0000
Message-ID: <IA3PR11MB8986B27E91681D79D9D8A387E547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-30-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-30-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7897:EE_
x-ms-office365-filtering-correlation-id: 7b7a6dfc-62d6-47f1-862d-08de7f4fc20e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: GxQQCd/c8eV6aNEekxf/kywrprbTaee5KerYvJkRN8yhsK9GmObVtty0cvZUqgruTDOnh9FYrnoryvIlYHlX1jPbTuRpZFBHu0FodbAGXBM+tQqVuKBZx5Rq5rtunOYZymKDvLdiGJJ+X2LSaEy6lyql4V32YdAsR9WvQ8LriGm0kT3J9sogaMlIk3w+RzQKv2V36PikgxJS0X03x1SKBIvYbugQ7+HXCFx+S54977zIJ0P0jRt4d3SI4R500xOle9LL9wl+NKUs+ZtXRPDTxXBRGMmhTxjrDke6HTfJlrlwNrD4bO3TlWEkE4iYRtPmH6ZzCA+S/yfwao3UbFe2MBKJPGG/WIGx8wWaqVG8suHB5h+oms3skixZcAmCnqUZfNhX7jCe114UW1puMdstFSN+lluiuvgbvmN1SFqRfkJOHBuCbAjmvGKIgPeUiVCJTUDUyRxcP3PVqW9bRFVu2O60LuQEA92OXdiCFtLBjr+mbnFBBlCUgnPczWphaTpOXMhAO/fyChiiDZF9qZNNPmIYPAtYNfW5A0zaj0sn5oIUzYxRvpEaS+vUowvXJ7WJPDoYhzDQl9DBoT7+PIYO895bhBXT1Zmo1y0gHPtb1RFJQqg+Fz4LGos7/ZrbG2fXN5CnlbS7KCCsk7050OVomSqrDeM2JP8EJnLoASHFjS9kg1Kq4S9smaAsEcfjgDGCX2082HK5ZN49fqlW/TzBrwoLWqJsfEGeIAfOm9NxClGzHYS4qqDJ40xLMc2sASYXhYaiH1O3kHtejDX8szCddM4ytwOhjczmM5QSQx06WvcYdwOZd6yMRpnXJn/nr1Cy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WU5GNWpPRWt2UXd3R05laHJacUZxQzlXN3RlNXh5YVJVUHFnbzh5OHB5TFY0?=
 =?utf-8?B?SkNhUXVpeHkrejlsNzA3YzYzdDlxTFVIRUptdzdiMU5ndFVpSCtvOXVhZDBl?=
 =?utf-8?B?K3l5dGFlWDRPVVVpaXRWRFJiTDYxbjJKOU5lRjR1bzFMbG5aU09obU5ya3Rj?=
 =?utf-8?B?L0JrWS9BRnVodFFZOXp4a01VYlA3WnBWMHd1TmRqWkliT2ZCNG13dTlPQ1RE?=
 =?utf-8?B?NWp6MXFFMEFMTU1STFh5bWdRSDdnMmI0RTh3Z2RhNlRDSDdZQWNoQ0VHM25m?=
 =?utf-8?B?cit3LzlUclZzUEtXQjRnVlEwQitxc2NoZTc2cXV0M2hUaSt6cHdQcVEyUHFN?=
 =?utf-8?B?Q0pFWjhETFI4NzI3Q0gvcjIvY1RrNDI1WDdMZjMvYlQxaThJcjZia0FuOTZ5?=
 =?utf-8?B?UEZwOUZSREhXSXk0MUdWUmR3OWhQT2trdlBTVUNFN1g5WitSeFVMMWdtSS8x?=
 =?utf-8?B?T0lLMyt6M29KbnV5VFNaejRiMWF3akhkQ0JzbVB2dmZIbjArOVM0MlltdktG?=
 =?utf-8?B?VVVKdTRHUjRlTnVpTVhLSE9saE44NnQzc2RQbVp6ckRQR2UxWENFR3NUc25R?=
 =?utf-8?B?aEQxaHc0U25FZWpQQjJ5Rzh1VmtUZW1McElvWTdTeEpvaS9GVG5lektXUVVn?=
 =?utf-8?B?RUxCbk40em5TQTR1dE0wV1p3T0RJVVJVQWc4dW1QeHkvcnZiYk1lSHBPUFdi?=
 =?utf-8?B?S1BGMGVhUGVyRDRjL3dFT1JFaGFuViswTk1SZXNiNXZJdEhqTnpqSXdWK1o5?=
 =?utf-8?B?ckJrd3kwT2lmNVljOGJvRWRRaW1PNUQwT0xUWkpXYUtNWWF3VUN5Q3VLRGh6?=
 =?utf-8?B?bVFqbm5QTlRCZll2SVhwaFVYSW5DMGhOWDRRbjU2bUxVVUtXNFg5UkN1eG0w?=
 =?utf-8?B?L3Rqa2F1SVUrazdqZ2doMHhBSjdML0s4Z21mRm5WdlJ5M1F2cDduYTRySDM0?=
 =?utf-8?B?N3k3THpiYlViTnZhV2VvQm0vOXVpRHBHUmZGaEpBcnBERkw3Qlc4RnEyWWpE?=
 =?utf-8?B?amU3RTRZUjVNYjZxR29VSXAyNVU4OFhsYVptTTQ2THVsOE85ZVYvTG9vSU05?=
 =?utf-8?B?SUpIbDFCOTJmZWU3ekpVL2oxNDRGWUFnZG1YUHJXRGVLaGFJczhVZFNjdW1B?=
 =?utf-8?B?cjhFbGJVT3NvWHlKV0pRMHZ3eDZxMzl4azVZRjY3S09vSFZ3RjRhSldHWUhV?=
 =?utf-8?B?c212T1JlSHZpSGVoQ29XR3NpRE9qa3VvWGRrODFyc3BkNXVHdStSZGszQzJw?=
 =?utf-8?B?UllibFlFRmVLRjlPcGFMM1VHT09ZdzZrRHQ3WDIvaGZRVkZOUHNJWUloU05r?=
 =?utf-8?B?NkJza1NvdFZuNUhBc2FiV08rbDlxSVhzd1RqencrdXZiVzFUa0RjTURnaXZ6?=
 =?utf-8?B?T0VTT0x4cEZVTi9uVDc3ZFVKSnNIb01FTnhCOHd1c3Vqck1OdnFQMnFHVzJx?=
 =?utf-8?B?SVFXcURtMnJ5MGF5VlRRdjVpNHVYMG45ektvaUVORzA0b21NV2FwZ0wyc3VC?=
 =?utf-8?B?L2xxbGg0VnpZcTRhMzdlNncxRzk5Q21iNnYrYnJMSmJMWWtPcU9BZUtMWWxG?=
 =?utf-8?B?bkFJVm5DaHZ5aFpCNjE1V1RMZ1JELzZOUk9QdGIvRythMjZib0d1eDNSVUZS?=
 =?utf-8?B?aXZlbExHUU1xZWtRc3dqRFl2QlJDc05hZzh2eEQ0U1FKdGlIa2NQMUhCRmdJ?=
 =?utf-8?B?L0N2VDNFcDNwRjRFUDR2RTZ2dG1iQVg5OVR6d1d6OTdWeTB5cnI0QVRHTWxI?=
 =?utf-8?B?ZkhLT201RHRkSUJ5VXc3a3JmUitEczJodEhqaEhzTHl0UmhkK2hCMEE1V1h1?=
 =?utf-8?B?RjNuczdmTmdsNVlDMDE1NXhPNHcwRklJQW1xL2MxdWNsRnIwZVF5bVdiNXJ4?=
 =?utf-8?B?WGw5OEM1V0pwS1BXSDVuYy9OQmJuVVdEUlA5amFYL2JCSllLaEhnSnZhR0Uz?=
 =?utf-8?B?SmRJZTlnWjRoU2Jwczc0bTQwdzdHNkhJamxGUXRsd3dDdjZpNVk1NE1QT0N4?=
 =?utf-8?B?bVNwZ1BqbllvZTNTVHdSN09MT1RGQWlpa3BzTkhxZU4xUjRxMjBPdm01RGZN?=
 =?utf-8?B?VXZJODBnd2dnZVU0ZkM4RVM1Q3A2MkIrd3ZLaCtSaXhnOTlEaUV0dHBRay9W?=
 =?utf-8?B?TURmTWI4V0RVQVJxUFlNS3lNcmVndGMxSk14WFlmdEsyQTNVemdiZGZIY2FO?=
 =?utf-8?B?UGk5NjBmaFFHVVZWVXB3VmxZb1lBT005blU5ODlsRjMyclVPRWRJZENGbFZi?=
 =?utf-8?B?dmxZeGNPSWs2Mnl5dENGTFIwaDJkdWtjSVI4Uyt5ajluS1dlTVIxNXBKem9j?=
 =?utf-8?B?aTk1UkhSUHBsWUM4WkhuYTNTdXAzU0ptSEZVU2tDcFJldkpnOGxacEVLc3hN?=
 =?utf-8?Q?d+ODkmbfj2d1XMOQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uqN/PRuN+pHeGKAJeiVslQTfIoQDMSjXr/jPdOzJJ3OoQQSj1v7QxjBPGBW57eCn9dqtHV3Z3wcPezqhXwae0k4zhFu9vFi0et76GamFVnAkwI7j5nAUh51dQkzv7R11kKVmL7oPWLpUFr/Tp9x33d6niKWH7giuk1bdQtDsIPGTQEfzNY9PS91Tov41ZJ1s9KEOQUrVXkuWUAl3T655CAr6N9dkUsS6vrgGUjGgnP1oRdTpPPEHB0iXn1jkQGV/Q/vi9xP1yDKqBy6Bab/qdCXXkE2CQhJXlb9oyHY91l4tUFHb588Fyn/6VCgF8kU3Mh9lJHZ+WMoUvfnbvo5/bA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7a6dfc-62d6-47f1-862d-08de7f4fc20e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:22:46.7619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZLgNgL1yFcWDQiRaEtxZHr4XDLXtW42+n30PIQJxmEMOHU73e4kE3c/XFVsH5B8Pm+/0D1cNn3DD5Kane2r8K2fhocF3RSNuDUsNdiqZA+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7897
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [Intel-wired-lan] [PATCH 30/61] net/sunrpc: Prefer
 IS_ERR_OR_NULL over manual NULL check
Reply-To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 3406
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/8apKxfoUKpPh8dkq2J4Cwg>

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
bS5kZT4NCj4gQ2M6IFRyb25kIE15a2xlYnVzdCA8dHJvbmRteUBrZXJuZWwub3JnPjsgQW5uYSBT
Y2h1bWFrZXINCj4gPGFubmFAa2VybmVsLm9yZz47IENodWNrIExldmVyIDxjaHVjay5sZXZlckBv
cmFjbGUuY29tPjsgSmVmZiBMYXl0b24NCj4gPGpsYXl0b25Aa2VybmVsLm9yZz47IE5laWxCcm93
biA8bmVpbEBicm93bi5uYW1lPjsgT2xnYSBLb3JuaWV2c2thaWENCj4gPG9rb3JuaWV2QHJlZGhh
dC5jb20+OyBEYWkgTmdvIDxEYWkuTmdvQG9yYWNsZS5jb20+OyBUb20gVGFscGV5DQo+IDx0b21A
dGFscGV5LmNvbT47IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMg
RHVtYXpldA0KPiA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtl
cm5lbC5vcmc+OyBQYW9sbyBBYmVuaQ0KPiA8cGFiZW5pQHJlZGhhdC5jb20+OyBTaW1vbiBIb3Jt
YW4gPGhvcm1zQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRD
SCAzMC82MV0gbmV0L3N1bnJwYzogUHJlZmVyDQo+IElTX0VSUl9PUl9OVUxMIG92ZXIgbWFudWFs
IE5VTEwgY2hlY2sNCj4gDQo+IFByZWZlciB1c2luZyBJU19FUlJfT1JfTlVMTCgpIG92ZXIgdXNp
bmcgSVNfRVJSKCkgYW5kIGEgbWFudWFsIE5VTEwNCj4gY2hlY2suDQo+IA0KPiBDaGFuZ2UgZ2Vu
ZXJhdGVkIHdpdGggY29jY2luZWxsZS4NCj4gDQo+IFRvOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25k
bXlAa2VybmVsLm9yZz4NCj4gVG86IEFubmEgU2NodW1ha2VyIDxhbm5hQGtlcm5lbC5vcmc+DQo+
IFRvOiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4gVG86IEplZmYgTGF5
dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+DQo+IFRvOiBOZWlsQnJvd24gPG5laWxAYnJvd24ubmFt
ZT4NCj4gVG86IE9sZ2EgS29ybmlldnNrYWlhIDxva29ybmlldkByZWRoYXQuY29tPg0KPiBUbzog
RGFpIE5nbyA8RGFpLk5nb0BvcmFjbGUuY29tPg0KPiBUbzogVG9tIFRhbHBleSA8dG9tQHRhbHBl
eS5jb20+DQo+IFRvOiAiRGF2aWQgUy4gTWlsbGVyIiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4NCj4g
VG86IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4NCj4gVG86IEpha3ViIEtpY2lu
c2tpIDxrdWJhQGtlcm5lbC5vcmc+DQo+IFRvOiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5j
b20+DQo+IFRvOiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+DQo+IENjOiBsaW51eC1u
ZnNAdmdlci5rZXJuZWwub3JnDQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHAgSGFo
biA8cGhhaG4tb3NzQGF2bS5kZT4NCj4gLS0tDQo+ICBuZXQvc3VucnBjL3hwcnRyZG1hL3N2Y19y
ZG1hX3RyYW5zcG9ydC5jIHwgMTIgKysrKysrLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9zdW5y
cGMveHBydHJkbWEvc3ZjX3JkbWFfdHJhbnNwb3J0LmMNCj4gYi9uZXQvc3VucnBjL3hwcnRyZG1h
L3N2Y19yZG1hX3RyYW5zcG9ydC5jDQo+IGluZGV4DQo+IDliNjIzODQ5NzIzZWQwZWI3NGI4Mjc4
ODFjNmYzMmQzNDM0Yzg5MWIuLmI0ZDAzZTU5YTgyMDJmMjAzNjBjZmYxZTJlNzkNCj4gYjFlMzI1
Mzk2NTE3IDEwMDY0NA0KPiAtLS0gYS9uZXQvc3VucnBjL3hwcnRyZG1hL3N2Y19yZG1hX3RyYW5z
cG9ydC5jDQo+ICsrKyBiL25ldC9zdW5ycGMveHBydHJkbWEvc3ZjX3JkbWFfdHJhbnNwb3J0LmMN
Cj4gQEAgLTU3OCw3ICs1NzgsNyBAQCBzdGF0aWMgc3RydWN0IHN2Y194cHJ0ICpzdmNfcmRtYV9h
Y2NlcHQoc3RydWN0DQo+IHN2Y194cHJ0ICp4cHJ0KQ0KPiAgIGVycm91dDoNCj4gIAkvKiBUYWtl
IGEgcmVmZXJlbmNlIGluIGNhc2UgdGhlIERUTyBoYW5kbGVyIHJ1bnMgKi8NCj4gIAlzdmNfeHBy
dF9nZXQoJm5ld3hwcnQtPnNjX3hwcnQpOw0KPiAtCWlmIChuZXd4cHJ0LT5zY19xcCAmJiAhSVNf
RVJSKG5ld3hwcnQtPnNjX3FwKSkNCj4gKwlpZiAoIUlTX0VSUl9PUl9OVUxMKG5ld3hwcnQtPnNj
X3FwKSkNCj4gIAkJaWJfZGVzdHJveV9xcChuZXd4cHJ0LT5zY19xcCk7DQo+ICAJcmRtYV9kZXN0
cm95X2lkKG5ld3hwcnQtPnNjX2NtX2lkKTsNCj4gIAlycGNyZG1hX3JuX3VucmVnaXN0ZXIoZGV2
LCAmbmV3eHBydC0+c2Nfcm4pOyBAQCAtNjA4LDcgKzYwOCw3DQo+IEBAIHN0YXRpYyB2b2lkIHN2
Y19yZG1hX2ZyZWUoc3RydWN0IHN2Y194cHJ0ICp4cHJ0KQ0KPiAgCW1pZ2h0X3NsZWVwKCk7DQo+
IA0KPiAgCS8qIFRoaXMgYmxvY2tzIHVudGlsIHRoZSBDb21wbGV0aW9uIFF1ZXVlcyBhcmUgZW1w
dHkgKi8NCj4gLQlpZiAocmRtYS0+c2NfcXAgJiYgIUlTX0VSUihyZG1hLT5zY19xcCkpDQo+ICsJ
aWYgKCFJU19FUlJfT1JfTlVMTChyZG1hLT5zY19xcCkpDQo+ICAJCWliX2RyYWluX3FwKHJkbWEt
PnNjX3FwKTsNCj4gIAlmbHVzaF93b3JrcXVldWUoc3ZjcmRtYV93cSk7DQo+IA0KPiBAQCAtNjE5
LDE2ICs2MTksMTYgQEAgc3RhdGljIHZvaWQgc3ZjX3JkbWFfZnJlZShzdHJ1Y3Qgc3ZjX3hwcnQg
KnhwcnQpDQo+ICAJc3ZjX3JkbWFfcmVjdl9jdHh0c19kZXN0cm95KHJkbWEpOw0KPiANCj4gIAkv
KiBEZXN0cm95IHRoZSBRUCBpZiBwcmVzZW50IChub3QgYSBsaXN0ZW5lcikgKi8NCj4gLQlpZiAo
cmRtYS0+c2NfcXAgJiYgIUlTX0VSUihyZG1hLT5zY19xcCkpDQo+ICsJaWYgKCFJU19FUlJfT1Jf
TlVMTChyZG1hLT5zY19xcCkpDQo+ICAJCWliX2Rlc3Ryb3lfcXAocmRtYS0+c2NfcXApOw0KPiAN
Cj4gLQlpZiAocmRtYS0+c2Nfc3FfY3EgJiYgIUlTX0VSUihyZG1hLT5zY19zcV9jcSkpDQo+ICsJ
aWYgKCFJU19FUlJfT1JfTlVMTChyZG1hLT5zY19zcV9jcSkpDQo+ICAJCWliX2ZyZWVfY3EocmRt
YS0+c2Nfc3FfY3EpOw0KPiANCj4gLQlpZiAocmRtYS0+c2NfcnFfY3EgJiYgIUlTX0VSUihyZG1h
LT5zY19ycV9jcSkpDQo+ICsJaWYgKCFJU19FUlJfT1JfTlVMTChyZG1hLT5zY19ycV9jcSkpDQo+
ICAJCWliX2ZyZWVfY3EocmRtYS0+c2NfcnFfY3EpOw0KPiANCj4gLQlpZiAocmRtYS0+c2NfcGQg
JiYgIUlTX0VSUihyZG1hLT5zY19wZCkpDQo+ICsJaWYgKCFJU19FUlJfT1JfTlVMTChyZG1hLT5z
Y19wZCkpDQo+ICAJCWliX2RlYWxsb2NfcGQocmRtYS0+c2NfcGQpOw0KPiANCj4gIAkvKiBEZXN0
cm95IHRoZSBDTSBJRCAqLw0KPiANCj4gLS0NCj4gMi40My4wDQoNClJldmlld2VkLWJ5OiBBbGVr
c2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg==
