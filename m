Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EC6C433EF
	for <cocci@archiver.kernel.org>; Wed,  8 Jun 2022 14:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=MpdA8rU/qT4L2Y7wN0b5OUKLSiyNsMsLO7cEUjcnIqE=;
  b=lEZ4NJJcbsc0qXqt84L+K5GXqrgXdiTwDUYyK5FhOcxlRi8WGAatiWx6
   lDoF4VCISKc90jXQrZaysrGO70A6l4XAImtbhytlMr3YkqALZKxENbWGt
   R3fX5mBRKZCByIDcXuYhvq+gTmDN0TExTz0uVM+BTxo5qrFV3//mZ4y2X
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="40056927"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Jun 2022 16:08:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2651CE02DE; Wed,  8 Jun 2022 16:08:05 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 46CD5E00A1
	for <cocci@sympa.inria.fr>; Wed,  8 Jun 2022 14:04:55 +0200 (CEST)
IronPort-SDR: iGHfCHTbyrC86drblNyrL2V2kQRnH1vnRvs/X4BzAZvhHIIQPpK39ntnlfVRRd3iaJDXPQU1Ox
 2gzs7+Iz2M1GH0PvlD1+9b5nZYmnkkoqLItDT70H09c3EWmqE8OU5P93sMlEam3g3cYFj8y9T/
 ltYLUKX7FpEmDd7/0Klg17vUoWcja67cyYYLYYI35g77MAq3qNtst0CB0HZ+nr5S+vkmeDN79K
 XxARs3f/Rr6ME0b5SKTJMeks5i8toDVqLwKnl0uEbZgJqXZ/BeqEAiIFpSSbXpA6KcHWpO+Bmm
 4Pfudbfx7vTmwZiq3n8bOhFc
X-IPAS-Result: =?us-ascii?q?A0CAAQD+j6Bih4oFayhaHgEBCxIMQIFEC4FSUn9ZKgMHC?=
 =?us-ascii?q?ESIGgOFMYULgwIDnmMLAQMBCwJCBAEBhH0BAgEBAoVHHwYBBDMGDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEBCw0JBQgLBg4QBTxkgQgBg?=
 =?us-ascii?q?U4BgVMLAzENgjUpAYNjAQEBAQIBDAYVGQEBNwEECwIBCBEEAQEvMh0IAgQBD?=
 =?us-ascii?q?QUIGoJbgnYjBAKgAwGBPgICih14gQEygQGCCAEBBgQEh10JgT2KToQbglCBW?=
 =?us-ascii?q?HmBPjA+gQ+CfDkChAuCLpI/gxeBcB06A0c0EoEhcQEIBgYHCgUyBgIMGBQEA?=
 =?us-ascii?q?hMSUx0CEgwKHA5UGQwPAxIDEQEHAgsSCBUsCAMCAwgDAgMjCwIDFwkHCgMdC?=
 =?us-ascii?q?AocEhAUAgQTHgsIAxkfLAkCBA4DRQgLCgMRBAMTGAsWCBAEBgMJLw0oCwMFD?=
 =?us-ascii?q?w8BBgMGAgUFAQMgAxQDBScHAyEHCyYNDQQcBx0DAwUmAwICGwcCAgMCBhcGA?=
 =?us-ascii?q?gJvCiYNCAQIBBwdJBAFAgcxBQQvAh4EBQYRCQIWAgYEBQIEBBYCAhIIAggnG?=
 =?us-ascii?q?wcWNhkBBV0GCwkhHCkLBgUGFgMjcQVIDyk1NjwWHBsFBB8BmGdrBgE9UU5eg?=
 =?us-ascii?q?XegLZ8cgTAHKYMooC4Vp2Z1lmkZB6ZqAgQCBAUCDgEBBoF3gX9wgzhOAQIBA?=
 =?us-ascii?q?g0BAgIDAQIBAQEJAQEBAY4dGYNZil5CMzsCBgEKAQEDCYw8gkgBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 pzV2OPKMIj5UHranowXd1Rt10WE2ClqYNdqDw==
