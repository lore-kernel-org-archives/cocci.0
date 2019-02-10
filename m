Return-Path: <SRS0=Zy7X=QR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D65DC282C2
	for <cocci@archiver.kernel.org>; Sun, 10 Feb 2019 18:27:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFBEF20874
	for <cocci@archiver.kernel.org>; Sun, 10 Feb 2019 18:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="bDQ6N6xD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBEF20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1AIRE9S007935
          ; Sun, 10 Feb 2019 19:27:14 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E65FB76E9;
	Sun, 10 Feb 2019 19:27:13 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CC1DF761B
 for <cocci@systeme.lip6.fr>; Sun, 10 Feb 2019 05:56:59 +0100 (CET)
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-oln040092254045.outbound.protection.outlook.com [40.92.254.45])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1A4uwiP001653
 for <cocci@systeme.lip6.fr>; Sun, 10 Feb 2019 05:56:58 +0100 (CET)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExxCgsdpKVVppO/4Z/uP5DOQObo6GkhblhXvIKmOcvk=;
 b=bDQ6N6xDcNbeOSpG2DZugFfzW/tkLOEt5eEY1o0+rZFIoVJUZZsgwMxCp20QzesDqcmr+Vl7YAfAA+8bCWCSxW3pfqIw/I4xCZvy8N6UvbZE8dx52gLR6Q89/hB1CpYuzWhQx+uu6wQqbLnz3ruheHdf94rxTt7V2njna60QUSMWjFc0aWXzTc2vJpFYar06mywFOcqADxMY2cLXYG9DWHOzx4JgxlBalGktdhWTl18w98wOWZtMCsK3xcDH/DNXcBSyLwmAQmVYB/wqJ8h7xQ8x09OU6WWhgzJ5T8aeO7B8FYdReaci94JldnSsVqjJNv6d+XwdIndaVQ0LhhppdQ==
Received: from HK2APC01FT115.eop-APC01.prod.protection.outlook.com
 (10.152.248.60) by HK2APC01HT055.eop-APC01.prod.protection.outlook.com
 (10.152.249.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Sun, 10 Feb
 2019 04:56:54 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.248.56) by
 HK2APC01FT115.mail.protection.outlook.com (10.152.248.194) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Sun, 10 Feb 2019 04:56:54 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1601.023; Sun, 10 Feb 2019
 04:56:54 +0000
From: Wen Yang <yellowriver2010@hotmail.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>, Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek
 <michal.lkml@markovi.net>
Thread-Topic: [PATCH v2] coccinelle: semantic patch for missing put_device()
Thread-Index: AQHUwP0KPDAmvZUDEkG5WGDBof+AjQ==
Date: Sun, 10 Feb 2019 04:56:54 +0000
Message-ID: <HK0PR02MB3634E85F5155655F3A5A20DBB26B0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::47) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:F0A14543B3BD9E1AB04FE359EFB58040DA54024323252A63F95B31EC758A03D2;
 UpperCasedChecksum:824DF01111419B809D5FC432BE139B89F517973EF67437D0349E3094D938DFF0;
 SizeAsReceived:8687; Count:63
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn: [MRZpjMRaGTXtfU/CUqTI53wuKppBvxd0]
x-microsoft-original-message-id: <1549774437-12520-1-git-send-email-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HK2APC01HT055;
 6:RzoFUM8hqqyfAUnkZFNfxNToIZLqU99aRWBU7fSfDY46LRdiToKmanAXQUztgN6RYtSZg1xZyOS4KD/k4Koydx5RkoA5p3ghwOs2f9Mb6U/tG5rnJ+ZzTU9xbVdrS/me/VAtSEQ+rbgArohhNMS16lZ+yfDZ/2SiMc7zIS/hZTSCNU6/pbhOgVcr76bqHRJUttcvN0iL6D98rdeQxr0HfU9FDNiHUovzXuLZh7I3CzCC0zUBhCpmtQ0AC6RXPaUA+M9h12pnP7NNGRn0z0ROwfySI6MBHbzK0MSYwihQRQ/DVLlLlBO9TBvvOtYCPIq4yeSJjY/xuxaRmNBY1qC0Z/wVULD3lNlj7RfKxFvHVcWaY5UoqW7o+TdQN8IIJ16vBwi2ZQ8ip6a9PqspAskE62MKtQ4gu5aAaACGFFiw8ASeMfz/HY/SGoG8X1YlVrLReSiGrz8VjvF9utp8DcS9CA==;
 5:GmNz5JQsQmcOOZnfoiY+WT7Cpwj14uZNjEHnB4hEfFyJinQlH84pkLv4li3Pryo2g/e5leuvXdgDZrUX/SwtqTfjcbkRiIgQBFj+YOVImginj+Vt/mqPOQ8cxnzrS38YyXTA27NMGQucThAMhh++dcTmEj0ynqlUvl7W9SFbdCuGOj1oXcbgjrmo5Gwg53JyiXnUr3VW6wRbs8yT35wYdQ==;
 7:aXjooBOQL5wM/yhGqdlglbrxGWA9qLkkbFpEt1Lh5k87/YvPk/CqCK9JsCTFf9X7jNpj0QRgo6TMM7jgWnRTQ4VRJRseiALyiku/4Qfuo/Jdgk9Rm/dYRoy9uCN4gYagOyOx6b+MSCD3A/jQr8ALZQ==
