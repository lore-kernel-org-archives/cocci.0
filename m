Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2C1C47DDE
	for <cocci@archiver.kernel.org>; Mon, 22 Jan 2024 07:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject:
   reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=C7cHS53LtlPmvEiFprr8QgoOKoGhDK6UCJrQucGr8P8=;
  b=mel9vaC6620l8kMJ4tZf8Kgn/QRzYDpc26ILK5g6KCv5OW77iV+UGlGn
   74OCvxsHCxQ1cGlYHDuSrk6W+I/hPDpEtaL5m5ftGYBUHQvpGhKO9bI0L
   2+686Y/KgdcFAR7PpydB02pBQ8PvdqnAAXZ0nQqjFU1cum7Cxy2dxA1y9
   8=;
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
   d="scan'208";a="147851132"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jan 2024 08:50:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C8538E0D11; Mon, 22 Jan 2024 08:50:52 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 76BFAE0035
	for <cocci@sympa.inria.fr>; Mon, 22 Jan 2024 04:29:15 +0100 (CET)
IronPort-SDR: 65ade109_boiMTuqf1BNEbPW+fZ12yjScUKXziDpLj0fh/3h3tYx6NGg
 fvrUQS0tcG9lObXGz1kx7dsaCeLtUZ1QI51AHNg==
X-IPAS-Result: =?us-ascii?q?A0E6AwDQ361l/9SX6ERaHgEBCxIMQIFEC4FnUgdzWjAHC?=
 =?us-ascii?q?EiEU4NMA4UtiGqEO5NvhVqBQD4PAQMBCwJEBAEBAwSEfwIWhzACHwYBBDAJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQKBBhOFbA2CXAGBHFhGA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBFAIIYQEeAQEBAQIBEhERDAEBNwEPAgEIG?=
 =?us-ascii?q?AICGQYHAgICLxUQAgQOBwEBHoJegj0jAwGmNwGBFAEWPwIoAUABAQIJgQuJE?=
 =?us-ascii?q?nqBMoEBggoBAQYEBLJ1CYEaLogcAYFQh1h6Qj+BToEVJ4MDPoRag0SCRiKBG?=
 =?us-ascii?q?3+DGimKFYc9CUt/HQOBBQRcDxsQHjcREAUODQMIbh0CMTwDBQMEMgoSDAshB?=
 =?us-ascii?q?RNCA0MGSQsDAhoFAwMEgTAFDRoCEBoGDCYDAxJJAhAUAzgDAwYDCjEwVUEMU?=
 =?us-ascii?q?ANoHxYcCTwPDBoCGxsNJyMCLEADERICFgMkFgQ0EQkLJgMqBjcCEgwGBgldJ?=
 =?us-ascii?q?gcPCQQlAwgEAyspAyN0EQMECgMUBwsHeIIQgUIDGSsdQAIBC209NQkLGwY9A?=
 =?us-ascii?q?pkfBgGaaa5dCoQRoRwGEy+EAaYTLoUFglAWkDuCUaEMhGcCBAIEBQIOAQEGg?=
 =?us-ascii?q?WM9gVlwL4MITwMZD44gOINAj3lDMzsCBwsBAQMJiSKBRgEB?=
IronPort-PHdr: A9a23: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
 O+/mw==
IronPort-Data: A9a23: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
 +Msh8uT2w==
