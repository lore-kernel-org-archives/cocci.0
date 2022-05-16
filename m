Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BECC433F5
	for <cocci@archiver.kernel.org>; Mon, 16 May 2022 20:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:content-transfer-encoding:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=iRN2R7Sf8zsgIrffI3acUJuGzGYxDBm2Nhg5m3PGXW8=;
  b=c6fhk2BjlkVOGsJb7TW/Tmax/mO73Ruxqr4UpRrFqZpBvthi1/H/YHC7
   PwblozkDmUK/uwWclXlsclOUgGehaUCN/gkpi4eP8Y63Y/xceAK7vhct+
   m9PfBHb2uZp1CJF/fXHO0hHho4v8KaeUXgpo3JtIcj/m0jERakqqMUgmB
   0=;
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
X-IronPort-AV: E=Sophos;i="5.91,230,1647298800"; 
   d="scan'208";a="36570680"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 May 2022 22:18:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 679A8E436E; Mon, 16 May 2022 22:18:58 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id ED0DBE436E
	for <cocci@sympa.inria.fr>; Mon, 16 May 2022 20:34:17 +0200 (CEST)
IronPort-SDR: Jcod2SDh++1DP1EbuRcqncNNIXtZ1KOoPVBRIZWN5VQvyIUlzKzsGxZLIvaSG0WiVeEHk34ixS
 S5lc1EF6vPa8fbhdeFTn5AfJe/TTXLZYIXoxyHgimJ/ARrRgBkcYBH77jLTXScU1oFJvmpoVAA
 nuFECZYimU02XkxiNiO40dYJJc3D1KG2wg/3eIMnGZASogTtaQ29LTe0LLIviLs4uT6t3aPhMC
 jChOmuxuNZ3tNU3dq7DcJ7PGsVA7khRKGwX3JWlRAMAG7xRfc12BSmaleUM35qN+62ue1Nn5E5
 hnpVsYpRzYNYmQTMx1HrYrLw
X-IPAS-Result: =?us-ascii?q?A0BjAQAOmIJih3RyayhaHgE8DAILFYFPgVJSfFgpAwcIQ?=
 =?us-ascii?q?4gaA4UxhQmfaYF8CwEDAQsCQgQBAYUCAoU/HwYBBDAJDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEDAQEFAQEBAgEBAgQEARMBAQEBCw0JBQgKBw4QBUFkgQMBgU4BgTAoB?=
 =?us-ascii?q?gMBMAEMgjUihAQoBgEBOBEBPkImAQQbGoJbgxkCoBABgT4CAosVgTOBAYIIA?=
 =?us-ascii?q?QEGBASGAYFcCYE8ikOEVIFVRIEVQ4I3AQGFMoQLgi6VajsDVIEFEoEhcQEIB?=
 =?us-ascii?q?gYHCgUyBgIMGBQEAhMSUx4CEwwKHA5UGQwPAxIDEQEHAgsSCBUsCAMCAwgDA?=
 =?us-ascii?q?gMuAgMYCQcKAx0IChwSEBQCBBMfCwgDGh8tCQIEDgNDCAsKAxEEAxMYCxYIE?=
 =?us-ascii?q?AQGAwkvDSgLAwUPDwEGAwYCBQUBAyADFAMFJwcDIQcLJg0NBCMdAwMFJgMCA?=
 =?us-ascii?q?hsHAgIDAgYXBgICcQooDQgECAQcHiUTBQIHMQUELwIeBAUGEQkCFgIGBAUCB?=
 =?us-ascii?q?AQWAgISCAIIJxsHFjYZAQVdBgsJIxwsEQUGFgMmVAUEH5wyrWuSRzQHg08Fg?=
 =?us-ascii?q?TgGDJ5XFYNjpHSHUI8WIKZeAgQCBAUCDgEBBoFhZ4EuTSODOE4BAgECAQwBA?=
 =?us-ascii?q?gIBAgECAQEBCQEBAQGONoNZil5CMzsCBgsBAQMJkRoBAQ?=
IronPort-PHdr: A9a23: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
 55LTg==
IronPort-Data: A9a23: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
 zeFVfY=
