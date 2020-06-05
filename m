Return-Path: <SRS0=TTUf=7S=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67146C433DF
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D60E0206E6
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4k/4UcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60E0206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 055DiY6Q015885;
	Fri, 5 Jun 2020 15:44:34 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EA5C77567;
	Fri,  5 Jun 2020 15:44:33 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A51493F9A
 for <cocci@systeme.lip6.fr>; Fri,  5 Jun 2020 15:44:32 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 055DiUik026028
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 5 Jun 2020 15:44:31 +0200 (CEST)
Received: by mail-pj1-x1044.google.com with SMTP id b7so3300363pju.0
 for <cocci@systeme.lip6.fr>; Fri, 05 Jun 2020 06:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nbCvcqCG573LD2ha1hkVo9FjEMY8WANrl+7FFPQE1Hc=;
 b=h4k/4UcKwjU1/vQfdH5SorxVI6dTS4PNQrDHkW4ZWAi9h9SUzfm2gwSMCfK7XHgG5b
 rhIUZK+vSak2XkOALxeSyVQb5EiGJ86a0npkIGV/FlK03ST8P5l462glqkfYQ/7FKcjA
 f5MO0JPI+5ULNY0FruCN0BLILf4pEWJSDz+BI83BDhMZAn/4sSogNXrGyWkYb4S7Kpq6
 sHkDSGnyNwoJ+wWmIqJ57KnC1fnvjRAca1A3f+pwXGL6zqskQEn2OtzkOjsNPVqBnOal
 yhcPAyrT5h+XjEc/yPmmIo3MI/q2Jw1RLjYO7e+OQecwKT+e75ihJVk1hnDtFVqlK0UP
 jMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nbCvcqCG573LD2ha1hkVo9FjEMY8WANrl+7FFPQE1Hc=;
 b=FKzoeTrkomoTN/b8ZlUbqIFYqXoJq1Z0uZ1Mrt5TBYO4DVqD0czOmC4+KRTzYywXeg
 RK0U5j3+lXmDli3Cw1gdNLfC09BXBHL8vaa8/wHAzjTBVwVglSKCJGC2UArx8KHiUl3D
 iaDuz91O1sfyF+rGsnZNEk/gv3famLin20qBZreo5x7aUhXtCNyplXv/4rtqSxV/BUYY
 3ymoQLFtj9IlJyUZs0gzo3sSE2BsKI4dKUu2wOt3/kbltkYLCcSx5wT6cxX2MxBW42RZ
 dCDUVrpWQ1jUSQittCYEKS4kKNETjpOc7LpKEykrBcB583K9Yn4uONZzpDYvX+jJQP6E
 Kayw==
X-Gm-Message-State: AOAM533UPmpFLSm2h2jjd7oojGd7zVW4vv8tJLdB8rF18yVwfUX4h0SY
 rSltFBlmU2mh9enDwSG/Oot7XM3nZws=
X-Google-Smtp-Source: ABdhPJzJU63WsUMT8Q+sztBc/Lqnf9M0gDs2x8ayGSZ6GlG52odqSSeStH5s9ouVF7uH5r5VY6gcFg==
X-Received: by 2002:a17:90a:df0f:: with SMTP id
 gp15mr3254925pjb.128.1591364670073; 
 Fri, 05 Jun 2020 06:44:30 -0700 (PDT)
Received: from localhost.localdomain ([1.38.221.125])
 by smtp.gmail.com with ESMTPSA id w186sm7861353pff.83.2020.06.05.06.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 06:44:29 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri,  5 Jun 2020 19:13:16 +0530
Message-Id: <20200605134322.15307-9-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
References: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jun 2020 15:44:34 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 05 Jun 2020 15:44:32 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v4 08/14] parsing_c: parser: Add
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
index d24ab7b8..9afbd68c 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -1667,6 +1667,23 @@ init_declarator2:
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
@@ -1675,6 +1692,8 @@ teq: TEq  { et "teq" (); $1 }
 
 init_declarator: init_declarator2  { dt "init" (); $1 }
 
+init_declarator_attrs: init_declarator_attrs2 { dt "init_attrs" (); $1 }
+
 
 /*(*----------------------------*)*/
 /*(* gccext: *)*/
@@ -2372,9 +2391,9 @@ enumerator_list:
 
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
