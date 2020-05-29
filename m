Return-Path: <SRS0=Yx51=7L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA08FC433E0
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:08:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C692074D
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1WK1mR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C692074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04TC8DbI025106;
	Fri, 29 May 2020 14:08:13 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C4E377783;
	Fri, 29 May 2020 14:08:13 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E1FE65D47
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:08:11 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:530])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04TC89DB016321
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:08:10 +0200 (CEST)
Received: by mail-pg1-x530.google.com with SMTP id s10so1419749pgm.0
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 05:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PdnWVLRH6peS+ppaM2qceL+5ngeoU1ip/LxhBv6SPr0=;
 b=p1WK1mR7a8zrZETUZMQak7X1IBLQ9bjWDa3cSS8zXfLQPLgAOcaj1S/5+Wh4BtP9Di
 PXYFPMbfR1QKxBQ8D6VDiUSCHt6Gb76bJ4o9CW2iYETnBqJj6/lkA4udIAW7JQQK1FtU
 +MiIKwLmOSZZnrSKPexIabv4OhQrR7Leyajd9KYdh59e0Ws91qJ9MZX/Vfo1yhM+ItsH
 4WnD0jBqLitFjSqPr7EbRyRRiAF0j8fjZgdysTpuyZp8scs+yjH8snKdq9WfpzU4ixRM
 xggZWRzI5r0967uc9EjJ3lHgi1xIVODCptUwJbwP20ZYzhL8CkYsiAcQidgxz3vqdT/W
 StGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PdnWVLRH6peS+ppaM2qceL+5ngeoU1ip/LxhBv6SPr0=;
 b=lT/k0yntuESypoOCGnGyyLqUqYGsW/pDbKgR3zS6tOT+hzD8OALSiX1lk6cqyfki8/
 MJih430vAEGS5CgIQlJbTM5XkYdHsyGTgVPANiEYR/olHjsZAoY9cGw76t/hc40K5huR
 byY8YQuZuYJ8KCNqz19k4PrvTGCpz9ENV0UaoIsJWV7BvXIJtOY1BhgSj4GoYE4Y3kfc
 dtuqOwctZN+lGBcyup32AHJe5wbPlAhmbidyhk2tR5AbT9x20SFmZg8uZ1TIbFOvI6zj
 Xn+fqiM6qhwwxUOJudBVlPKorQDG4/bcR2XinzqioBOiOb3VS4fjyqLZ7fsYC5+HFh9H
 ER+g==
X-Gm-Message-State: AOAM5304MI3PusesS6wCKOldc8Ctw9ki3yPF4s83k84lE0pAF1J6AiDz
 B9e6AjWjEgEfN3ZsZYj0ZjXc+ZOA
X-Google-Smtp-Source: ABdhPJzY51k0fK6ns3yC0IOMXwlK+XEZEFWdi2F9lmeNq1imrLhgg0W2+aZxzbXQfoWv6welZ4NSuA==
X-Received: by 2002:a62:d41a:: with SMTP id a26mr8270058pfh.290.1590754088635; 
 Fri, 29 May 2020 05:08:08 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:694:e576:19d1:a79b:707d:59f2])
 by smtp.gmail.com with ESMTPSA id dw13sm7975161pjb.40.2020.05.29.05.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:08:07 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 29 May 2020 17:36:30 +0530
Message-Id: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 May 2020 14:08:14 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 May 2020 14:08:11 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 00/32] cocci: Add cast attributes to C and SmPL
	ASTs
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

This patch series aims to add cast attributes to the C and SmPL ASTs, and
match them in C source code. This is a continuation of the series "cocci:
Improve C parsing of attributes"[1].

Three test cases are included:

- detect_cast_attr: Test case to detect a parameter attribute.

- remove_cast_attr: Test case to remove a parameter attribute as per the
  given SmPL.

- remove_cast_attr_allminus: Test case to replace a type in a cast and
  checking if the attribute is removed as well.


Changes in v3:
--------------
Rebase as follows:
	v3 of "cocci: Add Parameter attributes to SmPL"[2]
	v3 of "cocci: Improve C parsing of attributes"[3]
	gitlab master branch (ffb87d9d)


Changes in v2:
--------------
parsing_c: parser: Pass attribute list from type_name
- Warn about dropped attributes in typeof and sizeof productions

parsing_cocci: parser: Parse cast attributes
- Mention in commit message that cast attributes are matched anywhere
  in a cast.

parsing_cocci: arity: Reflect Cast attributes
- Apply mcode2arity on attributes as well.

parsing_cocci: visitor_ast: Visit cast attributes
- Typo in commit message (AST0 -> AST).

