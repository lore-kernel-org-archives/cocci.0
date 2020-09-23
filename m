Return-Path: <SRS0=fIkn=DB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B38C4363D
	for <cocci@archiver.kernel.org>; Thu, 24 Sep 2020 12:54:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA56F20708
	for <cocci@archiver.kernel.org>; Thu, 24 Sep 2020 12:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Bq+bpKmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA56F20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08OCrnLN010923;
	Thu, 24 Sep 2020 14:53:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5F1BB778D;
	Thu, 24 Sep 2020 14:53:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A7A585F8F
 for <cocci@systeme.lip6.fr>; Wed, 23 Sep 2020 19:00:37 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08NH0ZFE010244;
 Wed, 23 Sep 2020 19:00:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1600880420;
 bh=HIB6ACSShB4DcEeM+ykjDxPf//JC6kKqOqPKnr0Dh90=;
 h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
 b=Bq+bpKmZYAcGlwcsXJObJbBSmpxrJoXejdb+bLii5454mih8Q2wdzfzkbWaKwtP5z
 JAV2EFU31Myoq1DrHzHomIZ0JGryyoFqDU5UUZpcwW7uif64FsupDSJ1NhQfE1fFLL
 wNtP0SC61ZR/d7sBKUR5b1ZOKZPlF7C1FaLscY14=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.138.166]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ls9F9-1kS1Wd0TUt-013riW; Wed, 23
 Sep 2020 19:00:20 +0200
To: Coccinelle <cocci@systeme.lip6.fr>, Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix
 <nicolas.palix@imag.fr>,
        Stephen Boyd <swboyd@chromium.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <dbb7be9c-788e-c5bd-b4b2-d709e3bd5e8b@web.de>
Date: Wed, 23 Sep 2020 19:00:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:88QIFrrRdMUoCDyB4bETW5GnjhmQidSs5SdetizH/soenqCT9O2
 6UE9VNxj5tIh/IRzG20eYN/DG1guxS/CJlwmQj+DDweYJi86R9WRbUUk1fBI9G78V5IY9kd
 X68HGejyBNuY5jHjhw5I5aPisEIZ5uQzTI5pgK57PjEG634onNITqi0DVCmLgZOS9v38GOp
 Jphz1n8neCuSZDWtFhM5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2jzmdMn/uSY=:pH8lEfUYHJ4GHwpF7siR5c
 Tt+1/HVswby359FO88cnlkWiHvVEcXQmPOIqfAtuijAYGyOYElHrjZ9gWivbcn7g4F9U9YzdK
 1bPpw80yrvEvhmbVIhwkkn/dcYj2aHpHO0cBH6LpehKn6rAY3/ZYuatij5dovUWeczKE0vw6Q
 nF4hqtxVcPuJK/11RW/jiKoOVToXrQR1KWZ3EregK1gJi1qaNfNfAklimpMO69e1pWfKM9z0m
 t1VNeEM9BEHeg8j7HRxDaUZXUwEDTXTpM5RtnNxg+G2P395bTYHhr4Eti6dJOtWakeUcVilSl
 dV/5fMv7DP2wayw1c1CXRCTMV6L0EKTrS09KC0Lqg+ZlGVprWdGE8uJt3dtFFrv267+q48HIE
 g68O8md/CPhGfpitNtXRhmVadIwJUJIaHkGQvD4YHJsiiDDs1Y2frN29LMI1s2EF/xbp+6u+B
 1VXPRUaQMu2vHN0y0J7D/fzxfgwWFIX9s2UPNDsb++VuBG4JNghQ1vxX3WwxoJBD0MX9174ZT
 +DB+FTn5JXp1ifSxZQGpH3sSBXshKeg3HS/xYWCrfLQWwQvvbQCUV4irh1J1k2cMo5U1Z7s2z
 jmN4Gl8BrD8XHkVyre0mQsT8Wkp1E8Y/cBgmLzykTtxBsF7Bopf7pv9Jd19ebTyDQy9Duf8dp
 kPTbsl6x3L68uXv1JkobDu36xRGpprs7vPg0RC7+Vte3+YmPXR7DUf0/v/hgIp8Uh3GDmOkvQ
 7cLZzLYGNLXQS66GiDXHWImiUHjaX7RnanTlv0sTYh8y3lmLByfFeCsP1JyDNXmTbZrnhDuFq
 st/cvyx8g4nwnyH3w1hs1NhR+D53vApm9u5Q+e0iuCbivo+vHgGzFAl5RKF0vwdMTq0LLy3Bx
 mctpdzwec/2ObPlyzJrv330eQ6foKfcErpO+rQZzDJ0KT2DvbhtVLa2Ru4BGcNkoBCqABn1DR
 8iiiWRA0P+uRgOcablGe88zOW4qQ4PACqDhqo9seWRMMnzbUURLiuBG7m8sxx3r5RaTMYpG1a
 CMoms9bIPY0fGc7PfQPlweF7n5DQU252Q07TpxqxuxrxQHa/EcN/DKZu+o6wV8UjiM04sRBLY
 6/m18Nsw0KozFcrx2w0ZFo9wovnf+zZVoHEPm9Yfi+uWg41Pl6xkURPplPml1PsSe7l47qmxv
 Q6tuCIzYNNLpgCO8yRTW405zOQT7iAqsyZCSZTPxIsYMD0gFyPnX02rb3dHYTxxIlNNzoj3KJ
 12TSAdHof12uEuWrVnqn65gaJsnAA9i4LP0dI1g==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 24 Sep 2020 14:53:49 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 23 Sep 2020 19:00:36 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Thu, 24 Sep 2020 14:53:48 +0200
