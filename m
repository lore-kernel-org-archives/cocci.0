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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7626C83000
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:06:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3417520730
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBUiCgUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3417520730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SH5xsG027663;
	Tue, 28 Apr 2020 19:05:59 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DC7207807;
	Tue, 28 Apr 2020 19:05:59 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 291173DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:05:58 +0200 (CEST)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SH5uVK022175
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:05:57 +0200 (CEST)
Received: by mail-pg1-x542.google.com with SMTP id t11so10654721pgg.2
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 10:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XsOUCWb5UG6k/8xHVHn/Y03zDxBj23UKsYCk5pFSAy4=;
 b=CBUiCgUwMgq1h5ERuBei3XFP6NIsvhhI2BDBiIxe28a5s0D0s6Y9VnawypNomfGDxp
 2uOEnY93yJs8c9RckPom86jGfkpECuLFGIK+1Le9CO3vTKV0cYZjo4Ns5frouJJ6/Q6V
 tu8FJWUFdMy5xj143M2GhL3Pl89It+bQO7d7WX8fNq+5HsSGfYitdM/MkuyfGymrcwcN
 csiUCjdczF1ifTF915Ar65a7i2is+85MXZfjXSdkO5oSdTQKTnMW2P/kR4g0BZPNC1F1
 Jz8oaXDyMCIL4/16vSg6H/wkXGhwb23SWdL2LDMRyROCzbp/vYTxE8i/TJb6zl+zDc1h
 lsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XsOUCWb5UG6k/8xHVHn/Y03zDxBj23UKsYCk5pFSAy4=;
 b=Ruo8qJSw/0ScbrCgjtdAvxa57ZjmueNpNWAKE6nhRHfAIQdF6vHe//elrItbj5EDhJ
 vuAVp7g0XHsW3nXvTTBiGppchM0lVGqytHrhwxUe7YCG1bssbIzjCd8zEY7pVdhfk+9A
 GETftikZP5Cn39orf/urW9OWv249DOmOOCahtSOo4AadHj3JeDLmi5kzPZWwaFYtcV3G
 dNQah7xaO87JB+07YwegpCzfPDYj2Kyp1FI95M2njNv4Ii1Dl6QqqHRVe2ONTLsLhYOY
 MA7XFTzWfQUsMURUCRo3LuSZKi9HXA8OKNjWyTtVzeo222VDoLRiBBiCy/q/hQDXWa5y
 Tm+A==
X-Gm-Message-State: AGi0PuaiY4woIM8hh5qilsFqE6DQZl6AgZEH+qgfUWFh/1D8K4L+PTvj
 UybsVEO3jQ4NOmGQ7ZDuLOUhjNCrpZU=
X-Google-Smtp-Source: APiQypL3VtY0CkM8YLF0ZS8oxllt7cNj28YdBUiy1H25Ft8TZdm8BrvhZipBiWqURgbcKhBu3V7ChA==
X-Received: by 2002:a05:6a00:2b4:: with SMTP id
 q20mr30718030pfs.104.1588093555747; 
 Tue, 28 Apr 2020 10:05:55 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.163])
 by smtp.gmail.com with ESMTPSA id u15sm2505097pjm.47.2020.04.28.10.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:05:55 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 28 Apr 2020 22:32:25 +0530
Message-Id: <20200428170228.7002-30-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:05:59 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 19:05:57 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 29/32] tools: spgen: Reflect Cast attrs
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
position_generator.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tools/spgen/source/position_generator.ml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/spgen/source/position_generator.ml b/tools/spgen/source/position_generator.ml
index 757faf5f..9143a474 100644
--- a/tools/spgen/source/position_generator.ml
+++ b/tools/spgen/source/position_generator.ml
@@ -359,9 +359,9 @@ let rec expression_pos exp snp
       let c ~exp ~id = Ast0.RecordPtAccess(exp, arrow, id) in
       let alt() = id_wrap ~id ~constructor:(c ~exp) snp in
       exp_wrap ~exp ~constructor:(c ~id) ~alt snp
-  | Ast0.Cast(lp, typec, rp, exp) ->
+  | Ast0.Cast(lp, typec, attr, rp, exp) ->
       let _ = type_pos typec snp in (* sanity check for disj *)
-      let c ~exp ~mc = Ast0.Cast(lp, typec, mc, exp) in
+      let c ~exp ~mc = Ast0.Cast(lp, typec, attr, mc, exp) in
       let alt() = mcode_wrap ~mc:rp ~constructor:(c ~exp) snp in
       exp_wrap ~exp ~constructor:(c ~mc:rp) ~alt snp
   | Ast0.SizeOfExpr(sizeofmc, exp) ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
