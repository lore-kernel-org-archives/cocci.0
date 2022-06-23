Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37182CCA481
	for <cocci@archiver.kernel.org>; Sat, 25 Jun 2022 12:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:content-transfer-encoding:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=b1aeWg0JJwlLug7q3Roq3dGINHz947X0xfpPTVjVoiE=;
  b=IX6F5IRNCG47Sb4W6exw444DIhGEC7Zo1/WP910W/7ZwJ1B1/WnxK7uf
   uuPTtTFRd53WCFw6e8QBUneSFidgEpOlMtb3hFtGgT/5v7uWRDgH6okzI
   s047A8jfrfFGzj6tN+UU8Drsgs0r4WcxV8CYGgB8tMLjkA6CKDRDTYh8G
   s=;
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
X-IronPort-AV: E=Sophos;i="5.92,222,1650924000"; 
   d="scan'208";a="42838451"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jun 2022 14:33:53 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 82336E00BE; Sat, 25 Jun 2022 14:33:53 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CE44EE7E61
	for <cocci@sympa.inria.fr>; Thu, 23 Jun 2022 18:42:07 +0200 (CEST)
IronPort-SDR: ljlBkazwIGu9WTOTzEuR6UE5qrObVV0+fUv2dNVN5XhO0QTuy1Xbsp0lXLdqujUDPsQH1ElZws
 N2FMb8fC6WySbEK/xSTnC+KB0C1HTZiKYWvhcKbSoPtu+vKauQOACNPhHWPvi9PQjxJoz6KGA6
 VYV8G1G1F8QB9EYQJu6+fp6VWvaqcbQMVDtXniSatUwa9A5wEsxEvwtZ5rAXbYqbZLLr9SX2C3
 9nuvJMTqAm+6TiXIdX0GKc3kMMsupWjDHUA/kd04/CAwEeSB2tKJb+GLhhN9f7ATz3yHKBNrLI
 u2zI3oFfE1Z4meawOawlajZD
X-IPAS-Result: =?us-ascii?q?A0AZAAB4l7Rih3UVayhaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYFRUn9ZKgMHCESIGgOFMYUKn3OBfAsBAwELAkIEAQGFAwKFSx8GA?=
 =?us-ascii?q?QQyBw4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBAQsNCQUIC?=
 =?us-ascii?q?gcOEAU8ZIEIAYFOAYEwIwsDMQ2CNSkBg2YQBhUZAQE3AREBgQAnBAENBQgTB?=
 =?us-ascii?q?4JbgxkEAp9vAYE/AgKLFYEBMoEBgggBAQYEBIddCYE9AYpXhm2BWHmBPm6BD?=
 =?us-ascii?q?4M3hAuCLpZsgiY5A0cvEoEgbgEIBgYHCgUwBgIMGBQEAhMSUxwCEgwKGw5UF?=
 =?us-ascii?q?wwPAxIDEQEHAgkSCBUrCAMCAwgDAgMgCwIDFgkHCgMdCAocEhAUAgQRHgsIA?=
 =?us-ascii?q?xkeLAkCBA4DQAgLCgMRBAMTGAkWCBAEBgMILw0nCwMFDw0BBgMGAgUFAQMgA?=
 =?us-ascii?q?xQDBSQHAyEPJg0NBCIdAwMFJQMCAhsHAgIDAgYVBgICbi4NCAQIBDckDwUCB?=
 =?us-ascii?q?y8FBC8CHgQFBhEIAhYCBgQFAgQEFgIQCAIIJxcHEzMZAQVZEAkhHCkQBQYWA?=
 =?us-ascii?q?yNuBUUPKDQ2PCwfGwqBGywrGAMEBAMCBh4DAycFBB+aP3EBgQ6jVYEznyIHK?=
 =?us-ascii?q?YMooDAVqGSWcCCmcgIEAgQFAg4BAQaBaAGCDXCDOE4BAgECDQECAgMBAgEBA?=
 =?us-ascii?q?QkBAQEBjh0ZHoM7il5CMzsCBgEKAQEDCY8BAQE?=
