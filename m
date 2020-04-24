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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B839C55186
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F90020724
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iv8PGlmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F90020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03O9JfkK000572;
	Fri, 24 Apr 2020 11:19:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 97C6F7827;
	Fri, 24 Apr 2020 11:19:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E2E8D7815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:39 +0200 (CEST)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03O9JcIv008151
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:39 +0200 (CEST)
Received: by mail-pj1-x1041.google.com with SMTP id y6so3676349pjc.4
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 02:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m6sHL+daGjFtrlFNbl9xtJCyZuqsxj+72Q2ol8+9r+0=;
 b=Iv8PGlmuwbkD0guC8QIFoOL9a5hzEmaY1L1iNLcUE5NGuRwKhR3p2yCPWWMQTbaCao
 1/E7kLHf7TKQ/gkW7fABWuoJWwKm+ppW4TrI1kFSS68kWHkCrH7wsYBspjBN2M5guVq1
 Yg2faEEDsnJl9xU95Yb0iTJvQ9P18kercYHLeua6Ks3agmYJXpBRX8MGBoHtZz/4/USg
 rtyhzeR+Zr2xgVTJTbdWWc7u85xFj6I4ufWgP4rHJGRvwui3udU1fC70y8JQ96t2Xda6
 8WUDiEDIZDnrSW4V/5PFdiFkBceI9IFxQH/Vk1sePoIZFW0XaJ+QZ0zI7HhOu6U761DU
 JNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m6sHL+daGjFtrlFNbl9xtJCyZuqsxj+72Q2ol8+9r+0=;
 b=AOiC1V/1BDTfXrw6B6ZXYWp+7yoDXld7whA4kyGoRYXmBh9Q6mHVGdLxS6h9AMPvMZ
 daXpcKIHNUdUd9fjXw+fFQH1rM4K6YLmzOGjKg2ocFc3aijSyXXtM7SvSWhXtzK2zgCq
 z8QTZqGBptwyZ5/WTUGPY4q2i60vpKR2HPWdDiRPyRdX9uIsKwKGmB7hFHmZCUFSLxpX
 2RZMFTRchoju1xakSgiglVjFy49LQpVJkjXWjm6GOa81wEcXRhYSqBkP6UFGIyg3ujge
 v3xNwtAKbzkd4OFLZ3dFMU/1Q/4KbABTDA65yR9h3l3WBGazHmgbcSc3Gqr9FlSnLhON
 f2Ig==
X-Gm-Message-State: AGi0Pubqgnleb6UPB6DofccIBR8Mc6mC7oqLkz5mwL8+r/bt7BJoj3i8
 /HG4KdrcaF5u1MJedkJRb4NSDAQ4xAU=
X-Google-Smtp-Source: APiQypJgkh/ILYXOcHq22DB3g6nBMjiSUyILPmk6zxPMOsWywXF6FioWrPKVRE3wXMuQOLNnxMEnjA==
X-Received: by 2002:a17:902:40a:: with SMTP id
 10mr7980835ple.183.1587719977430; 
 Fri, 24 Apr 2020 02:19:37 -0700 (PDT)
Received: from localhost.localdomain ([1.38.216.60])
 by smtp.gmail.com with ESMTPSA id c80sm5043933pfb.82.2020.04.24.02.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 02:19:37 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 24 Apr 2020 14:47:54 +0530
Message-Id: <20200424091801.13871-19-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
References: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 11:19:41 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 24 Apr 2020 11:19:39 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [RFC PATCH 18/25] parsing_c: parser: Make
	abstract_declarator pass attributes
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

The attributes in abstract_declarator can be used for adding parameter
attributes, cast attributes and others to the C AST. Make
abstract_declarator pass these attributes in a tuple.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parser_c.mly | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index da6b9c7b..0c3da206 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -1397,13 +1397,14 @@ tccro: TCCro { dt "tccro" ();$1 }
 
 /*(*-----------------------------------------------------------------------*)*/
 abstract_declarator:
- | pointer                            { snd $1 }
- |         direct_abstract_declarator { $1 }
- | pointer direct_abstract_declarator { fun x -> x +> $2 +> (snd $1) }
+ | pointer                            { $1 }
+ |         direct_abstract_declarator { ([], $1) }
+ | pointer direct_abstract_declarator
+     { (fst $1, fun x -> x +> $2 +> (snd $1)) }
 
 direct_abstract_declarator:
  | TOPar abstract_declarator TCPar /*(* forunparser: old: $2 *)*/
-     { fun x -> mk_ty (ParenType ($2 x)) [$1;$3] }
+     { fun x -> mk_ty (ParenType ((snd $2) x)) [$1;$3] }
 
  | TOCro            TCCro
      { fun x -> mk_ty (Array (None, x)) [$1;$2] }
@@ -1461,7 +1462,7 @@ parameter_decl2:
      { LP.kr_impossible();
        let ((returnType,hasreg), iihasreg) = fixDeclSpecForParam (snd $1) in
        { p_namei = None;
-         p_type = $2 returnType;
+         p_type = (snd $2) returnType;
          p_register = hasreg, iihasreg;
        }
      }
@@ -2118,7 +2119,7 @@ define_val:
      }
  | decl_spec abstract_declarator
      { let returnType = fixDeclSpecForMacro (snd $1) in
-       let typ = $2 returnType in
+       let typ = (snd $2) returnType in
        DefineType typ
      }
 
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
