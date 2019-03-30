Return-Path: <SRS0=8gHk=SB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057B2C43381
	for <cocci@archiver.kernel.org>; Sat, 30 Mar 2019 22:24:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E0EA2183F
	for <cocci@archiver.kernel.org>; Sat, 30 Mar 2019 22:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAujq2tO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0EA2183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2UMOGHI014366
          ; Sat, 30 Mar 2019 23:24:16 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C5B0F771A;
	Sat, 30 Mar 2019 23:24:16 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5E4D07719
 for <cocci@systeme.lip6.fr>; Sat, 30 Mar 2019 23:24:15 +0100 (CET)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:444] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2UMODB4012063
 for <cocci@systeme.lip6.fr>; Sat, 30 Mar 2019 23:24:14 +0100 (CET)
X-pt: isis.lip6.fr
Received: by mail-pf1-x444.google.com with SMTP id e24so2684365pfi.12
 for <cocci@systeme.lip6.fr>; Sat, 30 Mar 2019 15:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=nOWWSS9n1Clj3/e/4InRMcwdNEnCbaaRbAmDyLoVbiQ=;
 b=sAujq2tONgK0WW7XwZubEdvdomBrCKrkAcaURGyH3DlWGu19qKXFkydWH1pwWRXDf4
 T+/w68f64AZK2/n9l7LNQZXbaicnG6xl4L0Xhzf+aXZ2kTL+GHT3q9SqI28TZlB3MyAJ
 2dQjxlsPjta0MtX2pi6ot0nKj9rMtoxuPOCghFcHa2s9H9XiFWRtb4D/ZrZ69qzVEgh2
 riUQnAAaz/VZgnE3iXvRl5elk8S4knuaYRuLQrffEFQmYnpeRYZ75hrQyIMNQWcOWFc4
 Ixmayd3bG3L8SozC71jPIOIIdkhBXh18GpM/xzks/rWJGRDVdi4ndyIW27g9VQ8KQgzB
 8MhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:subject:message-id
 :mime-version:content-disposition:user-agent;
 bh=nOWWSS9n1Clj3/e/4InRMcwdNEnCbaaRbAmDyLoVbiQ=;
 b=aOVavjil2nEVlDJhe6bvb2V5WimFNS3a4ARyG25BLW1lJ3kKo/VyVJkMJTExvEI3RN
 yAWrbUyrTUxMkfUgTgDV6rYanUPoWWI5xaSYePdSLrmxGVfFGy1rylZylYSOZSELMSwO
 mtJemA60EEyAsZiUlWs7FieNt2FNvtco7Op0T6OwUXrc1DRxBBrmg28jURhQVtYwMEuO
 UnvUZTOyljYEanXr4Nv37Ob9r0avFBV5ZCs2Jc9g5mwVD4x7Sg7YQXussvbpV3e19pey
 rD5y5mANcCccVcSpZ3u/Lme0LGPVUi7ZQ5Z+3qL7RRYFzpBEAiH9HqkVGf96xVO7WCzv
 631g==
X-Gm-Message-State: APjAAAXXs4zKgZX4LlTvnwFJvlY/USF4RpmSuhiJUJkLpcL5GxXbufU8
 2fA0R8SeggU0gPwkAzez1yNjiSzT
X-Google-Smtp-Source: APXvYqzErfQXWs8ffyEnhnxBixoIZOb/bCmgMnVcuSx9RwfRw7UoBTKpVF/2hsoF5jjZu0HiJLKQWQ==
X-Received: by 2002:a62:e706:: with SMTP id s6mr35357071pfh.80.1553984652453; 
 Sat, 30 Mar 2019 15:24:12 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id a13sm6842875pgw.91.2019.03.30.15.24.10
 for <cocci@systeme.lip6.fr>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 30 Mar 2019 15:24:11 -0700 (PDT)
Date: Sat, 30 Mar 2019 15:24:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: cocci@systeme.lip6.fr
Message-ID: <20190330222410.GA27158@roeck-us.net>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 30 Mar 2019 23:24:17 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 30 Mar 2019 23:24:14 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] A complex set of rules: can it be done ?
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

Hi Coccinelle experts,

is it possible to define a set of rules to automate the conversion done
in the attached patch ? I tried doing it myself, but did'nt get anywhere.

Thanks,
Guenter

---
From 37f506439c184e930afda2ff82c3e207e0ac5d27 Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 29 Mar 2019 13:26:40 -0700
Subject: [PATCH] hwmon: (nct7904) Use new HWMON_CHANNEL_INFO() macro

The new macro simplifies the code, reduces the likelihood of errors,
and makes the code easier to read.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct7904.c | 128 +++++++++++++++++-------------------------------
 1 file changed, 46 insertions(+), 82 deletions(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 82c7de7b4639..04516789b070 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -400,89 +400,53 @@ static int nct7904_detect(struct i2c_client *client,
 	return 0;
 }
 
-static const u32 nct7904_in_config[] = {
-	HWMON_I_INPUT,                  /* dummy, skipped in is_visible */
-	HWMON_I_INPUT,
-	HWMON_I_INPUT,
-	HWMON_I_INPUT,
-	HWMON_I_INPUT,
-	HWMON_I_INPUT,
-	HWMON_I_INPUT,
-	HWMON_I_INPUT,
-	HWMON_I_INPUT,
-	HWMON_I_INPUT,
-	HWMON_I_INPUT,
-	HWMON_I_INPUT,
-	HWMON_I_INPUT,
-	HWMON_I_INPUT,
-	HWMON_I_INPUT,
-	HWMON_I_INPUT,
-	HWMON_I_INPUT,
-	HWMON_I_INPUT,
-	HWMON_I_INPUT,
-	HWMON_I_INPUT,
-	HWMON_I_INPUT,
-	0
-};
-
-static const struct hwmon_channel_info nct7904_in = {
-	.type = hwmon_in,
-	.config = nct7904_in_config,
-};
-
-static const u32 nct7904_fan_config[] = {
-	HWMON_F_INPUT,
-	HWMON_F_INPUT,
-	HWMON_F_INPUT,
-	HWMON_F_INPUT,
-	HWMON_F_INPUT,
-	HWMON_F_INPUT,
-	HWMON_F_INPUT,
-	HWMON_F_INPUT,
-	0
-};
-
-static const struct hwmon_channel_info nct7904_fan = {
-	.type = hwmon_fan,
-	.config = nct7904_fan_config,
-};
-
-static const u32 nct7904_pwm_config[] = {
-	HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
-	HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
-	HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
-	HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
-	0
-};
-
-static const struct hwmon_channel_info nct7904_pwm = {
-	.type = hwmon_pwm,
-	.config = nct7904_pwm_config,
-};
-
-static const u32 nct7904_temp_config[] = {
-	HWMON_T_INPUT,
-	HWMON_T_INPUT,
-	HWMON_T_INPUT,
-	HWMON_T_INPUT,
-	HWMON_T_INPUT,
-	HWMON_T_INPUT,
-	HWMON_T_INPUT,
-	HWMON_T_INPUT,
-	HWMON_T_INPUT,
-	0
-};
-
-static const struct hwmon_channel_info nct7904_temp = {
-	.type = hwmon_temp,
-	.config = nct7904_temp_config,
-};
-
 static const struct hwmon_channel_info *nct7904_info[] = {
-	&nct7904_in,
-	&nct7904_fan,
-	&nct7904_pwm,
-	&nct7904_temp,
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT, /* dummy, skipped in is_visible */
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT),
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT),
+	HWMON_CHANNEL_INFO(pwm,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT),
 	NULL
 };
 
-- 
2.7.4



_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
