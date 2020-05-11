Return-Path: <SRS0=43Z/=6Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051B1C54E4B
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731E72082E
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tu10wngL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731E72082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA7oSe015798;
	Mon, 11 May 2020 12:07:50 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 402003E6B;
	Mon, 11 May 2020 12:07:50 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7645F3DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:07:48 +0200 (CEST)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA7ktZ023871
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:07:47 +0200 (CEST)
Received: by mail-pg1-x542.google.com with SMTP id l12so4336490pgr.10
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z2zDlikEkJciTy/5/f2JkjOKet6MVMbX5CQMorUUeXY=;
 b=tu10wngLXAsMdOEbzdsJwnxl8+9uVPbBhZVSUdIgnFW46xPhcoZS1y68fuqjGvrcMU
 4jc35r0hIs3tFOwUDBLCoaXIwJDP7e0EpkWsYA+iX/6e9g1RAqS1ZVWCy1mw6CSKF5om
 hGezk2Zg1umz1qCbDm7/FEbZnIMXBk13MUzYgDdpTUJYyKCwdA+HMA1ju1uRhr4yEG7T
 FTIQctHjgxK3bSQXxEGgfOWThMtw/7m17UOMJ80lImjRKpEncx9Z+7JnLT77SKVrwNvf
 BPltzcXBxm5rLmUJpON9cdw/c3hQoXB1ynY+D6SPO0OXYqtCBPUq3PAj0dOv9jW8XYL4
 fznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z2zDlikEkJciTy/5/f2JkjOKet6MVMbX5CQMorUUeXY=;
 b=a/NnuBam9fz0s+X8Bs12TqLHHqKd5O/ZqSgNCi2PgeJRAJcs3ymcbEazkQqCQ9xmKO
 UOAqGdNlCPZKtwhE1YG319Gpk4W1quf83CBhqhcJNlMUXBlEVD15epwn/YZmnePsQWKe
 MAtXo7Pz66Gvqajd0H871s+YHG/JMZw2DAppFVAfTK+4EC19VDeHnogPvepAFrI3oW+f
 f8MvY77AE8aqp2ngt94RuLvmbRLEEFdMTmZoU4/O5NjjVuzHh1t3cts2DYmxLn7MW7Rz
 RoCXciENcWmP1pGdDYDkk9XZz28GNgtUUtmqdFh/pofcL1fLmsngWEwyfrlfK9TepDAh
 In7A==
X-Gm-Message-State: AGi0PuZhzcl1QUtEmsXIZOhaet4HJj+OpY50FAQUbzn8HiH32FKaQA0S
 md/GRIi3gF6xCNvYQMsRletN1Fu4ulI=
X-Google-Smtp-Source: APiQypJOWhvwiCeIRkqTjnXneBVlD1YVc0gMjNIHKkrrr3kIC9b4nJTDA4MNOoEyhHtoZPc+CTW4eA==
X-Received: by 2002:a62:1994:: with SMTP id 142mr14713519pfz.259.1589191666152; 
 Mon, 11 May 2020 03:07:46 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:07:45 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:36:46 +0530
Message-Id: <20200511100715.19819-4-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:07:50 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:07:48 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 03/32] parsing_cocci: parser: Parse cast
	attributes
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

Cast attributes are added to the SmPL ASTs. Parse these attributes in
the SmPL parser and place them in the SmPL AST. The added production
only supports attributes after the type and before the expression.
However, these attributes are matched anywhere in within a cast.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/parser_cocci_menhir.mly | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/parser_cocci_menhir.mly b/parsing_cocci/parser_cocci_menhir.mly
index db5661bd..38b0e039 100644
--- a/parsing_cocci/parser_cocci_menhir.mly
+++ b/parsing_cocci/parser_cocci_menhir.mly
@@ -2176,11 +2176,12 @@ arith_expr_bis:
 
 cast_expr(r,pe):
     unary_expr(r,pe)                      { $1 }
-  | lp=TOPar t=ctype rp=TCPar e=cast_expr(r,pe)
-      { Ast0.wrap(Ast0.Cast (P.clt2mcode "(" lp, t,
+  | lp=TOPar t=ctype ar=attr_list rp=TCPar e=cast_expr(r,pe)
+      { Ast0.wrap(Ast0.Cast (P.clt2mcode "(" lp, t, ar,
                              P.clt2mcode ")" rp, e)) }
-  | lp=TOPar t=ctype d=direct_abstract_d rp=TCPar e=cast_expr(r,pe)
-      { Ast0.wrap(Ast0.Cast (P.clt2mcode "(" lp, d t,
+  | lp=TOPar t=ctype d=direct_abstract_d ar=attr_list rp=TCPar
+    e=cast_expr(r,pe)
+      { Ast0.wrap(Ast0.Cast (P.clt2mcode "(" lp, d t, ar,
 			     P.clt2mcode ")" rp, e)) }
 
 unary_expr(r,pe):
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
