Return-Path: <SRS0=J+r8=6L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE61C54FD0
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E476206CD
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef+0b1js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E476206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RC9C8c029893;
	Mon, 27 Apr 2020 14:09:12 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3A7577807;
	Mon, 27 Apr 2020 14:09:12 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2F85F7769
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:11 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:643])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RC99ou014750
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:10 +0200 (CEST)
Received: by mail-pl1-x643.google.com with SMTP id v2so6918324plp.9
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 05:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZcLgsD2NT4RKlSvX8OLhp3WwZOfSpNZrQHDX9kzUnVA=;
 b=ef+0b1js6ziep3xZnZxScPoP82nnbTitMcOPp3viS4EJ+Xn92FqJosm0eBIfkr5R3+
 v/WuNpz56hHHJHhDCxh/FQjjsXpFrVgU691bLMYwpjfvshEmXX70qa0TQkmWolvPlcRP
 YTdkOtssE3iYbVQV+qeGgKTTO7wxWaU2W2Ugs42fmLin1ilw6gDEW/clTUR6Pq3WHdT2
 NLCq5mlTX4hvXV6vKyO5txQkf0Oml308DhFpbmx05BMfeGUqFd+aT3S6pfW2LTG/qmyk
 5yif8WcDgQBkxiINCIWvKjmh8hVbCOE8xgsjLrmvmwY+ufldfx/UzJNKOX/j2D1K8Rl+
 yqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZcLgsD2NT4RKlSvX8OLhp3WwZOfSpNZrQHDX9kzUnVA=;
 b=W3zvKM3iXQQWv1YZbzuowW3xxIjTzTKPjFk7KEexW4AZeJkIebteOJJ9+lH3PH3dV7
 +j52Z1T3O7cKvGlRrBNglrX3QoZ8Dxzc1NElo+J4esZ1pRNG9BfruutKgmhTeEv0u0GJ
 iH7gmWZQn98A2QuvNATyqD7WI5RNAU+koxyS9UCygo1eaLpw3eo8bKI/yiCrWH4Kv7GX
 9fQcWeKKzPwjH1uzYa09HXebA2s7q8FUVsrsccBOYp+AwxrZjSpm5Psl5SmNo+vHYLm5
 LSG4zGwR7J3Gxzeuqdr+iKs7fArnOofsO8lwrHRlFtxj41rjoVfUb8f88npZ5zEyhyLA
 Optw==
X-Gm-Message-State: AGi0PuakMBm6tehD/hqykKkX4sbTTdNJOdQ3kPvpSDihefFXoGTaFg8K
 egNvRAdz+iyfrH42VokMSaR7A/ejfi0=
X-Google-Smtp-Source: APiQypJ18TUhWMfbVdB6r3QXUJzv6dXIDHPYSbO1mI92BRqC/H2pITAZlvnZV+h6oA6t3Dcvqi8x/g==
X-Received: by 2002:a17:902:a985:: with SMTP id
 bh5mr18640511plb.163.1587989348659; 
 Mon, 27 Apr 2020 05:09:08 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.114])
 by smtp.gmail.com with ESMTPSA id r17sm9623885pgn.35.2020.04.27.05.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 05:09:08 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 27 Apr 2020 17:38:17 +0530
Message-Id: <20200427120834.380-7-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 14:09:12 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 Apr 2020 14:09:10 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 06/23] parsing_cocci: compute_lines: Reflect
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
 parsing_cocci/compute_lines.ml | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/parsing_cocci/compute_lines.ml b/parsing_cocci/compute_lines.ml
index 1361d842..9bf4ab06 100644
--- a/parsing_cocci/compute_lines.ml
+++ b/parsing_cocci/compute_lines.ml
@@ -914,13 +914,16 @@ and is_param_dots p =
 
 and parameterTypeDef p =
   match Ast0.unwrap p with
-    Ast0.VoidParam(ty) ->
-      let ty = typeC ty in mkres p (Ast0.VoidParam(ty)) ty ty
-  | Ast0.Param(ty,Some id) ->
+    Ast0.VoidParam(ty,attr) ->
+      let attr = List.map normal_mcode attr in
+      let ty = typeC ty in mkres p (Ast0.VoidParam(ty,attr)) ty ty
+  | Ast0.Param(ty,Some id,attr) ->
       let id = ident id in
-      let ty = typeC ty in mkres p (Ast0.Param(ty,Some id)) ty id
-  | Ast0.Param(ty,None) ->
-      let ty = typeC ty in mkres p (Ast0.Param(ty,None)) ty ty
+      let attr = List.map normal_mcode attr in
+      let ty = typeC ty in mkres p (Ast0.Param(ty,Some id,attr)) ty id
+  | Ast0.Param(ty,None,attr) ->
+      let attr = List.map normal_mcode attr in
+      let ty = typeC ty in mkres p (Ast0.Param(ty,None,attr)) ty ty
   | Ast0.MetaParam(name,a,b) ->
       let name = normal_mcode name in
       let ln = promote_mcode name in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
