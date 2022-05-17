Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4F4C433EF
	for <cocci@archiver.kernel.org>; Tue, 17 May 2022 06:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/CZocCNveRJ1HeJkxHNYWn5KrPS1CBLw/WJ65YlRqkU=;
  b=KU2zCCIwAnSwMNYD/OfUq35o6hen9z3DWGp+g+GFu2PPCtQW+R+EuKMh
   J4kqijM26SX9z1ogmdaomxjT9w4nqFR0K+F9vtYXBH1C+URHAKtbVLMYS
   8JG1k1z+PU29QUvQY63mOOxU9kEbDALCDI6ohzrdIQ+4tukcxr4RmewvT
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@renesas.com
X-IronPort-AV: E=Sophos;i="5.91,232,1647298800"; 
   d="scan'208";a="36610170"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 May 2022 08:50:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 30FC7E033C; Tue, 17 May 2022 08:50:43 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5311DE00A8
	for <cocci@sympa.inria.fr>; Tue, 17 May 2022 08:45:34 +0200 (CEST)
IronPort-SDR: TJ8nRqIeD5GppjdAAxwZyywETn/TJ4M9wq7AtXJ071KNL23mubSz/hwA4e+3SSY5WkxXHQlZw2
 cBskyrcQBQ+qQGIkq5f38epnKtxj5ANg6D0Odl1lLVm69UN2oinAfHJpXg60NsIFL+5681Lulp
 F6KyMWCQlo+Uo8iVc+3kbcWGQkQ5NKQ2ZW3OluRXs824dX9E4LEbLG2flpQu8K0kRY+VqMlFO/
 bLlna+79YWh8MkbXaSufpkA0WKgI2ps32HRIKA/awh2qw+F8IY4gLECsoOgKQZ1loflT2o9tGR
 gOnlcutVWsgDGeUmo/R43tUh
X-IPAS-Result: =?us-ascii?q?A0AhAQAVRINih2JyayhagQmBT4FSUnxYKQMHCEOIGgOFM?=
 =?us-ascii?q?YUJgwWcZIF8CwEDAQsCQgQBAYUCAoU/HwYBBDAJDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgQEARMBAQEBCw0JBQgMBQ4QBUFkgQMBgU4BgVgGAwEwD?=
 =?us-ascii?q?YI1KQGDYwEBAQEDEigGAQE3AQ8CAQgYHhAyJQEBBA4NGoJbgxkCn1IBgT4CA?=
 =?us-ascii?q?oodeIEzgQGCCAEBBgQEhgGBXAmBPI5gN4FVRIEVQ4I3MD6ERoQLgi6VczsDV?=
 =?us-ascii?q?IEFEoEhcQEIBgYHCgUyBgIMGBQEAhMSUx4CEwwKHA5UGQwPAxIDEQEHAgsSC?=
 =?us-ascii?q?BUsCAMCAwgDAgMjCwIDGAkHCgMdCAocEhAUAgQTHwsIAxofLQkCBA4DQwgLC?=
 =?us-ascii?q?gMRBAMTGAsWCBAEBgMJLw0oCwMUDwEGAwYCBQUBAyADFAMFJwcDIQcLJg0NB?=
 =?us-ascii?q?BwHHQMDBSYDAgIbBwICAwIGFwYCAnEKKA0IBAgEHB4lEwUCBzEFBC8CHgQFB?=
 =?us-ascii?q?hEJAhYCBgQFAgQEFgICEggCCCcbBxY2GQEFXQYLCSMcLAsGBQYWAyZhBQQfA?=
 =?us-ascii?q?Zw8wDI0B4NPgT0GDJ5XFahXh1CPFqZ/AgQCBAUCDgEBBoFhghVNI4M4TgECA?=
 =?us-ascii?q?QIBDAECAgECAQIBAQEJAQEBAY42g1mKXkIzOwIGCwEBAwmPDwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 xSQMKONSDLeZzuRKLC5pcST/9bxxpkbtpvdmB4=
IronPort-HdrOrdr: A9a23:cnYYYK6dJHn74pZzdgPXwU6BI+orL9Y04lQ7vn2ZFiY5TiXIra
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
X-IronPort-AV: E=Sophos;i="5.91,232,1647298800"; 
   d="scan'208";a="36609179"
