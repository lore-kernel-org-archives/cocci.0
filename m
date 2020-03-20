Return-Path: <SRS0=15MF=5F=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1435FC4332E
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:02:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 619E120775
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3Fn7+z0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619E120775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K72IGn021295;
	Fri, 20 Mar 2020 08:02:19 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D5DBD780E;
	Fri, 20 Mar 2020 08:02:18 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 287493B93
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:02:17 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:532])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02K72ENR003239
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:02:15 +0100 (CET)
Received: by mail-pg1-x532.google.com with SMTP id b22so2601323pgb.6
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 00:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1sY74GkyZuxdCYokvBmv+hrifgX3v/qyVpyDCQhtrjA=;
 b=p3Fn7+z05Pd9TDTfcHErHEAYF+iRb/a2MomtlrMTMgDx/e1Oy8QzdgCTFYrZ8jJQzh
 VrZkYSV6+1SfVxcmF2HQc5x0A63jyYoXRNSY8inxcH8fcfPxw7X3kcG5KMOe+gOZfjcL
 O8Rw+GFlgZLUv4He7ZG/sJjQcsU/SkLEjY3GJ9pl/0qUTgCak5OEb6ogLCRvPPJSAGyD
 607H/z10pj5uv7pdN52EpKd1f1hfPVvNmYOJYXt4N3nbik2q7qDfZSrY90rrwKiJEO6f
 hMP9G7+W4ygnDub5+xPEHIc7tKk1yY+LM00fGtJcPQqssDLdNWLy/HgxbnrSkiKPMV0a
 EskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1sY74GkyZuxdCYokvBmv+hrifgX3v/qyVpyDCQhtrjA=;
 b=VCHTeppuP+/7eDT+obl6vg5C6/U7iMOREeGgZ0lzEcMLK5brge/0yh/XpqLtoJQrUk
 wNp5pVgKmYYoTiBmgkEokkrn0Bpv1SaiaS3ucRVeH4hsO0cauHPNbkUWRkt9ygO9qsjN
 rHVePYrZ2Dy9GztxCEznCaVNEy5dQV1jHCgdsAkerU/oy37Vu1GMmelRmaJ2yPeiqAYg
 Asr07ElV1NyJDZs8FhyjXyGgQ+IuFm/CIke1Uy5nfw9jT/dHDMdVhBriu+m7Ymw36Ea2
 iQ91mv3Ep/R/ClovjWOwxNHkZwLpNVe6gk1PM80rGAFKND0eD25toDMYHDyvo1okMu4p
 tgew==
X-Gm-Message-State: ANhLgQ1p9pHIUY7+7ugi2SOoJJ3PTm/uW7e0+0UFNxSeVXv+wWvItF/1
 +FEdpQL/4ZSGU/cSbOsPshla2VPl
X-Google-Smtp-Source: ADFU+vuO/1o6IId7Nr/PrsGbEZmz4iZ3BsLSRJGGozvbpmg9w3A6e8dL8cgNnElaPpAKRw1kTy1P1A==
X-Received: by 2002:a63:82c2:: with SMTP id w185mr7423709pgd.382.1584687733209; 
 Fri, 20 Mar 2020 00:02:13 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2190:a751:deeb:c09d:833a:659d])
 by smtp.gmail.com with ESMTPSA id l11sm3941232pjy.44.2020.03.20.00.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 00:02:12 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 20 Mar 2020 12:31:31 +0530
Message-Id: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 08:02:20 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Mar 2020 08:02:15 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 00/26] cocci: Add ParenType/FunctionType to SmPL
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

The aim of this patch series is to add the types ParenType
and FunctionType to the SmPL AST. These types are present in
the C AST but not in the SmPL AST.

Preliminarily, a hack to resolve a reduce/reduce conflict
with the funproto rule in the SmPL parser is implemented.

Upon this, a rule similar to that of the C parser's direct
declarator rule is implemented, and used wherever suitable.
The direct declarator rule produces ParenType and FunctionType,
similar to the C parser.

Cases for these types are added to various places in the codebase.

The FunctionPointer type is removed from the SmPL AST, since
all the productions that produce FunctionPointers in the SmPL
parser are replaced by those that produce ParenType. Any functions,
constructs or cases of FunctionPointer are also removed from the
codebase.

A test case to match an array of function pointers is included to
demonstrate matching improvements.

Changes in v3:
--------------
- Patch 01/26:
    - Add case for __attribute__((.*)) in is_permissible_proto
      so that the p1p2 test case passes successfully with just
      01/26 applied.
    - Add case for typeof(.*) in is_permissible_proto.
    - Change the function balanced_args in find_function_names
      by adding a new argument "reverse". reverse is a bool that
      indicates whether the given list is reversed, and if it is
      then when to return the rest of the tokens and how to increment
      or decrement the current depth/level of the parentheses.
- Patch 02/26:
    Briefly describe how the new constructs are used in
    the SmPL AST.
- Patch 03/26:
    State examples of productions that are not supported
    by the direct_declarator and direct_abstract_d rules, and how some
    of these could be supported.
- Patch 04/26:
    - Group together repeated code in a function.
    - Place match statement on a single line.
    - Change spaces to tabs in a ParenType/FunctionType cases of
      named_type and named_type_typedef.
