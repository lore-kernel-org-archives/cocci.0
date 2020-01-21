Return-Path: <SRS0=kxF3=3K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F85C47409
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 12:28:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F92621734
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 12:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxQ0MCKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F92621734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00LCRdMV013687;
	Tue, 21 Jan 2020 13:27:39 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1483B77E4;
	Tue, 21 Jan 2020 13:27:39 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7A2E677E1
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 13:27:37 +0100 (CET)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00LCRVed023457
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 13:27:32 +0100 (CET)
Received: by mail-pl1-x641.google.com with SMTP id p27so1269144pli.10
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 04:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IsJaYZtQo19fVGMr85I01baXl5YZLZhRFya5p7CvVcc=;
 b=jxQ0MCKhhCdXQfG13FK1N8EIeQabN+ZwE5xg8lRdnRG6k3Wf3MgawtTLlAwHA9+yCU
 SF8U5ok7ybM5buPCtTJ2wiS6BaWILw3EsFytD74I+Oc+JxxVsifQPJj5oge1WIu7GAgg
 SYAV5ZQlAwU6tK9vgQmcgNNCqT23ATrQYMu/AiqOr8hahxuU37C62VVCpQ+nfbFTQc0w
 +tjN8xi10gYIV8/3Hlb+5cvOz14LKO+tnNZTwyCfEYpXh0kNdhuhO5xd1QymgSmCtrjB
 y2kQfrvYss5gOb6GY+xoSLD/HjzzKoNzKrayw9hgh9UDvrL+f3eQpBK3MEVLrfDKoSM6
 5/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IsJaYZtQo19fVGMr85I01baXl5YZLZhRFya5p7CvVcc=;
 b=dNrgSF97bRtivZ1DSR+oyMfKy9uItaLNVV5HR3522ztld7cLObN//ZLAjc4TxArmWu
 HobxCKnSdqnUybN1vxKQBcsHGThyWRh6+3A7fiSC/5f5vqyt+VcbZ34SNk1iNYfg1VU6
 8vrUx5lf7GqwrNLZP6MFdP7ak/31e4gOwC6gbN3rQE7prglVlEeYDi+guNoImCRLzxp3
 EwwtjCXDiI2DjPErVpcOR1Ize/L/BuCi6kWZfokYsBqAPehTlyPrJUl71o5AxHJt2mX3
 eCrAMS4eAiQYlwY/EFQ9fPksNsHHVJuRyAnmNyYJ292/RKgPU4WTYnQC0km1MEn3LcMd
 tGzQ==
X-Gm-Message-State: APjAAAWUgsVOGzZmZngA/mn/c3lWcDU7woiuwaBkB3qOxQTyeFPq17Bl
 bEShB2MvnbYEHp5Ibs1+woY3SajQwI4=
X-Google-Smtp-Source: APXvYqxQYHQpzequEiKEEkgjz+ZzR514ghsazq64tUGImZDU8JlumnwVK1R/i611HWN8vLMd6boSyA==
X-Received: by 2002:a17:90a:20aa:: with SMTP id
 f39mr5197189pjg.35.1579609651316; 
 Tue, 21 Jan 2020 04:27:31 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:167e:da7:fcf8:ab67:c0bb:e29])
 by smtp.gmail.com with ESMTPSA id
 i9sm44381347pfk.24.2020.01.21.04.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 04:27:31 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 21 Jan 2020 17:57:17 +0530
Message-Id: <20200121122719.24226-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200121080455.24748-1-jaskaransingh7654321@gmail.com>
References: <20200121080455.24748-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 21 Jan 2020 13:27:39 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 21 Jan 2020 13:27:32 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 1/3] parsing_c: Handle case of macro before
	typedef
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

For the following case:

<macro> <typedef> <identifier>

A case in parsing_hacks.ml sometimes mislabels <macro> as a
typedef identifier.

If typedef is a known typedef (such as u8 or *_t), then label <macro>
as a CppMacro. Subsequent cases will continue to label <typedef>
correctly as a typedef identifier.

Following are results of --parse-c on the Linux Kernel v5.5-rc4:

Before:

  nb good = 18956150,  nb passed = 134061 =========> 0.70% passed

After:

  nb good = 18956150,  nb passed = 134062 =========> 0.70% passed

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parsing_hacks.ml | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/parsing_c/parsing_hacks.ml b/parsing_c/parsing_hacks.ml
index 8374731b..23d675cf 100644
--- a/parsing_c/parsing_hacks.ml
+++ b/parsing_c/parsing_hacks.ml
@@ -2184,6 +2184,41 @@ let lookahead2 ~pass next before =
       && ok_typedef s && is_macro s2 && is_type type_
         ->
 	  TIdent (s, i1)
+
+  (* xx yy zz : xx is a macro *)
+  | (TIdent (s, i1)::TIdent (s2, i2)::TIdent(_,_)::_ , _)
+    when not_struct_enum before
+	&& ok_typedef s2
+	&& is_known_typdef s2
+        ->
+	  TCommentCpp(Token_c.CppMacro, i1)
+
+  (* xx yy zz : xx is a typedef ident *)
+  | (TIdent (s, i1)::TIdent (s2, i2)::TIdent(_,_)::_ , _)
+    when not_struct_enum before
+	&& ok_typedef s
+        ->
+      msg_typedef s i1 2; LP.add_typedef_root s i1;
+      TypedefIdent (s, i1)
+
+  (* xx yy * zz : xx is a macro *)
+  | (TIdent (s, i1)::TIdent (s2, i2)::ptr , _)
+    when pointer ~followed_by:(function TIdent _ -> true | _ -> false) ptr
+	&& not_struct_enum before
+	&& ok_typedef s2
+	&& is_known_typdef s2
+        ->
+	  TCommentCpp(Token_c.CppMacro, i1)
+
+  (* xx yy * zz : xx is a typedef ident *)
+  | (TIdent (s, i1)::TIdent (s2, i2)::ptr , _)
+    when pointer ~followed_by:(function TIdent _ -> true | _ -> false) ptr
+	&& not_struct_enum before
+	&& ok_typedef s
+        ->
+      msg_typedef s i1 2; LP.add_typedef_root s i1;
+      TypedefIdent (s, i1)
+
   (* xx yy *)
   | (TIdent (s, i1)::TIdent (s2, i2)::rest  , _) when not_struct_enum before
 	&& ok_typedef s && not (is_macro_paren s2 rest)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
