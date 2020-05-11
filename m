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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60600C54E8D
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E0020720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh+LXt+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E0020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA8pKh022994;
	Mon, 11 May 2020 12:08:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7C8E03E6B;
	Mon, 11 May 2020 12:08:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 286FA3DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:50 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA8mLT017858
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:49 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id k19so3733836pll.9
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P7a3ovJfYqH7rlgS40CehEM91vUo6sSt21YTgxgCWwc=;
 b=Kh+LXt+39Cxq2KUVUoHnFAD9YIN0H45fLzNmDihbp7vusdsxOE7KCRdyn25uPL/vcf
 OtWXw7kxCq6G/dfKiyiB6zZoGN9bZoDLP+5lFKnXsxG0VnT3+MYrxyBVvOgwrlhJBVlF
 iHVLghy3ml3T2dXLGFkt/h8dFhMoNYpAGjmJBEuXA8OwGIHsrs84YuuQeV+Zl1jhq0Ie
 1+f87Fl5Nh4Hht5wI+30IhTg6TiOYkLQ6pJeHjCQw/Hl2tLxodUXFHsIyc0wDnRRnvlQ
 AYlhEgn/YuUay9NPocmcPxGjnowDzPZWs4cS1x6RcmUSI2pbpl9PDjwkAKG0kVdjmoI2
 YEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P7a3ovJfYqH7rlgS40CehEM91vUo6sSt21YTgxgCWwc=;
 b=NGhRCgxAC74BlH42xZsHrYenKep26txz2xFyACxebdkg4lGVoXSPL43S0z6Zq9wW4k
 6+oBUWZo346eZyS8u2wbdDJDacHx7tyeFzMnwZpSJBb2XRqo0blgS8nJfeEncn2ghMdv
 UsWwoVVS1A6aWJh/6lNYWoOipEtf0kRl75LIP4/p8MQrwN5o3nHXxqOQs2wffunh2X07
 v4gsCtFndeThGZ5LW6vg8dK4HHt8v186QezOVNCtohwlOo1Ks2oOVakyM+7NVHKiNNqT
 J9hZsEzswLd4fjz/+Cfm2Of5fjcD14M8OO8HD/BFOzkLn8JN/hw8hl5jJHgaepmxUzaC
 +iMg==
X-Gm-Message-State: AGi0PubUGFFtISH4fjJkjtOsL7193RDHV37NJdVvou6QL+tDiOSLBF9p
 N5xIJ6OlzMpaL/Pa/vhva32L2cnJYSk=
X-Google-Smtp-Source: APiQypKQllK9mPpgoFhUEPJ7/dt/yrKEUxnuG3lMWILzxCfpMnr4uBkB8YTUR/zfqxAf9qR8MH2NQw==
X-Received: by 2002:a17:90a:7065:: with SMTP id
 f92mr21208721pjk.160.1589191727809; 
 Mon, 11 May 2020 03:08:47 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:08:47 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:37:01 +0530
Message-Id: <20200511100715.19819-19-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:08:51 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:08:49 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 18/32] parsing_cocci: disjdistr: Reflect Cast
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

Cast attributes are added to the SmPL AST. Reflect these changes in
disjdistr.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/disjdistr.ml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/disjdistr.ml b/parsing_cocci/disjdistr.ml
index 6724bb25..e171e6ea 100644
--- a/parsing_cocci/disjdistr.ml
+++ b/parsing_cocci/disjdistr.ml
@@ -219,9 +219,10 @@ and disjexp e =
   | Ast.RecordPtAccess(exp,ar,field) ->
       disjmult2 (disjexp exp) (disjident field)
 	(fun exp field -> Ast.rewrap e (Ast.RecordPtAccess(exp,ar,field)))
-  | Ast.Cast(lp,ty,rp,exp) ->
+  | Ast.Cast(lp,ty,attr,rp,exp) ->
       disjmult2 (disjty ty) (disjexp exp)
-	(function ty -> function exp -> Ast.rewrap e (Ast.Cast(lp,ty,rp,exp)))
+	(function ty -> function exp ->
+          Ast.rewrap e (Ast.Cast(lp,ty,attr,rp,exp)))
   | Ast.SizeOfExpr(szf,exp) ->
       let exp = disjexp exp in
       List.map (function exp -> Ast.rewrap e (Ast.SizeOfExpr(szf,exp))) exp
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
