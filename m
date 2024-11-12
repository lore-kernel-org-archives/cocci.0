Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39278D42BAD
	for <cocci@archiver.kernel.org>; Tue, 12 Nov 2024 16:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=huafFYUVhMNsyvDi8UlHqiGH33pnbx3afGjMG1QJyqg=;
  b=UB3xn8jRKuNWbgfw4LqybC890ANm8gZZWbPlVFPPgHU4PklTSrn6AjwN
   tXBTk4VLpqxjS0w7z2ZmAAPkS/vcM6VoWcL0EBzmIkbemxV0Ov3GYjB6F
   WrnQqFYmuvO6uYKZ0O8ubnHQRGcfBgPbPVwtYwni0ALpl9CFrdp0RE59N
   4=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.12,148,1728943200"; 
   d="scan'208,217";a="193446271"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2024 17:50:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1D91BE013D; Tue, 12 Nov 2024 17:50:18 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3593CE00B7
	for <cocci@sympa.inria.fr>; Tue, 12 Nov 2024 17:50:16 +0100 (CET)
IronPort-SDR: 67338747_CQHHJfqpQahaU3Qxm/HcdWrvcLMwS3D+uLirWFpgQaBvQhU
 fbmcUEyGKimvpZ73kW/jBMtbijSJf5YTQ1AJXpA==
X-IPAS-Result: =?us-ascii?q?A0FiAgDOhTNng1yOJa1agQmBU4FBMVJ7AoENBwhIiCIDh?=
 =?us-ascii?q?S2gNYZVgSUDGD4PAQMBCwJEBAEBAwSFAAKKOwIfBgEEMgcOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBARABAQUBAQECAQECBAYBAhABAQEBOQcOO4V7AQyCW4EsUQ0DAgIDA?=
 =?us-ascii?q?wM4AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQINXjguA?=
 =?us-ascii?q?QE4EQF/JwQbGoJfAYIcSAMBpSgBgUACAoopeIE0gQGCDAEBBt4DCYFIhQCDT?=
 =?us-ascii?q?AEqgTKEKB2EPycbgUlEgVeCNwEBg04CgWKEE4IvgkWEJ4FoiEiHM5EcgUciA?=
 =?us-ascii?q?yYzIREBVRMXCwcFgXYDgXuBVoE5gVFDgRaBR0qFGoEFOYIRaUs6Ag0CNoIkJ?=
 =?us-ascii?q?FmCT4UahG2EZoIhHUADC209NRQbBQSBNQWdAQGBbIdfohdHoWKBPgqEGgWhc?=
 =?us-ascii?q?BeqTZh3IqhXAgQCBAUCDwEBBoFuCyiBXHAVgyJPAxkPji0NCYNYxUR4OwIHC?=
 =?us-ascii?q?wEBAwmPJIFLAQE?=
IronPort-PHdr: A9a23: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
 swkNUGTUhJ2pFN0Px8ILsHFbwpSapgKnEU=
X-Talos-CUID: =?us-ascii?q?9a23=3AidEhrGivyIqv5JQVfGQJ8KQLDjJuWFri6mjWAHG?=
 =?us-ascii?q?BDkFodqapa2bP0Zg4qp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AA0Hfow0U6dBUkL77GjAzPwpi5TUj4qShD1sfk5I?=
 =?us-ascii?q?/nciqJCJ3CS2D1mq3e9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,148,1728943200"; 
   d="scan'208,217";a="101394178"
X-MGA-submission: =?us-ascii?q?MDE2MIo7vtKVgYoODWVjpBrFttKmTLxEZ37Ihp?=
 =?us-ascii?q?Xz8Y3G7PXddYpRiMd2s7/XnZyroQE6V4ow9uE3sHxAEeYSyZ8qep+lI8?=
 =?us-ascii?q?07GeOJ/Zt/PxBaodw3J9uLVSrc4bPCr/cSw0lFcqEzHkXICDjLgFfK1q?=
 =?us-ascii?q?ZHk4zkdLcXWTbLDkrTB5mINg=3D=3D?=
