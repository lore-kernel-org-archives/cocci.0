Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB0C1049516
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Vb8k9EUnk5kJj2LtvvAOaCQRgisPN85MlLKf/pO85gI=;
  b=ZuX35P/PCypIXQOx6wgD3/0lF3CFNrsdmZ6I4YbAZnMSmVBxiUsHXjEK
   7eWJY/RR53vkQt5Q6iU3OlLp4jgEkiKtX4OSRn8SSDb6POKXgDYfia5zq
   5x8vmmLqm4IC6jwEA9v7Hn9O9Cx0DQ4bt97jONPdYOXeYg0MnLULtzYMx
   k=;
X-CSE-ConnectionGUID: gKEQQTkjQK2Civk9EqheNA==
X-CSE-MsgGUID: hfOA3B3qTqySQmKqFOvuVg==
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
   d="scan'208";a="267246005"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:22 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 16FDA818D3; Wed, 11 Mar 2026 10:46:22 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id DB8E0800CB
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 09:19:15 +0100 (CET)
X-CSE-ConnectionGUID: ZGWhoEPmQie+9RBg6okASw==
X-CSE-MsgGUID: 8uop3/MuQF2EW98kYdI0XA==
IronPort-SDR: 69b12585_ObtYl+sEmhPxyLpJoFgWVS1hk2cbuoWvneiRkm3m7BaEckQ
 fIDE9BoEB2QqHKvfy8/FTUjtLe6IdPNx8tHBkmw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EYAADQJLFpjwyjxsBaHQEBAQEJARIBBQUBQIE8CAELA?=
 =?us-ascii?q?YFtU4FoMQRUhFiDTAOETYlYA4ETm1yBK4FAMwoCDwEDAQsBAS4gAQIEAQEDB?=
 =?us-ascii?q?IUAAhaNDQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQEBAQE5BQ47hk8NgluBLF4HCTgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQERAg1eAQEdAQEBAQMBERERDAEBNwELBAIBCA4DBAEBAwImAgICJQoVC?=
 =?us-ascii?q?AgCBAENBQgagmCCIwEGSgMBAgKhcAGBPQKKKnqBMoEBggwBAQYEBN4JCQkBC?=
 =?us-ascii?q?gGBCi4BhTuDFwEBgXCCSoEgARmEAHongWVDgRVCgjA4PoQKHB8Vg0Q6gi+DN?=
 =?us-ascii?q?IxNhlYJSXgcA1ksAVUTFwsHBWFCEDMDIAovLQIUDRASDwQWBS0dcAwnEg8dF?=
 =?us-ascii?q?xQfWBsHBRIhKgeBQXiBZhsPhmh5Ay5eGg4iAigSAzIEI4EGC1oFgiwCHAMLb?=
 =?us-ascii?q?T03Bg4bAwQ6ewWNaz2CFB8BAYENgQc9fBiTOIN0r1YDBAOEHJlciDIXqmsuh?=
 =?us-ascii?q?2WQcyKodAIEAgQFAhABAQaBaDqBXHCDN08DGQ+OIRklg0KPPQG5cEUzPAIHC?=
 =?us-ascii?q?wEBAwmFRgEBjCIBJwyBSwEB?=
IronPort-PHdr: A9a23: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
 JTHIU+v0CE8C9FiyPGXME0wjGufoXPYUyw0Ew==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:YhVmx6rKXf4a+J5QPmTZr9MaV5s9LNV00zEX/kB9WHVpm5Oj5r
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
X-Talos-CUID: 9a23:Lfe3fWx/wI9A22WxlwOzBgUmNf8ldVDlyU7RLgzpM0xmFrqWYGSPrfY=
X-Talos-MUID: 9a23:2Uq+7Ql8huAYu46MGtV3dnoyKcBwuOOLFXkjy7g56pmHBCBRYwe02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267220676"
X-MGA-submission: =?us-ascii?q?MDFeduzbcx5M/JuRj+DbrsHv9DXJGmKugxfpss?=
 =?us-ascii?q?9kLhypjvNHCZUpHqSewpstDJUN2fXko5YJXh/8SnLEtRC3cTlp86/BrY?=
 =?us-ascii?q?f8cEhWNAgbjJIvC9DjkWVLuVusAFVv1tC/BoMTHh9ZXurrZm6IBx7d8c?=
 =?us-ascii?q?IK8asOa3iZNPvQxLPZEKsrvg=3D=3D?=
