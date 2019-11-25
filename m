Return-Path: <SRS0=oxWY=ZR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9FBC432C0
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2019 19:57:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 223702071E
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2019 19:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SptTVuGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223702071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAPJvKvL006653;
	Mon, 25 Nov 2019 20:57:20 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2BA0377CC;
	Mon, 25 Nov 2019 20:57:20 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 45B8B77B5
 for <cocci@systeme.lip6.fr>; Mon, 25 Nov 2019 20:57:18 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:62e] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAPJvHri012067
 for <cocci@systeme.lip6.fr>; Mon, 25 Nov 2019 20:57:17 +0100 (CET)
Received: by mail-pl1-x62e.google.com with SMTP id k20so2492938pll.13
 for <cocci@systeme.lip6.fr>; Mon, 25 Nov 2019 11:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=nagjP51PSoa63SxGT1YAWV0qiAD6RkmEi8dz7RAXktU=;
 b=SptTVuGeizdUv3NpCPfeqxvBR5Xtld7+wjr0za9RhMbtV259TI1Df6rXx2d4iMq9BT
 4kClFRKA3wZSdF+VF22drxgtfpng/SuaepTV2PgANHtgD4Ma8z6eyeR3Kw5Rk6HliF/Y
 h5CBCDyq0EszOtTPg/mu7/GVmpAR1Dz207f6P+pOPObYVlvFNi0gCSnmAS9rfv5c5mn/
 Ff2Qk8R3rK9TMJrpxyAVz6bxtywlgMw9fofNOjKt2Z1SajWv+zX9OIa+mk3lVI5yBmpr
 cEfgIjoO5g+JwlBv5lxJq4sHLQrmPxacgyAVrV+UEsiUhz65NGtR1gsJPZuAcWK/Kzcv
 e6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=nagjP51PSoa63SxGT1YAWV0qiAD6RkmEi8dz7RAXktU=;
 b=P1BoixaO6JcjfBjayTJZNiQY0Lb38dSzzf33iSWgGEnvwq8jBRe9y1N/JqJoI4i6Ky
 cuwBvgcrAlOCmDSSbl6VlGfOup/U9flRAmmDTEfZ2X6Tgw21i7Fcj4ntuUkctW2ckJjt
 W8HrBqjV144g0UGvnpLbCSieypFtm3tMlMfTgOD+YE3kT7nSgvLyGLeSHRC7h0rbS0WF
 G3eI5oKGLAj7oY5PEmHuwDruKTvtbxsCpR9S8NTBrfwZaK9313oB7zFKKKPJTowq910D
 9VgttZpw6WLEEOUB+DfZhO1i4Dlsyufl9Oj/KlSRFB0qTmUxmlV2P5DpJfQBKDT5px6m
 fIfQ==
X-Gm-Message-State: APjAAAUnI744tDWjItqJAArLkUP4yM9ktcTJsnAH9ctbLPrsJT+ov/Jv
 jbnkl5LRLU7IDZPVTwJ8AL/ANyiTCBY=
X-Google-Smtp-Source: APXvYqxFIr4t462yCtgx+MG8zCXhDhvxexX+TwQ3Yc+WVfuIm9kBDZ4Q0vIgc4fPAQLYFPi4ahbG9Q==
X-Received: by 2002:a17:90a:9f8d:: with SMTP id
 o13mr975558pjp.88.1574711836558; 
 Mon, 25 Nov 2019 11:57:16 -0800 (PST)
Received: from [10.1.70.17] (carmd-fwm01.sierrawireless.com. [208.81.120.1])
 by smtp.gmail.com with ESMTPSA id 16sm9488173pfc.21.2019.11.25.11.57.15
 for <cocci@systeme.lip6.fr>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Nov 2019 11:57:16 -0800 (PST)
To: cocci@systeme.lip6.fr
From: David Frey <dpfrey@gmail.com>
Message-ID: <c156dbfc-8c3d-4750-fa90-2bbd11060130@gmail.com>
Date: Mon, 25 Nov 2019 11:57:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 25 Nov 2019 20:57:20 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 25 Nov 2019 20:57:17 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] Problem writing simple patch
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

Hi,

I'm trying to write a .cocci file to transform all calls to a function
"f(ex)" to something like this:

#ifdef USE_F
f(ex)
#else
g(ex)
#endif

The function has this signature:
bool f(int x);

This is the patch that I tried to use:
@@
expression ex;
@@
+#ifdef USE_F
 f(ex)
+#else
+g(ex)
+#endif


This is the result of running it:
$ spatch --show-c --sp-file test.cocci test.c
init_defs_builtins: /usr/bin/../lib/coccinelle/standard.h
plus: parse error:
  File "test.cocci", line 7, column 1, charpos = 50
  around = 'g',
  whole content = +g(ex)

What is wrong with the patch above?

Thanks,
David
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
