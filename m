Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25753C43334
	for <cocci@archiver.kernel.org>; Tue,  7 Jun 2022 09:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:content-transfer-encoding:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=dItGQ+h9yQ++1HDINsJSpXm4WKQs9notJnf+PenvKxM=;
  b=WGb/B1UV5mSOx9WEuW20c8x44Z0RyJmEUbmov2HH2JO8xqGcJl62r0UL
   3SEkcMhVTxRPG2Tm9/MtXzv7dP9zryutSAAI+PnI+It0WP7cyghA3WAjK
   AxPqxj/CkfXoUoFATrxMDz+kNERJNxvCw2Smvmfp4vLklMH2K/cMCrKYF
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
X-IronPort-AV: E=Sophos;i="5.91,283,1647298800"; 
   d="scan'208";a="39784039"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jun 2022 11:44:38 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0F423E0B4E; Tue,  7 Jun 2022 11:44:38 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B67A6E007E
	for <cocci@sympa.inria.fr>; Tue,  7 Jun 2022 11:15:38 +0200 (CEST)
IronPort-SDR: FD4jHUBGlZM3HCa+vHMfibnJZ+DJ9URPu4SCVSPinnmjEdnZTcsyaWXhugkAVPKQfCOnA9xpYp
 jIzYX5npwFF8i/gNSEDDgoszw+qTO8EkLX+jH+j8l/DjaMhdtMroe8x6AglJNbNmdOBYvnZR/H
 NV5HczycRiUy1zEUs46qYBk7qAYSXYiEqB4wKhDkZyzC5r0NHPkhmR+W7l9m/YroaWJ8BR2fZe
 Poje0XiJ+Vul4zFTxOyjAo0nd24e0X1WqPskHtTxJS/A0wyMWHtmLuldObgApPzAVhp4l+8cSX
 y/kD2VmHp2nXZnZprKjD0d9x
X-IPAS-Result: =?us-ascii?q?A0CUAQCkFp9ih3QGayhaHgEBCxIMQIMhUn5ZKQMHCESIG?=
 =?us-ascii?q?gOFMYULoWcLAQMBCwJCBAEBhQIChUcfBgEENBMBAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?wEBBQEBAQIBAQIEBAETAQEBAQsNCQUICgcOEAU8ZIEIAYFOAYEwIwsDMQ2CN?=
 =?us-ascii?q?SkBg2YQBhUZAQE3AREBgQAnBAENBQgagluDGgKfGAGBPgICixWBATKBAYIIA?=
 =?us-ascii?q?QEGBASHXQmBPYpIhmuBWHmBPm6BD4J8O4QLgi6VOIIJOwNHNBKBIXEBCAYGB?=
 =?us-ascii?q?woFMgYCDBgUBAITElMdAhIMChwOVBkMDwMSAxEBBwILEggVLAgDAgMIAwIDI?=
 =?us-ascii?q?wsCAxcJBwoDHQgKHBIQFAIEEx4LCAMZHywJAgQOA0UICwoDEQQDExgLFggQB?=
 =?us-ascii?q?AYDCS8NKAsDBQ8PAQYDBgIFBQEDIAMUAwUnBwMhBwsmDQ0EIx0DAwUmAwICG?=
 =?us-ascii?q?wcCAgMCBhcGAgJxCiYNCAQIBBwdJRAFAgcxBQQvAh4EBQYRCQIWAgYEBQIEB?=
 =?us-ascii?q?BYCAhIIAggnGwcWNhkBBV0GCwkhHCkRBQYWAyNxBUgPKTU2OhcMBQQfmEdxA?=
 =?us-ascii?q?YEOpQKfGAcpgyigLBWoW5ZpIKZqAgQCBAUCDgEBBoF4gX5wgzhOAQIBAg0BA?=
 =?us-ascii?q?gIDAQIBAQEJAQEBAY4dGYNZil5CMzsCBgEKAQEDCY0sgkgBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 dywjTI84K8JUHvanYwUd1lt2pSlPfmPYdc=
