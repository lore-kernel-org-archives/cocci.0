Return-Path: <SRS0=TTUf=7S=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5A3C433E0
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:45:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B6BA206E6
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXhGXDHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B6BA206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 055Diubu014672;
	Fri, 5 Jun 2020 15:44:57 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E3733777D;
	Fri,  5 Jun 2020 15:44:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 32EF17567
 for <cocci@systeme.lip6.fr>; Fri,  5 Jun 2020 15:44:55 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:643])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 055DirU5022853
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 5 Jun 2020 15:44:54 +0200 (CEST)
Received: by mail-pl1-x643.google.com with SMTP id v24so3654851plo.6
 for <cocci@systeme.lip6.fr>; Fri, 05 Jun 2020 06:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SQehgLNKcnkP2r6snLh68vsSiNrWsr6X4sXUN+Ob+dg=;
 b=mXhGXDHeJNRfbU05PeRDwLvr4ZgtL+kg1r3hphuMeQ1HcPcSjljueaeBCuRcvO7atY
 O20JZ7YW+rtTjmFh6S88de6CwiZtAGFxricc1uRLjODNb94ZbwstCzNx+wmcbZ9grcGw
 J7e7mY8My6suPXOphgDlYnC6BFuN+OaBSg6IH3epcSrwovZwqkw2+7gmBvD84HFLuSS4
 5uY9ZN+CHtYqR6vfejEE/O6N1D6wapRLuxVlJB8dQiMX5Urt32+5X9djiEe/wJpXSsHa
 2T43NVlsqa3eJ2lmZ0TyOcp//n6S71cNHDzEEb329QHmaJ/TX76bT7mnXEfObxPatbW6
 spuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SQehgLNKcnkP2r6snLh68vsSiNrWsr6X4sXUN+Ob+dg=;
 b=VY42EzCfRm5QP7ZBNs1WpNEfEspEoCrTmLUxNlzWPka364SWoTPg+Rxct/RMF+r1EJ
 AYj/iJ1afoT3kbANCYw66KoEysf2vWZhd+6FPkOrfpLvQDjMyOMOxhw7cDNHksG4ghrR
 amwA/FKTgsKmugqFQKbpPF5UGCLaAksFLS81ME/dapPbjF218b+eQ8QurCsxffw93iOS
 jcAMJHwubRcTDNjokXfVTYgMRVC78I7dEQDHwzhv2Cf05j8WtRpTlJVj2Yl9B1sIbAlb
 S/xUqM2W86YkCZ9wjkTWKdy+erCJ9FCBtYzLthrgg9B8fSzbji59ykIFrlaON4hLcr4Z
 kDYw==
X-Gm-Message-State: AOAM533KAjo7D5by/W6kX2o2M4G/s8JPhh4PPoExzOliB3EcFhV5NF0i
 I3luuooucCwf+nF8xRhVp7J/kED+kVY=
X-Google-Smtp-Source: ABdhPJy6aqXfFFBWvT/6q+/mXSHcZruGxXh9GAjT/LBtgeJZ9RJy4d2bj8pm4yt1ZztBOh48+e2GQg==
X-Received: by 2002:a17:902:714e:: with SMTP id
 u14mr9904805plm.175.1591364692699; 
 Fri, 05 Jun 2020 06:44:52 -0700 (PDT)
Received: from localhost.localdomain ([1.38.221.125])
 by smtp.gmail.com with ESMTPSA id w186sm7861353pff.83.2020.06.05.06.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 06:44:52 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri,  5 Jun 2020 19:13:21 +0530
Message-Id: <20200605134322.15307-14-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
References: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jun 2020 15:44:57 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 05 Jun 2020 15:44:54 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v4 13/14] parsing_c: cpp_token_c: Introduce
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
