Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36BE1049521
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/WnYjaq9zqroKxNH1/RH2NWPVjerKMwSwnhWZn9wJdw=;
  b=YlnrDMMrG/te53yX7XSqjSNDMP/QdqHalRc7bAEcdI94dWXR2NK4g2Uu
   pCvkNyCoh/y7Jlo4jv4/5P5l+OfM6Wc3NlLICjrqIblkFuZVEie9bJAYY
   z3jedj/E+TwEAJLCB9pNa09bDH7bRPgASq5dBz0PduoYq2H7fhl3coCuE
   c=;
X-CSE-ConnectionGUID: ccNGGDubTmqMGmi2wy87/Q==
X-CSE-MsgGUID: 2eJxezBaSkm5Mb78YVjQXw==
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
   d="scan'208";a="267246419"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:40 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 77977818CB; Wed, 11 Mar 2026 10:46:40 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id CA4F2818AF
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 10:24:51 +0100 (CET)
X-CSE-ConnectionGUID: EEDkK1wIRDqdLqPkZAReUg==
X-CSE-MsgGUID: yjdUo54FRnmO91njGgpWtA==
IronPort-SDR: 69b134e4_DHEZmGzSwyZ9mixMmaAwoy+kUswyTPBMvKQqlqRtW9f8gQi
 4l3eonyoSIMDIPiOow8fsG68acI1TAzGXqT75DQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ENAAAINLFpjwlBr8ZaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwHAQELAYFtU4FoMQRUhFiDTAOETYlYA4ETilGRC4ErgUA1CAIPAQMBCwEBL?=
 =?us-ascii?q?iABAgQBAQMEhQACFo0NAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBB?=
 =?us-ascii?q?QEBAQIBAQIEBgECEAEBAQEBATkFSYZPDYJiAYEkXgcJOAEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBARECDV4BAR0BAQEBAwEREQQNDAEBNwELBAIBCA4DBAEBA?=
 =?us-ascii?q?wImAgICHgcKFQgIAgQBDQUIGoJggiMBBhEDNgMBAgKiLwGBPQKKKnp/M4EBg?=
 =?us-ascii?q?gwBAQYEBNsnDYJVCQkBCgGBCi4BhTuCeR4BAYFwgkqBIAEZhAB6J4FlQ4EVQ?=
 =?us-ascii?q?oIwOD6CH4ImFYNEOoIvgzSMTYZWCUl4HANZLAFVExcLBwVhQhAzAyAKLy0CF?=
 =?us-ascii?q?A0QEg8EFgUtHXAMJxIPHRcUH1gbBwUSISoHgUF4gWYbD4ZoeQMuXhoOIgIoE?=
 =?us-ascii?q?gMyBCOBBgtaBYIsAhwDC209NwYOGwMEOnsFjWs9ghQfAQGBDoEGPXwYlmIBS?=
 =?us-ascii?q?a5lcQMEA4QcmVyCAIYyF6prLodlkHMikXCXBAIEAgQFAhABAQaBaDqBXHCDN?=
 =?us-ascii?q?08DGQ+OIRklg0KPPQG5bEUzPAIHCwEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:BcKzaKprybCs1k7q0nEI/9saV5s9LNV00zEX/kB9WHVpm5Oj5r
 uTdaUgpGfJYWgqKQgdcIi7Sd+9qXO1z+8K3WBjB8bqYOCAghrvEGgC1/qk/9SEIUbDH4FmpN
 VdmsRFeaHN5B1B/LHHCWqDYo8dKbu8gdWVbI7lph8CPGQaD9AGnmEJcHfnLqQ1fngzOXNQLu
 vP2iMtnUvQRZ1jVLXJOpBzZZmymzSkruOYXTc2QzQcxE2lizSu5LTmEx6e8Cs/flp0q9Yf2F
 mAuTbUooG4vd+G6jK07QKy071m3PfxwNpKA8KBzvMSNijtjQiQYoFgUa2pvTw+ou2jgWxayO
 Uk5C1QXPib7Um8ERDWnTLdny3blBo+4X7rzlGVxVH5p9bieT48A81dwapEbxrw8SMbzYpB+Z
 MO+1jcm4tcDBvGkii4zcPPTQtWmk29pmdnufIPjkZYTZAVZNZq3NYiFQJuYco99RDBmd8a+d
 pVfZ/hDTFtAAKnhkXizzVSKRqXLyQO91m9Mxs/U4euonBrdThCvgAlLYok7yI9HdsGOtN5zv
 WBPaJymL5USMgKKap7GecaWMOyTnfAWBTWLQupUBba/Yw8SjLwQqTMkfYIzfDvfIZNwIo5mZ
 zHXl8dvWkue1j2AcnL2JFQ6BjCTGi0QDyok6hlltxEk6y5QKCuPTyISVgoncflq/IDAtfDU/
 L2PJ5NGffsIWbnBI4M1QzjXJtZL2UYTaQuy5MGckPLptiOJpzht+TdfvqWLL3xESw8Ume6GX
 cHVCibHrQA0qlqYA63vPH8YQKjRqWkx+M8LEHzxZle9LQw
