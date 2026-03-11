Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EA11049521
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=v1t280Vnao4M3LdN6N1OEluSWRx5I9iIpTKM8xy2hGw=;
  b=fJkzbdJGD6aa8qd/zosaWKs81kiqnHz8Fk4xMHFEPjZQtvZ/Vx7hqFyN
   FbzyflFyE5fb6dN2EP05ON5aIAYMxdNXRQNV+bnDTEf+4wWDETLBAZopG
   nYZovGs3gFwqmwheRpO+ib3pp2x+27Q6B/eu4raY2sljRso4bc86XPFah
   Q=;
X-CSE-ConnectionGUID: cUACV6bhQHei3RcQpcI3hw==
X-CSE-MsgGUID: wcW4LKNSRcaEARnnaXRZCg==
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
   d="scan'208";a="267246281"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:34 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 0AC5C81866; Wed, 11 Mar 2026 10:46:34 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id D9CC2818A4
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 10:21:47 +0100 (CET)
X-CSE-ConnectionGUID: IvJPO9cDQRiPBGnTyuWYjA==
X-CSE-MsgGUID: 13KxVuzzSRmUmVtUm2S/tQ==
IronPort-SDR: 69b1342d_eNFISneoZYLuF1lLGE6XyYe3V0HzdojwTn/6rD6GUI0w1ue
 CaEw4wCs9HPwQxkfNQ/JcGaAOxTLm/UbuU1FFEg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ETAAAdM7FpjxCjxsBaHQEBAQEJARIBBQUBQIE8CAELA?=
 =?us-ascii?q?YFtU4FoMQRUhFiDTAOETYlYA4ETilGRC4ErgUA1CAIPAQMBCwEBLiABAgQBA?=
 =?us-ascii?q?QMEhQACFo0NAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBAQEBATkFSYZPDYJiAYEkXgcJOAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARECDV4BAR0BAQEBAwEREQQNDAEBNwELBAIBCA4DBAEBAwImAgICH?=
 =?us-ascii?q?gcKFQgIAgQBDQUIGoJggiMBBhEDNgMBAgKiKwGBPQKKKnp/M4EBggwBAQYEB?=
 =?us-ascii?q?NsnDYJVCQkBCgGBCi4BhTuCeR4BAYFwgXdTgSABGYQAeieBZUOBFUKCMDg+g?=
 =?us-ascii?q?h+CJhWDRDqCL4M0jE2GVglJeBwDWSwBVRMXCwcFYUIQMwMgCi8tAhQNEBIPB?=
 =?us-ascii?q?BYFLR1wDCcSDx0XFB9YGwcFEiEqB4FBeIFmGw+GaHkDLl4aDiICKBIDMgQjg?=
 =?us-ascii?q?QYLWgWCLAIcAwttPTcGDhsDBDp7BY1rPYIUHwEBgQ2BBz1lFxiWYkquZXEDB?=
 =?us-ascii?q?AOEHJlcggCGMheqay6HZZBzIpFwlwQCBAIEBQIQAQEGgWg6gVxwgzdPAxkPj?=
 =?us-ascii?q?iEMDQkcg0KPPQG5ekUzPAIHCwEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 S4Q3MfsPGW3
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:dzv6iayOKhc6fivDGhLGKrPxyugkLtp133Aq2lEZdPULSKGlfp
 GV9sjziyWetN9IYgBZpTnyAtj6fZq8z+853WB1B9uftWbdyQ+Vxe1ZjLcKhgeQYhEWldQtmZ
 uIEZIOb+EYZGIS5amV3OD7KadH/DDtytHKuQ6q9QYJcegcUdAD0+4WMGamO3wzaBhNBJI/Gp
 bZ3cxaujqmd00Qa8SwFlMFU+LAq9CjruOoXTc2QzocrCWehzKh77D3VzCewxclSjtKhZsy7G
 TflAT9x6O799W20AXV2WP/54lf3IKJ8KoDOOW8zuwubhn8gAehY4psH5WEoTAOuemqrHo6jd
 XWpB8kHsJrr1fcZHu8rxfB0xTplBwu93jh41mFhmaLm722eBsKT+56wa5JeBrQ7EQt+Ptm1r
 hQ4m6fv51LSTvdgSXU/bHzJlJXv3vxhUBnvf8YjnRZX4dbQqRWt5Yj8ERcF4pFND7m6bogDP
 JlAKjnlbRrmBKhHjXkV1tUsZuRt0cIb1G7q485y5WoOg1t7TREJo0jtZQidzk7hckAotJ/lp
 752+xT5cxzp4ktHOJA7a46MLSKI32IThTWPG2IJ1P7UKkBJnLWspbypK44/eewZfUzvdIPcT
 v6ISBlXEMJCjXT4Pe1ret22wGIRH/4USXmy8lY6ZQ8srrgRKDzOSnGTFw1icOvr/gWH8WeAp
 +ISdlrKu6mKXGrFZdC3gX4VZUXIX4CUNcNstJ+X16VuMrEJoDjq+SeKJ/oVfDQOCdhXnm6Dm
 oIXTD1KskF5ke3WmXgiByUX3/2YETw8Z95DaCf9ekOz4oGMJFKr2Eu+ByEz9DOLScHvr09fU
 N4Lr+imqSnpXOu9WKN9GltMgo1NDcg3FwhaQI+meYnCTKFTV9YgaTgRUlCmH+cYgRyR8nKEA
 hZvT1MiN6KxrSrtFEfIsPiNH6GhH0Oo3/PR4sAm8S4lLXYRq8=
