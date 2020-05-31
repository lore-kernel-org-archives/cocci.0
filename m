Return-Path: <SRS0=O8dQ=7N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF60AC433DF
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F0A2206EB
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InjJvtn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0A2206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFSGt0021484;
	Sun, 31 May 2020 17:28:16 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B55AD7752;
	Sun, 31 May 2020 17:28:16 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 01F4E3C89
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:28:15 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFSBT7013376
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:28:12 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id y18so1426463plr.4
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9RKu4+hBUs9HmPljH1l7+WPmn25c+K+wryyLk+AOrw0=;
 b=InjJvtn+F/movD8J397mnw/IhDjOpHCIoVz1XN1m8HRb644+xuTVlGToeq9VdUjxrZ
 Qz9YyYntc/1Gj133Sk0y8UfuZFwopZXsXDGAIXm/Uduvm1jPcL/Yo+Dw4n6EuNBLLA9E
 p48e2EDX/iFzsz7ouvAGG4eYo/Piu7Mwlfgwi/jjiI323hMWYB7fCVzenwhjdSmrfiaM
 cy3SsAiIo0RznJj6AKrVZwXzK8hJHbCGyQT3KL0L5t63daYWVqcMx8jVxG1kzCb/f8x2
 n6iax4oDK/OOG2uKvejddjrWakSmSgbJb4dpcSqnzeSz/I1ByGKDlPa1aUb7uvanZfeR
 +gKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9RKu4+hBUs9HmPljH1l7+WPmn25c+K+wryyLk+AOrw0=;
 b=Ocy74GckG/LDu5pnP3xM4uA1b7pDduA+ryUyOjJPUfKHl6KKvi+XgT+zzLxIDYq/vy
 A5GdFxnaxXhKnTm1joatQaF1LHqiytOrucBo9gEPuLoOgIqrYAkubtWC5Caj0+Wj9Ej1
 gW1lJ7p874SXs7ub31N3JtYFO8cbsQ8L2fBcJPPajm8vrop7EZPe+eKh41TaGgwSOywi
 gOuiFOP+1wMSCIX8kCmosLXNpkGq8CvNqHBoi7ckHxrSfAEfDLuQzq6yQc/1mQt2ifDQ
 TFVTiBzlfTfTlz89z6cSUvzGe4FTsQNbRFbatPe/MhaAHxV41ERa7PV3kCawep/v1Jxc
 eJww==
X-Gm-Message-State: AOAM533K06AK9QhzcYaa6qPxd9LvoJvuLXITTkzou/jhnkhXo5XULP9a
 YkwgJ2YViBLia4/WX0BlhoAd0sH5
X-Google-Smtp-Source: ABdhPJzQ7YGN1bX+wb3AjAL9iFT6FhTOiLg1Zo9Fx01/5D1GxgIvSNCOL0lF2mahli36IUhoerUJ9g==
X-Received: by 2002:a17:902:8697:: with SMTP id
 g23mr14392117plo.306.1590938891011; 
 Sun, 31 May 2020 08:28:11 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:28:10 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:56:15 +0530
Message-Id: <20200531152621.2886-22-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:28:16 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:28:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 21/27] engine: check_exhaustive_pattern: Reflect
	struct end attributes
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

Struct end attributes are added to the SmPL AST. Reflect these changes
in check_exhaustive_pattern.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 engine/check_exhaustive_pattern.ml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/engine/check_exhaustive_pattern.ml b/engine/check_exhaustive_pattern.ml
index b702063d..fe2dac67 100644
--- a/engine/check_exhaustive_pattern.ml
+++ b/engine/check_exhaustive_pattern.ml
@@ -62,7 +62,7 @@ let dumb_astcocci_decl = function
    A.UnInit (stg, typa, sa, attr, _)     -> ()
  | A.Init (stg, typa, sa, attr, _, expa, _) -> ()
  | A.FunProto _ -> ()
- | A.TyDecl (typa, _)     -> ()
+ | A.TyDecl (typa, _, _)     -> ()
  | A.MacroDecl(stg, fn, _, eas, _, _, _) -> ()
  | A.MacroDeclInit(stg, fn, _, eas, _, _, _, _) -> ()
  | A.MetaDecl _ -> ()
@@ -78,7 +78,7 @@ let dumb_astcocci_initialiser = function (* seems same as the above *)
   | A.FunProto _ -> ()
   | A.MacroDecl(_, fn, _, eas, _, _, _) -> ()
   | A.MacroDeclInit(_, fn, _, eas, _, _, _, _) -> ()
-  | A.TyDecl(ty,sem) -> ()
+  | A.TyDecl(ty,attr,sem) -> ()
   | A.Typedef(d,ty1,ty2,pv) -> ()
   | A.DisjDecl(decls) -> ()
   | A.ConjDecl(decls) -> ()
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
