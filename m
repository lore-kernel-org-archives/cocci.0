Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A361CCA47C
	for <cocci@archiver.kernel.org>; Wed, 29 Jun 2022 14:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=veC4il1/p3lVsrLxnWWaAuQ7w/d0z5tQcTNcg1CTY8Y=;
  b=LJhXc/h5dbWf/SIKPV6PptluGdOGTQnHTsMMargbRGzs/EDMpcKnp3lE
   FIvCieiRM51V4lXkdwjc5KKPkoKkbMlRKWdYZnZ2pKNZ3KwdrZR1r2l0T
   48HvFS9Xt4EoRtZjQCQ6P735VEumkBQTQYi5MeKUthlC0liBdis6HkIoh
   c=;
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
X-IronPort-AV: E=Sophos;i="5.92,231,1650924000"; 
   d="scan'208";a="43455073"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jun 2022 16:31:02 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4E3E2E4373; Wed, 29 Jun 2022 16:31:02 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7DDFEE00BE
	for <cocci@sympa.inria.fr>; Tue, 28 Jun 2022 19:13:08 +0200 (CEST)
IronPort-SDR: OBKciN3cSJiMAaWQJTh8+nlC6WE6x81ATTPP2pvg0AT/jmEWUaFMtGq+howGbV6E8Ne1sObIEN
 SHUtkpQXBy3rHX0FXQXvSH8jr+5nJ9KNmjkll4pl75cnzUCibdfLZiGgL9UimLOf+nxgIaxz/0
 dMMa2QDe0HOhmkFoSkBmX8r7CG6dOW/kC7rX+mrdBviBTPPGFsPrc5qLlGWwDL8VDV0KZUfdnD
 yL1cxSvRd9dtlGhJDGdur/bJnA6Xg/VH08GnHZesOgG5boJRee6mx7e/jVcN6IFmcCuwImL8oO
 Ju1otRjfM6jOy6JVS8qlEb++
X-IPAS-Result: =?us-ascii?q?A0AmAQDgNbtih4MDayhagQmBT4FSUn9ZKgMHCESIGgOFM?=
 =?us-ascii?q?YULgwWccoF8CwEDAQsCQgQBAYUDAoVLHwYBBDAJDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgQEARMBAQEBCw0JBQgKBw4QBTxkgQgBgU4BgVMLAzENg?=
 =?us-ascii?q?jUpAYNkAQEBAgEMBi4BATcBDwIBCEYyJQIEDg0agluCdiMEAqBkAYE/AgKLF?=
 =?us-ascii?q?YEzgQGCCAEBBgQEh14JgT2OeYJQgRVDgjcwPoEPgzUChAuCLpFvh3k5A0cvE?=
 =?us-ascii?q?oEgbgEIBgYHCgUwBgIMGBQEAhMSUxwCEgwKGw5UFwwPAxIDEQEHAgkSCBUrC?=
 =?us-ascii?q?AMCAwgDAgMgCwIDFgkHCgMdCAocEhAUAgQRHgsIAxkeLAkCBA4DQggLCgMRB?=
 =?us-ascii?q?AMTGAkWCBAEBgMILw0nCwMUDQEGAwYCBQUBAyADFAMFJAcDIQ8mDQ0EGwcdA?=
 =?us-ascii?q?wMFJQMCAhsHAgIDAgYVBgICbi4NCAQIBDckDwUCBy8FBC8CHgQFBhEIAhYCB?=
 =?us-ascii?q?gQFAgQEFgIQCAIIJxcHEzMZAQVZEAkhHCkKBgUGFgMhcAVFDyg0NjwsHxsKg?=
 =?us-ascii?q?RosKxYDBAQDAgYaAwMiAhIpBjsFBB8BmxhrgRV5pBOfIAcpgyigMxWoZJZxo?=
 =?us-ascii?q?1mDPgIEAgQFAg4BAQaBYYIVcIM4TgECAQINAQICAwECAQEBCQEBAQGONh6DO?=
 =?us-ascii?q?4peQjM7AgYBCgEBAwmPAQEB?=
