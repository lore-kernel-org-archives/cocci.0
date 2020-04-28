Return-Path: <SRS0=bJsz=6M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1477AC83001
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:03:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E2820730
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNyoY/rX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E2820730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SH31mh008039;
	Tue, 28 Apr 2020 19:03:02 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BC39F782D;
	Tue, 28 Apr 2020 19:03:02 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 37E463DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:03:00 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SH2wuV018213
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:02:59 +0200 (CEST)
Received: by mail-pg1-x544.google.com with SMTP id n11so2526191pgl.9
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 10:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mDnBPl3qIHtqg930rr9qdZdP5Uw3rvrHwoa1ZEd6TMs=;
 b=rNyoY/rXdi9R/wAiFTn7R3mfeNe3ziEbo3RjNgxitCbRCNX8t81tPLJtfQQ9+RoKov
 NV/pFZ1AP1oj3/2K9NlGB1JFtlL9oeNFnr9G9sgIbGUYu2Haup8bA8nZAXckdWriYfV6
 9Bvn3xeOlstS9fjJZAb/xAT3eVbmAPPXFEn8FUm1cUljWJIZuTmmVBP9iK942J9+3AgH
 wTX/IcPQTD3W6kyanQu0XE1NJtmLWQMJw6d4yzutbqqB+f18/dketrA6RwBCrXOzk2DT
 /4DeDoQ22shIPgcT+evKxryC2Ox3EOkgUWl8XxaMUD/dMnfES5KAv5jXY72uqIDtYYwu
 fjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mDnBPl3qIHtqg930rr9qdZdP5Uw3rvrHwoa1ZEd6TMs=;
 b=eTLyxmXPxjoZlVe/5lZtJhsyRT3YXr8+lKdRMc5LdJCwwKGUFX2Zv/FXk/cpoophsx
 kS7nH+nmZJM4z+WItrUhPBDaSbj3lQRERM9H803r0sAFFEXwMpY0mBbctrUTFUxO17mL
 Vs/lbJ2rKGDZWOuJbz1JrEvZlJb38yUgv2RNXSM8+9zJkP0DP7Q01KhAtZdpwRSnFhjf
 UY04r/+aJEnnOiUvzF40ofIA0Ohlwc0GyvqSCfLHy2t4nacmxyMfszT5L9RJA34xVUJw
 JZLY9UIvai+kfCL5yQCzWdoZSbKxJPAJLfEWdmUqUhKPFYF1z7GRpNmOaFp/s5tw6qIG
 JJ2g==
X-Gm-Message-State: AGi0PuabTN4brBxyAUp/ppMNY5vzvmqdTPIjBgbHcuFfMMnu4LQ1y/xm
 dvRvCU2o0z3BBVWv7NMp8IkDtApzMlY=
X-Google-Smtp-Source: APiQypLsXOCeyVl2qilIHPM4I1AaCJ+iV+9qhwBEoEM9B/qRaL3HpiUQYe9nGtjv75Cb9CtQ+rkHMQ==
X-Received: by 2002:a62:3857:: with SMTP id f84mr32523134pfa.56.1588093377757; 
 Tue, 28 Apr 2020 10:02:57 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.163])
 by smtp.gmail.com with ESMTPSA id u15sm2505097pjm.47.2020.04.28.10.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:02:57 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 28 Apr 2020 22:32:00 +0530
Message-Id: <20200428170228.7002-5-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:03:02 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 19:02:59 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 04/32] parsing_cocci: visitor_ast0: Visit cast
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

Cast attributes are added to AST0 of SmPL. Visit these attributes in the
AST0 visitor of SmPL.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/visitor_ast0.ml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/visitor_ast0.ml b/parsing_cocci/visitor_ast0.ml
index d9e340ed..2ccdb0bb 100644
--- a/parsing_cocci/visitor_ast0.ml
+++ b/parsing_cocci/visitor_ast0.ml
@@ -184,12 +184,14 @@ let visitor mode bind option_default
 	    let (ar_n,ar) = string_mcode ar in
 	    let (field_n,field) = ident field in
 	    (multibind [exp_n;ar_n;field_n], Ast0.RecordPtAccess(exp,ar,field))
-	| Ast0.Cast(lp,ty,rp,exp) ->
+	| Ast0.Cast(lp,ty,attr,rp,exp) ->
 	    let (lp_n,lp) = string_mcode lp in
 	    let (ty_n,ty) = typeC ty in
+	    let (attr_n,attr) = map_split_bind string_mcode attr in
 	    let (rp_n,rp) = string_mcode rp in
 	    let (exp_n,exp) = expression exp in
-	    (multibind [lp_n;ty_n;rp_n;exp_n], Ast0.Cast(lp,ty,rp,exp))
+            (multibind [lp_n;ty_n;attr_n;rp_n;exp_n],
+             Ast0.Cast(lp,ty,attr,rp,exp))
 	| Ast0.SizeOfExpr(szf,exp) ->
 	    let (szf_n,szf) = string_mcode szf in
 	    let (exp_n,exp) = expression exp in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
