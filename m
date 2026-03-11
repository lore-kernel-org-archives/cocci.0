Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473971049516
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VICTIF5oKMXxelvmMzEh0zJq1HLJVA1XI2LRgC7VCcU=;
  b=GELV0Z30Ji93DbR8FDe/MDD12Uqt3HDSPTHPNFAIoPOZo0uyJM5c21Vs
   dSIlNKIObNMAEg2Qt4i0bhu6lOmCqH6FTSW3gPaSTVvY7xp92vG9Lemsr
   8DK2uszxVS3JcLniY6k5Vt2/Hx6Afq5P9eD/2IVX15uDNYzoOH1XYBSDF
   M=;
X-CSE-ConnectionGUID: wDSeSK4wRZmS9k5zPyYIaA==
X-CSE-MsgGUID: rwv8q7brQMO5CLzokZSUqQ==
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
   d="scan'208";a="267246246"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:32 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id F065C818D1; Wed, 11 Mar 2026 10:46:31 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id DC2FD80641
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 10:20:07 +0100 (CET)
X-CSE-ConnectionGUID: VVl5onxdReiZPaoLqF364g==
X-CSE-MsgGUID: 4gNP88qJTPqo82oojN4kxw==
IronPort-SDR: 69b133c3_52TyBlHcFWCkblB8pYuCrIm+Al4MPRgr1bObc4zXruWH8o2
 mPW0tQm/mIFGn9rFRNQakc6KyBIhN+gzk+TuiYQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EUAACiMrFpjwxBr8ZaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0GAQELAYFtU4FoMQRUhFiDTAOMBIIhA4ETm1yBK4ElAxg1CAIPAQMBCwEBL?=
 =?us-ascii?q?iABAgQBAQMEhQACFo0NAh4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBB?=
 =?us-ascii?q?QEBAQIBAQIEBgECEAEBAQEBATkFDjuGTw2CYgGBJF4HCTgBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQERAg1eAQEdAQEBAQMBEREEDQwBATcBCwQCAQgOAwQBA?=
 =?us-ascii?q?QMCJgICAiUKFQgIAgQBDQUIGoJggiMBBkoDAQICohoBgT0Ciip6fzOBAYIMA?=
 =?us-ascii?q?QEGBATeCQkJAQoBgQouAYU7gxcBAYFwgkqBIAEZhAB6J4FlQ4EVQoIwOD6ER?=
 =?us-ascii?q?RWDRDqCL4M0jE2GVglJeBwDWSwBVRMXCwcFYUIQMwMgCi8tAhQNEBIPBBYFL?=
 =?us-ascii?q?R1wDCcSDx0XFB9YGwcFEiEqB4FBeIFmGw+GaHkDLl4aDiICKBIDMgQjgQYLW?=
 =?us-ascii?q?gWCLAIcAwttPTcGDhsDBDp7BY1rPYIUHwEBgQ6BBj18GJZjSa9WAwQDhByZX?=
 =?us-ascii?q?IgyF6prLodlkHMiqHQCBAIEBQIQAQEGgWkBODyBIHCDN08DGQ+OIQwNCRyDQ?=
 =?us-ascii?q?o89Abl6RTM8AgcLAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 VU=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:dATshK5heWkPc8aX6wPXwd6CI+orL9Y04lQ7vn2ZFiYlCfBwxv
 re5MjziyWE8Qr5AEtQ7+xpOMG7MA3hHO1OkMAs1NCZLU/bUQqTXcZfBO7ZqAEIdBeOhNK1uZ
 0QD5SWTeeAemSS7vyKuTVQcexQteVvmZrA7YmuqgYIPGYaDdAbnnpE40SgYzlLrWF9dMgE/f
 Gnl7t6Tk+bCAcqh7OAdwk4tob41qL2vaOjSyQrQzQg7w6Dhy6p7rnVLzi0ty11Mg9n8PMJy0
 SAtxb2yJmCnpiAp3/h/l6Ww4VdmdPnxNcGP8qRl8gTJAzrjwajdK5hV7eBsD1dmpD21L9sqq
 iun/4nBagdmhHsV1DwhSGo9xjr0T4o5XOn40Sfm2HfrcvwQy9/I9ZdhKpCGyGpsHYIjZVZ6u
 ZmzmiZv51YAVfrhyLm/eXFUBlsiw6dvWciq+gOlHZSOLFuMoO57LZvoX+9Iq1wQx4S27pXTt
 WGy/ustcq+RGnqM0wxeFMfkOBEEE5DTStuCXJy8vB9mwIm10yRiXFokfD3101wvq4VWt1K4f
 /JPb9vk6wLRsgKbbhlDONEWsevDHfRKCi8cl56DG6XVJ3vAUi96KLf8fEw/qWnaZYIxJw9lN
 DIV05Zr3c7fwbrBdeV1JNG/xjRSCHlNA6djv129tx8oPnxVbDrOSqMRBQnlNahuewWBoneV+
 yoMJxbDvf/JS/lGJpP3Qf5R55OQENuFfE9q5I+QRaDs8jLIorluqjSd+vSPqPkFXI+Vmb2Eh
 I4LXnOzQV7nw6Ws1PD8VfssinWCwHCFLpLYeTnw9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AEDdhKmlFlvk5iuwXIuqmX43IMNLXOUPjyCrXJV+?=
 =?us-ascii?q?0M2toeoWcTnuJ1vg6z8U7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AUW8erAwLg9UkZdDEbPsIFDbFEfWaqPihLnhdwYw?=
 =?us-ascii?q?kh/GdMnwqPDCfqmi0UpByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="141008780"
