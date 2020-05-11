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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B07C54E4B
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66BAA20720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDPQBORE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66BAA20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA8m4D028410;
	Mon, 11 May 2020 12:08:48 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 025153E6B;
	Mon, 11 May 2020 12:08:48 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 78B8F3DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:46 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA8iv1026093
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:45 +0200 (CEST)
Received: by mail-pj1-x1044.google.com with SMTP id a7so7560652pju.2
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q9ypuI2Md0mVYC2/fR1d5UCBTOm19QzTtQ7LOldzd/4=;
 b=VDPQBORElUs0peBBwiTiBD2gWwBzpUtPziiXlpv5sNSzHnpdtkszruGuKPCAsfRYr0
 wP9i+NehVIC/56T8mt/WDzzG3bI45yL+nA6ODxbfigssLUqGy36ethEbRxaKo+wjE0tF
 Bw573iLt6zrg4/iz0Y9rWmpWwBOiEa76usv+U+R6UVAnKiveGGIKumzt93NwrVgAUrc0
 vFCaZ55evsaHRrZiFOl/j5/OF6g2gQaPcMe8lUrnwCePrYp5VREMGARTMQ4Ylmqd4Tzi
 YBJG/3pFkDw230BszFES6fq/YEagiL79u4M4xk+lbvqJRrINuNwRhr1xgGc7qojt6jWE
 aWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q9ypuI2Md0mVYC2/fR1d5UCBTOm19QzTtQ7LOldzd/4=;
 b=faZISXuK8H57umx3kgJG26fq0Irg2NOQ4o/RL6zIuLKUr/PPf//yh/2U4H2ryLFyec
 7kQtnG/GLAglAK90G9MbEgWavEdimJCn9/cYti71SFYQLWmARzxs8NZJVu2PdxIwzDAT
 wv2ZLZ0+pagwJIvfXQfd/ns3sj4y58ywwWCABzTEh1KIQvFQGBoc2JvPqqMVqw6EPvqp
 3mx7ZWfwoNmllLLi6aTqDf3+j9XbS+iiK3gi+wQNJK1acRxKX0iXYgSJq2BoEsY83yZx
 wGqPsfEjvK2eSMdjHx+0sKE3hKuTFgWJI9S9a8dhDXSN26EQRUTO5c8fCaNR8LnSFSBL
 h6Jg==
X-Gm-Message-State: AGi0PuZ3fJY/QEWyWF0HRx/k157GSUks0TgAw/tKvLy7CcJ3G1LRT8T8
 paE3ijcYuYClXZT9xKy70yK/1URySrI=
X-Google-Smtp-Source: APiQypLCV2GQU6UAA3/60duuEtJe6FT30ZHfkKg8NF6S+4S8yIvhypy11Q/lpPIJCIVwt+gojjD1UA==
X-Received: by 2002:a17:902:527:: with SMTP id 36mr9755108plf.69.1589191724013; 
 Mon, 11 May 2020 03:08:44 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:08:43 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:37:00 +0530
Message-Id: <20200511100715.19819-18-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:08:48 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:08:46 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 17/32] parsing_cocci: ast0toast: Reflect Cast
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
ast0toast.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/ast0toast.ml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/ast0toast.ml b/parsing_cocci/ast0toast.ml
index 09c28c06..56f684ee 100644
--- a/parsing_cocci/ast0toast.ml
+++ b/parsing_cocci/ast0toast.ml
@@ -439,9 +439,10 @@ and expression e =
 	Ast.RecordAccess(expression exp,mcode pt,ident field)
     | Ast0.RecordPtAccess(exp,ar,field) ->
 	Ast.RecordPtAccess(expression exp,mcode ar,ident field)
-    | Ast0.Cast(lp,ty,rp,exp) ->
+    | Ast0.Cast(lp,ty,attr,rp,exp) ->
 	let allminus = check_allminus.VT0.combiner_rec_expression e in
-	Ast.Cast(mcode lp,typeC allminus ty,mcode rp,expression exp)
+	let attr = List.map mcode attr in
+	Ast.Cast(mcode lp,typeC allminus ty,attr,mcode rp,expression exp)
     | Ast0.SizeOfExpr(szf,exp) ->
 	Ast.SizeOfExpr(mcode szf,expression exp)
     | Ast0.SizeOfType(szf,lp,ty,rp) ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
