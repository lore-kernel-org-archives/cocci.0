Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B5EC433EF
	for <cocci@archiver.kernel.org>; Sat, 25 Jun 2022 12:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=C+e9+60fmPpm9fSWqQGR24K0YEUa9AHVQhWVqDyKuI4=;
  b=offvAl8jqiYYbBT0hk5e2HGA+6YWFsouVfdEVoPE9K/7kQUeH8AVjjb4
   AnhuuAv/emYaXJ7BdGNPvEgqg4QZ3mWnrEmhyXaTMPP5dW4EjAzX7OvHh
   6g9yiXTrsAqj5zbBmaxYAgK/uj/HrLcg6fnnnoBJL7NXRqxykVcGb3hr8
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@netatmo.com
X-IronPort-AV: E=Sophos;i="5.92,222,1650924000"; 
   d="scan'208";a="42838426"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jun 2022 14:33:52 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 28CDAE00F5; Sat, 25 Jun 2022 14:33:52 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id ECB5FE7E61
	for <cocci@sympa.inria.fr>; Thu, 23 Jun 2022 18:17:54 +0200 (CEST)
IronPort-SDR: SWKXp06t9IAK9K+DEdMbpKNe+B0X/YcbK02+BUTLm/0VSI7PAdyg8FqUJsPr6N3iUc6fuiPO8I
 tndm0sjhrRVeC3UZ5XqV2eAczm10ANxVFf+85aXMw/83i48FGCtvDhPcEVG3VUnSsj5OG4WbtK
 60mMfC9s8uZjhEmPeO71jskg6k9SECsv3Lh4Pap5HiFxB8CMlH00IxMdpnGsMAxsM0i8/asS4U
 ETGu7p+bteiKEXVWe1JraPElu6GRmEz1ojIVbPb311Nd9vmeDqo+QDFFpOhAHQasz6mFgQEhXI
 Wj+TKoAR6CH/iWHy27M08ng1
X-IPAS-Result: =?us-ascii?q?A0BHAQDHkbRih1wIayhagQmBT4FSUn9ZKgMHCESEET2DT?=
 =?us-ascii?q?AOFMYUKgwWcboF8CwEDAQsCQgQBAYIPgnACAgIWhTUfBgEEMgcOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQENCwkFCAoHDhAFPGSBCAGBT?=
 =?us-ascii?q?gGBUwsDMQ2CNSkBg2QBAQECAQwGEREMAQE3AQ8CAQYCGgImAgICMBUQAgQBD?=
 =?us-ascii?q?Q0agluCdiMEApBGjzkBgT8CAosXgTGBAYIIAQEGBASGPoEfCYERLIdKhyuCU?=
 =?us-ascii?q?IFYgjcwPoEPgzUCg1Q3gi6Rb4cHHDkDRy8SgSBuAQgGBgcKBTAGAgwYFAQCE?=
 =?us-ascii?q?xJNBhwCEgwKBhUOQhIXDA8DEgMRAQcCCRIIFSsIAwIDCAMCAyALAgMWCQcKA?=
 =?us-ascii?q?x0IChwSEBQCBBEeCwgDGR4sCQIEDgNACAsKAxEEAxMYCRYIEAQGAwgvDScLA?=
 =?us-ascii?q?wUPDQEGAwYCBQUBAyADFAMFJAcDIQ8mDQ0EGwcdAwMFJQMCAhsHAgIDAgYVB?=
 =?us-ascii?q?gICGFYuDQgECAQYHyQPBQIHLwUELwIeBAUGEQgCFgIGBAUCBAQWAhAIAggnF?=
 =?us-ascii?q?wcTMxkBBVkQCSEWBikKBgUGFgMjSCYFRQ8oMwE2PCMJHxsKgRssCSIYAwQEA?=
 =?us-ascii?q?wIGHgMDJwUEHwEbmiNrCINMDJZFqxoHKYJBZ6AwFahklnAgoWiFCgIEAgQFA?=
 =?us-ascii?q?g4BAQaBaAOCC3CDOE4BAgECDQECAgMBAgEBAQkBAQEBjjYegzuKXkIzOwIGA?=
 =?us-ascii?q?QoBAQMJgjqMRwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:FzNSqq+r/PjT2OlIHrRuk+Ffdb1zdoMgy1knxilNoENuH/Bwxv
 rFoB1E73TJYW4qKQodcdDpAtjifZquz+8O3WB3B8bpYOCGghriEGgG1+ffKlLbakrDH4JmtJ
 uINpIOcOEYbmIKwPoSgjPIderIqePvmM/HuQ6d9QYVcegAUdAD0+4NMHf+LqQAfngiOXNWLv
 qhz/sCgwDlVWUcb8y9CHVAdfPEvcf3mJXvZgNDLwI76SGV5AnYp4LSIly95FMzQjlPybAt/S
 zuiAri/JiutPm911v1y3LT1ZJLg9Hso+EzSvBky/JlawkEuDzYJ7iJaIfy/gzdZ9vfrWrCpe
 O84yvI+f4Dr085MFvF5icFkDOQrQrGo0WStWNwx0GT7fARDQhKdfaoie9iA2Tkwltls9dm3K
 1R2WWF85JREBPbhSz4o8PFThdwiyOP0AwfeMMo/ghiuLElGchshJ1a+FkQHIYLHSr85oxiGO
 5yDNvE7PITdV+BdXjWsmRm3dTpBx0Ib1+7a1lHvtbQ3yldnXh/wUddzMsDnm0Y/JZ4T5Vf/e
 zLPqlhibkLRM4LaqB2AvsHXKKMeyXwaAOJNHjXLUXsFakBNX6Io5nr4K8t7OXvY5AMxItaou
 W1bLqZjx9BR6vDM7z/4HQQyGG9fIyUZ0Wf9v1j
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,216,1650924000"; 
   d="scan'208";a="17623478"