X-MGA-submission: =?us-ascii?q?MDEZYW1BS/yoAKNwTKhKkQhBIcYSh/dvXV+Mh9?=
 =?us-ascii?q?Pnc5NejRJtH33CJmsiJqLSzPv1/QnblxAoHv05qBWO6qsGUyqRzmL1Gh?=
 =?us-ascii?q?pHU4aHU41AGFuPMqrMrOM5Q2eYhmKNnQga0FMYb39GZZoMyVP8vbuRSR?=
 =?us-ascii?q?Ic+VlNmkqRtupvPn8b+oGy7g=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 10:20:01 +0100
X-CSE-ConnectionGUID: ex2nhDfNRjqmGZr7GTsk9w==
X-CSE-MsgGUID: 4KqoNghwSqm97BV8GLeYQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85760410"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="85760410"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:19:58 -0700
X-CSE-ConnectionGUID: rDRkcxt4S2OrIy4Cq2KTYQ==
X-CSE-MsgGUID: rJMf+9RKSX6kadZB4KURPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="246008222"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:19:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:19:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:19:56 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:19:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBGG4b7Mdcpvq8z9yjAjPaUvWfs0969wp35Z/SLhR6InEbJEFhaspgNYY88ae+ZdBOsep6jkskWKU85RsuBka9aNuS7ILrocSsI9607DCJrexM9Nzcemy7avRs9dkUQ3WfWXQsQNwAnzHSaUNsSafYBXS0W40gkMZONfhQhaTTTDqWzYitHdN/TEkLiCeNy+idNvXz61VqJaMl3G+NBxXWL8frlhzEYWrL6bgvEL++4KmrfGmcWkzAPM9v7t9PScMaV/jRMmKd49JNsyq6OBncJ1BBh3iiQhjw1tLvKTObiJXiy2p/DWvgtg0KFIKwkiHyD1HXK+2hptWijd0caB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VICTIF5oKMXxelvmMzEh0zJq1HLJVA1XI2LRgC7VCcU=;
 b=xfcbkXZEdYs5HLIJ2+RiuBCXGERHxwTQRaX8mksonk+QjitTrQrNfhKNs6k7ObcV+aQhOS7NWZe/wu6ZqZb6/GGM//v7K5wZC6l8reZEZf71p/KJnMEJOcIdNd8KeiZDUs7QhU04x3Me3t74jznDcB4OREvnvw51oAcPX5RZwMag4sIxX96PhH1W8/9nsYyKE2oPxh1MZZcM/fg8MBl4iVb81ZhXmhGlFZJAGP9qPSWYpRx2Sy0Smi8mWdn+9O0vKYZHVWiHGb5Sr161HNfzgG9TkIIlrE02eddq/HH65rKWWSwgXuLhvNmtj43akkr6ZfmnAgA3Y4Es5JhYrvIV0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7897.namprd11.prod.outlook.com (2603:10b6:930:7d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 09:19:53 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:19:53 +0000
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
 Schoenebeck" <linux_oss@crudebyte.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH 24/61] net/9p: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Index: AQHcsKKa+tfh5nrJRUSV5t+CFXfTkLWpDx2A
