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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302A6C54E4B
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A02A020720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBNPM+Vw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02A020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA8MNU008770;
	Mon, 11 May 2020 12:08:22 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 808F73E6B;
	Mon, 11 May 2020 12:08:22 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 94FE53DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:20 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1043])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA8IPs016950
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:19 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id a7so7560150pju.2
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hng7/Ni+h9OoD4yErxJiv2mDpyB/SRBbLSaLYVxbSB4=;
 b=eBNPM+VwvOFEBMRzBNLaJn9j4sVksfZkgKaFKSywEPwplrmJ0XwJIvhL65FleRO8ax
 gnd+XAaZ29sq01sUtbOSysqrS2bWQduB8J1uYHe41N0xb5ibHeyQoFW8z7kPJ/2t0D1k
 UFgIkBff1mbV3Yaj1LT+Nw8q6BbEjNsfB60fPAgQ1WaESZ8QFXsPLUgfCwLdqWkemnDk
 s6bO9N0dym8tnKcYyLMGmjBECcIj49DhVyHlEt6m1xlMUpkA636NWhVlCz6NbUs4ceOx
 kEvLJvAM9l1Kb4aWWEGh3ETWc3rwhYeMiZ2BoCudTLbQwZGD+YsJNX8MaGY6z43AJC1L
 V0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hng7/Ni+h9OoD4yErxJiv2mDpyB/SRBbLSaLYVxbSB4=;
 b=Mqf5PS1FpEDsbKXazELgvv2vM9V517YIQr51lurnZIiW50iFUJL//c2IO+CU+UyWGZ
 04QHcKwMDtP/287JrOyPWkc/mPsyEnDhMs1XdpXOGhAb/uICPDay72BnjHtlI3V0EMf6
 0poU9Hd+/4qJXdKCZJUPeiSRTyMvFfmCZbby/BuyhVtVwtbiDJ7j/W+Fm7BoskeQPxGf
 TAHoq9UhdQFcZhQkZozNrhV+NesTSIuADp85TdSTUSmkVzy7rz40O3iy0NOLcxQ5ic8p
 ipe2XZj5uItYB7XbK1qag9Jxeihf2Qp77NwER36IMMnYZU3nK7iE7ob+AehzsZ39lI1C
 zIhA==
X-Gm-Message-State: AGi0PuadDwc0bNPRjCieI9AZDgEqwwZ3qganhLzq0SY5e35xQ93WTsz8
 bIoee7mFAG6hYzFCMe9RdiM6fSKvrbw=
X-Google-Smtp-Source: APiQypKPnMQJ2TjX+RFesXfUCn0o8JDm0DR6m4E21VPMjd4SMjzRwMY42ghh5f1OgAfJFrgthZ+YLQ==
X-Received: by 2002:a17:90a:f404:: with SMTP id
 ch4mr21417444pjb.123.1589191698199; 
 Mon, 11 May 2020 03:08:18 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:08:17 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:36:54 +0530
Message-Id: <20200511100715.19819-12-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:08:22 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:08:20 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 11/32] parsing_cocci: compute_lines: Reflect Cast
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
compute_lines.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/compute_lines.ml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/compute_lines.ml b/parsing_cocci/compute_lines.ml
index 1361d842..e945914b 100644
--- a/parsing_cocci/compute_lines.ml
+++ b/parsing_cocci/compute_lines.ml
@@ -425,11 +425,12 @@ let rec expression e =
       let ar = normal_mcode ar in
       let field = ident field in
       mkres e (Ast0.RecordPtAccess(exp,ar,field)) exp field
-  | Ast0.Cast(lp,ty,rp,exp) ->
+  | Ast0.Cast(lp,ty,attr,rp,exp) ->
       let lp = normal_mcode lp in
       let exp = expression exp in
+      let attr = List.map normal_mcode attr in
       let rp = normal_mcode rp in
-      mkres e (Ast0.Cast(lp,typeC ty,rp,exp)) (promote_mcode lp) exp
+      mkres e (Ast0.Cast(lp,typeC ty,attr,rp,exp)) (promote_mcode lp) exp
   | Ast0.SizeOfExpr(szf,exp) ->
       let szf = normal_mcode szf in
       let exp = expression exp in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
