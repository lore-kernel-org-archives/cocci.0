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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EEAC4332D
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B31420774
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhMRFCVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B31420774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K73Rdm021078;
	Fri, 20 Mar 2020 08:03:27 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AD0C7780E;
	Fri, 20 Mar 2020 08:03:27 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 821463B93
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:03:26 +0100 (CET)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02K73OPh002112
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:03:25 +0100 (CET)
Received: by mail-pf1-x442.google.com with SMTP id x2so2749904pfn.9
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 00:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dqkv3oqMwtTa6d0C2gk8rkkDFXuoowFPaClNAY6dKVA=;
 b=fhMRFCVtgW5WofbO8MhxOTJFbhWyCfqPBSFUIK0Wt3RkU7mC9lCkS5pIaxoUwfJZL9
 jp2riFRfFtvxu2Qmr0ZWS7ue/qSptOkqluvKLhg0Ey1rXFafmdRmm5Rz5a5bZxi+5qzE
 6J9ctkFjk9ydTMxVmzQU34dOwo1tNwc3rIY6toVE1ybPFrY04Jukl7Qq03uR19u2zJhJ
 AltNckXN/pAcuuUTB9IPGcO9kTkqEnE84gDiABmQn82rk+BWqzZ0qoi1UlSEixzuC0Lb
 NCACSxFFsy1qcUkmeEGGZYrneqezdJmVcCQUbyxVEKyNDTTE0jDq7Ip84R6AHk6551Qh
 sUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dqkv3oqMwtTa6d0C2gk8rkkDFXuoowFPaClNAY6dKVA=;
 b=MWOn970xwb4Jk5/VK1YODPpw42wh2h9DjPpn/Fo5qKbUAVEf9Hx1RV/wKJqUED8nGi
 NbW+WjRyCDJhKrQhVlgPCtN11McZP3KpDBV4k3VfiNwE66VSFLf0+cXBKJ02oq6PLYMJ
 py6hPpRanR81HO4Xc1UFSmjqMY6d3/sjyWG8ykV/DnWvNM07fyrZ22qQanR/2FALigeY
 +TCRqvmQYfZfmhyywY3646gr5bAwLVOqm4Ai5GcvmLmF5rRQgRMNJ3JDnpRGFf0K6oAQ
 v/5pSu8PZkehLvg3ZJkfJ0dEvgb4Tuek5Rmvb43LjUdPKAxIUjehiyNya+6aJ7OGvsxG
 4x4Q==
X-Gm-Message-State: ANhLgQ0W5EyWiVzYICDEZGIswkIyRusidR/SRVEO1pGvPxV8cO4Rb7Ug
 U5T4X0PtyxoXnhnId5DoqpUdtw/G
X-Google-Smtp-Source: ADFU+vuC53C/Ph5T5zHAYKVBl0U8l7AyPfXjl5hf9M+58LIRtpd+DowwtNLTOiWSZz2S6soqRp1gVg==
X-Received: by 2002:a62:4ed1:: with SMTP id c200mr8076751pfb.207.1584687804156; 
 Fri, 20 Mar 2020 00:03:24 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2190:a751:deeb:c09d:833a:659d])
 by smtp.gmail.com with ESMTPSA id l11sm3941232pjy.44.2020.03.20.00.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 00:03:23 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 20 Mar 2020 12:31:50 +0530
Message-Id: <20200320070157.4206-20-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
References: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 08:03:27 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Mar 2020 08:03:26 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 19/26] parsing_cocci: disjdistr: Add cases for
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
cases for these types in disjdistr.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/disjdistr.ml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/parsing_cocci/disjdistr.ml b/parsing_cocci/disjdistr.ml
index 668a8810..91d7f1b8 100644
--- a/parsing_cocci/disjdistr.ml
+++ b/parsing_cocci/disjdistr.ml
@@ -73,6 +73,16 @@ and disjtypeC bty =
 	(function ty ->
 	  Ast.rewrap bty (Ast.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2)))
 	ty
+  | Ast.ParenType(lp,ty,rp) ->
+      let ty = disjty ty in
+      List.map
+        (function ty ->
+          Ast.rewrap bty (Ast.ParenType(lp,ty,rp))) ty
+  | Ast.FunctionType(ty,lp,params,rp) ->
+      let ty = disjty ty in
+      List.map
+        (function ty ->
+          Ast.rewrap bty (Ast.FunctionType(ty,lp,params,rp))) ty
   | Ast.Array(ty,lb,size,rb) ->
       disjmult2 (disjty ty) (disjoption disjexp size)
 	(function ty -> function size ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
