Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26917C61CE2
	for <cocci@archiver.kernel.org>; Tue, 25 Aug 2026 10:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Es6YdiCcuV05io5fZ0rSMt4fxC+kpfJdnTNRWnCdaEs=;
  b=PTr9N7OQLXz7zBxT/h6ZTv9v+/f0y53MTWk4T92ROg3xJUy+ldC37WGo
   CKrK7OO0gqhQ5s02EY5cJl5qzE3wYSsEBIzXJH5UCsps7Yk6x/OZw/+Cf
   K0PNB1X6432Q6XrKGsa8/A19npvlAFs1EsUL/lJ0nA3YqiY2cG7X8GRnX
   g=;
X-CSE-ConnectionGUID: w6gOrhd3SEyLjhWai8/LvA==
X-CSE-MsgGUID: 1gUbXrhEQYybh61nfw/n0w==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.25,242,1779141600"; 
   d="scan'208";a="291425310"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Aug 2026 12:02:23 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 29CB681CB9; Tue, 25 Aug 2026 12:02:23 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 8F639804A2
	for <cocci@sympa.inria.fr>; Tue, 25 Aug 2026 11:57:07 +0200 (CEST)
X-CSE-ConnectionGUID: Hw8LbEQ/Q1qDsjTh4nzg6A==
X-CSE-MsgGUID: LmgGpCDuTeWIXKe8T6T2FA==
IronPort-SDR: 6a8d66f3_z/s8eevpjdhum+AfC378oJ5lJHsYvhQHwikknBXhs69tHe9
 nMC/CPyv505cG3eAb4JOdJJDEjJefUhk0EB5OEg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EkAAD3ZY1qjxJTNs9aHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?W1TgWwwBwhJhFiDTAOETF+HC5AJiTaGTYF8Ag8BAwENUQQBAQECBIR+Ao1tA?=
 =?us-ascii?q?h8GAQQwCQ4BAgQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQA?=
 =?us-ascii?q?QEBAQEBOQUOO4ZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAghjAQEeAgEDIQEeA?=
 =?us-ascii?q?QE3AQ8CAQgZAyUDAjElAQEEDg2CeoIjB0sCAQECo2GRBQICiw4BgTcaAmWCD?=
 =?us-ascii?q?AEBBgQE3hQJFYEHMQGIXQGFAm2EC3qBKldOgVeCaT6ERYNWPYIwgiaBDJNVU?=
 =?us-ascii?q?ngcA1ksAVUTFwsHBYEjQwOBBiNLBS0dgSMhHRcXHlgbBgUSICpBRCMDPoEZQ?=
 =?us-ascii?q?QKBdT8jGTZ8gQlegSspYAECEBcnHy4VggcCglqBJ14CAUlDDgdHIgttPTcUG?=
 =?us-ascii?q?QMEgTUFjlMfgkUolw+DGZsLlRcHK4JrgQuEHZ11F4NxARKTegOSa5kIglmmP?=
 =?us-ascii?q?wIEAgQFAhABAQY2gTI6gVxwgzdQAxkPjiEZg2nMGXk9AgcCBw4DC5IcgUwBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:70m3t6MefWLFsMBcThmjsMiBIKoaSvp037BN7TEKdfU1SL3iqy
 nKpp8mPHDP6Ar4JBob6LW90cW7LU80jKQFgrX5ZI3SPjUO21HYVL2Kk7GO/9SIIUSXygc678
 hdmsBFYuEYZmIasS+V2meFOudl6NSa9MmT9IPjJjhWPGZXgzoK1XYeNu4AeXcGPTV7OQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AdQRk32lvRtS44o/BXAapo7u0nJ3XOV3CnFPaDnb?=
 =?us-ascii?q?/MD9wZKaXdV/M/rFrzeM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A0wk/lAy1vnxC5hQO+yNThNi10S2aqICrB28Vurk?=
 =?us-ascii?q?bh8S7FBxTNmeh0gjtbKZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,242,1779141600"; 
   d="scan'208";a="291423958"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGQ27MjuyxBK972L4tCdEJKC0ztW9mTa/ertO?=
 =?us-ascii?q?AEECbI5siWNqeXvAScbWx8gvVDSyQW1tRsQAfV2ld6+ofvQFAzjNJ6UI?=
 =?us-ascii?q?vudXmpBQXKWYKkD58phVh8BHKoAipWHMVuuGbDZqEGNKDbmHOdKKqwaJ?=
 =?us-ascii?q?3LigL1BO62KsMg+u6up3t8NA=3D=3D?=
