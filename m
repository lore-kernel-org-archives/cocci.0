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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778E3C433DF
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA438206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSWFN84T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA438206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFRgQc000478;
	Sun, 31 May 2020 17:27:42 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CC2AE7752;
	Sun, 31 May 2020 17:27:42 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0A19D3C89
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:41 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1043])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFRdE6018065
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:40 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id fs4so3904515pjb.5
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6L99YIbczK8ww6izwOowhRAEm6cO+5mBUJvpTwe6i4g=;
 b=mSWFN84TLxSdkskZ4cZ56blCcGnFkEFHzLH0Osr2U4ee62aU7bOF5Iq9iqCTUW56kA
 N0MQz9nOnaVwDXL623dpkjW9QyjQswAiUeJW9u67cmWSxWlZcbxhKNyNWswXtrzCHt/E
 SoZPU9B8IXVAfp9jHDyWfLLYhEOlSZ1R5qeDHyTILLpBKa7yiEKf+iMyTaGl0IIQwDOL
 55rmpE7qcqVLYzmBWt6+P8ynqjD9EfKMT48rNjepfcWm66lF59Bf0qn7xoP2HxS3csot
 Zu+t380Yjxfz8yuk+cvdht7LsDu+9mieO5eLCacYxcZNs9yXzUqd6R/Lg63/Tb/dKeJo
 r7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6L99YIbczK8ww6izwOowhRAEm6cO+5mBUJvpTwe6i4g=;
 b=V9NrgIDFOOmMLaMs5OeGu9KPfY44MYLjLILVmICeBPGrzDW7IAqFn2SuCRahwEwYYy
 FxSneRnqLcMeOovjDHUgSgk0Hiu/STt6lNnTc+r6ApBGDVZwsqdluL/vc8KEivHFL+Ag
 kPI2ApkPXJBBqW52PFKBytwtGbn7k3WiBNdf4kvFaX57/9yCLjrWOOr0oBVtJ22YzWGM
 cLv3v9Piu9lgDqhNBzTbpI5aij4Br3Y1YkQNvWDDpA1XrsmiiBtn0J5Z5GylT9YjXNll
 NSmPFE8pfkpdz5ygpboYYwTgCfGU0JTrWW97Gc95Wl8Q4N35Yd0jdPO7czuyAe7I9tUm
 MDlg==
X-Gm-Message-State: AOAM532UzsZDnh9PphWaLpDa5oTcPebk9I012XR0J+h6HuaNbF6XtZR6
 +ZLNpFHkfcwSR4mpudrl/EJ8Zjb+
X-Google-Smtp-Source: ABdhPJyH54IqKpZ1VmC7ag4Nco1E6y0VSCwoOG9vhJ6FaUZS0/bqMuE2KOZTLxIUSme3vcfkDx7ylg==
X-Received: by 2002:a17:90b:1002:: with SMTP id
 gm2mr19282084pjb.197.1590938858691; 
 Sun, 31 May 2020 08:27:38 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:27:38 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:56:05 +0530
Message-Id: <20200531152621.2886-12-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:27:42 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:27:40 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 11/27] parsing_cocci: context_neg: Reflect struct
	end attributes
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
in context_neg.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/context_neg.ml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/parsing_cocci/context_neg.ml b/parsing_cocci/context_neg.ml
index 5354bb3e..41bc621f 100644
--- a/parsing_cocci/context_neg.ml
+++ b/parsing_cocci/context_neg.ml
@@ -763,7 +763,8 @@ let equal_declaration d1 d2 =
        equal_option stg1 stg2 &&
        equal_mcode lp1 lp2 && equal_mcode rp1 rp2 && equal_mcode eq1 eq2
 	 && equal_mcode sem1 sem2
-  | (Ast0.TyDecl(_,sem1),Ast0.TyDecl(_,sem2)) -> equal_mcode sem1 sem2
+  | (Ast0.TyDecl(_,attr1,sem1),Ast0.TyDecl(_,attr2,sem2)) ->
+       List.for_all2 equal_mcode attr1 attr2 && equal_mcode sem1 sem2
   | (Ast0.OptDecl(_),Ast0.OptDecl(_)) -> true
   | (Ast0.DisjDecl(starter1,_,mids1,ender1),
      Ast0.DisjDecl(starter2,_,mids2,ender2))
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