Received: from alln-iport-5.cisco.com ([173.37.142.92])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 17:50:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=6409; q=dns/txt; s=iport;
  t=1731430215; x=1732639815;
  h=from:to:subject:date:message-id:mime-version;
  bh=huafFYUVhMNsyvDi8UlHqiGH33pnbx3afGjMG1QJyqg=;
  b=Vg6cPT5xaYtSen26NBwCjyX9gEyz/atHf5w6MLaaJn0FqR/l0Nd98fj8
   VvXMlO5l6fiAK06ZNiK6raJ0raVxq+Gp/4/KyseGOuqHLMki9//O087kg
   ArYX9hopNceQ8YT4KAHCIbeLdynPhfQcqNqVjFAt/J5TRRfN2MHlDr0uC
   I=;
X-CSE-ConnectionGUID: VR93zE/8RJCnE2OmSGs0Kw==
X-CSE-MsgGUID: II4rfNAMREWGIT4jK6LM6A==
X-IPAS-Result: =?us-ascii?q?A0CyAQBFhjNnj5AQJK1aHgE8DA4LCSWBLoFBMVJ7AoEci?=
 =?us-ascii?q?GkDhS2gNYhTDwEBAQ0CRAQBAYUHAoo7AiY3Bg4BAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?QEBAQELAQEFAQEBAgEHBRQBAQEBAQE5BQ47hXwMhnN5AX8nBBsagl8BghxIA?=
 =?us-ascii?q?wGlJgGBQAKKK3iBNIEB4CCBSIUAg0wBKoEyhCgdhD8nG4FJRIFXgjcBAYUyh?=
 =?us-ascii?q?BOCLwSCQYQngWiISIczkR6BRyIDJjMhEQFVExcLBwWBdgOBe4FWgTmBUUOBF?=
 =?us-ascii?q?oFHSoUagQU5ghFpSzoCDQI2giQkWYJPhRqEbYRmgiIdQAMLbT01FBsFBIE1B?=
 =?us-ascii?q?Z0BAYlLohdHoWKBPgqEGgWhcBeqTZh3IqhXAgQCBAUCDwEBBoF9JIFbcBWDI?=
 =?us-ascii?q?1EZD44tDQnJHYEzAgcLAQEDCZBtAQE?=
IronPort-PHdr: A9a23:TLSZGR9uVgZFx/9uWBDoyV9kXcBvk6//MghQ7YIolPcTNK+i5J/le
 kfY4KYlgFzIWNDD4ulfw6rNsq/mUHAd+5vJrn0YcZJNWhNEwcUblgAtGoiEXGXwLeXhaGoxG
 8EqaQ==
IronPort-Data: A9a23:Z2RDeKKC7UM2gAoyFE+RqZUlxSXFcZb7ZxGr2PjKsXjdYENShDIAm
 zFNDGjUOvyOY2DxKdxwboTjox8DuJPTyoNgGwod+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCea/kr1WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVrX0
 T/Oi5eHYgP8gmcuajl8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1QNhBtL6BfqtxVKmdjr
 9sdEx8WNjOc0rfeLLKTEoGAh+wqKM3teYdasXZ6wHSBUrAtQIvIROPB4towMDUY358VW62AI
 ZNHL2MzMHwsYDUXUrsTIIk/l+ehmmXyWzZZs1mS46Ew5gA/ySQqj+myboKNJITiqcN9v2fEv
 Gzg1kHDLy41FeDDyxnb1lfyr7qa9c/8cNlPTOLjrKECbEeo7mcUAxYXfVq9u/iwzECkM++zM
 GQd/i4o6Kx3/0uxQ5ylAFuzoWWPuVgXXN84//AGBB+l9JCFuBS0QTg+bBVHRYYBsfQZXmQJy
 Qrc9z/2PgBHvLqQQHOb076bqzKuJCQYRVPugwdaEGPpBPG9/OkOYgLzczp1LEKiYjTI9dDML
 9Ki8HhWa1Y71JJjO0CHEbbv2GnESn/hFVJd2+kvdjj5hj6Vnab8D2BS1XDV7OxbMKGSRUSbs
 X4PlqC2tb9VVMrRxXzcGbhRQdlFAspp1hWC2DaD+LF8p1yQF4KLJN44DMxWfR0wa51VI1cFn
 meI5FMKv/e/w0dGnYcsPtruUJ51pUQRPd/kTfvTJsFfeYR8cRTP/SdlIyatM5PFziARfVUEE
 c7DK66EVC9CYYw+lWbeb7lGi9cDmHthrV4/sLinlHxLJ5LCPybNEd/o8TKmMogE0U9ziFyIr
 YwFaJLRkko3vS+XSnC/zLP/5GsidBATLZv3sMdQMOWEJ2Jb9KsJUZc9HZtJl1RZoplo
