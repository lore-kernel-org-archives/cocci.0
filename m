Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7ECC021B8
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject:
   reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=m/kuQieIX2XgrmgXLtwT4vTUgIKfVCEgdlUnyaVsc4E=;
  b=gGs+EWCetn47RqlEHoXNSyxLaf/O4eeNZvJrRA6bA8yPYfBqKRmQWBgZ
   bySTyvUSqqowIm11xkV0K8p51AjyJO5Ccf2MoBVagYTawxK458JQY8phJ
   mdZuj+Rb5L3fUQb03NiaaismqYc14cszPjZax6O60hFpGQj85afwVNoQz
   I=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
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
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211069924"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:59:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4A066E116B; Tue,  4 Mar 2025 10:58:45 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 529D8E0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 14:47:08 +0100 (CET)
IronPort-SDR: 67c5b2db_Dauum/e9NKo/tEoG9YdmlxPuBZrpyBAuXiisI1RrVUUutr/
 qJg2e6Xo8ny+YY5qRujARj/dMIkrk3Sr1W/ITFg==
X-IPAS-Result: =?us-ascii?q?A0ENAABsscVnjwmjxsBaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYFxUn1cMQQlLoRWg0wDhE6JUwOYOIQGKoEsRHw+DwEDAQsBATEQA?=
 =?us-ascii?q?QIEAQEDBIIMgnQCFop/Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBAQEBATkFSYV7DYJiAYEkXgcJOAEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBARECDV4BAR0BAQEBAgESEQQNDAEBBzABBAsCAQgQBAEDAgImA?=
 =?us-ascii?q?gICLxUQAgQBDQUigmABgkEjAwEEokoBgUACiit6fzOBAYIMAQEGBATdfQkJA?=
 =?us-ascii?q?YEQLgGDDoVAAYFscoMkJINCeieBZUOBFYE7gW8+ggOCV4NEgmmCM4FnAgGDP?=
 =?us-ascii?q?Y0TiViRbQlJexwDWSwBVRMXCwcFJQY5RRA4AyAKNBUcAhQNDwEPBhAEagU0Q?=
 =?us-ascii?q?TqCC2lJOgINAjWCHiRYgiuCF4I3hD2EQII/UYJCghFxbAMDFhCDH3cchHyEa?=
 =?us-ascii?q?h1AAwttPTcGDhsGPaFtATqDT3EBAVI7TEEpgTMNkm+EGq89AwQDhBuhYjOqV?=
 =?us-ascii?q?i6HZZBqIqNxhHQCBAIEBQIPAQEGgWc6gVxwgzcJRgMZD44hDA0JFoNCM48KA?=
 =?us-ascii?q?bkQRTM8AgcBCgEBAwmFRgEBiiItBYFLAQE?=
IronPort-PHdr: A9a23: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
 cCYVg==
IronPort-Data: A9a23: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
 VUIqat4rI1XhKI//QuMu5KYJf3BgA7S8g==
IronPort-HdrOrdr: A9a23:zuZ9cKoDYFrbnKyt8jOwa90aV5tDLNV00zEX/kB9WHVpm5Oj5r
 uTdaUgpGfJYWgqKQgdcIi7Sd+9qXO1z+8K3WGIVY3SGjUOy1HYZb2KirGSlgEIeheOsdK1sJ
 0KT0EQMqyDMbEXt7eH3OD8KadW/DDlytHwuQ699QYZcegCUcgJgXYde2LrdTwRNXM2eKbRVq
 DskvavzwDQKkj/Bf7Ld0XtKtKz1OEj46iWESLuaSRXlzWmvHeD0pK/OR6e2RsVTjNIxpkf0U
 WtqWaZ2oyT99uA5lv5zWH807R68eGNquerQ/b86fT9LA+B5XfLWK1RH5m5+BwlquCm71gn1P
 PWpQ07Ash143TNOkmovBrEwWDboW4Twk6n7WXdrWrooMT/Sj5/IdFGn5hlfhzQ7FdllM1g0Z
 hMw3mSu/NsfEj9dWXGloL1viNR5xaJSEkZ4LEuZrtkINUjgYpq3NEiFYVuYcY99WzBmdAa+a
 JVfYnhDb5tABinhjbizztSKZWXLz4ONwbDTU4YtsOP1T9K2Hh/0ksD3cQa2mwN7ZQnVvB/lq
 b524lT5fFzp/UtHOFALfZERdHyBn3GQBrKPm7XKVP7FLsfM3aIr5Ls+r066OyjZZRNlfIJ6d
 D8eUIdsXR3d1PlCMWI0pEO+hfRQH+lVTCozs1F/ZB2trD1WbKuOyyeT1Illdemvpwkc4jmcu
 f2PIgTD+7oLGPoF4oM1wriW4NKIX1bS8ERssZTYSPOnisKEPyligX2SoedGFO2K0doZorWOA
 pOYATO
