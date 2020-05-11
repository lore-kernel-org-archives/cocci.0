Return-Path: <SRS0=43Z/=6Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD94C47255
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F0820720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5px5UJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F0820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BADsLs024230;
	Mon, 11 May 2020 12:13:54 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 845C03E6B;
	Mon, 11 May 2020 12:13:54 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 88FE03DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:13:52 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BADoTN023865
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:13:51 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id b8so3738387plm.11
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y8ZHPI+OwU9oMruCD+HaFNKjHqJkEPQxmCEE5Iwn03A=;
 b=u5px5UJ9JGGgqLsbkXYVrsZ5ibuNm0yorjJsCY/t6iJhQ7YbowazUEYdv5BK/CzCA7
 fo5Rt6Sc6kD/Kbt5lqqeHHZYJI6LjWZAfFNE3+gEKkrIGoaDp5qRLda8GOC8bUMfHG00
 u0SzNUtBq56q368JJwhNkNfhDOnf+hfbqbFVaE0C0W3tzaN5PcXGFNx1YqbYhG3Sfmub
 R1GEYiwoVcfJULbgWZKslhjdk+RPaGEzYuaWVpcjtOrbvtCDrrFUlP0Gk1OIKx0PC5km
 /v5d7cLl8epudkHbK65UDvD1FNAvKExJb/D8Ltlh9Ikp7B+rEI/Eqd7YTq4XrFiTTZm3
 +tuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y8ZHPI+OwU9oMruCD+HaFNKjHqJkEPQxmCEE5Iwn03A=;
 b=V3vjLfQNKZ6n6yRrTBRMSegLMs7gz0PJDRyDcUCKtwyR9pP05PlatrCwQtACqa3WlX
 Gi+qLLC92VWty2TZo3fe6JJxXfRnPiH15tQAK58xsQhFyamAGPX5OVFvm1xqMETHq1LY
 KV3SBpty2foVb0YJcrymXm0abNOGQdV6TFSEt4ohTZK+UQS9HL22bzS+Tx+RQ2Ygsk/Q
 FAA8lvO6LY5NnKBrvv0FLQti2JpX7EZeG6zXTRipqggdzxQ2XvQ6b05kiEiXdb+fWJR6
 bi7ech8ai2PvpEbHjl5RTsKmG/AeOiuGuU1yNAYrUhXdaUi1OqXVuw+XkjVFxSESYgQd
 UgMg==
X-Gm-Message-State: AGi0Pua7sBQhgxcr+8DmpbbqQO2Z/Lt21SpIVxVDHIooRps+104zG17n
 Qy3Ar0P0F9e9j4FDY1f6B10c7uIZ9AI=
X-Google-Smtp-Source: APiQypKCmD9EPSn4/rxm+m2lFBdHFLICCKOQRczLszpO5xNLGDQexrCSfcDsa0QAe4TsPtjGZPXzFQ==
X-Received: by 2002:a17:90a:ce01:: with SMTP id
 f1mr22080374pju.166.1589192030240; 
 Mon, 11 May 2020 03:13:50 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:13:49 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:42:46 +0530
Message-Id: <20200511101300.11101-10-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:13:54 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:13:52 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 09/23] parsing_cocci: index: Reflect Parameter
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

Parameter attributes are added to the SmPL AST. Reflect these changes in
index.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/index.ml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/index.ml b/parsing_cocci/index.ml
index f7ae48b4..1baeb2bb 100644
--- a/parsing_cocci/index.ml
+++ b/parsing_cocci/index.ml
@@ -157,8 +157,8 @@ let initialiser i =
 
 let parameterTypeDef p =
   match Ast0.unwrap p with
-    Ast0.VoidParam(ty) -> [59]
-  | Ast0.Param(ty,id) -> [60]
+    Ast0.VoidParam(ty,attr) -> [59]
+  | Ast0.Param(ty,id,attr) -> [60]
   | Ast0.MetaParam(name,_,_) -> [61]
   | Ast0.MetaParamList(name,_,_,_) -> [62]
   | Ast0.PComma(cm) -> [63]
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