parsing_c: pretty_print_c: Reflect Cast attributes
- Less space in front of [

parsing_c: ast_c: Add Cast attributes
- Switch places of expression and attributes in Cast type.

parsing_c: parser: Parse Cast attributes
- Switch places of expression and attributes in Cast type.

parsing_c: pretty_print_c: Reflect Cast attributes
- Switch places of expression and attributes in Cast type.
- Change printing order of cast elements.

parsing_c: type_annoter_c: Reflect Cast attributes
- Switch places of expression and attributes in Cast type.

parsing_c: visitor_c: Visit Cast attributes
- Switch places of expression and attributes in Cast type.
- Change visitor order of cast elements.

engine: cocci_vs_c: Match Cast attributes
- Switch places of expression and attributes in C AST Cast type.

ocaml: coccilib: Reflect Cast attributes
- Switch places of expression and attributes in C AST Cast type.


[1]https://www.mail-archive.com/cocci@systeme.lip6.fr/msg07133.html
[2]https://www.mail-archive.com/cocci@systeme.lip6.fr/msg07311.html
[3]https://www.mail-archive.com/cocci@systeme.lip6.fr/msg07439.html


Jaskaran Singh (32):
      parsing_c: parser: Pass attribute list from type_name
      parsing_cocci: ast0_cocci: Add cast attributes
      parsing_cocci: parser: Parse cast attributes
      parsing_cocci: visitor_ast0: Visit cast attributes
      parsing_cocci: unparse_ast0: Reflect cast attributes
      parsing_cocci: index: Reflect Cast attributes
      parsing_cocci: iso_pattern: Reflect Cast attributes
      parsing_cocci: type_infer: Reflect Cast attributes
      parsing_cocci: arity: Reflect Cast attributes
      parsing_cocci: check_meta: Reflect Cast attributes
      parsing_cocci: compute_lines: Reflect Cast attributes
      parsing_cocci: context_neg: Reflect Cast attributes
      parsing_cocci: single_statement: Reflect Cast attributes
      parsing_cocci: ast_cocci: Add cast attributes
      parsing_cocci: visitor_ast: Visit cast attributes
      parsing_cocci: pretty_print_cocci: Print cast attributes
      parsing_cocci: ast0toast: Reflect Cast attributes
      parsing_cocci: disjdistr: Reflect Cast attributes
      parsing_cocci: unify_ast: Reflect Cast attributes
      parsing_c: ast_c: Add Cast attributes
      parsing_c: parser: Parse Cast attributes
      parsing_c: pretty_print_c: Reflect Cast attributes
      parsing_c: type_annoter_c: Reflect Cast attributes
      parsing_c: unparse_cocci: Reflect Cast attributes
      parsing_c: visitor_c: Visit Cast attributes
      engine: check_exhaustive_pattern: Reflect Cast attributes
      engine: cocci_vs_c: Match Cast attributes
      ocaml: coccilib: Reflect Cast attributes
      tools: spgen: Reflect Cast attrs
      tests: Add test case to check cast attribute allminus
      tests: Add test case to remove cast attributes
      tests: Add test case to detect cast attributes


 engine/check_exhaustive_pattern.ml       |    2 +-
 engine/cocci_vs_c.ml                     |   24 +++++++++++++++++-------
 ocaml/coccilib.mli                       |    9 +++++----
 parsing_c/ast_c.ml                       |    2 +-
 parsing_c/ast_c.mli                      |    2 +-
 parsing_c/parse_c.ml                     |    4 +++-
 parsing_c/parser_c.mly                   |   27 ++++++++++++++++++---------
 parsing_c/pretty_print_c.ml              |    7 ++++---
 parsing_c/type_annoter_c.ml              |    4 ++--
 parsing_c/unparse_cocci.ml               |    6 ++++--
 parsing_c/visitor_c.ml                   |   11 +++++++++--
 parsing_cocci/arity.ml                   |    8 +++++---
 parsing_cocci/ast0_cocci.ml              |    4 ++--
 parsing_cocci/ast0_cocci.mli             |    4 ++--
 parsing_cocci/ast0toast.ml               |    5 +++--
 parsing_cocci/ast_cocci.ml               |    4 ++--
 parsing_cocci/ast_cocci.mli              |    4 ++--
 parsing_cocci/check_meta.ml              |    3 ++-
 parsing_cocci/compute_lines.ml           |    5 +++--
 parsing_cocci/context_neg.ml             |    2 +-
 parsing_cocci/disjdistr.ml               |    5 +++--
 parsing_cocci/index.ml                   |    2 +-
 parsing_cocci/iso_pattern.ml             |   12 +++++++++---
 parsing_cocci/parser_cocci_menhir.mly    |    9 +++++----
 parsing_cocci/pretty_print_cocci.ml      |    4 +++-
 parsing_cocci/single_statement.ml        |    2 +-
 parsing_cocci/type_infer.ml              |    2 +-
 parsing_cocci/unify_ast.ml               |    6 ++++--
 parsing_cocci/unparse_ast0.ml            |    4 +++-
 parsing_cocci/visitor_ast.ml             |   10 ++++++----
 parsing_cocci/visitor_ast0.ml            |    6 ++++--
 tests/detect_cast_attr.c                 |   10 ++++++++++
 tests/detect_cast_attr.cocci             |   11 +++++++++++
 tests/detect_cast_attr.res               |   10 ++++++++++
 tests/remove_cast_attr.c                 |   10 ++++++++++
 tests/remove_cast_attr.cocci             |   10 ++++++++++
 tests/remove_cast_attr.res               |   10 ++++++++++
 tests/remove_cast_attr_allminus.c        |   10 ++++++++++
 tests/remove_cast_attr_allminus.cocci    |    9 +++++++++
 tests/remove_cast_attr_allminus.res      |   10 ++++++++++
 tools/spgen/source/position_generator.ml |    4 ++--
 41 files changed, 219 insertions(+), 74 deletions(-)


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
