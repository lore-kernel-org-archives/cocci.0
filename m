Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA531049524
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=5RoLMOnUP13VcDZLe8DOkUtk65UsNylplQ/Hwrj5XX0=;
  b=IWHc/dKI2hfdRlBa7xTrsp0MHnCzkMwPlfirsq5a2MaYvdzVFzHS0+kx
   RPTTgyPI5uQ8P76F2qg+lqNcB1bkTHeK/1tKy6big+zlAUhvtejGwK5r9
   Rr10peVpZK80Ld2PnWjFREfDdTf5Hon6wCf9dYFHe2vP4DqE3Sds9OUzW
   w=;
X-CSE-ConnectionGUID: TS0PjqNPTYu9KDjIXylNFw==
X-CSE-MsgGUID: MViRJMwVS/G2znu9BrGzkw==
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
   d="scan'208";a="267246372"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:38 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 2253D818CF; Wed, 11 Mar 2026 10:46:38 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 8C3FC818A9
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 10:24:36 +0100 (CET)
X-CSE-ConnectionGUID: prf6qPZFR7yP3Ly1dfGlEw==
X-CSE-MsgGUID: QfaUijMZSF2nN/KISXo4nQ==
IronPort-SDR: 69b134d5_9g/fI5g60feoBk6PIzTCTdR6xo7cFZjr+UiLrl+r7uBnAOY
 nQGo6TarXa4PeY1wqDe/elH1JL9Quecbl3x0NZQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EFAAAINLFpjw+jxsBaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgT8BAQEBAQELAYFtU4FoMQRUhFiDTAOMBIIhA4ETi?=
 =?us-ascii?q?lGRC4JQAxg4BQIPAQMBCwEBLiABAgQBAQMEhQACFo0NAh4HAQQzBg4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAQEBATkFDjuGTw2CY?=
 =?us-ascii?q?gGBJF4HCTgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEdAQEBAQMBE?=
 =?us-ascii?q?REEDQwBATcBCwQCAQgOAwQBAQMCJgICAh4HChUICAIEAQ0FCBqCYIIjAQYRA?=
 =?us-ascii?q?zYDAQICoi8BgT0Ciip6fzOBAYIMAQEGBATbJw2CVQkJAQoBgQouAYU7gnkeA?=
 =?us-ascii?q?QGBcIF3U4EgARmEAHongWVDgRVCgjA4PoIfgiYVg0Q6gi+DNIxNhlYJSXgcA?=
 =?us-ascii?q?1ksAVUTFwsHBWFCEDMDIAovLQIUDRASDwQWBS0dcAwnEg8dFxQfWBsHBRIhK?=
 =?us-ascii?q?geBQXiBZhsPhmh5Ay5eGg4iAigSAzIEI4EGC1oFgiwCHAMLbT03Bg4bAwQ6e?=
 =?us-ascii?q?wWNaz2CFB8BASxigQY9fBhLkmoCgysBSa5lcQMEA4QcmVyCAIYyF6prLodlk?=
 =?us-ascii?q?HMikXCXBAIEAgQFAhABAQaBfiQ8gSBwgzdPAxkPjiEJAw0JHINCjz0BuWxFM?=
 =?us-ascii?q?wI6AgcLAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 G4H1sb4bwqPplojMg==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:uR7WlaDPg84czIzlHei6sseALOsnbusQ8zAXPh9KOGdom52j5r
 iTdaogpGbJYW4qKQcdcdDpAtj/fZquz+893WB3B8blYOCGghruEGgG1+DfKlLbal/DH4JmpN
 tdmu1FearN5DtB/J/HCWuDYqMdKbC8mcjH9IKuqwYLPGcaEdAc0+46MHfuLqQffngVOXNTLu
 vs2iMznUvSRZ1hVLXKOpBqZZm9m/T70LjdTVotARkh5AOSjTWuxoLbPnGjtHYjegIK640PtU
 zenSLExojLiZza9jbsk0PD5ZVfn9XsjuBEGNGNjcYtLDDtgBaDZYhqWbGO1QpF+N1Hr2xa8+
 UkpS1NULUQ11rhOkWO5Tf90Qjp1zgjr1X4z0WDvHflqcvlABonFston+tiA0DkwntlmOs5/L
 NA3mqfuZYSJwjHhj7B69/BUAwvvlaooEAljfUYgxVkINEjgf5q3NEiFXFuYcg99RHBmd4a+S
 5VfZDhDcNtAA+nhrbizzlSKZKXLycO91y9MwA/U4SuonNrdTZCvh4lLYUk7z093YN4RJ9e6+
 veNKN00LlIU88NdKp4QPwMWM2tFwX2MFDx2U+pUBTa/Zs8SjHwgo+y5K9w6PCheZQOwpd3kJ
 PdUElAvWp3f071E8WB0JBC7xiIGQyGLHDQ49Ab44I8tqz3RbLtPyHGQFcyk9G4q/FaBsHAQf
 68NJ9fHvemJ2rzHoRC2RH4RvBpWDwjedxQvsx+V0OFo8rNJIGvvuvHcOzLLL6oCjogUnOXOA
 pDYNEyHrQP0qmGYA62vPGKYQKhRqXWx+M9LJTn
