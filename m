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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F02C18E5B
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 008052051A
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBcvpOv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008052051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GA4eMY012935;
	Mon, 16 Mar 2020 11:04:40 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 377A47809;
	Mon, 16 Mar 2020 11:04:40 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9C9F67802
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:38 +0100 (CET)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GA4aqW028446
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:37 +0100 (CET)
Received: by mail-pf1-x442.google.com with SMTP id 2so9628278pfg.12
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 03:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z5Vt+kSyi/RcHyrlEg6BWuNNcdeP5nA5wISFF/Yfsqg=;
 b=tBcvpOv48ZK8ACvgScx0mxSLE+Hey+IZqt2tohXLrgqHu0c+21ju+0ghXWth9t5Ug5
 BAA6gGK30H9vjpcaMWKYMkI+0KpXfZhY4gedt/vVbCkyFXxpQb/RC6HDqkLaWzVPw117
 ECzJhiJY+CgiTk24EY/NOuHokWNrtSUutZBeKISTQ3Zdq0i0CbAtLD0qNJX7db/UOgl4
 5799C99aguxskhsBdSVvmPY2XK/3jOdFjIaJazKeSiiuwlXC/Gof41kXtODyqf23xBAI
 q8Ts2rrhEeYn5gSetEFbVx4mN6eCgF1RmEnetRyoZ42KxCAYKGUkQpDuJPfIy71SZpGn
 ratg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z5Vt+kSyi/RcHyrlEg6BWuNNcdeP5nA5wISFF/Yfsqg=;
 b=U3aY7mqBzTSSJBsyljk/I1L1We4wPjGrbsCfpkGaPSLrueRU4YXZ7By2QL8mJQkuoe
 eGn5V4mM3KfjOo5lu7PK5e6EYTFYBNooWlpixebB40MgF0okAOgJWVa38dCNwsFGZLl1
 Zce5t2XPopAaNeY2rShzIR/sPDvUwclu3D+LiCYuhpnIAS1gZ6IGtkxhKQnx8di7SsnR
 Q1y60h1LZ+gOPj2w2ca/7g3m3EDiObM8mDpkn7kJ54MtRNi3uN50tZNSA74GpoZ3kNl2
 COq6ZGJpQ5NAIESF/MEPDETEaglv/9OKhCBx48sILVvXPJf6teUoE9xHnEJ2jd92oWEF
 bL1A==
X-Gm-Message-State: ANhLgQ3EjHS0epaCiF717Bwk0kC37hep2lQjqrVWRuoc3hvca7VuFaGy
 HcOjrmgAP0VyMow04gp/KiFIQhcK
X-Google-Smtp-Source: ADFU+vu1fbwM99gGzkn5JRcy+wsFdkIsZIGs7yw7uir9cJyWQX0bcgG0e/LZv08nzezdG+CL77y/Fg==
X-Received: by 2002:a63:4b07:: with SMTP id y7mr26016286pga.272.1584353076167; 
 Mon, 16 Mar 2020 03:04:36 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:284:a4f2:cc63:b7fc:551c:dce5])
 by smtp.gmail.com with ESMTPSA id
 u3sm19803374pjv.32.2020.03.16.03.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:04:35 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 16 Mar 2020 15:33:11 +0530
Message-Id: <20200316100319.27935-19-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 11:04:40 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 16 Mar 2020 11:04:38 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 18/26] parsing_cocci: unify_ast: Add cases for
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
cases for these types in unify_ast.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/unify_ast.ml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/parsing_cocci/unify_ast.ml b/parsing_cocci/unify_ast.ml
index d4ad3030..de86b1d3 100644
--- a/parsing_cocci/unify_ast.ml
+++ b/parsing_cocci/unify_ast.ml
@@ -336,6 +336,14 @@ and unify_typeC t1 t2 =
 	 unify_fullType tya tyb &&
 	 unify_dots unify_parameterTypeDef pdots paramsa paramsb
        else false
+  | (Ast.ParenType(lpa,tya,rpa),Ast.ParenType(lpb,tyb,rpb)) ->
+      unify_fullType tya tyb && unify_mcode lpa lpb && unify_mcode rpa rpb
+  | (Ast.FunctionType(tya,lpa,paramsa,rpa),
+     Ast.FunctionType(tyb,lpb,paramsb,rpb)) ->
+      unify_fullType tya tyb &&
+      unify_mcode lpa lpb &&
+      unify_dots unify_parameterTypeDef pdots paramsa paramsb &&
+      unify_mcode rpa rpb
   | (Ast.Array(ty1,lb1,e1,rb1),Ast.Array(ty2,lb2,e2,rb2)) ->
       unify_fullType ty1 ty2 && unify_option unify_expression e1 e2
   | (Ast.Decimal(dec1,lp1,len1,comma1,prec_opt1,rp1),
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