X-MGA-submission: =?us-ascii?q?MDHWFC0M/aOwNwnDgfGeA2J4g36/Ta+hRUuWSJ?=
 =?us-ascii?q?6tZscWWVnI/jx47+Co4CbwOG1cyBAyQ3Muv252KUJzFZGtIsGucDwFa2?=
 =?us-ascii?q?8TxUT+SZJmv4j3WZ+jbuDL8eSqhWdIAOHrmuy64Ob2org5+f9k1dnPJN?=
 =?us-ascii?q?tOuvdeBz3YQsKpOJZcdLSUxQ=3D=3D?=
Received: from mail-eopbgr80092.outbound.protection.outlook.com (HELO EUR04-VI1-obe.outbound.protection.outlook.com) ([40.107.8.92])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 18:17:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXqJGKRnKFpBrUmszLcz4u3MGjhnP5mJCXJp/CO8KfClcXubCVIdUkMK1Kgm7+CMXVeuoLjjjQd+xbckyOlY9vkoF/zVZXAYJXj86Efq+4zIpIwFPgrFKQ9WaLlBkndQDVK5DAQA+Geec/eBS12h2Tzt7gpW4ky9gK5imhYo0xklYwNqi6jRU+q+ITVwtJBpNMMRwfHWfCEZ0h+9Xy9/48mr7cRx0dRScJ+9pssAkvwEUnkrJ8bsOSRliKLZoZ78sB9QCgflqvaezxzAMZZ72/5Oq5tFs9hj+HZPxH/g/B5bBOxxCpiwJXjfFQxHIm4w+mftCzVTk8iUPecD0IrKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+e9+60fmPpm9fSWqQGR24K0YEUa9AHVQhWVqDyKuI4=;
 b=ENssDfBlXamuhL7ZDkrWQdN9Tdkq8Zqfum4F5kaLu6IWr70VsvrEAgtAB2r+eke7wCeIhFA6s0LBBVE5YDFh0gT3oX87nJaxozjap0k/cpZcyJPNhtWzZKyAFnGa6tB7w1M/KeQuNTzW3BwebVMuSWoZaomJnQyCMr/HopPrEsL108WjFbmyBnibjj3Q0fr+DfZzUW3TjSa4gpSlFtWtJ5CNbX7FFwLydqWEwz9ABY/WBOdXkMhatCmC5IDg5tRfOh40hzfEr7uOd8RbwUjpoopGYPPpJuFMhm8CUtg6yM7ugkIPXqHOaPxWuLE0AGCHAlN2pGlLykGTzyvYYvxS3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netatmo.com; dmarc=pass action=none header.from=netatmo.com;
 dkim=pass header.d=netatmo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netatmo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+e9+60fmPpm9fSWqQGR24K0YEUa9AHVQhWVqDyKuI4=;
 b=fbnuWyi8t0bTT+fZ77NqqQ8SxhSy9L2UAlwoEDMmxAjCjuDC6k5MdfEZiaFfRvv/stfsGWG6qgy8UQYBSKXXqgU6pMEGzxvkJAEbfNvk+9bIpB3o1YYG5wc4t7JNK/kamTxmkicawr4aIv7w6CusuoS8HB/nP+iVBF+NNeZx7pM=
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com (2603:10a6:20b:34e::15)
 by DB6PR0301MB2439.eurprd03.prod.outlook.com (2603:10a6:4:5b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 16:17:51 +0000
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::8175:20e5:60ec:b87d]) by AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::8175:20e5:60ec:b87d%9]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 16:17:51 +0000
From: =?utf-8?B?SsOpcsOpbXkgTEVGQVVSRQ==?= <jeremy.lefaure@netatmo.com>
To: Markus Elfring <Markus.Elfring@web.de>, "cocci@inria.fr" <cocci@inria.fr>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
CC: Julia Lawall <julia.lawall@inria.fr>, Nicolas Palix
	<nicolas.palix@imag.fr>
