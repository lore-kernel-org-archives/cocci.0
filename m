Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BBACCA479
	for <cocci@archiver.kernel.org>; Sat, 25 Jun 2022 12:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=m7MCgaHdN16Q6hHgWrp7vZcmxRDBSa07tbUOSSmXP5M=;
  b=c885RzHCTUVnEWLoM+mRSRKvYKlT0uSC4pnGbulixrL1SiA3sW8vit0v
   OqyEHFWQL838fGF4NkMSks76v/yv1hposzPlBlFSlN9kc82wGIo/AWTw3
   kXvp9cIlEBvdvVXcI0p+86h1HRyEJFZMAfdPfMBb/zZn2SbhFE3rWpOjc
   Y=;
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
   d="scan'208";a="42838410"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jun 2022 14:33:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DFB0EE00F5; Sat, 25 Jun 2022 14:33:50 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 508BFE0094
	for <cocci@sympa.inria.fr>; Tue, 21 Jun 2022 18:10:26 +0200 (CEST)
IronPort-SDR: GbAGj/t2jU77xOc8kIpSABB+vPSq3Rn4+wVumjMfm/GJ0BzEw9nc48eGqf3SegqW1LGK5kKlSE
 jOTjE4DdO+vPYj6j7q9qtFVT5+3J9Wo3IT+k8+gsOaTxliIihv0NzdF7vOFugM5ZeyPK7XHLJ+
 Ju145SN4M7ju2wO4bSJ0ve/RQHQx5zt5vMNQ5MdffRz2lESaO8cprPBjPQTwjmi7WP+xz1e1Rb
 zT5Rc0umwc56kcRa5bQwnte2JTEZjOJaZwhN+gvBrxGhrrtx56SCbkK6d4arrtPR9XPtmZG20Q
 FIfimwaK+p/p4NsjXdyxwo9h
X-IPAS-Result: =?us-ascii?q?A0DXAQCo7LFih3kUayhagQmBT4FSUn9ZKgMHCESIGgOFM?=
 =?us-ascii?q?YUKgwWeZwsBAwELAkIEAQGCD4JvAQIBAQKFSh8GAQQzBg4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBAETAQEBAQsNCQUICgcOEAU8ZIEIAYFOAYFTC?=
 =?us-ascii?q?wMxDYI1KQGDZAEBAQIBDAYuAQE3AQQLAgEIRjIlAgQBDQ0agluCdiMEAp98A?=
 =?us-ascii?q?YE/AgKLFYEzgQGCCAEBBgQEh10JgT6OdIJQgViCNzA+gQ+DNQKEC4IumT8cO?=
 =?us-ascii?q?QNHNBKBIXEBCAYGBwoFMgYCDBgUBAITEk0GHQISDAoGFg5CEhkMDwMSAxEBB?=
 =?us-ascii?q?wILEggVLAgDAgMIAwIDIwsCAxcJBwoDHQgKHBIQFAIEEx4LCAMZHywJAgQOA?=
 =?us-ascii?q?0MICwoDEQQDExgLFggQBAYDCS8NKAsDBQ8NAQYDBgIFBQEDIAMUAwUnBwMhB?=
 =?us-ascii?q?wsmDQ0EHAcdAwMFJgMCAhsHAgIDAgYXBgICGFYKJg0IBAgEGAQdJBAFAgcxB?=
 =?us-ascii?q?QQvAh4EBQYRCQIWAgYEBQIEBBYCAhIIAggnGwcWNhkBBV0GCwkhFgYpCwYFB?=
 =?us-ascii?q?hYDI0onBUgPKTU2PCMMIRsKgQ0WLAkkIQUEHwGaXYEvxHUHKYMooC8VqGOWb?=
 =?us-ascii?q?iCmbQIEAgQFAg4BAQaBd4F/cIM4TgECAQINAQICAwECAQEBCQEBAQGONh6DO?=
 =?us-ascii?q?4peQjM7AgYBCgEBAwmPAQEB?=
IronPort-PHdr: A9a23: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
 LD2ZpUlcdnzTH29Vw7m4w8=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:vqDrdKqDBGK9L5cQcASGwR4aV5oFeYIsimQD101hICG9Kvbo8P
 xHnJwguiMc+wxhPk3I+OrwQpVoLkmslqKdjbN9AV7mZniDhILKFvAe0WKB+UyDJ8SWzIc0vs
 1dmupFebjN5DNB4/oSlTPZLz9W+ri6Gc6T6ds2hE0dND2CI5sQlzuRJDzraXFLeA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,209,1650924000"; 
   d="scan'208";a="42222698"
