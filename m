Return-Path: <SRS0=O8dQ=7N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4393C433E1
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5468D206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXU8HhXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5468D206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFRPtn014976;
	Sun, 31 May 2020 17:27:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0A761781F;
	Sun, 31 May 2020 17:27:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 495347752
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:22 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFRHoO013780
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:18 +0200 (CEST)
Received: by mail-pj1-x1042.google.com with SMTP id q9so3798094pjm.2
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iY7kMVY/Z+foJLhK7iFtUpr4n6aNS/lYGHg0U3Vn48E=;
 b=ZXU8HhXUCE6wXufjJuycR4e5LvY7Zlw6E6Ia6F9SkqIhIk+usS7hFVCgob+ihReAjD
 O/Nq33Q6t+Sg9fdYWs2G+UuUjMjzGAGD8e3LdZGSPBT+kgVYqKmJ2M51MCLbkSHwXSk5
 Xq0P2y4dZacEnPrmdbJAWVQRFOSq1BskSM8sjjXI/7LYLOXXKHcGx53ad2bEzNC0EutB
 wRFnPDfJNMDTeCoXH3KaYfM2Le+a0LM0VCo0WjCkGYfLKunAPdKnh6On1J8gQS4SLOoE
 3fUPcsPcYh4h1MGlAbPVA3b1UzNp/rAd97ghnowIkxb+PrOb3ONcMmbydRkEAwRPKSAO
 PT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iY7kMVY/Z+foJLhK7iFtUpr4n6aNS/lYGHg0U3Vn48E=;
 b=IbQ8XjQUstSuHs8jqd4oA7fotLyBVo1WzIenoSPHbXXzUDMuLUqRDlfEca6D6a0OqI
 qHFB5EYMX3WuH/tv1uXWO0EQa1ghPlUEc0SeocAvcY72ABo+KpH19qdHj6NCdDOFAbBt
 PokoFOr59COGEd1burjuozr3StwmgAJXwUmDvkg+POkq4y2P2QOMVRyFyD6kw8DAZ9EB
 uSUMCrXv3Z8XxbWFU5RI7StVehlybPJ7/XWc5zdaUosuhTW2LQlIuC+ChvGuBXfWW7Z5
 TEqrYe5avg3KIj1qnM1IARc/5lNxO3+9kXpDjec6+JNx+IojHhfs7NAao298oajoRObZ
 481A==
X-Gm-Message-State: AOAM530soxHuSP6u7TMMbBD/uYfoUx/6ZH9HrrKawL2q6yYFKJD794lv
 DxPHjbfRTGSPw2B0y9riW1/ufF3Etio=
X-Google-Smtp-Source: ABdhPJz2F0z/xLpwBfbQpnfAjKiyud4F3fH3QK+lEI7zMdqybC6yXfBeEUcY1boZwnVgc7scevtuzA==
X-Received: by 2002:a17:902:d883:: with SMTP id
 b3mr16705000plz.133.1590938836446; 
 Sun, 31 May 2020 08:27:16 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:27:16 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:55:58 +0530
Message-Id: <20200531152621.2886-5-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:27:25 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:27:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 04/27] parsing_cocci: unparse_ast0: Reflect struct
	end attributes
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

Struct end attributes are added to the SmPL AST. Reflect these changes
in unparse_ast0.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/unparse_ast0.ml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/parsing_cocci/unparse_ast0.ml b/parsing_cocci/unparse_ast0.ml
index ebe8084a..81bbb71a 100644
--- a/parsing_cocci/unparse_ast0.ml
+++ b/parsing_cocci/unparse_ast0.ml
@@ -440,7 +440,11 @@ and declaration d =
           print_string " ";
           mcode print_string eq; print_string " "; initialiser ini;
 	  mcode print_string sem
-      | Ast0.TyDecl(ty,sem) -> typeC ty; mcode print_string sem
+      | Ast0.TyDecl(ty,attr,sem) ->
+          typeC ty;
+          (if not (attr = []) then print_string " ");
+          print_between (fun _ -> print_string " ") (mcode print_string) attr;
+          mcode print_string sem
       | Ast0.Typedef(stg,ty,id,sem) ->
 	  mcode print_string stg; typeC ty; typeC id;
 	  mcode print_string sem
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
