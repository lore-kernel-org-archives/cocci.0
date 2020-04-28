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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFE1C83001
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:05:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C8F20730
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHfNLVuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C8F20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SH5W2A010479;
	Tue, 28 Apr 2020 19:05:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A31D77807;
	Tue, 28 Apr 2020 19:05:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 955803DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:05:30 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SH5SQi012605
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:05:29 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id f7so10963235pfa.9
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Rrzz3VKyAplkiQoSTk8Ir4A1V86JltGAz16X3d5PyBk=;
 b=PHfNLVuUb1LexSd8MakxPJBFDVmxWAnmBO9h42GPnp3XJxYTwxJFr1xTxRTUPBx8R1
 VpEM/vt4boYEzsKiArDvKIzdSMye76QCjqdwyVZLYQ5o2+Z6brD3LV9TOC2aAeWpO83O
 XsZ/rk8eWHhFdMN3day5PyETooboCcxdN6hNuwaIUWpnl9jzgGE8OSzF8OdENK2hXVzS
 1OMv6HyC01Wt2EX1PK6IC3PsaUm8nSWXrYz3SAgpX2rsU1Cyjb8BHWV4+GO0lmpMvJlM
 mZc0zo7U4w+ugEKxZVJCSiNaTu6XsWX/PO7a8slHoGA7ZlMCAl4DBwtdV6ONBEvbQNse
 ijoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rrzz3VKyAplkiQoSTk8Ir4A1V86JltGAz16X3d5PyBk=;
 b=KTM6K5I0Nk9K0Fa0gpbOHfgQSnUJZTQ2LGI4eqks+KD/QZZs+NAQAj+HavUl6/6+vX
 i1aHu5T+8EcrRqjewSTlNPPXbm76aXsqdg0nO7enKrTGC1t2HcGovQDVuxNIA2cPA+7l
 r/HLjFkTJKGhhljwP+4bvK+twq6d6ElVDqK1COGKxcbYN6honj950oF1k7Syhk3KrYKX
 DZyKR5b2PsIZbehVJoUj6vd1Q9fPCml2At+If6ThH/USsR5iSGcIdMLhKXrWXuZlDINS
 x4UJu6GVZ51ggqDGBG6vHvKb4Om3yPMfMfuK5z83CGP62MQM0Hy3w11RBxos2W2Opp0b
 Cy7Q==
X-Gm-Message-State: AGi0Pub7sxfCW6/s0KCZdIUlN613l+f5qnjcYDWjoseFROTSYAD4Xwbh
 knmB3/6BRHzD+B2Lzdhs/H3QzZyqztA=
X-Google-Smtp-Source: APiQypLA61j/GwJXvcuQuAVo/LmvahNT0qtyqis2JhTEZA7pg05jEhuumoxj0K6mcfL7mPpvA+puyw==
X-Received: by 2002:a62:c1c1:: with SMTP id i184mr31850442pfg.18.1588093528183; 
 Tue, 28 Apr 2020 10:05:28 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.163])
 by smtp.gmail.com with ESMTPSA id u15sm2505097pjm.47.2020.04.28.10.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:05:27 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 28 Apr 2020 22:32:22 +0530
Message-Id: <20200428170228.7002-27-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:05:32 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 19:05:30 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 26/32] engine: check_exhaustive_pattern: Reflect
	Cast attributes
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
check_exhaustive_pattern.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 engine/check_exhaustive_pattern.ml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/engine/check_exhaustive_pattern.ml b/engine/check_exhaustive_pattern.ml
index 903c32ff..d7785fc7 100644
--- a/engine/check_exhaustive_pattern.ml
+++ b/engine/check_exhaustive_pattern.ml
@@ -123,7 +123,7 @@ let dumb_astcocci_expr = function
  | A.ArrayAccess (ea1, _, ea2, _) -> ()
  | A.RecordAccess (ea, _, ida) -> ()
  | A.RecordPtAccess (ea, _, ida) -> ()
- | A.Cast (_, typa, _, ea) -> ()
+ | A.Cast (_, typa, attra, _, ea) -> ()
  | A.SizeOfExpr (_, ea) -> ()
  | A.SizeOfType (_, _, typa, _) -> ()
  | A.TypeExp (typa) -> ()
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
