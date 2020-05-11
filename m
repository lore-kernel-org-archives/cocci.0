Return-Path: <SRS0=43Z/=6Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7340EC54E4B
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B122082E
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uP0gu4g3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B122082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA9ac6006809;
	Mon, 11 May 2020 12:09:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CA0173E6B;
	Mon, 11 May 2020 12:09:36 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 67E4E3DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:09:35 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA9XJm023462
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:09:34 +0200 (CEST)
Received: by mail-pj1-x1044.google.com with SMTP id 7so7259142pjo.0
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XsOUCWb5UG6k/8xHVHn/Y03zDxBj23UKsYCk5pFSAy4=;
 b=uP0gu4g3fUuUWBEgNz5Nqzy4+nIt8GKdWO/h/ERjwlD/spSR6/HRhbPBK2jOvZSROy
 2DC3DmwB7fVhNB3zZXyZHlFlHGpXNU6D3Hk7K9oS81WclnKLx2yR0tX9xZhippCDHi2T
 6HmpyNUDA3oAnSfVymD1S+qA3mFp4bq+Xbqs8F/jzlNCLJ0nbyJitx7R2i2J0oSZzuAO
 kn7COFZ0QLc3Y3u/lO7P1N99SqLbSs3O0dOP68f3lQZ/EMSlf/uP4qoOYRc40OCsxH7j
 H/+pW+UtS6j/ZReEGoleM56ItKGhmL4WuZCAF9MVWDbFJ8If9oCLABEeC75R4OKdrzEY
 hnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XsOUCWb5UG6k/8xHVHn/Y03zDxBj23UKsYCk5pFSAy4=;
 b=sgCyz8WlvcnWleEwob8eGDtXP/ewTMLCFPYl5WZ8Xo34Ij6e4XjgDRQKb82keCiPWk
 w+5Y5WiEjEA0kfKf6ZY2NsugIljtAva+lo0uSYj9SBHa1on5GlLqMoefLMIv2GzQGJjw
 ZZ69w9GHMpjHl4wXf4UMpZMVrni/37ZQdMOi7mNc42ug1HEF0xVjoKZUVhV0rbVHMW9v
 3BkpIzMQHQeiuYExmIAuTn68soPZXara1uMRg60450awPpGPTIeVZ4r0rA7TDzDNcZJY
 dfd/mOpn4eVxFqvl8++c4f/v1nNsiSeNrlVmst3UvhFNCL753rANX+FSfer/fYAAWiRm
 YGWw==
X-Gm-Message-State: AGi0Pub0yOwDleBCjd0GKQX0C5x8CWo9tx/+kl40/Qi1Fz0CxS+rgie/
 efYVKIxnbfy692u4J8mmlePWXviT6kY=
X-Google-Smtp-Source: APiQypLCKrmpPawaTIiaEP0hZjWBQoqVZGbo4QDncI3H3XkwbSHFXscC8HDKCrL3A7QwqZQqBShnSg==
X-Received: by 2002:a17:90a:376c:: with SMTP id
 u99mr21750489pjb.228.1589191772862; 
 Mon, 11 May 2020 03:09:32 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:09:32 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:37:12 +0530
Message-Id: <20200511100715.19819-30-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:09:37 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:09:35 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 29/32] tools: spgen: Reflect Cast attrs
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
