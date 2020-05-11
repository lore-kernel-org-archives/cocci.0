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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92F3C47255
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:13:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ECA520720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u4gEnup6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECA520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BADX51002509;
	Mon, 11 May 2020 12:13:33 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1ECB73E6B;
	Mon, 11 May 2020 12:13:33 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D7C633DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:13:31 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BADUXo029010
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:13:31 +0200 (CEST)
Received: by mail-pj1-x1042.google.com with SMTP id mq3so7632173pjb.1
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wngLDj53d40UAfdANhcc9OYS/iaJ7M2lYJl5+hepAbA=;
 b=u4gEnup6F2WC4iYWFP0kwOVZrO5oe7C0Jve532TLU6gahqW9eZXYZFfJJK3T6miu9c
 CPlOpkddPwxcVfHolR2SDo4CP78bjdooSluPml4x2DDzEbz4JfN2Ts4BX46aZ2Uj9a1S
 6H18DkZnqsnd68l4b9InnweAA6jKPsu5siT9JMvKw2TFYumlamhXou6kh7aO9NE1GzKJ
 y7HERPj7Trytdnb6H7p+5xIOIidcWk70Qk9V9vSMWrEJUFJrjlxJIC/1z32OUfl5t/mg
 mmwr0XMIxvuqW/hCsLGkranCt/ypP8rX0pi5ZJXJE5YMHCgRgKER38xELr3nEqklHMQ6
 hIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wngLDj53d40UAfdANhcc9OYS/iaJ7M2lYJl5+hepAbA=;
 b=LOLH/mpIrB9MmA+aKKJYxEL84UokfaVoer3oxUDdOp6Mj9f6cutzsD4LZWFWsmAO6e
 TdXwk4kZV7eWE6IO9/OZUx3C9E2pnxsmBJH/8QoEEgYdV4DUf7f7W5xo2/Ry0nl72sF8
 soI0iwvAs2gPHoKMluRzBmwLpjddns+mPReCRt+1BAudTMNnM/ubD3Uo2QKyVstJ/nxZ
 1j0gmLOFqwZjT1tDtZDQ/SSPdrByN7ke+1hBOcrq0gnz7dhq8QCfQua5R3z2Shb0IAvx
 mC4EIm+WsFDbQogpFX2eeeesFFKfKq5jm6+oAnW9rgKEanOB3OBUXZqagK/vejDszOPY
 ZDBw==
X-Gm-Message-State: AGi0PuaNiOp7iJbhp0j3S1ZSLdXQHUbbVVFnrO3sxk9Di3pzexaGDdSP
 oExtLSofq5N8Qu7eQRuhggySmtwLa6M=
X-Google-Smtp-Source: APiQypI1Oxvcnh0F8j08HTC5e+9PaLLa4hDEhq6aGWozTck99Xhwo8LbaVv4UG7g/66E2zTxnaCMsw==
X-Received: by 2002:a17:90a:d086:: with SMTP id
 k6mr22579779pju.47.1589192009489; 
 Mon, 11 May 2020 03:13:29 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:13:29 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:42:40 +0530
Message-Id: <20200511101300.11101-4-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:13:33 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:13:31 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 03/23] parsing_cocci: visitor_ast0: Visit
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

Parameter attributes are added to AST0 of SmPL. Visit these attributes
in the AST0 visitor.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/visitor_ast0.ml | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/parsing_cocci/visitor_ast0.ml b/parsing_cocci/visitor_ast0.ml
index d9e340ed..d6feccb7 100644
--- a/parsing_cocci/visitor_ast0.ml
+++ b/parsing_cocci/visitor_ast0.ml
@@ -826,14 +826,18 @@ let visitor mode bind option_default
     let k p =
       rewrap p
 	(match Ast0.unwrap p with
-	  Ast0.VoidParam(ty) ->
-	    let (n,ty) = typeC ty in (n,Ast0.VoidParam(ty))
-	| Ast0.Param(ty,Some id) ->
+	  Ast0.VoidParam(ty, attrs) ->
+	    let (ty_n,ty) = typeC ty in
+	    let (attr_n,attr) = map_split_bind string_mcode attrs in
+            (bind ty_n attr_n,Ast0.VoidParam(ty, attrs))
+	| Ast0.Param(ty,Some id,attrs) ->
 	    let ((ty_id_n,ty),id) = named_type ty id in
-	    (ty_id_n, Ast0.Param(ty,Some id))
-	| Ast0.Param(ty,None) ->
+	    let (attr_n,attr) = map_split_bind string_mcode attrs in
+	    (bind ty_id_n attr_n, Ast0.Param(ty,Some id,attr))
+	| Ast0.Param(ty,None,attrs) ->
 	    let (ty_n,ty) = typeC ty in
-	    (ty_n, Ast0.Param(ty,None))
+	    let (attr_n,attr) = map_split_bind string_mcode attrs in
+	    (bind ty_n attr_n, Ast0.Param(ty,None,attr))
 	| Ast0.MetaParam(name,constraints,pure) ->
 	    let (n,name) = meta_mcode name in
 	    (n,Ast0.MetaParam(name,constraints,pure))
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
