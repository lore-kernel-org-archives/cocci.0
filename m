Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384B6C43334
	for <cocci@archiver.kernel.org>; Wed, 29 Jun 2022 14:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=m5VhDBCEU1TMiepeofgTQLWvQuWOqke8MN9WsTowCss=;
  b=p/2SmtTn0UQEJcUzfp9Zp8XZDDTWe4o7lBzAx8Q2GnvACApBEZk5RgDb
   eiGKJdKmUZ57EQNpcChbqNN+vOs9i9gLumiH4+GWXgJodggoNZ581wx+g
   1BGfkEeZb3jkBOcTRd7hoFEg3PwcZgkNngmi0uVPDAk+8C877lY3GxoWM
   w=;
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
   d="scan'208";a="43455037"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jun 2022 16:31:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0B135E436F; Wed, 29 Jun 2022 16:31:01 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1E92EE00BE
	for <cocci@sympa.inria.fr>; Tue, 28 Jun 2022 18:42:54 +0200 (CEST)
IronPort-SDR: /5Q5Tx/IyfkAiRcqJ2wgd48E9u9sIr776azL+Q7iGZS715zMPzLO3JbdpxRhzqK1L0u1rcMeej
 H/iQSsSfu1Gp7L9uUXGdXJ6e7Ebe4gBS8zM5Og3IIDg9JySiurnVu1r6/1KH2VaHC1lvhu4F96
 o3Z0h1TtGu8wVDv4y6AIgmHO/eyuC5u7fPticp7u4YnBuGOZbTaNw+5E0EvNb4rO7hzZNn0LVU
 P6ITHBzSZYMCOrhqyynU4ZOVVYVWVyGt6R/TI6ymkbSHzjb9rE9gw1zYOKtjEg5XGqZnA2k/uY
 cIAUkGDT52ZVew/7mLrMxDCx
