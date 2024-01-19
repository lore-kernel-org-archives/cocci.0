Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386CFC47DDC
	for <cocci@archiver.kernel.org>; Mon, 22 Jan 2024 07:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject:
   reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=8aTK8Fz2WhK6qh8d+yIpcYSyrgRrI24cyuPCNWKIGCs=;
  b=WTsA0NUBCG26G6iPndisuilmCoHX5q0h+wgzGzTP7OyjB4YzViu3tUgS
   RuS1YS1PyTD4r7WmMCAw91cnlyRZ40RxsAtKKuWXKD43AnW8C0DH1MDCr
   LaaiXp8PAnrHu3o4my+SIChBj6ZpTss7kyEGwkDJYlh3LSucPHlG6tml2
   g=;
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
   d="scan'208";a="147851061"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jan 2024 08:50:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E7786E0CDB; Mon, 22 Jan 2024 08:50:51 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 774F9E00B6
	for <cocci@sympa.inria.fr>; Fri, 19 Jan 2024 03:53:55 +0100 (CET)
IronPort-SDR: 65a9e442_N+g1tH7XdI3AdOH+CgxRRAaOiHjPG2hLT4jDnTaghEy7T/p
 ZBbfzVqcdHcMJL9UKDNqLVs5upKm8aQNuTCTqKA==
X-IPAS-Result: =?us-ascii?q?A0EmAAA046ll/2uc6ERaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYFmUgdzWjAHCEiEU4NMA4ROX4hnA4Q7k2+FWhSBLD4PAQMBCwJEB?=
 =?us-ascii?q?AEBAwSEfwIWhzACHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQKBBhOFOwYrDYJcAYEcWEYBAQEBAQEBAQEBAQEBAQEBAQEBAQEUAghhA?=
 =?us-ascii?q?QEdAQEBAQIBEhERDAEBNwEPAgEIGAICGQ0CAgIvFRACBA4FAgEBHoJegj0jA?=
 =?us-ascii?q?wGpMwGBFAEWPwIoAUABAQIJgQuJEnqBMoEBggoBAQYEBLJ1CYEaLgGIGwGBU?=
 =?us-ascii?q?INcH4J0aXpCP4FOgRUngRSBbz6EBiMaBxAjgyGCaIEbf4MZKYoWJoZ0CUmBA?=
 =?us-ascii?q?h0DgQUEXA8bDx43ERAFDg0DCG4dAjE8AwUDBDIKEgwLIQUTQgNABkkLAwIaB?=
 =?us-ascii?q?QMDBIEwBQ0aAhAaBgwmAwMSSQIQFAM4AwMGAwoxMFVBDFADEVQfFhwJPA8MG?=
 =?us-ascii?q?gIbGw0nIwIsQAMCDxICFgMkFgQ0EQkLJgMqBjcCEgwGBgldJgcPCQQlAwgEA?=
 =?us-ascii?q?yspAyN0EQMECgMUBwsHeIISgQgDGSsdQAIBC209NQkLGwY9AphzgQ4cgQOBC?=
 =?us-ascii?q?iIpMpY0rl0KhBGhGwYTL4QBjHWZHi6HVBaQO4JRoQyEZwIEAgQFAg4BAQaBY?=
 =?us-ascii?q?z2BWXCDN08DGQ+GUIdQOINAj3lDMzsCBwsBAQMJiSKBRgEB?=
IronPort-PHdr: A9a23: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
 EE0YOw=
IronPort-Data: A9a23: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
 w==
