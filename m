Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09EFC433F5
	for <cocci@archiver.kernel.org>; Wed, 18 May 2022 19:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=tVrZUI4dFazHlUR+5H9yZhna6HF0bdc5vJqOk88u2Cc=;
  b=mVhCu9y9Q4HltwpXjEGsd3a1DBHNZTV0eqaQf2fhLovKEv5LmjhfSC0N
   +IqZcuf/Bqge0QJN/8FfguEKK30/xIcDEm//decFiQ/GgA4EVhl6jbsMf
   k49uwrKJNiMkHCVYihjkTY29FnN7yFXjrN36BvTgNffyudPsIOAp1yz5p
   w=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@renesas.com
X-IronPort-AV: E=Sophos;i="5.91,235,1647298800"; 
   d="scan'208";a="36987764"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 May 2022 21:31:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AEA0FE4380; Wed, 18 May 2022 21:31:13 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 82959E001A
	for <cocci@sympa.inria.fr>; Wed, 18 May 2022 21:05:33 +0200 (CEST)
IronPort-SDR: P2t6qb+hOGJ6hj/nOenD6/o9RRoKFfmUvI/7D3iTAsG49lnYTKIUMxbsJtEntLnLuVexIk8cuB
 KnKjPA1hrrfsIYl4mPnAXcqcYS9AGdEL1rxd6c7loNbRr8bPlcdX7Y6CXaGMTTtDuyE9XNLEhG
 XCn2lBVVxQIH/NqNXOW6S2f6Sf/ebdzXN46arfSYm20m1YSgO4xwB6+WUZMBLoFeWrEik4OVQm
 Ry2gTqFX6zTQ+ZWfaWxWAPK+gnI17xniYpdxiGN9wB0BOgNfyWhrXjmV2aPn5Dfbdp50go1cp1
 QEw0mxDjMtFsO3Zaf423AAvB
X-IPAS-Result: =?us-ascii?q?A0CgAQBZQoVih31xayhaHgEBCxIMQIMhUnxYKQMHCEOET?=
 =?us-ascii?q?oNMA4UxhQqDBZcUh0wLAQMBCwJCBAEBhQICFoUqHwYBBDQTAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQELDQkFCAwFDhAFQWSBAwGBTgGBW?=
 =?us-ascii?q?AYDATANgjUpAYNjAQEBAQMSEREMAQE3AQ8CAQgOCgICJgICAjAVEAIEAQ0NG?=
 =?us-ascii?q?oJbgxkCoD8BgT4CAoodeoExgQGCCAEBBgQEhgGBXAmBECyHPoJZL4QbN4FVR?=
 =?us-ascii?q?IEVQ4I3MD6BD4M3FYM/N4IulUUdOwNQOxKBIXEBCAYGBwoFMgYCDBgUBAITE?=
 =?us-ascii?q?U0GHQITDAoGFg5CEhkMDwMSAxEBBwILEggVLAgDAgMIAwIDIwsCAxgJBwoDH?=
 =?us-ascii?q?QgKHBIQFAIEEx8LCAMaHy0JAgQOA0MICwoDEQQDExgLFggQBAYDCS8NKAsDB?=
 =?us-ascii?q?Q8PAQYDBgIFBQEDIAMUAwUnBwMhBwsmDQ0EHAcdAwMFJgMCAhsHAgIDAgYXB?=
 =?us-ascii?q?gICGVgKKA0IBAgEGAQeJRMFAgcxBQQvAh4EBQYRCQIWAgYEBQIEBBYCAhIIA?=
 =?us-ascii?q?ggnGwcWNhkBBV0GCwkjFgYsCwYFBhYDJicrLgUEHwEbl0uBKYIjO5YTqkw0B?=
 =?us-ascii?q?4NQgT0GDJ5YFahZLZEMhS4gpmECBAIEBQIOAQEGgXiBfk0jgzhOAQIBAgEMA?=
 =?us-ascii?q?QICAQIBAgEBAQkBAQEBjh0MDQkVgzuKXkIzOwIGCwEBAwmPHwEB?=
IronPort-PHdr: A9a23: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
 0sE4D6e4zg5/rO/khjc9ZCMfgnH
