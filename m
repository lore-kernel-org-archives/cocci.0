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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E8CC433E0
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:25:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C5F20888
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSd+nS5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C5F20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04SCPLEu028707;
	Thu, 28 May 2020 14:25:21 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A52035D47;
	Thu, 28 May 2020 14:25:21 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E6E443E1D
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:25:20 +0200 (CEST)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04SCPJF7022379
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:25:20 +0200 (CEST)
Received: by mail-pg1-x542.google.com with SMTP id m1so7164445pgk.1
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 05:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LL6ZxXzagbOZAMBjCaJZisg3zIcPtkLdKtjR0GrIzA8=;
 b=BSd+nS5aE4MU+Bk0DXUJqlikadcFjV44wMX+QfwDRbyF5CwJg2iNHDE/9bukoMvhUB
 fEdmLM+xvSrej9T2nfFDEja5tCH5uCMenUZJPzj5Z7d5raLL/I/xYevikHN5IeZSUQfA
 kNWmguLy/Or8AVaXBowjNbzPElhQanHZEmAKeMCXmGCyHUYyvWgTnN6wf3Y+1TyCmObo
 aQNnTbs+K+gqsOTwzaojU9INixBaci2GSEpp//i7Ksty7nJfwqQpKxv2ZE2M/9wYclAw
 5X8Enp/6Oq17ll3IffNj4AqlKqvyAxLT5zoqC4fD92HLDTHCLCz7udAoLUPznYAqRyfX
 gBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LL6ZxXzagbOZAMBjCaJZisg3zIcPtkLdKtjR0GrIzA8=;
 b=IoFVQEk4MsP+t0q02uCotwTRcWe1uAf1DJRrgA4jWWLnxmMZyewsaFscjEWrNj9GE6
 prtBElHo4jU1UdHpZU/p6RgX6CCPyjGAODzDf0saoSJ+gBK74beSWimuCjlj0GNMjxgR
 TTXZEkopEJqODftJ4xuHm5N9SAw0+kpVBpeKyLQZ89DhFkq2a/MlDhwTTF6QDpCEILdz
 Fn2RKvrsAonujkdQZj3Ohjj0jCVHH7vGj3DTEMiWhqHG7PIKZLynQKdGtMppUthpcs/J
 I69Sx53BVY7h9YdjWQTaWEwD/eicJP/pdmh3WCJt5K+XXRTLR2qGtnoNTVm16nNHmaQB
 TPgA==
X-Gm-Message-State: AOAM531tDvKs8g58qypEz07JjsTDgtmz9zCy+cr0mYzFyCWW+Ry3u4MH
 bFU9oXvlLXm5qtQPoZ5cs/5+rG/B
X-Google-Smtp-Source: ABdhPJyPPSXfqkkdkevDX80z0Ic5XuovSWpqVF5EsMdszFtaE6vDIAdh0s8DJFyLZwREx/Nw0Rsldw==
X-Received: by 2002:aa7:9ac5:: with SMTP id x5mr1089086pfp.234.1590668718425; 
 Thu, 28 May 2020 05:25:18 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2183:e360:deba:7bf4:98ef:5568])
 by smtp.gmail.com with ESMTPSA id 1sm5722888pje.26.2020.05.28.05.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 05:25:18 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 28 May 2020 17:54:13 +0530
Message-Id: <20200528122428.4212-12-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
References: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 May 2020 14:25:21 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 May 2020 14:25:20 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 11/25] parsing_c: parser: cpp_other end
	attributes production
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

Add a production for a macro call in the cpp_other rule of Coccinelle's
C parser. This parses the following C code from Linux v5.6-rc7
successfully:

  arch/x86/kernel/irq_64.c:

	DEFINE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store) __visible;

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parser_c.mly | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index d36ac2a6..2caf4974 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -2261,6 +2261,37 @@ cpp_other:
            (* old: MacroTop (fst $1, $3,    [snd $1;$2;$4;$5])  *)
      }
 
+ | identifier TOPar argument_list TCPar end_attributes TPtVirg
+     {
+       if args_are_params $3
+       then
+	 (* if all args are params, assume it is a prototype of a function
+	    with no return type *)
+	 let parameters = args_to_params $3 None in
+	 let paramlist = (parameters, (false, [])) in (* no varargs *)
+	 let id = RegularName (mk_string_wrap $1) in
+	 let ret =
+	   warning "type defaults to 'int'"
+	     (mk_ty defaultInt [fakeInfo fake_pi]) in
+	 let ty =
+	   fixOldCDecl (mk_ty (FunctionType (ret, paramlist)) [$2;$4]) in
+	 let attrs = Ast_c.noattr in
+	 let sto = (NoSto, false), [] in
+	 let iistart = Ast_c.fakeInfo () in
+	 Declaration(
+	 DeclList ([{v_namei = Some (id,NoInit); v_type = ty;
+                      v_storage = unwrap sto; v_local = NotLocalDecl;
+                      v_attr = attrs; v_endattr = $5;
+		      v_type_bis = ref None;
+                    },[]],
+                   ($6::iistart::snd sto)))
+       else
+	 Declaration
+	   (MacroDecl((NoSto, fst $1, $3, true), [snd $1;$2;$4;$6;fakeInfo()]))
+           (* old: MacroTop (fst $1, $3,    [snd $1;$2;$4;$5])  *)
+     }
+
+
  /* cheap solution for functions with no return type.  Not really a
        cpp_other, but avoids conflicts */
  | identifier TOPar argument_list TCPar compound {
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
