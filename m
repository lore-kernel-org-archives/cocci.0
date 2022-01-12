Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C9CC433F5
	for <cocci@archiver.kernel.org>; Wed, 12 Jan 2022 12:21:29 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,282,1635199200"; 
   d="scan'208,217";a="15340219"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jan 2022 13:21:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 69B37E01B8; Wed, 12 Jan 2022 13:21:27 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DBAE6E008D
	for <cocci@sympa.inria.fr>; Wed, 12 Jan 2022 13:02:01 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=gstooss@outlook.de; spf=Pass smtp.mailfrom=gstooss@outlook.de; spf=Pass smtp.helo=postmaster@EUR01-VE1-obe.outbound.protection.outlook.com
IronPort-PHdr: =?us-ascii?q?A9a23=3AsEvMphyNuVNEHTrXCzK8zVBlVkEcU1XcAAcZ59I?=
 =?us-ascii?q?dhq5Udez7ptK+ZhWZvKgwxweXFazgqNt8w9LMtK7hXWFSqb2gi1slNKJ2ahkel?=
 =?us-ascii?q?M8NlBYhCsPWQWfyLfrtcjBoVJ8aDAwt8H60K1VaF9jjbFPOvHKy8SQSGhLiPgZ?=
 =?us-ascii?q?pO+j5AIHfg9qq2+yo5pHeYwVFiDWhbb5zMR67sRjfus4KjIV4N60/0AHJonxGe?=
 =?us-ascii?q?+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L281/szrugL?=
 =?us-ascii?q?dQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QLYpUjqg8qhrUgflh?=
 =?us-ascii?q?icZOTAk7GHZhM9+g75Urx+6vRNz35LYbZuJOPZiY6/Qe84RS2pbXsZWUixMGoK?=
 =?us-ascii?q?yb4oVAOoHIelXtZP9p18JrRSmGAesGOTvyjhIgXTr2qA63P8hER3B3AwnBNIOq?=
 =?us-ascii?q?2/ZrNLoNKcOVeC1y67IzTbZY/xLxzjw8Y7FeQ0urv+QR7x/a9bRyVUxGAPfiFW?=
 =?us-ascii?q?dsZHpMi2I2+gTsGWW4OVtWP6xh2I7qw99vyaiy8QshIXViI8bxF7J+CdnzYg7K?=
 =?us-ascii?q?tC0VFN2bMK5HZVfqS2XNZZ6T8MkTmp1tig6zbgGtoS6fCgM0Jko2h/fa/+ac4S?=
 =?us-ascii?q?S/x3jV/6dITZ+hHJ/ebKwnQy+8Ua6yuD6S8K6005KozJKn9XQrHwA0wLf5tKGR?=
 =?us-ascii?q?/Z85EutxCqD2gPL5u1aIE04iaTWJps8zrIsjJUesEHOEyzqlEj4iaKaa1ko9fa?=
 =?us-ascii?q?t5unifLnqu5mRPJJuhA7kKKQhgMm/DPw4MgcQW2ib/vyx2rLt8kPlXLlGk+Q6n?=
 =?us-ascii?q?abWvpzHPMgbobW2DBFP3oYk9ha/Eyyp0NMFnXkBMV1JYgqHj5LuO1HSPv/3Eeu?=
 =?us-ascii?q?/g1WrkDdt3fzGOaDhAonJLnjEl7fhfqxx5FJbyAo21dxf5pRUBa8dIP/rVUL9q?=
 =?us-ascii?q?MbUAxsnPwCuwuvqCc9x2p4CVW+MGqOZNbndsV6M5uIhOemMY4oVtS7yK/g++/7?=
 =?us-ascii?q?uing5mUQGfaSy2psXdWy4HvBhI0WeYnrgmMoOHnkSsgokUOPqkEGCUSJUZ3uqQ?=
 =?us-ascii?q?6084S00B56nDYrYXYCsgLmB3D+hEZFMZ2BGDEqMEXbyeImeVfcMcnHaHsg02Dc?=
 =?us-ascii?q?DXrOgY44nzxCn8gHggfIzJe3f8SwwtJT51dEz6feFxj8o8jkhIMWU1WqEVWVzq?=
 =?us-ascii?q?VgUQDiBlPRwulB6zUyY+a9ln/hfEt8V6/4fAVRyDoLV0+EvU4O6YQnGZNrcED5?=
 =?us-ascii?q?Orf2hHC01SdUyhdMDMR8V8zCKiQ3f2y2tAPkZmu7TbHTV2o/h5SCoYvhQkjPB3?=
 =?us-ascii?q?qRniEQ6SMxSM2HgnrR46wXYG4/OlQOeirqucqMfmiXK8TXapVc=3D?=
