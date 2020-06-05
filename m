Return-Path: <SRS0=TTUf=7S=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB3EC433DF
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ABDC206E6
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hM/8gCUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABDC206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 055DiVgW023099;
	Fri, 5 Jun 2020 15:44:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7EE7B7567;
	Fri,  5 Jun 2020 15:44:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1CD923F9A
 for <cocci@systeme.lip6.fr>; Fri,  5 Jun 2020 15:44:30 +0200 (CEST)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 055DiSQh016821
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 5 Jun 2020 15:44:29 +0200 (CEST)
Received: by mail-pj1-x1041.google.com with SMTP id s88so2753296pjb.5
 for <cocci@systeme.lip6.fr>; Fri, 05 Jun 2020 06:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3CR1z9NG03ePu7G+tgZJY9zyBtNaGEunTpnX9HF6W0s=;
 b=hM/8gCULjRc+sV7QL80KfOKcw7rz7EgJZSm2W9pksCmGcaKh6uZTSS1BosotoK5waM
 gs4G1OMr8Uscj1tdALlND9FrR0wN12y5OiDs0nMGnbkobAfNPCbhvH2kjfteWcvd5Q0R
 ZA45CMsWszdwcT3meZnArs20YYo3qymavY2bOmZonTlYuuUYlH4Wx71T3yghRpQaupuF
 rKQ2mFgez5UaZNot8ENuKd5T5bH1XglPg2TBRttLwXlmQfhbJBSq7W9SFJ6hSe/W/m2U
 DxrqhGk8jVb7Y11MhUBWfb8cnwEPuIj1dX0oGkOBl4SVctHkzW41I45QaeM/xHm4MnIT
 WSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3CR1z9NG03ePu7G+tgZJY9zyBtNaGEunTpnX9HF6W0s=;
 b=qPxs1VXAJCLnwkYYBwugAjvDiRzXcHiWqAeSt3lbknJn/rsFgMPF6fZb5Bh9e4QDgq
 mulIQccmE0++yT+TRVOuQKQnNTq7tw5lvvCe8wRNi3vjUyJbkAVEK6hRLtA3zkTkJR+N
 9o2XM3eolppYTthHKtHqdCNCt3NZ6s31DU3u4brvrtgnacgt01CzVJYqBxZVHPCNELiB
 M39e0wltqe09afEVibQ+pJakm8I7jKIPCh9BNfe4x06V4J3GOEoaUtbcInkEq6XNvdiv
 vmdTLyKgcOKE7/UbyFyWShpVEDjyS58WUhHPLjlBRB0fL9J7vDpDVjOMvy75Bhi+BJti
 D0Ug==
X-Gm-Message-State: AOAM532LOg6Y2o95qz7PosaPZcq9jNwcpOXk01DlAzHk/TW5uU4CtXQK
 R5wZ0iA3UOsq6i5KqyRUSiaW514oi18=
X-Google-Smtp-Source: ABdhPJzawQgtI/bL3wpRFIIiWFWNvd0iItEBFiMnVmNkF+J4mJL93eUnPCYffGwMliByLwGtEaAOCw==
X-Received: by 2002:a17:90b:193:: with SMTP id
 t19mr3149586pjs.155.1591364667424; 
 Fri, 05 Jun 2020 06:44:27 -0700 (PDT)
Received: from localhost.localdomain ([1.38.221.125])
 by smtp.gmail.com with ESMTPSA id w186sm7861353pff.83.2020.06.05.06.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 06:44:27 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri,  5 Jun 2020 19:13:15 +0530
Message-Id: <20200605134322.15307-8-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
References: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jun 2020 15:44:31 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 05 Jun 2020 15:44:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v4 07/14] parsing_c: parser: Add attribute
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
 parsing_c/parser_c.mly | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index 443ac59f..d24ab7b8 100644
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
 
@@ -1521,9 +1523,12 @@ type_qualif_list:
 
 type_name:
  | spec_qualif_list
-     { let (returnType, _) = fixDeclSpecForDecl $1 in  returnType }
+     { let (attrs, ds) = $1 in
+       let (returnType, _) = fixDeclSpecForDecl ds in returnType }
  | spec_qualif_list abstract_declaratort
-     { let (returnType, _) = fixDeclSpecForDecl $1 in $2 returnType }
+     { let (attrs1, ds) = $1 in
+       let (returnType, _) = fixDeclSpecForDecl ds in
+       $2 returnType }
 
 
 
@@ -1808,7 +1813,8 @@ struct_decl2:
 field_declaration:
  | spec_qualif_list struct_declarator_list TPtVirg
      {
-       let (returnType,storage) = fixDeclSpecForDecl $1 in
+       let (attrs, ds) = $1 in
+       let (returnType,storage) = fixDeclSpecForDecl ds in
        if fst (unwrap storage) <> NoSto
        then internal_error "parsing don't allow this";
 
@@ -1823,8 +1829,9 @@ field_declaration:
 
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
