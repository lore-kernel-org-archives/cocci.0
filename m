Return-Path: <SRS0=FJ6B=7K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A74FC433E1
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:25:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF40520888
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRu5FccV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF40520888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04SCPcH2013926;
	Thu, 28 May 2020 14:25:38 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3F1EA5D47;
	Thu, 28 May 2020 14:25:38 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0C86D3E1D
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:25:37 +0200 (CEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:543])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04SCPZMm023126
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:25:36 +0200 (CEST)
Received: by mail-pg1-x543.google.com with SMTP id p30so13399140pgl.11
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 05:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kkmMfCn78jeLBrlG5zHTVXjT0l4ypf79mn+DmgCmYOA=;
 b=tRu5FccVI83mCNdAzuE6PGvTomTtHLwsrXKA88tpsukf3POgraoi7Tsx234wlc4lQm
 FSjGX3QZ0cU0ozHaPNWJGnIC5ACJSFDsmQ9tDcUScyPk4MpLpY8+GSa4dFMFSvF4KQjQ
 YHTaaTADyFxbdtJeeOd6FdpA2UrvpEdfyDyqXD9XlE9nlQ7hSt+ATtAMzAbVbBPV9NyW
 cygrImXWY/wSz52qZhMVAChE1hyF3fdBIVH9zH5b4BRVsLjpe6ItIduWaYQGkht+Udbl
 yNTFtiUKyOPox4fvhH7ZsCoWy6wUC4yS8/NJPNDjaPK+LEO3+EbO/VdbhG6ZzRwlQ/wV
 jufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kkmMfCn78jeLBrlG5zHTVXjT0l4ypf79mn+DmgCmYOA=;
 b=I0wizt8Oh3viGBD0XaTGi7TU+01lXbhi/pn5yhh8na1bTQJAsrUdAcoBSKxHTzQ/q4
 fkcFklz4MkHALO/GmkqL4rMjEpgLrR3A25M8YxHxjmFrRzywa4nvO+hBdBAbZ22kW3vV
 7YAEsGQVd9j6sCcG2lmLqebUJqCmtkLIpVsZzMPWwxBxor9xqEd6ShOfuxPwrq9mfzC5
 F1KAmHKrCVjAKkqgYEklzafoz/v/Cas9wAnQsJ3cOwCMQ9lUzxWyjcuHQ4106HG0uIAE
 yC4YRkNOOlDXErv0gyDDh00EZViVewMMGd/x2sBEkTBT3XkZ9FRW2oUjJAtwxJwTmuCO
 0vMw==
X-Gm-Message-State: AOAM5335w47I7zXoAQykLQTIBy7uh7U1vLa9dGejoa6jS0Zdex2s4Yhu
 dOMHx+j0i9JYIytHC2tzCvoym/XU
X-Google-Smtp-Source: ABdhPJwcmshj88XR2zCpdAosuQUEyA4esnmBodP7AG8KRRi7UwWwh+3xm1QjBs0IeW0UpnrVoJal1Q==
X-Received: by 2002:a62:ed10:: with SMTP id u16mr2891940pfh.0.1590668734531;
 Thu, 28 May 2020 05:25:34 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2183:e360:deba:7bf4:98ef:5568])
 by smtp.gmail.com with ESMTPSA id 1sm5722888pje.26.2020.05.28.05.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 05:25:34 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 28 May 2020 17:54:17 +0530
Message-Id: <20200528122428.4212-16-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
References: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 May 2020 14:25:38 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 May 2020 14:25:36 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 15/25] parsing_c: lib_parsing_c: Add ii_of_attr
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

ii_of_attr can be used to get the corresponding info of a single C
attribute. Add this function to lib_parsing_c.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/lib_parsing_c.ml  | 1 +
 parsing_c/lib_parsing_c.mli | 1 +
 2 files changed, 2 insertions(+)

diff --git a/parsing_c/lib_parsing_c.ml b/parsing_c/lib_parsing_c.ml
index 2ab3b3a9..99e43be3 100644
--- a/parsing_c/lib_parsing_c.ml
+++ b/parsing_c/lib_parsing_c.ml
@@ -315,6 +315,7 @@ let ii_of_define_params =
 let ii_of_ident_list = extract_info_visitor Visitor_c.vk_ident_list_splitted
 let ii_of_exec_code_list =
   extract_info_visitor Visitor_c.vk_exec_code_list_splitted
+let ii_of_attr = extract_info_visitor Visitor_c.vk_attribute
 let ii_of_attrs = extract_info_visitor Visitor_c.vk_attrs_splitted
 let ii_of_toplevel = extract_info_visitor Visitor_c.vk_toplevel
 
diff --git a/parsing_c/lib_parsing_c.mli b/parsing_c/lib_parsing_c.mli
index 1fc59420..d9578f3c 100644
--- a/parsing_c/lib_parsing_c.mli
+++ b/parsing_c/lib_parsing_c.mli
@@ -125,6 +125,7 @@ val ii_of_ident_list :
   (Ast_c.name, Ast_c.il) Common.either list -> Ast_c.info list
 val ii_of_exec_code_list :
   (Ast_c.exec_code, Ast_c.il) Common.either list -> Ast_c.info list
+val ii_of_attr : Ast_c.attribute -> Ast_c.info list
 val ii_of_attrs :
   (Ast_c.attribute, Ast_c.il) Common.either list -> Ast_c.info list
 val ii_of_toplevel : Ast_c.toplevel -> Ast_c.info list
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