IronPort-HdrOrdr: A9a23:ukpiH6krBNeqn9S6m0KQE7s49QHpDfOyimdD5ihNYBxZY6Wkfp
 +V8cjzhCWftN9OYhodcIi7Sc+9qADnhOdICOgqTMGftWzd1FdAQ7sSibcKrweAJ8SczJ8V6U
 4DSdkYNDSYNzET4qjHCWKDYrUdKay8gcWVbJDlvhVQpG9RC51I3kNcMEK2A0d2TA5JCd4SD5
 yH/PdKoDKmZDA+ctm7LmNtZZmJm/T70LbdJTIWDR8u7weDyRmy7qThLhSe1hACFxtS3LYZ93
 TfmQCR3NTojxj78G6Q64bg1eUYpDLT8KoMOCVKsLlVFtzYsHflWG2mYczDgNl6mpDt1L9gqq
 i1n/5pBbUJ15qWRBD8nfKl4Xic7N4jhkWSs2OwkD/tp9f0Syk9DNcEjYVFcgHB405lp91k1r
 lXtljpwqa/ICmw7xgV3eK4JS1Chw6xuz4vgOQTh3tQXc8Xb6JQt5UW+AdQHI0bFCz35Yg7GK
 02Zfusk8p+YBefdTTUr2NvyNujUjA6GQqHWFELvoiQ3yJNlH50wkMEzIgUn2sG9pg6V55Yjt
 60RphAhfVLVIsbfKh9DOAOTY++DXHMWwvFNCaILVHuBMg8SgLwQl7MkcQIDc2RCeI1JcEJ6e
 j8uXtjxBEPR34=
X-Talos-CUID: =?us-ascii?q?9a23=3ABy9kCmuGYHtlcWQCM1W0jma06IsATVjn0HbVEXW?=
 =?us-ascii?q?yAG0wF4OvY3K7qbxNxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AOVn7ag/M2+Aa+9rEf4c4h9CQf85u+KaNUUAqq7g?=
 =?us-ascii?q?XhuvdKwFvBj2nqh3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,203,1701126000"; 
   d="scan'208";a="147489478"
X-MGA-submission: =?us-ascii?q?MDHebQybGpm7UuqT7HUB0yq7qybN6VFS5ZvJ9X?=
 =?us-ascii?q?qFQ4oYXHCnOjuugpr+tmePjaSuJiy7bKCHwjppnfSnOf0nKEOM/cgeZ+?=
 =?us-ascii?q?UpKiCvGxKRT6ueRPkbQgIUFHZOM1/Ke9O/cZNBJ1lyjRu+d7Vghu77wl?=
 =?us-ascii?q?ToHscbhuqwm9z6EOkJlN5gtw=3D=3D?=
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 03:53:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1705632835; x=1737168835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8aTK8Fz2WhK6qh8d+yIpcYSyrgRrI24cyuPCNWKIGCs=;
  b=Uqpm9ONZZ20iIIgJHFiHEiQXiGD2btqWVxwfC932cQXOfV/WYLWYSM5R
   AqIimQsnqqOM4pY/hlNtm9Qg8mt5C8M0ctbVsV1OUiS5KU8W+y/zC5BEM
   PNHzCAYLk+J28OjYO+2jIhZd4K6YHdRoQqh3HmKZFzT6h8QGKs6jrg5nu
   nsLu453t9yEez83cdJq6GkMBK+jJrlyLepQ7eDrd40s+jk2Iw/qxoJl8R
   KYkY9qaT4Mqj4adX1m+9Mx3jZTRQqsI04NEu9j6GG65kN2TTMK+e58CPh
   mt/8xPAXpflqmdHnq//7E6Sefl/SkXE9vByzDFxgFfeCSkN1LE4CU62Qz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="108831552"