Received: from esa.hc514-86.ap.iphmx.com ([207.54.83.18])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 11:57:04 +0200
X-CSE-ConnectionGUID: fblKrMO9R16aiLJ3jH3sVA==
X-CSE-MsgGUID: suWY0jzhSW6+G/jxaH8jTQ==
X-IronPort-AV: E=Sophos;i="6.25,242,1779148800"; 
   d="scan'208";a="509724162"
Received: from unknown (HELO mlsv3.hitachi.co.jp) ([20.18.96.98])
  by ob1.hc514-86.ap.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 09:56:58 +0000
Received: from mfgw13.hitachi.co.jp (unknown [10.178.97.250])
	by mlsv3.hitachi.co.jp (Postfix) with ESMTP id 76D11405F61;
	Tue, 25 Aug 2026 18:56:57 +0900 (JST)
Received: from mrelays03.hybrid.go365.ext.hitachi.co.jp ([133.144.234.40])
	by mfgw13.hitachi.co.jp with ESMTP
	id yntpwF7vcCSkFyntpwY73F; Tue, 25 Aug 2026 18:56:57 +0900
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011029.outbound.protection.outlook.com [40.107.74.29])
	by mrelays03.hybrid.go365.ext.hitachi.co.jp (Postfix) with ESMTPS id 65C96113F3D0;
	Tue, 25 Aug 2026 18:56:57 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gizSZvxfv7GrVwsCMYg0hEjC1ri9dVWfJOwc8TdpAs64/KUEenIO+K2dL+UON1EjK5hKQLSBThZ9G5Xx/bnGDA8X8IdFUlxkMszHU3kQCugRzDwnYRwcA7X5qKLP3aqZ+H8jH1M6yXIiKQSEuDT+5AR8cIiuI6rZc/qcx3jZXz31ji+inbiVczHaEEz/zX3mDg7MjcO9ValwSsLgxN4tote6PuJYzegiHK8hINsNK1Jqt4IdATSo9MslQACeju2KyHpoBCtY+1hw8WcDjFWhLcOa4EzFgPAvpAcPAxGeM78ageRFkOFJKhFvpKPwAWuPHxybRLC8tAAt+VrQl/m3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Es6YdiCcuV05io5fZ0rSMt4fxC+kpfJdnTNRWnCdaEs=;
 b=qYYoetzH4IosJiyKecqZaO4Mjf1fuUokoxhpERWgXrqDOvSQsvsVJODaRTmM+0wwL4fJdW1ZuTPBSz1mWH/0iAUuenPTnyxy7AH0TKYgy5iDA85xq1NU3CIMHsRZzWtrXGuR7bL+l0aWsPeJlS957FUR+MWjyk4CzqWRBRDwigqKl8jfGEZPTswfyFwckPFXCmlmkFCKbjS0wkfiSzAh+COR+LZSI9uE2F4Pbl3iHMPPO+efh2syfuLW82A8PXE1pUJHU8CXx+ZALm5HtYhJ1B2eEkPLat0DKxaaQOjltidL4c+jg0b+smWCmkLqPFSZU6VaDRjlF9miv4VzbxKPZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachi.com; dmarc=pass action=none header.from=hitachi.com;
 dkim=pass header.d=hitachi.com; arc=none
