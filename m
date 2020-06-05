Return-Path: <SRS0=TTUf=7S=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81640C433E0
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00EA206E6
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axdlCXXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00EA206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 055Di20p027079;
	Fri, 5 Jun 2020 15:44:02 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2E6027567;
	Fri,  5 Jun 2020 15:44:02 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 714DB3F9A
 for <cocci@systeme.lip6.fr>; Fri,  5 Jun 2020 15:44:00 +0200 (CEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:443])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 055Dhw6O028348
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 5 Jun 2020 15:43:59 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id h185so4937910pfg.2
 for <cocci@systeme.lip6.fr>; Fri, 05 Jun 2020 06:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nV3qp30vahdf2LjeklPIogPl2PZxLdKOXkcxwb0UmnA=;
 b=axdlCXXW9/5zrn0y7ORU0ObS87xrTBaESr0GZK0YH1jZLyTFGYorbc2YIYia57rl6w
 hXC2gqmLiAAISp8qHPtjieZALtZstvggXa6+bt2pFnjsaHAYebGEcN3GX4IGUM1jkSCR
 wNceL+1Cg3jnXD8CMVmtfSlD2fHQQ0x6DHO3wZCMDzcoMj2tKULjU+DrS+PvzO42SN8a
 pX2PKv/fg24y3E8XFA15wfKMybM+peRflLIc5fHXydJ7HaRJajz6LjvK6TIAATkHXbwa
 igl1/UNFaxvGHYkmGoFT32XZ/p57A8LNe3V1r08LYQiUWgJ5c8ZvQxTaDOtoF75SJH/Y
 PXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nV3qp30vahdf2LjeklPIogPl2PZxLdKOXkcxwb0UmnA=;
 b=jqEr9Wo2e4ekNanKXqEOVfQNHYrS7aLtn0wJXffa/50pVkQ2XMES69YTI0e3psq4m5
 KtRjKKHrkdLKgShaf+OjBFetUhqMy+AdvjcCL8L67C+3gQ9GkuL3YM5SERF7At/7LUC3
 OcSshkuT1t5KgLFd0Fo4RJroEPI0JsM3xF+RExY6NZhLMRy9rHmzQ7ugAs37h40mLVQn
 rohzIYJ8fhNl1WwsOhvB5hklAvwqRtU34gYanmWxvn4wA3YqIKzkci3XPBfcfbeJsNV2
 4dNnhGQ8oeXIsbn91M4co8lxJA+fhLpJqt+fMCXq/gjCxcezokmkRiTGDqVBwA5bQnmn
 XTqw==
X-Gm-Message-State: AOAM531koO/T5xL8Dv3g2KqGTyqSfKvnfUYAk6tkUIL+fx8DAn/w0IYQ
 dQ2m0suGu44rxzdjuP+ZF+Zu0GLEQ5c=
X-Google-Smtp-Source: ABdhPJwy0Ssw0P1Oa6CD+e9LwW25jPbZ00JuOZBceYXoEVLUHQ94zaqFG1k9Dm8OeNtEOkz8ZWFxMQ==
X-Received: by 2002:a62:7547:: with SMTP id q68mr10064038pfc.202.1591364637251; 
 Fri, 05 Jun 2020 06:43:57 -0700 (PDT)
Received: from localhost.localdomain ([1.38.221.125])
 by smtp.gmail.com with ESMTPSA id w186sm7861353pff.83.2020.06.05.06.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 06:43:54 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri,  5 Jun 2020 19:13:08 +0530
Message-Id: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jun 2020 15:44:02 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 05 Jun 2020 15:43:59 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v4 00/14] cocci: Improve C parsing of attributes
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

What this patch series does not do:
- Add attributes from all the new productions into the C AST. Some of
  these are dropped.
- Reflect changes from the C parser in the SmPL parser.

Separate patches will be sent for the above.


Changes in v4:
-------------
Remove the following patches from the series and add/merge them to [1].
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

parsing_c: parser: Add rule for optional end attributes
- Add to series.

parsing_c: parser: Add field declaration end attributes production
- Use end_attributes_opt to avoid duplicate code.

parsing_c: parser: Handle struct/union/enum end attributes
- Use end_attributes_opt to avoid duplicate code.

parsing_c: parser: Add MacroDecl end attributes production
- Use end_attributes_opt to avoid duplicate code.

parsing_c: parser: cpp_other end attributes production
- Use end_attributes_opt to avoid duplicate code.


Changes in v3:
-------------
parsing_c: parser: Place parameter attributes in C AST
- Remove the "attr is ignored" comments in the declaratorp rule.
- Place the attributes from the "declarator attributes" production
  in the declaratorp rule in the C AST as well.


Changes in v2:
--------------
parsing_c: parser: Add attribute production in spec_qualif_list
- This patch applied on its own causes a build error. Fix the error by
  removing the let binding for abstract_declaratort in the type_name
  rule

parsing_c: parser: Make abstract_declarator pass attributes
- Reflect changes from the above build error fix.


Jaskaran Singh (14):
      parsing_c: parse_c: Ignore TMacroAttr and TMacroEndAttr in passed tokens
      parsing_c: parsing_hacks: Label end attributes correctly
      parsing_c: parsing_hacks: Commentize attributes before qualif/type
      parsing_c: parser: Add rule for multiple end attributes
      parsing_c: parser: Add expression statement attributes
      parsing_c: parser: Add rule for optional end attributes
      parsing_c: parser: Add attribute production in spec_qualif_list
      parsing_c: parser: Add init_declarator_attrs rule
      parsing_c: parser: Add field declaration end attributes production
      parsing_c: parser: Handle struct/union/enum end attributes
      parsing_c: parser: Add MacroDecl end attributes production
      parsing_c: parser: cpp_other end attributes production
      parsing_c: cpp_token_c: Introduce MACROANNOTATION hint
      cocci: standard.h: Annotate attributes with MACROANNOTATION

 parsing_c/cpp_token_c.ml   |    2 
 parsing_c/parse_c.ml       |    4 +
 parsing_c/parser_c.mly     |   91 ++++++++++++++++++++++++-----------
 parsing_c/parsing_hacks.ml |   37 ++++++++++++++
 standard.h                 |  116 ++++++++++++++++++++++-----------------------
 5 files changed, 164 insertions(+), 86 deletions(-)


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
