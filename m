Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F6EC433EF
	for <cocci@archiver.kernel.org>; Thu,  7 Jul 2022 09:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:content-transfer-encoding:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=HGcJwuzkaMSogrcLi2wvtUgCZb9nkgA0gWdEvA11DvU=;
  b=jBI3fYKaaVXncDmzEO1vLi6EbOw9k0F84yIRcHUWH/n/ZvS2L8uXZtpY
   rZYmbMfqsEJ6tDYai3IRq+l/4FutiPJynA2GaQG9mRAu2lh3fFJyxj+ir
   lQnwbz8oqf1I6+n+Qj37L6OrjPgYCM5ywuXxpEHSycC3sQh2tZFWCVOVD
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@netatmo.com
X-IronPort-AV: E=Sophos;i="5.92,252,1650924000"; 
   d="scan'208";a="44643646"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jul 2022 11:24:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D621AE0359; Thu,  7 Jul 2022 11:24:04 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B16D9E0092
	for <cocci@sympa.inria.fr>; Fri,  1 Jul 2022 18:01:55 +0200 (CEST)
IronPort-SDR: dK1DPhBwyxwpkNkhgopXs2sde7hg2bDKhPHGcMHIQPu+/xfr00sF6goA98flu/SgmIPBXKTaYq
 tvv0ztcDO6EGIK9qf7tbqiIOK7Gwg49JZ1+jZD5Dw6h5iBAA4GdAZeMvyQTV7YRUG6LjGxbazX
 XJlnwmgaumK/8Lo0GvOa2RjZ4GY5FshouAn77daySO1Z4cGKdNw+ZlqFAhlUe1w01Z8sAv/2eU
 vmoCUXVlY/POvcDtif1eLaqRO/G668nsnJzhj/p7KVKbhainD8EEI/zlPTNYFHNBhU/SVOFP88
 ojKS8OHKLQM+8a9FIQKDoTMA
X-IPAS-Result: =?us-ascii?q?A0ATAAA2Gr9ihoMGayhaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YFRUn9ZKgMHCESIGgOEUl+FC594gXwLAQMBCwJCBAEBhQQChUwfBgEEMAkOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQELCwkHCAoHDhAFP?=
 =?us-ascii?q?GSBCAGBTgGBMCMLAzENgjUpAYNmEAYVGQEBNwERAYEAJwQBDQUIEweCW4MZB?=
 =?us-ascii?q?AKgQwGBPwICixWBATKBAYIIAQEGBASHXgmBPQGKXYZugRVDeYE+boEPgzeEC?=
 =?us-ascii?q?4Iul3GCNzkDRy8SgR9uAQgEBgcKBTAGAgwYFAQCExJTHAISDAobDlQXDA8DE?=
 =?us-ascii?q?gMRAQcCCRIIFSsIAwIDCAMCAyALAgMWCQcKAx0IChwSEBQCBBEeCwgDGR4sC?=
 =?us-ascii?q?QIEDgNACAsKAxEEAxMYCRYIEAQGAwgvDScLAwUPDQEGAwYCBQUBAyADFAMFJ?=
 =?us-ascii?q?AcDIQ8mDQ0EIh0DAwUlAwICGwcCAgMCBhUGAgJuLg0IBAgENyQPBQIHLwUEL?=
 =?us-ascii?q?wIeBAUGEQgCFgIGBAUCBAQWAhAIAggnFwcTMxkBBVkQCSEcKRAFBhUDIW0FR?=
 =?us-ascii?q?Q8oNDY8LB8bCoEaLCsWAwQEAwIGGgMDIgIQKQYyAxUGLRUTBQQfm1txAYEOo?=
 =?us-ascii?q?1yBM58gBymDKKAyFahklnMgpnoCBAIEBQIOAQEGgWGCFXCDOE4BAgECDQECA?=
 =?us-ascii?q?gMBAgEBAQkBAQEBjh0ZHoM7il5CMzsCBgEKAQEDCY8FAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 X+xXBIbEa8LUHvak4wUpnVZK5R02A==