Cc: Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [Cocci] =?utf-8?q?=5BPATCH=5D_Coccinelle=3A_api=3A_Add_SmPL_scrip?=
 =?utf-8?b?dCDigJx1c2VfcGxhdGZvcm1fZ2V0X2lycS5jb2NjaeKAnQ==?=
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
Date: Wed, 23 Sep 2020 18:30:25 +0200

A wrapper function is available since the commit 7723f4c5ecdb8d832f049f8483beb0d1081cedf6
("driver core: platform: Add an error message to platform_get_irq*()").
Provide design options for the adjustment of affected source code
by the means of the semantic patch language (Coccinelle software).

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 .../coccinelle/api/use_platform_get_irq.cocci | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 scripts/coccinelle/api/use_platform_get_irq.cocci

diff --git a/scripts/coccinelle/api/use_platform_get_irq.cocci b/scripts/coccinelle/api/use_platform_get_irq.cocci
new file mode 100644
index 000000000000..0a0b27a3cd1a
--- /dev/null
+++ b/scripts/coccinelle/api/use_platform_get_irq.cocci
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Simplify a function call combination by using a known wrapper function.
+//
+// Keywords: wrapper function conversion IRQ resources
+// Confidence: High
+// Options: --no-includes --include-headers
+
+virtual context, patch, report, org
+
+@depends on context@
+expression device, error_code, index, irq, resource, x;
+identifier ri;
+type t;
+@@
+(
+*resource = platform_get_resource(device, IORESOURCE_IRQ, index);
+*if (resource == NULL)
+*{
+*   dev_err(&device->dev, ...);
+*   return error_code;
+*}
+ irq =
+*      resource->start
+ ;
+|
+*t ri = platform_get_resource(device, IORESOURCE_IRQ, index);
+ ... when != ri
+     when != device = x
+*if (ri == NULL)
+*{
+*   dev_err(&device->dev, ...);
+*   return error_code;
+*}
+ irq =
+*      ri->start
+ ;
+)
+
+@depends on patch@
+expression device, error_code, index, irq, resource, x;
+identifier ri;
+type t;
+@@
+(
+-resource = platform_get_resource(device, IORESOURCE_IRQ, index);
+-if (resource == NULL)
+-{
+-   dev_err(&device->dev, ...);
+-   return error_code;
+-}
+ irq =
+-      resource->start
++      platform_get_irq(device, index)
+ ;
++if (irq < 0)
++   return irq;
+|
+-t ri = platform_get_resource(device, IORESOURCE_IRQ, index);
+ ... when != ri
+     when != device = x
+-if (ri == NULL)
+-{
+-   dev_err(&device->dev, ...);
+-   return error_code;
+-}
+ irq =
+-      ri->start
++      platform_get_irq(device, index)
+ ;
++if (irq < 0)
++   return irq;
+)
+
+@or depends on org || report@
+expression device, error_code, index, irq, resource, x;
+identifier ri;
+position p;
+type t;
+@@
+(resource = platform_get_resource(device, IORESOURCE_IRQ, index);
+ if (resource == NULL)
+ {
+    dev_err(&device->dev, ...);
+    return error_code;
+ }
+ irq = resource->start@p;
+|
+ t ri = platform_get_resource(device, IORESOURCE_IRQ, index);
+ ... when != ri
+     when != device = x
+ if (ri == NULL)
+ {
+    dev_err(&device->dev, ...);
+    return error_code;
+ }
+ irq = ri->start@p;
+)
+
+@script:python depends on org@
+p << or.p;
+@@
+coccilib.org.print_todo(p[0], "WARNING: opportunity for platform_get_irq()")
+
+@script:python depends on report@
+p << or.p;
+@@
+coccilib.report.print_report(p[0], "WARNING: opportunity for platform_get_irq()")
--
2.28.0

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