IronPort-Data: A9a23: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
 2OFVSd7STLZtxqxCpGYh+iy3ivx05jKU5o=
IronPort-HdrOrdr: A9a23:hPUkX64seNF57JIajAPXwU6BI+orL9Y04lQ7vn2ZFiY5TiXIra
 qTdaogviMc0AxhI03Jmbi7Scq9qADnhORICO4qTP2ftWjdySCVxeRZgbcKrAeQfBEWmtQ96U
 4kSdkHNDSSNyk2sS+Z2njfLz9I+rDun86VbKXlvg5QpGpRGsNdBnJCe2Km+zpNNWx77PQCdK
 a0145inX6NaH4XZsO0Cj0uRO7YveDGk5rgfFovGwMnwBPmt0Lm1JfKVzyjmjsOWTJGxrkvtU
 LflRbi26mlu/anjjfBym7o6YhMkteJ8KoMOCXMsLlVFtzfsHfqWG1TYczBgNnzmpDr1L8eqq
 iNn/7nBbU215qeRBDznfKn4Xic7N9n0Q6f9bbfuwqunSWxfkNEN+NRwY1eaRfX8EwmoZV117
 9KxXuQs95NAQrHhzmV3am/a/hGrDvBnZMZq59ls5Wfa/psVJZB6YgEuE9FGpYJGyz3rIghDe
 l1FcnZoPJba0mTYXzVtnRmhIXEZAV6Ij6WBkwZ/sCF2Tlfm350i0Me2cwEh38FsJYwUYNN6e
 jIOrlh0LtOUsgVZ6RgA/ppe7r/NkXdBRbXdG6CK1XuE68Kf3rLtp7s+b0woPqnfZQZpaFC7a
 gpkGkox1LaV3ieePFmhqc7jCwlaF/NLQjQ9g==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,235,1647298800"; 
   d="scan'208";a="36986098"
X-MGA-submission: =?us-ascii?q?MDFkdLbHWjcA2Gf3GBZ9PjGN0+GSv/H+heQV9T?=
 =?us-ascii?q?B6BfYkkjZHA9J8xJA1tjhgKuEmbE11uslw2RnN13t2wIdaLvI1CJi+24?=
 =?us-ascii?q?kPiYNZwmnr5KlhQg04BrEHIUyd23zcS4zXDpC50BI9PiEzkPSaRzTttz?=
 =?us-ascii?q?ZJoo5jkeJqbxi9vX4YGpQY3g=3D=3D?=
Received: from mail-os0jpn01on2125.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([40.107.113.125])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 21:05:30 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWtoPVUE+39aDpoi8R8UB6zJYDZ88xO3sOmfa361xrY0FKMdN0fq1rF3L3xcDIi7uK6TwIkNYxXHJYaUeI9DHyqZxc4GLj5g6Gv/UfpVQegO7IOBUpFvXbi16auRYdWX0RvzYzxZenRG+E+elxjqVZcvBBuGHCkU5nSRXp0EbWNbUwdhfsFLC8Rj73jzUv9NGz34ZVlleDJ0SS91kPit8RraUylcueUvMTOU7a2bkSc/8UXjR6bMqZZByUAGpq9uo3NLvRzionDO2HNsF1k8lP+ttZ0suasKrPzDVFYFirIpq3/Gie6aqzc7Ti5U2vxmhJQDr/VBdZ0GYb9zxCWXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVrZUI4dFazHlUR+5H9yZhna6HF0bdc5vJqOk88u2Cc=;
 b=gM2CbwTz9Euc4svT/6z4kjp7TuOvUYcmFC0LcbGUzrAzsASiV+Zm95e7S2TVBmWTa5AVjLrlAujmPCyfWpelBk2DV4Ogr3pG5fdg1xv3cTWYa4j5Ic+CDBsEyJmF/pqytGQSTJfEH5/hDpBb9jWp+Ig6hZvV8VjoXIQSFJ8tYeBO4fYjojxiP5iAnNONpFJVymp/b+dfTvpxFzB4oHwSuFsqax2HvXoxXjgpZ5ID1n926HLPyAFRF7cPFRFzPlwLzzwrHf1ojpq46SJIvNRcDtZn8lO7r7QTmYoxmun4G9+xvQSrjOhFa0nTaZEl1qXYd2SDvY6TJUfVw0wwoJ1VGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVrZUI4dFazHlUR+5H9yZhna6HF0bdc5vJqOk88u2Cc=;
 b=UWWBmPyNWF20kiqbnDkKheeCqn3Uh9pgfnJfZhuTM1x2Wq/JnjkE912xF416qAXWysRQCjS/SToi2fw/z9nhmbjUGQjzHwqFEtNjraekkYyh6poD6u2zs2Uolg785UVdJWiHZ+ehpPvXjQOfqFKoRorksEk2Y2r9Q3w2bMr6fYQ=
