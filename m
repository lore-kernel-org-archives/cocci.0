Return-Path: <SRS0=+34m=CQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A075DC43461
	for <cocci@archiver.kernel.org>; Mon,  7 Sep 2020 16:58:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 456DC207DE
	for <cocci@archiver.kernel.org>; Mon,  7 Sep 2020 16:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="EbFx19ne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456DC207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 087GwFVc021309;
	Mon, 7 Sep 2020 18:58:15 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 79AAC7595;
	Mon,  7 Sep 2020 18:58:15 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A7DF04316
 for <cocci@systeme.lip6.fr>; Mon,  7 Sep 2020 18:54:43 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 087Gsg6N016823;
 Mon, 7 Sep 2020 18:54:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1599497682;
 bh=zpCWFiaT3xEtP+JHi5OqYg95ccNUMbzWiFVTxEHRf3g=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=EbFx19neVtBLRs7Z1Vks47ZJ3Z4h0cf1rUSc4ICZQ1OwLD3mcERrxHQtNdOj/toOi
 vqqG9BeQdSWW2fRaWgaCYBSa1i6AskGVvfHduzrJEtBIbvnQy0ViLItBYyfHnzPW+2
 LoZ1bYTIk/fHpX6ZtASd47wiQhUUbh+5/TlVza1s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.162.183]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LhNs4-1kt2sz46JU-00mcx8; Mon, 07
 Sep 2020 18:54:42 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>, Dejin Zheng <zhengdejin5@gmail.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix
 <nicolas.palix@imag.fr>,
        kernel-janitors@vger.kernel.org
References: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de>
 <5f9fdd59-4b0b-1cb5-c3a2-92efc5bb3841@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4b505afc-ae48-d8eb-f4e1-8e3f7192f73d@web.de>
Date: Mon, 7 Sep 2020 18:54:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5f9fdd59-4b0b-1cb5-c3a2-92efc5bb3841@web.de>
Content-Language: en-GB
X-Provags-ID: V03:K1:hj998AkXbfqAy5SQXrSMnMQwggzcQi7VIZgdXW5bkbk1GMUHDud
 KmCpLN20WwEUwofULL6ABpl6/ODTuWjo/CvJ3CabCz7Vo94jHP/WTnl2XdF8u+tipCGwD+4
 d/vfMXvBhNs4NuLicS/j+uH0KtdPyFSRAypL/bmzTXmTYB+fhxQzR0qwA320yUKHPEcG4UH
 o0DSBIXrgFACqtomeqTHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5743oQnFu9E=:M0U1IMP+9UGNJU5WAel+FT
 UWAW7lqAcjw0OkLV/bfq63XfR1QhZ1kWm7EiyPRwEa5vfyqe0wQq6gnkFvfpKWLtR9/LBYl6p
 iAJTDjGUp2/wGodN/AK8xmZHsFzw6E5MwoZX4TadTbInN5pOybMIef0XFRQWajimJH+/YI0Ub
 Y0jKDtdyjcLTcnS7JZIeu9oKHzDQWX3vkm5s3Nkc5t+a/8AO7InZvqdgyT142YNndQogcQpCU
 tgJdexcdKx/eRQAfzF1i8KYtnCC+A9Q9g6O8JOPTo3FP8cHkf30ATYthEVxeR/vo/tfusKySU
 GMMx+3r6UHdclOgUgzq3alWT7kmVm0SxLOcqvcgGXntn/tPxQhJkuHzuvb4Acaoian0wlReFU
 qb+WGhQmYwzJVW9NO1CX/JSPK99vXDOhcXXND6vI5xaLIUbLSav9T22WPmVkLSh8W1sbJDnff
 gatwWsfA1e8uOH6NCHQzcnXzFhYZp66ks7C/iaeFyDDwqpAyUznwuW26rhjBuZXKqdLVfhVQZ
 9RiCSWD3eyqZeZgvprwn2Vora1TQPpb3iK9bdLkB/bt7NkldHp6Ytq/gvfzIBzRR1GSgIl9CK
 x85iyiIhA52IRSxWGhaAAW7gbku27J/cLV0pledgcadeV8UaEfz3TTCskKH/ujEiGkbmWRcrq
 GQp8wqw9FkDaU5Wtw71Pep0/Mqk7UPze9daPb8uijU5wfScZeARLfesGq9E9S7cY2de6zET4P
 MtYuKUvIjprFWlKjGHNoqdYcNbyzDWIkDJD8eUagNSQcKLl0nAHXrr2M/aykfXnzZqCjwO7jO
 ktxJr33aXovKi+6rQo/R0LmUZs3C9iNh5W4iAg5ahcoWyU9IeSAi8OY2zuC2BjRyxPJPbvS4W
 Uw+x4+9AaJG/BkX1QwZRHmR6vtvoN3SQS6hKz1m3g8NRnwtePVz+fqduNGKq5vWqGJrddIasn
 jKXtM4+alBqwabX2z+YiR9pzbJ8UGoDBJsY6DWxCgioRu9iI9+EBATvBbZ08eSU+eKUCHGOlL
 65JihPoDaZGK+R/UKcWf2btBzXBqgzzx4BOirMikDpvu8qZnttiro05Hdd22MaVA0ENsPyDQi
 60nLTOeULaZfA3RzCeaailepTxa9OPJEpLA6TWhDYINVTZKWM5LD9twUCNoORD3qAS01V/Rqr
 PfxHGThy8pDs9AusU9RAVXmOlmzEwPLRnQOHFpgOG6eG7152K6FgguYN2/NJZ2Tr3DSOUu7DB
 39EXwTBRJ268nkCeBGqHxy30OH0N+5Ts3ZYW+5Q==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 07 Sep 2020 18:58:16 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 07 Sep 2020 18:54:43 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Mon, 07 Sep 2020 18:58:14 +0200
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [Cocci] =?utf-8?q?=5BPATCH_v2=5D_Coccinelle=3A_api=3A_Add_SmPL_sc?=
 =?utf-8?b?cmlwdCDigJx1c2VfZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVz?=
 =?utf-8?b?b3VyY2UuY29jY2nigJ0=?=
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 7 Sep 2020 18:38:04 +0200

