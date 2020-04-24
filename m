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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601A1C55186
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:18:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE55920728
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx4q9ME1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE55920728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03O9Iccf004257;
	Fri, 24 Apr 2020 11:18:38 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 045237827;
	Fri, 24 Apr 2020 11:18:38 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6C3CA7815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:18:36 +0200 (CEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:443])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03O9IYIb011112
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:18:35 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id 18so4517679pfx.6
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 02:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tIUifw++gcNjsA6xw62XJoWy60jEOtatHZYKBU3ncSk=;
 b=Rx4q9ME1bsr1iajLU6VwQoUO01cqLUgUgC5A1/G8fIBP1IL9GJQz8snwjAGg3f0TwF
 e40/zBRJWIOQZaxn+kn/FhcjrC5/aCzu9d3HtAdvQmHkXug18+DwHm8VwFzfUidsuI2P
 bVbg8w4Ut++rebEFeWdSC+IuRuFzR125APKcs/+45zcvS/TizS7kpV9P64w0QoVs4GdL
 KF0sfm2soFvGq4lh7Aa57L/dreXNWKb00kdaryUHuBuJnm3YBD+OQAVybpbgdqSYPpan
 AUtvRTOZlgcQKAqr32EIJcgLAlYFFu3almnXKMCmDQm9+GDUh0IYUhX4oxAQYjpdeyGi
 EaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tIUifw++gcNjsA6xw62XJoWy60jEOtatHZYKBU3ncSk=;
 b=TFkw1ZTRSnfZlCqW39ksb+FT15dPjoNi1c13RDGW2rcTnMBUZbLDuvgQ/a6cW3CNAL
 3iEpXW9ylR8+B89GaWe1bZt6CrU9WTXS9vB0j9nrzjdYFjbnUT7nr7QLXb1L30pwvVgI
 u3vOfi6w3d8t47q38Mu9H+7cXjz2Ae481wlwRmQwWfGHgH/cuADVhaAAVj07F90UjMUx
 kbyikPBv/cNAjYad7j4HILwOGaPH4EnXerOMxqn+J3yaSQ0wyfgSnKe4VKtCRdEBgHnT
 fqma3+2yVN1fH69IGjk/u8glU9DXEJql/NLs+02e4tNcQ3CxI6QLJpRs+KTFUxVLgEZL
 ri7Q==
X-Gm-Message-State: AGi0PuaEUtMgIXapIswG8EmQu/omOYDBEc+ivmb+WfYe64xBPtap2Xzt
 sZVEUfXSvkV9xbv6YurF0CUl3RujFuI=
X-Google-Smtp-Source: APiQypKebcgDSTTX5mPn8FxPUilz0qN1hlQ6HiwJ4LUeaFmv9EUK9R6ALNRXnb9eEASP/pOXx/tlWg==
X-Received: by 2002:a63:e749:: with SMTP id j9mr7981788pgk.319.1587719914063; 
 Fri, 24 Apr 2020 02:18:34 -0700 (PDT)
Received: from localhost.localdomain ([1.38.216.60])
 by smtp.gmail.com with ESMTPSA id c80sm5043933pfb.82.2020.04.24.02.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 02:18:33 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 24 Apr 2020 14:47:41 +0530
Message-Id: <20200424091801.13871-6-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
References: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 11:18:38 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 24 Apr 2020 11:18:36 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [RFC PATCH 05/25] parsing_c: parser: Add expression
	statement attributes
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

As per GCC's C grammar, the expression statement rule has the following
production:

	expression-statement:
  	  gnu-attributes ;

Add this production to the expr_statement rule of Coccinelle's C parser.
If attributes are recognized, this parses the following code
successfully:

	label: attribute;

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parser_c.mly | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index d259f12a..a858db56 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -1082,8 +1082,9 @@ stat_or_decl:
 
 
 expr_statement:
- | TPtVirg      { None,    [$1] }
- | expr TPtVirg { Some $1, [$2] }
+ | TPtVirg                     { None,    [$1] }
+ | end_attributes TPtVirg                     { None,    [$2] }
+ | expr TPtVirg                { Some $1, [$2] }
 
 selection:
  | Tif TOPar expr TCPar cpp_ifdef_statement              %prec SHIFTHERE
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
