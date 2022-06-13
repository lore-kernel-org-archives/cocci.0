Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC27C433EF
	for <cocci@archiver.kernel.org>; Mon, 13 Jun 2022 18:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Jfy0QYvhoMrP8bjy0n6chaum6Z9q5DMBv7clHK8CdIE=;
  b=cnF+BARYFY+yelBjSnHrxoB6cFtTtNNhd5ckxPU9Yqp/j0o6Uo+r64LP
   sotjQs/t4hqFvtopb5jrkw3uw5S3Nvj/6pIjPH+e/5HXiPyKQz02Ass/f
   LCroIND+iM9ZG5UBBQgvHAR0WHaTkqAhDJNxs0huK6e1nm13SDtij3Rmo
   Y=;
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
X-IronPort-AV: E=Sophos;i="5.91,297,1647298800"; 
   d="scan'208";a="40819507"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jun 2022 20:11:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AA6F4E013D; Mon, 13 Jun 2022 20:11:27 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 56C2EE0038
	for <cocci@sympa.inria.fr>; Mon, 13 Jun 2022 18:25:06 +0200 (CEST)
IronPort-SDR: oDQdlpYJmnP5YfDXR8orpDVKRiDIO88jCB8l6YROkM0D1fmwPHawNf8Fvdd6xgcZo9p1sGPkdg
 xIejy5h4fYicWnkxJJAN6AD4+KOSCjf4CaFZk3vQgfCNm09jUKy/fBnWHD+8dtSiDATE4fqhya
 K7mfRUTgvMLpYFBG4TvDu7OfvSNORQphtWWRoNlTORRSEk6XDEs7OG2wK7F9ChSNVEEc9z5VDi
 BSVgT5Qts0dsR4c9wCnvytg6YxJqVyXSg+tRjRnZGO2Sfzw+SI1nt8h2GQQJKeSDLHOKDn5D0P
 ek1WweoGPpYYFa3Hw61/OI+s
X-IPAS-Result: =?us-ascii?q?A0CKAQDEZKdih4EPayhagQmDIVJ/AlcqAwcIRIgaA4Uxh?=
 =?us-ascii?q?QuDAgOeZAsBAwELAjkJBAEBgg6CL0ABAgEBAoVIHwYBBDQTAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQENCwkFCAoHDhAFPGSBCAGBTgGBU?=
 =?us-ascii?q?wsDMQ2CNSkBg2QBAQECAQwGLgEBNwEECwIBCEYyJQIEAQ0FCBqCWwGCdSMEA?=
 =?us-ascii?q?gyhOwGBPwICixWBM4EBgggBAQYEBIE3AQMCDAJDhU8DBoE9ilOEHIJQgViCN?=
 =?us-ascii?q?zA+gQ+BUwMBgV4ChAuCLpI8hWkcOQNHNBKBIXEBCAYGBwoFMgYCDBgUBAITE?=
 =?us-ascii?q?k0GHQISDAoGFg5CEhkMDwMSAxEBBwILEggVLAgDAgMIAwIDIwsCAxcJBwoDH?=
 =?us-ascii?q?QgKHBIQFAIEEx4LCAMZHywJAgQOA0MICwoDEQQDExgLFggQBAYDCS8NKAsDB?=
 =?us-ascii?q?Q8NAQYDBgIFBQEDIAMUAwUnBwMhBwsmDQ0EHAcdAwMFJgMCAhsHAgIDAgYXB?=
 =?us-ascii?q?gICGVYKJg0IBAgEGAQdJBAFAgcxBQQvAh4EBQYRCQIWAgYEBQIEBBYCAhIIA?=
 =?us-ascii?q?ggnGwcWNhkBBV0GCwkhFgYpCwYFBhYDI0wnBUgPKTU2PCMMIRsKYQUEHwGZS?=
 =?us-ascii?q?1IZBgKBNwLDdQcpgyiLHpUQFahclmsgjQ2ZXQIEAgQFAg4BAQaBeIF+cIM4T?=
 =?us-ascii?q?gECAQINAQICAwECAQEBCQEBAQGOKQ0JFYM7gT6DVoVKQjMCOQIGAQoBAQMJj?=
 =?us-ascii?q?n0BAQ?=
IronPort-PHdr: A9a23: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
 goGMcNTifHAsQkiPrC6J0GT1dD8Gg6Q