X-MGA-submission: =?us-ascii?q?MDEGBBlXsHbzLBJguHE+JBIOTIrHzw2VMBRBYo?=
 =?us-ascii?q?1iJwCzpR84rsyVfg530tyZCFyHOvWVEGQfyygTW6nvoL7twkeivG7LYt?=
 =?us-ascii?q?Y4vLzHVUcwxEtouOHlsl1QBY/f3SHneXH1nI6CzUaEt1145PNjd6lzrr?=
 =?us-ascii?q?Ss2KyPdCysoOXEC73LJw/qhg=3D=3D?=
Received: from mail-db8eur05on2121.outbound.protection.outlook.com (HELO EUR05-DB8-obe.outbound.protection.outlook.com) ([40.107.20.121])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 18:10:25 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2xET1WFkvLbuyi295DBSZT586sHVdEXzlfxCjv8FhNURiXl4Br/AJSmCyo4FX8KlP54b8sVGrUE6bLPEPe3d4oB2NVfQtARNWujajNPFFFDsM2B0IQscG+ZYW2bTsknA7wLZm1icgDi4NtM52wpuGAC7MSDFS1PoVcYTkt0A453vB2jsLNgWqtcX7pWLo4bwVxJvszijkevMa78q92MQ2UFYPD45FMsAAX1SZ02n0NLlBq/auMJqkxymyZAQh4BkewsSZBhp9afEZcWXu26V7yz2CfMRsNVuE1qHajJ8Sp5lbhl9Od1xNINh0KAjTSOuacvveqkCmjDzKmj/a9Gmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7MCgaHdN16Q6hHgWrp7vZcmxRDBSa07tbUOSSmXP5M=;
 b=Yl9plQBLCZC4HRT2GaaGqB5aKNXS5DP5FQ0VzZzk4n10GkVbO7PrlviqD1+XVR+vFRSNdPRHmOtqiQlMBIzgwHKN+7UYbCC/FvDL0jBAA8kuIS0gRXF5K1EG3a7dLBMtR4pgRpS4gTNW991YnBtSLxWug4gA90n9rMgdo7jDyjIlqgzpaS/kQG3L1nfiiLb3vr31nPVVgh10vUts0ChVFjaU+7n+OlgIgkoZNgMkPrxDP82o+t8axIWkJ/yzL9tpoClAbWSo0FWGp9/9Oi5FLuPICNyszLE9C/6TyEjSgkXGQi08ATYodOLT05Up5Zs6zR1iNM/l+1VaOxMxEnhQEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netatmo.com; dmarc=pass action=none header.from=netatmo.com;
 dkim=pass header.d=netatmo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netatmo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7MCgaHdN16Q6hHgWrp7vZcmxRDBSa07tbUOSSmXP5M=;
 b=GovrXu+6z+DnZ9yH4TWdgUcV6fBLE/wdxwYbX7Go1GXUJhyMNGklLosT3yDrWArAszZOZtjA65v6g5icHJAokz2gJe/8yrCECZKfTqxauGzn51seOsmm00AirJKKM5VLs48JQROVilepvgl2Z9FdSpUHVYWQpa3n9c0pdKnmQV4=
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com (2603:10a6:20b:34e::15)
 by AM0PR0302MB3187.eurprd03.prod.outlook.com (2603:10a6:208:7::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Tue, 21 Jun
 2022 16:10:24 +0000
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::8175:20e5:60ec:b87d]) by AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::8175:20e5:60ec:b87d%9]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 16:10:24 +0000
From: =?Windows-1252?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
To: Markus Elfring <Markus.Elfring@web.de>, "cocci@inria.fr" <cocci@inria.fr>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
CC: Julia Lawall <julia.lawall@inria.fr>, Nicolas Palix
	<nicolas.palix@imag.fr>
Thread-Topic: [cocci] [PATCH v3] coccinelle: Extend address test from ifaddr
 to every test expression
Thread-Index: AQHYfLsCmi/5kwNDAkqS6gBbhAOymK1RnEyAgAh8uag=
Date: Tue, 21 Jun 2022 16:10:24 +0000
Message-ID:
 <AS8PR03MB7603675681B64E5F14C1995593B39@AS8PR03MB7603.eurprd03.prod.outlook.com>
References:
 <AS8PR03MB76033CF2848D03651D6E189093A69@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <6aef3ee4-d934-daff-7145-73ac563d2fb4@web.de>
