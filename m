Return-Path: <SRS0=cw0N=6I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB1DC55194
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F05720724
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKeLOXQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F05720724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03O9JNF4010076;
	Fri, 24 Apr 2020 11:19:23 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5C6347827;
	Fri, 24 Apr 2020 11:19:23 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 61BA17815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:21 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:644])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03O9JJ4F021588
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:20 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id ay1so3543485plb.0
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 02:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ufMl+xv8bNr3ftwXMxG2RrjAxFKAfKqTdDmc4xiwlvI=;
 b=hKeLOXQK+anrkJIwN03BrlyGyqanCGQP72PFAJxR94SrH7qknLnRuf8rdhpI5AmrTA
 DD4u0AkOrHkrzId/gMpxSm6tKmeTzE76hu1GBt/QQQAmauXqGsJBoMrIyqA8fRLYiWx/
 +4gukWytuNstN/v9NqTwwZS5zrl093VFav+ac9syLavobT7x8lZWnCLo8bqqtDfA4QeX
 dwlYXU1qLYMXK8w+lbcFOQjHfm+VB7r6lC3wBNmxUWcHnkZLYiH7ZoPFkTNE0ajzu7x3
 mF+QBRmWB0oaB3dryH2Q6WV/IXPhPgepPMzGYhv0VKhsMvnq1SyO8BHnV8dESaAgymAt
 ycsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ufMl+xv8bNr3ftwXMxG2RrjAxFKAfKqTdDmc4xiwlvI=;
 b=f6wwx4Itg9Vs5XkidBdWNSHG//BR3//wVX5UdSqnn4ZUjtbkA4nlD3sf8yKId1zhTq
 Fnl+MicBcQkQz1jAx099M3ADsoIwtyqjQbfqwg6A2Mgn2nte96XTXPdHA4Q3+RYhNikE
 EFDvJzF5dJYx6BWLNT3Cas5df18HnEG5R/M/6L1ZWiipqXb/lll9NCRHXcoJt6e4ZHLY
 KUjLtcHQtpRzqXjd+UiiYukzqOzzwaPi64jIdVWJmuhRAk/adGFmRwZIS6YRj9iBwRVE
 V7UeYuR8t/oujwox2dMRPvGc7hv/vXgjx10O47nCTEiHPcaCBpw1juuCt4Z29xT0C7jN
 3uug==
X-Gm-Message-State: AGi0PubrY9T+eYJrWRnC/1hno9l/s+t0nz563oHVlWdUWZy3ALIYii54
 lnf3JSyR9H/yVCsceW7koO8wo4WJy6A=
X-Google-Smtp-Source: APiQypIcR8Jvz8oBparLORczG99zLOjNeB94lkyUxrPLF02Ri+t6vV51c+ydnb5GowkH8Wr4Zc1vJg==
X-Received: by 2002:a17:902:a515:: with SMTP id
 s21mr8482010plq.41.1587719958781; 
 Fri, 24 Apr 2020 02:19:18 -0700 (PDT)
Received: from localhost.localdomain ([1.38.216.60])
 by smtp.gmail.com with ESMTPSA id c80sm5043933pfb.82.2020.04.24.02.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 02:19:18 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 24 Apr 2020 14:47:49 +0530
Message-Id: <20200424091801.13871-14-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
References: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 11:19:23 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 24 Apr 2020 11:19:20 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [RFC PATCH 13/25] cocci: standard.h: Annotate attributes
	with MACROANNOTATION
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

Apply the MACROANNOTATION hint to select attributes in standard.h. These
hints can be replaced, removed or added by the user as their use case
demands.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 standard.h | 116 ++++++++++++++++++++++++++---------------------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/standard.h b/standard.h
index 7a7f96ea..a25d2ae7 100644
--- a/standard.h
+++ b/standard.h
@@ -87,46 +87,46 @@
 // ----------------------------------------------------------------------------
 // Attributes. could perhaps generalize via "__.*"
 // ----------------------------------------------------------------------------