X-MGA-submission: =?us-ascii?q?MDEib6qOGSilrYi0/7GiNO+JEctEo9oFqo6z0G?=
 =?us-ascii?q?LW184Grlug5VXtGyHHu09Ar02fT7g8o+kw9jPOK0u9YrZBNKIjPxyXqH?=
 =?us-ascii?q?eQjFcrBlloOPR5M1h1k7nWiO767Yq50Lm3UujGfi3nUQJyjr8T1FnQGp?=
 =?us-ascii?q?BsRnQeSbY70krZPLwT/bTqEg=3D=3D?=
Received: from mail-tycjpn01on2098.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([40.107.114.98])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 08:45:31 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KL/ogg7RPXty7wSc4bdHaXcf5rhHH7AWqu0FoXm7PEcQYBbW843BK+vQDbfkmbE1F7t/zcCPnwBMaoEwXWRz/dXdbMSTrt+9FJ65mmELbvN6LIGf2CHjem1Yr7LBEuEdd3XirDASeObkAMU03Kh2NJfol15z8Na+RbeITLzioGdBppFfuFGutn+o18cPWnneYItcebcdjagidN0ZW2FVb5EtGzM/cHJF2fseMZaaIOujerDmEgRSeJ+IeP9l2H4Od2+hqMCLZHZTebO5cxrGC5ebTpCHXM+5/MKWWQOVZ8tVkUuMUDYBBAcPlzVaQl6YKW7YyEMoMbpgRqeHafTluQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CZocCNveRJ1HeJkxHNYWn5KrPS1CBLw/WJ65YlRqkU=;
 b=IKsEEFgEpzeMTQUQnBXxMnT6uGwoaZPOl79Yw+MnYBtg3qU/kUOHoUeD475yRSYnePy7tD/HkNEhbSaqS0Rxo/FuDKEgT9cgbnggp4s2rhmmR880iDyGJ9ZuP4LIcWM/CzOg+Dbqoj/Rd4tmrlQb9+UkVMhmGZPeosdmYIVzi6iyVhZemitkWamP2CZ4xJL4qRcJUffWSgVbLtrJ93X9eni+U/moIg9f4JVVRSiJn2XSzLqAN3F4S1ODMnvpAuQCxD6tevg4Mf/qEBg02k5ih/AHMVJbnTyROj7SLVVkzbnwA7F7Kf/umLB2JlJIFffSYKPVvic0KAqYvxskbxWAWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CZocCNveRJ1HeJkxHNYWn5KrPS1CBLw/WJ65YlRqkU=;
 b=UhX8pb+YfHhd2pKJT6TDcMVBckaH3qnBd1ZgS6j0Ou52acYbN7vuc0HTT6YJhkgnD88j6h7QZOsZ7zsLDoftwBqZrY3SLlF50wU5DHcxE2NyY+Mj8wg1DIoFhyqpNlMGozQEx7YujDZGWCPH5seHFNaKU6mPvxhjZ80vOAE+5ys=
