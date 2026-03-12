Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABB3105F78F
	for <cocci@archiver.kernel.org>; Fri, 13 Mar 2026 10:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=S2r3mEx4jaS69b6pg4TeplPYQyNYaMq5f3Q1pXlTbJ4=;
  b=Jhddjk57xTMVz4bRCSrW/LCZcqJHR09Kx3sDwnGY5MpTy75EeD4PEEsj
   l4I8rSNP3Q/DPsSXj9m1CnTJopPu6lAxE4jfAq7gVP5r6XnaB/gBGuvLg
   0rnE2zICvIVzlkNl5Ukc3tf2dE4eNe/rsadRldVc6/XkEKh1Bek/1Epz2
   o=;
X-CSE-ConnectionGUID: Uk+XXO+JS8qoo164Kg9fMQ==
X-CSE-MsgGUID: 9hYZhMT7Tfu4epKh9r0UBQ==
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
X-IronPort-AV: E=Sophos;i="6.23,118,1770591600"; 
   d="scan'208";a="267642896"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2026 11:19:48 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1D54981D16; Fri, 13 Mar 2026 11:19:48 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 3623E83591
	for <cocci@sympa.inria.fr>; Thu, 12 Mar 2026 17:12:45 +0100 (CET)
X-CSE-ConnectionGUID: VaSF7iXKRv2SmBQseOYQVw==
X-CSE-MsgGUID: Ttf3e9yCSuCxNqfRARPVLw==
IronPort-SDR: 69b2e5fe_jscjpDmeWEFz2PrWAd6WKBPzY6wBuf/CK0ergGDumsMZVpm
 7il5TfJ8sjr+uYmvXhrnO28p4PHX35Alm7ehjtw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EBAABJ5bJpjwxBr8ZaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgT0DAQEBAQELAYFtU4EHYTEEVIRYg00BAYwEgiEDh?=
 =?us-ascii?q?DuHKZELgSuBJQMYNQgCDwEDAQsBAS4PEQECBAEBAwSFAAKNIwIeBwEEMQgOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQEBAQE5BUmGT?=
 =?us-ascii?q?w2CYgGBJF4HCTgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAQEBA?=
 =?us-ascii?q?wEREQQRCAEBNwEPCw4KAgImAgIgBwolBg4FAgEBHoJgAYIiAQYRAzYDAQICD?=
 =?us-ascii?q?AaiZAGBPQKKKnp/M4EBggwBAQYEBIFQQdkWDW6BZwMGCQEKAYEKLgGINB8Bg?=
 =?us-ascii?q?XCBd4FzGoQAeieCKIEVJ4MDPoIfQgSFOYJpgzSJB4NDhloJSXgcA1ksAVUTF?=
 =?us-ascii?q?wsHBYEjQwOBBiNLBS0dgSMhHRcUH1gbBwUSISqBRHiCAQ+GaHkDLl4aDiICK?=
 =?us-ascii?q?BFcSj4LUgWCLQIfAgELbT03CQsbBI8lPYIzAQEsNC4pAltygSqSagKDKwGOJ?=
 =?us-ascii?q?qEIcQeEH4wejT6CAIYBBg8EL6prLodlkHOOCYQJlwQCBAIEBQIQAQEGgWoDN?=
 =?us-ascii?q?TyBIDMaI4M3TwMZD44hCQMNCYNehRPDUEQzAjoCBwsBAQMJhUYBAYxWgUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 AI7jk11ZuF/rF/R
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:dvUANaj2tQdR+F9ZmMCaTXJuJHBQX6d23DAbv31ZSRFFG/FwyP
 re58jzhCWE8Ar5BktQ4OxoWJPwO0819fZOkPss1MSZLX7bUQyTXclfBOrZsnTd8kjFndK1up
 0QDZSWZOeAeWSSyPyKljVQcOxQjeVvkprY+ts2pk0FJW8aDtAFnmAJbHfnYzFLrUt9dO8E/f
 Knl4B6TlGbCAQqh6qAdwo4tqT41qz2vaOjSyQrQzQg7w6Dhy6p7rnVLzi0ty11Mg9n8PMJy0
 SAtxb2yJmCnpiAp3/hPzi51eUcpPLRjvdTDs2FjcYYbg7rlhupY4pZXbiDtiAeoe2k6lom+e
 O85SvIeP4DiE85M1vF5CcF3TONv0dN11bSjXujxVfzq83wQzw3T+JHmIJiaxPcr24tpst13q
 5n13+Q88M/N2KGoA3No/zzEz16nEu9pnQv1cYVknxkSIMbLJtct5YW8k95GIoJWAj69IckOu
 9zC9y03ocTTXqqK1Ti+kV/yt2lWXo+Wj+AX0g5o8SQlwNbmXhopnFohPA3rzMlztYQWpNE7+
 PLPuBDj7dVVPIbaqp7GaMoXda3Inale2OWDEuiZXDcUI0XMXPErJD6pJ8v4vuxRZAOxJwu3L
 zcTVJjs3IocU6GM7zX4HRyyGGRfIyBZ0Ww9ikHjKIJ5YEUBYCbaBFrcWpeyfdJ+J4kc5Pms/
 XaAuMWPxasFxq+JW9z5XyxZ3BjEwhTbCQrgKd1Z7uvmLOJFmS4jJ2YTB+UHsu8LQoZ
