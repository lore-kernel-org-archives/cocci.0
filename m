Return-Path: <SRS0=Yx51=7L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13218C433DF
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:09:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3790206F0
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxoHRgHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3790206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04TC9SOe010884;
	Fri, 29 May 2020 14:09:28 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 408557783;
	Fri, 29 May 2020 14:09:28 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3CE275D47
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:09:26 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1043])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04TC9ONJ011086
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:09:25 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id a45so1692829pje.1
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 05:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G4GcJpC8iPvcpZGDUEaqohU9qGW6hrIhJTus4DqAu78=;
 b=XxoHRgHRe1FGfRWNgTuiJPFVE3q9ecKgfrY5dlYJhz5K9lHfy8Gn8d7zv9sLJqphzg
 BS1Zdu6JnX5cQtHHoEbtO4viHSWavTWQTFHkuYpwblNm84e9/BS0YsNu2TCRaULaPBkd
 h/hRvbzXAL4Fa5nc29KHORmuRZabkTCTotMEiOPSjdTdRtvk13XgXXqH97WB0y42/0K9
 Ks+xBX4xeIpIX9B9isuZJFnDya1TNwfUXZjqdhnnIKug59iaUG5aDpGXISDqlzcq2SGI
 ow7DyK+tHz1+mKeEI7IMCWrmDL+VFY4CGmURRq8L661gklQXp23urjWLN/gbVbjnCNXL
 80rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=G4GcJpC8iPvcpZGDUEaqohU9qGW6hrIhJTus4DqAu78=;
 b=jo6erP33+AqmmQlTFoPMlgm2FQvdQW/Mlt/oGhyxcdcb+mFOsGP85Be4kmzWpu+wLt
 g2jEKhBZ5U6b4x60f3QlPdQJO5HECemUP2nvul8VCtekRuASfLGs16vqVEAZr+AtcVKh
 H8esKuSAqudw4WfIwGueDDZT+UFEmuuO1v6aAHvANo7LQPH6W3dHNY0lNUH5pEAaMf8p
 yxtKo8w5NuZGTom22B1kHTYdhGo9+7kxThXJQ9tOIUdmaNRL82idHfBZvTnGc+x6HeII
 In/ppjzCI82WR6RlNfeqJ01c21Wqv1ROvBK0DbmgQSkGuCM1rDsuzmVRt8mZQll4Zcrh
 Lv9g==
X-Gm-Message-State: AOAM5334Jn/x9po9SdKq/qYFifyuOoae/ImEDmQ3F1UaetWfFPr9yEq7
 7JBURHcZw4f3AjzABF0rAF5c7B4l
X-Google-Smtp-Source: ABdhPJzwlNj4o5U7LTJiYMtj0cSCP4eMJ876q9JeNkmtGYWKmDRvgTVkZZEHX9MKr+9+yXLAx/EGjw==
X-Received: by 2002:a17:902:ea8a:: with SMTP id
 x10mr8566987plb.61.1590754163836; 
 Fri, 29 May 2020 05:09:23 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:694:e576:19d1:a79b:707d:59f2])
 by smtp.gmail.com with ESMTPSA id dw13sm7975161pjb.40.2020.05.29.05.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:09:22 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 29 May 2020 17:36:46 +0530
Message-Id: <20200529120703.31145-17-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
References: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 May 2020 14:09:28 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 May 2020 14:09:25 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 16/32] parsing_cocci: pretty_print_cocci: Print
	cast attributes
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
pretty_print_cocci.ml by printing these attributes.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/pretty_print_cocci.ml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/parsing_cocci/pretty_print_cocci.ml b/parsing_cocci/pretty_print_cocci.ml
index a9eb4a8b..aff95b25 100644
--- a/parsing_cocci/pretty_print_cocci.ml
+++ b/parsing_cocci/pretty_print_cocci.ml
@@ -249,8 +249,10 @@ let rec expression e =
       expression exp; mcode print_string pt; ident field
   | Ast.RecordPtAccess(exp,ar,field) ->
       expression exp; mcode print_string ar; ident field
-  | Ast.Cast(lp,ty,rp,exp) ->
+  | Ast.Cast(lp,ty,attr,rp,exp) ->
       mcode print_string_box lp; fullType ty; close_box();
+      (if not (attr = []) then print_string " ");
+      print_between print_space (mcode print_string) attr;
       mcode print_string rp; expression exp
   | Ast.SizeOfExpr(sizeof,exp) ->
       mcode print_string sizeof; expression exp
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
