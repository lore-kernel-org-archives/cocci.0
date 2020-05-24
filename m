Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FC1C433DF
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:20:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8C1206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vE94AdOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8C1206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHKK2X005867;
	Sun, 24 May 2020 19:20:21 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A7EE53DC8;
	Sun, 24 May 2020 19:20:21 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3A8A43DC8
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:20:19 +0200 (CEST)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHKH6D026939
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:20:18 +0200 (CEST)
Received: by mail-pj1-x1041.google.com with SMTP id fs4so634178pjb.5
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vZTLyxSMO4D6l8LWn8/g+XmxYvohWd+GhczidP/ewsg=;
 b=vE94AdObCqFZHeiCbehkd53qYCkHHjm6XKC6KYN7E5FQLurU7JljqiD0AIwhWM3PIQ
 jdtd5hTCgGKpJ7EicgZ6jyqBynKiLn1nhG8S5J+uaaMTSV8qemmbTlzhC9pCRqG9L6Bs
 jlQjMplo+oiZMFFVbCdM8+mbicOh3UZKE5LaRPCAngqcaUaYjMMG/yDEpe7bMvi9PMmR
 4A6IXNPisJC8v+QmRvYvgMbrJdHvZ0VYbL738yTcG4J+ynERa7SAYlO1ngvFzFxzLOj0
 yFbseOEPItFX5SmDZQ++99g0PBvJoQUebsgBe8GQ5J86ojiPRyomdP3LCtZQ43eIay/o
 I9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vZTLyxSMO4D6l8LWn8/g+XmxYvohWd+GhczidP/ewsg=;
 b=RS3bTjaxZu8rmboGZfxnwsDYMSsy5VjutRk3GJtFFb+leXZ5tUsCdJMRIqDNAkEuli
 CmVqI9cZ5ztYMyeG4nrjtRll1dYJMV9eYiUvynF5a/oGtlMzDne3b3IOlOopYMiGm3Rq
 zQB6jSfiEUi95J4Hf+iV6ALbHGWjRKVRSyNFn325NcUuqGUWqU5Hvw0iG+yvKlyAHAfk
 tK8El3tftedn35Mxu/ASlUqMUeU600pX4NWa39uHn1ZrWDsKJRA93n9UE9xRL9ecQudA
 l+jYGPkNCtsTv1EI3mBv8VCVnNAK03ZJmF5/rdhLWtlNO7SI7N4GM7ZDCc+ZmglD9OPG
 9Gtg==
X-Gm-Message-State: AOAM533awB59HeYi5KztW1bD7n3z3IK8i9weo2EvrRvFvo9jSUsGrrkd
 FdvhtbHIFUxnRRdjvF68p+Pt8hgJ0j8=
X-Google-Smtp-Source: ABdhPJyCEFbCL82Wnk+8z8h3hxdhH64kNk7trIi6AJoQpGPv7+sMwwacnRRRuYZ3f4B62koDEwwgtA==
X-Received: by 2002:a17:90a:ad92:: with SMTP id
 s18mr16755197pjq.30.1590340816665; 
 Sun, 24 May 2020 10:20:16 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:20:16 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:08 +0530
Message-Id: <20200524171935.2504-4-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:20:21 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:20:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 03/30] parsing_cocci: visitor_ast0: Visit Macrodecl
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

Macrodecl attributes are added to the SmPL AST. Visit these attributes
the AST0 visitor of SmPL.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/visitor_ast0.ml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/parsing_cocci/visitor_ast0.ml b/parsing_cocci/visitor_ast0.ml
index d9e340ed..edc8ff78 100644
--- a/parsing_cocci/visitor_ast0.ml
+++ b/parsing_cocci/visitor_ast0.ml
@@ -637,15 +637,16 @@ let visitor mode bind option_default
 	    let (sem_n,sem) = string_mcode sem in
 	    (multibind [fi_n;name_n;lp1_n;params_n;va_n;rp1_n;sem_n],
 	     Ast0.FunProto(fi,name,lp1,params,va,rp1,sem))
-	| Ast0.MacroDecl(stg,name,lp,args,rp,sem) ->
+	| Ast0.MacroDecl(stg,name,lp,args,rp,attr,sem) ->
 	    let (stg_n,stg) = get_option storage_mcode stg in
 	    let (name_n,name) = ident name in
 	    let (lp_n,lp) = string_mcode lp in
 	    let (args_n,args) = expression_dots args in
 	    let (rp_n,rp) = string_mcode rp in
+	    let (attr_n,attr) = map_split_bind string_mcode attr in
 	    let (sem_n,sem) = string_mcode sem in
-	    (multibind [stg_n;name_n;lp_n;args_n;rp_n;sem_n],
-	     Ast0.MacroDecl(stg,name,lp,args,rp,sem))
+	    (multibind [stg_n;name_n;lp_n;args_n;rp_n;attr_n;sem_n],
+	     Ast0.MacroDecl(stg,name,lp,args,rp,attr,sem))
 	| Ast0.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem) ->
 	    let (stg_n,stg) = get_option storage_mcode stg in
 	    let (name_n,name) = ident name in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
