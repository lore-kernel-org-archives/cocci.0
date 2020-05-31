Return-Path: <SRS0=O8dQ=7N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA80C433E0
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F436206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLcPYUS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F436206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFSBqe009379;
	Sun, 31 May 2020 17:28:11 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 36B707752;
	Sun, 31 May 2020 17:28:11 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id ECAF83C89
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:28:09 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1043])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFS85J015063
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:28:09 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id nu7so3903082pjb.0
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zU4amKGusW40yYOw6SpmUuhDr+uqLTgraL7yGwd6ZOY=;
 b=fLcPYUS6MGiTfiiVvXxtkq8cgTI98nGPB4tOWqf5z5QcrT4xfD/PcxrjmVPihnyi59
 gZYnzgQ0waUNb7U3PVrJGBqJeuRAPbVOjaAQBLgXVNSD8nbtkWlF66TimxK8rEeO6cQu
 LnaZoMQUgtCAvP+XN51NrlYMoxfk1rTzj6hOuhGEOVmQ7Rb5r+R0vdYPZH1LKHVc18BG
 63m3X2uBnKmosIUqyH7hpBhW4Ec2py3dorO4hF6yPBRR2JVEmUpt82CrbC1IjYiCXGyU
 dsDtBbU39L4x7VFgIJ802/OACCpVMrCUG8l+7As/425RncA6KF/ZB4x0PaeSM9Fzuj0S
 M89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zU4amKGusW40yYOw6SpmUuhDr+uqLTgraL7yGwd6ZOY=;
 b=m6j4TxafN0WL4hXhRUVq+nO4TCDozs7dmQOP9dknxOcsI+6f3HLBMAYkwpmMDojFXs
 iabcD9ZNHx7cufWIAywAPHFafEqXdPxkJM59/dDY9hxrFBrFoRipIVnDG5hNhxGNU/PB
 zt72XkwJkWin4n7tNBl/BZnbR/UFnMu3eyH9skgc5MwiJKuCTy2G/29rANwjgGtBpQKe
 pqXsavOpH7tCWj3i6Qfmuq2dXdbHpCc9EwqToR3GRQlcONPAYPJnE0HoOo3cGcOs0G21
 QMCRt/pQmSX8JihfTl57TLV06beeO4j2X1Z9OHEc93sHqKfv0MxkRwAqohnecZSeuQKj
 tccw==
X-Gm-Message-State: AOAM533PA6qRrp4TbhqABXFSVSKToI4ytE8HyPwdZcjE4vH0V5RPrJ/O
 iWNugS3tbljZv5UOLJ4DLQ+Gr2qG
X-Google-Smtp-Source: ABdhPJyT3RJZEMPueeQkg4x1HnU2eb5R34tSjGYIkVZtzQN7jBZ3zzOFmI+0+wRJsMe4JkCDCVx+qA==
X-Received: by 2002:a17:902:ba8d:: with SMTP id
 k13mr16646870pls.290.1590938887659; 
 Sun, 31 May 2020 08:28:07 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:28:07 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:56:14 +0530
Message-Id: <20200531152621.2886-21-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:28:11 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:28:09 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 20/27] parsing_c: unparse_cocci: Reflect struct end
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

Struct end attributes are added to the SmPL AST. Reflect these changes
in unparse_cocci.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/unparse_cocci.ml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/parsing_c/unparse_cocci.ml b/parsing_c/unparse_cocci.ml
index 30050ea1..f0efc968 100644
--- a/parsing_c/unparse_cocci.ml
+++ b/parsing_c/unparse_cocci.ml
@@ -955,7 +955,11 @@ and declaration d =
       close_box(); mcode print_string rp;
       pr_space(); mcode print_string eq;
       pr_space(); initialiser true ini; mcode print_string sem
-  | Ast.TyDecl(ty,sem) -> fullType ty; mcode print_string sem
+  | Ast.TyDecl(ty,attr,sem) ->
+      fullType ty;
+      (if not (attr = []) then pr_space());
+      print_between pr_space (mcode print_string) attr;
+      mcode print_string sem
   | Ast.Typedef(stg,ty,id,sem) ->
       mcode print_string stg; pr_space();
       print_named_type ty (fun _ -> typeC id);
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
