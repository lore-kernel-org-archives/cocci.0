Return-Path: <SRS0=cw0N=6I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387D0C2BA1A
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:20:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C81E620724
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oS2wCle9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81E620724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03O9K7C7003531;
	Fri, 24 Apr 2020 11:20:07 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C15BF7827;
	Fri, 24 Apr 2020 11:20:07 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 844547815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:20:05 +0200 (CEST)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03O9K3UF017691
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:20:04 +0200 (CEST)
Received: by mail-pj1-x1041.google.com with SMTP id a31so1814895pje.1
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 02:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iL12afvc8E+4S7BFOl5ZbAwj/mn8D1h40NLooKUmeGU=;
 b=oS2wCle9Es28t0G/GMwjhIPSvDOInw9z7ReW7oSae07JHHEFoDyNjGTyK28Cf9Mtrk
 oOLYjVL904Ft3uFcBlOdRAOEt5waeKRCybbQbCcA1Ak+0774GlSFuGXI8Tzoxs2Dq762
 HgsGJuJN8Vppu0nhcEwPgmxNbHYM9Z/RB7S62t24H6f4RV+8m7+DNEEScM4qiPnZj4OP
 4rRR5tJ4BeXEdgF1voiDVQ8yMxcWq0j8uisHChlisPScBaFCnhzI3bVSMm6nK8JM2hVg
 dRNN7nLWCODS0gwMFftL701AYhfUeFSUhTad4uWVWrN2AqXQFE0SZfZYBS9/tlSkxecd
 syjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iL12afvc8E+4S7BFOl5ZbAwj/mn8D1h40NLooKUmeGU=;
 b=Qvlk2k5ZI/OCGoVhA5l5oVISpkeZHu9eOWk6y8cY5dfG40GPohYSP81EL+KykjkfEj
 QAFsvGSCdli5R2i3N7pBBEJlnR12nwnPCbaok7KD8t7SuTpOOaNgq2T8V1mE9uYBKId4
 vsciE+JTwXC6KnNlQKSSMLATNS+AjUCMu/G1jE/xm+OE51x8K4iUDmzuFQa3biglmRuG
 Rpyo8w+qndpNb750vUTs2/vOSenWFdvLbUYJ7M3t68vS/rQmIX0WlwxEpemPWJo6Nv26
 t0bxnBgmUknpFh6H0NPnJk88z/s7U9kadMqOUgZpvSgNw2APKbRjKNee92AaumrLajbF
 oyvQ==
X-Gm-Message-State: AGi0PuaMb2yr/9BP31UOu9AFw6IWWHRLzRk9OzHon4l/qBt7klCSpO0w
 DLeOqHmm80Bq0TtPZzP7o3HEAIcmSKg=
X-Google-Smtp-Source: APiQypJU4cwD96oP6iDF5aUJ3DTvmMp5wiGoiuBLDLquMCidYs2SbgMVGRW1t0XGPfCbcVbZCA21og==
X-Received: by 2002:a17:902:b685:: with SMTP id
 c5mr8622192pls.323.1587720003037; 
 Fri, 24 Apr 2020 02:20:03 -0700 (PDT)
Received: from localhost.localdomain ([1.38.216.60])
 by smtp.gmail.com with ESMTPSA id c80sm5043933pfb.82.2020.04.24.02.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 02:20:02 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 24 Apr 2020 14:48:01 +0530
Message-Id: <20200424091801.13871-26-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
References: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 11:20:07 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 24 Apr 2020 11:20:05 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [RFC PATCH 25/25] engine: c_vs_c: Match parameter attributes
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

Parameter attributes are added to the C AST. Add an expression to check
if attributes are equal on both sides to the parameter case in c_vs_c.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 engine/c_vs_c.ml | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/engine/c_vs_c.ml b/engine/c_vs_c.ml
index e2bd7408..b569c244 100644
--- a/engine/c_vs_c.ml
+++ b/engine/c_vs_c.ml
@@ -135,9 +135,11 @@ and typeC tya tyb =
           let iix = iia in
           acc >>= (fun xs ->
 
-            let {p_register = (ba,iiba); p_namei = saopt; p_type = ta} =
+            let {p_register = (ba,iiba); p_namei = saopt; p_type = ta;
+                 p_attr = attrsa} =
               parama in
-            let {p_register = (bb,iibb); p_namei = sbopt; p_type = tb} =
+            let {p_register = (bb,iibb); p_namei = sbopt; p_type = tb;
+                 p_attr = attrsb} =
               paramb in
 
             let bx = ba in
@@ -145,13 +147,15 @@ and typeC tya tyb =
 
             let sxopt = saopt in
 
+            let attrsx = attrsa in
 
             (* todo?  iso on name or argument ? *)
-            (ba = bb && same_s saopt sbopt) >&&>
+            (ba = bb && same_s saopt sbopt && attrsa = attrsb) >&&>
             fullType ta tb >>= (fun tx ->
               let paramx = { p_register = (bx, iibx);
                              p_namei = sxopt;
-                             p_type = tx; } in
+                             p_type = tx;
+                             p_attr = attrsx; } in
               return ((paramx,iix)::xs)
             )
           )
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