Date: Wed, 11 Mar 2026 09:19:52 +0000
Message-ID: <IA3PR11MB89860002CF9EED385181141EE547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-24-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-24-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7897:EE_
x-ms-office365-filtering-correlation-id: 146b6497-57df-4729-7c02-08de7f4f5a74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: xCzo8EzOlP1vZF7EM8SGVAPapKDtDSJ9Onrfr0iC1Ul3jbJp+H5/xvrVGhWVhOAUvpUksI5GqokHPwAgYbia+l8Phr4v5imaJqjPwPVuAYpvIWoxwk5Fa34TmO36HQOv/zGERAVWPri+oruLJPjkDNbAwHWgEV3mSphZJI1ow7fgT9V6yNsiMdhw4MalqOBAxsnT0Kuak5pL+mD59TLzZ1FAu6dKl9FO4PB4ti7p1IrOMTXVtjRJ2niY9+E+LrmUdugLbF8jcggmgtoTGWi96vqbqxnEjkOIHm4YD9GDNCmIBRgteJ83GtQU4CZGUvfUbRjfFoiMuyNptzIBMZXM7njG2eUqaAxVZBj5K4Hxw9vaaZlwyz6Ppg6ZZLPRZgfF95iCc0x0nZqQKNH4QtV8JRb0offlpviOvR1+nNLwCBy9YfKrzsSlTDBJbg5DzfBXZfza4KQRT13W0ebTCbB1x4RVTgP09IYLKbWE1xiwKPJ+3resnHDtWC3U4/2xVQ/YqUVAJZMa/fCHwmD5NXnqYtw5CFBOj7178Qp3z5LuLgv9B7EjHv0xOb4W8YvYrLzDwMCwlj7CxK1NUhr8cAzkzgXMQadCuYA0JvhBNDBYqtcIsXyFDXASt5+/+JtoXn+Jb94eJqJZ7YHeStDaPrD7NlIVscXhkUdAOqzUzzeCpyhzUe/oTbXLycKPHJqNXyz6CNIU2OObJQevWL2VTAJu1rPJBWL8wRjMMQoyfe55tTxJx9VJCKw9hyXE454gBcuDtLLc1udWV/FbB7c7cC4am2lXYPz1pb61er8qpsY1LImElxWAQ1kQRXK4XecHwbar
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXZJUTJ5cFJtN1k2d09ZM3h6TXNaaEVrMXNUc1NHbUVPMnJrb3liY0Zxek81?=
 =?utf-8?B?aW9MRXIwR1RTYmFFQ1Z1YlNQb25lVytGRWVzZlpkMTVGa25VeUF1UVhlTHph?=
 =?utf-8?B?b1FHNlZTc1FuTzNUZkxUWTl1Mm5xbGpFMW5SNC84VUI4MDdybkx4WHhOemRy?=
 =?utf-8?B?UmNkWUY0V3NPYjF6VEgvOVg0dDQwQ0JvUXVXQ2JCZDI2bFYxd0ZFaHNrT0do?=
 =?utf-8?B?K2hiejVjM1NYeHQ0Yjg1M09PeGg1ZkwyczVjTEJnUnZNa0lxNnN2cG1xYmZL?=
 =?utf-8?B?U1MzVzN4UTI3Ty9SMmtQT2dGMlNsVlZ1KzFGRzBxdDJEaGd0dzVmYlREYWt3?=
 =?utf-8?B?ejdTLzUvcUF0KzJ3U3YwVUpudVVENkk4L3JRZTVNNTFqd3lVZHprNTdpTlc1?=
 =?utf-8?B?K290VWNEdFhBemRDMFdZTzBkbkllS1FJc2c0V1I1cmdRdktBSXArTU1JNFUw?=
 =?utf-8?B?SDNTbDFBV1BKWFVEV1ZyMS9FYkxGdERvM2pCSy9Bb05WeTVmQUk3NDdIb0N0?=
 =?utf-8?B?V1E5MDZiS3o3dUZrZTg4SEdjKzlIank4WXRuUmYwTUdLOE1ma3Fvckl6SGlC?=
 =?utf-8?B?bUoxZldwYXZ1cUFyQXBSc0pRN2NESmFUZ2gwQVVhQXZ4M1hObkk2UnJ3YmNt?=
 =?utf-8?B?VklvY3ZsUU95REZEUUdma29sbnJjSWI2S3N0Tmw3SVNVMEwxU1J4SVYwZzJC?=
 =?utf-8?B?dWhGcGFzVEdJUXhFOEViN24zbnNGdkU5R0RaOTMxTnpUN3VuQ05jZ1l1cVg0?=
 =?utf-8?B?a2FrRXh5WG1xaXlGdUhLRjFlbmFyNWlkVFdyQVozbHFuNytQMURIaDR3V2NR?=
 =?utf-8?B?Um5hc3JvQjI0THZvQzk3NXo2WlY4UWtKd0ZjanU1Uy8rZ3I0SjhmMDBtZW5R?=
 =?utf-8?B?T25BY3NwV0VGRnIxYWJFTlBqZlBQNjFTUFRoTjF1KzIzQnQwVDBzbHdMbHNE?=
 =?utf-8?B?dDZQb0k4azljMlAzdVdhQXlSZ3NGRWgzZ3hqYkxqTmRDc1E3d1dpT1drN1JP?=
 =?utf-8?B?M0J5dkpqYlI2cVJaUzZWMHo4RmpKNXQrUW9IeTBPMWN5WkQ0T01UTjBRZWd0?=
 =?utf-8?B?azNVUkkxdGQ0QVdUN0JGMHI2TmhBRnQvK01URlI1OE1WK3dVbEhSUHRwTUlM?=
 =?utf-8?B?S0R5SUd4SlBkZGJwY3FJdDQ2TFlVaUZuRXorbEhpSDczS3VFUWtTaEhRSXE1?=
 =?utf-8?B?K0lNWDZSekZpbTJhazFCUEE0K085cmwwZ0FMZDhKbnAyQk9iandCYnpDUlJG?=
 =?utf-8?B?VlZNcjhxZThBVFdRalAvL01MeUQ4MW9uVWd0QU11Mlh0UkZWSDhDYjNLbjhy?=
 =?utf-8?B?RkU4LzJVOUJKVWhjdGlCVllROVdCdnEvam5QaGRQZUM5Zm4wVWJIckt5RWUy?=
 =?utf-8?B?U2I0cGd4T1UxRytiUDN5QW80TzdVVnU4MXB2NXdWaVJtbUcwSHZCdytUeWVv?=
 =?utf-8?B?bTl6ZTZjNEhOTnJIRHNSYVN1bWE3TjRtWXJGeEZuV3d5TUd0eG85OWxyTHh5?=
 =?utf-8?B?Z1FLa21RQTVzWkNuajBSZTU4aGIyUUU5R3p1R0NGSis1Z0E0ajRRM2x1bm1s?=
 =?utf-8?B?T3pUWDZWdVRwd1VkNWNTSlZpU1JhRTliUG5OdjAyUzU1azF6QkFxWkpvSVFn?=
 =?utf-8?B?UktjSmNFZVV2U3pFeDc2ZHlOOFYwM3U2cHJNdWk0L0pRc1BOaFYrSlEyb0Uv?=
 =?utf-8?B?Nldnd2drMWxQQWdENUVSVmo1UHp6am1xK245alhPNFhZcFVVaDU0clJqSlJE?=
 =?utf-8?B?VWlqMjBOUWRodTJPNk03R1Z2dGhiYmROVHZ4aXlPVERDQ1Z2UHdNbjJKR2Jy?=
 =?utf-8?B?VWxmWUlRWWJHYkNQd1lCQjZrdjJtcGZ2cXhrbCtEZjY2ZkpqVmpsYno3UUxQ?=
 =?utf-8?B?WVkwWC9PZkJUU3o4aFBnYmJBNlBHb0dETVdFL1Y0cXl2ejA5cVB2MWNjNTV0?=
 =?utf-8?B?V1R4ZE9IUUZDODd2aUI2V2FXYkZONDcxSTk0VkdleUFjTlF6YVVvWmVDRmxu?=
 =?utf-8?B?VHdxalk0RjFTR2tGMndWMkdwS0EraDQvOUpCZ1pDL0N3NE9WOE5iWTV5VjY5?=
 =?utf-8?B?SVNWYW0ySUhBSXU4RHVLUU9MbEh4Yi9tdHBBK3oxUXhiaUdGWW9nSC9LRXpy?=
 =?utf-8?B?KzMwMXl6S2JNOFdnd05nK3owNVNEbVc2bDVYTjhUd08yU0x2WXcwVXozT0Zh?=
 =?utf-8?B?TUVqS2RYNlNYdDJSSTgyNzR5alNyVWNLc3J3RHE4WFk3V1JySEZuR1pKSndP?=
 =?utf-8?B?MjNySHJ1RGx3TDBVbHFuVlMwNkwzb1FzVTZFR2JQQS95VkI3ZFBrVUpud0FU?=
 =?utf-8?B?bVZPaUFWNlc1ZHRtMVhGdnJYZmhKM0tnL3crLzQ3R3gzdEFJczhnSnVRc3Vq?=
 =?utf-8?Q?4trO51J1GdXfqpgE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: a69exJuCkYK9He6WhXS5mSdevm7QQYzMbKq84o6cab/5zxaKKIUsXxZYgqCNGumcBaFYj5zLT1NCQUL80c4a3isUjr381++Uszaxdb+w5gQ3ba2ICCPC4p4S98Tto+gtTS3inkmYhU6lWe4LdVhuTdSfcEEx5WYWHKzq9EoNXTXaza62zs2mCjoKYQ4FGd0s6imSNFVgZso0GnP1fA05JfZzBZXax8lUVJJD3NHpTVS7O+eMXVBl5SkwIt2o84IHBRoKTycswILn+dpCi1xdfZCcW0cVL5ytxukuqDkiRpzmx8Ifcw4FsWCPhc/WOC7/BSQT7ZFKDAzjTO/HqycriA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146b6497-57df-4729-7c02-08de7f4f5a74
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:19:52.9395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Ftkionec1AH2Drm+uzecDRYAiZuu9W4MK6U0DRbxspF/1CAxnRVLkh4XI4gsD2ggIGpaCVs0DgNhFcoz/9RHiBchDTTlsTKwloLswabMQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7897
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [Intel-wired-lan] [PATCH 24/61] net/9p: Prefer
 IS_ERR_OR_NULL over manual NULL check
