Return-Path: <SRS0=O8dQ=7N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08A7C433E1
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6001E206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rq4nBbUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6001E206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFRaaa012678;
	Sun, 31 May 2020 17:27:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EFA4A7752;
	Sun, 31 May 2020 17:27:35 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A405D3C89
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:34 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFRXUX013220
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:34 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id p30so2319542pgl.11
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OLQ/cqD/PIME/yXpfozaq7fkE1pcQOwRe/iiEfP0pwY=;
 b=rq4nBbUQF45+Z2PDaUM5rL04umLwDSUyQvnX7gWHucju/31EBnTi7olQlIoDCtKI5V
 w8U9roQP/Bh+tBiR0bDaoFMnCHFvVKUHmt68ywRTKbbHqn2/dmRAUtdTSTqcvF7l6iZz
 tP/yAUOIACN3XylShXa7KWaRZV3rScgE4IxNTgoY2BVLZn4KvrCd9x55oZIZsQk2vhZt
 lOmKcp8sSZWcdmzBmaAwMTOnLvofWv8+TF2h0lWsDuGpvq5NEJEiMmZUilMOwNGozujH
 hFAvOCvI9p07Ni8ARXjcByOZX8eQlq9QdtvPYR4UEFfyYnQBFUzOL/ynw1+0J/rRrUSs
 rn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OLQ/cqD/PIME/yXpfozaq7fkE1pcQOwRe/iiEfP0pwY=;
 b=PJPlTNIak7LN/x+HisGXo9qSY8NysztF/AMd4RSFsTGA+PEI1ILTaK2lryeTXYbgnt
 IKhQ7h4fxnUDSR+j5dB4mTkQxqgKalOV77SiO5s0vqIpTvdZ772WqIEW2idgehd1zZ7d
 yCYLiVblSizqjJYSgO8LILPJ9HFOHGJVLOcE7JiEAHh9Axqji+QczN+fhDzIBF2yRZjB
 9a8DLtnnNqX2Y7Az5mm51tHBCxGL6j9J5iP/pAxSrwflXDBuUzq9cHt0YegOGwl+/oWz
 oPrU1+d7Gl7+bASu4j3yhxc8Ajh0yHY0V4djJuAbqM5TS7uceL4eHzFkM4WxRDadb9WP
 szwQ==
X-Gm-Message-State: AOAM5337/NcsajYz4bWL2UCyRLekd5WQnio2AXIPgJir/u25g18ONzG4
 t79k2OZJKmsrAQUSaMDomhVswUl1
X-Google-Smtp-Source: ABdhPJzp6hn/IiZCIT1R27ERqguwCUdKWhgC92CMtKuOV4KmzQqizsdQFlB3wmqOLazZ5KM29FESKQ==
X-Received: by 2002:aa7:9431:: with SMTP id y17mr16004030pfo.33.1590938852322; 
 Sun, 31 May 2020 08:27:32 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:27:31 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:56:03 +0530
Message-Id: <20200531152621.2886-10-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:27:36 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:27:34 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 09/27] parsing_cocci: check_meta: Reflect struct end
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
in check_meta.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/check_meta.ml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parsing_cocci/check_meta.ml b/parsing_cocci/check_meta.ml
index 7035766c..f651ff8b 100644
--- a/parsing_cocci/check_meta.ml
+++ b/parsing_cocci/check_meta.ml
@@ -292,7 +292,7 @@ and declaration context old_metas table minus d =
       (match Ast0.unwrap ini with
 	Ast0.InitExpr exp -> expression ID old_metas table minus exp
       |	_ -> initialiser old_metas table minus ini)
-  | Ast0.TyDecl(ty,sem) -> typeC old_metas table minus ty
+  | Ast0.TyDecl(ty,attr,sem) -> typeC old_metas table minus ty
   | Ast0.Typedef(stg,ty,id,sem) ->
       typeC old_metas table minus ty;
       typeC old_metas table minus id
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
