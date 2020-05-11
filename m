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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC5AC47255
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B7A20720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAUh8YDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B7A20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA89HZ002640;
	Mon, 11 May 2020 12:08:09 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 54D293E6B;
	Mon, 11 May 2020 12:08:09 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0C0AE3DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:08 +0200 (CEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:543])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA86Vh023231
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:07 +0200 (CEST)
Received: by mail-pg1-x543.google.com with SMTP id r10so3856794pgv.8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U2vjDY6M9kJuWsvQDE56SPl3eiXzk/sM3F8VvOJWJ5o=;
 b=kAUh8YDCc/lVV9GTklDB+b50ku4jhGky0xlzwPkx36vp2Hk/X/3kMMWW8OtZNN0eYQ
 gwEBPpmafrYeyJ8b8moFDqGHmyqZh57ZTuAtwPyDMN5Q8BCbbOgRG80As+RkfBiGAZVm
 ahYHagJRcEqwB9sWX4/6jjw3UQFJyBLrZ6uZEqmbrq/PMJopkTIsyWH9hqojVUPwOLwj
 jHER73zuUqQlhDjZtum8fS8oSgyLobkMqJ3yatq7lClHtVycD1wPZLfsZoGwqyTcYmhV
 QEFOnjxoFRPX7gtz/0qrFLGaOnf8GjZzyRC3hYXoh3jEArlQZlKYxt/Rym2Y/ePTaYPI
 EWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U2vjDY6M9kJuWsvQDE56SPl3eiXzk/sM3F8VvOJWJ5o=;
 b=kkRrHDNGkihaL5ggwsA1M3ilf05WKVqLDvBHiuFXjRAvQEjyvx0+xFW/JlF+MarBL2
 jy+hGzKKPAw7KzIU2BFM1ZaAs4vAchPjKM19h1/S7ve5xmi1m2kFJQR6LgqdzyNpFDd4
 MGjuZzqkW9+YNf3q/H/257Qljl+PONA+HFeUNs9M9wHk9iRhhUWh8/ZNbcpBYTZt5J7w
 GVN3AW8qNWWrBkrNR8No5mwJLkSChuNbw7l/p2I7dvlslJcE3H5fm0LG/Xe+GyF5LfkH
 43ihNjzeKqQeX6p8IJljeAFVCTrKVd3ts6X8KnSp3BmqmOX4RIMBI9QDMzBSJ+it4aGB
 QBnQ==
X-Gm-Message-State: AGi0PubZGT/nGGt2zuDXhqtG2abNXygzkLl7SaP/hcGtz/UQj9pfv2DE
 wEVOj5a2K0WjBq0DQ5kGlLWAz7QkT18=
X-Google-Smtp-Source: APiQypI+6l5mEx8lUM8/Gjk9NkEVx8t4/OzRy2RM+8tt58FjYAhXCseOxzgbRMAtdY5tZSAjBkZvGw==
X-Received: by 2002:aa7:8ec6:: with SMTP id b6mr14880977pfr.50.1589191685715; 
 Mon, 11 May 2020 03:08:05 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:08:05 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:36:51 +0530
Message-Id: <20200511100715.19819-9-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:08:09 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:08:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 08/32] parsing_cocci: type_infer: Reflect Cast
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

Cast attributes are added to the SmPL AST. Reflect these changes in
type_infer.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/type_infer.ml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parsing_cocci/type_infer.ml b/parsing_cocci/type_infer.ml
index e8aad810..2c1cc73b 100644
--- a/parsing_cocci/type_infer.ml
+++ b/parsing_cocci/type_infer.ml
@@ -291,7 +291,7 @@ let rec propagate_types env =
                | Some x ->
                    let ty = Ast0.wrap x in
                    err exp ty "non-structure pointer type in field ref")
-	| Ast0.Cast(lp,ty,rp,exp) -> Some ty
+	| Ast0.Cast(lp,ty,attr,rp,exp) -> Some ty
 	| Ast0.SizeOfExpr(szf,exp) -> Some (Ast0.wrap int_type)
 	| Ast0.SizeOfType(szf,lp,ty,rp) -> Some (Ast0.wrap int_type)
 	| Ast0.TypeExp(ty) -> None
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
