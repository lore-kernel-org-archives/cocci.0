Return-Path: <SRS0=43Z/=6Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5502C54E8E
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE3A20720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGspPLMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE3A20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA7x86018109;
	Mon, 11 May 2020 12:07:59 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2960E7773;
	Mon, 11 May 2020 12:07:59 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 37EF43E6B
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:07:57 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA7t3e018710
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:07:56 +0200 (CEST)
Received: by mail-pj1-x1044.google.com with SMTP id y6so7619583pjc.4
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lwqNogG8vHxP252WZiCGBfjwezgxLB4uDA3affNqJMs=;
 b=SGspPLMvRF5YaQP/mKKPZYTP4HX2+W89zla2jc3fWpFQK/ro1mZXNGtqSmPMbo7ZQ8
 Gu5F/Z3u/2EMD+zCI5Ewxs8ZzzMsN99ttKziZCt6yFWe1FMrswkj0h8wUMSuKUkzbmjy
 3CzWCyJQmfyOHTdz49m1S4/pbWtyCS9qIWbcd9+RxjRhRzvBlV/EaQrES4fa+nvQWtuK
 tWolOW5qjOqXOj9y/SmqnP5hZ89h8A40NR59t6gCjaK3zTUX2ziNr1bMwCy+ZF9JwvHi
 viX7JZufAXXAxd6+pXFhJDWcJySQO3WGmYnXbFrtgHX+c+KHHYdP7lV2VwdZg+wLJgQz
 ylSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lwqNogG8vHxP252WZiCGBfjwezgxLB4uDA3affNqJMs=;
 b=l+jbfiT1y0Yk+ixjpEl6+VhrCOnvsdUxF8oFqcAtEjaBitnJwv/BK1zAxjFhBZPb6q
 e0IcnBSfl0w1XyPZaLRvcb6r4V20haRIZp4cr9sA9WQiUVJG3lRRJYgTvXoslyMVL6SH
 yHszuX29SeK2BlGhVPMlKduxvsNRvMSivQiGerjDYAOV2MlqoDdVHN+HezYVa8JgA+AA
 I6d5n2Zn9LqiD+sX2vTiH0ux5vlWL+GcekIT55buozdw/Yiv8YGmK89uFwzQsi7pjfKK
 KLXId52BvJhnXUOlezajQRBUTMEvW8FbD+230ASONSaYgO01PICxS/TO4m8NqqtGzOjR
 N6kA==
X-Gm-Message-State: AGi0Puar1KbUZfWbfE6nBJ+waL+TD3yVjpFgJesxKhC0cMwtGhX7L66Y
 bWsZye8/BHLp3k623gcHqcDjJYBcnqI=
X-Google-Smtp-Source: APiQypJ68zQGHG5UsppyrzhPXuU4lpCYa9QqUfkjD5EStfgOGg9DGG5fwMHnYkg+widv7RjG6s+MRA==
X-Received: by 2002:a17:90a:276a:: with SMTP id
 o97mr21386692pje.194.1589191674892; 
 Mon, 11 May 2020 03:07:54 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:07:54 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:36:48 +0530
Message-Id: <20200511100715.19819-6-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:07:59 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:07:56 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 05/32] parsing_cocci: unparse_ast0: Reflect cast
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

Cast attributes are added to the SmPL AST. Reflect these changes in
unparse_ast0.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/unparse_ast0.ml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/parsing_cocci/unparse_ast0.ml b/parsing_cocci/unparse_ast0.ml
index fdaf6cfa..7f554b37 100644
--- a/parsing_cocci/unparse_ast0.ml
+++ b/parsing_cocci/unparse_ast0.ml
@@ -221,8 +221,10 @@ let rec expression e =
 	  expression exp; mcode print_string pt; ident field
       | Ast0.RecordPtAccess(exp,ar,field) ->
 	  expression exp; mcode print_string ar; ident field
-      | Ast0.Cast(lp,ty,rp,exp) ->
+      | Ast0.Cast(lp,ty,attr,rp,exp) ->
 	  mcode print_string_box lp; typeC ty; close_box();
+	  (if not (attr = []) then print_string " ");
+	  print_between (fun _ -> print_string " ") (mcode print_string) attr;
 	  mcode print_string rp; expression exp
       | Ast0.SizeOfExpr(szf,exp) ->
 	  mcode print_string szf; expression exp
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
