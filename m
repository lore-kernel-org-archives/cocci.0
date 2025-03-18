Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8215C282EC
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 15:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=PxXu+S6wO1oSK5m6YUi4LCpkSd8CsLuY7xb80xk/cyk=;
  b=mj1N+6f4qlbXRN3QFdqhZ/h0bRGd1nXMYNTWTpx2KMn+/e3NCOeQCuQm
   VeeJ9RllCrbaPAAwaW3W8HGmZHCsYHeWm/th4yzfkKn9GwDKDLRdDWEOJ
   B5qrOrLaiEdd3Y/z8lEnBCc01j3hV8IS/oJ5vOF2f+Jk26+DCO1lgZysT
   4=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@aepfle.de
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="213534508"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 16:43:57 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 05D4CE0260; Tue, 18 Mar 2025 16:43:57 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5A50AE0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 16:43:53 +0100 (CET)
IronPort-SDR: 67d994b8_N5kVTHOGnaZ9CwNJKb3Rwv1GMEnRINFxz1aJYBIcdo8PPqZ
 CerOorQzG23YO6M3i4NGUQ87lnozRKaccncttWw==
X-IPAS-Result: =?us-ascii?q?A0HjAwAMk9lnjhb/11VagQmBVYJCfVk0BwhIYYdEjiKTH?=
 =?us-ascii?q?osNgWoPAQMBDTUPBAEBAwEDhQCLIQIfBgEENBMBAgQBAQEBAwIDAQEBAQEBE?=
 =?us-ascii?q?AEBBQEBAQIBAQIEBgECEAEBAQEBATkFDgkyhUwvDUkBEAGCADuCFiwNgR4BH?=
 =?us-ascii?q?wYBAThQdgmDAgGCZAeuC4E0gQGCDAEBBoEIgWDZOIFlCYFIhW2CYwGEfHCEd?=
 =?us-ascii?q?ycbgg2GTXqBRAESATaGL4IchUGBbIpPHC2CJYcZk1VIgQUcA1ksAVUTDQoLB?=
 =?us-ascii?q?wWBbAM1DAsuFYFFQziCRGlJOgINAjWCG3yCKIROhD6EQYVQghGCBYkthGQtU?=
 =?us-ascii?q?IFNHUADCxgNSBEsNxQbBj5uB6IYATqDURtYPTgGEwqBPWI1CZMtsyuCP4Fmg?=
 =?us-ascii?q?WOKNZUwGjOBS4QPkWwOkwOIKZBVlxCNO4RogX4jbHAzGggcFIMiCUYDGQ+Ne?=
 =?us-ascii?q?AExEAmEC4NssV1FMjwCBwsBAQMJiQCHHGtgAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 U/KelY=
IronPort-HdrOrdr: A9a23:wo5q3KyAL8vAcrcscDO6KrPwSb1zdoMgy1knxilNoHtuA6+lfq
 GV/MjzuiWftN98YhwdcLO7WZVoI0myyXcd2+B4VotKNzOJhILHFu1f0bc=
X-Talos-CUID: 9a23:/902iGAY6btQeYn6EwRfxUkbKPoYSXPm4nyIExOIVH9tdqLAHA==
X-Talos-MUID: 9a23:DSVxUwViOkIzr1/q/CWrgmBkMf042YqNFWQtt5og4uWCMBUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="213534494"
X-MGA-submission: =?us-ascii?q?MDExymDuqH95fyWV5E5nT7I1PRReqMHMzuetPO?=
 =?us-ascii?q?Rai/6rSS53BrpkGISmN1Cgfq17MuHvP+zWEBk2mIfFxfxwtQ1LIllKej?=
 =?us-ascii?q?9j+txkauZm8vJljc1DJmN8xJ5BZetuxWq+NT9HB79Ee49P3E/jVPLM1N?=
 =?us-ascii?q?zSjL1ruLHY5RVEXjiAM1//DA=3D=3D?=
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 16:43:51 +0100
ARC-Seal: i=1; a=rsa-sha256; t=1742312631; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=U3PH0nER/XgD2NNSXFgNLVoGb5fhlIc/py5Owc8t6YTX7Sxm50RWB0d6LgTnQygwNX
    AYIdRXfKgJ3u7AShqpBwk/avSqiz4OQ3DhQsiKkBR5pgmXgydtStM2ja9WgTOn0HyDAB
    LH6EX/EgV46tUIj3Z4WoI37ChbJOmb8iiQGUAdBRP0+NfRU0xwm5BVeHTmepgGdrVddj
    OwFrbFhMVm22sZ7miaieQniVi7FlPwzF43FovtuPbdZtD80RHjpU/L1vQBHxHcXJ5Qdc
    UoThJutJA7ivVADkkqzw9l0/UnwIsucrBCc2bQW0iGhj9MMxc1xs0TdVfOvcuPlMnHrf
    SIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742312631;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=PxXu+S6wO1oSK5m6YUi4LCpkSd8CsLuY7xb80xk/cyk=;
    b=gi+NX3Fzd/6T1pFC+D++FZ87GrL1QKnJ23A0xPiGqlh4Ke8NsKndJjIbnRUSZQFpOP
    lRdrfbqa85GHkEP7/r0RoIxqDhFD5sw+kHv6LhisC7WEGIQBmgYwwqC8lpJB8mOb/V4m
    VZ9Mxu45g98X+Hn/GCACMlm/jq4z2SYxrkt9jeY4lBzpl6hIAg4PX2c3M8nAK4Pi3RbO
    uEnqGh24QMPe75ZHDTVsdNub5AOHwOvaYf56Occfo+uww6kIrcPY07zyqDRWjv8uJ8yn
    IU9deQ9U8NmIfd9nwDcsDaw+N7jM+KXAJIkBEPcNBKJ1Y6ra4S07TyWxD9P52n4Bp9lT
    ucnw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742312631;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=PxXu+S6wO1oSK5m6YUi4LCpkSd8CsLuY7xb80xk/cyk=;
    b=c2QT7xgYW9KjcVVRp6SYd0GiZoRi61t0mLsXDWRqbm3MSiIzXYxfb4iDLRwTmCD9Yx
    m1n7kSIUuKHOzahtGGVne3hIw3KNVS7kFpUuYruuaeyHEyYCdt1YJdC0F6XOEw2znMrI
    DbiUT8EhR8s7c65sM7SkzbA9bF4vaB880el4Kir08izvtKvBxJ6kNG5k7EUqFBT481pi
    RVf4XEMmtgYQaZnfqwros8mgAFd6bgajowFGlDGMHrsUiCENS3r01jHFrK6zI05VvMX7
    t1lpYsPK8g3AEfB+adH81wfy9dYsEItxzxGtpHgJCurdUENz0K83fNWS6JIc3EPPQm63
    COkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742312631;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=PxXu+S6wO1oSK5m6YUi4LCpkSd8CsLuY7xb80xk/cyk=;
    b=DlQ/fI6/zS2iG3xQuhzOjNvepfNzSnd+ZCfIaibcwdAaF1k0w95bRplGZX5EVIxVz7
    WuiqwkdhQpqPf+BkFCAA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0uv8ZofWaSVYjagMyZmkab3cQQk8ITYm/c/zHbXf6Nw2MS9"
Received: from sender
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id D1c4dd12IFho2em
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate)
    for <cocci@inria.fr>;
    Tue, 18 Mar 2025 16:43:50 +0100 (CET)
From: Olaf Hering <olaf@aepfle.de>
To: cocci@inria.fr
Date: Tue, 18 Mar 2025 16:42:43 +0100
Message-ID: <20250318154345.31468-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
Subject: [cocci] [PATCH v1] remove stale log.txt
Reply-To: Olaf Hering <olaf@aepfle.de>
X-Loop: cocci@inria.fr
X-Sequence: 2626
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250318154345.31468-1-olaf%40aepfle.de>

