Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52001049524
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xPVL3bTeONWi/ds5cJDTAGXrbPqCVMwyIidh5uvqAMA=;
  b=j/rSw1SiDAcyVMUu8sVMa6x3R1ejnC4qXTYuxauQP4c6WaB9QiD0JvAo
   +lnKOmqzB0Y1qkOvA9AvalTUyGRgEap4A6r5/qeyXvVy+yEFSRJDSimWh
   9UZaMGDE2Hy+u8dIvVljr9bUIFnSvJMO8UfmobvAJexinRBRV4cNor6jZ
   o=;
X-CSE-ConnectionGUID: KfwLvBMxQxiQG3ezlB2Zkg==
X-CSE-MsgGUID: Xe8SuFWnQIup+KlUwlwnow==
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
   d="scan'208";a="267246125"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:27 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 4CC4C818E1; Wed, 11 Mar 2026 10:46:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id D60EE80641
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 10:16:17 +0100 (CET)
X-CSE-ConnectionGUID: OKCRF3q4Ry2sPfWDaeFV5A==
X-CSE-MsgGUID: h8/DMdt/SUiQ16uxNU9Xbw==
IronPort-SDR: 69b132e2_2TFxW6NDX5YaXnrUo/IyTm1PZ8Go6CMbyykniHd90DchqYn
 OoSgEJjeK9kN2/R36dOfi3gcHDHjMJRU4uxJDFA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ENAAAiMrFpjxBBr8ZaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwHAQELAYFtU4FoMQRUhFiDTAOETYc3giEDgRObXIErgSUDGDUIAg8BAwELA?=
 =?us-ascii?q?QEuIAECBAEBAwSFAAIWjQ0CHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEBAQENA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQEBAQEBOQVJhk8NgmIBgSReBwk4AQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBEQINXgEBHQEBAQEDARERBA0MAQE3AQsEAgEIDgMEA?=
 =?us-ascii?q?QEDAiYCAgIlChUICAIEAQ0FCBqCYIIjAQZKAwECAqIYAYE9Aooqen8zgQGCD?=
 =?us-ascii?q?AEBBgQE3gkJCQEKAYEKLgGFO4MXAQGBcIJKgSABGYQAeieBZUOBFUKCMDg+h?=
 =?us-ascii?q?Ao7FYNEOoIvgzSMTYZWCUl4HANZLAFVExcLBwVhQhAzAyAKLy0CFA0QEg8EF?=
 =?us-ascii?q?gUtHXAMJxIPHRcUH1gbBwUSISoHgUF4gWYbD4ZoeQMuXhoOIgIoEgMyBCOBB?=
 =?us-ascii?q?gtaBYIsAhwDC209NwYOGwMEOnsFjWs9ghQfAQGBDYEHPXwYS5YYSa9WAwQDh?=
 =?us-ascii?q?ByZXIgyF6prLodlkHMiqHQCBAIEBQIQAQEGgWg6PIEgcIM3TwMZD44hDA0JH?=
 =?us-ascii?q?INCjz0BuXpFMzwCBwsBAQMJhUYBAYwiNIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:vParia4lXXXA5CV72gPXwFfXdLJyesId70hD6qkQc3dom6uj5r
 qTdZUgpHvJYVkqMk3I9ertBEDiewK4yXcW2+gs1N6ZNWHbUQ2TQ72KhrGN/9SPIUDDH8dmpM
 VdmtBFeb7N5CNB7frS0U2CCc8pxNTC2Kq0heHYpk0dKz1CWuVa9R5wDgveK1Z7ADJLH4Y9Cf
 Onl7J6jgvlQm4PZsC3QkEYU/TO4/3H/aiWGiIuNlod8hCHiT7t0rLgDBSCty1uKg9n8PMZ6G
 DAnkjD6r++tuzT8G6661Pu
X-Talos-CUID: =?us-ascii?q?9a23=3AknT4gmoj+l1mLSnvlc48dxfmUecGWUfzl26MGV7?=
 =?us-ascii?q?iEl5nd5GcRHGupYoxxg=3D=3D?=
