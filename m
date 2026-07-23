Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B22AC53209
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=F8mhpmEDshmhrnJzOm0SjRPxlbbTONvQUQTaAO3cAYY=;
  b=IkU+0LqVC1WyM+mWrcxAsVPH7AAxh9H33isSQgTcMzaqCo/9490MoV/0
   zu1Rgxt87yVwnJqMFuUbAMd20Q/Z8uCD2xdjULLrpIR+FIkSsh2quL2Yt
   9ukKgLsQWYTuJFcTEGDFccfsvZGF9udXZWDcumQdITj6snScNkcKnBXC8
   s=;
X-CSE-ConnectionGUID: jhQyUBifQUKixjNbROV54g==
X-CSE-MsgGUID: ObjpZiN0TTK+BH2gKfyJ0A==
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
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287734515"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:58 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 90F31803EC; Fri, 24 Jul 2026 10:54:58 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 9AD17819A4
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 22:36:06 +0200 (CEST)
X-CSE-ConnectionGUID: e1BeqFa/QTGaR4B5ICfSgA==
X-CSE-MsgGUID: R3gW6aqyT+2pTherfvnwRA==
IronPort-SDR: 6a627b36_wh+ch0DcM7y+Kwj4Rxwg/Pomt5quA8rWdzb5Sn9rMX0066c
 rmCTC8uSKc+Lx9kTuILktYUZy1GCvbW8Yp36uTg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EDAAA2emJqg3TLKjRaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBgXwFAQEBAQsBgW1TgWoyBFSIJAOETF+IeQOCf4hlEJBSKoErg?=
 =?us-ascii?q?T89EQEDAQsBAVEEAQEBAgSEfgKNYAIeBwEFLwkOAQIEAwIDAQEBAQEBAQEBA?=
 =?us-ascii?q?QELAQEBBAEBAQIBAQIEAwEBAQECEAEBAQE5B0mGTw2CYgGBJF4DBz4BAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAkMoAQEdAQEBAQMRA?=
 =?us-ascii?q?S4BATcBCwQCAQgXLyARHQgCBAENBQgagmCCIwEGEQM3BAKsIwGJJgGBFQGBP?=
 =?us-ascii?q?QKKKniBNIEBggwBAQYEBNsqDYJbCQkBCgGBOAGIOyABgxSCShk7g0d6QoFKQ?=
 =?us-ascii?q?4FXgmk+gh9CAoV1gjCCJoEMki5SeBwDWSwBVRMXCwcFgSMQMwMgCi8tAhQNE?=
 =?us-ascii?q?BIPBBYFLR1wDCcSDx0XFh5YGwcFEiAqQUUjAxQtJhA4C0MFgVYCgXg/Ix8DK?=
 =?us-ascii?q?RB/gS8Ka0p3LWkBAhAXSjgkgRgBAwKCKwIGgTEDC209NwYOGQMEKoELBY1hI?=
 =?us-ascii?q?4FsVAGBDoFDZReWe44njGSUJnEDByqDc5tfhjIXqmyZCCORcJcFAgICAgQFA?=
 =?us-ascii?q?hABAQaBaDqBXHAVgyJQHA+OIYQCjz0BvBJFND4BBwIHDwKBc5A0gUwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Hns3Ms=
IronPort-HdrOrdr: A9a23:oGG8RK4bjSX31Qu/0APXwDvXdLJyesId70hD6qkRc20wTiT7//
 rFoB1/73LJYVkqNE3Ip+rwWpVoLUmyyXcX2/h1AV7BZmnbUQKTRekI0WKF+VPd8kbFh41gPM
 lbEpRWOZnRJnxBo4LR6BS1HdA60LC8gcaVrNab71xIdy8vUK1uhj0JcjqzIwlXby19K94DGJ
 Wn/cAvnUvYRV0nKuSRIkMqG9XEpdHN/aiWGiLvrnYcmXOzZEiTmdnHLyQ=
