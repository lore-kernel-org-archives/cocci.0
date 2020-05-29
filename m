Return-Path: <SRS0=Yx51=7L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796AFC433DF
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:09:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D96206F0
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF41EDmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D96206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04TC9cAj013754;
	Fri, 29 May 2020 14:09:38 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4F5197783;
	Fri, 29 May 2020 14:09:38 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 03ACC5D47
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:09:37 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04TC9ZSn005493
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:09:36 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id bg4so1101078plb.3
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 05:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hP8DWHEVvYyvtFvTLwpy0ZStITBukfwThcNKgQpsO/I=;
 b=bF41EDmUec2E/a3ceUjeD7SwVI5+Ok8OdfqOP+kpdJXultCZRlI9jVmKn5nss7UQbQ
 h59yG+L6W4xrNA+emX+W0J83yh7wFj/H/dlyGK5admq2w2FZQVQnONjbZBlzScrz7VoM
 EEy0m5njv17eH7ny20RSXdXYUzw2R6ExoO2/HZRgXCjPBYV3zYVqDpx2IWOMb6B3QInf
 MA/vY+/TJWRL5mpFvRG0KLf+bxxlXxBAtEYXAb/Go5/yjD7zd9eMe9RGbyII9f0aeW+Y
 03og8WZhWwF9r3FXq+aRie0fGkVnuciUtemrMr6hVCnO2iY6D4WNW7ZDa3qC1kzqhCe7
 7gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hP8DWHEVvYyvtFvTLwpy0ZStITBukfwThcNKgQpsO/I=;
 b=GC6a0w7tGgNzTvxtEGu4J61Fsav97FJBgSZ/TucI51/M0gC/ZOtqYVfUcgcmj8eleH
 wkogTx0iNBUxgzE+c9DucrNoK2dKJXwt9VnYk21Le58QQYkhx8UaxQPKjnOQxIKkNoul
 8CwAEOT23TrWmng/BnB3PVrTN3KB1ev8Y7jufdkyumJLxVIC8Khx35uF0kTa5uisKHmA
 cLEDng/4SeyLNcQP0XFDQWa28dVb9tacB9HdWRt74aIbqBJi6nx6eC6tr7hnNHjPAZD5
 QtHRpVA5Zb83sXJ6gun2pTQNSJW+zJv7EuP4Fwa8ydWbVcpfL7j2GylJWy34B6wo2JbH
 Eh5A==
X-Gm-Message-State: AOAM531Fqv49ZZ+DcxDLODwJ1OZxmOgUxQLS+srQWObq7wlCzWYh+BbR
 fh1Co7ayy7qIZEp90UoPc0+ar3Kp
X-Google-Smtp-Source: ABdhPJzMsQpGqJ7pO1DSP26XCclo4b45zEOPgT0NIXxl9xmQb5myXW+WGLR553jRNgI3V+Vt1/Q3lw==
X-Received: by 2002:a17:90a:21e5:: with SMTP id
 q92mr8313410pjc.63.1590754174539; 
 Fri, 29 May 2020 05:09:34 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:694:e576:19d1:a79b:707d:59f2])
 by smtp.gmail.com with ESMTPSA id dw13sm7975161pjb.40.2020.05.29.05.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:09:34 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 29 May 2020 17:36:48 +0530
Message-Id: <20200529120703.31145-19-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
References: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 May 2020 14:09:38 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 May 2020 14:09:36 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 18/32] parsing_cocci: disjdistr: Reflect Cast
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
index c868cb1c..12e3d164 100644
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
