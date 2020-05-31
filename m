Return-Path: <SRS0=O8dQ=7N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D42C433E1
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92AAE206EB
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgsCKBya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92AAE206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFRIFP008963;
	Sun, 31 May 2020 17:27:18 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9C8087833;
	Sun, 31 May 2020 17:27:16 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0E5487830
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:15 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:644])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFRAil016395
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:11 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id y11so3212926plt.12
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/esz5+1vzkbbW+2y/fuP4JSdygfzKs2wP6JPwtSf/W4=;
 b=RgsCKByaAIHybCejoFp9e+yDaqq70f/t2cyrEiRvHrJvc/QM4EKouHrtsDYUioLk8i
 HDzbSvmxKMwVRWfl0XSsucsIsQ2DcRQtlEZh5Xf1fecxdW9kMlJvDWCMgQ0tQMxwA8k+
 XB+QhQSfWkekz0YUJALAje/CXjWdQg+O6HE8mL/JxnvLf9kdZ3sRlQSkxO0Suh42dEHw
 4k/4su+vxSl5qRdlO/pWx+zXX39N+A/lpLeOmrPoDIb+5xGI86mtgQkGukMB4vLzOHZb
 IH3upu7VNKWZgcXV92BVCZjunHOJqDquHJ1MxBvPdAgYMJYIkSpeRyfazsiWC4+X9D3N
 p2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/esz5+1vzkbbW+2y/fuP4JSdygfzKs2wP6JPwtSf/W4=;
 b=TdrTpZuEwd0+urtP+CdJSEtVBm5R1EHyQggA0Wn8SmmzUnK6l9mDok/aWibHKBh9wG
 DBhkwWzvcmrh6IhWaMVblhFU3m8X64cgZ3+JvZ8t8/eXRdtn6bSyJ8szCE+u/ttAyPkY
 Mp7hNrR/2g5/MxwKYZ7nkXio9gmSHG7OT3Ic4Ttc+gMio6sTYLTq6fgXf9VWJRYEwdyz
 Txw3GrbQGCn5pY6kpQFoBvaYb1hJ4Kb7nntx3vi72qXwfUMUnQiUP/uWjiviZhkFOpsb
 OrSlHjdLN3hLKclgK5gVXIFWvik5DdwyO3CzPvpOkX2SLbldiEi0emHKxP27ToKewh1h
 XrGQ==
X-Gm-Message-State: AOAM531OQeLEKZizSE+ZfkpASicZmYBe+6iYSw0aIaqdoys3LcrLaCW0
 AiT3965lKppxvKhe7usPgO2vBfGbf/U=
X-Google-Smtp-Source: ABdhPJwaVi/1sZsnd/x79dVIRjxgBHWk1on7KvIeQFePsVmsaPx+lkgJX7YyC+K96DbuMoCBp3UiOg==
X-Received: by 2002:a17:902:b206:: with SMTP id
 t6mr16942391plr.248.1590938829810; 
 Sun, 31 May 2020 08:27:09 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:27:09 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:55:56 +0530
Message-Id: <20200531152621.2886-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:27:18 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:27:11 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 02/27] parsing_cocci: parser: Reflect struct end
	attributes
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

Struct end attributes are added to the SmPL AST. Parse these attributes
correctly in the SmPL parser.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/parser_cocci_menhir.mly | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/parser_cocci_menhir.mly b/parsing_cocci/parser_cocci_menhir.mly
index 94e0b84a..63cb8b5e 100644
--- a/parsing_cocci/parser_cocci_menhir.mly
+++ b/parsing_cocci/parser_cocci_menhir.mly
@@ -1678,8 +1678,8 @@ the language is ambiguous: what is foo * bar; */
 /* The AST DisjDecl cannot be generated because it would be ambiguous with
 a disjunction on a statement with a declaration in each branch */
 decl_var:
-    t=ctype pv=TPtVirg
-      { [Ast0.wrap(Ast0.TyDecl(t,P.clt2mcode ";" pv))] }
+    t=ctype ar=attr_list pv=TPtVirg
+      { [Ast0.wrap(Ast0.TyDecl(t,ar,P.clt2mcode ";" pv))] }
   | TMetaDecl { [P.meta_decl $1] }
   | s=ioption(storage) t=ctype
       d=comma_list(direct_declarator(disj_ident)) pv=TPtVirg
@@ -1731,8 +1731,8 @@ decl_var:
 	  d }
 
 one_decl_var:
-    t=ctype pv=TPtVirg
-      { Ast0.wrap(Ast0.TyDecl(t,P.clt2mcode ";" pv)) }
+    t=ctype ar=attr_list pv=TPtVirg
+      { Ast0.wrap(Ast0.TyDecl(t,ar,P.clt2mcode ";" pv)) }
   | TMetaDecl { P.meta_decl $1 }
   | s=ioption(storage) t=ctype d=direct_declarator(disj_ident)
       a=attr_list pv=TPtVirg
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
