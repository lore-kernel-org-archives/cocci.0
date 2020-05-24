Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D0FC433DF
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:22:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE73A206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Njr27Ers"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE73A206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHMHdO008266;
	Sun, 24 May 2020 19:22:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 71D273DC8;
	Sun, 24 May 2020 19:22:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 06BC43D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:22:16 +0200 (CEST)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHMDEL023744
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:22:14 +0200 (CEST)
Received: by mail-pg1-x542.google.com with SMTP id f21so4696548pgg.12
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lRju4Ib2Cb5NOkSs8EnRNB65rQ8XoMnq2zTCePSZyW4=;
 b=Njr27ErslcOK9cH6s3+9s7SEWHjhwcW5DRgyxR8KxnW4bca96KZqbHLnN4rL0bCFdK
 LQEjQGq/We/Y8C2++FvAMqQQ8ZeQ7dDLTV/eav3zDingw132I/Q5VafHLAGn0cEyCfm4
 ztnKxHcChtmp7oQJUCZHtxpmo7XXFgPXROq8Ek0YbrSyYu574NARrARmtIVKV/reO7c8
 pf1oO14K56pGu6nNo4NdwGxQItgW5M4lSOL6XrC9OIZcTGWps7N1Ubj8HPzYP8BvKiRG
 4knxLxM9ZFcECMVXjQCiZKViNDMfjHwUYRLjnqMw2UvHEtQIeh6YBzbquS1/5sIJdC2Y
 1kLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lRju4Ib2Cb5NOkSs8EnRNB65rQ8XoMnq2zTCePSZyW4=;
 b=o1crocMevXh+7V4XPyhLZhrWuF9wqRg2u6Zu42MEsGdOfR+liuC61YzhP9H+WGOLTB
 kWatZJLAnSQXwHEEgN6R2tctgYZfxanQRsIHz/Gf2QuWHF8dBs3jh5+K66wXNfbvl1QV
 VoMx0T+0bURoaMN4wj/nYm8O21ffBFbZ2fEiUHT05XQNtPmcvb/F0CtoF8dRHMY8Jjul
 q1hqMS+vxFAsMj4NUXLAoF2xYLomT6iWqKAqYtWnO67Qj37igBbigIikjISAijqVSkr0
 N6qo8tBS0gmSKOb76gcTwEfdPJf78mn7Dl4qngEQdc1EIEUEQmbqn6HtdQVsGaqn2F2J
 FQJw==
X-Gm-Message-State: AOAM530RkahzWSn8cskq1kwBlGpjeGNiwXCk6DaXkHCjE62radvUx2oC
 QneeurIeyBPp/WcxWaiEBBSNrLDaojk=
X-Google-Smtp-Source: ABdhPJxCHSxG7UlhR9jEMxGLUdDGUpd+aECWcPwtas9/hoRDh0FECEJh5rRZrDuUV+pgnbjKmL8YWQ==
X-Received: by 2002:aa7:99c6:: with SMTP id v6mr13306023pfi.260.1590340932478; 
 Sun, 24 May 2020 10:22:12 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:22:12 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:29 +0530
Message-Id: <20200524171935.2504-25-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:22:17 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:22:14 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 24/30] parsing_c: unparse_cocci: Reflect Macrodecl
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

Macrodecl attributes are added to the SmPL AST. Reflect these changes in
unparse_cocci.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/unparse_cocci.ml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/parsing_c/unparse_cocci.ml b/parsing_c/unparse_cocci.ml
index 395b3a3c..903dc785 100644
--- a/parsing_c/unparse_cocci.ml
+++ b/parsing_c/unparse_cocci.ml
@@ -936,12 +936,15 @@ and declaration d =
       end;
       close_box(); mcode print_string rp1;
       mcode print_string sem
-  | Ast.MacroDecl(stg,name,lp,args,rp,sem) ->
+  | Ast.MacroDecl(stg,name,lp,args,rp,attr,sem) ->
       print_option (mcode storage) stg;
       print_option (function _ -> pr_space()) stg;
       ident name; mcode print_string_box lp;
       dots (function _ -> ()) arg_expression args;
-      close_box(); mcode print_string rp; mcode print_string sem
+      close_box(); mcode print_string rp;
+      (if not (attr = []) then pr_space());
+      print_between pr_space (mcode print_string) attr;
+      mcode print_string sem
   | Ast.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem) ->
       print_option (mcode storage) stg;
       print_option (function _ -> pr_space()) stg;
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