X-Talos-CUID: 9a23:w/fQ+m6mhfESi6Gh5Nss+RYKFJ4DdUHn/VSMJFaaGWw3ZYScYArF
X-Talos-MUID: =?us-ascii?q?9a23=3Avrvtxg6pLaQfRaH4YqbBh9Okxow02omjI2YfrK8?=
 =?us-ascii?q?CgI6EbDQpHy29pj6OF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="110506721"
X-MGA-submission: =?us-ascii?q?MDEbXlQgPz2vceSQo0yvWbJbPlHCMqOjR/ig3l?=
 =?us-ascii?q?ZX5wojNlOqN+jtHE0vXOF7+ChWkTdWMzaLm7kIrvUygLGLeUMzqBPJW1?=
 =?us-ascii?q?FAozCKKYEd95ICTe6wQ8RD8kcfcj4LG2nebERCEH5wZmha117nmWiKGs?=
 =?us-ascii?q?87Rm1IMsk9bbP4Pe6GYJIqqg=3D=3D?=
Received: from mgamail.intel.com ([192.198.163.9])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 14:47:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741009626; x=1772545626;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=m/kuQieIX2XgrmgXLtwT4vTUgIKfVCEgdlUnyaVsc4E=;
  b=MWg+M2X5YOO8jeeAEJesJUECIip5y+32nrse2a5s7lwCdZguB98Eb+OJ
   q/5LR1XXtUglzpOgEkbJGEBFRBI5i/CJJLwQR9JR23nhAtPmddVyzJ/h1
   fSypReNfsqEqBHJZ02xCL5gAiSHtbCvczbDC3DCfqus/SJ5PAFvkPoTsZ
   k4N+SbaPvUAqzWliuFkZOO/8ye4qDhN7Wuu2PYiY+LCCsCTtYpzp/vzl5
   28Rxpfjdw/vNyiferjGUH71wQbmL6m9zV78/yHvKSbEdihAYZPZKVVUf/
   mb0wDL/RJhBJa66FYxIdYxz0Z2cnGkzlwabJbdXEX/FJelApL5sh53Tel
   w==;
