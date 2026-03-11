Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893E91049521
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=EtXvAtG2Nq0/hQHPRy+43TWGRsERYyZeG5NpAQzHH84=;
  b=hryAEHqwJaADapuDwQ5nEF7ZxUeG7jpR5j2Q0Xi/tdyGtD84W0kRWtfm
   nxMLT67Vf8xbYxxF78mrncvJAUea5G9sLgAycpt9m+QaA1a6ZYVrjDeZq
   TTd1vKNFF6+y8nR7c4n9gHCPZ1jjaaIK28duM7Cl7QgcDJfbUZdat/w+b
   g=;
X-CSE-ConnectionGUID: aSBRCp74TsyULYMBb0/SyA==
X-CSE-MsgGUID: 1gl5wFynSZWI2qJmCyZbng==
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
   d="scan'208";a="267245960"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:19 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 3A6CD818C6; Wed, 11 Mar 2026 10:46:19 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id E0C64800CB
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 09:18:36 +0100 (CET)
X-CSE-ConnectionGUID: ku3sZcvkSVGu6WzX2mojSA==
X-CSE-MsgGUID: 3uIKbCqQQteR3Jw7IH0tag==
IronPort-SDR: 69b1255e_Jl5e12KTUsoxXlKVIkSWjjZqOjp8NOYr8S6BGWdWCn8yBiZ
 gC+VjVzBYcJnoqb1uoIaCAFrq78uaoi0xc05zUQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ETAADQJLFpjxFBr8ZaHQEBAQEJARIBBQUBQIE8CAELA?=
 =?us-ascii?q?YFtU4FoMQRUhFiDTAOETYlYA4ETm1yBK4FAMwoCDwEDAQsBAS4gAQIEAQEDB?=
 =?us-ascii?q?IUAAhaNDQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQEBAQE5BQ47hk8NgmIBgSReBwk4AQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEQINXgEBHQEBAQEDAREREQwBATcBCwQCAQgOAwQBAQMCJgICAiUKF?=
 =?us-ascii?q?QgIAgQBDQUIGoJggiMBBkoDAQICoXABgT0Ciip6gTKBAYIMAQEGBATeCQkJA?=
 =?us-ascii?q?QoBgQouAYU7gxcBAYFwgkqBIAEZhAB6J4FlQ4EVQoIwOD6ECjsVg0Q6gi+DN?=
 =?us-ascii?q?IxNhlYJSXgcA1ksAVUTFwsHBWFCEDMDIAovLQIUDRASDwQWBS0dcAwnEg8dF?=
 =?us-ascii?q?xQfWBsHBRIhKgeBQXiBZhsPhmh5Ay5eGg4iAigSAzIEI4EGC1oFgiwCHAMLb?=
 =?us-ascii?q?T03Bg4bAwQ6ewWNaz2CFB8BAYENgQc9fBiXLIwnoy8DBAOEHJlciDIXqmsuh?=
 =?us-ascii?q?2WQcyKodAIEAgQFAhABAQaBaDqBXHCDN08DGQ+OIRklg0KPPQG5cEUzPAIHC?=
 =?us-ascii?q?wEBAwmFRgEBjCI0gUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:IN5WbaAxuYq9qGflHemD55DYdb4zR+YMi2TDtnoBKyC9F/bz+v
 xG88526faZslkssQgb6LW90fC7MBfhHP1OkOos1NWZPTUO0VHAROpfBO3Zslvd8kbFltK1u5
 0PT0EwMqyWMbCI5/yKmTVQa+xQuuVvB5rY+Ns3dx1WPHpXgghbnn9ENjo=
X-Talos-CUID: =?us-ascii?q?9a23=3AEBmKkmgcfUeswQYURSnzyplRVDJucWCG10XbPUy?=
 =?us-ascii?q?DN0l0FoKHeQWV/6Ffup87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AjhX6VQ3k8unoR5eumG6eGEkC4TUjuLmPK0omiKw?=
 =?us-ascii?q?/p8S+bg5vZBa91Ci+Tdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267220464"
