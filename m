Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED308C433DF
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:21:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B711206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiCHp9Ua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B711206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHLHuX019152;
	Sun, 24 May 2020 19:21:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BEBF83DC8;
	Sun, 24 May 2020 19:21:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CCB303D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:21:15 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHLE3F008991
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:21:15 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id n18so7868991pfa.2
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0TK4SBb9CnUXLZimGDRWYYXGovLdTn8ncKA3GspiW1A=;
 b=eiCHp9Ua4DQ3kpujPkyfEg8FVsLiOBzzUhzjX7CLxAHK+giZx5mJqGQ7PB6atM6KC9
 dwkiL3pCgb5PHU6DO9BeSR5z63C5+zKx5S4ltG4oB0JAgYWaDh9GgCUU/uZFLisWWprF
 Bso+CHmaI89xcvSUGe4yE63sC5OHOAkq+vbtCz52dVPiJnZhFxAZTjeRCLRKT0BG4iBX
 L4dK6afSsoarWE40fEQdgbRmzqvpoE3zAv3innACBHup4qaPbtL3qsdOO356q/aMmSx4
 OTc7gRLRe/eXXlhwm5uZ1ZTs7uckV9bhdAMxfbZGh/h6Vu8PbFY7Ok/LPr/KCOWIXQnc
 diUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0TK4SBb9CnUXLZimGDRWYYXGovLdTn8ncKA3GspiW1A=;
 b=XLAc8fboOyZazTt7r0y6Jp28Vnxr6G7R17KkEI2IwCDG/pEEVivq0jyiJAUQjvZDuN
 UGT/uGY94UBvfcowlIKsj/fMEBGIoSKcd22CWgkRsYSPBndFY+Rr2Ymar260Wg1EYkJY
 F3Qopgvb7KZwhCkOCQslxJU8f3VIaDkcCp/lJbbjBSAvsxHyJTPD1x6U6EUiPaTqp1BF
 /6mlvRFRE9x3EnXPPi39LlsAGoun1+XjcuGihE32fXTHlOWnlejf9cZAs76Sq+z8pP4L
 1lElxT3WvOp6KKuSxjol9m7BYUkkmEmhbAvbzwwl3cJkQCIb8e4ASDLrMzooJT+fEPkz
 Ej8w==
X-Gm-Message-State: AOAM532Nz24gQ/Zp7t8Ys7zX8COE3AwFLGdj1mQgAf4JkGtB/zL6tdgM
 mVPbN/WUHdsuUES500zQ97FI7CKdAiI=
X-Google-Smtp-Source: ABdhPJw6d/g13j418aenPl7ucKgD9sjaJNR1MGBVsQfxX9oJs77E8kAdnlzrRUZ5tBcBw6uVoBpqBA==
X-Received: by 2002:aa7:829a:: with SMTP id s26mr13624818pfm.40.1590340873405; 
 Sun, 24 May 2020 10:21:13 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:21:12 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:19 +0530
Message-Id: <20200524171935.2504-15-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:21:17 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:21:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 14/30] parsing_cocci: visitor_ast: Reflect Macrodecl
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
in the SmPL AST visitor.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/visitor_ast.ml | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/visitor_ast.ml b/parsing_cocci/visitor_ast.ml
index 8e530114..9746b085 100644
--- a/parsing_cocci/visitor_ast.ml
+++ b/parsing_cocci/visitor_ast.ml
@@ -470,14 +470,15 @@ let combiner bind option_default
 	  let lrp1 = string_mcode rp1 in
 	  multibind
 	    (lfi @ [lname; llp1; lparams] @ lcomma @ lellipsis @ [lrp1])
-      | Ast.MacroDecl(stg,name,lp,args,rp,sem) ->
+      | Ast.MacroDecl(stg,name,lp,args,rp,attr,sem) ->
 	  let lstg = get_option storage_mcode stg in
 	  let lname = ident name in
 	  let llp = string_mcode lp in
 	  let largs = expression_dots args in
 	  let lrp = string_mcode rp in
+	  let lattr = multibind (List.map string_mcode attr) in
 	  let lsem = string_mcode sem in
-	  multibind [lstg; lname; llp; largs; lrp; lsem]
+	  multibind [lstg; lname; llp; largs; lrp; lattr; lsem]
       | Ast.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem) ->
 	  let lstg = get_option storage_mcode stg in
 	  let lname = ident name in
@@ -1417,14 +1418,15 @@ let rebuilder
 	    let lrp = string_mcode rp in
 	    let lsem = string_mcode sem in
 	    Ast.FunProto(lfi,lname,llp,lparams,lva,lrp,lsem)
-	| Ast.MacroDecl(stg,name,lp,args,rp,sem) ->
+	| Ast.MacroDecl(stg,name,lp,args,rp,attr,sem) ->
 	    let lstg = get_option storage_mcode stg in
 	    let lname = ident name in
 	    let llp = string_mcode lp in
 	    let largs = expression_dots args in
 	    let lrp = string_mcode rp in
+	    let lattr = List.map string_mcode attr in
 	    let lsem = string_mcode sem in
-	    Ast.MacroDecl(lstg, lname, llp, largs, lrp, lsem)
+	    Ast.MacroDecl(lstg, lname, llp, largs, lrp, lattr, lsem)
 	| Ast.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem) ->
 	    let lstg = get_option storage_mcode stg in
 	    let lname = ident name in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