IronPort-HdrOrdr: A9a23:nCzrz624L8wQGu0ETwi4JwqjBTlyeYIsimQD101hICG9Lfb0qy
 n+pp4mPEHP4wr5AEtQ4OxpOMG7MBDhHO1OkPEs1NCZLUHbUQqTXchfBO7ZrwEIdBeOkdK1uZ
 0AT0EcMqy6MbEZt7ed3ODQKb9Jr7e6GcuT9IXjJgJWPGVXgtZbnmJE42igcnFedU1jP94UBZ
 Cc7s1Iq36LYnIMdPm2AXEDQqzqu8DLvIiOW29KOzcXrC21yR+44r/zFBaVmj0EVSlU/Lsk+W
 /Z1yTk+6SYte2hwBO07R6e030Woqqv9jJwPr3MtiEnEESttu9uXvUjZ1S2hkF6nAho0idprD
 CDmWZkAy050QKrQoj8m2qW5+Cn6kdl15aq8y7lvZPuzPaJOQ4SGo5Pg5lUfQDe7FdltNZg0L
 hT12bcrJZPCwjc9R6Nk+Qgeisa5HZcm0BS5NI7njhaS88TebVRpYsQ8AdcF4oBBjvz7MQiHP
 N1BM/R6f5KeRfCBkqpyFVH0ZipRDA+Dx2GSk8Ntoic1CVXhmlwyw8dyNYElnkN+ZohQ91P5v
 jCMK5viLZSJ/VmGp5VFaMEW4+6G2bNSRXDPCabJknmDrgOPzbXp5v+8NwOlZKXkVwzvesPcb
 j6IS1lXDQJCj3T4OW1rex2ziw=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,237,1650924000"; 
   d="scan'208";a="18327328"
X-MGA-submission: =?us-ascii?q?MDFaWlXSlJf5YdEnn/7EVphrScE2t7cZmrAyYB?=
 =?us-ascii?q?eNrLMKNvwjvfKPn83HCq2Ua7jak+BxU3L6Mz43nRv3473FzsV/UcB2rG?=
 =?us-ascii?q?Pjh3tcdqnYy9Rh3DFiDjB0HWOzAiRtJSOMsmcqOSkX8AWc3BBaeaMkZg?=
 =?us-ascii?q?Kd6/mGJOBRL65u9peX0K8TWQ=3D=3D?=
Received: from mail-eopbgr60131.outbound.protection.outlook.com (HELO EUR04-DB3-obe.outbound.protection.outlook.com) ([40.107.6.131])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 18:01:39 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UezJsg3bXJG5LChTASjUOnMZuxSGl8rggKDeJ6PmBv/S80fluc0XwW4Ghv77LLMXXUBD/3EjqwA71HMT1PzYzj0VEubjsKPWomqK0ImOrrAKHjd/7PDvDtzKs1NEq9P4eGniuZj+R+tFhLc8Fl3XiY9y73hbr84qojg9rME2bGEJOVlGvrir7MeMgCxKEXNUv3g5pMwFBeqI6vkLMUSdj9rd+KJf/kmaUKUiut6cAIfGCm9QPkgH+S0JGPLYihHJfAMBCFMgUtEsHN2drSlGfIcNWLURQejO+N/v+05dk9RpW2IxYXmX5cW3+25xBEuNlMg0JTjRto5rOGVU5s27ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGcJwuzkaMSogrcLi2wvtUgCZb9nkgA0gWdEvA11DvU=;
 b=SuuLsh/6kIQN/xKEBsjH07g5szjFyDMGVPucHD+EiR0xwlkWw4FO38ZDYdSPWSCXGLBY/ceSLgYasWJ2GjNrINvBd++DsZs7j5woVt2y33ZB+qidu5wnq0QaLsuXJtwtzOKG0XhOaXjDlOszmnva7006yY0BWokq0grsMurqpGjPCqloAkYXOAuY13+8qIpWpGK8xFBniIY6UfaM44qcmYo7B+uHZgydunhdPHQSKcmXMuPIVGaFGkTgEdk63huOEDwhbLaw55HBuZRxOyPHU07ji80jeHdydEY5sC0/rUacfWweEWNk+ZjcbfbNdVNcZK94GuFrabC1hVCdbC688Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netatmo.com; dmarc=pass action=none header.from=netatmo.com;
 dkim=pass header.d=netatmo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netatmo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGcJwuzkaMSogrcLi2wvtUgCZb9nkgA0gWdEvA11DvU=;
 b=eWRIjaGXjAvx0nHXzuY0nrmm+5CU/MxZjRajWP7ju22w7GXdBo8X/VumS3KTmd5BwDWzvsc1kY+kCX5NPnKXowxsctgPEoWXcgXOIcKD4OXkKO/3sqKpWGbNqIExOwA8jy+L3g6G4DfFQz2ln1UxfL2NrSIkmplrkfla8qdEYDo=
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com (2603:10a6:20b:34e::15)
 by AS8PR03MB8324.eurprd03.prod.outlook.com (2603:10a6:20b:523::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 16:01:37 +0000
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::8175:20e5:60ec:b87d]) by AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::8175:20e5:60ec:b87d%9]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 16:01:37 +0000
From: =?iso-8859-1?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
To: Julia Lawall <julia.lawall@inria.fr>, Nicolas Palix
	<nicolas.palix@imag.fr>
