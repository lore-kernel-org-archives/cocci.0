Return-Path: <SRS0=Yx51=7L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8E4C433DF
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:08:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD382074D
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJgH/wTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD382074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04TC8b6B014967;
	Fri, 29 May 2020 14:08:37 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 958117783;
	Fri, 29 May 2020 14:08:37 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0E4395D47
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:08:36 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04TC8YAd021201
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:08:35 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id k22so1089741pls.10
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 05:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=egqE8QPOd0x0zRf1q0HdvBOn4qh0yTumMHvwgcA5GyI=;
 b=dJgH/wTmOjF1JIyfm9Am6/EVaE0PEC/FqZp5jQr+qR/Kc+4Xva+Tl21CVaWA50TcwY
 3MHbIRiFRLBhpyYfO5IKH2Kgz67w3XMhg82Qpw4XCSixIoOnRPaK4Iad00UHAwFipkPr
 nebVfFVmwMPhW5kD18UtM8wTWOntHl2fQhX18KCrTEg8QhVbUMjITDaD6ELY6j3fs68W
 Kx1vJbXUe/gkmccDdKqqypiuy8S600ln6jcTml56e10z4FYuGJ0iApfJkperNsWDw5p+
 zKZUU3HNZKyJbLKDvjRNOxzxrrrEkhbjgx8+/g5qeXmFYmJ9p8qhotk6o9E7oyOPGrug
 eE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=egqE8QPOd0x0zRf1q0HdvBOn4qh0yTumMHvwgcA5GyI=;
 b=YbQxTDHQNTJVl2oUF+CF+R6Mgboacd77JpHliOchiOC1LsLdnb6iEf3saTYb89ld7V
 q/qilEaLaeYkOXSIs6M80gnEW5abV2YoHe2Jt73Fn4rSLHrjkPxCJho13PeGlyR2GJC2
 VQbkwEAXk8Sj/xSN5BcvEBnj7V0OVj54BDjjSCr8zlhTSv86Sfyjc/KArAYlPqWAcQfJ
 B39UDWtNydbTbwjIBqhv75piYccZFyfbKpR7fPKGYRtkUJ6nNzPjm+6DMvqCfbfuY3Pl
 wnCpPDW+aqzWtknWt4GLUkaw8sEhG+bP5MeZ436Z9WAjk4JaS+Iljx7RFc6errsVV5kt
 ZpWg==
X-Gm-Message-State: AOAM5319vk7+A/o3JoiI5jXp3zLvmCCV5gxe3AngsdY5Gv1rgjpLLsPW
 iNdiZYcRAU2ccj79vEX9zGjk/qkk
X-Google-Smtp-Source: ABdhPJxEFtk2C0FMLJIOp7Sz4sQMJzP36q/z4YJRFKApRPu0Uy9W1/xGiaTBWR/dnl2UhdTwFsdpWQ==
X-Received: by 2002:a17:90a:bb8b:: with SMTP id
 v11mr9200107pjr.50.1590754113632; 
 Fri, 29 May 2020 05:08:33 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:694:e576:19d1:a79b:707d:59f2])
 by smtp.gmail.com with ESMTPSA id dw13sm7975161pjb.40.2020.05.29.05.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:08:33 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 29 May 2020 17:36:34 +0530
Message-Id: <20200529120703.31145-5-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
References: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 May 2020 14:08:37 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 May 2020 14:08:35 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 04/32] parsing_cocci: visitor_ast0: Visit cast
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

Cast attributes are added to AST0 of SmPL. Visit these attributes in the
AST0 visitor of SmPL.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/visitor_ast0.ml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/visitor_ast0.ml b/parsing_cocci/visitor_ast0.ml
index d6feccb7..0a7068b7 100644
--- a/parsing_cocci/visitor_ast0.ml
+++ b/parsing_cocci/visitor_ast0.ml
@@ -184,12 +184,14 @@ let visitor mode bind option_default
 	    let (ar_n,ar) = string_mcode ar in
 	    let (field_n,field) = ident field in
 	    (multibind [exp_n;ar_n;field_n], Ast0.RecordPtAccess(exp,ar,field))
-	| Ast0.Cast(lp,ty,rp,exp) ->
+	| Ast0.Cast(lp,ty,attr,rp,exp) ->
 	    let (lp_n,lp) = string_mcode lp in
 	    let (ty_n,ty) = typeC ty in
+	    let (attr_n,attr) = map_split_bind string_mcode attr in
 	    let (rp_n,rp) = string_mcode rp in
 	    let (exp_n,exp) = expression exp in
-	    (multibind [lp_n;ty_n;rp_n;exp_n], Ast0.Cast(lp,ty,rp,exp))
+            (multibind [lp_n;ty_n;attr_n;rp_n;exp_n],
+             Ast0.Cast(lp,ty,attr,rp,exp))
 	| Ast0.SizeOfExpr(szf,exp) ->
 	    let (szf_n,szf) = string_mcode szf in
 	    let (exp_n,exp) = expression exp in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