X-IronPort-AV: E=Sophos;i="6.05,204,1701097200"; 
   d="scan'208";a="108831552"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 11:53:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9dioT2c3+35ccFua2CsOgJlEw/+N2hjFMMAzUnuBGp6jS3Y6xGi6aWiQSrfTnSeV6IaNvpW73y7PjgBFmBLF61dy5phkUHfOdIC2Q+7CnzZwPhDnyLNF66tZvQfi9nNRkJ07T8rO2UOo9iNNyeDEq3Co6qYGx4MIobezh9j6OXoUwj5/BiqtlvW0acExZ6kui5TaoIFXXYKcBKYhCwATod5bihW6s1VQlqKigSfYIfLGLAy+keoKjF78DlvgHiFI2OLYBYNhc56qPt+PEi81BjKghz0m6yJd/bJ6gdI9yPU5zI0oI+wxazbhLc36DB/cChvGd4uLTh6acAozVMATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aTK8Fz2WhK6qh8d+yIpcYSyrgRrI24cyuPCNWKIGCs=;
 b=Cbxh4HvurKiyJbSNjkz4O/jvigIEYVI+NbtmO7GxiT0DBD5RIogE/pJngCgFAAkI25E3BhZf8ipaSkryF1xSUbCbCsmiviMSMZ+zA+4E1nNsY1h+jtMuV4mSa17K1vCZ2V1lDhBGnfNPQkcnK3QrPGEjkBEpwzuHB6EJ5wB83xjga5qExBI0yWb+x8PUY1XKbbAJZtZM1dX73qIsGEEzR0QJpfWiZDNbxUWx+iimWgpA9NxVN+UqGdsF+h9PfjTeXuRmdQdh1HeegHlflsqHeIQxnaqFBiz/3xqz0Q+7WlEyn82gFV/IKEDa2iU2U9DiAOwhId/TzWQ7gOeGoQFN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TY1PR01MB10865.jpnprd01.prod.outlook.com (2603:1096:400:323::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.15; Fri, 19 Jan
 2024 02:53:41 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50%6]) with mapi id 15.20.7228.009; Fri, 19 Jan 2024
 02:53:41 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Julia Lawall <julia.lawall@inria.fr>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas
 Palix <nicolas.palix@imag.fr>, "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: [PATCH 01/42] coccinelle: device_attr_show.cocci: update
 description and warning message
Thread-Index: AQHaSDIil6iSQfVKJk6069otilFPcrDgCPuAgABsBwA=
Date: Fri, 19 Jan 2024 02:53:41 +0000
Message-ID: <5b32f57e-c44d-44a1-b2f1-4dd7be59636e@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116041129.3937800-2-lizhijian@fujitsu.com>
 <alpine.DEB.2.22.394.2401182125480.3296@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2401182125480.3296@hadrien>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TY1PR01MB10865:EE_