Received: from mgamail.intel.com ([192.198.163.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 09:19:16 +0100
X-CSE-ConnectionGUID: yfOnw43MSIqfUlQKeG3z8w==
X-CSE-MsgGUID: Se4fb0EeTCW89zdnQfEGCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="78164852"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="78164852"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:19:13 -0700
X-CSE-ConnectionGUID: 0G/JU1hJQDO4CX97TaJrVA==
X-CSE-MsgGUID: 7FfCmmmvT/izw51Ty9X2lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="225346316"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:19:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 01:19:12 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 01:19:12 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.22) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 01:19:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4t3UpqGV4Iwt1Cg6SX9sEYFE2m/da3cKxX1afn4MUvi6yj9zT4pthCq9A004dIzW7bXS98TU+4axPGJTAwGmaY4N+rIysvulbxBCWvABnjSe2slga6kxxoUrNS2SrwEb3m72CFNJrcnea8IwcAnV2fNBnVp+qQiIqggtQxb12siFmvcMMNQiQ/amYzFg0jAmYSdgAJQ+skniHyl9D5Cqd5q3+NuM1nWRLNYV3+y5+VCCRYlUYIStZFepSpxeyPs41EHIwIt1vDy5IeBXEiCTNxJFvoavqlmZWmUEVv2c8mw1/Y/AK/xOfvnTAbGkRRK4mxSnbdM8rkcHEzBqL8uqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vb8k9EUnk5kJj2LtvvAOaCQRgisPN85MlLKf/pO85gI=;
 b=EiUDl672fvZA+ijYyaPTCjPwCEpLVplqSI4cfOec7Ynh7DU2D4qpjt0i0z23WnYoDvTJQctct/WQka/5QESAAZNzsS6Xs7eWWanjQegd5OMJJHYOXP+7iSea7FgOCC5gb/aTcR1EKawbkJ4kSdCGsG2h9POGEZyqLyqzBCuM9FavPV0Dd9MeP2JP/jXaJ6uo+S9AQL/5zKzlmIL0Te6Kn8TcKQD52+fBTb9lcUvFHL43STQ0rxNQ/FMHlW+R8Z738/lbQsDmYnFJTo42pYkPGtx+qlkbTdQ8UoDbCsmeR8hKVcgCEALh1m6n7GH8z/HcjPI3HsUO1QXiriKSC/Cdjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV8PR11MB8510.namprd11.prod.outlook.com (2603:10b6:408:1e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 08:19:03 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 08:19:03 +0000
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
CC: Jan Kara <jack@suse.com>
Thread-Topic: [Intel-wired-lan] [PATCH 12/61] quota: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Index: AQHcsKKaOR7G0NDKQEmlo1IiQUHj5rWo/h3w
Date: Wed, 11 Mar 2026 08:19:03 +0000
Message-ID: <IA3PR11MB8986DFF52256F69D2D8813AAE547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-12-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-12-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV8PR11MB8510:EE_
x-ms-office365-filtering-correlation-id: 45170395-41f3-4f6e-eee8-08de7f46db56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021|921020|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: uDlo72zsfG7E7OegXYkgviuwxoEgXaQcvEoAJg6j4/rltsamRh/Qn9VNeTSSeHInq0aq0fsq4v/Bdcg7Bu9fowjf7kVfGkmRO4sHgo6UoLAucxJE5mV1UPNNekdUC8c14BHka0ajN4E62VBuw8ezPo6Szn1KmPPoCHszFNbnFKt73DcPuLI1+5CzzWdpgYMbhYzughjIDAdGd5KaDrao2XCGz4Y7vlp4pPkxhGSgBcWd8od5s+H0FtaAvLLkNLcxHrrNOJw7W3cr4+lGQ4TYN+96OzlDiZ98/4xKM3zQxVUr2YXyQnyaw2/LKg6lIZBu/bWHL1GmeV0gkPoWjYtsvSf8c8B6B50GnO0Q/HxfYmkH42E+A5vQGURNRR0syUZ+5vE42aTiX2VQSvEJp2bX8V/VCBR492SZ/RQAB/B86gzbVjpJhp/UCY+d7MAlBeNz3Vhaz2DbUsQxbpdQJTlcjBFUadmDgWef08tW5Dn28lL+u3v9HxgXk6FrNIqU/uuxb2gNMow5kq/4A3yV841iZVQanjpdLzZE15xBEFpzoOnLaSUsbEc9vap5CVUMr3oJKfVh6txp+I/91pdubcTMhiM9H3SoxgEyDUY0a5gKuil0QqoD2+8xDTkcc0lhWGn8p2QfT7dFHBEqprQZJl5C3GACzzX2bzH68IsnSQ/ZwxfznEaGV+bglhaLusO13upuwd3VwYC311TO4BYUFl6nKdo/Xr579B2L/I6b8Oh+5SKiokkchULV9lvfi4xnS7hLMk97rjgDRIKbAYsYJjOEn/YP6hTF/tCJfk2+qJeQ21XLP4lDmom5BfybqRJ1Uelu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2xncWZUZTJZaUQ5SDZWeEtDZlMzcVc3SDZsSThjMUJSYjQrV3JWU0ZqS2Fx?=
 =?utf-8?B?czNKVzhscERCS2VEUzFhVW5BbEk4bjRZeUd1ekdmekFlTSs2bXNFSUh6T2FG?=
 =?utf-8?B?cXUwZlJGdTQyVUhPUmI0emsycHB1d3FuUTdRWC9GbGdNR1RpRVZIZXVUa1FR?=
 =?utf-8?B?YU8zRVcrUndtNG0zWEFCQTRNdldGQ1RSbjQ0d2txZHNuZDVmYVVhQko1dm92?=
 =?utf-8?B?OERFTmh5SkpLdWVIenNSV201YkRndWlWZ0FvMW5xWHI5eEFLNEdydkRlTTFT?=
 =?utf-8?B?R2VLR3FIV0xEOUhQUDZJeStlRmxSU3doZEV5NTZtbS9DWHhIQkt2ZzZsY2dn?=
 =?utf-8?B?M254RnZTbXZSV2piN04wRTF6L21oWmJya1l0d1hjUjlOdEtXcGdpZE9Zelhy?=
 =?utf-8?B?dVJxWmlvV1h0TVcwMDJwd3VkdGRKdWJSdXdFakQwZ2hGMUFuWEp2Y3ZLSG1m?=
 =?utf-8?B?Sk52TkRZKytpbm1VYTg3K2c0eUZ1ZXZUSXZJaFg0ZksrK0hYZm5TMVl4Zkd6?=
 =?utf-8?B?Yk9ta2ZqUVZkSUlFVFlCNDVtVDJwbmNIdVdkbXlRWGZ2eW1LQlBWMlNJdEdj?=
 =?utf-8?B?bU4yUjdIODFPNFZJVkZzYitwSkFPZVM5UDIvWmhHbk4wUmRNckE1TDJKeHZS?=
 =?utf-8?B?aGh1Y3cxUWF2S1phOFFPQXptTzlNblB5dytGMHpCdStmcDM4R2k0bVVISDY2?=
 =?utf-8?B?aTVJRlZYdDlBcXpSdm40NHZGUHFPMDZkYTU0dTRUcmNidzR5TjFxS0FOSDdF?=
 =?utf-8?B?dmVEcmRXQ21LSDd4STd6WVhLNC9UNzVVTG9PbTNONHFZVUlSWUFvRmsrcVcr?=
 =?utf-8?B?U0F2cXVsUFBWSUhSb2M3ZUtCU3lxZTFjekpEU2k3c1ZkdWV6WXBLU3plc2tH?=
 =?utf-8?B?U2hGa0VTanpGcDBNbDJBOFhOQlRCR05BRmJYMm9lZUdScXU4a3Rxa1kycVV1?=
 =?utf-8?B?YTlpN2QreHdNYjR0Q04xQ1d0ZEtIeHZKenBQazhvY1V3a1VJeElKSmhRR1V4?=
 =?utf-8?B?bjJBRkxXVDIzT3gwYVl3eVNiYTVwcFllTzN2WGRSaDlVdzAvdE91NUphUVRz?=
 =?utf-8?B?aVZaODlUcElwNzU2Rk5PZVEvbkhWbDhhK2pxd3dvMXNxeUNrM0tZUmxGaC9Y?=
 =?utf-8?B?WVBzWVg0VUlyTGEwVWZjYnhGYk1sZUoxZG1PWWh0ekw4dkJROE83Zzd3Q0FC?=
 =?utf-8?B?NHV2R0UvdS96a1R4Y1JadEFab0d4ZldRbnQzR2xqa08rQUc4UWZtVXlrRUxM?=
 =?utf-8?B?MXVyWFJOVG1Ha01mSXpiNG5NeG5weUpGVDRqV3ZuOVF1YlVWMUJycnhMbU5Y?=
 =?utf-8?B?TTZrVG5RZTZNT3QzZUkzYU1QK1F2VUE1ZUZVWWlwd085QWdQcFQ1cVA1WVFI?=
 =?utf-8?B?b1cyWk9QZzhWaHZkWDlnNUZ0cERKL2F4cFVyN2R0MVFjN25XMkdGVUFiTEd5?=
 =?utf-8?B?eGRwaDlGUWxZaHhtNVhGQUFOOXNRdTcyZ2NFTVdIM2JYYUhOTlZ0ajlsS1Jh?=
 =?utf-8?B?YjFEZERQNDAvWEpGZ1RxUmgvYjZFaHdLcGdZSTl3RCt1ZFpycWNjL2NyYUIv?=
 =?utf-8?B?Q3JxUGdrOFhGM0xpNkpGYXBOd2ZNWGdaYnpaRnpPMmhQYWZyZ2tOdTVYSk9l?=
 =?utf-8?B?ZTMzNCtQMFo4dmFTd3QwSXhqZzdiRjZGLzZOSFNmTGoxZkFpcXlFY1dBUDUw?=
 =?utf-8?B?V2JkaDBkV1FXZG1WNUJZcCtIWDYxTVpjcmFrMmtDR3RmT0t0QjkySDRzUUU0?=
 =?utf-8?B?d3BzSEZCOGNDY29RaVNrSWZ6cnpiV29Kamw3ZmQ1c0VhOFY3V0paWDRaelVv?=
 =?utf-8?B?d1E3RFJHbmNJdG1uNmptTC9kNmRpQloxaDNvd25DVC9mays2MDlMSEwxbG5z?=
 =?utf-8?B?UGZBQVoweFhSK3BVUzVVTmJQRnBIdFlEUEI1Rkl3S0ZDUUwvdzZlY2NRTTZG?=
 =?utf-8?B?anJTVEtZd3B1S29rU1dnRU1CRlhTaEtuUmhzeHM2alQ2NFo1cklTSU0yaDB3?=
 =?utf-8?B?Z1YwUlRnOU4zcnJEZkVQZmFKTzZWYkEwaFNsZGFhZXNHdFlsUHhHZ2xkOFAr?=
 =?utf-8?B?N2xVVjdNaGlwdDJ1ZG5YK0xjdGp4N0dERk5laVBKQndMSm91Snd3MSthVm9j?=
 =?utf-8?B?a1BlcTlYR2cyZ05zdWRtbGRteXl5T3JpSUQ2eHhub0JFeGd5dGNmeTB3bTIr?=
 =?utf-8?B?ZGJFTDh4SzV0NFVSSXhvdXVlKzBKc0haSXMwQnhFKzg1SWNYdGhtSXQvaVlL?=
 =?utf-8?B?N2t1bFNyYThOWWVySmZFRWVVdHRQT25KZWtMcHBOUHRvQ29kUjIwaHdjUWgv?=
 =?utf-8?B?ZjBlQ25mMVhRZG1CcGlrOWVQMU9uTThtTUhJNElGN1FXazRlUy9TbUVwMVRw?=
 =?utf-8?Q?7E/cpfHei4SBWdR4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ch+ochnprmtl2q9ovwqRCZrVKKPwM03tyxbmujYFXAOT4AvuwA9ANdyDEY1HYq6IS0CBOXih0ogi6kACQR5W6FOpUALMb1OgLPFZSt7TP7Zhrw7oa9Enw/9mMlwsHJG+Pm3TxuDNvdJyQO8kQOVniBOcvmswGUA/ghhpct1Qc942Npgeam/uTxbvHzh0RlgJgnbg0BOQC/40OOrTRkwjrKD0Zx07MQljFPxynL49qHtwlJhex01xgxSeN3yRDQ93lb8sXyrrmWc84Hn2r6LcA0e8KmOYPSzhVMI7T+UZ3AilKzyF9I4T3COOKVRZjIH/UnbR9RG+DtSLbXhPRtKf5A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45170395-41f3-4f6e-eee8-08de7f46db56
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 08:19:03.7196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5RHPwGkuHaFJ/hqNzAtwi022X2mgyphxIgJ+1aWEloOatEVlDDLjsHcJbFCqfAMKzQX0FZ0cacMjTK6ge16Cprkp4plz4B+kggP05WubqN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8510
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [Intel-wired-lan] [PATCH 12/61] quota: Prefer
 IS_ERR_OR_NULL over manual NULL check
Reply-To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 3397
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/LXMMXZRXHNrrkTNxlZKEUw>

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
bS5kZT4NCj4gQ2M6IEphbiBLYXJhIDxqYWNrQHN1c2UuY29tPg0KPiBTdWJqZWN0OiBbSW50ZWwt
d2lyZWQtbGFuXSBbUEFUQ0ggMTIvNjFdIHF1b3RhOiBQcmVmZXIgSVNfRVJSX09SX05VTEwNCj4g
b3ZlciBtYW51YWwgTlVMTCBjaGVjaw0KPiANCj4gUHJlZmVyIHVzaW5nIElTX0VSUl9PUl9OVUxM
KCkgb3ZlciB1c2luZyBJU19FUlIoKSBhbmQgYSBtYW51YWwgTlVMTA0KPiBjaGVjay4NCj4gDQo+
IENoYW5nZSBnZW5lcmF0ZWQgd2l0aCBjb2NjaW5lbGxlLg0KPiANCj4gVG86IEphbiBLYXJhIDxq
YWNrQHN1c2UuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTaWdu
ZWQtb2ZmLWJ5OiBQaGlsaXBwIEhhaG4gPHBoYWhuLW9zc0Bhdm0uZGU+DQo+IC0tLQ0KPiAgZnMv
cXVvdGEvcXVvdGEuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL3F1b3RhL3F1b3RhLmMgYi9mcy9x
dW90YS9xdW90YS5jIGluZGV4DQo+IDMzYmFjZDcwNzU4MDA3MTI5ZTAzNzViYWI0NGQ3NDMxMTk1
ZWM0NDEuLjJlMDlmYzI0N2QwY2Y0NWI5ZTgzYTRmOGEwYmUNCj4gN2VhNjk0YzhjMmExIDEwMDY0
NA0KPiAtLS0gYS9mcy9xdW90YS9xdW90YS5jDQo+ICsrKyBiL2ZzL3F1b3RhL3F1b3RhLmMNCj4g
QEAgLTk2NSw3ICs5NjUsNyBAQCBTWVNDQUxMX0RFRklORTQocXVvdGFjdGwsIHVuc2lnbmVkIGlu
dCwgY21kLCBjb25zdA0KPiBjaGFyIF9fdXNlciAqLCBzcGVjaWFsLA0KPiAgCWVsc2UNCj4gIAkJ
ZHJvcF9zdXBlcl9leGNsdXNpdmUoc2IpOw0KPiAgb3V0Og0KPiAtCWlmIChwYXRocCAmJiAhSVNf
RVJSKHBhdGhwKSkNCj4gKwlpZiAoIUlTX0VSUl9PUl9OVUxMKHBhdGhwKSkNCj4gIAkJcGF0aF9w
dXQocGF0aHApOw0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+IA0KPiAtLQ0KPiAyLjQzLjANCg0K
UmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50
ZWwuY29tPg0K
