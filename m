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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF5AC18E5B
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A5D520663
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkPjBvPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5D520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GA4Nkp014220;
	Mon, 16 Mar 2020 11:04:23 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A029A7809;
	Mon, 16 Mar 2020 11:04:23 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 420CE7802
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:22 +0100 (CET)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GA4Jfr008596
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:20 +0100 (CET)
Received: by mail-pg1-x544.google.com with SMTP id b22so3468833pgb.6
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 03:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xD9df8bv9wIYUBatbkENn7i6mJZ18F2Xo6z3HsOAU7Q=;
 b=rkPjBvPMbZCSTDjFv0Jgl6CGcnV0+GzWoZPTBlYoZroCMPFR3FMd8jPi845jVF4YIw
 QGlL9LOvpxRuJapA9E15dgxxiIDOXRYZHVCijs3YqjnilmFgVHZVchHQqPnr5Bwo0c9M
 9LLG1rKH9epCk0RNKxJ+HnbJvmAjSLbKcsNvbzOAgH1y0hQ7yENPTUN7y/wXHguI4+Ow
 e/HFYMXKGgeudZbdm+pGDcNgoPrBwutojJqH1Ht3hoOBUq6eGtehPwREnS5iwq/CpCnO
 4UayFMi5otNdag3m0MgOIxLUZFcCaTO0yTONExArOGM8nsfIf0tt9XRmJAYomJPdbhF0
 VYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xD9df8bv9wIYUBatbkENn7i6mJZ18F2Xo6z3HsOAU7Q=;
 b=fDUdiH+eOibeICl6CCvnAK3GFoWwS80TA6rEKpcVBiirZgakel5jJscm154XBtIu2J
 SOXlYLOjRn+nfM7WSsz3vWb8wn95GhChNJUAc7NerVFluME3WyL8cohAfRHgqlMmcxMA
 c/sdgJOABuABoygD4B1WX/+ZWj54K2fgIWs/X0yLU7nyyBQWggPAp6W9cmZua9UCvl/R
 Gz6Z+c0JFnGeCMI7CXntSISRXKzKQI2RAd/8k2Uj962ZPYby15ubcDO+CL4KpH4u53Nx
 7jrTlFSMkyjfdqMZCxMDy/hO1LH4McWorHYtV4KEQAzHHPPLYdF1jjFMoHyNTqvS8X69
 ymjg==
X-Gm-Message-State: ANhLgQ3o1seaKlUOwIY4Wu/seplIwVkBmH0qY0Q5qwX1MxYMDow1HgHL
 llNtUCeGcZopql6zZtau/VAwMb4f
X-Google-Smtp-Source: ADFU+vuM52W17+/747GrdB4L+PSxYqj2/8Miydnbr4IaPTKx1SWZPHMSF1nj9LbYR0xGMMJx6i4Z7Q==
X-Received: by 2002:a62:31c3:: with SMTP id x186mr15929273pfx.5.1584353059227; 
 Mon, 16 Mar 2020 03:04:19 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:284:a4f2:cc63:b7fc:551c:dce5])
 by smtp.gmail.com with ESMTPSA id
 u3sm19803374pjv.32.2020.03.16.03.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:04:18 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 16 Mar 2020 15:33:07 +0530
Message-Id: <20200316100319.27935-15-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 11:04:23 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 16 Mar 2020 11:04:21 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 14/26] parsing_cocci: adjust_pragmas: Add cases for
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
cases for these types in adjust_pragmas.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/adjust_pragmas.ml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/parsing_cocci/adjust_pragmas.ml b/parsing_cocci/adjust_pragmas.ml
index 73b5ff5f..537150e7 100644
--- a/parsing_cocci/adjust_pragmas.ml
+++ b/parsing_cocci/adjust_pragmas.ml
@@ -171,6 +171,10 @@ let rec left_ty t =
   | Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
       call_right left_ty ty t
 	(function ty -> Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2))
+  | Ast0.ParenType(lp,ty,rp) ->
+      call_right left_ty ty t (function ty -> Ast0.ParenType(lp,ty,rp))
+  | Ast0.FunctionType(ty,lp,params,rp) ->
+      call_right left_ty ty t (function ty -> Ast0.FunctionType(ty,lp,params,rp))
   | Ast0.Array(ty,lb,size,rb) ->
       call_right left_ty ty t (function ty -> Ast0.Array(ty,lb,size,rb))
   | Ast0.Decimal(dec,lp,length,comma,precision_opt,rp) ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
