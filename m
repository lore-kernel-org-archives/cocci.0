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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986C8C55186
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:18:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F0420728
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax+kMoLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F0420728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03O9IYrE003810;
	Fri, 24 Apr 2020 11:18:34 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1FAF77827;
	Fri, 24 Apr 2020 11:18:34 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B4C9E7815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:18:29 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03O9IRU9004584
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:18:28 +0200 (CEST)
Received: by mail-pj1-x1042.google.com with SMTP id ms17so3707300pjb.0
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 02:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p7rZYxRe2Sz/SF1CBsPRfrtZT5FjMYD5co3xZ8oxX9U=;
 b=ax+kMoLm3IIrCgdTQX2Gm3JD4LhEF5plv3ZtAqoMNdfIcoYZPGjd2FVfUbCSSE4ddg
 M+9WIB8b1hcIMskIcbEq7UjDMQPXbj5pjXqPhY38kuazQ6KoG3GZL5R3oQwxMoRzslYG
 L5H+KhZBhnF22dqlMMRoFw7pj3qdFDfD/jTWBKhiaa7ZsrSd4kenBlEKDfLpsXMUZ7gN
 Ob2DSssZTTBbdbMy6GEfY3En6FuSKY56LfrerDkggsFrPQ3KtCgPjPrDwIIG0+ZHwSMa
 jTD+RFP3sbkMFjcbAZDE30bOrAE/2rn/o27C6craeAhnZ4N04I2lBkApdfwL7lOGAVCA
 rf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p7rZYxRe2Sz/SF1CBsPRfrtZT5FjMYD5co3xZ8oxX9U=;
 b=TP8jfNtEemN8qV+dWPT2fM3OkTvg4eZqAkddHbZhPb9HsG+piGCUmZ0ajfbgvFggOs
 6tcigvdHSP0YTFjY59mcwuMpEcwUpv9C34MRFtqQW4x0TwsVXXZIJCK84/2j0zIkdvLY
 uYpa+4DO+yt7nlrwzDxVPwhMVegFF1xiC2DhP83KNo1sKDOmz5OA2JZdPw+xu7j1w+XB
 0B2uy9H4drd+C9830S/YsFxvXxqT4j3MkfHTDykndf2drPrl63PKp38SjI0SZHPPPQVi
 G0m8zkYY7Wx8+uwqRLETTC1Jns/TX3TZCCECB3rZ3rHxWiYxYFcHCv5J5ChafABfPXhr
 2/lg==
X-Gm-Message-State: AGi0PuZZ3/pcl2P972wJzN/WbyhlFh2B3eJc4GbH/aHGqDNH5AtZFxun
 7RGAQnxmAyI2Z4HW+j3Qwis4cAZYVDE=
X-Google-Smtp-Source: APiQypLl0zlT037EQQDQ8+HF0G5thYz4Qg5QjEdoEA3+lx2Tc5CQoapKECljGfYOnhddBhqwbGPXFA==
X-Received: by 2002:a17:902:788e:: with SMTP id
 q14mr8138360pll.72.1587719906293; 
 Fri, 24 Apr 2020 02:18:26 -0700 (PDT)
Received: from localhost.localdomain ([1.38.216.60])
 by smtp.gmail.com with ESMTPSA id c80sm5043933pfb.82.2020.04.24.02.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 02:18:25 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 24 Apr 2020 14:47:39 +0530
Message-Id: <20200424091801.13871-4-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
References: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 11:18:34 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 24 Apr 2020 11:18:28 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [RFC PATCH 03/25] parsing_c: parsing_hacks: Commentize
	attributes before qualif/type
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

For the following example from fs/btrfs/ctree.h in Linux v5.6-rc7:

__cold __noreturn
static inline void assertfail(const char *expr, const char *file, int line)
{
	pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
	BUG();
}

__cold and __noreturn are not labeled correctly, leading to C parsing
errors. Add a case to commentize attributes before a storage
qualifier/type qualifier/type correctly.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parsing_hacks.ml | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/parsing_c/parsing_hacks.ml b/parsing_c/parsing_hacks.ml
index 74c3ba60..0254fc7f 100644
--- a/parsing_c/parsing_hacks.ml
+++ b/parsing_c/parsing_hacks.ml
@@ -1952,6 +1952,29 @@ let is_type = function
   | Tshort _ -> true
   | _ -> false
 
+let is_type_qualif = function
+  | Tconst _
+  | Tvolatile _ -> true
+  | _ -> false
+
+let is_storage_spec = function
+  | Tstatic _
+  | Tregister _
+  | Textern _
+  | Tauto _ -> true
+  | _ -> false
+
+let rec is_idents ?(followed_by=fun _ -> true) ts =
+  let rec loop l =
+    match l with
+    | x::xs when ident x -> loop xs
+    | x::xs -> followed_by x
+    | [] -> failwith "unexpected end of token stream" in
+  match ts with
+  | x::xs when ident x -> loop xs
+  | x::xs -> followed_by x
+  | _ -> false
+
 let is_cparen = function (TCPar _) -> true | _ -> false
 let is_oparen = function (TOPar _) -> true | _ -> false
 
@@ -2134,6 +2157,16 @@ let lookahead2 ~pass next before =
 	  else
 	    TCommentCpp (Token_c.CppDirective, i1)
 
+	(* tt xx yy *)
+  | (TIdent (s, i1)::rest, _)
+    when not_struct_enum before
+	&& is_idents
+           ~followed_by:
+             (function x ->
+                is_type x || is_storage_spec x || is_type_qualif x) rest
+        && s ==~ regexp_annot ->
+	    TCommentCpp (Token_c.CppMacro, i1)
+
   | (TIdent (s2, i2)::_  , TIdent (s, i1)::seen::_)
     when not_struct_enum before
 	&& is_macro s2 && is_type seen ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
