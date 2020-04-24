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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F703C2BA1A
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:18:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE49320724
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adE8bZtY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE49320724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03O9IUiO014073;
	Fri, 24 Apr 2020 11:18:30 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 94B767828;
	Fri, 24 Apr 2020 11:18:30 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 417427815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:18:28 +0200 (CEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:543])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03O9IMOv025914
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:18:23 +0200 (CEST)
Received: by mail-pg1-x543.google.com with SMTP id s18so1689930pgl.12
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 02:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UsrJPSiuYdGhSf7MtnSc/hKUCEuYgCouViQySYM/Xaw=;
 b=adE8bZtYHlT7YNIsmrH91UiW2BoqbBWPW0kZca/PDObSSIGUkzQzZqxKYULzjAcI0m
 D7Ld0IOOi1qq4bDC5mVe2oQDF1yz5EhGSrcpjxqzqQUXQhTzSKlwfwYpSHRQLXXd+e7u
 4BXVy+62d3muuM082/acjwXe0QuA9F53F/x4CQmas8rLR3jZtO3zSaZNuE70x5S4GbV5
 AtH0Vs0bX1SVIAvlmuY3SZ1S59bmTprRyXpsvE1Cmtd1JrhAt+9iWKv9D7nA43wRL7+8
 DYg9EGAdI9Cc4fBd9+cp66LDWP34CaFrcOSr5k2Umm+4SGMPicbKIwpAyQ47aL9CbFYo
 cUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UsrJPSiuYdGhSf7MtnSc/hKUCEuYgCouViQySYM/Xaw=;
 b=GavBKnIcf6R9Mp9LBpHmNkoFQ0UdYTIqnWiVI7fvNipGaO+2UV5VyEp13LxR/WtT1y
 rXICYPgEasQ03PGFpUR9Xii1yaVFJ+FBMvv1pYitibPdE/mQ0L98LfM9S3cxHkv4F7Ux
 jX9QF0zXDcsObicQhGWaciRz2+yz+9znGQEfoZK4cT6dOdqt9PFoT3phQAij0XqIYMxs
 rXspgJ6zSCEvDrb5KYI1TZx6NnxDra8DBzcTlC+1Jig4POgC4uPqOcd2DWsyiK1DCuiX
 DHIF92fVCQT8JLU+bLlzp6gKlzCuc5Rsta+kEXu9+wdpAspDCOlxKn+61cuqjwV0mOQJ
 SrnQ==
X-Gm-Message-State: AGi0PuY/IPet0mvriKkjxhEWVCpbdxfzwawLW3tVY4qSY7TK/ExaLPPU
 eY+y/uuI05DHFNLXzAEXLVtM1ZPKYNo=
X-Google-Smtp-Source: APiQypKn4CWFY1lA576CSp2ms4E2vNTEWkJj2EmCanyhB0FCzm/hQZ+dQAZQSgDyNrEkSHJjG3E7fg==
X-Received: by 2002:a63:c504:: with SMTP id f4mr8218854pgd.292.1587719900697; 
 Fri, 24 Apr 2020 02:18:20 -0700 (PDT)
Received: from localhost.localdomain ([1.38.216.60])
 by smtp.gmail.com with ESMTPSA id c80sm5043933pfb.82.2020.04.24.02.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 02:18:20 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 24 Apr 2020 14:47:37 +0530
Message-Id: <20200424091801.13871-2-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
References: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 11:18:30 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 24 Apr 2020 11:18:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [RFC PATCH 01/25] parsing_c: parse_c: Ignore TMacroAttr and
	TMacroEndAttr in passed tokens
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

Most cases in parsing_hacks do not consider attributes before or after
the token in question. So, do not pass TMacroAttr or TMacroEndAttr
tokens to parsing_hacks in the before list.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parse_c.ml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/parsing_c/parse_c.ml b/parsing_c/parse_c.ml
index 428261f6..0d3a189a 100644
--- a/parsing_c/parse_c.ml
+++ b/parsing_c/parse_c.ml
@@ -608,13 +608,15 @@ let rec lexer_function ~pass tr = fun lexbuf ->
             | x -> x
           in
 
+          let passed_before = filter_noise 10 tr.passed_clean in
+
           let v =
 	    if !in_exec
 	    then v
 	    else
 	      Parsing_hacks.lookahead ~pass
 		(clean_for_lookahead (v::tr.rest_clean))
-		tr.passed_clean in
+		passed_before in
 
           tr.passed <- v::tr.passed;
 
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
