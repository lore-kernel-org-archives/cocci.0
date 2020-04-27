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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6D0C7C8A0
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C8E20656
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt9FvGmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C8E20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RC9fnw002369;
	Mon, 27 Apr 2020 14:09:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C32ED7807;
	Mon, 27 Apr 2020 14:09:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A2AD07769
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:39 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RC9c8P015462
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:38 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id t7so1001516plr.0
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 05:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UvHa+JnzOSwV06PrvaE7jD1s2TVcEm/6dw+RStRj2F4=;
 b=Pt9FvGmzwq78DXZ+zdBTr65mGm3QzIIwg49HtSsqiy4wpaTLPmkt4pbMD4GV8Kd+et
 4B/hBbDrYZiczDKCAk3MXwoPLYLeevW8fB1oPq97PIzk4YNPbReYH5KbrsK5feEchhV7
 8eGzECv7vi3FrTYK/UfgcabKfjBf4TgILuU+QxidUHJ/EmRUg28UvCKoEAxvhvv6hE1t
 Y8F2fMkdiPxpnKt/ngCiF6R6e7DI0bSLY8tPl6kRzZs5A7O1JFRWiFaySD1EE3+5w7I7
 Ad7huZGu5rkTXcAJ7uIrTk2nCDy/46i5EDT9hfO6kAId567PQScl9lH/WiYh+9swm36Q
 K2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UvHa+JnzOSwV06PrvaE7jD1s2TVcEm/6dw+RStRj2F4=;
 b=H7ECDuLro8apmT3f5hXjFFly7wGq0KyPyez88MkNZ+EZmeq+c217qSIuhFmW/6ub5X
 6peZwfLYUSQOZfTrEb5ScYmuJ4yNWZGROzv/7H19VlQk2hompMCGvoPll/QlRpD+PCPY
 RkKlFjjX2Dyg0AyD6AsxcpY+3QjznSq21zzfnJCOM2u8mwC3m5OwRcAnre7a0gP3Jus5
 Y2oHB1RLqZBa8s/tJtPIICD0w41lFVzvmSgvlkuEtAOGUOcsNy18ahE8ELX3VTpFuT7X
 fNXj4EhLqmGw/TKVidGtvNHJNMeebxEYFvI0zL2GjzSNx3P0+azKTfuRMb6I3gAJQtbI
 b+xA==
X-Gm-Message-State: AGi0PuYKw85ys/9ToTclFp/qy1W7+7nq9JIAMpNUhYmZp2WtCuOtVams
 5bKZg+RH85o6+qDUxtuGsAoOlFIty30=
X-Google-Smtp-Source: APiQypLm8ctJ0+LH8caGKQZdrqUw/p2NZa6frop0eGbmRYDLgfR6bKMabZXaBaCE18sANhj/RFeAVg==
X-Received: by 2002:a17:902:b08e:: with SMTP id
 p14mr7189929plr.326.1587989377236; 
 Mon, 27 Apr 2020 05:09:37 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.114])
 by smtp.gmail.com with ESMTPSA id r17sm9623885pgn.35.2020.04.27.05.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 05:09:36 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 27 Apr 2020 17:38:23 +0530
Message-Id: <20200427120834.380-13-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 14:09:41 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 Apr 2020 14:09:39 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 12/23] parsing_cocci: unparse_ast0: Reflect
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
unparse_ast0.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/unparse_ast0.ml | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/parsing_cocci/unparse_ast0.ml b/parsing_cocci/unparse_ast0.ml
index fdaf6cfa..738549fd 100644
--- a/parsing_cocci/unparse_ast0.ml
+++ b/parsing_cocci/unparse_ast0.ml
@@ -546,9 +546,18 @@ and parameterTypeDef p =
   print_context p
     (function _ ->
       match Ast0.unwrap p with
-	Ast0.VoidParam(ty) -> typeC ty
-      | Ast0.Param(ty,Some id) -> print_named_type ty id
-      |	Ast0.Param(ty,None) -> typeC ty
+        Ast0.VoidParam(ty,attr) ->
+          typeC ty;
+	  (if (attr = []) then print_string " ");
+	  print_between (fun _ -> print_string " ") (mcode print_string) attr;
+      | Ast0.Param(ty,Some id,attr) ->
+          print_named_type ty id;
+	  (if (attr = []) then print_string " ");
+	  print_between (fun _ -> print_string " ") (mcode print_string) attr;
+      |	Ast0.Param(ty,None,attr) ->
+          typeC ty;
+	  (if (attr = []) then print_string " ");
+	  print_between (fun _ -> print_string " ") (mcode print_string) attr;
       | Ast0.MetaParam(name,_,_) -> mcode print_meta name
       | Ast0.MetaParamList(name,_,_,_) -> mcode print_meta name
       | Ast0.PComma(cm) -> mcode print_string cm; print_space()
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