-#define  __init
-#define  __initconst
-#define  __page_aligned_data
-#define  __page_aligned_bss
-#define  __always_unused
-#define  __visible
-#define  __exit
-#define  __user
-#define  __iomem
-#define  __initdata
-#define  __exitdata
-#define  __devinit
-#define  __devexit
-#define  __devinitdata
-#define  __cpuinit
-#define  __cpuinitdata
-#define  __init_or_module
-#define  __initdata_or_module
-#define  __pminit
-#define  __pminitdata
-#define  __irq_entry
-
-#define  __cacheline_aligned
-#define  ____cacheline_aligned
-#define  __cacheline_aligned_in_smp
-#define  ____cacheline_aligned_in_smp
-#define  ____cacheline_internodealigned_in_smp
+#define  __init MACROANNOTATION
+#define  __initconst MACROANNOTATION
+#define  __page_aligned_data MACROANNOTATION
+#define  __page_aligned_bss MACROANNOTATION
+#define  __always_unused MACROANNOTATION
+#define  __visible MACROANNOTATION
+#define  __exit MACROANNOTATION
+#define  __user MACROANNOTATION
+#define  __iomem MACROANNOTATION
+#define  __initdata MACROANNOTATION
+#define  __exitdata MACROANNOTATION
+#define  __devinit MACROANNOTATION
+#define  __devexit MACROANNOTATION
+#define  __devinitdata MACROANNOTATION
+#define  __cpuinit MACROANNOTATION
+#define  __cpuinitdata MACROANNOTATION
+#define  __init_or_module MACROANNOTATION
+#define  __initdata_or_module MACROANNOTATION
+#define  __pminit MACROANNOTATION
+#define  __pminitdata MACROANNOTATION
+#define  __irq_entry MACROANNOTATION
+
+#define  __cacheline_aligned MACROANNOTATION
+#define  ____cacheline_aligned MACROANNOTATION
+#define  __cacheline_aligned_in_smp MACROANNOTATION
+#define  ____cacheline_aligned_in_smp MACROANNOTATION
+#define  ____cacheline_internodealigned_in_smp MACROANNOTATION
 
 #define  __ALIGNED__
 #define  __3xp_aligned
 
-#define  __pmac
-#define  __force
-#define  __nocast
-#define  __read_mostly
+#define  __pmac MACROANNOTATION
+#define  __force MACROANNOTATION
+#define  __nocast MACROANNOTATION
+#define  __read_mostly MACROANNOTATION
 
-#define  __must_check
+#define  __must_check MACROANNOTATION
 // pb
-#define  __unused
-#define  __maybe_unused
+#define  __unused MACROANNOTATION
+#define  __maybe_unused MACROANNOTATION
 
 
 #define  __attribute_used__
@@ -139,27 +139,27 @@
 #define  __xipram
 
 // in the other part of the kernel, in arch/, mm/, etc
-#define  __sched
-#define  __initmv
-#define  __exception
-#define  __cpuexit
-#define  __kprobes
-#define  __meminit
-#define  __meminitdata
-#define  __nosavedata
-#define  __kernel
-#define  __nomods_init
-#define  __apicdebuginit
-#define  __ipc_init
-#define  __modinit
-#define  __lockfunc
-#define  __weak
-#define  __tlb_handler_align
-#define  __lock_aligned
-#define  __force_data
-#define  __nongprelbss
-#define  __nongpreldata
-#define  __noreturn
+#define  __sched MACROANNOTATION
+#define  __initmv MACROANNOTATION
+#define  __exception MACROANNOTATION
+#define  __cpuexit MACROANNOTATION
+#define  __kprobes MACROANNOTATION
+#define  __meminit MACROANNOTATION
+#define  __meminitdata MACROANNOTATION
+#define  __nosavedata MACROANNOTATION
+#define  __kernel MACROANNOTATION
+#define  __nomods_init MACROANNOTATION
+#define  __apicdebuginit MACROANNOTATION
+#define  __ipc_init MACROANNOTATION
+#define  __modinit MACROANNOTATION
+#define  __lockfunc MACROANNOTATION
+#define  __weak MACROANNOTATION
+#define  __tlb_handler_align MACROANNOTATION
+#define  __lock_aligned MACROANNOTATION
+#define  __force_data MACROANNOTATION
+#define  __nongprelbss MACROANNOTATION
+#define  __nongpreldata MACROANNOTATION
+#define  __noreturn MACROANNOTATION
 
 #define  __section_jiffies
 #define  __vsyscall_fn
@@ -193,9 +193,9 @@
 
 
 // last last
-#define __net_init
-#define __net_exit
-#define __net_initdata
+#define __net_init MACROANNOTATION
+#define __net_exit MACROANNOTATION
+#define __net_initdata MACROANNOTATION
 
 #define __paginginit // in mm
 
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
