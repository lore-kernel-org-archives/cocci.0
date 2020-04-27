Return-Path: <SRS0=J+r8=6L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9B6C54FD0
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196BD20656
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auYFOoIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196BD20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RC96CK009451;
	Mon, 27 Apr 2020 14:09:06 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6366D7816;
	Mon, 27 Apr 2020 14:09:06 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 213677807
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:05 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:643])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RC93KY028248
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:04 +0200 (CEST)
Received: by mail-pl1-x643.google.com with SMTP id t4so6906434plq.12
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 05:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WAbYcI+ddLC4sIyW6AKwmLufMWLaaZ3sTc/dozO6PhM=;
 b=auYFOoIeQK74uwOMT0Lie7LxcWEvPB0eP9aHRHzAaRuqBVXTuQa8J7zZ7V8v9vka/e
 uFfYfXe1XQBJyGKxCRTK1Bab86MGsimJ4DUlX1AmqtF1igUl682LpdyCjwmb0vWoIuEI
 seiHV3Vk1VSqVvlTmYn5TKhG3B44DfInzusObAPaOb3Fh2B3gyzP+XoySRhz6QOdDqst
 KjzmWo+YTDbXv4IKINPhY+rEl5IniGR6xqeUz1vV3tNLLHN/Su6sz9ofcTJWO1U7WJmg
 Ca4CUINT4bOhJzvNUnZV7sS2c/wsaXoPyoCOyFTOjTh812ETO6pdsMIcq6VwGg0PJQAf
 5LKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WAbYcI+ddLC4sIyW6AKwmLufMWLaaZ3sTc/dozO6PhM=;
 b=g4E76Rc+gRE5ERBPzzsdgBtteq9mGmmLOB+/cRNdLKvOX5Pl1Tf50Wn1+03mjGjToY
 IAsrye0/dY9cytD92ScVFBfiaYqzq4FznttglGsVkg/3PyIR21vevqO66r+SMhUfC9ZD
 t4Qdyfs/ma14DF768w1g7Ii59+9LjfL81PWdib/Fqgdg9NaldVgvkF72/NtRqaeHjNKG
 y9a5Jwjd0yasEOtgiNIYQPOr5dx+oQD4bCh8rahvu86hQSXPkhhWYQW4vaLUiQb7N9b1
 kUpgIYWDBro0cKGnKbCIOH04jM1ISr/rCQWMSEWELMyU5CpRYj64ZbdbbT/oZG6Pbi9f
 8XWw==
X-Gm-Message-State: AGi0PuZHobfu1WF7HPvOGRfTUkCpJgJby5yLfFt7eNSq1sMk7QEAyCsl
 kqXCtSG9FPs5dhhcNEwTpBbIhmRcbbs=
X-Google-Smtp-Source: APiQypKzshW3RlyzHQtEz3tIMJ9R/BMlk8j0XAJd1X417bZfgm1TkajeWt3eTfBso2ZZBjeUEEo/Rg==
X-Received: by 2002:a17:902:784c:: with SMTP id
 e12mr22715929pln.191.1587989342094; 
 Mon, 27 Apr 2020 05:09:02 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.114])
 by smtp.gmail.com with ESMTPSA id r17sm9623885pgn.35.2020.04.27.05.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 05:09:01 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 27 Apr 2020 17:38:15 +0530
Message-Id: <20200427120834.380-5-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 14:09:06 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 Apr 2020 14:09:04 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 04/23] parsing_cocci: arity: Reflect Parameter
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

Parameter attributes are added to the SmPL AST. Reflect these changes in
arity.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/arity.ml | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/parsing_cocci/arity.ml b/parsing_cocci/arity.ml
index 8ee6d33f..0f64c113 100644
--- a/parsing_cocci/arity.ml
+++ b/parsing_cocci/arity.ml
@@ -812,26 +812,29 @@ and make_param =
 and parameterTypeDef tgt param =
   let param_same = all_same true tgt in
   match Ast0.unwrap param with
-    Ast0.VoidParam(ty) -> Ast0.rewrap param (Ast0.VoidParam(typeC tgt ty))
-  | Ast0.Param(ty,Some id) ->
+    Ast0.VoidParam(ty,attr) ->
+      Ast0.rewrap param (Ast0.VoidParam(typeC tgt ty,List.map mcode attr))
+  | Ast0.Param(ty,Some id,attr) ->
       let ty = top_typeC tgt true ty in
       let id = ident true tgt id in
+      let attr = List.map mcode attr in
       Ast0.rewrap param
 	(match (Ast0.unwrap ty,Ast0.unwrap id) with
 	  (Ast0.OptType(ty),Ast0.OptIdent(id)) ->
-	    Ast0.OptParam(Ast0.rewrap param (Ast0.Param(ty,Some id)))
+	    Ast0.OptParam(Ast0.rewrap param (Ast0.Param(ty,Some id,attr)))
 	| (Ast0.OptType(ty),_) ->
 	    fail param "arity mismatch in param declaration"
 	| (_,Ast0.OptIdent(id)) ->
 	    fail param "arity mismatch in param declaration"
-	| _ -> Ast0.Param(ty,Some id))
-  | Ast0.Param(ty,None) ->
+	| _ -> Ast0.Param(ty,Some id,attr))
+  | Ast0.Param(ty,None,attr) ->
       let ty = top_typeC tgt true ty in
+      let attr = List.map mcode attr in
       Ast0.rewrap param
 	(match Ast0.unwrap ty with
 	  Ast0.OptType(ty) ->
-	    Ast0.OptParam(Ast0.rewrap param (Ast0.Param(ty,None)))
-	| _ -> Ast0.Param(ty,None))
+	    Ast0.OptParam(Ast0.rewrap param (Ast0.Param(ty,None,attr)))
+	| _ -> Ast0.Param(ty,None,attr))
   | Ast0.MetaParam(name,cstr,pure) ->
       let arity = param_same (mcode2line name) [mcode2arity name] in
       let name = mcode name in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