IronPort-HdrOrdr: A9a23:ZjsqBqr5t+UQdx17MI5G6pgaV5ubLdV00zEX/kB9WHVpm5Oj5q
 OTdaUgtSMc1gxxZJh5o6H/BEDhex/hHZ4c2/h2AV7QZniWhILIFvAp0WKM+UybJ8STzJ846U
 4kSdkANDSSNyk2sS+Z2njELz9I+rDum87Y55a6854ud3AXV0gK1XYBNu/vKDwMeOAwP+tAKH
 Pz3LshmxOQPV4sQoCQAH4DU+Lfp9vNuq7HTHc9bSIP2U2ltx/tzKT1PSS5834lPg+nx41MzU
 H11yjCoomzufCyzRHRk0XJ6Y5NocDszttYCNbJotQJKx334zzYIrhJavmnhnQYseuv4FElnJ
 3nuBE7Jf1p53fQZG2u5TPwxgjF3Dwu43jj01vwuwq7neXJABYBT+ZRj4NQdRXUr2A6ustn6b
 lG22KCu4ASJQ/cnR76+8PDW3hR5xKJiEtntdRWo21UUIMYZrMUh5cY5lltC5sFHDj38sQNOs
 MGNrCB2N9mNXehK1zJtGhmx9KhGl4pGA2de1MPvsyO3yITplpdpnFonvA3rzMlztYQWpNE7+
 PLPuBDj7dVVPYMYaZ8HusaBfatAmvWWBTWLV+IKVvpFKs7K2vAwqSHu4kd1aWPQtgl3ZEykJ
 POXBdzrmgpYXv0BcmPxpFQthjLXWWmRDzojttV759yvLrgSKv3WBfzGWwGoo+FmbEyE8fbU/
 G8NNZ9GPn4N1L0FYJIxQHlH5pVNWIYWMgYt5InXRaUrsjKM43nsfHAGcyjdIbFIHIBYCfSE3
 EDVD/8KIFr9UawQEbijBzQQX/2Pkjy54h5HqTB+fQJwoRlDPwQjiElzXCCou2bIzxLtaI7OG
 FkJqn8q7i2oWmt8XyN6X5oNBpbBkNe5bXtVG5LvAcGPlj5a6xrgaTBRUlimF+8YjNvRcLfFw
 BS435t/7isFoedwSA5B8jiK3mdhXcIvn6GC5wN3q6E+dzjcpY5CZhOYt0jKSz7UzhO3Sp6om
 ZKbwEJAmXFECn1sL6oiJwPCPuaasJ1hx2zJ9VItGnWukqdr9w+X3dzZU/xbeenxSIVAxZEjF
 x49KESxJCanyy0FGc5iOMkdHVRdWW+Gtt9fUu4TbQRvoquVBB7TG+MizDfoQo0YHDW+0IbgX
 GkBTGIeMvMHkFWthljo+jXGRJPBySglnBLGzNHWL5GZCb7U7FIoKq2j5+Ioiusg505s6Ug2X
 /+EHwvy0hVtqCKPVau6UW//N8dt8cT16rmffgem72/4ALeFKSY0a4BBPNa55BjKZTntfIKS/
 uWf0uPICr/EP5B4X3fmp8JAlg8lJAfq4Kh5PTI1hnP4JdkO4unHH12A7UAZ8qR52L4R/COyv
 xC/KcIVMOLQxLMVuI=
