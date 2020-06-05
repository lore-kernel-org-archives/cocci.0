Return-Path: <SRS0=TTUf=7S=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B85C433DF
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA85206E6
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siudvXqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA85206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 055Di8iF029631;
	Fri, 5 Jun 2020 15:44:08 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A3AEB7567;
	Fri,  5 Jun 2020 15:44:08 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E48BF3F9A
 for <cocci@systeme.lip6.fr>; Fri,  5 Jun 2020 15:44:07 +0200 (CEST)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 055Di65s008978
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 5 Jun 2020 15:44:07 +0200 (CEST)
Received: by mail-pj1-x1041.google.com with SMTP id 5so2751259pjd.0
 for <cocci@systeme.lip6.fr>; Fri, 05 Jun 2020 06:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J6Of3e9PWPQ3II+PK6sniBNSR/brODCfwu8bVl4lcJ0=;
 b=siudvXqGQ+KDYjN1rktPWGpTolpS30M+miE8JsqI1R48M8S4eQtOHmSetbd4CgMSBh
 nd+OauJkFpdbTJ7nRI69tSHeq3Y6yv5VpdTKwDjjyBonnAkTYWOgBDgZYrB+HLSQUDNW
 d50kghP8I3UpvodG4z1Ut4HFA948byCRY1q/RvhgGAVI5QsH7g7DoHciT3J3rOWGRk4e
 F9jtLYTRfsv4b3nDL16W0Eq1cbK/NJFouTYVXMmjHO4ufNeMrFn9mrcmWhdFK0ZQnbcU
 v5u67OH/UfGrtQRJquovDWVuVif+GFJsSZp8M/VT9IsUq+gluN7lz1ywoAgf9bQbZ3qb
 ieVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J6Of3e9PWPQ3II+PK6sniBNSR/brODCfwu8bVl4lcJ0=;
 b=ckSonotDzvED31LLlirOReZMWWWcc/Sd2axlxW0z5qpTap/OI5KT+7lFlTkLmhffno
 fp2ReXxDP9DryPJ6q8xOdyg3oFHM0sk7xOaS9IfKGIk0xSPfWhwYpLNGz0GUGgtkWIeP
 xZCbmdeHyi/KBRSEMIcg/fnFG8Aw/R5Sd6LINgSPl7shkUWuFHeX/u45Z/n2zs/Ha0mc
 A9DnC2n97y+MSUqw1Mgj0xJ1m7670NAmWwM5r6Vffkyd5Fs3A+WbtphzhuS41gSFeXgs
 Xbmfnb/7JW7StQSv+SWPhonprz2u3OA58bbUgo9hFGghtsxaAKf5GDfAUcJfMnEgzCGg
 SIGQ==
X-Gm-Message-State: AOAM532PmgNEYMbN9NqxuDkFIfGjduNjxPD2pSSAin1gPJx8/5TXPXrZ
 hNl/usvdSSnesZcdwNGzERD1kbo8n+E=
X-Google-Smtp-Source: ABdhPJwPzX2twxHdPI6Km1DxGN5vaf4Z+xdlb+oVMLVKcWvsATAKoK02z35oFPcdCL9L9ND/4/xhJg==
X-Received: by 2002:a17:902:bd46:: with SMTP id
 b6mr10019069plx.42.1591364645507; 
 Fri, 05 Jun 2020 06:44:05 -0700 (PDT)
Received: from localhost.localdomain ([1.38.221.125])
 by smtp.gmail.com with ESMTPSA id w186sm7861353pff.83.2020.06.05.06.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 06:44:04 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri,  5 Jun 2020 19:13:09 +0530
Message-Id: <20200605134322.15307-2-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
References: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jun 2020 15:44:08 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 05 Jun 2020 15:44:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v4 01/14] parsing_c: parse_c: Ignore TMacroAttr and
	TMacroEndAttr in passed tokens
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

Most cases in parsing_hacks do not consider attributes before or after
the token in question. So, do not pass TMacroAttr or TMacroEndAttr
tokens to parsing_hacks in the before list.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parse_c.ml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/parsing_c/parse_c.ml b/parsing_c/parse_c.ml
index 86bebf32..ef4482f5 100644
--- a/parsing_c/parse_c.ml
+++ b/parsing_c/parse_c.ml
@@ -612,13 +612,15 @@ let rec lexer_function ~pass tr = fun lexbuf ->
             | x -> x
           in
 
+          let passed_before = filter_noise 10 tr.passed_clean in
+
           let v =
 	    if !in_exec
 	    then v
 	    else
 	      Parsing_hacks.lookahead ~pass
 		(clean_for_lookahead (v::tr.rest_clean))
-		tr.passed_clean in
+		passed_before in
 
           tr.passed <- v::tr.passed;
 
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
