Return-Path: <SRS0=02ua=7V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9610C433E0
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 12:21:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 679972074B
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 12:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmyXdexq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679972074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 058CKx1V002065;
	Mon, 8 Jun 2020 14:20:59 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 986297783;
	Mon,  8 Jun 2020 14:20:59 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B902A44A7
 for <cocci@systeme.lip6.fr>; Mon,  8 Jun 2020 14:20:58 +0200 (CEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:543])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 058CKvve013292
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 8 Jun 2020 14:20:58 +0200 (CEST)
Received: by mail-pg1-x543.google.com with SMTP id p21so8639270pgm.13
 for <cocci@systeme.lip6.fr>; Mon, 08 Jun 2020 05:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L/H5sSIkBx5Y4W3AtTFGNRoAgrU9OF5ws+/F7pPa0MY=;
 b=cmyXdexqZt9rkg0j348JxK4c4A5fyAA61j+DDlsRKm8yxsOtiP4Df3aKSgWpgLaIJ6
 5L5lBlsbeVPqP7KpB8GNeNUiH2BVeD79DL2cv5B+bF+sO9IQJf/SKI/99Kkl+1Xcq99D
 5XFHtX/UOca1elJYr/FQbKvlPWBsCB9b3gsMcdvCSgaRKZ5gbLn+x+nfI4ERs2RC0SrC
 94T06KQNI84ujuJ5gelkyX7Ukm/B3Fl/YBNoSc7Vo+p6A02psGyJUgjfMQ8MwrOwFmGK
 C4EbDXAY0LGKaxBaBC+jw5NEvtfSj9QSdGlf9ydiM8qsCdVecN07mvo6lADhjFsSG3Iy
 roiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L/H5sSIkBx5Y4W3AtTFGNRoAgrU9OF5ws+/F7pPa0MY=;
 b=EMAT9HVmyZE7zAwq826NIi+AsEM3A+sKyIZBbvnYLMRRywIeY8qeT3p6diontPTZxH
 aH5MtbexAtxhC/V4odEyXXQV7XVwFuZ4vhkXMnYN0St4P6ASkM3YrKWsUcws8hvZB1VO
 rTRk4QFXlkLYWh1NxdX7yLxixqKxAwVo7XlFL71NH7Q56DJpQm7S3pee7Dep53H0U92Z
 /plPdcl+G30o8v3DZkE8MY5rJJPoT6avsF111flYSAREiLr5nKIONdHB2hdRh2lB1Z1Y
 DsjxoY4U19KfcgYMzqJiNVXrxTeT2pPo9D9DY00jie7O7jn8M86r14yXT1vS1dYL1VBx
 gMPQ==
X-Gm-Message-State: AOAM531lvT781lwPAZIn9xAhwRNa41vRchmACoBeZl+BzS9GBcZtRc6V
 JbIbYH+I4sXmHcfbaZr4fsCu2e68
X-Google-Smtp-Source: ABdhPJzBKegCFSi+SBUtxlKSLwIAm2M5WoebWgD0fHEa/GhC3iQVspBYLehR8VsQIJJP1HxRYEQixg==
X-Received: by 2002:a63:36ca:: with SMTP id
 d193mr19752761pga.253.1591618856364; 
 Mon, 08 Jun 2020 05:20:56 -0700 (PDT)
Received: from localhost.localdomain
 ([2402:3a80:1863:7add:d8e9:7114:e8b0:51a9])
 by smtp.gmail.com with ESMTPSA id i5sm15747657pjd.23.2020.06.08.05.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 05:20:55 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon,  8 Jun 2020 17:50:35 +0530
Message-Id: <20200608122037.28019-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200608122037.28019-1-jaskaransingh7654321@gmail.com>
References: <20200608122037.28019-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 14:20:59 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 08 Jun 2020 14:20:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 2/4] parsing_c: parser: Use end_attributes_opt in
	decl2
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

The decl2 rule has redundant code caused by additional productions for
end attributes. Use end_attributes_opt to resolve this.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parser_c.mly | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index 78407844..ebb3b327 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -1560,18 +1560,7 @@ abstract_declaratort:
 /*(*************************************************************************)*/
 
 decl2:
- | decl_spec TPtVirg
-     { function local ->
-       let (returnType,storage) = fixDeclSpecForDecl (snd $1) in
-       let iistart = Ast_c.fakeInfo () in
-       DeclList ([{v_namei = None; v_type = returnType;
-                   v_storage = unwrap storage; v_local = local;
-                   v_attr = fst $1; v_endattr = Ast_c.noattr;
-                   v_type_bis = ref None;
-                },[]],
-                ($2::iistart::snd storage))
-     }
- | decl_spec end_attributes TPtVirg
+ | decl_spec end_attributes_opt TPtVirg
      { function local ->
        let (returnType,storage) = fixDeclSpecForDecl (snd $1) in
        let iistart = Ast_c.fakeInfo () in
@@ -1605,18 +1594,7 @@ decl2:
      }
  /*(* cppext: *)*/
 
- | storage_const_opt TMacroDecl TOPar argument_list TCPar TPtVirg
-     { function _ ->
-       match $1 with
-	 Some (sto,stoii) ->
-	   MacroDecl
-             ((sto, fst $2, $4, [], true),
-              (snd $2::$3::$5::$6::fakeInfo()::stoii))
-       | None ->
-	   MacroDecl
-             ((NoSto, fst $2, $4, [], true), [snd $2;$3;$5;$6;fakeInfo()]) }
-
- | storage_const_opt TMacroDecl TOPar argument_list TCPar end_attributes
+ | storage_const_opt TMacroDecl TOPar argument_list TCPar end_attributes_opt
    TPtVirg
      { function _ ->
        match $1 with
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