IronPort-PHdr: A9a23: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
 bOF/2cX
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ZzQNOq4UT0Z1VALYMAPXwU+BI+orL9Y04lQ7vn2ZFiY5TiXIra
 qTdaogviMc0AxhI03Jmbi7Scq9qADnhORICO4qTP2ftWjdySCVxeRZgbcKrAeQfBEWmtQ96U
 4kSdkHNDSSNyk2sS+Z2njfLz9I+rDun86VbKXlvg5QpGpRGsNdBnJCe2Km+zpNNWx77PQCdK
 a0145inX6NaH4XZsO0Cj0uRO7YveDGk5rgfFovGwMnwBPmt0Lm1JfKVzyjmjsOWTJGxrkvtU
 LflRbi26mlu/anjjfBym7o6YhMkteJ8KoMOCXMsLlVFtzfsHfqWG1TYczBgNnzmpDr1L8eqq
 iNn/7nBbU215qeRBDznfKn4Xic7N9n0Q6f9bbfuwqunSWxfkNFNyJM6LgpDSfx+g4uuspx37
 lM2H/cv51LDQnYlCC4/NTQUQp2/3DE10bKvNRj+0C3a7FuH4N5vMga5gdYAZ0AFCX15MQuF/
 RvFtjV4LJTfUmBZ37Us2FzyJj0N05DViuuUwwHoIiYwjJWlHd2ww8Rw9EehG4J8NY4R4Nf7+
 rJP6x0nPVFT9MQb6h6GOAdKPHHQ1DlUFbJKiafMF7nHKYINzbErIP2+qw84KWwdJkB3PIJ6e
 H8uZNjxBwPkm7VeL2zNcdwg2HwqU2GLEfQ9v0=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,229,1650924000"; 
   d="scan'208";a="18003946"
X-MGA-submission: =?us-ascii?q?MDHWmuAyCp2IG8MGjQAzkdqgkUj15VjesJkOBV?=
 =?us-ascii?q?6fHRmKu4cCk+Dq5Fmel4IRPRjhkZ/hK6f/Mfar3/s9nCzpG2hSWqIcJ4?=
 =?us-ascii?q?7FiGmJCQPFjYNEqYnLTZ6J0prUxdQNt8BQcG5bxBu0LE2zXBxZF+DA4T?=
 =?us-ascii?q?uF06ozbJ5PjBh8/BjcM4weMA=3D=3D?=
