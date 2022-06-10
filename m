Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103FAC433EF
	for <cocci@archiver.kernel.org>; Fri, 10 Jun 2022 12:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:content-transfer-encoding:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=H4Zeq8/Dss8EG/55Ksao4CO0zVRUd4uLszKWwnFXYqc=;
  b=cnZiDjjUf1AL0FhbFEbeAkZgpyolUx1U4mYe+s4K6btS0j8bxAnoNfMt
   pNMlTJSWnuwOkydsCST8B5GTw5a/clthL9GCHzLfhzve5rNmGEXaSjz+R
   Cxhg/9sKo9IDpiwYcotMcVgdzftremNUhWCWJbKkawnfTqwM4wZk+3bzP
   A=;
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
X-IronPort-AV: E=Sophos;i="5.91,290,1647298800"; 
   d="scan'208";a="40417994"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jun 2022 14:30:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0FF2BE0152; Fri, 10 Jun 2022 14:30:22 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DB4A6E0038
	for <cocci@sympa.inria.fr>; Fri, 10 Jun 2022 13:18:30 +0200 (CEST)
IronPort-SDR: Vo14aaVZacqii4dF9EZgFHDO75lSv7F1yV1W1TPaxbapIuDFyWguebY76CUDtqBxCfsR/P+8Df
 /M/iLLPLXQW7D/EGbr2PByHQH17amnHITq3FH8K7L3vX8E2thzdFlsIEPZeG0jOH3Ir9gTJ32j
 Zp2d8Np1eUof/zU2GODUgyuQ/FL5yJBmMoA46wfL+L8mAbkNkplFnjM1ShdSAS7BHRqdZJoStP
 KbyiktTqWgV1vrrAXhxfhuju4DdkLtBfrZ7fSpa9t51BNrRZ/HKr9MqM6gMS+ecuaCWxgu8n7I
 n+rbPKQrLTMCxOtw+ahHlD4H
X-IPAS-Result: =?us-ascii?q?A0ASAAA+J6Nih2gWayhaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYFRUn9ZKgMHCESIGgOFMYUMn2yBfAsBAwELAkIEAQGFAgKFRx8GA?=
 =?us-ascii?q?QQxCA4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBAQsNCQUIC?=
 =?us-ascii?q?gcOEAU8ZIEIAYFOAYEwIwsDMQ2CNSkBg2YQBhUZAQE3AREBgQAnBAENBQgTB?=
 =?us-ascii?q?4JbgxkEAp9sAYE+AgKLFYEBMoEBgggBAQYEBIddCYE9AYpOhmyBWHmBPm6BD?=
 =?us-ascii?q?4M3hAuCLpYGghg6A0c0EoEhcQEIBgYHCgUyBgIMGBQEAhMSTQYdAhIMCgYWD?=
 =?us-ascii?q?kISGQwPAxIDEQEHAgsSCBUsCAMCAwgDAgMjCwIDFwkHCgMdCAocEhAUAgQTH?=
 =?us-ascii?q?gsIAxkfLAkCBA4DRQgLCgMRBAMTGAsWCBAEBgMJLw0oCwMFDw8BBgMGAgUFA?=
 =?us-ascii?q?QMgAxQDBScHAyEHCyYNDQQjHQMDBSYDAgIbBwICAwIGFwYCAhlWCiYNCAQIB?=
 =?us-ascii?q?BgEHSQQBQIHMQUELwIeBAUGEQkCFgIGBAUCBAQWAgISCAIIJxsHFjYZAQVdB?=
 =?us-ascii?q?gsJIRYGKREFBhYDI0onBUgPKTU2PC8hHAosBQQfmStxAYEOo1OBM58ZBymDK?=
 =?us-ascii?q?KAuFahblmogpmoCBAIEBQIOAQEGgWIBghNwgzhOAQIBAg0BAgIDAQIBAQEJA?=
 =?us-ascii?q?QEBAY4dGYNZil5CMzsCBgEKAQEDCY5cAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:JmLxk652fc3Fbon/wgPXwUmBI+orL9Y04lQ7vn2ZFiY5TiXIra
 qTdaogviMc0AxhIU3Jmbi7Scq9qADnhOZICO4qTPyftWjdySOVxeRZgbcKrAeQfBEWmtQ96U
 4CSdk1NDSTNykdsS+S2mDRfLgdKbK8gcKVbJLlvhNQpHZRGsRdBmlCajqzIwlTfk1rFJA5HJ
 2T6o5svDy7Y0kaacy9Gz0sQ/XDj8ejruOrXTc2QzocrCWehzKh77D3VzKC2A0Fbj9JybA+tU
 DYjg3C4Lm5uf3T8G6S64aT1eUZpDLS8KoCOCW+sLlXFtwqsHfrWG1VYczCgNnympDr1L9lqq
 iJn/5qBbUJ15qYRBDOnfKq4Xis7N9m0Q6f9beV7EGT3PDRVXY0DdFMipledQac4008vMtk2K
 YOxG6BsYFLZCmw6xgVyuK4Ii2CrHDE1UbKUNRj/0B3QM8bcvtcvIYf9ERaHNMJGz/78pkuFK
 1rANvH7PhbfFuGZzSB11MfieCETzA2BFOLU0ICssua33xfm2141VIRwIgakm0b/JwwRpFY76
 DPM7hulrtJUsgKBJgNctspUI+yECjAUBjMOGWdLRDuE7wGIWvEr9rt7LA89IiRCe41JVsJ6e
 f8uX9jxBAPkhjVeLKzNbVwg2HwfFk=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,290,1647298800"; 
   d="scan'208";a="40403124"
