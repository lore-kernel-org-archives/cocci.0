Return-Path: <SRS0=FJ6B=7K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CDBC433E0
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:26:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4839C20888
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSJK1YEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4839C20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04SCQ6AP029153;
	Thu, 28 May 2020 14:26:06 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EDADC5D47;
	Thu, 28 May 2020 14:26:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 907613E1D
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:26:04 +0200 (CEST)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04SCQ22h020938
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:26:03 +0200 (CEST)
Received: by mail-pj1-x1041.google.com with SMTP id ci21so3138073pjb.3
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 05:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R4XE5uPcNgqgWnR2Cr0pQe97/Ns3BG8LcPaOZ3ZDM6I=;
 b=JSJK1YEcUw+tXh4ctftmUqWz+jVmYW3JcNPpHG24x+yA5BC2UHpT3dYvWL12ZcSEZU
 neULlVZ/wIHvbc1FJa5Rc05+rkd6JDJ1tzsyLZ/R6tLhpJegtPTMUCPtk7gUAgprHJ8C
 JQPUqsDU/pR1GY/diVtMWobzNhTnqIlHxrBIfIS3scst3kkjjgn9YBDR4BbHGVBTSrZm
 yBqsH5luvkWRUXbaBilpTr8uOPtmB+EojIeKJjE816+dyUEUYJfv8Yxil+QKUpz38Y3L
 uQBcM7V6m8UX5RAIcOGklns/0EKx03QUxdzNw7rYk+7YeQDYdWZWbbVC4f830UTM4cvm
 n30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R4XE5uPcNgqgWnR2Cr0pQe97/Ns3BG8LcPaOZ3ZDM6I=;
 b=riBfWaZtqev9kFfyfbD4CMr3n+Mo8Fj1jOYuPF4Gy/koj2Fk4HMQJRo66nVszX1pGz
 hUg0QRiaDwxVZjiWBEPkVVHi6ay2pu7dsu+Hao98kMSutJIH06aKTUkZMEr5XzhIf4DQ
 QI4gIRkvmtXvDBbmFyd+J5/B3r+E0Dnubpx8xabmf3A76Tkt8JenbUQJA9kpLSQBEo+o
 mVvWopj1So375vlSxPM25NSbqYPHNFUGtvo+Zg/jaTHzYod//4oI3v8WEKaqtI3nCRiA
 t0JpMJy8HY72PRpc80i3t5slsxqZU3us2AapVaTleI0ZgUHxod06Ny7t0dNa4MzO57aS
 fg1A==
X-Gm-Message-State: AOAM531nDnap55pfqcF6x0vHH8am48warIb18P1P2C6/ma5DFYis4enA
 MnRDTAXOqGREf6eXtvCbs5E+JUcC
X-Google-Smtp-Source: ABdhPJz1DabSFsd1LZyX3pcB+IN6N6zm6ha3mHKorH2hgfMfPJaQ2pGMpTP2WVzMTcf+J+RcL9npnw==
X-Received: by 2002:a17:902:bb87:: with SMTP id
 m7mr3265232pls.270.1590668762273; 
 Thu, 28 May 2020 05:26:02 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2183:e360:deba:7bf4:98ef:5568])
 by smtp.gmail.com with ESMTPSA id 1sm5722888pje.26.2020.05.28.05.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 05:26:01 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 28 May 2020 17:54:25 +0530
Message-Id: <20200528122428.4212-24-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
References: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 May 2020 14:26:06 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 May 2020 14:26:04 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 23/25] parsing_c: type_c: Add parameter
	attributes to record
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

Paramter attributes are added to the C AST. Reflect this change in a
case in type_c.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/type_c.ml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/parsing_c/type_c.ml b/parsing_c/type_c.ml
index 4a85b683..617b6fc6 100644
--- a/parsing_c/type_c.ml
+++ b/parsing_c/type_c.ml
@@ -304,6 +304,7 @@ let (fake_function_type:
                 { Ast_c.p_namei = None;
                   p_register = false, Ast_c.noii;
                   p_type = ft;
+                  p_attr = [];
                 }
               in
               Some (paramtype, ii)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
