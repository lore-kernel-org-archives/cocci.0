Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C8FC47DDF
	for <cocci@archiver.kernel.org>; Mon, 22 Jan 2024 07:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject:
   reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=FP7rlYHb7p8Ht1LnMTRnBENudqUROCrX1NE7/QDIB2g=;
  b=DZ1cyDKcJgMZeKqlwjNotV2yYhyy9KWP2eKQCAkNusuTcTDBU3qSp4Lm
   x+MtcnIxhLGZduhkIvpOlJAzmfKAVbeXGuzFC1AmDzrZfBIWDfUuxan1K
   7O5EltneRQQoAiyrUdsTi/7V4zKM3Cn7q+uI/UV0HZCdLR74Iwb/CcvS0
   M=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@fujitsu.com
X-IronPort-AV: E=Sophos;i="6.05,211,1701126000"; 
   d="scan'208";a="147851095"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jan 2024 08:50:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 60BA4E0CF8; Mon, 22 Jan 2024 08:50:52 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4D88AE00B6
	for <cocci@sympa.inria.fr>; Fri, 19 Jan 2024 07:26:00 +0100 (CET)
IronPort-SDR: 65aa15f6_4sN0gJh8yYWRfHxvj7UgImkCerKYjiA2s/jA7Z5JLLR/VVG
 oFwxv5E2sY0xbfuoeV+G2kR4mkRsPM6bmWB32TQ==
X-IPAS-Result: =?us-ascii?q?A0EmAABPFKpl/2Cc6ERaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYFmUgdzAlgwBwhIBIRPg0wDhE5fiGcDhDuTb4VaFIEsFigPAQMBC?=
 =?us-ascii?q?wI7CQQBAQMEhH8CFocwAh8GAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECgQYThTsGKw2CXAEQgQxYAwQDBjYBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBBwIIBUIaAQEeAQEBAxIREQwBATcBDwIBCBgCA?=
 =?us-ascii?q?iYCAgIvFRACBA4FAgEBHoJeAYJfAwEQqHABgRQBFj8CKAFAAQECCYELigyBM?=
 =?us-ascii?q?oEBggoBAQYEBLJ1AwaBGi4BiBsBgVCDXB+CdGl6Qj+BToEVJwuBCYFvPoJKF?=
 =?us-ascii?q?wICGIEJIyEQI4MhgmiBG3+DGSmKFiaGdAlJgQIdA4EFBFwPGw8eNxEQBQ4NA?=
 =?us-ascii?q?whuHQIxPAMFAwQyChIMCyEFE0IDQAZJCwMCGgUDAwSBMAUNGgIQGgYMJgMDE?=
 =?us-ascii?q?kkCEBQDOAMDBgMKMTBVQQxQAxFUHxYCGgk8DwwaAhsbDScjAixAAwIPEgIWA?=
 =?us-ascii?q?yQWBDQRCQsmAyoGNwISDAYGCV0mBw8JBCUDCAQDKykDI3QRAwQKAxQHCwd4g?=
 =?us-ascii?q?hKBCAMZKx1AAgELbT01CQsbBj0CljcBgjuBDhwQc0FJIikyljSuXQqEEYwFl?=
 =?us-ascii?q?RYGEy+EAYx1mR4uh1QWkDuCUYklgXeVcIRnAgQCBAUCDgEBBoFjPYFZcIM3E?=
 =?us-ascii?q?gE8AxkPhlCHUDiDQIUUimVDMwIBOAIHAQoBAQMJiSKBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 zIYY8qT2+0=
