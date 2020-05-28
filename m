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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D2CC433DF
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:25:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF10212CC
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEV430Dl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF10212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04SCP2iE028650;
	Thu, 28 May 2020 14:25:02 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E6DC85D47;
	Thu, 28 May 2020 14:25:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 25D863E1D
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:25:00 +0200 (CEST)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:444])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04SCOw3n022083
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:24:59 +0200 (CEST)
Received: by mail-pf1-x444.google.com with SMTP id y18so13460945pfl.9
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 05:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cGDUzhZcEhkVFp2C8yOH7JRCO3lSVAy9MoJAYsw+VoQ=;
 b=gEV430DlDKZNk2wykprugo7vVbOKxYnkGlgJBx4CBXVaXXGmsFS2UFnrD1kaOmSLgg
 xILUdGLvUP3wFsJy+H3AEC79XwWFkBBerUnTXJ1J/wvpoNJOcR6mkCGUD+yQ9fSayUdt
 fK9kNTvN651IuOSA3OOzrgZ1lQn5yB1KYR37/bQ9BL9N2X1Q3fKnJgYeqFAG8NoZ0WQ5
 f4yyMjeJwxHqe0SziquEfkcBot+qU7/uE9V3MoTE6vNzIOti9Ov/6XVzF6KtIz8prue2
 HOHYNmw4+J1yGQJqNbwYrq9BSz7fivSmggcNEQhR1Np55uB56ful6f7R9dgi1z8rVvEs
 S01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cGDUzhZcEhkVFp2C8yOH7JRCO3lSVAy9MoJAYsw+VoQ=;
 b=t969LK6fUS9+0BAK6Eu7BoD7kqfiCkfe6J3g9d2J1lPMSgjr7yULyVVBk18QOs3h6B
 UEj0TqXsN4dkJY/CMmxqDEaJaai7cdyS81fhqnew3nBTdGUh6poTEZ/d/tjK6pPmxvxp
 izl/qSV1UGAxZcU+2F6wgP2beqTaEIzho7YO3PQltsF8HQDZe6cDH7MqnDHFzmyCR/wx
 AYVyTuR2FO9LiegaK5y5UlyA8t3gM7QY7g31jm4FUBwvjdTNNdqhawUGXnCVx3XNx5ra
 0MTEAHw8NVmw2X23omOG0fa8jOAcqZvFMHbSz0MVm7uI956m5IPJsXbsR+c6ZyuO5M/g
 fR/w==
X-Gm-Message-State: AOAM531oReDRy6Nqq9ZIjap+vR0W7h+QVRbXN84oZ5y9690UvBAViklr
 1BDImJL1FlC1t7c68Lfz80hKJGw0
X-Google-Smtp-Source: ABdhPJwaxcAMOolxi0nQ1pKLvuGjEDWQ17mag6Bj4YmEo9nSthqnbjKxsskE0k8BLBbKREX2PyLTxw==
X-Received: by 2002:aa7:93ac:: with SMTP id x12mr3040780pff.143.1590668697788; 
 Thu, 28 May 2020 05:24:57 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2183:e360:deba:7bf4:98ef:5568])
 by smtp.gmail.com with ESMTPSA id 1sm5722888pje.26.2020.05.28.05.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 05:24:57 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 28 May 2020 17:54:07 +0530
Message-Id: <20200528122428.4212-6-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
References: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 May 2020 14:25:02 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 May 2020 14:24:59 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 05/25] parsing_c: parser: Add expression
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
index d259f12a..e4352a61 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -1082,8 +1082,9 @@ stat_or_decl:
 
 
 expr_statement:
- | TPtVirg      { None,    [$1] }
- | expr TPtVirg { Some $1, [$2] }
+ | TPtVirg                     { None,    [$1] }
+ | end_attributes TPtVirg      { None,    [$2] }
+ | expr TPtVirg                { Some $1, [$2] }
 
 selection:
  | Tif TOPar expr TCPar cpp_ifdef_statement              %prec SHIFTHERE
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
