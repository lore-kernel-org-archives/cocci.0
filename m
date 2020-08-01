Return-Path: <SRS0=js+q=BL=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4942C433E0
	for <cocci@archiver.kernel.org>; Sat,  1 Aug 2020 20:36:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 182F220725
	for <cocci@archiver.kernel.org>; Sat,  1 Aug 2020 20:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182F220725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 071KaCmP020298;
	Sat, 1 Aug 2020 22:36:12 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DF2557428;
	Sat,  1 Aug 2020 22:36:11 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EAB974084
 for <cocci@systeme.lip6.fr>; Sat,  1 Aug 2020 22:36:09 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 071Ka8Mh027442
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 1 Aug 2020 22:36:08 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.75,423,1589234400"; d="scan'208";a="355776692"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Aug 2020 22:36:07 +0200
Date: Sat, 1 Aug 2020 22:36:07 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jaskaran Singh <jaskaran.singh@collabora.com>
In-Reply-To: <20200726125141.17787-1-jaskaran.singh@collabora.com>
Message-ID: <alpine.DEB.2.22.394.2008012235440.14815@hadrien>
References: <20200726125141.17787-1-jaskaran.singh@collabora.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 01 Aug 2020 22:36:12 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 01 Aug 2020 22:36:08 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 00/43] cocci: Add support for meta attributes to
	SmPL
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



On Sun, 26 Jul 2020, Jaskaran Singh wrote:

> This patch series aims to add support for meta attributes in SmPL.
> Currently, only meta attributes in context and minus code are supported.
>
> Changes include adding the MetaAttribute and MetaAttributeDecl constructors to
> the SmPL ASTs and the MetaAttributeVal constructor to the C AST.
>
> Two test cases are included for detecting and removing meta attributes.

Applied.

Is this the end of atributes?

julia