Received: from mail-eopbgr30131.outbound.protection.outlook.com (HELO EUR03-AM5-obe.outbound.protection.outlook.com) ([40.107.3.131])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 19:13:08 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdaVkv5b1Dk2n+ewGBjre6g5uflJTgCpuPd8VMaOODc+HCMFB6o+4CgSNQtCk9fNBnkpfgP0rTJ8PeHFgwo/m7igIM8IGKjKf3E4qr7mNdwoQ7nzeaGMbPbEqQIGT1Lu5vLPKbkX2RjyLxrxBJpqNz9lgzsvWRJA5wKgAqiCr9DAGqb/MRMk0r4ilnj6UU4LHSehZFhTCWwLlxqHK/yMFRGgyTW3hv5aVueI8FDPPW6XXNY/FPWx3rrrkL+7kqcserHWQHOF2J9WpwHYr+F9XHfKK4UrJSR5sjqnaS3JsKuNk4ohRKotf3HuHNLvryVXZklVsYdqpMMrqAYTkEpTiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veC4il1/p3lVsrLxnWWaAuQ7w/d0z5tQcTNcg1CTY8Y=;
 b=O0Kj1C5WB61Icqyl2je/oLr+QTBXk2iAOukThtrffgAU6xgbTIL0vXwRQ9nH4Z4ZucIl2g6oN1Z+4nOZCrE1X/+9MnHyyAG3YfZ+sN6jT+lBUw0ra+TLOD9i9UDu6xj360w9UbSugbbSdZ49quv8VA8widuNhZhkPm74P9piMB4xigNOCQM8Ef0yf4oZaepxY71sLBy3O3/Sf2RsWiCMPIGDml9SpGXP9xW/ZpTXgT6bmIol6F3kI2Ln1+Vm8RpTQjCHHhfd/KTQo9kf3iZj9LFx+XD2Czmk4MbqvlCEcLKJTJoqr7MAfFklaVZ2qFJ/Fn21pHMjpBMt6NJsttPb+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netatmo.com; dmarc=pass action=none header.from=netatmo.com;
 dkim=pass header.d=netatmo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netatmo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veC4il1/p3lVsrLxnWWaAuQ7w/d0z5tQcTNcg1CTY8Y=;
 b=p0P+cnk4ugrU+0u8o7PwkhgWgYbLkL5gbIAs3K4SToRyQljDo3n0CH7vF6cfPxPZrTJcG0Gft2nkXjcX11UGPetCKC2eh8dxBu+C6BZIuAQHN1AgxEtjs9VQjQjx6Tb2LyV0l4o/mVYxMX1x/56JSlL/YRc0NtbTb6vcfQVwuTU=
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com (2603:10a6:20b:34e::15)
 by HE1PR0301MB2233.eurprd03.prod.outlook.com (2603:10a6:3:22::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 17:13:05 +0000
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::8175:20e5:60ec:b87d]) by AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::8175:20e5:60ec:b87d%9]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 17:13:05 +0000
From: =?iso-8859-1?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
To: Julia Lawall <julia.lawall@inria.fr>
CC: Nicolas Palix <nicolas.palix@imag.fr>, Markus Elfring
	<Markus.Elfring@web.de>, "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: [PATCH v4] coccinelle: Extend address test from ifaddr semantic
 patch to test expressions
Thread-Index: AQHYhx/sYXozXHdjsU6hCbxgevq7Za1lDaHVgAABjwCAAAcc/A==
Date: Tue, 28 Jun 2022 17:13:05 +0000
Message-ID:
 <AS8PR03MB7603A0EDD52082F08387477993B89@AS8PR03MB7603.eurprd03.prod.outlook.com>
References:
 <AS8PR03MB76039ED18663E85F7E8234CF93B59@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <AS8PR03MB76032BE6B27D43AD020D810D93B89@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <alpine.DEB.2.22.394.2206281246160.2182@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2206281246160.2182@hadrien>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebd0776d-3fdb-4d05-b718-08da59297744