IronPort-Data: A9a23:ptOJFq90P59Lw+ZFnYz0DrUDinuTJUtcMsCJ2f8bNWPcYEJGY0x3n
 2sYCD3SaKnYM2OnfIogaYS28RxU6pHdyoJnSApq+HxEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHvymYAL9EngZqTVMEU/Nsjo+3b9g6mJUqYLhWVnV5
 4qp+5S31GKNglaYDEpEs8pvlzs05JweiBtA1rDpTa0jUPf2zhH5PbpHTU2DByOQrrp8QoZWc
 93+IISRpQs1yfuC5uSNyd4XemVSKlLb0JPnZnB+A8BOiTAazsA+PzpS2Pc0MS9qZzu1c99Zy
 fATl5G6RxsVN5L1mrkUdisIVD9FMvgTkFPHCSDXXc274nD8KyKp798zSUY8MMsf5/p9BnxI+
 boAMjcRYxufhuWwhrWmVu1rgcdlJ87uVG8dki04i2iBUrB/HNaaGfSiCdxwhF/cguhMEOzTY
 ttfbTdhZQnabjVJN0seFJc52uyvgxETdhUE8ALN9PNtuQA/yiRq8J3dPPT/R+eRBpULwUi0j
 2SX7Vj2V0Ry2Nu3kmPeqS3EavX0tSfyR4sWEJWq9/tgmlTVx2oJCRRQW0HTifK+gUW/c8lOL
 lQdvCsot6k7skKxJuQRRDW9qX+A+xMbQ9BfCbRnsFjXm+zT/hqTAXUCQnhZcts6ucQqRDssk
 FiUg9fuAj8pu7qQIZ6AyluKhTKXZwoYJ2EeWSY7dAlY6vzR8MYttR2aG76PD5WJptHyHDjxx
 RWDoy4/m6gfgKY3O0OTrQyvb9WE9sehc+Il2unEdj/+tVgmNOZJc6TttwKGvK4owJOxFAHpg
 ZQSpySJxMEjZX1nvACQSuEMGtlFDN6paGe0bbJHO5Qg8S+x9mTLQGy9yDR3JUMsP8EcczDzO
 RKL4FkAophOIHGtcKl7JZqrDNgnxrThEtKjUe3Iat1JYd56cwrvEMBSiay4gD6FfKsEyP1X1
 XKnnSCEUSty5UNPkWLeegvl+eV3rh3SPEuKLXwB8zyp0KCFeFmeQqofPV2FY4gRtf3Z/V2Io
 4gEbZDRkH2ztdEShAGHr+b/ynhafRAG6Wze8JA/mhOrflc9SThxVKW5LU0JItw7x/UM/gs3w
 p1NchQBkwGg7ZE2AQCLYWpkc7ThQd50qmgjOjYlIVev3RAejXWHvc8im28MVeB/roRLlKYqJ
 9FcIpnoKqkRFlzvpmpMBbGg/N0KXEn63mqmYnv1CBBhJcIIb1KSoLfMIFCwnBTi+wLs6KPSV
 ZX7iliEKXfCLiw+ZPvrhAWHlQ7u7SFDwrksDyMl4LB7IS3RzWSjEASp5tdfHi3GAUyrKuKy2
 1nEDBEGi/PKpoNpotDFibrd9tWvHvd3Ak9dWWLc6O/uZyXd+2Oix65GUfqJJGuFCDuso/r9P
 +gFnevhNPAnnUpRt9YuGbhcy69jtcDkoKVXz1g5EXiSNwarB7psL2Oox85KsqERlLZVtRHvA
 xCJ98VTJbCOfsjiFQdJdgYia+2C09ASmyXTtK9tfB2iv3AoprfeCBdcJRiBjiBZPYBZCoJ9z
 LdzotMS5iy+lgEuboSMgBdS+jneNXcHSagm6swXDYK32AomzlZOPc7VBiPsvMzdRuh2ahBvD
 hXJwa3IivJb21bIdGc1GT7Vx+1BiJ8SuRdMilgfO1COndmDjfgyhUUD/TMyRwVT7xNGz+MsZ
 TcyZxcpff2Dr2VymcxOf2GwAAUeVhCU/0rGzVFWxmDUSk+fUHPAcT8mMuGX8UFFqG9RImpB8
 LeDxDq3WDrmZp2gjC47WEogpvv7R9Nrr1CawZr2WcOYA5M9fDzpxLe0YnYFoAfmBsV3g1Dbo
 e5t/6B7bqiibXwcpKgyCo+707UMSU/bezUSG605pK5ZT3vBfDyS2CSVLx/jd85IIcvM+xDqB
 sFrIPVJSBnjhj2FqSoWBPJXLrJ59BLzCAHupl82ya86X7qjQv5Bna/qrnG7qEV2BtJknIA6N
 5/bcC+EHiqIn3xIlmTRrc5CfG2lfd0DYw661+ewmAnMP4xWq/liKCnezZPt10h58iM+l/5Xg
 O8HT6nb0+V+zIMqlIzpekmGLxvhMsv9DYxk7yjq2+mjrrrz3QPmsQ4Jo0XiOEJdOr55txGbU
 1iSmIaf4X4pd4ran4wUd1dt2kWJCQiPsDJrD//K
