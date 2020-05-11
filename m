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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAA5C47255
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A07582075E
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMwi1ZUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07582075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BAESKK028124;
	Mon, 11 May 2020 12:14:28 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4789F3E6B;
	Mon, 11 May 2020 12:14:28 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7C4333DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:27 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BAEPsu025976
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:26 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id f15so3745486plr.3
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LiameRiyJLzWrc6OD69O6jqN0a7XU1kU6x01nq1+tvI=;
 b=bMwi1ZUVslR2u55Nk9yAXoKqJ4AdYGnG/lHKDET8XgXIXxSb3KNePb6cksxPM1yAH2
 miqWyjweb+RtWTrbBKJl+268nV6xbJEU452PiAJuwAuDv3it/zVkmC2mJiqrbR8v7VOl
 TgjxqYFstWVanzFdCVnwIFyZC5XRF/G7OEuaXrMLJ8MU9sMPMOkMS+uIqriNK3Cb6tvJ
 aJ7QzvuE7HIHUzgGVCBuroovM1BuNvAYTegUGtJOEW4WP0tfq+BSCFZDBH0dMRXn2FOJ
 Q0BYktb5YAVjGjvUIukj7sxfQknSNV03j5Bu8y4duERXY6ioUxs5p4hOyVI6FFgYQATz
 5rxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LiameRiyJLzWrc6OD69O6jqN0a7XU1kU6x01nq1+tvI=;
 b=EpmRbnGWlaJaA4hDiMVxYDXKiA2DU91uuunYzPLJtfGeGZkkuQYIgTPPRPunNsz0Cl
 Eq2OGsBoup2i1VntamxlFIPZBXkNkpMTmWl3IOywwiTG6C+R2uIXsZMhgluRl/gWRSC7
 f3X0pE4XTRuRz3Fx0mkpHI3nQKPMvtdZEw6ykR6PsTTp2q7Txy3Ybx4rB/vvmzVr1LnZ
 Aj23vOZkRqbf5xy8sQH4CkzIzv10HExTczHbuvHekJyvz0mJ0BjZPG1iPLVFQ6VNit66
 jl6zaussT09cuqXA9SyIS3/83z/oNxl7qCoGAxsk5JTNlo2xRq8oDR+qWHoxrHpV3yB8
 DWuQ==
X-Gm-Message-State: AGi0Pubh/z11qJJQiLHe5OGB7Vn6VLjxmBbl4XxTsyWZdZIsu0rPggGf
 Mb0BezYjVwfJTTvdaxkuydzyWXSTAAs=
X-Google-Smtp-Source: APiQypJXvGkQpAzb1FtNR+vS1aQ2Sgaq1TcUZhK1oGM5TQmK/LH3x/UP9Euqeas24pZam+CZiUbzgw==
X-Received: by 2002:a17:90a:216b:: with SMTP id
 a98mr20981013pje.235.1589192065055; 
 Mon, 11 May 2020 03:14:25 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:14:24 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:42:55 +0530
Message-Id: <20200511101300.11101-19-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:14:28 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:14:27 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 18/23] parsing_cocci: pretty_print_cocci: Reflect
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

Parameter attributes are added to the SmPL AST. Print these attributes
correctly in pretty_print_cocci.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/pretty_print_cocci.ml | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/parsing_cocci/pretty_print_cocci.ml b/parsing_cocci/pretty_print_cocci.ml
index 7628882b..a9eb4a8b 100644
--- a/parsing_cocci/pretty_print_cocci.ml
+++ b/parsing_cocci/pretty_print_cocci.ml
@@ -688,9 +688,18 @@ and designator = function
 
 and parameterTypeDef p =
   match Ast.unwrap p with
-    Ast.VoidParam(ty) -> fullType ty
-  | Ast.Param(ty,Some id) -> print_named_type ty (fun _ -> ident id);
-  | Ast.Param(ty,None) -> fullType ty
+    Ast.VoidParam(ty,attr) ->
+      fullType ty;
+      (if not (attr = []) then print_string " ");
+      print_between print_space (mcode print_string) attr
+  | Ast.Param(ty,Some id,attr) ->
+      print_named_type ty (fun _ -> ident id);
+      (if not (attr = []) then print_string " ");
+      print_between print_space (mcode print_string) attr
+  | Ast.Param(ty,None,attr) ->
+      fullType ty;
+      (if not (attr = []) then print_string " ");
+      print_between print_space (mcode print_string) attr
   | Ast.MetaParam(name,_,_,_) -> mcode print_meta name
   | Ast.MetaParamList(name,_,_,_,_) -> mcode print_meta name
   | Ast.PComma(cm) -> mcode print_string cm; print_space()
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
