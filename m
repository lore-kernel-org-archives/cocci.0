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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5ACC43332
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:02:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CAD920777
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkl6yvts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CAD920777
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K72eDd000696;
	Fri, 20 Mar 2020 08:02:40 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E68DD780E;
	Fri, 20 Mar 2020 08:02:39 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 454B13B93
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:02:38 +0100 (CET)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:543])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02K72aTg016680
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:02:37 +0100 (CET)
Received: by mail-pg1-x543.google.com with SMTP id m15so2590745pgv.12
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 00:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OV/gLGY/NmJycahJnWnGTZEGnDcl13EtNi5n5P7gq2I=;
 b=gkl6yvtsKj6KTYEtBvsEtGQpbK1DABTvXrvh28A6HdBWR/wMuQtLkkTT9ExasyCfeX
 ldru/6mG3tL9C5Z9jKKUytcisWlkA24VfhE3jQEXQDVNbPd+p38VJA7J9YsiF4RCmTKb
 MAyffYadm22rxoMGra5YldebEdqFqMgeK7vSxl6Sq1exnivArmnsHIXaRCgUKppax6XL
 vMSBAV4p2v2stTZGw4so6YiUJmbduonvlC+a7BeE+7GVYkvstidk0oTlisd6P8XIboJZ
 SkF12J6Uh3T87T8+GNv6GO0F2x5Tvga5fZsgt3bYxn+VgMMZ9oBJwuFpBCNSWtjMOk6R
 IpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OV/gLGY/NmJycahJnWnGTZEGnDcl13EtNi5n5P7gq2I=;
 b=k3MnyvUSjEjtynBJakWh7XOedAc80MaeXbnJsd+AM2VnfCFYXB25qvDFNb8dQ+nYcE
 yf00nXcdEaccYjKX3ZyinOcw9EYbMBmAZ3+jXzCa/ogGfCBZ8Ek/7cP9byU7AsgU5rH4
 xGYATWJ8k3+ocs4f+Jw4tU38+evvMqxr+xsge92iptixxlKNVROkijRzDCQtK6lkR3Gu
 t35oJrHdw9ZdhMWueexehSagZwfh2klfxvktRh05m+5hX/YvLWKI/EdL+HATBby0Xda0
 WrPMYrwlCZ58WJFUmRKQjZdVbH8JFXRrxWPvLAIe3nlK+eMfVc5ibUEbG4wJw54lwoAF
 V1yw==
X-Gm-Message-State: ANhLgQ1RuiFrm3/j7W2a14zmtzy3V4CFNQTUWuH1wI8eKEpMQukg7z6F
 bPvKAmeNwjMhhrI4/F6Qk0s/xpej
X-Google-Smtp-Source: ADFU+vustBO/qP8U8iE094kJ1NHhYEkgHKTAnNVKjK5gCECwbriS+/iIZbmI79xXVSRprLU5vfnfAg==
X-Received: by 2002:a63:f60e:: with SMTP id m14mr7048138pgh.342.1584687755778; 
 Fri, 20 Mar 2020 00:02:35 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2190:a751:deeb:c09d:833a:659d])
 by smtp.gmail.com with ESMTPSA id l11sm3941232pjy.44.2020.03.20.00.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 00:02:35 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 20 Mar 2020 12:31:37 +0530
Message-Id: <20200320070157.4206-7-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
References: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 08:02:40 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Mar 2020 08:02:37 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 06/26] parsing_cocci: arity: Add cases for
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

ParenType and FunctionType are added to the SmPL ASTs. Add
cases for these types in arity.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/arity.ml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/parsing_cocci/arity.ml b/parsing_cocci/arity.ml
index f29b86eb..3b408554 100644
--- a/parsing_cocci/arity.ml
+++ b/parsing_cocci/arity.ml
@@ -419,6 +419,23 @@ and top_typeC tgt opt_allowed typ =
       let params = parameter_list tgt params in
       make_typeC typ tgt arity
 	(Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2))
+  | Ast0.ParenType(lp,ty,rp) ->
+      let arity =
+        all_same opt_allowed tgt (mcode2line lp)
+        [mcode2arity lp; mcode2arity rp] in
+      let lp = mcode lp in
+      let ty = typeC arity ty in
+      let rp = mcode rp in
+      make_typeC typ tgt arity (Ast0.ParenType(lp,ty,rp))
+  | Ast0.FunctionType(ty,lp,params,rp) ->
+      let arity =
+        all_same opt_allowed tgt (mcode2line lp)
+        [mcode2arity lp; mcode2arity rp] in
+      let ty = typeC arity ty in
+      let lp = mcode lp in
+      let params = parameter_list tgt params in
+      let rp = mcode rp in
+      make_typeC typ tgt arity (Ast0.FunctionType(ty,lp,params,rp))
   | Ast0.Array(ty,lb,size,rb) ->
       let arity =
 	all_same opt_allowed tgt (mcode2line lb)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