X-IPAS-Result: =?us-ascii?q?A0BcAAAgL7tih4cGayhaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YFRUn9ZKgMHCESIGgOFMYULgwIDnm4LAQMBCwJCBAEBhQMChUsfBgEEMwYOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQELDQkFCAoHDhAFP?=
 =?us-ascii?q?GSBCAGBTgGBUwsDMQ2CNSkBg2MBAQEBAwwGFRkBATcBDwIBCBEEAQEvMh0IA?=
 =?us-ascii?q?gQBDQUIEweCW4MZBAKgYQGBPwICih14gQEygQGCCAEBBgQEh14JgT0BilqEH?=
 =?us-ascii?q?oJQgRVDeYE+MD6BD4M1AoQLgi6Rb4VIgjE5A0cvEoEgbgEIBgYHCgUwBgIMG?=
 =?us-ascii?q?BQEAhMSUxwCEgwKGw5UFwwPAxIDEQEHAgkSCBUrCAMCAwgDAgMgCwIDFgkHC?=
 =?us-ascii?q?gMdCAocEhAUAgQRHgsIAxkeLAkCBA4DQggLCgMRBAMTGAkWCBAEBgMILw0nC?=
 =?us-ascii?q?wMFDw0BBgMGAgUFAQMgAxQDBSQHAyEPJg0NBBsHHQMDBSUDAgIbBwICAwIGF?=
 =?us-ascii?q?QYCAm4uDQgECAQ3JA8FAgcvBQQvAh4EBQYRCAIWAgYEBQIEBBYCEAgCCCcXB?=
 =?us-ascii?q?xMzGQEFWRAJIRwpCgYFBhYDIXAFRQ8oNDY8LB8bCoEaLCsWAwQEAwIGGgMDI?=
 =?us-ascii?q?gISKQY7BQQfAZsXAXEBAYENeaJggTOfIAcpgyigMxWoZJZxIKZ3AgQCBAUCD?=
 =?us-ascii?q?gEBBoF3gX9wgzhOAQIBAg0BAgIDAQIBAQEJAQEBAY4dDA0JFYM7il5CMzsCB?=
 =?us-ascii?q?gEKAQEDCY8BAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:tCI3P6PrcfH8VKjvrR2rksFynXyQoLVcMsEvi/4bfWQNrUomg2EEz
 TQYWGvSO62MazP1fIx/Ody1oxsD6JXSnIc1THM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/vgqoPUUIYoAAgoLeNfYHpn2EgLd9IR2NYy24DnWVPV4
 7senuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB3Slo92w
 cxOsKeOQFkRfaaWibo9T0dhRnQW0a1uoNcrIFCSjPbLkwjqWSCpxP9jSkYrIYcf5+B7R3lU8
 uAVIywMaRbFgP+qxLW8Sa9ngcFLwMvDYNtZ4yk/i2+fVK17KXzAa/2iCdtw3joqi8VfW/LTa
 cMEczdHahncagFKPREcD5dWcOKA2iKlI2AJ9AP9Sawf6mniwz5DiqTXYdeKUOC0FeBWv3mln
 zeTl4j+KkpDb4fAodafyVqngeTEnAvgSYcKHfu58ORriRud3AQ7DBQJXF+/ieu4j0SkUpReL
 VYV82wgt8APGFeDS9D8W1i1p2aOsQRCA4MLTqs99R2HzbfS70CBHG8YQzVdadsg8sgrWTgt0
 VzPlNTsbdByjFGLYSmUqbCdtDC3AhYcc1dBbnUVEysZveC29enfkSnzZtpkFae0iPj8Fjfx3
 y2GoUACa1M73ZFjO0KTrQ+vvt68mnTaZlNuvV6IDgpJ+is8OtT4NtTABU3zt64oEWqPcrWWl
 Fkp8yR0xMwTB5WMkkRhq80hROvBCxqtFDDdh0VzEoNJythA03uqfIQV7TZmLkhzbJ5dImKvZ
 1LPswRM4pMVJGGtcaJ8f4O2DYIt0LTkEtPmEPvTa7Kig6SdlifYo0mChmbJgwgBdXTAd4liY
 /93lu7xVx4n5VxPlmbeegvk+eZDKtoC7W3SX4vn6B+szKCTYnWYIZ9cbgbQNb1lsvna+FuFm
 zq6Cyds40UPOAEZSnmHmbP/0XhRdRDX+Liq9pcGLb/ZemKK5kl4VaGLn+NJl3NZc1R9zb6Tp
 S7Vtr5wzVv0n3rcLguWIntkcqvoR59jrHU9VRHAzn75s0XPlb2Htf9FH7NuJedP3LU6kZZcE
 qdZE+3dXKUnYmmWo1w1MMimxKQ/JUTDrVzUY0KNPmNlF7Y+HFOhxzMRVlCynMX4JnHr7pRWT
 nzJ/l+zfKfvsCw7U5iINKv2kQPr1ZXf8corN3b1zhBoUB2E2OBXx+bZ15fb+ukAdkfOwCW0z
 QGTDUtKrOXBudZsot/EmamYqoDvGOx7RxIIE27e5LewFC/b4mv6mtccCL7TIm+HWTOm4rima
 MVU0+r4bK8NkmFMvtcuCL1s168/u4biquYCnARpFXnGdXqxDbZkLiXU1MVDrPQUlLlUpQKqX
 0XJ8d5fYO3bNMTgGV8XBQwkcuXajqlIwmGJsqtvLRyjtiFt/beBXUFDBDW2iXRQfOlvLYco4
 eY9o8pKuQaxvRwnb4SdhSdO+mXQc3ENXvl1tpweB4O32AMnxksePM7xNxWuvNSjQY4JNUMnZ
 DiJmKDFmrJQgFLYdGY+HmTM2uwbgokSvBdNzxkJIFHQwojJgfo+3Rtw9zUrT1sKkUwXib4rY
 mU7ZVdoIaiu/itzgJcRUm2pHTZHDkLL90H0zWwPi2CEHVKjUXbALTFmNOvRrloV9XlQImpS8
 L2ClDa3VD/reIT82TM4VlQ786W4EJp26xHIn92hE4KdBZ4mbDH5g6ioI20Vtx/gBsB3j0rC/
 LE48OF1YKz9FCgRv6xkVNbDhe5MEEiJdD5YXPVs3KIVBmWDKjy/3D65LUruKM5AIvr991C1V
 p51LcVVWhXijyuDo1j330LXz2OYQRLo2DYDRl8vDUM7iePD6xZD69fX/CW4g3I3SdJzl8p7M
 pnWaz+JDm2Xgz1ThnPJq85HfGG/ZLHooSXiifut/rxh+40r6YlRnYMai9NYfEl59CNh8g6do
 AbEIaTRyoSODKxyypD0HPwr6xqccLvOuSfhzOx3m9JDcdrTNMCIvAQQwrUi08K6IpNJM+lKe
 X+xXBIbEa8LUHvak4wUpnVZK5R02A==
