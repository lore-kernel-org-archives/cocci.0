Return-Path: <SRS0=43Z/=6Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D01C54E4B
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:13:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC015206D6
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tt2WqyZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC015206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BADaoP023439;
	Mon, 11 May 2020 12:13:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A036A7773;
	Mon, 11 May 2020 12:13:36 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 358DC3DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:13:35 +0200 (CEST)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BADXbh027117
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:13:34 +0200 (CEST)
Received: by mail-pj1-x1041.google.com with SMTP id mq3so7632219pjb.1
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WAbYcI+ddLC4sIyW6AKwmLufMWLaaZ3sTc/dozO6PhM=;
 b=tt2WqyZMxACu979jHSzGEKVbV1D1ZFS6qrxMFzDAZbHxc8fzLlGyhYT7IsEAcJGE2t
 b7BcRGSIAc2WfO+/Voa/2a4Vjt8AM8ls6PFlomLitKviI2+tGC/RxN9bigAW09hJbsiP
 5RPZoEqzTTsoi57G11o2fcExoVYoPTEGQRq8Y8fNHCbBKIO4FJuylXNnX9yFYGYh8tRa
 0qmI7vXMGgoBtZ376+URnxAf27C2r1kPIol5hbBCBqcZLETrWwNOEtzJrTKLKLZ0cGj0
 I73hgMO7Monw/t2j2m/wYsBHgXjn4Xxsb9yaSAAqdeLT598KI4hSChuqXcdwrYk9Bxt7
 ZiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WAbYcI+ddLC4sIyW6AKwmLufMWLaaZ3sTc/dozO6PhM=;
 b=m+w18C/RXJP6qsbSfdeSSNohOnK0xQkCOrwTDgTT+ekqLiIh8V4Dcdb7q2TcR/k2yg
 mZyX8OZk3AJnlJtRo9/sa/MgzgRNXv/5zuMVP/bS64LDuw91rrPelG6dmMUnq8tWhJVJ
 tkSFv3OPyz1nq5G41w7JpCqtCz6z57G2xVbtZegfJtPkYjg0gBsFgEF7odpS9sFzrlmS
 6cyCYDjnVVfFXivXkwtmzMIcjjcVeYrj51jcHBcbhKXcfu9J2WpcQCITMDo3gpuvh+HD
 bkNS3t/pYWy0ZiSl2yFebHnjac8AmWyoCniaE22Dnr18+SHLlhtcrVZ8KseWFggT0FrW
 avrQ==
X-Gm-Message-State: AGi0PuYuSQ7uKgviMWK0pTdrkxeVaPOvJy1Z7KTY+xEcEhPgeteLc8R2
 ekfDUaTw/ZXWcQEF4kfIRa8EjnsXG3Y=
X-Google-Smtp-Source: APiQypLfMnmCqp9pA80yqUSe0U2qaPWFWKjZZ1LUJrZ5dpaS1vhp6UxTk6CFaWrHj9LYuw0CrbILmw==
X-Received: by 2002:a17:90a:276a:: with SMTP id
 o97mr21417951pje.194.1589192012752; 
 Mon, 11 May 2020 03:13:32 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:13:32 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:42:41 +0530
Message-Id: <20200511101300.11101-5-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:13:36 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:13:34 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 04/23] parsing_cocci: arity: Reflect Parameter
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