X-MGA-submission: =?us-ascii?q?MDHpxTmZlh+XoaMLGfi49ruwpLOY3Fkfr80EW9?=
 =?us-ascii?q?Ljdo2DgmiI4UwdgwtVyfazqZGqN5GD1bgLKtnZB4E/3JaWBhdidg89Ts?=
 =?us-ascii?q?Rb73EXbBgiZYCvbYINEvyMYiEn2QndsPW6DgziqDFimdJ+UpriXIIvMO?=
 =?us-ascii?q?88sdHyLgve7Tb13c4B9vqf0Q=3D=3D?=
Received: from mail-am6eur05on2104.outbound.protection.outlook.com (HELO EUR05-AM6-obe.outbound.protection.outlook.com) ([40.107.22.104])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 13:18:30 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klS78yRuO1KV+ORK2Ve0l3Xdk/8S7qLnug6Zs/PR4LtSKnjPbkTqjqwuh+GEyKZ/cBj5PaVlBv9IanQf//40AVHhi26veJjbyVF9vTozackmAyNWS8pyVTxICs6WtGawdJTRdH+875i4O+DA4lHQiMaje8XfLCiyyWcvMTL3O5DlfOQKG3VAssnbX8o0x5bCNnPrWa80fn+JwzzYeZoPWwaDOefooW6xKiKPetgGmJkEFtA778Z8XUJNHSmDxHCdsBQ162q0e1qGlx3Kei7kn6kB5qVCIAZVbIES5VV7sTR/jmEXrcGIJsjp13QWAem2HcaWyADRn7EaXgLn0uLfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4Zeq8/Dss8EG/55Ksao4CO0zVRUd4uLszKWwnFXYqc=;
 b=DUXF7l7wgE3GJQDPz0Xo1NgLQK/cdBWGnI7MFp/YhsSsPAfLSW7WCRuSr3zDPjgVtO79Je7Awl5ycJahLgP172MpUAEdphSt4z4nbQKdZhi1T+yYHhtOHvl5vkMLrOtkxZ06WBg0YEkr4PY5hHm+7WXvle+1ZwdRz1knmTC8Wl46rzw4145dOgJgOhhvuNq+KdhZvQzsbAFzuB+89tLJ/4Emcoawqo7of61XZ/HKGX4ZOoN0BUWT+GENJzKJflpFc3a4FCqdwwIUfwxKBDwDhmzWp+gyVFIqloWE3txA3fdG4QvfnIgM6Wdju4FVZn+p8ZUvoTqpZsycCSmIZP1k8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netatmo.com; dmarc=pass action=none header.from=netatmo.com;
 dkim=pass header.d=netatmo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netatmo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4Zeq8/Dss8EG/55Ksao4CO0zVRUd4uLszKWwnFXYqc=;
 b=oBP/nLdJ0+mlGsrXvtE+wZWFbFYJoyLlcGFnfbnW2Ld/bWOzBO4m/SW5ujmL6X6GNW3EsY+T2dFlDMoIg/fcM4ttm4moUfDOOLA+Cjv3GwkCO/2zjVId6oPfBP1wFa2FRBz4JjmL0F87eqW0/N/aFUa/b6ok0+2p4QxNaDfMqho=
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com (2603:10a6:20b:34e::15)
 by DB6PR0301MB2437.eurprd03.prod.outlook.com (2603:10a6:4:59::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 11:18:28 +0000
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::8175:20e5:60ec:b87d]) by AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::8175:20e5:60ec:b87d%7]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 11:18:27 +0000
From: =?iso-8859-1?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
To: Julia Lawall <julia.lawall@inria.fr>, Nicolas Palix
	<nicolas.palix@imag.fr>, Markus Elfring <Markus.Elfring@web.de>
