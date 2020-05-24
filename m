Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2BFC433E1
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:21:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA50206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrKSZXnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA50206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHKvXp024614;
	Sun, 24 May 2020 19:20:57 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F1E053DC8;
	Sun, 24 May 2020 19:20:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id ABEA93D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:20:54 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHKrCB025430
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:20:53 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id n18so7868797pfa.2
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hXCcTNHs6BcDAorV/Zh/3HZAsQrfyCEIJITUm7AsUZU=;
 b=DrKSZXnTOdb1/FZXoDnsfo+PUPplKKAFZp3NTqBQT0I56cP/Ln/AOk8/aB0TS8rlrn
 pqEmDHOSlVUjGkTjoR/PDYHIVr+h1JVhr8g3LdOyXlwA5hWrO2YDm2y/t3W/bd3vM5FI
 lj60GOJUfqhjNrEKXHsvOPvb7zhQpw2Di6P0b4BY251OEfzLHk6X3Iv5Ro2OmA5W/rC8
 gfYdJNlx4h9UkHF0BuXcYFePkMYkeDViECphuae5nWSID+/VHZCLeePnOMRDDj4/18nZ
 NJM193oegMcCHFb7DbM/Ihbc+2IMhG1FMyJZ79b/3wF4F5QFGTLnbtOl4GfdDFy8ubwp
 Py3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hXCcTNHs6BcDAorV/Zh/3HZAsQrfyCEIJITUm7AsUZU=;
 b=bHs2m0D6QbC8OcONKLdcv+7C5/1UNE3EnXT3FIhW+S9aju2Z05EQuD/Js0BSN000yE
 vU5m5nl8RYVCixGNvKzzJY+oG+vtNWeS3qifqr7t39jKTidDpYnEgD/im/f4/D5FeRNt
 BxZ1jMwAeGcyHGUr/WywvF6M79hcbpcN3PX+9dZG2FgpZHjRzVx0JYbwnXFXx/VE2wKa
 yIawIK6mW425DNmywnN145iYRmSMInkPwWd6OC5FPrlNQxqiMNDvTHexa8H44QIL4Tkw
 m7rWrzp1dH02KTSX8vr8W65MaOs4iY9umrcd1+DPVAP7wXi2vG1I0ZWwCJmizbgfY0U3
 wPfg==
X-Gm-Message-State: AOAM531PG6Mt3gd3DYuZ0O8J8hPbPkoUwzGFoFmhhOVx0hfsiF6afPvD
 yzlF/vgm4UoNE7K+80A0qe1rFxtYMbg=
X-Google-Smtp-Source: ABdhPJzM6IhC1qzRdq8ic489pMRvmQuCi55L9xxqYeylk+L4/kJjpQpSfLSwADPHMPMbKin/5XS9Kg==
X-Received: by 2002:a63:de06:: with SMTP id f6mr24034792pgg.238.1590340852324; 
 Sun, 24 May 2020 10:20:52 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:20:52 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:15 +0530
Message-Id: <20200524171935.2504-11-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:20:57 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:20:54 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 10/30] parsing_cocci: compute_lines: Reflect
	Macrodecl attributes
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

Macrodecl attributes are added to the SmPL AST. Reflect these changes in
compute_lines.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/compute_lines.ml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/parsing_cocci/compute_lines.ml b/parsing_cocci/compute_lines.ml
index 1361d842..d4124d15 100644
--- a/parsing_cocci/compute_lines.ml
+++ b/parsing_cocci/compute_lines.ml
@@ -715,19 +715,20 @@ and declaration d =
 	| Ast0.FType(ty)::_ -> mkres d res ty right
 	| Ast0.FInline(inline)::_ -> mkres d res (promote_mcode inline) right
 	| Ast0.FAttr(attr)::_ -> mkres d res (promote_mcode attr) right)
-  | Ast0.MacroDecl(stg,name,lp,args,rp,sem) ->
+  | Ast0.MacroDecl(stg,name,lp,args,rp,attr,sem) ->
       let name = ident name in
       let lp = normal_mcode lp in
       let args = dots is_exp_dots (Some(promote_mcode lp)) expression args in
       let rp = normal_mcode rp in
+      let attr = List.map normal_mcode attr in
       let sem = normal_mcode sem in
       (match stg with
 	None ->
-	  mkres d (Ast0.MacroDecl(None,name,lp,args,rp,sem))
+	  mkres d (Ast0.MacroDecl(None,name,lp,args,rp,attr,sem))
 	    name (promote_mcode sem)
       | Some x ->
 	  let stg = Some (normal_mcode x) in
-	  mkres d (Ast0.MacroDecl(stg,name,lp,args,rp,sem))
+	  mkres d (Ast0.MacroDecl(stg,name,lp,args,rp,attr,sem))
 	    (promote_mcode x) (promote_mcode sem))
   | Ast0.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem) ->
       let name = ident name in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
