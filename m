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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE40C83001
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:04:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD02420730
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfHdJaea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD02420730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SH45oE008336;
	Tue, 28 Apr 2020 19:04:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 833B47807;
	Tue, 28 Apr 2020 19:04:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 552593DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:04:03 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:644])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SH416i014763
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:04:02 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id v2so8619064plp.9
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 10:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9+LCecuHRzdR/o7M/ikGH5G4JrMwoDyf73lHut0jbu0=;
 b=cfHdJaea6GdJ+OdQbhn4F5Ou7Kpvtbxkl8eoJLllM/XnfYnDcsd4lprG8i4SasKmn6
 SNhAYchRMI+oxGij2qdBfODjx1rmECLK5CGmEg7ACxZjpdhLWgV4wKuVrtcuxl8yeH/9
 m/AAq9EA8Wh/ScimvYz5bqugY7OmXxI3SGOs2Rpal9zKrD0QZvwmlqrjqEFEHnw+Xde9
 RpPAYXUHIMtUAaaH4T7YwFnbpq+7ByvFKdijDorWM8StKBss9wtjFhdPeif6uTzedLcx
 1xoVlgeIDn6h5j3dY0NrLRdNkO1dCCwjaTfZqoU+3DE/bNWKysvYjmFEeHJUky5RaKb0
 xO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9+LCecuHRzdR/o7M/ikGH5G4JrMwoDyf73lHut0jbu0=;
 b=jypLAqVJ481GEb7izKi6l72D3ejJairHPGXVykZwCJm4hFa2Lfw1xHX8kqGsQ/ymGg
 YDgFDDQXZ0U0qT+GcfIbP+ZLiZ6VEKjD2R8wo6CbS+lmCSzNivNlVO3G0joFK4a48upd
 JQWf6Us1ZwLvo5kjviedact7UkJ8n69Ha/HrBLLLrHRaU54pO3I4tUeQIxWxPjjZA9kx
 3gTfSNBvWGn/cOmLK1idndaNP7OQ9TYpisSxxsXn/+rGFzWqVASfF+ygiam7mPo9h03g
 1VJO/FCs5slCHIIFHgw53J6L6C0CYxp/LDYNB/fVtcoaqSicxSkqdUq3qN+XnxSLwpwr
 g2oQ==
X-Gm-Message-State: AGi0Pua8S6+/ICeFj9PHm2Q5VWdshncjlfR2tLATNaQlAEKXZSFHDUGp
 6jj4RDTpKReGKmpGytYsadgX098/JJw=
X-Google-Smtp-Source: APiQypIy5CTFMeQW13OAjizD6NjHNeoY2x6cpwm40OiDjsXhI9NhZM9xVjmFi8bTADF1I7mvRqTmfQ==
X-Received: by 2002:a17:90a:e389:: with SMTP id
 b9mr6061256pjz.141.1588093440968; 
 Tue, 28 Apr 2020 10:04:00 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.163])
 by smtp.gmail.com with ESMTPSA id u15sm2505097pjm.47.2020.04.28.10.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:04:00 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 28 Apr 2020 22:32:15 +0530
Message-Id: <20200428170228.7002-20-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:04:05 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 19:04:02 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 19/32] parsing_cocci: unify_ast: Reflect Cast
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
unify_ast.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/unify_ast.ml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/unify_ast.ml b/parsing_cocci/unify_ast.ml
index 68cb6613..25287503 100644
--- a/parsing_cocci/unify_ast.ml
+++ b/parsing_cocci/unify_ast.ml
@@ -220,8 +220,10 @@ and unify_expression e1 e2 =
       unify_expression e1 e2 && unify_ident fld1 fld2
   | (Ast.RecordPtAccess(e1,pt1,fld1),Ast.RecordPtAccess(e2,pt2,fld2)) ->
       unify_expression e1 e2 && unify_ident fld1 fld2
-  | (Ast.Cast(lp1,ty1,rp1,e1),Ast.Cast(lp2,ty2,rp2,e2)) ->
-      unify_fullType ty1 ty2 && unify_expression e1 e2
+  | (Ast.Cast(lp1,ty1,attr1,rp1,e1),Ast.Cast(lp2,ty2,attr2,rp2,e2)) ->
+      if List.for_all2 unify_mcode attr1 attr2
+      then unify_fullType ty1 ty2 && unify_expression e1 e2
+      else false
   | (Ast.SizeOfExpr(szf1,e1),Ast.SizeOfExpr(szf2,e2)) ->
       unify_expression e1 e2
   | (Ast.SizeOfType(szf1,lp1,ty1,rp1),Ast.SizeOfType(szf2,lp2,ty2,rp2)) ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
