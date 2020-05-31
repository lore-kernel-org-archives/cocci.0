Return-Path: <SRS0=O8dQ=7N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB15C433E0
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA92A206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPcV3klT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA92A206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFRq2I020622;
	Sun, 31 May 2020 17:27:52 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 445A77752;
	Sun, 31 May 2020 17:27:52 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 675793C89
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:50 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:644])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFRmj7012156
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:49 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id y11so3213340plt.12
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wESlDUXuHBg14Mcr12cBcG8rr8tsnmhzigRKGJW73pc=;
 b=nPcV3klTi2ct5LnQ3C7a3X3BMa2qmeAx1P7Z1gsu/EkgbMAbRU+A1mwZErODvoYuyu
 ApPveX8lxF0GVxy5RZen649AOwqlCrkCrr7c99x5U8CN8PZMWj4hXRlqnKGQBLu1g59H
 lyFYDDORmuJPUBXcgzyNqr8VH591yb2Mc4wyHSrrlRLUby1FHJfp7Be3HfB6k7hqsCRy
 +YaAlxZF4zCiYhDrpUxGhJvCbZXpvFQrI9hu9MhJJSXpIMFchwNpIFjMut/6pm6U2HjC
 B0mt1CGFZHfdSQ1YzXYvo7xNsetAbv9KOEhWcxRexSo+KLfUB/NmIftWA4SsObM1LszB
 i6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wESlDUXuHBg14Mcr12cBcG8rr8tsnmhzigRKGJW73pc=;
 b=NDPEtMbI40V3cxU0R8QxVd7hlZChTWp6O1xUzGljHlSV3BnYpscKCqpGSu6z3hqFXn
 +9E0m1xihK7x5nbLa5m7aFlBUxiv3Ln+8VIyJfZC8eUpGF/kUiBhNenAc5xB562IDJVi
 kL6adTtOiOD86Y6SymB8lSZL8fCah/tR9OjQkURe5Ccjc7yswgdRDJSE82VWNGB+lGX0
 gld7vb7I8ESCNsoj72S3DXcpLN1F8kVtfIle87ct6kkr1Ww1/Hppe3rZ+wz7hmy7GL2X
 jJKMEA6hAi02rcZVZ0P4K0aIT17QyT9aTHP9vprbHOafmr3S2kdcif0ZOo9koMzsiKAj
 3WPg==
X-Gm-Message-State: AOAM531Kz1tjxQuchlCYKHKge5qP3i5QRJE7aypLgv1ETWbYwQTSAhKc
 xWwf/oKNcRx4bum0/XJy4FpFdO0E
X-Google-Smtp-Source: ABdhPJzmgEZCoim+kBwdVjprXZA9b5QUu1MZsXJXvkwvKfnInx6006ChDvUR8HWSXrmnUfmpHMVJDQ==
X-Received: by 2002:a17:902:bb85:: with SMTP id
 m5mr14293924pls.23.1590938868063; 
 Sun, 31 May 2020 08:27:48 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:27:47 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:56:08 +0530
Message-Id: <20200531152621.2886-15-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:27:52 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:27:49 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 14/27] parsing_cocci: visitor_ast: Visit struct end
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

Struct end attributes are added to the SmPL AST. Visit these changes in
the AST visitor.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/visitor_ast.ml | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/visitor_ast.ml b/parsing_cocci/visitor_ast.ml
index faadfbb9..8129bcda 100644
--- a/parsing_cocci/visitor_ast.ml
+++ b/parsing_cocci/visitor_ast.ml
@@ -490,10 +490,11 @@ let combiner bind option_default
 	  let lini = initialiser ini in
 	  let lsem = string_mcode sem in
 	  multibind [lstg; lname; llp; largs; lrp; leq; lini; lsem]
-      | Ast.TyDecl(ty,sem) ->
+      | Ast.TyDecl(ty,attr,sem) ->
 	  let lty = fullType ty in
+	  let lattr = multibind (List.map string_mcode attr) in
 	  let lsem = string_mcode sem in
-	  bind lty lsem
+	  multibind [lty; lattr; lsem]
       | Ast.Typedef(stg,ty,id,sem) ->
 	  let lstg = string_mcode stg in
 	  let lty = fullType ty in
@@ -1448,10 +1449,11 @@ let rebuilder
 	    let lini = initialiser ini in
 	    let lsem = string_mcode sem in
 	    Ast.MacroDeclInit(lstg, lname, llp, largs, lrp, leq, lini, lsem)
-	| Ast.TyDecl(ty,sem) ->
+	| Ast.TyDecl(ty,attr,sem) ->
 	    let lty = fullType ty in
+	    let lattr = List.map string_mcode attr in
 	    let lsem = string_mcode sem in
-	    Ast.TyDecl(lty, lsem)
+	    Ast.TyDecl(lty, lattr, lsem)
 	| Ast.Typedef(stg,ty,id,sem) ->
 	    let lstg = string_mcode stg in
 	    let lty = fullType ty in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
