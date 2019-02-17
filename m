Return-Path: <SRS0=/UbJ=QY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_INVALID,DKIM_SIGNED,FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A402C43381
	for <cocci@archiver.kernel.org>; Sun, 17 Feb 2019 02:33:10 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9061121A4A
	for <cocci@archiver.kernel.org>; Sun, 17 Feb 2019 02:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="RoJKu0MN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9061121A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1H2WmGA025116
          ; Sun, 17 Feb 2019 03:32:48 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8588F76FA;
	Sun, 17 Feb 2019 03:32:48 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 37EEF76F4
 for <cocci@systeme.lip6.fr>; Sun, 17 Feb 2019 03:32:44 +0100 (CET)
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-oln040092254102.outbound.protection.outlook.com [40.92.254.102])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1H2WgpN016740
 for <cocci@systeme.lip6.fr>; Sun, 17 Feb 2019 03:32:42 +0100 (CET)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiupUqSbjU8L7taOlmSFc20Phfe448yXC3jlOF9NSI4=;
 b=RoJKu0MN6HDw5OYGpWgzGZn5c8qjiC78GyAzEyXnQtGXsVztORiVuPl7X88s2Ln0YHCofdJ/1ckFCBXhwTXwiCf2BIkRz6ZoAQm49UhlfvQm4CwOtX4LKp8nKx3fAscmDxYAvCWY92Nz4nxUtfbxVzjVwqVWJJHpCky7pEeCl7zoJP9aj4J/1xSnDB8HeNqRNb1yUNwGCq7Qf6NMzchmlnXISjKuXjbBHGzJ/ZYmTNjUsyx70i6963pACjeU7ix63PrObt15deip/P7Vf2WYJzGkRf1tFKZNYwDv5r0PrqnH8W7wiT718aj4Hz8F+n2vfJtvLixef1vng61n9ITETA==
Received: from PU1APC01FT018.eop-APC01.prod.protection.outlook.com
 (10.152.252.60) by PU1APC01HT005.eop-APC01.prod.protection.outlook.com
 (10.152.252.91) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Sun, 17 Feb
 2019 02:32:38 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.252.60) by
 PU1APC01FT018.mail.protection.outlook.com (10.152.253.189) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Sun, 17 Feb 2019 02:32:38 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1622.018; Sun, 17 Feb 2019
 02:32:38 +0000
From: Wen Yang <yellowriver2010@hotmail.com>
To: Markus Elfring <Markus.Elfring@web.de>,
        Julia Lawall
 <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
Thread-Topic: [v6] coccinelle: semantic code search for missing put_device()
Thread-Index: AQHUxicMT09vQ7Vunkaw08iyKrsAn6XjQrPn
Date: Sun, 17 Feb 2019 02:32:38 +0000
Message-ID: <HK0PR02MB3634E4B3441651D4F7737399B2620@HK0PR02MB3634.apcprd02.prod.outlook.com>
References: <HK0PR02MB36344E2B29CEB195892F6420B2610@HK0PR02MB3634.apcprd02.prod.outlook.com>,
 <52c3fdf6-0d04-eed5-da57-ef7d1008c291@web.de>
In-Reply-To: <52c3fdf6-0d04-eed5-da57-ef7d1008c291@web.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:693F222A4D37DD3368241B05C9360ED1895CDB3CC1A5DE9BE68DC876A755666C;
 UpperCasedChecksum:18BA7BE0523D0618B836A142787BEF6BF3E82B4DF2C7742E31CAF12E4D9DA985;
 SizeAsReceived:7467; Count:45
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [3SSAi4JV01an08QUOQnZpofgZ5GzpQRa]
x-ms-publictraffictype: Email
x-incomingheadercount: 45
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:PU1APC01HT005; 
x-ms-traffictypediagnostic: PU1APC01HT005:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:PU1APC01HT005; BCL:0; PCL:0; RULEID:; SRVR:PU1APC01HT005; 
x-microsoft-antispam-message-info: 7lXgikwCn3P3eXApXMkqzH1l/ldfZ2LEHWkhN0EAAYKHzg29uhzJ/fgQxkAKFW0M
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: 5763301a-00f2-45d5-d11f-08d694802ec7
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2019 02:32:38.0325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT005
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 17 Feb 2019 03:32:49 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 17 Feb 2019 03:32:43 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: [Cocci] =?gb2312?b?tPC4tDogW3Y2XSBjb2NjaW5lbGxlOiBzZW1hbnRpYyBj?=
 =?gb2312?b?b2RlIHNlYXJjaCBmb3IgbWlzc2luZyBwdXRfZGV2aWNlKCk=?=
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr


Hi Markus, 


> > In a function, for a local variable obtained by of_find_device_by_node(),
> 
> I got a software understanding where such a variable can not be obtained
> from this function call.
> The return value (like a pointer in this use case) can be stored there.
> 
> > v6:
> > - to be double sure, replace &id->dev with (T)(&id->dev).
> 
> The support for data type casts is another interesting extension for
> this source code analysis approach.
> Further adjustments might become possible at other places of the presented SmPL script
> after specific clarifications of previously mentioned implementation details.

First of all, thank you for your comments.

But please also refer to the examples of coccinelle, such as:
http://coccinelle.lip6.fr/rules/kmalloc.html
and 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccinelle/free/pci_free_consistent.cocci

You will find that there are differences between coccinelle and c.

 
Regards,
Wen
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