IronPort-HdrOrdr: A9a23:Md5DxaExMVKzt3U6pLqFVZHXdLJyesId70hD6qkvc3Fom52j/f
 xGws5x6fatskdrZJkh8erwW5VoMkmsj6KdhrNhcItKPTOW8ldASbsP0WKM+UyGJ8STzI9gPO
 JbAtBD4b7LfBRHZKTBkW+F+r8bqbHpnpxAx92utkuFJjsaCZ2Imj0JbjpzZXcGITWua6BYKL
 Osou584xawc3Ueacq2QlMfWfLYmtHNnJX6JTYbGh8O8mC1/H2VwY+/NyLd8gYVUjtJz7tn23
 PCiRbF6qKqtOz+4gPA1lXU849dlLLau5p+7Y23+4gowwfX+0SVjbdaKvi/VfcO0aWSAWMR4Z
 rxStEbToNOAj3qDyeISFDWqnTdOX4VmgPfIBmj8DTeSIXCNUwH48Ytv/MnTjLJr0Unp91yy6
 RNwiaQsIdWFwrJmGDn68HPTAwCrDv8nZMOq59ls5Vka/ppVFaRl/1swGpFVJMbWC7q4oEuF+
 djSMna+fZNaFufK3TUpHNmztCgVmk6Wk7ueDlIhuWFlzxN2HxpxUoRw8IS2n8G6ZImUpFBo+
 DJKL5hmr1CRtIfKah9GOACS82qDXGle2OFDEuCZVD8UK0XMXPErJD6pL0z+eGxYZQNiIA/nZ
 zQOWkowVLau3iefPFm8Kc7giwlGl/NLAgF4vsulKREhg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="40024137"
X-MGA-submission: =?us-ascii?q?MDGE9EoEjyxiC7M09InmixAxirkUkSrqV91Tqv?=
 =?us-ascii?q?qXn1lBEmRr3/BO9FEC9nXZKbTkphNVlzLscd+iigNYSwzdznEE0pfeNx?=
 =?us-ascii?q?pX/sQCPTnfEM99LC3FuobyLQWoNwjVBocQ1QnIZtBZ5y6urNb1eDXUBC?=
 =?us-ascii?q?VFi59GRgQya80igdnmRCF4xg=3D=3D?=
Received: from mail-eopbgr50138.outbound.protection.outlook.com (HELO EUR03-VE1-obe.outbound.protection.outlook.com) ([40.107.5.138])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 14:04:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5WKeEfqJoXLYPec+/uLCZpXgwfV4Ez3fMdWixVgeSiu6hxTFprpEj04tAa5kZdP4xRwBzr4yGHdUfHXzDm/fEWY+vOChfm15eJ4O7U7mUCBMQwLaf5rY3rDEs8R4m+GG3i9DRMDeYTNZk2R3kuB6uPcX1/+Jr78+toTrsCvpZ31JxQ6BqwjMkUAxe+l9F5KQkOCIgmZ/k9aCZHLPf+aj865n16wArnKpc0SZRB8APq58YXJRm1A/IsLnJ3VI6t9Ryo9bcZI7etOAUz87/GQFt1rCeH1W/n++REg8LioqoAJR8fPs2GuLPpbaU2cu39rq7QxEUDW12dnFj8ImPQYJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpdA8rU/qT4L2Y7wN0b5OUKLSiyNsMsLO7cEUjcnIqE=;
 b=a+qdGImeuZ5BXJMdXKwhhJwUAaUpo9BMbfNBZBBsuSnfeqVLxgrdQldfp3tGqaF6/pOEJw9NGFcKinEc/cLA2xcYbZr8ACL1+1a8HOFwN98ESY/MLd8/pU5CmyDtoKiiZjnnqqLSlq2sQKJmy4NOqkLyVWIUnbtzDHZL9F8O+kXNqvo0HIhwF77SMH24veWHpQUX4lfeneNziR/XbCyfEl1ukazbjWvj+9XZ4gI1dxNyi4PTqopsnMQhlA69iqvqpJt5MO51eGl7w4ddo7YXqijJRad1fm9uxQQn700wyDrjxwCUfO2FG1DLUpHSR2BzhcR1VBZw/+WxOgDg3tPUKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netatmo.com; dmarc=pass action=none header.from=netatmo.com;
 dkim=pass header.d=netatmo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netatmo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpdA8rU/qT4L2Y7wN0b5OUKLSiyNsMsLO7cEUjcnIqE=;
 b=MqHmlp1ETXAuzqobwVFdj1wI9eHgTA84/3r4OcgH5B0Jy4TyJWYwW7UCPo77iltmv7b+4ZwCBHDzQcVDK54c51/AsQNIs18uanw9SvreXO4Bo7vTKb+6mdSX/fwRFgpfT8T3lySK6RpdCvMWa2DiosXVc12krGhmKwS6EYiwWSs=
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com (2603:10a6:20b:34e::15)
 by DB8PR03MB5673.eurprd03.prod.outlook.com (2603:10a6:10:105::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Wed, 8 Jun
 2022 12:04:53 +0000
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::197:874b:24ea:e4d5]) by AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::197:874b:24ea:e4d5%5]) with mapi id 15.20.5332.011; Wed, 8 Jun 2022
 12:04:53 +0000
