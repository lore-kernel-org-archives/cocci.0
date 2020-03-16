Return-Path: <SRS0=+m3J=5B=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAF3C18E5B
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B26A2051A
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwFV7Sps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B26A2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GA4m6b023912;
	Mon, 16 Mar 2020 11:04:48 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F13607809;
	Mon, 16 Mar 2020 11:04:47 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D8E4C7802
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:45 +0100 (CET)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GA4iqu014307
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:45 +0100 (CET)
Received: by mail-pg1-x542.google.com with SMTP id x7so9466728pgh.5
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ArrNOO2wlymy2Vj0YHultq0jk+uBF2UAiwJa1GYgwt4=;
 b=UwFV7Spsf3fyqWsq4FUIR8rF0zQKtla+P+FTcHJ2ZYO6gWeswlWlAJ4kuj+Ax8q/l6
 Pni0DpcoDMsP7hEfOEXQovGwZ97XL3pSO4Li5cvXNsiN55fgfaInHxnmOn+AIZCHkpm1
 NJaPr3068fN/wIVrAPULPDAwM++sT1fXDXzsK+LLWFApQ8hsYeQhsAivHDlekgcd+VIe
 dIDGgDaK+AUgg74m/vOnW36CVF2Y948DqwJEnKTjSuNEIrQia9UI63N/opUDqhVbC5Oy
 6dKaGslXLnSJN0Dl1e2IvUH4fMEFPv6faf0Y3T8Veqd3khQZyi86Gfux8grDOfXeJ7V2
 7e9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ArrNOO2wlymy2Vj0YHultq0jk+uBF2UAiwJa1GYgwt4=;
 b=Z4qwKVaAnXuN/JXVJPg5dVoCDyEcf2ZY2iN9eVm7KCEvD5skXqcNuOsml7E2dW2mfr
 LKT1X8Rrx41T2SmcV8nNxKbohHHZSfnQbvSCVCB0mvM+PPAPJC5BjgMUOmd2npHKUUCh
 cIyWLRs3GdOJdcQjmEySMYF6UAO4Nt7Sf6u5ZBd16ONSz3chuzK8YTVbbv17dItTUgeR
 X4JizlK5dF2byy6tZhx4LdNoK05NDzjs9lS884YSLfj5lWaB0FUuUSRgDmotasHtPAaw
 YA+dH2pKBVzhvNAP4SRGC6LImRINBE947w5ontWMYcdwvkXF3uB6WeCJZm+Wvq/3ROdI
 mOVg==
X-Gm-Message-State: ANhLgQ3KMh6fPJ6s1WvRaXJdW3wzwh15DpJlzSYIL3KhwrwynWOfCVsb
 YNnd7l9J/gQmtJGw52Sa+AEFz1F+
X-Google-Smtp-Source: ADFU+vsguXrFHHDmq87Igt4YWiA0uWkkNWVxbltg1q1MR4YNfkBxP4cNNBwIcM1fBVDbqIwTH4Wn9g==
X-Received: by 2002:a62:2fc2:: with SMTP id
 v185mr28487961pfv.192.1584353083426; 
 Mon, 16 Mar 2020 03:04:43 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:284:a4f2:cc63:b7fc:551c:dce5])
 by smtp.gmail.com with ESMTPSA id
 u3sm19803374pjv.32.2020.03.16.03.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:04:43 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 16 Mar 2020 15:33:13 +0530
Message-Id: <20200316100319.27935-21-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 11:04:48 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 16 Mar 2020 11:04:45 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 20/26] parsing_cocci: ast_cocci: Add cases for
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
cases for these types in ast_cocci.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/ast_cocci.ml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/parsing_cocci/ast_cocci.ml b/parsing_cocci/ast_cocci.ml
index f8e6dee6..4fea9794 100644
--- a/parsing_cocci/ast_cocci.ml
+++ b/parsing_cocci/ast_cocci.ml
@@ -1110,6 +1110,10 @@ let rec string_of_typeC ty =
       string_of_fullType ty' ^ "*"
   | FunctionPointer (ty', _, _, _, _, _, _) ->
       string_of_fullType ty' ^ "(*)()"
+  | ParenType (_ , ty', _) ->
+      "(" ^ string_of_fullType ty' ^ ")"
+  | FunctionType (ty' , _, _, _) ->
+      string_of_fullType ty' ^ "()"
   | Array (ty', _, _, _) ->
       string_of_fullType ty' ^ "[]"
   | Decimal(_, _, e0, _, e1, _) ->
@@ -1191,6 +1195,10 @@ and typeC_map tr ty =
   | Pointer (ty', s) -> rewrap ty (Pointer (fullType_map tr ty', s))
   | FunctionPointer (ty, s0, s1, s2, s3, s4, s5) ->
       rewrap ty (FunctionPointer (fullType_map tr ty, s0, s1, s2, s3, s4, s5))
+  | ParenType (s0, ty', s1) ->
+      rewrap ty (ParenType (s0, fullType_map tr ty', s1))
+  | FunctionType (ty', s0, s1, s2) ->
+      rewrap ty (FunctionType (fullType_map tr ty', s0, s1, s2))
   | Array (ty', s0, s1, s2) ->
       rewrap ty (Array (fullType_map tr ty', s0, s1, s2))
   | EnumName (s0, ident) ->
@@ -1250,6 +1258,8 @@ and typeC_fold tr ty v =
   | SignedT (_, Some ty') -> typeC_fold tr ty' v
   | Pointer (ty', _)
   | FunctionPointer (ty', _, _, _, _, _, _)
+  | ParenType (_, ty', _)
+  | FunctionType (ty', _, _, _)
   | Array (ty', _, _, _)
   | EnumDef (ty', _, _, _)
   | StructUnionDef (ty', _, _, _) -> fullType_fold tr ty' v
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
