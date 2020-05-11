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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD72CC47255
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9082075E
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA34Zuho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9082075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BAEPdK009119;
	Mon, 11 May 2020 12:14:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E79EE3E6B;
	Mon, 11 May 2020 12:14:24 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 44BD03DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:23 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:643])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BAEL1v024809
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:22 +0200 (CEST)
Received: by mail-pl1-x643.google.com with SMTP id b12so1827429plz.13
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DoYSqyO22rGi0Db4CqIjpeG/yfksbrnzAwvFWBh1tCQ=;
 b=PA34ZuhoueMzVNNpXoDkUbGOgbhnPFJLNflfhVZH13vZYJXUBVMWz++qlAYSKghLD2
 ooSPEbvMvVhud5QQucLgs8U8vNUGuVrNOAvTBti/sNs/zm4TH3LCygi20DyLIsafG7c4
 r7H7snSGcxnkPX4/HPlHbglmjlnQ7UkrOdjn+IIxE4GtYyuIeI0vKVqUcpE3msCqZx1k
 ZVNWX8HS0AOibmxyNRTYOVjgDSa3wCvDurgWBuRLpO+ehKnTxOxiR9AkaA1aNspAWZsg
 62ibS8rHrpkGIstwkryU33Os3/8PKRBBJ805xKnN9/NKW+U6h60at7/l7bxP20nKTqJM
 1KUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DoYSqyO22rGi0Db4CqIjpeG/yfksbrnzAwvFWBh1tCQ=;
 b=HtAoNIKGLwdY1q6MWcQdVwtE1WApfxMShSGEQwaVopXvGRO9K3wacuMjRUK5nJArSo
 a2spCwt935rWW4t/fSH06yfo6wJ2m3suHg/lnD4sZMXmUpAnJMii8oMW2y+WeLTV4vh2
 89ZvJ0NPMKFm1g2oAvYqc6NSNCSXhje2d9pttzzBOQpQhZoR/8ZdArA+NcqhsKF+FNwC
 u8NQ/NVGl0n8avcfMeBynlw1QZyZHJQWTDi/hhUZpvjD2hKisq4fFd3lQfZ/PPlyQNLP
 xXcqaHmHUBlwTCwjhi625+UWSC97c5Nx0zEW/AAj/SP9DSWABMPdIy3VLbY9sE4mV2MA
 /KLA==
X-Gm-Message-State: AGi0PuboxNBvai0viUFfAXpjjyjkINzxo1oB2JTt51X7meqNp2u5XFzH
 WUUp+MzBZ0cg4QlRJ6SpmTmpTjZID+U=
X-Google-Smtp-Source: APiQypL0gkzgoyBkOBpe/xxEoyBY8W3FD0pZV+w1RNPAVovUwI9LrTIXMGZisDsgUrYdC1ctVy27fg==
X-Received: by 2002:a17:90b:692:: with SMTP id
 m18mr21690185pjz.39.1589192060472; 
 Mon, 11 May 2020 03:14:20 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:14:20 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:42:54 +0530
Message-Id: <20200511101300.11101-18-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:14:25 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:14:22 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 17/23] parsing_cocci: disjdistr: Reflect
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
disjdistr.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/disjdistr.ml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/parsing_cocci/disjdistr.ml b/parsing_cocci/disjdistr.ml
index 6724bb25..c868cb1c 100644
--- a/parsing_cocci/disjdistr.ml
+++ b/parsing_cocci/disjdistr.ml
@@ -259,10 +259,10 @@ and disjexp e =
 
 and disjparam p =
   match Ast.unwrap p with
-    Ast.VoidParam(ty) -> [p] (* void is the only possible value *)
-  | Ast.Param(ty,id) ->
+    Ast.VoidParam(ty,attr) -> [p] (* void is the only possible value *)
+  | Ast.Param(ty,id,attr) ->
       disjmult2 (disjty ty) (disjoption disjident id)
-	(fun ty id -> Ast.rewrap p (Ast.Param(ty,id)))
+	(fun ty id -> Ast.rewrap p (Ast.Param(ty,id,attr)))
   | Ast.AsParam(pm,asexp) -> (* as exp doesn't contain disj *)
       let pm = disjparam pm in
       List.map (function pm -> Ast.rewrap p (Ast.AsParam(pm,asexp))) pm
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
