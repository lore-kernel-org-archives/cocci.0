Return-Path: <SRS0=FJ6B=7K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC16C433E0
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:25:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F35C820888
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sl2lFvU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35C820888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04SCP6tn015682;
	Thu, 28 May 2020 14:25:06 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 59FB85D47;
	Thu, 28 May 2020 14:25:06 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 758BA3E1D
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:25:04 +0200 (CEST)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04SCP2FN015788
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:25:03 +0200 (CEST)
Received: by mail-pg1-x542.google.com with SMTP id c75so13417404pga.3
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 05:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cjt6sxZFmRYyDn89xbKCN5jJbQoWEaF9AKdC/CvYNgE=;
 b=Sl2lFvU1EF5IQPx+NJykkz/nWmDFUW3kCDTWKJTZDXjVlJeFZC6LdHEeY0+9+dFPyH
 DfV+cDpocKP8gMdoccnsuYEwX+/iQKjdw7ADAv8yzhYQFqJ31C+OKXo9pccHnHtZxZQu
 7qhsetu4P6hy6lNTF5PXTXTM4tCtZRqJarPZK49WhbwSzlcFr+NJmm10si/O4KBhyW03
 OKQQsWQFGyddsiljz8jl7JDoqqP1LkXyo6Pd9/vHnPYjUMFtaT6EdlwQt0U0An02sSA2
 E5tU/cSh+sBzB6LtmMi92o6BtOawPNPZij4cVH3DQhjJjJRnGDDecs3FQmYCLylK6KRr
 Ab4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cjt6sxZFmRYyDn89xbKCN5jJbQoWEaF9AKdC/CvYNgE=;
 b=baGOYKrtEUrLkUwiPehKayzRGiGkrC+JsJ03fwG1Hg/qRRvh36PU93opAdxW71mxfe
 FBStGydVo6LUjERx95gJRiV5ubbuJ5ILo4Jd4UMPsEH2owBpiaVy/X2+ZZFcZypoFGRq
 8LYVbrDLd0DE9SlwyySoQ98T8f5z6dLfwX6lOaQrRdkkhAzQZxzKvpand/Bdu/Rbw1cM
 hlRuaibiDcqIRiOkiUPfq/So9Uvfn0ynz1zs1+Q+e5SQI0LQNnliZwMQrip3gkz9JD5j
 rd8d1vCNYk6gBYHmLZ8Dr7OZ4GSZKS5jP4wvO9PBZ+csIGoBZFAM3NDdFXeGlmmWGOrk
 tq2w==
X-Gm-Message-State: AOAM531X3/b/0js0GOwNpUqwlQxRjYGjqrKc0bKkUH0S1e2sSyvKJ5iE
 2iADYKeHAaKoUOI6EIrli7Q4A2tN
X-Google-Smtp-Source: ABdhPJwtJit18e2FTsW10sv7UbzEbj6s1sQf6/Vq5tVu2h3eUm6RW1VJ/A6bYzL1KfiPzKH/FCo7Mg==
X-Received: by 2002:a62:1a91:: with SMTP id a139mr1225568pfa.149.1590668701769; 
 Thu, 28 May 2020 05:25:01 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2183:e360:deba:7bf4:98ef:5568])
 by smtp.gmail.com with ESMTPSA id 1sm5722888pje.26.2020.05.28.05.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 05:25:01 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 28 May 2020 17:54:08 +0530
Message-Id: <20200528122428.4212-7-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
References: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 May 2020 14:25:06 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 May 2020 14:25:03 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 06/25] parsing_c: parser: Add attribute
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
index e4352a61..be3fdbab 100644
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