CC: "cocci@inria.fr" <cocci@inria.fr>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Thread-Topic: [PATCH v3] coccinelle: Extend address test from ifaddr to every
 test expression
Thread-Index: AQHYfLsCmi/5kwNDAkqS6gBbhAOymA==
Date: Fri, 10 Jun 2022 11:18:27 +0000
Message-ID:
 <AS8PR03MB76033CF2848D03651D6E189093A69@AS8PR03MB7603.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8af47acf-ff8a-41cb-7ed6-08da4ad2f154
x-ms-traffictypediagnostic: DB6PR0301MB2437:EE_
x-microsoft-antispam-prvs:
 <DB6PR0301MB2437665673E745BC196FC92E93A69@DB6PR0301MB2437.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7SXmzd4CP7DVpSM2A99KNrW8e1Q1h4tDM+HjoojGVyUYWeVawDmPVtatS0yNeznmIX2TGWtbIP1jd84p/KaY9ORTYWkodjeXKZ7kKrxzKdSzaikc+sGwNwXXWeJ10wNyLsj4aLhMnNzlkfc8wxtjq80nG/iZyxSpkKPVgiDcYN+tWje8D/I2Y9GdR2exCTtF1ji5Gi8Xhb/q3s7NgfImlqEgmr3LgZmC2l/LasY5reaQgrdLUQX1zJYob3zidtHAoe0sCVK0+FE3KEPhCiMvs/G1IOSftdD/o7dgGHI/y6+fXm+14plCORzGjHjYwYRDAJ0mr7VPU0jOH57dqNiNDwVm3BT1efJwDHmQDr4g4N/dCHk185+GGR/EMcqc7hWXYJ8dEnz9HAUGn/x3S5II4bIFDCstkcEmJZU2NCyzvrEDGNLaG+tgftNfZnxb6JHi3AnhbnUDhMP8QOqcZBk4KmkEJUG0CXxlTXJk7M4CftVcFeYbJMnJHn+LxUjxLWLmm7g2IZZDqgTo42FfbQMtz5rp3ssH82A1juE5ncp5/0TjPJ4VHnwpklNsksiI08NCry3P9mh6rbX8DaneUXeKiWim34d3IVkfEyRIYSjr5o3L92v+N2+A6xc1s/0eORLrfVmS7OCjAf5eYBPzD4kbOZbt6Dlaw2aDoNYz4XK1gxTLXYvn2sSfr4hGEiWb69qrRxpQw19meiihvWiMVK90KA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7603.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39850400004)(346002)(366004)(396003)(136003)(66946007)(9686003)(66556008)(66446008)(8676002)(91956017)(64756008)(2906002)(122000001)(4326008)(38070700005)(66476007)(41300700001)(26005)(54906003)(110136005)(38100700002)(7696005)(6506007)(55236004)(55016003)(71200400001)(508600001)(8936002)(83380400001)(52536014)(186003)(33656002)(76116006)(5660300002)(316002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NKFVfyiE1Iw4dJYiLHkbS97mXIA/8p20G5EZFuBGx8p8atFJKK9+mCbTdE?=
 =?iso-8859-1?Q?x9LzHyUK0Z6XHiG4rqU7SFFCBpjX1XjLnVOFb1+6MerrupvRAPnflYgKfr?=
 =?iso-8859-1?Q?JF5qH4D/IwsB52T4vrj4T7XJIwGOjq1omyVPcfgH+h5YfqWBD4/KplD9GY?=
 =?iso-8859-1?Q?bMHs9ihlY800VEK5LVqtqBNnbpy520VFVqoZSyDAHm2tzfriG+EA5Om5Kv?=
 =?iso-8859-1?Q?LWMxz9nT1xTk8ty54psKX/z1YZB7r2LqKw0juL4cYMfpaY13rBVHi+QZB5?=
 =?iso-8859-1?Q?E1L5gw7KffaIivPikrmAr7hcIrZ4Fnd0rjt4IDArOUBqKk6rfxMAX17z2O?=
 =?iso-8859-1?Q?rOeiGNaEDCjtephpphu76/AN3w7YtZ5NJqzC3mb/xytuAgV99TdPaBHgCx?=
 =?iso-8859-1?Q?sEl6VHnZpz6z3njXjyZESRgpK2uFEYzHe5lBNEVBnEqkuBTRjBzVkuHSIp?=
 =?iso-8859-1?Q?YKb7EfvQLih0PlBF9J2YspYjZFfA17ug17e2jEHIKPYIx6wY8eOIiEILrr?=
 =?iso-8859-1?Q?Z9hkdl8hdYTvv+9f3n4O/HEDKnpyKySkdMFM9GJIk1Dq9jXxQo8RmSpqbe?=
 =?iso-8859-1?Q?7sGS934d1uVUorKQG5aGSriUZiLlul2L9vHwb35u7THZ7atHTif9+ERSrJ?=
 =?iso-8859-1?Q?w2RUSDh9SE9xN0lAGhuCt6T4NjPebFjnYOKcOg4cOJFhuNiOSxTzHWn50B?=
 =?iso-8859-1?Q?Rd24R/cr42YlsB4RTIkmMpX+BGFbKcEi3nG4xXGWI240izyvAsprAxBJWk?=
 =?iso-8859-1?Q?eA3SXAvt3YgorELThku4Go6wzjWare49NDjcfAGxUZKCUIskK7n2R0G+rB?=
 =?iso-8859-1?Q?z5624SzuaDP028qIa9CCtsIw8ydfbwQ2AfCTSZ0CSLFYGtWQorcKemdVdO?=
 =?iso-8859-1?Q?kONx/LUWmmhiyY5omjlUMP5d7v7nr6uNOusKai8Mta6gw5ZcYzV/UwrwWs?=
 =?iso-8859-1?Q?WwrjjoK4FBSL2O82JXInDekpAttsrjB1HWC04+1NnCTppqPDXy/+EN3SRb?=
 =?iso-8859-1?Q?Q6WfePCb1bWpUpYnRrSeIGBuysJOqD1nNy479YFc4o1avqyQUu6fTHfJxN?=
 =?iso-8859-1?Q?s4dJGEX32FyttXMHDx/SpllCnGxACuSVc9Y0DC5U1jQQj2f4d5ZUTIS4Dl?=
 =?iso-8859-1?Q?eAw1vrcP2KekmtfCu5LhepdpJjc71pyqkF+9o3hkpgvl1NMHgtfnxloKmF?=
 =?iso-8859-1?Q?aYNw64QXSf+Yz2q8Uo/IIdsdtK1mJgACon6N+KhfOHRzjFQC6Gdvp6ZE3n?=
 =?iso-8859-1?Q?BGd+w+OFKtXAltVCnZJKVzF675xMFCi1oaWM31lrvpbgdI686dn1BSF76M?=
 =?iso-8859-1?Q?sWjigMLgebA0pAyCsLkdeeeFehmygBGLruNv3OgHLyZjlNrl6x/p2LtkuT?=
 =?iso-8859-1?Q?7KQaBLBOY9f9f88jtb7bqxE3i3hz0IY8b1mROANM5Qy1jtz7G7XGIldTCa?=
 =?iso-8859-1?Q?VBp8DgczKtH/HAZ0IlYMeqfRTnKiKbT/CONasELVBbYShi4Arg1NWEZQ+I?=
 =?iso-8859-1?Q?r3IKzAki6prk+8nSu3SoSNnfY2YdWtYPBTsTtSb3TT7LHNnXZtcZdMWR2d?=
 =?iso-8859-1?Q?NcPoNNBSCmWXkqr+lbK3UcEUzGPRiFbTs6ucF6BLpUffylhIzjeFtO1N9Q?=
 =?iso-8859-1?Q?HA5twX6r1cm/zH2Tkx7REP0gJrsnRonxM89R4zSVYEe0H6JMgut6wSIrVF?=
 =?iso-8859-1?Q?OFU3Z9ePWKUTw1ye+tIpzIgRlj0syAtrNicRYC0aoWYQatSDukDcUXMN+B?=
 =?iso-8859-1?Q?7bFA0DVHD4ViRzqihZbGVV6jv4TGemDa18ZHyVIbmvPqeSdh5RuCGAOUV4?=
 =?iso-8859-1?Q?tJ8XxBSJYVBto3J/Mmq+yZzod5bOyVQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netatmo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7603.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af47acf-ff8a-41cb-7ed6-08da4ad2f154
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 11:18:27.8311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4528446a-2666-441f-95cd-cc2cbd9f2c49
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uXhjoYOH7FGXrSSDq9+xTbNG5sjnfmAXyAwDFUOHNTVjgO+ACdEku0LpxaNc8gkC1Qz5+qpDFdZANCJ7+Zn0+BfET6+OcUURQ77hd/Gcfs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0301MB2437
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v3] coccinelle: Extend address test from ifaddr to
 every test expression
Reply-To: =?iso-8859-1?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
X-Loop: cocci@inria.fr
X-Sequence: 433
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/AS8PR03MB76033CF2848D03651D6E189093A69%40AS8PR03MB7603.eurprd03.prod.outlook.com>

The test of an expression's address does not necessarily represent the=0A=
whole condition, it may only be a part of it. Also, an expression's=0A=
address is likely to be non-zero in every test expression, not only in=0A=
if statements.=0A=
=0A=
This change aims at detecting an address test in more complex conditions=0A=
for every test expression.=0A=
=0A=
Signed-off-by: J=E9r=E9my Lefaure <jeremy.lefaure@netatmo.com>=0A=
---=0A=
v2 -> v3: Apply Julia's suggestion to have a more generic solution + adapt =
commit message and file=0A=
          name to this new solution.=0A=
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
index fc92e8fcbfcb..2d0ec86d1701 100644=0A=
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
+*&x@p || ...=0A=
 =0A=
 @script:python depends on org@=0A=
 p << r.p;=0A=
-- =0A=
2.25.1=0A=