X-CSE-ConnectionGUID: /+bY81d8RWmXAP9BS6QJQg==
X-CSE-MsgGUID: Ojf9BhN7RRCqfrBLUDp9SA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52522434"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="52522434"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 05:47:03 -0800
X-CSE-ConnectionGUID: jkKcoZD+SYSWPJZ3ffxopA==
X-CSE-MsgGUID: 43GZLUiDSwSEJOCBR++uWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122139966"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 05:47:01 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 3 Mar 2025 05:47:01 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 05:47:01 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 05:47:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAaTrEYZskpXBSPB+u8dUrYwyJckJ0F4JNYh5+9EnbZ2+5MtMXqDrTYqYCKMsGhwKBNXfiy+rqZBrtaXaVyaXDHs5GWDlLiXBzOoZpOjZ+qiRscXgLZXZAzZg6aeK0pxz8vEMs1VQstFl2njctlG2d/a0VSaZiphZGe5YlKWR8/JRTRwpxSXmazv/elJ7n8I2oNpuUIZNQadQQ6CmKYiAVICAJ/InlboY6mI4gRGGDiDA6zcGX5doFchiPMGcbddK9vT18D0eMJquxL/yjxnbNQFJjPXkUwm3/tSAHPPo8ovQMRcGsRpGxpoMXanD60SXnGKTDEvxrpRt2Mbik19dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lCUaAfh7NqSb6MQUPttDUkhXntzHQkWwe/XI1IjAXM=;
 b=dobhLWXrTaLkCRUMAkleqm9zN5UMHP4ZWu+ChazD58v2oQKwGl6XIgz8kVLv4iVh2teY+HkDz4yOD5keiopA8zeEFkqaNfkyeLYsWgveJUk5OXEhwwQ6ZxHNMTO2vNaviDWzyCgDg8Ve5FSjwE9d8YHX9RZP7F0efqsA959aMKS7SWZv/qz0Mwk7wx187R5ESKCPnXOBqugsOktMqzq32RKgWUbf2oXEA2kQlgNA6VUxMAXY/DAe8sWmKK4tZcL7zRQJPCH8ht/mTKxPvNo/gnAqeQo0nJ1zG4tjvP/JK5qYCNZNyzZjM9P1oCPChcDylgpCP0rL4uqYVauI89Fx1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9)
 by IA0PR11MB8336.namprd11.prod.outlook.com (2603:10b6:208:490::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Mon, 3 Mar
 2025 13:46:58 +0000
Received: from PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f]) by PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 13:46:58 +0000
From: "Berg, Benjamin" <benjamin.berg@intel.com>
To: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"Markus.Elfring@web.de" <Markus.Elfring@web.de>, "davem@davemloft.net"
	<davem@davemloft.net>, "Berg, Johannes" <johannes.berg@intel.com>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "quic_srirrama@quicinc.com"
	<quic_srirrama@quicinc.com>, "gregory.greenman@intel.com"
	<gregory.greenman@intel.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "Korenblit, Miriam Rachel"
	<miriam.rachel.korenblit@intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "horms@kernel.org" <horms@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: [PATCH RESEND] iwlwifi: Adjust input parameter validation in
 iwl_sta_calc_ht_flags()
Thread-Index: AQHbjD7QpN77/r5imE6nKxR9LH86KbNhbPcA
Date: Mon, 3 Mar 2025 13:46:58 +0000
Message-ID: <529d640929c2349f2dfe6c3de20331b5b809fcfb.camel@intel.com>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
	 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
	 <9cb634c8-d6e6-32bc-5fd6-79bf6b274f96@web.de>
	 <22e24ec8-283f-49e9-b7b0-555e8113c250@web.de>
