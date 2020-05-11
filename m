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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C4BC54E8E
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:13:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCF8C20720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdKEpAvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF8C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BADkUQ008578;
	Mon, 11 May 2020 12:13:46 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CF72A3E6B;
	Mon, 11 May 2020 12:13:46 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2DBDC3DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:13:45 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BADhsW013722
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:13:44 +0200 (CEST)
Received: by mail-pg1-x544.google.com with SMTP id f23so3683292pgj.4
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZyzlIWNwdkp9Rh6rKkpnyNaMorCGqrIfrYY1rTdq+DE=;
 b=GdKEpAvjvlQ4UG+ptorIXw5vHIPchGzNBE0ldIEykqUvnxCcVgUebw15TS2o8a2cix
 X8aShB3pEwv6jrU/q8eZ6upkDOZ+cHQSbud0RtUptjKpN4Ah3tMZfoNOCsl26N6nwL7S
 X9f7tsfr0iRPw36Dfrkwi6vEKPrhwXAuSCLyu94EgiLMmdRo+cHrMqIL4VpUGGLUXf77
 KfQVI/7KA9jFNWPBQu48yGE46LRasiRjvS37tsl2ora2RSuCwzABxCL9VDi1BznogJZl
 UmhOH33c1gMImB+0PSLum4CK0SWYIuA+UgDnFRJgZP+340nOy/3fXNGJ+2JMmqsmkBZv
 r3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZyzlIWNwdkp9Rh6rKkpnyNaMorCGqrIfrYY1rTdq+DE=;
 b=sAjyUg585IesumnN8GKaSKezgM24f7e6MGuP0IAWxed+uiTScRoLS0EkUlCs368HHK
 Pn4gXSpUZamP5VPzb1tps5H8rN1yOtqUfFWKiP1X9ISthvoiVoe04GhrBWzziHufu0z8
 rjhalre/u9pwqUkGPZwlcElEMTFtFMKvliB1Pu87Y9xJg3gH3tEZhNmLw6HgBKrctcC+
 MpCiQqpXckQPsFWzErCq8/XQFd02E4YOB3mUFNEzxvqvDPpLYV1jJO2wr2uuqU5AUqt4
 U0hfP0bFuwn/vvnuJwg17WCEM/zh0a17eomiSt6eOtVYFOyJu5o4r4RxZ7Ga7el/FXKg
 YClQ==
X-Gm-Message-State: AGi0Pubm8SJSKefXtiySfFWMmcodXVrxNOyfxg28W4fLGftlb39tzuXl
 FBnRdP6G6wQMZmLahuh4ojDk752tyCo=
X-Google-Smtp-Source: APiQypI/UgKcbKFrc9Xamq6WcE5y8eDdT8C77XPHs4ufeyMWzfHV2o63kwOTxAFSvbJ8smcdz1w1XA==
X-Received: by 2002:a63:6543:: with SMTP id z64mr14200468pgb.260.1589192022774; 
 Mon, 11 May 2020 03:13:42 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:13:42 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:42:44 +0530
Message-Id: <20200511101300.11101-8-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:13:46 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:13:44 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 07/23] parsing_cocci: context_neg: Reflect
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
context_neg.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/context_neg.ml | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/context_neg.ml b/parsing_cocci/context_neg.ml
index dd768a61..98b96ac5 100644
--- a/parsing_cocci/context_neg.ml
+++ b/parsing_cocci/context_neg.ml
@@ -466,9 +466,11 @@ let classify is_minus all_marked table code =
   let param r k e =
     compute_result Ast0.param e
       (match Ast0.unwrap e with
-	Ast0.Param(ty,Some id) ->
+	Ast0.Param(ty,Some id,attr) ->
 	  (* needed for the same reason as in the Init and UnInit cases *)
-	  bind (r.VT0.combiner_rec_typeC ty) (r.VT0.combiner_rec_ident id)
+	  bind (r.VT0.combiner_rec_typeC ty)
+           (bind (r.VT0.combiner_rec_ident id)
+              (List.fold_right bind (List.map mcode attr) option_default))
       |	_ -> k e) in
 
   let typeC r k e =
@@ -839,8 +841,8 @@ let equal_initialiser i1 i2 =
 
 let equal_parameterTypeDef p1 p2 =
   match (Ast0.unwrap p1,Ast0.unwrap p2) with
-    (Ast0.VoidParam(_),Ast0.VoidParam(_)) -> true
-  | (Ast0.Param(_,_),Ast0.Param(_,_)) -> true
+    (Ast0.VoidParam(_,_),Ast0.VoidParam(_,_)) -> true
+  | (Ast0.Param(_,_,_),Ast0.Param(_,_,_)) -> true
   | (Ast0.MetaParam(name1,_,_),Ast0.MetaParam(name2,_,_))
   | (Ast0.MetaParamList(name1,_,_,_),Ast0.MetaParamList(name2,_,_,_)) ->
       equal_mcode name1 name2
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
