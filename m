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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F38C433E0
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:21:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA470206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+AA1grp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA470206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHLc9w012925;
	Sun, 24 May 2020 19:21:38 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2D3C63DC8;
	Sun, 24 May 2020 19:21:38 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 262C13D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:21:36 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHLYaM017502
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:21:35 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id c75so7703838pga.3
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6JGEKFsxFuHSsUljfKUFffLbRzeznecp1vrka61QpQY=;
 b=n+AA1grpDAR9IX4n4FFlXhkXzh7KAgVxaYM2XTb784nIJXbI4VPZudXH2AkwGwbnju
 vU93uteC6P6YM9MyrZquLVDacs2kNulAfBK1oRHed+GehwjfElGqNLHWFPyZoEsCuHVr
 /ZeJSM30L+HUfKBvienhPfS1LxkG4VC8MOwNZcb5n6+hDXUSjRyDLSwuzsUeHPSFAJJQ
 KugjO8lkH1GFXsWYK5MFOl9iNvwS3ZYQ+NrYAaxyNrQvWY1I5mIggGeN7NqTWTO7cTZ7
 LaPxVKMnYGP6W8rB1DlgiLq/0HFTNuWEbverkM7yXDHohW/GXERdiav+j1l9tT8EYum4
 wY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6JGEKFsxFuHSsUljfKUFffLbRzeznecp1vrka61QpQY=;
 b=losjKy2SCrqBRhdcMBONlxYNnzzxvrrUTVPJf65I3dAqB/WSXJgOdPJc76pcn7QpDe
 1y638OhCl625Rq1qQ/P+1tFLa7wPs2bnOrlkKoKN0gY2TUyLEz3zuvsH+wL48zESlFxa
 40FfiwTmHty0r/wXFD/rChDQ+i1wZhGKdc7OA9Y84oXIBm9MZ5xSwS+ZMVJc0posj06K
 Fz9JVxK1um+i1QXSTYqRsV/X+KnK32qolkLzuDjBiH/w+BpWXH17aS172lkydjR9jw0U
 ykPm1mj2JBukVPMEOF8jmzuALsHJ+o1ptGuCIpR7xvF0k+9HspMP0NCfRsRw4fYg4lvS
 JiXA==
X-Gm-Message-State: AOAM533Ba1PU9+mPwyqGi64FLM/9oRLoQPoKGk+etOnX2L+arYDHtnBq
 dmTrbZDxCmUs+NH+NB1cNKeo20POZYw=
X-Google-Smtp-Source: ABdhPJyU0kkKtZxZwo0iBWurOSh9w3795/BTKa6nychsfVE4wNO2IcaYF8/AOaKS9qAGzxghm/7Fiw==
X-Received: by 2002:a63:5245:: with SMTP id s5mr6174951pgl.394.1590340893781; 
 Sun, 24 May 2020 10:21:33 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:21:33 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:24 +0530
Message-Id: <20200524171935.2504-20-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:21:38 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:21:35 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 19/30] parsing_cocci: ast0toast: Reflect Macrodecl
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

Macrodecl attributes are added to the SmPL AST. Reflect these changes in
ast0toast.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/ast0toast.ml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/ast0toast.ml b/parsing_cocci/ast0toast.ml
index 09c28c06..7ca7bd3f 100644
--- a/parsing_cocci/ast0toast.ml
+++ b/parsing_cocci/ast0toast.ml
@@ -657,15 +657,16 @@ and declaration d =
 	  let rp = mcode rp in
 	  let sem = mcode sem in
 	  Ast.FunProto(fi,name,lp,params,va,rp,sem)
-    | Ast0.MacroDecl(stg,name,lp,args,rp,sem) ->
+    | Ast0.MacroDecl(stg,name,lp,args,rp,attr,sem) ->
 	(* this would seem to need allminus... *)
 	let stg = get_option mcode stg in
 	let name = ident name in
 	let lp = mcode lp in
 	let args = dots expression args in
 	let rp = mcode rp in
+	let attr = List.map mcode attr in
 	let sem = mcode sem in
-	Ast.MacroDecl(stg,name,lp,args,rp,sem)
+	Ast.MacroDecl(stg,name,lp,args,rp,attr,sem)
     | Ast0.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem) ->
 	(* this would seem to need allminus... *)
 	let stg = get_option mcode stg in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