CC: "cocci@inria.fr" <cocci@inria.fr>, Markus Elfring <Markus.Elfring@web.de>
Thread-Topic: [PATCH v5] coccinelle: Extend address test from ifaddr semantic
 patch to test expressions
Thread-Index: AQHYjWPCH/nX3ZGffkaEjZiGR5ioSg==
Date: Fri, 1 Jul 2022 16:01:36 +0000
Message-ID:
 <AS8PR03MB7603EE9F885BA2573CD56CF993BD9@AS8PR03MB7603.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9fe3bd6-7676-484d-8743-08da5b7afa55
x-ms-traffictypediagnostic: AS8PR03MB8324:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TnjTo9Dowgtn0HJ0oBUnYueWRcSmLSVYxwBK2cUqa1S05D8/GMJdffQHbNgvpTMha3v7jYZyDF/NwWRZbQWgFodxh9cT82eOwbtJw4X7NOBm3ZVHIZmoSe61+qNCElkIwfg8QfWuMQx9NKntGNQE4iuzi6FhkS8d406S9Nn+N8L69xmk3mIxA1BQp6Ckt8N7hayqCUu8UAptHsc64oWr5YjEtheMK5GcVQm/VUlP0K9KqxMmgOwTwvYFQPuzHLyulI5O8CnTWPLs6HPGFIqEHpwhWjrx/IsoEo9Zvs2ZbRMu6wBSXEgbQMxMu1612xJbFgZv3OIIsQ8ScP/v5bdGZXqRoNKZ2sOnBW9xhO3Xqupq0niPGzCwT3HwVMU+G1UWhvP4alma1fFVsDhzHRPp7RIkw99mXpoYTKCiuhjCOVLatxSw77l28hE0CVD9ESoCAY9CHX6DZgqjrWonk+rW9ysTQCCP/Ctgt8Ez49d1NXEFRSkx1Kqg/+pknDEZ+l9Habtr0EUfSuz+UQRUjlQfwa/8woHp3Gs23Fi29tL73w/B2htNBjeNiO5R/kcehj79UPSIOdzY6hzLbuQPCZosZMAIC3cY/LMa8DzvRhsOTXsffWh/rMEHkuNjkcVI37NGjBorX49da6BY7dONQrxjOL924jAHucybEYCuS6JGIEH681I6NMvVrZ6l7/6tEZt0GMjslXiIwmcCBdCzCfqwY/UB29RcmXFI0hmFdqGMOiK0WdpNlX038/x081AzpNCaq9Xv2hEB80rH80B4Z14qFFwNpnSrNXqaNJpsy7stjPY97xrpIXhGKQsHjucrEWe7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7603.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39850400004)(346002)(136003)(396003)(366004)(55016003)(71200400001)(8936002)(478600001)(83380400001)(5660300002)(52536014)(66446008)(186003)(122000001)(6506007)(33656002)(66946007)(66476007)(41300700001)(38070700005)(2906002)(9686003)(54906003)(26005)(86362001)(55236004)(38100700002)(110136005)(316002)(66556008)(7696005)(76116006)(91956017)(8676002)(4326008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?17aX8n47vnD4l8m4YOQpwky9t0XjVwAm+9wCV2wJJKJw5gEsl9K7Ri+E1K?=
 =?iso-8859-1?Q?ukdPPvnJumtOggcO8eOQ0cjAh+nxrY62Yg7tUbaCb9jyM90v1ZrCTM4mug?=
 =?iso-8859-1?Q?aEhZzqs+q/oamQqwVebCqHYoDRv+NTGTIHKG5KzopfeO/NKsjemBGlSdZ3?=
 =?iso-8859-1?Q?yrA1xtidNsekheUNAv/4ukrC7EnOGVkIBzjUUe5hC3TIbBBH6BPgXf9bF0?=
 =?iso-8859-1?Q?YE3ljlK15S5NeFDBDMC4Gb7qJfRl290+WV/T3oGJZROFD1pW1fFNjIihvc?=
 =?iso-8859-1?Q?wofc0P7/J7EmyFgrsZ60GlwvVjjxuyuJYy0DwWCRTuaW1zrcqgLeLNIrmd?=
 =?iso-8859-1?Q?y3v0Xv2all+5S6NeQoLk5/KEBTO84b0DlzCkWFkfhfeUzKjJbjgEln0/g8?=
 =?iso-8859-1?Q?iWYL66ICRgu4AhfjnvCMc+z9AjmOAaxFF8n4UJcNta+hpgKDQBA4wzFJdv?=
 =?iso-8859-1?Q?FC8W7XKZiF6Z/PtJMMp4jgICob4N/zbPiTUxeEMEL8tbIfpJHGwIfOvUo/?=
 =?iso-8859-1?Q?L9GwUhOeP13MtfnBbpTTD/aZdhf1EAzPE3/8mUfH4LrJKZWuA7IM3hGONs?=
 =?iso-8859-1?Q?6tlSHO4TF/PxCdcZ6EFfJ5qZ/aBpwUbGTsax3e4G6Pb2oOQpsbovepboi6?=
 =?iso-8859-1?Q?p5Uu06WbHOdVJTLS9L7SR0H7dXjTvF0ucZAhcbJ/97vLQNgyAwGpka+1ld?=
 =?iso-8859-1?Q?1c27YX55+yOARBhDiHhMnQXkA8/NZMfLqTN5tZUJ8/Q1h/6E+Is3+z5A1H?=
 =?iso-8859-1?Q?0SFY1k3EKc5HWuDLdl5e6SXsU39GJks3Qt0WN1kQ0Rn4+Dkj020wPEYtya?=
 =?iso-8859-1?Q?11QYCa9EPfSrS59zcXHNIvsvnvZJX6rxnTi1jTTfToRAcFsHlFf6cwtplZ?=
 =?iso-8859-1?Q?ZGpx/bzpcg/nDI1/2uZyXZ9hbMLz/Rf3S/Dp4Nx68rlC3m8/lD4Ek+aZvC?=
 =?iso-8859-1?Q?8t/leXo+i2AzQbyjxVVfOP7E3Epj61UW8dFZP8he7aKHQzrR+YiGlZUbaL?=
 =?iso-8859-1?Q?82F6PlBdZGMtJXHVNOxVL0GbMv2xTza/VNh0UO5yfBtqVYq7+5rwEgIgsF?=
 =?iso-8859-1?Q?BaRAV/6wWZP+5pL4ame4tUjaHCxw6GzugmlfRXPrU+K+7Aa4cOzwo0cwGg?=
 =?iso-8859-1?Q?CvFIU00lDHBL/XSE4xp0F68ppKuu45zVuVeoxohirjgj3uGkDfqIg1iJRI?=
 =?iso-8859-1?Q?V26+8W6tgDCFPW3eu1Z6RQdy7NOFMNlU3kWUJhu+oVNhd7NEMVJhuI6Qaj?=
 =?iso-8859-1?Q?04mtCt+4uULtDvlHtGCyx28fTDbN4Hr0nvV2Ez2XKDW4nSTFKeC92xpZvT?=
 =?iso-8859-1?Q?MwHzDprPGaNeQzXhB6hO3l3zeHK7G0ztcyOtoFAo4YCtSGiq7q8+fDe6H4?=
 =?iso-8859-1?Q?HA1Xf/Wakkczh9qvEm5O37loizQk4nLecFuFi6AF4bCX6sSdYu3LM19Apk?=
 =?iso-8859-1?Q?Aeh2dJQp9kq9KwgSiI1BTy63nnHRxokeuVq9mf0vlqFBb4DkM9/7n8zQqD?=
 =?iso-8859-1?Q?8ZOOS747iQd4t+Flu4gWBq0vX7s9OxVN5qjN69czLB971hiCjVy1Ca/nSS?=
 =?iso-8859-1?Q?Hwo4vWNnCtqr2X22O5NJb6KUpO4sihoAS6+BwnFU8Yi5YRxPbUnpqEn5jx?=
 =?iso-8859-1?Q?H4io4HfdNynWi4ISBVt+aDy3W4h49G7s9/HSIIGBp8CMlJ61sRvfIKDQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netatmo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7603.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fe3bd6-7676-484d-8743-08da5b7afa55
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 16:01:36.9768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4528446a-2666-441f-95cd-cc2cbd9f2c49
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OsP3fZ1DLOIZmJOqLlvMxPmfDMXsciGptYWwXcPClI5XFuhHfwyFGTRM7PqIhhLiYRbDp5bc6nGh8fxA3fE5VRmTSnCVbt6IJ/xakUIyXQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8324
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v5] coccinelle: Extend address test from ifaddr
 semantic patch to test expressions
