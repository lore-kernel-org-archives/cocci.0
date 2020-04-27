Return-Path: <SRS0=J+r8=6L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D970C54FD0
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEC13206CD
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTHO8k7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC13206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RC99eH015373;
	Mon, 27 Apr 2020 14:09:09 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D6A717807;
	Mon, 27 Apr 2020 14:09:09 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 118967807
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:08 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:643])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RC96ZR008322
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:07 +0200 (CEST)
Received: by mail-pl1-x643.google.com with SMTP id k18so6925616pll.6
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 05:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CZ5votp7iJyEHJkIeJl40honWeZHULCEBP3YDk5oiHU=;
 b=GTHO8k7iHz56GYP1fwrcKp/QXst5IcAXmU+Z67BRa/0oWhKQRe7EgRU4BzWhgQOZve
 W2MvbdJ1VvWELqF7iATr1Phl3zjXzlsHS9wfY+FFRjdAt3Qb+04KPAQVvKMB4kFZGAmb
 f0T68ye0RcCX2rlroI04KgZob26ktFGBziXA3fjNajcByWrWebBwFli/uLVwIGRp2P0r
 AqFyYcFDyyBQmdV8ZSAal9jR3C4/kr5Bc06etmIJmhvUWRApw75LVwQLVHUShRWLhKEY
 G+jQYNTcZDe9rlUB/1wciK6FIU4Az2vAMLw1VHjR+p1AKgCH2iW/rtonrQmRrkRmZ5H0
 XzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CZ5votp7iJyEHJkIeJl40honWeZHULCEBP3YDk5oiHU=;
 b=l4E30+vYWAwOgLH+EBHRd7ICxxH9QAky3DhkF/byhJaHpbBgDTvQvoVcaQpC2ivqtq
 qfWXbWrWN7emJ5DE8IsID7CsDqvAZJHS++jeRN6YtrGzajtAB4UnAaLQ5E4UTiRdxAn8
 Gp23uPDp/9mJyjQ/4IA4GoeuSM1Beme1drAfF3r3DWXDERxQrhgfo1Z55btzybDO4PU/
 x9i76FdnBsPwiLSHR8Ylf+C5R61Xdihog7HQMkkNtGIFKoIl2OIVXzkG2nkKzUPsv4ik
 3oqHtDJngYn+OQP53g2kxrXlG4dqI5iRK75w2bSDHINRNtQ6PonHyievAj6MIl9dwfZU
 6NJg==
X-Gm-Message-State: AGi0Pubg9hEl1MgqT2/ZbmDasiftRMiMReAf6+S4Rtyiq5dXdw7xlAGM
 4STpD+YBrHwkb811eSXgMei+dlbCGfs=
X-Google-Smtp-Source: APiQypISpS71+6HrTkWFfrZLGMg6hgh3o+1fUy9OVqpCGbdtRgfrwxWwNc4EcvIlDLQ7voqkO6+d0w==
X-Received: by 2002:a17:902:d697:: with SMTP id
 v23mr21008191ply.262.1587989345694; 
 Mon, 27 Apr 2020 05:09:05 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.114])
 by smtp.gmail.com with ESMTPSA id r17sm9623885pgn.35.2020.04.27.05.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 05:09:05 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 27 Apr 2020 17:38:16 +0530
Message-Id: <20200427120834.380-6-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 14:09:09 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 Apr 2020 14:09:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 05/23] parsing_cocci: check_meta: Reflect Parameter
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

Parameter attributes are added to the SmPL AST. Reflect these changes in
check_meta.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/check_meta.ml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parsing_cocci/check_meta.ml b/parsing_cocci/check_meta.ml
index 5a348ba3..ab1d357e 100644
--- a/parsing_cocci/check_meta.ml
+++ b/parsing_cocci/check_meta.ml
@@ -374,7 +374,7 @@ and initialiser_list old_metas table minus =
 
 and parameterTypeDef old_metas table minus param =
   match Ast0.unwrap param with
-    Ast0.Param(ty,id) ->
+    Ast0.Param(ty,id,attr) ->
       get_opt (ident ID old_metas table minus) id;
       typeC old_metas table minus ty
   | Ast0.MetaParam(name,_,_) ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
