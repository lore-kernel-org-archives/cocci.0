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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412A3C2BA1A
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B982074F
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXzGkVzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B982074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03O9JVqM006357;
	Fri, 24 Apr 2020 11:19:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3D7D17827;
	Fri, 24 Apr 2020 11:19:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BBDB87815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:28 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03O9JRH9026852
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:28 +0200 (CEST)
Received: by mail-pj1-x1042.google.com with SMTP id a7so3699042pju.2
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 02:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kkmMfCn78jeLBrlG5zHTVXjT0l4ypf79mn+DmgCmYOA=;
 b=WXzGkVzIhLcUWM99DMUrWoa9sIC38Yz3Gk/3bAuNSgkZGGQ6tfnCSuyTAdhkwwhFni
 cuYBueTVvpuDBprwSwv63R4IKpwstEbZRG8svV/D9DU7gzSfQVewaKWJHusfsyM1HtO6
 IL5juAwCkigllEETLpaiFE37U1YugKIECaQbJL76e4yOx/dY2IZqTvxDAJ4vHJHcGaj+
 TQOFr2rU8L1pl6IOLWEoIKP6kFJbo6PiZYcVccNc1M/Avl1JvO+WqCXo7+v7v7VLj7iW
 grtOQBVYv1iaA2hXwEL1p7CSN980yFYFYGsiIuknoT7NQdKjuniAQLwp2WjoAaeKiW5c
 uhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kkmMfCn78jeLBrlG5zHTVXjT0l4ypf79mn+DmgCmYOA=;
 b=hm7FuQOmGLapuQAROJRqeM6lluW3ybCsl1S/P0wq7jpMVV7+6lEgQRr4oprrMOQ39q
 a4uXkMquR2Zxh3tit4LPZwpsWeDOwY/I+45lcyJYMztbypFd9gSsJezRpo5Z1XdYBunl
 6F6EvYQvb4p7GtGs2Yvtj8KCI9DdC8SwCJpQo+brsYp6m69lngpGoGLbTTNX7EYpIZUJ
 27sbtOrfBNxVkbu50qsAImeRhNzSsVjwKlLqK7ZWdWATvUYcqjXcMLU1L+igRGJjvsNB
 l8fYYYfDRBMg4tf9XFj+8QaFaEH3o+KjiCDg/RaUNGuP7MnNsIybSia+k3RYNcpWwWRF
 UPcQ==
X-Gm-Message-State: AGi0PubEZZLiD/5tZAXFzkIT9ks617NOVdj1JHSJi88d3YenP0As/XXO
 qhAI5D7g9Sx2Kzg1xQrWt+/JAQ7rSGw=
X-Google-Smtp-Source: APiQypJdIs4tzwi74kUNnMhdUlyNu8a7Icrd7Si+ZRxT6ZdHRH5BHmfCaW88ri7ahe4tta0dWRJhqQ==
X-Received: by 2002:a17:90a:734b:: with SMTP id
 j11mr5168948pjs.108.1587719966223; 
 Fri, 24 Apr 2020 02:19:26 -0700 (PDT)
Received: from localhost.localdomain ([1.38.216.60])
 by smtp.gmail.com with ESMTPSA id c80sm5043933pfb.82.2020.04.24.02.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 02:19:25 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 24 Apr 2020 14:47:51 +0530
Message-Id: <20200424091801.13871-16-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
References: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 11:19:31 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 24 Apr 2020 11:19:28 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [RFC PATCH 15/25] parsing_c: lib_parsing_c: Add ii_of_attr
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
