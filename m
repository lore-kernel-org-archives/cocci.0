Return-Path: <SRS0=Yx51=7L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA13C433DF
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:08:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08715206F0
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJ/BcXpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08715206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04TC8Xat019943;
	Fri, 29 May 2020 14:08:33 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1D1617783;
	Fri, 29 May 2020 14:08:33 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 711535D47
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:08:31 +0200 (CEST)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:444])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04TC8Tmb001724
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:08:30 +0200 (CEST)
Received: by mail-pf1-x444.google.com with SMTP id q8so1296916pfu.5
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 05:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U5aG24rARWzd3AJS18SdfBfZgIYT7ABRPNJBC0Z4aH0=;
 b=CJ/BcXpcto8FI8cPAi8w8eg3BOS7ZRLc/00LicZvUL1S7vUgmkAglKONtfX8Lu6Lty
 ornK5Nw407AaJs6Si5nWu1rF/guVS48LcIpgojOxD3Gz+L/a+LZnjETdcSuVVOYcYWPF
 A0qqXuXI/KRLH2IkA8+u5GpsPK78rmJPgv1qMHlJ4z54HNwp7ENCwVxs3vsq8wPPMKBb
 oV4CA/vT48N7LO2kf9pZjhOldfPH7jclrHAxm3UXI/IWDvRIhC6ozCF7/9RSPCuPYPiu
 rLLuwMzzpoLLRYvFIWHMpqqbBITuVOyN4DxJmNbbhtHLTFMbzFSNOMx+UXxbyDBc18q1
 kTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U5aG24rARWzd3AJS18SdfBfZgIYT7ABRPNJBC0Z4aH0=;
 b=L1BrQ0vCflUkNnnLZtR/UEDdTQiPQObsIroB4AP8uKMyBL286gD6sC1/yInNbGVO1V
 ln0R1F9+0NTUzgDR3hiwhEt3l8j21epGbhc5+rRXonAhDnPrSYqVOTuOsRkw27RuNTeZ
 qcX/dxqoKGeDafrIo74sLrqwDwRmaIFg3lQMfCXgWBntoYRWqjIeJ0NJElYpiqgyXCYm
 H6G//XMWRjuEszf+SY5LHKCQL0WZtw7fNGphGRFIbEkx74Av8/jDJOf3bYn/xDzt/mIJ
 2y81/X644QkvF4WhWKAlwR9Ab7w7NihGoRMNLXRoDfyG0HQSNMhs/VoU2azQbRWNv0D/
 aOLw==
X-Gm-Message-State: AOAM533Zo+TXcXjRxsHPmBMTnB5QEG017jM8XNjS9Ate1EWyV/bUn5GS
 gwInr+tgcjl7X/52j9J50RBMlvRj
X-Google-Smtp-Source: ABdhPJzmjRb7b6eUyWOhyyYAL6BtJeXYqAGO0mNPKDZsnwViUxrRMIG/+3giD/dpVFQqyalD2J6Crg==
X-Received: by 2002:aa7:9e9a:: with SMTP id p26mr8828494pfq.20.1590754109001; 
 Fri, 29 May 2020 05:08:29 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:694:e576:19d1:a79b:707d:59f2])
 by smtp.gmail.com with ESMTPSA id dw13sm7975161pjb.40.2020.05.29.05.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:08:28 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 29 May 2020 17:36:33 +0530
Message-Id: <20200529120703.31145-4-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
References: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 May 2020 14:08:33 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 May 2020 14:08:31 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 03/32] parsing_cocci: parser: Parse cast
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

Cast attributes are added to the SmPL ASTs. Parse these attributes in
the SmPL parser and place them in the SmPL AST. The added production
only supports attributes after the type and before the expression.
However, these attributes are matched anywhere in within a cast.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/parser_cocci_menhir.mly | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/parser_cocci_menhir.mly b/parsing_cocci/parser_cocci_menhir.mly
index fe4ef322..8669405f 100644
--- a/parsing_cocci/parser_cocci_menhir.mly
+++ b/parsing_cocci/parser_cocci_menhir.mly
@@ -2177,11 +2177,12 @@ arith_expr_bis:
 
 cast_expr(r,pe):
     unary_expr(r,pe)                      { $1 }
-  | lp=TOPar t=ctype rp=TCPar e=cast_expr(r,pe)
-      { Ast0.wrap(Ast0.Cast (P.clt2mcode "(" lp, t,
+  | lp=TOPar t=ctype ar=attr_list rp=TCPar e=cast_expr(r,pe)
+      { Ast0.wrap(Ast0.Cast (P.clt2mcode "(" lp, t, ar,
                              P.clt2mcode ")" rp, e)) }
-  | lp=TOPar t=ctype d=direct_abstract_d rp=TCPar e=cast_expr(r,pe)
-      { Ast0.wrap(Ast0.Cast (P.clt2mcode "(" lp, d t,
+  | lp=TOPar t=ctype d=direct_abstract_d ar=attr_list rp=TCPar
+    e=cast_expr(r,pe)
+      { Ast0.wrap(Ast0.Cast (P.clt2mcode "(" lp, d t, ar,
 			     P.clt2mcode ")" rp, e)) }
 
 unary_expr(r,pe):
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
