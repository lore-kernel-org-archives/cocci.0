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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1EFC54E8D
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B66620720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tix/5NW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B66620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA8e79021234;
	Mon, 11 May 2020 12:08:40 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 379B23E6B;
	Mon, 11 May 2020 12:08:40 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E25F53DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:37 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA8aWA023312
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:37 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id y9so1149360plk.10
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5ydkvxIkepDiYoSKkPkEhluyN99PFKVNQGZApVx5OTU=;
 b=Tix/5NW9TtYMKbcVlhqdkMS0wLaYQNd4PtMM+YZ9KswJOuujTEOve+1Y+Gk0CE+Qwk
 jDbsHPE74fZym02/jwqD84uyk/ltgc16AsGKoxdHhqCOUzlkoXjdxLS4h5/6LkBo63Ux
 I1PrZLcyky64F5JUw9ZTupaN7h+/+HJ37gdBx9Mrh1ofXW3QKCRwvS4ZI4gS4ksthjd6
 nYFmoTO2YDlIhYMeJskd32KyEbu3XvBznRUtu3t07hwkVo9wMclML3jRZm0/4SzMFIMy
 zd0ci/Q52Gva+Cwsn8wJB4mwigk5TU44GAPAvHCChZJ0zF/f+rJzcgPUFlHUDs7zTv4T
 w8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5ydkvxIkepDiYoSKkPkEhluyN99PFKVNQGZApVx5OTU=;
 b=iKqPFGbmwr+kBupMBawHqEcbLsF+OcOmfPUuLLkOO9nLeyfdsi5YK2yaMpnHKNphaF
 fActENK8wTK4BiE3AGvUaQOeJKBEAsnHfA39dy0HmaVf0syGOQNVasyV8Q2AbIQoXq4r
 +aJk3VgNRGxBtdyfJ17623InwQST86Lvgno70G74KHJ975+Q1Qp6gdukICYlCg7QWHOz
 ubuI4jHISuAmnoALaj3gnUiRMaVQCcSZ9WvOR8ltSPhdCwlcKHKUh2WHU+fuP+S+NAAi
 E8RgiDeVWpSOrAAjsVVjpj70rMieeTEXDBn3i4p1WB5kSMYUZvmWQygtqWdo6CxOA3kh
 CDkg==
X-Gm-Message-State: AGi0PuZc2so1RwW+z9EjXrigPsV8xIBjpswNKoElLvJ316laMqHfpTM6
 +8uacxdryYnU9OtOO24xUQgKPhtpumc=
X-Google-Smtp-Source: APiQypK6T0n3C+2oibpAfmDHL6GfcRjGUBElnKjJjbI2Wo2f2KeuKkhf8+GgT5VGk+D0xh/fxrcGew==
X-Received: by 2002:a17:902:5a8e:: with SMTP id
 r14mr14610306pli.81.1589191715445; 
 Mon, 11 May 2020 03:08:35 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:08:35 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:36:58 +0530
Message-Id: <20200511100715.19819-16-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:08:40 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:08:37 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 15/32] parsing_cocci: visitor_ast: Visit cast
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

Cast attributes are added to the SmPL AST. Visit these attributes in the
SmPL AST visitor.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/visitor_ast.ml | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/visitor_ast.ml b/parsing_cocci/visitor_ast.ml
index 8e530114..644bcd5d 100644
--- a/parsing_cocci/visitor_ast.ml
+++ b/parsing_cocci/visitor_ast.ml
@@ -198,12 +198,13 @@ let combiner bind option_default
 	  let lar = string_mcode ar in
 	  let lfield = ident field in
 	  multibind [lexp; lar; lfield]
-      | Ast.Cast(lp,ty,rp,exp) ->
+      | Ast.Cast(lp,ty,attr,rp,exp) ->
 	  let llp = string_mcode lp in
 	  let lty = fullType ty in
+	  let lattr = multibind (List.map string_mcode attr) in
 	  let lrp = string_mcode rp in
 	  let lexp = expression exp in
-	  multibind [llp; lty; lrp; lexp]
+          multibind [llp; lty; lattr; lrp; lexp]
       | Ast.SizeOfExpr(szf,exp) ->
 	  let lszf = string_mcode szf in
 	  let lexp = expression exp in
@@ -1184,12 +1185,13 @@ let rebuilder
 	    let lar = string_mcode ar in
 	    let lfield = ident field in
 	    Ast.RecordPtAccess(lexp, lar, lfield)
-	| Ast.Cast(lp,ty,rp,exp) ->
+	| Ast.Cast(lp,ty,attr,rp,exp) ->
 	    let llp = string_mcode lp in
 	    let lty = fullType ty in
+	    let lattr = List.map string_mcode attr in
 	    let lrp = string_mcode rp in
 	    let lexp = expression exp in
-	    Ast.Cast(llp, lty, lrp, lexp)
+	    Ast.Cast(llp, lty, lattr, lrp, lexp)
 	| Ast.SizeOfExpr(szf,exp) ->
 	    let lszf = string_mcode szf in
 	    let lexp = expression exp in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
