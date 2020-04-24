Return-Path: <SRS0=cw0N=6I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACADC2BA1A
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4401320724
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvXpW81o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4401320724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03O9J3cR015783;
	Fri, 24 Apr 2020 11:19:03 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4F6147827;
	Fri, 24 Apr 2020 11:19:03 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A5F267815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:01 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03O9IxtB005540
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:00 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id g6so4353546pgs.9
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 02:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WJXJOG837ljJDf1BCpsh0Gm8keDx/MYNVfJwGzLbhs4=;
 b=TvXpW81ovHbfhs+kawU5obrDOyv265F6F6k5FAR9uv2eXlEdYgoq5AASqmS+A1K3vW
 u+WC+0mmNBJFXElJNYQ+9SmyT2vmsvrL22RJ1rGrfcVyFjE+4/MSf/nc2RwMRhqGAoAt
 jwBf9XEmSV4WGor59LLvR1gij0nZ/XNMj4PO8VdQImFts13r2iYeMiV0tnT55ltquxxU
 Ik7Xwbv5j7f0WMeUmtWTq+Rw7DJI59iQuYB2sMSne7P1lvHVfxcUFuRWJ7O0UNbAKmSS
 5YYzrDvYt59qkB/tQ8CPMp8U3Z74baNp8qWNFW5BOyaZwXMi9ypLfDXCNDu5hDTBCK4Q
 Cozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WJXJOG837ljJDf1BCpsh0Gm8keDx/MYNVfJwGzLbhs4=;
 b=kiKxSBhSV+PO+x+hvq4pLYAeRVXTnze6q5crL1QTaLmDgEbWi6kYadn5kq/ZG9z+wH
 oCRD+69OuLfb8wMSM2Lx32OyBM4I0FhshW728JaaP5jwaxqWQmY9GGff/d3U5G1muHxQ
 Yc7ScEoI/pY3d4JXBbnaJSECRezdbelTl4+wjHS5ur3aq3koP3fxI9B6x6vjzDd1UxEp
 GepW+2uQHOVASIlUR1G/qDSdRQB6xk4i8rPGerlurQUEXss5t+N7MAHgQEsDl9EENFpV
 j8bvcOHCWqpJI/n8MbpvbqN9pzhJFTgcLDApJkKmvDVbKBJ4xrxFhJb5ZZhyCAX4X+2i
 oV4w==
X-Gm-Message-State: AGi0PuY7vRA0SOVL5fTY7GXiGkPZrMBKnL8jGzRAB5ucobvdiqk7cYXq
 bHqNkml52tE0qNSkxAX0WUK0LkuTfjU=
X-Google-Smtp-Source: APiQypJIg9N7H441n+AG4PB2KacFR9P7niMfDBVY03Rxk4J34lcHHsgVssvh4+NDXHv0+qHokq5NLg==
X-Received: by 2002:a63:1705:: with SMTP id x5mr8361728pgl.12.1587719939202;
 Fri, 24 Apr 2020 02:18:59 -0700 (PDT)
Received: from localhost.localdomain ([1.38.216.60])
 by smtp.gmail.com with ESMTPSA id c80sm5043933pfb.82.2020.04.24.02.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 02:18:58 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 24 Apr 2020 14:47:44 +0530
Message-Id: <20200424091801.13871-9-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
References: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 11:19:03 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 24 Apr 2020 11:19:01 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [RFC PATCH 08/25] parsing_c: parser: Add field declaration
	end attributes production
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

As per GCC's C grammar, the struct-declarator rule has the following
productions:

	struct-declarator:
	  declarator gnu-attributes[opt]
	  declarator[opt] : constant-expression gnu-attributes[opt]

While these productions are handled in the struct_declarator rule of
Coccinelle's C grammar, end attributes are not.

Add productions for end attributes in the field_declaration rule of
Coccinelle's C parser. This parses the following C code from Linux
v5.6-rc7 successfully:

  kernel/sched/sched.h:

	struct task_group {
		...
		atomic_t load_avg __cacheline_aligned;
		...
	};

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parser_c.mly | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index 1ff2fd87..8def5f0d 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -1847,6 +1847,22 @@ field_declaration:
           *)
      }
 
+ | spec_qualif_list struct_declarator_list end_attributes TPtVirg
+     {
+       let (attrs, ds) = $1 in
+       let (returnType,storage) = fixDeclSpecForDecl ds in
+       if fst (unwrap storage) <> NoSto
+       then internal_error "parsing don't allow this";
+
+       let iistart = Ast_c.fakeInfo () in (* for parallelism with DeclList *)
+       FieldDeclList ($2 +> (List.map (fun (f, iivirg) ->
+         f returnType, iivirg))
+                         ,[$4;iistart])
+         (* don't need to check if typedef or func initialised cos
+          * grammar don't allow typedef nor initialiser in struct
+          *)
+     }
+
  | spec_qualif_list TPtVirg
      {
        let (attrs, ds) = $1 in
@@ -1859,6 +1875,18 @@ field_declaration:
        FieldDeclList ([(Simple (None, returnType)) , []], [$2;iistart])
      }
 
+ | spec_qualif_list end_attributes TPtVirg
+     {
+       let (attrs, ds) = $1 in
+       (* gccext: allow empty elements if it is a structdef or enumdef *)
+       let (returnType,storage) = fixDeclSpecForDecl ds in
+       if fst (unwrap storage) <> NoSto
+       then internal_error "parsing don't allow this";
+
+       let iistart = Ast_c.fakeInfo () in (* for parallelism with DeclList *)
+       FieldDeclList ([(Simple (None, returnType)) , []], [$3;iistart])
+     }
+
 
 
 
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
