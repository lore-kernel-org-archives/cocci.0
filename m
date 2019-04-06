Return-Path: <SRS0=uZfY=SI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663D2C10F06
	for <cocci@archiver.kernel.org>; Sat,  6 Apr 2019 06:11:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908BF21855
	for <cocci@archiver.kernel.org>; Sat,  6 Apr 2019 06:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN24TkZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908BF21855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x366BUSe016256
          ; Sat, 6 Apr 2019 08:11:30 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 108D77720;
	Sat,  6 Apr 2019 08:11:30 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A1380771E
 for <cocci@systeme.lip6.fr>; Sat,  6 Apr 2019 08:11:28 +0200 (CEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:443] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x366BQOT002376
 for <cocci@systeme.lip6.fr>; Sat, 6 Apr 2019 08:11:26 +0200 (CEST)
X-pt: isis.lip6.fr
Received: by mail-pf1-x443.google.com with SMTP id z5so4461563pfn.3
 for <cocci@systeme.lip6.fr>; Fri, 05 Apr 2019 23:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=VMs1CYpo/0RK1Sdao0S2WvIYnQ1BE7whDsp5LVr2ATk=;
 b=dN24TkZUWfoRt9jt2rWs73PCWNngiDsO3W78dJf9BuvAh+k+n1vSfkmtoLT59hmG66
 jVIXxSDJZAi/iFbz1wNNREEX788sFhvvHIy1nZAi/4bN7q3otkxkK50z/FexBdV15QYj
 W8yCEta13aSBgeK5l/F4RzoGqfDtRdzmqJC62lsjHsc/2EzatzjU3vo34WCEY/g2Zeog
 8RJVy97tpBKbZI9nYRiFG/L+OBkm73VrXdJg1y2AgizkK2A4EXjjznRJ0WCmFu+utdXp
 284eq3tUrg04WO95cPA31e1ZDPZ7IzFCNFqLrADEVT4BmQG++fW8iYY4u/3BZWF/2vcL
 BAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=VMs1CYpo/0RK1Sdao0S2WvIYnQ1BE7whDsp5LVr2ATk=;
 b=IFjKxXXBF0YaM+S/AziMcgLtxrKnwZVPtAmQ76VupkUEpK7eA5f8kDA5ik5lNVgPSy
 xIMuxrwqc5wn9qfYrE/FaHel0yh5sOqODSgGQcwQYilMQyCFdJ38bt+V4ZKZbLvtO6EM
 j0Kh2GyUrYnM+7RigVMjwbgJDrC5q33beLkUh/MWxkNK4UnY5Vro5oW4pJLraNM9cZNr
 FixH95lBIVoafiasMtTvKq3H0u7vKGmIcSRbfVTd+ojsFC3Eul9Tc2yb+fDbxwxfW8Q/
 TMg19dkdkLQ0xTGcEzU+8kXAYprvUD/M1xj/dvzqaxc3+WyQNIv81bnUHqos5Ou7ME4d
 KHxA==
X-Gm-Message-State: APjAAAUeih7VHRfoJtcOVVhZCcZhRP7U7SiUr2bKKqqtWExCgKjszif2
 uJ2RfqvFqW00tC0HB5SVL7Y=
X-Google-Smtp-Source: APXvYqwOqmaM6QXzclfbheEPWRdFL1BoEsuTei0JLiogK8DIIKN89ISXs71/lIHmUqGGh4c2T19QqQ==
X-Received: by 2002:a63:4f1c:: with SMTP id d28mr15751008pgb.144.1554531085129; 
 Fri, 05 Apr 2019 23:11:25 -0700 (PDT)
Received: from localhost.localdomain ([103.77.40.121])
 by smtp.gmail.com with ESMTPSA id m25sm33069517pfa.175.2019.04.05.23.11.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2019 23:11:24 -0700 (PDT)