From: =?Windows-1252?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
To: Julia Lawall <julia.lawall@inria.fr>, Markus Elfring
	<Markus.Elfring@web.de>
CC: "cocci@inria.fr" <cocci@inria.fr>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>
Thread-Topic: [PATCH v2] coccinelle: ifaddr: Find address test in more complex
 conditions
Thread-Index: AQHYek7fHLsMc4LTfk+02uWH++YB5q1ERYKAgAASjwCAARMGRA==
Date: Wed, 8 Jun 2022 12:04:52 +0000
Message-ID:
 <AS8PR03MB76038B2D2E451F0A07AEE4D093A49@AS8PR03MB7603.eurprd03.prod.outlook.com>
References:
 <AS8PR03MB760365A0DE3A8522136471BE93A59@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <415ca02b-9618-b447-6471-6bcd0e2215e8@web.de>
 <alpine.DEB.2.22.394.2206072138160.2960@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2206072138160.2960@hadrien>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8658a2c-9e90-4308-bc90-08da4947188f
x-ms-traffictypediagnostic: DB8PR03MB5673:EE_
x-microsoft-antispam-prvs:
 <DB8PR03MB5673CA8B98B1C62B50EB6A6B93A49@DB8PR03MB5673.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RNq4yEBsCl/e4BducuAF1vBB1tv4WhupMpZAmSJeOWVqUxfLAlltc5cOHJmAXdNq6cLBWsHjg/8ISGyuqrVTqFDK6ZCsZeo6inOfqqnk2yQ1P56w6eg/d13uAHL33N6AFQ3/Vce67w/cBFsWDCF2TuI6WNuhyMPM04dkaB4/DvuVUGjq1N/wJK8GLBeZgz/5UozPF96axbWXfscdhSfoL3NDsTa1GRJ6DMOydeqJBUV8ogePUlbcwgEBUmUBhZM0Nl4PL8JPZaeyNS9WzDieIIi0YZoBmwIQZrrX4BR04BEUTYWcjQzX2wFw7TKy2pNEGq8A+0NFtbFulDDB8ixhe0WS1QppilMotIMHowP6Zo1vid7CG+q0bpnfkT/24kg+su3hf/NpFRRzOx3wr2Lvro7SerA5vAhDvZ8/r9SltNo8nuVE50HuFAkjAysHrV1UWOeuGHmXQtmXTTTD+1m16kUEJ5xawOJ9ISerSb3HzSpRz+3UyU4yacXKxI8ZWyapVtwODFP0Bd24ulCOdpQwDjEMbIibyq35lJZYzGaPSIPwHnj9quvaZneixzlgBhCIgs/nrbzR0T5txax1BLWMgVvHxh28bi5ShJGwMbOXe8/qVZD6k2CBAMHv6VQBhajWx2hVs6V+LCB/hodZ8tmmGd7rDpXhI0PnnCIcE7EvibWVafTCnAa4Ja4qL8unCSMuX0pPWZ8mGBXNyYr0lsNYCA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7603.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(366004)(39850400004)(136003)(396003)(8676002)(6506007)(66946007)(53546011)(64756008)(38100700002)(66476007)(33656002)(7696005)(76116006)(91956017)(86362001)(4326008)(66574015)(55016003)(5660300002)(55236004)(71200400001)(186003)(2906002)(52536014)(66556008)(66446008)(508600001)(83380400001)(54906003)(9686003)(110136005)(316002)(26005)(122000001)(38070700005)(8936002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?tanPr7vY5biYx8+/kJddDnXFMFLI/8Nxhprt2QbZguj7/sxJZGAWwSyB?=
 =?Windows-1252?Q?H+akENWYdHLYA3hTLyN58pwDQ0mNckCI+2t0XeDjxh32OONNLrfFNHdL?=
 =?Windows-1252?Q?+oj5CUMOJPEFOfwNQoMIKp+VO38Fdr7OYrY7fHAbgxzX7autmi8oKsIv?=
 =?Windows-1252?Q?EhfwwWPLpbIGbeYFU4HJSscGI148cTMuSOubuOnu5oYV0jPrkdz6/jsJ?=
 =?Windows-1252?Q?Smq4kktDoZLZFAEzS30I336noLOwa3q/XBooZvaNamZS/MQyWcVagA1D?=
 =?Windows-1252?Q?/9KLZvMNwcPypcF7IpIk4dLil/O7aoJTbpPQY1kBvwfrYrCr1SENWleH?=
 =?Windows-1252?Q?rYNdOQ9ff2MkEfnb5wRODSbGzNd3x7L7phlNuI06jl6IRJHvdBXfJSsY?=
 =?Windows-1252?Q?En5+bZNz7gt6OHMCVN24fUpXugW4U957BjEdWVw2xXNC5gOqd+upRXIo?=
 =?Windows-1252?Q?OgQ8FE/Q0MZI/m9f9bVahCRCyyfMLk4rTAW4eBG2q/v0uabPSOnVE+QD?=
 =?Windows-1252?Q?Nv2DI1gYXzf7RTUoum3RlXe8KcQyi8Eh8i5Ho93/stzdAEiIpbknBbbg?=
 =?Windows-1252?Q?aBI0hx9R16tmUsHe0lU+BZzXVON2ww9PyZWHa3WwxmyNjIM9z9KgBUDx?=
 =?Windows-1252?Q?2q16yP4taZT3tLRMWKOj3j+lVPtv2e0sNMUaFxXF6iOX9rr8ZtpOaRnp?=
 =?Windows-1252?Q?Q17vE4mrigzHViIKtSwBVUSY++AagI9XHLdhDyAbAB31aSq1IfDA0JQP?=
 =?Windows-1252?Q?xkva1Fv/QEBZKdxVMJ/XCqC8jigu4XKZVBw98w7b4y+fVrJElhsizlgd?=
 =?Windows-1252?Q?undcgzCi0vN5/8fitCiiTaikg0c2vFSBSmvvCZftNwIVTLDT62bKKS4Z?=
 =?Windows-1252?Q?oempj0qVZMKh+2xHTqNNFbOkyOfe16YejBKPjDaAhRPTKW/pbldll5Zt?=
 =?Windows-1252?Q?d0iVdD+HmB9AgATb4vZMWHHZ1rUGQr0Qf4JdiDwhi5tp3T2E/ZHVmrjM?=
 =?Windows-1252?Q?KGhJJCtSxbTaGvbZtNTndG/zKybvgPIKLhyFOjw4F0njLrN6FQgMYYMr?=
 =?Windows-1252?Q?y2IP0X70w0O93uCVWmBwHUz+I/Hm6mG/mX+wPIAdqflsIDxfeDqje+fj?=
 =?Windows-1252?Q?YCAX6bNyrW+udAzNhH6FrEAQfTBniDwuR27l0g+IEDILoqCgr4BKiQxA?=
 =?Windows-1252?Q?CkqtQ1WKJ6N/nD1au2OnVkq1TP09lofxDDOAdvU1i8F1VSaHt1IpGn9P?=
 =?Windows-1252?Q?7eIm9jFU4keHkQDjH/JgQbo9ZXzFdhr9mj2XLZfa+LIW5LUX8xVeBztj?=
 =?Windows-1252?Q?R9fVC/pth4H+3JUZ39CnojjOM/TF+rJzyHhFVvz9wry9X8byACLoCg6A?=
 =?Windows-1252?Q?DNKnLzYRYxCfv7GwindMbv0No7WXnpXKkWgRKyXOn7IE5ytcmuMPcYWv?=
 =?Windows-1252?Q?D3075QFqdbH14XREzAD8gMsh4Aqbw5nuuAA7k7BrhpEhE/0Va5YWdkVi?=
 =?Windows-1252?Q?Q2VTf8zBO2HMRmEb54xD7Vgv1P5O5ooBlpAduTMvCCA3jq56bd/IT9Qu?=
 =?Windows-1252?Q?AXcV8iQd0NLOySrp8kkezEYYYtqKNaV4liJvo3SfeJTSCvEa0SS28G8O?=
 =?Windows-1252?Q?24kF7Dsqdy5YqSKVcfkx6rZ6s+XY4PD7qNCqQIbi1aD488OjX2oOj0Aj?=
 =?Windows-1252?Q?F98KA7Kd/YXvTry6US8vFcZ44WsrbQzncucCFOPPgnCxU8peiRAfNxwZ?=
 =?Windows-1252?Q?TCpkiA5FiSzAO536t45AGnPpBIHpGTrIJ7S1Cgyn5JjMscFJ8b5UlTEm?=
 =?Windows-1252?Q?9gAV+kRjswS70NwbfbilW4E3/Wihi1mRXoPYn+tY+oUc8JqzvugPeZg4?=
 =?Windows-1252?Q?ZgzKztJqGMGiEsSX37JVe8Hym5afw7l4evQ=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netatmo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7603.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8658a2c-9e90-4308-bc90-08da4947188f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 12:04:52.9613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4528446a-2666-441f-95cd-cc2cbd9f2c49
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JQlJYyCXZwjerrjUxtYQ/bPtGcukt6gfvwHZhJAsgLikALAMY/eN7glUKIEfFtbU5eA64cRiaAQYgeTT7/B++39sejEuty8nh4HL/Ic+Hxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5673
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2] coccinelle: ifaddr: Find address test in
 more complex conditions