IronPort-HdrOrdr: A9a23:S2ft3KwnznW8/Djifc17KrPxEegkLtp133Aq2lEZdPULSK2lfp
 GV8sjziyWatN9IYgBdpTiBUJPwJU81bfZOkMYs1MSZLXbbUQyTXc9fBOrZsnHd8kjFndK1up
 0QC5SWZOeAb2SSyPyKnTVQcOxQgeVvkprY/ts2pk0FJW0LGsJdBkVCe3ym+yZNNW577O8CZe
 OhD7181lydkBosH6GG738+NYX+juyOsKijTQ8NBhYh5gXLpTS06ITiGxzd8gYCXyhJybIC93
 GAtwDi/K2sv9yy1xeZjgbontdrseqk7uEGKN2Hi8ATJDmpogG0ZL55U7nHkCEprPqp4FMKls
 CJhxs7Jcx8517YY2nwixrw3AvL1ioo9hbZuB+lqEqmhfa8aCMxCsJHi44cWADe8VAcsNZ117
 8O936FtrJMZCmw2RjV1pztbVVHh0C0qX0tnao4lHpES7YTb7dXsMg24F5VKpEdByj3gbpXVN
 WGTfuso8q+Q2nqNkwxjVMfmOBEmU5DRStud3Jy/PB9FQImxkyRgXFomfD31U1wiq7VA6M0lt
 gsdJ4Y1o2mB/VmHp6UTo06MLuKI32IThTWPG2IJ1P7UKkBJnLWspbypK44/eewZfUzvdAPcb
 n6IRplXFQJCgrTINzL2IcO/gHGQW27UziowsZC54Jhsrm5QLbwKyWMRF0njsPl+pwkc4Dmcu
 f2PIgTD+7oLGPoF4oM1wriW4NKIX1bVMEOoN40V1+Hv8qOIIz3se7QdurVOdPWYHwZc3K6Bm
 FGUCn4Jc1G4EzuUnjkgALJU3eoYUD79YIYKtmtwwHS8vl7CmRhiHlgtb3i3LD4FdRriN1CQH
 dD
X-Talos-CUID: 9a23:qSuiVGDsHP1biYv6E3JcpBQPJJwDTnjyyiyPIWuzUFxsVoTAHA==
X-Talos-MUID: 9a23:8xy9xwrctRz4ZJvayEEezxhIGpd14rWnMXgQzJoXi9WvFAZ3YzjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,204,1701126000"; 
   d="scan'208";a="147498637"
X-MGA-submission: =?us-ascii?q?MDEn10w3xXVhLb++8RkklO0WVAx+oV4l22U2Hd?=
 =?us-ascii?q?vInvpnr8DRTYsF152sdDwEdY6wA4UtfD9BGdmQAzogeawdwZm5Jh4Uq8?=
 =?us-ascii?q?Xlanp5373cYv2JhSJqNUhvABabUO3Zoj3at1YdOeADDT4mHKXyh8gLXH?=
 =?us-ascii?q?FE9TpuBufbzSRqSpVUTJnGpw=3D=3D?=
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 07:25:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1705645560; x=1737181560;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FP7rlYHb7p8Ht1LnMTRnBENudqUROCrX1NE7/QDIB2g=;
  b=OWrS7YX6jc7jdnI/4KkbXDYKx1JiNMSzlxVVG6UWG4Kl3TTkjgbmJj4m
   /n0zO2qwgLosPDSAuWH9bVF5bfkhQaMU6j2apHFgF5A8Z4si88BQmyM1q
   9OH4L8aP3m0Sr5KKlk//abOhUq7bYJ3WCt7vLAGyEA3mG3VeDGnBOM+t3
   B95M+K2d9qOtQNXDCP4nb0VwFVS224ImAli+2hTU83w7Ge69yILfB0Wwd
   ZWO9IHPLbFFDAPwttNolx/h3oSSgVAu6Guc4gVp0whEvGYFdO6pIwk/Uz
   sM5ChQU2dlLpDzYrQtXymGuWGx8FMy+nUo/nCRqTRe0X0SbnvXV5tgwV+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="108245378"
