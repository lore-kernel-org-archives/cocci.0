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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA71C54E4B
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CFBA20720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFLfuCp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFBA20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BAE5IM014296;
	Mon, 11 May 2020 12:14:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BC3993E6B;
	Mon, 11 May 2020 12:14:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 17EA93DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:04 +0200 (CEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:443])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BAE2sv025430
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:03 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id x77so4545633pfc.0
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x2LB1W7SZNovzatDWHiYGdfEM78OJ6e3zHBVrPfzpJE=;
 b=eFLfuCp5+OUhXiLdPkHKYzO3SCm06LG9T59ps0nkpnRiqKY62J624/Y0QKL8k/d7HF
 mPDZLK8l19jZZZ6EV6eInM0KK5BrTuMtWns8l4ikpCkwWLtJ9Zk/FWLAheieIEUOGSw1
 52rf1o+4PFHRqNGX1G2W0JgvdHYH5hP0Bo9YWF0Jm4h0CNL7Lh1b38HcquScX63xUPCn
 M5jfRickxRxu7RYNM5htR7rlHmpcEnrKkxYWBABNlhZOEu5iUAhChZWhXiVVuG32Fitj
 Qx+S4f+Xqq3To0QrWCBnnwFzh+l9EKXevlXHWJRBhy1XaCK6VwZsKsba1t7VrLuI6hmt
 1zXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x2LB1W7SZNovzatDWHiYGdfEM78OJ6e3zHBVrPfzpJE=;
 b=lZHPoKl85Src2bJRup/VgHp5sRtMz1oTwwtvxApGtNOCdMGNm2c0K7dD5hOBNFq59E
 BRieFd9LxvkhS/lsC25PoOKdRKXlSB7BEspA1TfiM+oXBUA3NyB/+Qt65Wxqy+UZaBgo
 Yl5BYwtr+naeBMsV75AgVKhYJCVSE/HUMvGGCtH1dpK/QyXJEJ9danuU/q5emjIcGySy
 gz9mofwCQL3bPdO1Y/tz5Lu8nzSrNnlzFuNkrBRuFJFFIskDVmG1q4oMIlCqRFe+r4i0
 T3Mq968DH3d+qyvaLtzxRRqXDvTFRrra4nEisiVyep5IXUmjzYQkKIqAYcy9fMUFQeqA
 UhJQ==
X-Gm-Message-State: AGi0PubK6bw/ztqeR3It/uHmMtvScCyeSJfroVtOw2B+wEvZqT5Z2/L8
 RkMjozZDYzJEHiVqybkQSz82rWKcXt8=
X-Google-Smtp-Source: APiQypJrFIJUFJhSqXnYxGMvBtY9LcZB5HgDgWCPOK1T9ccJ0LTQZbWmZOFzBG+r6/lkH+wgxPkwLg==
X-Received: by 2002:a62:1415:: with SMTP id 21mr15108170pfu.203.1589192041556; 
 Mon, 11 May 2020 03:14:01 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:14:01 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:42:49 +0530
Message-Id: <20200511101300.11101-13-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:14:05 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:14:03 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 12/23] parsing_cocci: unparse_ast0: Reflect
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
index fdaf6cfa..86b545b9 100644
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
+          (if (attr = []) then print_string " ");
+          print_between (fun _ -> print_string " ") (mcode print_string) attr;
+      | Ast0.Param(ty,Some id,attr) ->
+          print_named_type ty id;
+          (if (attr = []) then print_string " ");
+          print_between (fun _ -> print_string " ") (mcode print_string) attr;
+      | Ast0.Param(ty,None,attr) ->
+          typeC ty;
+          (if (attr = []) then print_string " ");
+          print_between (fun _ -> print_string " ") (mcode print_string) attr;
       | Ast0.MetaParam(name,_,_) -> mcode print_meta name
       | Ast0.MetaParamList(name,_,_,_) -> mcode print_meta name
       | Ast0.PComma(cm) -> mcode print_string cm; print_space()
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
