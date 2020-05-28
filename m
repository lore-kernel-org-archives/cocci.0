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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6AAC433E0
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:25:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C12320888
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2FUPRp1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C12320888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04SCPChU020335;
	Thu, 28 May 2020 14:25:12 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2C84A5D47;
	Thu, 28 May 2020 14:25:12 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CB3693E1D
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:25:10 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04SCP9tI010208
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:25:10 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id u5so13427734pgn.5
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 05:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q4mSnbPeci1449T1OL1fEROEbgH8C4/X8I9Kmacw/iA=;
 b=f2FUPRp1Iqh+ccP+R8bOnAqNPTul3YyKumQUAjxLm398nIxeNJKoZ2FLL9HM1vY7O7
 swXPNp4aLGAhGF/t4LdZedVpj99sHRQEMZ/pCNO5rge7E+OXBePYxvPI/ubW7oRh3XpO
 KSLoxSAKKpsceVzDOfPuN2xxUHIMbygDZYAFqXNW31UUtH3YPrvq+64oudc0wySL1J0K
 mzzTq0bGO35eqtzpl8RqklSstyKEhf8lyckCPelvepp2E5iPaHLfLD04Vvk2vZhW/4xO
 dlunRvSRlaMWAqKrCzZLSvcMfNKvYh0MI1xetEJF0GZB9mVSBNYvc/v4ICqPkfbuJtzF
 evhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q4mSnbPeci1449T1OL1fEROEbgH8C4/X8I9Kmacw/iA=;
 b=nkqiGOmwUmqE0OwMda8DpgeoprLHV152CNw46KfoiknAidOD8iJw+dMZp3zWYyzsWU
 LWSgHANFxZmq5uZk4LAVpI0+aHRg/KLRTCmjRmxPhdtRkjIeN8+rNUJZzTdf8DHCu6Q+
 z9aplzggcFKg0JJDSn1UPcrjF2ZRCCCMGFhAHe8CVquPsAViD/BuayHayfF8fm0OrBzt
 a+NxvDk5QEkFhWWH+AZJPCIT211bkivhY0GMc+NMASzlfcJ/Nh0OivxD85mM6N/FzCz5
 DjCRInxfc9NIwe5GMpWZ/DdmnYurxvDjsmCHm3IdHT2qgmD57A69EO6hPFW6t3E8/0Fc
 ukKA==
X-Gm-Message-State: AOAM533UfZyYZ4o6a0TCS2DIV+ce9OPggmBkB6SDNOsVqfYrwMpmHrzv
 zsQ0uFoq/c/8FkcHhgnR5jOUSC6q
X-Google-Smtp-Source: ABdhPJyW9G1J544UhOZ2VP+OxIjWDpp4Rm8whL7h+PnP19RElPiuOGY54FERA0egxsMo7et3VhRCRA==
X-Received: by 2002:a63:a36e:: with SMTP id v46mr2658737pgn.378.1590668708346; 
 Thu, 28 May 2020 05:25:08 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2183:e360:deba:7bf4:98ef:5568])
 by smtp.gmail.com with ESMTPSA id 1sm5722888pje.26.2020.05.28.05.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 05:25:07 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 28 May 2020 17:54:10 +0530
Message-Id: <20200528122428.4212-9-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
References: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 May 2020 14:25:12 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 May 2020 14:25:10 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 08/25] parsing_c: parser: Add field declaration
	end attributes production
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

As per GCC's C grammar, the struct-declarator rule has the following
productions:

	struct-declarator:
	  declarator gnu-attributes[opt]
	  declarator[opt] : constant-expression gnu-attributes[opt]

While these productions are handled in the struct_declarator rule of
Coccinelle's C grammar, end attributes are not.

Add productions for end attributes in the field_declaration rule of
Coccinelle's C parser. This parses the following C code from Linux
v5.6-rc7 successfully:

  kernel/sched/sched.h:

	struct task_group {
		...
		atomic_t load_avg __cacheline_aligned;
		...
	};

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parser_c.mly | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index 498def13..b795f3a0 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -1846,6 +1846,22 @@ field_declaration:
           *)
      }
 
+ | spec_qualif_list struct_declarator_list end_attributes TPtVirg
+     {
+       let (attrs, ds) = $1 in
+       let (returnType,storage) = fixDeclSpecForDecl ds in
+       if fst (unwrap storage) <> NoSto
+       then internal_error "parsing don't allow this";
+
+       let iistart = Ast_c.fakeInfo () in (* for parallelism with DeclList *)
+       FieldDeclList ($2 +> (List.map (fun (f, iivirg) ->
+         f returnType, iivirg))
+                         ,[$4;iistart])
+         (* don't need to check if typedef or func initialised cos
+          * grammar don't allow typedef nor initialiser in struct
+          *)
+     }
+
  | spec_qualif_list TPtVirg
      {
        let (attrs, ds) = $1 in
@@ -1858,6 +1874,18 @@ field_declaration:
        FieldDeclList ([(Simple (None, returnType)) , []], [$2;iistart])
      }
 
+ | spec_qualif_list end_attributes TPtVirg
+     {
+       let (attrs, ds) = $1 in
+       (* gccext: allow empty elements if it is a structdef or enumdef *)
+       let (returnType,storage) = fixDeclSpecForDecl ds in
+       if fst (unwrap storage) <> NoSto
+       then internal_error "parsing don't allow this";
+
+       let iistart = Ast_c.fakeInfo () in (* for parallelism with DeclList *)
+       FieldDeclList ([(Simple (None, returnType)) , []], [$3;iistart])
+     }
+
 
 
 
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