X-IronPort-AV: E=Sophos;i="6.05,204,1701097200"; 
   d="scan'208";a="108245378"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 15:25:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gofk3nNfJfmpb2H3K3Lrrn3s8Wpmx8h7utiabeKZucjeyNzZqASLPsDOhQuWfxhLyZ80qMRe1nlUim53zh5bjgKZHM23h37ybek55kP+oImRMrR2luWISCiARhtkxzCQ7+Ti6v2xOoi18mG4nJZSfNspq0gmSAW++jHhINYvjOsT21dCwwduAQJfffu7rnvwpkzDatwLeGQ1/ZrZK0/a3a21NEj7kIt7+R4fBf+OZijsuON/Wg1K/jJpiDwquxt/9cG/uxm66zszofFs07uKb4TcfoFUNwwhFFRnTitt7/hJNXBvRLNhN6SgMzerwUlsEjWobv+XVCKxlHUVuHIHgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FP7rlYHb7p8Ht1LnMTRnBENudqUROCrX1NE7/QDIB2g=;
 b=gcv8blblPz3Oquw2t/0movHviTdKuETylaih+C1pTrhu5TdNg8itNqh218kKGIkkZJkpNabI54JEMiblYfS/cQyQOqFXqbF0h6EZIOjE55rTTSZ/UJKNv9Ff/HXtUBYAJIvzUtCbOBMJp7kkTrknZDTDI51lPA3oUcnAZnDxqy6NEP2/nC8yBmPXNNGFoa5T6Z3E+ddflt+Z18e4L8so4Gop/4qmDD5L2UA4t/eMBE+uRWqKDC4oVufDCDBQTDGSNP1/JfJxUiAhtvbp3X+E2ckaBNEexcE4x0XWmcpIvjl1ed3dV+iz4Uk/jReYJWxpJNoG8qpbK0Q+SF3pEjCbSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYCPR01MB8326.jpnprd01.prod.outlook.com (2603:1096:400:15b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.15; Fri, 19 Jan
 2024 06:25:45 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50%6]) with mapi id 15.20.7228.009; Fri, 19 Jan 2024
 06:25:44 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Julia Lawall <julia.lawall@inria.fr>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas
 Palix <nicolas.palix@imag.fr>, "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: [PATCH 01/42] coccinelle: device_attr_show.cocci: update
 description and warning message
Thread-Index: AQHaSDIil6iSQfVKJk6069otilFPcrDgCPuAgABsBwCAADtCgA==
Date: Fri, 19 Jan 2024 06:25:44 +0000
Message-ID: <53bc3ab0-57a0-4075-9055-03125259874b@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116041129.3937800-2-lizhijian@fujitsu.com>
 <alpine.DEB.2.22.394.2401182125480.3296@hadrien>
 <5b32f57e-c44d-44a1-b2f1-4dd7be59636e@fujitsu.com>
