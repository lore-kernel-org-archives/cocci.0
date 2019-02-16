Return-Path: <SRS0=17+G=QX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB143C43381
	for <cocci@archiver.kernel.org>; Sat, 16 Feb 2019 16:05:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BD7222A3
	for <cocci@archiver.kernel.org>; Sat, 16 Feb 2019 16:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="A4O2TwHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BD7222A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1GG5ZM6016017
          ; Sat, 16 Feb 2019 17:05:35 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 510B376FA;
	Sat, 16 Feb 2019 17:05:35 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5FE2376F4
 for <cocci@systeme.lip6.fr>; Sat, 16 Feb 2019 17:05:32 +0100 (CET)
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-oln040092254013.outbound.protection.outlook.com [40.92.254.13])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1GG5RY1028596
 for <cocci@systeme.lip6.fr>; Sat, 16 Feb 2019 17:05:28 +0100 (CET)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2F8E39+o7/sRS6VCRTarI1sFG0JkAdUuZjGNENeASDs=;
 b=A4O2TwHs7t5g8KVdPFdm5Bu9bgzwR2Zfp35k1YVAwfxNxJAL60RoGg5YyEVsAVXP6D+9l901rNfCQKjBJa0rh6rTVgesYfr3fid8WLrveC6GRFZDgWmPr6TeNkBDO5Tfhp056tOLK0XUrmjzXYsv0rE2JxKq20rlZSQf1MbI+nVlf99Ra7Cuq/ZRFFKs8gzL1e3V36xiIxCQuWMn4JFf9z8aTeiNsXD+8mqli2/LRqYHz74DuOVa3CfbDefl6IIHfSWQvyp4eiSpM1azLeXXeiW/Brkc34l1c2DjxjjEezzSTQNcgHgfPUyMLfbgq73V5Vntxsl+t+55e1gX18l7dg==
Received: from HK2APC01FT062.eop-APC01.prod.protection.outlook.com
 (10.152.248.55) by HK2APC01HT065.eop-APC01.prod.protection.outlook.com
 (10.152.249.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Sat, 16 Feb
 2019 16:05:23 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.248.56) by
 HK2APC01FT062.mail.protection.outlook.com (10.152.249.193) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Sat, 16 Feb 2019 16:05:23 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1622.018; Sat, 16 Feb 2019
 16:05:23 +0000
From: Wen Yang <yellowriver2010@hotmail.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>, Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek
 <michal.lkml@markovi.net>
Thread-Topic: [PATCH v6] coccinelle: semantic code search for missing
 put_device()
Thread-Index: AQHUxhFshArXPGjFCU6fpXuO2HedKw==
Date: Sat, 16 Feb 2019 16:05:23 +0000
Message-ID: <HK0PR02MB36344E2B29CEB195892F6420B2610@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0094.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::35) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:E1799C7C8FDB8623835E51482981BCEC6915CEEC76CB6581ECD3D6301F747733;
 UpperCasedChecksum:2FBF9FC6B4ED2847F8841F140EEDAA3ABEB9B20B2FF7ED0377CD16476AF65AA8;
 SizeAsReceived:8731; Count:62
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-tmn: [vRMjxu7EN8c620FiABGEeeD68AJctdh5]
x-microsoft-original-message-id: <20190216160209.22876-1-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-incomingheadercount: 62
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: NS9Gj58uCj29K/+W35O7IhkXu46ajzz6JLxqq5pJVZREXIkaV54jThjjfK3iuYBSLKwmaY5zmf8Wnw08Bl8IyDxwP8VYV7tarS1mKkExOzUnuaMOXUGwR0yR1IsxqGNSH0ZvK5YIgJYV7w1/eJ6GxVfifpgxqO9mcRw6posI1UZHa3JLbLzDNDkZHVtIgh0K0KMnWU4AApreNsUMRjkRQNiF1f+fH/rr/ELK10m+/aoN6k4iz7PkDViSVWDJpuURGPzCP+joh2gSXKB1ABhv2EoQUO25ZLetn2tgeKwTfZJ7dYtlLNjnuMv+IDs3vxPRZVL1iNt9t+eOmeyqF6ofPondvuD+fuu7lJ6kIFXWaKKyxv3KnSkVF3020mIKFJBMXLS3+jzyRXPNR34v2TC1CiwEz31HFe+anwyabwL4x9TKEd63f1Hb9jIKakofZJPQaax4oNZZjx1sTcF0IzqRU5xZmMCbTynAMEITG7qRFyfBGTs1g7Q92eyso3soE1VhW6K+V6RItyyYArva3nucH+oAG542SBNsptJD6q2PzBqFjY8q12dNTcbUTL/fk0vs7SEM2Aue7tnXTOw7TwjHjDP9CDbbKY7EqvJByInSrts6GnnkrYjnTRSkf3DvJs9qf6sU2gD/uYAd5w6vYUshlOnakwJZ6wPrUYGXKWi6oCxArn+OVNryCPYe5Q/zNfbCGebjMXS63FVEHNpGaclDcA==
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(20181119070)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031322404)(2017031323274)(2017031324274)(1603101475)(1601125500)(1701031045);
 SRVR:HK2APC01HT065; 