x-ms-traffictypediagnostic: HE1PR0301MB2233:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1ie8A69KTzTSq1kj1GnkrBrSfHxynlP8yGVw4R/CSO8CkBE4jDMJBV4Q76Z86mN+HEzIbtgk9/2S6q1q2An2akWk0RBIqsALCp1g8Zrit5s05tlviy09GcTDuAh8XTZGJTN1XhrZEnzCekQ2Llt1A8bSI/dA+kV1MKh2GQ0Z2I538pF/G1fYx3UzRB1xJQrLoc8hLMCmtqozjXbfUT9h60aKsTjJZ5QnWTb31Fx9TP3YJWoQQ8fn9+3djSj9NhIscB8NIIS8pNr3TvZ3753kuikLbdHJKxkAQWarVYjMIWPuuFTIOfEZp7heSZrFd85FTedpFdULwNzXu1Zl/wgPVIDm1l1Z0wjnA6ySCwf34+m6CUD+XaXGhsMjthjx66DvjENGhWYQoekj+bZGLjgQhbS4kp61MmP5thZaKay+FtkzA0cqZDFyYZ7j2D8rniyAcCmzcu8Fg2xsEjzDq4jl1J5UKXUtznQ8sYYiM+vUgGNJOmQPU5gSvr+Twab8j+PtZyaTfvxcIUj3vz7Xyei4ewR+d0vHfSvV7O0+FFdInfrcrzaRf2BcvCLcwv7N0UQQkbBpeFgMIzuK7onSNRwo2giqMLWNp0xb01lsvPGiuo9JSqLF8bpiiVr0nMvg9pwClSW53ppJ+22DiWuZw7Yqr2Y8Avi1YdZ2QuHZKsnOqi6yBICKLViLzJjeYaLzYy++QB6VNM7mBrvScV+KTjcsQmi7CwyUHDqWYD8PVRe2uzYZn4GmDgz6TN2Ig87R9uKvv/xGgH9mfK+LC5fDqLyd1Jb5YiHJAw7RiXJmfEyqTL0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7603.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(376002)(346002)(136003)(396003)(366004)(8676002)(66556008)(38070700005)(4326008)(52536014)(64756008)(71200400001)(66946007)(86362001)(66476007)(9686003)(41300700001)(76116006)(26005)(478600001)(66446008)(91956017)(6506007)(7696005)(186003)(6916009)(2906002)(55236004)(33656002)(55016003)(8936002)(38100700002)(122000001)(54906003)(5660300002)(316002)(4744005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?HbgZ3R8x3mIBdyse8Fg9iDShC/49fLI4noxXZ/+D/eQMAZw5hX8/TSbkLs?=
 =?iso-8859-1?Q?tu3HQCpBTh9EcFJNqWekOs29LxK+yyjB/+JRu8sD+vupx4sxmmq9Eg12tl?=
 =?iso-8859-1?Q?gyuMx8SjLp1b6V0jFFOWunmozLwYRjKEVVdvNa3rexAYyaLWwssWiLaJ0g?=
 =?iso-8859-1?Q?tKql44I/TlbtKxoOoEygg4LS+3FZhnEy+8grcBxmPL22GWeQBavUuAg2+i?=
 =?iso-8859-1?Q?k+Gveebth7mRR2iz15Dr3aM0XvA1gNqVv8krCmIU6rWpUWjWO/H2I0M+9t?=
 =?iso-8859-1?Q?GPG6gmCW/nT5Rx7hvZkV2MopqZtH4ooZq9cUmXcMIcFOGvaXEEZOTO9+nX?=
 =?iso-8859-1?Q?XPd1cbFs63z913+fe34Qs5UiXgP3v72NALO9SP8Kxi5EX4ft73fINZ6SW4?=
 =?iso-8859-1?Q?0n9e9tAN9MmZnVX4DedEfOCmSPUTCd77iqxx+C7XVDjmkdGqbk1C3nyzZv?=
 =?iso-8859-1?Q?ZwhQAXH408tHQjYLHxjdG47TWRUJAQzCW3YZGNPn35/CKgbwr+az+jW6+C?=
 =?iso-8859-1?Q?A6gLpL4etB7jJ9OL/gvckOeHehBM1C3rhu8lZN/X3Wh7WsaloM48jmPDFO?=
 =?iso-8859-1?Q?gtJFdIwiCWDXA/ipBaJD9PFyZIVYYJo6x+MCSyNCMBhElbHyCw9F392FTX?=
 =?iso-8859-1?Q?YY5S4sASMIsVXMg9ZSIJmUXkvwICm/bDHVASYvuCHh3IOgHYaZyYTuPl01?=
 =?iso-8859-1?Q?KEcEwq2z6jKPYnMwElDka/5ZREQtL2afBPwvXM94Ooa5knz7Dwjgyb0Oh4?=
 =?iso-8859-1?Q?eemXDu3UUDr7o9W6AnT+PQB22sqiMIDcqvpNl71ulWUJ/wqw7l7C17Eevl?=
 =?iso-8859-1?Q?a6mQrAwquin6md/sNhu3jvEvPy6NbH7EVyAuqaVt+ilfXwbUw3x4fPJENe?=
 =?iso-8859-1?Q?8Jm17jPdkRTEmz2StDcWIilSh7SfQlTZ5rfbMghpBWVJbWXlxoLjMyPiyY?=
 =?iso-8859-1?Q?CAwBSZlHrL1L4oV74co3HqzYf8uQeJZYRwdmvW79Ty/q3CeRJemmWfBxPq?=
 =?iso-8859-1?Q?cMzP5mmcDlu8qkrjeW0z66FV5eZSXMt40ocS5Wrjizbsestl0BjVjku1IT?=
 =?iso-8859-1?Q?dqiEQlG/QV+sUfyFhRzgjJFVDzUwdTtxHUuqwj52zNtsWxz3r3u8pQoY41?=
 =?iso-8859-1?Q?ArRl1QsiTbJpUiX04OGGiQNhbzIM+ef6cJXTUDF2pjhKhzh9UiuimvUYTP?=
 =?iso-8859-1?Q?HpZRQGxBpsCnIL1UGozxDQwkpEIyqk3mdG6r8AmOzD7PxBMzjFLrX8TNX1?=
 =?iso-8859-1?Q?G/CcAv5tPRlsUhLS9r6of8H85nGInIVVQPEhHAZJVtDVscIHx3VVj07AH8?=
 =?iso-8859-1?Q?nuh0PAAlozvyyP0QoFB1R6r6LEkyi9SmwH7L9nxfPgWMJqeguqQWk9KcGi?=
 =?iso-8859-1?Q?VRpSgFZQSt4gg+QzknQy7ePBQpKRwx6IFB2TH+xlYCjyY8wfG9vSj7eSwx?=
 =?iso-8859-1?Q?lXXp1Ectwe2ygXjWVwV7GhCqSvaNkSXICVrVaTyiVf5ZiXrxCpiiYD8YYQ?=
 =?iso-8859-1?Q?hTyadRibJ0687rfR1YB/czL4YbO1RSKXZm+3P18Taf4TGRbgWKQiZYo+56?=
 =?iso-8859-1?Q?JjlkG5Qs2nnEmYeVxuKW0cileWBOxzA5EmT53/4gD4LprrNpRgcpnMDibZ?=
 =?iso-8859-1?Q?7t6M+PQmF/WZEvIpfjSf19VCQcWyAIyGXlKSHYv8gPsNc39e2A1iOS9w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netatmo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7603.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd0776d-3fdb-4d05-b718-08da59297744
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 17:13:05.5400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4528446a-2666-441f-95cd-cc2cbd9f2c49
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hKaYZrudJwk08kJNlq5ws8O3NXTwtBgPyvIXess3TkHZyA0JPuRNo0ZJ+fD52WkkjjCbxnF/8Wy7v1UzcQPzc40fDhezADqQIiR3EA0r5GQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2233
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v4] coccinelle: Extend address test from ifaddr
 semantic patch to test expressions