X-Talos-MUID: 9a23:UbPN2wn0SO+1q+TXVJJKdnpiZIBExqiyT3swkKxf5dSUExEhCz2C2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267237005"
X-MGA-submission: =?us-ascii?q?MDFfX/Y2LfjvQczYVjc36VwOeZCD3myMhCaAcl?=
 =?us-ascii?q?6bNKj8LGgm6P+IA40JL3Fjlcdvh8GTaQwb4EqFp7uDcPMvtljOSSVRl2?=
 =?us-ascii?q?ea6q6c5iSGc/os9ccvKWAGMYnxfV/6z3gOVMosXddQIP7uWO46I3jO2x?=
 =?us-ascii?q?t9LOgFhefmJ6DfbkjtG1fXug=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.16])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 10:16:17 +0100
X-CSE-ConnectionGUID: IaZGONTqQQmgcT02SGEGyQ==
X-CSE-MsgGUID: 8h0RQiEcR0GXTOyRaJPGtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74473160"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74473160"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:16:15 -0700
X-CSE-ConnectionGUID: 0nldSm1gQjySuKZO2vFqPA==
X-CSE-MsgGUID: z1vnnK3bT6GqnlTxUKLRkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="217088498"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:16:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:16:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:16:12 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:16:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/04S6Prr2YA2xe2B3IprnhrK7EgUmJRr1d/dWgNNo1VyR+AGeHf70MFTmnZCUa6yJrDLzQAGLT/gizQz1D9PDrj0wkd04QQLtgpNSdGKa+2MtdH5LSrS3Mfk8fRNbaMEaLcWULWgs+iVRyzhFw1oWIFZyjELsu6cfLmgB2hQJnFFyQsIqT5WiXQTazrikD070Ftk1YCd8p3tT+exOIDiUGjCVeDRBb0dQTDIE66MlVHYTiW50u72SRewNrkdKVSQOo3t7Tfe19JltpwtkxYEq1S4KrIHODYKBfrm5ZVCTltiv6btrS/Da7bDDaNxA6zgNI6VG6OYTjMixb2e0xlEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPVL3bTeONWi/ds5cJDTAGXrbPqCVMwyIidh5uvqAMA=;
 b=CKBOAgqZ+sYTR9FSJGdOI5a5Rt0GJswEcmJFCN0S/PIo91CN8VepAt0aERjuu3wwDCtGUyWOqyKu3trreCp+8R2GlQH0YCVZCqvQlG38ugcFFGWfQZD6Q8WFCYRuJJ+Y/tbqYUz5Y2/ooQuXdOK11ymBuBXAvEeLUBO/hVPlBllNNGfCWcgnPpgsl6G/IkH2uZybj86P1F7zwwdwwSAHM60Ylg3cCzHkDk90g++a1afzgjhJ33WNXJp4usIzuAaMr6so1shLrPu3VGUBFoYSsUdYmqIiIQYOFZYQcZ2k0jrNFShbR287OLH3GZCtRUFAbJv+2eAF5EE7Guo6wNkbIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA1PR11MB6291.namprd11.prod.outlook.com (2603:10b6:208:3e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 09:16:08 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:16:08 +0000
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
CC: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi
	<arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Thread-Topic: [Intel-wired-lan] [PATCH 16/61] sched: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Index: AQHcsKKfUYNoLm9pdUuTIzut4nKxsbWpDgGQ
Date: Wed, 11 Mar 2026 09:16:08 +0000
Message-ID: <IA3PR11MB89860B67553D69141D41B381E547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-16-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-16-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA1PR11MB6291:EE_
x-ms-office365-filtering-correlation-id: 21fb89e6-e749-4c05-6fde-08de7f4ed4cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: qTRoNxtrbOzoNiDMXOgHCRRy4iHbiJrgtvgwYO44MVanYjZgMhyavLxKBk7cdDGb6c936CFY/D++xMeX2S2/7CM4v6vVLPXA0FJFsc+2fEetReB07WYN4Yo1to/CVH4Hl8c9xGG/RnRoxtww2Nyjz9UVg0Evk4vIGYmYDGMaiD5qcjqEHdICUg0xFoDhN/ZIQsrEYjGJHgfrjWvCERcw/+LcDcpBacDAhD5edPGUZqm7eJ7E9KFnU7kU7j6XYyRkZ4MGa2dzl93dOOHyun61nI5yfMNQS9pMByKpRmjxxQQtg3riDgn0T458vn2T9gJSfQfr5vQaEt09jfzbsWt02UU8qcZSP95yawlaVAeHTCQDykGEv9dwiOrJx2Fqf6k7u6KszQfzgo6oGNxxBOA5Ox2+WG0Ynch2n2tBp7AB6Fp3c5GrPMhsjNG9FFwGMh3i4iXD5A4R+5AZhSL2SvcVc6xjnOoI8ASm76kx+cr6Tjpa0YhFmOB9wAKFIeqr9eD+Y7JVLI73qC2rku9bESO7bmNOqwJQTpf4gRT2M//vxHmWVQ+p0o0YUrrpt7bsTrrU+BcoQoMPFLJ3GBmid44Cvs6JGuaiJZjrEHpPr2FR/pzZRQ3WwsOdUUq0S3w4uRS7phrCeZMTskyyaJi0phvIz1Jt1MKX0gKv+3iHsjBoAwLCR5/FPTl59m7WxiVerDBxqrvwbmUSQp2hhtqV/5H9lRmrSlskd22+2NqJ4tTV1s4hSiq1jBjWGE+xWG2K6c0NjSnFSfm0EWNDIx2AraNR/VV6JB5tU5hhPnnijlps1/0iRCljCFtaSrD2CA1/RKg9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWxaUFFaK0lPT216T0xlQ085QXhWeFhJQkp1enl6ekJxUHVFaEJpb2FFeUFw?=
 =?utf-8?B?OFprdTRrOGhFeHg5dk5vd0RPdGxPT2ZOeFpLTk1qQVhSSzBzYkkvZDI5WEtP?=
 =?utf-8?B?VDgxd1FXS245SkRHeXE4TlJQSWM3WjdNTnRjcTZxQllDT0s1MmUzVU1GZHBr?=
 =?utf-8?B?RGhNZ2ZINzhLTS9zOEEvRzcyMUlBd05lZE4xV2pPL1hkV05Jd09ONCtxUUxP?=
 =?utf-8?B?YXVNVVllSnhwamd4b21XcjhkOVFtb3Bpak1IMHU2VnFsTWZUeWl3US9WZUJF?=
 =?utf-8?B?cldJWnpPZDVDcFYvcVpzU1FDOVY0Um8wYnBYaVB0blluN1NBYk9hWHEwT09X?=
 =?utf-8?B?czBVTEptOXR3V2JIVTF4ZTNGRDhvY0EvM1kyYTBwWmk0OFlGSFdiTGs4Y1Rm?=
 =?utf-8?B?VHdoSVU1bEQxd0oxQmgrWXRPdmNRKzBaWFVzWWhoRURpcFgyc0lVOWJwRFVS?=
 =?utf-8?B?UXV1ZUpDdldMMmgwN1gxNGY2RUVrdDZxcVAxOS94YXZkcXF6cElXSkJCQkNp?=
 =?utf-8?B?YUNvcXJrL0lkNTNVT0svSE5kRVUxbjlRdmpWZ3A2TWJHSWRTblJUcktkU1c4?=
 =?utf-8?B?TWNUUzJCRDFMU2U2SXBBZG1KUWtxa291cEEydEZKU1htdmxnVXNrWG4yREVZ?=
 =?utf-8?B?OCs2cElscUpsaXoyTG1HTmthOHBpelZjUXd5OWVzRFJ3eFFDUVU2azZqcnYz?=
 =?utf-8?B?SmQyRVovL1lxTFFoVkJTVlNCUHBPUFUrckZmWlNoclFUMG1WczZ6WFFxbXZK?=
 =?utf-8?B?RUJZdjI0TVVRWUNkckl1K0F2K0E2b1dVem1KRnluM2VVSlg0czlFYkxydHJw?=
 =?utf-8?B?STVQa2lLUE1Db3N5YUR3QisvRHBvWlIwMVlmQmROSnBBc1U1alBqNmxUWWNZ?=
 =?utf-8?B?dmEyeEhXRU5wakg4Z0wwTkxMV0U4ZzRaYmNPTmN6bXdhVnNsdW52K2FFYkRV?=
 =?utf-8?B?eFkxVUNGQytXVTZ2cnNSWHFESEs0YzEvRzcvZWg5TEIwTzRPRHRFM0RIWUZZ?=
 =?utf-8?B?TUU3QysvT2xzakp3Q0RXM1VGN1pvM1Zqdm9KNmVVRFdYa2FJU0hYMVNOZDBx?=
 =?utf-8?B?RXgxYnhXbWNlR21UOXpkV01ZSmk4VnpYOGd2OWRmTTlQbjk1VklMVzFEcld5?=
 =?utf-8?B?RTg1ejRJOXVidVUxenN4RDJhbTZRdEt5aW5HcitDOWxZT1pCcjlnRStZakx4?=
 =?utf-8?B?aHZGb2YzOFpRUitMUTNZMEFmMGJ3eERyVmJaRlIvaklNNkw1Y2NCK0xFc0Ix?=
 =?utf-8?B?REF5MFdzenVrNUF3ZmNDZGFLY25waVBMeG1JYVZiNVdvdi83TitHM3BoOWtk?=
 =?utf-8?B?RU1uMUxYNU9Hd3UxemRWWUlIWUVwSHBobmZ0WjNZZGI0T1FWUUFMbUwxRm8z?=
 =?utf-8?B?VWFicTZTTjZpMjUzdlRMcEJHZ3lQakV2aDl3NWpVd1hYRW14MUpJM2dZbkZD?=
 =?utf-8?B?WFpHUDEzd2xKRzFJVUdHbXJjbDBRYmRlU2U0NTYrcFZBYmpERWw5NUU0blph?=
 =?utf-8?B?em82anRFWXVUTlRSY0hoK2pVdGl5MjFLdHlrZ2NmWXVmSFpyM1hsazBoTlJx?=
 =?utf-8?B?TFcxOTlZRjJmbGF0RVN3WDVDa25oN3hIYVFVZnRBNDYzRDd5WFljTy8xUUpJ?=
 =?utf-8?B?SHJvSGFWaWUycEJHbXlNTjc2ZDI1WU1RcXQxTEtUdm5RMmlVQXVIWUlZUXdO?=
 =?utf-8?B?YzdCS0luL0lpTVAydENFMngyT2FOVEdFdUMyaDJ5U2NYVnhkUy81azhaQzlr?=
 =?utf-8?B?VllIY2lsbFNRS0x1bkdUbXVmSnNjaUFZNGRJSVRpMHRRYnRWdUhJUFk4WVhX?=
 =?utf-8?B?Qy9RNXpLcHdyZWQyRStGMnViN25vYzlLdldFVjhQTnAxOWs1Yk9OTG40djVn?=
 =?utf-8?B?ZDFCdXU0ajlJOHZsWGdneURva3ZySnhyUnFybTI1VHJ3WlREcFFkRldvbGNr?=
 =?utf-8?B?MmhOZCswZnBKQStzenUwRFNObzArZjFkMllpNjRZdURoL2tEbnpUZmVFWVlQ?=
 =?utf-8?B?Slc4cGwza3Z2K05XM0xuYUlOV3hzNlkrS1htbjYrc0FUOHpGQjJrMXB1eEVi?=
 =?utf-8?B?cFBCMElNOEVxOHZzRmd3TjFKVmdSU1BpSFdkalBlWFBlTEErdUpGSXRiNEpG?=
 =?utf-8?B?MlptL255NGl4U1RWRlZPeXNFZ2tHd0M4Mkt1OG1GVkxHUnNXREhGeHVWZmRZ?=
 =?utf-8?B?Zy9Ya3NYbUF3bG1yQkRFUnp6T1dvd2tGNDlWcklYRzdYTGw0TDliSXoyUHBT?=
 =?utf-8?B?bURaYmgrbHY1ZGZyb0o3L1IxMC9GdDF6dmYrNGNiRHl5LzFDck1BMTJnY1F3?=
 =?utf-8?B?aU5WcnByTjczbHZnRkdsTVlRU1I2NnhIamc3VWVIcGFyUHowbWgvWDZEOU11?=
 =?utf-8?Q?AxQtvYoIkyHYX4PA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M3cngJEvkFuurESqdwsRbufXMuRoqMkoe6jxfomI88XKAiMl7ZpyE5ss46HqjTtO3g4uf7YqDnk/nQDsPkB1r6tIelsYVMm01y5Nd9qG/rlyVJybZfaL9H+9ijc4ui8EXmDe41aKbVnxbq4xOpX3Ma0UKZS4roN3UnszvRSu76YH0sGNhcw8/0A/AyBV9EKiitGKA1lf46ndW/+UJDUSzxpuR25eDuanCI1ZudbTl/lMPnr1f/mYSg+QHVshBtO3/75kI1ed51WwnsOgM3pqnzpMvPOLPLFrWxpdcm/Sg8OVr2SntFxTlEfhY1WS3fH7WFbYSKe0oLxQ7x8Fj3veRw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fb89e6-e749-4c05-6fde-08de7f4ed4cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:16:08.7290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h47sHmLqaUCG9vERJMTMEVxi4anH3F71frhZm7Ao4Df9aB1l1rCKts+uUTjDLDD04Kf+AvEB5gcJrSB0AOLGrVWD6Gml2s+5NUYuU0ZCqVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6291
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [Intel-wired-lan] [PATCH 16/61] sched: Prefer
 IS_ERR_OR_NULL over manual NULL check
Reply-To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 3400
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/dsBYz63so0xYjlRNMGSq0Q>

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
bS5kZT4NCj4gQ2M6IFRlanVuIEhlbyA8dGpAa2VybmVsLm9yZz47IERhdmlkIFZlcm5ldCA8dm9p
ZEBtYW5pZmF1bHQuY29tPjsNCj4gQW5kcmVhIFJpZ2hpIDxhcmlnaGlAbnZpZGlhLmNvbT47IENo
YW5nd29vIE1pbiA8Y2hhbmd3b29AaWdhbGlhLmNvbT47DQo+IEluZ28gTW9sbmFyIDxtaW5nb0By
ZWRoYXQuY29tPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsNCj4gSnVy
aSBMZWxsaSA8anVyaS5sZWxsaUByZWRoYXQuY29tPjsgVmluY2VudCBHdWl0dG90DQo+IDx2aW5j
ZW50Lmd1aXR0b3RAbGluYXJvLm9yZz47IERpZXRtYXIgRWdnZW1hbm4NCj4gPGRpZXRtYXIuZWdn
ZW1hbm5AYXJtLmNvbT47IFN0ZXZlbiBSb3N0ZWR0IDxyb3N0ZWR0QGdvb2RtaXMub3JnPjsgQmVu
DQo+IFNlZ2FsbCA8YnNlZ2FsbEBnb29nbGUuY29tPjsgTWVsIEdvcm1hbiA8bWdvcm1hbkBzdXNl
LmRlPjsgVmFsZW50aW4NCj4gU2NobmVpZGVyIDx2c2NobmVpZEByZWRoYXQuY29tPg0KPiBTdWJq
ZWN0OiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggMTYvNjFdIHNjaGVkOiBQcmVmZXIgSVNfRVJS
X09SX05VTEwNCj4gb3ZlciBtYW51YWwgTlVMTCBjaGVjaw0KPiANCj4gUHJlZmVyIHVzaW5nIElT
X0VSUl9PUl9OVUxMKCkgb3ZlciB1c2luZyBJU19FUlIoKSBhbmQgYSBtYW51YWwgTlVMTA0KPiBj
aGVjay4NCj4gDQo+IENoYW5nZSBnZW5lcmF0ZWQgd2l0aCBjb2NjaW5lbGxlLg0KPiANCj4gVG86
IFRlanVuIEhlbyA8dGpAa2VybmVsLm9yZz4NCj4gVG86IERhdmlkIFZlcm5ldCA8dm9pZEBtYW5p
ZmF1bHQuY29tPg0KPiBUbzogQW5kcmVhIFJpZ2hpIDxhcmlnaGlAbnZpZGlhLmNvbT4NCj4gVG86
IENoYW5nd29vIE1pbiA8Y2hhbmd3b29AaWdhbGlhLmNvbT4NCj4gVG86IEluZ28gTW9sbmFyIDxt
aW5nb0ByZWRoYXQuY29tPg0KPiBUbzogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQu
b3JnPg0KPiBUbzogSnVyaSBMZWxsaSA8anVyaS5sZWxsaUByZWRoYXQuY29tPg0KPiBUbzogVmlu
Y2VudCBHdWl0dG90IDx2aW5jZW50Lmd1aXR0b3RAbGluYXJvLm9yZz4NCj4gVG86IERpZXRtYXIg
RWdnZW1hbm4gPGRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbT4NCj4gVG86IFN0ZXZlbiBSb3N0ZWR0
IDxyb3N0ZWR0QGdvb2RtaXMub3JnPg0KPiBUbzogQmVuIFNlZ2FsbCA8YnNlZ2FsbEBnb29nbGUu
Y29tPg0KPiBUbzogTWVsIEdvcm1hbiA8bWdvcm1hbkBzdXNlLmRlPg0KPiBUbzogVmFsZW50aW4g
U2NobmVpZGVyIDx2c2NobmVpZEByZWRoYXQuY29tPg0KPiBDYzogc2NoZWQtZXh0QGxpc3RzLmxp
bnV4LmRldg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2Zm
LWJ5OiBQaGlsaXBwIEhhaG4gPHBoYWhuLW9zc0Bhdm0uZGU+DQo+IC0tLQ0KPiAga2VybmVsL3Nj
aGVkL2V4dC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL2V4dC5jIGIva2VybmVs
L3NjaGVkL2V4dC5jIGluZGV4DQo+IDE1OTQ5ODdkNjM3YjA5ZTU4NmFlNzg4YjdmMmU2MzM2MzMy
ZDYwNWEuLmNmYTg2OWJkN2RlNTQwNmE1Y2EwOTQ5OTJhYjANCj4gNGM2MmIwZTkyZmQwIDEwMDY0
NA0KPiAtLS0gYS9rZXJuZWwvc2NoZWQvZXh0LmMNCj4gKysrIGIva2VybmVsL3NjaGVkL2V4dC5j
DQo+IEBAIC0zNjg4LDcgKzM2ODgsNyBAQCBzdGF0aWMgdm9pZCBzY3hfc2NoZWRfZnJlZV9yY3Vf
d29yayhzdHJ1Y3QNCj4gd29ya19zdHJ1Y3QgKndvcmspDQo+ICAJZG8gew0KPiAgCQlyaGFzaHRh
YmxlX3dhbGtfc3RhcnQoJnJodF9pdGVyKTsNCj4gDQo+IC0JCXdoaWxlICgoZHNxID0gcmhhc2h0
YWJsZV93YWxrX25leHQoJnJodF9pdGVyKSkgJiYNCj4gIUlTX0VSUihkc3EpKQ0KPiArCQl3aGls
ZSAoIUlTX0VSUl9PUl9OVUxMKChkc3EgPQ0KPiByaGFzaHRhYmxlX3dhbGtfbmV4dCgmcmh0X2l0
ZXIpKSkpDQo+ICAJCQlkZXN0cm95X2RzcShzY2gsIGRzcS0+aWQpOw0KPiANCj4gIAkJcmhhc2h0
YWJsZV93YWxrX3N0b3AoJnJodF9pdGVyKTsNCj4gDQo+IC0tDQo+IDIuNDMuMA0KDQpSZXZpZXdl
ZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+
DQo=
