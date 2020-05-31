Return-Path: <SRS0=O8dQ=7N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F29C433DF
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84E4206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cS6puiw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84E4206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFRWAI001250;
	Sun, 31 May 2020 17:27:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 82DA87752;
	Sun, 31 May 2020 17:27:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5784D3C89
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:31 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:644])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFRTx1026607
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:30 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id x11so3219490plv.9
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rXH065TEJpyQCEIMDnCvPM+XrRnyBZ4WAxquHZrHOUM=;
 b=cS6puiw59rez3e2hM2OPb8BOXe4U6KDFiQ0fiMdKNKppKsxx0N4bKfNERuGyJa78PH
 Q60iQ6axLHPM3Q8t5uV0eoaJ2971IWSFykat/5RlGspAqlkyMXM0QzdXBpF98iGrPZgk
 5g/Zp2l1y2Xl9kE4SDlO0x+Zda0XLU//CTx43D8rvU1HGj1MqMeapax3OCOe9h0eFKR1
 OgtbtVhCjpvg7ST+oZo2O6gUgnZwlkrvXbbmQPGa9N3xU4x+LURPNFWPII98YTt3g/Ud
 OCobeiqBD20emkeJYIS3e6W7w0BzcZxjbiOOuvyiLCZuiCl2DbkH19Gy6o7rkvWfKL+y
 pm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rXH065TEJpyQCEIMDnCvPM+XrRnyBZ4WAxquHZrHOUM=;
 b=nmdlhp9ANDQnXpWWOM6I3bC4+Ai8b+kXMUAdwEAwA6YRHb8xnGBzybAuWPxT9WqU60
 /0j+T0iw+RgueFOUPAcnOGJu8lfh+a+J9Pxww4U/dOFRRSBpaguCA4ytX59jgOyuzuh2
 NBJpwGG+u1NEJaBU475IQmJB+rqeIyXWmP3qHDw4I+aNhUAyb8+b7mukyQ3xz+mwKxYH
 xHkMDib+Cc0xtk7e44mln7zDSKKSj4mS8T3TmK4ULcoi5knyqVMhUfztmPaWY1PuY15J
 DeaR75iY30/4Cj+qYAPYgMoFmxF9683yN2NY2KBi4B/XBtBrQFjdmNDDwtQFNSkGT6lf
 GYxA==
X-Gm-Message-State: AOAM531mlWBhSPrMq5cm3qkd742ATnJqDfk9VOToKWLvzmf9rorIX97Y
 3eBpG8GkHJp5BrDABAK4gvXx+2rg
X-Google-Smtp-Source: ABdhPJzJ+LnJa5a8wxvqDZmbLKtOMDDNNDsfXOxVw/PaV9gL8TbZPpPRJGef0UW3kMFaviaa5gJUjw==
X-Received: by 2002:a17:90a:ba86:: with SMTP id
 t6mr19936505pjr.19.1590938849016; 
 Sun, 31 May 2020 08:27:29 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:27:28 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:56:02 +0530
Message-Id: <20200531152621.2886-9-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:27:32 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:27:30 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 08/27] parsing_cocci: arity: Reflect struct end
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

Struct end attributes are added to the SmPL AST. Reflect these changes
in arity.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/arity.ml | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/parsing_cocci/arity.ml b/parsing_cocci/arity.ml
index cbfb84e3..6f90616e 100644
--- a/parsing_cocci/arity.ml
+++ b/parsing_cocci/arity.ml
@@ -624,12 +624,14 @@ and declaration tgt decl =
       let sem = mcode sem in
       make_decl decl tgt arity
 	(Ast0.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem))
-  | Ast0.TyDecl(ty,sem) ->
+  | Ast0.TyDecl(ty,attr,sem) ->
       let arity =
-	all_same true tgt (mcode2line sem) [mcode2arity sem] in
+        all_same true tgt
+          (mcode2line sem) (List.map mcode2arity (attr @ [sem])) in
       let ty = typeC arity ty in
+      let attr = List.map mcode attr in
       let sem = mcode sem in
-      make_decl decl tgt arity (Ast0.TyDecl(ty,sem))
+      make_decl decl tgt arity (Ast0.TyDecl(ty,attr,sem))
   | Ast0.Typedef(stg,ty,id,sem) ->
       let arity =
 	all_same true tgt (mcode2line sem)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
