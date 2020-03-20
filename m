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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB94C4332B
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFAC220774
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIvgeQJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFAC220774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K73ViF009250;
	Fri, 20 Mar 2020 08:03:31 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2A144780E;
	Fri, 20 Mar 2020 08:03:31 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8285D3B93
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:03:29 +0100 (CET)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:444])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02K73RWM015468
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:03:28 +0100 (CET)
Received: by mail-pf1-x444.google.com with SMTP id l184so2748610pfl.7
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 00:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ArrNOO2wlymy2Vj0YHultq0jk+uBF2UAiwJa1GYgwt4=;
 b=bIvgeQJ5Za+pl9hBEvOwM8kOcJrSlNi56xK7wkv5NFbechcr5tLMsHhsAVpGTW/T67
 R+MVEcA88zTZ89OmdIsj+Y8rWqYi41ip8u4loYQB6z4eoNIFanptqYlMJ8v29bEaP4uQ
 lEkyYSi6ncIVKoqP01utQWZtd0EGyNUceDwuqeuQaC6j3qf1PRdJRmBgXEDyI6n8Alsh
 3OtECk8u9GDhnx8btSdfJDVXbNtSpljdxho11MB1fAenpYYPPJiQSIICt5CPRJDBMHm5
 6MPqsPD2Rlw08a5cKrfhnvgP7w220v2N5+jiuSxZHL74T2eHENBPNKSO+bX55m7CqUaZ
 4KhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ArrNOO2wlymy2Vj0YHultq0jk+uBF2UAiwJa1GYgwt4=;
 b=J7KrHduGNEQQc69LKy/OiAklNoXnt05NBlCyZVfsfMmrYYMRfPf2RWLPU29j9Tkdpw
 wUNB3f2Lh2ERRUIq0XAMHIaQRe3ncmP/E6H/D+6IYnKKXFGkZ6wYWFGouHJfznY0Qe7z
 EuAGmJbX3XFlNZRplDdp2x0+VzoXcU0jJYDvAiInVLLLOLh7WjGcFr0C/Y84Kludophe
 qAstA2t2W2c8mG8j09Ffje9GvChcBuaz9WLe7F6B8QzihtMXvwle9udEjY602WuTZPYT
 6Y+zI1KmbSU6SDuGFay65jQwWoyi44xu/SUpf3rRT06i68cUX7Gay1diQ98SaSeq+eCr
 nO5g==
X-Gm-Message-State: ANhLgQ2NmCl0kIoer6Ouq2aSIVSbw1DvQI66Z1XaBEA3Ojw6r7aJhFsL
 mA6VizepPmi0UwD9MpBl7w5sAucR
X-Google-Smtp-Source: ADFU+vus+n3hvjNEw+FutfIcYeo9c67roFBP0Gfb0n4/JCvr+loIhNr4RYqZRfEzpD3oclvOf8imiw==
X-Received: by 2002:a62:8244:: with SMTP id w65mr6546627pfd.114.1584687807069; 
 Fri, 20 Mar 2020 00:03:27 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2190:a751:deeb:c09d:833a:659d])
 by smtp.gmail.com with ESMTPSA id l11sm3941232pjy.44.2020.03.20.00.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 00:03:26 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 20 Mar 2020 12:31:51 +0530
Message-Id: <20200320070157.4206-21-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
References: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 08:03:31 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Mar 2020 08:03:29 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 20/26] parsing_cocci: ast_cocci: Add cases for
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