IronPort-HdrOrdr: A9a23:udBmfaCfAc4x+g7lHegtsceALOsnbusQ8zAXPh9KJCC9I/bzqy
 nxpp8mPEfP+U8ssHFJo6HiBEDyewKlyXcT2/hbAV7CZnivhILMFu1fBOTZslrd8kHFl9K1tp
 0QOZSWaueAa2SS5PySiGbXLz9K+qjkzEncv5a7854bd3AOV0gP1WdEIzfeNnczaBhNBJI/Gp
 bZzNFAvSCcdXMeadn+LmUZXsDYzue72K7OUFojPVoK+QOOhTSn5PrRCB6DxCoTVDtJ3PML7X
 XFqQrk/a+u2svLhSM0llWjoai+quGRiuerN/b8yfT97Q+cyDpAUb4RGoFqegpF5d1Hpmxa1O
 Uk6C1QRPibo0mhBF1d5yGdljUImQxel0MLxTKj8AbeiN28SzQgB8Vbg4VFNhPf9ko7pdl5lL
 lGxmSDqvNsfGT9dQnGlq31vitR5z6JSLsZ4J4upm0aVZFbZK5arIQZ8k8QGJAcHDji4IRiFO
 V1FsnT6PtfbFvfNhnizyBS6c3pWm52EgaNQ0AEtMDQ2z9KnGphx09dwMAEhH8P+J80VpEB7e
 XZNaZjkq1IU6YtHNRALfZERdHyBn3GQBrKPm7XKVP7FLsfM3aIsJLz6KVd3pDZRHXJ9upApH
 3saiIniYdpQTOQNSSn5uw7zizw
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,283,1647298800"; 
   d="scan'208";a="39775583"
X-MGA-submission: =?us-ascii?q?MDEheFmARiQSfeyOh6tcm0TrZHG39OiiqNq6/C?=
 =?us-ascii?q?JgA7l9/O8gX5qJEOGdEGbSYL7MtSG+YgEjjQUCIsMpKjiM5T03uAV/Mf?=
 =?us-ascii?q?b9ZzJCbs7bInWCyz3nrh8oC/qp7hINn1vcqcQdL3QGPZb8m2KjIddq/i?=
 =?us-ascii?q?/PtGR1vecTORq8iO1ZBmcEVg=3D=3D?=
Received: from mail-eopbgr60116.outbound.protection.outlook.com (HELO EUR04-DB3-obe.outbound.protection.outlook.com) ([40.107.6.116])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 11:15:38 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQJhMLfeJE2IWCidKYtH/+KovRgk/NH8R/xKxs2VzRXFlFlwyfxkOQ6oe4Iiev0lZgVGCXfdbffgiCEPK96nGKzm1gvIhyBMSVXwrmibSxc1SjvKONy9Y8kSkBOMQnVVWnFCz75wRS5mcdr8LLybYlYRa8fZMPkk9FHXO87S67L0fMaw910K+KcCejceNEweQnLPzMbOlgMFXNNIbWPtZ3yRoyZKrtf01LBvgcytnbOGxfKFs1/xdEYjde8sqt+z2Hk0vYbpuYRJvwNRCucb2lVf3PV8dlF10kxNlClzGsQn/XEcx/uiH1wSnGWhr5hTQKKLk/8pbdhHKPSjpySzuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dItGQ+h9yQ++1HDINsJSpXm4WKQs9notJnf+PenvKxM=;
 b=hOgw8dLJCvzMcFd71iOWNVnBTlT+SsQNlZLsSZQg0dH6NOwBGZbs/ilR9YBWXYkJoxReiguSzpeMN00At14DKjxx2+rFrPtEm2d3bvetad6EdopMqB2uNIKot1y/DAcBkSCYhSTOkthaF9ipbm4Hxp9c8Yj9pRAez0qhcR8qaATBqYXPeBS6DC/4WBW7lfpkisZvmOPmkBkCPnoQ68jYmH7xGkBN+mSDk3ls5Yt7Xw+ju9/3vh5f7n1747egHrebIujTl0vPWkkudrZFjFlja17rnMsDVBZKVElNJSwHY/Kd//eZaWThpbAmMUCA8OrSZSUyYbN2YnYA6wkheLjinA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netatmo.com; dmarc=pass action=none header.from=netatmo.com;
 dkim=pass header.d=netatmo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netatmo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dItGQ+h9yQ++1HDINsJSpXm4WKQs9notJnf+PenvKxM=;
 b=hk9gU6yNAdWJjnOcMKLoWNohs1PhxjKgYXd332AVDiusrNLwlpVYzlaTtvO8Owd2fpatP/02gsv5vRmmi4wTSFNuOJ5aYpC41UPpX6sLoGO39Qp2ZwxBu6fISYZWLbPEVJGwXWEpJZs9/fxf4Y6O9YxfB21jTqE3qEjLJ3nXehc=
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com (2603:10a6:20b:34e::15)
 by AM0PR03MB3857.eurprd03.prod.outlook.com (2603:10a6:208:6e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 09:15:37 +0000
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::197:874b:24ea:e4d5]) by AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::197:874b:24ea:e4d5%6]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 09:15:37 +0000
From: =?iso-8859-1?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
To: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
	<nicolas.palix@imag.fr>
