Return-Path: <SRS0=hRma=A5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAC9C433E1
	for <cocci@archiver.kernel.org>; Sat, 18 Jul 2020 14:17:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315B42074B
	for <cocci@archiver.kernel.org>; Sat, 18 Jul 2020 14:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315B42074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06IEHNwe020241;
	Sat, 18 Jul 2020 16:17:23 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 89CF87779;
	Sat, 18 Jul 2020 16:17:23 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D99383F6C
 for <cocci@systeme.lip6.fr>; Sat, 18 Jul 2020 16:17:21 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06IEHLQ8007246
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 18 Jul 2020 16:17:21 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.75,367,1589234400"; d="scan'208";a="460309023"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Jul 2020 16:17:02 +0200
Date: Sat, 18 Jul 2020 16:17:02 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jaskaran Singh <jaskaran.singh@collabora.com>
In-Reply-To: <20200716130521.7717-1-jaskaran.singh@collabora.com>
Message-ID: <alpine.DEB.2.22.394.2007181616520.2538@hadrien>
References: <20200716130521.7717-1-jaskaran.singh@collabora.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 18 Jul 2020 16:17:23 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 18 Jul 2020 16:17:21 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 00/17] parsing_cocci: Add attributefn to the
 SmPL AST visitor
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



On Thu, 16 Jul 2020, Jaskaran Singh wrote:

> This patch series aims to add a public function for visiting attributes
> to the SmPL AST visitor. This is needed to support meta attributes.

Applied.  Thanks.

>
> Jaskaran Singh (17):
>       parsing_cocci: visitor_ast: Add attributefn to SmPL AST visitor
>       parsing_cocci: parse_cocci: Reflect attributefn in AST visitor
>       parsing_cocci: cleanup_rules: Reflect attributefn in AST visitor
>       parsing_cocci: disjdistr: Reflect attributefn in AST visitor
>       parsing_cocci: free_vars: Reflect attributefn in AST visitor
>       parsing_cocci: get_constants2: Reflect attributefn in AST visitor
>       parsing_cocci: re_constraints: Reflect attributefn in AST visitor
>       parsing_cocci: safe_for_multi_decls: Reflect attributefn in AST visitor
>       parsing_cocci: stmtlist: Reflect attributefn in AST visitor
>       parsing_cocci: unify_ast: Reflect attributefn in AST visitor
>       parsing_c: unparse_hrule: Reflect attributefn in AST visitor
>       cocci: Reflect attributefn in AST visitor
>       engine: asttoctl2: Reflect attributefn in AST visitor
>       engine: asttomember: Reflect attributefn in AST visitor
>       engine: cocci_vs_c: Reflect attributefn in AST visitor
>       engine: transformation_c: Reflect attributefn in AST visitor
>       popl09: popltoctl: Reflect attributefn in AST visitor
>
>  cocci.ml                              |    2 +-
>  engine/asttoctl2.ml                   |   11 ++++++-----
>  engine/asttomember.ml                 |    8 ++++----
>  engine/cocci_vs_c.ml                  |    4 ++--
>  engine/transformation_c.ml            |    2 +-
>  parsing_c/unparse_hrule.ml            |    2 +-
>  parsing_cocci/cleanup_rules.ml        |    2 +-
>  parsing_cocci/disjdistr.ml            |    5 +++--
>  parsing_cocci/free_vars.ml            |   16 +++++++++-------
>  parsing_cocci/get_constants2.ml       |    3 ++-
>  parsing_cocci/parse_cocci.ml          |    2 +-
>  parsing_cocci/re_constraints.ml       |    8 +++++---
>  parsing_cocci/safe_for_multi_decls.ml |    6 +++---
>  parsing_cocci/stmtlist.ml             |    2 +-
>  parsing_cocci/unify_ast.ml            |   20 +++++++++++++-------
>  parsing_cocci/visitor_ast.ml          |   12 ++++++++----
>  parsing_cocci/visitor_ast.mli         |    4 ++++
>  popl09/popltoctl.ml                   |    2 +-
>  18 files changed, 66 insertions(+), 45 deletions(-)
>
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