Fixes commit 2ff738c7c ("chore: project compiles perfectly after fixing com=
pilation error bugs")

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 log.txt | 1191 -------------------------------------------------------
 1 file changed, 1191 deletions(-)
 delete mode 100644 log.txt

I'm forced to use send-email --transfer-encoding=3Dquoted-printable
due the lines longer than 1k.

A local 'git rm log.txt && git commit' will achive the same result.

diff --git a/log.txt b/log.txt
deleted file mode 100644
index b98e1b60f..000000000
--- a/log.txt
+++ /dev/null
@@ -1,1191 +0,0 @@
-OCAMLDEP  commons/ocamlextra/dumper.ml
-OCAMLDEP  commons/commands.ml
-OCAMLDEP  commons/common.ml
-OCAMLDEP  commons/ograph_simple.ml
-OCAMLDEP  commons/ograph_extended.ml
-OCAMLDEP  globals/config.ml
-OCAMLDEP  globals/flag.ml
-OCAMLDEP  globals/iteration.ml
-OCAMLDEP  globals/regexp_pcre.ml
-OCAMLDEP  globals/regexp.ml
-OCAMLDEP  parsing_cocci/flag_parsing_cocci.ml
-OCAMLDEP  parsing_cocci/ast_cocci.ml
-OCAMLDEP  parsing_cocci/ast0_cocci.ml
-OCAMLDEP  parsing_cocci/pretty_print_cocci.ml
-OCAMLDEP  parsing_cocci/visitor_ast0_types.ml
-OCAMLDEP  parsing_cocci/visitor_ast.ml
-OCAMLDEP  parsing_cocci/visitor_ast0.ml
-OCAMLDEP  parsing_cocci/ast0toast.ml
-OCAMLDEP  parsing_cocci/unparse_ast0.ml
-OCAMLDEP  parsing_cocci/unify_ast.ml
-OCAMLDEP  parsing_cocci/compute_lines.ml
-OCAMLDEP  parsing_cocci/iso_pattern.ml
-OCAMLDEP  parsing_cocci/comm_assoc.ml
-OCAMLDEP  parsing_cocci/iso_compile.ml
-OCAMLDEP  parsing_cocci/single_statement.ml
-OCAMLDEP  parsing_cocci/simple_assignments.ml
-OCAMLDEP  parsing_cocci/get_metas.ml
-OCAMLDEP  parsing_cocci/stmtlist.ml
-OCAMLDEP  parsing_cocci/top_level.ml
-OCAMLDEP  parsing_cocci/type_infer.ml
-OCAMLDEP  parsing_cocci/test_exps.ml
-OCAMLDEP  parsing_cocci/unitary_ast0.ml
-OCAMLDEP  parsing_cocci/arity.ml
-OCAMLDEP  parsing_cocci/index.ml
-OCAMLDEP  parsing_cocci/context_neg.ml
-OCAMLDEP  parsing_cocci/adjust_pragmas.ml
-OCAMLDEP  parsing_cocci/insert_plus.ml
-OCAMLDEP  parsing_cocci/function_prototypes.ml
-OCAMLDEP  parsing_cocci/semantic_cocci.ml
-OCAMLDEP  parsing_cocci/data.ml
-OCAMLDEP  parsing_cocci/free_vars.ml
-OCAMLDEP  parsing_cocci/check_meta.ml
-OCAMLDEP  parsing_cocci/safe_for_multi_decls.ml
-OCAMLDEP  parsing_cocci/parse_printf.ml
-OCAMLDEP  parsing_cocci/parse_aux.ml
-OCAMLDEP  parsing_cocci/cleanup_rules.ml
-OCAMLDEP  parsing_cocci/disjdistr.ml
-OCAMLDEP  parsing_cocci/cocci_grep.ml
-OCAMLDEP  parsing_cocci/dpll.ml
-OCAMLDEP  parsing_cocci/get_constants2.ml
-OCAMLDEP  parsing_cocci/id_utils.ml
-OCAMLDEP  parsing_cocci/git_grep.ml
-OCAMLDEP  parsing_cocci/patch_diff.ml
-OCAMLDEP  parsing_cocci/adjacency.ml
-OCAMLDEP  parsing_cocci/commas_on_lists.ml
-OCAMLDEP  parsing_cocci/re_constraints.ml
-OCAMLDEP  parsing_cocci/parse_cocci.ml
-OCAMLDEP  parsing_cocci/command_line.ml
-OCAMLDEP  parsing_cocci/cocci_args.ml
-OCAMLDEP  parsing_c/token_annot.ml
-OCAMLDEP  parsing_c/flag_parsing_c.ml
-OCAMLDEP  parsing_c/parsing_stat.ml
-OCAMLDEP  parsing_c/token_c.ml
-OCAMLDEP  parsing_c/ast_c.ml
-OCAMLDEP  parsing_c/includes.ml
-OCAMLDEP  parsing_c/control_flow_c.ml
-OCAMLDEP  parsing_c/visitor_c.ml
-OCAMLDEP  parsing_c/lib_parsing_c.ml
-OCAMLDEP  parsing_c/includes_cache.ml
-OCAMLDEP  parsing_c/pretty_print_c.ml
-OCAMLDEP  parsing_c/control_flow_c_build.ml
-OCAMLDEP  parsing_c/semantic_c.ml
-OCAMLDEP  parsing_c/lexer_parser.ml
-OCAMLDEP  parsing_c/parse_string_c.ml
-OCAMLDEP  parsing_c/token_helpers.ml
-OCAMLDEP  parsing_c/token_views_c.ml
-OCAMLDEP  parsing_c/cpp_token_c.ml
-OCAMLDEP  parsing_c/parsing_hacks.ml
-OCAMLDEP  parsing_c/cpp_analysis_c.ml
-OCAMLDEP  parsing_c/unparse_cocci.ml
-OCAMLDEP  parsing_c/parsing_recovery_c.ml
-OCAMLDEP  parsing_c/parsing_consistency_c.ml
-OCAMLDEP  parsing_c/danger.ml
-OCAMLDEP  parsing_c/parse_c.ml
-OCAMLDEP  parsing_c/unparse_c.ml
-OCAMLDEP  parsing_c/unparse_hrule.ml
-OCAMLDEP  parsing_c/type_c.ml
-OCAMLDEP  parsing_c/cpp_ast_c.ml
-OCAMLDEP  parsing_c/type_annoter_c.ml
-OCAMLDEP  parsing_c/comment_annotater_c.ml
-OCAMLDEP  parsing_c/compare_c.ml
-OCAMLDEP  parsing_c/test_parsing_c.ml
-OCAMLDEP  ctl/flag_ctl.ml
-OCAMLDEP  ctl/ast_ctl.ml
-OCAMLDEP  ctl/pretty_print_ctl.ml
-OCAMLDEP  ctl/ctl_engine.ml
-OCAMLDEP  ctl/wrapper_ctl.ml
-OCAMLDEP  ocaml/externalanalysis.ml
-OCAMLDEP  ocaml/exposed_modules.ml
-OCAMLDEP  ocaml/coccilib.ml
-OCAMLDEP  ocaml/ocamlcocci_aux.ml
-OCAMLDEP  ocaml/yes_prepare_ocamlcocci.ml
-OCAMLDEP  ocaml/prepare_ocamlcocci.ml
-OCAMLDEP  ocaml/run_ocamlcocci.ml
-OCAMLDEP  python/pycocci_aux.ml
-OCAMLDEP  python/yes_pycocci.ml
-OCAMLDEP  python/pycocci.ml
-OCAMLDEP  engine/flag_matcher.ml
-OCAMLDEP  engine/lib_engine.ml
-OCAMLDEP  engine/pretty_print_engine.ml
-OCAMLDEP  engine/check_exhaustive_pattern.ml
-OCAMLDEP  engine/check_reachability.ml
-OCAMLDEP  engine/c_vs_c.ml
-OCAMLDEP  engine/isomorphisms_c_c.ml
-OCAMLDEP  engine/cocci_vs_c.ml
-OCAMLDEP  engine/pattern_c.ml
-OCAMLDEP  engine/transformation_c.ml
-OCAMLDEP  engine/asttomember.ml
-OCAMLDEP  engine/asttoctl2.ml
-OCAMLDEP  engine/ctltotex.ml
-OCAMLDEP  engine/postprocess_transinfo.ml
-OCAMLDEP  engine/ctlcocci_integration.ml
-OCAMLDEP  popl09/ast_popl.ml
-OCAMLDEP  popl09/asttopopl.ml
-OCAMLDEP  popl09/insert_quantifiers.ml
-OCAMLDEP  popl09/pretty_print_popl.ml
-OCAMLDEP  popl09/flag_popl.ml
-OCAMLDEP  popl09/popltoctl.ml
-OCAMLDEP  popl09/popl.ml
-OCAMLDEP  extra/classic_patch.ml
-OCAMLDEP  extra/kbuild.ml
-OCAMLDEP  extra/maintainers.ml
-OCAMLDEP  flag_cocci.ml
-OCAMLDEP  cocci.ml
-OCAMLDEP  testing.ml
-OCAMLDEP  read_options.ml
-OCAMLDEP  enter.ml
-OCAMLDEP  main.ml
-OCAMLDEP  tools/spgen/source/globals.ml
-OCAMLDEP  tools/spgen/source/ast_tostring.ml
-OCAMLDEP  tools/spgen/source/detect_patch.ml
-OCAMLDEP  tools/spgen/source/meta_variable.ml
-OCAMLDEP  tools/spgen/source/snapshot.ml
-OCAMLDEP  tools/spgen/source/user_input.ml
-OCAMLDEP  tools/spgen/source/position_generator.ml
-OCAMLDEP  tools/spgen/source/disj_generator.ml
-OCAMLDEP  tools/spgen/source/rule_body.ml
-OCAMLDEP  tools/spgen/source/rule_header.ml
-OCAMLDEP  tools/spgen/source/context_rule.ml
-OCAMLDEP  tools/spgen/source/script_rule.ml
-OCAMLDEP  tools/spgen/source/file_transform.ml
-OCAMLDEP  tools/spgen/source/spgen_interactive.ml
-OCAMLDEP  tools/spgen/source/spgen_config.ml
-OCAMLDEP  tools/spgen/source/spgen.ml
-OCAMLDEP  tools/spgen/source/spgen_test.ml
-OCAMLDEP  tools/spgen/source/main.ml
-OCAMLLEX  parsing_cocci/lexer_cocci.mll
-403 states, 6934 transitions, table size 30154 bytes
-4123 additional bytes used for bindings
-OCAMLDEP  parsing_cocci/lexer_cocci.ml
-OCAMLLEX  parsing_cocci/lexer_cli.mll
-14 states, 681 transitions, table size 2808 bytes
-OCAMLDEP  parsing_cocci/lexer_cli.ml
-OCAMLLEX  parsing_cocci/lexer_script.mll
-27 states, 322 transitions, table size 1450 bytes
-OCAMLDEP  parsing_cocci/lexer_script.ml
-OCAMLLEX  parsing_c/lexer_c.mll
-404 states, 15896 transitions, table size 66008 bytes
-16334 additional bytes used for bindings
-OCAMLDEP  parsing_c/lexer_c.ml
-OCAMLDEP  tools/spgen/source/spgen_lexer.ml
-OCAMLYACC parsing_c/parser_c.mly
-OCAMLDEP  parsing_c/parser_c.ml
-OCAMLDEP  commons/ocamlextra/dumper.mli
-OCAMLDEP  commons/commands.mli
-OCAMLDEP  commons/common.mli
-OCAMLDEP  commons/ograph_simple.mli
-OCAMLDEP  commons/ograph_extended.mli
-OCAMLDEP  globals/config.mli
-OCAMLDEP  globals/flag.mli
-OCAMLDEP  globals/iteration.mli
-OCAMLDEP  globals/regexp_pcre.mli
-OCAMLDEP  globals/regexp.mli
-OCAMLDEP  parsing_cocci/flag_parsing_cocci.mli
-OCAMLDEP  parsing_cocci/ast_cocci.mli
-OCAMLDEP  parsing_cocci/ast0_cocci.mli
-OCAMLDEP  parsing_cocci/pretty_print_cocci.mli
-OCAMLDEP  parsing_cocci/visitor_ast0_types.mli
-OCAMLDEP  parsing_cocci/visitor_ast.mli
-OCAMLDEP  parsing_cocci/visitor_ast0.mli
-OCAMLDEP  parsing_cocci/ast0toast.mli
-OCAMLDEP  parsing_cocci/unparse_ast0.mli
-OCAMLDEP  parsing_cocci/unify_ast.mli
-OCAMLDEP  parsing_cocci/compute_lines.mli
-OCAMLDEP  parsing_cocci/iso_pattern.mli
-OCAMLDEP  parsing_cocci/comm_assoc.mli
-OCAMLDEP  parsing_cocci/iso_compile.mli
-OCAMLDEP  parsing_cocci/single_statement.mli
-OCAMLDEP  parsing_cocci/simple_assignments.mli
-OCAMLDEP  parsing_cocci/get_metas.mli
-OCAMLDEP  parsing_cocci/stmtlist.mli
-OCAMLDEP  parsing_cocci/top_level.mli
-OCAMLDEP  parsing_cocci/type_infer.mli
-OCAMLDEP  parsing_cocci/test_exps.mli
-OCAMLDEP  parsing_cocci/unitary_ast0.mli
-OCAMLDEP  parsing_cocci/arity.mli
-OCAMLDEP  parsing_cocci/index.mli
-OCAMLDEP  parsing_cocci/context_neg.mli
-OCAMLDEP  parsing_cocci/adjust_pragmas.mli
-OCAMLDEP  parsing_cocci/insert_plus.mli
-OCAMLDEP  parsing_cocci/function_prototypes.mli
-OCAMLDEP  parsing_cocci/semantic_cocci.mli
-OCAMLDEP  parsing_cocci/data.mli
-OCAMLDEP  parsing_cocci/free_vars.mli
-OCAMLDEP  parsing_cocci/check_meta.mli
-OCAMLDEP  parsing_cocci/safe_for_multi_decls.mli
-OCAMLDEP  parsing_cocci/parse_printf.mli
-OCAMLDEP  parsing_cocci/parse_aux.mli
-OCAMLDEP  parsing_cocci/cleanup_rules.mli
-OCAMLDEP  parsing_cocci/disjdistr.mli
-OCAMLDEP  parsing_cocci/cocci_grep.mli
-OCAMLDEP  parsing_cocci/dpll.mli
-OCAMLDEP  parsing_cocci/get_constants2.mli
-OCAMLDEP  parsing_cocci/id_utils.mli
-OCAMLDEP  parsing_cocci/git_grep.mli
-OCAMLDEP  parsing_cocci/patch_diff.mli
-OCAMLDEP  parsing_cocci/adjacency.mli
-OCAMLDEP  parsing_cocci/commas_on_lists.mli
-OCAMLDEP  parsing_cocci/re_constraints.mli
-OCAMLDEP  parsing_cocci/parse_cocci.mli
-OCAMLDEP  parsing_cocci/command_line.mli
-OCAMLDEP  parsing_cocci/cocci_args.mli
-OCAMLDEP  parsing_c/token_annot.mli
-OCAMLDEP  parsing_c/flag_parsing_c.mli
-OCAMLDEP  parsing_c/parsing_stat.mli
-OCAMLDEP  parsing_c/token_c.mli
-OCAMLDEP  parsing_c/ast_c.mli
-OCAMLDEP  parsing_c/includes.mli
-OCAMLDEP  parsing_c/control_flow_c.mli
-OCAMLDEP  parsing_c/visitor_c.mli
-OCAMLDEP  parsing_c/lib_parsing_c.mli
-OCAMLDEP  parsing_c/includes_cache.mli
-OCAMLDEP  parsing_c/pretty_print_c.mli
-OCAMLDEP  parsing_c/control_flow_c_build.mli
-OCAMLDEP  parsing_c/semantic_c.mli
-OCAMLDEP  parsing_c/lexer_parser.mli
-OCAMLDEP  parsing_c/parse_string_c.mli
-OCAMLDEP  parsing_c/token_helpers.mli
-OCAMLDEP  parsing_c/token_views_c.mli
-OCAMLDEP  parsing_c/cpp_token_c.mli
-OCAMLDEP  parsing_c/parsing_hacks.mli
-OCAMLDEP  parsing_c/cpp_analysis_c.mli
-OCAMLDEP  parsing_c/unparse_cocci.mli
-OCAMLDEP  parsing_c/parsing_recovery_c.mli
-OCAMLDEP  parsing_c/parsing_consistency_c.mli
-OCAMLDEP  parsing_c/danger.mli
-OCAMLDEP  parsing_c/parse_c.mli
-OCAMLDEP  parsing_c/unparse_c.mli
-OCAMLDEP  parsing_c/unparse_hrule.mli
-OCAMLDEP  parsing_c/type_c.mli
-OCAMLDEP  parsing_c/cpp_ast_c.mli
-OCAMLDEP  parsing_c/type_annoter_c.mli
-OCAMLDEP  parsing_c/comment_annotater_c.mli
-OCAMLDEP  parsing_c/compare_c.mli
-OCAMLDEP  parsing_c/test_parsing_c.mli
-OCAMLDEP  ctl/flag_ctl.mli
-OCAMLDEP  ctl/ast_ctl.mli
-OCAMLDEP  ctl/pretty_print_ctl.mli
-OCAMLDEP  ctl/ctl_engine.mli
-OCAMLDEP  ctl/wrapper_ctl.mli
-OCAMLDEP  ocaml/externalanalysis.mli
-OCAMLDEP  ocaml/exposed_modules.mli
-OCAMLDEP  ocaml/coccilib.mli
-OCAMLDEP  ocaml/ocamlcocci_aux.mli
-OCAMLDEP  ocaml/yes_prepare_ocamlcocci.mli
-OCAMLDEP  ocaml/prepare_ocamlcocci.mli
-OCAMLDEP  ocaml/run_ocamlcocci.mli
-OCAMLDEP  python/pycocci_aux.mli
-OCAMLDEP  python/yes_pycocci.mli
-OCAMLDEP  python/pycocci.mli
-OCAMLDEP  engine/flag_matcher.mli
-OCAMLDEP  engine/lib_engine.mli
-OCAMLDEP  engine/pretty_print_engine.mli
-OCAMLDEP  engine/check_exhaustive_pattern.mli
-OCAMLDEP  engine/check_reachability.mli
-OCAMLDEP  engine/c_vs_c.mli
-OCAMLDEP  engine/isomorphisms_c_c.mli
-OCAMLDEP  engine/cocci_vs_c.mli
-OCAMLDEP  engine/pattern_c.mli
-OCAMLDEP  engine/transformation_c.mli
-OCAMLDEP  engine/asttomember.mli
-OCAMLDEP  engine/asttoctl2.mli
-OCAMLDEP  engine/ctltotex.mli
-OCAMLDEP  engine/postprocess_transinfo.mli
-OCAMLDEP  engine/ctlcocci_integration.mli
-OCAMLDEP  popl09/ast_popl.mli
-OCAMLDEP  popl09/asttopopl.mli
-OCAMLDEP  popl09/insert_quantifiers.mli
-OCAMLDEP  popl09/pretty_print_popl.mli
-OCAMLDEP  popl09/flag_popl.mli
-OCAMLDEP  popl09/popltoctl.mli
-OCAMLDEP  popl09/popl.mli
-OCAMLDEP  extra/classic_patch.mli
-OCAMLDEP  extra/kbuild.mli
-OCAMLDEP  extra/maintainers.mli
-OCAMLDEP  flag_cocci.mli
-OCAMLDEP  cocci.mli
-OCAMLDEP  testing.mli
-OCAMLDEP  read_options.mli
-OCAMLDEP  enter.mli
-OCAMLDEP  main.mli
-OCAMLDEP  tools/spgen/source/globals.mli
-OCAMLDEP  tools/spgen/source/ast_tostring.mli
-OCAMLDEP  tools/spgen/source/detect_patch.mli
-OCAMLDEP  tools/spgen/source/meta_variable.mli
-OCAMLDEP  tools/spgen/source/snapshot.mli
-OCAMLDEP  tools/spgen/source/user_input.mli
-OCAMLDEP  tools/spgen/source/position_generator.mli
-OCAMLDEP  tools/spgen/source/disj_generator.mli
-OCAMLDEP  tools/spgen/source/rule_body.mli
-OCAMLDEP  tools/spgen/source/rule_header.mli
-OCAMLDEP  tools/spgen/source/context_rule.mli
-OCAMLDEP  tools/spgen/source/script_rule.mli
-OCAMLDEP  tools/spgen/source/file_transform.mli
-OCAMLDEP  tools/spgen/source/spgen_interactive.mli
-OCAMLDEP  tools/spgen/source/spgen_config.mli
-OCAMLDEP  tools/spgen/source/spgen.mli
-OCAMLDEP  tools/spgen/source/spgen_test.mli
-OCAMLDEP  tools/spgen/source/main.mli
-OCAMLDEP  parsing_cocci/lexer_cocci.mli
-OCAMLDEP  parsing_cocci/lexer_cli.mli
-OCAMLDEP  parsing_cocci/lexer_script.mli
-OCAMLDEP  parsing_c/lexer_c.mli
-OCAMLDEP  tools/spgen/source/spgen_lexer.mli
-OCAMLDEP  parsing_c/parser_c.mli
-OCAMLC    commons/ocamlextra/dumper.mli
-OCAMLOPT  commons/ocamlextra/dumper.ml
-OCAMLC    commons/commands.mli
-OCAMLOPT  commons/commands.ml
-OCAMLC    commons/common.mli
-make -C bundles/stdcompat all
-make[1]: Entering directory '/home/okabe/coccinelle/bundles/stdcompat'
-cd stdcompat-current; make && cp *.mli *.cmi *.cmx *.cma *.cmxa *.a *.h *.=
so ..
-make[2]: Entering directory '/home/okabe/coccinelle/bundles/stdcompat/stdc=
ompat-current'
-make  all-am
-make[3]: Entering directory '/home/okabe/coccinelle/bundles/stdcompat/stdc=
ompat-current'
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__native.mli -o stdcompat__nat=
ive.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__init.mli -o stdcompat__init.=
cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__root.mli -o stdcompat__root.=
cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__either_s.mli -o stdcompat__e=
ither_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__either.mli -o stdcompat__eit=
her.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__seq_s.mli -o stdcompat__seq_=
s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__seq.mli -o stdcompat__seq.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__tools.mli -o stdcompat__tool=
s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__pervasives_s.mli -o stdcompa=
t__pervasives_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__arg_s.mli -o stdcompat__arg_=
s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__lazy_s.mli -o stdcompat__laz=
y_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__char_s.mli -o stdcompat__cha=
r_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__uchar_s.mli -o stdcompat__uc=
har_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__uchar.mli -o stdcompat__ucha=
r.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__buffer_s.mli -o stdcompat__b=
uffer_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__string_s.mli -o stdcompat__s=
tring_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__stringLabels_s.mli -o stdcom=
pat__stringLabels_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__bytes_s.mli -o stdcompat__by=
tes_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__bytesLabels_s.mli -o stdcomp=
at__bytesLabels_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__list_s.mli -o stdcompat__lis=
t_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__listLabels_s.mli -o stdcompa=
t__listLabels_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__stack_s.mli -o stdcompat__st=
ack_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__list.mli -o stdcompat__list.=
cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__hashtbl_ext.mli -o stdcompat=
__hashtbl_ext.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__hashtbl_s.mli -o stdcompat__=
hashtbl_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__set_s.mli -o stdcompat__set_=
s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__map_s.mli -o stdcompat__map_=
s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__weak_s.mli -o stdcompat__wea=
k_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__sys_s.mli -o stdcompat__sys_=
s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__digest_s.mli -o stdcompat__d=
igest_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__nativeint_s.mli -o stdcompat=
__nativeint_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__int_s.mli -o stdcompat__int_=
s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__int64_s.mli -o stdcompat__in=
t64_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__int32_s.mli -o stdcompat__in=
t32_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__filename_s.mli -o stdcompat_=
_filename_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__array_s.mli -o stdcompat__ar=
ray_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__arrayLabels_s.mli -o stdcomp=
at__arrayLabels_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__float_s.mli -o stdcompat__fl=
oat_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__queue_s.mli -o stdcompat__qu=
eue_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__hashtbl.mli -o stdcompat__ha=
shtbl.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__ephemeron_s.mli -o stdcompat=
__ephemeron_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__moreLabels_s.mli -o stdcompa=
t__moreLabels_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__lexing_s.mli -o stdcompat__l=
exing_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__pervasives.mli -o stdcompat_=
_pervasives.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__option_s.mli -o stdcompat__o=
ption_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__result_s.mli -o stdcompat__r=
esult_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__bool_s.mli -o stdcompat__boo=
l_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__fun_s.mli -o stdcompat__fun_=
s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__printf_s.mli -o stdcompat__p=
rintf_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__printexc_s.mli -o stdcompat_=
_printexc_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__format_s.mli -o stdcompat__f=
ormat_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__atomic_s.mli -o stdcompat__a=
tomic_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__in_channel_s.mli -o stdcompa=
t__in_channel_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__out_channel_s.mli -o stdcomp=
at__out_channel_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__random_s.mli -o stdcompat__r=
andom_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__unit_s.mli -o stdcompat__uni=
t_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__stdlib_s.mli -o stdcompat__s=
tdlib_s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__arg.mli -o stdcompat__arg.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__lazy.mli -o stdcompat__lazy.=
cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__char.mli -o stdcompat__char.=
cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__option.mli -o stdcompat__opt=
ion.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__buffer.mli -o stdcompat__buf=
fer.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__sys.mli -o stdcompat__sys.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__bytes.mli -o stdcompat__byte=
s.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__bytesLabels.mli -o stdcompat=
__bytesLabels.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__string.mli -o stdcompat__str=
ing.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__stringLabels.mli -o stdcompa=
t__stringLabels.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__filename.mli -o stdcompat__f=
ilename.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__listLabels.mli -o stdcompat_=
_listLabels.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__stack.mli -o stdcompat__stac=
k.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__set.mli -o stdcompat__set.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__map.mli -o stdcompat__map.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__weak.mli -o stdcompat__weak.=
cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__random.mli -o stdcompat__ran=
dom.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__digest.mli -o stdcompat__dig=
est.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__nativeint.mli -o stdcompat__=
nativeint.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__int.mli -o stdcompat__int.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__int64.mli -o stdcompat__int6=
4.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__int32.mli -o stdcompat__int3=
2.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__array.mli -o stdcompat__arra=
y.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__arrayLabels.mli -o stdcompat=
__arrayLabels.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__float.mli -o stdcompat__floa=
t.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__queue.mli -o stdcompat__queu=
e.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__ephemeron.mli -o stdcompat__=
ephemeron.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__moreLabels.mli -o stdcompat_=
_moreLabels.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__lexing.mli -o stdcompat__lex=
ing.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__printexc.mli -o stdcompat__p=
rintexc.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__result.mli -o stdcompat__res=
ult.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__bool.mli -o stdcompat__bool.=
cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__fun.mli -o stdcompat__fun.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__format.mli -o stdcompat__for=
mat.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__printf.mli -o stdcompat__pri=
ntf.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__atomic.mli -o stdcompat__ato=
mic.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__in_channel.mli -o stdcompat_=
_in_channel.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__out_channel.mli -o stdcompat=
__out_channel.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__unit.mli -o stdcompat__unit.=
cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__stdlib.mli -o stdcompat__std=
lib.cmi
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat.mli -o stdcompat.cmi
-ocamlfind ocamlmklib -o stdcompat__stubs stdcompat__stubs.o
-ocamlfind ocamlc -package seq -package uchar -bin-annot -no-alias-deps -no=
labels -I . -alert -deprecated -c -impl stdcompat__native.ml_byte
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__init.ml -o stdcompat__init.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__root.ml -o stdcompat__root.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__either_s.ml -o stdcompat__eith=
er_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__either.ml -o stdcompat__either=
.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__seq_s.ml -o stdcompat__seq_s.c=
mo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__seq.ml -o stdcompat__seq.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__tools.ml -o stdcompat__tools.c=
mo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__pervasives_s.ml -o stdcompat__=
pervasives_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__arg_s.ml -o stdcompat__arg_s.c=
mo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__lazy_s.ml -o stdcompat__lazy_s=
.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__char_s.ml -o stdcompat__char_s=
.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__uchar_s.ml -o stdcompat__uchar=
_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__uchar.ml -o stdcompat__uchar.c=
mo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__buffer_s.ml -o stdcompat__buff=
er_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__string_s.ml -o stdcompat__stri=
ng_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__stringLabels_s.ml -o stdcompat=
__stringLabels_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__bytes_s.ml -o stdcompat__bytes=
_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__bytesLabels_s.ml -o stdcompat_=
_bytesLabels_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__list_s.ml -o stdcompat__list_s=
.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__listLabels_s.ml -o stdcompat__=
listLabels_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__stack_s.ml -o stdcompat__stack=
_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__list.ml -o stdcompat__list.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__hashtbl_ext.ml -o stdcompat__h=
ashtbl_ext.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__hashtbl_s.ml -o stdcompat__has=
htbl_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__set_s.ml -o stdcompat__set_s.c=
mo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__map_s.ml -o stdcompat__map_s.c=
mo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__weak_s.ml -o stdcompat__weak_s=
.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__sys_s.ml -o stdcompat__sys_s.c=
mo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__digest_s.ml -o stdcompat__dige=
st_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__nativeint_s.ml -o stdcompat__n=
ativeint_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__int_s.ml -o stdcompat__int_s.c=
mo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__int64_s.ml -o stdcompat__int64=
_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__int32_s.ml -o stdcompat__int32=
_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__filename_s.ml -o stdcompat__fi=
lename_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__array_s.ml -o stdcompat__array=
_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__arrayLabels_s.ml -o stdcompat_=
_arrayLabels_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__float_s.ml -o stdcompat__float=
_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__queue_s.ml -o stdcompat__queue=
_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__hashtbl.ml -o stdcompat__hasht=
bl.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__ephemeron_s.ml -o stdcompat__e=
phemeron_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__moreLabels_s.ml -o stdcompat__=
moreLabels_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__lexing_s.ml -o stdcompat__lexi=
ng_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__pervasives.ml -o stdcompat__pe=
rvasives.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__option_s.ml -o stdcompat__opti=
on_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__result_s.ml -o stdcompat__resu=
lt_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__bool_s.ml -o stdcompat__bool_s=
.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__fun_s.ml -o stdcompat__fun_s.c=
mo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__printf_s.ml -o stdcompat__prin=
tf_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__printexc_s.ml -o stdcompat__pr=
intexc_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__format_s.ml -o stdcompat__form=
at_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__atomic_s.ml -o stdcompat__atom=
ic_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__in_channel_s.ml -o stdcompat__=
in_channel_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__out_channel_s.ml -o stdcompat_=
_out_channel_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__random_s.ml -o stdcompat__rand=
om_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__unit_s.ml -o stdcompat__unit_s=
.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__stdlib_s.ml -o stdcompat__stdl=
ib_s.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__arg.ml -o stdcompat__arg.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__lazy.ml -o stdcompat__lazy.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__char.ml -o stdcompat__char.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__option.ml -o stdcompat__option=
.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__buffer.ml -o stdcompat__buffer=
.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__sys.ml -o stdcompat__sys.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__bytes.ml -o stdcompat__bytes.c=
mo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__bytesLabels.ml -o stdcompat__b=
ytesLabels.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__string.ml -o stdcompat__string=
.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__stringLabels.ml -o stdcompat__=
stringLabels.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__filename.ml -o stdcompat__file=
name.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__listLabels.ml -o stdcompat__li=
stLabels.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__stack.ml -o stdcompat__stack.c=
mo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__set.ml -o stdcompat__set.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__map.ml -o stdcompat__map.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__weak.ml -o stdcompat__weak.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__random.ml -o stdcompat__random=
.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__digest.ml -o stdcompat__digest=
.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__nativeint.ml -o stdcompat__nat=
iveint.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__int.ml -o stdcompat__int.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__int64.ml -o stdcompat__int64.c=
mo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__int32.ml -o stdcompat__int32.c=
mo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__array.ml -o stdcompat__array.c=
mo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__arrayLabels.ml -o stdcompat__a=
rrayLabels.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__float.ml -o stdcompat__float.c=
mo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__queue.ml -o stdcompat__queue.c=
mo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__ephemeron.ml -o stdcompat__eph=
emeron.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__moreLabels.ml -o stdcompat__mo=
reLabels.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__lexing.ml -o stdcompat__lexing=
.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__printexc.ml -o stdcompat__prin=
texc.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__result.ml -o stdcompat__result=
.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__bool.ml -o stdcompat__bool.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__fun.ml -o stdcompat__fun.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__format.ml -o stdcompat__format=
.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__printf.ml -o stdcompat__printf=
.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__atomic.ml -o stdcompat__atomic=
.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__in_channel.ml -o stdcompat__in=
_channel.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__out_channel.ml -o stdcompat__o=
ut_channel.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__unit.ml -o stdcompat__unit.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat__stdlib.ml -o stdcompat__stdlib=
.cmo
-ocamlfind ocamlc -c -package seq -package uchar -bin-annot -no-alias-deps =
-nolabels -I . -alert -deprecated stdcompat.ml -o stdcompat.cmo
-ocamlfind ocamlc -package seq -package uchar -bin-annot -no-alias-deps -a =
stdcompat__native.cmo stdcompat__init.cmo stdcompat__root.cmo stdcompat__ei=
ther_s.cmo stdcompat__either.cmo stdcompat__seq_s.cmo stdcompat__seq.cmo st=
dcompat__tools.cmo stdcompat__pervasives_s.cmo stdcompat__arg_s.cmo stdcomp=
at__lazy_s.cmo stdcompat__char_s.cmo stdcompat__uchar_s.cmo stdcompat__ucha=
r.cmo stdcompat__buffer_s.cmo stdcompat__string_s.cmo stdcompat__stringLabe=
ls_s.cmo stdcompat__bytes_s.cmo stdcompat__bytesLabels_s.cmo stdcompat__lis=
t_s.cmo stdcompat__listLabels_s.cmo stdcompat__stack_s.cmo stdcompat__list.=
cmo stdcompat__hashtbl_ext.cmo stdcompat__hashtbl_s.cmo stdcompat__set_s.cm=
o stdcompat__map_s.cmo stdcompat__weak_s.cmo stdcompat__sys_s.cmo stdcompat=
__digest_s.cmo stdcompat__nativeint_s.cmo stdcompat__int_s.cmo stdcompat__i=
nt64_s.cmo stdcompat__int32_s.cmo stdcompat__filename_s.cmo stdcompat__arra=
y_s.cmo stdcompat__arrayLabels_s.cmo stdcompat__float_s.cmo stdcompat__queu=
e_s.cmo stdcompat__hashtbl.cmo stdcompat__ephemeron_s.cmo stdcompat__moreLa=
bels_s.cmo stdcompat__lexing_s.cmo stdcompat__pervasives.cmo stdcompat__opt=
ion_s.cmo stdcompat__result_s.cmo stdcompat__bool_s.cmo stdcompat__fun_s.cm=
o stdcompat__printf_s.cmo stdcompat__printexc_s.cmo stdcompat__format_s.cmo=
 stdcompat__atomic_s.cmo stdcompat__in_channel_s.cmo stdcompat__out_channel=
_s.cmo stdcompat__random_s.cmo stdcompat__unit_s.cmo stdcompat__stdlib_s.cm=
o stdcompat__arg.cmo stdcompat__lazy.cmo stdcompat__char.cmo stdcompat__opt=
ion.cmo stdcompat__buffer.cmo stdcompat__sys.cmo stdcompat__bytes.cmo stdco=
mpat__bytesLabels.cmo stdcompat__string.cmo stdcompat__stringLabels.cmo std=
compat__filename.cmo stdcompat__listLabels.cmo stdcompat__stack.cmo stdcomp=
at__set.cmo stdcompat__map.cmo stdcompat__weak.cmo stdcompat__random.cmo st=
dcompat__digest.cmo stdcompat__nativeint.cmo stdcompat__int.cmo stdcompat__=
int64.cmo stdcompat__int32.cmo stdcompat__array.cmo stdcompat__arrayLabels.=
cmo stdcompat__float.cmo stdcompat__queue.cmo stdcompat__ephemeron.cmo stdc=
ompat__moreLabels.cmo stdcompat__lexing.cmo stdcompat__printexc.cmo stdcomp=
at__result.cmo stdcompat__bool.cmo stdcompat__fun.cmo stdcompat__format.cmo=
 stdcompat__printf.cmo stdcompat__atomic.cmo stdcompat__in_channel.cmo stdc=
ompat__out_channel.cmo stdcompat__unit.cmo stdcompat__stdlib.cmo stdcompat.=
cmo \
-  -cclib "-L. -lstdcompat__stubs" -dllib -lstdcompat__stubs -o stdcompat.c=
ma
-ocamlfind ocamlopt -package seq -package uchar -bin-annot -no-alias-deps -=
nolabels -I . -alert -deprecated -c -impl stdcompat__native.ml_native
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__init.ml -o stdcompat__init.c=
mx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__root.ml -o stdcompat__root.c=
mx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__either_s.ml -o stdcompat__ei=
ther_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__either.ml -o stdcompat__eith=
er.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__seq_s.ml -o stdcompat__seq_s=
.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__seq.ml -o stdcompat__seq.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__tools.ml -o stdcompat__tools=
.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__pervasives_s.ml -o stdcompat=
__pervasives_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__arg_s.ml -o stdcompat__arg_s=
.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__lazy_s.ml -o stdcompat__lazy=
_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__char_s.ml -o stdcompat__char=
_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__uchar_s.ml -o stdcompat__uch=
ar_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__uchar.ml -o stdcompat__uchar=
.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__buffer_s.ml -o stdcompat__bu=
ffer_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__string_s.ml -o stdcompat__st=
ring_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__stringLabels_s.ml -o stdcomp=
at__stringLabels_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__bytes_s.ml -o stdcompat__byt=
es_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__bytesLabels_s.ml -o stdcompa=
t__bytesLabels_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__list_s.ml -o stdcompat__list=
_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__listLabels_s.ml -o stdcompat=
__listLabels_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__stack_s.ml -o stdcompat__sta=
ck_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__list.ml -o stdcompat__list.c=
mx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__hashtbl_ext.ml -o stdcompat_=
_hashtbl_ext.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__hashtbl_s.ml -o stdcompat__h=
ashtbl_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__set_s.ml -o stdcompat__set_s=
.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__map_s.ml -o stdcompat__map_s=
.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__weak_s.ml -o stdcompat__weak=
_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__sys_s.ml -o stdcompat__sys_s=
.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__digest_s.ml -o stdcompat__di=
gest_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__nativeint_s.ml -o stdcompat_=
_nativeint_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__int_s.ml -o stdcompat__int_s=
.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__int64_s.ml -o stdcompat__int=
64_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__int32_s.ml -o stdcompat__int=
32_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__filename_s.ml -o stdcompat__=
filename_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__array_s.ml -o stdcompat__arr=
ay_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__arrayLabels_s.ml -o stdcompa=
t__arrayLabels_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__float_s.ml -o stdcompat__flo=
at_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__queue_s.ml -o stdcompat__que=
ue_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__hashtbl.ml -o stdcompat__has=
htbl.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__ephemeron_s.ml -o stdcompat_=
_ephemeron_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__moreLabels_s.ml -o stdcompat=
__moreLabels_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__lexing_s.ml -o stdcompat__le=
xing_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__pervasives.ml -o stdcompat__=
pervasives.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__option_s.ml -o stdcompat__op=
tion_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__result_s.ml -o stdcompat__re=
sult_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__bool_s.ml -o stdcompat__bool=
_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__fun_s.ml -o stdcompat__fun_s=
.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__printf_s.ml -o stdcompat__pr=
intf_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__printexc_s.ml -o stdcompat__=
printexc_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__format_s.ml -o stdcompat__fo=
rmat_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__atomic_s.ml -o stdcompat__at=
omic_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__in_channel_s.ml -o stdcompat=
__in_channel_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__out_channel_s.ml -o stdcompa=
t__out_channel_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__random_s.ml -o stdcompat__ra=
ndom_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__unit_s.ml -o stdcompat__unit=
_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__stdlib_s.ml -o stdcompat__st=
dlib_s.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__arg.ml -o stdcompat__arg.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__lazy.ml -o stdcompat__lazy.c=
mx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__char.ml -o stdcompat__char.c=
mx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__option.ml -o stdcompat__opti=
on.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__buffer.ml -o stdcompat__buff=
er.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__sys.ml -o stdcompat__sys.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__bytes.ml -o stdcompat__bytes=
.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__bytesLabels.ml -o stdcompat_=
_bytesLabels.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__string.ml -o stdcompat__stri=
ng.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__stringLabels.ml -o stdcompat=
__stringLabels.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__filename.ml -o stdcompat__fi=
lename.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__listLabels.ml -o stdcompat__=
listLabels.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__stack.ml -o stdcompat__stack=
.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__set.ml -o stdcompat__set.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__map.ml -o stdcompat__map.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__weak.ml -o stdcompat__weak.c=
mx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__random.ml -o stdcompat__rand=
om.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__digest.ml -o stdcompat__dige=
st.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__nativeint.ml -o stdcompat__n=
ativeint.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__int.ml -o stdcompat__int.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__int64.ml -o stdcompat__int64=
.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__int32.ml -o stdcompat__int32=
.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__array.ml -o stdcompat__array=
.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__arrayLabels.ml -o stdcompat_=
_arrayLabels.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__float.ml -o stdcompat__float=
.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__queue.ml -o stdcompat__queue=
.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__ephemeron.ml -o stdcompat__e=
phemeron.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__moreLabels.ml -o stdcompat__=
moreLabels.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__lexing.ml -o stdcompat__lexi=
ng.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__printexc.ml -o stdcompat__pr=
intexc.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__result.ml -o stdcompat__resu=
lt.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__bool.ml -o stdcompat__bool.c=
mx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__fun.ml -o stdcompat__fun.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__format.ml -o stdcompat__form=
at.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__printf.ml -o stdcompat__prin=
tf.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__atomic.ml -o stdcompat__atom=
ic.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__in_channel.ml -o stdcompat__=
in_channel.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__out_channel.ml -o stdcompat_=
_out_channel.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__unit.ml -o stdcompat__unit.c=
mx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat__stdlib.ml -o stdcompat__stdl=
ib.cmx
-ocamlfind ocamlopt -c -package seq -package uchar -bin-annot -no-alias-dep=
s -nolabels -I . -alert -deprecated stdcompat.ml -o stdcompat.cmx
-ocamlfind ocamlopt -package seq -package uchar -bin-annot -no-alias-deps -=
a stdcompat__native.cmx stdcompat__init.cmx stdcompat__root.cmx stdcompat__=
either_s.cmx stdcompat__either.cmx stdcompat__seq_s.cmx stdcompat__seq.cmx =
stdcompat__tools.cmx stdcompat__pervasives_s.cmx stdcompat__arg_s.cmx stdco=
mpat__lazy_s.cmx stdcompat__char_s.cmx stdcompat__uchar_s.cmx stdcompat__uc=
har.cmx stdcompat__buffer_s.cmx stdcompat__string_s.cmx stdcompat__stringLa=
bels_s.cmx stdcompat__bytes_s.cmx stdcompat__bytesLabels_s.cmx stdcompat__l=
ist_s.cmx stdcompat__listLabels_s.cmx stdcompat__stack_s.cmx stdcompat__lis=
t.cmx stdcompat__hashtbl_ext.cmx stdcompat__hashtbl_s.cmx stdcompat__set_s.=
cmx stdcompat__map_s.cmx stdcompat__weak_s.cmx stdcompat__sys_s.cmx stdcomp=
at__digest_s.cmx stdcompat__nativeint_s.cmx stdcompat__int_s.cmx stdcompat_=
_int64_s.cmx stdcompat__int32_s.cmx stdcompat__filename_s.cmx stdcompat__ar=
ray_s.cmx stdcompat__arrayLabels_s.cmx stdcompat__float_s.cmx stdcompat__qu=
eue_s.cmx stdcompat__hashtbl.cmx stdcompat__ephemeron_s.cmx stdcompat__more=
Labels_s.cmx stdcompat__lexing_s.cmx stdcompat__pervasives.cmx stdcompat__o=
ption_s.cmx stdcompat__result_s.cmx stdcompat__bool_s.cmx stdcompat__fun_s.=
cmx stdcompat__printf_s.cmx stdcompat__printexc_s.cmx stdcompat__format_s.c=
mx stdcompat__atomic_s.cmx stdcompat__in_channel_s.cmx stdcompat__out_chann=
el_s.cmx stdcompat__random_s.cmx stdcompat__unit_s.cmx stdcompat__stdlib_s.=
cmx stdcompat__arg.cmx stdcompat__lazy.cmx stdcompat__char.cmx stdcompat__o=
ption.cmx stdcompat__buffer.cmx stdcompat__sys.cmx stdcompat__bytes.cmx std=
compat__bytesLabels.cmx stdcompat__string.cmx stdcompat__stringLabels.cmx s=
tdcompat__filename.cmx stdcompat__listLabels.cmx stdcompat__stack.cmx stdco=
mpat__set.cmx stdcompat__map.cmx stdcompat__weak.cmx stdcompat__random.cmx =
stdcompat__digest.cmx stdcompat__nativeint.cmx stdcompat__int.cmx stdcompat=
__int64.cmx stdcompat__int32.cmx stdcompat__array.cmx stdcompat__arrayLabel=
s.cmx stdcompat__float.cmx stdcompat__queue.cmx stdcompat__ephemeron.cmx st=
dcompat__moreLabels.cmx stdcompat__lexing.cmx stdcompat__printexc.cmx stdco=
mpat__result.cmx stdcompat__bool.cmx stdcompat__fun.cmx stdcompat__format.c=
mx stdcompat__printf.cmx stdcompat__atomic.cmx stdcompat__in_channel.cmx st=
dcompat__out_channel.cmx stdcompat__unit.cmx stdcompat__stdlib.cmx stdcompa=
t.cmx -cclib "-L. -lstdcompat__stubs" -o stdcompat.cmxa
-ocamlfind ocamlopt -package seq -package uchar -bin-annot -no-alias-deps -=
shared stdcompat__native.cmx stdcompat__init.cmx stdcompat__root.cmx stdcom=
pat__either_s.cmx stdcompat__either.cmx stdcompat__seq_s.cmx stdcompat__seq=
.cmx stdcompat__tools.cmx stdcompat__pervasives_s.cmx stdcompat__arg_s.cmx =
stdcompat__lazy_s.cmx stdcompat__char_s.cmx stdcompat__uchar_s.cmx stdcompa=
t__uchar.cmx stdcompat__buffer_s.cmx stdcompat__string_s.cmx stdcompat__str=
ingLabels_s.cmx stdcompat__bytes_s.cmx stdcompat__bytesLabels_s.cmx stdcomp=
at__list_s.cmx stdcompat__listLabels_s.cmx stdcompat__stack_s.cmx stdcompat=
__list.cmx stdcompat__hashtbl_ext.cmx stdcompat__hashtbl_s.cmx stdcompat__s=
et_s.cmx stdcompat__map_s.cmx stdcompat__weak_s.cmx stdcompat__sys_s.cmx st=
dcompat__digest_s.cmx stdcompat__nativeint_s.cmx stdcompat__int_s.cmx stdco=
mpat__int64_s.cmx stdcompat__int32_s.cmx stdcompat__filename_s.cmx stdcompa=
t__array_s.cmx stdcompat__arrayLabels_s.cmx stdcompat__float_s.cmx stdcompa=
t__queue_s.cmx stdcompat__hashtbl.cmx stdcompat__ephemeron_s.cmx stdcompat_=
_moreLabels_s.cmx stdcompat__lexing_s.cmx stdcompat__pervasives.cmx stdcomp=
at__option_s.cmx stdcompat__result_s.cmx stdcompat__bool_s.cmx stdcompat__f=
un_s.cmx stdcompat__printf_s.cmx stdcompat__printexc_s.cmx stdcompat__forma=
t_s.cmx stdcompat__atomic_s.cmx stdcompat__in_channel_s.cmx stdcompat__out_=
channel_s.cmx stdcompat__random_s.cmx stdcompat__unit_s.cmx stdcompat__stdl=
ib_s.cmx stdcompat__arg.cmx stdcompat__lazy.cmx stdcompat__char.cmx stdcomp=
at__option.cmx stdcompat__buffer.cmx stdcompat__sys.cmx stdcompat__bytes.cm=
x stdcompat__bytesLabels.cmx stdcompat__string.cmx stdcompat__stringLabels.=
cmx stdcompat__filename.cmx stdcompat__listLabels.cmx stdcompat__stack.cmx =
stdcompat__set.cmx stdcompat__map.cmx stdcompat__weak.cmx stdcompat__random=
.cmx stdcompat__digest.cmx stdcompat__nativeint.cmx stdcompat__int.cmx stdc=
ompat__int64.cmx stdcompat__int32.cmx stdcompat__array.cmx stdcompat__array=
Labels.cmx stdcompat__float.cmx stdcompat__queue.cmx stdcompat__ephemeron.c=
mx stdcompat__moreLabels.cmx stdcompat__lexing.cmx stdcompat__printexc.cmx =
stdcompat__result.cmx stdcompat__bool.cmx stdcompat__fun.cmx stdcompat__for=
mat.cmx stdcompat__printf.cmx stdcompat__atomic.cmx stdcompat__in_channel.c=
mx stdcompat__out_channel.cmx stdcompat__unit.cmx stdcompat__stdlib.cmx std=
compat.cmx -cclib "-L. -lstdcompat__stubs" -o stdcompat.cmxs
-make[3]: Leaving directory '/home/okabe/coccinelle/bundles/stdcompat/stdco=
mpat-current'
-make[2]: Leaving directory '/home/okabe/coccinelle/bundles/stdcompat/stdco=
mpat-current'
-make[1]: Leaving directory '/home/okabe/coccinelle/bundles/stdcompat'
-OCAMLOPT  commons/common.ml
-OCAMLC    commons/ograph_simple.mli
-OCAMLOPT  commons/ograph_simple.ml
-OCAMLC    commons/ograph_extended.mli
-OCAMLOPT  commons/ograph_extended.ml
-OCAMLOPT  -o commons/commons.cmxa
-OCAMLC    globals/config.mli
-OCAMLOPT  globals/config.ml
-OCAMLC    globals/flag.mli
-OCAMLOPT  globals/flag.ml
-OCAMLC    globals/iteration.mli
-OCAMLOPT  globals/iteration.ml
-make -C bundles/pcre all
-make[1]: Entering directory '/home/okabe/coccinelle/bundles/pcre'
-make depend-rec
-make[2]: Entering directory '/home/okabe/coccinelle/bundles/pcre'
-/usr/bin/ocamldep  -I pcre-ocaml/src pcre-ocaml/src/pcre.mli  pcre-ocaml/s=
rc/pcre.ml     >.depend
-make[2]: Leaving directory '/home/okabe/coccinelle/bundles/pcre'
-make[2]: Entering directory '/home/okabe/coccinelle/bundles/pcre'
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I pcre-ocaml/src  -cclib -lpcre -c pcre-ocaml/src/pcre.mli -o pcre-oc=
aml/src/pcre.cmi
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I pcre-ocaml/src  -cclib -lpcre  -c pcre-ocaml/src/pcre.ml -o pcre-oc=
aml/src/pcre.cmo
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I pcre-ocaml/src  -cclib -lpcre -custom -cclib -lpcre_stubs -cclib -l=
pcre -a pcre-ocaml/src/pcre.cmo -o pcre-ocaml/src/pcre.cma
-cp pcre-ocaml/src/pcre.cma pcre.cma
-cp pcre-ocaml/src/pcre.cmi pcre.cmi
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I pcre-ocaml/src  -cclib -lpcre -ccopt -fPIC pcre-ocaml/src/pcre_stub=
s.c -o pcre-ocaml/src/pcre_stubs.o
-mv pcre_stubs.o pcre-ocaml/src/pcre_stubs.o
-/usr/bin/ocamlmklib -linkall -ldopt -lpcre -o pcre-ocaml/src/pcre_stubs pc=
re-ocaml/src/pcre_stubs.o
-cp pcre-ocaml/src/libpcre_stubs.a libpcre_stubs.a
-cp pcre-ocaml/src/dllpcre_stubs.so dllpcre_stubs.so
-make[2]: Leaving directory '/home/okabe/coccinelle/bundles/pcre'
-make[1]: Leaving directory '/home/okabe/coccinelle/bundles/pcre'
-make -C bundles/pcre all.opt
-make[1]: Entering directory '/home/okabe/coccinelle/bundles/pcre'
-make[2]: Entering directory '/home/okabe/coccinelle/bundles/pcre'
-/usr/bin/ocamlopt.opt  -I /home/okabe/coccinelle/bundles/stdcompat -I pcre=
-ocaml/src  -cclib -lpcre  -c pcre-ocaml/src/pcre.ml -o pcre-ocaml/src/pcre=
.cmx
-/usr/bin/ocamlopt.opt  -I /home/okabe/coccinelle/bundles/stdcompat -I pcre=
-ocaml/src  -cclib -lpcre -cclib -lpcre_stubs -cclib -lpcre -a pcre-ocaml/s=
rc/pcre.cmx -o pcre-ocaml/src/pcre.cmxa
-cp pcre-ocaml/src/pcre.cmxa pcre.cmxa
-cp pcre-ocaml/src/pcre.cmx pcre.cmx
-cp pcre-ocaml/src/pcre.a pcre.a
-make[2]: Leaving directory '/home/okabe/coccinelle/bundles/pcre'
-make[1]: Leaving directory '/home/okabe/coccinelle/bundles/pcre'
-OCAMLC    globals/regexp_pcre.mli
-OCAMLOPT  globals/regexp_pcre.ml
-OCAMLC    globals/regexp.mli
-OCAMLOPT  globals/regexp.ml
-OCAMLOPT  -o globals/globals.cmxa
-OCAMLC    parsing_cocci/flag_parsing_cocci.mli
-OCAMLOPT  parsing_cocci/flag_parsing_cocci.ml
-OCAMLC    parsing_cocci/ast_cocci.mli
-OCAMLOPT  parsing_cocci/ast_cocci.ml
-OCAMLC    parsing_cocci/ast0_cocci.mli
-OCAMLOPT  parsing_cocci/ast0_cocci.ml
-OCAMLC    parsing_cocci/pretty_print_cocci.mli
-OCAMLOPT  parsing_cocci/pretty_print_cocci.ml
-OCAMLC    parsing_cocci/visitor_ast0_types.mli
-OCAMLOPT  parsing_cocci/visitor_ast0_types.ml
-OCAMLC    parsing_cocci/visitor_ast.mli
-OCAMLOPT  parsing_cocci/visitor_ast.ml
-OCAMLC    parsing_cocci/visitor_ast0.mli
-OCAMLOPT  parsing_cocci/visitor_ast0.ml
-OCAMLC    parsing_cocci/ast0toast.mli
-OCAMLOPT  parsing_cocci/ast0toast.ml
-OCAMLC    parsing_cocci/unparse_ast0.mli
-OCAMLOPT  parsing_cocci/unparse_ast0.ml
-OCAMLC    parsing_cocci/unify_ast.mli
-OCAMLOPT  parsing_cocci/unify_ast.ml
-OCAMLC    parsing_cocci/compute_lines.mli
-OCAMLOPT  parsing_cocci/compute_lines.ml
-OCAMLC    parsing_cocci/iso_pattern.mli
-OCAMLOPT  parsing_cocci/iso_pattern.ml
-OCAMLC    parsing_cocci/comm_assoc.mli
-OCAMLOPT  parsing_cocci/comm_assoc.ml
-OCAMLC    parsing_cocci/iso_compile.mli
-OCAMLOPT  parsing_cocci/iso_compile.ml
-OCAMLC    parsing_cocci/single_statement.mli
-OCAMLOPT  parsing_cocci/single_statement.ml
-OCAMLC    parsing_cocci/simple_assignments.mli
-OCAMLOPT  parsing_cocci/simple_assignments.ml
-OCAMLC    parsing_cocci/get_metas.mli
-OCAMLOPT  parsing_cocci/get_metas.ml
-OCAMLC    parsing_cocci/stmtlist.mli
-OCAMLOPT  parsing_cocci/stmtlist.ml
-OCAMLC    parsing_cocci/top_level.mli
-OCAMLOPT  parsing_cocci/top_level.ml
-OCAMLC    parsing_cocci/type_infer.mli
-OCAMLOPT  parsing_cocci/type_infer.ml
-OCAMLC    parsing_cocci/test_exps.mli
-OCAMLOPT  parsing_cocci/test_exps.ml
-OCAMLC    parsing_cocci/unitary_ast0.mli
-OCAMLOPT  parsing_cocci/unitary_ast0.ml
-OCAMLC    parsing_cocci/arity.mli
-OCAMLOPT  parsing_cocci/arity.ml
-OCAMLC    parsing_cocci/index.mli
-OCAMLOPT  parsing_cocci/index.ml
-OCAMLC    parsing_cocci/context_neg.mli
-OCAMLOPT  parsing_cocci/context_neg.ml
-OCAMLC    parsing_cocci/adjust_pragmas.mli
-OCAMLOPT  parsing_cocci/adjust_pragmas.ml
-OCAMLC    parsing_cocci/insert_plus.mli
-OCAMLOPT  parsing_cocci/insert_plus.ml
-OCAMLC    parsing_cocci/function_prototypes.mli
-OCAMLOPT  parsing_cocci/function_prototypes.ml
-OCAMLC    parsing_cocci/semantic_cocci.mli
-OCAMLOPT  parsing_cocci/semantic_cocci.ml
-OCAMLC    parsing_cocci/data.mli
-OCAMLOPT  parsing_cocci/data.ml
-OCAMLC    parsing_cocci/free_vars.mli
-OCAMLOPT  parsing_cocci/free_vars.ml
-OCAMLC    parsing_cocci/check_meta.mli
-OCAMLOPT  parsing_cocci/check_meta.ml
-OCAMLC    parsing_cocci/safe_for_multi_decls.mli
-OCAMLOPT  parsing_cocci/safe_for_multi_decls.ml
-OCAMLC    parsing_cocci/parse_printf.mli
-OCAMLOPT  parsing_cocci/parse_printf.ml
-OCAMLC    parsing_cocci/parse_aux.mli
-OCAMLOPT  parsing_cocci/parse_aux.ml
-OCAMLC    parsing_cocci/cleanup_rules.mli
-OCAMLOPT  parsing_cocci/cleanup_rules.ml
-OCAMLC    parsing_cocci/disjdistr.mli
-OCAMLOPT  parsing_cocci/disjdistr.ml
-MENHIR    parsing_cocci/parser_cocci_menhir.mly
-OCAMLDEP  parsing_cocci/parser_cocci_menhir.ml
-OCAMLDEP  parsing_cocci/parser_cocci_menhir.mli
-OCAMLC    parsing_cocci/parser_cocci_menhir.mli
-OCAMLOPT  parsing_cocci/parser_cocci_menhir.ml
-OCAMLC    parsing_cocci/lexer_cocci.mli
-OCAMLOPT  parsing_cocci/lexer_cocci.ml
-OCAMLC    parsing_cocci/lexer_cli.mli
-OCAMLOPT  parsing_cocci/lexer_cli.ml
-OCAMLC    parsing_cocci/lexer_script.mli
-OCAMLOPT  parsing_cocci/lexer_script.ml
-OCAMLC    parsing_cocci/cocci_grep.mli
-OCAMLOPT  parsing_cocci/cocci_grep.ml
-OCAMLC    parsing_cocci/dpll.mli
-OCAMLOPT  parsing_cocci/dpll.ml
-OCAMLC    parsing_cocci/get_constants2.mli
-OCAMLOPT  parsing_cocci/get_constants2.ml
-OCAMLC    parsing_cocci/id_utils.mli
-OCAMLOPT  parsing_cocci/id_utils.ml
-OCAMLC    parsing_cocci/git_grep.mli
-OCAMLOPT  parsing_cocci/git_grep.ml
-OCAMLC    parsing_cocci/patch_diff.mli
-OCAMLOPT  parsing_cocci/patch_diff.ml
-OCAMLC    parsing_cocci/adjacency.mli
-OCAMLOPT  parsing_cocci/adjacency.ml
-OCAMLC    parsing_cocci/commas_on_lists.mli
-OCAMLOPT  parsing_cocci/commas_on_lists.ml
-OCAMLC    parsing_cocci/re_constraints.mli
-OCAMLOPT  parsing_cocci/re_constraints.ml
-OCAMLC    parsing_cocci/parse_cocci.mli
-OCAMLOPT  parsing_cocci/parse_cocci.ml
-OCAMLC    parsing_cocci/command_line.mli
-OCAMLOPT  parsing_cocci/command_line.ml
-OCAMLC    parsing_cocci/cocci_args.mli
-OCAMLOPT  parsing_cocci/cocci_args.ml
-OCAMLOPT  -o parsing_cocci/parsing_cocci.cmxa
-OCAMLC    parsing_c/token_annot.mli
-OCAMLOPT  parsing_c/token_annot.ml
-OCAMLC    parsing_c/flag_parsing_c.mli
-OCAMLOPT  parsing_c/flag_parsing_c.ml
-OCAMLC    parsing_c/parsing_stat.mli
-OCAMLOPT  parsing_c/parsing_stat.ml
-OCAMLC    parsing_c/token_c.mli
-OCAMLOPT  parsing_c/token_c.ml
-OCAMLC    parsing_c/ast_c.mli
-OCAMLOPT  parsing_c/ast_c.ml
-OCAMLC    parsing_c/includes.mli
-make -C bundles/parmap all
-make[1]: Entering directory '/home/okabe/coccinelle/bundles/parmap'
-make depend-rec
-make[2]: Entering directory '/home/okabe/coccinelle/bundles/parmap'
-/usr/bin/ocamldep  -I parmap/src parmap/src/bytearray.mli parmap/src/parma=
p_utils.mli parmap/src/parmap.mli  parmap/src/parmap_compat.ml parmap/src/b=
ytearray.ml parmap/src/parmap_utils.ml parmap/src/setcore.ml parmap/src/par=
map.ml     >.depend
-make[2]: Leaving directory '/home/okabe/coccinelle/bundles/parmap'
-make[2]: Entering directory '/home/okabe/coccinelle/bundles/parmap'
-/usr/bin/ocamlopt.opt  -I /home/okabe/coccinelle/bundles/stdcompat -I parm=
ap/src -I +unix   -c parmap/src/parmap_compat.ml -o parmap/src/parmap_compa=
t.cmx
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I parmap/src -I +unix   -c parmap/src/parmap_compat.ml -o parmap/src/=
parmap_compat.cmo
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I parmap/src -I +unix  -c parmap/src/bytearray.mli -o parmap/src/byte=
array.cmi
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I parmap/src -I +unix   -c parmap/src/bytearray.ml -o parmap/src/byte=
array.cmo
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I parmap/src -I +unix  -c parmap/src/parmap_utils.mli -o parmap/src/p=
armap_utils.cmi
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I parmap/src -I +unix   -c parmap/src/parmap_utils.ml -o parmap/src/p=
armap_utils.cmo
-/usr/bin/ocamlopt.opt  -I /home/okabe/coccinelle/bundles/stdcompat -I parm=
ap/src -I +unix   -c parmap/src/setcore.ml -o parmap/src/setcore.cmx
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I parmap/src -I +unix   -c parmap/src/setcore.ml -o parmap/src/setcor=
e.cmo
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I parmap/src -I +unix  -c parmap/src/parmap.mli -o parmap/src/parmap.=
cmi
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I parmap/src -I +unix   -c parmap/src/parmap.ml -o parmap/src/parmap.=
cmo
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I parmap/src -I +unix  -custom -cclib -lparmap_stubs  -a parmap/src/p=
armap_compat.cmo parmap/src/bytearray.cmo parmap/src/parmap_utils.cmo parma=
p/src/setcore.cmo parmap/src/parmap.cmo -o parmap/src/parmap.cma
-cp parmap/src/parmap.cma parmap.cma
-cp parmap/src/parmap_compat.cmi parmap_compat.cmi
-cp parmap/src/bytearray.cmi bytearray.cmi
-cp parmap/src/parmap_utils.cmi parmap_utils.cmi
-cp parmap/src/setcore.cmi setcore.cmi
-cp parmap/src/parmap.cmi parmap.cmi
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I parmap/src -I +unix  -ccopt -D_GNU_SOURCE -ccopt -fPIC parmap/src/b=
ytearray_stubs.c -o parmap/src/bytearray_stubs.o
-mv bytearray_stubs.o parmap/src/bytearray_stubs.o
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I parmap/src -I +unix  -ccopt -D_GNU_SOURCE -ccopt -fPIC parmap/src/s=
etcore_stubs.c -o parmap/src/setcore_stubs.o
-mv setcore_stubs.o parmap/src/setcore_stubs.o
-/usr/bin/ocamlmklib -linkall  -o parmap/src/parmap_stubs parmap/src/bytear=
ray_stubs.o parmap/src/setcore_stubs.o
-cp parmap/src/libparmap_stubs.a libparmap_stubs.a
-cp parmap/src/dllparmap_stubs.so dllparmap_stubs.so
-make[2]: Leaving directory '/home/okabe/coccinelle/bundles/parmap'
-make[1]: Leaving directory '/home/okabe/coccinelle/bundles/parmap'
-make -C bundles/parmap all.opt
-make[1]: Entering directory '/home/okabe/coccinelle/bundles/parmap'
-make[2]: Entering directory '/home/okabe/coccinelle/bundles/parmap'
-/usr/bin/ocamlopt.opt  -I /home/okabe/coccinelle/bundles/stdcompat -I parm=
ap/src -I +unix   -c parmap/src/bytearray.ml -o parmap/src/bytearray.cmx
-/usr/bin/ocamlopt.opt  -I /home/okabe/coccinelle/bundles/stdcompat -I parm=
ap/src -I +unix   -c parmap/src/parmap_utils.ml -o parmap/src/parmap_utils.=
cmx
-/usr/bin/ocamlopt.opt  -I /home/okabe/coccinelle/bundles/stdcompat -I parm=
ap/src -I +unix   -c parmap/src/parmap.ml -o parmap/src/parmap.cmx
-/usr/bin/ocamlopt.opt  -I /home/okabe/coccinelle/bundles/stdcompat -I parm=
ap/src -I +unix  -cclib -lparmap_stubs  -a parmap/src/parmap_compat.cmx par=
map/src/bytearray.cmx parmap/src/parmap_utils.cmx parmap/src/setcore.cmx pa=
rmap/src/parmap.cmx -o parmap/src/parmap.cmxa
-cp parmap/src/parmap.cmxa parmap.cmxa
-cp parmap/src/parmap_compat.cmx parmap_compat.cmx
-cp parmap/src/bytearray.cmx bytearray.cmx
-cp parmap/src/parmap_utils.cmx parmap_utils.cmx
-cp parmap/src/setcore.cmx setcore.cmx
-cp parmap/src/parmap.cmx parmap.cmx
-cp parmap/src/parmap.a parmap.a
-make[2]: Leaving directory '/home/okabe/coccinelle/bundles/parmap'
-make[1]: Leaving directory '/home/okabe/coccinelle/bundles/parmap'
-OCAMLOPT  parsing_c/includes.ml
-OCAMLC    parsing_c/control_flow_c.mli
-OCAMLOPT  parsing_c/control_flow_c.ml
-OCAMLC    parsing_c/visitor_c.mli
-OCAMLOPT  parsing_c/visitor_c.ml
-OCAMLC    parsing_c/lib_parsing_c.mli
-OCAMLOPT  parsing_c/lib_parsing_c.ml
-OCAMLC    parsing_c/includes_cache.mli
-OCAMLOPT  parsing_c/includes_cache.ml
-OCAMLC    parsing_c/pretty_print_c.mli
-OCAMLOPT  parsing_c/pretty_print_c.ml
-OCAMLC    parsing_c/control_flow_c_build.mli
-OCAMLOPT  parsing_c/control_flow_c_build.ml
-OCAMLC    parsing_c/semantic_c.mli
-OCAMLOPT  parsing_c/semantic_c.ml
-OCAMLC    parsing_c/lexer_parser.mli
-OCAMLOPT  parsing_c/lexer_parser.ml
-OCAMLC    parsing_c/parser_c.mli
-OCAMLOPT  parsing_c/parser_c.ml
-OCAMLC    parsing_c/lexer_c.mli
-OCAMLOPT  parsing_c/lexer_c.ml
-OCAMLC    parsing_c/parse_string_c.mli
-OCAMLOPT  parsing_c/parse_string_c.ml
-OCAMLC    parsing_c/token_helpers.mli
-OCAMLOPT  parsing_c/token_helpers.ml
-OCAMLC    parsing_c/token_views_c.mli
-OCAMLOPT  parsing_c/token_views_c.ml
-OCAMLC    parsing_c/cpp_token_c.mli
-OCAMLOPT  parsing_c/cpp_token_c.ml
-OCAMLC    parsing_c/parsing_hacks.mli
-OCAMLOPT  parsing_c/parsing_hacks.ml
-OCAMLC    parsing_c/cpp_analysis_c.mli
-OCAMLOPT  parsing_c/cpp_analysis_c.ml
-OCAMLC    parsing_c/unparse_cocci.mli
-OCAMLOPT  parsing_c/unparse_cocci.ml
-OCAMLC    parsing_c/parsing_recovery_c.mli
-OCAMLOPT  parsing_c/parsing_recovery_c.ml
-OCAMLC    parsing_c/parsing_consistency_c.mli
-OCAMLOPT  parsing_c/parsing_consistency_c.ml
-OCAMLC    parsing_c/danger.mli
-OCAMLOPT  parsing_c/danger.ml
-OCAMLC    parsing_c/parse_c.mli
-OCAMLOPT  parsing_c/parse_c.ml
-OCAMLC    parsing_c/unparse_c.mli
-OCAMLOPT  parsing_c/unparse_c.ml
-OCAMLC    parsing_c/unparse_hrule.mli
-OCAMLOPT  parsing_c/unparse_hrule.ml
-OCAMLC    parsing_c/type_c.mli
-OCAMLOPT  parsing_c/type_c.ml
-OCAMLC    parsing_c/cpp_ast_c.mli
-OCAMLOPT  parsing_c/cpp_ast_c.ml
-OCAMLC    parsing_c/type_annoter_c.mli
-OCAMLOPT  parsing_c/type_annoter_c.ml
-OCAMLC    parsing_c/comment_annotater_c.mli
-OCAMLOPT  parsing_c/comment_annotater_c.ml
-OCAMLC    parsing_c/compare_c.mli
-OCAMLOPT  parsing_c/compare_c.ml
-OCAMLC    parsing_c/test_parsing_c.mli
-OCAMLOPT  parsing_c/test_parsing_c.ml
-OCAMLOPT  -o parsing_c/parsing_c.cmxa
-OCAMLC    ctl/flag_ctl.mli
-OCAMLOPT  ctl/flag_ctl.ml
-OCAMLC    ctl/ast_ctl.mli
-OCAMLOPT  ctl/ast_ctl.ml
-OCAMLC    ctl/pretty_print_ctl.mli
-OCAMLOPT  ctl/pretty_print_ctl.ml
-OCAMLC    ctl/ctl_engine.mli
-OCAMLOPT  ctl/ctl_engine.ml
-OCAMLC    ctl/wrapper_ctl.mli
-OCAMLOPT  ctl/wrapper_ctl.ml
-OCAMLOPT  -o ctl/ctl.cmxa
-OCAMLC    ocaml/externalanalysis.mli
-OCAMLOPT  ocaml/externalanalysis.ml
-OCAMLC    ocaml/exposed_modules.mli
-OCAMLOPT  ocaml/exposed_modules.ml
-OCAMLC    ocaml/coccilib.mli
-OCAMLOPT  ocaml/coccilib.ml
-OCAMLC    ocaml/ocamlcocci_aux.mli
-OCAMLOPT  ocaml/ocamlcocci_aux.ml
-OCAMLC    ocaml/yes_prepare_ocamlcocci.mli
-OCAMLOPT  ocaml/yes_prepare_ocamlcocci.ml
-OCAMLC    ocaml/prepare_ocamlcocci.mli
-OCAMLOPT  ocaml/prepare_ocamlcocci.ml
-OCAMLC    ocaml/run_ocamlcocci.mli
-OCAMLOPT  ocaml/run_ocamlcocci.ml
-OCAMLOPT  -o ocaml/ocaml.cmxa
-OCAMLC    python/pycocci_aux.mli
-OCAMLOPT  python/pycocci_aux.ml
-make -C bundles/pyml all
-make[1]: Entering directory '/home/okabe/coccinelle/bundles/pyml'
-make depend-rec
-make[2]: Entering directory '/home/okabe/coccinelle/bundles/pyml'
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I pyml-current -I +unix  -c pyml-current/pyutils.mli -o pyml-current/=
pyutils.cmi
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I pyml-current -I +unix   -c pyml-current/pyutils.ml -o pyml-current/=
pyutils.cmo
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I pyml-current -I +unix  -c pyml-current/generate.ml -o pyml-current/=
generate.cmo
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I pyml-current -I +unix   -I /home/okabe/.opam/default/lib/result res=
ult.cma stdcompat.cma unix.cma pyml-current/pyutils.cmo pyml-current/genera=
te.cmo -o pyml-current/generate
-cd pyml-current && LD_LIBRARY_PATH=3D/home/okabe/coccinelle/bundles/stdcom=
pat: ./generate
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I pyml-current -I +unix  -c pyml-current/pytypes.mli -o pyml-current/=
pytypes.cmi
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I pyml-current -I +unix  -c pyml-current/pyml_arch.mli -o pyml-curren=
t/pyml_arch.cmi
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I pyml-current -I +unix  -i pyml-current/pywrappers.ml >pyml-current/=
pywrappers.mli
-/usr/bin/ocamldep  -I pyml-current pyml-current/pyml_arch.mli pyml-current=
/pyutils.mli pyml-current/pytypes.mli pyml-current/pywrappers.mli pyml-curr=
ent/py.mli pyml-current/pycaml.mli  pyml-current/pyutils.ml pyml-current/py=
types.ml pyml-current/pywrappers.ml pyml-current/py.ml pyml-current/pycaml.=
ml    pyml-current/pywrappers.ml pyml-current/pywrappers.mli >.depend
-make[2]: Leaving directory '/home/okabe/coccinelle/bundles/pyml'
-make[2]: Entering directory '/home/okabe/coccinelle/bundles/pyml'
-gcc -E pyml-current/pyml_arch.ml.c | sed '/^#/d' >pyml-current/pyml_arch.ml
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I pyml-current -I +unix  -c pyml-current/pyml_arch.ml -o pyml-current=
/pyml_arch.cmo
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I pyml-current -I +unix   -c pyml-current/pytypes.ml -o pyml-current/=
pytypes.cmo
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I pyml-current -I +unix  -c pyml-current/pywrappers.mli -o pyml-curre=
nt/pywrappers.cmi
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I pyml-current -I +unix   -c pyml-current/pywrappers.ml -o pyml-curre=
nt/pywrappers.cmo
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I pyml-current -I +unix  -c pyml-current/py.mli -o pyml-current/py.cmi
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I pyml-current -I +unix   -c pyml-current/py.ml -o pyml-current/py.cmo
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I pyml-current -I +unix  -c pyml-current/pycaml.mli -o pyml-current/p=
ycaml.cmi
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I pyml-current -I +unix   -c pyml-current/pycaml.ml -o pyml-current/p=
ycaml.cmo
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I pyml-current -I +unix  -custom -cclib -lpyml_stubs  -a pyml-current=
/pyml_arch.cmo pyml-current/pyutils.cmo pyml-current/pytypes.cmo pyml-curre=
nt/pywrappers.cmo pyml-current/py.cmo pyml-current/pycaml.cmo -o pyml-curre=
nt/pyml.cma
-cp pyml-current/pyml.cma pyml.cma
-cp pyml-current/pywrappers.cmi pywrappers.cmi
-cp pyml-current/py.cmi py.cmi
-cp pyml-current/pycaml.cmi pycaml.cmi
-/usr/bin/ocamlc.opt -unsafe -w @42 -I /home/okabe/coccinelle/bundles/stdco=
mpat -I pyml-current -I +unix  -ccopt -I/home/okabe/coccinelle/bundles/stdc=
ompat -ccopt -fPIC pyml-current/pyml_stubs.c -o pyml-current/pyml_stubs.o
-mv pyml_stubs.o pyml-current/pyml_stubs.o
-/usr/bin/ocamlmklib -linkall  -o pyml-current/pyml_stubs pyml-current/pyml=
_stubs.o
-cp pyml-current/libpyml_stubs.a libpyml_stubs.a
-cp pyml-current/dllpyml_stubs.so dllpyml_stubs.so
-make[2]: Leaving directory '/home/okabe/coccinelle/bundles/pyml'
-make[1]: Leaving directory '/home/okabe/coccinelle/bundles/pyml'
-make -C bundles/pyml all.opt
-make[1]: Entering directory '/home/okabe/coccinelle/bundles/pyml'
-make[2]: Entering directory '/home/okabe/coccinelle/bundles/pyml'
-/usr/bin/ocamlopt.opt  -I /home/okabe/coccinelle/bundles/stdcompat -I pyml=
-current -I +unix  -c pyml-current/pyml_arch.ml -o pyml-current/pyml_arch.c=
mx
-/usr/bin/ocamlopt.opt  -I /home/okabe/coccinelle/bundles/stdcompat -I pyml=
-current -I +unix   -c pyml-current/pyutils.ml -o pyml-current/pyutils.cmx
-/usr/bin/ocamlopt.opt  -I /home/okabe/coccinelle/bundles/stdcompat -I pyml=
-current -I +unix   -c pyml-current/pytypes.ml -o pyml-current/pytypes.cmx
-/usr/bin/ocamlopt.opt  -I /home/okabe/coccinelle/bundles/stdcompat -I pyml=
-current -I +unix   -c pyml-current/pywrappers.ml -o pyml-current/pywrapper=
s.cmx
-/usr/bin/ocamlopt.opt  -I /home/okabe/coccinelle/bundles/stdcompat -I pyml=
-current -I +unix   -c pyml-current/py.ml -o pyml-current/py.cmx
-/usr/bin/ocamlopt.opt  -I /home/okabe/coccinelle/bundles/stdcompat -I pyml=
-current -I +unix   -c pyml-current/pycaml.ml -o pyml-current/pycaml.cmx
-/usr/bin/ocamlopt.opt  -I /home/okabe/coccinelle/bundles/stdcompat -I pyml=
-current -I +unix  -cclib -lpyml_stubs  -a pyml-current/pyml_arch.cmx pyml-=
current/pyutils.cmx pyml-current/pytypes.cmx pyml-current/pywrappers.cmx py=
ml-current/py.cmx pyml-current/pycaml.cmx -o pyml-current/pyml.cmxa
-cp pyml-current/pyml.cmxa pyml.cmxa
-cp pyml-current/pywrappers.cmx pywrappers.cmx
-cp pyml-current/py.cmx py.cmx
-cp pyml-current/pycaml.cmx pycaml.cmx
-cp pyml-current/pyml.a pyml.a
-make[2]: Leaving directory '/home/okabe/coccinelle/bundles/pyml'
-make[1]: Leaving directory '/home/okabe/coccinelle/bundles/pyml'
-OCAMLC    python/yes_pycocci.mli
-OCAMLOPT  python/yes_pycocci.ml
-OCAMLC    python/pycocci.mli
-OCAMLOPT  python/pycocci.ml
-OCAMLOPT  -o python/python.cmxa
-OCAMLC    engine/flag_matcher.mli
-OCAMLOPT  engine/flag_matcher.ml
-OCAMLC    engine/lib_engine.mli
-OCAMLOPT  engine/lib_engine.ml
-OCAMLC    engine/pretty_print_engine.mli
-OCAMLOPT  engine/pretty_print_engine.ml
-OCAMLC    engine/check_exhaustive_pattern.mli
-OCAMLOPT  engine/check_exhaustive_pattern.ml
-OCAMLC    engine/check_reachability.mli
-OCAMLOPT  engine/check_reachability.ml
-OCAMLC    engine/c_vs_c.mli
-OCAMLOPT  engine/c_vs_c.ml
-OCAMLC    engine/isomorphisms_c_c.mli
-OCAMLOPT  engine/isomorphisms_c_c.ml
-OCAMLC    engine/cocci_vs_c.mli
-OCAMLOPT  engine/cocci_vs_c.ml
-OCAMLC    engine/pattern_c.mli
-OCAMLOPT  engine/pattern_c.ml
-OCAMLC    engine/transformation_c.mli
-OCAMLOPT  engine/transformation_c.ml
-OCAMLC    engine/asttomember.mli
-OCAMLOPT  engine/asttomember.ml
-OCAMLC    engine/asttoctl2.mli
-OCAMLOPT  engine/asttoctl2.ml
-OCAMLC    engine/ctltotex.mli
-OCAMLOPT  engine/ctltotex.ml
-OCAMLC    engine/postprocess_transinfo.mli
-OCAMLOPT  engine/postprocess_transinfo.ml
-OCAMLC    engine/ctlcocci_integration.mli
-OCAMLOPT  engine/ctlcocci_integration.ml
-OCAMLOPT  -o engine/engine.cmxa
-OCAMLC    popl09/ast_popl.mli
-OCAMLOPT  popl09/ast_popl.ml
-OCAMLC    popl09/asttopopl.mli
-OCAMLOPT  popl09/asttopopl.ml
-OCAMLC    popl09/insert_quantifiers.mli
-OCAMLOPT  popl09/insert_quantifiers.ml
-OCAMLC    popl09/pretty_print_popl.mli
-OCAMLOPT  popl09/pretty_print_popl.ml
-OCAMLC    popl09/flag_popl.mli
-OCAMLOPT  popl09/flag_popl.ml
-OCAMLC    popl09/popltoctl.mli
-OCAMLOPT  popl09/popltoctl.ml
-OCAMLC    popl09/popl.mli
-OCAMLOPT  popl09/popl.ml
-OCAMLOPT  -o popl09/popl09.cmxa
-OCAMLC    extra/classic_patch.mli
-OCAMLOPT  extra/classic_patch.ml
-OCAMLC    extra/kbuild.mli
-OCAMLOPT  extra/kbuild.ml
-OCAMLC    extra/maintainers.mli
-OCAMLOPT  extra/maintainers.ml
-OCAMLOPT  -o extra/extra.cmxa
-OCAMLC    flag_cocci.mli
-OCAMLOPT  flag_cocci.ml
-OCAMLC    cocci.mli
-OCAMLOPT  cocci.ml
-OCAMLC    testing.mli
-OCAMLOPT  testing.ml
-OCAMLC    read_options.mli
-OCAMLOPT  read_options.ml
-OCAMLC    enter.mli
-OCAMLOPT  enter.ml
-OCAMLC    main.mli
-OCAMLOPT  main.ml
-OCAMLOPT  -o spatch.opt
-OCAMLC    tools/spgen/source/globals.mli
-OCAMLOPT  tools/spgen/source/globals.ml
-OCAMLC    tools/spgen/source/ast_tostring.mli
-OCAMLOPT  tools/spgen/source/ast_tostring.ml
-OCAMLC    tools/spgen/source/detect_patch.mli
-OCAMLOPT  tools/spgen/source/detect_patch.ml
-OCAMLC    tools/spgen/source/meta_variable.mli
-OCAMLOPT  tools/spgen/source/meta_variable.ml
-OCAMLC    tools/spgen/source/snapshot.mli
-OCAMLOPT  tools/spgen/source/snapshot.ml
-OCAMLC    tools/spgen/source/user_input.mli
-OCAMLOPT  tools/spgen/source/user_input.ml
-OCAMLC    tools/spgen/source/position_generator.mli
-OCAMLOPT  tools/spgen/source/position_generator.ml
-OCAMLC    tools/spgen/source/disj_generator.mli
-OCAMLOPT  tools/spgen/source/disj_generator.ml
-OCAMLC    tools/spgen/source/rule_body.mli
-OCAMLOPT  tools/spgen/source/rule_body.ml
-OCAMLC    tools/spgen/source/rule_header.mli
-OCAMLOPT  tools/spgen/source/rule_header.ml
-OCAMLC    tools/spgen/source/context_rule.mli
-OCAMLOPT  tools/spgen/source/context_rule.ml
-OCAMLC    tools/spgen/source/script_rule.mli
-OCAMLOPT  tools/spgen/source/script_rule.ml
-OCAMLC    tools/spgen/source/file_transform.mli
-OCAMLOPT  tools/spgen/source/file_transform.ml
-OCAMLC    tools/spgen/source/spgen_interactive.mli
-OCAMLOPT  tools/spgen/source/spgen_interactive.ml
-OCAMLC    tools/spgen/source/spgen_lexer.mli
-OCAMLOPT  tools/spgen/source/spgen_lexer.ml
-OCAMLC    tools/spgen/source/spgen_config.mli
-OCAMLOPT  tools/spgen/source/spgen_config.ml
-OCAMLC    tools/spgen/source/spgen.mli
-OCAMLOPT  tools/spgen/source/spgen.ml
-OCAMLC    tools/spgen/source/spgen_test.mli
-OCAMLOPT  tools/spgen/source/spgen_test.ml
-OCAMLC    tools/spgen/source/main.mli
-OCAMLOPT  tools/spgen/source/main.ml
-OCAMLOPT  -o tools/spgen/source/spgen.opt
-cp parsing_c/token_c.cmi ocaml/token_c.cmi
-cp parsing_c/ast_c.cmi ocaml/ast_c.cmi
-cp parsing_c/parse_c.cmi ocaml/parse_c.cmi
-cp parsing_c/parser_c.cmi ocaml/parser_c.cmi
-cp parsing_c/lexer_c.cmi ocaml/lexer_c.cmi
-cp parsing_c/pretty_print_c.cmi ocaml/pretty_print_c.cmi
-cp parsing_c/lib_parsing_c.cmi ocaml/lib_parsing_c.cmi
-cp parsing_c/visitor_c.cmi ocaml/visitor_c.cmi
-cp globals/regexp.cmi ocaml/regexp.cmi
-cp globals/config.cmi ocaml/config.cmi
-cp globals/flag.cmi ocaml/flag.cmi
-cp parsing_c/flag_parsing_c.cmi ocaml/flag_parsing_c.cmi
-cp globals/iteration.cmi ocaml/iteration.cmi
-cp commons/commands.cmi ocaml/commands.cmi
-cp commons/common.cmi ocaml/common.cmi
-cp parsing_cocci/ast_cocci.cmi ocaml/ast_cocci.cmi
-cp parsing_cocci/ast0_cocci.cmi ocaml/ast0_cocci.cmi
-cp commons/ocamlextra/dumper.cmi ocaml/dumper.cmi
-OCAMLC    parsing_c/token_c.ml
-cp parsing_c/token_c.cmo ocaml/token_c.cmo
-OCAMLC    parsing_c/ast_c.ml
-cp parsing_c/ast_c.cmo ocaml/ast_c.cmo
-OCAMLC    parsing_c/parse_c.ml
-cp parsing_c/parse_c.cmo ocaml/parse_c.cmo
-OCAMLC    parsing_c/parser_c.ml
-cp parsing_c/parser_c.cmo ocaml/parser_c.cmo
-OCAMLC    parsing_c/lexer_c.ml
-cp parsing_c/lexer_c.cmo ocaml/lexer_c.cmo
-OCAMLC    parsing_c/pretty_print_c.ml
-cp parsing_c/pretty_print_c.cmo ocaml/pretty_print_c.cmo
-OCAMLC    parsing_c/lib_parsing_c.ml
-cp parsing_c/lib_parsing_c.cmo ocaml/lib_parsing_c.cmo
-OCAMLC    parsing_c/visitor_c.ml
-cp parsing_c/visitor_c.cmo ocaml/visitor_c.cmo
-OCAMLC    globals/regexp.ml
-cp globals/regexp.cmo ocaml/regexp.cmo
-OCAMLC    globals/config.ml
-cp globals/config.cmo ocaml/config.cmo
-OCAMLC    globals/flag.ml
-cp globals/flag.cmo ocaml/flag.cmo
-OCAMLC    parsing_c/flag_parsing_c.ml
-cp parsing_c/flag_parsing_c.cmo ocaml/flag_parsing_c.cmo
-OCAMLC    globals/iteration.ml
-cp globals/iteration.cmo ocaml/iteration.cmo
-OCAMLC    commons/commands.ml
-cp commons/commands.cmo ocaml/commands.cmo
-OCAMLC    commons/common.ml
-cp commons/common.cmo ocaml/common.cmo
-OCAMLC    parsing_cocci/ast_cocci.ml
-cp parsing_cocci/ast_cocci.cmo ocaml/ast_cocci.cmo
-OCAMLC    parsing_cocci/ast0_cocci.ml
-cp parsing_cocci/ast0_cocci.cmo ocaml/ast0_cocci.cmo
-OCAMLC    commons/ocamlextra/dumper.ml
-cp commons/ocamlextra/dumper.cmo ocaml/dumper.cmo
-cp parsing_c/token_c.cmx ocaml/token_c.cmx
-cp parsing_c/ast_c.cmx ocaml/ast_c.cmx
-cp parsing_c/parse_c.cmx ocaml/parse_c.cmx
-cp parsing_c/parser_c.cmx ocaml/parser_c.cmx
-cp parsing_c/lexer_c.cmx ocaml/lexer_c.cmx
-cp parsing_c/pretty_print_c.cmx ocaml/pretty_print_c.cmx
-cp parsing_c/lib_parsing_c.cmx ocaml/lib_parsing_c.cmx
-cp parsing_c/visitor_c.cmx ocaml/visitor_c.cmx
-cp globals/regexp.cmx ocaml/regexp.cmx
-cp globals/config.cmx ocaml/config.cmx
-cp globals/flag.cmx ocaml/flag.cmx
-cp parsing_c/flag_parsing_c.cmx ocaml/flag_parsing_c.cmx
-cp globals/iteration.cmx ocaml/iteration.cmx
-cp commons/commands.cmx ocaml/commands.cmx
-cp commons/common.cmx ocaml/common.cmx
-cp parsing_cocci/ast_cocci.cmx ocaml/ast_cocci.cmx
-cp parsing_cocci/ast0_cocci.cmx ocaml/ast0_cocci.cmx
-cp commons/ocamlextra/dumper.cmx ocaml/dumper.cmx
-cp /home/okabe/coccinelle/bundles/parmap/parmap.cmi ocaml/parmap.cmi
-if test -f /home/okabe/coccinelle/bundles/parmap/parmap.cmx; then \
-	cp /home/okabe/coccinelle/bundles/parmap/parmap.cmx ocaml/parmap.cmx; \
-fi

base-commit: d9064ec494fa1572abc4b1e26984246ce902b7aa
