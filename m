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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA446C83000
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:03:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E7B20730
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ziby3/na"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E7B20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SH37Bp006866;
	Tue, 28 Apr 2020 19:03:07 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 327B97816;
	Tue, 28 Apr 2020 19:03:07 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8B3447807
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:03:05 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SH33Nl016718
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:03:04 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id n24so8610649plp.13
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 10:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lwqNogG8vHxP252WZiCGBfjwezgxLB4uDA3affNqJMs=;
 b=Ziby3/naw6SZNptK0ZCBVret6THiTk8NCdfOVQcL5pEDkMbyA1d7jUSkxWmk0HXY5a
 jJHoKYpNRlBD7203vjBRGyoFScDVApy335ZCctijofMroleVwbUBcFExE4Bh8qKB7Fvs
 xOM2d2hVIw5s8oQkDNs4dqMrOdZqcU37y9YbA8ltmHtyLO5lgMc6GjecVo+qg2uSnoqa
 rUbV8h+/5Ep67626NCrJXtaOl7/IlcFeGeryJSEQpCpIvrqwOzg4yhqpSfgXgYXczIhw
 Qxj77NtLP/mxuZAIPE2bfXsPX0wEblxwXCKo4CaN9OlZxTPGRLd7mWVpc5TrTUCYFuXR
 yv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lwqNogG8vHxP252WZiCGBfjwezgxLB4uDA3affNqJMs=;
 b=BRvqWYp9ZZRTBmL40eQdx0bPP8zUz6TFShIdsGTj8s93UALu47f34krJx8UOP+q5S/
 ncgKRFTZE8n7OhxcF8CZwljL7bzo2Wozhs9D6DB8yx5CttktPf+++O2pqBOlzHsqSJS/
 p92e9LKynf27MWJyrCWSKdrPb27RCNB5lVSKs0/81JmBR54NGtKYVuQ6wFX8Jpemu3Ik
 DgBVn7/F8wLtFhJTt5S7QSlLG83GmpdXjwQELIJ/uN7k9sX1ut3gqGL9MDj8HP53N+bv
 qdUh2G6hnhUUUpx5wMFxYmRVcG1ENUBXfQymSQYCnJe6mENg84ZfykHju+ib8g7ql11/
 zewg==
X-Gm-Message-State: AGi0PuYaeKAHY1AISUEwSWFr8OCO//avfkPInc/ogrM5623kGkGInZLY
 1VoQwHuJhgWKzcXJLtPJJcUjrA/dXgE=
X-Google-Smtp-Source: APiQypLqDo69KGOp9D2CpPc5C6DkVAEWYZSECiOGBRVjy40VelsGnjmcTYJWLy4Hl9WyIlNhn77BCA==
X-Received: by 2002:a17:90a:c297:: with SMTP id
 f23mr6397287pjt.21.1588093382259; 
 Tue, 28 Apr 2020 10:03:02 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.163])
 by smtp.gmail.com with ESMTPSA id u15sm2505097pjm.47.2020.04.28.10.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:03:01 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 28 Apr 2020 22:32:01 +0530
Message-Id: <20200428170228.7002-6-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:03:07 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 19:03:05 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 05/32] parsing_cocci: unparse_ast0: Reflect cast
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
unparse_ast0.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/unparse_ast0.ml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/parsing_cocci/unparse_ast0.ml b/parsing_cocci/unparse_ast0.ml
index fdaf6cfa..7f554b37 100644
--- a/parsing_cocci/unparse_ast0.ml
+++ b/parsing_cocci/unparse_ast0.ml
@@ -221,8 +221,10 @@ let rec expression e =
 	  expression exp; mcode print_string pt; ident field
       | Ast0.RecordPtAccess(exp,ar,field) ->
 	  expression exp; mcode print_string ar; ident field
-      | Ast0.Cast(lp,ty,rp,exp) ->
+      | Ast0.Cast(lp,ty,attr,rp,exp) ->
 	  mcode print_string_box lp; typeC ty; close_box();
+	  (if not (attr = []) then print_string " ");
+	  print_between (fun _ -> print_string " ") (mcode print_string) attr;
 	  mcode print_string rp; expression exp
       | Ast0.SizeOfExpr(szf,exp) ->
 	  mcode print_string szf; expression exp
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