IronPort-HdrOrdr: A9a23:YfyQqaHCY5JtLc++pLqF1ZLXdLJyesId70hD6qkvc31om52j+f
 xGws516fatskdsZJkh8erwXJVp2RvnhNFICPoqTMiftW7dySWVxeBZnMffKljbcBEWmdQtrZ
 uIH5IOauEYSGIK8PoSgzPIUurIouP3i5xA7N22pxsMPGJXguNbnn1E422gYypLrXx9dOME/e
 2nl6x6TlSbCBEqh8KAbBQ4dtmGg+eOuIPtYBYACRJiwA6SjQmw4Lq/PwmE0gwYWzZvx65n1W
 TeiQT26oiqrvn+k3bnpizuxqUTvOGk5spIBcSKhMRQAjLwijywbIAkd6yesCszqOSP7k9vtN
 XXuR8vM+l69nuUVGCophnG3RXmzV8Vmj/f4G7dpUGmjd3yRTo8BcYEr5leaAHl500pu8w5+L
 5X3kqC3qAnSC/orWDY3ZzlRhtqnk27rT4JiugIlUFSVoMYdft4sZEfxkVIC50NdRiKrLzPUd
 MeS/001swmKG9yXEqp5lWHB+bcBUjbKy32BHTqfPbliQS+0koJknfwj/Zv4EvovKhNOqWsod
 60cJiA3Ys+PfP/J8hGdZc8aNryBWrXTR3WNmWOZVzhCaEcInrI74X6+bMv+YiRCdc1JbYJ6d
 38uWljxCYPUlOrDdfL0IxA8xjLTmn4VTPxyttG75w8vrHnXrLkPSCKVVhryqKb0rgiK9yeX+
 z2NINdAvflI2erEYFV3xfmU50XLXUFSsUattsyRlrLqMPWLY/hsPDdbZ/oVfDQOCdhXnm6Dm
 oIXTD1KskF5ke3WmXgiByUQH/pclyXx+MHLEEbxZll9GEgDPw5juFOsyXK2iiiE0w2jpAL
X-Talos-CUID: 9a23:QD48oGHBfhpX4Na6qmJI9mdJO/8Ve0bRlingKnL/MjwzWoS8HAo=
X-Talos-MUID: 9a23:xyMxKwSbIEfMF3ubRXTixwFaCfwzyJ6qDWA2k7tXieaFLSxvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,211,1701126000"; 
   d="scan'208";a="147827507"
X-MGA-submission: =?us-ascii?q?MDH2aVlRBPeZhhpYH3MAhLdyuypi/lH9u4z37M?=
 =?us-ascii?q?sfut+thAKjWO8IKA8aYEkCYgA2kKcgs7CN649uK69pQXbNCFVPz7X7hP?=
 =?us-ascii?q?86mC2vFMrsFt+qIxNZoCVumP0FU6Ff1Ya3cczOMzXspN4lHyyu905bpy?=
 =?us-ascii?q?+nf66afOQgoLygr2eIuuZoTQ=3D=3D?=
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 04:29:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1705894154; x=1737430154;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C7cHS53LtlPmvEiFprr8QgoOKoGhDK6UCJrQucGr8P8=;
  b=k78Vb53Cuo60a3YDvxqYYV55Ia2i4d6FUWxPhZ/Q3dHRKIYdqmmzuCni
   U3YhNVrPUKp/DocW+Q4oYzvpWLiO7kx5kIaP7XTlXIJBo1Mq+WH5Bk7xu
   gYLPc6+4Z3BAtRbcK/IVaFstDqVu+Zm0BiCcYeKvUEVlz8zmt1ImgtCI1
   QRULH6+SKvQ8kPY00b6PdZVk8muJ+bfO+IP0kg9/M9e+9cUVBMGWbYwL4
   buMamZoqDLHfnzDp0knWF1TiVPLPP3tFPjWXQH8/6n+3RGBZNsX8bj1hi
   WsBbnO8m6Yq1IdG4VTcIddcuzKtUEemecUz+IUyWlKoOc4h2KmW9lP5mZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="19976537"
