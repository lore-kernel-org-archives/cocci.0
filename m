Return-Path: <SRS0=+m3J=5B=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CFEC18E5B
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22BD82051A
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uAYd+84E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BD82051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GA4CqB007777;
	Mon, 16 Mar 2020 11:04:12 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 355177809;
	Mon, 16 Mar 2020 11:04:12 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F3F1E7802
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:10 +0100 (CET)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GA49RZ011547
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:10 +0100 (CET)
Received: by mail-pl1-x642.google.com with SMTP id a23so7787160plm.1
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 03:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e0faUHZFhKqlJpCf1OkmBJeKUysMgYHHIjGAG+ug/PI=;
 b=uAYd+84EdC9KQvGzQNOmfqX85pq7l37MwncTFIZZygs4eblmstxTS8VeLwbtyXq5rx
 DDeDI6keLLNhAJ7TBj/zprmvYVS0iMRdypIeeYV2RFauzjwxzc1hSOidRseqhRq7V6Cr
 cUffA0I/YEQ6F86Q/Qx0OX3b9sm+3A+kBj6ZqLSlKwbdx9R3+UsuTHIQirgfECLVcrwf
 bkftc2VbL81bxgEE7rqlMCohIfghU0It+H4yJhxx2d9vt7kKLXjomtQKbyC7LJyX5/jw
 xrEMhiPL9elFLI5X4N3S0XUL1YglEX5JOa08IGSkECrO07d6FKvS7pzq4gAu8xlia8w+
 tc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e0faUHZFhKqlJpCf1OkmBJeKUysMgYHHIjGAG+ug/PI=;
 b=rXCqg9iT7PrRxiZMNAllgX7vNh/CxgeCcG/5cwTRqlooJoXFLpw+vBUuZWAXsyp4n1
 KSqnVbnsXkjXCUwmsgEDvN/IbsbUbuv/9n1gX8wd9QdgudaF4x0mYqfh2sQCTHnTUK+r
 byBOs+p70wzZZ6hmEVK0Lq3JjV+UBgi11m9SlorvUzsQjH3PXHrQrTGukR2tENAQYUxG
 Ibsfpip2O/QRsmVgzpN2PLv2394+Rte4CC+walcXbGUfa9XBHOT8JZNYjlzx6LtcWlhn
 ts3AnSsBkTRETJz59jJD2RbAxqY67KEM8198NLJ6CSox18Vfa+sPDD6x7DIkDVnDa5aR
 gxFg==
X-Gm-Message-State: ANhLgQ0Nz+y3JthRDKOahQiHRy/lxO0pkHXNpbOiiKKBBLXIJGVWp2sX
 XplX9Y0gNmbiOVg7ZryPeU1akmsh
X-Google-Smtp-Source: ADFU+vvUz5yIY3NdhpihrVhsr8iQ1Xl7p2PIYhp+52Y8wnIfkNbW61Z/QrvkUIWsNglhVuaaPCv4dQ==
X-Received: by 2002:a17:90a:da01:: with SMTP id
 e1mr25664093pjv.100.1584353048412; 
 Mon, 16 Mar 2020 03:04:08 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:284:a4f2:cc63:b7fc:551c:dce5])
 by smtp.gmail.com with ESMTPSA id
 u3sm19803374pjv.32.2020.03.16.03.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:04:08 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 16 Mar 2020 15:33:04 +0530
Message-Id: <20200316100319.27935-12-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 11:04:12 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 16 Mar 2020 11:04:10 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 11/26] parsing_cocci: function_prototypes: Add cases
	for ParenType/FunctionType
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

ParenType and FunctionType are now added to the SmPL ASTs. Add
cases for these types in function_prototypes.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/function_prototypes.ml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/parsing_cocci/function_prototypes.ml b/parsing_cocci/function_prototypes.ml
index 2e6eea43..fd36f31b 100644
--- a/parsing_cocci/function_prototypes.ml
+++ b/parsing_cocci/function_prototypes.ml
@@ -229,6 +229,10 @@ let rec attach_right strings ty =
     | Ast0.FunctionPointer(ty,lp,star,rp,lp1,ps,rp1) ->
 	Ast0.FunctionPointer(ty,lp,star,rp,lp1,ps,
 			     right_attach_mcode strings rp1)
+    | Ast0.ParenType(lp,ty,rp) ->
+	Ast0.ParenType(lp,ty,right_attach_mcode strings rp)
+    | Ast0.FunctionType(ty,lp,ps,rp) ->
+	Ast0.FunctionType(ty,lp,ps,right_attach_mcode strings rp)
     | Ast0.Array(ty,lb,e,rb) ->
 	Ast0.Array(ty,lb,e,right_attach_mcode strings rb)
     | Ast0.Decimal(dec,lp,e1,comma,e2,rp) ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