In-Reply-To: <5b32f57e-c44d-44a1-b2f1-4dd7be59636e@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYCPR01MB8326:EE_
x-ms-office365-filtering-correlation-id: e23674f5-811b-4954-bafd-08dc18b777b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JPrP/xW2067Rtotw5XoFD1QwsA6YNuImTiOuVgp3dADwvQQRL/v8ZBbkS6yDGBB7lJNUQNJ8NePJklfC/UDh5dalsQzBKMW0CAZqwcxxEKiMwHYV25hO3LjdkeQ8nHfljaoo2k4SaV6sW7ZD8sdDFW78N0ZVuuKtkS9Qu2oUHXOfmPGI3sbCOO+GJFbCSwfaL8WcdBTPXG+Okhr0IwtppAw5I+1HzL3PnuQO4FpWIvAHgi5GheZjseCfQcahL69FseQNZF+I2awX3UL3xkwcGVvx3y0B6XbKQimRb4aNCQ3eUK5ud2klTAf0feDybTOg9UxPV+CgCBTg1h4FhZ0O43pTE+aulF3ubMDEzx3xBLSuCsFsOt9MaKHfXr5iwOwm3b6UyG2QGj9PJDFFMERCNVsPWC7Sx/4iBi9fFRLIbF7n0C6XmDbxjurxidlHfNhN+hXi6kK998pDQ2g7QR3IcC2r80NRZbdqKkcPgSgn4+5CNYIHFKk22OTfGy4I2j3F2jGLp/KHedzxcYSSOGf7KkkFQJTnEA5aCK1Nm7F8CzaOxPc0aELpm10jVs0rSXhclC2rOHlZIUI7kMIYzUshdZcNcaF2b0A37uO04ngN+qaybpXpdWqihQOtDUmplPNmB0w424ABBUtxoSuQKUyHjIWQgvwmeo2Pe5JP47De61PUUhzwWtoRextqvLj1VdWi/T2gAlnsWyiRt828QqozaoVbGAWaQ1DzoMVncXF0sPGtM2O0cr12oujq8GpkJLTIuoZYM1DbigaATtPeJlCoaw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230273577357003)(230922051799003)(230173577357003)(64100799003)(1800799012)(451199024)(1590799021)(186009)(31686004)(1580799018)(83380400001)(86362001)(31696002)(2616005)(26005)(36756003)(82960400001)(38070700009)(41300700001)(5660300002)(6512007)(15650500001)(66946007)(4326008)(122000001)(85182001)(53546011)(71200400001)(38100700002)(8936002)(91956017)(66476007)(64756008)(66556008)(54906003)(76116006)(6916009)(66446008)(316002)(8676002)(6506007)(478600001)(6486002)(966005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUgwYVFFcDRtSk95NEMwd1AzWGYwWVVFeEZuRnRJUk1hWnljcDNzcmxLcThs?=
 =?utf-8?B?NmVQVjZ1dHkrakl5YmJ6RHhEcVhqTDQ4eWNhMEZwZ1k5dWwzWVNNQldhOTg1?=
 =?utf-8?B?VjlPTnZMWWNyeDF0azdVT2w2Sk04T09iU2hmdVdHbVJqMWpyWVVZNjdiYkts?=
 =?utf-8?B?SnkzbktIYnZWQWhhdm9McW9mdld1YTNEc25IdFQzWkpRcUcvbjc0eUhkaFJF?=
 =?utf-8?B?QnllMktnODFzSWR1c1dZYWxKRkRYN2FwVXZLWjI3S2NhMzBiMVBlZHRGWVcw?=
 =?utf-8?B?aG5Cby9FRzBPVTBOWEcrbm9HeWw0ajlLZnJlWnkzNldCZHg0R0ViTGJyZFlC?=
 =?utf-8?B?OXF5OFJuMGJtM0tJa3lEM2Z4YW9mYkg2RTFleXByTkQyMWVvdXd2VzM3eVhO?=
 =?utf-8?B?b3JvV2wvN3IxbWxFZkZ1aHpnWWR4SkU0UXJzODB5UVZpckpZakVYcnh1UlZ5?=
 =?utf-8?B?ZmlqblZoeEpMWVBYUmZPVGhRR2YxR3daVURraWpRWVJFV3p1cHk0dm1LY1Vk?=
 =?utf-8?B?SDZoL3Job0pCQmFkWGMvZklVTHdvSi8wTzd4MnlENUtPc3c3S000VWVYSTBJ?=
 =?utf-8?B?aHNLZXhScVlYQXQ2ckJXTnZOamRRcWdhK1hvV2syRW4rTXhYbElmcnR5L05L?=
 =?utf-8?B?cGdnVEdhK3Q4cUx3aTdkNVlXUngzV1hrcm5WKzRZQUE0L2xOU2NlSjRlY0JW?=
 =?utf-8?B?dVRTSkRaaElLTjg5TjFkd1ZwMGJZWUZDV05zYWxuMklRRGd3MnRmUzRTWDdr?=
 =?utf-8?B?U04vZTkyTFhPRmJJb1NqNVM2eTJOb3l1b1FkSTkvMUVuZ3JXYjNzV1R2MXBk?=
 =?utf-8?B?U2I1dUNKMURhZVIxcEJJRENHY2lYZ0lCbXJ4aGlMdTVUZ2dZYWZ6NDZIa2o5?=
 =?utf-8?B?Z3lWeWdEaWxqYTRZQmtLTUpZb1dXYkx5TTlDOWFzdDlQVlhvUERVbXNKUWR0?=
 =?utf-8?B?RmNmeWdWaUhvcmJXRWZxbko0SllxbnZJZG5OYXRoN2wraDg5MGRrcVBLSm9Z?=
 =?utf-8?B?Z084QVNiSVVDMEFseHFJc09OTW5VUy9nVWUxYTYzc1ROK25VakdRKzV1eVVD?=
 =?utf-8?B?dEVJNGc2VXo3R0lCR1lNUzBQRi81TUhxZ2poNDE1TVYrcFJnaloxaDJvR2xq?=
 =?utf-8?B?WFpkNUdoanc5VWhuWVZweWUzWXcwUjRIN0FMSGJaMjcxSnFyV3hPS0MzeVJK?=
 =?utf-8?B?aWxRV3k3aGQ0ZlJiWmRLOVVjSVFwM3dYWEh1Qm1PajEwQk9OSEcxRkdUYjN2?=
 =?utf-8?B?SThFSEczL1BGTTVxNkZGT1paRXRYcVovUnhxWjRjUGRnMzhTZm1jZnY2Z2Z0?=
 =?utf-8?B?VmlzUjVkcDdITm13T1ZCUzB2dEtMV3hGdlU2bzRxYlE1c0hjL2Myelk4cFdV?=
 =?utf-8?B?YlBVeERXR01xajNsM3Z1U2VRdnd6U3FmQXhSTE05ZWUyVW4wM2VpcmpnanhP?=
 =?utf-8?B?UWFSaTg1QXFPVGNLU25tK3JwVDVzMkpIUWxDZmpLSmVDVTlZR2l2SDRPRkJ5?=
 =?utf-8?B?UkhBcU1jZmNJYzdOdHBmc3I4MU9vT3kzZXFPVzhMcFdkd3hiTWdHeHpjdGl3?=
 =?utf-8?B?dXUrdGxsQWt3aHV4bW1KQ1lRelo3VTJFTmxnb01CUXVLeE1nc1VUR0h6NnRr?=
 =?utf-8?B?VkliQ3hhSDZjT2pBaEdUdlFqUlRmUGdBQVhLemhNRmNlSEw1QnkwQjlKeFB4?=
 =?utf-8?B?YWl0aTBvT2tTbldyaXlnSHozU1NZQ0RyZjFKMG5HTDlkRjlWdTB3RmNlRDM2?=
 =?utf-8?B?UjkxK2R3VjI0Zmg5R3BCdmREcFlLTVZpM0kwNEN0clJWQmtiMTNmeXVQL3g1?=
 =?utf-8?B?TXNEOGxkdktTUCtRYnpuM1daS1RiTHY5UE9vUE1nTHN0bVhSMCtVbEhTd1po?=
 =?utf-8?B?aWdQMVJkbUhCM0lVYzFWVGh5SUtQR21DamdZOVJqWStockNIcWd5eEVDNlFw?=
 =?utf-8?B?UzhPTzVnZlBBejhsUWlBa3ZySmdweHI1TGpKWG5XZjM2dEVieGs4MHd2MnlJ?=
 =?utf-8?B?L3RkeitlamlESFFwTmdsUEk3QmdvMnVUdmdCRmxXN3ZRdGNXNktxcHBHLzBS?=
 =?utf-8?B?Z1VINW1IdUgrNGZ6S01lOWlMZm5rMTJ5VVkwT1cvT0ZBeUx5c3gxSzdLRGh6?=
 =?utf-8?B?ekI1ZFBlRmtyekE3Y1FTSG5pTi9hbDV2RDlJV1k5eW80bXpSeGpwTy8wVGxv?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0063E97F80BBD4BBC9049AD4786DAEA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ziu9ACenRO6AGqmFvMOsUe+4PEzI/t0BHuNQtisGSaM1mU7bG2JJXv5KHScgSHOtvs8uguYarjPilDyeXYBUuUaKqyJBt95RTlIC3kjTqxiitrzI85FNavfd+axea6Hwk49biGCgolhUBynk+gk5zUhmqcZCBRrmJtSjXv9kbGqit8Jw1d5G3Bzm1EDlsT/7gTwuI958WEImCLxSDhQ9ney0cNlc8KqIYAJdmxveMZ9QRy1hcxp89pB2FceYtVZQOvRGVPLRyG9I1hF6dM1/5nkZmy4xnAHTP1WzxslE2GivdqXQK2AjeXpfAbRSA4VeNibpfcSF7NVBTV1gT241/5P69BdN3rgst7w2kPNqSqK0fdIUYUSsbvP4AhafVQWfl4qGA8pIJNzwp1owAt2B82+68K/zUCsbgoPy1T+yBJFlc0Q/9n1wh6kovqsauzSQiMt3b/HE0OBtZkC4xEPnLW2kcVJrqEiaU7wvGFd8Rf43JeTie1saaF2qgHNDJrnDEF1DgOENcQ4Jg0C+5cFLPmloUG1GqB8k6eIBQmZasY8uOgnN0lTm0KBC7jsca/v9OBm+SMS7pr7mSIme5dbh20aCR32QJBtCcMgbFK9T+clHMJqBf+d2m9eVuJkrstb3
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23674f5-811b-4954-bafd-08dc18b777b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 06:25:44.5632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avbeDB/bO7GR2EarkQ6MvuV//7lLGxE52ZhBDJdIJwNCKkYwC59Fp9skg8CIR8vFSkuIoBkX8yxavEa5BE7D9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8326
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 01/42] coccinelle: device_attr_show.cocci:
 update description and warning message