IronPort-HdrOrdr: A9a23:o8XvIK0ghYzWqp78AsOhtAqjBSFyeYIsimQD101hICG9Lfb0qy
 n+pp4mPEHP4wr5AEtQ/+xoS5PwOE80kqQFqLX5XI3SKjUO3VHFEGgM1/qH/9SNIUzDH41mpO
 9dmspFebrN5DFB5K6UjjVQeOxQo+VvhZrY4Ns2uE0dLz2CBZsB0y5JTiKgVmFmTghPApQ0UL
 CG4NBcmjamcXMLKuymG3gsRYH41pf2vaOjRSRDKw8s6QGIgz/twqX9CQKk0hAXVC4K6as+8F
 LCjxfy6syYwryGI17npiPuBqZt6ZXcI+h4dY2xYw8uW3XRYzOTFctcsnu5zXMISa+UmRQXeZ
 L30m8d1oxImgjslyeO0FDQMkDboUwTwm6nxlmCjXT5p8vlADo8FspanIpcNgDU8kw6obhHod
 d2Nk+ixulq5Cn77VbADhnzJm9Xv1vxpWBnnf8YjnRZX4dbYLhNrZYH9EcQFJsbBir15I0uDe
 ErVajnlYFrWELfa2qcsnhkwdSqUHh2FhCaQlIassjQ1zRNhnh2w0YR2cRalHYd85A2TYVC+o
 3/Q9BVvaALStVTYbN2Be8HT8fyAmvRQQjUOGbXOljjHLFvAQO8l3c22sRF2AiHQu118HJpou
 W9bLpxjx9MR37T
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,230,1647298800"; 
   d="scan'208";a="14242989"
X-MGA-submission: =?us-ascii?q?MDEqFPeBTyNjJOI92kmeLKYDfblbG+3tvCq9qC?=
 =?us-ascii?q?LXaaPm0Jl0uDCMmfEnmohLjsxvU1OKW3JaUQn4yocoHc++r0voD+taC+?=
 =?us-ascii?q?N7aWIja/8W0TTBXZPUskzA542V9ARFWaBzf0ZrgV5srqkP+ZG+40np/H?=
 =?us-ascii?q?7ffdi0I9FTu7AYrnem7m66CA=3D=3D?=
Received: from mail-tycjpn01on2116.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([40.107.114.116])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 20:34:14 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKPe7fU4fOGOsTcJgtMkwatNqsfMM7HsUDM+6/Ix9ibWjbr3i4vH+I60ZRUskZXop7Z0dPterufh45Vt2TVKihTyBsImWWlJ+H4TKE2GyYKG3JHI5Dxqqu9QuCu4rT7AVcrp3Jlr2A149Tvi7BiwQ7m6ReVjckXDR5fi6gemcH4qrXMmrGtdnGXAEpds0xuIFdC28NVAZTEvBPXLKAyAl9fk2p8mfqBGtOJs4MVvIOq2RcV+EMCwolwwYa+jb2RVnvwmhSIW1hMmjGAUVqLVfb6Io5ncy8qm+lGDMfONXOO0s2kY0TAF6kODdMLhbXCAdTRaqQV7Ey+Va4wOTrE+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRN2R7Sf8zsgIrffI3acUJuGzGYxDBm2Nhg5m3PGXW8=;
 b=V68NZvTVtNZKdJapc6Yeu2mFVnPKuR40gJzDL098ntIAHIYZv7/U+WuWSohk2377uFCl2Bx21ogmNs0hRhnA8+cXSq0c0EN91BW+9DMMOL9HshWqr//qmcIZEGhBXkszLD1Hpm8739bmkV3C8ITPN2/1GD5uTk/X+FJyWOIoLtxCLIH4JxwRrxQ7JiXQIdKBfKbzBXLrkMoGTvmJIpr1WkQDyyNCU4hivx4TVDvdaHlFykv/n44mihpaxkB8PuVm5qr9hQhJZ894iXhYEyjEIdSe/d7XxoGRk4Jc0SeWGHpo53gGKNnokwGii/YeYAaNA9qWwUa3E5a59Z5AmFdrUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRN2R7Sf8zsgIrffI3acUJuGzGYxDBm2Nhg5m3PGXW8=;
 b=le4/+LWeHfufa+p0DGQUC68TAXjXyfyZY0atVjvyh2sKta54igtPhQCwLvNNgSW51vKFuk44ceFHQP9JIh6d4KCTiEAiNBcV84X9sCGtlSMvTEVLjODxqHA56Jo8YJmBNozNJbCpkO+ZtY3ktfQPSEBxiacveVP9Ac+kKdNsSGc=
