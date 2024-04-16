Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D49C4345F
	for <cocci@archiver.kernel.org>; Tue, 16 Apr 2024 12:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject:
   reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=kgtPOXB2qQt2znF/2RRaQn62w4opu9HQPZ+eNpVqWcY=;
  b=oyIwY6Adn3SvCPcj5WO266ZAooqta14VAz+GXH53HsKSc+WGfhky+2TT
   uHCb/KA0pkcmqIu4DzXa9UcMP/myLnQ+duIc9TfzNPAzifbwsnKmbwxI6
   +Nm9IxbRxDFUTok76bBsyf9fYsA0eCgjOUAIaWJyW7r4bz3Hcrcx+m1g6
   o=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@csgroup.eu
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="scan'208";a="161861569"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2024 14:57:42 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C360EE013D; Tue, 16 Apr 2024 14:57:41 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4BEB1E0035
	for <cocci@sympa.inria.fr>; Tue, 16 Apr 2024 14:18:52 +0200 (CEST)
IronPort-SDR: 661e6cab_dLAr3eEm5psaWObnMj7wLRVhz+Cuh6v50vNz2Ux2+fkQKVw
 3wRHqLL3RrHW325aqpt+6eqhbtf8qtyWWlfH0QA==
X-IPAS-Result: =?us-ascii?q?A0EcAAAubB5mfwOnZTRaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYFxUnpZMgcISIRWg0wDhE5fjSqXd4FWgX4PAQMBCwJEBAEBAwEDh?=
 =?us-ascii?q?H8CFogFIAYBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QEiGQcODimFbQ2CZwFqgSgBAQEBAQEBAQECAQEBIisCCIEBAgEDEhERDAEBN?=
 =?us-ascii?q?wEPAgEIGgImAgICLxUQAgQBDQcBAR6CXoJgBAKnHAGBQAICiyCBMoEBggoBA?=
 =?us-ascii?q?QYEBNwVgWEJgRouAYgtAYFZhCMJhDc2gVVEgRUnC4J4PoRDF4NEgmiQaoZxh?=
 =?us-ascii?q?CCGIwlLfRwDWSASAVUTIgsEDBoCGxQNJCMCKT4DCQoQAhYDHRQEMBEJCyYDK?=
 =?us-ascii?q?gY2AhIMBgYGWyAWCQQjAwgEA1ADIHARAwQaBAsHdYF8gT0EE0QCAQ0DgTIGi?=
 =?us-ascii?q?g8MgX2BDAIFIQQlgU4pgSmDCUtxFYEIAoJ9gWADRB1AAgELbT01BgMLGwYjH?=
 =?us-ascii?q?aIGJ5lRrkQ0B4QWgVsGDJ9FBhMvg3KmQphiIKJZhWICBAIEBQIPAQEGgWQ6g?=
 =?us-ascii?q?VxNJoM0TwMZD44ghHuOOwGGf0Q0OwIHAQoBAQMJiSKBSAEB?=
IronPort-PHdr: A9a23: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
 id8SyMPn3dxv2yo1ycNmOChw/3Xi0XJGKk=
IronPort-Data: A9a23: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
 Epc7jnlxL+aYw==
IronPort-HdrOrdr: A9a23:ir8bWanpJhtLVzC3lC+S9XdYwafpDfOSimdD5ihNYBxZY6Wkfp
 +V8cjzhCWftN9OYhodcIi7SdK9qXO1z+8X3WGIVY3SFjUOy1HYVr2KirGSjgEIeheOvdK1sJ
 0NT0EQMqyWMbEXt6fHCUyDYq4dKbq8geyVbIXlvhFQpGhRAskOgTuRSDzra3GeLzM2Z6bRYa
 Dsgvav0ADQHEj/AP7aOlA1G8z44/HbnpPvZhALQzQ97hOVsD+u4LnmVzCFwxY3SVp0sPkf2F
 mAtza8yrSosvm9xBOZ/XTU9Y5qlNzozcYGLNCQi/ISNi7nhm+TFcVcsvy5zXAISdOUmRQXee
 r30lId1gNImjfsl1SO0FjQMs/boXETAjHZuBmlaDDY0LHErXoBerZ8bMRiA1TkAgMbza9BOO
 gg5RPni7NHSRzHhyjz/N7OSlVjkVe1u2MrlaoJg2VYSpZ2Us4mkWUzxjIgLH47JlOM1Kk3VO
 11SM3M7vdfdl2XK3jfo2l02dSpGnA+BA2PTEQOstGcl2E+pgEw82IIgMgE2nsQ/pM0TJdJo+
 zCL6RzjblLCssbd7h0CusNSda+TmbNXRXPOmSPJkmPLtBPB1vd75rspLkl7uCjf5IFiJM0hZ
 TaSVtd8XU/fkr/YPf+qaGjMiq9MllVcQ6duf22vaIJy4EUbICbQRG+dA==