IronPort-HdrOrdr: A9a23:bJmB5KxeT5axWyGxRbuUKrPxkeskLtp133Aq2lEZdPULSKGlfp
 GV9sjziyWetN9IYgBapTiBUJPwIk80hqQFm7X5Wo3SETUO2VHYZr2KiLGP/9SOIVyYygcw78
 Zdmu1FeaXN5DtB/IrHCWuDYrAdKbC8mcjG69s2jU0dND2CAJsQjTuRfzzrdnGeMzM2YKbReq
 D92uN34x6bPVgHZMWyAXcIG8LZocfQqZ7gaRkaQzY69Qinl1qTmfDHOind+i1bfyJEwL8k/2
 SAuRf+/L+fv/ayzQKZ/3PP7q5RhMDqxrJ4dY2xY4kuW3XRYzSTFcZcso65zXUISSaUmRIXee
 z30lQd1gJImjTsly+O0F3QMkLboUsTAjfZuCOlaD3Y0IPErXsBerR8bY41SGqn12Mw+N57y6
 5FxGSfqt5eCg7Bhj3045zSWwhtjVfcmwtqrQc/tQ0pbWIlUs4mkWXfxjImLL4QWCbhrIw3Gu
 hnC8/RoP5QbFOBdnjc+m1i2salUHg/FgqPBhFqgL3f7xFG2HRii0cIzs0WmXkNsJo7Vplf/u
 zBdqBljqtHQMMaZb90QO0BXcy0AGrQRg+kChPbHX33UKUcf37doZ/+57s4oOmsZZwT1ZM33I
 /MVVtJ3FRCD34Gyff+qaGj3iq9MFlVBw6du/22z6IJyYHBeA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,297,1647298800"; 
   d="scan'208";a="40809122"
X-MGA-submission: =?us-ascii?q?MDEtvq3eJHPML1g/pj3+PYh3NCpqf7B0I825jM?=
 =?us-ascii?q?MSdsjIoYvSvPsCvFiNet8EhWk8nwkzf2wGKpYSupZksTzT0OxtCXucFe?=
 =?us-ascii?q?XhoaW4RjW412KlMXk8G6SFR58mYjWl+1NDJ0FCJkqep4PMlP9TyE8NTA?=
 =?us-ascii?q?FAUrNbMxdZFvvEoy6pDtqIlQ=3D=3D?=
