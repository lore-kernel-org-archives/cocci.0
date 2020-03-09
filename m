Return-Path: <SRS0=xIcw=42=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798B4C10F27
	for <cocci@archiver.kernel.org>; Mon,  9 Mar 2020 14:52:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B94222C3
	for <cocci@archiver.kernel.org>; Mon,  9 Mar 2020 14:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vcCl6X3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B94222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 029Epdvw029338;
	Mon, 9 Mar 2020 15:51:39 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 64A3E7800;
	Mon,  9 Mar 2020 15:51:39 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 17F5F77F4
 for <cocci@systeme.lip6.fr>; Mon,  9 Mar 2020 15:51:37 +0100 (CET)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:644])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 029EpY7K012454
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 9 Mar 2020 15:51:35 +0100 (CET)
Received: by mail-pl1-x644.google.com with SMTP id w3so4073770plz.5
 for <cocci@systeme.lip6.fr>; Mon, 09 Mar 2020 07:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=FPP1I02AYa5MYHJNYi5VXU7bLfJxthH5SibbSqRjnKo=;
 b=vcCl6X3ZIFN03MlJd0TNipy6MazVLgSGg0StUXFMyrudyS9wwEqoqzm3oU40Bp2+8T
 woyh649pitsglmyEArpmslIiHR/5PzBCMR66WeTGCEA8VRJd61KzJpMgf3TyoSSdWZ/t
 4aqm+q4zIhY5DD5v/aKpfMw4kcl0kF4oj3kOOdO11Fl6cKN+fUiUxvj6TUSYo4K8lPTN
 4yJOraUfK88YX6rl9xwvxzbiNg7JCsmaUwLK87thqhSinL/6aEkq9gqTIL35+XHpmjeK
 qAioPzhayF20bL9/WgnlPrwbx3xpLVSCDRbbovUX7AnotWvbnxVC2cwQ08KGwR07Gwax
 Ol5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=FPP1I02AYa5MYHJNYi5VXU7bLfJxthH5SibbSqRjnKo=;
 b=EbwViforBWj6DZ8OOEoOd3z4VkPU8d8wCsmDb79bsCZCxuJ+aXgk7xRYJe9aEMOFAI
 LfObNNIg3zQn9Cud4VeZQYiorYIuhq+9cuOQtLC11fFewqvvpYdPBSvZwkIOLXsIqgQT
 3gTBB9VaySdx/60yAq9RBvjKObm7NfT8hnjpmVRFzMBmsRf+CZpcs4J9WbHARUfDSXXb
 ncGxw3VXsLKIvuSvxlU10AdGtAzCjA19xmxz3lhYdjwPy8ArO46QyEVJR6hW2r310EGQ
 gGVofp5VRa8xbCRsU6gRZUA7h1BiOJ9bLPsKeQm6a7LNWX5wIT5L6wCvhA+0R0nyZLsB
 4CQQ==
X-Gm-Message-State: ANhLgQ2adtx1pBS2xUDJtRte+NBLUnL1yuTuG9f3g4cUm7jhGxTbtF6y
 +eGShMorWJ3HScAM6VSf/gI=
X-Google-Smtp-Source: ADFU+vvJsSxZ6cbIyQwxTyKYZgtR0w9oL87CA2kB8ETk1HeQIg66QV/601LMKLgOLTjpaFG3XXA6ew==
X-Received: by 2002:a17:90a:d104:: with SMTP id
 l4mr19909059pju.60.1583765494129; 
 Mon, 09 Mar 2020 07:51:34 -0700 (PDT)
Received: from localhost.localdomain ([1.38.145.201])
 by smtp.gmail.com with ESMTPSA id r199sm19064450pfc.101.2020.03.09.07.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 07:51:33 -0700 (PDT)
Message-ID: <ac84fa9ba60e8a0b107b5946ee0c6285a78dcf71.camel@gmail.com>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Mon, 09 Mar 2020 20:21:30 +0530
In-Reply-To: <alpine.DEB.2.21.2003091514310.4721@hadrien>
References: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
 <alpine.DEB.2.21.2003091514310.4721@hadrien>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 09 Mar 2020 15:51:39 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 09 Mar 2020 15:51:36 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
        "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH 00/13] cocci: Align the C AST and SmPL AST for
	enum
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

On Mon, 2020-03-09 at 15:15 +0100, Julia Lawall wrote:
> 
> On Sun, 8 Mar 2020, Jaskaran Singh wrote:
> 
> > The C AST and SmPL AST differs with respect to the enum type.
> > 
> > For an enumerator, the C AST is as follows:
> >     Enum -> list of (name, (info, expression))
> > 
> > For the same, the SmPL AST is as follows:
> >     EnumDef -> list of expression
> > 
> > While the SmPL parser does make sure that enumerators are
> > parsed as per C rules, the OCaml types for an enumerator themselves
> > mismatch, due to their organization. This causes bugs/mismatches
> > for
> > cases where enums are in disjunctions.
> > 
> > This patch series makes the enumerator type of the SmPL AST
> > closer to that of the C AST. Various places in the codebase that
> > handle an enum are also changed to match the new type, and
> > collateral evolutions caused by changed in the SmPL visitors are
> > handled as well.
> > 
> > Changes are also made to Cocci_vs_c to correctly match two
> > enumerators, and in Pretty_print_cocci and Unparse_cocci to
> > correctly print an enumerator.
> 
> I have applied all of the changes.  In the end, I squashed all of the
> commits together, to only commit something that compiles, but I
> appreciated having the changes broken up into more understandable
> units.
> 

