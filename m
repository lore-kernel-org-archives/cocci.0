Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B73C433EF
	for <cocci@archiver.kernel.org>; Sat,  4 Jun 2022 11:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:content-transfer-encoding:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=KUiSsQHJ93cDwoizlXaUnLYBlb9pRBig6JshYzhs4s8=;
  b=PnNABqeRMrkCaj64bWzRWEsKsfNrbDo3O0pp0xwBPfJhZIc1u9S1SaeG
   kIixgJ4utzfx8pgxP8eFhWHvLoQYLAKt8tF+UOHeorNtlxbk8fGGvbrhJ
   vYQ0vD+A5hovsM9GQaZRQoyyca4DSbzWvge9eFFFgr/9RLS077Zlm7GMs
   E=;
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
X-IronPort-AV: E=Sophos;i="5.91,277,1647298800"; 
   d="scan'208";a="39498275"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Jun 2022 13:24:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D5FA0E02B4; Sat,  4 Jun 2022 13:24:10 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E5B52E0380
	for <cocci@sympa.inria.fr>; Mon, 30 May 2022 17:40:54 +0200 (CEST)
IronPort-SDR: qujtYulc1Qpc3G7cXnaRzRmHUr+pM9+B33TLjeP5YnbtVqVJH5DXKvGPw2z5/crNiYg8m8TtwA
 QrYB2oQh0EeZ76H5r+bmeRLAjCAN2gyGArHAvW7yMfmiNP+jSeQfF1nQ/GswjwgyiL4tGxOb1j
 5RI9UBIk0Xx1IT+uUBcA7ZCYOpBDrPHzgDLm0ERJ8jQ5alTcTuG9Og8wHi+BdFItC7H5To0Uq8
 MH81/dd3zOI85eNQxWYq8XLt4YLM7E0TT5/iwbPEQFa97czpTDT7Xf4bTpdPefoRez7+OZ0IKe
 I3FhnfYBJ0s4ObiHHx0IKi3P
X-IPAS-Result: =?us-ascii?q?A0D0AAAy5ZRih4IDayhaHgEBCxIMQIFEC4FSUn5ZKQMHC?=
 =?us-ascii?q?ESIGgOFMYULn2yBfAsBAwELAkIEAQGFAgKFRR8GAQQwCQ4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBAETAQEBAQ0LCQUICgcOEAU8ZIEIAYFOAYEwI?=
 =?us-ascii?q?wsDMQ2CNSkBg2YQBi4BATcBEQGBACcEAQ0FCBqCW4MaAp91AYE+AgKLFYEzg?=
 =?us-ascii?q?QGCCAEBBgQEh10JgT2KSIZrgVh5gT5ugQ+DN4QLgi6UW4IFOwNONRKBIXEBC?=
 =?us-ascii?q?AYGBwoFMgYCDBgUBAITEVMdAhMMChwOVBkMDwMSAxEBBwILEggVLAgDAgMIA?=
 =?us-ascii?q?wIDIwsCAxgJBwoDHQgKHBIQFAIEEx8LCAMaHy0JAgQOA0MICwoDEQQDExgLF?=
 =?us-ascii?q?ggQBAYDCS8NKAsDBQ8PAQYDBgIFBQEDIAMUAwUnBwMhBwsmDQ0EIx0DAwUmA?=
 =?us-ascii?q?wICGwcCAgMCBhcGAgJxCigNCAQIBBweJRMFAgcxBQQvAh4EBQYRCQIWAgYEB?=
 =?us-ascii?q?QIEBBYCAhIIAggnGwcWNhkBBV0GCwkhHCkRBQYWAyN4BUgPKTsFBB+XdHEBg?=
 =?us-ascii?q?Q6lAp8WBymDKKAqFahZAZZoIKZqAgQCBAUCDgEBBoFhghVwgzhOAQIBAg0BA?=
 =?us-ascii?q?gIDAQIBAQEJAQEBAY4dGYNZil5CMzsCBgEKAQEDCY4SAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aul6LbK4a8OgFr6v601VXVM+2mlKPhehNZqD/8=