Received: from mail-eopbgr150129.outbound.protection.outlook.com (HELO EUR01-DB5-obe.outbound.protection.outlook.com) ([40.107.15.129])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 18:25:05 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhpbFJqAPQL9A/lTMYuSHXk5TWPEgc44ck8HYLe38MPlrmVOJI+v1qwLtXqVKm20JiPmrM9ZTjDfXoA6/wFfQJVE0fca+sx6W6v6PlqJ5/fnGRgryELmrTMTPvLWsbhyVq8HdIzlEfhBm3Ao36OquKHD2wAgAPFxFIUIdmVfi3G133z91q5D6whKPcF2junq96kOCfaP3QtVEYKKMl6lRzlflDdPuqv9S1t+RvlNqGBcVAjGXAZzYmVzSnNU1x5YpWjWmiVyJ5fZbSDLOH68b4P77JbyCvAoYAtm+51xSbJt8ck57a75OQ94bbX5Rmg0cML3zvGJV6s5rgm5/1Vusw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jfy0QYvhoMrP8bjy0n6chaum6Z9q5DMBv7clHK8CdIE=;
 b=cMIFfVdz8usTUSo5a0f/LC0ELy/l9o85pULLv+OVUP2xVguki/A9yZkiVgnLO+ANLwszUOLbDs2/781U5tHVW+vB6IMOae4vCctqFVcsy4RL7yIK7On4FAepHeJfkp32OluOsJQdfvyoqYqhi+LHhOEX7GbdUzJsU15BRJEdSVFoTjLYHcLon3ixq+LWC6V0g1F6a4meZd7y14kbkQ9Juu5R3M0ep4FUioP00dTeH1fjF84J1lInOaDKs6n1637mYb+5M6Z0YMO1GNBYDuIqlnrGWC/y8c4cFi1QmrZqbDXAAs2lRz7SI6ymj0myxoUuez5817iL+y/TWkJIJhqGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netatmo.com; dmarc=pass action=none header.from=netatmo.com;
 dkim=pass header.d=netatmo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netatmo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jfy0QYvhoMrP8bjy0n6chaum6Z9q5DMBv7clHK8CdIE=;
 b=GQdo/q7jOProfJzspF59Je1I7c7lqs0W00PsSoTqD9p+gZrXpVlOHdIRigrNWhxgymB61A6itqRyAc9N6NJlQOfUwjsnX5N/OouqHPoML1/C7r7VS9f3hI0bubK1WGNVEo+UlkxYW2SSCDs/HhyQ5hRFWep00cCItagtHutsps0=
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com (2603:10a6:20b:34e::15)
 by DB7PR03MB4811.eurprd03.prod.outlook.com (2603:10a6:10:30::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Mon, 13 Jun
 2022 16:25:03 +0000
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::8175:20e5:60ec:b87d]) by AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::8175:20e5:60ec:b87d%7]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 16:25:03 +0000
From: =?Windows-1252?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
To: Markus Elfring <Markus.Elfring@web.de>, Julia Lawall
	<julia.lawall@inria.fr>, "cocci@inria.fr" <cocci@inria.fr>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	Nicolas Palix <nicolas.palix@imag.fr>
Thread-Topic: [PATCH v3] coccinelle: Extend address test from ifaddr to every
 test expression
Thread-Index: AQHYfLsCmi/5kwNDAkqS6gBbhAOymK1I5+MAgASimqE=
Date: Mon, 13 Jun 2022 16:25:03 +0000
Message-ID:
 <AS8PR03MB76031920B2F9E7A0A7A6A97893AB9@AS8PR03MB7603.eurprd03.prod.outlook.com>
References:
 <AS8PR03MB76033CF2848D03651D6E189093A69@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <a8c3479c-c8f1-da57-23fe-657c2f13872b@web.de>