IronPort-PHdr: A9a23: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
 S4=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:2xU1VaEufQIyPuHepLqFY5HXdLJyesId70hD6qkvc3Fom52j/f
 xGws5x6fatskdpZJkh8erwW5VoMkmsjaKdhrNhdYtKPTOW8VdASbsP0WKM+UyGJ8STzI9gPM
 RbAuND4b/LfD5HZK/BiWHWferIq+P3kpxA8N2uq0uFOjsaDp2IgT0YNi+rVmlNACVWD5swE5
 SRouBdoSC7RHgRZsOnQlEYQunqvbTw5d/bSC9DIyRixBiFjDuu5rK/OQOfxA0iXzRGxqpn2X
 TZkjb++r6ov5iAu1PhPi7onttrcenau5p+7f+3+4gow/LX+0WVjbFaKvO/VfYO0aOSARgR4Z
 zxSlwbTr9OAjvqDxuISF3WqkPdOX8VmgPfIVP0uwqfneXpAD09EMZPnoRfb1/Q7Fchpsh11O
 ZR03uerIc/N2K1oM3R3am7a/hRrDvAnVMy1eoIy3BPW4oXb7Fc6YQZ4UNOCZ8FWCb38pouHu
 ViBNzVoK8+SyLtU1nJ+m10hNC8VHU6GRmLBkAEp8yOyjBT2HR01VERysATlmoJsJg9V55H7e
 LZNbkArsA4cuYGKaZmQOsRS8q+DWLABRrKLWKJOFziULoKPnrcwqSHk4ndJNvaCKDg4KFC5q
 gpCmkoylLaU3ieePGz4A==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,216,1650924000"; 
   d="scan'208";a="17625362"
X-MGA-submission: =?us-ascii?q?MDFqRPOZ1ZS+HTPJDZ/+4PdsDCl42NXGZDeqrI?=
 =?us-ascii?q?ZYpG4YhZqVnnrXG/EJA74fmTI7Q33yxK+YwFIBv9D3NHoeZT/+X739Js?=
 =?us-ascii?q?17OF0ZbWLEL/NXHRxgUhFCkrxeG55gVsKmPrgb77oKOkoNwnh0IkuHaT?=
 =?us-ascii?q?YWwQi+1GBjUzhF/Ls/xyUuZA=3D=3D?=
Received: from mail-vi1eur05on2117.outbound.protection.outlook.com (HELO EUR05-VI1-obe.outbound.protection.outlook.com) ([40.107.21.117])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 18:42:06 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YH0cvdnFtpfmA6tWzTUEMlAjMmVQpgpbusaMC7Yytf77GVtX50Gp3yerODNmbZvlLJxuU6t9FsIYiuF7h6/aE5z9+INzPYciJ+QvrMbYC2ZPfH13YHym1RKCE60PxPkEL4STEJK1WSHkMWvQBiM77fbUuYxdqERlMnp9UG3B7IEF4xLqmNjNMUOCecIvBJasYZoQKbYRj6E+e6N5K44EHGC6axQYPUu4PrimrqO3BOVKwVuf/iaR3CHxRw47ssj1alSIBzg1szNWkzRqeNyo5jPGYppViL3BIKA5AbjlI/bwehrcplElDwPKbAhdLZEmjIQpdy4p9NJM23nhQXMhIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1aeWg0JJwlLug7q3Roq3dGINHz947X0xfpPTVjVoiE=;
 b=fkpTFj8C8rNAGLvFNrXPzIZZ5RZo22LLd73Oq0K4l/psCdwisdkWhlgp3zTzhBjjmGhbJoKcyRYsLLKveRCDB+/oa0CcKqE6UCe5eNoYQ+kn5Yu3ajB5nosOayEag/qTHzxye5ihIjXgL1LCynlowpapjQt8N8MeVLrgIvPUTfklLqS+kE+Klft2xz81/Hc9k44oC4AsV1VpKA4Dm/6i8O4P0ZEGP3zXZxgp/idUYcGjYXpfgOBcE//nMY7VSVbnkb7dropx1gZyfnGyoPaKGDXka2ExW3vLq2OlOh7UF1fld8wXu25dFfuxxYwm4UpzS/IGOSLoByCkhJVrUkv8Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netatmo.com; dmarc=pass action=none header.from=netatmo.com;
 dkim=pass header.d=netatmo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netatmo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1aeWg0JJwlLug7q3Roq3dGINHz947X0xfpPTVjVoiE=;
 b=m+VTtACLXQ3lZ/jUTBT8nAwVcSDbHzBDZTIRWSYp8AmqbVu2YlmsJ8TjdUoXNKQ5x8jZhHEu4JMPzBQrvYCVKn1BcNHO26q1Lj8ZlUtRGLQfYRXKU7xle7assNerpl0EJbrt1Gto/ZabA2CSEkh9GaAPKEQr3alW6RdEf5UTECs=
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com (2603:10a6:20b:34e::15)
 by DB6PR03MB3030.eurprd03.prod.outlook.com (2603:10a6:6:37::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Thu, 23 Jun
 2022 16:42:03 +0000
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::8175:20e5:60ec:b87d]) by AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::8175:20e5:60ec:b87d%9]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 16:42:03 +0000
From: =?iso-8859-1?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
To: Julia Lawall <julia.lawall@inria.fr>, Nicolas Palix
	<nicolas.palix@imag.fr>
