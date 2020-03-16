Return-Path: <SRS0=+m3J=5B=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBFCC0044D
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABFD220663
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a06Pyq2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFD220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GA4hm0029356;
	Mon, 16 Mar 2020 11:04:43 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 921787809;
	Mon, 16 Mar 2020 11:04:43 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9A6057802
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:41 +0100 (CET)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GA4dcr027852
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:40 +0100 (CET)
Received: by mail-pg1-x544.google.com with SMTP id m15so9452259pgv.12
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 03:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dqkv3oqMwtTa6d0C2gk8rkkDFXuoowFPaClNAY6dKVA=;
 b=a06Pyq2Ojb7wEsGm91//1BvYSdvaZSgtgA98Pgkgv6vQSfwtmyyMdiFcupEjBi92W0
 piY2Tc3qXthxI/VTaBSp0iIQvpyxA07lgjSKDfgL1PKJmVkAoCqvIaUdB/xbjbk8YJAq
 u9imwvMu+0uTIYnH31boT1mRVPWtbSn/zmXSf2j5U9z0mgCRn8e0aRrRKDvsQ25J4l6/
 mhlRXpp9vGz3WWQJctokd3qfjxCyXdPVKm1jqYN4kAJv0DFU9z0X/VwnPTtzZ0eqGcto
 /kjzSxB9h4ZTK4On29kN7bEx+m+vujihAwFxEf84OH2NWgC/LpVqVY5HVkIx+qV1SkYM
 NtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dqkv3oqMwtTa6d0C2gk8rkkDFXuoowFPaClNAY6dKVA=;
 b=DYZuc1n1El1sUIuW0GpV0Fg01agbVwCsehtVab/LMLmqg1XNP2/8yZnIgmj9ABrkH7
 0WIDoQgfrbh6fVzjUprBa2p/9EnXx4Xb5bane66poaKBp9ujG+2eQwSWv8NByVcrbudK
 OKNtC0yhTXgJjKyDocHvF+L3BfTjDX1nK77rU3u2HZ/LAyQRS8YD7MfJHjb7+WM8Txol
 mhqteEnx9L1fY3hK83dbQQ849n5yROqWfL4qdgAhxIu+kzbUhx14Mur9qfVGgt2dDH79
 quRBtflpkg0iWZBfS40OixyKMrCCjo5bGL0AX08nLW6129c+LR/G9mvFXalKMdfAfbB9
 mAcg==
X-Gm-Message-State: ANhLgQ3efsUdWCabfRh7vtTiaJZvhhLn/Gipkq2MVAAswKIvDaNR63tB
 +4oJWdqIoBE7MmTKV7u3WG65Diye
X-Google-Smtp-Source: ADFU+vuNSGvnN+XiyxhDBk0Y1sCD9fMNs/PcYnfwmBm7gAZ4+5uhfaKAuLrTXNqCTU6N3HIbs9pJDw==
X-Received: by 2002:a65:4081:: with SMTP id t1mr3387890pgp.134.1584353079205; 
 Mon, 16 Mar 2020 03:04:39 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:284:a4f2:cc63:b7fc:551c:dce5])
 by smtp.gmail.com with ESMTPSA id
 u3sm19803374pjv.32.2020.03.16.03.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:04:38 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 16 Mar 2020 15:33:12 +0530
Message-Id: <20200316100319.27935-20-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 11:04:43 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 16 Mar 2020 11:04:41 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 19/26] parsing_cocci: disjdistr: Add cases for
	ParenType/FunctionType
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

ParenType and FunctionType are now added to the SmPL ASTs. Add
cases for these types in disjdistr.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/disjdistr.ml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/parsing_cocci/disjdistr.ml b/parsing_cocci/disjdistr.ml
index 668a8810..91d7f1b8 100644
--- a/parsing_cocci/disjdistr.ml
+++ b/parsing_cocci/disjdistr.ml
@@ -73,6 +73,16 @@ and disjtypeC bty =
 	(function ty ->
 	  Ast.rewrap bty (Ast.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2)))
 	ty
+  | Ast.ParenType(lp,ty,rp) ->
+      let ty = disjty ty in
+      List.map
+        (function ty ->
+          Ast.rewrap bty (Ast.ParenType(lp,ty,rp))) ty
+  | Ast.FunctionType(ty,lp,params,rp) ->
+      let ty = disjty ty in
+      List.map
+        (function ty ->
+          Ast.rewrap bty (Ast.FunctionType(ty,lp,params,rp))) ty
   | Ast.Array(ty,lb,size,rb) ->
       disjmult2 (disjty ty) (disjoption disjexp size)
 	(function ty -> function size ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
