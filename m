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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00D4C7C8A2
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:10:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6B420656
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrGoUOjk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6B420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RC9ups018983;
	Mon, 27 Apr 2020 14:09:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 99F757816;
	Mon, 27 Apr 2020 14:09:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 46935782D
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:54 +0200 (CEST)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RC9qJn021782
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:53 +0200 (CEST)
Received: by mail-pg1-x542.google.com with SMTP id o15so8612020pgi.1
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 05:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=96G1ivLh1DBNVuKEJBoB0hDamYQo6rKx1EXrpxqcHM4=;
 b=RrGoUOjk5KrhaWld2Gfw2IrWXjoLliyyqP0IMlAGolGJvopBmsxlv5GokdYW4TYDZG
 V33+DRJempNdEtxBEqE6P2cCgTxwhBNJvyRRoT1WSdflMt0eF2rN+6C7c+Bo2jo2HnL1
 BvRMJ7/cTWOi+yxqVpab8YEmES0Yx9bP9RdCd/9pkN+KzgpCbjI9XYMFXT/yN55GzZhT
 yBq7RuxkQi6qesMnvpiYcOaZ6PDjhhbsuAZbpfTj98B/DjkPkaG9sgf0JSm+rr5xtV0d
 uXYgd218oq97g2yoRamN0hYYRkZjlMncDzhxfhmwRKJ3HUGaVw0+W0mfWS4e3zsQ+2Sr
 6w6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=96G1ivLh1DBNVuKEJBoB0hDamYQo6rKx1EXrpxqcHM4=;
 b=PwHss2s4vjyDmRIZ1ZIp0LTVKPjW3By68no0HgTUjnoirgetNXwiHEqTA8k+RLQYwN
 /HiQZrbSZwcfuzS3XiHJ62OdrRcDxdFxd6/LpknbqdFZUavu3M8K8C8RiWvkZbx8GWUE
 SZ4BuR+i4cwxGcxU7bLG4Yjd+npA5zRgwq0LI+tZhsol37IoF0GBCkvd/nogvGATOVEE
 20vVkEWB2lfcTGYPtTRX1NBKamRfwO9O12COr0/JFfgikz7WmXyI4Wf29j53lQLAgGJI
 DL13hl4YPsCKcww2o+5kGmT5sTSyVg4spgrqOQzXOGf+8t1nU1D43IBjWBbaSqV0mkY0
 dN1A==
X-Gm-Message-State: AGi0PuafcfIqrIil451oJyl3orjQxc0cVBXxvP5+dHyg6noK8YYBBQJv
 gQAaspqwLyGh8XJbiIujrY7RQJELnag=
X-Google-Smtp-Source: APiQypIEotHE7F8lbJ4McgR4pQ4Zr+asb0CZF09QNc2+IpHpNwEKbT5r0uCm/8GlrZWnBswDdG1dbg==
X-Received: by 2002:aa7:8f26:: with SMTP id y6mr24502609pfr.36.1587989391779; 
 Mon, 27 Apr 2020 05:09:51 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.114])
 by smtp.gmail.com with ESMTPSA id r17sm9623885pgn.35.2020.04.27.05.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 05:09:51 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 27 Apr 2020 17:38:27 +0530
Message-Id: <20200427120834.380-17-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 14:09:56 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 Apr 2020 14:09:53 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 16/23] parsing_cocci: ast0toast: Reflect Parameter
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
ast0toast.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/ast0toast.ml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/parsing_cocci/ast0toast.ml b/parsing_cocci/ast0toast.ml
index 09c28c06..80d38138 100644
--- a/parsing_cocci/ast0toast.ml
+++ b/parsing_cocci/ast0toast.ml
@@ -857,10 +857,11 @@ and designator = function
 and parameterTypeDef p =
   rewrap p no_isos
     (match Ast0.unwrap p with
-      Ast0.VoidParam(ty) -> Ast.VoidParam(typeC false ty)
-    | Ast0.Param(ty,id) ->
+      Ast0.VoidParam(ty,attr) ->
+        Ast.VoidParam(typeC false ty,List.map mcode attr)
+    | Ast0.Param(ty,id,attr) ->
 	let allminus = check_allminus.VT0.combiner_rec_parameter p in
-	Ast.Param(typeC allminus ty,get_option ident id)
+	Ast.Param(typeC allminus ty,get_option ident id,List.map mcode attr)
     | Ast0.MetaParam(name,cstr,_) ->
 	Ast.MetaParam(mcode name,constraints cstr,unitary,false)
     | Ast0.MetaParamList(name,lenname,cstr,_) ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