X-Talos-CUID: =?us-ascii?q?9a23=3AhT2mI2r6YImcqL48RZTMZ9LmUeE7UEX6nXz8GnW?=
 =?us-ascii?q?5MUxGToGEVGCh+ooxxg=3D=3D?=
X-Talos-MUID: 9a23:mDzqGAjIuNhKnqu2SlttqcMpbZxL85qzGlI2q5A7vveYCCkqAHCBtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267238492"
X-MGA-submission: =?us-ascii?q?MDE0cWhV5rBCL7Tyt0ilBYU9UmIBF8epjCBwbg?=
 =?us-ascii?q?GF9cqadnVw6si7eICJsuzMKmJeFXnTtktjDmcOwx7QYEnLe4lyLYnZQu?=
 =?us-ascii?q?k7V2i7AqAJR2+dIg1peJtj29KiiF/FVqlLAzE31KBu7dC2JkDc571bAD?=
 =?us-ascii?q?+EdMO4tLYUHqpIJN6fgZ5RRQ=3D=3D?=
Received: from mgamail.intel.com ([192.198.163.16])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 10:21:47 +0100
X-CSE-ConnectionGUID: gdWQM4pSQqG34Y/juE0ffg==
X-CSE-MsgGUID: w39Z/TxaS7yelyJEgeKnaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="61856358"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="61856358"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:21:45 -0700
X-CSE-ConnectionGUID: N/7289b9QyiHBtEPBGJDwA==
X-CSE-MsgGUID: JtgS+kDiQyOaY4gnmZIOPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="258315167"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:21:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:21:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:21:44 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:21:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXodpLz1ypWACOxjs5Y2yzW80sowbvJYr/aIvDxxQl+ZmlEnPh/FM7km0tAylRfL9xBtInzAJj8Y858Jm2zhRKRHmUnzF1EhKbTKFQI2W3H2H7u3Azyq/LSNGld25wR6ZzkEV7GWoU0rjEFQHWdwbcjwrmSZ1cYfU9cTJD32n45m2b7ipHs+R8ZrDySuZjzNS4x8hckwOdgZ1wXm/GCKgbO/QnWPyTk3m7KADq8I67kSJ3zcD09BbI7zMV+WtfRUXxDaO0XQpRKydHfAtD2/zMb50M3vACZ6k2brlpDiEHMgGQnoNAmNmy6s2bkIuix/XiCDq5L9HIGtfuc6UWp2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1t280Vnao4M3LdN6N1OEluSWRx5I9iIpTKM8xy2hGw=;
 b=iAyEiRaFvhPZh09LE1osOGyngK3EbAzskXqsUU+kRwDn6PCUsYxBt6m9xUoDJQA3Z6xCNEyUWZvjJYD3NV9587UfrVsWitiaYljh3Z9IRbiKP+526n6MrPquTuh9wKXSjStSm12Xge6Bn7WBu4QaR+MIv8bUbTIsz/228IdbRldaB8Xe0qt/GpP0B+/yhWOoO8ujD486aziCbOQVsKRT2TvptQ0nVwTWJJ7d3U7v5rVh52B5x2F61jD+Z4VUzMKX6Ea1LO66VZHgTSaYwtFySc5wCmyQLkmeZ98yngjbmpHWszjpjbC81JMJv80RBPa8IOoyR5voDkE1b1pWYhHjbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7897.namprd11.prod.outlook.com (2603:10b6:930:7d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 09:21:40 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:21:40 +0000
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
CC: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Thread-Topic: [Intel-wired-lan] [PATCH 25/61] net/bluetooth: Prefer
 IS_ERR_OR_NULL over manual NULL check
Thread-Index: AQHcsKKfY2LGU59NIUyiYsEtTLG4YrWpD5cA
Date: Wed, 11 Mar 2026 09:21:40 +0000
Message-ID: <IA3PR11MB8986984785C5D967485333E8E547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-25-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-25-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7897:EE_
x-ms-office365-filtering-correlation-id: 7226963e-0fed-4154-d9cb-08de7f4f9a57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: fJZ5n8hAlyXDfP0YDfkDn7z6vFCt+GrYnz30UYmYjojmxfDFquyzt5QyTDe9wxdqAjAhxkFW2Dwsh5dNNRKcChxLhdRKRe62KmneDcetFkttgK9sacTWDioY3H/qcGKQt0jU1RL0KGZHSDKbCl4dQWRsQkJ/aZncoa53wbbuvAIP2u5/31nFdScaUFkhW9pe8nvCt7PZMS4psIDrtFHcWmgLBB3671Ai3D4BmI/qCX7ztZ3kQDVRACYTGVh5QN+QMSrkOukQxY9qTanZkqO2po7GSA3RClaD6r3Y9jAG1kNQPnWmBKjdoznlKfWWglhG4ixnfDw+qFL2W7vThVD3QzdZV977pmrIDWdwvbQMQ03yFfK4pHj5MHhRME2QT9h+ilPtEpTmroVd/xK3Aum6b5GfTsP+AgonPjB6YOXiVBRjMLI1/soSOgRQ4ii44eN5YCFPPpBWOUIpWss8FJNuzDsfrrVlg2BzHXyzhxErAL5uaE59wkecYdk4mhM3Dxxt+4jC1U1jmSeT89QQExeDQ9F4c4CNXoJR5IeOvpwKQEBuGT5gBJiX5FqkIAf6DvApKzoZm+UMesTjQ043jNazxStk4HQrlZv2KOknuMa8gUkGPQ/JSugLkJvRW0Yp6gxm1Yfe+JWNJjt4d3DBCO5WyGpR/VE87+/dPVqdA+iS0IN8GZKUT8ZZE0M5UBU64/hj5VE0KZManqnyMLdFj5guyHjfcuE4omOqM7zmo2WJ8zt4VMt4UtmobAt1OmMt15GBcD4JZpXEjdYM6U4gxEHxUet15xjMlPNmbP36pbe7Ewzq9O9A8ixqgObSPQNSC+0v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnhKTG9nd3I5V0YySC9UNGpUc3VIUGZhdXRUQlcwQ3d0TFMzZ293V1kzWGNs?=
 =?utf-8?B?N1JKQ014Yld3S3dZbi8wVlFaUnhVNldVQ00vODNyWGp1enZWY0svZE45R3Bp?=
 =?utf-8?B?aHIrbGpCUEVZelNTSmxlTUhCNm5pek5yY1E4SmhJSG1oMVlUTXR3YjIyTE1o?=
 =?utf-8?B?QTNyS0hTbGNjalFnWHc0NEtSd0Y3TDVXWGtUcDJSRWpUdisxU1F0Y0FjdVd2?=
 =?utf-8?B?L2M1VTRWUm5FeE9qU0hwY1FzbzI3MzUvZk1uMGpXbndWTzVhS3R0VVNEYmE0?=
 =?utf-8?B?cEdsR05BdkJtUElxb0xocE5uZm55NUtCVTViNjIyR0hKQzBRcUtiempGNCtO?=
 =?utf-8?B?Mm1XcEZnbWNlOHpSWnY0WTJnSHNrS0Q5L1FvUmJnY1Bra1g3amJkMUc0Rmpq?=
 =?utf-8?B?Mmw1SnF3c1Jad3BsRkQwbG5YMVlNU0V1RENFV2FlY3JNMFpXYjN0TkdabWEv?=
 =?utf-8?B?SWFCbklENGRVTDNDYTYzL1J0NGc2MThtTkFMZXZGM1k0M211YUx0eTEwV3BC?=
 =?utf-8?B?OVNYcVdLczBxekE1Smw4YjNPYzdaWDJndEg1cTJMZFBKSzJYU0lvTVgyQ0JU?=
 =?utf-8?B?dnRmT0FreU92bkJXV3dzOUFqd1VRTnJZOTM3bXljNjljcUxHRDU2S25zWnha?=
 =?utf-8?B?TnJ6KzVzR0xNR2ZQNzFGNVNsRVduTllOV2hTc3ZVMS9FNklkMmVWTytNV0Vq?=
 =?utf-8?B?b3pnOXFPb3FVcXZpVEFOd25xNHNmYW9NeWFXa0VwNkdCNlpmZmNXaVFRMVl1?=
 =?utf-8?B?SXVQQjVlWmd5VFZiMk9xTXRhMUw0SUZiWjQwclpiNk11MktlSEpYWUZ6ckdk?=
 =?utf-8?B?U3cyK1ozT3FxN1ZZZlkzKzhrcTlDMzRRZ3lEMWFvTFp3V0hTOTJMVkhSWWFx?=
 =?utf-8?B?cEhVWEZ4RUNieFk5VVNBSEowYU9ua2VOM3RjNFZJbVZ4cFgyc2R3cHZNT3ZJ?=
 =?utf-8?B?SUJMY2k1RlZzbVRSb3B6ZFN4RnpxQS9mdkQ4RmdxMTVxOU1hQUxYU1JIa3p4?=
 =?utf-8?B?M3RxbHFWR1c0WW9QOW1aSkZ4aWRSUTczMWZPamt4QlNjLzBnQ0s5ZHVUZ3ZF?=
 =?utf-8?B?cnNlaE9aMTcxWWxSOXVIWjdaNWpKQmZoZzRId3hSMTgzVFowZHAzZDBvSjN2?=
 =?utf-8?B?bW9yS1N1SklheXJqVVRCQVpMbENrLytGdXNISXVHbFE5WnE3aEs0UzRpNGlr?=
 =?utf-8?B?OHdCYzRHTWhjdG55VVgxVTRQdlJDd3d6SFhkaVJWQUc5Z3lmZUh5UnFtTlVN?=
 =?utf-8?B?KzZwVnlqQ3R5dkpsYmk0dU8zVHAyUXh5clAzNkR2L1NrSXUxMFRMcE9HbEhS?=
 =?utf-8?B?eWphcWdmS3cwMUo2UUJqMDVMSUtTMlQ2Vnpab0EwNUJtb3lyWFh1RXZKbm1n?=
 =?utf-8?B?TkVWaWs0dCt0Uzh2Wm9pNlA3TDhTWTJQaStLRys3Q0gyYTF3bTNPQkY2dSsy?=
 =?utf-8?B?U1IzZEY3dnhSbXpHQngzUnNYb0JBME9KTWR6blVueDRTYzRTM2lJOUNXdVFL?=
 =?utf-8?B?WVhIemxhNTl5WGxmTk1BTkZsQTc3N1hTWFIzWDI4YTNLNGN6NGdNOTI0S2k0?=
 =?utf-8?B?bmNNNzNJbnptVk1BZlllVW1OZzRWdVhlaGRHQzk4eEtYclBJZmp1aVFCaFFn?=
 =?utf-8?B?YThtYk00b2hpWlVRKy9mMUxXOWVvZ0tnNHUxRVVoR3hoMWpScmF6TW9lZTVD?=
 =?utf-8?B?QU9Ub2Z2cDdna0U4M3c3RTEvdkdwNW1ieWYyRXNCcGUxQUJ3d3p1STM0R2ZK?=
 =?utf-8?B?ZmprNkxUNVR5Sy9sODllaXZPTGFzRThmRWRrOHo5NmJqK0FzdmRuaTc2Z0xI?=
 =?utf-8?B?NnBRK2VaV3cxKzJOMW5XWjJXcjJZUENkL1RHRGFOb2NVWVQwY2pYc2x3UzhY?=
 =?utf-8?B?aWgrelgyL1NUQzZ4b0JXcHFHZjkxQ09SNHZ0bkQzZEFNdkJYL0ppdWkrZCsy?=
 =?utf-8?B?Y3JER08zV0dKTEY4MnlwS1FqK0MzQUtQK0plQitNbmw4SDFjRzBWRWQ2ck9a?=
 =?utf-8?B?aCtpUU5HRVRWczVQS2FuT2tra1FtNkw0MDRESXRkZlIwam5tc1Vmc21kbzU3?=
 =?utf-8?B?b2VxUE5ZZ2JORllYb3ljc1Jxb2lrZlVsK0thb0FTWlh5WjZ4UlZ2Y094N0tY?=
 =?utf-8?B?OElCbmNKazdxK0ZQVEpsV1ZNOTNTcEdtZThuMTAzb0lqSUNZOUFNTjMzZEZR?=
 =?utf-8?B?M0JYa3h6NzBBcFpOd0g4a2dRU1M1c0JIWi9aVDhIcTdZVjVHZ3dzYjBVeXhn?=
 =?utf-8?B?SXp3OEh1RDlHZzZXRG9LaUJIYmhVYWh2dENYNlNiWW5oNnhmSVVFRGlaUzZZ?=
 =?utf-8?B?YnFRUW14RjJOMHZNS3ZFK08wUVNLZ0k3VVlVMUhYYTlVaVdONnFMOCtNaitk?=
 =?utf-8?Q?dp6qTd4tTyIr8nxA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EKSgq8YxyB6SQjCJLYlEMyCI3jNphKsg/+Qj8bvXgpnOPyghf/rR8MM+q1SNVS4rhfFdDEHbU16vqV1PJF+ZgwX3bghoHtvlt9wI/QqzyHK2Y441h+FPRqe68t1OMy/31wxjO51TkQHuZXGGM9yGmtUGmn95KTo3N/pxYO2LbbmWzjcGvfqCIgCXmy0ufA/+MzqhNd0Lmk2bPYsbPy1EB6bSe+OL4aZactvdB4wdqgS+QgLaQq82yViuNZ/+NWU1oufNHIpKLPyFvIQoXQvx4Rc2C/ZlRQgzKYrWuz5goSXRUEuI7rontLLjHpP0W54mjZOPsSu3FCLdmJxxNiRlGA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7226963e-0fed-4154-d9cb-08de7f4f9a57
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:21:40.1727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KXVyM1udEKOqZuvOHaP8T8W4bTGeVYOjXfLAgEw/Lyi0EG1f9FPPOfFsv8kpQvm1q6xkaU61sKgabJVhEvk/ZHNb+mqLMIoMp777pmRqkgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7897
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [Intel-wired-lan] [PATCH 25/61] net/bluetooth: Prefer
 IS_ERR_OR_NULL over manual NULL check
Reply-To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 3404
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/6jXLk3HxcRATUKgRmY4w8w>

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
bS5kZT4NCj4gQ2M6IE1hcmNlbCBIb2x0bWFubiA8bWFyY2VsQGhvbHRtYW5uLm9yZz47IEpvaGFu
IEhlZGJlcmcNCj4gPGpvaGFuLmhlZGJlcmdAZ21haWwuY29tPjsgTHVpeiBBdWd1c3RvIHZvbiBE
ZW50eg0KPiA8bHVpei5kZW50ekBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1s
YW5dIFtQQVRDSCAyNS82MV0gbmV0L2JsdWV0b290aDogUHJlZmVyDQo+IElTX0VSUl9PUl9OVUxM
IG92ZXIgbWFudWFsIE5VTEwgY2hlY2sNCj4gDQo+IFByZWZlciB1c2luZyBJU19FUlJfT1JfTlVM
TCgpIG92ZXIgdXNpbmcgSVNfRVJSKCkgYW5kIGEgbWFudWFsIE5VTEwNCj4gY2hlY2suDQo+IA0K
PiBDaGFuZ2UgZ2VuZXJhdGVkIHdpdGggY29jY2luZWxsZS4NCj4gDQo+IFRvOiBNYXJjZWwgSG9s
dG1hbm4gPG1hcmNlbEBob2x0bWFubi5vcmc+DQo+IFRvOiBKb2hhbiBIZWRiZXJnIDxqb2hhbi5o
ZWRiZXJnQGdtYWlsLmNvbT4NCj4gVG86IEx1aXogQXVndXN0byB2b24gRGVudHogPGx1aXouZGVu
dHpAZ21haWwuY29tPg0KPiBDYzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZw0KPiBD
YzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBw
IEhhaG4gPHBoYWhuLW9zc0Bhdm0uZGU+DQo+IC0tLQ0KPiAgbmV0L2JsdWV0b290aC9tZ210LmMg
fCA2ICsrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL21nbXQuYyBiL25ldC9ibHVl
dG9vdGgvbWdtdC5jIGluZGV4DQo+IGE3MjM4ZmQzYjAzYmI1NGYzOWFmMWFmZWU3NGRjMWFjZDkz
MWMzMjQuLjA2ZDJkYTY3YmJlMTRlMTdlZTQ3OGFhOTM5ZGUNCj4gMjY1MjZjMzMzZDkxIDEwMDY0
NA0KPiAtLS0gYS9uZXQvYmx1ZXRvb3RoL21nbXQuYw0KPiArKysgYi9uZXQvYmx1ZXRvb3RoL21n
bXQuYw0KPiBAQCAtNDE2OSw3ICs0MTY5LDcgQEAgc3RhdGljIHZvaWQgc2V0X2RlZmF1bHRfcGh5
X2NvbXBsZXRlKHN0cnVjdA0KPiBoY2lfZGV2ICpoZGV2LCB2b2lkICpkYXRhLCBpbnQgZXJyKQ0K
PiAgCQltZ210X3BoeV9jb25maWd1cmF0aW9uX2NoYW5nZWQoaGRldiwgY21kLT5zayk7DQo+ICAJ
fQ0KPiANCj4gLQlpZiAoc2tiICYmICFJU19FUlIoc2tiKSkNCj4gKwlpZiAoIUlTX0VSUl9PUl9O
VUxMKHNrYikpDQo+ICAJCWtmcmVlX3NrYihza2IpOw0KPiANCj4gIAltZ210X3BlbmRpbmdfZnJl
ZShjbWQpOw0KPiBAQCAtNTczMCw3ICs1NzMwLDcgQEAgc3RhdGljIHZvaWQgcmVhZF9sb2NhbF9v
b2JfZGF0YV9jb21wbGV0ZShzdHJ1Y3QNCj4gaGNpX2RldiAqaGRldiwgdm9pZCAqZGF0YSwNCj4g
IAkJCSAgTUdNVF9TVEFUVVNfU1VDQ0VTUywgJm1nbXRfcnAsIHJwX3NpemUpOw0KPiANCj4gIHJl
bW92ZToNCj4gLQlpZiAoc2tiICYmICFJU19FUlIoc2tiKSkNCj4gKwlpZiAoIUlTX0VSUl9PUl9O
VUxMKHNrYikpDQo+ICAJCWtmcmVlX3NrYihza2IpOw0KPiANCj4gIAltZ210X3BlbmRpbmdfZnJl
ZShjbWQpOw0KPiBAQCAtODI3Nyw3ICs4Mjc3LDcgQEAgc3RhdGljIHZvaWQNCj4gcmVhZF9sb2Nh
bF9vb2JfZXh0X2RhdGFfY29tcGxldGUoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEs
DQo+ICAJCQkJIG1nbXRfcnAsIHNpemVvZigqbWdtdF9ycCkgKyBlaXJfbGVuLA0KPiAgCQkJCSBI
Q0lfTUdNVF9PT0JfREFUQV9FVkVOVFMsIGNtZC0+c2spOw0KPiAgZG9uZToNCj4gLQlpZiAoc2ti
ICYmICFJU19FUlIoc2tiKSkNCj4gKwlpZiAoIUlTX0VSUl9PUl9OVUxMKHNrYikpDQo+ICAJCWtm
cmVlX3NrYihza2IpOw0KPiANCj4gIAlrZnJlZShtZ210X3JwKTsNCj4gDQo+IC0tDQo+IDIuNDMu
MA0KDQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25v
dkBpbnRlbC5jb20+DQo=
