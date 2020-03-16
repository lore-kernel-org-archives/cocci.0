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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82F8C2BB1D
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E6C20663
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awBpypZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E6C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GA4XWB029639;
	Mon, 16 Mar 2020 11:04:33 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 78FB47809;
	Mon, 16 Mar 2020 11:04:33 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D23D77802
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:31 +0100 (CET)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GA4UCB028024
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:31 +0100 (CET)
Received: by mail-pg1-x544.google.com with SMTP id t24so9461954pgj.7
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 03:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=748xKLCwQqLPdCAv6SLGVWG8zuIrb/ZVbTG9e7X15dM=;
 b=awBpypZYKQbfPTAX7GKNxZVbpNy/TTJe21uqB6Hd83r4YimTcwt9KlYUz6gMgQ4aMp
 AffvtzyQYP9Zti1+Kbooo8TYlqyAKDLP0weJnGWsEmoKBiWJPBL5t4XDz/9e3picEBqF
 DPHtPSkdASi74Ci2NQ7WBXN79l4tHpI3YrM2G8S81mUs/VIyJVdY7udPprGUR6u5/7CY
 9BIzwDLY7BVXVJ9JsdFpcSgfFhV9/TsmsH1CBFRAOeIvNdIc9LZTK3e5amEJk/07R1JR
 NjlevM8DjKBuDH8N92tzDLrf1izpB+7b6J/a7GDIF+fK+C/jvWshebzmevLgn2LBrUzh
 N4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=748xKLCwQqLPdCAv6SLGVWG8zuIrb/ZVbTG9e7X15dM=;
 b=rlMEQ7G99b0uacz5WXTqoObdwllNkTonLDRBXlW2LaEkC0xAoyNV5CWH5ylnA6iTqt
 tgPkPCWqC/koWHLiek+kiy0jX+xYcWWjA03QEltvI+kxo/L2Ndjd2WO15lcV8C2mRWLC
 mQre6hEvICIfr3Z9AXZaNCpWv9AKUwsGu6xzpObtwBjqeOz6pCmlSBJianx/57L9W5km
 l4iGxPvdO09rxm/N4zMHPr1FctE+1xFojeKAFob+7+sYSJdHIw5mEu6lUu66JZLC35Y9
 hE9+wHJuHdeycNJi3kxm2OkYn/jZPsD9jek138tcGkuFrlox1Um+ylAe46OXcmK+xZuZ
 oj5w==
X-Gm-Message-State: ANhLgQ0mxMN66M+IedO0Fm3OH5tKTSWAIP8sCCJ8W8aGwFA1yJjUcfh9
 WXvYaKRIGljZE5M0io8EMgpkKS19
X-Google-Smtp-Source: ADFU+vueB6r/vYv52C4vPHw7yM0HzSwfusa32gsWKtLNyCHbdCuc8xHsDKC0KxVJJvEQfwpYl8sVfQ==
X-Received: by 2002:a05:6a00:c8:: with SMTP id
 e8mr24050030pfj.131.1584353069183; 
 Mon, 16 Mar 2020 03:04:29 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:284:a4f2:cc63:b7fc:551c:dce5])
 by smtp.gmail.com with ESMTPSA id
 u3sm19803374pjv.32.2020.03.16.03.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:04:28 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 16 Mar 2020 15:33:09 +0530
Message-Id: <20200316100319.27935-17-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 11:04:33 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 16 Mar 2020 11:04:31 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 16/26] parsing_cocci: ast0toast: Add cases for
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
cases for these types in ast0toast.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/ast0toast.ml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/parsing_cocci/ast0toast.ml b/parsing_cocci/ast0toast.ml
index f1bbde0b..dc7b30f7 100644
--- a/parsing_cocci/ast0toast.ml
+++ b/parsing_cocci/ast0toast.ml
@@ -562,6 +562,7 @@ and typeC allminus t =
 	| types -> Ast.DisjType(List.map (rewrap t no_isos) types))
     | Ast0.BaseType(_) | Ast0.Signed(_,_) | Ast0.Pointer(_,_)
     | Ast0.FunctionPointer(_,_,_,_,_,_,_)
+    | Ast0.ParenType(_,_,_) | Ast0.FunctionType(_,_,_,_)
     | Ast0.Array(_,_,_,_) | Ast0.Decimal(_,_,_,_,_,_)
     | Ast0.EnumName(_,_) | Ast0.StructUnionName(_,_)
     | Ast0.StructUnionDef(_,_,_,_) | Ast0.EnumDef(_,_,_,_)
@@ -588,6 +589,11 @@ and base_typeC allminus t =
       Ast.FunctionPointer
 	(typeC allminus ty,mcode lp1,mcode star,mcode rp1,
 	 mcode lp2,parameter_list params,mcode rp2)
+  | Ast0.ParenType(lp,ty,rp) ->
+      Ast.ParenType(mcode lp,typeC allminus ty,mcode rp)
+  | Ast0.FunctionType(ty,lp,params,rp) ->
+      Ast.FunctionType
+        (typeC allminus ty,mcode lp,parameter_list params,mcode rp)
   | Ast0.Array(ty,lb,size,rb) ->
       Ast.Array(typeC allminus ty,mcode lb,get_option expression size,
 		mcode rb)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