IronPort-Data: =?us-ascii?q?A9a23=3ABjGwTq+mILuVMVtiraBLDrUDtX+TJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUoq3mMExmYZDzuCPf+CajOmfNgnaYvioUlT7JfWyt4yHHM5pCpnJ55og?=
 =?us-ascii?q?ZqcVI7Bdi8cHAvLc5adFBo/hykmh2ipwPkcFhcwnT/wdOixxZVA/fvQHOCkUbe?=
 =?us-ascii?q?eYnoZqTJMEU/Ntzozw4bVvaYz2bBVMyvV0T/Di5W31G2Ng1aYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57WT3dSG/vsEFHLjXBbHa+/nhJFuyo+lL4hM+YRYltWjDPPmM1tzNJKttq7T?=
 =?us-ascii?q?gJB0q/kxLxbAkMeTX84ZPUWkFPECSDXXci7wFbadHz32N1pEV0yOoobvOp6aY1?=
 =?us-ascii?q?L3aZGdWtXMUjra+Wem+vgEbYEat4YBMLsN4gekmpxyCnQS/cgW5HKBavQjeK0d?=
 =?us-ascii?q?h8k3pUVW6vKPp9BL2J7NkGYJUcSZAkDU8dm2rq82SzWbRtzrXS5pY4W6k7v1ip?=
 =?us-ascii?q?P0Z35aYKAIpjTUa25hW6dr2PCumP9BElGbITOk2LbrCv01qnIgD/xX58UGPug7?=
 =?us-ascii?q?Pl2jVaPx2sVThoLSV+8pvr/gUm7M++z4nc8okIGxZXePmTyJjU8Y/G5nJJAljM?=
 =?us-ascii?q?hYYIJVtMXsUSKwKeS5BuFDG8ZSDIHcMYhqMI9WT0t0BmOgs/tAjts9raSTBpxM?=
 =?us-ascii?q?5+K+CiqN3F9wXAqPEc5ockturEPY73fSjrIU8pnF6m2yNH4cd016y7ftzAw3t3?=
 =?us-ascii?q?/kuZSv5hWPjn7b/aEoYXVSgky5UPbUwpJKysRiJGNP+SV1LQQ0RqMwEt1gLVMU?=
 =?us-ascii?q?LjoVvVyNNwzMKw=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A5hwfP63xiSC3ncXoYk4zFAqjBK0kLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SKalfq+V88jzuSWetN9VYhEdcK67Scq9qALnmKKdiLN5VYtKHjOJhI?=
 =?us-ascii?q?LCFu1fBOXZogEIYxeOlNJg6Q=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CZAgBtwt5hh2xCXChaHgEBCxIMQIJ6M?=
 =?us-ascii?q?YFTWCcSMYgOA4U5lDaGDIwZCwEDAQsCNwoEAQGEQUUCg0kfBgEENBMBAgQVAQE?=
 =?us-ascii?q?FAQEBAgEDAwQBEwEBAQ4LDgg0IoVoAQyCNSKEBHkBDHQnBBsaglkBAgGCDlYBM?=
 =?us-ascii?q?gIMoGkBgToCixeBM4EBhlcBgn8jgTqHKoJ+hE2CDYFYh2yDTYIMIgSRdSoBUJQ?=
 =?us-ascii?q?rjQKBb55XXoE4gTcFCQGKapRyFYU6k3qON5Y9IIxllDOEeAIEAgQFAg4BAQY1g?=
 =?us-ascii?q?RkqT4EuMyIcFIMkCUgZD445hCVxiSBCMgIBNQIGAQoBAQMJj0IBAQ?=