IronPort-HdrOrdr: A9a23:a6NL3q0ROfJUFNA1UX8sBwqjBTVyeYIsimQD101hICG9Lfb0qy
 n+pp4mPEHP4wr5AEtQ4uxpOMG7MBDhHO1OkPMs1NCZLUPbUQqTXcpfBO7ZrwEIdBeOkdK1uZ
 0AT0E6MqyJMbEYt7e23ODbKadH/DDvysnB6onjJjVWPHhXgspbnmVE43OgYylLrX59dP8E/f
 SnhvZvln6FQzA6f867Dn4KU6zovNvQjq/rZhYAGloO9BSOpSnA0s+0LzGomjMlFx9fy7Yr9m
 bI1ybj4L+4jv29whjAk0fO8pVtnsf7wNcrPr3DtiFVEESstu+bXvUjZ1SwhkF2nAhp0idurD
 D4mWZhAy200QKUQoj6m2qr5+Cq6kdS15ar8y7lvZKkm720eNtyMbs+uWpUHyGplHYIrZVy1r
 lG0HmesIcSBRTcnD7l79yNTB1ykFGoyEBS59L7okYvJbf2UoUh2rA37QdQCtMNDSj64IcoHK
 1nC9zd/u9fdRefY2rCtmdizdSwVjBrdy32CnQqq4iQyXxbjXp5x0wXyIgWmWoB7os0T91B6/
 7fOqplmblSRosdbL57Bu0GXcyrY1a9CC7kISaXOxDqBasHM3XCp9r+56g0/vijfNgSwJ47iP
 36ISZlXK4JCjDT4OG1re12G0r2MRSAtBzWu7Jj26Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,229,1650924000"; 
   d="scan'208";a="43285949"
X-MGA-submission: =?us-ascii?q?MDHI46E7kEd+W3R+7h9ttAfFAxhvJ4tVD0ttVQ?=
 =?us-ascii?q?59QvyeVEJSvMNTIUs7USXXYUWwUikto68SnlRAry0ecEcALd8bJR6IKK?=
 =?us-ascii?q?HqtbNhN3+zuWLeqCPIPTeK88xcwdATlSJkt3OJKltekaveFnL0mFLhc1?=
 =?us-ascii?q?SlY7EorbXb6vCbtc1bYNeY1w=3D=3D?=
Received: from mail-eopbgr60135.outbound.protection.outlook.com (HELO EUR04-DB3-obe.outbound.protection.outlook.com) ([40.107.6.135])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 18:42:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcxZvInfBA8vW8zSZBkNctRMPF+kcg/u3m7/3y3lYC+c4a6RGRf3jVn0fH8/bQAtz3A7HZPMoL4ju6xqgzPKwZ52pU+bvNfO4k64cxqv+QPuxfv8+G/BynAEv4AR1WIsuPLKss7+2Edh71Zvt7Fy0qc6/jdS8RPinT4pvAdH1UN6muOIoZLujTOPWA8Ximqp+AS7oG/XqGWr8qr6tZvQ7WK5x0dXkDpvZtCa/hEp4OBoZrT2cebH4fp19wxGoHIlfKsytg5D4efcVkKhvzV6Mn2W8uxXy49mXeFIiMf688Dh/E3yD3gBlbYIzUo0Z2huiXb6oqOs5JfxvjaeRkz6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5VhDBCEU1TMiepeofgTQLWvQuWOqke8MN9WsTowCss=;
 b=aRobaw9Owk/zlomHkoXGt2h+ebD0PbYIzpV0jBv34wDLlhLbn+zXTgh4lSSqPRGpeRayh8qIf/CDl5LenGBdaP8C93Xaj1hsIMkGVUkIZrTNKDIoU7XjaQYoP1JiGNKcPx5UyxGJCDeugiiR8GYBIsMQXmiBqsGTr3wkxA1IfBvybUCw+ROKNxJxVixlmJDI8c42AryBF9pYlYLOQe8H40zNkPwYjqRVUKs/vu6SC38e9j8nfIyVaQ1doPR98PWF5aQE80pgDvSxjKoSfxpU7afGPc11LVcl6/ITitBUkf2IuFKD22p7Xf12cUld4dqDbJbgp3V92ZRSIPGTG4hyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netatmo.com; dmarc=pass action=none header.from=netatmo.com;
 dkim=pass header.d=netatmo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netatmo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5VhDBCEU1TMiepeofgTQLWvQuWOqke8MN9WsTowCss=;
 b=oO8usbn1dVywfgn4A6sP89I31seakah1fjXs+eXetczSVssSBUXwRp52ZMZP05SEzAYDT41EOhSN/dXhxW0nZ0kIAjzwnCVpUEyyPGOMghWLUtWDZiFe1X7eahbunh2Q2jKYmrEx7uVIWydRM+uyCWoyfRZKD65A6JzfkE+xbBs=
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com (2603:10a6:20b:34e::15)
 by AS8PR03MB7079.eurprd03.prod.outlook.com (2603:10a6:20b:291::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 16:42:52 +0000
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::8175:20e5:60ec:b87d]) by AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::8175:20e5:60ec:b87d%9]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 16:42:52 +0000
From: =?iso-8859-1?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
To: Julia Lawall <julia.lawall@inria.fr>, Nicolas Palix
	<nicolas.palix@imag.fr>