X-Talos-CUID: 9a23:GI24QWP2gNUI6u5DBSJD/wkFO+0eKieGj3qNZB6ZKkdXR+jA
X-Talos-MUID: 9a23:kZQ6VwT8milwATn4RXS3qzYlMN9r4Jj3L0UJrK0+5tGuESpZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="scan'208";a="84950479"
X-MGA-submission: =?us-ascii?q?MDHyZiqWmsW8SdITsVpRcYOheFoUhMCV9MIk4n?=
 =?us-ascii?q?lrD8VZHGKxb589MaVH5yVtZdio4Y36zE+y0VeQ2GRpcZWFMu7pvNiH7A?=
 =?us-ascii?q?wqrUOm9JelwxW5wanBZ5d0Eq33m/HwGGnkr/C8OUzB9YgZpD4mBFmhCc?=
 =?us-ascii?q?cCkLkEDYoHeA5apWfvZgQKAg=3D=3D?=
Received: from mail-francecentralazon11020003.outbound.protection.outlook.com (HELO PA5P264CU001.outbound.protection.outlook.com) ([52.101.167.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:18:52 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfBj/n5RXh1mNoAWn7Ebl8iH0GB4PTNSgp3XJiR8Clok+jHL08Epv3Hl07rjuFH6IroNLCCM/ltHxQI4S7A4K7fXgeCzjWBobXEcR6/DIwx7BgIRr0W1TOUkKaPWpri36pHTsfAKtDi4C00X4asXUHldiDlbpQuzp+QtAknbyU45nzZEmbUJSwvtFZ8r1hAaQ95jYN7a8z/GOk25Ko6EMfGrTisQwphOk1ohTmRM42eY4oBNIN5yrC7VNO9LOo96+1u33/LAhlNv2pocNF9z9FY7VwZs3GL7EXrEcEXF+p3hSkv0FNz0fVqKfsKEXkoAmpq35Lco0D0E0klbRF79sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgtPOXB2qQt2znF/2RRaQn62w4opu9HQPZ+eNpVqWcY=;
 b=DikA7rfUcdYlnfCWEwq9YRZYRlwrceGB27KwcswnDLDyjvnTX/WFQkRvas9B/p2JD44oTOB/BGhOR13IL4o++TVBkAtj1ShZe4xrdmIHTNfHNT4Zx1MmImkbkZw6lpB499tKppxA8jUzIbBs4fiUNsD+Hwp0EP7QUq8PXmx+lMs0XBjtJAzX/ow3jA/CNrWwSOx8kdtTVFIMYQanm5GyWNLfrirG8Kfkhd25adpJTk7uDohfiwk/kqywc8TYiTnSCFCKdM1NYsbDFwwgcLnmr5jjSkwv6taJLBW3R9kMr3sEpBwIMroxVCpaV4I4kg4ueYgSu55RshzlbxOG/QFVCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgtPOXB2qQt2znF/2RRaQn62w4opu9HQPZ+eNpVqWcY=;
 b=C3iayb6ldD3YJ8Gb45Ww61XJPRfUybhczJNVJ98Z1wwbphFwwT2jBcmbtq+UIg9TQeab5rb4rVHfZwIdzlSJ3LDuQ+b/hC2sUhtEjyVsVMbhndgjxvQBRbmJQ1wUkUfz0RUrIFnnXnUqfloGuAkz/7vrmxmShVyuwvHtbaKSbGmQaF7/6cb0qN6kt625hA1sXavkZYEFW4mdvwXtHUWO3Sa2ndvG8gEpz7q9BDIeo9zyz13wT7i6GKFpDPWJS16o8wU4KiVlD7EfsCjCxY43RlkM9aB1mooiMK7lfuQcGqIIevUakzmknjCkhfVqnQMLqEzc2vQA2cQ5uybW0D1d8A==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2617.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 12:18:49 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1f75:cb9f:416:4dbb]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1f75:cb9f:416:4dbb%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 12:18:49 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Markus Elfring <Markus.Elfring@web.de>, Michael Ellerman
	<mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>, "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: [0/2] powerpc/powernv/vas: Adjustments for two function
 implementations
Thread-Index: AQHajwiUZ49WFhSb3kyGC8qA5pa//LFqv4eAgAAGBwCAAAuhgIAAATcA
Date: Tue, 16 Apr 2024 12:18:49 +0000
Message-ID: <3711cad3-a627-4a6e-8769-ce916c1919ee@csgroup.eu>
References: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
 <ee6022b8-3aeb-4e6e-99f5-2668dd344e0a@web.de> <87plupbm0c.fsf@mail.lhotse>
 <795ca003-4231-45c0-8bb6-178597950fa5@csgroup.eu>
 <33a38d7e-26da-46e0-90d4-7137f9ec0c90@web.de>
In-Reply-To: <33a38d7e-26da-46e0-90d4-7137f9ec0c90@web.de>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB2617:EE_
x-ms-office365-filtering-correlation-id: b5dfc68f-f52c-4380-96ec-08dc5e0f5f1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rA/uONqvfBvay2XDc+3oxBBVhn+Y1SVHzbA6D75KMPdOywyjtWqWv28JzxOTERwNm0t+/pzR2xl/JeH1hSd2OvP9UvN8g8I+iEqbiL/n6bUY9xF2Ce6FncVYl0Z855iSGa5s+arKGf0+J5Qb5CVKP95diPJl0YHfaYZUROCoJ6K78KpQm5dP7B4OV8xLLzeI8PbOmrS/5Y+jlgO+EiJhJPZJRTE7STd5Xp2iS9sSHejfu2FZ6rcZ59QYI9kgfqpAYddbrBnRfBHDxqhWLg4bnWAzKzEJMfp2kgBW4Kr5svyBa55SVwObqyBx1NmYRPQnX7Isj4j7SsavTk0MwIalwHx9M9lhQYsDdpDrT6nKrjm/41W4VsxA/iVQwxZ7wcZiZ4YUjhSd2CvArkkBmcnJKTyN5k0uFit84AhsyuZ9P77mG22SMAkBVcTnPE41MEqm/8QaGwM37sPZrsxr6JHvkcs5U6yiKp9oW1fRdWBU+6uGOmezeEh4a8KMjO2Knwl2DqvwDTx9cyA/RDMeX3Y0UR0EWq5BYwWHxfTo1+yNsBswpHFSkHzWk4634HoAwY3Tr8CGrbYuvkrxDCUIOk+tgKAuKIFi+ZjUxxhJWYBXWcJs7s7QC8jjFVl4HD48/n6hmRyF8yjz+9i+z8zQ+DQX63rDgpGGh9ecQ6IdPdAPcKqLWMhkknu8UcPpsQhaoCxOXOf3JdRkJXWtez1tuQ3Ng3kRAIE+V2hsq6aPpPUEuDY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGRreXVQSXRha3h0OGt1MmlyWUxEa3BvZHFiSGF3dERmVkpoU1kwQ2h6djg3?=
 =?utf-8?B?bEkzR3VIRXRtelBqblQrU2IzWUxVN0F5M09wTkU1eHRTMDZUTDdzcnlyVU9H?=
 =?utf-8?B?Z2plbkpmc3IxSUFOZkxWdWlJMHlYT1pJdjhZY0EyUWF6ZDVyNFZGTEFIRWNH?=
 =?utf-8?B?YzVOdGkzSDREaHErc2lOR2RGQ0FLblNmVDN6d3BVNVFrSE5lT1BrMzhReGQ0?=
 =?utf-8?B?V3huSnUwVVpnR1pUUkZZMDA5bE4yb2tGelk0SFlueFpWNTZTaHFmV1grYU5v?=
 =?utf-8?B?U2dFUWNhc3hkOTVQNWk5N2hyOEh1ZUs3M0ZKeld6dUFjQThESkdGMTltLzUy?=
 =?utf-8?B?eS9BK1pzNDFIb1JxVmhaTDlzaHdaQWcrNGNOdnpIbVRWY3pRREl4MWRjVU9B?=
 =?utf-8?B?MDNoN3JaMnJTb1h5b0xjVHdldEFvdFBrZjAzY1pGbm5SKzYyMmdaWmxpcjdv?=
 =?utf-8?B?S0ZRVmlCUjhhZ3RSK0RicE5ZZG85VWhZWjFNN29HbUIzZzA5bHJjYTZDcUpC?=
 =?utf-8?B?ay9EYkRDZkEyWWxJZFMxWnY4N2NnMDd6ZmtvakhKRWRVbXNRbUVNUUo2SlQv?=
 =?utf-8?B?Q3pVMy80dlI4TkptYXlNbVVaR2pxKytvZGx0ZWFqTzFZbXoxakw0SzhwcnNk?=
 =?utf-8?B?bW1PVjdSZURNMWErenZ3d1VMd3AyY25GZzU5UnBzNjlGcXYyV0pWZm1qRExm?=
 =?utf-8?B?dWxYeVpNajJZdlJ3QXZBQUNlNTdkcXVlZnc3dmkyeHd3OS9uVEsyVUIyckNz?=
 =?utf-8?B?U2hmb2hpN2pIYXRqUDR5Tnk2TEl5VkVsV0orSEdpak1EV2hMNnVYTGROeHhK?=
 =?utf-8?B?VWd5VTVtNWg1dWJtNHcybm8xenFMNnMxeVBaZjVkVitIdUFCbS9oZzdyakNH?=
 =?utf-8?B?dlU2RVkvRVhYZzJRMHJrRmtBRWJ5QWZHNDJpRnVuMnR5ZG5hdFVVYzFhSUVF?=
 =?utf-8?B?SzBjSnBvL05xQmdTRkRiaFlaOHNJdVIwN1pTaVErclZKV3pyN2ZFTnpiMVhR?=
 =?utf-8?B?WU12TXBaaWNYY25LTEtjTUtOUHk3MFRDbUVwZndVZjhVcmxWZURWbUZEWUx0?=
 =?utf-8?B?NUIrM2RoT0JXYTZlYWtDa2lDQWhjZUZQQlF1aUI2eENTYUU4b2dNYWdnTHZY?=
 =?utf-8?B?dDQ1M1lpTkhkZkpLL2lDQ2lGUmhCOXorUmpPdDVIUnhzM3JhYTlpOHIxcE5k?=
 =?utf-8?B?UldsditzbGE1WmVETG45NDNkYkEyOWlLM2wzUE8vRUhGbWJzdVdLUUdieDhk?=
 =?utf-8?B?QzhuSG5rNzdpYlpHWlFKdkQvRUNUcHN1Vjhwa1o5UnVXRzMzVHBoZjlEblJS?=
 =?utf-8?B?VXhZbGo5UHhNemgrYytOTXFQbzgvLytCbHhpNEJjMmZ0VmVBYVI2SVJ0UmtW?=
 =?utf-8?B?L1psRHBSRG9wS0NiNTFBY3ZzRCtrUXBRc1dXRlhEL0ZERU03ZkMxR3dGdjNl?=
 =?utf-8?B?QmtwanlIZFRKRUE1RzFVWWhJY2g1Y3AxTVlZRzdwdno3dnpHTnJZcENldkRa?=
 =?utf-8?B?ZjlrQUI4SFg1VElIelYxbjc5MmxON3hzRDJxNlppTzlRTnROeUpFMm9IaGt3?=
 =?utf-8?B?dkE3d2dzSHZiNUxzUHlpVjJUT0M2S0VlTlZQUkZpbUZnMndxL0FBQW9wemtK?=
 =?utf-8?B?Sy9sS0haMVdkV0JnT0h3Q2srV0xvckp3eTFwZFpmeHhSSUJ6Sm4vcHoyNXZh?=
 =?utf-8?B?ZzFtVXhpRUtvZzdQdkN2ZHhlSUhQWXB1N0NoM2w5Vi9KVzhQM3Z6dmRtb29X?=
 =?utf-8?B?QkhPT3Z5U3ZMcm9sWkFVaDFUamdzTHcxTEtTTmo0MmdsRVU4ZDhNSTFhaDdJ?=
 =?utf-8?B?M04zN3JNeE5EaGlMS2dlTjIrUmR3ME10NVpEbThxNTFzUFRKN2pxNmxkbkUw?=
 =?utf-8?B?YlVEMHQ4YmF2ZFhPOGdxb2EranVTRmlyVWRBWko5d0I4S3VPUXp0YW5qQTJU?=
 =?utf-8?B?YytsN0dSZXFxcEZKSjFHK2VYanFLUEl5eVJ3S1AvTDBiclZGdDdnZWkvWVpC?=
 =?utf-8?B?bzMzSGhFZnBncmtBZi9wMC9wWVRzNE9sQjA4LzlJa2dvOWNIR2NRSWQ3ZGJi?=
 =?utf-8?B?NjJMSHRHa2RWM0xydjQyUkFRYmJNWVNDdjlGcmxSQjJKUXFGT1EyWVpsdnNV?=
 =?utf-8?Q?kVoDAELm0UR2SYL7thzri3+1u?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D8A3C3A369B184FB72E6A16983EEC71@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dfc68f-f52c-4380-96ec-08dc5e0f5f1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 12:18:49.2642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 65CcY13glDu/wDP0h/HrIYlEjVbiL8K977h1JyT36KVne9J7nCp3kQZSM6B72xbWvnqgK62Dil9cWUx8P/ZqTAbpEslTcT3rlimw3ghc7P4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2617
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [0/2] powerpc/powernv/vas: Adjustments for two function
 implementations
Reply-To: Christophe Leroy <christophe.leroy@csgroup.eu>
X-Loop: cocci@inria.fr
X-Sequence: 1667
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/3711cad3-a627-4a6e-8769-ce916c1919ee%40csgroup.eu>

DQoNCkxlIDE2LzA0LzIwMjQgw6AgMTQ6MTQsIE1hcmt1cyBFbGZyaW5nIGEgw6ljcml0wqA6DQo+
PiBUaGlzIGlzIGV4cGxpY2l0IGluIEtlcm5lbCBkb2N1bWVudGF0aW9uOg0KPj4NCj4+IC8qKg0K
Pj4gICAgKiBrZnJlZSAtIGZyZWUgcHJldmlvdXNseSBhbGxvY2F0ZWQgbWVtb3J5DQo+PiAgICAq
IEBvYmplY3Q6IHBvaW50ZXIgcmV0dXJuZWQgYnkga21hbGxvYygpIG9yIGttZW1fY2FjaGVfYWxs
b2MoKQ0KPj4gICAgKg0KPj4gICAgKiBJZiBAb2JqZWN0IGlzIE5VTEwsIG5vIG9wZXJhdGlvbiBp
cyBwZXJmb3JtZWQuDQo+PiAgICAqLw0KPj4NCj4+IFRoYXQncyBleGFjdGx5IHRoZSBzYW1lIGJl
aGF2aW91ciBhcyBmcmVlKCkgaW4gbGliYy4NCj4+DQo+PiBTbyBDb2NjaW5lbGxlIHNob3VsZCBi
ZSBmaXhlZCBpZiBpdCByZXBvcnRzIGFuIGVycm9yIGZvciB0aGF0Lg0KPiANCj4gUmVkdW5kYW50
IGZ1bmN0aW9uIGNhbGxzIGNhbiBvY2Nhc2lvbmFsbHkgYmUgYXZvaWRlZCBhY2NvcmRpbmdseSwN
Cj4gY2FuJ3QgdGhleT8NCg0KU3VyZSB0aGV5IGNhbiwgYnV0IGlzIHRoYXQgd29ydGggaXQgaGVy
ZSA/DQoNCkNocmlzdG9waGUNCg==