X-IPAS-Result: =?us-ascii?q?A0CZAgBtwt5hh2xCXChaHgEBCxIMQIJ6MYFTWCcSMYgOA4U?=
 =?us-ascii?q?5lDaGDIwZCwEDAQsCNwoEAQGEQUUCg0kfBgEENBMBAgQVAQEFAQEBAgEDAwQBE?=
 =?us-ascii?q?wEBAQ4LDgg0IoVoAQyCNSKEBHkBDHQnBBsaglkBAgGCDlYBMgIMoGkBgToCixe?=
 =?us-ascii?q?BM4EBhlcBgn8jgTqHKoJ+hE2CDYFYh2yDTYIMIgSRdSoBUJQrjQKBb55XXoE4g?=
 =?us-ascii?q?TcFCQGKapRyFYU6k3qON5Y9IIxllDOEeAIEAgQFAg4BAQY1gRkqT4EuMyIcFIM?=
 =?us-ascii?q?kCUgZD445hCVxiSBCMgIBNQIGAQoBAQMJj0IBAQ?=
X-IronPort-AV: E=Sophos;i="5.88,282,1635199200"; 
   d="scan'208,217";a="2653270"
X-MGA-submission: =?us-ascii?q?MDE/xnl+fqPJ88oG648pw0DikQJ8nCKCK161UE?=
 =?us-ascii?q?iKRpbD2FunwbkixN86DVnmF3NNYAeTPJhiW6Eo13ZIyB8QbA6J/zAYTZ?=
 =?us-ascii?q?xYx6Af1MHoMDGDDYxJJTyDvM8+AsZBidAX1Gt3rxHY71JjjTyfxZfPXL?=
 =?us-ascii?q?LgivOTzWEwc/6C7JFdcfKYiw=3D=3D?=