Reply-To: =?Windows-1252?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
X-Loop: cocci@inria.fr
X-Sequence: 424
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/AS8PR03MB76038B2D2E451F0A07AEE4D093A49%40AS8PR03MB7603.eurprd03.prod.outlook.com>

> I don't really understand the above, but it made me realize that actually
> the following is sufficient:
>
> @@
> expression x;
> @@
>
> *&x || ...
>
> This forces &x to appear as a test expression. There can be 0 or more
> occurrences of ||, so eg &x && y is also matched.

That's indeed better because it allows to catch issues in tests that
are not in if statements (such as loops). Is it ok to rename this file
to test_addr.cocci in the next version of the patch to give it a more
appropriated name?

It also gives a better line indication for conditions split on several
lines.

I also noticed that with this change the semantic patch catches tests of
addresses in if statements when likely/unlikely is used, for example
if (likely(&a)). This was not the case with my previous patch nor with
the current semantic patch version on master even though the isomorphism
unlikely(E) <=3D> likely(E) =3D> E is in the standard.iso file. I don't get
this behavior change, do you have any idea why it didn't work?


Thank you!
J=E9r=E9my

________________________________________
From: Julia Lawall <julia.lawall@inria.fr>
Sent: Tuesday, June 7, 2022 21:39
To: Markus Elfring
Cc: J=E9r=E9my LEFAURE; cocci@inria.fr; kernel-janitors@vger.kernel.org; Ju=
lia Lawall; Nicolas Palix
Subject: Re: [PATCH v2] coccinelle: ifaddr: Find address test in more compl=
ex conditions



