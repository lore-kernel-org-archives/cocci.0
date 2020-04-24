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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B55C55186
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20CC120724
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FryyyBAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CC120724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03O9It7n011367;
	Fri, 24 Apr 2020 11:18:55 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EA4A27827;
	Fri, 24 Apr 2020 11:18:54 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0EFD67815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:18:53 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03O9IpGR001365
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:18:52 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id 145so4503163pfw.13
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 02:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=438wvAmjSRefVIvaDhaeYHRQmYcSFJQekHePTY/5Erk=;
 b=FryyyBAPp0Jac4z4a5YKT3KwRUgDtBH8LWZPBOOR+raL4ju2BahMgKwfLoRckO05PM
 Ege0KnyiqadGxmJzeRGGhivg5R2uvMqmD9lXZQSCSScCYwFeYQj8Dqnb+wXL2cbfLb4a
 rmJ1U7o4VJDghjVJHecqeoBfKgxEuyCbOmPSeu+BJVkjwA+OyeivlCgzeCT6tu4SnL91
 tzCFaRsc/EIBK3s32wHqC/iABUYe/3VpXLV4XsB/NHdqvmPoDbRD8rauOpPm//QpIKVx
 +MLsvOdYzmtoGPyfRmnryO6f4IXjbbHIM+Duai2DS/w9iHlwfvgk2crbVzbat3V6qs09
 psyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=438wvAmjSRefVIvaDhaeYHRQmYcSFJQekHePTY/5Erk=;
 b=EWN1y/FPXXRmzUTkXUzsKS2xFonDDdQxFMgNF+Y76JnvGXJ4HGGdgeOudM1CJY6Gt1
 nTGnI8VhShRuF/qsSrvNofdOXAn60Gk1g/HkWFvgAAfZe63uy1dydQ1IU/0UJlO9/8jf
 xqNS6t0ltO861G6k4JouIPOoTFf3Mm/Umh9WxdU1RXZyAULa8/ywxtdVtuajLqUkFUit
 qStZofhnmcYrMTXRsH9jS9jcnm7ZEmPyImcFam3+URYnUWdExULZ/7wlwhDtd8JVuEgy
 HuWEZKNbHI6eSA4ZTBajNGk9rWDHDwW0JfdTIC+CBz6kiF5W3ESlYeLL+1ZI/fwOp1nm
 npog==
X-Gm-Message-State: AGi0Puafrf1KZqdH7e6m/Ku7V+r66D593ZnzvXuBaMuYBS99Fda4LC0/
 UcLArwmBcHxi2xOC+MzOnhTwi14W6ak=
X-Google-Smtp-Source: APiQypKaCMQZYiKCUoL5MVgu4YLns7Nmz2SX4Gfje+8CfZyhGEDJmnwCJUOt3ng9cAIqEeDv8COwUQ==
X-Received: by 2002:a62:d119:: with SMTP id z25mr8135572pfg.153.1587719930358; 
 Fri, 24 Apr 2020 02:18:50 -0700 (PDT)
Received: from localhost.localdomain ([1.38.216.60])
 by smtp.gmail.com with ESMTPSA id c80sm5043933pfb.82.2020.04.24.02.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 02:18:49 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 24 Apr 2020 14:47:43 +0530
Message-Id: <20200424091801.13871-8-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
References: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 11:18:55 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 24 Apr 2020 11:18:52 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [RFC PATCH 07/25] parsing_c: parser: Add
	init_declarator_attrs rule
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

As per GCC's C grammar, the init-declarator rule has the following
production:

	init-declarator:
	  declarator simple-asm-expr[opt] gnu-attributes[opt]
	  declarator simple-asm-expr[opt] gnu-attributes[opt] = initializer

Due to conflicts in Coccinelle's C grammar, adding productions with
attributes to init_declarator is not possible. Create
init_declarator_attrs and use this rule in init_declarator_list for
handling attributes after commas.

Following is an example of C code that is parsed successfully:

	struct mxser_mstatus ms, __user *msu = argp;

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parser_c.mly | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index a5b0d214..1ff2fd87 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -1668,6 +1668,23 @@ init_declarator2:
  | declaratori TOParCplusplusInit argument_list TCPar
      { ($1, ConstrInit($3,[$2;$4])) }
 
+/*(*-----------------------------------------------------------------------*)*/
+/*(* declarators (right part of type and variable). *)*/
+/*(* This is a workaround for the following case: *)*/
+/*(* <type> <declarator>, <attribute> <declarator> ...*)*/
+/*(* The normal init_declarator rule does not handle this, and adding *)*/
+/*(* attributes to it causes conflicts, thus the need for this rule. *)*/
+/*(*-----------------------------------------------------------------------*)*/
+init_declarator_attrs2:
+ | declaratori                  { ($1, NoInit) }
+ | attributes declaratori       { ($2, NoInit) }
+ | declaratori teq initialize   { ($1, ValInit($2, $3)) }
+ | attributes declaratori teq initialize   { ($2, ValInit($3, $4)) }
+ /* C++ only */
+ | declaratori TOParCplusplusInit argument_list TCPar
+     { ($1, ConstrInit($3,[$2;$4])) }
+ | attributes declaratori TOParCplusplusInit argument_list TCPar
+     { ($2, ConstrInit($4,[$3;$5])) }
 
 /*(*----------------------------*)*/
 /*(* workarounds *)*/
@@ -1676,6 +1693,8 @@ teq: TEq  { et "teq" (); $1 }
 
 init_declarator: init_declarator2  { dt "init" (); $1 }
 
+init_declarator_attrs: init_declarator_attrs2 { dt "init_attrs" (); $1 }
+
 
 /*(*----------------------------*)*/
 /*(* gccext: *)*/
@@ -2373,9 +2392,9 @@ enumerator_list:
 
 init_declarator_list:
  | init_declarator                             { [$1,   []] }
- | init_declarator_list TComma cpp_directive_list init_declarator
+ | init_declarator_list TComma cpp_directive_list init_declarator_attrs
      { $1 @ [$4, [$2]] }
- | init_declarator_list TComma init_declarator { $1 @ [$3,     [$2]] }
+ | init_declarator_list TComma init_declarator_attrs { $1 @ [$3,     [$2]] }
 
 
 parameter_list:
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