X-Talos-CUID: =?us-ascii?q?9a23=3Az8xzYWp6swBBPh7a+n+WiMLmUf4sSVOCzUfzGVH?=
 =?us-ascii?q?iMmNDcaaYbm6pxrwxxg=3D=3D?=
X-Talos-MUID: 9a23:9RhYOgsEvmpQHJ+sJM2nuC1sb8o58o+VFWsdt4wIgeC+DRJUJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,116,1770591600"; 
   d="scan'208";a="267533606"
X-MGA-submission: =?us-ascii?q?MDHDWjT4eTxMS2gxf2mz4daA+3tHlr5ClcRBJw?=
 =?us-ascii?q?XXZMqc1Sq+phpKDel+XPVV8vhn+AEpqo+N6GhJ0Pour5KPBfuonWJXaU?=
 =?us-ascii?q?CKg05r0Gj78g1pBRVfaJpVPtmMQIQYVn3Jny9QVQqgNyuYufil6EDaz6?=
 =?us-ascii?q?bOx0j06jEk/JQMlBKkphPshQ=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 17:12:45 +0100
X-CSE-ConnectionGUID: tr2DsVfwSBKrvfRgffq1qw==
X-CSE-MsgGUID: c4WIGLJnRsOvHaNvlb50WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="85910027"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="85910027"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 09:12:42 -0700
X-CSE-ConnectionGUID: wo9a9boLQ3W77nLAysyVeA==
X-CSE-MsgGUID: UCZc7QZASc6MQg3o49dwnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="221051544"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 09:12:26 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 09:12:16 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 09:12:16 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 09:12:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQffyITYkzTS7flG4mkV7DfqRy6p0yvoelsD1vPvzqmebccUjnkt1BqsOASVKXX4x3BQJ0/fhMjJjYTbKnlf3lvYGmjtJVizJ69cNSh5jhuSL2AQ01AGkoVtcw3unypqT9dvuaTwpqb+jjgJ7vlCBtf1HWVN6s4fqOYqq9QZwsk1A9WzGZGdEs/5dSSqLdPPfixlVnwkDluMZyAhItvv5kGdMIcI6g35NEL5jpCBIoBM372SFwDMdrPpAdQ5KcYZcdMKZRMeyPvTlVgDa8AjH2VNO5QGAihTlm5OehOlbQf/y69qehIByv+JbnNkYOFrLMG4EmrTpDQKs37UJp4uYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2r3mEx4jaS69b6pg4TeplPYQyNYaMq5f3Q1pXlTbJ4=;
 b=BztW+Cme5OBlZFfQyBCT3cw5ysoYvV9bvxO9E6neEsl0PT5FFXC3+hYCwymttBgqy/O1ZLFwr0kDKiWbQkgNkrKS4GIU57Keqr5x34a5354EeTMbgD3X8v5XNkdeHaxX/rr3vxJFgx2JDRU8FQbxz4nMP5ci3XJHEh43dAgT8+mP0ZXNwXUvKgg+BXL7/+njvxLtEkUIMgxIflWkKsSVdgeYD4aMFtVpIeABrP99SEHA1GvIK5GAlGmSYhMUpM5kPkTPOM6wrwVlwR5CjOhT6Qgc7hMTjtxIa8k1CJOgDbe0WZCQKoI2qggdWbyMknWbNKzpzgNtgx2i25vyrDOpjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS4PPFDA9EFDFDB.namprd11.prod.outlook.com (2603:10b6:f:fc02::55) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 16:12:12 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 16:12:12 +0000
