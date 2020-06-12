Return-Path: <SRS0=FQJD=7Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB197C433DF
	for <cocci@archiver.kernel.org>; Fri, 12 Jun 2020 06:46:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58926207F7
	for <cocci@archiver.kernel.org>; Fri, 12 Jun 2020 06:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+QGhNnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58926207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05C6kMmv022619;
	Fri, 12 Jun 2020 08:46:22 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BAD9C44A7;
	Fri, 12 Jun 2020 08:46:22 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2C83E3BAB
 for <cocci@systeme.lip6.fr>; Fri, 12 Jun 2020 08:46:21 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05C6kJvV020373
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 12 Jun 2020 08:46:20 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id x11so3359526plv.9
 for <cocci@systeme.lip6.fr>; Thu, 11 Jun 2020 23:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nnEr7qzQW3/zvUdkvr5MBD8uoSpGlLUJmDraCT0xLAI=;
 b=s+QGhNnMuhsjfN9rN0QN0RUjjtUeoz7mDB5tk8zBYLeKzr4EgFhgyoDcYyHfizQ9u+
 GtXdTtF9RgNxemv2vMR+4wV0bQqwsLVRidrf8hZgRd+0y/Md06ZYQhk7jX8vo3BbrZLs
 4dleqrHGOfPS3gtAPqekMRDktY9O8M5JR++e0E8SfdaWKQxjCFCdcOhE7vbUvX1AmajC
 JAcYThYvl6mORF/LEOmUcaa2gAd+waOaMyMtmTdF9u0LvA4rDUiFWObist1kpaPgnUrs
 EGbXPSecbAMtUPhGErWt/R7jv3xIlSn5LdmYpn6+8WWvuE7w7jDHunanBeUWAyQKeOhj
 jw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nnEr7qzQW3/zvUdkvr5MBD8uoSpGlLUJmDraCT0xLAI=;
 b=CfZIA6YcRgNoYrCOsWOgUhprIqbBBvTR4iLSBPawNwhIodUPLhbDQezW52R4jYQwP/
 S5yomwCZrReWik1r8HL2GVh0Uv4EDz35VfA/gMmSZxhOW6gq73C3Age4coA5QhXm49Ap
 bURzPqPEL93i1C2UBwqjgEXKHVg2RaJ6VbgzPMABxaDhc2E+zYEqbsHh+LuAjpXPZvay
 PDX8kf+YB8N+JJLdh6ol98OduOS7z4y3L/4aBcOPYFDDVz4iNqlMkYShSwvwUOHaB+VH
 g9CB4Mo1i4QFqKxZIdToNeEjFXxMdll56kGXtq8WlGzYD8l4npHbWxW4geg7QHFw56Wc
 3OXw==
X-Gm-Message-State: AOAM531cHkpw6jJPHdawWVDaohl1LHl2uUv6ju+IUDU00Vn0Exy0Nf8l
 H80dVrgUaJfqS0vXik0VDVuHH6/A
X-Google-Smtp-Source: ABdhPJzRoWiepYm/v3AVQdDi+1fdXJ7/ARZLECrfrMb1wTwzb2CnQckTJijo7BE1F2S35wEzMdh28w==
X-Received: by 2002:a17:90a:df98:: with SMTP id
 p24mr11744151pjv.135.1591944378599; 
 Thu, 11 Jun 2020 23:46:18 -0700 (PDT)
Received: from localhost.localdomain ([1.38.217.229])
 by smtp.gmail.com with ESMTPSA id w192sm5087476pff.126.2020.06.11.23.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 23:46:18 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 12 Jun 2020 12:15:43 +0530
Message-Id: <20200612064544.30194-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200612064544.30194-1-jaskaransingh7654321@gmail.com>
References: <20200612064544.30194-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 12 Jun 2020 08:46:22 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 12 Jun 2020 08:46:20 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 2/3] parsing_cocci: context_neg: Apply equal_mcode
	on cast/param attrs
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

The following commits introduced some poor management of attributes in
context_neg.ml:
	2b7e99a5b86d41e05980c8a9d98eb931e42bb4d8
	08f1cd9fb83ec400435e0ad8fdf579ec8f9c0f21
Apply equal_mcode on cast and parameter attributes in context_neg.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/context_neg.ml | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/context_neg.ml b/parsing_cocci/context_neg.ml
index 41bc621f..6e992245 100644
--- a/parsing_cocci/context_neg.ml
+++ b/parsing_cocci/context_neg.ml
@@ -630,8 +630,10 @@ let rec equal_expression e1 e2 =
       equal_mcode pt1 pt2
   | (Ast0.RecordPtAccess(_,ar1,_),Ast0.RecordPtAccess(_,ar2,_)) ->
       equal_mcode ar1 ar2
-  | (Ast0.Cast(lp1,_,_,rp1,_),Ast0.Cast(lp2,_,_,rp2,_)) ->
-      equal_mcode lp1 lp2 && equal_mcode rp1 rp2
+  | (Ast0.Cast(lp1,_,ar1,rp1,_),Ast0.Cast(lp2,_,ar2,rp2,_)) ->
+      equal_mcode lp1 lp2 &&
+      List.for_all2 equal_mcode ar1 ar2 &&
+      equal_mcode rp1 rp2
   | (Ast0.SizeOfExpr(szf1,_),Ast0.SizeOfExpr(szf2,_)) ->
       equal_mcode szf1 szf2
   | (Ast0.SizeOfType(szf1,lp1,_,rp1),Ast0.SizeOfType(szf2,lp2,_,rp2)) ->
@@ -842,8 +844,10 @@ let equal_initialiser i1 i2 =
 
 let equal_parameterTypeDef p1 p2 =
   match (Ast0.unwrap p1,Ast0.unwrap p2) with
-    (Ast0.VoidParam(_,_),Ast0.VoidParam(_,_)) -> true
-  | (Ast0.Param(_,_,_),Ast0.Param(_,_,_)) -> true
+    (Ast0.VoidParam(_,ar1),Ast0.VoidParam(_,ar2)) ->
+      List.for_all2 equal_mcode ar1 ar2
+  | (Ast0.Param(_,_,ar1),Ast0.Param(_,_,ar2)) ->
+      List.for_all2 equal_mcode ar1 ar2
   | (Ast0.MetaParam(name1,_,_),Ast0.MetaParam(name2,_,_))
   | (Ast0.MetaParamList(name1,_,_,_),Ast0.MetaParamList(name2,_,_,_)) ->
       equal_mcode name1 name2
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