Received: from TYYPR01MB7086.jpnprd01.prod.outlook.com (2603:1096:400:de::11)
 by TYCPR01MB9813.jpnprd01.prod.outlook.com (2603:1096:400:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Mon, 16 May
 2022 18:34:09 +0000
Received: from TYYPR01MB7086.jpnprd01.prod.outlook.com
 ([fe80::e180:5c8b:8ddf:7244]) by TYYPR01MB7086.jpnprd01.prod.outlook.com
 ([fe80::e180:5c8b:8ddf:7244%7]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 18:34:09 +0000
From: Phil Edworthy <phil.edworthy@renesas.com>
To: "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: Matching an if statement with just one func call
Thread-Index: AdhpUuUAdHcxOS+STjCVaRB6YEfnZw==
Date: Mon, 16 May 2022 18:34:09 +0000
Message-ID:
 <TYYPR01MB7086CFE025C9A65F40613D61F5CF9@TYYPR01MB7086.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5139266-6593-4db7-f350-08da376aaa8c
x-ms-traffictypediagnostic: TYCPR01MB9813:EE_
x-microsoft-antispam-prvs:
 <TYCPR01MB98133A46601294AC9DBAB4AEF5CF9@TYCPR01MB9813.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TEaYRckphZ2RojAu+gdsea41eSA1ybeM+BQj9LX4QXGCguhfGonR7CN5rHushsDmBKsf6HUBnqKlBmxXq6fQxepN3TOWLbWw+7PIFC+ywBboUgFQENA52vLJkx79LODJO4OPn/YlZ4FlNNRI2MoXzOFESRmscBKvWoKNtlRJxOZAGdkII/oze3xnPIef1irpVLQTv4dwxn1+zdDn3NSBoCReLXFPGaCdWxUbgfDqRsPCmxv6tv1uoGxi3I3yStZTQMOAer1o8ikCE0q4Gw1YKGlkYNSvagtjo9/R4NSsvysQRCEN61r0rCwRA7MVo/vXbXhWNSYmsrbORndaHKq562Qw9j+xThRJsLxXVE8ssnMD0T3SY/NPgzdMr9j2ra6XKPk7rLQ+lCcT4yTRv0FmPszDXbxI7O+sLhYAptJ35N+RG0LdNixw+i2U4ZXT2ilqbNlDRMHwqAEg+xYT1PIZsflnU4qEhNSBn056qWiCbUo6IPT3R/MSm793UTZAOZalALCeqF63geaSR9q8sljXpw9gM05JVOddr+wiVowXkixGi7Qa7yPcuGQulA8ngyHGTQoBg0UbzwejpLWNsw/2O9xOYKXiBORVq+LSxRnMhScC9uldPnfwUgl6IO2TgqCeCrATdMZ6J5i3JlU+2wesKsThJKLRsft61fK2lcpI38emzQoZcr6ELzHGnIBxdfgINcl4vDxlXSGV0soa3En8Vg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB7086.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(2906002)(26005)(9686003)(38100700002)(86362001)(83380400001)(508600001)(38070700005)(8936002)(7696005)(4744005)(316002)(5660300002)(6506007)(8676002)(186003)(6916009)(76116006)(55016003)(122000001)(64756008)(66946007)(44832011)(33656002)(66556008)(66446008)(66476007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VqppIqiQmhJ2WK8yHrqG9+O9V9babVvEUDNj+zuSwGzWSXWfj+Dpg8oPIE8M?=
 =?us-ascii?Q?FbZhuWum0RC5w1doaz/h9vY9KgBipr2StZPwNKst4WT6SqHIA8Vd/wN74Gs9?=
 =?us-ascii?Q?dDTWdfwR9DvJFyBHNOPValr0Revccj1+tAeXzkbAsr0qpKttVygI50rZJxW5?=
 =?us-ascii?Q?onIuF7nGqdt5ov0RbZ1tx7QGto/Y60fOKZzOmjlb+z8MRrqZiQlKmCRM3LWP?=
 =?us-ascii?Q?IkEcSFVaxPDsEisBJkPIrDHA/oNtNzeiHB5yv1wMhDGVS8D6+m3CSemH86dP?=
 =?us-ascii?Q?xBdZ09wS3G4NHl6O6N1p+uUsdJFg09/IsK1fiSEE7dd057Na4Lz1q/QUgJJT?=
 =?us-ascii?Q?AHJXOWxaJ1TuDJ/Exsgsfk4uJ7IIkmvJvafdRnbdk//c4FyrXH6IIY5hRSdr?=
 =?us-ascii?Q?FFFgkNiT9FdOJJGEyGFnublylbdOfPdd5JmHdQhqO3Z4bQi3krHoW9oGSx+u?=
 =?us-ascii?Q?3drYgVLrYk5OqU47IwkZua7M1ga4XZfLWI29kZH69Y1eck5HNq8l/6mQGh4m?=
 =?us-ascii?Q?6GSrMDuhruuIdpeuRVLdxuipjRVBYjPOwIWiKAROjNRwM6yzBBoOhOJN2hYG?=
 =?us-ascii?Q?fFTVNFX+pqZ3zIs2Pa2R2kMZouxLvnmZDSbbLIamqxUp4OTwxZRr/9jMVg5H?=
 =?us-ascii?Q?uepsrxgdzXDG+y+cCRCN1enFBQviEDIvA4+5P1K0OfIdw35JF9okyWSSqJeg?=
 =?us-ascii?Q?ZlTBw0hgWGx9dLTALpnvF6MXU2LDVRUFl4lhOhVU8Z81XoC1onGvSWRZ796Z?=
 =?us-ascii?Q?0RtHxVWkwfSiR7gQQk0fgBr0EZRdJHrKJmiVUFWzonHG0snxJeGUQuQc+8uU?=
 =?us-ascii?Q?EW2MUtCz9w/z+UYHnZj4O9xchamlokRg0RLUQvZdNuiK6jkEQHo1fCddKT9n?=
 =?us-ascii?Q?hWRJwjJWgvP1H32Yz54N3+57OQdxkvP596Iy4XBcrxvGJTOJvrQvSUeOTqqu?=
 =?us-ascii?Q?G8YmdwnQ1QCf1IVDijW+uTdFfsKHrkbBM+8+bdYR0Evmdi1dGcl5NzU6sfCD?=
 =?us-ascii?Q?ABBl8l9+85EWMI3btOi44YK16D5Mz2n2gIzB5F+toP/SMicYOBRU7e71s36S?=
 =?us-ascii?Q?vLqypa83VIBKoUSBzxImHgY6mWw1CBF3EqopV5agCTy8JlvjsMOS/PhqATGC?=
 =?us-ascii?Q?/3owbq5/TGYtUEMhv4qHMBoUU9ry9sbmgYd3iKK1JzhyzkRe2/CZPJs9A+1U?=
 =?us-ascii?Q?D/tN7w7Slcx2BOaO9VER3OjqT73/NOXAcpSxWiafW5QBKaRPIg9PCaEe9mdH?=
 =?us-ascii?Q?se3HB761HIhtInw6cVA0hUh3VyIrCi7ZW0lyZQjLCV5nGLQQLJNg8v0OouBV?=
 =?us-ascii?Q?LjwdXhC2CZ0sUyU9sCIGvLVXfQsAEW/0d1GWs1Jw/IcOVCVlAiP8rBa5m93O?=
 =?us-ascii?Q?5SIwah5+8fLRD9BRPSi1OTYZk7PoHuIsXYPraYIGnpo97xWIcBe+MS3lf2Py?=
 =?us-ascii?Q?4snmzxw89+LAEo5/gAiTNBPAChfpVululkrxvsZUU3DB8MTCBy2ywKhUBD3u?=
 =?us-ascii?Q?OUsJ2DTrQqfm3QDWJOcA7zdu6dK0+lkk2mqG7/jug42yS04dRTr+MeskV2Xj?=
 =?us-ascii?Q?DfxO2TSA9Y17Ia5tuqNUxmUkxxdhzIhfZxHjRGmWSDbDQGonGl23K1NKpiMs?=
 =?us-ascii?Q?ht3in1MxRsk3j395uvVJWePnwWBdaPdQHEu8DA7udzks7cApPg8d8VgOf2sv?=
 =?us-ascii?Q?lzCTat/rlmryZKN/iyJ24GqHtmiTh3CSDRzMtoDYNWdoJDi+QOEQyFRRsvUK?=
 =?us-ascii?Q?Cvfog1MDujFYOOpBrNWL+J/TWVBl2KI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB7086.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5139266-6593-4db7-f350-08da376aaa8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 18:34:09.3615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8HRQk+dqfhek4DZ/wXs1tpYWJYVrN+5wM9OFIsilNIJUBSw0S1AVLYvM0WUlTN8wbByM13G5zftkzCYtKimZyj457AApyhzABldF82Rf+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9813
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Matching an if statement with just one func call
Reply-To: Phil Edworthy <phil.edworthy@renesas.com>
X-Loop: cocci@inria.fr
X-Sequence: 391
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/TYYPR01MB7086CFE025C9A65F40613D61F5CF9%40TYYPR01MB7086.jpnprd01.prod.outlook.com>

Hi,

I'm trying to get my coccinelle test to detect code in
the Linux kernel similar to:
if (!clk)
   clk_disable_unprepare(clk);

So far, I have got:
expression clk;
position p1,p2;
@@

if@p1 ( \( !clk \| clk !=3D NULL \| !IS_ERR(clk) \) )
{ ...
clk_disable_unprepare@p2(clk)
}

However, I don't want to pick up code where something else is covered
by the if statement, such as:
if (!clk) {
   do_something_else;
   clk_disable_unprepare(clk);
}

I know it's related to the ... but I can't get it to work.
Sorry, I'm a coccinelle newbie.

Any help appreciated!

Thanks
Phil