Message-ID: <0da51c50-3afd-464a-aad8-99e475a31339@intel.com>
Date: Thu, 12 Mar 2026 17:11:56 +0100
User-Agent: Mozilla Thunderbird
To: Philipp Hahn <phahn-oss@avm.de>
CC: <amd-gfx@lists.freedesktop.org>, <apparmor@lists.ubuntu.com>,
	<bpf@vger.kernel.org>, <ceph-devel@vger.kernel.org>, <cocci@inria.fr>,
	<dm-devel@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
	<gfs2@lists.linux.dev>, <intel-gfx@lists.freedesktop.org>,
	<intel-wired-lan@lists.osuosl.org>, <iommu@lists.linux.dev>,
	<kvm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-block@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
	<linux-btrfs@vger.kernel.org>, <linux-cifs@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
	<linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-leds@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<linux-mips@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-modules@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<linux-nfs@vger.kernel.org>, <linux-omap@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-rockchip@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, <linux-sctp@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-trace-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
	<ntfs3@lists.linux.dev>, <samba-technical@lists.samba.org>,
	<sched-ext@lists.linux.dev>, <target-devel@vger.kernel.org>,
	<tipc-discussion@lists.sourceforge.net>, <v9fs@lists.linux.dev>, "Igor
 Russkikh" <irusskikh@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Pavan
 Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>,
	"Potnuri Bharat Teja" <bharat@chelsio.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Taras Chornyi <taras.chornyi@plvision.eu>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Iyappan Subramanian
	<iyappan@os.amperecomputing.com>, Keyur Chudgar
	<keyur@os.amperecomputing.com>, Quan Nguyen <quan@os.amperecomputing.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-38-bd63b656022d@avm.de>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260310-b4-is_err_or_null-v1-38-bd63b656022d@avm.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR05CA0028.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::33) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS4PPFDA9EFDFDB:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0f9ecc-edd7-4e03-1a3f-08de80521e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|7053199007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0JzyEtz+ZbY+UJfay1MMx6cC7k0VDpTAisQfHr8ee8fhRS9oZ/3EkK0SYa4H9xO+17cqN8E+INuWd0bDOhg6KyMSzQi4RLCB8yuN8addTN8WfkoDEXNJd3uynlJwQMFvJpVc5/6mTD+E8XvzGrnqrFo3mdW0yJLnV+UL+VFlNvaI7d3JY+amn8fmczN5NWzLWPhGBAt2EMHTRLTc8v8nGb0g73JENOqONAlmDCfKE0GXQx238nSbuoRBzBGsrkpYLX0pGkMHDk5HsKqQySnqWHSIGAs9FIfiQ40DdaWm8mwqbOfnJpoxF8PSYWVX02H6lUXF2NuGRZVoW0O6iEmJTBTtk47r/Uob+aS0SdHobYpGy2JhDE1CFbFyiD8Rhr9YqFpB6I7pUC5CO376reeOmS1ggrEUisVWCJ8UCW/cm7uZVmRS7KJnFOPnJ0H1rbHeXczxrtg13GUOjBpAoeHkI6e72lLPv5Xj5OOdYD8GCbWA6bNGCfVjbZXkKtYzNhOp9gtoZ1NNYTLIklJDjukLNoia6KYo5rUKZkX3sMViba6m8oY1T/8y6T83Q7cSeVNXpdvgJ+D3rUuF66Bn29BhUp50Gss35pc8jsAIvV92tpazJssg2Yfv3zGruCBTbGG6uKoA/+Lyct3jhQyr2suol6i7dMGHlSURpaY/Y65Ye+icJJRzr306I9/r63LzJ5Kl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(7053199007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTh0emRrTjRWY2xrdUwrdmFCeDU4bmVmeGtUQTI5MnZ2MnQ5UmJtWFllN3Nv?=
 =?utf-8?B?WVZpMHFMNGREY2IxMllKYnY1UGxWanZTNlFHTGk1QjdyS0lvTVh4eU9BUkhk?=
 =?utf-8?B?L2tJRUJEN1RQdmlqUUtvY2hhOGgrSis2Y00wTC9uU0U4WXZuOUZWL25kWXNX?=
 =?utf-8?B?eXBRZkprWlpkUFU4M2RPckgxNlFBM0lCZnIxZzJpeWV0UmczVkMweGRHUFM3?=
 =?utf-8?B?Sjh6TWE3WVNJd21XM1RQODMzT1J3c2ZTa1NyUEs4dTdmMlNtQXlzZU5nVzND?=
 =?utf-8?B?K29aRHA4ZDllcmNWRFNZeDBRUTNheWd2dWNWdHY4RjJIVnhuRGNvRG93NVZv?=
 =?utf-8?B?dGhPVkUvYlJSbmhxZDJFMEF5TU5Bb3RkbjlvVktNQWVqWWlRSWMyNlFYei8v?=
 =?utf-8?B?ZFdzUFpFR0xseWs3ZDNRbW5qenowWXM3MEpjTldRc0J6eVdBT0prNTNqQUF2?=
 =?utf-8?B?SjloL0Jzd0lnSC8yTkFvMzJtemJzckxHeEVKU1FmcU5lcXcrT29BWGsvNmFB?=
 =?utf-8?B?SEE0ZlFaTlkvOUNHZDdjRDN2Vzg4Y1lEOFlRRitsOC9IOVJrSi93YnFyRnB0?=
 =?utf-8?B?d1ZjTm1TUWl4TnBQSytnektHR1hzWk1mT1BuTi9ZVlJyaFlWTVJjSnZ1WUo3?=
 =?utf-8?B?MEUyYkUraHNhcTRtMmNMa3VIS1ovVFlVbTYyc2NVMDlYN2svaDRHYmlpa0lz?=
 =?utf-8?B?RjhZaEF0eVZTUDJBREtqZTdaMkNobkkwTURGTmFHOFlnNGUwSTFSRmEvSmFF?=
 =?utf-8?B?TnE5RXp4MmZOeEFzZ0xUZTBZSlh0VWVnams3eWlpWTNOL1JmN3RleEExRVo4?=
 =?utf-8?B?R0JyVUg1ZkxnV21LSUtocHMzSDJ4bTdYTFpBK1VPWjVoTnBEU1NKaHRLUW1z?=
 =?utf-8?B?ODFUYTdUZm9ZUysrUm9pbEd5ZXZXd1J5ZGRsMjV6eXRmWVIvVUkva2FSYjVC?=
 =?utf-8?B?OUFyTVhNQ2xCWkJEdnNjUm1VM0VLM2lEYkVnazRSalVzQUl3cFk3UDhMcHBJ?=
 =?utf-8?B?U2pMWC93eUIzZy9QVGJGQkp6d21rRTR1R1gyWUdScVdkRVo5R1FTcDlvOGI4?=
 =?utf-8?B?cmNLeWdZKzJnaDlYa0xMSXNRamg3YWE5eWhsTldaS21jaUNDVHBKZGdOcEZT?=
 =?utf-8?B?V2wrZWNhOTBCVEdkMnpIdTNWdGt6MlJXTXlRdDIzanYreUEydGsrTU92SVFu?=
 =?utf-8?B?OHluS3JyS0RiR2N0UVU0V01Ub1l0K2hZVjNjeTJiVEFhTklBWm52eHRWQjI3?=
 =?utf-8?B?THByM21VZ3V2QVV2ZWJEWG5SbFNRZzdoR0lnM0F6aDBxSFU3aU1RbEZYa0VL?=
 =?utf-8?B?SUc5ZDRkWXRhWkRvamZxMlh6eDBGSVJJeHZnanBRU0FUaE5lcUZXMzB4WSt2?=
 =?utf-8?B?cFBNRC91b0FlaSthVXpjK1VnZXMrakl2enVYdFMrU09UZHNQbnY1dk15V243?=
 =?utf-8?B?UEdGL05LczgzTHMrUlRVNk9IallyLzFyb0xwbkxYZ0wrZm9PeUx2MXVwbzEx?=
 =?utf-8?B?NTA4Wk9GUlpFRElnUEpNNDZqODAxQ0F0ejdQS1JZaGtmd1V3MG5QYnZ5K1Rs?=
 =?utf-8?B?MGFTK3VsblR1M3dQaDB6NHhkV3pUaUFERTd4UUxQQjlSK2JsZjRQNForNENm?=
 =?utf-8?B?MFpKYjVWc21qOXBKSmR4T1F3TW9uaFpxY0EzWVZZZFRoMW5RWk5HdWNTMmJr?=
 =?utf-8?B?OWtBbG9XODhZNEphWURHbjdwYnNEUlNPcGRQNmtvNHhuSHZQN2VBQ21MWUxD?=
 =?utf-8?B?L04zYzQvRTBzc25HSGtLMHNBWlgzZTFud1VOUGdTVkhRU0lydExMZ1hiRUVk?=
 =?utf-8?B?OEo3SGtYelUxRW1QT05oNG1FVlB6WDIxc05TVU5EMVpQb0w0WjJIdVFVTnNG?=
 =?utf-8?B?eUhPZm5hZU1JeG5tbTRMbUNKR0h6R2xEaEdyWFRSWksrWnE4UkY5NkZlM2ZX?=
 =?utf-8?B?N0h6WSszYVZhQUVOREhCNDdlZmlXV3UvUFMwbG5sbWFjS3pPWEdnMlBqRGxG?=
 =?utf-8?B?ZWpmb1NNUWN6UDg3NVVwTlhKZGZ4RThBdUI5cFJjazZKWUhyTmZyRm9VZ0Nx?=
 =?utf-8?B?VmVXMXg0T0dtODErRndFcndkWG5EeGY5NGNsSDdoYTZRZFpLbDAwU0pDSnRD?=
 =?utf-8?B?NVRYS3RZNkZvRVEwVjNlajFJVTRVZlM0ek9JbnozeFBQY1U0c25BaFkzMGl5?=
 =?utf-8?B?bG1FZlBZdGxZTGdmSnFHdXdjR240OGZGR3JiQ2w4UE1YSHNaVVMydG9CZHo2?=
 =?utf-8?B?OVRkd0hTaENFTEhscWluWVN2N3RCOWUrTnRuTEs5NHRtWVoxK21LSDQvWnpD?=
 =?utf-8?B?WkhKZkp4U3dVVzE2VG9Fc0hERXRBdUFWRHlSWjdGMDNmUEZzYW1VY1lDNEtF?=
 =?utf-8?Q?lEcw5NvkT6Xp+YVo=3D?=
X-Exchange-RoutingPolicyChecked: k+VKSPAM7KWe+eF9eQg7nB4SNgLOqJ5F7bFdYbbZTeKXANRkNzvGEEYyC8gBkAnYBQbBnLETSuGZzhg7V4slfrEEpJGCeVVYiKSNWO4OGl7pZi68LFMzCHTPrtuvVgpFVD4uDxqt1/HNubsnanmP1G8FAl6IOpxVKnaoPEg/NVcU52Q0KSEBFFkAPBogHPZy7e9fZJLJe3ETdjYg9N6IwBd9le+DB9VqnLVHfYvwevLcu2RqYd8Pnb86MrH17SC1qPrVolB8jsGaZJmKP6DFKbBWzt6ba1ADz8SHmFKvpVy8K5W1mh+EmY5zJIOQfUYIOwbE9LGf9+WF/pWC99LnEQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0f9ecc-edd7-4e03-1a3f-08de80521e93
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:12:12.3882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEdWwkLUzCzbtdV4esOcW+KF0h2yXcJdE4EMktG7LaB1JizSgLunmzY78asDDAwWKzmb3uxKUCQCT5c3xwKLv6ET/L3+njS36DMvqibeYL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFDA9EFDFDB
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 38/61] net: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 3421
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/B5ELXJy3PLpDICiYjBWMoA>

