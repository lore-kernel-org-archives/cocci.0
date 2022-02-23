Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1122BC433FE
	for <cocci@archiver.kernel.org>; Wed, 23 Feb 2022 08:13:52 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,390,1635199200"; 
   d="scan'208";a="22777077"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Feb 2022 09:13:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3C28EE035B; Wed, 23 Feb 2022 09:13:50 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 17E85E00A8
	for <cocci@sympa.inria.fr>; Wed, 23 Feb 2022 06:34:59 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=morgangreen@hotmail.com; spf=Pass smtp.mailfrom=morgangreen@hotmail.com; spf=Pass smtp.helo=postmaster@NAM10-DM6-obe.outbound.protection.outlook.com
IronPort-SDR: F7cl0CqNM4ky+ediNur+ocVBbhPCpM49BhOC6T1c6yypPQp/biHYe9Se8jrCXJsJZq5CoSQA0/
 g5QFulvwVPcdwg2y42gmBEmebCPFvUQa3TCbXvtsToRRQQWuaYnxkMMyvCkucXLI7t0nPP11eT
 lFGa24XXQ4UsKqEmoHk9L7EC457lt+8YKKhVafLsUWLe6CYQ96gv8iiPRiUJpIGgBhAQDQYTU5
 GBGBaejE0I7u+I1ltJvBqQEZvRMBLP3q2xyu+vS0rcP9RnU91H9Tp+Vct3Mez9D3qdne5EfElP
 rtfVxgUV3TRb8W5LsVOIWpJI
X-IPAS-Result: =?us-ascii?q?A0CqAwA3xhVih0kpXChaHgEBCxIMQIINgR9WgVYnAwcIQ?=
 =?us-ascii?q?ogeA4U5iGmCLIgigQSGEIwfCwEDAQwBQQQBAYUHAoQKHwYBBDQTAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQMBAQUBAQECAQECAwQBEwEBAQwNCQUICgcOEAVmZV0BgU4Bg?=
 =?us-ascii?q?TAoBgMxAQyCNSKEBC4BATgRAYEAJwQbGoJigmUBAy8Cn34BgToCAosVgRcFA?=
 =?us-ascii?q?RaBAYIIAQEGhEcBIygDcYFbCYE8iTR8hFaBSUSBWIdsg02CLpRQNGGCaZJ1j?=
 =?us-ascii?q?maeal6Ccw8BgS8LnjcVg2ABlXeOPZZOIKYqAgQCBAUCDgEBBjWBQ4F+Mxojg?=
 =?us-ascii?q?zlOAQIBAQENAQIBAQMBAgEBAQkBAQEBjh0MDQmDUIpeQjM4AgYLAQEDCZNMA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FhNXBPKMJv5gYsL
IronPort-HdrOrdr: A9a23:eeyuFat7jBSq9LheGGNrOr5F7skCUYMji2hC6mlwRA09TyXGra
 2TdaUgvyMc1gx7ZJh5o6HnBEDyewKkyXcT2/hlAV7CZniVhILMFu1fBOTZslnd8kHFl9K1tp
 0QB5SWaueAamSS5PySiGbXLz9K+qjlzEncv5a6854bd3AJV0gP1WdEIzfeNnczaBhNBJI/Gp
 bZzNFAvSCcdXMeadn+LmUZXsDYzue74q7OUFojPVoK+QOOhTSn5PrRCB6DxCoTVDtJ3PML7X
 XFqQrk/a+u2svLgyM0llWjpKi/1bPau5N+7f63+4UowwbX+0qVjbFaKve/VGhcmpDh1L9lqq
 iDn/5qBbUK15qYRBDPnfKq4XiW7N8C0Q6d9bajuwqTneXpADYhT8ZRj4NQdRXUr0ImodFnya
 pOm2aUrYBeAx/MlDn0o4GgbWAYqmOk5X451eIDhX1WVoUTLLdXsIwE5UtQVJMNBjjz5owrGP
 RnSMvc+PFVe1WHaG2xhBge/DWBZAVOIv7deDl+hiW86UkooJhYp3FovvAiog==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,390,1635199200"; 
   d="scan'208";a="22756506"
X-MGA-submission: =?us-ascii?q?MDF/vqd5P/v2KOyCjfUKa9hx+mtCq83Mm7dWhA?=
 =?us-ascii?q?1AIJCr8CIKMQt5xN6E2oGFqwFVgjEJCdXpineGSywlH85XPIDbuJPpVf?=
 =?us-ascii?q?wh7c6I7eSievoRyU4r/tAdhEKVZsCJY5b5DWbSVn8MhcHLmC+7G+5m8M?=
 =?us-ascii?q?MV04evazP4eKOiNT2ZKJnwjQ=3D=3D?=
