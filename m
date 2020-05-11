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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0152FC54E8D
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8971F20720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8qND20r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8971F20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA8PTT006779;
	Mon, 11 May 2020 12:08:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E92557773;
	Mon, 11 May 2020 12:08:24 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E32AE3DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:23 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA8M9A021810
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:23 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id p25so4520410pfn.11
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+1Jx1GCzpkJYz5KJHR+2EEkLhsdfIdOz4vT4XJi1p5g=;
 b=K8qND20raiDMYWGc9hBPhjLeMzCbSDyiEEk9gJhUvl7mHhsSlvw9pwfm5u97EooNKP
 WwJSLtlDOJUQaQ6uYjU1kDhH2m6QVk8ukw+k7clMmpBqaszPgefX88ndlEplHSWp6wsp
 zc/wF6ypIY+sAVizVh263uzN2iMoA5tH4xecb/H370F5ZnbPFoz9dRRu2nxMloXFdu4J
 INoSnIYkczx7SqiVfpI8yHumUgxjizUYnGEXVM3PJ4B7BWx2rBiznfxOw7+8TFdN7Ivl
 eCB/k9mK2ojIJaF65FqVCLY5usIcxo0QQDUrZR+cPR19eMVF6lDcd1iVc/V8JSy4J8fI
 Vs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+1Jx1GCzpkJYz5KJHR+2EEkLhsdfIdOz4vT4XJi1p5g=;
 b=XUPsOw/SblwYZ9bO42w93he+y7s0nha+AQAonX//kdUixhAfG8AKVd1A6eQBiu6Mbz
 ZOEGAmpwrKyy4WRsMZET/qF6mlIJpcjvrk8oaC4vAIvderfa1+rWIEs1eD1nolt92pz7
 oeGYzKpgNzFW3ZNi8Wm84HDKq/Lt4153jRPfv8Rb3wSC+uCclmums45EI+2MyzGPZLEZ
 qVsqPDpYoSauRRvDngrkltvBYjPDpTYqKUVzPEXBkxMK8es7u2hdNrHGx8hPfIrDeBs0
 paG/yUVzg+ia4ayHYDuB3SeqE7/a7M2kQrmihfJMdMmy8TUNY1lQDwAmVc9bXqC31Xh0
 NZ1g==
X-Gm-Message-State: AGi0PubutwEfWZKNr0uvnsJAyKnGv+yHR9QvpMq4OatY2fHauQRfjWiq
 4W+595ukQgpePofBGaOnehW4cJA+Qag=
X-Google-Smtp-Source: APiQypIX6LNikNIHjT12JuagNMMKefabWKB2cK0FpcIhrHij65JzP4EIrHjs/SWLXwOJk/2su8+Lew==
X-Received: by 2002:a62:7c51:: with SMTP id x78mr14782655pfc.227.1589191701520; 
 Mon, 11 May 2020 03:08:21 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:08:21 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:36:55 +0530
Message-Id: <20200511100715.19819-13-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:08:25 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:08:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 12/32] parsing_cocci: context_neg: Reflect Cast
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
context_neg.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/context_neg.ml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parsing_cocci/context_neg.ml b/parsing_cocci/context_neg.ml
index dd768a61..b6378512 100644
--- a/parsing_cocci/context_neg.ml
+++ b/parsing_cocci/context_neg.ml
@@ -628,7 +628,7 @@ let rec equal_expression e1 e2 =
       equal_mcode pt1 pt2
   | (Ast0.RecordPtAccess(_,ar1,_),Ast0.RecordPtAccess(_,ar2,_)) ->
       equal_mcode ar1 ar2
-  | (Ast0.Cast(lp1,_,rp1,_),Ast0.Cast(lp2,_,rp2,_)) ->
+  | (Ast0.Cast(lp1,_,_,rp1,_),Ast0.Cast(lp2,_,_,rp2,_)) ->
       equal_mcode lp1 lp2 && equal_mcode rp1 rp2
   | (Ast0.SizeOfExpr(szf1,_),Ast0.SizeOfExpr(szf2,_)) ->
       equal_mcode szf1 szf2
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
