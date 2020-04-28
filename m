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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365F7C83001
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:03:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A982A205C9
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCnh/lmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A982A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SH3QAA016751;
	Tue, 28 Apr 2020 19:03:26 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E98727807;
	Tue, 28 Apr 2020 19:03:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 360133DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:03:24 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SH3Mtc013648
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:03:23 +0200 (CEST)
Received: by mail-pg1-x544.google.com with SMTP id n11so2527205pgl.9
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3HxfcmDQC1LTYn8Ag4N3xUOyxSJuA9YRm6z4xlq/lwc=;
 b=PCnh/lmIw2ta4I5quFCFtypY4vnIKNrwuafSvnc7rghVziBxwtMbZGiQYlOWpCFLtb
 FwpCKhFMMN1iDE7IsUoinx0WjxGebPN/3zTHCgC1ln1VOp06715CH+TL9o7syTjdRKBc
 FMUHW+/aBbz8GrhyOK2qBuslHOH6bI+TlqIRKvLE7ztS70RjrYtVMhaNMRV65IrN4/VT
 fgrdUEiMcHiM/X5YSI2gZdAF+JaMXpSysC6dhSbelLromaENUALLe3WAH6pSa/wjylaD
 q34LvWfC6AXg+claQglAYiPwh/FKH8FqOc5UOJ1haI0QBgkLo7RMhW8CDEgt27NWe/73
 +4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3HxfcmDQC1LTYn8Ag4N3xUOyxSJuA9YRm6z4xlq/lwc=;
 b=fVn6Rpwsavcnkupr6QeOI0lifejhV483W0Oev87VHXDH9eRFRX3kP2W9KHM5GDJir/
 1nCLUO9RGuW0vYpf2mFunJuHB/md+T9I04UgCmsyFfKUbnDUQDJsZs6xC1cHAdICaAKa
 j4aDXD4m9r00/25rOPLCRkMsrSfy6iBZJ0zcqR/rEJEAD1FmAF+EOZhPl8PIFQaiPXCH
 YCU2hGWLWsJeNrCBlBTMVca514ja4vdi9Bh0tnSCuqcTarYZ+5Nq6577BgqLicd1SIjk
 TOdVbJMr2Iz8yRg7Jyv8ekjY0C7Jd9UfpqIC0Kgusgg9RDznH46KOF5dRcANzyQBi30N
 wxCg==
X-Gm-Message-State: AGi0PuYLBpmHNoH2IRbaGabRQ8JlQ41Dgl9NXe0Apnv4OqtueDFXguWk
 UkkhpE6ecz5XQLo+SwbNR+A3bbM7YLo=
X-Google-Smtp-Source: APiQypJQjSqqCmv95DKjdM4eyjEkHFjrnwmQXA/wMT1DHKg/KK+wb08zAy+rqQL3gkfpNJXXl/D9Dw==
X-Received: by 2002:aa7:9ae5:: with SMTP id y5mr30456404pfp.294.1588093398875; 
 Tue, 28 Apr 2020 10:03:18 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.163])
 by smtp.gmail.com with ESMTPSA id u15sm2505097pjm.47.2020.04.28.10.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:03:18 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 28 Apr 2020 22:32:05 +0530
Message-Id: <20200428170228.7002-10-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:03:26 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 19:03:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 09/32] parsing_cocci: arity: Reflect Cast attributes
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
arity.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/arity.ml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/arity.ml b/parsing_cocci/arity.ml
index 8ee6d33f..880cd7a3 100644
--- a/parsing_cocci/arity.ml
+++ b/parsing_cocci/arity.ml
@@ -254,13 +254,14 @@ let rec top_expression opt_allowed tgt expr =
       let ar = mcode ar in
       let field = ident false arity field in
       make_exp expr tgt arity (Ast0.RecordPtAccess(exp,ar,field))
-  | Ast0.Cast(lp,ty,rp,exp) ->
+  | Ast0.Cast(lp,ty,attr,rp,exp) ->
       let arity = exp_same (mcode2line lp) [mcode2arity lp;mcode2arity rp] in
       let lp = mcode lp in
       let ty = typeC arity ty in
+      let attr = List.map mcode attr in
       let rp = mcode rp in
       let exp = expression arity exp in
-      make_exp expr tgt arity (Ast0.Cast(lp,ty,rp,exp))
+      make_exp expr tgt arity (Ast0.Cast(lp,ty,attr,rp,exp))
   | Ast0.SizeOfExpr(szf,exp) ->
       let arity = exp_same (mcode2line szf) [mcode2arity szf] in
       let szf = mcode szf in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