X-IronPort-AV: E=Sophos;i="6.05,211,1701097200"; 
   d="scan'208";a="19976537"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 12:29:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqF2CyKmNxHGy/hRfVruiJLtfDlICP/rSG3g2kB1ZMrFZf+w9iM4w7MPfwHBCZ4pV/oF1FgN+psIsc8DXDP7BtUAGQ25ExC+NdGQoMWWLDVSVY1PEY+6SXPIdBjdzfleaYeouFSbhACgsMklPDpXY8UBZ4YUApY2hgxpXEUGwqupIk/z147NSCRl62aiUX4CyEFkuYejcNJgUqGGvIbz/F9d3ujt62l5cEG0Pn3PqZ8ATMLV1ep1EzpOLXpQlRpdmJnarafvRJbN7UYjAyE7j9ANRP7nrqZInNgqx/iqFXODOXbyEM+d/9KuW3hAbcauFY7zlrZmVzeteNn9y2XlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7cHS53LtlPmvEiFprr8QgoOKoGhDK6UCJrQucGr8P8=;
 b=cD0O81zxPxkYzD16pJHRq2Tm2trGAjG4SkDdZ6qazCzi8DrGkx8z8xRHmy5FN/VyHOrimyi0vX/7IqyaLJiLyEUl7i2BPW4FCsRS6gaVI4rSdC+o0UcJQELLKtRGvKj7PDo2ui/r8205eL7VvNVEee4YwnFZpNQf+gEr/lx0puKWfmbzw3x98Bu2816zhfXrL0lLNN/HNDxyg6f6aJcpq69ATbnOi9z9PWbxhgQEQ6DAEAwzvG+uX9gdQ5VkLiclzxuM/Fh5gxSvlYqeMjtT4IM+Rs91icjPI8heuOa56qfY6m9zzem95O5/YDsYDbM1XEFy3eQLg9P3bbZehSt3lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSYPR01MB5445.jpnprd01.prod.outlook.com (2603:1096:604:84::13)
 by TY3PR01MB11004.jpnprd01.prod.outlook.com (2603:1096:400:3b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.11; Mon, 22 Jan
 2024 03:29:02 +0000
Received: from OSYPR01MB5445.jpnprd01.prod.outlook.com
 ([fe80::c61:6ef5:22ee:565]) by OSYPR01MB5445.jpnprd01.prod.outlook.com
 ([fe80::c61:6ef5:22ee:565%4]) with mapi id 15.20.7228.011; Mon, 22 Jan 2024
 03:29:02 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Julia Lawall <julia.lawall@inria.fr>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas
 Palix <nicolas.palix@imag.fr>, "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: [PATCH v2] coccinelle: device_attr_show: Adapt to the latest
 Documentation/filesystems/sysfs.rst
Thread-Index: AQHaSp+vRA5kPLZbkUqjfxDpv5AXBbDjN7kAgAH5TgA=
Date: Mon, 22 Jan 2024 03:29:01 +0000
Message-ID: <d14443fd-96ee-4d94-a149-d81990f64de6@fujitsu.com>
References: <20240119062057.4026888-1-lizhijian@fujitsu.com>
 <alpine.DEB.2.22.394.2401202217550.3267@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2401202217550.3267@hadrien>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5445:EE_|TY3PR01MB11004:EE_
x-ms-office365-filtering-correlation-id: 6aa8879f-1911-4f30-fa19-08dc1afa4744
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 01fMV+JfQui0iCnjXJy5b/DRQYiNwVEbbTy9fCOqEHz5Zo/TwVsub5uZyEpG+eu1QINQ8AZsqPbOY2dMOkt2oTENf19pt7lw347B5Ce25Oh8dZcHsnYi0Wgq6afnpnc2I3NSXMrGVTlIGZ3ppgUqYGZVGfyeYYAERDHjrOJWT25YU4Oxq7u3mWbEfwx9jke1QeFpnWqtUrZ3s3xfblWxAgPVvftJLc9iPJYT6lrm6oS5M6PpmpOjyXcKWmZyDV9PvhjOSVmquhUB4NCtX4CKYYQfFCSJc8hIkJYqxFivpmQFWfwrXnwE59V+5wtuyHH06OJezqXrZ6wZbrTjH2fHRoYhgsVzv5j6dJsA6s5Xvgqjskhm9UqRYGiHcENJCLN9edptP8XKLHUDvuWMmKexto2UWelxwGrGwa/o7UtN2BUZHekfQ0m8KSqAQdF/Xt4hiHwkU67be8jDtWAhymedvL+SGM5s5g5PJVt8ukUgBQs49e4QfJq3Lr0dXogdNZxE4UG2aWKMq1dZs/eLXu926+UCuFqRie/ayLnVRsPLBFmoCjh/9nc/0EShxe2UbvIKswNQgK6glPfom46q5B1AVFOlH6043Cgm1Vk1Y2TGbE0M3ilEIBa2vPOYpPI33jT4zyOuBjQPMJc0OW1RhMJcs1p1LW1x4+9jqNltrLdcgT2hpdRuPdq7Oo+rrIF1b5O37xbNNaoIzulmveSygT7NmwMzi7pqu0u28uLkk1egvMqzv1AGkPLHvA5mFsb7lhga
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5445.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(1800799012)(451199024)(1590799021)(186009)(26005)(6506007)(2616005)(6512007)(53546011)(71200400001)(5660300002)(122000001)(316002)(4326008)(8936002)(4744005)(2906002)(6486002)(76116006)(66556008)(6916009)(66946007)(478600001)(91956017)(64756008)(66446008)(54906003)(66476007)(41300700001)(8676002)(82960400001)(31696002)(86362001)(36756003)(85182001)(38070700009)(83380400001)(38100700002)(1580799018)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGxMa241NHh3NjJZVmh0eEh2ODNob2dJM09CRXZyTWlQTUMvNEpId21ReHFa?=
 =?utf-8?B?MlJqQ0tWZUF3QmUzOVBXQUdwVU5BdlNYY1d5UFVDSTRkenlLOWFpTTN3Nk11?=
 =?utf-8?B?QXB6ODI0RW9WR241Z1FpaVdRV05aRkpacVJmQXNjaEdSTCtWMTBNV1A5UXV0?=
 =?utf-8?B?RmZqTVRSbS8wdEMxSjlxa1Bjd3lnV1c3RVB4SWVYelF1elRYRExKelpnSHYx?=
 =?utf-8?B?dktSdFRhcXhUT2V2bUx0L1llbmNtek9kUkNCQmlqZlR0QXVTdm5SNmhXdSs0?=
 =?utf-8?B?ai9pTmcyYzRVcHpRRlJ6TUVUZkZtVWxGdURrWjYzNWNrejlIN2xnVmk0c3h5?=
 =?utf-8?B?WXN4bjVXNU9pSzlnUzdsSlZmeHlDR0lHdGtTUk9FSWVaSWZiVlhDNk4wVXh1?=
 =?utf-8?B?TmNPM2VqQzJvTE1mV09rN21GUUlmcURzbFZVeHBDR1VncjF0aXI1M21TWXlM?=
 =?utf-8?B?V2VXaUFiVGlsRVpXLzNpbVdFcHBZYjdLZnBXaXdienYwLzNoaTFHWGdpNWd0?=
 =?utf-8?B?QzYxTlRlRU5peDRlVWhpd2JhNHpGd1JqMUpmbmZHUWRXMFhjK0w3M3o1ZzlN?=
 =?utf-8?B?RG5YREhEZW1QMzJ3NGtva1hIRCswQ0tRdjdhWkNkMVM3M00wc3dzTzBBS3Mv?=
 =?utf-8?B?Q29BNjBKMngxdFVjVkJiS2JUTng2ZTNSRjBHUURHMmEwZ3luSTNoZVNsaHg0?=
 =?utf-8?B?a25GRC9wZkg1VUlzc2Z5QWZ1TXoxcFJya3Z2Mld1MDJkcVhyL21kaWMvMUw1?=
 =?utf-8?B?OHlnNUx2S09xZDUrVUtxY1N3aklDRVFWMGpoWXdKV3NRRy85QWI0L0xoakpH?=
 =?utf-8?B?aFkxU3ZtOHAzT1pHMmlQVHhCU1BQT2Nsc25MN0RCVHRlbUJRN3JqdTlHcU1z?=
 =?utf-8?B?ZUptcEVybHpzVDQ0VUhnVk5vcXVYLzZSTzVwSUhzUkgxUGpkU2pCaE43d1c0?=
 =?utf-8?B?a2duMVJqS1AxVmpoQTN2eGpvc1RHbG14eW5OSUxrOXA5WVRHTTBSdmtab2lL?=
 =?utf-8?B?SGlJVmF2cEZwT1hvQ3d6aG5pbkQzNmtvUVR1QzNGU1psNjZXbEVFWTdjQnly?=
 =?utf-8?B?L2FUWHB2L2pPTlk5OHA1S3Z3amd4TzdjMks0NHhLVVNqbzBtb2QxV1lPczZ6?=
 =?utf-8?B?L09KdlFIc2NkL2h4OURWRDA4dkRYZkNwdDZheEFZK1lzUWlYbjZTZDE1a3l4?=
 =?utf-8?B?dXRjUnN4V2JtRTRtK1ozYzdMSjFpc1JadVNrQWRTVkg5QTB0R28vT2UzNjZu?=
 =?utf-8?B?ZnM0WlpGOVoyMjk5d2F6SzRXckNOTXdtOHZvSHN1ZXd5Q1o3ZXBUWXRTN3Fz?=
 =?utf-8?B?V3ZCS0FBSmZVWUx1cGE4L1B3K3dwSlRxNU5EeUU2TXdCeXNtd29wMHVxOTBJ?=
 =?utf-8?B?TE0rbXo1aHl5THVEZmw3aXBiMEtGaGRjb3NnQ0JtNVE1UGpab3ZxUDZrT085?=
 =?utf-8?B?Zk1KWGhtRzZ3Y1dtYktEVDZlUC96VCtOYmgrb2hqRVdYcmY3OHM3cjhEeXQ4?=
 =?utf-8?B?OS92SnNGTUhoMllhd2VWZkQ5K1NwWnp3Q1NOdENYcGo2YTMzdy9iOWFJWGZC?=
 =?utf-8?B?RXpxeU0weFA4dnBnbFFRdmtnd0FDcGIzN2V2a3A1cnhQR3FLdk1GenVGSVdC?=
 =?utf-8?B?d1ozMitLV1ZhM3l2WjNBUldJNXdCK3ZoejA4MWgrakFHRERqSmRHN1BRVUFv?=
 =?utf-8?B?ODA5NHA3RXUzY3hlZzR5cWZMMGRTMWw2OEFwZ1F1NW81UUxHKzIvWjhqY2k2?=
 =?utf-8?B?Tis4akVBQkNpTnlLNFV5TFQ2NlRXMmhGcThyL3JlcEpjeTdNZUV0UmwwbUc4?=
 =?utf-8?B?dk5BcmF6UmI3T0FOL2VNZUUrNjBKcHRobHVJeGJ3L0xwREVLK01XV2lyZW1p?=
 =?utf-8?B?OUhkbnE1YU5TLzBPcTkrSkNCbDIyekJIMTF5Q1R5YnY4YXdQTG9MOE1WZ2tO?=
 =?utf-8?B?aTl1Y1J3aTA3Rmo5SGZ1d014MEI1M2VHSkpSeFVTeXVIcFpxT0ZwSzhVaHZZ?=
 =?utf-8?B?dHFxK3NqQUZXN2tTejRrWG13OU9SZXBhb0ZpLzZveCs3UWxKTDFpOHhHVmYw?=
 =?utf-8?B?clQ5UXFVVUZyVU5Cd0RXOTFTWVF2TEkyd1hQTVlqMzVpVUV1ci9KMEMrRllU?=
 =?utf-8?B?NW9HMmJzWnl2V1lBMGQ1MTl1NDE2Tmp5bE1CTFQ1NStSbklVOHE1ei9TZHdY?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5269B382AB50624787E8AA8C1DF5CFEE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	09UZIJj+IYBhhXhvVq3v6IZBH/TzqfmpjGQUfz93aM+4aWtAW9kXpjBzOM3NaJGMJ53ZOdDeUgCrtQrOJA1bKZAahIL2IrxUod2FTTVXuzVA8qYL2auFi0Ia1+HaOkF2gM0TbpoD/zIJGzJz8OBohaz8IPiGVqO8itToh/ZiVgXXQBK1oveih6L2mzFptAy3FaWbBYFuJ9SZ+DQXFo7q5B5P3EHnbL0jYMbyi5+EYAnTXt42s4q9S8q82miTkKI0KFAGs+VSd7fAxrX4PIBoq53m0fobeCuGNAZzLQ2nVm09kLO8vqt0l6IVX5e6CTPfB/fCvGcrFWDcHt2978+R9VMhinNAbS4+r/66FEnIJgLVza7FdGRn3uv04Br608sphE1FmmaqAYeHKTWuSonoiAQtNlUZFXVSOwkenZ0P1HfdeY+X8G0vv3fMjaRzAaNu9b31sf4va9OLVIWxraZSYUszLZI0PkM5cQh0m+Qsotd92FwxrUIKnOOnjkFw+lBf5w4VI0XM82dZg0u8LA5K6UBY5Q7A3RP1W6eM8P3oUTeZ1cEXQesONk6yrUmKZVesmMrJ0yIjjZ9OkAQDCObO5gUA8XtlGWJ/CtscCYlbv26CgD+0c9DjngX7qlF+PHy/
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5445.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa8879f-1911-4f30-fa19-08dc1afa4744
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 03:29:01.9028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /sVoWx2wJ7o1EmDUyEYZFNbvhb2SoNWpgPllk15yDBLID9+FSH1hZdy9SnDNzF9HSP/hziBZ1pCZdqm3k1YYbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11004
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2] coccinelle: device_attr_show: Adapt to the
 latest Documentation/filesystems/sysfs.rst