In-Reply-To: <22e24ec8-283f-49e9-b7b0-555e8113c250@web.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7964:EE_|IA0PR11MB8336:EE_
x-ms-office365-filtering-correlation-id: e319515d-10f5-40bb-1869-08dd5a59de3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?VWVoZVdNOUsva0pwRzVBOUd0YWdyOTJmc0hrUVdNUldjd2tGRjhmQm9DbWFL?=
 =?utf-8?B?UFE0c2l1L3RWMjZOSTNxN0pjTFhqb1lyc01FU0U0MTBsUjY2cDhxVENRRWZS?=
 =?utf-8?B?bkprR0FabUZoTUtqNjc4dDdOQnJuTCtPYUJHeXZiT0phaVgzQUNOSVh6dlJL?=
 =?utf-8?B?RXYvem1ManVUeDdmMHBGclplZmltNHJWSTVxZ09IOFE4SlJZYjcvUkZqcHBj?=
 =?utf-8?B?MFBPRVA1U2J0SGV5bHVweXVxSGhsMHkyU2NPSm15b1VVMW5FR0ZIN0lHb2tJ?=
 =?utf-8?B?YmhqSUhqWjBYWkRNSVlhdlIvdG5lVSsrK0tBS1Q0TWY3TVZKZG9QNEhRYXRh?=
 =?utf-8?B?Tk02M3hvSWEwMmRWRlFmQncwZTgxNzdrU1VaMEoyNCtYaGV2MU5lTTM4VUEy?=
 =?utf-8?B?d2kyNEYrQW0vQzJIQU1STHBPeDdYZDZHQkRWdzVoVGpBZ3lFYnQzVEZWTVly?=
 =?utf-8?B?UHRjNVJtRDRvTWZ6czYwL2tuYmovU0swRkhGZGoxOEs0UEp5LzQxTjlhV0pv?=
 =?utf-8?B?R3BrUjZ2eUFtdFliWjBMQ2ZvN3VuN0ZZNmJIblhrTlZBYU4zTXVBQW8wc1Vr?=
 =?utf-8?B?NW9oMVFWaWgwcDl3RmRjZWxrdTdpdXlUS2VUZHhMRUpnaFFxY3ZadUQzR3p6?=
 =?utf-8?B?VFlKaTZWUVdjeEdIU2pVOEJkdG94TitGMWVRUVVUM1Q1eFRoQkQrSnl1RWVy?=
 =?utf-8?B?NEtMRUZuWTBhMEdUaE54SGxwcUJHOTZsajVkbG9lNWpHckpEMllCUWxRcTZt?=
 =?utf-8?B?UFVKSDhFRUpWa2MrUmw3QjdaQnQ0YnJkK1ZIM1JnS2VMbS9EdklKU3ZEdFlX?=
 =?utf-8?B?dnR0S0YxaDdiWFVuaVZXVlIyMjZuWThIcTRub1g2aThQVjE4VFdva1dzQ3Jm?=
 =?utf-8?B?SFJKckEvV2pMcUpxZ0RuVkZRSU9qYkQ0Y0c0MTA2dHNNVGdZQXo1L2U3N2lk?=
 =?utf-8?B?MWxpMTRsdmtmVU9RS0hRZVFMTytWTmVBRVpJS1hTa2lvbzJtQzc0YlF4aE9E?=
 =?utf-8?B?V1FvN3ErVmlteUJwZlI4YVNBZEF4Y3hsak1RcWVNdmRVZVpsMkl3eGdwSGRP?=
 =?utf-8?B?TUlMcktvVXdIUTY1KzFGZjJnV0VsYkdwSDVpa3I1dzNvM1lBV0hXcC9waHRx?=
 =?utf-8?B?amNzOWFaM1lWdHVFeWhXNVBTeW53cmJwNmYycFpadEVsOXI1REhCaUVaZ3di?=
 =?utf-8?B?d1UyVkpPbi9ObDRuM0FXMTZFMmxlaFhtQXYxL1BLTnR6cnZnYWk3YkJNUWRO?=
 =?utf-8?B?TTdmU0ZkSTFndFRTOTBhd3gwOVcwakpIN3IycXVWVWZxanhBek96VFFSREp2?=
 =?utf-8?B?K3RjWCtnWThEMmRvTWdZUmhzSTZYVk9ReHRlZEh1WnRqb25tZWs1am1ud0dB?=
 =?utf-8?B?YUhlMXNxV1AxMDhPdnp0N21EOG5UMithdzUrMHJMV051OWtEZThPOXdDZTFD?=
 =?utf-8?B?YTZXcS9vNVNGZGdQSkZVUFcyY2g4UnhkM2RVbThOL0lBZ1Q0WEx0SDJjMU5k?=
 =?utf-8?B?azM0NTFSVjMyWXJzM2Z1eEVaTDlXUHpjbFBzS1l0cS9lRXB4Wm41aW81S3lq?=
 =?utf-8?B?Qk1PUUdtYjFMT0FPUCtpcG5sMExVcEZ5djRBZm83aGhSekVLSU9GT2dZaWN0?=
 =?utf-8?B?d0RlUUMwTlg3TDAyUDNZbmNWY2RYdHVDZTc0aWY5VVlST1VqSGVpcW16dVVC?=
 =?utf-8?B?MlE2MG10VTc2eFlDWnNkK2NKNXovV0tYUUhGeXBNVW5rcDJ2VjJEMGtxbUZi?=
 =?utf-8?B?alBvM1BYVGl2WmhsazBrdGIzNUZRTHUxMDd5SDNJOFhadUVWVEp4SGE2NTY3?=
 =?utf-8?B?MFE1R0w2V0hHQzlHOHdPcXh3Z0l4dmc1QzArYldyVWZZZDdYN25tQlFOZ1pF?=
 =?utf-8?B?VE9BZVhBMUtSTXFnS3BqRDRWdHk3ZkFrbUNUMnFsTkQzL3dzR1EyUDhjVTRh?=
 =?utf-8?B?ZjlPdlRKeUYwdDhscGtsVllVS0JsblBtenl0NHFjQS9uVHhETDZueXpGSStY?=
 =?utf-8?B?UWppTHpZc0N3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7964.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0gxOS9KamZsWVBCWWFBaFZmWGtzeVNqUk1yRmNmQzBNblJQLzlJS3BkY3BY?=
 =?utf-8?B?aE1aYnI1MkpoYzI5WHlUcHhqQWRCTmVLN0dTNTc0QnhORGJBUmoxc1h3blBI?=
 =?utf-8?B?b0dHNEVNRDhndTI2YUcrelNSYitzQWg3bThqR2FQNGpmNnBSUSs4ZVFFQnFX?=
 =?utf-8?B?enNqSm0xejN2WDJ6SDR1bjg0dlVjK2xkeFNIcXBlZzFML1VCUDVrRnpqUmcv?=
 =?utf-8?B?SlBHSENHREkwUWY4emJzL3ZLeW5MYUR6bGlmMkpJY1JJU3doNUxybFg2Vk53?=
 =?utf-8?B?Ri8wZGJFWnc2ZklHQTQ3bTBFLzdaZ2NLVUpRRS9FQVFnZkpxK2JJdUYwVzV1?=
 =?utf-8?B?eWNXZ2tKcmZqQ0RocHZkWDczb2hVREF3a2lyYmVGbHZjV01kaWdNZ28vbno5?=
 =?utf-8?B?MmV6d0NhdWFxSjJ3aUhNaGZ2S0doM2ZEbE5PMGo4SVhGY1IwUmJwN0hmTzYz?=
 =?utf-8?B?YzFmYVFZdGNuMHI2dC9SbEtrZ0QyK0F0ZHY0UUpqY09Ia2U2ajRXYlNSV2J0?=
 =?utf-8?B?bExJWXV2Rk1IM2dEVjdVcytuWE5STEtTeWU3ejVhekovdFJvR1VkcEdSeXJL?=
 =?utf-8?B?RjI4dmx4NGRFbjdWSDJ3OHFCajZqYzI0dUtNZFBTRmFpeUo0MWtaNG1NZ1l5?=
 =?utf-8?B?Y2VIUEhOS3dHN1hRbGJ3dDdOb1BVbVFORFhENlZDTlpJVW1nV0ovb2hXNW92?=
 =?utf-8?B?OW5MOVRia0VMRnpUOTB2MGdMNTJSWEFuWElMNUtNSitUMUg0OHRtSUhqYm56?=
 =?utf-8?B?RFUwdzNEWTJ3RFd0VUtYRWl2aVpiTkZXVElOSVNEWnJCYXJWNnEySWNGbWZU?=
 =?utf-8?B?MGZrUlpjN1EzcE1DSDZNRnplNm1IbWExOVNMUnBrbEZXSFAwUDNCdjhKdHJ4?=
 =?utf-8?B?b0J3WlkrS2dtdDkybkg5Z2thQUVKb2plaDN3dnRPWU04Y3V3VElwMi80QjFo?=
 =?utf-8?B?OHpzTWExVWovYmN5Z1dYbUE2ZjZJRmtwMVo1d0Zwd3FWYTdIT2VCTlA2UWlq?=
 =?utf-8?B?WHByQ2QzNFhwOFdVNDIwQWJsak40Yk9aV21TV0Y3d2RYOWEremNHdlpidllh?=
 =?utf-8?B?VkJLZlUwQjZCUFpuRDAvNjRqeVk1VVNUU0NCZk1Ob1QydnB4WFJjN1lUdHRR?=
 =?utf-8?B?ZVBrNm1TUHUvdzUyUEE1djFlSzNleGhVQUtQbGphek5YSXZUaEw4c3pxSmNR?=
 =?utf-8?B?Tkxyd0ozN0R0anZ3U1h1QmNzQkJKN0t2cnNSa3hjYVlaSndrQTVhUFpPanBC?=
 =?utf-8?B?K2plS2ZhOWZ4S3EyM1FiaVFaSi9LL215VTlaYU15Vkg0WkxzYWxIOFNLSlQ3?=
 =?utf-8?B?RzgzS0t0Q2J5R3UraVlxUXM4aFV6Um93bmJHdlBreGREUzRyeFhkR1FiMU12?=
 =?utf-8?B?Zlp0QXF4bTZzYldpMG5HcU5YZTdyMkZJNDgwRE15STQzbDUwb2gxR3hYUDFq?=
 =?utf-8?B?QjI0c0orOGxNeDB5YUpOUjVURWN3NkpUY3ZEbFR5K2pPaHpRYW9OeldmeWs2?=
 =?utf-8?B?TFNHWnhnL0psb1ZzNFF2bGFiT09BTjY1RUxzZWlIblZIelhxeCtCdW1vQ0pu?=
 =?utf-8?B?bVFBMWFJdktsYkFsbytVRWg3cXF6a0grR3F6eUxoam5EajF1QUo3Z20waG96?=
 =?utf-8?B?VG9tSFhRSjR5MXRJTCtVSytRU3RLSXBFYVcyTTJqUzZrdTJBdUIxU1FBaGNW?=
 =?utf-8?B?NWpjc0JYaTE2ZWxBT2haMkk2QW94YlN2dWxpTHZwRlAzNzBSVzNYbFZDS0xK?=
 =?utf-8?B?dWxEeGsxU3daODA4VUZ2WXdkZUpYZnRCbkNWVi9JVnVLTytpaFcrR1BHTEU2?=
 =?utf-8?B?dDFzQTRYM0ZDUWZaNUJtdkhoZmZGQWptekprenJUcjNDNHk0Vi9IOURvM3BB?=
 =?utf-8?B?Z0E0NVR1WWUwRk1lU0MvK3YvdmduMGw3WmhydWEyUW9WRjgyamlOQUZIemth?=
 =?utf-8?B?UWlndTJVekQwZzdlL2VlL2FPbEpNZnJ2cU9uRlFDK2J4ZkpSUkRjS2lPOXl4?=
 =?utf-8?B?dHBFeTdGL09TbzNCbmZGTi9rUkkvblpOenN6TXNGSEVkQ3hwOVRXRUE0MlVn?=
 =?utf-8?B?QVh4V3J4cE1CYTN0VFhtQ1RlQ1IyeU45Nk1tNHllTzBwMndJdzUvT3dSd0I1?=
 =?utf-8?B?SThIdllhMjNmbGt6SUYzL0FNaHF3YWx0RGduSDkxcmkyeEF6aE00UDM0VFM2?=
 =?utf-8?B?U2VZT3NyOTBPVmxXaGtaSGxBVFdlbktYRFBTaFd2ZTY2T1E3QW50M2hlTCt3?=
 =?utf-8?B?SSszWVlJQ05aM3RnY0tuWkNQSnBRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <341285465845ED4C956DFAFA92FBA564@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7964.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e319515d-10f5-40bb-1869-08dd5a59de3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 13:46:58.3185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4BT6zAvZaaO4GR/Fhvhqr8cAhnR10ULScDiJM/0wIsUe3Qns+yCX1La5rAGUSR7n15eJ76/zFOD5lHkSKtCOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8336
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH RESEND] iwlwifi: Adjust input parameter
 validation in iwl_sta_calc_ht_flags()
