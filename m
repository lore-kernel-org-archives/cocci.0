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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1535FC54E4B
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:13:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52B120720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lib4o9sr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52B120720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BADhwX007881;
	Mon, 11 May 2020 12:13:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 741A73E6B;
	Mon, 11 May 2020 12:13:43 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 05C423DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:13:42 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BADep9022397
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:13:41 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id x10so3745181plr.4
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UNK86jdCWpZvvuZbrZBw1TBtV6hkQFeqAzcg7yMFU+c=;
 b=lib4o9srr9cMamEx4Z/FYbQasBfwu61ExGcgIj84mC9ZybOYN3kEBAIksAv5XQ3xoV
 q45d2AGPJvxmu4u4T+eAsVIXteEUyRWSeeYSowpZ1xtRHfjTOXlXqfl8+WVsQag/ngLr
 C9iBxOoV7ehuSX67BHKW0Gk9k35cH+vq7G9MBYGTUQR94HlPdcMJ4lQvX2FfdRzGGuto
 dc4ZX8mBswVzUZBsoFObw5+zshGK+QISNqHpmIWXn4lkckr5SZ+cRkymySnevuoMqs9F
 tUXPA5aZoHxpvDgcVTVn2T+hJXGsGiTHFFkaQ9hG+VsyLl6Tfx2MdQGYYigltInVZeW2
 eMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UNK86jdCWpZvvuZbrZBw1TBtV6hkQFeqAzcg7yMFU+c=;
 b=TfcncH4juL7sZTvvPelu7adY2OPwSJS48mO9WIeL9c0LAxghOlXyREDw4UJ93/7uuQ
 RSQS+3hkgGkz24sKJi+5z0M1LT2gr0YOKsHXskyYiQxzl7qPCnTxqMr7T4+i8M/EcGt/
 VyDvW/vCIunOBNRkP28sbsnAbG8sAcfl9XpZU6El9uU7jrmUnRawX19XGhPmugSEb3mB
 SdF5VWI0NTg2IDFC1ucNmRgN6n1XCco6kociHXfRqB185p00cfAIzOzAXanAB17XLSNA
 JjYfjrnDlU8GnDRgn7IHSGNbrzZHyHuZT4SWDUktzb2Vps9oMfhLkNH2OonaYY188bbX
 5z+A==
X-Gm-Message-State: AGi0PuZuGWYJo9tk9OtlI3WHyRLgznVPgDndVrLF4OZpi8fzGtyfSQoP
 A1+pjowiphGAOM1swAWs9nMbFhwaglM=
X-Google-Smtp-Source: APiQypIOj08YAgdVRcK2HhdQMggqYYkQ7XERZLzo24BgpALqK4MyEfZRih0WLYxWF9pu3H0XBzurpw==
X-Received: by 2002:a17:902:522:: with SMTP id
 31mr14481033plf.68.1589192019608; 
 Mon, 11 May 2020 03:13:39 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:13:39 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:42:43 +0530
Message-Id: <20200511101300.11101-7-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:13:43 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:13:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 06/23] parsing_cocci: compute_lines: Reflect
	Parameter attributes
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
compute_lines.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/compute_lines.ml | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/parsing_cocci/compute_lines.ml b/parsing_cocci/compute_lines.ml
index 1361d842..5c739d8b 100644
--- a/parsing_cocci/compute_lines.ml
+++ b/parsing_cocci/compute_lines.ml
@@ -914,13 +914,31 @@ and is_param_dots p =
 
 and parameterTypeDef p =
   match Ast0.unwrap p with
-    Ast0.VoidParam(ty) ->
-      let ty = typeC ty in mkres p (Ast0.VoidParam(ty)) ty ty
-  | Ast0.Param(ty,Some id) ->
+    Ast0.VoidParam(ty,attr) ->
+      let attr = List.map normal_mcode attr in
+      let ty = typeC ty in
+      (match attr with
+        [] -> mkres p (Ast0.VoidParam(ty,attr)) ty ty
+      | l ->
+          let lattr = List.hd (List.rev l) in
+          mkres p (Ast0.VoidParam(ty,attr)) ty (promote_mcode lattr))
+  | Ast0.Param(ty,Some id,attr) ->
       let id = ident id in
-      let ty = typeC ty in mkres p (Ast0.Param(ty,Some id)) ty id
-  | Ast0.Param(ty,None) ->
-      let ty = typeC ty in mkres p (Ast0.Param(ty,None)) ty ty
+      let ty = typeC ty in
+      let attr = List.map normal_mcode attr in
+      (match attr with
+        [] -> mkres p (Ast0.Param(ty,Some id,attr)) ty id
+      | l ->
+          let lattr = List.hd (List.rev l) in
+          mkres p (Ast0.Param(ty,Some id,attr)) ty (promote_mcode lattr))
+  | Ast0.Param(ty,None,attr) ->
+      let attr = List.map normal_mcode attr in
+      let ty = typeC ty in
+      (match attr with
+        [] -> mkres p (Ast0.Param(ty,None,attr)) ty ty
+      | l ->
+          let lattr = List.hd (List.rev l) in
+          mkres p (Ast0.Param(ty,None,attr)) ty (promote_mcode lattr))
   | Ast0.MetaParam(name,a,b) ->
       let name = normal_mcode name in
       let ln = promote_mcode name in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
