Return-Path: <SRS0=O8dQ=7N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C6EC433E0
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55742206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCj++rnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55742206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFR8NN000835;
	Sun, 31 May 2020 17:27:08 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C6CA67752;
	Sun, 31 May 2020 17:27:08 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 709FC3C89
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:06 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFR4f2024284
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:05 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id m7so3234051plt.5
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QLCn+hu3XyMfTe5JXU0MfTa2zkxECdy10Y5As/RVP0E=;
 b=FCj++rnjW+cYPTyeP0hfMv4C7d4Ot071iIIIghq1lASRiIZdXCTarosduBzeARAW3C
 PxqgBRzv6ezdChBkskaATLTf3GsoFfx+oYw9VUa0oluagg+exAgnXFr+X1DLvTvHhJss
 XsbxiAnKwO6kYLBG++tyFuW9S2YG8Xz7T1lZTLyHgHnpZrC9ofqCSkTDZRVuDLIb5YLc
 UoP4Q1sQZh7o1S3U23Q02mJK4nwTQNjLBbCyB/swRNluiEszace0TyGxBw1OfVxZduWo
 0iecXsT/w2zfLVmS77xpr2Dc1GUZRLnFdwypYQ9ssj/VD26g6w5SxxjAzGBp+V6ujY9Z
 WfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QLCn+hu3XyMfTe5JXU0MfTa2zkxECdy10Y5As/RVP0E=;
 b=qR3cw3E8wooFS87oBmZKiA26ZDIoYfDqt4xgVSC0jvSseWC8yBtxMgU99ZJyDW2Bk3
 Fe0gQBpjZtHBcXKA56C+4T1yfkzSwOghiNbIYojUFK2ER3RRj+g3gjM7WBv5838c0bTL
 D8EYrozftN4jK8zubz9f7IeU6FPZ5YtwUla8KUimm6T6X2Ej5sJtiPc6uS2tII1sSPWn
 Y73yrjEJRFlI1CQAlisURgZkZIm9iXPQ9p8xyKMZWo/ERz9vjvziwxFiua57ItQPqDnC
 wVcXpVSMbKfuwV9TiVD5Tj8O7VyUhMS1lSE3cjo+hoRA9AnUYFvnPD5inspLKnykIFXU
 EZLg==
X-Gm-Message-State: AOAM531ynjAwiClxHMg0Q4tmQsdOsSDSDoJ1GDcg9WSWAYXEvRfIELMu
 byEufpc58vrFWXNGnPyzHmZ3GhKp
X-Google-Smtp-Source: ABdhPJyqEqbSif+P4NiW+Er22CL/vN/Wc7Ubor6yJbRVzye7UcLeh20qtUYcfH0q7z5X/aavuAlhBA==
X-Received: by 2002:a17:902:7618:: with SMTP id
 k24mr16971641pll.167.1590938823208; 
 Sun, 31 May 2020 08:27:03 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:27:02 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:55:54 +0530
Message-Id: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:27:09 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:27:05 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 00/27] cocci: Add struct end attributes to SmPL
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

This patch series aims to add struct/union end attributes to SmPL, and is a
continuation of the series "cocci: Improve C parsing of attributes"[1].

Two test cases are included:

- detect_struct_endattr: Test case to detect a struct end attribute.

- remove_struct_endattr: Test case to remove a struct end attribute as per the
  given SmPL.

- remove_struct_endattr_allminus: Test case to remove a struct definition and
  check if the end attribute is removed as well.

This series is rebased on [2].


[1]:
[RFC PATCH 00/25] cocci: Improve C parsing of attributes
https://lore.kernel.org/cocci/20200424091801.13871-1-jaskaransingh7654321@gmail.com/

[2]:
[PATCH 00/30] cocci: Add macrodecl attributes to C and SmPL ASTs
https://lore.kernel.org/cocci/20200524171935.2504-1-jaskaransingh7654321@gmail.com/


