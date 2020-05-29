Return-Path: <SRS0=Yx51=7L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D30C433E0
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:09:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A094D206F0
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFv2ofrk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A094D206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04TC9srF011348;
	Fri, 29 May 2020 14:09:54 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 28C437783;
	Fri, 29 May 2020 14:09:54 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 52A0D5D47
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:09:52 +0200 (CEST)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04TC9oY9009955
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:09:51 +0200 (CEST)
Received: by mail-pg1-x542.google.com with SMTP id o6so586632pgh.2
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 05:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D0QvzcJdnxs5FOqQZUwMdH+ePAV0OSOpsV/1LQynJ30=;
 b=IFv2ofrkY3SWtycUW2Vh6g647GGfsQpkBvzx+74FSo+R0G1phlzkCemdXEFcpBuuob
 HcMqIZWahT77+K1fggKG3VoF7w2EqkIBTFpWdsc4jvv7NM8cNU0KpwHJq4+o17HD9+81
 XGCjPUZ0qvYaBG1EUR4x//D6oly4ImiM5hXObE48XkpGu71eM92gmsXGQcHgO+EQ0Hfl
 C946/fIXMKOMfhLfXV9O81IKqFBrUHL+J9KVLUVtnU/Mnk1vyDkQohmwF1axytZkOuk+
 9MuP5KS9sxK2fGgSIPIL/tsfz7jR8ZJhN/aooQxapaEVveI3UdaWKI3lmWywGsW1pR2g
 cLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D0QvzcJdnxs5FOqQZUwMdH+ePAV0OSOpsV/1LQynJ30=;
 b=odbaiWYpqbzA+ClZHrWq0AYJnZfYQUrdfYAiBERQwL5b2eEpJZrtHh7Os/LvldC+hD
 rPnlfuMtkdnVV7iVgHYVC2kgJJpV3cy7adicKbCpWk/7ABYSe+7o0nuXNsizGIIyX3oI
 N/2xazDdI5CmcrN6aOPbmTWVaEszZ/Vw3x4drRwrMp0OdfikaX5QtifXjxcftOMVSqvQ
 besOYUBDfWqeOzbfSAry0RaeHRkoujnuaGoT90vzYftTyF/IdhoLyZmwv9+uoAvGCFAU
 8rj6z/6ao7mb7OywiVH31FkzQ0GOFUKKiIOeGz5wUgfIb59/k63gSPNYBb82zMzKmk9g
 fhHg==
X-Gm-Message-State: AOAM530VGy3FVdpCuJCctIrF7FG99yIrrhWE8iSMnLkJiW0+Zd8sbZVL
 Nso7WTiBfA29GF9S3WApIMjVpv+K
X-Google-Smtp-Source: ABdhPJwwsHZQgPruXLWIDHJSm/Q0Altn6a2+SVa/aEoVAi2Bew2h6dbItPjCflyMqEC7KlS+7fGJbw==
X-Received: by 2002:a62:640b:: with SMTP id y11mr8764353pfb.318.1590754189861; 
 Fri, 29 May 2020 05:09:49 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:694:e576:19d1:a79b:707d:59f2])
 by smtp.gmail.com with ESMTPSA id dw13sm7975161pjb.40.2020.05.29.05.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:09:49 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 29 May 2020 17:36:52 +0530
Message-Id: <20200529120703.31145-23-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
References: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 May 2020 14:09:54 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 May 2020 14:09:51 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 22/32] parsing_c: pretty_print_c: Reflect Cast
	attributes
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

Cast attributes are added to the SmPL AST. Print these attributes in
pretty_print_c.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/pretty_print_c.ml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/parsing_c/pretty_print_c.ml b/parsing_c/pretty_print_c.ml
index b9b9b929..1a4a8f17 100644
--- a/parsing_c/pretty_print_c.ml
+++ b/parsing_c/pretty_print_c.ml
@@ -146,8 +146,9 @@ let mk_pretty_printers
 	pp_expression e
     | SizeOfType  (t),     [i1;i2;i3] ->
         pr_elem i1; pr_elem i2; pp_type t; pr_elem i3
-    | Cast    (t, e),      [i1;i2] ->
-        pr_elem i1; pp_type t; pr_elem i2; pp_expression e
+    | Cast    (t, a, e),   [i1;i2] ->
+        pr_elem i1; pp_type t; a +> pp_attributes pr_elem pr_space;
+        pr_elem i2; pp_expression e;
 
     | StatementExpr (statxs, [ii1;ii2]),  [i1;i2] ->
         pr_elem i1;
@@ -184,7 +185,7 @@ let mk_pretty_printers
     | CondExpr (_,_,_) | Sequence (_,_) | Assignment (_,_,_)
     | Postfix (_,_) | Infix (_,_) | Unary (_,_) | Binary (_,_,_)
     | ArrayAccess (_,_) | RecordAccess (_,_) | RecordPtAccess (_,_)
-    | SizeOfExpr (_) | SizeOfType (_) | Cast (_,_)
+    | SizeOfExpr (_) | SizeOfType (_) | Cast (_,_,_)
     | StatementExpr (_) | Constructor _
     | ParenExpr (_) | New (_) | Delete (_,_)
     | Defined (_)),_ -> raise (Impossible 95)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