Received: from mail-dm6nam10olkn2073.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([40.92.41.73])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 06:34:57 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnBvz1S0i8CVcrTkvnH40P1EvjSRueNmVbjz+K4HC1RImkZlI3eM4tVTF6p8gTKRjMy6LFwc0WkSe5fENB9rvMTfsGKyiXf13NsAyNdHBb9xFPL91U9Dmqgz+UyuwJ+tuP3BtWO6vrTtXEsslG6yWriHcwRklEctcc1LER8ByWnR6Z41243Ydb2YH0ZoGSjUrMi4UvwZyOc+RbpJrnd2W0DutpVDYxzLpvx/VrFr3ASiHrLl7LHiynEwWsdUdU8JSmWDEm2aRayxZ4wV+hYAFoZiRqiWYbSptqwoSRqOspUlEhwdUSXpHy4afPfNwdePL15aCo+h5XHZFVtF4glbtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cq5tmQ+TzT2Ga0RSPppz9rlevChD0Gbkg+aEMVKWzs=;
 b=bAqdTIEbUSu5puIueTcCroiwJcdCgOp6SQLqXMSTcD1PDEnbulPN+SaFJwaww6u3QiCIHEdspSZq7dnJDwmPa770sEGme6Xgd8lDQfas5cU/q+FsNLyA2VyTgn+VXIkMZHwtuloxIiQH4okLTArdMrcu+voRd2yvE/xWsWhZqGjjqj9ETClTdzoYIWqtTbl1IaCzvVv3HbLkkEkqVVk2NebsYtwg1rPqXG7gXcZOCx5s/FizQg3SPXERRu6B5sYhaSnmjYJ5c7riaGdW7PYMVsO5qPDDOqcm1KyABxnsLV2AidLZH6McE0huVik4L1P7K7ziQCmTwuNataFrGInr5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cq5tmQ+TzT2Ga0RSPppz9rlevChD0Gbkg+aEMVKWzs=;
 b=Wj5yhCVN3nvR7+0PxRGIN3otuqxPH/l8NqEtGWCN795edJ2b/sR+3m8GR7w/jfxIvNIQIh++5xNsizHcM0LHicaC4b9wgOT+G2VpwJ6TjToV9e0hfAXhVz1zDk1R6ZNs+k5uILYWCS56/xuNTdWSKH59fINzScE34BY/ybmhLTEGfKMPobUfixQiLQ+mgxVcgmQto3tJKdM4DBWGZU6VO+IOxnJnLHe/sWQeq16bQ59vG3eKpwLDOCXBLdEB0n5x+67wp+meEFshfvgrYwGq7CnKM2b0L2ztkNGDB3jZ4i1EbQy+seqd/F894LKBXSj6ODlh7oz3v5bvI1zz06jH6w==