Reply-To: "Berg, Benjamin" <benjamin.berg@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2512
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/529d640929c2349f2dfe6c3de20331b5b809fcfb.camel%40intel.com>

T24gTW9uLCAyMDI1LTAzLTAzIGF0IDE0OjE4ICswMTAwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToN
Cj4gRnJvbTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0Pg0K
PiBEYXRlOiBXZWQsIDE5IEFwciAyMDIzIDE5OjE5OjM0ICswMjAwDQo+IA0KPiBUaGUgYWRkcmVz
cyBvZiBhIGRhdGEgc3RydWN0dXJlIG1lbWJlciB3YXMgZGV0ZXJtaW5lZCBiZWZvcmUNCj4gYSBj
b3JyZXNwb25kaW5nIG51bGwgcG9pbnRlciBjaGVjayBpbiB0aGUgaW1wbGVtZW50YXRpb24gb2YN
Cj4gdGhlIGZ1bmN0aW9uIOKAnGl3bF9zdGFfY2FsY19odF9mbGFnc+KAnS4NCj4gDQo+IFRodXMg
YXZvaWQgdGhlIHJpc2sgZm9yIHVuZGVmaW5lZCBiZWhhdmlvdXIgYnkgbW92aW5nIHRoZSBhc3Np
Z25tZW50DQo+IGZvciB0aGUgdmFyaWFibGUg4oCcc3RhX2h0X2luZuKAnSBiZWhpbmQgdGhlIG51
bGwgcG9pbnRlciBjaGVjay4NCg0KSSBhbSBhIGJpdCBjb25mdXNlZCwgSSBkb24ndCBzZWUgYW55
IHJpc2sgb2YgdW5kZWZpbmVkIGJlaGF2aW91ciBoZXJlLg0KDQpUaGUgY2hhbmdlIGlzIG9idmlv
dXNseSBmaW5lLCBhbmQgSSBndWVzcyBvbmUgY2FuIGFyZ3VlIHRoYXQgaXQgaXMgbGVzcw0KY29u
ZnVzaW5nIGFzIHRoZSBjb21waWxlciB3aWxsIGdlbmVyYXRlIGEgd2FybmluZyBpZiBvbmUgdXNl
cyB0aGUNCnZhcmlhYmxlIGJlZm9yZSBhc3NpZ25tZW50Lg0KDQpIb3dldmVyLCB0aGUgY29kZSBp
cyBib3RoIHdlbGwgZGVmaW5lZCBhbmQgY29ycmVjdC4gSWYgc3RhIGlzIE5VTEwgdGhlbg0Kc3Rh
X2h0X2luZiBpcyBuZXZlciB1c2VkLCBzbyB0aGUgZmFjdCB0aGF0IGl0IGlzIGVmZmVjdGl2ZWx5
IGEgTlVMTA0KcG9pbnRlciBbb2Zmc2V0b2Yoc3RydWN0IGllZWU4MDIxMV9zdGEsIGRlZmxpbmsu
aHRfY2FwKV0gZG9lcyBub3QNCm1hdHRlci4NCg0KQmVuamFtaW4NCg0KPiBUaGlzIGlzc3VlIHdh
cyBkZXRlY3RlZCBieSB1c2luZyB0aGUgQ29jY2luZWxsZSBzb2Z0d2FyZS4NCj4gDQo+IEZpeGVz
OiAwNDZkMmU3YzUwZTMgKCJtYWM4MDIxMTogcHJlcGFyZSBzdGEgaGFuZGxpbmcgZm9yIE1MTw0K
PiBzdXBwb3J0IikNCj4gU2lnbmVkLW9mZi1ieTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNl
cnMuc291cmNlZm9yZ2UubmV0Pg0KPiAtLS0NCj4gwqBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL2R2bS9zdGEuYyB8IDggKysrKysrLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZHZtL3N0YS5jDQo+IGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9kdm0vc3RhLmMNCj4gaW5kZXggY2VmNDNjZjgwNjIwLi43NDgx
NGNlMDE1NWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvZHZtL3N0YS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
ZHZtL3N0YS5jDQo+IEBAIC0xNDcsNyArMTQ3LDcgQEAgc3RhdGljIHZvaWQgaXdsX3N0YV9jYWxj
X2h0X2ZsYWdzKHN0cnVjdCBpd2xfcHJpdg0KPiAqcHJpdiwNCj4gwqAJCQkJwqAgc3RydWN0IGl3
bF9yeG9uX2NvbnRleHQgKmN0eCwNCj4gwqAJCQkJwqAgX19sZTMyICpmbGFncywgX19sZTMyICpt
YXNrKQ0KPiDCoHsNCj4gLQlzdHJ1Y3QgaWVlZTgwMjExX3N0YV9odF9jYXAgKnN0YV9odF9pbmYg
PSAmc3RhLQ0KPiA+ZGVmbGluay5odF9jYXA7DQo+ICsJc3RydWN0IGllZWU4MDIxMV9zdGFfaHRf
Y2FwICpzdGFfaHRfaW5mOw0KPiANCj4gwqAJKm1hc2sgPSBTVEFfRkxHX1JUU19NSU1PX1BST1Rf
TVNLIHwNCj4gwqAJCVNUQV9GTEdfTUlNT19ESVNfTVNLIHwNCj4gQEAgLTE1Niw3ICsxNTYsMTEg
QEAgc3RhdGljIHZvaWQgaXdsX3N0YV9jYWxjX2h0X2ZsYWdzKHN0cnVjdA0KPiBpd2xfcHJpdiAq
cHJpdiwNCj4gwqAJCVNUQV9GTEdfQUdHX01QRFVfREVOU0lUWV9NU0s7DQo+IMKgCSpmbGFncyA9
IDA7DQo+IA0KPiAtCWlmICghc3RhIHx8ICFzdGFfaHRfaW5mLT5odF9zdXBwb3J0ZWQpDQo+ICsJ
aWYgKCFzdGEpDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCXN0YV9odF9pbmYgPSAmc3RhLT5kZWZs
aW5rLmh0X2NhcDsNCj4gKwlpZiAoIXN0YV9odF9pbmYtPmh0X3N1cHBvcnRlZCkNCj4gwqAJCXJl
dHVybjsNCj4gDQo+IMKgCUlXTF9ERUJVR19JTkZPKHByaXYsICJTVEEgJXBNIFNNIFBTIG1vZGU6
ICVzXG4iLA0KPiAtLQ0KPiAyLjQwLjANCj4gDQoNCkludGVsIERldXRzY2hsYW5kIEdtYkgNClJl
Z2lzdGVyZWQgQWRkcmVzczogQW0gQ2FtcGVvbiAxMCwgODU1NzkgTmV1YmliZXJnLCBHZXJtYW55
DQpUZWw6ICs0OSA4OSA5OSA4ODUzLTAsIHd3dy5pbnRlbC5kZQ0KTWFuYWdpbmcgRGlyZWN0b3Jz
OiBTZWFuIEZlbm5lbGx5LCBKZWZmcmV5IFNjaG5laWRlcm1hbiwgVGlmZmFueSBEb29uIFNpbHZh
DQpDaGFpcnBlcnNvbiBvZiB0aGUgU3VwZXJ2aXNvcnkgQm9hcmQ6IE5pY29sZSBMYXUNClJlZ2lz
dGVyZWQgT2ZmaWNlOiBNdW5pY2gNCkNvbW1lcmNpYWwgUmVnaXN0ZXI6IEFtdHNnZXJpY2h0IE11
ZW5jaGVuIEhSQiAxODY5MjgK