Reply-To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
X-Loop: cocci@inria.fr
X-Sequence: 1472
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/d14443fd-96ee-4d94-a149-d81990f64de6%40fujitsu.com>

DQoNCk9uIDIxLzAxLzIwMjQgMDU6MjAsIEp1bGlhIExhd2FsbCB3cm90ZToNCj4+IFYyOg0KPj4g
LSBjaGFuZ2VkIHRpdGxlIGZyb20gY29jY2luZWxsZTogZGV2aWNlX2F0dHJfc2hvdy5jb2NjaTog
dXBkYXRlIGRlc2NyaXB0aW9uIGFuZCB3YXJuaW5nIG1lc3NhZ2UNCj4+IC0gRml4IE1PREU9cGF0
Y2gNCj4+IC0gRXh0cmFjdCBwYXRjaCBmcm9tIHRoZSBwYXRjaCBzZXRbMV0gc28gdGhhdCBtYWlu
dGFpbmVyIGNhbiBhY2NlcHQgaXQgc2VwYXJhdGVseS4NCj4gQXBwbGllZC4NCj4gDQo+IEkgc3Vi
c2VxdWVudGx5IHNpbXBsaWZpZWQgdGhlIHBhdGNoIGNhc2UgdG8gY29udGFpbiB0aGUgZm9sbG93
aW5nOg0KPiANCj4gLSAgICAgICAgICAgICAgc25wcmludGYoQlVGLCBTWiwgRk9STUFUDQo+ICsg
ICAgICAgICAgICAgIHN5c2ZzX2VtaXQoQlVGLCBGT1JNQVQNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAsLi4uKTsNCkdyZWF0LCB0aGF0IHdhcyB3aGF0IGkgd2FudC4gQnV0IGkg
ZGlkbid0IGdldCB0aGUgY29ycmVjdCBzeW50YXguIEkgd3JvdGUgaXQgd3JvbmdseToNCi0gc25w
cmludGYoQlVGLCBTWiwgRk9STUFULCAuLi4pOw0KKyBzeXNmc19lbWl0KEJVRiwgU1osIEZPUk1B
VCwgLi4uKTsNCg0KDQoNCj4gDQo+IFRoaXMgYWxzbyB3b3JrcyBmb3IgdGhlIGNhc2Ugd2hlcmUg
dGhlcmUgYXJlIG9ubHkgdGhyZWUgYXJndW1lbnRzLg0KPiBJdCBoYXMgdGhlIGJlbmVmaXQgdGhh
dCB0aGUgY2hhbmdlIGlzIHJlY29nbml6ZWQgYXMgYSBsaW5lIHJlcGxhY2VtZW50LCBzbw0KPiBu
byBleHRyYSB7fSBhcmUgYWRkZWQgd2hlbiB0aGUgY2FsbCBpcyBpbiBhbiBpZiBicmFuY2gu
