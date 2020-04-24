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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343DBC2BA1A
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A7020728
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcZdQICu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A7020728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03O9JQQ9024379;
	Fri, 24 Apr 2020 11:19:26 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D6C207827;
	Fri, 24 Apr 2020 11:19:26 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0F0097815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:25 +0200 (CEST)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03O9JNDm004513
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:24 +0200 (CEST)
Received: by mail-pf1-x441.google.com with SMTP id v63so4515431pfb.10
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EuaS5Onylm7y9OnVpbHrxgUexCsuvS51b9zNiFw/YOQ=;
 b=QcZdQICuKkFx/+c2cAaj0pnd5U38R5lfZYAjRV9TYM0JgiuHF9Wh5rNMkbyr081Vm2
 zcr5gFyi+AqTyFrK7U8cbg8GidfM6yeuBCc/aUumwCylW3m+c9APpUwWgQFvCzGpEIWg
 m2Bwz3Kfkrwlh6+6P2JMBlxwNSD6HuqQ5WiqNEJSH6zi8Vs6469ULfXCX6jvx7929+hS
 QLo1ph/ZloJ8DpPFWEA01K3+UnAcIqfS/6b6cBWfI1PL+t+uOlTyr4TeIJMi7JVUKFj4
 kIPf3BRxB4gucwzBu2ya8wIZn5EFxvfJ4sfh6bOXdkLsb7NCleKVKxsTU/WF6F67Kef2
 8e9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EuaS5Onylm7y9OnVpbHrxgUexCsuvS51b9zNiFw/YOQ=;
 b=P/yOqq3SlW516527hxIGhP0OBFzlVeW11xDci8hDRY6QDFxhmZFecrU9lqQjPRaUbU
 0gAaeTwId7X2I6Ppknlml2cLd7HeXe/hniB5mny0rR3voaj2mb1V8DlLxJnJFIFCJISS
 JGJG/IExFMPRUTXB1tMIuK7qk0StFTTY4vSOSwNJlG1OGA1PheGTOjpqVvM8D5A0DlFS
 SYDaSn6LOd5RgHJxBDyst6rtcc0QpSKir/7LcPGnpUGC574j5S20PYKUNg7QAfAKG0J0
 l+oTdagwCifJ2bVwtjwE6o/eIoICQ+tEtQpx5f18ebQG3NJUnWl+IOdeUHCoUk9+TgAI
 Fgxg==
X-Gm-Message-State: AGi0PuZdWbAbnbfoELuRvlzLb5SAJDAQmlDKbwvfn9rATjdaj4Bg+seK
 wwmoutKFMG6zacQQratknPpmMuT2YBA=
X-Google-Smtp-Source: APiQypLBdqZLlngLtD1Tsa3cKdMz3kB/W3pEYuQEjiB1UZxA2zS2dI8Ibt/84enECqev0qhW2pyIig==
X-Received: by 2002:a63:e40e:: with SMTP id a14mr7958563pgi.432.1587719962742; 
 Fri, 24 Apr 2020 02:19:22 -0700 (PDT)
Received: from localhost.localdomain ([1.38.216.60])
 by smtp.gmail.com with ESMTPSA id c80sm5043933pfb.82.2020.04.24.02.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 02:19:22 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 24 Apr 2020 14:47:50 +0530
Message-Id: <20200424091801.13871-15-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
References: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 11:19:26 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 24 Apr 2020 11:19:24 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [RFC PATCH 14/25] parsing_c: visitor_c: Add vk_attribute
	and vk_attribute_s
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

vk_attribute and vk_attribute_s were not declared in visitor_c.mli.
Declare these functions in visitor_c.mli to use these outside of
visitor_c.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/visitor_c.mli | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/parsing_c/visitor_c.mli b/parsing_c/visitor_c.mli
index 1a76b87c..85551fca 100644
--- a/parsing_c/visitor_c.mli
+++ b/parsing_c/visitor_c.mli
@@ -86,6 +86,7 @@ val vk_ident_list_splitted : visitor_c -> (name, il) Common.either list -> unit
 
 val vk_exec_code_list_splitted :
     visitor_c -> (exec_code, il) Common.either list -> unit
+val vk_attribute       : visitor_c -> attribute -> unit
 val vk_attrs_splitted :
     visitor_c -> (attribute, il) Common.either list -> unit
 
@@ -205,6 +206,8 @@ val vk_exec_code_list_splitted_s :
     visitor_c_s ->
       (exec_code, il) Common.either list ->
 	(exec_code, il) Common.either list
+
+val vk_attribute_s : visitor_c_s -> attribute -> attribute
 val vk_attrs_splitted_s :
     visitor_c_s ->
       (attribute, il) Common.either list ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
