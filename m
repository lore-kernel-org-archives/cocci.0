Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D931049516
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=rHSTPR8Fc9A1kcEr9BNgQ3H6ENCSh2fOQze/dBJ1Cc0=;
  b=Gd8xFbUOP8t1qAz0UcSUO72xu/GGrS4zji4X6XGwoy0ZOnmLxoB2QOqa
   mqSwbOWCXpSgHJcy5H7MlNnNkCPTdAENWvuSXpU1mtiZVfbHHn2gTTONv
   /H9QlUkpskjt0vzTLN7UGQq9t+MLagHOxPNFRl+7uACPTGl7bOOau8tTS
   A=;
X-CSE-ConnectionGUID: +9pGl5fUQMyPzQtnziXWHA==
X-CSE-MsgGUID: Df0tr2yPRqaI9HKcMzz41w==
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
   d="scan'208";a="267245923"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:17 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 06F76818C6; Wed, 11 Mar 2026 10:46:17 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id DDB5F8064A
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 09:18:15 +0100 (CET)
X-CSE-ConnectionGUID: cdJLqOYKS5yazpI1fsJ3qg==
X-CSE-MsgGUID: ZZLd9amYSqqQmspnKAtWPA==
IronPort-SDR: 69b12545_layXwzpdb9I+rXP2ym1L7NogxCI1smrEQWdmUtpFVgSKZQU
 +k5KdoPHJCSBt0gvwZQF2yBjI7Syt6fDUOi/e8g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EZAQDQJLFpjxFBr8ZaHgEBCxIMQIFFC4FuU4FoMQRUh?=
 =?us-ascii?q?FiDTAOOJQOBE5tcgSuBQDUIAg8BAwELAQEuIAECBAEBAwSFAAIWjQ0CHgcBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBAQEBO?=
 =?us-ascii?q?QUOO4ZPDYJiAYEkXgcJOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BH?=
 =?us-ascii?q?gEBAQEDAREREQwBATcBCwQCAQgOAwQBAQMCJgICAiUKFQgIAgQBDQUIGoJgg?=
 =?us-ascii?q?iMBBkoDAQICoXABgT0Ciip6gTKBAYIMAQEGBATeCQkJAQoBgQouhTyDFwEBg?=
 =?us-ascii?q?XCCSoEgARmEAHongWVDgRVCgjA4PoQKOxWDRDqCL4M0jE2GVglJeBwDWSwBV?=
 =?us-ascii?q?RMXCwcFYUIQMwMgCi8tAhQNEBIPBBYFLR1wDCcSDx0XFB9YGwcFEiEqB4FBe?=
 =?us-ascii?q?IFmGw+GaHkDLl4aDiICKBIDMgQjgQYLWgWCLAIcAwttPTcGDhsDBDp7BY1rP?=
 =?us-ascii?q?YIUHwEBgQ2BBz18GJcsr1YDBAOEHJlciDIXqmsuh2WQcyKodAIEAgQFAhABA?=
 =?us-ascii?q?QaBaDqBXHCDN08DGQ+OIQwNCRyDQo89AblwRTM8AgcLAQEDCYVGAQGMIjSBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
 zBz5g==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:X7ElW6saAN9vLXs60YWxDbiW7skDZ9V00zEX/kB9WHVpm5qj5q
 OTdZUgpHrJYVkqNk3I9ertBEDiexnhHOBOkOss1OyZPDUO0VHAROpfBO3ZogEIcBeSygcy78
 hdT5Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AUIUM3GnTfsRuhlrERTpOv2ZM5evXOXbR7lPJBH6?=
 =?us-ascii?q?bMjt4Qa+NaAae44E/isU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AeT/q0w77Cp9m+ALxfH6v79vixoxa0YCiWUkIoK4?=
 =?us-ascii?q?fovCBLjR2GB6BswyeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="140997928"
X-MGA-submission: =?us-ascii?q?MDGCGfKNVbkjEQj/dHnRLa7YleEBjqz5ACvcy2?=
 =?us-ascii?q?nJGv6i0536qi9m9D4DMovMn+a16pNA7VejDHtA+I3V4Rvc6m1lRnPEz1?=
 =?us-ascii?q?B0Dtlf9qUxlRKo/Sbnl1jZkr0zPtDYuBaoLFkKA9stx3GZRCx6vAeM3y?=
 =?us-ascii?q?r8RDVGlb8PcIkMydSp6w8GoA=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.17])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 09:18:07 +0100