Sorry about that. Will be more careful about these big changes next
time, and thanks for applying.

Cheers,
Jaskaran.

> thanks,
> julia
> 
> 
> > [PATCH 01/13] parsing_cocci: Align C AST and SmPL AST for enum
> > [PATCH 02/13] ocaml: coccilib: Reflect changes in SmPL AST for
> > [PATCH 03/13] parsing_cocci: parser: Parse enumerators correctly
> > [PATCH 04/13] parsing_cocci: Add EnumDeclTag and EnumDeclDotsTag to
> > [PATCH 05/13] ocaml: coccilib: Reflect EnumDeclTag and
> > [PATCH 06/13] parsing_cocci: visitor_ast0: Add visitor functions
> > for
> > [PATCH 07/13] parsing_cocci: Reflect visitor_ast0 changes in
> > [PATCH 08/13] parsing_cocci: Add visitor functions for enum_decl in
> > [PATCH 09/13] cocci: Reflect changes in SmPL visitor_ast in
> > codebase
> > [PATCH 10/13] engine: cocci_vs_c: Match enumerators properly as per
> > [PATCH 11/13] cocci: pretty print EnumDef as per enum_decl type
> > [PATCH 12/13] tests: Add test case for assigned enumerator
> > [PATCH 13/13] tools: spgen: Reflect visitor changes
> > 
> >  cocci.ml                              |    4 -
> >  engine/asttoctl2.ml                   |   21 +++++---
> >  engine/asttomember.ml                 |   17 ++++---
> >  engine/cocci_vs_c.ml                  |   46 ++++++++-----------
> >  engine/transformation_c.ml            |    4 -
> >  ocaml/coccilib.mli                    |   22 ++++++++-
> >  parsing_c/unparse_cocci.ml            |   27 ++++++++++-
> >  parsing_c/unparse_hrule.ml            |    4 -
> >  parsing_cocci/arity.ml                |   25 ++++++++++
> >  parsing_cocci/ast0_cocci.ml           |   15 +++++-
> >  parsing_cocci/ast0_cocci.mli          |   14 +++++
> >  parsing_cocci/ast0toast.ml            |   30 +++++++++++-
> >  parsing_cocci/ast0toast.mli           |    4 +
> >  parsing_cocci/ast_cocci.ml            |   13 +++++
> >  parsing_cocci/ast_cocci.mli           |   12 ++++-
> >  parsing_cocci/check_meta.ml           |   17 +++++--
> >  parsing_cocci/cleanup_rules.ml        |    5 +-
> >  parsing_cocci/commas_on_lists.ml      |   10 ++--
> >  parsing_cocci/compute_lines.ml        |   25 ++++++++++
> >  parsing_cocci/context_neg.ml          |   47 +++++++++++++++++--
> >  parsing_cocci/disjdistr.ml            |   29 +++++++++---
> >  parsing_cocci/free_vars.ml            |   27 +++++------
> >  parsing_cocci/function_prototypes.ml  |    7 +-
> >  parsing_cocci/get_constants2.ml       |    7 +-
> >  parsing_cocci/index.ml                |    7 ++
> >  parsing_cocci/index.mli               |    2
> >  parsing_cocci/insert_plus.ml          |   39 +++++++++++++---
> >  parsing_cocci/iso_compile.ml          |    4 -
> >  parsing_cocci/iso_pattern.ml          |   80
> > ++++++++++++++++++++++++++++------
> >  parsing_cocci/parse_aux.ml            |    5 ++
> >  parsing_cocci/parse_aux.mli           |    9 +++
> >  parsing_cocci/parse_cocci.ml          |    4 -
> >  parsing_cocci/parser_cocci_menhir.mly |   13 ++---
> >  parsing_cocci/pretty_print_cocci.ml   |   18 +++++++
> >  parsing_cocci/re_constraints.ml       |   10 ++--
> >  parsing_cocci/safe_for_multi_decls.ml |   11 ++--
> >  parsing_cocci/single_statement.ml     |    5 +-
> >  parsing_cocci/stmtlist.ml             |    4 -
> >  parsing_cocci/unify_ast.ml            |   29 ++++++++++--
> >  parsing_cocci/unitary_ast0.ml         |    5 +-
> >  parsing_cocci/unparse_ast0.ml         |   22 ++++++++-
> >  parsing_cocci/visitor_ast.ml          |   72
> > +++++++++++++++++++++++++++---
> >  parsing_cocci/visitor_ast.mli         |    8 +++
> >  parsing_cocci/visitor_ast0.ml         |   72
> > ++++++++++++++++++++++++++++--
> >  parsing_cocci/visitor_ast0.mli        |    4 +
> >  parsing_cocci/visitor_ast0_types.ml   |   14 +++++
> >  parsing_cocci/visitor_ast0_types.mli  |   12 +++++
> >  popl/popltoctl.ml                     |    2
> >  popl09/popltoctl.ml                   |    5 +-
> >  tests/enum_assign.c                   |    6 ++
> >  tests/enum_assign.cocci               |   11 ++++
> >  tests/enum_assign.res                 |    7 ++
> >  tools/spgen/source/detect_patch.ml    |    6 +-
> >  tools/spgen/source/meta_variable.ml   |    6 +-
> >  tools/spgen/source/rule_body.ml       |    6 +-
> >  55 files changed, 748 insertions(+), 182 deletions(-)
> > 
> > 

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