CC: Markus Elfring <Markus.Elfring@web.de>, "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: [PATCH v4] coccinelle: Extend address test from ifaddr semantic
 patch to test expressions
Thread-Index: AQHYhx/sYXozXHdjsU6hCbxgevq7Za1lDaHV
Date: Tue, 28 Jun 2022 16:42:52 +0000
Message-ID:
 <AS8PR03MB76032BE6B27D43AD020D810D93B89@AS8PR03MB7603.eurprd03.prod.outlook.com>
References:
 <AS8PR03MB76039ED18663E85F7E8234CF93B59@AS8PR03MB7603.eurprd03.prod.outlook.com>
In-Reply-To:
 <AS8PR03MB76039ED18663E85F7E8234CF93B59@AS8PR03MB7603.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecb1abcb-7049-47c6-9e6a-08da59253e96
x-ms-traffictypediagnostic: AS8PR03MB7079:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yBQr7UeeVlr5yWEqExCGALcILQSDg1/uW6uQwUrqCGUVHYu06RK7kJRPI/OL/+rQTpBoU3wfA+lJ00AnZLOGZghD1OWP70itnlOzyic2yLx27OqToc6Hl+2EuTeEPYR+cp+XR5yiONTzHWCSO9Ud3SMnFylPlgIuJFiqxfx8GKrqoSfEbuMOSWYHScP2t8lZT0S6o29ytI/j2GEdFJFMhLpAu2/tu+HZRYVycvLLrMkkOi/48SbweRhaW+yQkkRtXh4CDU9Hj62gQe/BW7GRjwpAwxreLvbxGsufDC1ZsdGkTj6WoIDOcFYImHO2tVt05qjwAMMcVn/6DxHy8CLDcdbBO39p4iGUPpLhCzwmL/4K2zDjThlx+ngydvSUDilAKZcOkkNAU0uzl7INeRKXtnXdbooQ8hlq8DAX/k390hBhZw8ue8h1bKJnKidejf+Ntx5JzVmVENvzNhPtsVkbXgtMHsV76E0gwe1Y8xTAa/RFIeuSIYpUoVaXIbkA12zQ75jW8yOzko8ylsTzkgjbe2FeGRfyk7lEr1j0DinyXRt5OvNVJgwGwdUBWDJGgvjGa5aCJH5HnO+q3ylBUIyIqBxPfggO0ocDAK9GOXD0eEEf6+esibIEAoqJ54uVWQPnS9Cv4awX6mQwh+e4k/9G8C8lCmrzT2ixHfhUEiSGpog3KJrimezDMTLX7AMc54KrNlmwPT3ClN8zKuNCqG6wNUP6kSt8dzz9Kk/xg2yIPUKgG0gFMpDjqAZa7BQ78r8P1l2T6GC2BIOE8Gy/cTMu7kXgbal/W9uVwgExL1OrMtA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7603.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(376002)(346002)(39850400004)(66446008)(186003)(55016003)(5660300002)(4326008)(9686003)(26005)(110136005)(66476007)(54906003)(52536014)(478600001)(33656002)(122000001)(38070700005)(86362001)(6506007)(55236004)(71200400001)(38100700002)(64756008)(83380400001)(53546011)(91956017)(8936002)(8676002)(76116006)(41300700001)(66946007)(66556008)(2906002)(7696005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?n+Ea22USUIXnS2obR9rn5h0V+5Hr3LraeFj9k1ycMhZ2c5T85t3HZUD1nh?=
 =?iso-8859-1?Q?4/NP9ySRonxSCmSqmQRSSs2KCeRC/cvKy9Ok3YtEhg1gXD2GXQapCNPDzN?=
 =?iso-8859-1?Q?DOdL/5WF9tUw4i0CjtKJm8wGme4f+zmuDKnEINWY7Q0MzWI6UDYlnqzN/2?=
 =?iso-8859-1?Q?cEyy4ljkCUY+6FMtn77rhNecG31KqeRvO3rtQ07qY+6KsQooRgTtH+cyvW?=
 =?iso-8859-1?Q?CTsmdTLZ0xZUjV+ge1/VLC0Dl2Kjqm5MDETi2fMAEuLLCP1JXt57iVKniK?=
 =?iso-8859-1?Q?0l/rEBpOiOf09Uqj8zwAgOmI+tunu4I9F/qlIOlh06PIAZjmdVFNPUb4UX?=
 =?iso-8859-1?Q?r/4BUJjUqE/GbCGUpA5xHLiJIn74ZjwJO3todyFAC1lhV+v2wyd4zvm2lD?=
 =?iso-8859-1?Q?F+s96LGWjaELPom+Nu/5+k/0ojotjNxwm2uljsJFQJe2F6AWw+4ztzFAsp?=
 =?iso-8859-1?Q?jpcAzHV1jyMMsWgL8aS9Wuw/dEGMdH5mgFVuE91ph3KrDZgLu/R3TtbtSp?=
 =?iso-8859-1?Q?IPcyAA7Cqa2LXoJ2r6gIA63pHFnFh74KehomqGdB9paeOxOYpgyY5asi29?=
 =?iso-8859-1?Q?AJ2cV01C1TCJJv0QmAZSrij3jtK2XY40nFPGBBl17JKrh1ubk6OEDqx+NC?=
 =?iso-8859-1?Q?M7/NVs8KwQw7K7pXF3VSZMxHOmPRPDVep3/w+HzYkbPRqGHhK5SPbFPu1b?=
 =?iso-8859-1?Q?vlBufzepc2RW2y7HZDB75eH3DEuzsjI6LptWMEpupKwfkkIBi4JalvrNXl?=
 =?iso-8859-1?Q?Kz9EwTf/fTn5ovZISFlLzinC1YEHCqZ/zewKfnpQe9WiVIIZVyvkDW1v60?=
 =?iso-8859-1?Q?wWQyOxrYWVA4kuc/F47qMTCeCxm05YgFpFJULvUWgKU/xF///pVOVg+ETo?=
 =?iso-8859-1?Q?H6nSatD+eP0tkG1J9ry7KhyOg31VYE5U91wIZIguBCS0GoW7OUqzj/gRVh?=
 =?iso-8859-1?Q?6MlsjsJnqvIZmoVIaFtaR3DMdB5lhR0SUMYbE+NxHQoMnVR3LCsZW+FPWa?=
 =?iso-8859-1?Q?GueiB+HGvFYLSnX1pfPQ7el9OG9WB9ii8n69EmmhlnY6feg9hnAxslqmvo?=
 =?iso-8859-1?Q?iaFQVwjI6yPobshc9e/ngquyx5Or6g7FcDhs3J77lktF+eQNcHMQ/QMrie?=
 =?iso-8859-1?Q?rt9pJFKSVPua2UsH4sWYwRLc6giZTl6uwO1hgsza+zzr2lBqrhDugl7RYv?=
 =?iso-8859-1?Q?tYnGT99rCnv3vEkr85AP0E+XlMdU161WGPCIBfbGrRkdUh58ST/Qeor2bJ?=
 =?iso-8859-1?Q?v0rjV1h29gG2K4Fjx1VAlVtAyjk/EPnJK9hAhaM7HZGNEAGy0mAKJ0Inql?=
 =?iso-8859-1?Q?2JnweOtrEhAwNZIifVoe+iAn+CDk4T4egfZzmlgsp632+73VuVZ6zbug5E?=
 =?iso-8859-1?Q?nf+V0NuVxwnUdLG6hCRLxCCtEMdy4A47gGbwEfSeKMIXynnINVDt2SvIWj?=
 =?iso-8859-1?Q?hDxCGODMlC+3vuQsSCBcR9ZoR7fRg1hjkKR2mw6EgYBla9RBoBqxP2LEn6?=
 =?iso-8859-1?Q?DxqPgTwrMc/Dchy/uPD9l/gVW0wELNDm6mMuYI2VeJBn/mCLXOLTOJdRHC?=
 =?iso-8859-1?Q?NIoyYLaHQ9EmpTN5+JT0/Yw43uyUEzxb4+FhD+GvK+LxYuUZiHkIJQlGvx?=
 =?iso-8859-1?Q?Dud3W6qhf3A3Q8yrdtHjyel0zFWo3b0j+4uJ52Gu33Dgsylj4JkyMk8Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netatmo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7603.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb1abcb-7049-47c6-9e6a-08da59253e96
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 16:42:52.4754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4528446a-2666-441f-95cd-cc2cbd9f2c49
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h8H69chD//z64enC35FdsS2nqSAwMwPHp4brbyGzjLN73yHXvPmCEm26cZG7bOieXGtBqEpJ2mmakBACz+mX6mhnFsVZKvM6jBmweWww7Lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7079
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v4] coccinelle: Extend address test from ifaddr
 semantic patch to test expressions
