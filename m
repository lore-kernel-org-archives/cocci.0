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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEA2C0044D
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:09:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88052051A
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdIXojF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88052051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GA3v0o003728;
	Mon, 16 Mar 2020 11:03:57 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E941C7809;
	Mon, 16 Mar 2020 11:03:56 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DF50C781A
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:03:54 +0100 (CET)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GA3r4r011092
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:03:54 +0100 (CET)
Received: by mail-pg1-x541.google.com with SMTP id 37so9452195pgm.11
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 03:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OV/gLGY/NmJycahJnWnGTZEGnDcl13EtNi5n5P7gq2I=;
 b=LdIXojF4AEBLwrKSe93EZWDWVYYpZQyOuighxeDAClAz3875iNebFlJySGd70hNxHA
 Xs7WwFPdSwmXPrjd/vv99iKk9/xUjWpTUFNBuRyqOSMSpggE29EDjIamSuQyZkxY0fAN
 Tj3/X6t7lKAmITa4gN5oxEP3J9FIoby9Rr/mLTcYJrIlXCXA/53Hckix7/ffyY2u5zl+
 eAdKvWDoZz+x9DjJ/JVfY8nySi06KLSyI7qVtrM4oNu0I2Lht2OwC/hRJZbtPQbPRwL4
 K7b9k3lT42mrGkVh5majpe6ltHFgSUZc63asSjcMhoDH0UD4Ein4LsXqJhLux4Wi8kBY
 aQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OV/gLGY/NmJycahJnWnGTZEGnDcl13EtNi5n5P7gq2I=;
 b=lqRWHE9fCEurrZ0Nv1OBMVyVvqcHpp7R03/AdQejKKSqjr/OyRowzRJueWCU3Xh7le
 ohLGgeLueNaTQNms8vPMlg9LK3LkMbrZ99H7FZuI41Il+274GE3XUgEfgJBBYSNVCVhm
 FnrXQO0lrH+dpSUV/4TjtKR/KmG4UIY+t6OL62B8Acv4OyNo9omzP8M6fzVRhYXEXgBW
 3R+lRzSKNh8ZvVXfR0Kpb0wnj692M6Gq19lAWW4Kwlz9a+d0bQNsoYgWTSQrNGF9B53f
 /YGjfCNII6X4PbAbaGSePJHHtLUysDeY8EcT9dNXdOXLj6EOyO8v5flKpEV8RFN6XTIE
 k59Q==
X-Gm-Message-State: ANhLgQ0dyJAShrTQDD+ltpjbFqjl6Co+Z/qPe1HtW40O4hJdaylLwuM+
 oDZXuDY5bb8tJkLor8whCw27Vscc
X-Google-Smtp-Source: ADFU+vuN/4QeJpwFXrMRTXdG+rQ3zXWdlfjwiqpQ3hI8HLFII+BXHQKXrEJXNoVtxZzmlFT9UCr3YQ==
X-Received: by 2002:a63:215a:: with SMTP id s26mr26646837pgm.339.1584353032489; 
 Mon, 16 Mar 2020 03:03:52 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:284:a4f2:cc63:b7fc:551c:dce5])
 by smtp.gmail.com with ESMTPSA id
 u3sm19803374pjv.32.2020.03.16.03.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:03:52 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 16 Mar 2020 15:32:59 +0530
Message-Id: <20200316100319.27935-7-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 11:03:57 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 16 Mar 2020 11:03:54 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 06/26] parsing_cocci: arity: Add cases for
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