IronPort-HdrOrdr: A9a23:xZw5sa5n/YqWNBiTawPXwUmBI+orL9Y04lQ7vn2ZFiY5TiXIra
 qTdaogviMc0AxhIU3Jmbi7Scq9qADnhOZICO4qTPyftWjdySOVxeRZgbcKrAeQfBEWmtQ96U
 4CSdk1NDSTNykdsS+S2mDRfLgdKbK8gcKVbJLlvhNQpHZRGsRdBmlCajqzIwlTfk1rFJA5HJ
 2T6o5svDy7Y0kaacy9Gz0sQ/XDj8ejruOrXTc2QzocrCWehzKh77D3VzKC2A0Fbj9JybA+tU
 DYjg3C4Lm5uf3T8G6S64aT1eUZpDLS8KoCOCW+sLlXFtwqsHfrWG1VYczCgNnympDr1L9lqq
 iJn/5qBbUJ15qYRBDOnfKq4Xis7N9m0Q6f9beV7EGT3PDRVXY0DdFMipledQac4008vMtk2K
 YOxG6BsYFLZCmw6xgVyuK4Ii2CrHDE1UbKUNRj/0B3QM8bcvtcvIYf9ERaHNMJGz/78pkuFK
 1rANvH7PhbfFuGZzSB11MfieCETzA2BFOLU0ICssua33xfm2141VIRwIgakm0b/JwwRpFY76
 DPM7hulrtJUsgKBJgNctspUI+yECjAUBjMOGWdLRDuE7wGIWvEr9rt7LA89IiRCe41JVsJ6e
 f8uX9jxBAPkhjVeLKzNbVwg2HwfFk=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,263,1647298800"; 
   d="scan'208";a="38624046"
X-MGA-submission: =?us-ascii?q?MDGypHshNxcYtUHDXYH+Fb+cpCUSAuOCG+Qqh/?=
 =?us-ascii?q?cLY1b/dgP6oSt/OZC094hqyiyzkNRdImUswqoH7z86DRt10iiRAicZwS?=
 =?us-ascii?q?zdB8rmcaCfk8pD0WdmvRHZznh4Gvl20sXSjf/fqprDeyGlulhNbGoLfk?=
 =?us-ascii?q?ReYOMeNujVmITeJ+xvePhHyQ=3D=3D?=
Received: from mail-eopbgr30130.outbound.protection.outlook.com (HELO EUR03-AM5-obe.outbound.protection.outlook.com) ([40.107.3.130])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 17:40:39 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIatHwYFWEs0NThg0fQsAznYmgQp3Gup9r2j4VGUSGsNpJY08rq+pAA6AcWE+YYXtEwLwQUSyBGml2bQFaO0tY9MA77jClkqi7fOi3apKIE2NFeqfZ28Cp0uhBbEreqFx0wjFD8chRAFZhGt6k73wgN1hzsY6R3iK2PhjFkk43ucNf8YtbTmEMIEfGf8/klrQvM9h7L3B6HNwiZov5GSHbn3GwrX/UKF+QoCLiEf9xCWmAUGKjkJcLPFgQn2XycCEdPj9RA3mx40eJim6GwIgE6Qw4Kd3LDu5hQHJFLsla0dFRs4tMUcZoCXMJqeJtG59LpB7bfg3BXvnvHP3YI6aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUiSsQHJ93cDwoizlXaUnLYBlb9pRBig6JshYzhs4s8=;
 b=O/tCKotPPCf3yOxWhYlmbjpLC2Mo7tFodwzf1xsbtEUcD34B1Mr6RQAun3/VveesaJX/aKmlY7BNRllxGfaMymR7KWaCGHQfO2pPmPTf+Bh67uiHrvrrHQrjCe1Mh2o2XLtuEXPPGHB8xrWB/eZHXdETNP3WNJ41VDjhg1gv6MtThu5We0CZc0lZKUhXcTbg2huEnmguNzvywZKoGE5l/LkPA4mls/wdb3C81e2zHWmDG/2J7BYf3SimJ0P1LVY61UGgw3ySs9zSHl1m81SoyXGd3/e/IzEy1e6X5A80ZJUgyTOKk/OfPZsTU22+w/4lq4uG1WCxleLd6hSWx+dYYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netatmo.com; dmarc=pass action=none header.from=netatmo.com;
 dkim=pass header.d=netatmo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netatmo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUiSsQHJ93cDwoizlXaUnLYBlb9pRBig6JshYzhs4s8=;
 b=diBfFNuSVLUDKE4UMfnrHCWcnKoJkHvQbLa0yfBDFZPWvRmmXsB19o5+LN1YgLF6zLwCMeGhNLDohIw2qoZvwC60oKfBB+hoqca53F290Nny6k1mKYMvmV5NRCvM1ON6rirkHqqR1g4Xi3bvFcsSz8AFq9nVcp+fAJaP9MDoysk=
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com (2603:10a6:20b:34e::15)
 by VI1PR0301MB2256.eurprd03.prod.outlook.com (2603:10a6:800:26::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 15:40:37 +0000
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::197:874b:24ea:e4d5]) by AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::197:874b:24ea:e4d5%5]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 15:40:37 +0000
From: =?iso-8859-1?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
To: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
	<nicolas.palix@imag.fr>