X-Talos-CUID: =?us-ascii?q?9a23=3A7dyHWGknWhf5z4Yds2UUro8C7fzXOWXHwinJG32?=
 =?us-ascii?q?WMzl4cOaxWAac9oxgvtU7zg=3D=3D?=
X-Talos-MUID: 9a23:gGSZpgg2VjRA4i1H+bXXb8MpDclh3qWsLXI2v88AnY6nFBdAPGubtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267239274"
X-MGA-submission: =?us-ascii?q?MDH19M107DaHrpCWXuu5a1fVkxyWCafuuQTYRR?=
 =?us-ascii?q?vPpk8cylFB5CvZTgnWMT2OiBtuY7wo9fe9e/jblTJsZwS5Pb/gPSvByD?=
 =?us-ascii?q?5rezsHh/fOU7+Hsaf0MVJrdRxYZ2iCSY5+NoPPDzHndZLA45OLlopKvf?=
 =?us-ascii?q?+EfMrMOQ9FKTvYVK0EBDxRwA=3D=3D?=
Received: from mgamail.intel.com ([192.198.163.15])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 10:24:31 +0100
X-CSE-ConnectionGUID: GaBh/8pkQnOft1prj+vzyw==
X-CSE-MsgGUID: tOvqIXZFQ5uBGRaKoc/H6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74403633"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74403633"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:24:28 -0700
X-CSE-ConnectionGUID: XlPxWM9tSxuxy/R2m8bOgg==
X-CSE-MsgGUID: 1FQ9T3YETb+alF/y3zB6jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220442344"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:24:26 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:24:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:24:26 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.54)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:24:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4+obR+DUr1NWwPV/opT2BKJh5cML7CR20tMRhNWdIVCWngUB6pzmViltafc4aDRm55nkHXh2TM7mR7st8u9tFZxfVU1SKXLojgWQRvGac+YzVyLh1OfdMQIvXqJq2VkW4MdAnl9kIwLIuTwxCRwVeKgvpcvYR0X/z54xlfkdT59fzK1+cv5NVOp0P3Ka/RX66j6C5Wo38YNKA9g6ojB7TSZbBTooYeaGaSF4EMhqyFemSb5To6PE+n/adJDL8MXy8Mo74eAOWKGvTwoyApFeVMBqYYpVNMqUAyLoZB1I8YufPsAmo1xHgKWaBtS2wGz37ilXKYdOgTuTIq5FeoSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RoLMOnUP13VcDZLe8DOkUtk65UsNylplQ/Hwrj5XX0=;
 b=C6pGgAvmJtyJbfm2PTOG3k6NJQdDzvUvhD74MCZldYycKj2miReiyKckyYPInfpA9uAeQ98ghwAPbTe2itQFk2LVevWtFM5tbBH9vrKUn6gKowICmRixlKTv/E4CchxfNN56c4dZ41mGzvLJJ/X3YGj/pBt9WE3jyqgDe9qDV8YBglbLiB371dkd9+hWLNu8kgvmETk3pQrB+oH4Snu+vgYsbu+pyu6dKmxVIpdnX5pnJvTKjsYE+sdZa6krSYFuplswmu+ig/d7lFbCuStKUhVx32hAtgqoW07tVVtB4t1Hx61H9GopyGe4KqWQVndSHrD1NghJz0swgoU8/0pQng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7897.namprd11.prod.outlook.com (2603:10b6:930:7d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 09:24:20 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:24:20 +0000
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
CC: Igor Russkikh <irusskikh@marvell.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan
	<mchan@broadcom.com>, Potnuri Bharat Teja <bharat@chelsio.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Taras Chornyi <taras.chornyi@plvision.eu>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Iyappan Subramanian
	<iyappan@os.amperecomputing.com>, Keyur Chudgar
	<keyur@os.amperecomputing.com>, Quan Nguyen <quan@os.amperecomputing.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Thread-Topic: [Intel-wired-lan] [PATCH 38/61] net: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Index: AQHcsKKD4Ry70gA6uk6MEWNBv9uR1rWpEF0g
Date: Wed, 11 Mar 2026 09:24:20 +0000
Message-ID: <IA3PR11MB8986CEEF7657B227DE50BB7CE547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-38-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-38-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7897:EE_
x-ms-office365-filtering-correlation-id: 63193b5f-3977-438b-d8d6-08de7f4ff9e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: RgkrEof3rBWQFwe3FC5U4zx9z4zsXX197T2TnOA/LmSF1sXJiOcogItWd8nR52P67MFVsl294YF8lIK7qyuGP71/sFqcDuXC/PPs6sKebUAtadKRjL6erwv0g5zGPPBhMR+RiPTv18H0kLEnwNIZl4sZgRDSCBYPj+EVcZL4lqDWpjHJQv+ocpkZQX0f+C8+k5qmm/50uTUAJA2nXbNpWIf5ro+RwC5os6JQbBWXM8DuxIitv6eENm/ZwrV9DaSKm4LL4iQh95P0vV6On1lpP2N3O/jsLsYBBpDAe682AZv/YONWwDALs0CzkU9aVzMDzM/Lq2J3d8y0yJ+cuEoHTeOp6ChixF39mzZ9LYXxTs4qm005aEfANeh15vW9ljZ/s4jDYpb0sfnZ1zDvbx0nncPqc3wK4ENUrtaWG68vllsEsJeUWunovycH8UwPHu6NugbYZoFqbtjzFZSt0mjC6M+ao9DIurYQkhcQ+J/Tvr1HeFBYFlrgKkFBO3W7uBa2JCdk0ObImtjiwU91Chj7j5Z2MYnHnly19+MOB3RueyoXHhtxP0919zBkT8aqMsqlT6us5Z0Ud8GZjKr6KdnzBNQv+oC7/q0Uq6SFtz+h+SPxQV9LVE5x3VkNd14B3L3cVCaovzE27HT2HdRqFUFcbRkoQ7gvDFBN2qx+096pxYHUmCyhZ/peMsmjjtg0YKzxd5JYqpGx6B5wExqFVNAygcdlcMS4yY2Kg/cn9DZWE5Cxt5HQQLoifGZBhpyCl4DV3/79vhL/L2+lbem5ZF71pVBWKPZJCVKCLmjd5kpYALiNPBgbwHwazlKE7HI6g/BQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3JkMDYzeXV0aVc4VmVvV2MzYTNOZ2s1TTFUcUE1eU11azdybzVYaVZldzA5?=
 =?utf-8?B?aTBsdG5rcW8zNTc3Vm9yZXljV2ozUGQ1WXU1dTBzRDNQUmVrT2x3MCt5Rnhi?=
 =?utf-8?B?QzJpVmRkTzZaV251YkY0U2lsbmZFaFJJb2VzSHEzc3llckhSMU1WM1czYW1k?=
 =?utf-8?B?UVpKQXBBZU1OcnlYaHl0TUtIVmRuQlBqSVZDL2EwWnBtTEhVREl3U09xQjRJ?=
 =?utf-8?B?Z2M5L2pIVzlEalBVNG8wNjdiOXpSeE12UVdERjE3Q3paLy9GRG4waXhnZEp2?=
 =?utf-8?B?RUNXdDBHZm9NUkUvVWRYcGkrNkJPVGlyVWlFNTNHRCt5MzU2cy9uQTA1UkY4?=
 =?utf-8?B?OGtYTmNjL1k4U0tCTnI1R3hBV0R3TGI5UitLTmx4b1NqQkdBbStyQ2JHaWtv?=
 =?utf-8?B?WlFacy9yeTNyc3Q5bnlBdnVDUHFJK3VFZkJ5MFVyc2lWUlViSk41UENJYVlh?=
 =?utf-8?B?SndNUkx3WXdoVW9YNWJtQllmYmlOcEdvaTBXaE80UHY0QXBoRUZWdStBRFI3?=
 =?utf-8?B?VjNHOVMwMnMxSnRXMm9lVkl4RVBjWDF2YjFpa1JyR2srNHRGeFhrU1ZjVnVr?=
 =?utf-8?B?MklOcE5ic0IySFJCd1A0V2RaT2tyVnlHckxiNzRBam1OOWtPcmFnZVZIMWFF?=
 =?utf-8?B?YzVWSklMOFZMSUVDVndyOTFUNjNqZUJXb2hPRkpOOEJORzEvUkV4bHpyVlVD?=
 =?utf-8?B?ZENNM2RtcmVQa0JXTWxBZ2VmRzNNVUNGUlZiQnFWQVh0bk8zTEpMc1kwTUM0?=
 =?utf-8?B?a3JxS01PSER6N3FWQkJtUW44Mnc1YnZycktDZlFvR1dSNlpzUEQwbExuZ1Bt?=
 =?utf-8?B?NHAvRnlGMlQ5Qkd1Wll2SW1WeVh6clBsQW9CVUgzTkxlWlZvMHBUa0lxTUly?=
 =?utf-8?B?YWFpb09qN2dvRWVvOHN0Yk1lRHR1bkFLaXRyTWlsbHhHMHIrVUpScm5TcjFa?=
 =?utf-8?B?Sys3YU56SEdWVHV6WFJsTzBMRTI3WjNxYlNoRDRZdzJwc3FmczlwS2k5NGwr?=
 =?utf-8?B?R3E1VWdIY09wRkg3SW5OeGJhSzdQMVlTUUIxK2lnYjNoL21HSjlOanhjTWpP?=
 =?utf-8?B?Qll1eHBBdDU4cE9hVHk4ZzErZUo3d3lFenJxR1Q4WWNkWE9hUEZ1Q0RZcFdK?=
 =?utf-8?B?MEhiemtOVWlEZHhtM3puV2NWenJCZnFzRFBncmNRSUZ2TEFXQnJiOTU5ODcv?=
 =?utf-8?B?Wkx2T1c2NHlOcHFUOU5US2ZxT1k2eWxxbkFidzlwYzBZZTB2ZTVxaTU3MUtN?=
 =?utf-8?B?VnZVV3hMdVVObkVuUjVmVWphMHFBWVRyM2tyL3lYajlEcHU3VXhPeWswWTRF?=
 =?utf-8?B?MGhmcDNmR1pDazV6VkNZUFNlbzEzSUE1ak5QMEQrVHR6cG5XdkV0S0h6T1B3?=
 =?utf-8?B?a2hWTVJkTlUyT3hTTk1Ga3dSQmZQajhOM0dydjN5aDIwZkNBS3B4VFduYzdT?=
 =?utf-8?B?TFl0WW5rOUJnbDArWXhqa1h6ZmtKdjB6Rm5jUFMyT09CcC9RUUZvaTU3d0Ry?=
 =?utf-8?B?LzkvUWF3azVVTTVXZ0hIcmJYblJYMEVRVXRudGFmSmx1WUdreVd6SDZ2djdC?=
 =?utf-8?B?eHdlVW5FMW8ycG9aclRtbWVvZ25jam4yMVZjMTJIK2hCbUphUHlMcWE4ZkNr?=
 =?utf-8?B?cU9XT2pPY3hoR25YZ3dKd3RaWlZoRnh4U25IVGZqeVY0Y1B0ajlRQk9WNEE1?=
 =?utf-8?B?QnloMHVkakZtMlpJT1RvS0tMWngyNWpkS2FES3M1WEYwNllMWGQ4MDlXY2NS?=
 =?utf-8?B?azkvMnluYThyeHJVRWFTUnd6ZGVPbEhpTFkvRTA4VmRNSTUvVUV0WFFTb1dO?=
 =?utf-8?B?SkMzMHlKNHMvSDg4dHozVHJWRy95VzZvVXdUNGxtbzlRL3pIOXlkMEFtZDVh?=
 =?utf-8?B?NTNoL21iUEwvUmMrdlFETitnNXpDTFRUWWpycVhuZ2FkYXlnU05KTUY4RTdN?=
 =?utf-8?B?aU5qckxrdHpMV0w2S2d1ZWFHaUx1Ukl0c1pPYnl5aGF1VTNhc25pRWNkdHFp?=
 =?utf-8?B?Z1BHT3BMYUhDSDdoa0xUUmRRMm1obXd4Mm9ZM3BNRG1VdGVSUjdETWNycnRm?=
 =?utf-8?B?YnF2Vjg4dW9TTHZGSVVUdXVwcGN4MEg0akI4U0JkZUJYTnZYQTd4SkNtMldV?=
 =?utf-8?B?eVROOFV0M2ZiaHZkK3VZRmRVajlnYTVQU0R4ck82WjUzcXdOVkp3bnhaQXRG?=
 =?utf-8?B?S0krUW81ZFk4d0FGK1U5eXN5YlpTUHljMS9nQmpreFRlbnUyTGpka3YyOGdx?=
 =?utf-8?B?K1pSbk1PNTBhR0tFUG4rVFV5ZW9hSHpGU3N3NTB2aEQxK3FabVR0MEEzMGhr?=
 =?utf-8?B?b2E1UWYxSDN0OXhJMm1MVFFkYmtXUVRYQ2tuT3FVWW1KZGVyeUphSkdwOTZi?=
 =?utf-8?Q?K9umCgd0L7xEFc8w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AZwS5pzkS+D5Nh73DvJfKXwuNk8Q81jLKYf4KuXrdEmDElrdoxJ+RlB+KWtM7wBvtd/MjpDS+6pYLjB91TmVt2v7YoFVhC+4LQOcaCl3kFKvfqv1G50mfIYQj+zvxnsvkiVqdqGR+A4iKK5R03s1w99lvqOxzMW5/XKRmNy42GRnrIX2KKXfqo0DvAd7afvfpqs52iNZEwtUVP0QgFnHh5/hZO/pbwtSLXxGiM3Rlz3gm3Iv4xq5EWCAdEmkK6dOW8woUoYZJDeMWl34IyVmn3FFU/HDabQdc+z4aSa69sViJAk3qSCF0RJPn5JsT9Ujhy65+16jwkfK+TXolw3DeQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63193b5f-3977-438b-d8d6-08de7f4ff9e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:24:20.4139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QTSSA+Jgtyl80MXGEpHEOtktlwsSjBf7+eCeufNAQo7CS/YqBWskpsPW8wBpAkjRhMREhc3ZLbJuxK9CE9E6oAGpyKAGYr0bqoL3MzzO7CA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7897
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [Intel-wired-lan] [PATCH 38/61] net: Prefer
 IS_ERR_OR_NULL over manual NULL check
Reply-To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 3407
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/o6YdLjt2fzlNKALvuPC1wg>

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
bS5kZT4NCj4gQ2M6IElnb3IgUnVzc2tpa2ggPGlydXNza2lraEBtYXJ2ZWxsLmNvbT47IEFuZHJl
dyBMdW5uDQo+IDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBEYXZpZCBTLiBNaWxsZXIgPGRhdmVt
QGRhdmVtbG9mdC5uZXQ+OyBFcmljDQo+IER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBK
YWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8NCj4gQWJlbmkgPHBhYmVuaUBy
ZWRoYXQuY29tPjsgUGF2YW4gQ2hlYmJpIDxwYXZhbi5jaGViYmlAYnJvYWRjb20uY29tPjsNCj4g
TWljaGFlbCBDaGFuIDxtY2hhbkBicm9hZGNvbS5jb20+OyBQb3RudXJpIEJoYXJhdCBUZWphDQo+
IDxiaGFyYXRAY2hlbHNpby5jb20+OyBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXll
bkBpbnRlbC5jb20+Ow0KPiBLaXRzemVsLCBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtpdHN6ZWxA
aW50ZWwuY29tPjsgVGFyYXMgQ2hvcm55aQ0KPiA8dGFyYXMuY2hvcm55aUBwbHZpc2lvbi5ldT47
IE1heGltZSBDb3F1ZWxpbg0KPiA8bWNvcXVlbGluLnN0bTMyQGdtYWlsLmNvbT47IEFsZXhhbmRy
ZSBUb3JndWUNCj4gPGFsZXhhbmRyZS50b3JndWVAZm9zcy5zdC5jb20+OyBJeWFwcGFuIFN1YnJh
bWFuaWFuDQo+IDxpeWFwcGFuQG9zLmFtcGVyZWNvbXB1dGluZy5jb20+OyBLZXl1ciBDaHVkZ2Fy
DQo+IDxrZXl1ckBvcy5hbXBlcmVjb21wdXRpbmcuY29tPjsgUXVhbiBOZ3V5ZW4NCj4gPHF1YW5A
b3MuYW1wZXJlY29tcHV0aW5nLmNvbT47IEhlaW5lciBLYWxsd2VpdCA8aGthbGx3ZWl0MUBnbWFp
bC5jb20+Ow0KPiBSdXNzZWxsIEtpbmcgPGxpbnV4QGFybWxpbnV4Lm9yZy51az4NCj4gU3ViamVj
dDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIDM4LzYxXSBuZXQ6IFByZWZlciBJU19FUlJfT1Jf
TlVMTA0KPiBvdmVyIG1hbnVhbCBOVUxMIGNoZWNrDQo+IA0KPiBQcmVmZXIgdXNpbmcgSVNfRVJS
X09SX05VTEwoKSBvdmVyIHVzaW5nIElTX0VSUigpIGFuZCBhIG1hbnVhbCBOVUxMDQo+IGNoZWNr
Lg0KPiANCj4gQ2hhbmdlIGdlbmVyYXRlZCB3aXRoIGNvY2NpbmVsbGUuDQo+IA0KPiBUbzogSWdv
ciBSdXNza2lraCA8aXJ1c3NraWtoQG1hcnZlbGwuY29tPg0KPiBUbzogQW5kcmV3IEx1bm4gPGFu
ZHJldytuZXRkZXZAbHVubi5jaD4NCj4gVG86ICJEYXZpZCBTLiBNaWxsZXIiIDxkYXZlbUBkYXZl
bWxvZnQubmV0Pg0KPiBUbzogRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPg0KPiBU
bzogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4NCj4gVG86IFBhb2xvIEFiZW5pIDxw
YWJlbmlAcmVkaGF0LmNvbT4NCj4gVG86IFBhdmFuIENoZWJiaSA8cGF2YW4uY2hlYmJpQGJyb2Fk
Y29tLmNvbT4NCj4gVG86IE1pY2hhZWwgQ2hhbiA8bWNoYW5AYnJvYWRjb20uY29tPg0KPiBUbzog
UG90bnVyaSBCaGFyYXQgVGVqYSA8YmhhcmF0QGNoZWxzaW8uY29tPg0KPiBUbzogVG9ueSBOZ3V5
ZW4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPg0KPiBUbzogUHJ6ZW1layBLaXRzemVsIDxw
cnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPiBUbzogVGFyYXMgQ2hvcm55aSA8dGFyYXMu
Y2hvcm55aUBwbHZpc2lvbi5ldT4NCj4gVG86IE1heGltZSBDb3F1ZWxpbiA8bWNvcXVlbGluLnN0
bTMyQGdtYWlsLmNvbT4NCj4gVG86IEFsZXhhbmRyZSBUb3JndWUgPGFsZXhhbmRyZS50b3JndWVA
Zm9zcy5zdC5jb20+DQo+IFRvOiBJeWFwcGFuIFN1YnJhbWFuaWFuIDxpeWFwcGFuQG9zLmFtcGVy
ZWNvbXB1dGluZy5jb20+DQo+IFRvOiBLZXl1ciBDaHVkZ2FyIDxrZXl1ckBvcy5hbXBlcmVjb21w
dXRpbmcuY29tPg0KPiBUbzogUXVhbiBOZ3V5ZW4gPHF1YW5Ab3MuYW1wZXJlY29tcHV0aW5nLmNv
bT4NCj4gVG86IEhlaW5lciBLYWxsd2VpdCA8aGthbGx3ZWl0MUBnbWFpbC5jb20+DQo+IFRvOiBS
dXNzZWxsIEtpbmcgPGxpbnV4QGFybWxpbnV4Lm9yZy51az4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGludGVs
LXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+IENjOiBsaW51eC1zdG0zMkBzdC1tZC1tYWls
bWFuLnN0b3JtcmVwbHkuY29tDQo+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcNCj4gQ2M6IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTog
UGhpbGlwcCBIYWhuIDxwaGFobi1vc3NAYXZtLmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0
aGVybmV0L2FxdWFudGlhL2F0bGFudGljL2FxX3JpbmcuYyAgICAgICAgfCAyICstDQo+ICBkcml2
ZXJzL25ldC9ldGhlcm5ldC9icm9hZGNvbS90ZzMuYyAgICAgICAgICAgICAgICAgICAgIHwgMiAr
LQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvY2hlbHNpby9jeGdiNC9jeGdiNF90Y19mbG93ZXIu
YyAgICB8IDMgKy0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvZGV2bGluay9k
ZXZsaW5rLmMgICAgICAgIHwgMiArLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9w
cmVzdGVyYS9wcmVzdGVyYV9yb3V0ZXIuYyB8IDIgKy0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0
L3N0bWljcm8vc3RtbWFjL3N0bW1hY19tYWluLmMgICAgICAgfCAyICstDQo+ICBkcml2ZXJzL25l
dC9tZGlvL21kaW8teGdlbmUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMiArLQ0KPiAg
ZHJpdmVycy9uZXQvdXNiL3I4MTUyLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
IDIgKy0NCj4gIDggZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2FxdWFudGlhL2F0bGFu
dGljL2FxX3JpbmcuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2FxdWFudGlhL2F0bGFudGlj
L2FxX3JpbmcuYw0KPiBpbmRleA0KPiBlMjcwMzI3ZTQ3ZmQ4MDRjYzhlZTVjZmQ1M2VkMWI5OTNj
OTU1YzQxLi40M2VkZWYzNWM0YjFmZjYwNmIyZjE1MTlhMDdmDQo+IGFkNGM5YTk5MGFkNCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvYXF1YW50aWEvYXRsYW50aWMvYXFfcmlu
Zy5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2FxdWFudGlhL2F0bGFudGljL2FxX3Jp
bmcuYw0KPiBAQCAtODEwLDcgKzgxMCw3IEBAIHN0YXRpYyBpbnQgX19hcV9yaW5nX3hkcF9jbGVh
bihzdHJ1Y3QgYXFfcmluZ19zDQo+ICpyeF9yaW5nLA0KPiAgCQl9DQo+IA0KPiAgCQlza2IgPSBh
cV94ZHBfcnVuX3Byb2coYXFfbmljLCAmeGRwLCByeF9yaW5nLCBidWZmKTsNCj4gLQkJaWYgKElT
X0VSUihza2IpIHx8ICFza2IpDQo+ICsJCWlmIChJU19FUlJfT1JfTlVMTChza2IpKQ0KPiAgCQkJ
Y29udGludWU7DQo+IA0KPiAgCQlpZiAocHRwX2h3dHN0YW1wX2xlbiA+IDApDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9icm9hZGNvbS90ZzMuYw0KPiBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2Jyb2FkY29tL3RnMy5jDQo+IGluZGV4DQo+IDIzMjhmY2UzMzY0NDdlYjRhNzk2
ZjkzMDBjY2MwYWI1MzZmZjBhMzUuLjhlZDc5ZjM0ZjAzZDgxMTg0ZGNjMTJlNmVhZmYNCj4gMDA5
Y2I4Zjc3NTZlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9icm9hZGNvbS90
ZzMuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9icm9hZGNvbS90ZzMuYw0KPiBAQCAt
Nzk0Myw3ICs3OTQzLDcgQEAgc3RhdGljIGludCB0ZzNfdHNvX2J1ZyhzdHJ1Y3QgdGczICp0cCwg
c3RydWN0DQo+IHRnM19uYXBpICp0bmFwaSwNCj4gDQo+ICAJc2VncyA9IHNrYl9nc29fc2VnbWVu
dChza2IsIHRwLT5kZXYtPmZlYXR1cmVzICYNCj4gIAkJCQkgICAgfihORVRJRl9GX1RTTyB8IE5F
VElGX0ZfVFNPNikpOw0KPiAtCWlmIChJU19FUlIoc2VncykgfHwgIXNlZ3MpIHsNCj4gKwlpZiAo
SVNfRVJSX09SX05VTEwoc2VncykpIHsNCj4gIAkJdG5hcGktPnR4X2Ryb3BwZWQrKzsNCj4gIAkJ
Z290byB0ZzNfdHNvX2J1Z19lbmQ7DQo+ICAJfQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvY2hlbHNpby9jeGdiNC9jeGdiNF90Y19mbG93ZXIuYw0KPiBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2NoZWxzaW8vY3hnYjQvY3hnYjRfdGNfZmxvd2VyLmMNCj4gaW5kZXgNCj4gMzMw
N2U1MDQyNjgxOTA4N2FkOTg1MTc4YzRhNTM4M2YxNmI4ZTdiNC4uMWM4YTY0NDVkNGIyZTM1MzVk
OGYxYjc5MDhkZA0KPiAwMmQ4ZGQyZjIzZmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2NoZWxzaW8vY3hnYjQvY3hnYjRfdGNfZmxvd2VyLmMNCj4gKysrIGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvY2hlbHNpby9jeGdiNC9jeGdiNF90Y19mbG93ZXIuYw0KPiBAQCAtMTAzMiw4
ICsxMDMyLDcgQEAgc3RhdGljIHZvaWQgY2hfZmxvd2VyX3N0YXRzX2hhbmRsZXIoc3RydWN0DQo+
IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAgCWRvIHsNCj4gIAkJcmhhc2h0YWJsZV93YWxrX3N0YXJ0
KCZpdGVyKTsNCj4gDQo+IC0JCXdoaWxlICgoZmxvd2VyX2VudHJ5ID0gcmhhc2h0YWJsZV93YWxr
X25leHQoJml0ZXIpKSAmJg0KPiAtCQkgICAgICAgIUlTX0VSUihmbG93ZXJfZW50cnkpKSB7DQo+
ICsJCXdoaWxlICghSVNfRVJSX09SX05VTEwoKGZsb3dlcl9lbnRyeSA9DQo+IHJoYXNodGFibGVf
d2Fsa19uZXh0KCZpdGVyKSkpKQ0KPiArew0KPiAgCQkJcmV0ID0gY3hnYjRfZ2V0X2ZpbHRlcl9j
b3VudGVycyhhZGFwLT5wb3J0WzBdLA0KPiAgCQkJCQkJCWZsb3dlcl9lbnRyeS0NCj4gPmZpbHRl
cl9pZCwNCj4gIAkJCQkJCQkmcGFja2V0cywgJmJ5dGVzLA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2RldmxpbmsvZGV2bGluay5jDQo+IGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2RldmxpbmsvZGV2bGluay5jDQo+IGluZGV4DQo+IDZjNzJi
ZDE1ZGI2ZDc1YTFkNGZhMDRlZjhmZWZiZDI2ZmI2ZTg0YmQuLjNkMDhiOTE4N2ZkNzZjYTMxOThh
ZjI4MTExYjYNCj4gZjFjMTc2NWVhMDFlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pY2UvZGV2bGluay9kZXZsaW5rLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaWNlL2RldmxpbmsvZGV2bGluay5jDQo+IEBAIC03OTEsNyArNzkxLDcgQEAg
c3RhdGljIHZvaWQgaWNlX3RyYXZlcnNlX3R4X3RyZWUoc3RydWN0IGRldmxpbmsNCj4gKmRldmxp
bmssIHN0cnVjdCBpY2Vfc2NoZWRfbm9kZQ0KPiAgCQkJCQkJICBub2RlLT5wYXJlbnQtPnJhdGVf
bm9kZSk7DQo+ICAJfQ0KPiANCj4gLQlpZiAocmF0ZV9ub2RlICYmICFJU19FUlIocmF0ZV9ub2Rl
KSkNCj4gKwlpZiAoIUlTX0VSUl9PUl9OVUxMKHJhdGVfbm9kZSkpDQo+ICAJCW5vZGUtPnJhdGVf
bm9kZSA9IHJhdGVfbm9kZTsNCj4gDQo+ICB0cmF2ZXJzZV9jaGlsZHJlbjoNCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvcHJlc3RlcmEvcHJlc3RlcmFfcm91dGVy
LmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL3ByZXN0ZXJhL3ByZXN0ZXJhX3Jv
dXRlci5jDQo+IGluZGV4DQo+IGIwMzZiMTczYTMwOGI1Zjk5NGFkODUzOGViMDEwZmEyNzE5Njk4
OGMuLjQ0OTI5MzhlOGEzZGE5MWQzMmVmZThkNDVjY2INCj4gZTJlYjQzN2MwZTQ5IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL3ByZXN0ZXJhL3ByZXN0ZXJhX3Jv
dXRlci5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvcHJlc3RlcmEvcHJl
c3RlcmFfcm91dGVyLmMNCj4gQEAgLTEwNjEsNyArMTA2MSw3IEBAIHN0YXRpYyB2b2lkIF9fcHJl
c3RlcmFfa19hcmJfaHdfc3RhdGVfdXBkKHN0cnVjdA0KPiBwcmVzdGVyYV9zd2l0Y2ggKnN3LA0K
PiAgCQluID0gTlVMTDsNCj4gIAl9DQo+IA0KPiAtCWlmICghSVNfRVJSKG4pICYmIG4pIHsNCj4g
KwlpZiAoIUlTX0VSUl9PUl9OVUxMKG4pKSB7DQo+ICAJCW5laWdoX2V2ZW50X3NlbmQobiwgTlVM
TCk7DQo+ICAJCW5laWdoX3JlbGVhc2Uobik7DQo+ICAJfSBlbHNlIHsNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0bW1hY19tYWluLmMNCj4gYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNfbWFpbi5jDQo+IGluZGV4
DQo+IDY4MjdjOTliZGU4YzIyZGI0MmIzNjNkMmQzNmFkNmYyNjA3NWVkNTAuLjM1NmE0ZTljZTA0
YjFmY2Y4Nzg2ZDcyNzRkMzENCj4gYWNlNDA0YmUyY2Y2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNfbWFpbi5jDQo+ICsrKyBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0bW1hY19tYWluLmMNCj4gQEAgLTEyNzUs
NyArMTI3NSw3IEBAIHN0YXRpYyBpbnQgc3RtbWFjX2luaXRfcGh5KHN0cnVjdCBuZXRfZGV2aWNl
DQo+ICpkZXYpDQo+ICAJLyogU29tZSBEVCBiaW5kaW5ncyBkbyBub3Qgc2V0LXVwIHRoZSBQSFkg
aGFuZGxlLiBMZXQncyB0cnkgdG8NCj4gIAkgKiBtYW51YWxseSBwYXJzZSBpdA0KPiAgCSAqLw0K
PiAtCWlmICghcGh5X2Z3bm9kZSB8fCBJU19FUlIocGh5X2Z3bm9kZSkpIHsNCj4gKwlpZiAoSVNf
RVJSX09SX05VTEwocGh5X2Z3bm9kZSkpIHsNCj4gIAkJaW50IGFkZHIgPSBwcml2LT5wbGF0LT5w
aHlfYWRkcjsNCj4gIAkJc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldjsNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9tZGlvL21kaW8teGdlbmUuYyBiL2RyaXZlcnMvbmV0L21kaW8vbWRp
by0NCj4geGdlbmUuYyBpbmRleA0KPiBhOGY5MWE0YjdmZWQwOTI3ZWUxNGU0MDgwMDBjZDNhMmJm
YjliMDlhLi4wOWIzMGI1NjMyOTVjNjA4NWRjMTM1OGFjMzYxDQo+IDMwMWU1Y2Y2YjJhOCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvbWRpby9tZGlvLXhnZW5lLmMNCj4gKysrIGIvZHJpdmVy
cy9uZXQvbWRpby9tZGlvLXhnZW5lLmMNCj4gQEAgLTI2NSw3ICsyNjUsNyBAQCBzdHJ1Y3QgcGh5
X2RldmljZSAqeGdlbmVfZW5ldF9waHlfcmVnaXN0ZXIoc3RydWN0DQo+IG1paV9idXMgKmJ1cywg
aW50IHBoeV9hZGRyKQ0KPiAgCXN0cnVjdCBwaHlfZGV2aWNlICpwaHlfZGV2Ow0KPiANCj4gIAlw
aHlfZGV2ID0gZ2V0X3BoeV9kZXZpY2UoYnVzLCBwaHlfYWRkciwgZmFsc2UpOw0KPiAtCWlmICgh
cGh5X2RldiB8fCBJU19FUlIocGh5X2RldikpDQo+ICsJaWYgKElTX0VSUl9PUl9OVUxMKHBoeV9k
ZXYpKQ0KPiAgCQlyZXR1cm4gTlVMTDsNCj4gDQo+ICAJaWYgKHBoeV9kZXZpY2VfcmVnaXN0ZXIo
cGh5X2RldikpDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC91c2IvcjgxNTIuYyBiL2RyaXZl
cnMvbmV0L3VzYi9yODE1Mi5jIGluZGV4DQo+IDBjODNiYmJlYTJlN2MzMjJlZTYzMzk4OTNlMjgx
MjM3NjYzYmQzYWUuLjczZjE3ZWJkN2Q0MDAwN2VlYzUwMDRmODg3YTQNCj4gNjI0OWRlZmQyOGFi
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC91c2IvcjgxNTIuYw0KPiArKysgYi9kcml2ZXJz
L25ldC91c2IvcjgxNTIuYw0KPiBAQCAtMjIxOCw3ICsyMjE4LDcgQEAgc3RhdGljIHZvaWQgcjgx
NTJfY3N1bV93b3JrYXJvdW5kKHN0cnVjdCByODE1Mg0KPiAqdHAsIHN0cnVjdCBza19idWZmICpz
a2IsDQo+IA0KPiAgCQlmZWF0dXJlcyAmPSB+KE5FVElGX0ZfU0cgfCBORVRJRl9GX0lQVjZfQ1NV
TSB8DQo+IE5FVElGX0ZfVFNPNik7DQo+ICAJCXNlZ3MgPSBza2JfZ3NvX3NlZ21lbnQoc2tiLCBm
ZWF0dXJlcyk7DQo+IC0JCWlmIChJU19FUlIoc2VncykgfHwgIXNlZ3MpDQo+ICsJCWlmIChJU19F
UlJfT1JfTlVMTChzZWdzKSkNCj4gIAkJCWdvdG8gZHJvcDsNCj4gDQo+ICAJCV9fc2tiX3F1ZXVl
X2hlYWRfaW5pdCgmc2VnX2xpc3QpOw0KPiANCj4gLS0NCj4gMi40My4wDQoNClJldmlld2VkLWJ5
OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg==
