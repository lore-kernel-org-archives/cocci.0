Return-Path: <SRS0=43Z/=6Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DFBC47255
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F58F2075E
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR2jWkw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F58F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BAEK4p006137;
	Mon, 11 May 2020 12:14:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6DB823E6B;
	Mon, 11 May 2020 12:14:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3FC433DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:19 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BAEHKJ003396
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:18 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id d22so4359262pgk.3
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=96G1ivLh1DBNVuKEJBoB0hDamYQo6rKx1EXrpxqcHM4=;
 b=cR2jWkw4QhGtG2U+3ww86zlTSmN20iIaPzunlWb+ir3luvbVKmGNN/6I28431IOtvK
 AravCKgqVHcFla6fQZSRMNJc6IrKJDB9FleW8zsn8PfEgApgWJV2QtwfVPFuuy1MMegR
 t0UCjYnHkxK2/eIS3en6PG4sNjCd6bA5yaabLkobUIcYGLskzAgG00TJjTuquHGWzQGi
 RQfD4KDwJrueB2uCH3QX6c740UwvWmMTvbM6z79vdsJo4BkgEzf8dyJQ/26jomkjrZXr
 h6YpyL/0ona+iNxAgdQ51j2LNbfDzv8Rg2/1QD8biCIUmzt9RctCU5Zta90cM5uW/2j4
 7A4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=96G1ivLh1DBNVuKEJBoB0hDamYQo6rKx1EXrpxqcHM4=;
 b=r12fVwP9l/3FwYKYZGU+Yf5kjRn5zq5/uZuy1Pcpk5jBJjvwxydy/khi0pJCsUH/k9
 7edoYjI2p4xkbHK+X0j013TcXReyPOiK1MgnhRfiHj/cPU/IpGWW0zcqjIb/9MI2RnRg
 Vx744Y7e9RcZjevw79ElxLvIzI0yEA0V9N8KstOIZ4gWkFCa9RKmWHIOngDF3PKPMQBz
 +K+1m1VsmGWPWVTOk2+e2SzrASowub1DH2XZmLu2ikfE1+bkk/UeuyoD3/3OMqzv0NAy
 zrpsIJMi73zOwQwbGENGHGI7IzW4/NI9klfFHEHGteZq/vORKHMMjjSuE0Tcv4rCWXo3
 rEEw==
X-Gm-Message-State: AGi0PuZi4SLFb1nFMqplQevhDO6KvPYooR+mh/SD15/nEejoLCzaqO4B
 0fVV7LbAzFZcjrXHRngVqMArW37VlDs=
X-Google-Smtp-Source: APiQypLaK8hQAghusADmdDc1HZt6Tij51yXMTt15vTD9XDnLdnxIUsEH373ZJXyHLgbU5XGFgQEgTA==
X-Received: by 2002:a62:1c89:: with SMTP id
 c131mr14622572pfc.164.1589192056876; 
 Mon, 11 May 2020 03:14:16 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:14:16 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:42:53 +0530
Message-Id: <20200511101300.11101-17-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:14:20 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:14:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 16/23] parsing_cocci: ast0toast: Reflect
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
