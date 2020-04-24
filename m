Return-Path: <SRS0=cw0N=6I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71215C55194
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:18:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C5620724
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tuBh/zCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C5620724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03O9IiNS026596;
	Fri, 24 Apr 2020 11:18:44 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 784FD7827;
	Fri, 24 Apr 2020 11:18:44 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A45717815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:18:42 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03O9IeKJ000197
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:18:41 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id g2so3536733plo.3
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 02:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6XBHD63aqXEwnWVqUZFm4dZkI8++//l/bmx4QlYKk4A=;
 b=tuBh/zCO6Y5ell5682/HmQmdBOCUBIH1kRLxYvV46GoCvTscljl3UBEz++PNDL5zHY
 H0Bf2ENZ6EAuofqPe/qoUfJSCWmWhc9llxxY/ZM6CWZxuQ92EkvAvLOY1EJ14LspvC0Q
 xs278w3dKBbyyy2i+RhqOF26YdJFnFkpwb5+GAQBQAwTbVJhchRYftyWiyeBS+pzytKJ
 5YZYIpnijKyhxBtwSc/gf4XSeWpjAD/5jAodvqUfEqLi1e9ipbSDj4s3AvHEGbsaewrE
 Yqxuqv+mPjUbYBGXJoITR2P5eS8+my0DfkyMCaqnJWyk/HxryRJ5RP2ri+wccBSm4rbW
 YAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6XBHD63aqXEwnWVqUZFm4dZkI8++//l/bmx4QlYKk4A=;
 b=AadnKDivmkbZM5TIvWmr9ly8D9SlBznL5FXyeuVzA9lxK0JtRPXfrz+8jaUi9dJLGS
 8oAGpgxfNCZuKKyghg673cS94tiaESCJBi4JyrATGZSpcLHrXsj1tHYUXryYWly30Qat
 G0OOh4y5OY+IH+06/CYE7PBr4IwxyZxiIytG0eLKyzonjjxbpVMSiijUCn0E6oEiN2/0
 knF6gi/WYJWGD+8hJs62X4eehKdYJMRJf+P102/F1OBQBuEMngbKUbXw6VMw8hW6CA0M
 C6afrAZWe/ENAyDDmWkc5hSfGDQYQkmuOUtYYhbTnYl+TRKe5LxI7hNGkaZES6mR2dPZ
 EnCQ==
X-Gm-Message-State: AGi0PuZDPPSWD2LuEpiCjKBToR3zrtVHcdJCzMz2sXrSsEqnKF66GbIx
 jXUREb9TD+R9wxTMJnD4wuHVvTNPOQM=
X-Google-Smtp-Source: APiQypLKon+9FsdzguRzip1t5PHqEXcXx56b81TFdtClkP/lbDR68jraNp4jchX4YZcX5d2KEoDR8Q==
X-Received: by 2002:a17:90a:b293:: with SMTP id
 c19mr5196698pjr.22.1587719920004; 
 Fri, 24 Apr 2020 02:18:40 -0700 (PDT)
Received: from localhost.localdomain ([1.38.216.60])
 by smtp.gmail.com with ESMTPSA id c80sm5043933pfb.82.2020.04.24.02.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 02:18:39 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 24 Apr 2020 14:47:42 +0530
Message-Id: <20200424091801.13871-7-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
References: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 11:18:44 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 24 Apr 2020 11:18:42 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [RFC PATCH 06/25] parsing_c: parser: Add attribute
	production in spec_qualif_list
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

As per GCC's C grammar, the specifier-qualifier-list has the following
production:

	specifier-qualifier-list:
	  gnu-attributes specifier-qualifier-list[opt]

Add this production to the spec_qualif_list rule of Coccinelle's C
parser. This parses attributes in struct fields and casts
successfully. Some code examples from Linux v5.5-rc4:

  kernel/rcu/tree.h:

	struct rcu_node {
		...
		raw_spinlock_t __private lock;
		...
	};

  kernel/sysctl.c:

 	char __user **buffer = (char __user **)buf;

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parser_c.mly | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index a858db56..a5b0d214 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -1500,10 +1500,12 @@ abstract_declaratorp:
 /*(* for struct and also typename *)*/
 /*(* can't put decl_spec cos no storage is allowed for field struct *)*/
 spec_qualif_list2:
- | type_spec                    { addTypeD ($1, nullDecl) }
- | type_qualif                  { {nullDecl with qualifD = (fst $1,[snd $1])}}
- | type_spec   spec_qualif_list { addTypeD ($1,$2)   }
- | type_qualif spec_qualif_list { addQualifD ($1,$2) }
+ | type_spec                    { ([], addTypeD ($1, nullDecl)) }
+ | type_qualif                  { ([], {nullDecl with qualifD = (fst $1,[snd $1])})}
+ | attribute                    { ([$1], nullDecl) }
+ | type_spec   spec_qualif_list { (fst $2, addTypeD ($1,snd $2)) }
+ | type_qualif spec_qualif_list { (fst $2, addQualifD ($1,snd $2)) }
+ | attribute   spec_qualif_list { ([$1]@(fst $2), snd $2) }
 
 spec_qualif_list: spec_qualif_list2            {  dt "spec_qualif" (); $1 }
 
@@ -1521,9 +1523,13 @@ type_qualif_list:
 
 type_name:
  | spec_qualif_list
-     { let (returnType, _) = fixDeclSpecForDecl $1 in  returnType }
+     { let (attrs, ds) = $1 in
+       let (returnType, _) = fixDeclSpecForDecl ds in returnType }
  | spec_qualif_list abstract_declaratort
-     { let (returnType, _) = fixDeclSpecForDecl $1 in $2 returnType }
+     { let (attrs1, ds) = $1 in
+       let (attrs2, fn) = $2 in
+       let (returnType, _) = fixDeclSpecForDecl ds in
+       fn returnType }
 
 
 
@@ -1808,7 +1814,8 @@ struct_decl2:
 field_declaration:
  | spec_qualif_list struct_declarator_list TPtVirg
      {
-       let (returnType,storage) = fixDeclSpecForDecl $1 in
+       let (attrs, ds) = $1 in
+       let (returnType,storage) = fixDeclSpecForDecl ds in
        if fst (unwrap storage) <> NoSto
        then internal_error "parsing don't allow this";
 
@@ -1823,8 +1830,9 @@ field_declaration:
 
  | spec_qualif_list TPtVirg
      {
+       let (attrs, ds) = $1 in
        (* gccext: allow empty elements if it is a structdef or enumdef *)
-       let (returnType,storage) = fixDeclSpecForDecl $1 in
+       let (returnType,storage) = fixDeclSpecForDecl ds in
        if fst (unwrap storage) <> NoSto
        then internal_error "parsing don't allow this";
 
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