CC: "cocci@inria.fr" <cocci@inria.fr>, Markus Elfring <Markus.Elfring@web.de>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Thread-Topic: [PATCH v2] coccinelle: ifaddr: Find address test in more complex
 conditions
Thread-Index: AQHYek7fHLsMc4LTfk+02uWH++YB5g==
Date: Tue, 7 Jun 2022 09:15:37 +0000
Message-ID:
 <AS8PR03MB760365A0DE3A8522136471BE93A59@AS8PR03MB7603.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8cca62d-0eee-485e-1646-08da486648e7
x-ms-traffictypediagnostic: AM0PR03MB3857:EE_
x-microsoft-antispam-prvs:
 <AM0PR03MB385769D5BF5DC510D584926C93A59@AM0PR03MB3857.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UE3ffWPWklT6ykNeyXc6wGES7k2p7u3rLDAG0Kjtr4krljo02gMU/MiqZfRnon6GgJyEST74Qh4RDVOKyIjo4+0s8ry1DycZmzHhmBPZkRzhg4gnr5MX2kmfoPhcLR5sprnU0vg63GOzXaBcSEmz+JI5KLo/LAlMN3XALDmoUZnyl/h/YgDn8LGiBVsb5fFCchyt0YiHk3vmIM9z72ROrhmcJ7S1On5nZW8iSZ/sZPZHy5BZQ9bMbnGmCgtRWRX/nV2VyKacQSDPxddyKUCCAa6Nq90TKE3FGxbrRcDETAUpWKZ56IG/2WdOjcj0UNK+cG85ewMJtDmhjvQvuXnRW0unkRX+5CGVeX2byzAob4uCLP9I5T9n4SK5I8ha/+acIVDMCvGbfvvo2asN5qJlYpD3C/2q9vUDBrFgCEGB/2jIWotrI/+l0arzdQf3OgHN5U4eLILu+BYDbeQdJk/YEqP7x/uAkWV+p5qou8R1SQYMeN2/Srzm5k1+X6uQyv39Tq34u1B5XfpAq7lJ7vVid6llHv266+W9WoO1Xwmf0ipMY5xzUhD6ACiEKg2tcOjpuZbS6JActqu+MZ55qdMI5xvFHGLsujtgU5n4xDhxZ5sLB9lY1ihhqbWdWlUojP9PW/JiBHl75RjRaLs/ILQi4YpjSwYTlcOHP2xZOKxoH77ireUn4APmON6DrB9pBx4xLYJiATlBzo/GjA1cDzj0aw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7603.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(66446008)(66476007)(54906003)(8936002)(76116006)(2906002)(110136005)(91956017)(71200400001)(66574015)(316002)(64756008)(5660300002)(38070700005)(26005)(122000001)(9686003)(55016003)(8676002)(66946007)(4326008)(7696005)(52536014)(6506007)(83380400001)(66556008)(55236004)(33656002)(508600001)(4744005)(186003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?oUAAJj7p6P6zEQxqsDM71rdhrRybYk2pIwxfJO9lEHLE7wSM9jFieVEXZP?=
 =?iso-8859-1?Q?PFe/8wday1d14CbFEmDo56/s4WKD3JKwfvxsaYb2moWsDC7EfAVxIJzJJP?=
 =?iso-8859-1?Q?36Gtn3hqqmSFkyEtaAnuWCUdUdk3r2cIU3wbdSwePGxnZ9FtsZEThoqRzQ?=
 =?iso-8859-1?Q?UeHH1rBgJ67HAYshfHY4TzTle4+sH5w2t7pJg0KfC5vWbGr07QfU9fk66s?=
 =?iso-8859-1?Q?O+W5j9lW2H9Y2eK90KnhQ00kdvU7seg6u9Nv+kM0099jgERU5fvddRNstH?=
 =?iso-8859-1?Q?4S0YIKD1Zfe8l5D4dI8HZq4h9cEuVvwZQtUGkf06ER9/BLXxTB2emn6VDI?=
 =?iso-8859-1?Q?LsYQumCbAG9Ft7CVEBiY9s+j7NGX0/RA9ByJyMf28v0IeyKWhonrUURVVq?=
 =?iso-8859-1?Q?erGalM6BmqNVTDx17JN5eYluk52t5g3jx5LoXCeTo7Szw1M2rLwAht+0Kb?=
 =?iso-8859-1?Q?C3pwqJezH8W3QygxSiFooWJfOS9r/qkP3Sd6Mudtnhl1rblH+scwbZzQn5?=
 =?iso-8859-1?Q?ux/jayOm1MZMgQZqcBIdUHq/ARTPu1cDH7nj9K3KPb4XVOD81jzBNmonkv?=
 =?iso-8859-1?Q?RWJS7Bd7W4cPfoW0vlwTxomKON5SVdpcR99/Kd2jwMq0J6OFNw9q60OEfN?=
 =?iso-8859-1?Q?P3nUsgIBydRKltcN2tc7ocUEQYW8r/ZTYdbW89GlmeV4vrIKeCF40rCfdP?=
 =?iso-8859-1?Q?oZZLZpLS3cKuriJ8UAL8af1L/KGmpjNaUo8lJTyA51rAdef5RjUTY0PJzj?=
 =?iso-8859-1?Q?THGk4wXGMrO1I9P8FvohzzYoNmTpNVYa6ocbTtDHjECmfu7952Wwbzj6dK?=
 =?iso-8859-1?Q?0/eNQUEPJfN25oeyY+4jFRyB3jGnqc8spMPkqte1YNUye4eaLcy3m78ojB?=
 =?iso-8859-1?Q?byROSEnPvybq2ZIu8N2sEXddQhY4n7hRlAg3PK9HB3TJybMsAhtjlDjBID?=
 =?iso-8859-1?Q?E2ZdqNMwJj4dwz0IpQIOI7qBT6zCAInQJdWkCL6mo/TAsa9gqXIOlHbYcU?=
 =?iso-8859-1?Q?+Vwvb5PZu73OYLHhUemF8voToyTXi1z+2ouhLfRX7WAZn7HpI6QxNzzUmV?=
 =?iso-8859-1?Q?Kb2XtIRlF1Xxgcu5Rh8T4t9b35zDyNESErJ+I+zwkJ8OdRHgZ7JLa39QvF?=
 =?iso-8859-1?Q?Z8nAAlFcXSSlkpYeUZgERND5JlogCs8R0a5L+7NdrAisruSqifLd2D5T6F?=
 =?iso-8859-1?Q?urBHlX0GpRpupagLvbfZMukNuHMWMvu7jPiTPTp3OHiHgyfVbD/U+stlra?=
 =?iso-8859-1?Q?1Btrh4wcQNM3zQlpyP9UodJSD9d0uVTShhtvajQKX1PBY3Hiw1dqem02D9?=
 =?iso-8859-1?Q?lKuNVtqRMcL4jc9HfjaGs6nTYIiKJxSVrSt95vKx8dEipKkS+AOdlLi0M/?=
 =?iso-8859-1?Q?assvhz+pDUgLLTbIP4AR+UF5CZvSHsJujNbPfX7pMZ7mzZn2iv0p7aGTcY?=
 =?iso-8859-1?Q?ILMgBPalQPKAc5fbtvwNpoi+ildli51bq8vlHx6HKAmwFCbb+tolzjs55i?=
 =?iso-8859-1?Q?J28c1KVhUGdef3sMzur7imTe2Tbfr8xo3PY96f/LwF4omCcA4dNyQ2bGa9?=
 =?iso-8859-1?Q?UJN6gRkfm9HM1+vpjvDPSvS52DCrfLG5gVO0s53OL7k/sN8036fBmxG+oX?=
 =?iso-8859-1?Q?5RRWaSJ6oZq2cG2/1D2Kly82WHr2Nk4mfNizTK84Z3mZNDncERRNXqFb3V?=
 =?iso-8859-1?Q?sl9BvlcKbet4YXmcYzdnA32c3qQBAgNSRvzE+BuNw87sQhznrVamO4Bdny?=
 =?iso-8859-1?Q?xrx49SYCrGomyuB1zOy+mDIOU8yR/XF4lZ5VkgSsvPDKEjGXylb9opVaqE?=
 =?iso-8859-1?Q?AxUGbBZFlnzUl04w8IlbPhhdbDhkgKQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netatmo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7603.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cca62d-0eee-485e-1646-08da486648e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 09:15:37.3002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4528446a-2666-441f-95cd-cc2cbd9f2c49
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JAdsqc0jWLFAiwYS9+Pix7kbmH0Y0eEuniAtctq3spuJWVTdf/fT/yOXMaaLkqvN7WlPY4LBWNwBIV3MRfN4fXyAYmTyPddM1PPELh4rLPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3857
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v2] coccinelle: ifaddr: Find address test in more
 complex conditions