From: Himanshu Jha <himanshujha199640@gmail.com>
To: yamada.masahiro@socionext.com, Julia.Lawall@lip6.fr
Date: Sat,  6 Apr 2019 11:41:12 +0530
Message-Id: <20190406061112.31620-1-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 06 Apr 2019 08:11:30 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 06 Apr 2019 08:11:26 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: kernel-janitors@vger.kernel.org, michal.lkml@markovi.net,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        bgolaszewski@baylibre.com, andriy.shevchenko@linux.intel.com,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH] coccinelle: api: add devm_platform_ioremap_resource
	script
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Use recently introduced devm_platform_ioremap_resource
helper which wraps platform_get_resource() and
devm_ioremap_resource() together. This helps produce much
cleaner code while removing local `struct resource` declaration.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---

Tree wide changes has been tested through 0-day test service
with build success.

BUILD SUCCESS 74ebaaca5d14d3d9b03e911f0b4995b78a4d60f0
tree/branch: https://github.com/himanshujha199640/linux-next  20190401-devm_platform_ioremap_resource-final
branch HEAD: 74ebaaca5d14d3d9b03e911f0b4995b78a4d60f0  Coccinelle: api: Add devm_platform_ioremap_resource.cocci

elapsed time: 385m
configs tested: 162


Stats:
916 files changed, 1028 insertions(+), 2921 deletions(-)

Note: cases where the `struct resource *res` variable is
used subsequently in the function have been ignored out because
those cases produce:

eg., drivers/bus/da8xx-mstpri.c

warning: 'res' may be used uninitialized in this function [-Wmaybe-uninitialized]

due to: 
	if (prio_descr->reg + sizeof(u32) > resource_size(res)) {

which seems correct as `res` isn't initialized in the scope of
the function(da8xx_mstpri_probe) and instead initialized inside:

   void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
                                                unsigned int index)
   {
           struct resource *res;
   
           res = platform_get_resource(pdev, IORESOURCE_MEM, index);
           return devm_ioremap_resource(&pdev->dev, res);
   }
   EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);


 .../api/devm_platform_ioremap_resource.cocci  | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 scripts/coccinelle/api/devm_platform_ioremap_resource.cocci

diff --git a/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci b/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
new file mode 100644
index 000000000000..a28274af14df
--- /dev/null
+++ b/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
@@ -0,0 +1,63 @@
+/// Use devm_platform_ioremap_resource helper which wraps
+/// platform_get_resource() and devm_ioremap_resource() together.
+///
+// Confidence: High
+// Copyright: (C) 2019 Himanshu Jha GPLv2.
+// Copyright: (C) 2019 Julia Lawall, Inria/LIP6. GPLv2.
+// Keywords: platform_get_resource, devm_ioremap_resource,
+// Keywords: devm_platform_ioremap_resource
+
+virtual patch
+virtual report
+
+@r depends on patch && !report@
+expression e1, e2, arg1, arg2, arg3, arg4;
+identifier id;
+@@
+
+(
+- id = platform_get_resource(arg1, arg2, arg3);
+|
+- struct resource *id = platform_get_resource(arg1, arg2, arg3);
+)
+  ... when != id
+- e1 = devm_ioremap_resource(arg4, id);
++ e1 = devm_platform_ioremap_resource(arg1, arg3);
+  ... when != id
+? id = e2
+
+@r1 depends on patch && !report@
+identifier r.id;
+type T;
+@@
+
+- T *id;
+  ...when != id
+
+// ----------------------------------------------------------------------------
+
+@r2 depends on report && !patch@
+identifier id;
+expression e1, e2, arg1, arg2, arg3, arg4;
+position j0;
+@@
+
+(
+  id = platform_get_resource(arg1, arg2, arg3);
+|
+  struct resource *id = platform_get_resource(arg1, arg2, arg3);
+)
+  ... when != id
+  e1@j0 = devm_ioremap_resource(arg4, id);
+  ... when != id
+? id = e2
+
+// ----------------------------------------------------------------------------
+
+@script:python depends on report && !patch@
+e1 << r2.e1;
+j0 << r2.j0;
+@@
+
+msg = "WARNING: Use devm_platform_ioremap_resource for %s" % (e1)
+coccilib.report.print_report(j0[0], msg)
-- 
2.17.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
