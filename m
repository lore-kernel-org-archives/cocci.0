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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CB8C4332B
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C911A20774
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmSBJ/Vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C911A20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K73I0L007833;
	Fri, 20 Mar 2020 08:03:18 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3ADBF780E;
	Fri, 20 Mar 2020 08:03:18 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C3B9A3B93
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:03:16 +0100 (CET)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02K73F0J021787
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:03:16 +0100 (CET)
Received: by mail-pj1-x1041.google.com with SMTP id np9so2064229pjb.4
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 00:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=748xKLCwQqLPdCAv6SLGVWG8zuIrb/ZVbTG9e7X15dM=;
 b=rmSBJ/VlLVGXUtkob6Qf5xlwK9ZuAt1nArUwbKd0RSUAQdyJFfj/R1MwKLgU8k7e+E
 b2LbOqmIP70U5jxdO4Dge5ZmgnmBA6P3N9fbO0HyxGDVAKcCGyFYl3oV6bNMt1t8bd6Y
 BIt/5grsCdbv/G7SfHpP4z2Zdt5B/uGD3DRtRC/cq3FQcn7RstIgeY5W3QTdQ+S5cP+F
 UMIfNO5cislxg6VvcmWBC+HmaAK+AO6Cr/2x+vre9PZ+DACTUyMZ8OKZDUyaxKZFYUWX
 zZHIRugsG06uE45EdfmHWBtWcBOfxGsqTz/0WzoQ0osxjH/f27TCWeX/bhj5oOqcgB6B
 g9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=748xKLCwQqLPdCAv6SLGVWG8zuIrb/ZVbTG9e7X15dM=;
 b=RtNrLPBzq7oVWWxEFO+eGZxFA5JJ6TpfIcZ06iyZ1B/cUHFOvFtiGCieGbv5+zRizz
 RV3hGbZIb5TonHFtapQnpRHYdMy+MxPyIEREm353E5kUYFowrSn3LEc1yEC39mpRcLyE
 NYd3Nx/XsMFn8Ov1oz5h+b49LGZBq8G63KWATXcTAPLgX6Zohs7MfP3EG5+ldQC3NzY0
 KDdlkevHIS8EHfiBQgysO+QiDNN+l9p6Vl0uzV/yOP2EWNWKkV9eOi4LOPfU4ow8L9/H
 /h8cN2iGk+hDsvsZ3DQpdp43NLNmuKXZ4XA58hShJHaydX5QL7OPAflE6HSDDfI6dH8m
 94Iw==
X-Gm-Message-State: ANhLgQ3sJbga7PjesQ4p3j5clyFpld42oQU2G15fhGDwgluPXOrOF0+9
 4cyPHc5tElr51p3hkAq2OW3Pet1b
X-Google-Smtp-Source: ADFU+vsws0QaCbFML6hPvn7UuJ6eJMD5msZEJuSgh38TEywwOLL+9Jeixccc9jd+7lbAFZrMl0gP/Q==
X-Received: by 2002:a17:90b:4d0b:: with SMTP id
 mw11mr7948514pjb.45.1584687794251; 
 Fri, 20 Mar 2020 00:03:14 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2190:a751:deeb:c09d:833a:659d])
 by smtp.gmail.com with ESMTPSA id l11sm3941232pjy.44.2020.03.20.00.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 00:03:13 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 20 Mar 2020 12:31:47 +0530
Message-Id: <20200320070157.4206-17-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
References: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 08:03:18 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Mar 2020 08:03:16 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 16/26] parsing_cocci: ast0toast: Add cases for
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
