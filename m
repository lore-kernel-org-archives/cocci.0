Return-Path: <SRS0=O8dQ=7N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6BCC433E1
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF743206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZ3oSTiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF743206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFSMuk015611;
	Sun, 31 May 2020 17:28:22 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 95ED17752;
	Sun, 31 May 2020 17:28:22 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8D33B3C89
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:28:19 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFSHff004141
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:28:18 +0200 (CEST)
Received: by mail-pj1-x1044.google.com with SMTP id a45so2716884pje.1
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4uwuGVmkBXskVvKyLUdthnTRx01/P3EiKMFAZiwawPY=;
 b=cZ3oSTiznmsJWvteVmwQ4sEH4+7KgvOuH4Mgkcu30DJpQTEBEftTXLDcsx5x+72PIx
 cN4kvMXEWTsGc1tcSyuRVj79I6M/doJ/SLTXAGbg+B89Yl2ORu6P2Vh359PHi2BV5Bah
 8TYVvTpOA9B6U45+4XcrvRrdLcU4IREqrVCTwMZjbCbEkINzctJW7EVwM0FlY6yBcHxC
 oXOcb+FAMQKYvkD5p+RrLi5wLzooWwsKooc3/MMdsoA5B4d/0c04feyU1o85XJQuV7/9
 btMZnQWpg31nTi5nSpV/dq1wU/Uw+bpAY4ucMUKinhc3GhjmXreT0sAwkXIll/Sththv
 IFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4uwuGVmkBXskVvKyLUdthnTRx01/P3EiKMFAZiwawPY=;
 b=jJg7SfyKvOwC9dBtTNxUhqxrLe843abPvIlqzziTpUHf3CuQ1RBCseUZHwp01ObDpJ
 iZWAjROJVYPsNdu2EEweer2MSGIGRxZnVsAF0lGE+3q97TLwruEzVLOXX5yBjn9LXEF/
 aSW3fyo/bw2f7Oc7GS3rsyDMftCVTNHY9uGmTea+klMaY+s07C7vcefLgym3d2m0YBbY
 2zZVoQujmSaW0siiyY4f3X7NTwdSfGaKbIJD2+It+UyejOToYVlaMo4RpbWEcixIQRTQ
 SiJrKh7HTB/7uaIEVLHzD0q0HE9/ZjiVw553tup1zqO9K1wDQ+ToXujdZD+rcEx/BzQv
 ksiA==
X-Gm-Message-State: AOAM5315wYA2YpM7Vr/1yypGlUn7U77tIWZmQ3ds9C5F5UcuhOr/0oiz
 AdTeJl7/CPKWnEgsrfKBzwmbryBY
X-Google-Smtp-Source: ABdhPJyEEd0lFJKzpZQFytrB2xFWI0/tbrZ+j08LpSmyvXpSrFqpPJ8qQ2vi3ZFgd9Uo55Vja7NUyg==
X-Received: by 2002:a17:902:d711:: with SMTP id
 w17mr16061018ply.139.1590938897259; 
 Sun, 31 May 2020 08:28:17 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:28:16 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:56:17 +0530
Message-Id: <20200531152621.2886-24-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:28:22 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:28:19 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 23/27] ocaml: coccilib: Reflect struct end attributes
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

Struct end attributes are added to the SmPL AST. Reflect these changes
in coccilib.mli.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 ocaml/coccilib.mli | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ocaml/coccilib.mli b/ocaml/coccilib.mli
index c5195084..24b5f1ae 100644
--- a/ocaml/coccilib.mli
+++ b/ocaml/coccilib.mli
@@ -2766,7 +2766,7 @@ module Ast_cocci :
           string mcode
       | FunProto of fninfo list * ident * string mcode * parameter_list *
           (string mcode * string mcode) option * string mcode * string mcode
-      | TyDecl of fullType * string mcode
+      | TyDecl of fullType * attr list * string mcode
       | MacroDecl of storage mcode option * ident * string mcode *
           expression dots * string mcode * attr list * string mcode
       | MacroDeclInit of storage mcode option * ident * string mcode *
@@ -3401,7 +3401,7 @@ module Ast0_cocci :
           attr list * string mcode
       | FunProto of fninfo list * ident * string mcode * parameter_list *
           (string mcode * string mcode) option * string mcode * string mcode
-      | TyDecl of typeC * string mcode
+      | TyDecl of typeC * attr list * string mcode
       | MacroDecl of Ast_cocci.storage mcode option * ident * string mcode *
           expression dots * string mcode * attr list * string mcode
       | MacroDeclInit of Ast_cocci.storage mcode option * ident *
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
