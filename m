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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B733BC433DF
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 375D5206E6
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uaZ4Eqt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375D5206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 055DiMlV027355;
	Fri, 5 Jun 2020 15:44:22 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0D7537567;
	Fri,  5 Jun 2020 15:44:22 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 016423F9A
 for <cocci@systeme.lip6.fr>; Fri,  5 Jun 2020 15:44:21 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 055DiJf9014416
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 5 Jun 2020 15:44:20 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id m7so3663021plt.5
 for <cocci@systeme.lip6.fr>; Fri, 05 Jun 2020 06:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cGDUzhZcEhkVFp2C8yOH7JRCO3lSVAy9MoJAYsw+VoQ=;
 b=uaZ4Eqt19z7Ew6mwrXFRvpNjsNsPjMDjDum9578ngnRKoDLa5UusiRFm2CyTDCwTCh
 Sk/KU7UC6TTnGE9T+60Hy+QylFEKkRNjSVrUc691KVjYBzQYRu4JFrMPn03qLAXKnC0J
 vvxKl6mxAOk2MEPdgN9N1viu4tu5eesc642443mF5/5D2l/a5DvWxSk4S0kMzozGXqIs
 fcRtmvyjrHpTOKznswHmxyz5PVbxcQ+MuQclZHkHg/NXxKIQn/W8jh0ponc6wqzQpuxa
 YLkw4CIrcOlRajGx9M6uLll5cjmUn+az0g7Vwa+pKRYcv095I7/ogZSel9qr3sTBvDLT
 lH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cGDUzhZcEhkVFp2C8yOH7JRCO3lSVAy9MoJAYsw+VoQ=;
 b=fyhuFpMjAQ0c0KW2xCek8Qurt/SKaTG9KsSH0XWp+tf0pOv0lbnGdhbp04WtDshmqm
 LDlg1SsewkkaItqcjVv/nRU4HBZWnZ4rB+OZKYBV0KEkq8k30OgUi6Vu+cnw/qywT0p5
 YsBO8EohlP8mZmGCkkncJfKgsspOCYrWflxUFGMsf+tU4HWPcaZtyNOzt0DLULuzjw1G
 ppdxA1smJ0g2fjgvwp8DpkqHkUrVYkCKm686fraxYIvWyheN+RMSbrVzJAPA8dYRE0yo
 p9HK2jy2t1RZqWyiELFzFlu5e5+yrQckCFNOQCoFRyikDGXQWiBlKtMP1ZmuKDswPxFL
 xmVQ==
X-Gm-Message-State: AOAM532673wyrlhrjFhi9AdbG7SJN/VRZJog8a+fC7Kxz4ofvThljdnj
 IGB5z0aFL4zVFRBbYTNIR3Y46hB8KMM=
X-Google-Smtp-Source: ABdhPJwdfxNYcS6dClsRvyguGwtVD/wCFW3GQ0+Fxh/dbO40vna8ov/YiPX1aa+i2Oykmpd9qfqaqA==
X-Received: by 2002:a17:90b:3005:: with SMTP id
 hg5mr3075251pjb.215.1591364658594; 
 Fri, 05 Jun 2020 06:44:18 -0700 (PDT)
Received: from localhost.localdomain ([1.38.221.125])
 by smtp.gmail.com with ESMTPSA id w186sm7861353pff.83.2020.06.05.06.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 06:44:18 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri,  5 Jun 2020 19:13:13 +0530
Message-Id: <20200605134322.15307-6-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
References: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jun 2020 15:44:22 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 05 Jun 2020 15:44:20 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v4 05/14] parsing_c: parser: Add expression
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