Reply-To: =?iso-8859-1?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
X-Loop: cocci@inria.fr
X-Sequence: 465
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/AS8PR03MB7603A0EDD52082F08387477993B89%40AS8PR03MB7603.eurprd03.prod.outlook.com>

> > This limitation could be avoided with an explicit test to NULL in the=
=0A=
> > semantic patch:=0A=
> > *\(&x@p || ... \| &x =3D=3D NULL@p || ... \)=0A=
>=0A=
> No.  Just put the =3D=3D NULL case.  The &x case will already be covered =
by an=0A=
> isomorphism.  You can see this with spatch --parse-cocci file.cocci=0A=
=0A=
I'm not sure to understand what you mean. I tried to have only:=0A=
*&x@p =3D=3D NULL || ...=0A=
=0A=
But it matches only negation of test addresses, something like=0A=
`if (&my_var)` is not matched. The --parse-cocci gives this output:=0A=
=0A=
(=0A=
*&*x@p  *=3D=3D *NULL *|| *...=0A=
|=0A=
*!*&*x@p  *|| *...=0A=
|=0A=
*NULL *=3D=3D *&*x@p  *|| *...=0A=
)=0A=
=0A=
I get that the &x allows to match the `!=3D NULL` case thanks to the=0A=
isomorphism `X =3D> X !=3D NULL` but I don't get how the `=3D=3D NULL` case=
 only=0A=
could match the test address without negation as the isomorphism is=0A=
`X =3D=3D NULL =3D> !X`.=0A=
=0A=
=0A=
Thank you for your help,=0A=
J=E9r=E9my=