Received: from TYYPR01MB7086.jpnprd01.prod.outlook.com (2603:1096:400:de::11)
 by TY3PR01MB10287.jpnprd01.prod.outlook.com (2603:1096:400:1aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Wed, 18 May
 2022 19:05:25 +0000
Received: from TYYPR01MB7086.jpnprd01.prod.outlook.com
 ([fe80::e180:5c8b:8ddf:7244]) by TYYPR01MB7086.jpnprd01.prod.outlook.com
 ([fe80::e180:5c8b:8ddf:7244%7]) with mapi id 15.20.5250.019; Wed, 18 May 2022
 19:05:25 +0000
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Stephen Boyd <sboyd@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
CC: Michael Turquette <mturquette@baylibre.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: [RFC] coccinelle: Add test for unnecessary check before calling
 clk_disable_unprepare()
Thread-Index: AQHYafMQ1GqDaGPIYUKMw5zLbxeQC60k948AgAAF9KA=
Date: Wed, 18 May 2022 19:05:25 +0000
Message-ID:
 <TYYPR01MB7086FB249443BFFB382BE006F5D19@TYYPR01MB7086.jpnprd01.prod.outlook.com>
References: <20220517133556.6934-1-phil.edworthy@renesas.com>
 <20220518183314.112E7C385A9@smtp.kernel.org>
In-Reply-To: <20220518183314.112E7C385A9@smtp.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9dc93a3-a123-4bec-d51b-08da39015d7d
x-ms-traffictypediagnostic: TY3PR01MB10287:EE_
x-microsoft-antispam-prvs:
 <TY3PR01MB10287DAAA04005371CD869551F5D19@TY3PR01MB10287.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5Ij55QiHS7np4cZ6Y5PLlVkr5Jp2CspPXe3jMGB8Ae1evJ9y0Rh2u9davJduTPlmohiv52I4BEhyxvPR1pMiJF37y4h44KqKTyZsDYdwkajDyUdNoPkuS+lfjvMqycb6wjSpa2UGoRdBExejxWKgYm83nh012F/AckV6kauZzwPlGRms81n5X26Yv7Q+n/BkXJgaFQlvTWcZDoXBlmi1D0m2syzdKuTpylYAVX10+nZ9bQt8DR3SJWFU7rBf4LIpLTnE7/gSA1skauiAzN0iihgoJ3BIuxnT75W+4RvOmFt9SeZFs6k8hjF/GMEsWrf46VFiPz+TcrzR73K13fzppaJSFaTcDNZ7pgNd6bWImPDEHUlYFrUE0pUljbhkAZPna4aCarIL0LHSlDpXMCQKe4JP8m7Oto6pTccpyxkSnQfymaEr3uArqvQKKhc3c7/juow7zBfBMg+K3khj8nIpRFX6H1lgGej095fpIgZvWBGXUVpWbSyV1960t/nYJFwiGikIu//kc2il/0Ghk87pkAnSJP38p1poMJXc/9EjzNJ7vmqbvyEAP/D3kzY3kGNqjXH/pIc/xQlCOp3EiaeoD+DPMqqp/HK7LWEGK9q4gDS8JYGfYiE2aoHCmFSI3/wIr1rhpc8tT7gVwhxTG3dPBNrT6hhCZsKOaUnWo1jIr+GbPXqAB9D+3s102Ufbpc2Puqe1xH8+OYm7oJ6iTs+q8Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB7086.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(38100700002)(38070700005)(122000001)(5660300002)(52536014)(8936002)(44832011)(64756008)(55016003)(8676002)(4326008)(66446008)(66556008)(508600001)(2906002)(26005)(9686003)(53546011)(7696005)(6506007)(316002)(66946007)(76116006)(66476007)(54906003)(71200400001)(110136005)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1ZJS2l6NXF5RFU4SXRHS2ZQWExlOEtudEMwL0hySnhHWG15SlJYYTFZcFpy?=
 =?utf-8?B?OGdpTmgwNGo2WVlzWWE3NThiYnpQVHozM1h6ODMzV3V5WVB6dVdadkFIR01Q?=
 =?utf-8?B?NkFVYWdrYnRvOTVWR0VqanI5YURLZzlYOHgyNmhwVmVCQlRHOUJnSEVva2Zm?=
 =?utf-8?B?d1RGakwvKzd1U2hRMk00QXNLYlV3TXpMTTFZVHhNL2RNYmJEUWFOOERONUUw?=
 =?utf-8?B?ZTdSd1BLd2crVnRpQ1YrMlRBZkQ4RnhnTEhFeGlSYXJ2OG1iYjdXZ0U0KzRa?=
 =?utf-8?B?MFpndEc4Z2pzWnVKTm5ndHovVTlNdFhPMG83QVpianBkVFllcGUrVWRnZGZB?=
 =?utf-8?B?VnNzUlFDdExhQlBwa296c3lTUXpUYzRzQUtBOWJCdU5aSWlhMG45ODV3L29v?=
 =?utf-8?B?MmFka0VTenI4TVZyVDcvYktobDB4ejhOamJtbDdaM3VUZXNqYVJVaWNNZGtB?=
 =?utf-8?B?OWhhbDBzLzAzanNzeWJqSTFsYzNpelErSG1PNzkzcnNaSTYxaW0xbW5hcElH?=
 =?utf-8?B?bnZrRnppSy9ZRWNzbG93ZWs4RllERGRWejRaaDNRRWtzYkNhTk5PZGhmbWVz?=
 =?utf-8?B?dVgrV2ZOQTN4Z0x0OUZNWU1TaEdPUjlxN0U4Nm83YkkvZHdFZ3RxbldFQXNi?=
 =?utf-8?B?azRJbjJPTU9Ba0Z4ZXI0YW5nbVdhY0V0QXRNY1NmZ3lTU1JGWUtJK2RaSGNQ?=
 =?utf-8?B?bUJDWmwxUGh4emVWNFRPZTZ5blUwVklvOXo3Vlo4cHd5U2NKN1pyU2NYZ2Zi?=
 =?utf-8?B?TGYyOHVFRFp0T3FCR0tOeUZkbmhuMFhJc0RiUytxeVVWb2xBM0JieHRzVjcz?=
 =?utf-8?B?ZlI3TFJxVTc0MEQydldNOTlPNjJxdHE1VG8zTENkeFRWUHBYMngxdG5nUHJX?=
 =?utf-8?B?aUpvVzJBTXpqVmx0TEFnUzFtbWQrOG1lN2czM0o0emU4dTRTVDFHeGNqeks2?=
 =?utf-8?B?aVIvSlVJMzZhVG9ZcStQNG85VTlkcmZIOUdjUk1hT0FKVlVvQ0YyNXptcXRa?=
 =?utf-8?B?UTVjNzVaQ0pmVkFiQWF6QjNlWXZBbFBCelNLMnJmS3hqb3pTQ2M2bmg2WFlF?=
 =?utf-8?B?RnVxZmp4V1Y1a0ovMmplTXQvQ0dWQnp5bXcrUWNGSC9LRXE3L0x6MXN1Yy9C?=
 =?utf-8?B?MWhyT1YybmYvd3JQclo4OUFmR3cvNld0MURnMkJqUUdEdThPUlZQZTZvd2Vx?=
 =?utf-8?B?YUl3bnNzQXZuNDhmYTQvUEEzNHdGeCtVSUFuMVZpMEQyblZGK3pSUVg0SVR1?=
 =?utf-8?B?TlJxa0lwOEt6Q1FOTk0xZU1xNENCSzNlaDZXbkVsQ0ZJUGVZbXpteGZkdENR?=
 =?utf-8?B?aFZtdDN5ek8vM0ZVWE04VUlycjlrMmNyR2tEeWtOd3NXcFRoOTVSRmdyWkxv?=
 =?utf-8?B?VnRNeTJTRGk3NVhMQnVaTXA5THE2aklZeGxYT2MxNCt4Unk0bXBpT3p1Vmx6?=
 =?utf-8?B?UHh2ZW5UN2FqZ3RMUHZaZVU2d3lBRXhDK0ttdDJ3bDc3RmM5S0FhYzhvWW9y?=
 =?utf-8?B?YnliWlRneWtSZG14Q3laemtqZHVxcEN5ZmFBNUo3V21TRW1uMnJ2TENHTnFi?=
 =?utf-8?B?TnovaEhQdDI3VmlFSGVFU2lCV0ZwMWFhNkxWbnB2VlhyUmNYNFJNUEhZYStW?=
 =?utf-8?B?Y3N4ZmVYeU4zSnZpZEhZbU8yRnpyY2Mxcm5PWFg3NlZRMUNNeFVpaE9nR0ox?=
 =?utf-8?B?ZUxyMmZ6NmV1V0duMTd5YTFNY3ByUHNSeGovVHMzQ3hYUmVqMFFhOUN1cWx3?=
 =?utf-8?B?eVJzQzVVRUZyMmFSaGJKOW9rd0kyUy94NFhHZ01JMXRTMEluSFNCMUo2UCtJ?=
 =?utf-8?B?QThOaFpYMHVQSTV1cDZ2b3MrV2JvZmNDT0tLRWZubFJ3YTRSS2IzVENaMEF1?=
 =?utf-8?B?M042Sk5HWVhKdndIL3V2dmFzRmxtdFU4RGxTeHhzaGJiMHlNbUtmdC9DMTY4?=
 =?utf-8?B?MFBLWGQ1d2NpaVZJWUVhR05oUlRFSXJvV3JzOHM5RjNXT3kvblhtZGtOcjdR?=
 =?utf-8?B?ckJKcUxjS1JiYXg1UG9SNXJiZmltcXk4YzBVeEFEaEJBWmw1SE82cVVGbnhJ?=
 =?utf-8?B?a0h0QVl6Qlc2MGxPbnVWckRTL01WamZyR1o3VGJEZmd2Qy9iMUk2ZkR3RHJv?=
 =?utf-8?B?aU1uQkZxMnFIWXVWaG9LeGdLZUd1WEZvM0ZHVnh2emRRUFZtMWxYREh3NmU1?=
 =?utf-8?B?Q3A2ckhOTElPZUhwOGhCb21rNXZSOWN2VVJKNXdmNnhHOG9LTFlwbUU0TGlh?=
 =?utf-8?B?YVlXejY3MmN5U0UzQmhkalk3bmVXVWpUb1VpQWxweTNhTmlzbkZOM1lBMnVR?=
 =?utf-8?B?dXNvM1ZsaWljYTEyb1J1RlJTRkYrU3RJTHFMdHRQWHIwOTZ3Wm9nTXZ1TFVx?=
 =?utf-8?Q?GMyJ42mzHMkKulWc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB7086.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9dc93a3-a123-4bec-d51b-08da39015d7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 19:05:25.2468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +OXnBxBEL9XOhPIGG5cae+8x5Sycss0RZyC6pufhTz0q0yNn55wZPW62bdbNnTyaeKVxRZWpnr7wWES7xtrzwhp6aKlBZColNFOdhvbiPh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10287
X-Validation-by: julia.lawall@inria.fr
Subject: RE: [cocci] [RFC] coccinelle: Add test for unnecessary check before
 calling clk_disable_unprepare()
Reply-To: Phil Edworthy <phil.edworthy@renesas.com>
X-Loop: cocci@inria.fr
X-Sequence: 396
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/TYYPR01MB7086FB249443BFFB382BE006F5D19%40TYYPR01MB7086.jpnprd01.prod.outlook.com>

SGkgU3RlcGhlbiwNCg0KT24gMTggTWF5IDIwMjIgMTk6MzMgU3RlcGhlbiBCb3lkIHdyb3RlOg0K
PiBRdW90aW5nIFBoaWwgRWR3b3J0aHkgKDIwMjItMDUtMTcgMDY6MzU6NTYpDQo+ID4gVGhlIGNs
a19kaXNhYmxlX3VucHJlcGFyZSgpIGZ1bmN0aW9uIG9ubHkgY2FsbHMgY2xrX2Rpc2FibGUoKSBh
bmQNCj4gPiBjbGtfdW5wcmVwYXJlKCkuIEJvdGggb2YgdGhlc2UgZnVuY3Rpb25zIGFscmVhZHkg
Y2hlY2sgdGhlIGNsayBwdHINCj4gPiBwYXNzZWQgaW4gdXNpbmcgdGhlIElTX0VSUl9PUl9OVUxM
IG1hY3JvLiBNYW55IGRyaXZlcnMgYWxyZWFkeSBvbWl0DQo+ID4gYW55IGNoZWNrcyBvbiB0aGUg
Y2xrIHB0ciwgc28gaXQgaXMgc2FmZSB0byBhc3N1bWUgdGhpcyBpcyB0cnVlIGZvcg0KPiA+IGFs
bCBjYWxsIHNpdGVzLg0KPiANCj4gU2tpcHBpbmcgdGhlIGNoZWNrIGZvciBOVUxMIG1ha2VzIHNl
bnNlIHRvIG1lIGJlY2F1c2UgYSBOVUxMIGNsayBwb2ludGVyDQo+IGlzIHN0aWxsIGEgdmFsaWQg
Y2xrLiBJJ20gbm90IHNvIHN1cmUgYWJvdXQgSVNfRVJSKCkgdGhvdWdoLiBEbyB0aGUNCj4gdmFy
aW91cyBpbXBsZW1lbnRhdGlvbnMgb2YgY2xrX2Rpc2FibGUoKSBhbmQgY2xrX3VucHJlcGFyZSgp
IGNoZWNrIGZvcg0KPiBJU19FUlIoKSB0aGVyZT8NCg0KY2xrX2Rpc2FibGVfdW5wcmVwYXJlKCkg
anVzdCBjYWxscyBjbGtfZGlzYWJsZSgpIGFuZCB0aGVuIGNsa191bnByZXBhcmUoKS4NClRoaXMg
Y29uc2lzdHMgb2Y6DQoNCnZvaWQgY2xrX2Rpc2FibGUoc3RydWN0IGNsayAqY2xrKQ0Kew0KCWlm
IChJU19FUlJfT1JfTlVMTChjbGspKQ0KCQlyZXR1cm47DQogICAgICAuLi4NCg0KYW5kOg0Kdm9p
ZCBjbGtfdW5wcmVwYXJlKHN0cnVjdCBjbGsgKmNsaykNCnsNCglpZiAoSVNfRVJSX09SX05VTEwo
Y2xrKSkNCgkJcmV0dXJuOw0KICAgICAgLi4uDQoNCmkuZS4gdGhlcmUgaXMgbm8gcG9pbnQgaW4g
Y2hlY2tpbmcgdGhlIGNsayBwdHIgYmVmb3JlIGNhbGxpbmcNCmNsa19kaXNhYmxlX3VucHJlcGFy
ZSgpIGxpa2UgdGhpczoNCg0KaWYgKCFjbGspDQogICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShj
bGspOw0KDQpvciBhbnkgb2YgdGhlc2UgdmFyaWF0aW9uczoNCmlmIChjbGsgIT0gTlVMTCkNCmlm
ICghSVNfRVJSKGNsaykpDQppZiAoIUlTX0VSUl9PUl9OVUxMKGNsaykpDQoNCkkndmUgaGFkIHJl
dmlldyBjb21tZW50cyBiZWZvcmUgc2F5aW5nIHRoYXQgdGhlIGNoZWNrIGlzIHVubmVjZXNzYXJ5
LCBzbw0KdGhvdWdodCBpdCB3b3VsZCBiZSBnb29kIHRvIGNhdGNoIGl0IHdpdGggY29jY2luZWxs
ZS4NCg0KVGhhbmtzDQpQaGlsDQo=