Reply-To: =?iso-8859-1?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
X-Loop: cocci@inria.fr
X-Sequence: 484
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/AS8PR03MB7603EE9F885BA2573CD56CF993BD9%40AS8PR03MB7603.eurprd03.prod.outlook.com>

The test of an expression's address does not necessarily represent the=0A=
whole condition, it may only be a part of it. Also, an expression's=0A=
address is likely to be non-zero in every test expression, not only in=0A=
if statements.=0A=
=0A=
This change aims at detecting an address test in more complex conditions=0A=
and not only in if statements.=0A=
=0A=
Signed-off-by: J=E9r=E9my Lefaure <jeremy.lefaure@netatmo.com>=0A=
---=0A=
v4 -> v5: Change semantic patch to match explicit tests to NULL +=0A=
improve commit message=0A=
v3 -> v4: Improve patch subject=0A=
v2 -> v3: Apply Julia's suggestion to have a more generic solution + adapt=
=0A=
commit message and file name to this new solution.=0A=
v1 -> v2: Moved disjunction on the condition itself instead of being on the=
=0A=
if statements.=0A=
=0A=
 scripts/coccinelle/misc/{ifaddr.cocci =3D> test_addr.cocci} | 4 +---=0A=
 1 file changed, 1 insertion(+), 3 deletions(-)=0A=
 rename scripts/coccinelle/misc/{ifaddr.cocci =3D> test_addr.cocci} (94%)=
=0A=
=0A=
diff --git a/scripts/coccinelle/misc/ifaddr.cocci b/scripts/coccinelle/misc=
/test_addr.cocci=0A=
similarity index 94%=0A=
rename from scripts/coccinelle/misc/ifaddr.cocci=0A=
rename to scripts/coccinelle/misc/test_addr.cocci=0A=
index fc92e8fcbfcb..029db9069c44 100644=0A=
--- a/scripts/coccinelle/misc/ifaddr.cocci=0A=
+++ b/scripts/coccinelle/misc/test_addr.cocci=0A=
@@ -14,12 +14,10 @@ virtual context=0A=
 =0A=
 @r@=0A=
 expression x;=0A=
-statement S1,S2;=0A=
 position p;=0A=
 @@=0A=
 =0A=
-*if@p (&x)=0A=
- S1 else S2=0A=
+*\(&x@p =3D=3D NULL \| &x@p !=3D NULL\)=0A=
 =0A=
 @script:python depends on org@=0A=
 p << r.p;=0A=
-- =0A=
2.25.1=0A=
