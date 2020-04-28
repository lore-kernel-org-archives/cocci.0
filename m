Return-Path: <SRS0=bJsz=6M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DF5C83000
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:04:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3CBB20730
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWs+T5Nk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CBB20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SH4ZAS007019;
	Tue, 28 Apr 2020 19:04:35 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D229A7807;
	Tue, 28 Apr 2020 19:04:35 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 451333DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:04:34 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SH4WEg015604
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:04:33 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id v2so8620088plp.9
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 10:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EOnyLzO8txfwyXdMk5xZdnI9RRWzBI9eFOCxN8utaI8=;
 b=PWs+T5NkLLr9kvjHBiwf4JR9a/hk1A0LWsmipHoRZKTugbxUAYtp+49K28Qs/sXcoq
 WgH1U5V2ryiLvnU/rNGKXlGbFSQwsPVTZyhCJbtYqjCmIyx5raBcTPcmMlwPtUlUUsRA
 O3EgdAL08eq7VcjiCyZe87j9cf7B/D6YLBs4qj1KPyl/6GAitMQRrZrLKwa12sdYazCd
 EosseqWqJngZd2VB0BAEg6V4IDAVQa+Thlqbw7hJB0ZaQOkgB0Q0i92J8yq/50DGCrBF
 +u47nUM9+sOYMETJY/cITiMRABXCvDcF1piEqwpxmTpL9yRkWONk0y6BT+TB0l2g/50v
 cRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EOnyLzO8txfwyXdMk5xZdnI9RRWzBI9eFOCxN8utaI8=;
 b=X6tjS0S/eTzFp6BgOnxoCT54uwUkepGsW549DT8n8crITPZKWE6lbSFwZxK3oMUL8x
 Mwt+WI971nJW0u2Uhottk5ez1NlMwuqP3k595P0O5aIIbtJyaScmV133uqGv+i8l2ywv
 x1M0E/aVYtMKuC8MCZytq6zqazXegoNJr4o1lQ5jqL4qznhD4Yac2mcO9KF/UPv7I2qq
 RVxrNIpP7W4nmZkIK9ORBhuij57/gJWoOFdKTzk9sknTcq+Fj4kntr52s46Ig6WBiG39
 VhxQorYCEop7udLXTJbbh+oB94pwRlezqC8S3r7bpde4X+QTpz7fgjcOxLNUsc34LyaA
 P0Og==
X-Gm-Message-State: AGi0Pub41TOPYDA0VwQUnIry1Fs1ElS3nk9ksMyS0Icc6hv5u137x8e6
 Fqs2DV2uNLyMIUgHsk5x9OJ9gMwKfP8=
X-Google-Smtp-Source: APiQypIQrFkcoKmIGiA5COLWgRpZU2Mr3OhLi3XqZaHDISWSQm0BuG4dLWksHKZhcby5M5BWBF27uw==
X-Received: by 2002:a17:90a:7486:: with SMTP id
 p6mr6315890pjk.62.1588093471888; 
 Tue, 28 Apr 2020 10:04:31 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.163])
 by smtp.gmail.com with ESMTPSA id u15sm2505097pjm.47.2020.04.28.10.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:04:31 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 28 Apr 2020 22:32:18 +0530
Message-Id: <20200428170228.7002-23-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:04:35 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 19:04:33 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 22/32] parsing_c: pretty_print_c: Reflect Cast
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

Cast attributes are added to the SmPL AST. Print these attributes in
pretty_print_c.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/pretty_print_c.ml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/parsing_c/pretty_print_c.ml b/parsing_c/pretty_print_c.ml
index 99a7e0ed..96a11d72 100644
--- a/parsing_c/pretty_print_c.ml
+++ b/parsing_c/pretty_print_c.ml
@@ -146,8 +146,9 @@ let mk_pretty_printers
 	pp_expression e
     | SizeOfType  (t),     [i1;i2;i3] ->
         pr_elem i1; pr_elem i2; pp_type t; pr_elem i3
-    | Cast    (t, e),      [i1;i2] ->
-        pr_elem i1; pp_type t; pr_elem i2; pp_expression e
+    | Cast    (t, e, a),      [i1;i2] ->
+        pr_elem i1; pp_type t; pr_elem i2; pp_expression e;
+        a +> pp_attributes pr_elem pr_space
 
     | StatementExpr (statxs, [ii1;ii2]),  [i1;i2] ->
         pr_elem i1;
@@ -184,7 +185,7 @@ let mk_pretty_printers
     | CondExpr (_,_,_) | Sequence (_,_) | Assignment (_,_,_)
     | Postfix (_,_) | Infix (_,_) | Unary (_,_) | Binary (_,_,_)
     | ArrayAccess (_,_) | RecordAccess (_,_) | RecordPtAccess (_,_)
-    | SizeOfExpr (_) | SizeOfType (_) | Cast (_,_)
+    | SizeOfExpr (_) | SizeOfType (_) | Cast (_,_,_)
     | StatementExpr (_) | Constructor _
     | ParenExpr (_) | New (_) | Delete (_,_)
     | Defined (_)),_ -> raise (Impossible 95)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
