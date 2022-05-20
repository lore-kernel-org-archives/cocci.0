Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA28C433F5
	for <cocci@archiver.kernel.org>; Fri, 20 May 2022 16:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=zx1wq5HLCcx0qyOnRoM9OPXeQVv7kOdTqTU8cnKyLlM=;
  b=P/JBnVBEZn6AVLsBrBBSx3eqYujcqeJJEyhgfY3SZIWTZcyu69lQ8FOe
   ZTe/99o46r9YwOOu+F1CPKAfY8mOgtPexaJl6qLVcer9pyrju6naultuV
   zwbFS69JQOGuDHTuxouwFzaxWm79fEoi1OVIBCOwdVHOqAyUZrOapAtiz
   o=;
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
X-IronPort-AV: E=Sophos;i="5.91,239,1647298800"; 
   d="scan'208";a="37387545"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 May 2022 18:13:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A0FB1E033C; Fri, 20 May 2022 18:13:55 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B4D53E0094
	for <cocci@sympa.inria.fr>; Fri, 20 May 2022 18:01:17 +0200 (CEST)
IronPort-SDR: HmrDGtBozAeC5Nr3+PEpWg03IldbK5Npx/1zSifqktrzIJIPGQt4OjIaGltC3pylnUVtscmj2g
 stzVhLsaW3LJpZXY4K7kcI5JRLOaAwYPUtXfxafe82XaaJqzAmAddM3bPbkkWWu9YEviEcFRE5
 0+ADIwsBbcRbb3PROJdpekb2KkxaahCoFKZSGus4j9wvwu/OSgNjz/THDmz6v6l+Bvicl2aKbS
 c8C1o5SE2uPwbQWpaKVK5uQBrQ24LsRCxhShjcI0gF7lI9hxjrGzc/NLnH5iay/WtF2KHQ+EIB
 7DXvGn4rPHaaTa9LIjqcW+VH
X-IPAS-Result: =?us-ascii?q?A0AuAQABu4dih4JxayhaHgEBCxIMQIFEC4FSUnwCViwHC?=
 =?us-ascii?q?EOIGgOFMYULgwIDlxSFUIF8CwEDAQsCOwcEAQGFAgKFQB8GAQQxCA4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBAQsNCQUICgcOEAVBZIEDA?=
 =?us-ascii?q?YFOAYFYBgMBMA2CNSkBg2MBAQEBAgESLgEBNwEECwIBCBgjCzIlAgQBDQ0ag?=
 =?us-ascii?q?lsBgnMlAgyfagGBPgICih14gTOBAYIIAQEGBASBNwEVQYNzgVwDBoE8ihmCZ?=
 =?us-ascii?q?4FjN4FVRIEVQ4I3MD6BD4FTAQOBJTuEC4IulWs7A041EoEhcQEIBgYHCgUyB?=
 =?us-ascii?q?gIMGBQEAhMSTQYdAhMMCgYWDkISGQwPAxIDEQEHAgsSCBUsCAMCAwgDAgMjC?=
 =?us-ascii?q?wIDGAkHCgMdCAocEhAUAgQTHwsIAxofLQkCBA4DRQgLCgMRBAMTGAsWCBAEB?=
 =?us-ascii?q?gMJLw0oCwMFDw8BBgMGAgUFAQMgAxQDBScHAyEHCyYNDQQcBx0DAwUmAwICG?=
 =?us-ascii?q?wcCAgMCBhcGAgIZWAooDQgECAQYBB4lEwUCBzEFBC8CHgQFBhEJAhYCBgQFA?=
 =?us-ascii?q?gQEFgICEggCCCcbBxY2GQEFXQYLCSIWBiwLBgUGFgMkUScFHwUEHwGVZQuCA?=
 =?us-ascii?q?WAaGySCHx4RKZIRj0ueXTQHg1CBPQYMiUyVDhWDdZMekUYtkQyFLiCNC5lZA?=
 =?us-ascii?q?gQCBAUCDgEBBoFjAYISTSODOE4BAgECAQwBAgIBAgECAQEBCQEBAQGOHRkeg?=
 =?us-ascii?q?zuBPokgQjMCCTACBgsBAQMJjgGCSAEB?=
IronPort-PHdr: A9a23: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
 pPsao4qK9vpFnK9VV/5gDUwHZ6ZAQ==
IronPort-Data: A9a23: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
 eenQJPYSOP5kOuxCJGYh+ay3vrd52nKgn/cmB6A