Received: from DS7PR19MB5853.namprd19.prod.outlook.com (2603:10b6:8:78::17) by
 DM6PR19MB4181.namprd19.prod.outlook.com (2603:10b6:5:2b4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Wed, 23 Feb 2022 05:34:55 +0000
Received: from DS7PR19MB5853.namprd19.prod.outlook.com
 ([fe80::b0a1:26e0:7bde:f54]) by DS7PR19MB5853.namprd19.prod.outlook.com
 ([fe80::b0a1:26e0:7bde:f54%7]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 05:34:55 +0000
From: Morgan Green <morgangreen@hotmail.com>
To: "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: spatch 1.1.1 hang
Thread-Index: AQHYKHVgCixvwz1tJEuQecp1k+EWVQ==
Date: Wed, 23 Feb 2022 05:34:55 +0000
Message-ID:
 <DS7PR19MB5853BC1DDFC7F8D92CF26115AC3C9@DS7PR19MB5853.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [HC0+gu8MA+iH7zVEUtlLFAye8nUXqD+l]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1e35164-49a0-48bd-86e9-08d9f68e3951
x-ms-traffictypediagnostic: DM6PR19MB4181:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3qRnS2X8Z7iMpYhcV51ThTlIsIYeJ9FLusnwa85uWA1aqgKrYgRVT3sawbl4cNId1q5dx5YF2+7jG1D5vVqzVgTA6TaAmUIGnoAg1JvPLKL9BlRlEeOHDUBWpN1fc0VOcpsw0gQBWV5QlMUK+0ujp/ZcT/m6EobXR83x+lK/eCS7ZcYSH1+Utdyp/uJ53V8xrbo8/diKBdTulFiEy52kb4sc8CEkR1aIIlmCJmfLbJ6iVG4ZnS0Oe0f1zIpOhGsoWqFe4mcAQHiKhlaQu0AQVrUU4+kRX8eoVYcoOoYTBQstPHg30IgM4TYC1aEwyIWujUKRS0iMPlJjvroGdncsP/A1uc94pDppeqIsETycWptOZmcOG/oecNudul2bk751HwyIrZHHZxhkXKxoVKYz3p3TzatxflAtFa1oduENI2I19Tv1yCVUHyjwtgRxx/Ux7JzYd57g/IY9kpWtspE2c3CYc1FdAoC6o8As1SLuXa2whlnEJ5Dftx9VO4M9VQteHaQKlv47T8wIMSvC5HcgsCORq+kmfpe2SjRe1RaanWgghCKB6H5pmHX9zFpDjDTAEgu5vyZ4OuTUqTCcIsEE3g==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 mLJxbJVa04SCMyuXGr0pMc8tnn+E83PvQJn372X312B98Xj9UzEjx0ItlsFHZtxwdHXktb8YJdstJnjHqIWVXJX0mWZpexx/sreqAuBtduZlgK4wgUzweDil/enQPEG8sHUCmGqlFy6Wq8O7np67QBM3muH0YBhmEY4hu7oc3i+w3WN+YNZvg1gc0xvdSi/o7+yq9dIGPYAZ8rdBe7Zbw6e93b6TYXq8eHHMypJ67G05AFr9V7U4pz7QRzIjTd60yxBVVptW9ofHEyHXajv3maEeziGQXQlmimVlPCQje9XqnOzqPCPVp+RoEAAKNGy33WZ6n1ZEB3I/COXrWYtQT0a2cZTqzecBLMm9r1cAAV7zxIz3trUlrkpvRPCgez05SQIy/7iGBPuteZY3A3AWxSdLo3m+t2tp9tDONiOf2/e8U06pNhkyKEkD8ZgTpXu7GsEarxwXzrSYic5w3siG4Z93PVJhIXRGySawfZIsN65lltHuNETJNjg1ErQX9PP8N1BLCMN1/BxKfbUt4JRSCvYxTbQ3NRXH5kzadO+6aNTzQ/UR0RehmjadGajDDX/1vDCXHeWqR0PQFzvCbrd0fXWk3fLM02UXE9U0OcCFK4mr5P0m9/5kHnTLaWYCbrs4qaSV8yzVozWSOsJrMscVdg/lYP0RiZLMhQ8ipZBXhoADW/7C5ljHFhLqdatriG02NBZIBcYf9vcM5ct3cIZvyyTRIGly/wGyM7JIcBycFdrpOPNY6K6jsJ5NoCRrBN8pTQf28ED8t1SKcQICkbig7CaaJgWcAYmVYjyqbpp+nS+O2DpeZtMf3LCRJQHMYMDPehfkrHgFtkbfheq8wbdHczWt7FoTAv+7lPTzFhFQdLU6y5NA0wscArysLDnJ6YKKzqjI/YXVU6biJ6EB2/quby8rNs4DppOZB5KtLXQ431wJPAzk3SMSPdg3WpeXlfYV
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e7757.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5853.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e35164-49a0-48bd-86e9-08d9f68e3951
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 05:34:55.6131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4181
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] spatch 1.1.1 hang
Reply-To: Morgan Green <morgangreen@hotmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 146
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/DS7PR19MB5853BC1DDFC7F8D92CF26115AC3C9%40DS7PR19MB5853.namprd19.prod.outlook.com>

In a message earlier today about C++ support I mentioned an unrelated spatc=
h hang. I've now figured out how to reproduce it with a simple C test case:=
=0A=
=0A=
spatch --sp-file test.cocci test.c=0A=
=0A=
---- test.cocci=0A=
@@ @@=0A=
{=0A=
...=0A=
- if(1) {=0A=
+ {=0A=
...=0A=
return ...;=0A=
}=0A=
- ...=0A=
}=0A=
---- test.c=0A=
void foo() {=0A=
    if(1) {=0A=
        return;=0A=
    }=0A=
=0A=
    while(loop_test) {=0A=
        if(junk) continue;=0A=
    }=0A=
}=0A=
----=0A=
=0A=
It seems to reproduce whenever there is a loop that contains a continue sta=
tement after an if(1) { return; }.=