Received: from mail-oln040092066108.outbound.protection.outlook.com (HELO EUR01-VE1-obe.outbound.protection.outlook.com) ([40.92.66.108])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 12 Jan 2022 13:02:01 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRQRvuWm0NJ1UIXxdGLkqDp5ysD7MCSMQo1tchV4BSpnzkKuIleC+Ct9k1m50oqVYO0tGtqX5Ykm1ZnQHQfbFfaWGw6ySl/dOQN/gH1jE9h7BPEpP/IUXYGSjKVYdeVfOwvMwhmPpWG4TJd5Af2HYF/2cfjD7oLPb/QEyT6Cg6+5IruorggpAslyAObEcwsh337q558LsnschDC91s5pkDhAJeiiQ0Z1RIwVEjSMhbeI6tg5eEHdVOl4TSzpy7w2dbGlZbFzWKGzgS28fD3YOUdSlVy4H18lHSZH04Iv1ZxIhd/OnHHfyXqUdt+3q8RwzrnMpiD8AILos6W/5g5m+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGe3IJ9o8G+ZgtCAwOz6iyeRddxIbOPCKcKG3fj2x9I=;
 b=oFp082szslhHUNlPHv2E0PxjufqeIwEu/GSTr1OYlcNezu+bzwu+zaQyl72o3jTMzY3IirBUjg+micaN9xEHeI6pPx3bUDedLgLZHaIZEIcl2RrwPduvp+05Aq9rIijUSPDxoI+ojmQJno36Z+sdSxnlxOIU0SUdwuUH9uVt3KoaykkGx2wwN5iGoVVo/o9eJchsw3IfPAgN2gb/+LwcIv+QEZWsSzUFTJ9Ufk00F0RrEYkmcStdo0o32yp2fXvEOlti6GbrWT/A9Y3nn2X0uVVGf87EYcCkEvL/mEM2xz1EzYE5QtYPWa+lv1fqiu9xpAarSTk3LQxTvv5QzWKT5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VE1PR02MB5391.eurprd02.prod.outlook.com (2603:10a6:803:10e::21)
 by VI1PR0202MB2861.eurprd02.prod.outlook.com (2603:10a6:800:dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 12 Jan
 2022 12:01:59 +0000
Received: from VE1PR02MB5391.eurprd02.prod.outlook.com
 ([fe80::a0d4:a751:f55e:a0d6]) by VE1PR02MB5391.eurprd02.prod.outlook.com
 ([fe80::a0d4:a751:f55e:a0d6%4]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 12:01:59 +0000
From: =?iso-8859-1?Q?Giancarlo_Stoo=DF?= <gstooss@outlook.de>
To: "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: Corrupted or missing coccinelle-tests files
Thread-Index: AQHYB6t81AOuPd5xw0mghn5a02Lycw==
Date: Wed, 12 Jan 2022 12:01:59 +0000
Message-ID:
 <VE1PR02MB5391616777980571A67A784EDC529@VE1PR02MB5391.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [FrY1iV+UF4jq57oLFAHD0qZRiTTF+aD1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0a35dee-954c-4ddd-746a-08d9d5c35693
x-ms-traffictypediagnostic: VI1PR0202MB2861:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hew/jGTvILdDiVPcYIU3kkmSpedUhFCtUgw/M6SfMIpWbRZIn58qSwlDLFawg2kZRxHsv9LqLMZ0Fm3MgpEjt0Al9l6JMJucffERUT84sKVwo4GgBetH5v84lcfKfFoTQFG1T0SD+6aYp5xdNPRcLZE4gd1b3t3DtGpkO1YHN/tKBf931/OCWS4tU6C/Dx/YG5BxTwyUWd569e9lMsZdoIeIMPe1KOCXOTSt7uaeetrquE8tvdIW34FYXPGXBLBjKw4kohpSv89gYWONqE79R9LXqADufRW+OnRCojEYq83cPCzJte//mbbxD5pegrT1FY1suMHxfQUTWHrrdTH68ZAUPd+69hySsj4teUyEwWOxCE0LSzd4/TAtHCX25jrF6F1Kq/Q9B8MSlYoTZ8oyZKUzjmHkkMvPH3so9d87NcLIT8ipI5e5ZuktePgtaONocof5jwHcb0CGcJ1s25pzNJk067Z5cPfq6WKTrpExcBmcisaS03Xl6Jm9TOK+1T0NQUKh+xAxq/OgOJBNt2RAchol/abhN3lbGdljfTU8h3kZqM2M0P+ec0Sj8IdH4EJNd1JHZvNkY6rz2ZgphYXhYhrae9IhKybx7kz4n7e3xnilP33lgCMQFPts4D9tSnwj
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?c/24a8415U+H1nIrjGUQC/s8pmN+JAAGgLOfQ2HtFdKgyM0z5fzQXDOWFd?=
 =?iso-8859-1?Q?rnxSVfbUYRlOSaml2E4bJ+HPO9NWJIgTNlKwlRWUSz4SySPMtbcAnmqtVA?=
 =?iso-8859-1?Q?jS3zF3c8taq5brY/RQvRRXLygvYl3CQmf/7vQLbmN0oyay9I4lPJJUiuRd?=
 =?iso-8859-1?Q?zosvi/iiEthFvIV6iblBD8UMnHtazG11EBSwvGBWNgVOmy7C6Q90EXVom4?=
 =?iso-8859-1?Q?GYaBBHDa/cv3NG+TBp97Mg/zx0cOITbS0CMQVnIAyDyiUXybapg4GX+BVe?=
 =?iso-8859-1?Q?Vwfqp7I/3WLRnrGbvKddo7pweIVm1B0Hriqgr7BO2nasyubghxQ9YZh5e6?=
 =?iso-8859-1?Q?HURKDHvOwkTGhyGA2GZjmDAMkqv+S16lIj/4zEtvq6pq7v6sIf10CfGdPj?=
 =?iso-8859-1?Q?XF/a+NQlfdUlo7Bm83Jf6kagHQbJ5vGkid+cUY7b0u3EW11njDGZX/AMZe?=
 =?iso-8859-1?Q?Uw0nfPqkvWCucBuKSlF7s/GaeAhNCAm569vshEelW/gBHtBtq2a4lfhCBG?=
 =?iso-8859-1?Q?wsEZxvtlg45n1zNGKNR8AYLjSLD208oFERy4vFrJAOcgLsZvTHHisWZe88?=
 =?iso-8859-1?Q?du5vNcgoGwe0yc5PLYbAADg6nuyZyuWjPjTwydlFvqyskXXuYbchlY8a6X?=
 =?iso-8859-1?Q?wCCo4+QagUTGLfzxTPS5x7yT+7Weue42bi5CmSFMGJdflVK1ZQPqj+jDQt?=
 =?iso-8859-1?Q?62rFBoj8Xwp1NbrtA7Ef9URKKfq8efmxMQLY8R99CZmvw92XkcnY0MM30W?=
 =?iso-8859-1?Q?WU/oU4ZgAIDhzd3ak6MAh0MtAGJwfG++Jh2F/td7hld03Lzml9dCtZeEZc?=
 =?iso-8859-1?Q?KQp0eAu9UAXTfIgw7IYQy56DWHGHJuwIxj8gSB1+8d58jmiSU8oPxEMgxs?=
 =?iso-8859-1?Q?QD/Bnzaj67hoVotxNENERpRqA0ggRaGRr0FqgKMpekzerNZMBhB0k/GSl3?=
 =?iso-8859-1?Q?2IG/4z8GIYeFvqvE/hQ4k/rgLppm8VsH62fsBPdN8gviqIQ/sMXUiMuDUj?=
 =?iso-8859-1?Q?/wWRs5hSdJcvKv8i0=3D?=
Content-Type: multipart/alternative;
	boundary="_000_VE1PR02MB5391616777980571A67A784EDC529VE1PR02MB5391eurp_"
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR02MB5391.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a35dee-954c-4ddd-746a-08d9d5c35693
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 12:01:59.7010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2861
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Corrupted or missing coccinelle-tests files
Reply-To: =?iso-8859-1?Q?Giancarlo_Stoo=DF?= <gstooss@outlook.de>
X-Loop: cocci@inria.fr
X-Sequence: 112
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-01/VE1PR02MB5391616777980571A67A784EDC529%40VE1PR02MB5391.eurprd02.prod.outlook.com>

--_000_VE1PR02MB5391616777980571A67A784EDC529VE1PR02MB5391eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

i tried downloading your coccinelle-tests.tgz (240 MB)<http://topps.diku.dk=
/cocci/coccinelle-tests.tgz>, coccinelle-tests.tlz (87 MB)<https://coccinel=
le.gitlabpages.inria.fr/website/distrib/coccinelle-tests.tlz> or coccinelle=
-tests.txz (67 MB)<https://coccinelle.gitlabpages.inria.fr/website/distrib/=
coccinelle-tests.txz> files but
the first one has a missing link and the other two seem to be corrupted whe=
n i try to unpack them with the tar command on Debian.

Greetings Giancarlo Stoo=DF



--_000_VE1PR02MB5391616777980571A67A784EDC529VE1PR02MB5391eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"DE" link=3D"blue" vlink=3D"#954F72" style=3D"word-wrap:break-=
word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-GB">Hi,<br>
<br>
i tried downloading your </span><a href=3D"http://topps.diku.dk/cocci/cocci=
nelle-tests.tgz">coccinelle-tests.tgz (240 MB)</a>,
<a href=3D"https://coccinelle.gitlabpages.inria.fr/website/distrib/coccinel=
le-tests.tlz">
coccinelle-tests.tlz (87 MB)</a> or <a href=3D"https://coccinelle.gitlabpag=
es.inria.fr/website/distrib/coccinelle-tests.txz">
coccinelle-tests.txz (67 MB)</a> files but<br>
the first one has a missing link and the other two seem to be corrupted whe=
n i try to unpack them with the tar command on Debian.<br>
<br>
Greetings Giancarlo Stoo=DF<span lang=3D"EN-GB"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_VE1PR02MB5391616777980571A67A784EDC529VE1PR02MB5391eurp_--
