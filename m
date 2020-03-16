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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDFEC0044D
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3832051A
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBxQAYnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3832051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GA4FJL023528;
	Mon, 16 Mar 2020 11:04:15 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BC60D7809;
	Mon, 16 Mar 2020 11:04:15 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 444747802
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:14 +0100 (CET)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GA4Cgj003420
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:13 +0100 (CET)
Received: by mail-pj1-x1044.google.com with SMTP id nu11so5130659pjb.1
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 03:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/tQzzSzGwOrXNCobyy8rVLQ7w9jC7U4oHB4x0KSxfhk=;
 b=iBxQAYnG2o0xs4n92t/fczNHhVz+3D/tPK70pv7cOMNe0uF39saW12nl+7lOjKZ8Is
 O0LTaiHIqkYhHrI9Dh1iBMK1LBBqs1s7Ww0KohPNHdn+6bz+lc+QMI9cKa+9Ng6Z1J/w
 O819dUGr5IN8XTZRHGeuVzqTvtQkeSVW+4s2061lZZpGTO5eCtAw6NUjeUBBvufKnONE
 L20rCY7w0xfOKAjkdkFw5D558eSjvB1+bln+ukys5EHHQ1tio5tGDaPPVUpotYdhwxIJ
 htj2ZvJNkEcGXxDzezKzWHGg4mr4bn2wXktRwKsG4TbEnuzBzxeG6MjAHw8z50MeLQxq
 cU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/tQzzSzGwOrXNCobyy8rVLQ7w9jC7U4oHB4x0KSxfhk=;
 b=aLDOA2LGAZUYhauRx468+ce7sgbPuxZ3wvwlzz0I/fnV3X8UM4W3RTxS3qMeK9tqyf
 N9h+F0IeTD6lAmwWcwIh2m6sPuxAL951h+2yVLAgG1gHEHfgqKJafHgUJ68USwmGIEvO
 8fnTMr2N/5mIrUdVp2QRcwWhn1FYn0LoyqW7KFZfBfIfIT1XAUvwIBnUDXyWYZR+XDS9
 JAkLW0ibFPLFiDcvkI03zn4ywVsySHBygJmBE4QU9zXMj1DJfEGvE5TSeD0JYpYqwdtE
 k6+73lSJ0+EaOZU6aLIZ1Xm6bRiGDB5qrNiHOo5lo+ixBwd0pN2jOeZ2fZ71bNMbUDVQ
 vGTA==
X-Gm-Message-State: ANhLgQ0oMO3UZ6z+mL5GEe+pENeRVD7HE8R/nb3b58/XJR9bYHJF7U2t
 Dy5OU7IrcFf2xElOljINB9s1cnXz
X-Google-Smtp-Source: ADFU+vu50HQa+mFIvy1ek/eHm2tQJXfxQnmRcyd3JvHZYua4/obGcrDLKq636OJRO7UFf8OwTFXBYQ==
X-Received: by 2002:a17:90b:3789:: with SMTP id
 mz9mr18890202pjb.43.1584353051845; 
 Mon, 16 Mar 2020 03:04:11 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:284:a4f2:cc63:b7fc:551c:dce5])
 by smtp.gmail.com with ESMTPSA id
 u3sm19803374pjv.32.2020.03.16.03.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:04:11 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 16 Mar 2020 15:33:05 +0530
Message-Id: <20200316100319.27935-13-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 11:04:15 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 16 Mar 2020 11:04:13 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 12/26] parsing_cocci: check_meta: Add cases for
	ParenType/FunctionType
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
cases for these types in check_meta.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/check_meta.ml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/parsing_cocci/check_meta.ml b/parsing_cocci/check_meta.ml
index 02b0fd9c..7b10bd53 100644
--- a/parsing_cocci/check_meta.ml
+++ b/parsing_cocci/check_meta.ml
@@ -224,6 +224,11 @@ and typeC old_metas table minus t =
   | Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
       typeC old_metas table minus ty;
       parameter_list old_metas table minus params
+  | Ast0.ParenType(lp,ty,rp) ->
+      typeC old_metas table minus ty
+  | Ast0.FunctionType(ty,lp,params,rp) ->
+      typeC old_metas table minus ty;
+      parameter_list old_metas table minus params
   | Ast0.Array(ty,lb,size,rb) ->
       typeC old_metas table minus ty;
       get_opt (expression ID old_metas table minus) size
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
