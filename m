Return-Path: <SRS0=bJsz=6M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC2FC83000
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:04:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31A620757
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGnQcBwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31A620757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SH3uRX023695;
	Tue, 28 Apr 2020 19:03:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 91EC97807;
	Tue, 28 Apr 2020 19:03:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B29213DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:03:54 +0200 (CEST)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SH3rtw009936
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:03:54 +0200 (CEST)
Received: by mail-pg1-x542.google.com with SMTP id o185so10648817pgo.3
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 10:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q9ypuI2Md0mVYC2/fR1d5UCBTOm19QzTtQ7LOldzd/4=;
 b=sGnQcBwj0+KWdi3/t43j3icLp5UtL4LzlrApg+HHE+KsfkZ9L6CvqNVabhgxyCy/Gc
 cnVJbKCpvMkjZfPNPA1Md7CMVSEgyU8k1kW8geRQd8hC/ibWlFf9MNKXFM29pV4C3hp8
 3VciX5SDw4vqTa+xIdy/XvE43j4WnGREY4gAU++KmoN8Vl2fJCZOJ3U0ylrGx6Du0ntC
 aSJ+wWsYR5rX2KVWmrvpTzw8C+66enrE0bM2EC4fijOn1SSupV6KSUV2mlDlv87UV534
 kjyrIKn6EIYdygETvz9UnC9NDoBLjzD6BxEMUQmB63oPAkREuayKK5LPVBhCqhuHgoe3
 MAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q9ypuI2Md0mVYC2/fR1d5UCBTOm19QzTtQ7LOldzd/4=;
 b=ENlWk8GyaY1A/Ei7bsg6fm07MiSJMTjMasoQVFzubIdkFrAzZZPY8asJMQ1nPB+Hrl
 aL8EKH/ZkPe/jmyQ24CodYIS6c8sVmEOook0ACAH7ZEbzBUHiC+uDzke80ocYrjkOYG1
 WQdMv0K3ELgM2nKAx6He348vyOsK0+OSDnW21E0+HK/kFC49p8D9i9SNOAykj0W/Mmr1
 7YJ23ppQLTokqcXvM3TRe/UyeE/ENomLV2O41jwqNcOeNa5XnErdZhPwBv1dBKA85nQU
 FG0bLRfh+X9+XoNpNoQIQVwSWxsxOWGPmFTO4mF0up1+yZESBX+H/M2Qi0f5xRSV+Lqo
 wXSA==
X-Gm-Message-State: AGi0PuZmg2+axlE2CP0wmVrf4LrvGxm39vyI/ZEwV3Uhli3xTM1AKboj
 POl8WYxexRdgixQVBNc8P6TCQzVhOyg=
X-Google-Smtp-Source: APiQypK3QbMs2Nq/04EQeN1osXxk5PqrNu9YDcoiv+tUFTgay2wdPXeVdMfqymHZKQeMDvCeqMYVmQ==
X-Received: by 2002:a63:cf10:: with SMTP id j16mr28578648pgg.201.1588093431303; 
 Tue, 28 Apr 2020 10:03:51 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.163])
 by smtp.gmail.com with ESMTPSA id u15sm2505097pjm.47.2020.04.28.10.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:03:50 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 28 Apr 2020 22:32:13 +0530
Message-Id: <20200428170228.7002-18-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:03:56 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 19:03:54 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 17/32] parsing_cocci: ast0toast: Reflect Cast
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

Cast attributes are added to the SmPL AST. Reflect these changes in
ast0toast.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/ast0toast.ml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/ast0toast.ml b/parsing_cocci/ast0toast.ml
index 09c28c06..56f684ee 100644
--- a/parsing_cocci/ast0toast.ml
+++ b/parsing_cocci/ast0toast.ml
@@ -439,9 +439,10 @@ and expression e =
 	Ast.RecordAccess(expression exp,mcode pt,ident field)
     | Ast0.RecordPtAccess(exp,ar,field) ->
 	Ast.RecordPtAccess(expression exp,mcode ar,ident field)
-    | Ast0.Cast(lp,ty,rp,exp) ->
+    | Ast0.Cast(lp,ty,attr,rp,exp) ->
 	let allminus = check_allminus.VT0.combiner_rec_expression e in
-	Ast.Cast(mcode lp,typeC allminus ty,mcode rp,expression exp)
+	let attr = List.map mcode attr in
+	Ast.Cast(mcode lp,typeC allminus ty,attr,mcode rp,expression exp)
     | Ast0.SizeOfExpr(szf,exp) ->
 	Ast.SizeOfExpr(mcode szf,expression exp)
     | Ast0.SizeOfType(szf,lp,ty,rp) ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