x-ms-office365-filtering-correlation-id: af37808d-9934-4f27-9613-08dc1899d7fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3AQfudXDe+QRrwToZBHkQD7EgDd0X8TlI+cetLlxYxAQsqNnZ/n4HMsha3mgqrmWwp01QPym1RY8AretD8STD9mbHRows/2BXGSBDDHIxl/gksY15XShZH6Ypdjn/7+89xSxbeHlPErumeleev0t1Rwc7WQJ57ekvmvREwn7gFSfDPLnogkhomZqKcAcSYqD8YruU2S7Auhx543VjDrLx9XSjtT1KBmK0b7OzdLsgshOKeuEnIm4mpo2r1NKFnz6MWRbiRw0E75UsL0tf653exf9FsitDVKMx3WmoFSuuzSFVViquHGZKp8TBKmf1Pq1+gUt+lWfvQNAPCtVefRXSLkD9AD2fVIyGuwD4jHF/cJH/vslvtsRUmp2JeMdjLHGd4KiTwI6/RtIWRHjO+efA7mlaUPezFa9hvDBusdvc1OVIo9i6EYq1CqT6gfsrX66JpQGf2UnJtXGB78z4iVQc1ljDaLl4APD4cbcZ2mSy27EXfh92sIt/+DItp+oV4h9kMIXALFoaCbzk8CJ1gn4KP1RUps2GlEB/Az4YoIb3K9p12wgT6mi15b6bbT5CW8KUIUZbrgTuMwgtbxnfgraLsiE7C6ez52MFdDck610OltYwXQsnF1gblHrthF7hi3MMPvILPLe/BL/tlQyFJKFkBpwj/8Gb1217fUOOt88s4wBPAtP+4Sj7d/ixpQGbGu6NDLU/l07dK9/xkTPfeJLWf8PznalJeeaN3z7SQkSPeRfJXnE1jxA/B2YL6t72dQd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(230173577357003)(230273577357003)(186009)(1590799021)(64100799003)(1800799012)(451199024)(38100700002)(66446008)(53546011)(26005)(478600001)(6512007)(66556008)(2616005)(83380400001)(6506007)(64756008)(5660300002)(54906003)(6916009)(8936002)(6486002)(66476007)(66946007)(316002)(91956017)(8676002)(2906002)(38070700009)(41300700001)(4326008)(76116006)(82960400001)(86362001)(122000001)(15650500001)(36756003)(85182001)(31696002)(71200400001)(1580799018)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVpYemtTdzRqRmpUcmNPTnJmYUNab0F6aW5yUDYyNE04cC9abDl4U2VLMTFy?=
 =?utf-8?B?SXB6YmNkdG1Icm9oYlQwQ3hFLzZBS0N4MHNwZnNhMnMwK01DcVZzZ01Wcy9V?=
 =?utf-8?B?Ykd0emt4dEJ2aDBuZ3Q4RDZ1cDZIY1BOM3FraDVRQ3ZjcWJ3M1NlVlA3RVNS?=
 =?utf-8?B?ek1uNFRWNkxaY3pWWmhTRnBMVVZ4MEZPSTlSbkEzRi9vL3B1V1poMm1xK09s?=
 =?utf-8?B?Yld4Z3JaeHh3anZMVkQvODVIVkxvR1YzZW40K3BmM2syMFJtZ3UvZkd0QVV0?=
 =?utf-8?B?NTZiNkx4em83N2RxZVB2OENUQ1N4b0tmampEckhDaTV4WkExYm5yYzVNdUJl?=
 =?utf-8?B?aXhMRXVTY0tJQ2pKcG5QZXBjZUwwU0J6VkNPWU1yWVVvemxjRVA3TE0vTGtF?=
 =?utf-8?B?Q0ljdU9PaGpmRXlWR3NMUHd3dzd1dTdtOWJneXJZUjVKdC9UcTRRdkFzR3F6?=
 =?utf-8?B?enZBSHhqT1pMUEtLTUk3L3JwZ3MxZU9UYXp2ZGhiZlJRMkdsY21xbmhXcnhZ?=
 =?utf-8?B?eGdPRThadVFiZmRtODI4a3JLdGJCaURZb3ppYjZJNmR1THdxYlRzVGxhU1Yr?=
 =?utf-8?B?WmtJZjJZdU1Ld1Zpb2F2YkF0cTJXcmk4bHN0Vk83VGFkRVVEc1NvMW85aXcv?=
 =?utf-8?B?aHU2cEFIaXdFa1QyejB4ZGVVbUxCYTZENUsvV1RqcGJsNjJaYlBOTTZ4YjVv?=
 =?utf-8?B?K0g5NmRsTzNTd1lwRjdvT0hGdUlDM1hyVEZsVytWSnQxdEZ1OVdqamFaVGVH?=
 =?utf-8?B?b2NzY0N2c3dub09nRktkMDF2WFY3b1A5V1l4YXpYWU96dDFXdUMvRkszOUw0?=
 =?utf-8?B?K2NObTNUTHRrZHNjaWhrdEJFbHRZcDFxUjBCQ0RQT2J3WVN3bnVKN0N4NmZj?=
 =?utf-8?B?dGU2VXVwVXB0Z0lFbldQdWlHWHYwU1BTNHpqZjlXU2dxVjZyczRhVUlxeStv?=
 =?utf-8?B?ZHZndytieU9OTFg5NDFVek8rQjRUSnlNWmg4bjlWLzJNLzB5YlVBWEZ1M3ZD?=
 =?utf-8?B?cUhLdVVKWk5sekNRa09naFpLcy9lNnhhaFZONWlSTXpVQnJTUXpMcVpKSTZZ?=
 =?utf-8?B?ZGwrV2l4WHRzRmhKWW96czdNTXdUZ2p0dDRTRERrMjRmek12bE83NXFyK2gw?=
 =?utf-8?B?RGp5dW5TVm1oeDBGcndCNFF4ZE1FbG9zSUNVS2tiSTd2TTJ2d3k2ZFYzTnc5?=
 =?utf-8?B?cU1DN3dRcGhXYWwzcW9BamxrMllNaGw1bHFtdU9pRFEzT2lIV2dMazVZSDEv?=
 =?utf-8?B?YjJoQ2JvQVRiZlRaUUJ2SmNqZjUvcmtyZ2cyS2pmN3NhdHU2SnFiWjZFdnZN?=
 =?utf-8?B?NzhRK1czb2psWlNjT3M5TzRTbDY3b3hxUlI0WTZnZWttbUorOG5hRktvN2lk?=
 =?utf-8?B?YVgvVktWenRuSVlYa21VOWN3YkZ4cjFUSVp1TzkxZkRGVHJBYWx1SE5QNnNB?=
 =?utf-8?B?V0JvK2h3RExtRGhYZTc1NG1VQWFtTDd1d2ZoTFRiZ0ZEd1BuT2JCRE4zdHBp?=
 =?utf-8?B?Y3dyRURTbkl4Yjl2SUUrcU8wQUFTY3hVL1FYSkR6THdPejhzaXlUc2ZJTE5E?=
 =?utf-8?B?TWl4RVlZQ0gvOUYrcGNXZWpvN1BuK2xEVG94MEFnRXdPTFRWT3JNVWJ3Yi81?=
 =?utf-8?B?bHlUQ3d0Um44bE9LUHp2R0ZUb28xOGovbEpRWlBqNHBZSHdLT256VllQZUtr?=
 =?utf-8?B?M1lhdXhoSUhYUk52OU5mbEZ5SUZxZVNWa2NpS1p6MzB3S0ZWSlZTRGN6L1Uz?=
 =?utf-8?B?dkRKOTdXQnA2U0ZHblJNZmJkVGRQUVlKYVhzSmJadUVlajE0UkRwWmwzT0ZY?=
 =?utf-8?B?T2RaR1R3YjIrczBCUzYvSjFnclBBeXBBMktYN3dpS2xIc2w1OC9oUGxaMXFt?=
 =?utf-8?B?M0ZNMmhKRk8wS01TVFNueU02UUl5NGlLaFJCWEkxMUVmV0M1bzRNamVqNGZp?=
 =?utf-8?B?VDBVY2FidGV6MjRsTS93OHFyeVMxMXIxMDF6OVN6Q1QwallweTZTdEIyRmV5?=
 =?utf-8?B?TkY2ck5XU1NkTGozZnVkbGRJQ3N0MTRKQnJkM2w3aUlMRGQvekhON0YrMkoy?=
 =?utf-8?B?cjkwc0xLdnZkMXdhV3NjS20weTlnaDRsaWx0bEJ2QWZCWHNraE4rTmxEWUF4?=
 =?utf-8?B?N0R1cHpIcXJBb0RxYnplR3BIUVF4anB5S0lESU5ITlJCNWFuYVF1UzF3SHJh?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5CF91744917D84582125CAE872687FF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9mIAxnpdNGcjrSdF84TFCW7vhmFTrCQfQw61qKknS55zodew29ijK8fV7XQNAT6RWA+908vtcd9oNXYOBZ/o9oP4WxzuJXQRsuZIbfhenfgS/9H5n3ZiOxpUB+lQ0uFj2ArgpMMG1IlE2OOhpkZbkNDxkuTTa+dsNFcCq5XJxhyQQtyZJxhY+SlaJ/+qCQ8e+uscr3ZcEJ7fZSUGPRPZj78q4Ida7ucv0tjm2HHP0q7X1NJ613l4SoNw2J8r6Y3B80qFUfC1JbEjfO+bYNpWDAnTd5jDA5uVlTrsyQfbSaeDrusaOEIKjJKA3/XpZ1p4A7cgYI0R568LaGAqcd46c3JBpuhhzDfviB+OsoSnCh/SLmQgCg4TF4RstA9hhmrIr58HvMbRt1kUKaU1c4KcL0EOBo4yM49SGmoistXAbGQdLyoSmwAS3Ets8+GUI2GKylvZahmoRNW4GFC8PaPsNWi4Y6ythrKnscC1cS3cAm1ELX6FO+3SWqE2No/v7zfCp7NjbHHi9PZiEqAFCfkW2E3M4+d3iSGYoL6FLxlpb2JHFTL1w0Z/xWTSast0EAQgKjchZWYFnb2T6U5NIQtJbp95UyMJcqJrUxQ4w3t7LWtEm+ogGxS05i1cfrfND8Qa
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af37808d-9934-4f27-9613-08dc1899d7fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 02:53:41.1920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sn/6B8AhthAX13AAhTdr5/SYJPkGfZ7My8BL1Zc820OJjoQMLnFc4E60HcXQbX499lJCM7xRmO2EEvsIK54dew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10865
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 01/42] coccinelle: device_attr_show.cocci:
 update description and warning message
