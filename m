Return-Path: <SRS0=FJ6B=7K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3B5C433DF
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:24:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1DF20888
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPoS++oA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1DF20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04SCOnsZ008244;
	Thu, 28 May 2020 14:24:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 47DC87831;
	Thu, 28 May 2020 14:24:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AEC3F782B
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:24:45 +0200 (CEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:543])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04SCOi8O022614
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:24:45 +0200 (CEST)
Received: by mail-pg1-x543.google.com with SMTP id d10so13412986pgn.4
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 05:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J6Of3e9PWPQ3II+PK6sniBNSR/brODCfwu8bVl4lcJ0=;
 b=EPoS++oAX3eVIRPSxuIE/wjnoygvZOc/U/t9lILoUd/oV53euoi5dpvL+W2rWS8GSm
 ddAgI5mFCjk93fYB7o2JUCeWMVSbazMtqSBBEc47rbyma48NAsM+0rKs3ft8Gx2xEov1
 +jKU9vCuMV47sR8mR5M3wy+oK4MFn1w5if0stGiKUWsWYRe8vjkE0OKNiZq9/zvHVPju
 puLnneaABggf6YomI9rolV4rkkA0hvYBUozy0pQDJwlouzxl3XRPUAU5LkMV6uzMU7R/
 MfcwzxW7ozpUQXC9puKrVjjyEFP0N1WvWQe5srChrlUMIodO1VxK2GLT+fId26Cqe4af
 ZcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J6Of3e9PWPQ3II+PK6sniBNSR/brODCfwu8bVl4lcJ0=;
 b=abNxio4QNPBaRt1o9s+D1oTdwzQjZ57UJKv+JiTmpBNeZlYnDW4x0oOYgN9PEDOnIZ
 Tn60b6iLNrJZI0KOyu/7hoVByG2ob8KLUl8Vp9oy83eaVxfiATDZpCFF14qZB6wbzAkc
 Wh7iGJRhxJTSmFM0/hxF6Eo/6gw/6N/g2bkA998XPXeCtCDvIwBer92uWBqHCLvFcZ6L
 3WkXWkfp0pP/d+D17pvmUK9Tpz+rKeLxBTtcSK/ASrTtrQXXRG9FH20xw2CrgZasFcAo
 q2mAzb5SqS37ycheE51g7Jqo7t07n5pf24rX8JE7oBqvrohT40OVLDyvaC79VtIUforR
 28pQ==
X-Gm-Message-State: AOAM530EPK1E8wO+UPwLRmEq9WMAUb/22tGBnqeAeXTzd5w+hxCSf+zD
 vrOc0NyLk9JYCxZZEEZQFXhMSXmC
X-Google-Smtp-Source: ABdhPJzFwNE5eqaPfxSHS0B4uXuHIDSVHGL3B933Aosl5kWYL7MvpRP6MTu4PVzPtg3/W8MI3F48TA==
X-Received: by 2002:a62:7d4d:: with SMTP id y74mr2909701pfc.286.1590668683118; 
 Thu, 28 May 2020 05:24:43 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2183:e360:deba:7bf4:98ef:5568])
 by smtp.gmail.com with ESMTPSA id 1sm5722888pje.26.2020.05.28.05.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 05:24:42 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 28 May 2020 17:54:03 +0530
Message-Id: <20200528122428.4212-2-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
References: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 May 2020 14:24:49 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 May 2020 14:24:45 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 01/25] parsing_c: parse_c: Ignore TMacroAttr and
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
