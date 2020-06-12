Return-Path: <SRS0=FQJD=7Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0DEC433E0
	for <cocci@archiver.kernel.org>; Fri, 12 Jun 2020 06:46:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDDB0207F7
	for <cocci@archiver.kernel.org>; Fri, 12 Jun 2020 06:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThprmTDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDB0207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05C6kKYA016551;
	Fri, 12 Jun 2020 08:46:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 41F3C44A7;
	Fri, 12 Jun 2020 08:46:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BB9EE3BAB
 for <cocci@systeme.lip6.fr>; Fri, 12 Jun 2020 08:46:18 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05C6kGHt007914
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 12 Jun 2020 08:46:17 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id y17so3359840plb.8
 for <cocci@systeme.lip6.fr>; Thu, 11 Jun 2020 23:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4agKA9fGXmmMQ0KXhvea/FbQXVfJX1PROKMSRGKAktA=;
 b=ThprmTDjSw+uozIeKE/7GKNLnIZ7xi3SxRDssEuXHP2qSsb4TJLw162yclQ/er6+P6
 HepEyFv+PGiUm1msj9KOEPfGH7WuQllv+BDAH0Olw1rsW8z9/IHQq9wVj+eB1IxNb0nn
 LWu+tXBCys8hcb4v+EGHpDARsKCaB8xd8XZcX/1Sun+7BKox9AV6i26K8uFIITb4fFsi
 QncAiem7ckJZuJRsOQvlq8nixWoNMQmvKUWqsUS6cqmfrW8L55McIwhIFyVL+sRwG80Q
 mU2PA/kfzj4jTT0L5RnUXZ32lMx26Uk7vM6CjRpW2vWGOwZ3GLNRcVEKZvjAWDFzCuH6
 XmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4agKA9fGXmmMQ0KXhvea/FbQXVfJX1PROKMSRGKAktA=;
 b=Qm5pDPy65zc5kobYQ3eXdFuJaGEFANJYf/9KEKvu3uAWYc/d7q/KLyrgDy6RIPjPG+
 w+FvIv96iQddBHFSTovbFi9YdJQH1jo7zG18ClHZ0vOhjaMqNI06LRBY36nD2INocnbp
 7hwg9tRoyDb+BuhfZal242l4iyqFtcHoDoSdnZgfnMfZXzUJosVitzIURpuOtOts7Nyc
 35o/PtpG4elO+qFJG6pi4aDNWfsbMzunAyj1OD899oS8yxq9yGjY5M+HffkfN305ifpn
 GNHfuB8/Y5idw4c3CvJ2rKgRdYudJW0lW+zG3yv9syKLNOY+mH5/5ax7asfhaHB6ogXK
 UtMQ==
X-Gm-Message-State: AOAM533C+bvJi4Yvx4BE1GHiz/J7/TIL9h0pJX4jcy3DB+s/ZrTiKjqJ
 r9vsE/2/MIQTMatmqUMu2GgCGRqM
X-Google-Smtp-Source: ABdhPJzHjA3Aj66iVd0K319U1Npw7WbqfaLLUR1vo9we0Uv7pvHu7hgilZz74en3IdDg9A7wRhWFiQ==
X-Received: by 2002:a17:90a:7347:: with SMTP id
 j7mr11960015pjs.128.1591944375944; 
 Thu, 11 Jun 2020 23:46:15 -0700 (PDT)
Received: from localhost.localdomain ([1.38.217.229])
 by smtp.gmail.com with ESMTPSA id w192sm5087476pff.126.2020.06.11.23.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 23:46:15 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 12 Jun 2020 12:15:42 +0530
Message-Id: <20200612064544.30194-2-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200612064544.30194-1-jaskaransingh7654321@gmail.com>
References: <20200612064544.30194-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 12 Jun 2020 08:46:20 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 12 Jun 2020 08:46:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 1/3] parsing_cocci: arity: Apply mcode2arity on
	macrodecl/param attrs
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

The following commits introduced some poor management of attributes in
arity.ml:
	08f1cd9fb83ec400435e0ad8fdf579ec8f9c0f21
	b4b8653bd5a9607922e0050fe2fede10d422b218
Apply mcode2arity to macrodecl and parameter attributes.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/arity.ml | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/parsing_cocci/arity.ml b/parsing_cocci/arity.ml
index 6f90616e..3bbecedf 100644
--- a/parsing_cocci/arity.ml
+++ b/parsing_cocci/arity.ml
@@ -601,7 +601,7 @@ and declaration tgt decl =
       let arity =
 	all_same true tgt (mcode2line lp)
 	  ((match stg with None -> [] | Some x -> [mcode2arity x]) @
-	   (List.map mcode2arity [lp;rp;sem])) in
+	   (List.map mcode2arity ([lp;rp] @ attr @ [sem]))) in
       let stg = get_option mcode stg in
       let name = ident false arity name in
       let lp = mcode lp in
@@ -816,30 +816,40 @@ and make_param =
 
 and parameterTypeDef tgt param =
   let param_same = all_same true tgt in
+  let make_param_attr param tgt ret = function
+      [] -> Ast0.rewrap param ret
+    | x::_ as xs ->
+        let arity = param_same (mcode2line x) (List.map mcode2arity xs) in
+        make_param param tgt arity ret in
   match Ast0.unwrap param with
     Ast0.VoidParam(ty,attr) ->
-      Ast0.rewrap param (Ast0.VoidParam(typeC tgt ty,List.map mcode attr))
+      let ty = top_typeC tgt true ty in
+      let attr = List.map mcode attr in
+      let ret = Ast0.VoidParam(ty,attr) in
+      make_param_attr param tgt ret attr
   | Ast0.Param(ty,Some id,attr) ->
       let ty = top_typeC tgt true ty in
       let id = ident true tgt id in
       let attr = List.map mcode attr in
-      Ast0.rewrap param
-	(match (Ast0.unwrap ty,Ast0.unwrap id) with
+      let ret =
+	match (Ast0.unwrap ty,Ast0.unwrap id) with
 	  (Ast0.OptType(ty),Ast0.OptIdent(id)) ->
 	    Ast0.OptParam(Ast0.rewrap param (Ast0.Param(ty,Some id,attr)))
 	| (Ast0.OptType(ty),_) ->
 	    fail param "arity mismatch in param declaration"
 	| (_,Ast0.OptIdent(id)) ->
 	    fail param "arity mismatch in param declaration"
-	| _ -> Ast0.Param(ty,Some id,attr))
+	| _ -> Ast0.Param(ty,Some id,attr) in
+      make_param_attr param tgt ret attr
   | Ast0.Param(ty,None,attr) ->
       let ty = top_typeC tgt true ty in
       let attr = List.map mcode attr in
-      Ast0.rewrap param
-	(match Ast0.unwrap ty with
+      let ret =
+	match Ast0.unwrap ty with
 	  Ast0.OptType(ty) ->
 	    Ast0.OptParam(Ast0.rewrap param (Ast0.Param(ty,None,attr)))
-	| _ -> Ast0.Param(ty,None,attr))
+	| _ -> Ast0.Param(ty,None,attr) in
+      make_param_attr param tgt ret attr
   | Ast0.MetaParam(name,cstr,pure) ->
       let arity = param_same (mcode2line name) [mcode2arity name] in
       let name = mcode name in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