Jaskaran Singh (27):
      parsing_cocci: ast0_cocci: Add struct end attributes
      parsing_cocci: parser: Reflect struct end attributes
      parsing_cocci: visitor_ast0: Visit struct end attributes
      parsing_cocci: unparse_ast0: Reflect struct end attributes
      parsing_cocci: index: Reflect struct end attributes
      parsing_cocci: iso_pattern: Reflect struct end attributes
      parsing_cocci: type_infer: Reflect struct end attributes
      parsing_cocci: arity: Reflect struct end attributes
      parsing_cocci: check_meta: Reflect struct end attributes
      parsing_cocci: compute_lines: Reflect struct end attributes
      parsing_cocci: context_neg: Reflect struct end attributes
      parsing_cocci: single_statement: Reflect struct end attributes
      parsing_cocci: ast_cocci: Add struct end attributes
      parsing_cocci: visitor_ast: Visit struct end attributes
      parsing_cocci: pretty_print_cocci: Reflect struct end attributes
      parsing_cocci: disjdistr: Reflect struct end attributes
      parsing_cocci: adjust_pragmas: Reflect struct end attributes
      parsing_cocci: unify_ast: Reflect struct end attributes
      parsing_cocci: ast0toast: Reflect struct end attributes
      parsing_c: unparse_cocci: Reflect struct end attributes
      engine: check_exhaustive_pattern: Reflect struct end attributes
      engine: cocci_vs_c: Match struct end attributes
      ocaml: coccilib: Reflect struct end attributes
      tools: spgen: Reflect struct end attributes
      tests: Add test case to remove a struct end attribute
      tests: Add test case to detect a struct end attribute
      tests: Add test case to check struct endattr allminus

 engine/check_exhaustive_pattern.ml         |    4 ++--
 engine/cocci_vs_c.ml                       |   17 ++++++++++-------
 ocaml/coccilib.mli                         |    4 ++--
 parsing_c/unparse_cocci.ml                 |    6 +++++-
 parsing_cocci/adjust_pragmas.ml            |    8 ++++----
 parsing_cocci/arity.ml                     |    8 +++++---
 parsing_cocci/ast0_cocci.ml                |    2 +-
 parsing_cocci/ast0_cocci.mli               |    2 +-
 parsing_cocci/ast0toast.ml                 |    5 +++--
 parsing_cocci/ast_cocci.ml                 |    2 +-
 parsing_cocci/ast_cocci.mli                |    2 +-
 parsing_cocci/check_meta.ml                |    2 +-
 parsing_cocci/compute_lines.ml             |    5 +++--
 parsing_cocci/context_neg.ml               |    3 ++-
 parsing_cocci/disjdistr.ml                 |    4 ++--
 parsing_cocci/index.ml                     |    2 +-
 parsing_cocci/iso_pattern.ml               |    9 +++++++--
 parsing_cocci/parser_cocci_menhir.mly      |    8 ++++----
 parsing_cocci/pretty_print_cocci.ml        |    6 +++++-
 parsing_cocci/single_statement.ml          |    4 ++--
 parsing_cocci/type_infer.ml                |    2 +-
 parsing_cocci/unify_ast.ml                 |    5 ++++-
 parsing_cocci/unparse_ast0.ml              |    6 +++++-
 parsing_cocci/visitor_ast.ml               |   10 ++++++----
 parsing_cocci/visitor_ast0.ml              |    5 +++--
 tests/detect_struct_endattr.c              |   13 +++++++++++++
 tests/detect_struct_endattr.cocci          |    9 +++++++++
 tests/detect_struct_endattr.res            |   12 ++++++++++++
 tests/remove_struct_endattr.c              |    7 +++++++
 tests/remove_struct_endattr.cocci          |    7 +++++++
 tests/remove_struct_endattr.res            |    7 +++++++
 tests/remove_struct_endattr_allminus.c     |   13 +++++++++++++
 tests/remove_struct_endattr_allminus.cocci |    6 ++++++
 tests/remove_struct_endattr_allminus.res   |    1 +
 tools/spgen/source/position_generator.ml   |    4 ++--
 35 files changed, 158 insertions(+), 52 deletions(-)



_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
