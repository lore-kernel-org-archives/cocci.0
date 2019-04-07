Return-Path: <SRS0=K+oe=SJ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F671C10F0E
	for <cocci@archiver.kernel.org>; Sun,  7 Apr 2019 18:49:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B0E720896
	for <cocci@archiver.kernel.org>; Sun,  7 Apr 2019 18:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZGeuHRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0E720896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x37InIc4029970
          ; Sun, 7 Apr 2019 20:49:18 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DAA917704;
	Sun,  7 Apr 2019 20:49:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DDF3E7673
 for <cocci@systeme.lip6.fr>; Sun,  7 Apr 2019 20:49:15 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:431] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x37InEBU016523
 for <cocci@systeme.lip6.fr>; Sun, 7 Apr 2019 20:49:14 +0200 (CEST)
X-pt: isis.lip6.fr
Received: by mail-pf1-x431.google.com with SMTP id i17so3145800pfo.6
 for <cocci@systeme.lip6.fr>; Sun, 07 Apr 2019 11:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:to:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=m4bXGKzP/iZslBKQ2auZMVB62Zy0Orltv5PNrLM6jrg=;
 b=PZGeuHROo7W8vkXtxKHSckwcrkkBh4+fRR9Bs68DDyj0HJrhYWeZm+iOItZP13VBfa
 uRVFwExW2s8OTnVJ+KHQ8xw3ZTOCn0680XNPGF3YU3RRf88zkAJlycDPtC7Xf1AKkLH3
 iBhvDOJEz3LEA/+jsN4+Wd+B1MxPxdtsdXXhrSgV5eQpE/ll8G0Kyt10pa6IzenGp52+
 GdYCQzpbs3aVay6H9W2ewh70P2bLfCiGgdRwLoGbmW0C5tnLZf5GGM/qGJDgTNmk+3VE
 vBNFKY6mOqcNrjkC9e5a7T+5+hAjDQMQIG2fPuiiEOqfuECia/3Gs5vxxvzqFgV/v8WS
 TUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:to:from:subject:message-id:date
 :user-agent:mime-version:content-language:content-transfer-encoding;
 bh=m4bXGKzP/iZslBKQ2auZMVB62Zy0Orltv5PNrLM6jrg=;
 b=CqzMCGCXKqhFlIUm3O1RcPK6/GZn7NuRcJxl2lCkVGyQZbAu7JYlIeUQU/FgT9hUAA
 tUqM+PSOWGTQ43WqdFMeNQl0O0wWMFiuhptnzkSuLMuqW8AeVse75FAOYqgUxZCWbdAK
 cpWd+lz+e/Ev9YR84KV/QSMHTfdCo+l2NneeP5s4QTHgvxMXlP8b2nE9zAy/pj0wmKhh
 DuskbbDUSFHQRhNM8bR3d0S2bZpbNR8aYDw3x6DCNkOQt9ofJAYiPp/hSc9H0OcVA9mI
 ouWa3CJTZm7r8Znk7Dyt0PG6C/y3rZzXAD6eqf8pSXgCrjHEEXHoX8uXMRYCQ5V1fy+z
 RXEA==
X-Gm-Message-State: APjAAAXJE6qZb3TvB3Aa77AWKk2MiaThl+nB6EwLGV7Egc1HqR8xHLQG
 TkBJ9tIraFiOTei3wd3kPpoNPMpd
X-Google-Smtp-Source: APXvYqzLbPQsWtCC3r2+mVc96P/4s6+JlTiNRA9CegY+vKveMrr6dKekkq52Tyhgk7QQOWF3lk+y9w==
X-Received: by 2002:a62:604:: with SMTP id 4mr25693436pfg.38.1554662953535;
 Sun, 07 Apr 2019 11:49:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 n82sm44961212pfi.63.2019.04.07.11.49.11 for <cocci@systeme.lip6.fr>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 Apr 2019 11:49:12 -0700 (PDT)
To: cocci@systeme.lip6.fr
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <4a22aba7-4983-3f17-a51e-7ad6d4f3eac2@roeck-us.net>
Date: Sun, 7 Apr 2019 11:49:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 07 Apr 2019 20:49:20 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 07 Apr 2019 20:49:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] ormatting problems when introducing a function with
	coccinelle
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Hi Coccinelle experts,

I am trying to introduce a new function with coccinelle.

The semantic patch is something like

@devm depends on prb@
identifier r.initfn;
identifier fname.clkfunc;
@@
+ static void clkfunc(void *data) { clk_disable_unprepare(data); }
   initfn(...) { ... }

This works, but the resulting output is always

+static void armada_clk_disable_unprepare(void *data) {
+       clk_disable_unprepare(data);
+}
+
  static int armada_37xx_wdt_probe(struct platform_device *pdev)

meaning the opening '{' is in the same line as the function declaration.
It doesn't matter if I provide the function in a single line or
in multiple lines. It also doesn't matter if I try to manipulate
the function afterwards. The output looks always the same.

Is there a way to tell coccinelle that it should generate

+static void armada_clk_disable_unprepare(void *data)
+{
+       clk_disable_unprepare(data);
+}
+
  static int armada_37xx_wdt_probe(struct platform_device *pdev)

instead ?

Thanks,
Guenter
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