- Patch 05/26:
    - Group together repeated code in a function.
    - Place match statement on a single line.
- Patch 07/26:
    Change the comment in the head of index.ml to indicate
    which indexes have now been used.
- Patch 09/26:
    Group together repeated code in a function.
- Patch 10/26:
    Change ParenType's case as per what term is to the
    left.
- Patch 14/26:
    Change ParenType's case as per what term is to the
    left.
- Patch 15/26:
    Change promote_mcode rp to promote_mcode lp for
    ParenType's case.
- Patch 21/26:
    Group together repeated code in a function.
- Patch 22/26:
    - Group together repeated code in a function.
    - Add FunctionType case to named_type function.

Changes in v2:
--------------
- Patch 05/26: Change "visitor_ast0" in patch subject to "visitor_ast"

[PATCH v3 01/26] parsing_cocci: Add Function Prototype token
[PATCH v3 02/26] parsing_cocci: AST: Add ParenType and FunctionType
[PATCH v3 03/26] parsing_cocci: parser: Add
[PATCH v3 04/26] parsing_cocci: visitor_ast0: Add cases for
[PATCH v3 05/26] parsing_cocci: visitor_ast: Add cases for
[PATCH v3 06/26] parsing_cocci: arity: Add cases for
[PATCH v3 07/26] parsing_cocci: index: Add cases for
[PATCH v3 08/26] parsing_cocci: context_neg: Add cases for
[PATCH v3 09/26] parsing_cocci: unparse_ast0: Add cases for
[PATCH v3 10/26] parsing_cocci: single_statement: Add cases for
[PATCH v3 11/26] parsing_cocci: function_prototypes: Add cases for
[PATCH v3 12/26] parsing_cocci: check_meta: Add cases for
[PATCH v3 13/26] parsing_cocci: iso_pattern: Add cases for
[PATCH v3 14/26] parsing_cocci: adjust_pragmas: Add cases for
[PATCH v3 15/26] parsing_cocci: compute_lines: Add cases for
[PATCH v3 16/26] parsing_cocci: ast0toast: Add cases for
[PATCH v3 17/26] parsing_cocci: type_cocci: Add
[PATCH v3 18/26] parsing_cocci: unify_ast: Add cases for
[PATCH v3 19/26] parsing_cocci: disjdistr: Add cases for
[PATCH v3 20/26] parsing_cocci: ast_cocci: Add cases for
[PATCH v3 21/26] parsing_cocci: pretty_print_cocci: Print
[PATCH v3 22/26] parsing_c: unparse_cocci: Print
[PATCH v3 23/26] engine: Match A.ParenType and A.FunctionType
[PATCH v3 24/26] tools: spgen: Add cases for ParenType/FunctionType
[PATCH v3 25/26] cocci: Remove Ast_cocci.FunctionPointer
[PATCH v3 26/26] tests: Add test case for array of function pointers

 engine/check_exhaustive_pattern.ml       |    3 
 engine/cocci_vs_c.ml                     |   82 +++-------
 ocaml/coccilib.mli                       |   10 -
 parsing_c/unparse_cocci.ml               |   72 +++++++--
 parsing_cocci/adjust_pragmas.ml          |    7 
 parsing_cocci/arity.ml                   |   25 ++-
 parsing_cocci/ast0_cocci.ml              |    7 
 parsing_cocci/ast0_cocci.mli             |    6 
 parsing_cocci/ast0toast.ml               |   11 -
 parsing_cocci/ast_cocci.ml               |   21 +-
 parsing_cocci/ast_cocci.mli              |    6 
 parsing_cocci/check_meta.ml              |    8 -
 parsing_cocci/compute_lines.ml           |   21 +-
 parsing_cocci/context_neg.ml             |    4 
 parsing_cocci/disjdistr.ml               |   16 +-
 parsing_cocci/function_prototypes.ml     |    7 
 parsing_cocci/get_constants.ml           |    2 
 parsing_cocci/index.ml                   |    5 
 parsing_cocci/iso_pattern.ml             |   17 --
 parsing_cocci/parse_cocci.ml             |   97 +++++++++---
 parsing_cocci/parser_cocci_menhir.mly    |  248 +++++++++++++++----------------
 parsing_cocci/pretty_print_cocci.ml      |   64 ++++++--
 parsing_cocci/single_statement.ml        |    3 
 parsing_cocci/type_cocci.mli             |    3 
 parsing_cocci/type_infer.ml              |   25 +--
 parsing_cocci/unify_ast.ml               |   16 +-
 parsing_cocci/unparse_ast0.ml            |   51 ++++--
 parsing_cocci/visitor_ast.ml             |   92 ++++++++---
 parsing_cocci/visitor_ast0.ml            |  198 ++++++++++++++++++------
 tests/funptr_array.c                     |    1 
 tests/funptr_array.cocci                 |    9 +
 tests/funptr_array.res                   |    1 
 tools/spgen/source/meta_variable.ml      |    1 
 tools/spgen/source/position_generator.ml |    9 -
 34 files changed, 732 insertions(+), 416 deletions(-)


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
