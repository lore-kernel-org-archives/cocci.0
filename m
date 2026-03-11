Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0823A1049516
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0XsUbJr6kXjuRtF79qpmNM/wiiW/pKARuseo0u1QYd8=;
  b=li5A4CI+G7LS2xx2bYlNAEwaq247ujSpcf3CPMbwya6Logh4JcKfn/ce
   Feg0U/DuAKihalF0DDofLD0VyEMzqOHlD6geosNImTFYPOyUX0/7tUOAH
   Cj963vgg4T7ral/J9yUSetYh1bAkFPR7nrYIPAaLw1hcPEUgCmQ2rZSnH
   U=;
X-CSE-ConnectionGUID: JxYUwKRBQSi7kfPjS72F3Q==
X-CSE-MsgGUID: TY/0sd5wQDSZkjSJ/ZhlDQ==
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
   d="scan'208";a="267246162"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:28 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 9D8A6818D0; Wed, 11 Mar 2026 10:46:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2CD5780641
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 10:18:24 +0100 (CET)
X-CSE-ConnectionGUID: vYB0hvgYTHq/QmYzCWvUow==
X-CSE-MsgGUID: 8yCp+mq5Qcya49Sz/V5Rtw==
IronPort-SDR: 69b13361_hAETy5VeWuGfGVUH40e851ljGi6XO6M/5xvUAno1Bv7/d0R
 RovaHt11foWXGxzk5sUNE9q4bNBvXSFWWMSVPjA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EJAAAiMrFpjwxBr8ZaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPgQBAQELAYFtU4FoMQRUhFiDTAOOJQOBE5tcgSuBJQMYNQgCDwEDA?=
 =?us-ascii?q?QsBAS4gAQIEAQEDBIUAAhaNDQIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQEBA?=
 =?us-ascii?q?Q0BAQUBAQECAQECBAYBAhABAQEBAQE5BQ47hk8NgmIBgSReBwk4AQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBEQINXgEBHQEBAQEDAREREQwBATcBCwQCAQgOA?=
 =?us-ascii?q?wQBAQMCJgICAiUKFQgIAgQBDQUIGoJggiMBBkoDAQICohgBgT0Ciip6gTKBA?=
 =?us-ascii?q?YIMAQEGBATeCQkJAQoBgQouAYU7gxcBAYFwgkqBIAEZhAB6J4FlQ4EVQoIwO?=
 =?us-ascii?q?D6ECjsVg0Q6gi+DNIxNhlYJSXgcA1ksAVUTFwsHBWFCEDMDIAovLQIUDRASD?=
 =?us-ascii?q?wQWBS0dcAwnEg8dFxQfWBsHBRIhKgeBQXiBZhsPhmh5Ay5eGg4iAigSAzIEI?=
 =?us-ascii?q?4EGC1oFgiwCHAMLbT03Bg4bAwQ6ewWNaz2CFBkGAQGBDYEHPXwYlmNJjCejL?=
 =?us-ascii?q?wMEA4QcmVyIMheqay6HZZBzIqh0AgQCBAUCEAEBBoFvAjE8gSBwgzdPAxkPj?=
 =?us-ascii?q?iEZJYNCjz0BuXpFMzwCBwsBAQMJhUYBAYwiNIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:nZLYTaBtucQ1zR7lHekz55DYdb4zR+YMi2TDt3obdfUzSL3jqy
 nOpoV+6faaslwssR0b9exoW5PwJE80l6QV3WB5B97LYOCBggSVxepZg7cKrQeMJ8TWzJ8+6U
 4ZSdkcNDSKNzhHpPe/2xOgG9IshPGM7aCvgo7lvhBQZDAvULt45wN1Tj+BHglMSBNbAIdRLu
 vm2uN34wG7YHwSY4CCGnUYU6ziqrTw5evbSC9DPAQ/4A2CyQml86H3CHGjr3EjegIK+64r9W
 WAqADi+qC/2svLsiPh6w==
X-Talos-CUID: =?us-ascii?q?9a23=3ARBYeDWkb3Qe6Xxo1paBw1+CIFcfXOWPs5i/QPUC?=
 =?us-ascii?q?JNUZwD4SQeE27x71ZlNU7zg=3D=3D?=
