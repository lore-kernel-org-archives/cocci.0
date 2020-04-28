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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80388C83000
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:05:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EBA520730
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpS4UL2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EBA520730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SH5HDc014614;
	Tue, 28 Apr 2020 19:05:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 446CA7807;
	Tue, 28 Apr 2020 19:05:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DF86D3DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:05:15 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SH5ENT002434
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:05:15 +0200 (CEST)
Received: by mail-pg1-x544.google.com with SMTP id d3so3398815pgj.6
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iAZwpXgyXbVEqG7G570Yyi1YamOd5ca2XXaSrHWEm88=;
 b=KpS4UL2rZjVeESKfcz3mMogXrGX/CeKHjNubaz6tldW3rXd4nSCmxvan6cPqIZn0wL
 fI58FII0YL+28nma78cpDWQb/pqer8dQUGFzl3LQ8OM4fG3IcS/MMFsJ0TNnZTlRBDhC
 ivJy+eozkAfP4Pl+0o2MOM0wFsArbk+Re0d2cB1pIh3QsXzJW+RFdlfdFOI/nFSpHi1w
 KJJTw72m7skScNllQbJQel0hAI5URDQsTLvxDEdgXlHPw7JRQNUpZHS3b4sSF+Hx1Fds
 CqcCY8pHeu+iSVXzKFvhk42iPBwciycsfiFhsbZb6nkKXwMb7cEDZJU4NWu4xotCevhn
 XOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iAZwpXgyXbVEqG7G570Yyi1YamOd5ca2XXaSrHWEm88=;
 b=kThxTbWlaiEpel/9sEyrcB6FlcK7H6ZyNc671X/dNNrnSm90gTHEMoLIGfdAkK5cZg
 3DoPBtS7luaR3Noie2bdHasgR4G02c1ImalKM7kJAZMfwwMIgCY+jCgk3k7fBUgG2WiT
 LlngBdhDd1gOpZuFBT5MQTUZkbJpbjgATThbFOrgikM19rc0ThDnEyvs6hkRDTSK00Ir
 SzKky66BVTeJcYjGq4oXliEhZaXxUNonURispqvJsDPY1XYWkVFcVhl9M9+PshfbYGTq
 1AQGFVvRaDMxWvnUVWo6+JIMkqnTcBC+LLwhiNIxb12C00v+aG2DZxIpFIqwM4/vCpS7
 xrZA==
X-Gm-Message-State: AGi0Pua4XS8OHJbnawJ5He9D72yXJCnB6FXUSnSfIIGKLqT6sKvollUr
 LNz2WKe071sAv0NTPJihT+VKe1P3U0s=
X-Google-Smtp-Source: APiQypLNkS0XUbsfkXqh2bzODQQF1vf+GCaV/JoN4WxpPRy0v5Eknh/cnVHvbHpiLe38ZwA/lK2M4Q==
X-Received: by 2002:a62:5402:: with SMTP id i2mr31249943pfb.89.1588093513520; 
 Tue, 28 Apr 2020 10:05:13 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.163])
 by smtp.gmail.com with ESMTPSA id u15sm2505097pjm.47.2020.04.28.10.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:05:13 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 28 Apr 2020 22:32:19 +0530
Message-Id: <20200428170228.7002-24-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:05:17 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 19:05:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 23/32] parsing_c: type_annoter_c: Reflect Cast
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
type_annoter_c.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/type_annoter_c.ml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/parsing_c/type_annoter_c.ml b/parsing_c/type_annoter_c.ml
index dfd363b2..c42ac5e9 100644
--- a/parsing_c/type_annoter_c.ml
+++ b/parsing_c/type_annoter_c.ml
@@ -525,7 +525,7 @@ let rec is_simple_expr expr =
       true
   | Binary (e1, op, e2) ->
       true
-  | Cast (t, e) ->
+  | Cast (t, e, a) ->
       true
   | ParenExpr (e) -> is_simple_expr e
 
@@ -961,7 +961,7 @@ let annotater_expr_visitor_subpart = (fun (k,bigf) expr ->
 
 
     (* -------------------------------------------------- *)
-    | Cast (t, e) ->
+    | Cast (t, e, a) ->
         k expr;
         (* todo: if infer, can "push" info ? add_types_expr [t] e ? *)
         make_info_def_fix (Lib.al_type t)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
