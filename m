Return-Path: <SRS0=15MF=5F=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8B3C4332B
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C99C20774
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNtvkkkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C99C20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K72g0P024937;
	Fri, 20 Mar 2020 08:02:42 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4EB9C780E;
	Fri, 20 Mar 2020 08:02:42 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 416BB3B93
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:02:41 +0100 (CET)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02K72d2l014753
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:02:40 +0100 (CET)
Received: by mail-pj1-x1041.google.com with SMTP id v13so2071754pjb.0
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 00:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VQGeOzvnAIMku75Z9zFKDRA+EXjMqvMkGVQ8piZaXTg=;
 b=iNtvkkkVTcDBgb8JhLocMXsLi6t20/MgRkvW3jjIWALIOo29/TKy808hvJo2L/hvJD
 MedI50cdtLq6uOwBsisC9rKu+4VaXpN57pKVefowQ1DxUe//ocqBTFbCy7nqXOyk1BY6
 RChcIRm9iADEz56fucYxRklFB71YEAD0PPMBVKsdUyEzJbCcrBTeU1kTQm3NQAKONgT4
 uBhMLxDze32uFJB9j5xQ+2SpcfFcvObKA1/B11ZegTtCmuee+9Ix02QJaU9XKHlUb7NR
 KkLHdKWwCaB/P8STIfgha75LaTdW/ssiHiHnvwbCjr71bfqJo6s6ecMUdZ8ihgG5hyG7
 u6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VQGeOzvnAIMku75Z9zFKDRA+EXjMqvMkGVQ8piZaXTg=;
 b=B1cXgvVcUb9gex3qmFQxoGnO6uxjNspTgwQ07Twdaf1VClJU3ILxJ21GNDs9nuum7P
 Wc8bCPPyG1NMnvlFju6mba5k4hTeLBPYwHhYDL3ALRAUKvCUJSA0EVMpU7Kb/RNNxpH8
 S5cQzjILdVJVVXzW/14VoSkeym3FATLuA3neuDT+0FeYMxhV1YCY6JLRpIf4dNf/FeGz
 jEuBUkZhqoADf8WwhoxmtSvUG1Y61Nul12HI2GNpyiAshBy0uaQqc3RfdfVyiaNTeoic
 p1XDAoKQNTBtysEN8/LP9oMdndEgDnx41FsKpDX53J0eYZLUWFqfM9uCleAbIzwNQmOC
 Iu5Q==
X-Gm-Message-State: ANhLgQ39CiQwFxHPf7IoE15iCLd2Sedo7WqUp1F1ZHjUKTs9R9XaJCV8
 Fc3FHqTYZjWf4lhxTHaZ1yUwgQBS
X-Google-Smtp-Source: ADFU+vs0KEZnqXI1yyXlbd2jE9Z48PzPMo1R6X3cVRPlQc/xfVdMvo7qe912yZCxs9xdTBvOYjTegQ==
X-Received: by 2002:a17:90b:8f:: with SMTP id
 bb15mr7226221pjb.186.1584687758764; 
 Fri, 20 Mar 2020 00:02:38 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2190:a751:deeb:c09d:833a:659d])
 by smtp.gmail.com with ESMTPSA id l11sm3941232pjy.44.2020.03.20.00.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 00:02:38 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 20 Mar 2020 12:31:38 +0530
Message-Id: <20200320070157.4206-8-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
References: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 08:02:42 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Mar 2020 08:02:40 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 07/26] parsing_cocci: index: Add cases for
	ParenType/FunctionType
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

ParenType and FunctionType are now added to the SmPL ASTs. Add
cases for these types in index.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/index.ml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/parsing_cocci/index.ml b/parsing_cocci/index.ml
index a1103503..088db18a 100644
--- a/parsing_cocci/index.ml
+++ b/parsing_cocci/index.ml
@@ -6,7 +6,7 @@
 
 (* create an index for each constructor *)
 (* current max is 188, also unused: 8-9, 15, 39, 40, 42, 46, 57, 65, 85-86,
- 113-115, 138-140, 162 *)
+ 113-115, 140, 162 *)
 
 (* doesn't really work - requires that identical terms with no token
 subterms (eg dots) not appear on the same line *)
@@ -93,6 +93,8 @@ let typeC t =
   | Ast0.Signed(sign,ty) -> [129]
   | Ast0.Pointer(ty,star) -> [49]
   | Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) -> [131]
+  | Ast0.ParenType(lp,ty,rp) -> [138]
+  | Ast0.FunctionType(ty,lp,params,rp) -> [139]
   | Ast0.Array(ty,lb,size,rb) -> [50]
   | Ast0.Decimal(dec,lp,length,comma,precision_opt,rp) -> [160]
   | Ast0.EnumName(kind,name) -> [146]
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