Thread-Topic: [cocci] coccinelle: Extend address test from ifaddr to every
 test expression
Thread-Index: AQHYhZKVoiShKWKcfECMq7fkDiuzD61dLk7r
Date: Thu, 23 Jun 2022 16:17:51 +0000
Message-ID:
 <AS8PR03MB76034D043F7A3FA878E13FA093B59@AS8PR03MB7603.eurprd03.prod.outlook.com>
References:
 <AS8PR03MB76033CF2848D03651D6E189093A69@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <6aef3ee4-d934-daff-7145-73ac563d2fb4@web.de>
 <AS8PR03MB7603675681B64E5F14C1995593B39@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <e887b364-7e69-267c-3a25-356bb2075699@web.de>
In-Reply-To: <e887b364-7e69-267c-3a25-356bb2075699@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8307587a-2c5c-46ee-90e6-08da5533ebff
x-ms-traffictypediagnostic: DB6PR0301MB2439:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mubd+Cg10XU7jg8xLz86MUaDbCKbO9JIs50yQhaNqhIZsY+2GPgzlqOZ/WMmukuKB0AWocl2C6z/WXm/BXmT2+LE7ksEf0vcWzgQtLbu2GM/hOnW2Jhva1mkgIJaKQ/YhLGJwwJJVI0L3RDzXkE6BN2DisPNppH+fdgB0FekivV0aK73m/xfjzfEzTW9zUJgzORUvAVgNfB45oFSeeXOYUAHQbUni6+iB+EIWOCKTiwixQF1DrkHLyyz1uFjskonzqjXqg5OFu5ZwXuAQFYXW6Gp+n6wNYW6viUEFV70vtjudTQmqh0E47fENi1lsVnRKjBshypT7R7XvCdWW6PQLmnyirqWy9tBargOdPlcDxJ0H7+81kwPEafReYtMiF/qM6gdDnfZwlYWISDt3CKmt0Zwgehw/Tf3fFsRbohDEPNyUUgXqNMNbwcuR0Ls+F8+34YiMSHnyu1PvzZittXDAhMKdwzAs+jleBu20zDlq85O7B/VYtR+W2cyr6XrYagB5YdIa5udAIpW6Aek1D2TCUrLuyuhfv9W0ONS+pLTCf6M5IQKYGbYQR6j7c8SC2jeT0AfrKsViEGOXDAYDlSsr683FNnHsSubKj1inTvvFyDQcYhDSXGuxq5VX/3Dn8DW9sojRLu73uxOl1QXfNFi2I1/qR6ts6YsGvI2qSm0p56faHvG20ICzEQUonn410DEaefz/rmFy38sko0YHQO77NgdTC4Sw+Jtbc5ucZadrcMralnV7B06jJxMt/XoYzVq2nXgz+oeijr7DnWHH9J83YYwHAyVbqkxPZBVGuCqAXc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7603.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(396003)(136003)(376002)(366004)(346002)(33656002)(55016003)(85182001)(85202003)(5660300002)(122000001)(52536014)(8676002)(66556008)(66476007)(64756008)(91956017)(66446008)(316002)(110136005)(8936002)(76116006)(71200400001)(66946007)(2906002)(4326008)(54906003)(478600001)(41300700001)(55236004)(6506007)(7696005)(9686003)(26005)(86362001)(186003)(83380400001)(38070700005)(38100700002)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OVhFNDVVWUJvRmUxaHp4S0tLTnZoREVNT3hBOTNweVUrWWZXVjNmM2hUd3Nk?=
 =?utf-8?B?RHdHT001dEpNcXlCUTRNdU1UWU4wZGpqOWJ6ejFSdnc0QlNUUVpDVEVLVUVP?=
 =?utf-8?B?eWNIVEFNQ2RjUldmc1JFY2J0d1RFSkpMYUUyZGpVZURaOFIwUFZHbFVaeVNr?=
 =?utf-8?B?MWFQQXZxTURydnhPTGZCaG13R1hSVlFJMEhUd0FQL2JrUXZGRC8zSkFoZ1Bx?=
 =?utf-8?B?WC9hQkJ3aGhyWm80a2lPSnROLzJNRDRSekFUaEd1YTNQRmFKTHpWOEUzZFRr?=
 =?utf-8?B?SkUrSzU1VjdyVHU2SXp6WnNmL2tFNFhYZ2FXb2hVQmk4Mkw1aXQ1NjJQMEpn?=
 =?utf-8?B?RTAvN09nc2RHNXFlTmdKNy9FNnh3cjJHTkR2OFVtS2hlNTVtZ0tLYmNHUVhX?=
 =?utf-8?B?Ti9LQzVWUEhZUkFQM1J0RnVKMEVUVWxmdy94b0k1d0JvbVczdWFSaEpvQWg5?=
 =?utf-8?B?MU1iRlVxajVlS0diSkFrVzlqYUduRWROb2NWNy95bDFBVDBVdXFJamowd3J2?=
 =?utf-8?B?UU9kOXVKcVRVU2I2bXltMDN2d3Z5alR4N1FMSlBMQXJUKzRIMHRxWTZ4dHFH?=
 =?utf-8?B?VmQ0bFpYelBGU0lIR2oxRFFFTjlOKzRQOWZIUTJXQktpMWFUTzhqS0Z2SmJU?=
 =?utf-8?B?UldFRzRPZnJyVS93OW45SlJxNUZTQk92UjdMOXVSbXFaaCs5c0VXNlNQY0dQ?=
 =?utf-8?B?djFkKzdBZ1NxUEpITHM5TGcveXBzSUJyVFFZYnFGU2NxSEhSdENtdkZhUjdu?=
 =?utf-8?B?Zkc1Tk5NNmMwOE96SVRHYm9UYjdrMDFnMi9hQldHNVBrMHM2SUpFVVJXcHVa?=
 =?utf-8?B?OEh3RmlSdjJCT2lVeGt4L3prUUZsc1h2ZGQ1cm9HSlJiZUd1NGtXU3ZEMU5i?=
 =?utf-8?B?dkZtaEZzWlhYdU5ZaFJ3WG5SbUxJM3dWUnVSV2Q0QTdzdFI0RlhHRTBmZGpj?=
 =?utf-8?B?dklmU1lNL1BjYVdCbFhVeng2VUNhalF4RmppSUU5VDhMT3BRNnhNdStReFBn?=
 =?utf-8?B?aDRRMDk3aUh6ZmlRdnZocjZkL3RNZng5bytpZDFEYnErektON21MaEI5MDlv?=
 =?utf-8?B?eGFwVFlKMGF3QlJIeFpKRTlLamRlWjlrSWFCQkNvWjBrUjFMa2FVL05pc3JU?=
 =?utf-8?B?Ry9vT0dVTzVKRWZVY0UwS1dJZzd2bmV5ZzZkTk5FN2dVTmQ3ZTFNby9QL2Fp?=
 =?utf-8?B?VkpLTEliS3pISENhYUFxWTRQWHlyMDZzRkg0ZjNrTWdTbWp5YjBHbnZ2dHdv?=
 =?utf-8?B?ckdlbzNPT1JVOUlLUmZqRUp1Q2VydGtuOW5uclgxYnRJeWV5blNHaUpRbkhl?=
 =?utf-8?B?VVdFNHJSeGNVVWNobWkxRVZ4SWRxMW1Tc2dOOGNqM05ldUpDMUdkTTNaeW1K?=
 =?utf-8?B?amo2SEUzY1gyVDV6c3VpTjh4bjZVKzB6OXFBU3RqdmsvZytWQ2tqSTIxT0Nu?=
 =?utf-8?B?T09rQnhIdi9oVlVLaVJueEVYK0pQVFV1Z2xBOU85eDNSOWpJS2ZTOC9FUExI?=
 =?utf-8?B?eWxkQnhVend1NEl6eEp1OU1NVkoyNlJPaU1jTXNoWWtWRzROQkFybWFHK1F1?=
 =?utf-8?B?Rm04RDRMOUdqOHJjZFZJNWkrZnl2MytVWU96Z3VUMXFnUzNPK0k0UVF6N2VE?=
 =?utf-8?B?UUxUemhnVzRlbWhZQlEyYmVZWmpkdXp6M1VDYXZJWGF5SnRtVXk4TklCc3Jz?=
 =?utf-8?B?S1VLQm44Z3B0dzQ3T1BQSDlLajlFZFNTdkdUUXdaTnE0OFFVVGw1dUJxWDZF?=
 =?utf-8?B?bEhZeW5ZakFsajRHYWpZZFppQ1AwWlZBYWc4cmgwRjVBYkhFYnZBSEUwQTZX?=
 =?utf-8?B?Wkw1VEZTNHI2NXBCam1jRnQyWWNGOFpxcllFUzBXOU5UeGNZd2tEdWRKUllx?=
 =?utf-8?B?SjRRdlZmTW51dW9LUEVYYjJna2tybUF5Sno2c214YVZKWXRLWEFGV2JpSDBG?=
 =?utf-8?B?VFFNdW9Lby9wQU41MlE2MGdyeXJXaTMvN3BwZTZYRy9GZWJEWGxBK1RuaFd3?=
 =?utf-8?B?N3ZaVlNua1dlbFRRRnNFejR1b1NFMDJnQTlSdE9mS1ZwWU1DdjFoVUpyYTlo?=
 =?utf-8?B?R2VrbE51Q0toVEpYcm15L0FtQTZHSUdqQzVVMS9YeWh3WCt1QU85NlRHQksz?=
 =?utf-8?B?MlRCRUdTemVCUmszQ3NTeFphZFJpWTFOODRVTXhuSjlPZGRObGFFRmRYbWJG?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netatmo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7603.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8307587a-2c5c-46ee-90e6-08da5533ebff
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 16:17:51.6809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4528446a-2666-441f-95cd-cc2cbd9f2c49
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WV2ZqQLATClMgPBPgxtjAfA6oCfbO9IwyeAwD9o9iXNqDvOGXPXzDV5HCTeVgvlZzyrcwtxXiX0px3RIYv0ZoYAw9gq1/enMD4AeSBWzcZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0301MB2439
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] coccinelle: Extend address test from ifaddr to every
 test expression