X-Talos-CUID: 9a23:y/Zt4mDXgfPMJNv6EwRK2E03Q98ESFHEwFPJG0yKIFxkdbLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AARpjEg+PLFrb/iHr0i8lGUCQf9Zq75mpVRwjq5M?=
 =?us-ascii?q?DnJjdMy5fNC+ikB3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267239340"
X-MGA-submission: =?us-ascii?q?MDGuhGWBoBbMeQXIiPeqgeIrh/Ab94/gIvocWA?=
 =?us-ascii?q?SXwDCJ/ZM070OoOE9zX06eMySqKOHPZaiRNQKMJJTv64sJNKqP9Svb01?=
 =?us-ascii?q?4LrG0Q6L4wJo1f0R4JUa81oZZb3rbe22M5Tpf04/+uI31bETR3TMjfjY?=
 =?us-ascii?q?eJX+STJZMN4mjjqe1efXDOMA=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.9])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 10:24:51 +0100
X-CSE-ConnectionGUID: YLGk59eHSl+GAan/KaHlhg==
X-CSE-MsgGUID: YA/OpMTOQ/aHTQguaIuCOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="96899639"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="96899639"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:24:49 -0700
X-CSE-ConnectionGUID: +pNzCQuOS4iMOvUIOsAbbw==
X-CSE-MsgGUID: ihZy0IpkRxC1aXJmO8GjSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220354338"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:24:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:24:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:24:48 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.3) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:24:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrGF6ysw3NLbFbz7lvDpDsZA34MAFk8M6PmU/DB+YGblIv+vOpJHUfRNdxOGGNT97eD/VPAXQl6832UdgZIlyco/xQ5N7yqkEP9715RZLzDgG2OCQPVM+c8qhUDQWzgNsSequTQ/0cGZBLotpTJdsw9XPPcvYJbc0W/0U13cjZxpsUs2+iBxSyLsO2jhJcZEEjEL65O/vlhdF4hOnb5V1YAhiiT08wChIxU/eWp8kLyw258X03oaDE2sw0J+vrdDo4X/jkMcyBQztWprdJH2K0PDhP9zDkx6cSSXKQUxpYrXJiioXIfZNZKg4X2+ZpjZTJceRSMn8YfckCdPx2uUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WnYjaq9zqroKxNH1/RH2NWPVjerKMwSwnhWZn9wJdw=;
 b=fEMQ+ysMnPe2j7XVEXA7acz6fhMjQ0kXtpbPix/u4OCeSl+jsMwiaXRncu292Ubnorn0DFmHj2r5fbLBS0tMaktq3yLpK67Yz9MZZksKW8cMKWP2/48/oi0Qbs1/78nwAKQS7KbhAgoKszGdIsSEhsdgPE9oY5UL743qCUq3eDsvPGV3dDzXTaPgUrK8YyzNp3FSP4nEk8xs+4aJ3mC+Sh4E6VtTKOLz5Ii7TYM+65aXFKGenEDpdLjLIqzCmHlJv9WyB2CBoB7Psd0bEnvWvBHO4Wd/YCGFEyQWVmLhMz/4VAlbZ0SuEW9Ka72ut/ucLp+5aLw47WUReY3sBQQFuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6836.namprd11.prod.outlook.com (2603:10b6:510:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 09:24:45 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:24:44 +0000
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
CC: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>, "Andrew
 Lunn" <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Thread-Topic: [Intel-wired-lan] [PATCH 39/61] irqchip: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Index: AQHcsKKg9oKg4QUhq0yGHO8ZtUkDV7WpEHiA
Date: Wed, 11 Mar 2026 09:24:44 +0000
Message-ID: <IA3PR11MB898641F143E155B8A8069936E547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-39-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-39-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6836:EE_
x-ms-office365-filtering-correlation-id: 16e59c4a-c185-4674-e460-08de7f500851
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: LSUZ060yA0zdkbfhlg7l9aVdcvsKojcvgwO3ACL3uZZlR/qzeqERV2DVHgMJwbPfqhu267UPDQzRLLv7X3d5RlS0JuOXDVxA9cm+WkkbMcCMMheQlIRAxrIktgbdkZESGhzlWgTbxl3Y/2gbbusycFgS0wjI5+GRZk26YjYST+YF3Cf7sBqIA7aduza3XxbWyGcS8eF9T0W6BRyf+jBN1IZ6mJ32KyDEwAPdnPfUMlrC6tr31AmtIuls+sW7d/tUscX6/XESWrivRoE+PBho0thaAsRLRKrhOV8qU1PPKRjY2iir7g48IrNLqDT5DRAQ22iTqJdt8cGwK7uoPrGBJxj7AULdq2IvwrtQYg0czy/oFGIJdrjEQvGAtmcVTPGkXmGkbNgRdgWIkvoA1lDlUMS2gALwKxiZh5PaAoX0JATl8b1EIr/ePZ+RXmc7HRRcAyUJ5ox0P84CR6ikaSNaIp/RQ4sOh2bGTfYI0V7N0JrWkAeVpHuGwS3+iRzCtLtXVMUvpcaKx6LgNt188r1ZN8p6Z9Jk/GFeOvJMqGFFsPLMwq0PebF4kfJt1gig815Ylf75pPpjL7O1ZPprsvGkgvnNM0uthucVJu6SuavLnsBH1QDfOy2BvuUqNHav1UU2sT7fQim8hOf8teLWQRN0nYSPrHNTDWP0c0PT2XpNnKCcpTYwz/bMUzACKZyfACaLP3dQ7r/lBBVithoKBQjk7PboSYKfrJ57BzzWTh1xwFMIbeKazCXevxZqhONUzLz3eAC5P0eeaEgZOsJ2yvUmoXihSND0r6uoToI7OcCqnrmC56cOaRHUHi+Q5fLAMXSS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmxSbWQwaUx5d3JubkVjM2tDUXZmaTdpNVNzYmdmbGhTdGRURTRxUjZPTFRL?=
 =?utf-8?B?QXVIejBEOFpaU0pHRXorVHBNR0c1dVV3Q0xBU2huK2VyNXBITU5IZU5vbHlI?=
 =?utf-8?B?UzdwS1BYVFhUUE1qRCtlK3JGZHN0bW5mNWNTdTVrTmhkWUlKTXJ6ZWlzcVlw?=
 =?utf-8?B?ZFFDYjZLaWFTeXhOYTA3SXpwWGVHVmZNcWZsQkUwZjhRa3BwbzFqWEdSQXA5?=
 =?utf-8?B?SndrMStaUmg1dFExejJqckFtNDBIOURJclI3MmVLOC85MGpETlBYWXU1MmJn?=
 =?utf-8?B?UjNTM0VUNEVkeHB4NlI0MENVSDlsclloMytKcERNVDczWjMzZHZTRjJtQ1pP?=
 =?utf-8?B?WTYwMVRsWXNLeDR4MWJxR0tqcmQ5OW1OTms2QXhScFdLQkgwRllnU2hIZWNC?=
 =?utf-8?B?dkl2TTcxbWJlRVBrWHRxaldyamNaTFgxdUF1Y2x1VmNTcVBVZEZvL25Gd2tm?=
 =?utf-8?B?V1Eybi9KOVJKZHIveW1kMVNmeUNVa3NpeDd4VURsRkRnSUZUN3p1SXQ1anhK?=
 =?utf-8?B?eVdDTTRNUUg3czYvK0lzUGFQcENCUEt6bGl6MENEalJ3aDFGaWlRVzRUMnRX?=
 =?utf-8?B?MEV6NmRseUFpYTdHL3FqYW41VWc1S3BYZEtkSGxTUkdZNEhBTXkwSkRSWVhr?=
 =?utf-8?B?enJSZ3V3VmJTa2gyWTdFVkdtcGpoTEVBSHB3Z2pUeFZ2M2IySDhTUTN4djUz?=
 =?utf-8?B?NUtscEVXM2Z3bFY2RGp2cGdpTXh4TG0rZmhhVDNLbGcrMFJ3dlUwSzlGYTQz?=
 =?utf-8?B?NEVxenZ4Wmt3TGdDalhRdWxSaFVVUWNaZUN2UlFZTFhFU1BPTFZhYlM1eHIv?=
 =?utf-8?B?YnVNbFFSYkRFaUZBcXpodHhnWldmRkUzUDVvQjVSZUlIb3FmOGw3UUM0TEgx?=
 =?utf-8?B?MFh2RGEyVHg3OVFhSE53OFhLakxqOHV2cGpJeHJVSXlLQXJBZUV3SFlMcHR2?=
 =?utf-8?B?OHZ2cmdKaGRvMUMvZHlmdklZUktUbk1FUFdoQk5YVENHS1pVN0VPRWp0Z214?=
 =?utf-8?B?Z1RYOEpJcHB3aXRXZ3I0cllMVVpRUk5xWTdXNXdpL0p1NTlCQnA5N1FRWDJ3?=
 =?utf-8?B?cnJoZGhrdm9MSFF3d1VlTlJzOVE5V0srdW8yd1o5RWdyRk5FYml5dUU3RWxK?=
 =?utf-8?B?TllLMW1nNVdXRytaYk5JWlVkKzdwbGdTRDhQYTdOTVpPRTh0Q0xzdkRsTmFm?=
 =?utf-8?B?WkJVUzhuWUNhRmZZZllKdzNvVWQwT203RTQrcVFHb0RSRHY5R0k4MEZZOC9l?=
 =?utf-8?B?dGlVbDEyMXFMbmZkYjNvcDdaR0JXODhaZ1hhYktwRytrT3VlM3NGbEdoSlZl?=
 =?utf-8?B?a2c5amkxTWlYV1c3K0tneUt6b0h6MUVMN1l0SG1mQXlRYWJiQXlJcUpZSTZG?=
 =?utf-8?B?MkRHdld0SDhDZUJ6Z0RIQURaNTdCbkNQdDJLWWR4clZuODBFSWg1QlNNdTlF?=
 =?utf-8?B?VHE1aGlCb1BMR3pxeFN1bTFaTmpnOHZnY3R2RWtmeEg2cjc5blgyT1czdGJw?=
 =?utf-8?B?UVdFbVB3Z1JwYnV0b1NidDkvZHZUUGp2dzQ0Z3RJRFVQUytJL1Jyb00raU5z?=
 =?utf-8?B?Wnlya3pMSW85ei9lbFJPNWE5U29vc08xUTY2b0psWnlrS1JZYWxUM0JvU3pX?=
 =?utf-8?B?d1NNSzhpcVFqV3RBZFhlZEQ4ODJlL2VyY3JaQzFibWxXVFI3TzZlZFlYbHVU?=
 =?utf-8?B?ZXVVUFhvYkFHdnRtUDJpdmRUZHh3SnFyNDZNd2FHUS9QNnRlSjRQbUNGNmJZ?=
 =?utf-8?B?N3QwaGN5a0lPQXJ3UmtHQmdXdFRQcVlSN21GUy96UGViTlBlNnZ4ak50dktI?=
 =?utf-8?B?UzhNbEZkVmJVb1BBY2lYbHJqQ2E0eDZhL3kvMFpXajVjSjVKaFByUHp6R1VW?=
 =?utf-8?B?QU1CaC9jUzdGL1IvaGNSMW5vbytyQ1RDeFZSVm5zT2ZkRmNFekpEZ1hkWWpG?=
 =?utf-8?B?bUFDK0xkd3Fld2laTHcra0srNUJabTMzdmV2bFZZbit6UXIveVp4djVsYkw0?=
 =?utf-8?B?YUd0M3J3RXdmSkpVSzhFKzB5bGRnRkxNVmR5RGFjWDErWFdCa1h5anljc1Q4?=
 =?utf-8?B?dzFwWlNFYitCTitjSTl0dVFpeitZV3BjMTdpanFTaEVocTFrbU1nTHZrZ1NV?=
 =?utf-8?B?VjNZMEtjK3BWTld2cjlmSlBOSjV5cG1kRnNSNW9peUpLT1dQaVlJRU9tU2NB?=
 =?utf-8?B?Z2RzRmM5YW9LcnNPZ0hWd3M1cnNwRXNzOEJrOW9MZXF3Q3ZHRTU5TXFhTVJj?=
 =?utf-8?B?NUNoVWZ2bXB3MmZ5U0tNRER0ZEMxZUY2dElmZDN5Y2UySzJTczgrdVFUVFpt?=
 =?utf-8?B?YWgrRlljbFVJZWI2UGtjSWVJcnEyYitUQ1c0R2NMQW4rQzZNQXkzUU5yT3p3?=
 =?utf-8?Q?EvJdgRAwpMEvFYGk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Zf8elrkojfQdHLplxPSo4yK9pOgnQPMMprHUKo82JkQvl86yNTT6u7FAqvRzYBNdLnuPysxlVmp8BstvFqQDqny1cWRhAcdoxkdIDAaCWkbh77LFjBUgp1P5ILvzqgKv76QMGIEOh1HCHFDMNpA6qp6fjlUNhGD4z0Xuil3d/pUjxQZg/3YpD7F/p0nRjF86T2yIY3G/pKQ7VqTDdvTi73RoDCb8vNdc6V/1zzPvjfuZV2K1E+0W4p1UNIHK0+vefUDENNd8FZMhHxLc8ThB/MIuhK32ckKHzwIfbK/qurKFCa8fafTrKq8nMw4io2MAQKvogLpLBhp4MU1Nvqflcw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e59c4a-c185-4674-e460-08de7f500851
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:24:44.6383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yzVMZJlgYUyNW1d1n7aK2gDj2On6Yp4tdJvWL75v0WwQK8k+SncwWDB0auqqFg+FHOhWsQ/6XA7hgcstAFc1oOtOHcR/GJGawyNNy64hpBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6836
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [Intel-wired-lan] [PATCH 39/61] irqchip: Prefer
 IS_ERR_OR_NULL over manual NULL check
Reply-To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 3408
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/fcyaY21rjldBhDIim1QgQA>

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
bS5kZT4NCj4gQ2M6IE1hcmMgWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+OyBUaG9tYXMgR2xlaXhu
ZXIgPHRnbHhAa2VybmVsLm9yZz47DQo+IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD47IEdy
ZWdvcnkgQ2xlbWVudA0KPiA8Z3JlZ29yeS5jbGVtZW50QGJvb3RsaW4uY29tPjsgU2ViYXN0aWFu
IEhlc3NlbGJhcnRoDQo+IDxzZWJhc3RpYW4uaGVzc2VsYmFydGhAZ21haWwuY29tPg0KPiBTdWJq
ZWN0OiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggMzkvNjFdIGlycWNoaXA6IFByZWZlcg0KPiBJ
U19FUlJfT1JfTlVMTCBvdmVyIG1hbnVhbCBOVUxMIGNoZWNrDQo+IA0KPiBQcmVmZXIgdXNpbmcg
SVNfRVJSX09SX05VTEwoKSBvdmVyIHVzaW5nIElTX0VSUigpIGFuZCBhIG1hbnVhbCBOVUxMDQo+
IGNoZWNrLg0KPiANCj4gQ2hhbmdlIGdlbmVyYXRlZCB3aXRoIGNvY2NpbmVsbGUuDQo+IA0KPiBU
bzogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz4NCj4gVG86IFRob21hcyBHbGVpeG5lciA8
dGdseEBrZXJuZWwub3JnPg0KPiBUbzogQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPg0KPiBU
bzogR3JlZ29yeSBDbGVtZW50IDxncmVnb3J5LmNsZW1lbnRAYm9vdGxpbi5jb20+DQo+IFRvOiBT
ZWJhc3RpYW4gSGVzc2VsYmFydGggPHNlYmFzdGlhbi5oZXNzZWxiYXJ0aEBnbWFpbC5jb20+DQo+
IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcCBIYWhuIDxwaGFo
bi1vc3NAYXZtLmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYzLmMgICAg
IHwgMiArLQ0KPiAgZHJpdmVycy9pcnFjaGlwL2lycS1tdmVidS1vZG1pLmMgfCAyICstDQo+ICAy
IGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12My5jIGIvZHJpdmVycy9pcnFjaGlw
L2lycS1naWMtDQo+IHYzLmMgaW5kZXgNCj4gMjBmMTNiNjg2YWIyMmZhZjcyMmRkMmIyNGZhZjk2
YWY2MzZhNGJiZC4uNmRjOTgyNzM1N2EyMWFlMDVkZDgzOGZiNzE3OA0KPiA3MWM3M2YzYzc1NjIg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYzLmMNCj4gKysrIGIvZHJp
dmVycy9pcnFjaGlwL2lycS1naWMtdjMuYw0KPiBAQCAtMjI1Miw3ICsyMjUyLDcgQEAgc3RhdGlj
IGludCBfX2luaXQgZ2ljX29mX2luaXQoc3RydWN0IGRldmljZV9ub2RlDQo+ICpub2RlLCBzdHJ1
Y3QgZGV2aWNlX25vZGUgKnBhcmUNCj4gDQo+ICBvdXRfdW5tYXBfcmRpc3Q6DQo+ICAJZm9yIChp
ID0gMDsgaSA8IG5yX3JlZGlzdF9yZWdpb25zOyBpKyspDQo+IC0JCWlmIChyZGlzdF9yZWdzW2ld
LnJlZGlzdF9iYXNlICYmDQo+ICFJU19FUlIocmRpc3RfcmVnc1tpXS5yZWRpc3RfYmFzZSkpDQo+
ICsJCWlmICghSVNfRVJSX09SX05VTEwocmRpc3RfcmVnc1tpXS5yZWRpc3RfYmFzZSkpDQo+ICAJ
CQlpb3VubWFwKHJkaXN0X3JlZ3NbaV0ucmVkaXN0X2Jhc2UpOw0KPiAgCWtmcmVlKHJkaXN0X3Jl
Z3MpOw0KPiAgb3V0X3VubWFwX2Rpc3Q6DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lycWNoaXAv
aXJxLW12ZWJ1LW9kbWkuYyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtDQo+IG12ZWJ1LW9kbWkuYw0K
PiBpbmRleA0KPiBiOTlhYjlkY2MxNGIzYmE5ODI4NzZjZjU1MjU0OTlkMDJiYzFjOTk3Li45NGU3
ZWRhNDZlODE4MzNjZmUwNDc5YjZmYWJiDQo+IGE3MTViZjRlZjZiOCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9pcnFjaGlwL2lycS1tdmVidS1vZG1pLmMNCj4gKysrIGIvZHJpdmVycy9pcnFjaGlw
L2lycS1tdmVidS1vZG1pLmMNCj4gQEAgLTIxNyw3ICsyMTcsNyBAQCBzdGF0aWMgaW50IF9faW5p
dCBtdmVidV9vZG1pX2luaXQoc3RydWN0DQo+IGRldmljZV9ub2RlICpub2RlLA0KPiAgCWZvciAo
aSA9IDA7IGkgPCBvZG1pc19jb3VudDsgaSsrKSB7DQo+ICAJCXN0cnVjdCBvZG1pX2RhdGEgKm9k
bWkgPSAmb2RtaXNbaV07DQo+IA0KPiAtCQlpZiAob2RtaS0+YmFzZSAmJiAhSVNfRVJSKG9kbWkt
PmJhc2UpKQ0KPiArCQlpZiAoIUlTX0VSUl9PUl9OVUxMKG9kbWktPmJhc2UpKQ0KPiAgCQkJaW91
bm1hcChvZG1pc1tpXS5iYXNlKTsNCj4gIAl9DQo+ICAJYml0bWFwX2ZyZWUob2RtaXNfYm0pOw0K
PiANCj4gLS0NCj4gMi40My4wDQoNClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxh
bGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg==