Reply-To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
X-Loop: cocci@inria.fr
X-Sequence: 1470
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
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/53bc3ab0-57a0-4075-9055-03125259874b%40fujitsu.com>

SnVsaWEsDQoNCg0KSnVzdCBMZWFybmVkIGNvY2NpbmVsbGUgZnJvbSB0aGlzIHZpZGVvIGh0dHBz
Oi8vd3d3LnlvdXR1YmUuY29tL3dhdGNoP3Y9MTZ3VXhxRGYxR0ENCmFuZCBwb3N0IFYyWzFdIHRv
IGZpeCBNT0RFPXBhdGNoLCBwbGVhc2UgdGFrZSBhbm90aGVyIGxvb2suDQoNClsxXSBodHRwczov
L2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjQwMTE5MDYyMDU3LjQwMjY4ODgtMS1saXpoaWppYW5A
ZnVqaXRzdS5jb20vVC8jdQ0KDQpUaGFua3MNClpoaWppYW4NCg0KDQoNCk9uIDE5LzAxLzIwMjQg
MTA6NTMsIExpIFpoaWppYW4gd3JvdGU6DQo+IA0KPiANCj4gT24gMTkvMDEvMjAyNCAwNDoyNiwg
SnVsaWEgTGF3YWxsIHdyb3RlOg0KPj4NCj4+DQo+PiBPbiBUdWUsIDE2IEphbiAyMDI0LCBMaSBa
aGlqaWFuIHdyb3RlOg0KPj4NCj4+PiBVcGRhdGUgdGhlbSBhY2NvcmRpbmcgdG8gbGF0ZXN0IERv
Y3VtZW50YXRpb24vZmlsZXN5c3RlbXMvc3lzZnMucnN0Lg0KPj4+DQo+Pj4gQ0M6IEp1bGlhIExh
d2FsbCA8SnVsaWEuTGF3YWxsQGlucmlhLmZyPg0KPj4+IENDOiBOaWNvbGFzIFBhbGl4IDxuaWNv
bGFzLnBhbGl4QGltYWcuZnI+DQo+Pj4gQ0M6IGNvY2NpQGlucmlhLmZyDQo+Pj4gU2lnbmVkLW9m
Zi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4+IC0tLQ0KPj4+IMKg
IHNjcmlwdHMvY29jY2luZWxsZS9hcGkvZGV2aWNlX2F0dHJfc2hvdy5jb2NjaSB8IDEwICsrKyst
LS0tLS0NCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL3NjcmlwdHMvY29jY2luZWxsZS9hcGkvZGV2aWNl
X2F0dHJfc2hvdy5jb2NjaSBiL3NjcmlwdHMvY29jY2luZWxsZS9hcGkvZGV2aWNlX2F0dHJfc2hv
dy5jb2NjaQ0KPj4+IGluZGV4IGEyOGRjMDYxNjUzYS4uYTYyMWU5NjEwNDc5IDEwMDY0NA0KPj4+
IC0tLSBhL3NjcmlwdHMvY29jY2luZWxsZS9hcGkvZGV2aWNlX2F0dHJfc2hvdy5jb2NjaQ0KPj4+
ICsrKyBiL3NjcmlwdHMvY29jY2luZWxsZS9hcGkvZGV2aWNlX2F0dHJfc2hvdy5jb2NjaQ0KPj4+
IEBAIC0xLDEwICsxLDggQEANCj4+PiDCoCAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMC1vbmx5DQo+Pj4gwqAgLy8vDQo+Pj4gwqAgLy8vIEZyb20gRG9jdW1lbnRhdGlvbi9maWxl
c3lzdGVtcy9zeXNmcy5yc3Q6DQo+Pj4gLS8vL8KgIHNob3coKSBtdXN0IG5vdCB1c2Ugc25wcmlu
dGYoKSB3aGVuIGZvcm1hdHRpbmcgdGhlIHZhbHVlIHRvIGJlDQo+Pj4gLS8vL8KgIHJldHVybmVk
IHRvIHVzZXIgc3BhY2UuIElmIHlvdSBjYW4gZ3VhcmFudGVlIHRoYXQgYW4gb3ZlcmZsb3cNCj4+
PiAtLy8vwqAgd2lsbCBuZXZlciBoYXBwZW4geW91IGNhbiB1c2Ugc3ByaW50ZigpIG90aGVyd2lz
ZSB5b3UgbXVzdCB1c2UNCj4+PiAtLy8vwqAgc2NucHJpbnRmKCkuDQo+Pj4gKy8vLyBzaG93KCkg
c2hvdWxkIG9ubHkgdXNlIHN5c2ZzX2VtaXQoKSBvciBzeXNmc19lbWl0X2F0KCkgd2hlbiBmb3Jt
YXR0aW5nDQo+Pj4gKy8vLyB0aGUgdmFsdWUgdG8gYmUgcmV0dXJuZWQgdG8gdXNlciBzcGFjZS4N
Cj4+PiDCoCAvLy8NCj4+PiDCoCAvLyBDb25maWRlbmNlOiBIaWdoDQo+Pj4gwqAgLy8gQ29weXJp
Z2h0OiAoQykgMjAyMCBEZW5pcyBFZnJlbW92IElTUFJBUw0KPj4+IEBAIC00NiwxMCArNDQsMTAg
QEAgc3NpemVfdCBzaG93KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1
dGUgKmF0dHIsIGNoYXIgKmJ1ZikNCj4+PiDCoCBwIDw8IHIucDsNCj4+PiDCoCBAQA0KPj4+DQo+
Pj4gLWNvY2NpbGliLnJlcG9ydC5wcmludF9yZXBvcnQocFswXSwgIldBUk5JTkc6IHVzZSBzY25w
cmludGYgb3Igc3ByaW50ZiIpDQo+Pj4gK2NvY2NpbGliLnJlcG9ydC5wcmludF9yZXBvcnQocFsw
XSwgIldBUk5JTkc6IHBsZWFzZSB1c2Ugc3lzZnNfZW1pdCIpDQo+Pj4NCj4+PiDCoCBAc2NyaXB0
OiBweXRob24gZGVwZW5kcyBvbiBvcmdADQo+Pj4gwqAgcCA8PCByLnA7DQo+Pj4gwqAgQEANCj4+
Pg0KPj4+IC1jb2NjaWxpYi5vcmcucHJpbnRfdG9kbyhwWzBdLCAiV0FSTklORzogdXNlIHNjbnBy
aW50ZiBvciBzcHJpbnRmIikNCj4+PiArY29jY2lsaWIub3JnLnByaW50X3RvZG8ocFswXSwgIldB
Uk5JTkc6IHBsZWFzZSB1c2Ugc3lzZnNfZW1pdCIpDQo+Pg0KPj4gVGhhbmtzIGZvciB0aGUgc3Vn
Z2VzdGlvbiwgYnV0IGl0J3Mgbm90IHJlYWxseSBjb25zaXN0ZW50LCBiZWNhdXNlIHRoZQ0KPj4g
cGF0Y2ggcnVsZSBzdGlsbCBnZW5lcmF0ZXMgYSBjYWxsIHRvIHNjbnByaW50Zi7CoCBXb3VsZCBp
dCBiZSBwb3NzaWJsZSB0bw0KPj4gZml4IHRoYXQgdXA/wqAgT3Igc2hvdWxkIGl0IGJlIHJlbW92
ZWQ/DQo+IA0KPiBHb29kIGNhdGNoLCBpIG1pc3NlZCBpdCBiZWZvcmUuDQo+IA0KPiBMZXQncyBy
ZW1vdmUgaXQ/wqAgSnVzdCBzaW1wbHkgcmVwbGFjaW5nIHNjbnByaW50ZiB0byBzeXNmc19lbWl0
IGlzDQo+IG5vdCBlbm91Z2ggZm9yIHRoZSBwYXRjaCBtZXRob2QuIEJlY2F1c2Ugc25wcmludGYo
KSB2cyBzeXNmc19lbWl0KCkNCj4gdGFrZSBkaWZmZXJlbnQgYXJndW1lbnRzLg0KPiANCj4gSSdt
IG5vdCBmYW1pbGlhciB3aXRoIC5jb2NjaSwgaWYgeW91IGtub3cgaG93IHRvIHdyaXRlIHRoZSBw
YXRjaCBtZXRob2QsDQo+IHBsZWFzZSBsZXQgbWUga25vdy4NCj4gDQo+IA0KPiBUaGFua3MNCj4g
Wmhpamlhbg0KPiANCj4gDQo+IA0KPj4NCj4+IHRoYW5rcywNCj4+IGp1bGlh
