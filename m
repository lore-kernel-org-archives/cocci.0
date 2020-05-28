Return-Path: <SRS0=FJ6B=7K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95AEC433E0
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:24:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B7A20888
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2qbNJbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B7A20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04SCOtj8017428;
	Thu, 28 May 2020 14:24:55 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 28B275D47;
	Thu, 28 May 2020 14:24:55 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 23FF43E1D
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:24:53 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04SCOpt4013843
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:24:52 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id k22so11513391pls.10
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 05:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p7rZYxRe2Sz/SF1CBsPRfrtZT5FjMYD5co3xZ8oxX9U=;
 b=p2qbNJbKh1tYHNFAD1TOdvrjaa2Zv6dfWxu6Xj7uoVYtWrAxgMnzMwbdCS0BNFhPv/
 eY8kJdK7DPBVJATJgSwxFaeGdCdIIWMjcJRjLFtzja0tFVtsyRilz9NZ4Ae/vBfgK/Zi
 /Or7uCRQsgokoEaivFolGC1uF9LaGp38r8qrCLl+LlyFYvzb+qqA0m5lbRb/mltOvT+0
 DB449kJrspmftzQVvuPkkxHz/2HEJNuLpae4E3R3/Vqoeni8ZJdcnry+xMgUBq37M1RK
 xt7pK12eVOEJiUsalOnxr4lMlBUTGKXK0dzCy9FGEZHjfEElom2A2iwY21vnpPIEuD2l
 KBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p7rZYxRe2Sz/SF1CBsPRfrtZT5FjMYD5co3xZ8oxX9U=;
 b=qsi0O+gFUJn617i/WHJ2lnxN4Qqa+dy8FYDdS/IHJzNKxw5x0We6HLPVQwoffxV6EE
 yOXki4cxKagt0c70SCkasChFJGaZ2mEdFE6zYdgFAWhRhfVA9ybKXQw/ewnqyScImjqi
 wwPG0MOtfim0wepC3GeF9nmmAmKoADR54LIouIT0FwIhD+4cvtHP9jHf2cGjJ7HgZBfC
 C+2ZyfTuJBJBDoyMf4LRS9ezPPF9g4qiDGhrxw21bk7ssZ+5AXiH7qrs9qBtjuRn0CSR
 RQY6OrJ9Cb8XFNq8XknZOTboICawFc1Phr11HK6TuF3rnpaPZnmhJtpHSu3wOv9OwYha
 rQ6w==
X-Gm-Message-State: AOAM533ZdjXxgX7yJqZqD9U3Dnd4W9K57Or2ubAe+0mCzYBCxBuGaDZz
 gZzcx9fdDxsFbW2UbSic1lz3cUdp
X-Google-Smtp-Source: ABdhPJwPWX+X3N67i74tHc8wp6Chun7bEhZeV3lFazC8xF0suRajYlLNI5FcCJtUgxQ8mtbl3oCS/Q==
X-Received: by 2002:a17:90b:80f:: with SMTP id
 bk15mr3628404pjb.51.1590668690457; 
 Thu, 28 May 2020 05:24:50 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2183:e360:deba:7bf4:98ef:5568])
 by smtp.gmail.com with ESMTPSA id 1sm5722888pje.26.2020.05.28.05.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 05:24:49 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 28 May 2020 17:54:05 +0530
Message-Id: <20200528122428.4212-4-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
References: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 May 2020 14:24:55 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 May 2020 14:24:52 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 03/25] parsing_c: parsing_hacks: Commentize
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