Another wrapper function is available since the commit 890cc39a879906b63912482dfc41944579df2dc6
("drivers: provide devm_platform_get_and_ioremap_resource()").
Provide safe design options for the adjustment of affected source code
by the means of the semantic patch language (Coccinelle software).

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
Julia Lawall requested to omit case distinctions (disjunctions) from
the first SmPL script.
The usage of different expression metavariables for the first parameter
of function calls was too questionable for the proposed source
code transformation.


 ...vm_platform_get_and_ioremap_resource.cocci | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 scripts/coccinelle/api/use_devm_platform_get_and_ioremap_resource.cocci

diff --git a/scripts/coccinelle/api/use_devm_platform_get_and_ioremap_resource.cocci b/scripts/coccinelle/api/use_devm_platform_get_and_ioremap_resource.cocci
new file mode 100644
index 000000000000..319583716ac8
--- /dev/null
+++ b/scripts/coccinelle/api/use_devm_platform_get_and_ioremap_resource.cocci
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Simplify a function call combination by using a known wrapper function.
+//
+// Keywords: wrapper function conversion ioremap resources
+// Confidence: High
+
+virtual context, patch, report, org
+
+@display depends on context@
+expression base, device, index, resource;
+@@
+*resource = platform_get_resource(device, IORESOURCE_MEM, index);
+ base =
+*       devm_ioremap_resource
+                             (&device->dev, resource);
+
+@replacement depends on patch@
+expression base, device, index, resource;
+@@
+-resource = platform_get_resource(device, IORESOURCE_MEM, index);
+ base =
+-       devm_ioremap_resource
++       devm_platform_get_and_ioremap_resource
+                             (
+-                             &
+                               device
+-                                    ->dev
+                              ,
+-                             resource
++                             index, &resource
+                             );
+
+@or depends on org || report@
+expression base, device, index, resource;
+position p;
+@@
+ resource = platform_get_resource(device, IORESOURCE_MEM, index);
+ base = devm_ioremap_resource@p(&device->dev, resource);
+
+@script:python to_do depends on org@
+p << or.p;
+@@
+coccilib.org.print_todo(p[0], "WARNING: opportunity for devm_platform_get_and_ioremap_resource()")
+
+@script:python reporting depends on report@
+p << or.p;
+@@
+coccilib.report.print_report(p[0], "WARNING: opportunity for devm_platform_get_and_ioremap_resource()")
--
2.28.0

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
