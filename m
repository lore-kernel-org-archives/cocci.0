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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49451C433DF
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:21:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E90206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAGl9n6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E90206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHL5as009635;
	Sun, 24 May 2020 19:21:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DDEE73DC8;
	Sun, 24 May 2020 19:21:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 220733D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:21:04 +0200 (CEST)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHL2nj011204
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:21:03 +0200 (CEST)
Received: by mail-pf1-x441.google.com with SMTP id 23so7852478pfy.8
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4AysMomGa6RXFEPipea45EWMRk3CTOxlO+t3BKqr7CM=;
 b=BAGl9n6xoEVKg6BwVr1/7uA7lc42y1AHM7bcNz12A2ZZytOpAWbjaGv6EC+LKlUePa
 2fH03gNZ1dvsw5FjgTtxpWA6fSjtdYrmpteNsXGflagnOp5ef3lKQ4FvnfgxTXsttJth
 w6rJQhhyT5NbK3KHXfSW7ZMK1OoUi8CXeLFg92lwiRTvrPUJBwFzJIKhlqR8NmjCZVHd
 6lUnoHw7n3aEA78HqpScyvHvzpHlPXOP9vw7ndG8/+K3fx6/2h/7BooBBHkaFmjnClCo
 4K6u9WaUt3kbHOh2oCGTLy6/CTWamfVvRxIi7Y8yMlGc7ltflBHMYUNSPGqqQEreMui8
 YSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4AysMomGa6RXFEPipea45EWMRk3CTOxlO+t3BKqr7CM=;
 b=oSG2EG5dP6Sra1zpZcDhyNiBC0pbynSgElCh94HG7l7MU3rlGtX0IuUARuy4TqOX/2
 z0PQAL7eEnbPAInRMrYhLKx340LpbJC4ArnZoszDqEJyLzSgTAus8v5sR/SQPE2c6Av9
 tmilIBV69mzq1xkgglG1JI3LugwKQGmzBrrswmiXnnKQSvvMKeADMC/KbOeVWMhEF0QU
 D/umFjV+pXS5dVy0T0uVV/34gCya63noNsb238fnmKNOK05KvX63kBgvS5ZYia3ZnOoJ
 SKgtLOh1eefAkWU25LMKOho8PJNOcmovm8NyCbF/qUyHDGpXAgRSpBmEjku/fM7gZn//
 +Hdg==
X-Gm-Message-State: AOAM531nh/f+dIsJR6JT5faBQpuGpsL0z7Q3kpRpBpv03EEal5PCdUHZ
 0ZvV400OYPbQR0VIJrsQ929q0tTqHz8=
X-Google-Smtp-Source: ABdhPJwdKpd/BJFd5Pd93nKW3vUPggvH6CEPjwEpYM4id9yderRAGM+/0VqQtxji14RNLn1tsWdJdA==
X-Received: by 2002:aa7:955d:: with SMTP id w29mr13966771pfq.133.1590340861769; 
 Sun, 24 May 2020 10:21:01 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:21:01 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:17 +0530
Message-Id: <20200524171935.2504-13-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:21:05 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:21:03 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 12/30] parsing_cocci: single_statement: Reflect
	Macrodecl attributes
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
single_statement.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/single_statement.ml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/parsing_cocci/single_statement.ml b/parsing_cocci/single_statement.ml
index 4ad1c4e4..a75dc755 100644
--- a/parsing_cocci/single_statement.ml
+++ b/parsing_cocci/single_statement.ml
@@ -200,8 +200,8 @@ and left_declaration d =
   | Ast0.FunProto(fninfo,name,lp1,params,va,rp1,sem) ->
       (* should not be nested in anything anyway *)
       false
-  | Ast0.MacroDecl(Some stg,name,lp,args,rp,sem) -> modif_before_mcode stg
-  | Ast0.MacroDecl(None,name,lp,args,rp,sem) -> left_ident name
+  | Ast0.MacroDecl(Some stg,name,lp,args,rp,attr,sem) -> modif_before_mcode stg
+  | Ast0.MacroDecl(None,name,lp,args,rp,attr,sem) -> left_ident name
   | Ast0.MacroDeclInit(Some stg,name,lp,args,rp,eq,ini,sem) ->
       modif_before_mcode stg
   | Ast0.MacroDeclInit(None,name,lp,args,rp,eq,ini,sem) -> left_ident name
@@ -219,7 +219,7 @@ and right_declaration d =
   | Ast0.Init(_,ty,id,eq,ini,attr,sem) -> modif_after_mcode sem
   | Ast0.UnInit(_,ty,id,attr,sem) -> modif_after_mcode sem
   | Ast0.FunProto(fninfo,name,lp1,params,va,rp1,sem) -> modif_after_mcode sem
-  | Ast0.MacroDecl(_,name,lp,args,rp,sem) -> modif_after_mcode sem
+  | Ast0.MacroDecl(_,name,lp,args,rp,attr,sem) -> modif_after_mcode sem
   | Ast0.MacroDeclInit(_,name,lp,args,rp,eq,ini,sem) -> modif_after_mcode sem
   | Ast0.TyDecl(ty,sem) -> modif_after_mcode sem
   | Ast0.Typedef(stg,ty,id,sem) -> modif_after_mcode sem
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
