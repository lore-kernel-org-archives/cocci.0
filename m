Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1939C433DF
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:22:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7214B206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVlgWYse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7214B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHMNfX011942;
	Sun, 24 May 2020 19:22:23 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D7CFF3DC8;
	Sun, 24 May 2020 19:22:23 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EAA973D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:22:21 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHMKeT020207
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:22:21 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id x10so6623190plr.4
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Az+F0PEMm7+AO/Nvbjule0aCiqTJupDpFvzo6TVkawI=;
 b=IVlgWYselt5YusLrrGFz9pI+96XQSeMg/DHxNFtOMH03SL0AX50sBgEQlqmkw3CARS
 Yh5RPcgSGXbSV6o7X1/4QYTbE/8xr8Pla5hxUvjHwzA41PtqgRgVnadkvS7ikHq5p9pj
 f/IbGs/3AZ31uPKvtmY11f0S6kXBjB95GFCSjUWc/hmTlRFx2bOoXyI2RIC6SF+4mUqB
 JQJydbIHQCxbMQNck4tteIgOsbGQR8wS3oZzVSQBlWaBK1pIAFo+DSw19w8WK2Oi6Opu
 PBo2aq0iEug3xUqB2QfnLh9+20HtioCj2U7kkJwBc05ur9MOdk6qoataqQdogWMBYxHX
 RD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Az+F0PEMm7+AO/Nvbjule0aCiqTJupDpFvzo6TVkawI=;
 b=K7LLk/h6kUvRwymXPdWr7rpNpinr3Trl1fsb61ci21u75z2b261zzjGkAEYrMCiKgK
 H4N5ISl7SNZyNjVnRWS/9z4E2DcMfcv3m9xYO6khepvw0PjqVbYQXZiazj6F2lUCgtgE
 4JNxWY3AX00mdvyohWUHOX2CNdZ+8I6acJAYgHLQYub+3xuMNvD+0SCD5N6c1ElFT2fV
 JGprtKWBp5RBSVGauhzjCwtVVTaBnctLHE132bgOtZB3HT4/PEwe1kZM4t5VRcSAKMZA
 z9Ci3DXA7bM/bdR15sgszTVza7Wu4PbBULciKkRM2NKb70iQJIl2XriclEX9WRNthjWl
 07ZQ==
X-Gm-Message-State: AOAM531t/Bz2YmY8mSt97Tz1adK3cAhuPIGm6pdpURtHHu2aikfw5+uy
 faQMRL8gudiCmCNKL5zxOgLuM8ZhvsY=
X-Google-Smtp-Source: ABdhPJxqxaSa1yQi6sDfPveaCEMBwPuIGSXG73PgkwaIooJBIV5vXIeA8KPW1hGsctyX77VeZ4TC8w==
X-Received: by 2002:a17:90a:ad92:: with SMTP id
 s18mr16761563pjq.30.1590340939616; 
 Sun, 24 May 2020 10:22:19 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:22:19 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:30 +0530
Message-Id: <20200524171935.2504-26-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:22:24 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:22:21 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 25/30] engine: check_exhaustive_pattern: Reflect
	Macrodecl attributes
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

Macrodecl attributes are added to the SmPL AST. Reflect these changes in
check_exhaustive_pattern.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 engine/check_exhaustive_pattern.ml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/engine/check_exhaustive_pattern.ml b/engine/check_exhaustive_pattern.ml
index 903c32ff..2f1ef4a3 100644
--- a/engine/check_exhaustive_pattern.ml
+++ b/engine/check_exhaustive_pattern.ml
@@ -63,7 +63,7 @@ let dumb_astcocci_decl = function
  | A.Init (stg, typa, sa, attr, _, expa, _) -> ()
  | A.FunProto _ -> ()
  | A.TyDecl (typa, _)     -> ()
- | A.MacroDecl(stg, fn, _, eas, _, _) -> ()
+ | A.MacroDecl(stg, fn, _, eas, _, _, _) -> ()
  | A.MacroDeclInit(stg, fn, _, eas, _, _, _, _) -> ()
  | A.MetaDecl _ -> ()
  | A.AsDecl _ -> ()
@@ -76,7 +76,7 @@ let dumb_astcocci_initialiser = function (* seems same as the above *)
     A.Init(stg,ty,id,attr,eq,ini,sem) -> ()
   | A.UnInit(stg,ty,id,attr,sem) -> ()
   | A.FunProto _ -> ()
-  | A.MacroDecl(_, fn, _, eas, _, _) -> ()
+  | A.MacroDecl(_, fn, _, eas, _, _, _) -> ()
   | A.MacroDeclInit(_, fn, _, eas, _, _, _, _) -> ()
   | A.TyDecl(ty,sem) -> ()
   | A.Typedef(d,ty1,ty2,pv) -> ()
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
