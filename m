Return-Path: <SRS0=15MF=5F=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AE5C4332E
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C1D20774
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awbKKoa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C1D20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K72v6J005342;
	Fri, 20 Mar 2020 08:02:57 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1F28F780E;
	Fri, 20 Mar 2020 08:02:57 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1E2D83B93
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:02:56 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:533])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02K72swx018704
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:02:55 +0100 (CET)
Received: by mail-pg1-x533.google.com with SMTP id 7so2621388pgr.2
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 00:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e0faUHZFhKqlJpCf1OkmBJeKUysMgYHHIjGAG+ug/PI=;
 b=awbKKoa+omDznONMTYpqWv0/VO5zH4rI/mo259qE7xtnXSvRL8xCLyNSTrtG0VR+U7
 9aeLalOhlKpTalglEHcTnNGL8N3MKwu0gSp2gjkXhRCIwjNj/4yoh1AZfSRFXdw1dI1N
 nPQVJNUHeThLmC/sYpwXyRNx68JLCpNINsoMG9mzNtamXmNxlGKMYHTtD3W19K3Rj+cW
 bVu2GB1AVpJs8j3S4VXJVb7+oTYDhv7tke4lXb77QRbGHMl8Qqa/wvX53uMib4Tg/6eZ
 v7wngPtr5tOEfTCAzjY39k2eYTG4CMaLtFFIzFW7pgPe6ar3mupc/Ectk4MfrkrUHBFZ
 s4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e0faUHZFhKqlJpCf1OkmBJeKUysMgYHHIjGAG+ug/PI=;
 b=DiqF9a1ioarEw/n8mYJRtsA4AEnMKG+AiyGSsuQB4aIp8bESqopK2Nid5Pto1aKxgx
 IpFHccUl7Ayjm/HP1E1HX1R0VjSDI/1GHYahQCWcLMfdYqeUHde07wFSZbRUHiRagVEB
 qJHaNKuDgMgKkRYk6QyM9Il2nH/IhwS5J2To3crgTEZkQcMFhs62RS8MMJoABqzH/aXW
 5/oMA1BpmtMceIlHT4MFMU2Jd3Mop/rjK3m6UhSspAl91Oshm52EwXCGcxwiADmhE13t
 5/YCGi6bKYHjBfi4RMuU6D7AbvCbpSzkD8khI9laRfGo3uPrL/4CE24bqKVxDsla66jo
 iY4A==
X-Gm-Message-State: ANhLgQ19/DFrCYivVxiUZBobvA3wHNTRKDsqRdbOhXTLLSQ24+xVFT2Z
 jVgXrRrcbxep97TV6cvZ2dAnAlNR
X-Google-Smtp-Source: ADFU+vuMJnZPMzh8bisZWM5wlzPCE+bXiYDrTZSQPuRrkAL0RmoHbK93ml9Jzd1z4wz/JWuxBBeq7A==
X-Received: by 2002:a65:4c88:: with SMTP id m8mr1346235pgt.192.1584687773688; 
 Fri, 20 Mar 2020 00:02:53 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2190:a751:deeb:c09d:833a:659d])
 by smtp.gmail.com with ESMTPSA id l11sm3941232pjy.44.2020.03.20.00.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 00:02:53 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 20 Mar 2020 12:31:42 +0530
Message-Id: <20200320070157.4206-12-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
References: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 08:02:57 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Mar 2020 08:02:55 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 11/26] parsing_cocci: function_prototypes: Add
	cases for ParenType/FunctionType
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