X-MGA-submission: =?us-ascii?q?MDGFl6Vsfp8JdH2vwF5RvXAl5gBa66dqj6kIav?=
 =?us-ascii?q?yjg/xGL9Hh90P+JtNYFH3TrEo8UomA0uP22MtRC8+OPLhNhFMJmgGNON?=
 =?us-ascii?q?KggRP0WXjuEN6QYCl+FLuYg+ykS9sNThikUqHSvnJeBf2FxwM8o7AB8q?=
 =?us-ascii?q?dKxuUyAuUCWGxGoo7R3ejngw=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.17])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 09:18:37 +0100
X-CSE-ConnectionGUID: GbcVjCyCTFeOzzVVj8CNiw==
X-CSE-MsgGUID: hzgu51QqSVaKaHuLLw9q0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74249487"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74249487"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:18:34 -0700
X-CSE-ConnectionGUID: HltMTZSVTuKXfMA+/dCoxQ==
X-CSE-MsgGUID: H7QQi/l0S3GdrHVwbKdJ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="224857220"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:18:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 01:18:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 01:18:33 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 01:18:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhWeUg9RHkwde45PsJ4JWqOSCdeKLI4zXqfmOmLC72RNsSuaePzgBOqydmdBart9kBRM4vGCsXHuicMQPqiRMunr+TDVDVhjNwU1uJeqkh0qw8A/rUlXEy/lbqK3GEeN6jUz2fC6wRsQWKqauF298jSC+Q/RFbzIE+W6VXt1JOgD0fpdatOT8es2hWEYCz53kPlVU+jVDyu2pogz6Wn68NcOQWy6ltCboG3aPGBv0QrmpKXLYCIr7s1fjtw0jMP6lZ8WrHxrb/qf/d7UhIdns54Ef5rr67QRiD2BG6rZQdTfrVQlCGs87WeWbmXIrMIE97HPLe1NmRthT+C2QpjZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtXvAtG2Nq0/hQHPRy+43TWGRsERYyZeG5NpAQzHH84=;
 b=oHyUy+PcAJ26UqZIDCAhBkwR5PEuLcOV9EAPJMdOG46fYZ3sZ2zEh+Jc6vEr0V4LxhaUtEWfuDtX7RY3ICuoXWxq5vIFctYkIcwqQV7qyRvYu2c5nW3GgdDpodZHiFagr8lWXwIHwa9+USjvsv1BLItaRNouSk6Pfqoisok3Citrt3is/cIKvqrJlJdXIS+bOYKW9LgL0dlSZXsVlJoadFXIuYaLtkBy4uIfc+igV9KMIS3gdk7CD4SJNdDHHpoSaTKjLN6hM0+Dxf+5rsxq3JiX692xN8nkcV1L9wo64i6ePYwPAEbh/cQuWFrnu4YYNRRwwhIP9PnelRsa44jKHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV8PR11MB8510.namprd11.prod.outlook.com (2603:10b6:408:1e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 08:18:29 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 08:18:29 +0000
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
CC: Miklos Szeredi <miklos@szeredi.hu>
Thread-Topic: [Intel-wired-lan] [PATCH 08/61] fuse: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Index: AQHcsKKakfOg0IOsvkih4vkupNrtzLWo/fKQ
Date: Wed, 11 Mar 2026 08:18:29 +0000
Message-ID: <IA3PR11MB8986489054B55797E95481B4E547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-8-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-8-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV8PR11MB8510:EE_
x-ms-office365-filtering-correlation-id: f0b79d3c-8a1e-491f-e6b6-08de7f46c705
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021|921020|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 218av+tk7NyEEEJHlt1fulpFsi4UC6fpwgDNRhUIo2srO+/2TlKPYUzqV6H5yx4/knSysiIYLAaj2nLqZWHAdu1SoQpRi0aWwfjkYGZkXXTnOqXXnGjeLjtTkO4fkIexEpaVwuoR3rXyNToQRzb5udkf2e0TkniRf63q3E4x2/Qsy+YHMKSDhdg0YrR7bqHLlTT65eVWUG8bQYTxuOIwxH/3eEeAr0QVcnMXps9rVv8ms4jTZAl9oBruoKwrcVKRvMAYtQeOHm/H4N+39mJro9jTVq7f0K2pUUVPUzLH0SjvADMnP79eNq0DfEgvto07cN9GtBHLJj9yz9ap6CHj+QxVwbx7qnEz+h6gtanoNtbQAXJS14mOiELCA7UYoGbm2oG9tpe0FbTbI35z3zgrJiCfOOkMu+TdauAyFH9ONVtEqs1BCc8Q08aATYoMPjnXz7l1F/Ie7LN32cpJHXtHUeLUZ7mt8QdGON2+772urnKn+bCSRhWpVC7iK5zs/aVo3VesNyKjWDntP0E+RvmNW9YW6iP29xyzZmIepfzptq7O0gVsc83K5NXWqNDl0XZbP2m+2SJLVItwf1rRVA98Uoic+p9HmIszvVm1BCdKiS3O68tN9M6AIUVmOV9o3WIVfAnXbSY0BVKVLXg3Mb2lx+2EkcGz43AAWbJ6eDOmDruN/6VoYWM/wCcQiAJj1WX/H//FLcsMb6L5AwFYc93/4NoHeaJGmcMFGb+D7+FzqWd9JGofHi/dA+FN1sszd7ygtK2IjBhTpNvItFkx5+FRi12Q/yLaVwUVyW18stZ9w32/hdIP58uJhbalSmXIx8AX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWx6ZFk5R0FqZEFyM01sZVlsSkc0eFhldEgyK3lOV0NGektFVWlqRThOOGlC?=
 =?utf-8?B?Ny9zTkZHVHlxWUhTUDVnL1J4WVBONk43VzZpNkprY2NyWDJPeEh3NmFjU1dC?=
 =?utf-8?B?bkU4d0pjVlFWM0pUNlgraHZkUFlLODBpWC82K2s1dS9KM2RDeTdlUytJaktV?=
 =?utf-8?B?dzI5T0w1bDVnUm43bEh2Q1UyOVVGYk1XblJEUmN0OXZxcEV0QTl0a0NzQUR1?=
 =?utf-8?B?NHZnV3dwY2pQclgrSTd1emRVT1g2VllPa3ZhclRvalZSenF4TjljK2hlZUUy?=
 =?utf-8?B?Rk9reTdLSlRlcUsvWlBWRjQyQk9WbFVDSGlzRkc5UlRza1lVZUx1N0dYOHht?=
 =?utf-8?B?dFFlaG1RV21lNlhMQkQ4UkVhM0JwbWEwNlYrbjBhRXIwbVp5WmkwTlFCTHBD?=
 =?utf-8?B?eDRWbXRnaFVYaGNkVkxFVFpaK3NOYUVuZXh4OVhxbVIwRk4xQ0hKQU1OL1lN?=
 =?utf-8?B?ZXpqeHhOTDY0MzA0SVdPdXdoS040NUFwN2c4eHA3WDkwUjZwNmV2Zjc2Z1h6?=
 =?utf-8?B?bGZpV3M5K3YwNnlDVlNRUWxkRUF2SHZUbStzQ01GUko5Qk5mRmhsMldWamhF?=
 =?utf-8?B?bUNVemRYWTVlbHBmd2NFSkRQZjIzc2dpOU01dktYbEcwN2FOT3l5RjVtSDdT?=
 =?utf-8?B?am9wSDdSWGIyTUg5UEtwTWJCWTFPZXhRZExxdlZuUGh0OXpTSExpN0dDczNu?=
 =?utf-8?B?YVR0bUtodFdVcHpyVUgyaEZ3UEQ3SHUwNjdoZ3RyZ2o2Y1B6Q1NlYkZMMmFF?=
 =?utf-8?B?YndOaXMzQ2NxeWJzRXF1NitOR0loOUtwSDVBZHg0N255V2hRdXJjVExuQVYx?=
 =?utf-8?B?V09BcDl2bXJQbTdWcmNQcVJhbENJdzZoc2VWSjZXSm12MkVoOHkxSDBEM240?=
 =?utf-8?B?Y09DY0g3aUxtZTlCMTc4ZWRzOEFubEY3UDZtci9lamVHZit6Y0tVK1cwdEV5?=
 =?utf-8?B?bDZ2RWFYYjNXMWRFTDhHL2ZhVXRpYm1DM0wrLzhacG1FQ1lkOTFvdnlCY2x0?=
 =?utf-8?B?MGJKZmloUUtvTWVCN1hZaTdITy9wdzV1U2tiM0Z2UGxXYWtxdWpLWXRxOFNa?=
 =?utf-8?B?dGdvZUNZSVRnNXFncDYvTEJhWGhIL2duQkJVUXp4aUJMWURVSTJSVGNRbkow?=
 =?utf-8?B?czBrUlNJVzl0N2FuUXJnaXBkNFRYMERQdlJqVHFBRFJKdUI5SmsvM3VscnFa?=
 =?utf-8?B?aVgyNlFDK1lIVERQeHJwWWpmMDFPMUdCRGNqUDZyUGNLek1BTVpmVGkyRlZt?=
 =?utf-8?B?RWVxTWJmb1poYURLZkkwRTNZc0liWlBpZUVKalZuR0taMVZBM3MyaFFhMnYx?=
 =?utf-8?B?RUpJVnRtbXQ1a1BRcE0rVUJXUXUwR0dVZmtLbUIzMVV1WTRKMDhLN1dTSngv?=
 =?utf-8?B?NTNpNklFTG5DU1duMWY1VTdTM0x3MFB0Rjl5dXVIa3JveW1KSk1Eb3pHVDRD?=
 =?utf-8?B?SktITXBPanVzVXJzOFZXUTI2eGpsc1YwOTRlaGRaMW55cnVqRldNZ2VTTlAr?=
 =?utf-8?B?YUdTYkc0YzNwSlRlNC9yOURYclN3UXlCRWxHR202ejZJa3lnQWdvb3U1OUM0?=
 =?utf-8?B?WnlpbEY2Z3FEM3dHUHJTOHNOTWJ5R0JCalRteHhmZlB4RXEwbFpZQlpqSEE4?=
 =?utf-8?B?UnVEZzlCa2Mvc0huSUEyQnJJSjhtczkyLzdIVXJ1RzRieUYyenpUazBwTzdL?=
 =?utf-8?B?RDFQRFVZNjFuUTc0V2ZnVjVmL0pOUW81YTc2cmN3QWtJNDRYcDZiZVozQ0gz?=
 =?utf-8?B?T2pFYWdTUlhqOVdQK09xUXNEVzFKb0ZBbU1FZVByUVUrZno1aUJNYTdoUFVZ?=
 =?utf-8?B?MzN3NzB5a1ZTd0xVeGl2UlRvcnQyTEhIY3phd1VMLzdWNFFqa0JQVVNYVGQ5?=
 =?utf-8?B?amhRMEhqK3lVRER4dmVEMGFMV1czTXJvNXEyVkZ0dHBHWU85SjRXSkplZ3U5?=
 =?utf-8?B?YlMzRVF5enFCZWJkQW9hVGYrZGJmWkVMVTd2djcyM29tWW9nckJFQ0VZWVNI?=
 =?utf-8?B?MUZ2TzZhMXFzOFkrN2xNL01PRXFZSm9tdkdtNXJ4V3c1YndxZUhOVytmUXdK?=
 =?utf-8?B?RE80RUhCMUdUeE1CSE1ldFB6NXRMTHhKbWhQNlJ2SlR6S3FWNjhFZ1lyUndl?=
 =?utf-8?B?SGtXbmtZWEpRVFJiSTU2Y1pPUlpIK1dIVGRpVXZHUkNRWFhWTDR4dE1ZWXFL?=
 =?utf-8?B?VzVMaHRwTDE2S0swcnQrSFJCUGdKamhQVktJSkpTNTg4WjNtUWJ6cE5aU3dn?=
 =?utf-8?B?QVN3ZE1VTjltdUpudTVrY1MzaGIrOG9nVjluZzUvQkRPZlNTbkpyaHNFcmda?=
 =?utf-8?B?ZzY0alErTU90NisrZnlMQXlRTU5WbEJsQ2VkWFJBZkttTG5jNzRpSVVKK29K?=
 =?utf-8?Q?937ogaSyRs1rYCpc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BSr62bCMqwvc3ZcTgKxPQEVAqCIGt47aCt5UFuG+ESCN/jeAx23g3sUt2to6KpPVm0z784cA7hIp1ShQK03CNPBOyVdxyDvJdnWURgYcxcMwEN6Ctx1Vn0H1jrG9rOS4k3a/6F2vFOGDqyG9ziWaiGYqYVeBzCKxv5+83M/FkSqNsRReWlomos6fqjV7BpRVXvadNez2cWwMc3FFTZWyHuyu/K++tUfMA3eG48glHKIZjDt42c1OmtYDfm2TeM7VARx9JHPeh74XZuCdnPIendjbbcNtuv/eIcqF8D+ph2o8ajfqSNJ/od+hZxZ3kv6WmCx49CEZKRVe7RzbSDvROA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b79d3c-8a1e-491f-e6b6-08de7f46c705
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 08:18:29.6298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lBgAK4LdcQe4vqxPgvycIwFMG4fqUxSz+qscY7c9Lw1EqVibO5WkDRGF3FDerZbyM25IO2GGZA3bgNIdAApemWxaqr28XJ0iX0vmtSb9Kak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8510
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [Intel-wired-lan] [PATCH 08/61] fuse: Prefer
 IS_ERR_OR_NULL over manual NULL check
Reply-To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 3396
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/o6SWvh6uLwuUa9q18bRZ5A>

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
bS5kZT4NCj4gQ2M6IE1pa2xvcyBTemVyZWRpIDxtaWtsb3NAc3plcmVkaS5odT4NCj4gU3ViamVj
dDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIDA4LzYxXSBmdXNlOiBQcmVmZXIgSVNfRVJSX09S
X05VTEwNCj4gb3ZlciBtYW51YWwgTlVMTCBjaGVjaw0KPiANCj4gUHJlZmVyIHVzaW5nIElTX0VS
Ul9PUl9OVUxMKCkgb3ZlciB1c2luZyBJU19FUlIoKSBhbmQgYSBtYW51YWwgTlVMTA0KPiBjaGVj
ay4NCj4gDQo+IENoYW5nZSBnZW5lcmF0ZWQgd2l0aCBjb2NjaW5lbGxlLg0KPiANCj4gVG86IE1p
a2xvcyBTemVyZWRpIDxtaWtsb3NAc3plcmVkaS5odT4NCj4gQ2M6IGxpbnV4LWZzZGV2ZWxAdmdl
ci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25l
ZC1vZmYtYnk6IFBoaWxpcHAgSGFobiA8cGhhaG4tb3NzQGF2bS5kZT4NCj4gLS0tDQo+ICBmcy9m
dXNlL2Rpci5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvZnVzZS9kaXIuYyBiL2ZzL2Z1c2UvZGly
LmMgaW5kZXgNCj4gN2FjNmIyMzJlZjEyMzIzZTNhZmI5N2I5ODMwMWY2MjNiY2U5MTdhNC4uN2Iz
OWMwMTMwMjdiZDljNGJhNmYwODBiZmM5Yg0KPiAzZWMyMmJjMmRkNGEgMTAwNjQ0DQo+IC0tLSBh
L2ZzL2Z1c2UvZGlyLmMNCj4gKysrIGIvZnMvZnVzZS9kaXIuYw0KPiBAQCAtMTU5OSw3ICsxNTk5
LDcgQEAgaW50IGZ1c2VfcmV2ZXJzZV9pbnZhbF9lbnRyeShzdHJ1Y3QgZnVzZV9jb25uDQo+ICpm
YywgdTY0IHBhcmVudF9ub2RlaWQsDQo+ICAJCWdvdG8gcHV0X3BhcmVudDsNCj4gIAl3aGlsZSAo
IWVudHJ5KSB7DQo+ICAJCXN0cnVjdCBkZW50cnkgKmNoaWxkID0gdHJ5X2xvb2t1cF9ub3Blcm0o
bmFtZSwgZGlyKTsNCj4gLQkJaWYgKCFjaGlsZCB8fCBJU19FUlIoY2hpbGQpKQ0KPiArCQlpZiAo
SVNfRVJSX09SX05VTEwoY2hpbGQpKQ0KPiAgCQkJZ290byBwdXRfcGFyZW50Ow0KPiAgCQllbnRy
eSA9IHN0YXJ0X3JlbW92aW5nX2RlbnRyeShkaXIsIGNoaWxkKTsNCj4gIAkJZHB1dChjaGlsZCk7
DQo+IA0KPiAtLQ0KPiAyLjQzLjANCg0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3Yg
PGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0K