X-CSE-ConnectionGUID: hbdOQDtqS8igYUEbyuRTuw==
X-CSE-MsgGUID: uRs/VcikQC6trHspztsalw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74249441"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74249441"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:18:06 -0700
X-CSE-ConnectionGUID: Hhe6i8ySQPa1KWece/+b8g==
X-CSE-MsgGUID: muxfWZe6Tw6D9HQb+gLyPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="224857183"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:18:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 01:18:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 01:18:04 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.23) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 01:18:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mL8svBQNKmw/8mtSvlf2JIW+8FxyS1RH8RujcMGnqIrU6PE0pSCQCGW6orrobOk3d+Qqs0MwBMYcTSiLso2GVCQLryZr7ve4sSek8OTw3pLhTOAIiS/mScFmL1V+tpL4QU8nXPg0QJWVtZ6jEIB4Sul9bZMhbvVMpIVLZCbzF0vaF60XAKR+lPFPorKThoxvgQiN2FVV0RPN0D+0QHlHgGo6q1NsTQCXPClrColCxjKjjhXk7ytVAU8IBR1WfwuA/NwZEeLG2x/R3vb82hlUqjIRqRCMSq6CoiGRufdpoSfsNMzS/QRJxw2P3cPd22/Oxaz1zavPeVKNFEaQ7K1r0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHSTPR8Fc9A1kcEr9BNgQ3H6ENCSh2fOQze/dBJ1Cc0=;
 b=ah5CXqMy7Do+WJ9plSBMqsIWm9msnWzxQG3DgJEjUJStONsj+1qroIhag9aNQQbJKA1lWCegeTAYlytc6Tkk2b0MFIhcXUW4lkJsVZWJStdiRvuz/Qsjy1zL9Hz+PRVKG4El9NlL/D/U1qtiw4G4bJssFK8HwGYtLpjcsTbx2rAjg811TeYUMAUmgWSbrd+lSp1VN5FucGBRTqUpZy0wZ/m0FVBDOKdtCtEy/loTCKYEJ6sFefpIUvKdm3MCZP+rVk+fINU7M3K7E5vUe0DfSLFkNFeu/+4m7Blh/ozrb6/zN3QzKIn9ftDPjB9v3rL349I7q6oGwhFvY2zcR+lzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV8PR11MB8510.namprd11.prod.outlook.com (2603:10b6:408:1e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 08:17:57 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 08:17:56 +0000
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
CC: Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
	<lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, "Christian
 Schoenebeck" <linux_oss@crudebyte.com>
Thread-Topic: [Intel-wired-lan] [PATCH 06/61] 9p: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Index: AQHcsKKDga63OVEHpEC6YaWFyczaH7Wo/acQ
Date: Wed, 11 Mar 2026 08:17:56 +0000
Message-ID: <IA3PR11MB8986DF184F43C9374B8A7735E547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-6-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-6-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV8PR11MB8510:EE_
x-ms-office365-filtering-correlation-id: 5b5ab855-410b-404c-df48-08de7f46b385
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021|921020|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 6rDIySybMEnrEtdINr8k5jYWFGk8tGETDyo7F47FsEs2kMQfOvBZpAEQatb2K5j5ba0H/ZnUKTlyVgDIHPUOdISEsD2JcGuzuWM2tLNvSgKyu/uxYe4lZDdxnx7k1ojHaZvToL0delNFlXnFDB0nAktpwIhjqHaLXFsoc+4GByTOnjlSMMZ7KUrq+6++Bgiq+O1Mj4ufCZKHxXpa+EPJszUnKaVoXkSiFZ3b74gfVTUCiHtDu2LwF1QCypkl6/4mAAmVDJDA/Uaf9FT5wkDwAq66pvnDzWJhMYqEXXRN8MY5mvX2Kffk9N97BX7tbUFGFCzylPMu/MH5y+0yxkqIJ7xzwUMFySm687PBUj52++g9lJ+EMuEAWFI6BT00dRSx2msRhrWj71pprY+783ksMzmFkfKy6Dhp0F73qeovM8SQ7joY4qouGvbRtfI8YQqbBo/lvKGaY1cdbCKq8zbwRtwppkrur1my3rSAazmyCL2PTyC83GwC3IcNkGtmQU46210aqn2QbjHOMfHARazZrxZB+5HVJG5B4kaJvamypCshm8Jg1SsCQlyHlpyqb4pVW+9NPWBkKnUbinEBZSTcidL0qQK7JymFLTd4ODfQLuB9vPlLk5eKDoWnL7lhMpa1nNXgek1mf7neEuZJGCWczr1ll6M9dbhjjsNvfICX/ZgRVdae4zAotC2Ig9WGoYH7U2gJ4uHvDf97GnMxb7GZyrtkzchjEdX+P/iBelbNbkQPtoo4FD7hGj8jJIYM1EKPcAtnOnwLOIzmNTT/xEivtELHoERlnQ7QssO1MG7syDWPzlp7MUyim+knN/0Yvwc3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEZHWVdxTkNyZlZDTUljRWpJNCs1OS8vOU9vUWRiSWxDVEgxWmZiSlRmbnU3?=
 =?utf-8?B?MTdPMXBBdkFLYlVpcnMyS3F1dllxTzZXNWFTR3czSk9jUVd4NjE5ZlpCbVNS?=
 =?utf-8?B?UlQ3eDFoQkUvbTJqMTRMNkEwenh3Ui9CaG5od3pORkpWT1dxbXR3bUVtRWU1?=
 =?utf-8?B?RnViNXpDckF6bUxkdnlSdDZ0MG84bzU1OG9OS1lSR1p1MUhTL1ZVUlZ1UzMz?=
 =?utf-8?B?ZEF3WWpyNFNrWUp5c0ZaSFBzVVJzTk1EOE9lZ1hyWFQvaEh6djJ3Uzh0VlFT?=
 =?utf-8?B?aTNKQmFKVE1qYXozUTMvS3Q4UUlNMUVkV1Y2TWVGd0JLSWc3aUdjK2ZlSWJQ?=
 =?utf-8?B?aXI0SHJEOUJvQ3NVUVRPRzVSUTJJT2Q0bHNxd21ZdldFeDRsaXZzZ3JNd0NL?=
 =?utf-8?B?U1ZhM3ppUTJtbHViTU95WnNCeURSdVQ0QjVERWVrQSsvTU1OUUtLaWlvcUFS?=
 =?utf-8?B?ZjZidWk1anM4aUJ6WmlGdzMybTgyNDBlSVFqUFFIWmUwT2c1NWhxN0MrcW5P?=
 =?utf-8?B?SE9HNXBKeHpWZ0JYZW5UaDVwaERycUFzY0doRVFrREg3bjhIdHJQenRMbmwz?=
 =?utf-8?B?STJ6Nmd4RXRydmw3RDB0SEJ0MHI5TDEvT0FnSndoVUFzUExXQUJmQlRNSjU3?=
 =?utf-8?B?UzB0ODVzNW5pQ2VGQ2lsTXJXN2JvY0F0dnUvMmJNelFEcjU2STRPOU9yNGh5?=
 =?utf-8?B?QWFLTDNwTDRRdTdXcFQ5NFVybEpnamN4aURmNFlneVVQcmdRTSs0NEl4Vktt?=
 =?utf-8?B?bW9VazFvVi9zallyNWIxNkRvTHpKazVPZ0NObEVUK3hrUjRRdTVwNytnMHl4?=
 =?utf-8?B?MWVrMmZybnZiNlpvL3d2YWJQcEdWWjlJTElaNFQzb1FFb0g3cmJVcitCOVRM?=
 =?utf-8?B?TmhjYks3QU9yOEc2bHBNVm9XMFM0T0loNEcrdi9DNDA5M0dhUFZFMVNzMHZM?=
 =?utf-8?B?QUNRa1dya2F4UWZaZGRMVUpRdHpnUXk1Nldxclp3ODhFWW9MUTZnRFJma2ts?=
 =?utf-8?B?c3Y1WCt1OWEySlJLWExLVlp3ZkN4eVZab1Q3bVdwTW5QSzZ4TUhlMzBlbjhU?=
 =?utf-8?B?UTVKakhIcUM3c2ozQThUN01heDFFNVUxV0VUQ2FlTFM5MW9JcGs1d3daNEJv?=
 =?utf-8?B?bXZacmdQYW1CTDFEbjV5QklXQmZTVmpyOTJ2MTFVQjdiRy9lQTFpNTZzMklE?=
 =?utf-8?B?cU9xQUNqU1RWWm16UEk1VE5PSnlxK0dReHhBU0VmM0JiSEN3cGVSTTR3SnZZ?=
 =?utf-8?B?ekpoNEtxT0REREQrUkhQOTFCdHVQdmViSXlDaTN4N2NnbkpHZ2ZpUTY4dG9Z?=
 =?utf-8?B?dkVOc2VXNStTcFdUaHovRDNDRUY1UUZuSSsxTFo1OTRwVmNta0xKdmdKTGxZ?=
 =?utf-8?B?a0FmVzNXa2Zab0grbk9jTktyZlFLYXZna05XQ29tOFhCZUVvaEhMeVVsSU5M?=
 =?utf-8?B?MWJ5b1VhaXlsbkhlSERHZm5ZODBjaVAwdU15NWtJNlJyVElxTWwyUDRxZmlz?=
 =?utf-8?B?c09RVmRIdWdpNG15eFBhZ2pYR1MyU2oreURsWnZnOEd0YjAxa3RyOFdrSndk?=
 =?utf-8?B?enlnMjlrSnBkbTQ1ckdJSFZwWWZZb0NSWTY2S1o4amkyVDIxUWo3VDB2dHdT?=
 =?utf-8?B?WERRTC9pVWVxSE1mdjkydDBjTWh6R215UDFQcWZxclA1ZUIrN1NyYXN0cFlE?=
 =?utf-8?B?M0E3ZlZQTHRUZm9hZEdyVndNdHRLLy9LQkdsbjBaQkNLODF3UXpydkI1d2Zj?=
 =?utf-8?B?S21iNGRleVA1bFdpZVBPRFgzV1lnRGZna080N3h2RDhuR2ZMRTZqN3d1U3VV?=
 =?utf-8?B?d3FNRHRaQWpFNDZ4ODhKWDgwRDhkcndlZmRNQytIVllVcVlvYWZHVWx4K205?=
 =?utf-8?B?cTA4TmdSV0JJejluMXRvMXpBMmFadi91WEJUTmtYM2xnYllORG54N284ZVVj?=
 =?utf-8?B?NTlMWitpNFBmcXFRREphKy9NSFdzU3p2TE52ZERTU1piN0haK2duR1FtK3pN?=
 =?utf-8?B?Y3Q2SWE2aFZYaTc3OFhOYzduZWtBVFZNTlU0U2thQTdMTjRXWEhyMVdJWkFU?=
 =?utf-8?B?VmRDNFBaRDYxOVJMdnM3TTl4MHlzbnRJM1RPckRwbTE1WkFteHBBM2wwRFl5?=
 =?utf-8?B?bjhvMDdlSDBLVE5XbGYzdHJTc3lCcU9sNE1LMHZHRkpQcHhXT1RlRUErY0Jt?=
 =?utf-8?B?VXRTamNyWXZRMGYzM2pKWGZ5bjk2Z3NPa25ncWkxeExhRXhZUlZvVjVVMzUv?=
 =?utf-8?B?cyszUU1nMFdrUzI5MC9QcjR2c3dHL2pqdFV1QjhDekRSMGhjMzU5WlhobDlL?=
 =?utf-8?B?dmUxZlh4aGdxUktZNy9iM0J4Y0w1eEhGSkFtbVRXeG5OZ0Y3TlF0emNDbWpN?=
 =?utf-8?Q?IDe+ZmwHwp+2VO6o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: USw/wKHP68g1t56EH6siG7zPpyocD42Cu4vWflTDaMTguNZOaT9sPsucGnvHksNlMqdOMvn8ggcqsA4MnMXXmV+qcROA1KdgumK09PT3bgSG/u48PbpHQQZdmSXbyfrSG4REn5n7D7KP0Qb5vJGBbzWdWTnxklwqPRPFzXxy1QKl2feOGmPS0TAs/niD5OjhYle2zcTqs3i51pW+GT3Uiz5eFpOWjJIT7/s5caAqF6/mnU73L2AMjxG+X5g9wDIP7KoRZzACzaQdF2xQTiZjwH50DgfiomRjcdqzwC7f88mNqbXtZQ9Gm8Dn40liAQLZfSYiRZV4a92/S7OTf084yg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5ab855-410b-404c-df48-08de7f46b385
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 08:17:56.9092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W68ONACbRXrFUYzV7oSeFHRa5YZyG3+ltabAb3fDtAr9g1RN1zo3PBObktdebn+J5Cyze5fLQUBtTpvdulDRemsIZPtbnN+HE6XWLYpSSTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8510
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [Intel-wired-lan] [PATCH 06/61] 9p: Prefer
 IS_ERR_OR_NULL over manual NULL check
Reply-To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 3395
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/ioob2uARULHuUMkNFIokZQ>

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
bS5kZT4NCj4gQ2M6IEVyaWMgVmFuIEhlbnNiZXJnZW4gPGVyaWN2aEBrZXJuZWwub3JnPjsgTGF0
Y2hlc2FyIElvbmtvdg0KPiA8bHVjaG9AaW9ua292Lm5ldD47IERvbWluaXF1ZSBNYXJ0aW5ldCA8
YXNtYWRldXNAY29kZXdyZWNrLm9yZz47DQo+IENocmlzdGlhbiBTY2hvZW5lYmVjayA8bGludXhf
b3NzQGNydWRlYnl0ZS5jb20+DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCAw
Ni82MV0gOXA6IFByZWZlciBJU19FUlJfT1JfTlVMTA0KPiBvdmVyIG1hbnVhbCBOVUxMIGNoZWNr
DQo+IA0KPiBQcmVmZXIgdXNpbmcgSVNfRVJSX09SX05VTEwoKSBvdmVyIHVzaW5nIElTX0VSUigp
IGFuZCBhIG1hbnVhbCBOVUxMDQo+IGNoZWNrLg0KPiANCj4gQ2hhbmdlIGdlbmVyYXRlZCB3aXRo
IGNvY2NpbmVsbGUuDQo+IA0KPiBUbzogRXJpYyBWYW4gSGVuc2JlcmdlbiA8ZXJpY3ZoQGtlcm5l
bC5vcmc+DQo+IFRvOiBMYXRjaGVzYXIgSW9ua292IDxsdWNob0Bpb25rb3YubmV0Pg0KPiBUbzog
RG9taW5pcXVlIE1hcnRpbmV0IDxhc21hZGV1c0Bjb2Rld3JlY2sub3JnPg0KPiBUbzogQ2hyaXN0
aWFuIFNjaG9lbmViZWNrIDxsaW51eF9vc3NAY3J1ZGVieXRlLmNvbT4NCj4gQ2M6IHY5ZnNAbGlz
dHMubGludXguZGV2DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25l
ZC1vZmYtYnk6IFBoaWxpcHAgSGFobiA8cGhhaG4tb3NzQGF2bS5kZT4NCj4gLS0tDQo+ICBmcy85
cC9maWQuaCB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzLzlwL2ZpZC5oIGIvZnMvOXAvZmlkLmgNCj4g
aW5kZXgNCj4gMGQ2MTM4YmVlMmEzZDFhYjU2NWFiMmQyMTBjMGEzZjNiZjk3ZTRlMy4uM2JiN2Vm
NDM4MGU5NzJhMmQ5YWI2N2ViNGFhYg0KPiA2Y2M1YmZlMmVlYTcgMTAwNjQ0DQo+IC0tLSBhL2Zz
LzlwL2ZpZC5oDQo+ICsrKyBiL2ZzLzlwL2ZpZC5oDQo+IEBAIC0yNyw3ICsyNyw3IEBAIHN0YXRp
YyBpbmxpbmUgc3RydWN0IHA5X2ZpZCAqdjlmc19maWRfY2xvbmUoc3RydWN0DQo+IGRlbnRyeSAq
ZGVudHJ5KQ0KPiAgCXN0cnVjdCBwOV9maWQgKmZpZCwgKm5maWQ7DQo+IA0KPiAgCWZpZCA9IHY5
ZnNfZmlkX2xvb2t1cChkZW50cnkpOw0KPiAtCWlmICghZmlkIHx8IElTX0VSUihmaWQpKQ0KPiAr
CWlmIChJU19FUlJfT1JfTlVMTChmaWQpKQ0KPiAgCQlyZXR1cm4gZmlkOw0KPiANCj4gIAluZmlk
ID0gY2xvbmVfZmlkKGZpZCk7DQo+IA0KPiAtLQ0KPiAyLjQzLjANCg0KUmV2aWV3ZWQtYnk6IEFs
ZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0K