On 3/10/26 12:49, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> To: Igor Russkikh <irusskikh@marvell.com>
> To: Andrew Lunn <andrew+netdev@lunn.ch>
> To: "David S. Miller" <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Pavan Chebbi <pavan.chebbi@broadcom.com>
> To: Michael Chan <mchan@broadcom.com>
> To: Potnuri Bharat Teja <bharat@chelsio.com>
> To: Tony Nguyen <anthony.l.nguyen@intel.com>
> To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> To: Taras Chornyi <taras.chornyi@plvision.eu>
> To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> To: Alexandre Torgue <alexandre.torgue@foss.st.com>
> To: Iyappan Subramanian <iyappan@os.amperecomputing.com>
> To: Keyur Chudgar <keyur@os.amperecomputing.com>
> To: Quan Nguyen <quan@os.amperecomputing.com>
> To: Heiner Kallweit <hkallweit1@gmail.com>
> To: Russell King <linux@armlinux.org.uk>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: intel-wired-lan@lists.osuosl.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

this is too trivial change, especially when combined like that
https://docs.kernel.org/process/maintainer-netdev.html#clean-up-patches

> ---
>   drivers/net/ethernet/aquantia/atlantic/aq_ring.c        | 2 +-
>   drivers/net/ethernet/broadcom/tg3.c                     | 2 +-
>   drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c    | 3 +--
>   drivers/net/ethernet/intel/ice/devlink/devlink.c        | 2 +-
>   drivers/net/ethernet/marvell/prestera/prestera_router.c | 2 +-
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c       | 2 +-
>   drivers/net/mdio/mdio-xgene.c                           | 2 +-
>   drivers/net/usb/r8152.c                                 | 2 +-
>   8 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> index e270327e47fd804cc8ee5cfd53ed1b993c955c41..43edef35c4b1ff606b2f1519a07fad4c9a990ad4 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> @@ -810,7 +810,7 @@ static int __aq_ring_xdp_clean(struct aq_ring_s *rx_ring,
>   		}
>   
>   		skb = aq_xdp_run_prog(aq_nic, &xdp, rx_ring, buff);
> -		if (IS_ERR(skb) || !skb)
> +		if (IS_ERR_OR_NULL(skb))
>   			continue;
>   
>   		if (ptp_hwtstamp_len > 0)
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index 2328fce336447eb4a796f9300ccc0ab536ff0a35..8ed79f34f03d81184dcc12e6eaff009cb8f7756e 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -7943,7 +7943,7 @@ static int tg3_tso_bug(struct tg3 *tp, struct tg3_napi *tnapi,
>   
>   	segs = skb_gso_segment(skb, tp->dev->features &
>   				    ~(NETIF_F_TSO | NETIF_F_TSO6));
> -	if (IS_ERR(segs) || !segs) {
> +	if (IS_ERR_OR_NULL(segs)) {
>   		tnapi->tx_dropped++;
>   		goto tg3_tso_bug_end;
>   	}
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
> index 3307e50426819087ad985178c4a5383f16b8e7b4..1c8a6445d4b2e3535d8f1b7908dd02d8dd2f23fa 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
> @@ -1032,8 +1032,7 @@ static void ch_flower_stats_handler(struct work_struct *work)
>   	do {
>   		rhashtable_walk_start(&iter);
>   
> -		while ((flower_entry = rhashtable_walk_next(&iter)) &&
> -		       !IS_ERR(flower_entry)) {
> +		while (!IS_ERR_OR_NULL((flower_entry = rhashtable_walk_next(&iter)))) {
>   			ret = cxgb4_get_filter_counters(adap->port[0],
>   							flower_entry->filter_id,
>   							&packets, &bytes,
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> index 6c72bd15db6d75a1d4fa04ef8fefbd26fb6e84bd..3d08b9187fd76ca3198af28111b6f1c1765ea01e 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> @@ -791,7 +791,7 @@ static void ice_traverse_tx_tree(struct devlink *devlink, struct ice_sched_node
>   						  node->parent->rate_node);
>   	}
>   
> -	if (rate_node && !IS_ERR(rate_node))
> +	if (!IS_ERR_OR_NULL(rate_node))
>   		node->rate_node = rate_node;
>   
>   traverse_children:
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_router.c b/drivers/net/ethernet/marvell/prestera/prestera_router.c
> index b036b173a308b5f994ad8538eb010fa27196988c..4492938e8a3da91d32efe8d45ccbe2eb437c0e49 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_router.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_router.c
> @@ -1061,7 +1061,7 @@ static void __prestera_k_arb_hw_state_upd(struct prestera_switch *sw,
>   		n = NULL;
>   	}
>   
> -	if (!IS_ERR(n) && n) {
> +	if (!IS_ERR_OR_NULL(n)) {
>   		neigh_event_send(n, NULL);
>   		neigh_release(n);
>   	} else {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 6827c99bde8c22db42b363d2d36ad6f26075ed50..356a4e9ce04b1fcf8786d7274d31ace404be2cf6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1275,7 +1275,7 @@ static int stmmac_init_phy(struct net_device *dev)
>   	/* Some DT bindings do not set-up the PHY handle. Let's try to
>   	 * manually parse it
>   	 */
> -	if (!phy_fwnode || IS_ERR(phy_fwnode)) {
> +	if (IS_ERR_OR_NULL(phy_fwnode)) {
>   		int addr = priv->plat->phy_addr;
>   		struct phy_device *phydev;
>   
> diff --git a/drivers/net/mdio/mdio-xgene.c b/drivers/net/mdio/mdio-xgene.c
> index a8f91a4b7fed0927ee14e408000cd3a2bfb9b09a..09b30b563295c6085dc1358ac361301e5cf6b2a8 100644
> --- a/drivers/net/mdio/mdio-xgene.c
> +++ b/drivers/net/mdio/mdio-xgene.c
> @@ -265,7 +265,7 @@ struct phy_device *xgene_enet_phy_register(struct mii_bus *bus, int phy_addr)
>   	struct phy_device *phy_dev;
>   
>   	phy_dev = get_phy_device(bus, phy_addr, false);
> -	if (!phy_dev || IS_ERR(phy_dev))
> +	if (IS_ERR_OR_NULL(phy_dev))
>   		return NULL;
>   
>   	if (phy_device_register(phy_dev))
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 0c83bbbea2e7c322ee6339893e281237663bd3ae..73f17ebd7d40007eec5004f887a46249defd28ab 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -2218,7 +2218,7 @@ static void r8152_csum_workaround(struct r8152 *tp, struct sk_buff *skb,
>   
>   		features &= ~(NETIF_F_SG | NETIF_F_IPV6_CSUM | NETIF_F_TSO6);
>   		segs = skb_gso_segment(skb, features);
> -		if (IS_ERR(segs) || !segs)
> +		if (IS_ERR_OR_NULL(segs))
>   			goto drop;
>   
>   		__skb_queue_head_init(&seg_list);
> 

