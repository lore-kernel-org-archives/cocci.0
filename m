Return-Path: <SRS0=cw0N=6I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30606C2BA1A
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:18:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE2620724
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9KmnucB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE2620724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03O9IKpd009574;
	Fri, 24 Apr 2020 11:18:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 90CFE7827;
	Fri, 24 Apr 2020 11:18:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7EDCE7815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:18:19 +0200 (CEST)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:444])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03O9IHvq003770
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:18:18 +0200 (CEST)
Received: by mail-pf1-x444.google.com with SMTP id r14so4530078pfg.2
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 02:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=T+uEhCoDVXUbYJvl23b4BPrGVZkGHC3ELQ4hh35XM+g=;
 b=O9KmnucBbILyIGXIRpzcrKONHuWaDu+Pd4px8G084uU12bwIVofFQXOyoH/a6rTGzA
 movAMzECa5G2ncLahh7HYmbnMrO5gct84+AjaMRVSfvBIP3B+5TjQq7K7O+kDCpduXdT
 VNJSbv44MU+R9TUD9BCQeg9IRvcUh4iUs8hoeb2yJG1GoMe0EgynyLUypAw4d3dQiDrS
 J4XoECdk05BfGHqIiDrufyC2s3PRdPBWmgYfNbDsap0hAf4QaUMb5pRboqXclvcKtkAS
 SZfeLNf7RzcuhyInS4rIBj04y/5peIQsSp3/SosaXNT3Nw5sAgMUWNDNyQxjx3hSNyS2
 AgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=T+uEhCoDVXUbYJvl23b4BPrGVZkGHC3ELQ4hh35XM+g=;
 b=HNt/rTkTzEuJp6DvImaCEu46p/8i/swZEU1QtNDkbxHv/hFsiD/8WAMNU+/OvG+FSC
 a61ogxGswETXHMXeeLREQOH9apLlUh7vGy063JNYifL/r506xn3VvYdwbnOcHk2MJGfi
 XnImt5yyjYL6lW8zl05Z8nAJR0c2Yu3l91KBT0gRnd1Z1RVFSQopbiWjVDVamNwmtOHM
 HBkqUpXTPqWm8+Q8cho/i+e0bBbd/8djj39qMg3h4SDeOHUlXdpg4k/ekaGeihjFr01M
 6duqvr+0kWKiqEC+R2PIC06Qb9U2xUHxkwDJjqjX0ulxVs2K2UH8uq9vo1d1MvjW8Iz1
 IbMA==
X-Gm-Message-State: AGi0PuYL8QyE4UHmBQa8ebkfBokhL7QiCwqUL+MFOb+D/TdpunSgzKJn
 eiIOog2dWy9YoG4EkFms/oi/g2cULNs=
X-Google-Smtp-Source: APiQypKbjGOz5ss+Zxtgd9ipX9zXCwbvViwozLH8P/3+9KxNsb5We2Mslqc6nYQbEReUn/Pv07bFIw==
X-Received: by 2002:a63:190a:: with SMTP id z10mr7906814pgl.331.1587719896438; 
 Fri, 24 Apr 2020 02:18:16 -0700 (PDT)
Received: from localhost.localdomain ([1.38.216.60])
 by smtp.gmail.com with ESMTPSA id c80sm5043933pfb.82.2020.04.24.02.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 02:18:16 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 24 Apr 2020 14:47:36 +0530
Message-Id: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 11:18:21 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 24 Apr 2020 11:18:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [RFC PATCH 00/25] cocci: Improve C parsing of attributes
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

This patch series aims to improve parsing of attributes in C by
Coccinelle's C parser.

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
 parsing_c/parser_c.mly      |  165 +++++++++++++++++++++++++++++++++++++-------
 parsing_c/parsing_hacks.ml  |   37 +++++++++
 parsing_c/type_c.ml         |    1 
 parsing_c/unparse_hrule.ml  |    3 
 parsing_c/visitor_c.ml      |    7 +
 parsing_c/visitor_c.mli     |    3 
 standard.h                  |  116 +++++++++++++++---------------
 19 files changed, 342 insertions(+), 107 deletions(-)



_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
