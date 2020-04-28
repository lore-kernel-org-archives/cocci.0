Return-Path: <SRS0=bJsz=6M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B982DC83001
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:03:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496C0205C9
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBecdJmk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496C0205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SH3cmV002567;
	Tue, 28 Apr 2020 19:03:38 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B1F6E7807;
	Tue, 28 Apr 2020 19:03:38 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1845C3DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:03:37 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SH3Z28020562
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:03:36 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id x15so10982955pfa.1
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 10:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u8KQVzS3ah3vs2qqwXtIf9FY1LkUh04IBlZi8QJebGs=;
 b=XBecdJmk95huRv0S5nPxXlQAaP0U+TAIxD/Wl5dOmK0zeo8LxITj82F62SdOO9FAO5
 PA7OVdkAGUs6+6TFgu06pYJNOE9N3Q1GL7J3s36T2T759OHt43gc+ACdAfaTFH3aFxG6
 Xo1LS1OWzIpYRacfLmfsPEsRAqBBgsAaOnd1AKlUpJG+EyPTMc51V9TWlbpml8JfJctd
 stLl463Hand6/fKAMZzyTTdzVnB309UrXOofz3ZKwv1QPF+wcikUgXeWaDERWvQ09ot1
 NHc4kNvzTHDyKhuhRWCtKWFKNBpihNFmjK5KzQWWin5QgNZ1QKuLWgHdvC6Ra2hK2ROZ
 D/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u8KQVzS3ah3vs2qqwXtIf9FY1LkUh04IBlZi8QJebGs=;
 b=c/X+9QS/RcB1LR5bNWcdfhxNmPe69u5UW3cbNu3HE0clASFA51/OxbPE06MNb3QP1+
 tQk7aSdPDegKIbj44Whl4e+cwgOkYeo9wIqgN9m3sKQvtvR/50q3YTCa1A/F7iO9UnbX
 qZxt91g43YdrNQYYxjRlYDJdWjuCfhPMgTAOU8UrA32R5JSnZdoJpJzx2LJRRXvhAHHw
 zOAxwxSzOGzeCBezYSiNyfCyoRhniaaTrkbGDjCUsnzzbg4+9RfQlbvLJ4y7Brlw1dyq
 DTmQA7CgA0kbKHqq1BLQpqDuVgyj76zWT8WAaDmU2bi/YV64vIK1r39vSL+fKJHdGN7t
 TAzg==
X-Gm-Message-State: AGi0PuaxFmyT20v7rXx7NP7yoBMOG5wjmxSNdPJ99xP7M0bZtIUeStLW
 9FFNr1sS0mopDpIQSEj58JOodDJU9gw=
X-Google-Smtp-Source: APiQypKx66FQk1P6SD4E2+1+2bpiUorhQiumhvWo4rXT0cqWxEZPYtXPk1jcfwa0hrX0+1LXlWIkgA==
X-Received: by 2002:a63:e04e:: with SMTP id n14mr22251184pgj.147.1588093414752; 
 Tue, 28 Apr 2020 10:03:34 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.163])
 by smtp.gmail.com with ESMTPSA id u15sm2505097pjm.47.2020.04.28.10.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:03:34 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 28 Apr 2020 22:32:09 +0530
Message-Id: <20200428170228.7002-14-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:03:38 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 19:03:36 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 13/32] parsing_cocci: single_statement: Reflect Cast
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
single_statement.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/single_statement.ml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parsing_cocci/single_statement.ml b/parsing_cocci/single_statement.ml
index 4ad1c4e4..73554e9c 100644
--- a/parsing_cocci/single_statement.ml
+++ b/parsing_cocci/single_statement.ml
@@ -138,7 +138,7 @@ let rec left_expression e =
   | Ast0.ArrayAccess(exp1,lb,exp2,rb) -> left_expression exp1
   | Ast0.RecordAccess(exp,pt,field) -> left_expression exp
   | Ast0.RecordPtAccess(exp,ar,field) -> left_expression exp
-  | Ast0.Cast(lp,ty,rp,exp) -> modif_before_mcode lp
+  | Ast0.Cast(lp,ty,attr,rp,exp) -> modif_before_mcode lp
   | Ast0.SizeOfExpr(szf,exp) -> modif_before_mcode szf
   | Ast0.SizeOfType(szf,lp,ty,rp) -> modif_before_mcode szf
   | Ast0.TypeExp(ty) -> left_typeC ty
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