Reply-To: =?iso-8859-1?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
X-Loop: cocci@inria.fr
X-Sequence: 464
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/AS8PR03MB76032BE6B27D43AD020D810D93B89%40AS8PR03MB7603.eurprd03.prod.outlook.com>

> -*if@p (&x)
> - S1 else S2
> +*&x@p || ...

I did additional tests and this version does not match explicit check
for NULL in if conditions such as `if (&my_var =3D=3D NULL)`. But it matche=
s
explicit check for non-NULL such as `if (&my_var !=3D NULL)`. I don't know
why the `=3D=3D` and `!=3D` cases are different. Do you have any idea Julia=
?

This limitation could be avoided with an explicit test to NULL in the
semantic patch:
*\(&x@p || ... \| &x =3D=3D NULL@p || ... \)

Would it be the best solution?

Thank you,
J=E9r=E9my

________________________________________
From: J=E9r=E9my LEFAURE
Sent: Thursday, June 23, 2022 18:42
To: Julia Lawall; Nicolas Palix
Cc: Markus Elfring; cocci@inria.fr
Subject: [PATCH v4] coccinelle: Extend address test from ifaddr semantic pa=
tch to test expressions

The test of an expression's address does not necessarily represent the
whole condition, it may only be a part of it. Also, an expression's
address is likely to be non-zero in every test expression, not only in
if statements.

