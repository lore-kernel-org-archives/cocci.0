Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73450C433E0
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:22:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E052A206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L71OqMkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E052A206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHM1gt019490;
	Sun, 24 May 2020 19:22:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 978143DC8;
	Sun, 24 May 2020 19:22:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BD4473D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:21:59 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHLw2O017524
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:21:59 +0200 (CEST)
Received: by mail-pj1-x1044.google.com with SMTP id fs4so635006pjb.5
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LRntHaUBFLsviLdl90o1C1s3Xmmq01PYd9cvb+sl1b4=;
 b=L71OqMkTIGYw/zLC4kQiVknJ/9dn4yFFrIElZ8KLQhydCy6ySravMVorUKJ/OHm113
 1LHD86mqlmxyYG52Z41VM6j41mgaMirXlp4KJCfGOp53UeXZxq9NRAa0pgnXzZgrWn+f
 YywEJdShHlsyEHvAamxpKh2TnGEKU+8/Q2gRXD0zG673DClz96aQ+b8oQer0kRBD/rvK
 GqvRPivNzUp/YMOhX+Dv283edAy03XKbRRJNPiGSgC/sjN+3Cv67trnNrdDR1Wn/NwI+
 cUhaGz/cxJ/r+nnbx645TRNLGafVgYh3YY7jrjWKAcqXoXLfLyPx7NQU3zO3Onc3XsPS
 tG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LRntHaUBFLsviLdl90o1C1s3Xmmq01PYd9cvb+sl1b4=;
 b=nbGDPL2v1ZKCjLnTDCqCKImnqUDvgHTy9CTS5YuHxWr9LNlwgwUBIN6eYeCf0nUw8R
 owYwEfxrw2tH1bn1xKbD2E868NLiSyHKBT2iHvbwjvCdVo/pxZjKzr/L8QJOu9qohqcX
 jkE6G/ZnbJpmkpSA3+3kpYAJRWSz4dN4ucSqvIfJsBoyqUeTdGC9Ts/co0YOisUfxvL/
 bHILMGQko/mEiFdvkA8fpx6Enhlc8dM7ttJDBwJjR0LrxQg83oK56nACRElg2ca2VjH5
 N0ZTgNA2RNi0vNlTXCny2cfJ8lDzV9vnCQOAVspg/KAPnUh/UcJVN3SB4qd+Or4WuoJU
 cyMA==
X-Gm-Message-State: AOAM530pGqHLJLJdkCADwwGn7V3vFFtludmaX5gbvFFkRUWUouxsOMy1
 56AgkCfJOlBkrC+OGaBB7SR4/GrYXgE=
X-Google-Smtp-Source: ABdhPJxBSHTJ/NZpzHA9ZlwKLhRcZ64FVbhwLvvDv9PLt3hnVUvYGez+aILXadhVQZO/0+o3b5oXtQ==
X-Received: by 2002:a17:90a:f18f:: with SMTP id
 bv15mr6374896pjb.37.1590340917431; 
 Sun, 24 May 2020 10:21:57 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:21:57 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:27 +0530
Message-Id: <20200524171935.2504-23-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:22:01 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:21:59 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 22/30] parsing_c: visitor_c: Reflect Macrodecl
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

Macrodecl attributes are added to the C AST. Visit these attributes in
the C AST visitor.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/visitor_c.ml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/parsing_c/visitor_c.ml b/parsing_c/visitor_c.ml
index 57b5f32b..3cc73ea8 100644
--- a/parsing_c/visitor_c.ml
+++ b/parsing_c/visitor_c.ml
@@ -548,8 +548,9 @@ and vk_decl = fun bigf d ->
         iif ii;
         vk_onedecl bigf x
       );
-    | MacroDecl ((_stob, s, args, ptvg),ii) ->
+    | MacroDecl ((_stob, s, args, attrs, ptvg),ii) ->
         iif ii;
+        attrs +> List.iter (vk_attribute bigf);
         vk_argument_list bigf args
     | MacroDeclInit ((_stob, s, args, ini),ii) ->
         iif ii;
@@ -1464,10 +1465,11 @@ and vk_decl_s = fun bigf d ->
     | DeclList (xs, ii) ->
         DeclList (List.map (fun (x,ii) -> (vk_onedecl_s bigf x, iif ii)) xs,
 		  iif ii)
-    | MacroDecl ((stob, s, args, ptvg),ii) ->
+    | MacroDecl ((stob, s, args, attrs, ptvg),ii) ->
         MacroDecl
           ((stob, s,
            args +> List.map (fun (e,ii) -> vk_argument_s bigf e, iif ii),
+           attrs +> List.map (vk_attribute_s bigf),
            ptvg),
           iif ii)
     | MacroDeclInit ((stob, s, args, ini),ii) ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
