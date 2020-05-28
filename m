Return-Path: <SRS0=FJ6B=7K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8724AC433E2
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:24:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27BC920888
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRLzrzce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BC920888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04SCOiZx006084;
	Thu, 28 May 2020 14:24:44 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CBB105D47;
	Thu, 28 May 2020 14:24:44 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id ACA5F3E1D
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:24:42 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04SCOe7S010671
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:24:41 +0200 (CEST)
Received: by mail-pj1-x1042.google.com with SMTP id fs4so3123561pjb.5
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 05:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rfmM+o3uGsfuHWt/WmDvmLX4T2GMeLI2uihv1+F33Jw=;
 b=WRLzrzceTeQ87f3qPn6HPnnsBo3e9FkUvDduuZOd27s8zVFhEJQNp0mqH6KUk34hLA
 TiMeuB9ftkp/BbyzNR1342NvFQUnvAC86vZrUaywSuYmVHnO1/RLURhmjn6iT7hE5ODN
 VagexZMJf6KqY7bOjhE62zPGH3rizNKIrzDpWM2FqfaP6TCU1PBp8hnRqGSxMe6ENBSE
 lLXLB74L22Jq2Dm8IMVJYF1Sjsw7WHSqqZAnEbOeaeNKS8FCnTRc1Osnp6uPaEga4z8F
 4H02IEEirtctOGcFQYojink8OoDLmTfJmJ+jETG8G+DNYHrNdlLXDUYcWlO5Og+Z4Rna
 h0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rfmM+o3uGsfuHWt/WmDvmLX4T2GMeLI2uihv1+F33Jw=;
 b=SEUuCh70kLXlA2NjAyLnRewYb9F6hY+kctZU6MVc7UI7G+VOXx4SGfJdU0Eq8XsKlp
 vgCh+6e/SHLRvKvQpbBWmtAWPF7Mb+8EOunklZioUofkBHb9EpPtFEFjh+wyxPkla7PP
 WCP3TTFJjX69bp+sLYUtj0gZ656Ogc4uJHBwhqsxm1TdvB7A50JUBnpHR0eooMYE4ca3
 Z9CsGEZ+mvIabY97aCCgDfaVWE5pkJdY6901wNM1wG0qnJ8w8vDskRyJ9JiDu+3HHHHe
 amn8bIJYNUO7IgdSP+9iYhsqN6OWiZ/LfH/WS2lYOpAk7OgJ6/lWp/T21Sq2CJxqcSW9
 nHOQ==
X-Gm-Message-State: AOAM532nBXYgTAwPLOrDx2q+7l2MfqGIuNOXPmmexedgBnTIDW5LIhIL
 c0b8VnAubEeNDZyGC9+6tD9R3RG9
X-Google-Smtp-Source: ABdhPJxltKMjmUkL/+//9TzppQ/LI/iZPFYiVU+D80x7Ryn1lsrdgzrqX7QhKuUu/MUzT8QB8YJ17A==
X-Received: by 2002:a17:90b:4c47:: with SMTP id
 np7mr3624534pjb.101.1590668679717; 
 Thu, 28 May 2020 05:24:39 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2183:e360:deba:7bf4:98ef:5568])
 by smtp.gmail.com with ESMTPSA id 1sm5722888pje.26.2020.05.28.05.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 05:24:39 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 28 May 2020 17:54:02 +0530
Message-Id: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 May 2020 14:24:45 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 May 2020 14:24:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 00/25] cocci: Improve C parsing of attributes
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

These parsing errors were discovered by running a build of Coccinelle's
master branch on gitlab to parse the source code of Linux v5.5-rc4 and Linux
v5.6-rc7. Coccinelle currently manages attributes similar to comments, so
to explicity state what the attributes are to the C parser, a
MACROANNOTATION hint was used in Coccinelle's standard.h file. The hint
enables the parser to correctly identify attributes, and thus potentially
handle them differently in the AST.

Upon collection of these parsing errors, The GNU C Compiler's
grammar was taken as a reference for introducing attributes in correct
places in Coccinelle's C parser.