Reply-To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
X-Loop: cocci@inria.fr
X-Sequence: 1468
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/5b32f57e-c44d-44a1-b2f1-4dd7be59636e%40fujitsu.com>

DQoNCk9uIDE5LzAxLzIwMjQgMDQ6MjYsIEp1bGlhIExhd2FsbCB3cm90ZToNCj4gDQo+IA0KPiBP
biBUdWUsIDE2IEphbiAyMDI0LCBMaSBaaGlqaWFuIHdyb3RlOg0KPiANCj4+IFVwZGF0ZSB0aGVt
IGFjY29yZGluZyB0byBsYXRlc3QgRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9zeXNmcy5yc3Qu
DQo+Pg0KPj4gQ0M6IEp1bGlhIExhd2FsbCA8SnVsaWEuTGF3YWxsQGlucmlhLmZyPg0KPj4gQ0M6
IE5pY29sYXMgUGFsaXggPG5pY29sYXMucGFsaXhAaW1hZy5mcj4NCj4+IENDOiBjb2NjaUBpbnJp
YS5mcg0KPj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29t
Pg0KPj4gLS0tDQo+PiAgIHNjcmlwdHMvY29jY2luZWxsZS9hcGkvZGV2aWNlX2F0dHJfc2hvdy5j
b2NjaSB8IDEwICsrKystLS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvc2NyaXB0cy9jb2NjaW5lbGxl
L2FwaS9kZXZpY2VfYXR0cl9zaG93LmNvY2NpIGIvc2NyaXB0cy9jb2NjaW5lbGxlL2FwaS9kZXZp
Y2VfYXR0cl9zaG93LmNvY2NpDQo+PiBpbmRleCBhMjhkYzA2MTY1M2EuLmE2MjFlOTYxMDQ3OSAx
MDA2NDQNCj4+IC0tLSBhL3NjcmlwdHMvY29jY2luZWxsZS9hcGkvZGV2aWNlX2F0dHJfc2hvdy5j
b2NjaQ0KPj4gKysrIGIvc2NyaXB0cy9jb2NjaW5lbGxlL2FwaS9kZXZpY2VfYXR0cl9zaG93LmNv
Y2NpDQo+PiBAQCAtMSwxMCArMSw4IEBADQo+PiAgIC8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wLW9ubHkNCj4+ICAgLy8vDQo+PiAgIC8vLyBGcm9tIERvY3VtZW50YXRpb24vZmls
ZXN5c3RlbXMvc3lzZnMucnN0Og0KPj4gLS8vLyAgc2hvdygpIG11c3Qgbm90IHVzZSBzbnByaW50
ZigpIHdoZW4gZm9ybWF0dGluZyB0aGUgdmFsdWUgdG8gYmUNCj4+IC0vLy8gIHJldHVybmVkIHRv
IHVzZXIgc3BhY2UuIElmIHlvdSBjYW4gZ3VhcmFudGVlIHRoYXQgYW4gb3ZlcmZsb3cNCj4+IC0v
Ly8gIHdpbGwgbmV2ZXIgaGFwcGVuIHlvdSBjYW4gdXNlIHNwcmludGYoKSBvdGhlcndpc2UgeW91
IG11c3QgdXNlDQo+PiAtLy8vICBzY25wcmludGYoKS4NCj4+ICsvLy8gc2hvdygpIHNob3VsZCBv
bmx5IHVzZSBzeXNmc19lbWl0KCkgb3Igc3lzZnNfZW1pdF9hdCgpIHdoZW4gZm9ybWF0dGluZw0K
Pj4gKy8vLyB0aGUgdmFsdWUgdG8gYmUgcmV0dXJuZWQgdG8gdXNlciBzcGFjZS4NCj4+ICAgLy8v
DQo+PiAgIC8vIENvbmZpZGVuY2U6IEhpZ2gNCj4+ICAgLy8gQ29weXJpZ2h0OiAoQykgMjAyMCBE
ZW5pcyBFZnJlbW92IElTUFJBUw0KPj4gQEAgLTQ2LDEwICs0NCwxMCBAQCBzc2l6ZV90IHNob3co
c3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAq
YnVmKQ0KPj4gICBwIDw8IHIucDsNCj4+ICAgQEANCj4+DQo+PiAtY29jY2lsaWIucmVwb3J0LnBy
aW50X3JlcG9ydChwWzBdLCAiV0FSTklORzogdXNlIHNjbnByaW50ZiBvciBzcHJpbnRmIikNCj4+
ICtjb2NjaWxpYi5yZXBvcnQucHJpbnRfcmVwb3J0KHBbMF0sICJXQVJOSU5HOiBwbGVhc2UgdXNl
IHN5c2ZzX2VtaXQiKQ0KPj4NCj4+ICAgQHNjcmlwdDogcHl0aG9uIGRlcGVuZHMgb24gb3JnQA0K
Pj4gICBwIDw8IHIucDsNCj4+ICAgQEANCj4+DQo+PiAtY29jY2lsaWIub3JnLnByaW50X3RvZG8o
cFswXSwgIldBUk5JTkc6IHVzZSBzY25wcmludGYgb3Igc3ByaW50ZiIpDQo+PiArY29jY2lsaWIu
b3JnLnByaW50X3RvZG8ocFswXSwgIldBUk5JTkc6IHBsZWFzZSB1c2Ugc3lzZnNfZW1pdCIpDQo+
IA0KPiBUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLCBidXQgaXQncyBub3QgcmVhbGx5IGNvbnNp
c3RlbnQsIGJlY2F1c2UgdGhlDQo+IHBhdGNoIHJ1bGUgc3RpbGwgZ2VuZXJhdGVzIGEgY2FsbCB0
byBzY25wcmludGYuICBXb3VsZCBpdCBiZSBwb3NzaWJsZSB0bw0KPiBmaXggdGhhdCB1cD8gIE9y
IHNob3VsZCBpdCBiZSByZW1vdmVkPw0KDQpHb29kIGNhdGNoLCBpIG1pc3NlZCBpdCBiZWZvcmUu
DQoNCkxldCdzIHJlbW92ZSBpdD8gIEp1c3Qgc2ltcGx5IHJlcGxhY2luZyBzY25wcmludGYgdG8g
c3lzZnNfZW1pdCBpcw0Kbm90IGVub3VnaCBmb3IgdGhlIHBhdGNoIG1ldGhvZC4gQmVjYXVzZSBz
bnByaW50ZigpIHZzIHN5c2ZzX2VtaXQoKQ0KdGFrZSBkaWZmZXJlbnQgYXJndW1lbnRzLg0KDQpJ
J20gbm90IGZhbWlsaWFyIHdpdGggLmNvY2NpLCBpZiB5b3Uga25vdyBob3cgdG8gd3JpdGUgdGhl
IHBhdGNoIG1ldGhvZCwNCnBsZWFzZSBsZXQgbWUga25vdy4NCg0KDQpUaGFua3MNClpoaWppYW4N
Cg0KDQoNCj4gDQo+IHRoYW5rcywNCj4ganVsaWE=