In-Reply-To: <a8c3479c-c8f1-da57-23fe-657c2f13872b@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ac5bfe3-49e3-4200-356d-08da4d594522
x-ms-traffictypediagnostic: DB7PR03MB4811:EE_
x-microsoft-antispam-prvs:
 <DB7PR03MB481121C0DC5ECA53F12A611C93AB9@DB7PR03MB4811.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /3mABX4G3TKEV8v9F6L1r/FYbHAA7sqJVe73tQkUgNd8qTnxrKgVwKFX0XAgz/cXSqd1DqR4kG0fpGRA8xQ7E3FxOsm0OzR8It4DrvO+p0ox7/pagmvCP16J+/G/N6nOowzoCss2mWNhR3Lhrd+lFJfdQ22urzXneUDg9giB7ZMsZVNCDyOjHr52ntlbKH9tmjnQk5eCMyWlTa9gCrBBIESezmHxKRa4szcmXuD2QI+oNKVLai6CaOumGogm/h1BeugQS9sRWxw4X4Vyt9/z4YlxzQA4RsL/Gv1Xo+LmISIaAnSKN9HD+lfiaTwO50KmeWhMX9J7BvjDZkrv4qQy3C2DSFUauYd7+C236ytoAfmwsYDw27Cm8DmC3YOr/Ynx5l1f1kzUj2a7WVU/2bugEf+RtQiJef/TTCyS4bfEIElv5OwUnWQaK1KRwcn5WvMQjZlsI5LynmMI68eMAgs62ffTqDuglX0XovrEn+TTZw8Cwi9G7zIR3Ij8gjVrKWIk7dsjHCpSASKGI7erOXyn3ak1OJliwJhNx/WA5Exiatphj62YQWo6oVCUVSqKrshZK0VhRVKONestXebce0D0yvheHLXuEZUJWeNsnwRWL18ZKWtLpPFvdY5QCkgxilHeWSW/t9EK7RpKWv/Ped0CH0TLo07XH5bhA9Vixb1Urg/4xc/1xo7eYDh87vDMY2F0FBdo8CfBKab/KRC1wmUHJQ3UYnXqaLgdkrLzk+pdTlymNQh1XTsQwpUj6h1vtJvgZAekgojlt0K8Yt0aOVx5SyOyPT6Vp21lZlAvfCTzho4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7603.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(136003)(366004)(39850400004)(55236004)(7696005)(83380400001)(52536014)(26005)(9686003)(8936002)(6506007)(186003)(41300700001)(76116006)(508600001)(66446008)(64756008)(66556008)(66476007)(55016003)(86362001)(71200400001)(122000001)(66946007)(2906002)(54906003)(316002)(38100700002)(966005)(8676002)(110136005)(4326008)(33656002)(5660300002)(91956017)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?RGOv64eIwciqbLcButBrwdlqmT5ygkOGKPO+X3G5W4by8NrkJX6Kl3/p?=
 =?Windows-1252?Q?N7L/61Bwnkgw88LPpeaHuKV1/MUUN2pCVswjkUYfnlGmkoXk5LrN1Xv4?=
 =?Windows-1252?Q?x5JLVDeLRQt4/q/KydJW4Rx4PAp7CV61FX4Kcd8jyuinhrZo6GumtOXN?=
 =?Windows-1252?Q?P4I32t6uMY+ANvVxfRYoSYYvegANOVB2dxzhWc8rR0Uk6SQHfVgOu5Qc?=
 =?Windows-1252?Q?UQ7VpI4w7i/xPfXQaBhC7KcYE3wMvwO/kxar2jMhYdSB2JAZc/C55/+s?=
 =?Windows-1252?Q?KLzmpWcVRlo1tSpTYHwTwiIWa3JuCqZX/PvrNQUQFzv/I/4p8EQoFp1O?=
 =?Windows-1252?Q?z03w7Qb9ywI+x2pnA6j+MIIyPH7apn9Rwz+pSywknWGWsRyfsNjlDTvF?=
 =?Windows-1252?Q?3z9A3pnUI1xXrf+t0jfmneFXNrHGreNQygtzQY+ooZQZJQnbTOuGdc7x?=
 =?Windows-1252?Q?GP3KK3n2FTIm+h2YqxbokkupUwnEFlt5j5VEBU+igp7h/vEdAyU98aTg?=
 =?Windows-1252?Q?ibtqp0bWyqu5o8w6iqew+IreVF+8wW9lYT+bmagSo9N6sT776x4CLQNs?=
 =?Windows-1252?Q?UHOh8Cm6tG6AHO83+eV00z4Bt+C4cL/byMnzVgyF56+i2c6TGxpmBZ+W?=
 =?Windows-1252?Q?ct+IehqF3FgZotBkdIguwnSoEDb1tO9xXx8nl4fhOqTOkJmx557wOBxy?=
 =?Windows-1252?Q?QeBWe7S3dtkGmheRBk7Po/4qXuUI1xxJgyZlfIksiW0z+f2Uqv8pY5vq?=
 =?Windows-1252?Q?TxNEAYra7eO8NjBWeNowlx3ma3e1Tu8wqsWwYk9oeNo5MgbrJ/gkwarr?=
 =?Windows-1252?Q?TSa7RzRitAocSevSm/fzEhAq32guiw/1dM+fYFWAUBx7YX+x1S3mtX3g?=
 =?Windows-1252?Q?dO5iEX5HFiT/MCxYM9VXLqj24N0T27LBoSQt8JU5QxcxarNlJUYu4jaJ?=
 =?Windows-1252?Q?Q1S8KJ+wi0K5oZMhbElRxNR/5g+OuI3H6YYKS5eLidbjZwg+qgYNwBNJ?=
 =?Windows-1252?Q?25hrgfDSMJvJpNlsSSHwiGhCCvZhcmtTIBh2hxC6DlwBh6482Yr1Ps/i?=
 =?Windows-1252?Q?K84usQOLgMJHNNqutIcSRLwL05oYxi6FkriKWppMCPUSDWSXLwf0m52I?=
 =?Windows-1252?Q?rcPK2HRI7AzakEli1EcJm6ozjgd+iS/CUqJftqwEqyJ/ZGI0QHDIZ2cz?=
 =?Windows-1252?Q?YFdTKdlg7xy1g15WZnX91pYTFPEKceJU1DY0T37OmUFph+6P1Jb+SkxP?=
 =?Windows-1252?Q?MER4YgHer78YsiVNad39UdNUx16591Z0kVECTxMEExe3GEEDYkKUFMVe?=
 =?Windows-1252?Q?5Ri2ff5PKQubcKFCs2RdYh0DJM2ObRvBBD39r1GFOxloJnlCBuJaBvtL?=
 =?Windows-1252?Q?ajhTtYMFpE6gpmcY9pt9vPruu9h3Fh1cNRoCQXcQDj0AlX7A4A4WxfG4?=
 =?Windows-1252?Q?2NgDDPYnncDdtpAXOWBrTlEHY/QkAyWESzz3CZf0ChmMzyVrt6EBlQ/z?=
 =?Windows-1252?Q?Xj5yhNzaiT8xJDgK5NILehyFIPgsG/civVEXLXdP/J0bjnZdRkw41IC7?=
 =?Windows-1252?Q?8f8j+wvjceHjh6bOb83IByuPq+XWER/lv0i5Xu+3wk1s+GKFySlUzXXt?=
 =?Windows-1252?Q?QbNpo6REt+aMbt2fBic7suJlMS0ozBBBz5sAibreQ6o0wAG+q2d5LUJg?=
 =?Windows-1252?Q?/f7QTYvkOgaq2BbJS5Ut6bzHZ8Jw97YVbLz6uobShxmtCvYArmI21xDU?=
 =?Windows-1252?Q?BH2Orpzak0JhZAA9e5gbf/R85kfWHp+z9SJMcafuiQ07sXiYa9fMBbd7?=
 =?Windows-1252?Q?sP9dytgUx46ZdEnR/RAkFUunCHKI1OChngi9gLiE/unvotUdP5jpJnDy?=
 =?Windows-1252?Q?c5dRtcNRkHY3oQ+JqPzcuPnguRwkwkoEORg=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netatmo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7603.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac5bfe3-49e3-4200-356d-08da4d594522
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 16:25:03.3488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4528446a-2666-441f-95cd-cc2cbd9f2c49
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tz8Jc9MxPEXCzJcMsPDqjPT5lCwzJYBH2do4vLC3f+vUpeUwCqRyPCqDdrxobe/s7gqA5tXbSlMBFaULEQWlREOUZ+R+kApd58rkq9flolU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4811
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v3] coccinelle: Extend address test from ifaddr
 to every test expression
