Return-Path: <SRS0=TTUf=7S=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3E9C433E0
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA6D206E6
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdcLp7iV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA6D206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 055DirBZ000283;
	Fri, 5 Jun 2020 15:44:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6D3457567;
	Fri,  5 Jun 2020 15:44:53 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3DC623F9A
 for <cocci@systeme.lip6.fr>; Fri,  5 Jun 2020 15:44:52 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 055Dior6020622
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 5 Jun 2020 15:44:51 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id n2so3637787pld.13
 for <cocci@systeme.lip6.fr>; Fri, 05 Jun 2020 06:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bcxNryKY3UmRddk1qamJbMBVRoDXa6JrWytYdE8m7ME=;
 b=AdcLp7iV6Bqa5kL7HNLqhPB2bswhM3yfmJI1RtoyEQh4FwJi9aJgs9MOI5Y0ZuBnWP
 XIDSHDXv8wxr5neaKz7uOmqO066I3uMRQUsIPTsrDWwEgtEfwkMK93mP7V8uvUXOMEwl
 j9tw6vzPCCQ7gsQ1AlwcWnPmeXPngHp6i64rXQNiFPKusI1bLDlRVEdhvYXYqOMvc+kx
 DVL0hau3qK+2BjbyzLjUDmy0ow/HqEjMzqFxmfTFo3mnmWjzz+EYDZImiinzuO3/7pxp
 2z8xORjPtFtfXIrUyt9ymR+SXe3MZTPIZho306Jd7ZCrz8gNERAIt4XCbKUdhmYDqSpg
 HdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bcxNryKY3UmRddk1qamJbMBVRoDXa6JrWytYdE8m7ME=;
 b=SLd7Dy+NsAUDxeQ5pVNFmEgTFen6cH1hoSXqF3XAzQYrV43nKB6XLjTqUUQtK1gwJy
 /PFGLWs4Ar0H6pmgdZXGDpSHTTzA769DPziEBfKLvV6OsuXu835bZ4Fga6cptUQAnOu6
 sGdhcUudbPO8Lz09tg75mTncD7t/e62mKlVct0xPaZDsHkdyRxd8HO4XJOuezWbaiW/s
 XTDe3B3uchr1ii0dNOeNdnjLm3FoMkuK93TwRKp2crYsv/9MAkdxC2aJqvMYQ+362GEg
 ZpTAxihMLFl+A83K9Vl6KwDD7psF69Fjl28MDl4O07OpBeMV13ou3MaBmaiQexSINNBU
 GGVQ==
X-Gm-Message-State: AOAM530/xPDHhD4bSc1ylmi1nbuvIjUGOZRbhTkD12oH7pyQbT72LoD5
 SbvUIggSl+L1lZRF54diuiuSsKFlXyQ=
X-Google-Smtp-Source: ABdhPJydzUUt0w0lfe1m8wgjET4wYAui4Q5fr+dFnP6xn8MzbwFfUGFbv89Ygy53FJFTfuvURY98vw==
X-Received: by 2002:a17:90a:d103:: with SMTP id
 l3mr3313822pju.194.1591364689804; 
 Fri, 05 Jun 2020 06:44:49 -0700 (PDT)
Received: from localhost.localdomain ([1.38.221.125])
 by smtp.gmail.com with ESMTPSA id w186sm7861353pff.83.2020.06.05.06.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 06:44:49 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri,  5 Jun 2020 19:13:20 +0530
Message-Id: <20200605134322.15307-13-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
References: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jun 2020 15:44:53 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 05 Jun 2020 15:44:51 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v4 12/14] parsing_c: parser: cpp_other end
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
 parsing_c/parser_c.mly | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index 71e58e5b..9cd8761e 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -2182,7 +2182,8 @@ cpp_other:
     * the rule are slightly different, they can't be statement and so expr
     * at the top, only decl or function definition.
     *)*/
- | identifier TOPar argument_list TCPar TPtVirg
+
+ | identifier TOPar argument_list TCPar end_attributes_opt TPtVirg
      {
        if args_are_params $3
        then
@@ -2202,16 +2203,17 @@ cpp_other:
 	 Declaration(
 	 DeclList ([{v_namei = Some (id,NoInit); v_type = ty;
                       v_storage = unwrap sto; v_local = NotLocalDecl;
-                      v_attr = attrs; v_endattr = Ast_c.noattr;
+                      v_attr = attrs; v_endattr = $5;
 		      v_type_bis = ref None;
                     },[]],
-                   ($5::iistart::snd sto)))
+                   ($6::iistart::snd sto)))
        else
 	 Declaration
-	   (MacroDecl((NoSto, fst $1, $3, true), [snd $1;$2;$4;$5;fakeInfo()]))
+	   (MacroDecl((NoSto, fst $1, $3, true), [snd $1;$2;$4;$6;fakeInfo()]))
            (* old: MacroTop (fst $1, $3,    [snd $1;$2;$4;$5])  *)
      }
 
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
