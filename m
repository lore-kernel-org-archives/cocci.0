Return-Path: <SRS0=O8dQ=7N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7CDC433E0
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F92F206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhetpzgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F92F206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFRIP0026595;
	Sun, 31 May 2020 17:27:18 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 149077837;
	Sun, 31 May 2020 17:27:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 86ABB7830
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:15 +0200 (CEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:543])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFRDTb001732
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:14 +0200 (CEST)
Received: by mail-pg1-x543.google.com with SMTP id w20so2329265pga.6
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B6uyJjgT2TCfSQBuoRToc4YmknOs+ptJn+8KC1M7YEo=;
 b=qhetpzgphCUbCXvaCxowOh8K5ACKhZRBinqrLTPVuf6yX6b+7o3fuzAYxYOcPJlAvS
 miiNaNvEnYjZE23Fu7xJCF9tcpcDvIlF3edxyp5PcAu86gHkvEUD7ORj8B1Yu0b/OjpN
 lXUe4kVMfl9PN3mC/67+bnOwV4t0y8Yehs6JfJ1G0PtbcduHpTVGyin+9o8yALoox3wy
 W6FcVlpdYLPdwM9YdhyxTO8gOAqOCZuG4x88qw7+dA374BPBq8w1sSS1yIiEizAxTy5V
 5hEu9v3KfGigN0w0AL8cSCGpg5fTL1w9t/x/XQ0XOeZo7s2CRFJqsY6h5GFI+WQnHP+5
 tVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B6uyJjgT2TCfSQBuoRToc4YmknOs+ptJn+8KC1M7YEo=;
 b=odoRslOJVlQDeAEIJ33ctkDKXMgnEtqHiRNRR8+62H79t7hJIYElysyeNaPtLa5njA
 9zbeK280Wdg9xtGs6KgxL+N2WwUkjtMRyaJ0qqT1d0f9AbpvHUnd4u8Pf2BRIDNZ4ZGV
 4XwbgkScT24sbtiqerhjfq86tWsy3b5ojye+Qyq2ssL5CabJug8+sde1pj5v4ztNlr5/
 H59p+gtVFV3SHo4Pp/NgRRmq0d4Rq+TQh6o3jGcUETBbaz6dVQZttnMpVZk/5+/U8sIX
 ycBZYuVgb4Xh0G1M+BD76LxJMJNKqaDYb6Er3+RGe9m3+bSn8yDnGOU61Exozme+Nv9U
 YKkg==
X-Gm-Message-State: AOAM531veyxBl95O6HbgShPAqlBELQE3Y/u3h/rQ3uoOZ7lLUazutYq/
 SYYRyFvLeTFEkkii7WAxojvSyDkte2c=
X-Google-Smtp-Source: ABdhPJy6MJQq4NaqepNG6Zl9cQfZMQ3Ghx8lKWgYD9/m/ElhijJYRZxKg8jH8+26bwR071P3xFGuDQ==
X-Received: by 2002:a63:7e5a:: with SMTP id o26mr16272617pgn.134.1590938833092; 
 Sun, 31 May 2020 08:27:13 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:27:12 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:55:57 +0530
Message-Id: <20200531152621.2886-4-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:27:18 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:27:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 03/27] parsing_cocci: visitor_ast0: Visit struct end
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

Struct end attributes are added to AST0 of SmPL. Visit these attributes
in the AST0 visitor.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/visitor_ast0.ml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/visitor_ast0.ml b/parsing_cocci/visitor_ast0.ml
index 63241ffd..87b2b3f5 100644
--- a/parsing_cocci/visitor_ast0.ml
+++ b/parsing_cocci/visitor_ast0.ml
@@ -660,10 +660,11 @@ let visitor mode bind option_default
 	    let (sem_n,sem) = string_mcode sem in
 	    (multibind [stg_n;name_n;lp_n;args_n;rp_n;eq_n;ini_n;sem_n],
 	     Ast0.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem))
-	| Ast0.TyDecl(ty,sem) ->
+	| Ast0.TyDecl(ty,attr,sem) ->
 	    let (ty_n,ty) = typeC ty in
+	    let (attr_n,attr) = map_split_bind string_mcode attr in
 	    let (sem_n,sem) = string_mcode sem in
-	    (bind ty_n sem_n, Ast0.TyDecl(ty,sem))
+            (multibind [ty_n; attr_n; sem_n], Ast0.TyDecl(ty,attr,sem))
 	| Ast0.Typedef(stg,ty,id,sem) ->
 	    let (stg_n,stg) = string_mcode stg in
 	    let ((ty_id_n,ty),id) = named_type_typedef ty id in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