CC: Markus Elfring <Markus.Elfring@web.de>, "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: [PATCH v4] coccinelle: Extend address test from ifaddr semantic
 patch to test expressions
Thread-Index: AQHYhx/sYXozXHdjsU6hCbxgevq7ZQ==
Date: Thu, 23 Jun 2022 16:42:03 +0000
Message-ID:
 <AS8PR03MB76039ED18663E85F7E8234CF93B59@AS8PR03MB7603.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a246058e-6687-433d-1d0b-08da55374d4f
x-ms-traffictypediagnostic: DB6PR03MB3030:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FVVx8Ps+VHA2CcHSJLT6dQQ1QsPaTWJe9XVBCUA8ufFyfU5Ok86EiUDMfO8bp3qrYOYiaA5mMOXhYIUOoOxIZnNVNqMnuNh8lPm0Biuqp5TJJbonnNHPClQscKUxRQDdMRkAdkSPpv723F2evS77mRjtmn6XC9/GAY8tOrzcnr4DAwFZgdF+gTgs59KlpSxyDrEwkZBESvCnTTu48od3p9pG/xyHyC7n42js7rDjdcZhWc7LwXhZSUDsIB6uluce0hEV2F2WVlu70TmyfOsqnnoTXWIJOBus9Gwo4d5l8C5wMDkVUPIPF3yTQtOpx0glCegODKeefZy1e6Pb6UuxAWfO3e0tPTYwhWspsHI48G53AfaS6njHKE1dsMXTHBo117GzXCYt4y0cLea/BW821ynr978GhmYTJZLKveDndWvfDIC0DiHk+jMetwzubLg7VJ5sMnlZvoQ3a9ErbuYQVX8Bfj10eYj2yq4cqEqVhx28RSOfQRG9k2SVh6h9z5z4GlLSYobD97F9/xIU3yLsRG/t1IKQDyEc0zIZiSWLArUip0r6tcHa4MpbBs64To4WVn2y9e8maPo5MLvdVnM5l77d5lWGXUzuHNEUL6cBwQyQ2Lfrm3GnGy3nETCLKe3tIOKRgTJaohZbuwKfKiTfSedVC2hE3etr4TVLkitMOouVyOge5zFXFWlfXFbSMtl4WlfRize/zX5IM289fzLE52xY+ixQp2ye45jNEfETvD8SA3uPH6QC9ImZJ5iSYHNfnwODvzK2HdRQ3zdhYn5C9PClCwTKsxSJGeXLNLK/cIk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7603.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(396003)(346002)(366004)(136003)(376002)(316002)(478600001)(38070700005)(64756008)(66446008)(122000001)(4326008)(26005)(2906002)(8936002)(91956017)(55236004)(54906003)(8676002)(52536014)(7696005)(86362001)(41300700001)(71200400001)(9686003)(66476007)(110136005)(66556008)(6506007)(66946007)(76116006)(33656002)(55016003)(186003)(38100700002)(5660300002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yovdHGJ4QI+IOsOFBYKnk7FqbeKOopZcEZDkJFx73Z20sbCjOBd9AriRgG?=
 =?iso-8859-1?Q?xtu9TjsEFhWYqb04w/ft0buMFb5zZqmezpGEyYt4efRjF/J1wx/63pUWQS?=
 =?iso-8859-1?Q?U7UGKIRdXkZe97hZwMQsAso8P+wpFhWp2kjKWwqTdVDU45OhSoAqktZjtD?=
 =?iso-8859-1?Q?jkTswck10tewIVST8XIxBgjtZA15qXD7Bl7AYLTs1KG4tC7Nf7NuLkeBum?=
 =?iso-8859-1?Q?ZwABTqvKC47wogfokgfsjtMuW56SXg3I1QvJGyZsWC7mtIzKljEQikLJo4?=
 =?iso-8859-1?Q?9FnitqKXyuLQHA4vILgoHLFfG0hQBEhWzes21/8lV1lCUUXtEcfyAR3PE2?=
 =?iso-8859-1?Q?5iz4bwSD65g2oclFqzUwYy8f22V/4T5ZwyMt5R4G8phrKjeoD33aM3Bdt+?=
 =?iso-8859-1?Q?wI5EhX2PAlS9sVHM4a9Szw//U92/BaGxqfzGpac8RakY0KW4tkN0auCt1h?=
 =?iso-8859-1?Q?8M6cilxWzYe84w58vEUntWH5TFVg7GKgdHv3rZb+m/4fmb7F94BMneqzmA?=
 =?iso-8859-1?Q?DQ1wnCweDk1tvgEVGYwkk/oGm/l1Yhkp75zHqJeylmXrhAChWZ+PzJcr5p?=
 =?iso-8859-1?Q?uRbHis2UetUoDSZ9WnqsHYx66xmhapZZXuX0VWdgGYeqbC9NfykiWMhxKw?=
 =?iso-8859-1?Q?Gas8C7rNLIpqJweMzaZuSrDmpxy6ZrOwa0Bc5EaK4Wh2VUo2DvJmyCskmW?=
 =?iso-8859-1?Q?bde6sAh4z8bNF5qtzMxrebqL/SdyAAdx4r8MGOMkkyjUBBMxDYd5lpgb7e?=
 =?iso-8859-1?Q?0m29tDwrd2iyMXrSi9bqno5NfVdnzbFQhlQTDG+RHvzSwUF5pQhQa4+nYU?=
 =?iso-8859-1?Q?3pq9PPMj6aUHx7WJczvrCwg993WIFRBm0xPtHhvYfB5GgR2Hp0TxLsXYsU?=
 =?iso-8859-1?Q?3JYZbWfIHhi0ItqIYiAYLZQrbUJfrBdrDJrcbPf1zLV2ywXdN5BhayP8lM?=
 =?iso-8859-1?Q?zC/lnKLFgNqfCSTNSXuFBxM8w1DD+a4TAJpbEnAHJ4o9vyT/jAs0ZEaKLR?=
 =?iso-8859-1?Q?3w3SIUefKHld/S8Vs4BX1fwIQmX0ZC7S/xk+wQc7Z1gYXMB6yWQSVVSNSH?=
 =?iso-8859-1?Q?728Bn1vGY6GD+CGQnoq6kiPL1k7QOvPIp9I3TucBXQ/BcNSdHo6W3KFNs6?=
 =?iso-8859-1?Q?kmpHwPAm3l2r6L8BCAWmY06M2qfBUnyH1kUHX8Ng9dAxA5hxh+DiBh1T4L?=
 =?iso-8859-1?Q?vZf94PeTZXEXDdfNfreJfNtpIOs6pWTQyyxenTKaanhp+XVbhjxw9P2ezm?=
 =?iso-8859-1?Q?na/bYFi1wnfMFM6w7MtjW6eoMJa9/QoQWm76MGobgZ0qh1VMFf4NKi7Kno?=
 =?iso-8859-1?Q?/QHkulm2/rh+fxCFZvz4X/Mg+Aj9BpKHVDJIqPJUUr0FVgp8KkJcvR+NkR?=
 =?iso-8859-1?Q?HPEiAwsw3HlKp0dZ5uzuotUG+fdzLl6wMuDbeKRAoAZGgSewP45oQndWo3?=
 =?iso-8859-1?Q?LlIE22xpO+mm4aDl3GOUAXLXPPVEWXSvQkDE/IMvf6PuTCzhyiM8Z+PaZ0?=
 =?iso-8859-1?Q?7DSNEFBlocs+UHf1S6BtqhC6xeqDoRFj+GqQFvosBLsgMa30kOqd5GOAoC?=
 =?iso-8859-1?Q?AEAxqKOZ0X6hhRVvmzeXwmEIYbUadt+R5M2oaaaSsziFyX/6rang3jWOSm?=
 =?iso-8859-1?Q?Iqqk7JNiruygIV4mutNXUzNXF8XS5QlltXcGHXMiZuTJiAI+78ydib8g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netatmo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7603.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a246058e-6687-433d-1d0b-08da55374d4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 16:42:03.4314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4528446a-2666-441f-95cd-cc2cbd9f2c49
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o9YYO9c3js3Em1jEJtmPpkV4RkQH9nqq/LILfHZU82lpgVAaf5+X6DbwU0qPxZBdM0Xff2h96y/B8Xm96LV5wlhiW0+6M0f+DOAFuqwFWuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR03MB3030
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v4] coccinelle: Extend address test from ifaddr
 semantic patch to test expressions
Reply-To: =?iso-8859-1?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
X-Loop: cocci@inria.fr
X-Sequence: 456
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/AS8PR03MB76039ED18663E85F7E8234CF93B59%40AS8PR03MB7603.eurprd03.prod.outlook.com>

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