Reply-To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 3403
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/ZWLs3AnXU4CSRs_wfnGvcw>

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
b3NzQGNydWRlYnl0ZS5jb20+OyBEYXZpZCBTLiBNaWxsZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5u
ZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1Yg0KPiBLaWNpbnNr
aSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgU2lt
b24NCj4gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBbSW50ZWwtd2lyZWQt
bGFuXSBbUEFUQ0ggMjQvNjFdIG5ldC85cDogUHJlZmVyIElTX0VSUl9PUl9OVUxMDQo+IG92ZXIg
bWFudWFsIE5VTEwgY2hlY2sNCj4gDQo+IFByZWZlciB1c2luZyBJU19FUlJfT1JfTlVMTCgpIG92
ZXIgdXNpbmcgSVNfRVJSKCkgYW5kIGEgbWFudWFsIE5VTEwNCj4gY2hlY2suDQo+IA0KPiBDaGFu
Z2UgZ2VuZXJhdGVkIHdpdGggY29jY2luZWxsZS4NCj4gDQo+IFRvOiBFcmljIFZhbiBIZW5zYmVy
Z2VuIDxlcmljdmhAa2VybmVsLm9yZz4NCj4gVG86IExhdGNoZXNhciBJb25rb3YgPGx1Y2hvQGlv
bmtvdi5uZXQ+DQo+IFRvOiBEb21pbmlxdWUgTWFydGluZXQgPGFzbWFkZXVzQGNvZGV3cmVjay5v
cmc+DQo+IFRvOiBDaHJpc3RpYW4gU2Nob2VuZWJlY2sgPGxpbnV4X29zc0BjcnVkZWJ5dGUuY29t
Pg0KPiBUbzogIkRhdmlkIFMuIE1pbGxlciIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+DQo+IFRvOiBF
cmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+DQo+IFRvOiBKYWt1YiBLaWNpbnNraSA8
a3ViYUBrZXJuZWwub3JnPg0KPiBUbzogUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPg0K
PiBUbzogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPg0KPiBDYzogdjlmc0BsaXN0cy5s
aW51eC5kZXYNCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcCBIYWhuIDxwaGFobi1v
c3NAYXZtLmRlPg0KPiAtLS0NCj4gIGluY2x1ZGUvbmV0LzlwL2NsaWVudC5oIHwgMiArLQ0KPiAg
bmV0LzlwL3RyYW5zX3JkbWEuYyAgICAgfCA4ICsrKystLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL25ldC85cC9jbGllbnQuaCBiL2luY2x1ZGUvbmV0LzlwL2NsaWVudC5oIGluZGV4DQo+IDgz
OGE5NDIxOGI1OTNmM2ZiMTllNjgyN2M0NzI3NTMzODAxOTM0NjEuLjRiZGU2YmQ3MTZmMzIzYzgx
OTc0NWU2NGM3YWENCj4gYzBkZWE3YmViNzJmIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL25ldC85
cC9jbGllbnQuaA0KPiArKysgYi9pbmNsdWRlL25ldC85cC9jbGllbnQuaA0KPiBAQCAtMzY0LDcg
KzM2NCw3IEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IHA5X2ZpZCAqcDlfZmlkX2dldChzdHJ1Y3QN
Cj4gcDlfZmlkICpmaWQpDQo+IA0KPiAgc3RhdGljIGlubGluZSBpbnQgcDlfZmlkX3B1dChzdHJ1
Y3QgcDlfZmlkICpmaWQpICB7DQo+IC0JaWYgKCFmaWQgfHwgSVNfRVJSKGZpZCkpDQo+ICsJaWYg
KElTX0VSUl9PUl9OVUxMKGZpZCkpDQo+ICAJCXJldHVybiAwOw0KPiANCj4gIAlpZiAodHJhY2Vw
b2ludF9lbmFibGVkKDlwX2ZpZF9yZWYpKQ0KPiBkaWZmIC0tZ2l0IGEvbmV0LzlwL3RyYW5zX3Jk
bWEuYyBiL25ldC85cC90cmFuc19yZG1hLmMgaW5kZXgNCj4gYWE1YmQ3NGQzMzNmM2I1ZTZmZDFl
NDM0NGQyNmJjMDIwMWZmN2Y3Zi4uNjA0NjEzNDRiNTM2YmNiNmU5NDExMmFhY2U3NQ0KPiBhODhi
NmE5OWFkODYgMTAwNjQ0DQo+IC0tLSBhL25ldC85cC90cmFuc19yZG1hLmMNCj4gKysrIGIvbmV0
LzlwL3RyYW5zX3JkbWEuYw0KPiBAQCAtMjUyLDE2ICsyNTIsMTYgQEAgc3RhdGljIHZvaWQgcmRt
YV9kZXN0cm95X3RyYW5zKHN0cnVjdA0KPiBwOV90cmFuc19yZG1hICpyZG1hKQ0KPiAgCWlmICgh
cmRtYSkNCj4gIAkJcmV0dXJuOw0KPiANCj4gLQlpZiAocmRtYS0+cXAgJiYgIUlTX0VSUihyZG1h
LT5xcCkpDQo+ICsJaWYgKCFJU19FUlJfT1JfTlVMTChyZG1hLT5xcCkpDQo+ICAJCWliX2Rlc3Ry
b3lfcXAocmRtYS0+cXApOw0KPiANCj4gLQlpZiAocmRtYS0+cGQgJiYgIUlTX0VSUihyZG1hLT5w
ZCkpDQo+ICsJaWYgKCFJU19FUlJfT1JfTlVMTChyZG1hLT5wZCkpDQo+ICAJCWliX2RlYWxsb2Nf
cGQocmRtYS0+cGQpOw0KPiANCj4gLQlpZiAocmRtYS0+Y3EgJiYgIUlTX0VSUihyZG1hLT5jcSkp
DQo+ICsJaWYgKCFJU19FUlJfT1JfTlVMTChyZG1hLT5jcSkpDQo+ICAJCWliX2ZyZWVfY3EocmRt
YS0+Y3EpOw0KPiANCj4gLQlpZiAocmRtYS0+Y21faWQgJiYgIUlTX0VSUihyZG1hLT5jbV9pZCkp
DQo+ICsJaWYgKCFJU19FUlJfT1JfTlVMTChyZG1hLT5jbV9pZCkpDQo+ICAJCXJkbWFfZGVzdHJv
eV9pZChyZG1hLT5jbV9pZCk7DQo+IA0KPiAgCWtmcmVlKHJkbWEpOw0KPiANCj4gLS0NCj4gMi40
My4wDQoNClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlv
bm92QGludGVsLmNvbT4NCg==