Received: from TYTPR01MB11045.jpnprd01.prod.outlook.com
 (2603:1096:400:39e::11) by TY4PR01MB17459.jpnprd01.prod.outlook.com
 (2603:1096:405:350::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 09:56:56 +0000
Received: from TYTPR01MB11045.jpnprd01.prod.outlook.com
 ([fe80::b94b:9fae:6de6:d9d2]) by TYTPR01MB11045.jpnprd01.prod.outlook.com
 ([fe80::b94b:9fae:6de6:d9d2%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 09:56:55 +0000
From: =?iso-2022-jp?B?GyRCQWoxOj40GyhCIC8gQUlVUkEbJEIhJBsoQkFLSVJB?=
	<akira.aiura.bj@hitachi.com>
To: Julia Lawall <julia.lawall@inria.fr>
CC: "corbet@lwn.net" <corbet@lwn.net>, "maennich@google.com"
	<maennich@google.com>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "workflows@vger.kernel.org"
	<workflows@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "cocci@inria.fr" <cocci@inria.fr>,
	=?iso-2022-jp?B?GyRCRXswZk0mMnAbKEIgLyBUU1VUU1VJGyRCISQbKEJZVVNVS0U=?=
	<yusuke.tsutsui.gt@hitachi.com>,
	=?iso-2022-jp?B?GyRCMCQ4fUA/O0obKEIgLyBBR1VDSEkbJEIhJBsoQlNFSUpJ?=
	<seiji.aguchi.tr@hitachi.com>,
	=?iso-2022-jp?B?GyRCTFpCPD4tNHUbKEIgLyBLSU1VUkEbJEIhJBsoQk1BU0FLSQ==?=
	<masaki.kimura.kz@hitachi.com>,
	=?iso-2022-jp?B?GyRCQEZGIzJtT0IbKEIgLyBTQUlUT1UbJEIhJBsoQk1BU0FLQVpV?=
	<masakazu.saito.jn@hitachi.com>,
	=?iso-2022-jp?B?GyRCOzNGYkJnT0IbKEIgLyBZQU1BVUNISRskQiEkGyhCSElST0tBWlU=?=
	<hirokazu.yamauchi.hk@hitachi.com>
Thread-Topic: [!]Re: [PATCH] coccinelle: update Coccinelle website URL
Thread-Index: Ad0fy7BG9rkZXOC8T/as5IN/IogPpgAHGdUABR4WFHA=
Date: Tue, 25 Aug 2026 09:56:55 +0000
Message-ID:
 <TYTPR01MB11045DA2A325E2C3C7A27F1E4D5AF2@TYTPR01MB11045.jpnprd01.prod.outlook.com>
References:
 <TYTPR01MB1104567F06F7DA6B366C264A9D5C92@TYTPR01MB11045.jpnprd01.prod.outlook.com>
 <c511e35e-ded-839c-c2e9-6774e2e5ac0@inria.fr>
In-Reply-To: <c511e35e-ded-839c-c2e9-6774e2e5ac0@inria.fr>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYTPR01MB11045:EE_|TY4PR01MB17459:EE_
x-ms-office365-filtering-correlation-id: 3ac5aa64-69ca-4cdc-6a6e-08df028f320e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 7XF7GvmTUiv7n4qFqzGRtFJZ4zKbu1ha0FFSHL65DFzbzQnEVZa6KBxC9bNyc4QuImYQGPkC0ARdEwAVG8VKw9l5aL5Br0UthiQuxhkVzO08ag04Fe5wWRxP0tDGBvCi2A8ktLgt71Cjg1FOViGzYUVAoIazlgZ5+Qy/DoS3WLw4hHXXbz3+gIBmeL9754nKjr1PcPqjCotm6acLKh8Zz+YtPzmoGs/iOUyZGt/M2v5KhLaxtAT4Fg8HGvUAsGUvW1IeJVH0zDbrWxNJ9ZbAZQgMUD2jpplvkZHeniX9Vpds22UA3ZWy9y/nRDwgxY2IfmnU1PIM5Vr+IPH6Y6jbP1SXnliMYjYoLx5nE/coIR1k1LYgGplnHs+60RaRcT4ajDk/8L3yas7b3DEO0PgRF+7mMBqxatAaZA47IkG+O43881wLAXbvui3Rc7XWbQdx6RtEjbix2lPEGmhu//TIdQmaldmph/H7CMS7jbhAOIKP7Orkt3rdjalWlmbTtqlbylAADkuUCPdmBrdYjZeIktDy8zo/z5ahZ9a0mJEIi6vETOHfCTsO+GhjqHi1nATAIWu0p8jB59ypE4gwuwxvv0BXsLFrkUzQmsqSVj099x+ZwhCpyeAOu+BeCoPuJdDKTuqsMhApf96yXRhWJdDMNq2kvaskglDy5Dwh0wQptKQwyiU41aGqsWR3R+pcVGyoriV7Nkuc5QwZv1Y+FnEB/kMeArWvUo45RTcUVfuwKok=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYTPR01MB11045.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?dVhERlBkK1RhTXVJMmRMKzh2UGR2U1k5MjZvcnI4TkVKUW5icENWWFNE?=
 =?iso-2022-jp?B?QWphRE81c1lJSUZnSlB6bUIyRmlDRjMwN1JRTzlqY3QzSWxXNXBPYndP?=
 =?iso-2022-jp?B?Q3B3WjFEa001enVWdi9vQ1hjbDJRUEpoL05kWDVnK1lwQS9NeWVtUURl?=
 =?iso-2022-jp?B?bVVyZC9yYzV2NWhFeTlIbEtoU3VkQ3dyeVpMd0Q5N2c3Q2lDaEhxak1n?=
 =?iso-2022-jp?B?Qk0wbVBtU1FjUExxMnE2SVVHMHB5aWRUUTMyTjVTNjVaNEZtaHh5cXlv?=
 =?iso-2022-jp?B?WVNUYkd2M1ZCSk9BTnh5WGF0Mk5OVmt4OW53NGxBWTROdTRhV3NnMnQx?=
 =?iso-2022-jp?B?Yk80R3p6bEtzbmc5VmNHZTVhTURSNStabTZWUUhrMkdna3VPQk9mMDlM?=
 =?iso-2022-jp?B?ZVRSL2FKcE1XTkVzTnNnL2k1bkYyME55aDRJZFd5djZEelBvUkIzcURy?=
 =?iso-2022-jp?B?cXJpcU00enZiSzNpVUJVRlBKZkJMVjIxMlYrVEtLYkJ0V1MzVCtROHp4?=
 =?iso-2022-jp?B?QkdzRm9YZUREaHRvUXdJUW5lcXY5VWs5bTBNaVAxLzlvOUdxbEE0a2ZU?=
 =?iso-2022-jp?B?MGdidHUva1o4WFRlL1FNQ0tLL3hOYUx4cFFndmhlSHhpR0dONy9YMDZX?=
 =?iso-2022-jp?B?d2FGMC9RYmJ5bVFURUhxV0M2WTF2cUcvTFlMSmhQUXY0SlRzTXV3L3ll?=
 =?iso-2022-jp?B?UGN1eTEzSi9QWTNtWGZWTTIvdUNkNWordFRYWC9zWnJmc1hHa0xxUDJV?=
 =?iso-2022-jp?B?QXJyNndEWHRWWEc1eHlpM1hkYlhJRWdpSy91NzJGcU1IalRlZStkOFRV?=
 =?iso-2022-jp?B?UWpFYmhlRVJIaFBsWGphU0c1Mk9vSGNLNDd0a2hMeDJ0UWFNcUhLTjhB?=
 =?iso-2022-jp?B?d3VBWjR2VlQxZzRpQzVVOTlCWit6cXRIRHorcW5Ma3AxMGFXWHJ2MW9X?=
 =?iso-2022-jp?B?bFFySDNsQUw5SWtYdjFjbVJ6VnpEbWV1My9WdS9vOG5NT2xTZ3MxYSsx?=
 =?iso-2022-jp?B?N3Fuc0VqWUx4aitZNU1VSmNOeVF5cFNtRGhBMmlBYktXRXVLMElIekNE?=
 =?iso-2022-jp?B?azZIaXgvZlhLSzQwUi9vYjdjcWZFbWpQTFA2dWZrK3UwN0hMNWNYOVAr?=
 =?iso-2022-jp?B?d05Zd2dGY1lqeUkyb0llSnh4ZTQyVkZLZFBnT3FJbGRaK09mUXFiQzRP?=
 =?iso-2022-jp?B?eUFJd1NpTXY1VnAyN0praURjRk9TNEp4M0hHSXc3ZS82VVpCbFZFRDFO?=
 =?iso-2022-jp?B?SVVVQWV4MjVhK0xzSjdSQU8zOVc0aHB0a2pLWVVwKzBnWUVOeFR3Qkoz?=
 =?iso-2022-jp?B?WGdaY2RpWlpCbUtFb2FIZHY1MWdVRXkvT2lBbXZCdVNtL1dEQW1IcENh?=
 =?iso-2022-jp?B?ditnOTdDUVBOMkhnclRpWUV0c2ZmdWtaWnQ4SzgvTVBHNCt6YzlmNS9G?=
 =?iso-2022-jp?B?UExuSWsybEF2Tkdkd0xzWWkxQnl2cFN3NTJpdGtsRlJ5Tm1oZ2orb0hr?=
 =?iso-2022-jp?B?ZmwvSWZ2djVzamZOcEZlQjg0Z1QxSXVwWnFDRGNRRDU4ZE5YWXl2bmtH?=
 =?iso-2022-jp?B?L3lzWUlKdFJQNmVMeW9UNDEyQjRLdTlOWjQwaHZvdVV4NGxsNDNmc3RH?=
 =?iso-2022-jp?B?eDdqNkZ5WmNtMUdvL1NUQ0d1RkV6MUdpZU45V2hubjEyNzFOTTIxR0Yy?=
 =?iso-2022-jp?B?d1EyN1pTVXJublpvWWRuVTdYbWx3R3ZRWkRJdWtmSHhsWGJ6ZkcxNTFo?=
 =?iso-2022-jp?B?QmcweTh3VmgrOEJKai9DaU1lcVNrYVVqUGEySnF5Z09OTlNEN1UrZlY4?=
 =?iso-2022-jp?B?eDQxSnZvdnYzcWNlNU1NaWNPT3Rxc3M0c2lHcG91RXk4M0I2bytzQlhj?=
 =?iso-2022-jp?B?QmNYb04yL0dKV3UvajVNVjhNVkNJNDV5SHRLQWFLYjZBUWlaQllNUGY0?=
 =?iso-2022-jp?B?TVdOYVlVZkFVa3MzN29CbHRrcXV0dFdOQmNLR0c2VFd5L2pjT2djaTV4?=
 =?iso-2022-jp?B?Q210WVdJR2o5Qkt2dVFTeENmRGU3R05qWWJiejVpYUdBbEdOVmhZdDBP?=
 =?iso-2022-jp?B?SWQ2Y3FJenhYNXk2SkgrMjI4NGZLaVduTGxwek95bXVMWjBtYUFWMksx?=
 =?iso-2022-jp?B?TU14bGpiZ1ZEMVcxdXkvTW5sSFptZktDNDZIbGVnMUpZa2pab25GNGc5?=
 =?iso-2022-jp?B?TmNTMW54QlN4eUM1MkR5dVV6bnJtd1c0dlorQ1ErZDFnQ2pLdy83N2w3?=
 =?iso-2022-jp?B?K1cxVGcxbGdiZmN1S1ZxOUlHR3pEOVB6RkZjNlBKejdpQndhazJ5SWg1?=
 =?iso-2022-jp?B?dG53TVpqTkdFOS9raDg2eVphZ3dPRzlnbkxXUFFZcFVGYzlXRFRhNmhV?=
 =?iso-2022-jp?B?YWpWQWV3bEJ0MDFKS1o1K3pOcE95MVd2S1BZNXlXTWdmSFAxQXVsLzNZ?=
 =?iso-2022-jp?B?SEdXRjdCRGVoVjJJQ1FCMEtjYVkvRE01b2Y4MkpTNWlQSDF6WmNGWUFq?=
 =?iso-2022-jp?B?WitndzIvL0dubmFlNlhxV0l6WGdlUzRyN3VzQT09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	fgtGgog6fFD0r0qfCxrp9YF9ky9lOhflQMJLyHRB/FjhV3if0HoWsmSAynIBTWpdYxnnBbkzBMsuweb+4UueK0OtV2WTyFNZ6a5RzCapob0btk2TajlwTP/2f/V1Q67UNoZhUfOaRQT6B6P9oOuknI1FWUGxze/QEUQBfl7YNPCo6W8lKUPyV/OVj07dGG6WHp574tyTdF8MqEJeJBRESR4QLpFa/waezXXuRmTPnLATrqnrPlVkatrc/RvRTVHXPGDsErJm0ZoOyONRX8bh+J3EyQ+Fz3aPUFMVKW8vWSwgKiSGKRyfl23P2PIgjW8UqV/zl9iBx3UVpM4ZyIj+4w==
X-OriginatorOrg: hitachi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYTPR01MB11045.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac5aa64-69ca-4cdc-6a6e-08df028f320e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 09:56:55.2697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f54277c9-dafe-44aa-85a4-73d5c7c52450
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /JuCiG/ltvjM7SKWmxI1B+7MdIy207PnmXw6i12FFxap15zS9ULtuE1hEsC1oCJSq1ztA9oBIEYVYnPUrDYVXKZzy2+iwL/Q4uXrUQ/c2A0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17459
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [PATCH] coccinelle: update Coccinelle website URL
Reply-To: =?iso-2022-jp?B?GyRCQWoxOj40GyhCIC8gQUlVUkEbJEIhJBsoQkFLSVJB?=
	<akira.aiura.bj@hitachi.com>
X-Loop: cocci@inria.fr
X-Sequence: 3708
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/RSq-AUb0gEvyoAgv9GNrrA>

Thank you for confirming.

I will close this case.

