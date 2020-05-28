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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61451C433E0
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:25:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D576B20888
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4JQkInV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D576B20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04SCPY6f015782;
	Thu, 28 May 2020 14:25:34 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DB9755D47;
	Thu, 28 May 2020 14:25:34 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AAD003E1D
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:25:32 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:62d])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04SCPVvs021280
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:25:32 +0200 (CEST)
Received: by mail-pl1-x62d.google.com with SMTP id bh7so4591892plb.11
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 05:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EuaS5Onylm7y9OnVpbHrxgUexCsuvS51b9zNiFw/YOQ=;
 b=U4JQkInVvvQhTvMXTd0lCYi7M8PVeq/yJp+jelxP0XMn9qIi0gOlFOxwsfoz4VVhfd
 mR6/7FauKJIXZyNNEaM+FLhHNrg2rdRSsmt5F6tI0LmRFqYSeIYO2Fk9aDoAB42H0J2S
 kJneJsz6wOjKzSTgUaIvHIGsnhOtvyoMdWK9BAfrMowndilhWiJFlFMeWM6Ls6ofKv9A
 LBUb8EQFRcpNjUGSCiobNzAhu4efeyzBdtnHMYN2nKuADfjt9bVyC+JVmLo6X9ozEI2X
 YWtNVBdHTA9rj2WM07z2VQazO+yxoj9d7D52HbHGGJgkmde0gMCLi17sAf7I+akzIRq+
 S1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EuaS5Onylm7y9OnVpbHrxgUexCsuvS51b9zNiFw/YOQ=;
 b=cKCpkOTWCvGg8C6bY8DPA/Fz+V8yGhaAaAZufcPRKoceEHLweO/1ollxFYEaj9Qfvv
 kCiSoaORd9WalVUH6ku1ZOBmm49TWxQwY1HpdrWf5gAPiR9O7uSWV6X1yzoqPBauc0if
 LcaU9QLa638PyEkItaUveOVLwQL6hnZWRZGbtgeHBH6ztcYzrhkxmo/FJAT/1nqv/NVj
 LAJQp0/QVyVj8OoMuqVh0u6rzeQU1pTQ1elyJAQIgO2RrijtBWsvmyi/z74Wt3DQvVCz
 wQoRnc71eEb3cnGa1a91yTiJJ4dCH+mneLWDd1lnZ0XRs01267EaOE8vnQVCc9/Mj9s8
 i6Eg==
X-Gm-Message-State: AOAM530Oekhfhdw+39bl2YZDLXxHyuaic3B0E/WX7Of7OCE8XUp4LG34
 62u3Q4X/OAZhxjcAHAiM4a93Bsg/
X-Google-Smtp-Source: ABdhPJx6buMGLwp1TFouiPKIKKocQFMrrAEao7rSZH+HoQ7UibqGd+4AQGf+NhaY111Zm5cKnZ40CQ==
X-Received: by 2002:a17:902:fe81:: with SMTP id
 x1mr3248626plm.239.1590668730261; 
 Thu, 28 May 2020 05:25:30 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2183:e360:deba:7bf4:98ef:5568])
 by smtp.gmail.com with ESMTPSA id 1sm5722888pje.26.2020.05.28.05.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 05:25:29 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 28 May 2020 17:54:16 +0530
Message-Id: <20200528122428.4212-15-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
References: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 May 2020 14:25:34 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 May 2020 14:25:32 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 14/25] parsing_c: visitor_c: Add vk_attribute and
	vk_attribute_s
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
