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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD6AC0044D
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF6362051A
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afnaxcBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6362051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GA4374016474;
	Mon, 16 Mar 2020 11:04:03 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E50497809;
	Mon, 16 Mar 2020 11:04:02 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D025F7809
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:00 +0100 (CET)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GA3xPh015475
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:00 +0100 (CET)
Received: by mail-pj1-x1041.google.com with SMTP id m15so7681093pje.3
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 03:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8WQLiIaOsmFjHM1HjEy2R4Nr4kZ1TGFicBFeXYCuWCQ=;
 b=afnaxcBkjsA/AOjz/U50ShMNgapRIdI+HYZrDUWFQ7Qogas1M3InMcqkFV8VRrakME
 Mi6HH7CyZ+TiR5FI6B4HNeBCaTz+kygWekZkkLCFquSQp8U7udIUnSBqWqgsU8g1/O6C
 HOIY7ljSobbHkTTdtQYWM0Thw8lR2zSxHW7786g473C9Y1vG8c81kz/b+Dl7hQHjvTyu
 FILCPwacor5MwdcK/ZcaoQ2ofmw6arwAE4I/YmxNphIvDfrqnatu4FI6Im3VEbbvO6Ph
 Q4voCH0H0i0VxxTUDrFaBeEGdnhrYCC0KR/yDtIhOiGZSMqrknsVksmvCOfXcl1SyZ85
 fEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8WQLiIaOsmFjHM1HjEy2R4Nr4kZ1TGFicBFeXYCuWCQ=;
 b=tjAoAlyW/nZr/kW+nmLXyRjiu2bcINDKIovqcRpr8lYdAS50Mt6gQNTGvpyw+48wZV
 QunKx169m94mRuqDa54KDKW92tLAKr3/hxzP8yh+g0isgxHC5xN4rCWMNBiXY85CvbyV
 UdFcNStaRRqoUXPBJibpDirPkM9uTKozXOJ7OA0Pu8Bt1fRN67LJZzr5a+zCuKdVagpK
 am0RQTqvgTya/hcJZCCm0YFmBwm8XskoyJKmAKF67V7thV9NJItdzJ9osR6jkxlclMBj
 AUvFXVGmElYj6fX4aYs805tMDkZeK0xQqDnL9e2rjfyf1cLx9+o9kooc8+zv1MXv59L+
 wgVA==
X-Gm-Message-State: ANhLgQ3pEFUaOxTohpNRzNum7whWiTIaFENvgemd8JoLsVqbP+kgSYXA
 5a1O7tyeeTpdjal2rdV1eWaTRSMr
X-Google-Smtp-Source: ADFU+vsWNKfLhdvdxKJG6Tv5vj7Jcs6ONcweaidYwQ3+171A2U2QfA5gn2V7k4ACe2cE9OXwNTTZ2Q==
X-Received: by 2002:a17:90a:a40f:: with SMTP id
 y15mr12719959pjp.143.1584353038359; 
 Mon, 16 Mar 2020 03:03:58 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:284:a4f2:cc63:b7fc:551c:dce5])
 by smtp.gmail.com with ESMTPSA id
 u3sm19803374pjv.32.2020.03.16.03.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:03:58 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 16 Mar 2020 15:33:01 +0530
Message-Id: <20200316100319.27935-9-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 11:04:03 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 16 Mar 2020 11:04:00 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 08/26] parsing_cocci: context_neg: Add cases for
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
cases for these types in context_neg.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/context_neg.ml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/parsing_cocci/context_neg.ml b/parsing_cocci/context_neg.ml
index 7bbf743d..b3a52daf 100644
--- a/parsing_cocci/context_neg.ml
+++ b/parsing_cocci/context_neg.ml
@@ -663,6 +663,10 @@ let equal_typeC t1 t2 =
       equal_mcode sign1 sign2
   | (Ast0.Pointer(_,star1),Ast0.Pointer(_,star2)) ->
       equal_mcode star1 star2
+  | (Ast0.ParenType(lp1,_,rp1),Ast0.ParenType(lp2,_,rp2)) ->
+      equal_mcode lp1 lp2 && equal_mcode rp1 rp2
+  | (Ast0.FunctionType(_,lp1,_,rp1),Ast0.FunctionType(_,lp2,_,rp2)) ->
+      equal_mcode lp1 lp2 && equal_mcode rp1 rp2
   | (Ast0.Array(_,lb1,_,rb1),Ast0.Array(_,lb2,_,rb2)) ->
       equal_mcode lb1 lb2 && equal_mcode rb1 rb2
   | (Ast0.Decimal(dec1,lp1,_,comma1,_,rp1),
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