CC: "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: [PATCH] coccinelle: ifaddr: Find address test in more complex
 conditions
Thread-Index: AQHYdDtaSsV9bHjawkKxSgGKgkpPXg==
Date: Mon, 30 May 2022 15:40:37 +0000
Message-ID:
 <AS8PR03MB7603A9FB9FA6A62438B09A3793DD9@AS8PR03MB7603.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9f05d49-f204-450b-3357-08da4252be56
x-ms-traffictypediagnostic: VI1PR0301MB2256:EE_
x-microsoft-antispam-prvs:
 <VI1PR0301MB2256EAFDAB271562C845674493DD9@VI1PR0301MB2256.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7Fohl+mCI9C3ypvllrCByccTpOdMl7ituuBzxXVbVyuEyQ9YBNhCt+SEYaPDv7k6Cbppfnfvzssxt54VE3WzxH0uCwUneG81WcMdJBgKYBXTDvsZruW9vUYtK2EHp2qPmhbiCMrZFADSztcF62bDOIbukzzEZvd97buthkl8EtaaUKcArEuaeYa15H52Satgu2pJR5KaAv2PleJ0W/qFPKL1n0o3gn15RxosFkl87XKAKVVohFQZLpA0tl+FfhyunFJP6IfMD8uN0vt9DNsBdUt/LIAKQRWA6QY5nTME/F1EUCTwx+oKUrVdRxDsaRQrGqtEGce9svtbMkq+sV6mDp5AFpxylz5eAmCby8duRwxmDkcWazZQlihh83PNVgFq6uzUrc2UD/sC4menxJBP8x8eSr9qzW7+NS5U4d+2tPEoIW/wBOMu8Z1hc1uoyjs6LAvrYqU7tSnYMydvF8vE9jVy5iTLZhLJg4T00IWb3Ho030Jx3Dcif9+xvfdvELh0EHj/kQ1gyt+h58yvHPZLE4/OPwGJHm9p/IkNaghWtIiyzdsKw3nzM1sjjGgEy+PIFKfFhRBxCdX6LJoIl0GkcRVTyx8ABVqlKiUPIxoRNUi+LsJNE1CLFBdIWxigUX7xDINki+dOEFGOyECVTP2qlI3UGKhOml5IQunN9flVVfit4kHUKFmpyCQFwJr8H13GC3GdpHtH3hm0jgCIknGxeQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7603.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39850400004)(396003)(366004)(346002)(136003)(376002)(55236004)(2906002)(7696005)(6506007)(26005)(38100700002)(9686003)(38070700005)(33656002)(122000001)(83380400001)(186003)(41300700001)(4326008)(8676002)(8936002)(5660300002)(508600001)(91956017)(76116006)(86362001)(52536014)(66946007)(64756008)(66446008)(66476007)(66556008)(110136005)(316002)(4744005)(71200400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+nvlXalBa+hMvXEKKLh3l3Ut/CeFVeJTmJHnSA6U2gpcEtzTLJJrE7SZvC?=
 =?iso-8859-1?Q?27+xHAZ/LzzmlT5DNHRbRVdqboXl20tk4fmB5eFbN9r4UinBoyPiO/NHKa?=
 =?iso-8859-1?Q?FX2C6weLtU31hj7NDo/X2Y4dVATtB7kmvEywoBh0lm0+C2Djf0sthSF1BO?=
 =?iso-8859-1?Q?jxvpheBW6XTvMKFTSyCCbKWFMEOqjsn7SPRbyDSXBhjXdeDpmu2lzoaSSP?=
 =?iso-8859-1?Q?eFk2eOcmtUUsqDvkxFETS6hK2LvojN/dogTJ6zIRUI8TvjFVwfolsG19X0?=
 =?iso-8859-1?Q?2zIZYOIphMvQa1VTS/37B7iM1zjbjZA3cdwU7KaLia8Jzz4cHu7GcM0zvs?=
 =?iso-8859-1?Q?ip3R2SNB+9liqYhU6GeiO9NWSACRxJQlgz0vfUH7Ap8yGJ3wtLJHU9EOZL?=
 =?iso-8859-1?Q?FEC34ghx3IBQAIKqBilATX1s62s641ca2UtB5FrMCft2tdear5YjaOmlL0?=
 =?iso-8859-1?Q?aX9NIMpfY25FmAfT6+oGMT4B+1xbcyXPNehgLVLE5WfyjouhktiaX0d2XR?=
 =?iso-8859-1?Q?G+4UWHisSfHEZyNlRZjuFtZsfAteKhC99YEZq0+8LcEB3csj+g9amP5Dr9?=
 =?iso-8859-1?Q?25XnxUhTClyoDa5djRvo8rdORcGOSRX89Kt7MLKxKu1HVh7IN9BKjwZIfw?=
 =?iso-8859-1?Q?XtdohhJ7xDAPHu3ZyRmhC3Zj3TpEnb5ZUFTUyfpj9u7WS4rQFhMe94pkjD?=
 =?iso-8859-1?Q?FyD6W453fMuuCy/qWgPu5/n0B02p8P73ADY7RjnV9qVQPo7xKr8l2zPJiA?=
 =?iso-8859-1?Q?g3uOuwsrZIXF57eliY7c0HxIEHyJMvpE/rJMLBiFwTggq5+dk7Hp91l8/+?=
 =?iso-8859-1?Q?k7W0SJ85VMmYT0sF4sPEm5jNU4P7BuKk0uTOz8cuG9sLD5y7ls1ip8LWZd?=
 =?iso-8859-1?Q?umtv5FULyEWZi0tZhFUlf4ebL0VYwxldRgT1Ff9QFQq5NHLW17ugG05iZo?=
 =?iso-8859-1?Q?Uruw9qRiLCEs1ziuU5CBwnBZ1Z15VL7FbLKJEm3AO39HlnArIghhoJofdB?=
 =?iso-8859-1?Q?uwb/vZAQnM3QXxv4859T5luXHXgbcR3lmT+/kbR2fK1rsnxirQ6navccuP?=
 =?iso-8859-1?Q?0EchhgBOQe5LYtW3dzULWtG36Qfrr26nq+AJNrPRqc2RcuZwZb9bIoMvE0?=
 =?iso-8859-1?Q?VbGk+xf3LdStveUAIrlruSX9kkNwjRjIuiLHcolYqdgy0Sai8IsGSF0SUT?=
 =?iso-8859-1?Q?BFQ1+4TDbGPQFp2OYLFPUajptwB7d1vyMOfFHlXenwCcE4FozGzDh9CS2l?=
 =?iso-8859-1?Q?KsK5OCjuhHG+Ql9geIFUrSjmO7uDlHdzR5YAP5rBcC+UTum3/CoMHOakIx?=
 =?iso-8859-1?Q?m2c5wlaVGTWPcwByDwcSG4CisFTu6jECHDUf0aEAs2/4mF56lfJzky9tn2?=
 =?iso-8859-1?Q?OfSJ9CpzJf4qGwIRCYeaOnKL8fStrU4SDzZPpaO7ROd5s808sMek8WlM8/?=
 =?iso-8859-1?Q?1X2yAGyfa934RJg3GX4IL5rT870GrCZwfahDNzlGHKBvdLFbm6ezxTJN1t?=
 =?iso-8859-1?Q?wbtbi0zka3PpoJV7GdGrWsavFdWto4mWzJpYbw5pDp6GshulFfSv8KfX1U?=
 =?iso-8859-1?Q?fPMvjFxlVfziH/nWShfcuER2SfFV8QUPaxdxXPRE65SKSah810fGq/X81K?=
 =?iso-8859-1?Q?UetehVpEUu//wfArHofj+8xHUt0fcmpOCqmxM3uaC/5jIl6E0MQzvKNKJX?=
 =?iso-8859-1?Q?9J76NERjuUWVlZp2h2rC0wNdI/i2uAH8gFYqYnO+2Tu/AsmLV6VeWlP9Ys?=
 =?iso-8859-1?Q?ShkjWlHYWbXCEgktZ5jt5CK/6xGk26K/XI7owm8fC/etxicz2gjr9Jtg+k?=
 =?iso-8859-1?Q?aw8R2z4wGrXLeBLUErvTrXbl3DtB+oQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netatmo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7603.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f05d49-f204-450b-3357-08da4252be56
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 15:40:37.3793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4528446a-2666-441f-95cd-cc2cbd9f2c49
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUXkudrI2d+KzC9PiQMwY/ioyH0qIjDs5ThSJGhqZn1DTeTEp6umr7czBnQo0zXWqgj0bsB7z5KKyT4mfV3zchNtQm+zbrQMeTfpbCT4qkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0301MB2256
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] coccinelle: ifaddr: Find address test in more
 complex conditions