X-Talos-CUID: 9a23:xDMvTm1jJN/l2jdjBaoKJbxfJPp0KW/wiyfqAWS+JDxOTYa6Ugez5/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3AEPdyrQ3XyxIXKOR9tHjzHDEV7DUjwoXyEk4ruLA?=
 =?us-ascii?q?8lvarFBAsORTDqBHpa9py?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-07.cisco.com ([173.36.16.144])
  by alln-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Nov 2024 16:50:11 +0000
Received: from rcdn-opgw-5.cisco.com (rcdn-opgw-5.cisco.com [72.163.7.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-07.cisco.com (Postfix) with ESMTPS id 1EBDF180001EA
	for <cocci@inria.fr>; Tue, 12 Nov 2024 16:50:06 +0000 (GMT)
X-CSE-ConnectionGUID: OBaikzwYRjOTIPQMmk4aXA==
X-CSE-MsgGUID: ORSVloKQQWezKmKME/i09A==
X-IronPort-AV: E=Sophos;i="6.12,148,1728950400"; 
   d="scan'208,217";a="19311911"
Received: from mail-dm6nam04lp2043.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.43])
  by rcdn-opgw-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Nov 2024 16:50:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/SZkHeB/pU6tkt9pMNLYkn5l8RTKGBFhqwcROwrnmvAkjxUUYk9GLQ3A1Smu5oQS9zj6OSF6K3DJ+1CDzcjrp5Qyll/FJHSz+isKwWAdxgsMTK7HWJWKvFMlUnPhkVR7J56ypQGUdidgwdDIakQ8/Ymi36lreAIt6Tp4nV8WWI96mszwqk1zRR+sgO1bVmZMdSX1stufDG/BnB8uRpRnAPrd7exSaUkqJMXi6VaJ0DSRbgQRCdwwX6+620tTDUmRS5/hUTQeDuRh4n7vdQqPUesV+aF1/34iRRRjfnT/vnZIGB03a4WBN5U+Gy/IAsfFZBsA0L3VveKtNWzPeJmbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huafFYUVhMNsyvDi8UlHqiGH33pnbx3afGjMG1QJyqg=;
 b=GLBVXNI8my489g9IObw2NsPaNMYu2qEPCaGMHyicGzM/tVpiJXYFm89oox2H2C1kZb29GRCC9aZB/qLUzoWESQHCqkd/5r5OwwQN6fJkJWWDZ13r3TCsp9l9eRLULMY95Q+IwpBD2KKRUrp3Yood/sBOX4sgUMP10a0pPosI/1BniIHDkM1GSyfqnYqkvJUTWx21DuaKMHK92Ty67T6FqjUb0agoXwUDwEgFxO7nylRaKwDLcu8A/oq7d1BJaTdigmgIjhexdfcm+6BnAgdpqpDdBPe4s6TzHJ3FYi2e6zo7Oxw5RfIzfyi/bYTAz15o5EZRab7w8tQpTyXgyWJEcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SA1PR11MB5828.namprd11.prod.outlook.com (2603:10b6:806:237::12)
 by MW4PR11MB6957.namprd11.prod.outlook.com (2603:10b6:303:22a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 16:50:00 +0000
Received: from SA1PR11MB5828.namprd11.prod.outlook.com
 ([fe80::677d:da83:5ac2:33a2]) by SA1PR11MB5828.namprd11.prod.outlook.com
 ([fe80::677d:da83:5ac2:33a2%3]) with mapi id 15.20.8137.022; Tue, 12 Nov 2024
 16:50:00 +0000
From: "Simon Chatterjee (sichatte)" <sichatte@cisco.com>
To: "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: Same identifier for type and variable
Thread-Index: AQHbNSIYGMWGRghLgkaMiK7u38wf2Q==
Date: Tue, 12 Nov 2024 16:50:00 +0000
Message-ID:
 <SA1PR11MB5828EE32EFC2E3117E464912D5592@SA1PR11MB5828.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB5828:EE_|MW4PR11MB6957:EE_
x-ms-office365-filtering-correlation-id: bf79eaa9-5d8e-4224-b47b-08dd033a0c5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|8096899003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?meLPQmKD6aBo2pqm6bkyGXk9ZQMZ1f6urQ4oxVU4oFY5V8hlKy1kQz4FsQwo?=
 =?us-ascii?Q?K+3qXUxtYNKspm1Hhbn0DXtGsjQ5CFHH63am9/Id0qKWWXwEJLeuvxQSS2Po?=
 =?us-ascii?Q?GKhVWE7Qgow1VcBiOVeQKPjVxuXrA+1mC66ch2ANNW8PUBTFpz+r3/MYD2Gu?=
 =?us-ascii?Q?e0G8UIGIOoYtfKIl7njp/oOtyX/PuOIP0H0GfF9ubVQPSF78CyqeAQt0qNjU?=
 =?us-ascii?Q?3BFBpCbBBWVGw+U5zA4L9Py83VaGAj4lw/v6q9wQVCuHl6bqXH6oo0E/BdDy?=
 =?us-ascii?Q?7v3NXkLm7bTe8Gl6xSUc9zwNG5FLWf4NfrdHRUXm5L68kdBs8lW8kLWEz73e?=
 =?us-ascii?Q?HJ9pRmpubYqUzWAQTuosoqQrNXY4Zsb3R0fBuGaaSjZqfImSe41bZ2B9/GM9?=
 =?us-ascii?Q?sAhJMFZznO2MkmQ0kZevUF4nWnStL5EHHWXyTUlqTtORhpj01tb714n8EjlX?=
 =?us-ascii?Q?IYwLOBqzorz776nbpO+Y7ZviwUCSfS6eZXPrZaFJYFbMkJxM0GjoHIdHMIxx?=
 =?us-ascii?Q?aD4XC2uKx6DjPedZGF8SL2vDoe0kMOIreBdKz14YYSFe00eLgV1oIr5UOHWU?=
 =?us-ascii?Q?D+CvyOAp0R0SBkunr3+h3Nv/bdt2OWS0vOCX0fDKF+MKcOt9L5KEatfsPlQg?=
 =?us-ascii?Q?ptOw1a4HwjflqPCAnw7vHUKpWzPjqaEiqa83MyE74DLnugqV7loVIELezgsQ?=
 =?us-ascii?Q?7zZ63PFmhJyUaIgwVR8iTDQ35k//2K1cQtgPzSGlpURkbL9zIkqvc1TQ/UIc?=
 =?us-ascii?Q?XsVFW53nZv/Ah81n4/bGW8hHTLnFbf+ury9dFt5QSMrB4M5xPjBue9Yayin+?=
 =?us-ascii?Q?9qX7xEpwPJzNhj/Pefya4Me8flf6FiI9TxrMf/yAtgoZngegQ0Kx4ICO9wnm?=
 =?us-ascii?Q?SVy8ADBkewlDS914Zi5UgMt+1baqVyW4ar+rgWhUgRtcCjYFPBdwL3/9fWjd?=
 =?us-ascii?Q?GZxiYb4zUo8uMTCkRCORYHYSoeqGUNOejcUfxDkm54IhTr42mC9C7oHTHuJo?=
 =?us-ascii?Q?v9es8MT3htEVQosRAFtOWJ0n6/epfJggZTBuWyow8eML0mD7ovsNGWPRgpIE?=
 =?us-ascii?Q?7TG8GYejfM0Q92HXdgB65JEKBCK9vRaGXhpY/UM8oI2FCxeTWzyDqkGTC07U?=
 =?us-ascii?Q?tfhz6MX15Rue3R/3WiYNUfRTmp++Fhv9WYdjifpSxdcxdoe1MOiNGv1PX/aI?=
 =?us-ascii?Q?9kmzh9cknFf/gIPoytJQpdOTsZZ/qLj2nOFXylLwYPySiL3sH6OBqnps+yaH?=
 =?us-ascii?Q?et9dB6Vv3KabAgS7bqy2C+pb8hPZSyCjloiD44Zk2PUMmkvQjSr+Z8wazoaO?=
 =?us-ascii?Q?nbV92jlIQoMMR67rTdZ8timKqWxXa0C8fywK/gM+rSFS1Zrml8mgfCObgboH?=
 =?us-ascii?Q?iqZDoBs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5828.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KCJsGEZ47JQSqDb4my34O7hmSQodXl2djaEcA3QxBGrRgqiFPWE4qmJ3VLu1?=
 =?us-ascii?Q?TwJoshdB8GE1ftH3tfV9C3abKC/xn6XS85eVfQMM0Z/rH3K5eVXUt0/z3RBz?=
 =?us-ascii?Q?WLCiLJu1pOxZwK/sq//HKn4HDzTwS8BNF2XRrXS3C12c1AS2YtOErOjEbJxe?=
 =?us-ascii?Q?32ZqcaEUEEkiVZHwjv+oTBiU0/vdxmssRPbEMQmSZz49596TDfNMKuo2GEPs?=
 =?us-ascii?Q?NuShgsQQEnrKg9L7gPKXyqFwv9JZf52r9EVikz3rwZLeJsnKPFIl5SGoSDgJ?=
 =?us-ascii?Q?TKJz48Dh75fZAZFesDhyxxv6oox6S9cC2nGxh0Pp/Tn6nd4AkjMNRnj3Mx6E?=
 =?us-ascii?Q?ENVVmCv8Aa6ixtqtMLokJISh01QAAae1W1c4el8rau8uRRsE2cZ6RElQ/XA5?=
 =?us-ascii?Q?3Fint2fitmuLQ1W7KEYFA40MPbijEl/+/0rjmKEgDa2PQFzxLwV5GjksX9KE?=
 =?us-ascii?Q?U+8+O46YnUYxo2zFF30u0RChUxmleKsGxRQWzquiWxphsKa9tcLaqRrci++N?=
 =?us-ascii?Q?tfAWSOHX7JUaaQJakMDgOj9fO8Sr+ofefBhbn6qoab1vkrxNvTZYt4byrIZb?=
 =?us-ascii?Q?MkmIdytLI+lS+q4yfQFdOoRleJ1OegYIOJ4al/KyBLSrD54Gxv0+6vUo2oU6?=
 =?us-ascii?Q?HKpFtgFu0XcTth4aAZIr/FkRre9UVa8EheSWElMRfq5leJ3biVQe8zbGf+p/?=
 =?us-ascii?Q?P20JAL9qSTZckGKX4bjTMnImeMVC6HDVJaz5jheWdl3vaTkIWZ/+oey1dBWT?=
 =?us-ascii?Q?jBSq+seSEeDiw4+LPMIp+oNmNsSd4jTGTCvITMbsWjQKeJ7rd1z8RE3utjmb?=
 =?us-ascii?Q?wY/2qowLcPXrl/Q0u9p4h2DgMp5+tmJwIPqkGOdLZT0kSWdT/k9KdDnyNrLv?=
 =?us-ascii?Q?Q2q2DvyMQwSnpO7DC/CYWq6gldUCF7jzw1F3/V8aikI/u64JzDkN8E8q+51A?=
 =?us-ascii?Q?2sQ6D0HlKMY498/BlyOCzR7/sThn2m2i1AnLVQ9KgZ/qD67C5L6y7CB/J1Ig?=
 =?us-ascii?Q?JFr/R1171yV7Q+KO7fuCGavuOaWuuJeNDO2tXW8igtmMYaG4fysbLCsY/z9J?=
 =?us-ascii?Q?bWgLV2+t1WdclBcKonUFOf13tiksCuKxIoCof5/rpmI5asPA5ZCI7bekEgSX?=
 =?us-ascii?Q?9QidqtmisAsltkrag73PNHtozGiD4a+TKZT3RScDpjifkVUMgLu4INa1I1fG?=
 =?us-ascii?Q?ei5oHutO+Rs9tWfih9SHd7DVlMbkYKouiIvGoLN/lvFJ7PNhwvB6TQL6SjKT?=
 =?us-ascii?Q?9kRP67UmX+FlUABm4N9d8Z9BHOg0X/+bNPAYavRZ5GGKJ2XIVliVJOJJk5yY?=
 =?us-ascii?Q?JRKAsQP1XXudn0MgoYzKE6ptLD+75OC8wAR8mc02EMQxtDuHSeL6t0zEYtk+?=
 =?us-ascii?Q?EIb/z/iSs1uAYy1jhVT4NmaBmF6DQFvY/lEf0XyNFlr6Gf52d81NLZdJu8wL?=
 =?us-ascii?Q?9PXqqGyyACFuo5lJFxmNSic7quDooKz2OvO/vbgd8c+lJ8T8xlSmIn9erN2f?=
 =?us-ascii?Q?7r6CSJ+7Ldq4OScPgi1M/blyydSzpAjUr/lc8/E4ELo79kyKNksAOQZALiQW?=
 =?us-ascii?Q?pMgH4uoaTT43GUqPdjuy4a+sw9zX/lXg3gL5Muh/uwpAfOMldKMgDvGGcWow?=
 =?us-ascii?Q?4Q=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_SA1PR11MB5828EE32EFC2E3117E464912D5592SA1PR11MB5828namp_"
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5828.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf79eaa9-5d8e-4224-b47b-08dd033a0c5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 16:50:00.6827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VxWZeHBirn/uWRw6sTzCcoVqES0s15aa/bqMSZyY98v7C4CFiOjlrsArIE1KZ1iWsVhZkYj3dTJxe+r2Myz+mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6957
X-Outbound-SMTP-Client: 72.163.7.169, rcdn-opgw-5.cisco.com
X-Outbound-Node: alln-l-core-07.cisco.com
Subject: [cocci] Same identifier for type and variable
Reply-To: "Simon Chatterjee (sichatte)" <sichatte@cisco.com>
X-Loop: cocci@inria.fr
X-Sequence: 1998
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/SA1PR11MB5828EE32EFC2E3117E464912D5592%40SA1PR11MB5828.namprd11.prod.outlook.com>

--_000_SA1PR11MB5828EE32EFC2E3117E464912D5592SA1PR11MB5828namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks for all your work with Coccinelle.

It seems that using the same identifier for an inferred typedef and variabl=
e name confuses the parsing heuristics. For example, spatch --parse-c fails=
 with both this:

    typedef int type1;
    typedef int type2;

    void bar (type2 *type1)
    {
        if (type1 !=3D 0) {
        }
    }

and this:

    void foo()
    {
        type1 x;
    }

    void bar (type2 *type1)
    {
        if (type1 !=3D 0) {
        }
    }

Are there any workarounds for this?

Thanks,

Simon


--_000_SA1PR11MB5828EE32EFC2E3117E464912D5592SA1PR11MB5828namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks for all your=
 work with Coccinelle.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">It seems that using=
 the same identifier for an inferred typedef and variable name confuses the=
 parsing heuristics. For example,
</span><span style=3D"font-size:11.0pt;font-family:&quot;Courier New&quot;"=
>spatch --parse-c</span><span style=3D"font-size:11.0pt"> fails with both t=
his:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp;&nbsp;&nbsp; typedef int type1;<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp;&nbsp;&nbsp; typedef int type2;<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Co=
urier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp;&nbsp;&nbsp; void bar (type2 *type1)<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp;&nbsp;&nbsp; {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; if (type1 !=3D 0) {<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp;&nbsp;&nbsp; }</span><span style=3D"font-size:11.0pt=
"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">and this:<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp;&nbsp;&nbsp; void foo()<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp;&nbsp;&nbsp; {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; type1 x;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Co=
urier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp;&nbsp;&nbsp; void bar (type2 *type1)<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp;&nbsp;&nbsp; {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; if (type1 !=3D 0) {<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;}<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Are there any worka=
rounds for this?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Simon<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
</div>
</body>
</html>

--_000_SA1PR11MB5828EE32EFC2E3117E464912D5592SA1PR11MB5828namp_--