Reply-To: =?Windows-1252?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
X-Loop: cocci@inria.fr
X-Sequence: 441
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/AS8PR03MB76031920B2F9E7A0A7A6A97893AB9%40AS8PR03MB7603.eurprd03.prod.outlook.com>

> A)=0A=
> I would like to point out once more that no questionable places were mark=
ed=0A=
> by the software =93Coccinelle 1.1.1=94 (OCaml 4.14.0) in the following so=
urce code.=0A=
> https://lore.kernel.org/cocci/da86bc36-36af-7bd7-6bee-861e160ba6a4@web.de=
/=0A=
> https://sympa.inria.fr/sympa/arc/cocci/2022-06/msg00017.html=0A=
>=0A=
>=0A=
> void check(void)=0A=
> {=0A=
> int s =3D 1;=0A=
> bool t =3D (&s);=0A=
> }=0A=
>=0A=
>=0A=
> Thus I propose to add another case distinction by the means of=0A=
> a SmPL disjunction.=0A=
>=0A=
>=0A=
> *\( &x || ... \| &x \)=0A=
>=0A=
=0A=
Unfortunately this creates false positives as it matches address-of=0A=
operator outside of test expressions such as in this code:=0A=
=0A=
void foo(int *a);=0A=
=0A=
void call_foo(int a)=0A=
{=0A=
  foo(&a);=0A=
}=0A=
=0A=
=0A=
> B)=0A=
> I imagine that generated diff output should be wrapped by a source block=
=0A=
> for the operation mode =93org=94.=0A=
> https://orgmode.org/quickstart.html#blocks=0A=
=0A=
This patch does not change the "org" mode output, it only changes the=0A=
matching part. Anyway, I am not sure that coccilib supports blocks, I=0A=
did not find any reference to block in the code [1]. Do you have an=0A=
example were it is used?=0A=
=0A=
[1]: https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/master/python/coc=
cilib/org.py=0A=
=0A=
=0A=
Thank you,=0A=
J=E9r=E9my=