X-Talos-MUID: 9a23:K9zgGAXV0PSW50fq/G/9rykhMd412q+/ARxcqodBhZS+KTMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267237661"
X-MGA-submission: =?us-ascii?q?MDHow91/hsqNv+LLVU+SKovTPMPC065U3bOc2X?=
 =?us-ascii?q?1ZBcy03pZExKj+492iuOFM0ndLkcTu6OYLsfgC0vL/Km6VmtC97Gzjk6?=
 =?us-ascii?q?C4Z6ZNsL2qiOWJq6AFoI2Pd8eCiVk8yMmF6QJ7CAcQR855xN5aadd3Vz?=
 =?us-ascii?q?XliOUfERs3kKPEUCS+xiKhxg=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 10:18:24 +0100
X-CSE-ConnectionGUID: dPkHLuq3ROeLn65xAQSrZA==
X-CSE-MsgGUID: EshBiJDqRY6pfvANnw3Z9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85760277"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="85760277"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:18:21 -0700
X-CSE-ConnectionGUID: NxX1EamFQoSh3UJDpM+/Ww==
X-CSE-MsgGUID: 5wb7UjhrQfKGhvEcabKrWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="246008064"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:18:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:18:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:18:18 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:18:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsYEUMbMx92ijibRhLQ26uX2yxPGs/SUR4PcurcOQ5pNmZhCvqJk5Ch1dFYWtyxJ4MQdvguy0bSe9+V5bBFSueJhX8mDTAHJnQK1MEdfypKs4x4BIr1nxNlA7j3a1DXg0z2h17f57XjWQOh7PXQC5S5KaEOo3tAOsfbvDkSuHl1dqYTepdLTV99YzhH8dH7vTEE+yfQV2miN9oNLKOoKixNLd+jhHJtXTQQv1t+xvxq+2QUyJrCbC/C4G+jWJwWpknuAiC6bLCI1GUFGT9kHprHBzvp+0gFZykIcpxa/pHCahmS6f6PLMJMN2XXTPehHOEGYF7chIxaIgxK6z+N7hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XsUbJr6kXjuRtF79qpmNM/wiiW/pKARuseo0u1QYd8=;
 b=nfQm4LD3rfqjcMm8IXRBbICNV/eGeNvcCgh+69CMNjZlV00JNMUAdsmflN1TB/K+BeigwnzXT/6P6nSUC1w4HUCU6dEWCnsNkZhUL9zzaU3rqMvS6zIIluyYHF5dVHOq558kQFJVULWxoR7nLPZi5kCjEVkW1QiWd26zrQfn2CihzeOG/xxrc7iWsR0/7cTgTPiV37RZmSx06hvnDfwENDa/U+WKa97sVIOzFw9n5p1JLi88WhgKXu8WT35FplAYGAs3AeYm5tsns/p6TWXpJlFGNjuXANdlFIsy4T8CpcFNQKZrFDZWefDmTT1x/PlXN5moI1O4FxotN85Le9Wq/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA1PR11MB6291.namprd11.prod.outlook.com (2603:10b6:208:3e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 09:18:09 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:18:09 +0000
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
CC: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Thread-Topic: [Intel-wired-lan] [PATCH 17/61] module: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Index: AQHcsKJ4ahF7LOyphUCOzd4K1MYbJrWpDp9A
Date: Wed, 11 Mar 2026 09:18:09 +0000
Message-ID: <IA3PR11MB8986803ADA5C966425D0F3B7E547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-17-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-17-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA1PR11MB6291:EE_
x-ms-office365-filtering-correlation-id: a0eb66c5-988e-4cc9-7dd7-08de7f4f1cb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: RgrtkBu9FG9L9sCO49CaTRTJ32/k1uT7Vp/mptuRJFzCoDh3TQ9NG7bf0bXkMi2xccdgkStOkh0vwl4um0sQogTjIXDe8yD0OE5QpgJ42utIQqqB2ydvB28HOGt38wvAsAnV2Lk1fO8tSUmjk6zngmzbhPcd3ZVAo27Uu+94qfC0kNEfh7kaFpwRp6Ng1Bh86P04nyp/gdyzpavqW53Byx3nGpRPB3ApyG8dZAgWIyN7kjYCnHTYS01ilbzNDdviC//RzaJ2cOKfC11KOcMG5zXw/c8dRZ9n14s8J+quGYT6KCoA057tXwJOO8HyvOOweeuVPz7lIVLHvyFVVAo0ue0/92hNvrF2hI3k5ZeTHAWbF8vf/tkd7/J9YJkc9iCSSS74oxpwIYUK5xRDMbfKy8tTTmovDhHZWXBCAJqdFCHdG8IMDRJjG1wigv/22OYN+fHO0jGJEXX/FgPPT3RFatemNKlc6VNyXY8XSxnX422zGIR2qu1NVNFQPIpxzdfgMCAuxZvEimcqxWb3V7/i+Ocd6c9rpn/HiU0/k17qY+Ts1uq0a+nhocbv1Ldi5sAZy7zuz0hpXHlWX/mIGLjzAMRPx0vKw96fdNm1atGgCEk4rSIdXkU0sNWKrVFwxmpSFJS/QnYEtm28SL631PPCtXk6iQjA43IL4ROGUUY4LISCaf7ufSY45PV+joZEhKDpqcG+dbqOICScgdZe2NUlML9mVlQxrlv2DB1GB1/RDNKKspUvHOKX0i8nWCgiZWEGy/m/94ex0nfXTkZzceSxr4Io4JevvUzlcd06ptKODaAUjsB6B+mDvSx7L/JtE0Z8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T092MjlLSjhJdk9KcmRSVVVpUkdGdzBjckZZQzMxakY1NGoxYm9BU0xkZ3li?=
 =?utf-8?B?b25Ec0pYei9PWko0dERLRVprWGwzYjFySTFxemUxVEIzcjllSVJyS3lxajRF?=
 =?utf-8?B?MlpldmdWeko2RmxSL24ya3ErZ2RKME94NENvbVUrbDJKbEVwMlpIWXdvalNC?=
 =?utf-8?B?djVGcndEYk5OMGszaUJIVnMzWUdieCt4RUYxSWx0ODNrK3podXovSk1MM0pN?=
 =?utf-8?B?ZEJEVEV6VFFPZmFuZC92N2w4bHlYK09LcEdLNGcraE13dTJIMHl1MkpxQWMr?=
 =?utf-8?B?YUhTVzcvK01xazEyV05TNkUrT01vbU44RVo4Wkd6WUNqWmp4eGUzanFPQ3Rv?=
 =?utf-8?B?cDhmZzlZVnVMMmU5R2ZoaTZzZ3EzZThIOFhwakttSEFzRmlBU2RCT0E3L3ZD?=
 =?utf-8?B?dVA3U2VTRkdFUkF3bWVYb04yR0NmZDV2ZU1OV055NStaU1hNaE45YVhmNkVE?=
 =?utf-8?B?WFdZb2Rkb1NSTkxERmplK3FUMFdyM2RaNUNJaVpndW9uZURmb1NQcjBEZ3Zq?=
 =?utf-8?B?WnlGMkMxd1lkbzdhMVNTS2twZm5VenlWKzgzQVNyY2xDMnFtTnR3OVYrT0Yz?=
 =?utf-8?B?ZWZGR3JkWTI3SnJEb3diWFVqZ1ZPOTM4NlpwWU5mQ3BMaU1xZG1WV0hoVTJ5?=
 =?utf-8?B?bUozQ0xtVTduZy9nbjh5TU5ZRlZ6ZWtRbmpqaGFaTXp3OTI0L2Z0Y2FpUmpx?=
 =?utf-8?B?Vnl3MWcvVm5EYmo0RkRYcUZKZG94YzdNUFZ4UEU5WUhtdGNFRFZnU1hXVXpG?=
 =?utf-8?B?bjJteFQzb0VhdkgySGtuY3crYmdXQUtvd3FUclhWcjVVdk9lOStSY2FSVzcv?=
 =?utf-8?B?MDFneEpob0FyamE2QWcxZUFKQVIyNVIrOFdsL2RIMmlaWk0wVjgrbzdGOUZG?=
 =?utf-8?B?SCtaLytXc0dkcHpGZW44cnRZRWZSSURkdnIvUHpkK2gyN0FLRC9oSytKK2x6?=
 =?utf-8?B?ODdtQ1RVcGZUdWJiNUFxbkFQUGxSY3VJUDg4N1Ryd01aS3ozRHNBclJCaDBW?=
 =?utf-8?B?MCtJU0c3MDNxTTZjUHZpTUZJaGpMQWpvZk5uSlNNYndTNmsxRmlsVDZDcFJq?=
 =?utf-8?B?MTA1TVpvSnlnVGJocjN6U1dVdm1GeVU0U1drVWJsSmFITnFodnRvVUI4aklE?=
 =?utf-8?B?Rmw1N3NnS3JscTY5ckdyc2dlSnJxNXl4TmR6bE9HRHBpMG9ZZ1E2R3UxZ1Bi?=
 =?utf-8?B?UHkwbkZOTDh4a1pGM3hLNkd3OEw3bjczZjl6bU5SenM5UWE1LzVteHo4RkZx?=
 =?utf-8?B?eTB2R2ZVNVI0Wnk0eGR3b3V1S3RGaW8wYU1pSE1RTWRzTmJCclRhRTF6WmNx?=
 =?utf-8?B?bkU3YTZ3RXhpMFQ2cjU1bUZXd0ZDM05VVkhuOElmQjBva016QVlHakhwOHg5?=
 =?utf-8?B?TzRFYWNNUUJuVlNCTU80NGVPLys5RXNwVDBFN1M0QjNkS1pTSzNTdkFjK3Qz?=
 =?utf-8?B?VFAwVS9tZGNRZjV5cHNmVlZLcHFhc1orNU02Tk5MSUV4UnlvMHEzODNsZzha?=
 =?utf-8?B?V2NmQlZYNFBHb2ZCU2I1MVh4SGROdXFWamozMXhpUmtYM080dWlNRGo3R3p6?=
 =?utf-8?B?VXM4OVI0b3VkMmUrVHNWNlZFNFpQSjVVRlJUYlZxZVl6cExVMFIwNGViZ3lO?=
 =?utf-8?B?Z2NQdVZzczZEUDNpTkVhT09WT1lmTlh0SFJacE1GSkF1ZUQrL092dktZcnFY?=
 =?utf-8?B?MnBkdzF0U1ptc2lXWCtySWtibmJ0NTAzM3FhenByYWUrN1k3a2JOSk9JakRD?=
 =?utf-8?B?MWlITlNubmFudTluaC9QamVzc0EyQXVvNjY2SGNTL0RpM1FuejJzZjhUK0VY?=
 =?utf-8?B?Yk5kUElSbVlOdnlLWVBtSXAzdUtRRm9ZTW0wamVXYUtFZVVRcFhnVjYzSTRo?=
 =?utf-8?B?WmNHRURzS0ZwUTlhUTByNGdjUmlHZlFXUVNlVGxuZjYvU0lodUdLRW5sYUJ1?=
 =?utf-8?B?dDVka1dsYjlabWltNVJWZ29TeVRlWW1uTEJUTGFZQm9peFVoNlhXOGFGeE5E?=
 =?utf-8?B?NzB6TzFLeUJvenR5V3pkcytYUE9jaWR1bUtudFJ5Mm5sVnEzb0Y5dFFwTHJZ?=
 =?utf-8?B?bSs2a25XdURwcHlGRDlGNGx5aS9UMVBLUjJWdHFrRVFFRTRZeTJ0R3FlQXNL?=
 =?utf-8?B?MUtRMG9GWEdxd3d6SlBiVWE4VVNmNS82ZlZXdUIvSHg0K2xSSjBCUjFhcmc5?=
 =?utf-8?B?bzFRR01wcHFUeGluSUt5R2VaN2ZMemdBcTBwUmIxS1dLcUE3a1ovNksxc1RT?=
 =?utf-8?B?c0JvaWdVZ3JDYWxGUjQxdmFadGZWR2N6Zmk3ejN4VEhueEZBeStlODdpcGRC?=
 =?utf-8?B?Z3FvL1BNQlFyZEordWhCNU1OVDlmMkdNek05VVI2M2tmOVNIeUFxUUYyZ09S?=
 =?utf-8?Q?yoPse7gjpcycE6jA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mN0KteOGTD7a4jL5FmknbuglbGAQBeL4vvgpfMErQSpe/IpxyD4L3HmNK1XoiRfwpAPFgUZWSynRQkHKAAfpnfncU7u0KfXAObZv4S4OqI4HI9p/qsIxFmQERcDw7k/e2xxiPV+9nRSimE26kNPW60FO3SA2o75fjkywwyJKPcYNXDPSftB9nj8RPGb+M1nDRXr8UMqsB8JBb8nSOemP0wfDsMdIasdH89l5NPLtkJT/Y3c91pKNPmvFH0GdT5SvazSia9yMIvLa+RVZ3qEnbc+4xTF00dCRSUSa2j13QEydq90txVVZiELY7Oj1qnV1IzYfTensPcaRDFDlxTiXEw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0eb66c5-988e-4cc9-7dd7-08de7f4f1cb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:18:09.3548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQF8zbYKxq9DcL/+EE6exOS2W6wvkjfzZ3C+4pDr68oix8WhhWW1Ho6fNgFJaSBdZ/EhP0gYrl9T3VzjMlQUkUEhANczkEl40dMJrlBfflg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6291
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [Intel-wired-lan] [PATCH 17/61] module: Prefer
 IS_ERR_OR_NULL over manual NULL check
Reply-To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 3401
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/KUKbloqAOXYv635FuvBR0A>

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
bS5kZT4NCj4gQ2M6IEx1aXMgQ2hhbWJlcmxhaW4gPG1jZ3JvZkBrZXJuZWwub3JnPjsgUGV0ciBQ
YXZsdQ0KPiA8cGV0ci5wYXZsdUBzdXNlLmNvbT47IERhbmllbCBHb21leiA8ZGEuZ29tZXpAa2Vy
bmVsLm9yZz47IFNhbWkNCj4gVG9sdmFuZW4gPHNhbWl0b2x2YW5lbkBnb29nbGUuY29tPjsgQWFy
b24gVG9tbGluIDxhdG9tbGluQGF0b21saW4uY29tPg0KPiBTdWJqZWN0OiBbSW50ZWwtd2lyZWQt
bGFuXSBbUEFUQ0ggMTcvNjFdIG1vZHVsZTogUHJlZmVyIElTX0VSUl9PUl9OVUxMDQo+IG92ZXIg
bWFudWFsIE5VTEwgY2hlY2sNCj4gDQo+IFByZWZlciB1c2luZyBJU19FUlJfT1JfTlVMTCgpIG92
ZXIgdXNpbmcgSVNfRVJSKCkgYW5kIGEgbWFudWFsIE5VTEwNCj4gY2hlY2suDQo+IA0KPiBDaGFu
Z2UgZ2VuZXJhdGVkIHdpdGggY29jY2luZWxsZS4NCj4gDQo+IFRvOiBMdWlzIENoYW1iZXJsYWlu
IDxtY2dyb2ZAa2VybmVsLm9yZz4NCj4gVG86IFBldHIgUGF2bHUgPHBldHIucGF2bHVAc3VzZS5j
b20+DQo+IFRvOiBEYW5pZWwgR29tZXogPGRhLmdvbWV6QGtlcm5lbC5vcmc+DQo+IFRvOiBTYW1p
IFRvbHZhbmVuIDxzYW1pdG9sdmFuZW5AZ29vZ2xlLmNvbT4NCj4gVG86IEFhcm9uIFRvbWxpbiA8
YXRvbWxpbkBhdG9tbGluLmNvbT4NCj4gQ2M6IGxpbnV4LW1vZHVsZXNAdmdlci5rZXJuZWwub3Jn
DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IFBo
aWxpcHAgSGFobiA8cGhhaG4tb3NzQGF2bS5kZT4NCj4gLS0tDQo+ICBrZXJuZWwvbW9kdWxlL21h
aW4uYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9tb2R1bGUvbWFpbi5jIGIva2VybmVsL21v
ZHVsZS9tYWluLmMgaW5kZXgNCj4gYzNjZTEwNmM3MGFmMTY1ZTJkYzFhM2M3OWY1YTA3NGE1YzNl
M2QzNC4uN2Y2MmYwNjIwZGNkNzU5NjBlNDMxZjdhZjNkMQ0KPiBjYWRmNGNjNDFlNGIgMTAwNjQ0
DQo+IC0tLSBhL2tlcm5lbC9tb2R1bGUvbWFpbi5jDQo+ICsrKyBiL2tlcm5lbC9tb2R1bGUvbWFp
bi5jDQo+IEBAIC0xNTUxLDcgKzE1NTEsNyBAQCBzdGF0aWMgaW50IHNpbXBsaWZ5X3N5bWJvbHMo
c3RydWN0IG1vZHVsZSAqbW9kLA0KPiBjb25zdCBzdHJ1Y3QgbG9hZF9pbmZvICppbmZvKQ0KPiAg
CQljYXNlIFNITl9VTkRFRjoNCj4gIAkJCWtzeW0gPSByZXNvbHZlX3N5bWJvbF93YWl0KG1vZCwg
aW5mbywgbmFtZSk7DQo+ICAJCQkvKiBPayBpZiByZXNvbHZlZC4gICovDQo+IC0JCQlpZiAoa3N5
bSAmJiAhSVNfRVJSKGtzeW0pKSB7DQo+ICsJCQlpZiAoIUlTX0VSUl9PUl9OVUxMKGtzeW0pKSB7
DQo+ICAJCQkJc3ltW2ldLnN0X3ZhbHVlID0NCj4ga2VybmVsX3N5bWJvbF92YWx1ZShrc3ltKTsN
Cj4gIAkJCQlicmVhazsNCj4gIAkJCX0NCj4gDQo+IC0tDQo+IDIuNDMuMA0KDQpSZXZpZXdlZC1i
eTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo=