x-ms-traffictypediagnostic: HK2APC01HT065:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:HK2APC01HT065; BCL:0; PCL:0; RULEID:; SRVR:HK2APC01HT065; 
x-microsoft-antispam-message-info: lRYEOmjHH3LIUKdyM3GA69cjCI04mcrN6bU5vR9dn2ScTmSaUFGq62BYgKtDSoM3
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: 66690990-3a0e-416a-28bf-08d694288e69
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2019 16:05:17.6778 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT065
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 16 Feb 2019 17:05:35 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 16 Feb 2019 17:05:29 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Wen Yang <yellowriver2010@hotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Markus Elfring <Markus.Elfring@web.de>,
        "cheng.shengyu@zte.com.cn" <cheng.shengyu@zte.com.cn>,
        "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Subject: [Cocci] [PATCH v6] coccinelle: semantic code search for missing
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
The implementation of this semantic code search is:
In a function, for a local variable obtained by of_find_device_by_node(),
a, if it is released by a function such as
   put_device()/of_dev_put()/platform_device_put() after the last use,
   it is considered that there is no reference leak;
b, if it is passed back to the caller via
   dev_get_drvdata()/platform_get_drvdata()/get_device(), etc., the
   reference will be released in other functions, and the current function
   also considers that there is no reference leak;
c, for the rest of the situation, the current function should release the
   reference by calling put_device, this code search will report an error
   with a specific confidence.

By using this semantic code search, we have found some issues, such as:
commit 11907e9d3533 ("ASoC: fsl-asoc-card: fix object reference leaks in
fsl_asoc_card_probe")
commit a12085d13997 ("mtd: rawnand: atmel: fix possible object reference
leak")
commit 11493f26856a ("mtd: rawnand: jz4780: fix possible object reference
leak")

There are still dozens of reference leaks in the current kernel code.

Further, for the case of b, the object returned to other functions may also
have a reference leak, we will continue to develop other cocci scripts to
further check the reference leak.

Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
Reviewed-by: Julia Lawall <Julia.Lawall@lip6.fr>
Reviewed-by: Markus Elfring <Markus.Elfring@web.de>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Markus Elfring <Markus.Elfring@web.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wen Yang <wen.yang99@zte.com.cn>
Cc: cheng.shengyu@zte.com.cn
Cc: cocci@systeme.lip6.fr
Cc: linux-kernel@vger.kernel.org
---
v6:
- to be double sure, replace &id->dev with (T)(&id->dev).
- long string literals can be accepted because of error message search concerns around a tool like grep
v5:
- exchange the word patch by code search.
- add a SPDX identifier.
- a split string literal can be unwanted.
- Change the content of the reported information.
v4:
- add Masahiro Yamada
- omit a blank line
- split the long message parameter
- reduce the number of metavariables
- Describe the implementation of the semantic patch,
  explain the scenarios it can detect,
  and further software development considerations. 
v3:
- reduction of a bit of redundant C code within SmPL search specifications.
- consider the message construction without using the extra Python variable msg.
v2:
- put exists after search, and then drop the when exists below.
- should not use the same e as in the when's below.
- Make a new type metavariable and use it to put a cast on the result of platform_get_drvdata.

 scripts/coccinelle/free/put_device.cocci | 55 ++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 scripts/coccinelle/free/put_device.cocci

diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle/free/put_device.cocci
new file mode 100644
index 000000000000..96e2508c0be1
--- /dev/null
+++ b/scripts/coccinelle/free/put_device.cocci
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Find missing put_device for every of_find_device_by_node.
+///
+// Confidence: Moderate
+// Copyright: (C) 2018-2019 Wen Yang, ZTE.
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual report
+virtual org
+
+@search exists@
+local idexpression id;
+expression x,e,e1;
+position p1,p2;
+type T,T1,T2;
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
+    when != e1 = (T)(&id->dev)
+    when != e1 = get_device(&id->dev)
+    when != e1 = (T)platform_get_drvdata(id)
+(
+  return
+(    id
+|    (T1)dev_get_drvdata(&id->dev)
+|    (T2)platform_get_drvdata(id)
+);
+| return@p2 ...;
+)
+
+@script:python depends on report@
+p1 << search.p1;
+p2 << search.p2;
+@@
+
+coccilib.report.print_report(p2[0],
+			     "ERROR: missing put_device; call of_find_device_by_node on line "
+                             + p1[0].line
+                             + ", but without a corresponding object release within this function.")
+
+@script:python depends on org@
+p1 << search.p1;
+p2 << search.p2;
+@@
+
+cocci.print_main("of_find_device_by_node", p1)
+cocci.print_secs("needed put_device", p2)
-- 
2.20.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