Reply-To: =?iso-8859-1?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
X-Loop: cocci@inria.fr
X-Sequence: 420
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/AS8PR03MB760365A0DE3A8522136471BE93A59%40AS8PR03MB7603.eurprd03.prod.outlook.com>

The test of an expression's address does not necessarily represent the=0A=
whole condition, it may only be a part of it.=0A=
This change aims at detecting an address test in more complex conditions.=
=0A=
=0A=
Signed-off-by: J=E9r=E9my Lefaure <jeremy.lefaure@netatmo.com>=0A=
---=0A=
v1 -> v2: Moved disjunction on the condition itself instead of being on the=
 if statements=0A=
=0A=
 scripts/coccinelle/misc/ifaddr.cocci | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/scripts/coccinelle/misc/ifaddr.cocci b/scripts/coccinelle/misc=
/ifaddr.cocci=0A=
index fc92e8fcbfcb..14dbf3131a3f 100644=0A=
--- a/scripts/coccinelle/misc/ifaddr.cocci=0A=
+++ b/scripts/coccinelle/misc/ifaddr.cocci=0A=
@@ -18,7 +18,7 @@ statement S1,S2;=0A=
 position p;=0A=
 @@=0A=
 =0A=
-*if@p (&x)=0A=
+*if@p ( \(&x || ... \| &x && ... \) )=0A=
  S1 else S2=0A=
 =0A=
 @script:python depends on org@=0A=
-- =0A=
2.25.1=0A=