IronPort-HdrOrdr: A9a23:gBcnRqrljK2CZnypXNlaI7oaV5utL9V00zEX/kB9WHVpm5Oj+v
 xGzc5w6farsl0ssSkb6Ku90KnpewK+yXcH2/hqAV7EZnithILIFvAo0WKG+VHd8kLFh4lgPM
 tbEpSWTeeAdWSS7vyKrTVQcexQpuVvmZrA7Yix854ud3ASV0gK1XYaNu/vKDwTeOAwP+tdKH
 Pz3Kp6jgvlXU5SQtWwB3EDUeSGjcbMjojabRkPAANiwBWSjBuzgYSKXCSw71M7aXdi0L0i+W
 /Kn0jS/aO4qcy2zRfayiv684lWot380dFObfb8xPT9aw+cyzpAVr4RGIFqjwpF4t1HL2xa1e
 Ukli1Qf/ibLUmhOl1d7yGdnDUImwxelkMKgWXo/UcL5/aJCA7SQvAx+r5xY1/X7VEts8p717
 8O12WFt4BPBReFhyjl4cPUPisa4HZcjEBS5dL7tUYvJrf2qYUh3rA37QdQCtMNDSj64IcoHK
 1nC9zd/u9fdRefY2rCtmdizdSwVjBrdy32CnQqq4iQyXxbjXp5x0wXyIgWmWoB7os0T91B6/
 7fOqplmblSRosdbL57Bu0GXcyrY1a9CC7kISaXOxDqBasHM3XCp9r+56g0/vijfNgSwJ47iP
 36ISZlXK4JCjDT4OG1rex2G0r2MRuAtBzWu7Fj26Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,239,1647298800"; 
   d="scan'208";a="37385502"
X-MGA-submission: =?us-ascii?q?MDGmRmt4Ou7pSZVR6/hZNT5EBZBtGVI67fo5h4?=
 =?us-ascii?q?ko3wn8TYuJcomSjoQgtvba4KlNZp1N04OF3C3yzOXXYNHldCuWZPNCCJ?=
 =?us-ascii?q?IxHPdJd1nCsLvEEkYyX16ThYIWVzEN3HHVwrnWUTwM/liM+wnLtaXZYn?=
 =?us-ascii?q?fvRqaiyUlwSPGqwXS7roxQBg=3D=3D?=
Received: from mail-os0jpn01on2130.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([40.107.113.130])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 18:01:14 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npkMDmYuSB8+GCzpckv+dp3l8JRcrWHMj/2G0ge6ZZi/6lMwVxl6JWGkxj+90jJi4TzeoS6HVkq1TjboXjqFTpBZ5i+aG3lTR3VLhPDIszXecUK48WsR56EWRC5YpEviz6AvY9liaisWtQEZ2QWwh2tYCYv/sH7J9D/PfEg71ANU0RmyStyULBmFLpFp+ZlnALECnxlMaLqVggImhM0AYXBCfthnYmQyPKO3MNqStTesVyEeeTaz+iRij/+OoyAhNGkNJlnrqvnM7xueRfp7mUo24g4jQOYjUfW6aiSaEo3o2UCb13+bzNRQbtw6bUCYf4sxBVQbs5uI4tDwRpDZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx1wq5HLCcx0qyOnRoM9OPXeQVv7kOdTqTU8cnKyLlM=;
 b=hoK+7Vjmr87HCb/WFg8rwcnWwJbkCia1XUeK/YmDv1a8Stud4hb/8muwXEe6rQjOt5KPavkKooWqk0QRApOhQNWOc2jrNBEgmyVP6vOsCCY2XdnqLEN68zuxXJHyBDQPqIRz65wSZiWWaZDms4VZL0nHs3dWn23slxMUqf6m1pwA9m1glz3rxYq+rFDIhBD4xeaoO2yRfGYaDatlbIV0qc3AYUVT8GDI9KJJRs/Fy25dUPNVtayE29gAECEdhu9gtclqiIFlGPtOppTb6etZX+vmPVOYDy93YGylcZI3zEBK+k0V2e+MmOi8YOo9KogIO8GeYWYiO77EphHOESQeAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx1wq5HLCcx0qyOnRoM9OPXeQVv7kOdTqTU8cnKyLlM=;
 b=gYP13joCBkha8y4K0yp9hVPIi1Nt1nN8SGX78pHJ5/d0pVPjM3dE8EVJ5rvchk+ESQVd2X/uyJg5DVXF6JTZOVBo/+YAkgkIJjThCl3AIzRhLzxW56OwrTnJbIL/ctxy7Yvbu5ZLAgAw6ea69U+WBJDO+D84p5I3jnS/3m1qmo0=