X-Talos-CUID: =?us-ascii?q?9a23=3A0hKnW2k6tG5sk4JU7KISMzQ+f2/XOXCE5nrJDUb?=
 =?us-ascii?q?/MFpGQYfJYwKx061fnOM7zg=3D=3D?=
X-Talos-MUID: 9a23:9ynaiwi2kVll9NAJhY96vMMpDpxn3PqnEVEx0s8eh8mJLyJuPSinpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="287674966"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGdBhVw1r5Q2juVDsMz71iZpYMa9FCg02W/eB?=
 =?us-ascii?q?KCZzCWzl65kgcqWWMN0Qpb01cX2PVZGyUIyUeZ9+HAaNWZxdeKHPox3n?=
 =?us-ascii?q?YUCXPhcG2X9nDTmC9LWD+/ztFjXKY7Xdi+3hZP6tbKwaSNgvpZEoKJvb?=
 =?us-ascii?q?v8Wbddpw5eUCKNcvIqyglK4g=3D=3D?=
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com ([52.42.203.116])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 22:36:05 +0200
X-CSE-ConnectionGUID: Af+hxQb8S2aFeNd8/1eKOw==
X-CSE-MsgGUID: /hq+x+LYSc2guX7TX7KC9Q==
X-IronPort-AV: E=Sophos;i="6.25,181,1779148800"; 
   d="scan'208";a="24278323"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:36:00 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:23741]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.115:2525] with esmtp (Farcaster)
 id 6ff998d2-62e3-453f-ab91-d57202915d59; Thu, 23 Jul 2026 20:36:00 +0000 (UTC)