On Tue, 7 Jun 2022, Markus Elfring wrote:

>
> > The test of an expression's address does not necessarily represent the
> > whole condition, it may only be a part of it.
> > This change aims at detecting an address test in more complex condition=
s.
> >
> > Signed-off-by: J=E9r=E9my Lefaure <jeremy.lefaure@netatmo.com>
> > ---
> > v1 -> v2: Moved disjunction on the condition itself instead of being on=
 the if statements
> >
> >  scripts/coccinelle/misc/ifaddr.cocci | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/coccinelle/misc/ifaddr.cocci b/scripts/coccinelle/=
misc/ifaddr.cocci
> > index fc92e8fcbfcb..14dbf3131a3f 100644
> > --- a/scripts/coccinelle/misc/ifaddr.cocci
> > +++ b/scripts/coccinelle/misc/ifaddr.cocci
> > @@ -18,7 +18,7 @@ statement S1,S2;
> >  position p;
> >  @@
> >
> > -*if@p (&x)
> > +*if@p ( \(&x || ... \| &x && ... \) )
> >   S1 else S2
> >
> >  @script:python depends on org@
>
>
> Would you ever dare to adjust the specification another bit for such
> a source code search approach according to the difference in the selectio=
n
> of the operators =93||=94 (disjunction) and =93&&=94 (conjunction)?

I don't really understand the above, but it made me realize that actually
the following is sufficient:

@@
expression x;
@@

*&x || ...

This forces &x to appear as a test expression.  There can be 0 or more
occurrences of ||, so eg &x && y is also matched.

julia