Reply-To: =?iso-8859-1?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
X-Loop: cocci@inria.fr
X-Sequence: 411
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/AS8PR03MB7603A9FB9FA6A62438B09A3793DD9%40AS8PR03MB7603.eurprd03.prod.outlook.com>

The test of an expression's address does not necessarily represent the=0A=
whole condition, it may only be a part of it.=0A=
This change aims at detecting an address test in more complex conditions.=
=0A=
=0A=
Signed-off-by: J=E9r=E9my Lefaure <jeremy.lefaure@netatmo.com>=0A=
---=0A=
 scripts/coccinelle/misc/ifaddr.cocci | 8 ++++++++=0A=
 1 file changed, 8 insertions(+)=0A=
=0A=
diff --git a/scripts/coccinelle/misc/ifaddr.cocci b/scripts/coccinelle/misc=
/ifaddr.cocci=0A=
index fc92e8fcbfcb..387af44a1256 100644=0A=
--- a/scripts/coccinelle/misc/ifaddr.cocci=0A=
+++ b/scripts/coccinelle/misc/ifaddr.cocci=0A=
@@ -18,8 +18,16 @@ statement S1,S2;=0A=
 position p;=0A=
 @@=0A=
 =0A=
+(=0A=
 *if@p (&x)=0A=
  S1 else S2=0A=
+|=0A=
+*if@p (&x || ...)=0A=
+ S1 else S2=0A=
+|=0A=
+*if@p (&x && ...)=0A=
+ S1 else S2=0A=
+)=0A=
 =0A=
 @script:python depends on org@=0A=
 p << r.p;=0A=
-- =0A=
2.25.1=0A=
=0A=