>
> Jaskaran Singh (43):
>       parsing_cocci: ast0_cocci: Add MetaAttribute & MetaAttributeDecl
>       parsing_cocci: parser: Parse meta attributes and metaattr decls
>       parsing_cocci: parse_cocci: Reflect MetaAttribute & MetaAttributeDecl
>       parsing_cocci: ast_cocci: Add MetaAttribute & MetaAttributeDecl
>       parsing_cocci: iso_pattern: Reflect MetaAttribute & MetaAttributeDecl
>       parsing_c: unparse_hrule: Reflect MetaAttribute & MetaAttributeDecl
>       parsing_cocci: pretty_print_cocci: Reflect MetaAttribute & MetaAttributeDecl
>       ocaml: coccilib: Reflect MetaAttribute & MetaAttributeDecl
>       ocaml: yes_prepare_ocamlcocci: Reflect MetaAttribute & MetaAttributeDecl
>       parsing_c: ast_c: Add MetaAttributeVal
>       parsing_c: unparse_hrule: Reflect MetaAttributeVal
>       engine: cocci_vs_c: Reflect MetaAttributeVal
>       engine: pattern_c: Reflect MetaAttributeVal
>       engine: pretty_print_engine: Add MetaAttributeVal
>       ocaml: coccilib: Reflect MetaAttributeVal
>       ocaml: ocamlcocci_aux: Reflect MetaAttributeVal
>       ocaml: run_ocamlcocci: Reflect MetaAttributeVal
>       python: pycocci_aux: Reflect MetaAttributeVal
>       parsing_cocci: visitor_ast0: Reflect MetaAttribute
>       parsing_cocci: check_meta: Reflect MetaAttribute
>       parsing_cocci: adjust_pragmas: Reflect MetaAttribute
>       parsing_cocci: context_neg: Reflect MetaAttribute
>       parsing_cocci: compute_lines: Reflect MetaAttribute
>       parsing_cocci: iso_pattern: Reflect MetaAttribute
>       parsing_cocci: function_prototypes: Reflect MetaAttribute
>       parsing_cocci: arity: Reflect MetaAttribute
>       parsing_cocci: unitary_ast0: Reflect MetaAttribute
>       parsing_cocci: unparse_ast0: Reflect MetaAttribute
>       parsing_cocci: ast0toast: Reflect MetaAttribute
>       parsing_cocci: visitor_ast: Reflect MetaAttribute
>       parsing_cocci: cleanup_rules: Reflect MetaAttribute
>       parsing_cocci: free_vars: Reflect MetaAttribute
>       parsing_cocci: get_constants: Reflect MetaAttribute
>       parsing_cocci: get_constants2: Reflect MetaAttribute
>       parsing_cocci: index: Reflect MetaAttribute
>       parsing_cocci: pretty_print_cocci: Reflect MetaAttribute
>       parsing_cocci: safe_for_multi_decls: Reflect MetaAttribute
>       parsing_cocci: unify_ast: Reflect MetaAttribute
>       parsing_c: unparse_cocci: Reflect MetaAttribute
>       engine: cocci_vs_c: Reflect MetaAttribute
>       tools: spgen: Reflect MetaAttribute
>       tests: Add test case to match meta attribute
>       tests: Add test case to remove a meta attribute
>
>  engine/cocci_vs_c.ml                  |   23 ++++++++++++++---
>  engine/pattern_c.ml                   |    6 ++++
>  engine/pretty_print_engine.ml         |    1
>  ocaml/coccilib.ml                     |    1
>  ocaml/coccilib.mli                    |    7 +++++
>  ocaml/ocamlcocci_aux.ml               |    2 +
>  ocaml/run_ocamlcocci.ml               |    1
>  ocaml/yes_prepare_ocamlcocci.ml       |    1
>  parsing_c/ast_c.ml                    |    1
>  parsing_c/ast_c.mli                   |    1
>  parsing_c/lib_parsing_c.ml            |    3 ++
>  parsing_c/lib_parsing_c.mli           |    3 ++
>  parsing_c/pretty_print_c.ml           |   12 ++++++++
>  parsing_c/pretty_print_c.mli          |    5 +++
>  parsing_c/unparse_cocci.ml            |    6 ++++
>  parsing_c/unparse_hrule.ml            |    5 +++
>  parsing_cocci/adjust_pragmas.ml       |    3 ++
>  parsing_cocci/arity.ml                |   29 ++++++++++++++-------
>  parsing_cocci/ast0_cocci.ml           |    1
>  parsing_cocci/ast0_cocci.mli          |    1
>  parsing_cocci/ast0toast.ml            |    4 ++
>  parsing_cocci/ast_cocci.ml            |    3 ++
>  parsing_cocci/ast_cocci.mli           |    2 +
>  parsing_cocci/check_meta.ml           |   27 ++++++++++++++-----
>  parsing_cocci/cleanup_rules.ml        |   10 ++++++-
>  parsing_cocci/compute_lines.ml        |   14 ++++++----
>  parsing_cocci/context_neg.ml          |   18 ++++++++-----
>  parsing_cocci/data.ml                 |    1
>  parsing_cocci/data.mli                |    1
>  parsing_cocci/free_vars.ml            |   28 ++++++++++++++++++--
>  parsing_cocci/function_prototypes.ml  |   10 ++++++-
>  parsing_cocci/get_constants.ml        |    7 ++++-
>  parsing_cocci/get_constants2.ml       |    9 +++---
>  parsing_cocci/index.ml                |    3 +-
>  parsing_cocci/iso_pattern.ml          |   46 +++++++++++++++++++++++++++++-----
>  parsing_cocci/lexer_cocci.mll         |   12 ++++++++
>  parsing_cocci/parse_aux.ml            |    4 ++
>  parsing_cocci/parse_cocci.ml          |   11 ++++++--
>  parsing_cocci/parser_cocci_menhir.mly |   25 ++++++++++++------
>  parsing_cocci/pretty_print_cocci.ml   |    3 ++
>  parsing_cocci/safe_for_multi_decls.ml |    1
>  parsing_cocci/unify_ast.ml            |    2 +
>  parsing_cocci/unitary_ast0.ml         |    8 +++++
>  parsing_cocci/unparse_ast0.ml         |    1
>  parsing_cocci/visitor_ast.ml          |    7 +++--
>  parsing_cocci/visitor_ast0.ml         |    5 ++-
>  python/pycocci_aux.ml                 |    2 +
>  tests/metaattr.c                      |    5 +++
>  tests/metaattr.cocci                  |    9 ++++++
>  tests/metaattr.res                    |    5 +++
>  tests/remove_metaattr.c               |    5 +++
>  tests/remove_metaattr.cocci           |    9 ++++++
>  tests/remove_metaattr.res             |    5 +++
>  tools/spgen/source/meta_variable.ml   |    8 +++++
>  54 files changed, 357 insertions(+), 65 deletions(-)
>
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