This change aims at detecting an address test in more complex conditions
for every test expression.

Signed-off-by: J=E9r=E9my Lefaure <jeremy.lefaure@netatmo.com>
---
v3 -> v4: Improve patch subject
v2 -> v3: Apply Julia's suggestion to have a more generic solution + adapt
commit message and file name to this new solution.
v1 -> v2: Moved disjunction on the condition itself instead of being on the
if statements.

 scripts/coccinelle/misc/{ifaddr.cocci =3D> test_addr.cocci} | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)
 rename scripts/coccinelle/misc/{ifaddr.cocci =3D> test_addr.cocci} (94%)

diff --git a/scripts/coccinelle/misc/ifaddr.cocci b/scripts/coccinelle/misc=
/test_addr.cocci
similarity index 94%
rename from scripts/coccinelle/misc/ifaddr.cocci
rename to scripts/coccinelle/misc/test_addr.cocci
index fc92e8fcbfcb..2d0ec86d1701 100644
--- a/scripts/coccinelle/misc/ifaddr.cocci
+++ b/scripts/coccinelle/misc/test_addr.cocci
@@ -14,12 +14,10 @@ virtual context

 @r@
 expression x;
-statement S1,S2;
 position p;
 @@

-*if@p (&x)
- S1 else S2
+*&x@p || ...

 @script:python depends on org@
 p << r.p;
--
2.25.1
