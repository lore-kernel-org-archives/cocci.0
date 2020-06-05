Return-Path: <SRS0=TTUf=7S=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33812C433E2
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A593D2075B
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMLELhXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A593D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 055DihxV004553;
	Fri, 5 Jun 2020 15:44:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 617C27567;
	Fri,  5 Jun 2020 15:44:43 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AED773F9A
 for <cocci@systeme.lip6.fr>; Fri,  5 Jun 2020 15:44:41 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 055DidwX019353
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 5 Jun 2020 15:44:40 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id y17so3648042plb.8
 for <cocci@systeme.lip6.fr>; Fri, 05 Jun 2020 06:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AG7aKTjYrpWO29CJRPMqYtbq2fkHSj17rRnvdb8I1QQ=;
 b=GMLELhXtIhZu3O5zhm2xEv/q6Rb707cFKYmAoi/uMaKvDVpSNIIrweBhPAsQKqBYU0
 uyo1elA3C9u4/M7Puk6w6Jw2VQ4F1k1h4z/Z789euSIVNu20VwJW8wlsSd7tpAZowHHx
 pJZ+oWYuDQ5+EagG4u9C7QbaAbCWNMiYY/Et7kB4laF1kyQB1OMIIsl48vEOjE7urG/d
 uHGwP3erj5K9Uqzsifg/H8YBCaJId3kYmJqUPEGZecL3xRQfzL9Rs8HHmHXE20xHU69+
 pLtZTjzAK0Ox0mCOlw+45vQ+6Zls+Yunj1IGAKAjcf/pOR/n+rvkdPa/RZs22RqLVcPQ
 i3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AG7aKTjYrpWO29CJRPMqYtbq2fkHSj17rRnvdb8I1QQ=;
 b=AMdWZivEakPMbDmR2+hlUx1+13bs01SkR5ATyP79b1t2tkA/+WLI4jktbUmL9Xi/CW
 nlN7Cz5VEYyhPjxix3YqDJ6hhslGZr05UqmK2a1Fb6yupLUcrbszP6Agwhgj/OOokLWV
 lU+9Uy9e/yuHUBvpRJQCRZxX7qIzxcV78iDP/0N/QIk2beoNjODB8U27K33P1gxTkHgl
 t7s1OamWaf0zfdvTljgpf0IEfahoK45rvIqqpM0OH44kJoOlsCibCF7ZuzSfUuxkzUv6
 buFuwVVFhYyqW4wqYcjPsvbOFqZpF8koOKQvytVn/PFGdnJdQzScvybisjYKrxrsho5P
 cRYA==
X-Gm-Message-State: AOAM532U/xunoL1sbf/MMZRCDvNIkpyRTOE0MTTc2lV1PuE9sgBtP1wn
 4iVDaFOKtCz1CR8gCg3/6Z8AKeIkA34=
X-Google-Smtp-Source: ABdhPJwEHmzCXmTgCaQlLMtflPrrQ46g8M8a/u1NwhPSVWkt2cdYAS7vaM4NUKvcCa3RZC9OEQZWkw==
X-Received: by 2002:a17:90a:70c6:: with SMTP id
 a6mr2945733pjm.16.1591364679227; 
 Fri, 05 Jun 2020 06:44:39 -0700 (PDT)
Received: from localhost.localdomain ([1.38.221.125])
 by smtp.gmail.com with ESMTPSA id w186sm7861353pff.83.2020.06.05.06.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 06:44:38 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri,  5 Jun 2020 19:13:17 +0530
Message-Id: <20200605134322.15307-10-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
References: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jun 2020 15:44:43 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 05 Jun 2020 15:44:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v4 09/14] parsing_c: parser: Add field declaration
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
 parsing_c/parser_c.mly | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index 9afbd68c..5b7e1faf 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -1830,7 +1830,7 @@ struct_decl2:
 
 
 field_declaration:
- | spec_qualif_list struct_declarator_list TPtVirg
+ | spec_qualif_list struct_declarator_list end_attributes_opt TPtVirg
      {
        let (attrs, ds) = $1 in
        let (returnType,storage) = fixDeclSpecForDecl ds in
@@ -1840,13 +1840,13 @@ field_declaration:
        let iistart = Ast_c.fakeInfo () in (* for parallelism with DeclList *)
        FieldDeclList ($2 +> (List.map (fun (f, iivirg) ->
          f returnType, iivirg))
-                         ,[$3;iistart])
+                         ,[$4;iistart])
          (* don't need to check if typedef or func initialised cos
           * grammar don't allow typedef nor initialiser in struct
           *)
      }
 
- | spec_qualif_list TPtVirg
+ | spec_qualif_list end_attributes_opt TPtVirg
      {
        let (attrs, ds) = $1 in
        (* gccext: allow empty elements if it is a structdef or enumdef *)
@@ -1855,7 +1855,7 @@ field_declaration:
        then internal_error "parsing don't allow this";
 
        let iistart = Ast_c.fakeInfo () in (* for parallelism with DeclList *)
-       FieldDeclList ([(Simple (None, returnType)) , []], [$2;iistart])
+       FieldDeclList ([(Simple (None, returnType)) , []], [$3;iistart])
      }
 
 
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
