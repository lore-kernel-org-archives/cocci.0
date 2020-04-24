Return-Path: <SRS0=cw0N=6I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A49C55186
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A02220724
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmnOshuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A02220724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03O9JHjV006483;
	Fri, 24 Apr 2020 11:19:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0379B7827;
	Fri, 24 Apr 2020 11:19:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 141867815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:16 +0200 (CEST)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:444])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03O9JEHv027535
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:15 +0200 (CEST)
Received: by mail-pf1-x444.google.com with SMTP id z1so2837239pfn.3
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 02:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SQehgLNKcnkP2r6snLh68vsSiNrWsr6X4sXUN+Ob+dg=;
 b=lmnOshuJAISWxrhI6uRfWGisXd5KiwS1rSynPF2Xmxqe1FMntwT8kgnUONKENSYd00
 3ZTelG44l8GAFIW6TB8u1TiwsBPMySflv3eM72gurM4zmdTmsOZkbXs6KswJ4C20LNgb
 muJ4H5lltM2DvWE08fnCuhaYUt5E41URgNTaHr6YYhlmkd/sam2rOrpxgYnp9aYn34IJ
 alnwAG7cBPz9T9l4fxk54Cn+sAHDn1N1ZP77AivW1ehEubayipUqu+JuHoKUKg2HFoG0
 ExYg96qOEUw0p1n6ybirZxzOg/o5A2OCFgP3/r3aqPaDCLPFKcCOPLKCvxLAs85plxPQ
 nN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SQehgLNKcnkP2r6snLh68vsSiNrWsr6X4sXUN+Ob+dg=;
 b=RcB1IO1+m6dLMCrz6Z7PGmhtox9fXN9Bd/F6qAd3KW1zS3RDReuaFYOI2If8KEo8Ts
 vXjV8dfIkEn6BeXTs5Mq1zYOzx5h4GkrTkE/wRzFhpIsM/rl5xx6V3IBvWuZHunENDgE
 nIqymlf5WXQNrNuKV4keKxlny+jPw3H8YBV+/eE59YGZLlAJauU79bVThUuGfUbFVG+C
 gVKObwa+n2vvL/pTu4NqKyBX2IOvrmvn2j3fDUoCepaF+eXzgGTiLhtzI5bnbTbmi4dz
 nm2JEqYmXD+o6nSYvj4uQvluYh+J0UR64/NTI8zUr8Ws1XnwOd0mududpzrwZDtve449
 qnpg==
X-Gm-Message-State: AGi0PuZqD72P4adRZXiIZgLDo6KZcX0nNZj2mHVw2L11jMP0+4erCbbW
 rtJCZ2WW3X7l8RGIjvFXbZtFBFXvXvA=
X-Google-Smtp-Source: APiQypI5hOl7Sz9P6ONJTaxtxFR193NME9k1L/obfvJi0VWNMBGVLcJg3rfISlvrUHWlSSZPbdVf3Q==
X-Received: by 2002:a63:b23:: with SMTP id 35mr7976708pgl.170.1587719953502;
 Fri, 24 Apr 2020 02:19:13 -0700 (PDT)
Received: from localhost.localdomain ([1.38.216.60])
 by smtp.gmail.com with ESMTPSA id c80sm5043933pfb.82.2020.04.24.02.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 02:19:13 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 24 Apr 2020 14:47:48 +0530
Message-Id: <20200424091801.13871-13-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
References: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 11:19:17 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 24 Apr 2020 11:19:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [RFC PATCH 12/25] parsing_c: cpp_token_c: Introduce
	MACROANNOTATION hint
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

A better way of denoting attributes is to pass attribute information
from SmPL to the C parser. However, a temporary solution is to introduce
a MACROANNOTATION hint to cpp_token_c.ml so that the parser can identify
attributes easily.

This hint can be used as follows in standard.h, the user provided
macro-defs file or the given C file itself:

	#define __attribute_name MACROANNOTATION

By default, __attribute_name would be identified as a comment. Using the
above hint, __attribute_name would be identified as an attribute and
transformations from SmPL would be performed as if __attribute_name is
an attribute, not a comment.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/cpp_token_c.ml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/parsing_c/cpp_token_c.ml b/parsing_c/cpp_token_c.ml
index 425234e8..0654be26 100644
--- a/parsing_c/cpp_token_c.ml
+++ b/parsing_c/cpp_token_c.ml
@@ -81,6 +81,8 @@ let assoc_hint_string = [
   "YACFE_END_ATTRIBUTE" , HintEndAttribute;
   "YACFE_IDENT_BUILDER" , HintMacroIdentBuilder;
 
+  "MACROANNOTATION"   , HintAttribute;
+
   "MACROSTATEMENT"   , HintMacroStatement; (* backward compatibility *)
 ]
 
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