x-incomingheadercount: 63
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: zswcL9HXbeXsGxgxUGH+YcjaDWppThp81DWPKDqPiOvEQNy/47bcPSMHCFm7DmOApG3PNYWAGQJ4l5saSpYlk3OAXHQ7zx1eZzJjjlCAb9+F7XaSCuV9Wg+jO1XICVTVwZNAIt+b1AjlvDANE/yQsFvOuqoVRYs+mWN3p7ng0upFjzolSPXhQ5d2hG5inSsnWFc7YtLbuopej5YEK9syioFj2xFXy2sCHMCsDs5O2JRtoxsZ7SxQPjhdg+4M3hglx6B9JCuVDPc1JWw40tLhBwuiCFMElhn3U+7x0y00cYXdkc5Gd8vgn6MhyZqSC4AhwCDSumeCOcMAzIcEfgLla2GpFPaqRdQQrZuxHoK6XXxxzewpK977NBSR3noCjsV1Xiu81AUURX93NfpY+tUHe7WcPVKW7jbW0bAmHlhbKJFojcmPTKKb0nM7pmkOszBlZryPLa2m6GRPIEHIdqyPWP3vVsOghpwY/JEFfzp9Ld5yY+veJ+QgV1ehhaalDoPZSs+n5nAKwz71sn5XwO1tHS1kNlzLzgsszxkROiGh2r0GlffRaTVuowk7hR+CljKRwezM/6qeYEqkLRYj/6/pxp/8zuqtX2no5ME5onZKyg878Jhzx3D4ltJKyfWMuR3N0bSUQ2dAtWIBwx7plwQTEPQC8eLlg7RpyeU71HMh5ztGmei4PP+HZ+ISsQzO35n6WyWoydOEmmy7RLqDrAEx8wEzE9ZqXmolDtJt1j1n5T2mUlu0qTI/AlecqY8traGC
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:HK2APC01HT055; 
x-ms-traffictypediagnostic: HK2APC01HT055:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:HK2APC01HT055; BCL:0; PCL:0; RULEID:; SRVR:HK2APC01HT055; 
x-microsoft-antispam-message-info: qrXpUfEarn1/JvgxzTegOppQTTx2VqLeblYTUAv9xXGLqGL30Hs40RUjoz6abTl/
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e47cdaf-ecdc-4e84-2b38-08d68f142cfa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2019 04:56:49.8547 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT055
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 10 Feb 2019 19:27:16 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 10 Feb 2019 05:56:59 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 10 Feb 2019 19:27:11 +0100
Cc: Wen Yang <yellowriver2010@hotmail.com>,
        "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [Cocci] [PATCH v2] coccinelle: semantic patch for missing
	put_device()
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

The of_find_device_by_node() takes a reference to the underlying device
structure, we should release that reference.
By using this semantic patch, we have found some object reference leaks,
such as:
11907e9d3533 ("ASoC: fsl-asoc-card: fix object reference leaks in fsl_asoc_card_probe")
a12085d13997 ("mtd: rawnand: atmel: fix possible object reference leak")
11493f26856a ("mtd: rawnand: jz4780: fix possible object reference leak")
There are still dozens of reference leaks in the current kernel code.

Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
Reviewed-by: Julia Lawall <Julia.Lawall@lip6.fr>
---
v2->v1:
- put exists after search, and then drop the when exists below.
- should not use the same e as in the when's below.
- Make a new type metavariable and use it to put a cast on the result of platform_get_drvdata.

 scripts/coccinelle/free/put_device.cocci | 54 ++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 scripts/coccinelle/free/put_device.cocci

diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle/free/put_device.cocci
new file mode 100644
index 0000000..510103a
--- /dev/null
+++ b/scripts/coccinelle/free/put_device.cocci
@@ -0,0 +1,54 @@
+/// Find missing put_device for every of_find_device_by_node.
+///
+// Confidence: Moderate
+// Copyright: (C) 2018-2019 Wen Yang, ZTE.  GPLv2.
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual report
+virtual org
+
+@search exists@
+local idexpression id;
+expression x,e,e1,e2,e3,e4;
+position p1,p2;
+type T,T1,T2,T3;
+@@
+
+id = of_find_device_by_node@p1(x)
+... when != e = id
+if (id == NULL || ...) { ... return ...; }
+... when != put_device(&id->dev)
+    when != platform_device_put(id)
+    when != of_dev_put(id)
+    when != if (id) { ... put_device(&id->dev) ... }
+    when != e1 = (T)id
+    when != e2 = &id->dev
+    when != e3 = get_device(&id->dev)
+    when != e4 = (T1)platform_get_drvdata(id)
+(
+return id;
+|
+return (T2)dev_get_drvdata(&id->dev);
+|
+return (T3)platform_get_drvdata(id);
+|
+return@p2 ...;
+)
+
+@script:python depends on report@
+p1 << search.p1;
+p2 << search.p2;
+@@
+
+msg = "ERROR: missing put_device; of_find_device_by_node on line %s and return without releasing on line %s" % (p1[0].line,p2[0].line)
+coccilib.report.print_report(p2[0],msg)
+
+@script:python depends on org@
+p1 << search.p1;
+p2 << search.p2;
+@@
+
+msg = "ERROR: missing put_device; of_find_device_by_node on line %s and return without releasing on line %s" % (p1[0].line,p2[0].line)
+cocci.print_main(msg,p1)
+cocci.print_secs("",p2)
-- 
2.7.4

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