Received: from TYYPR01MB7086.jpnprd01.prod.outlook.com (2603:1096:400:de::11)
 by OS0PR01MB5842.jpnprd01.prod.outlook.com (2603:1096:604:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Fri, 20 May
 2022 16:01:10 +0000
Received: from TYYPR01MB7086.jpnprd01.prod.outlook.com
 ([fe80::e180:5c8b:8ddf:7244]) by TYYPR01MB7086.jpnprd01.prod.outlook.com
 ([fe80::e180:5c8b:8ddf:7244%8]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 16:01:10 +0000
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Markus Elfring <Markus.Elfring@web.de>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "cocci@inria.fr" <cocci@inria.fr>
CC: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
	<nicolas.palix@imag.fr>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>
Thread-Topic: [cocci] [RFC] coccinelle: Add test for unnecessary check before
 calling clk_disable_unprepare()
Thread-Index: AQHYafMQ1GqDaGPIYUKMw5zLbxeQC60mn8+AgAEtr7CAACLhgIAAANuA
Date: Fri, 20 May 2022 16:01:10 +0000
Message-ID:
 <TYYPR01MB70862DC60F78A1F38F8CAA48F5D39@TYYPR01MB7086.jpnprd01.prod.outlook.com>
References: <20220517133556.6934-1-phil.edworthy@renesas.com>
 <c1d5d00d-d770-530b-abfa-0c1f462e5f22@web.de>
 <TYYPR01MB7086773272C8B95C344E663FF5D39@TYYPR01MB7086.jpnprd01.prod.outlook.com>
 <46c9b89a-a97f-1955-e231-de42be1d8e35@web.de>
In-Reply-To: <46c9b89a-a97f-1955-e231-de42be1d8e35@web.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4a2828e-a724-4a27-1fbb-08da3a79f503
x-ms-traffictypediagnostic: OS0PR01MB5842:EE_
x-microsoft-antispam-prvs:
 <OS0PR01MB58429C43D5BEF96296C7F9BAF5D39@OS0PR01MB5842.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lbKxqkzlzmuFzTlM4ak9hBX9Zr4eMLZ5Gsh6eDAh7cORtcvkwnmgTdK9r1elNr3OKLczW33sajjCc9nt94NVeGWi40J9CwHDWddPir40x7eIbuL3igvo0DIL8bEhytK8Jbz8Uz8gBhHZGQcRQLQrqVPxNux/IxV+gLuGH9hk9IJyFQ90UYN58QF5s6k5zWo1deJVkRnpiRkdRobH8aXTzOr65515FnfIR8akApymhDgVbeA3Bb7V+BcwVoU319RCGNblYZtwvCxgnTlf0NTnHz+FbiS/ZVWlpi8IRT/sF19eWXMFXgdOpZroeyf0EWXu+W2utMpwH21QIRaT1lqFfxhN6LwV59U5GXd0+yIiRoNPiCxN4c4BVn0IfeMcErZRkM6yDzfi50tuuxHyQUDP5u1h7E1v2Vz45DczfSBgXN9qLY1F30uar3qAIKjnDJh+M6HUPz4GebMr9udnv9fIVq7H9NqHLb0WNXlyxP3VQlihGqVBVyR2jRKgI8w7+VfaHBeZuKT/9UWnuHvEO+dTJRzyks5VPv5DU4Yy7GuxQBJ/9y9W0XJh2cLBgpIrp2NUGu38Tl+zR2vVL7TtqAfgZhU3/8urPyf/Mgm0DawZfKZ1WVreVwSO9wANj/i7FJrDbADm069iv5h2h86BUhNY2YE6d2dD7HnsJuEdBQpnRffKGgwqq9jzYhlGeWjAF6zEslUBJi2TNFKSYLuBHAuPmH6OTulD2ug7TldPC2W7zq1xCAG5vLNwhk54XqxHzF11IShCsffsvU/loI2W93OHNZ7UIODx7WSzAEGpOvceeVE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB7086.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(6506007)(66446008)(55016003)(122000001)(53546011)(83380400001)(8676002)(186003)(64756008)(76116006)(110136005)(508600001)(4326008)(66946007)(66556008)(66476007)(44832011)(38100700002)(316002)(38070700005)(26005)(71200400001)(966005)(5660300002)(9686003)(86362001)(8936002)(2906002)(7696005)(33656002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?2fdR8UJDpfIp1isYTaIJ7sD4Iq+A73IqwO7rU3AOK4K7q+cyNPR2qrqtQ0?=
 =?iso-8859-1?Q?cX0DZaz+UWWIaSyOpqpUXxb+w9LVvwiGnEBAkVZeRL+F4a8lPCm9QlaYwE?=
 =?iso-8859-1?Q?M9cs3ILWHwAo8SZKm7+ukusWAv1vaQfpJf6MGwllcIM/lPzTAFx/ekea5Q?=
 =?iso-8859-1?Q?GtxsSoB4S+689DnTzPM8i8d7/DRTyxu2pdulswed3M9Dju0qMNspYpxsNC?=
 =?iso-8859-1?Q?GwpDAXZYd6AytvhGH2xkGpKA5RcV3FGirt++LyrruZHSYCjQGUPjdiGnmL?=
 =?iso-8859-1?Q?iBPI2bZW1QNALJtF4ioyT5g7gufebqcraDriOZOpG9t3DIKCSoD0Hqyiyv?=
 =?iso-8859-1?Q?XJoM4yWAE8bPN3sET3eDDiwDOvnHPyv+LEgwI3NgDbTqh5n9UKiSGdSb7F?=
 =?iso-8859-1?Q?tm51yd9qyM3FYYA62Iuy7Vmk2Uet3SvxqAbn6c02/8dmoeUcLWmfDwLh7v?=
 =?iso-8859-1?Q?QfbL49W7xCFyArw4CWDl5RpcWWlt+IOKKM/04kv8xaOs4yAvuDm/gG0Liw?=
 =?iso-8859-1?Q?nhaNx10YK0zYaHn0IGH/6qpWJJ/UHnFBdBy+RNnHP0o29QecaWWTXMjIOA?=
 =?iso-8859-1?Q?AMJZFYCAN/m2ib/X/JIGBxbMliCqnbzx5KbMujQsCfzhatT/Yj+KM+vQAi?=
 =?iso-8859-1?Q?kWXg4hklLtrHs9ec96ta3tCi7c8NV6cLRsdyY8iFR6TihnwDq3OVKWP0Ce?=
 =?iso-8859-1?Q?j7vm7lI9Ja2CnrYC3k/toxZaS1cjTJr2Iv8e2AQr7saICGVQd+ESiPQTmx?=
 =?iso-8859-1?Q?FmJ0K2aFn0my8epeKBlwCjA1u2qyytuBTFvLPdbcUVqlZdxSW1yVmC8Jnf?=
 =?iso-8859-1?Q?q7LGsZek7oOPHKNr9FY4lHeEqdYEV8a1EaglsEYI2hnlxtCY6P2HgtPh0b?=
 =?iso-8859-1?Q?jc3tf8U30xL2VdJjpAD5K89+KiZA5sIARZPLpmASffMfW8YesnNI8IpW4T?=
 =?iso-8859-1?Q?kZjeUWPB6OyM6yURBKHzqKYC6lfq45vohVbv7BnP/UF66z07nqGpskk45M?=
 =?iso-8859-1?Q?MhnhrYFhnAX+De5pO1Op7bsRphl+hW1FkUlxlYPYiHk+HlWPYryYSggNqk?=
 =?iso-8859-1?Q?lYlFqP+a33Y47Ecmev6M4tGhSGvD3ujHVj1bq1dOw3whbeqNVbwqq9UUWY?=
 =?iso-8859-1?Q?vhkQXvc3+0HJBCsASQvhPMsj7SJbhZdZORXGtNPQkOf4yPAyi6KTHgyWoP?=
 =?iso-8859-1?Q?bAgawZPGTpjmRt3rT95qNMlrAUH8MSaOZinvZZqE/xBW8B5kYxEOwP1ZDV?=
 =?iso-8859-1?Q?85BSV2hHMsSqh2RTz416OTG+hH1ze4Jbcu2TVcGOr5o49aceifMXmV0ufb?=
 =?iso-8859-1?Q?SLn2et8+ywfHD5PdFAVRSSrV4Y0OKjhICb/FBbR1Y3kRAxV6nLIO9Rm6w6?=
 =?iso-8859-1?Q?oTsSWPg9I1F4tZjov/oVTozpIg0zhfH0ZPhi8FofNOM0Lw+380qfXbchIo?=
 =?iso-8859-1?Q?sRpPkjYjUkVizhsyaxBy66Wu5XFVfgKKSFmUEZrEsXWcNuvuoDylKl3Q/b?=
 =?iso-8859-1?Q?ByFcxPkxH1UvCVyRYGUH/dDv9s3a4r3fLtOQfPOZH0SiJGS0m2dc6eMfYL?=
 =?iso-8859-1?Q?LQVgMNdgj07rFnw3EhvzkW/VU0S6Keo/xxwIoDW7t9DOg0nEQdy/+vbGDx?=
 =?iso-8859-1?Q?1n+zBuYCcEUBMg9rOTQEHA1QwEqgSMAYn9fQRHMwDueTxcluRB/IMtQIaR?=
 =?iso-8859-1?Q?dchukvCrC0owDP3NTp0T4gWXDouk94KYXIw04y6du7uO+Bq5jJL+uxz+AD?=
 =?iso-8859-1?Q?tnTLBxD9Z/ghRYRdO/AQp6nLGQZj4hLPTMpQ1uciYf+OSyKWW386xXSmwd?=
 =?iso-8859-1?Q?ED2JXFBgROwOMh0pUtm6IZVglZzxj/4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB7086.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a2828e-a724-4a27-1fbb-08da3a79f503
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 16:01:10.2110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vfofW0XWIzN9X5VJYlcMvW4YwHaiS6yB2SaCIYrSOXTZ/o6/rjwEBWC3nC6LXpW9ysPAfbHq5M08c1Nyyfar7zvKPuF1Bq3Mt9shPEHZxVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5842
X-Validation-by: julia.lawall@inria.fr
Subject: RE: [cocci] [RFC] coccinelle: Add test for unnecessary check before
 calling clk_disable_unprepare()
Reply-To: Phil Edworthy <phil.edworthy@renesas.com>
X-Loop: cocci@inria.fr
X-Sequence: 407
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/TYYPR01MB70862DC60F78A1F38F8CAA48F5D39%40TYYPR01MB7086.jpnprd01.prod.outlook.com>

Hi Markus

On 20 May 2022 16:56 Markus Elfring wrote:
> >> I guess that you would like to mark the curly brackets also for
> deletion.
> >>
> >> How do you think about to handle simple and compound statements with
> your
> >> source code transformation approach?
> > Since we only want to transform code that just calls
> clk_disable_unprepare
> > and nothing else, we tend not to have much code like that, but point
> taken!
> > Sorry, but my coccinelle skills are only a few days old so I'll need to
> > work out how to do that.
>=20
>=20
> I suggest to become more familiar with applications of disjunctions also
> together with the semantic patch language.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/82e87d4b0a9c978b0015=
11270c652a93e72fe64d/docs/manual/cocci_syntax.tex#L1039
>=20
> Example of SmPL code:
> (
> -if ( \( !clk \| clk !=3D NULL \| !IS_ERR(clk)=A0 \| !IS_ERR_OR_NULL(clk)=
 \) )
> =A0clk_disable_unprepare(clk);
> |
> -if ( \( !clk \| clk !=3D NULL \| !IS_ERR(clk)=A0 \| !IS_ERR_OR_NULL(clk)=
 \) )
> -{
> =A0clk_disable_unprepare(clk);
> -}
> )
Thanks, I'll have a read.

> By the way:
> Would you like to add a SmPL rule for the operation mode "context"?
Right.


> >>> +@script:python depends on report@
> >>> +p1 << r.p1;
> >>> +p2 << r.p2;
> >>> +@@
> >>> +
> >>> +msg =3D "ERROR: clk_disable_unprepare already checks for valid ptr s=
o
> >>> +check on line %s is not needed" % (p1[0].line)
> >> I imagine that it can be a bit clearer to split the message into two
> >> sentences.
> >>
> >> Can a line break help here?
> > Sorry, I don't follow you. Perhaps you could make a suggestion for what
> > you want?
>=20
>=20
> The support might be unclear for multi-line messages.
>=20
> How do you think about the following code variant?
>=20
>=20
> coccilib.report.print_report(p2[0],
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 "ERROR: clk_disable_unprepare() already
> checks for valid pointer. Thus the repeated check is not needed on line
> %s." % (p1[0].line))
Looks ok to me

Thanks
Phil