Upon applying the MACROANNOTATION hint to a majority of the attributes in
Coccinelle's standard.h file and parsing the source code of Linux
v5.6-rc7, the difference between the stats (of --parse-c) before and
after applying this patch series are as follows:

Before:

        NB total files = 28268; perfect = 25697; pbs = 2570; timeout = 0; =========> 90%
        nb good = 19160664,  nb passed = 135235 =========> 0.70% passed
        nb good = 19160664,  nb bad = 129685 =========> 99.33% good or passed

After:

        NB total files = 28268; perfect = 25699; pbs = 2568; timeout = 0; =========> 90%
        nb good = 19160856,  nb passed = 71716 =========> 0.37% passed
        nb good = 19160856,  nb bad = 129493 =========> 99.33% good or passed

Fixes for a few test case failures that arise from applying the new
productions are also included. The test cases that failed were:

        unstruct
        nocast

What this patch series does not do:
- Add attributes from all the new productions into the C AST. Some of
  these are dropped.
- Reflect changes from the C parser in the SmPL parser.

Separate patches will be sent for the above.


Changes in v2:
--------------
parsing_c: parser: Add attribute production in spec_qualif_list
- This patch applied on its own causes a build error. Fix the error by
  removing the let binding for abstract_declaratort in the type_name
  rule

parsing_c: parser: Make abstract_declarator pass attributes
- Reflect changes from the above build error fix.


Jaskaran Singh (25):
      parsing_c: parse_c: Ignore TMacroAttr and TMacroEndAttr in passed tokens
      parsing_c: parsing_hacks: Label end attributes correctly
      parsing_c: parsing_hacks: Commentize attributes before qualif/type
      parsing_c: parser: Add rule for multiple end attributes
      parsing_c: parser: Add expression statement attributes
      parsing_c: parser: Add attribute production in spec_qualif_list
      parsing_c: parser: Add init_declarator_attrs rule
      parsing_c: parser: Add field declaration end attributes production
      parsing_c: parser: Handle struct/union/enum end attributes
      parsing_c: parser: Add MacroDecl end attributes production
      parsing_c: parser: cpp_other end attributes production
      parsing_c: cpp_token_c: Introduce MACROANNOTATION hint
      cocci: standard.h: Annotate attributes with MACROANNOTATION
      parsing_c: visitor_c: Add vk_attribute and vk_attribute_s
      parsing_c: lib_parsing_c: Add ii_of_attr
      engine: Add distrf_attr to PARAM functor
      engine: cocci_vs_c: Add allminus argument to attribute_list
      parsing_c: parser: Make abstract_declarator pass attributes
      cocci: Add parameter attributes to C AST
      parsing_c: parser: Place parameter attributes in C AST
      parsing_c: visitor_c: Visit parameter attributes
      parsing_c: unparse_hrule: Add parameter attributes in record
      parsing_c: type_c: Add parameter attributes to record
      engine: cocci_vs_c: "Match" parameter attributes
      engine: c_vs_c: Match parameter attributes


 engine/c_vs_c.ml            |   12 ++-
 engine/cocci_vs_c.ml        |   85 +++++++++++++++++-----
 engine/cocci_vs_c.mli       |    3 
 engine/pattern_c.ml         |    1 
 engine/transformation_c.ml  |    5 +
 ocaml/coccilib.mli          |    1 
 parsing_c/ast_c.ml          |    1 
 parsing_c/ast_c.mli         |    1 
 parsing_c/cpp_token_c.ml    |    2 
 parsing_c/lib_parsing_c.ml  |    1 
 parsing_c/lib_parsing_c.mli |    1 
 parsing_c/parse_c.ml        |    4 -
 parsing_c/parser_c.mly      |  167 +++++++++++++++++++++++++++++++++++++-------
 parsing_c/parsing_hacks.ml  |   37 +++++++++
 parsing_c/type_c.ml         |    1 
 parsing_c/unparse_hrule.ml  |    3 
 parsing_c/visitor_c.ml      |    7 +
 parsing_c/visitor_c.mli     |    3 
 standard.h                  |  116 +++++++++++++++---------------
 19 files changed, 343 insertions(+), 108 deletions(-)



_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