Reply-To: =?utf-8?B?SsOpcsOpbXkgTEVGQVVSRQ==?= <jeremy.lefaure@netatmo.com>
X-Loop: cocci@inria.fr
X-Sequence: 455
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/AS8PR03MB76034D043F7A3FA878E13FA093B59%40AS8PR03MB7603.eurprd03.prod.outlook.com>

Pj4+IFRodXMgSSBzdWdnZXN0IHRvIHJlY29uc2lkZXIgdGhlIHVzYWdlIG9mIHRoZSB3b3JkIOKA
nGV2ZXJ54oCdIGZvciB0aGUgcGF0Y2ggbWVzc2FnZQo+Pj4gb25jZSBtb3JlLgo+PiBJJ20gbm90
IGFnYWluc3QgY2hhbmdpbmcgdGhlIHBhdGNoJ3Mgc3ViamVjdC4KPgo+Cj4gSSBwcm9wb3NlIHRv
IHJlY29uc2lkZXIgYWxzbyB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gYWNjb3JkaW5nbHkuCgpGb3Ig
bWUgdGhlIHBhdGNoIGRlc2NyaXB0aW9uIGlzIGZpbmUuIERvIHlvdSBoYXZlIGEgcGFydCBvZiB0
aGUKZGVzY3JpcHRpb24gaW4gbWluZCB0aGF0IGlzIG5vdCBvaz8KCj4+IFdvdWxkIHlvdSBmaW5k
IGl0IGJldHRlciBpZiBpdCB3YXMgImNvY2NpbmVsbGU6IEV4dGVuZCBhZGRyZXNzIHRlc3QgZnJv
bSBpZmFkZHIKPj4gdG8gdGVzdCBleHByZXNzaW9ucyI/Cj4KPgo+IEFub3RoZXIgd29yZGluZyB2
YXJpYW50Pwo+Cj4gKiBhZGRyZXNzIHRlc3Qg4oeSIGFkZHJlc3MgY2hlY2sKPgo+ICogaWZhZGRy
IOKHkiBzY3JpcHQg4oCcaWZhZGRy4oCdCgpJJ2xsIGtlZXAgImFkZHJlc3MgY2hlY2siIGJ1dCBJ
IGNhbiBpbXByb3ZlIHRoZSAiaWZhZGRyIiBwYXJ0OiBpbnN0ZWFkCm9mICJzY3JpcHQiIGFzIHlv
dSBzdWdnZXN0ZWQgSSdsbCB1c2UgInNlbWFudGljIHBhdGNoIi4KCgo+Pj4gV2lsbCBmdXJ0aGVy
IGFkanVzdG1lbnRzIGJlY29tZSBoZWxwZnVsIGZvciBkZXNpcmVkIHNvdXJjZSBjb2RlIGFuYWx5
c2VzCj4+PiBhbmQgY29ycmVzcG9uZGluZyB0cmFuc2Zvcm1hdGlvbnM/Cj4+IERvIHlvdSBtZWFu
IGFkanVzdG1lbnRzIGluIHRoaXMgc2VtYW50aWMgcGF0Y2ggb3IgaW4gdGhlIGNvY2NpbmVsbGUg
c29mdHdhcmU/Cj4KPgo+IEJvdGguCj4KPiBBcmUgd2UgbG9va2luZyBmb3IgZnVydGhlciBjb2xs
YXRlcmFsIGV2b2x1dGlvbj8KCkkgY2FuJ3Qgc3BlYWsgZm9yIHRoZSBjb2NjaW5lbGxlIHBhcnQg
YnV0IGZvciB0aGlzIHNlbWFudGljIHBhdGNoIEknbQpub3QgcGxhbm5pbmcgb3RoZXIgY2hhbmdl
cyBmb3IgdGhlIG1vbWVudCAoZXhjZXB0IHRoZSBpbXByb3ZlbWVudHMKc3VnZ2VzdGVkIGR1cmlu
ZyB0aGUgcmV2aWV3IG9mIHRoZSBwYXRjaCkuCgpBY3R1YWxseSBJIGRvbid0IGtub3cgaWYgdGhl
IGV4YW1wbGUgeW91IHByZXNlbnRlZCAoYm9vbCB0ID0gKCZzKTspIGlzCnJlYWxseSBhIHRleHQg
ZXhwcmVzc2lvbiBvZiBpZiBpdCBpcyBhIGNhc3QgdG8gYm9vbC4gQnV0IGV2ZW4gaWYgaXQgaXMg
YQpzZXBhcmF0ZSBjYXNlLCBpdCBtYXkgYmUgcG9zc2libGUgdG8gZGV0ZWN0IHRoYXQgd2l0aCBh
IHNlbWFudGljIHBhdGNoLgpCdXQgSSdtIG5vdCBzdXJlIHRoYXQgaXQgaXMgaW4gdGhlIHNjb3Bl
IG9mIHRoaXMgcGF0Y2ggbm9yIHRoZSBydWxlCm1vZGlmaWVkIGJ5IHRoaXMgcGF0Y2guCgoKVGhh
bmsgeW91LApKw6lyw6lteQ==
