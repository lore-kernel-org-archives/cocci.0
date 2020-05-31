Return-Path: <SRS0=O8dQ=7N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4FDC433DF
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A9A206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ve/qNwEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A9A206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFRtim013368;
	Sun, 31 May 2020 17:27:55 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B321B7752;
	Sun, 31 May 2020 17:27:55 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B0D013C89
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:53 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFRqKL005658
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:53 +0200 (CEST)
Received: by mail-pj1-x1042.google.com with SMTP id ga6so716586pjb.1
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hN5UMrIMc/AEejMUwh7GPIfCbUdAcykfbXxFZ6tUuUk=;
 b=ve/qNwEH6rWxmS/mbGMpgDw1GXhA7C/K68avE3ejPPZZLC20xlwW57OFGBr6UTRpk3
 msodZXgA0Yd5IvwCqYcrCxFeLPTXtBlvTzEANn4zo/eZkQoxvdsd3geKeSVdS7X1URkD
 gnK8uhgkfkMj+7taOeDCjADJD1lXhMJHBZ6y62Ci6VfbSQ9F+dnUsCBvRSHimv6QTavd
 mXGBdsSkwK7zdKHrId5cbpEjiET9QpGLSVqAdu982Us1jnq+fDG5D8KkZkMfJQojoDM9
 VyPTN5GhOD4REIols7CeFfcLUnsU1fKjr49ZlJhP6MtT/y4I5hbVMpwL90kLHy/3zk/l
 ZkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hN5UMrIMc/AEejMUwh7GPIfCbUdAcykfbXxFZ6tUuUk=;
 b=ctrmy493FSJqmeva8npSBd9NtCgLsnUUt9Cp94eDcR0UWMM3lQxWVVYL+rW1sLhCQW
 QADtyDWD8m8Pg6PvoNWwrDXyNhhyw8TlrtPngwBBf9u97ikWuRrO/NsHllUehQvxGxFC
 M2rTzTVPGX1/xQpqW80Qw/f33YADGNWMCBqjK/Ck0xCvQdwhdnQWSsyFAa89Kr+9d7hS
 gITEQTI5qRSjKPHVOhejVqdBxGppBLliRhWYEdqU8Y7UXXlyMmS6PG3lrbGrvcZnYCSY
 I2P3Disvy1DVQVIAsapO/P5g5mSuqW0DZhhqQBvnE/yyz5taftubnXx+Q6zbAckvzXoJ
 Ac6g==
X-Gm-Message-State: AOAM531yvQuDJu7jdsEGRY6Obw9UlkUGvR9FP/Rn0UGJHeOGKEOLcB7G
 6CCCfcZs22jOtR0eTXC4s9WS7tqU
X-Google-Smtp-Source: ABdhPJwyj243/tLLmRpOmBE/PHwN3wX7J5KwiACHvMJcHhr4gHBnceXpPctprjTWkaCmk3pgWOeNtw==
X-Received: by 2002:a17:902:b18b:: with SMTP id
 s11mr16219727plr.160.1590938871398; 
 Sun, 31 May 2020 08:27:51 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:27:51 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:56:09 +0530
Message-Id: <20200531152621.2886-16-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:27:55 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:27:53 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 15/27] parsing_cocci: pretty_print_cocci: Reflect
	struct end attributes
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

Struct end attributes are added to the SmPL AST. Print these changes in
pretty_print_cocci.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/pretty_print_cocci.ml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/parsing_cocci/pretty_print_cocci.ml b/parsing_cocci/pretty_print_cocci.ml
index e554a6df..aaea3f9d 100644
--- a/parsing_cocci/pretty_print_cocci.ml
+++ b/parsing_cocci/pretty_print_cocci.ml
@@ -580,7 +580,11 @@ and declaration d =
       close_box(); mcode print_string rp;
       print_string " "; mcode print_string eq;
       print_string " "; initialiser ini; mcode print_string sem
-  | Ast.TyDecl(ty,sem) -> fullType ty; mcode print_string sem
+  | Ast.TyDecl(ty,attr,sem) ->
+      fullType ty;
+      (if not (attr = []) then print_string " ");
+      print_between print_space (mcode print_string) attr;
+      mcode print_string sem
   | Ast.Typedef(stg,ty,id,sem) ->
       mcode print_string stg; print_string " ";
       print_named_type ty (fun _ -> typeC id);
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