In-Reply-To: <6aef3ee4-d934-daff-7145-73ac563d2fb4@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46de47dd-248c-499b-51ef-08da53a08cad
x-ms-traffictypediagnostic: AM0PR0302MB3187:EE_
x-microsoft-antispam-prvs:
 <AM0PR0302MB318722AFE9D8DDC9450DFB4C93B39@AM0PR0302MB3187.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 22ZpHalkA5Wqn7HlPbbXqaGTSw35kp+viPkKP4LnjmfcYXGt8egUfc1ISUk5Z6jYRTJnUNHAz9xdZ/u3yiosG3WATMDhML/v7Cb55TqbJuVRCFB+4dM7jYlebhpQ/8XVoT3eJJnDZhD5idmYXlQPFNQ5TIx3BsSGBBD3VK/1azTegT1LF8bQgZ+XOxfM4QxgSb2E0IucB/pHSMfdkGwsiavkp7OHO7Qyq/m4bXQ58p75kZS6rib2s5RKcue16QuhUMT01qIM1z0pCuqnHoAUNiHkdnsEHWKhjvC30+UY7kdu1vECYMJhh/fL8ngGtXG25V+5x6n+CUY5+OmYF0X0Novc2mT1lT/ya+HPdIdZu7uucU0jcAvrLZIJ9nwZdK9OWgPTKNws/6oi050me6OFI8S41AuO1w1ZOwCwocyIfE6qUjUVmakPwQzWmfeAGhOy/akbH1/Ouuou8MuVc70jJvTF9ZLcAMrROMXOVGhsOn+A2ZScQiLG/wOxpxo2IfNG6ZvQMuyCTK77jPvXIpa5Vgzq8/QLWzdynsjxpXexPTTLeka12C75n7GvbU6lPWTGYImwwfRn/qUw2bS/2zb1WshDJEugnZtjnWADnoPQUdlfOrKOAotCAVTf3nCErppw7DcLeLNHfV4+1rbnf4WlzLOtWl1xrehPoLuHg0ZlUPlCOhJ/qAOIbpKjCc3KvGlKme0kBYwGgp/OsCo4osfOlA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7603.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(136003)(376002)(39850400004)(38100700002)(6506007)(55236004)(5660300002)(52536014)(110136005)(33656002)(55016003)(478600001)(7696005)(41300700001)(4744005)(26005)(8936002)(2906002)(66446008)(4326008)(54906003)(83380400001)(316002)(66946007)(64756008)(38070700005)(76116006)(71200400001)(66476007)(91956017)(186003)(86362001)(122000001)(8676002)(66556008)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?KfHEkp7Fd4Hk5wCqGH11EFrf44v2id3t16gDgZ310COgOYxJk6XVcroo?=
 =?Windows-1252?Q?7kP0I8Nux5rzWvomEoaV7OGlXih+UaFv5grkOXD4ZdN7s0kC0dQhqQ2V?=
 =?Windows-1252?Q?YkX/bhrPbIODVzrRy7wwGlscWTo8HehUZCfGgM8SnLTtV+c2/rw/36z0?=
 =?Windows-1252?Q?Cc8u4OUODIMkFd5bqw7moI7KbfpiuxNhSegWkTYx87/s2y8JvMOqlGlt?=
 =?Windows-1252?Q?O8XOgA6nL3Fwcc5su4yi48jDOPxVUTuWAMNLnLUv5EABGYC78bFWF392?=
 =?Windows-1252?Q?C8yeUQkPAQFHJGRe93SfA6NcKfZcoAqkWY29cUJiCQTh+tT+OqEZ8Y6B?=
 =?Windows-1252?Q?BP/Dc6/VuQHRda4drRpjEmlKfIAPLUIwSvUrwb/ehHZ1MfO3S95am7Yf?=
 =?Windows-1252?Q?1iou8FmKoG+5IcRocZU30OwYpNDhc0pkDtW8ZmRk7Go8Lf8nbv8lODXE?=
 =?Windows-1252?Q?0Cnx63UBc/xikBf6FccPjMfT2qCOubJo6N4SNOLJgiQat+i2L84MiqiN?=
 =?Windows-1252?Q?piiCx132+F2fefqTcMdgdW5QozS3XFgA8TN0Ya7Twd13EYJt5ZkixDyp?=
 =?Windows-1252?Q?/1WU2iW9F6wx3wm5FvvLpj5Tn9pRrSq9W4dGd2Zyg/4DqNAlVs3F8wN5?=
 =?Windows-1252?Q?VtzhC8628sTdL2ZBhCxApkC1gNRG+CiYDkPLkaXsKVVUiOu+8eqROhd3?=
 =?Windows-1252?Q?aeaihzg4aclyq/wbfN/3Rn/PMJsKpvwWkdsciXwEtkMgWBGq53DQoWjT?=
 =?Windows-1252?Q?g0pujSAm4WdKRR/fpqMID9dgG7cUf5t9pWxl5wvrxqAj70iueAr8hvTk?=
 =?Windows-1252?Q?MDr0EqDjemL8Az4dXO2VL2UTAHpL9D6EzSsCLrdub7YdjussK4Ifpira?=
 =?Windows-1252?Q?xLud0czI9IOORJASTL9EOmGcZXrvv3GUi/EFmOT2WZbM8x6g+BHVtGe6?=
 =?Windows-1252?Q?gGA01ISZQUGJvhcrvucKek8qYYQX6URP6ERVWQrd/slF8JUsYpf5qppV?=
 =?Windows-1252?Q?GPYcbtVH2a56lgmzhxhV8gqbh1b7/N/GAFWrBGayF3d9ah906d5HCVtT?=
 =?Windows-1252?Q?A1cYABi5+4KqgqcAIcdMv6LXbXwiS/2lK2AC1l6tn9Ywv8wjJFjGeRs/?=
 =?Windows-1252?Q?4UKuiK1AVjY78/bPUYWPgfTarmPQi7yUksMyp71sDuadiu7IFnMxk2a1?=
 =?Windows-1252?Q?iLOr5m1JCbqIltR0l3M975ci046ipo+WkKlps3LKTdLxXrO5YNMbWnuZ?=
 =?Windows-1252?Q?a/SfKHdYN9fvZDcM0/xdK0P2KSy4xHTA2OOkw21COjz4dctBUxWRL2gW?=
 =?Windows-1252?Q?z3SaLtBhOqiwYljgAnojR978XPfDjEMDno4cCODHwPDbvnuiwHBw0+DR?=
 =?Windows-1252?Q?ICxzFFtRg5iloX+J5FxmL2Z07Cy4u3gTbb+FxQeuAsaksBxgW1AwYcvr?=
 =?Windows-1252?Q?c5Qb4JbzBW7nxLnuR5pGRLD/+rZIp0OA3kKxjs60uMyuC6o03u6ggs6N?=
 =?Windows-1252?Q?Nv1P0DBXwej5Smel5U+h66aShML6l42t+KCP/VsgG4mWDj79oNDJdQ+5?=
 =?Windows-1252?Q?2+AZ37UcInmYiEEqJh2FelH0IEI5ERnDNkPCBI5SUY0PHkGgUUQufNVy?=
 =?Windows-1252?Q?humKYfTbgNewdi4pge5lvnBgFGdBLhQb3rXAqtdwxnquXKT0lmjevrBp?=
 =?Windows-1252?Q?7pM3NzIBtrvM4p3ojXNLk7PWom+lzqj+g5aWQjBBJmt/rJGO+JH9TeHo?=
 =?Windows-1252?Q?cRKqTHxX6Z3gHQOEZBVSiR83cCacHHEAFQjgV+VOR+Gfy6MCZlM3fNjq?=
 =?Windows-1252?Q?cFuD2S4BdQ5NoBeI8qbp6ZeQEnaxSe3hiqSlPOtu81/yychr+7YABkxN?=
 =?Windows-1252?Q?CDc/jwcv7myJCVcPBnlzWPSTZioOV39ZLVA=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netatmo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7603.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46de47dd-248c-499b-51ef-08da53a08cad
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 16:10:24.6388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4528446a-2666-441f-95cd-cc2cbd9f2c49
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5jeAHGZvVz2AXyqroIvlYakwuudX8A+z0mIgPsa0rP0qtuV4TIYxf8xZkvjgKm/SHy6s2HoHi7xfGUCc3H4mwJWMAJdJ3jE/pOId+CK5BoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0302MB3187
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v3] coccinelle: Extend address test from ifaddr
 to every test expression
Reply-To: =?Windows-1252?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
X-Loop: cocci@inria.fr
X-Sequence: 454
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/AS8PR03MB7603675681B64E5F14C1995593B39%40AS8PR03MB7603.eurprd03.prod.outlook.com>

> It can be determined that the proposed approach for the detection of=0A=
> questionable source code places is incomplete (also because of the curren=
t=0A=
> development status for the Coccinelle software).=0A=
> Thus I suggest to reconsider the usage of the word =93every=94 for the pa=
tch message=0A=
> once more.=0A=
=0A=
I'm not against changing the patch's subject. Would you find it better=0A=
if it was "coccinelle: Extend address test from ifaddr to test=0A=
expressions"?=0A=
=0A=
And what about you Julia?=0A=
=0A=
> Will further adjustments become helpful for desired source code analyses=
=0A=
> and corresponding transformations?=0A=
=0A=
Do you mean adjustments in this semantic patch or in the coccinelle softwar=
e?=0A=
=0A=
=0A=
Thanks,=0A=
J=E9r=E9my=
