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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACE9C433E1
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:26:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF0A20888
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpcOTYav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF0A20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04SCQ0vi007639;
	Thu, 28 May 2020 14:26:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D99E95D47;
	Thu, 28 May 2020 14:26:00 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2AC993E1D
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:25:59 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04SCPvCi008169
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:25:58 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id bh7so4592221plb.11
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 05:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tg8TivWc/r8jtttAIWUADKtf5xjAapRVbCp7eqUmDZg=;
 b=ZpcOTYavyMve6iKZyvv0doSOJMqQ1H5yjLdD/v7rd+LBMsXdPyHv26GNj6b2sbz03N
 V6LcK44HiiyCEtvNyLMzXy1386rhI78baq3WJ/J7j+Zok/Uvr/Ay40WcHvwtz/35Rn9+
 BLHGVOH1NJRTBTc4QeSBciGRaFP0PtG0k7ezw322s+g0+NMCVSMIFxDPfDiSUHRbqZ3R
 gwIRXRgZDIGBti7uXTYLN/QOCvfhbDyMKvuI3TOau0QdCnSSp2nCK5I3M+/pgrmaXbjt
 9i/KjwrUr8uYqekmKlNSz2x4hmSbp6DIBeNyUfzRTkByIDK8hCkIu93qxk37e5hRNvg5
 3urQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tg8TivWc/r8jtttAIWUADKtf5xjAapRVbCp7eqUmDZg=;
 b=Y3OfpaQT/cX9/ihEtpjBzwz8JawkAJdTXY7LUP2p7vbp+gBnr30xH+QYzdSllmZaY1
 be9M2Xq+Tf9lN7Sj5uzO5fqVe20/CS27hy67xRnJVXtALkLt6Zpmg655K77jHRGPN2zK
 owWwf+fNmA8oZEz31qmaf5Oq3j3pad7WqTcN6lyrQU+capBg0q0nclsUqneOZt31iBpA
 0DkcEaot0hJ7FNzTPMlfst04ieXTQPGC23BgZJ7ZNqOyKl0q6MkhKu14C4+/e9L/0n0D
 0Vc2U+sP1uZ/0vV226SipzoXvKo7j6gOW9rBfovVdUODYwx5856mwJUTAFEbbgpc2HJ2
 DIEA==
X-Gm-Message-State: AOAM531d9GTPPEgrbJzvnMxvORUSQslg/J2Wq68+m/5zHDAXXjZkLbLa
 OAPcwzUnXSDZ1IhOmAi3K18OMB90
X-Google-Smtp-Source: ABdhPJwcSRi2nEet8mF3iqpY2pKpFOPYpoe4AduNQIAMdsCycI7Otofo5E1U8HVYpE61s6ejytfobg==
X-Received: by 2002:a17:90b:80f:: with SMTP id
 bk15mr3633472pjb.51.1590668756753; 
 Thu, 28 May 2020 05:25:56 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2183:e360:deba:7bf4:98ef:5568])
 by smtp.gmail.com with ESMTPSA id 1sm5722888pje.26.2020.05.28.05.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 05:25:56 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 28 May 2020 17:54:23 +0530
Message-Id: <20200528122428.4212-22-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
References: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 May 2020 14:26:00 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 May 2020 14:25:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 21/25] parsing_c: visitor_c: Visit parameter
	attributes
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

As attributes are added to the parameter type, have the C AST visitor
visit these attributes as well.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/visitor_c.ml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/parsing_c/visitor_c.ml b/parsing_c/visitor_c.ml
index aaef1acc..57b5f32b 100644
--- a/parsing_c/visitor_c.ml
+++ b/parsing_c/visitor_c.ml
@@ -1929,10 +1929,15 @@ and vk_node_s = fun bigf node ->
 (* ------------------------------------------------------------------------ *)
 and vk_param_s = fun bigf param ->
   let iif ii = vk_ii_s bigf ii in
-  let {p_namei = swrapopt; p_register = (b, iib); p_type=ft} = param in
+  let
+    {p_namei = swrapopt;
+     p_register = (b, iib);
+     p_type=ft;
+     p_attr = attrs} = param in
   { p_namei = swrapopt +> Common.map_option (vk_name_s bigf);
     p_register = (b, iif iib);
     p_type = vk_type_s bigf ft;
+    p_attr = attrs +> List.map (vk_attribute_s bigf);
   }
 
 let vk_arguments_s = fun bigf args ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