X-Farcaster-Flow-ID: 6ff998d2-62e3-453f-ab91-d57202915d59
Received: from EX19EXOUWC001.ant.amazon.com (10.250.64.135) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 23 Jul 2026 20:35:59 +0000
Received: from EX19EXOUWA002.ant.amazon.com (10.250.64.216) by
 EX19EXOUWC001.ant.amazon.com (10.250.64.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 23 Jul 2026 20:35:56 +0000
Received: from CY3PR08CU001.outbound.protection.outlook.com (10.250.64.206) by
 EX19EXOUWA002.ant.amazon.com (10.250.64.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43
 via Frontend Transport; Thu, 23 Jul 2026 20:35:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBInXKrVgWWNU0oS6qtdC9HZVw5LZr+02FEc3TE3m7hq3Kp8VJJhAjja85ehPcpYH3HyzhgHH05feJ/p1JRLcbEZsrnHI+eabbYyLcSHJuqLtF7CT2YPHx0z8OXAY0wTf8RhctWhxWr22b/VPDctGCLFXc7b6QeTesqGqF6n+TDq33OdlE22rdv3b4ViRmcQwUMQbQNYA6CEss286rNbDjYfjbO1sg5W5dwiPXbMN5E1o4ri2GjNVHbEmFl/XVjXK4slKldk8Jl84HyTGpSGZFak6TcjdOiv1lJ7YGFBrRwY7dytyFfDnIzKLXWN/z7MyO1yFyzCUX/wXBAq4vJr5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8mhpmEDshmhrnJzOm0SjRPxlbbTONvQUQTaAO3cAYY=;
 b=BZqlPKncAHuSjAMY25Qmf8MVhBsdvqg6FOYrMftig0wOzmFaCylkwRoFvl7K2iwRqT+/ZBJ6tfTJwjszX3E5h97OpX/LfEIS5bdEu3uwu8QnUPe0o7BLrUA8jnREfaLhKgHwXvdNH6L0Bsbw7APvw85fiEflxGI3SPqQkhS/NFZXx7T8u2yqgSYCWcXec4t7+FKWkRCJTlHKgfSx37wgcjNiqzGcsh/Sxp/QzoQZQZLTL/lgFgopJHzLDLC6oM6T+63HX1aSgMXEVPeG0oKnikuCm4YkBIyf+2CcKt/B9Jskw1ANJPWNaIzGIQtkTXygJ93UW0CjB8T9wOjqQopR3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from SA1PR18MB4664.namprd18.prod.outlook.com (2603:10b6:806:1d7::5)
 by PH7PR18MB5703.namprd18.prod.outlook.com (2603:10b6:510:300::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 20:35:48 +0000
Received: from SA1PR18MB4664.namprd18.prod.outlook.com
 ([fe80::972c:f0e:7126:9112]) by SA1PR18MB4664.namprd18.prod.outlook.com
 ([fe80::972c:f0e:7126:9112%6]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 20:35:48 +0000
From: "Kiyanovski, Arthur" <akiyano@amazon.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>, "Julia.Lawall@inria.fr"
	<Julia.Lawall@inria.fr>, "Arinzon, David" <darinzon@amazon.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Sukhdeep Singh <sukhdeeps@marvell.com>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "Manish
 Chopra" <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>, "Shahed
 Shaikh" <shshaikh@marvell.com>, =?iso-8859-1?Q?Niklas_S=F6derlund?=
	<niklas.soderlund@ragnatech.se>, Sabrina Dubroca <sd@queasysnail.net>
CC: "cocci@inria.fr" <cocci@inria.fr>, "GR-Linux-NIC-Dev@marvell.com"
	<GR-Linux-NIC-Dev@marvell.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Thread-Topic: [PATCH 07/36] net: ethernet: remove conditional return with no
 effect
Thread-Index: AQHdGuLDHMLwqSGC80SEy6rJKdftmA==
Date: Thu, 23 Jul 2026 20:35:20 +0000
Deferred-Delivery: Thu, 23 Jul 2026 20:34:27 +0000
Message-ID: <SA1PR18MB4664DA66B9EA117823E78D9AD9C02@SA1PR18MB4664.namprd18.prod.outlook.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-8-ekffu200098@gmail.com>
In-Reply-To: <20260723184538.3888637-8-ekffu200098@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4664:EE_|PH7PR18MB5703:EE_
x-ms-office365-filtering-correlation-id: 02fb406f-9a5a-48ae-a82d-08dee8f9fade
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|38070700021|56012099006|10067099003|921020|18002099003|22082099003|4143699003|11063799006;
x-microsoft-antispam-message-info: 9mWKdtAmZRJiJeemqgQAmQdY+59Ms6Wg0cuwd1cTiU2LrTyn/ssn867XIuE9ork94RaVCbhFl2MC4yx9HT3oLeNI5B0zL+4KcS2gsDTRexUzaO13bmTASxe0v/jj/QJ4V2etb2v/yUBDaWmP4yH7Fg6oJWexAQjYcaEomgCfOUerBAGGlLwtbCL9SWt53niYDLNAsEQLVwZgoT11tXMTGDzpqXDFRNSuC4QE7154DlnhfNLyRQ2GWY/Nio/De3hOXUDbAZ5nc0ul6DZOH8OM+4MMjG71RduxQBODbug8uCzaTUD7mdygYByrt3EXqIcPDr6zKjQ7t5kDAWdNlmsBW4xLtVwTatiuokqcTmM+N74Awsil0IwjS9lLqLFmW0r+DGawvypV7l58OPv9T23rNvOVb/PYRxnMNnsUWPFI47cGNLxUDNKUoXLDth5ApjGHrpyO7/CZRWrR/zQi/eb2a91F4j6xW/nUGb0405hMxgaHXoqDkdi19zVGcs0mi/t6egvHy1b2eE3mLO+OQmZcTSczt/+krvvBELbZQv5xoGeCE1LvLJTDNHnLC6Nr+AbfU8RdcDqnY4bTpp8H5FP1Pk9ULjRr8X9VyOxF1TZXyK7xDq8fsp0ZmRP4lmGU1LSFnaOm+BUumuphOBwK9yHb0XYDQvEeE2JhucQlYwI4YQE5ISVmfxO0basYtYq/r0cKwMGtNEpvWKYCo24T9hHovCQKH9qN8DrolKDxLSzNAPQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4664.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(38070700021)(56012099006)(10067099003)(921020)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JPSd5Ib6I/widKRAKgu3iQnmvLP3XeH5ZJUOiCmp8UgroS9N8njdNbKkH3?=
 =?iso-8859-1?Q?5Hn5W3IlK+TDkNcJLz6dGxWYN6/NPjuAj48k1hl0NmUaFOeAsbqM6JLeqJ?=
 =?iso-8859-1?Q?K153ug0GFo6sZs+olxwXddkLUnz36ZzuecIJEHA6TreTyUPsS8nHdovLMQ?=
 =?iso-8859-1?Q?N2sukNUP0vDsIJq7yQKNMtTL8sd55jEXB/05VowKKvS9uELAvgnVNN/eKi?=
 =?iso-8859-1?Q?rnMqJkJ0hIr0jkHkYLxFj9Ia9/bzLfMD0Em8Dnb8RFmarmXeVFBdXV3RwU?=
 =?iso-8859-1?Q?RqbOKOI98mMIsPpgM15Vm1jpiTXwo6ManweGewhgmoFqUu1a5OUEWL7f/8?=
 =?iso-8859-1?Q?MYZrya1fYuGuuUwnOC8Pz4Y9Bnt99thDHxdR2Vtjo4sf7Q9AOtiDf6p/6D?=
 =?iso-8859-1?Q?ATLOHp31dOIpB/WxhTxtW+cQiQr2RU407jLqmpHVm8hMijI/9ct/GQoqe/?=
 =?iso-8859-1?Q?bjS6tmmhgK6kdHGVthdGS0GYmYG8iCyX7rsHdgb+jNMz4WZxIHESwl7HHT?=
 =?iso-8859-1?Q?JBjipeYPML0jiVjQXUe+oW3HnAW1Y+lj9hbf4KOw+LZzvoiff5UNQRHOSo?=
 =?iso-8859-1?Q?iX+gMdhzRmzLz/SQZPL775DZnduOtFm1KWDk0TOCdGRTm4JaSLCZ1YdfFF?=
 =?iso-8859-1?Q?mfzJZwuk3/r7R3sKvcoAYD5t5c19TJXx1dkIqEvXeKo/pGqGhXdjQKrhy1?=
 =?iso-8859-1?Q?T+Dh4G/Ufs6zZUkrmcnTuLqnxd9YqNQwAp/SWXSu0I8TDdidPAJPBvCWsD?=
 =?iso-8859-1?Q?NTQcSwRVAzlxrvjV3KhDDf7VO/V7PJ7mYaXf09WdfZXpCEeWS67X3qLkvI?=
 =?iso-8859-1?Q?hueSlLhP2Eyf0mufwLXV1NGZTbXSHQGFU9OF6HtWMW53z1qtKgXn01gaI1?=
 =?iso-8859-1?Q?TD03Qmu0UP1lLehTLzEVjpHLXbpgJRcTuOI83eJNjW0g/PYsnMMleGk3Qv?=
 =?iso-8859-1?Q?RLFUc5A2MJzmaJCDw3oVozlzd7a7YmCj7Y+04s4JPNRlIvxYvbsU4rJ/R5?=
 =?iso-8859-1?Q?C4fGfLe9BM7yfEvc4J3Ahm4nlEHR1l0TrDM0H9iHg3ozFVQcsjUmi8pAof?=
 =?iso-8859-1?Q?moYkPi3uwwYFGLVloQNCLj54dM7MT8QAiUF/95Cse1chiSnyxVNxoc01Ra?=
 =?iso-8859-1?Q?vGgwzhwxVNpmtmHfGRyge81oe5G9tj3pB3cCMFuKVH0bGGxQHZKNAtgX48?=
 =?iso-8859-1?Q?le06l481azEe/p9f9sf1DI5+nnl2HaYMA4sTeWaqo0Twysw/HrqSEyxE4m?=
 =?iso-8859-1?Q?sYdvni7c/+7paKIouSPBLmvr6HWbfwTj+2tF5ypRAjZ1WIZ/FwFtnydUWa?=
 =?iso-8859-1?Q?Dl1JWcS7TvAAENqus4KEddUC9P5iAxSphhw6x+OkcRhlJghydl33VHmg75?=
 =?iso-8859-1?Q?Kp+89QlrtXsGpn3BmxL90viZi+JssM7L3r91xlM2l9bsKjixuBkOwRmLSb?=
 =?iso-8859-1?Q?NzMFuHGzapGfuaVDPl1oyat4H2O9Ife5hgClrndEJvDDfYXe05rWozRPWD?=
 =?iso-8859-1?Q?7MmKKC2KuT3FAZhTANJGSvVnsLXJAE+22fOkkWhaBjCGv6cYsrqj9KLry0?=
 =?iso-8859-1?Q?S9r3Scp/gVAftNe9SRtE+Lgo6J5zUutOXTchdsb20KH8md8xovnXygjrdo?=
 =?iso-8859-1?Q?lZAeNFcbYEhMoqRziqcKDoA1WGnJSNOr3gEUfOIDr8tasKrEZHYXAwPRbo?=
 =?iso-8859-1?Q?fJwBLlQD5z+J9fM/ar3l5fToTeu4hp16jkkWYui04TYepk5SLyWjwFZhwp?=
 =?iso-8859-1?Q?ORafyrKV5OkEV+ex9zwL0ti0nRYEkyQoEGfdSKG9esWyXs?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cxuaMegXaN3UXXlgEg2Nd06jphUR5hY0WzHxC6HSTTIn1VHIy4fLIqmMWiWSyNOwBMGZLLX/ZSGQ4XlrQqfAi+7Je8n9hWTFXZjWigIgOfTEz4mGTmOB/N6Fvc5AabmrdnoqT2lwnpXgCsT1dKYodvo18I/T8S25KKcow9QktW5vrmQWD1A0gj+MrFynwFdU/SpZznixI9ab7VbA9Y1miqMD3Bny/3xm3gBF2c1B9OLze/PQ3c3NQDcvrGNF6UMdsGY2egvkSDZja9fG632W9HWBeEoaYeZ6LnNpYlofM3vyWvs8N3xRIQBklU//ynGdSBgMawoUJj8avTWO6HHheA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4664.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fb406f-9a5a-48ae-a82d-08dee8f9fade
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 20:35:48.6263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8uMfMxZVKhZtGVUrp8AhyX8yRlBX505MRQB7UyWSh9rLqr4cYpuDUld8gDc3Tf7LpLacYAQzkwIMiQKvp7Jag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5703
X-OriginatorOrg: amazon.com
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [PATCH 07/36] net: ethernet: remove conditional return
 with no effect
Reply-To: "Kiyanovski, Arthur" <akiyano@amazon.com>
X-Loop: cocci@inria.fr
X-Sequence: 3639
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/QgbSrI9gnNMc1gfeUb2qVw>



> -----Original Message-----
> Subject: [EXTERNAL] [PATCH 07/36] net: ethernet: remove conditional retur=
n
> with no effect
>=20
> Both branches of the check return the same value, so the check has no eff=
ect.
> Remove it and return the value directly.
>=20
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
>=20
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c          | 6 +-----
>  drivers/net/ethernet/aquantia/atlantic/aq_macsec.c    | 6 +-----
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c   | 6 +-----
>  drivers/net/ethernet/freescale/gianfar.c              | 6 +-----
>  drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c    | 7 +------
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c | 6 +-----
>  drivers/net/ethernet/renesas/rtsn.c                   | 7 +------
>  7 files changed, 7 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index 5d05020a6d05..ea89619039d8 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -2303,11 +2303,7 @@ static int ena_open(struct net_device *netdev)
>                 return rc;
>         }
>=20
> -       rc =3D ena_up(adapter);
> -       if (rc)
> -               return rc;
> -
> -       return rc;
> +       return ena_up(adapter);
>  }
>=20
>  /* ena_close - Disables a network interface diff --git

Thank you for this patch.

For ena_netdev.c:
Reviewed-by: Arthur Kiyanovski <akiyano@amazon.com>