Received: from TYYPR01MB7086.jpnprd01.prod.outlook.com (2603:1096:400:de::11)
 by OS3PR01MB9483.jpnprd01.prod.outlook.com (2603:1096:604:1c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Tue, 17 May
 2022 06:45:27 +0000
Received: from TYYPR01MB7086.jpnprd01.prod.outlook.com
 ([fe80::e180:5c8b:8ddf:7244]) by TYYPR01MB7086.jpnprd01.prod.outlook.com
 ([fe80::e180:5c8b:8ddf:7244%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 06:45:27 +0000
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Julia Lawall <julia.lawall@inria.fr>
CC: "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: [cocci] Matching an if statement with just one func call
Thread-Index: AdhpUuUAdHcxOS+STjCVaRB6YEfnZwAD68YAABW9MhA=
Date: Tue, 17 May 2022 06:45:26 +0000
Message-ID:
 <TYYPR01MB70864F201147465AF65E00EAF5CE9@TYYPR01MB7086.jpnprd01.prod.outlook.com>
References:
 <TYYPR01MB7086CFE025C9A65F40613D61F5CF9@TYYPR01MB7086.jpnprd01.prod.outlook.com>
 <alpine.DEB.2.22.394.2205162221140.2918@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2205162221140.2918@hadrien>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dae698e-2c96-4964-3273-08da37d0d3a8
x-ms-traffictypediagnostic: OS3PR01MB9483:EE_
x-microsoft-antispam-prvs:
 <OS3PR01MB948380761D28F85DDC0F53A6F5CE9@OS3PR01MB9483.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Mz0/3oRCagzg/SBDc4evjU6WMG7zrdd9MSfbCXIuxDw+T1zIxGml84OyeZJEeF90+9c9Xk0Mf5SEkRcaIuVqVqzkfpDAQpgk+GFUwOQ3Lpev+QWzySXopyscQ3KCp+QJOlUG9yFNNDRTMWaJKbpbrQ76rDoioTgwpOGaqLKl5B14P3x7Ui/SMjc4pl2oqxQKccKtVz9O6A65PM8Bhl4L1vpFeG3siTYAxNvzp6Pa8cmf+CKtvt2dI90qwpMZQs3T/qK3Q/V9+1LcS2S6rIFVbNfvcqvJP07CxTP2OWRE66KwY8palDf1Z8PEm7oUoUFNJpO92fnh95VPtWxzywznsRWvzWoRkOeBqaZ0Aa3oLumiLhh7+eoqw3sBU0CQpyFOIMb4Ruq6UmQMpleRkn5m0IuAc7pJb/e/YZ37LX2r6pDcQt4wXnAM+s/Xlw2ys+XuoM2qyTEEKdbaX0XwEpF2YsajQwA/t+W80mdrSZW+mUFGglewG2UnabGDs6wo+oamQteNe6p3eXXQSwwx5wtlP65Fuvqpd0YBoc9SF2oacI9rhjDV9Qi7kuJ4CR/OQlZUzS8jXtWNHVRdnFsViPxxIBOASyD6QI6SmOsUoLCgHTRYuj2lt3HzadfGWNby3eVbgvYj1DsRy007xxjqC6WMW594EqBTos8PzVrBgeAcHxii6ElCFvr6EPx9/Ua6Y98h8rbvbOgGNFUD9IquG/U5Bw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB7086.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38070700005)(4744005)(52536014)(8936002)(55016003)(53546011)(122000001)(5660300002)(44832011)(508600001)(71200400001)(26005)(7696005)(4326008)(64756008)(86362001)(66476007)(66556008)(76116006)(6506007)(6916009)(66446008)(8676002)(66946007)(2906002)(33656002)(450100002)(186003)(9686003)(316002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?U1RA7flItUJ0phSw9UyJMB+v5Xn7Q/oi8WLGN6XfscC1cj6R9xTfg6G+QwUR?=
 =?us-ascii?Q?DxWUv9PY6DeE48yo7gdUh6zJdL05NDJDOU/AQyXH9lW4Pz+Mjan/Zu2/3wdW?=
 =?us-ascii?Q?wQWTIE1/En/hAqWDtLxVGCwhqQnvY+s912pkVvgizD7d1JQHLq1/Hrr/4OV6?=
 =?us-ascii?Q?KlQH974A+KMVOUMZbsWLK3gVjA18XKQMrzU+l0q2oGtiJfjEA3MiIAEDDbZ8?=
 =?us-ascii?Q?sBx8nkGTPKReD0KiN8BbWmQzQeRSiPDYXflz40fOGBVLBtlzEEL9AQPIl3RH?=
 =?us-ascii?Q?xLrQLyl1A6A0RAjfDaXFPdR0ww9YdVCWN9r30uS0+8c4hh4IIAOoOymnYZ9B?=
 =?us-ascii?Q?Ni12sgVOk4ekKLSFBxpCO5JqZXkWmY/bL5JQz9VfjXzieoWl17SOBen91PZV?=
 =?us-ascii?Q?ogDxUYt/1YFcp3Rtl9Oy/UDp2//lkTb/8CaAEcT8tUUamCZu52Ae1EyCBCfR?=
 =?us-ascii?Q?MB7dJKKmjRKa+Gq58ah66SBLdfRtMT0ylaxiyDU6fK9kz+vxBUS0j0N73d6V?=
 =?us-ascii?Q?uQAOz3/kD70g/L1E/XDHt3sBVBbN1RVJH0tn/Bsqk3wPyJRbvSgQheYHNDyQ?=
 =?us-ascii?Q?7O5Q+Nfi9Qp/UO7hfln0E4uyHsZwabY/FqWsSzwiOFZqa8k+l5dPXp5nIhWL?=
 =?us-ascii?Q?gfG8W8uiKtCw5qTEb4DuRp38rjFlEgXNLg237zR9RE7pt5OgCOXHHbVou4AH?=
 =?us-ascii?Q?bsEDMVYER16AbOsGR/mozfcS/xcwVrckcQ4btUfQ81rAbuT9akDrUlhota2t?=
 =?us-ascii?Q?YVxIS3CfmtKqUgvnew7NVrZEWPHlggY9TzRzPotGC45jBBKJTgylPq8ONfHY?=
 =?us-ascii?Q?DPW9K5LNWQEesNBXfo/Cw8K/N+ucWwVBaufpulCvcQDCgxnbTalgRaXNnDYD?=
 =?us-ascii?Q?MyozMYlqtXL4kEYlesOixSAFs/5ZfWqMIdYx/OXuINfm7S1dM6XYVw5fQb2k?=
 =?us-ascii?Q?JZwdQZt7j/S0FEC6m0V6UkquEWrYaXkttC2FK+nRfwz7V3JhBvug7/2fPFfr?=
 =?us-ascii?Q?FYV7ekZYH/iC75yFXim+WNoWy8XcVV7EUGcuOWLc49rjVGFk2CziQgiIQH7E?=
 =?us-ascii?Q?7orQNC6z9PvoMNHz4190zQAPWxypdhPLQ48Fbu06WB3Poibco4f3zDhkGdkz?=
 =?us-ascii?Q?bwM09B9mQ1qoebuPTYH7FjdhNELVbZ6LfB4BeTuOggysrk3KEk7WThC5+QTa?=
 =?us-ascii?Q?dN3UFC85M4FqH01lbhpXmPPBSjTGbexzcDSN9HtJNL8ji0LkZ9R5hV790TLF?=
 =?us-ascii?Q?oTWnYGi3Z7Eu9kYrgMeCSO/2DGfRkDqDWKKPi8tM8vu05BlgwW33fbwvtZZt?=
 =?us-ascii?Q?0LZJprdRud2JirTVZqX/Yn+0hNtMhHwcpCMAdivFiU61oYmL1lG26iofSshR?=
 =?us-ascii?Q?vntiROcAQkDpV9VZVV7uRoKO6GVbFs6/mMQvKZLR2pOusMa+BP0oWIvtWSIo?=
 =?us-ascii?Q?Qc1eebRoWUoEtlKcz67og58SVF3PNyqRV4UCOboI0QP6pC2sstxQ1OpyHguq?=
 =?us-ascii?Q?+xHyL2jjthD3lvCCKS87kK1f41I55xTJU/Dxci3+PPpvrd4+t0KSalITuQi0?=
 =?us-ascii?Q?CIiSEqTH7qjU9zFzVvz78h0l4qDo9nAAYO4/kMlOmOymB28U//etEmmqVeOM?=
 =?us-ascii?Q?4ftEa9MS6ADMiy/tmdqNhme2gcNKWkgkXi8zFjksm9GKCmMm7uwNMp2Oibzq?=
 =?us-ascii?Q?uhqZedSuKa4sXpjENW1rsl/zhC4Y7bcUhbdv3vzx/4HxjEQsR4pukjSoWGIF?=
 =?us-ascii?Q?b5pZQaUXi7FgTMaefm8jL1VtgUAO53o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB7086.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dae698e-2c96-4964-3273-08da37d0d3a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 06:45:26.9618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IDfxMoyp9pyL+auJzxs+O71OZy4nP2CcsYJJh2CV0BmN4zI13aiJ/r7CizwChNX8fsCMbxmJkS9g9SY2NS0s+g7adceyXtPG6h9XN1ok2/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9483
X-Validation-by: julia.lawall@inria.fr
Subject: RE: [cocci] Matching an if statement with just one func call
Reply-To: Phil Edworthy <phil.edworthy@renesas.com>
X-Loop: cocci@inria.fr
X-Sequence: 393
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/TYYPR01MB70864F201147465AF65E00EAF5CE9%40TYYPR01MB7086.jpnprd01.prod.outlook.com>

Simple as that, all working now.
Thanks Julia!

On 16 May 2022 21:22 Julia Lawall wrote:
> On Mon, 16 May 2022, Phil Edworthy wrote:
>=20
> > Hi,
> >
> > I'm trying to get my coccinelle test to detect code in the Linux
> > kernel similar to:
> > if (!clk)
> >    clk_disable_unprepare(clk);
> >
> > So far, I have got:
> > expression clk;
> > position p1,p2;
> > @@
> >
> > if@p1 ( \( !clk \| clk !=3D NULL \| !IS_ERR(clk) \) ) { ...
>=20
> Drop the ...
>=20
> > clk_disable_unprepare@p2(clk)
>=20
> Add a ; after the above.
>=20
> julia
>=20
> > }
> >
> > However, I don't want to pick up code where something else is covered
> > by the if statement, such as:
> > if (!clk) {
> >    do_something_else;
> >    clk_disable_unprepare(clk);
> > }
> >
> > I know it's related to the ... but I can't get it to work.
> > Sorry, I'm a coccinelle newbie.
> >
> > Any help appreciated!
> >
> > Thanks
> > Phil
> >
