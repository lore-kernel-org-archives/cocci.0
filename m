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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A24C4332B
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F18520774
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUpxpaHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F18520774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K73DYZ009048;
	Fri, 20 Mar 2020 08:03:13 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D40AC780E;
	Fri, 20 Mar 2020 08:03:13 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4C85B3B93
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:03:11 +0100 (CET)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:443])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02K739PS013433
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:03:10 +0100 (CET)
Received: by mail-pf1-x443.google.com with SMTP id b72so2738122pfb.11
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 00:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hNEhW8aZpA5clMp5UvBCyPEnXqNYsg9iLkQyh57jJrA=;
 b=PUpxpaHpEf2HYDoWrJ36bETWEaMM4OOjPQWEdHTBMIH7CqhVgThdF4bpiE6seSaUsH
 Me4g8A6Go0esOq+6Q3PZHXSX3jsFJ2qLtdqNeJ7osKpA2b8F5EyztSd8M5HmU/YO6nCc
 duizISQN9OxUUbTz8cngc1f+JlfaEOnqFfRFSOzNuWhn1qYSnQr1P6RAH457l4MTzfB2
 tkxpNx2KttkFq4v1BS/hXlrNaESRH9Uav6JZBHyi4zXpenUpRknar7iaK5msOyjkrP1V
 EMdvFKRkTkobPF6PSzdc7qZ2d56EFQoRkZwXUV9K8HUS659q7Qkx1CJOWODc4icTqyEP
 oHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hNEhW8aZpA5clMp5UvBCyPEnXqNYsg9iLkQyh57jJrA=;
 b=rvP9CFWYMSJoKevbd+Ief602fv+ocHuXC/tfz8PeutCNYvmzZ7yOB6d+XKFtFc68WX
 WnnUSJFFwGJwYoNxldpLiqFIc9OtBVTZJpKIdyJO0x1gE29bL4Wj7s0N6st/vM6pt24P
 3A4bI/xFx+eszLY+fHHaULN1pCNXS1VH1zOSEOBzYkJHoKMYrknSxon9HBEEi7aZp8Xv
 bDv3QnZR4Fs5sBDWFIdKJ+h9kCp6wMPjI/GjuyVhQIjellB3LswBN5N0The/6hqqc1hj
 Mub+ScNmQBHwF8Q4lnWGZrUcYV32owx4NM/dVn7+a9dfgNb3pEifSlydT15ID47b7BZp
 NwpQ==
X-Gm-Message-State: ANhLgQ34BCsleO0TyokhTn9qluPb1FThvzYfo6r/IRPRF+TAbqoTa1SN
 qQy4s86VApcuKp5CmFd/WZvbft22
X-Google-Smtp-Source: ADFU+vvf93UccsyiCMpGreLeLFIJqk8BjMn0eK3ru9PHuzMBwQx7ZMW9FYFW2mm1Fu5mzmZ5h4hVfA==
X-Received: by 2002:aa7:99c8:: with SMTP id v8mr7939838pfi.151.1584687785001; 
 Fri, 20 Mar 2020 00:03:05 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2190:a751:deeb:c09d:833a:659d])
 by smtp.gmail.com with ESMTPSA id l11sm3941232pjy.44.2020.03.20.00.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 00:03:04 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 20 Mar 2020 12:31:45 +0530
Message-Id: <20200320070157.4206-15-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
References: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 08:03:13 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Mar 2020 08:03:10 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 14/26] parsing_cocci: adjust_pragmas: Add cases
	for ParenType/FunctionType
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
cases for these types in adjust_pragmas.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/adjust_pragmas.ml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/parsing_cocci/adjust_pragmas.ml b/parsing_cocci/adjust_pragmas.ml
index 73b5ff5f..6d2a9c5d 100644
--- a/parsing_cocci/adjust_pragmas.ml
+++ b/parsing_cocci/adjust_pragmas.ml
@@ -171,6 +171,10 @@ let rec left_ty t =
   | Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
       call_right left_ty ty t
 	(function ty -> Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2))
+  | Ast0.ParenType(lp,ty,rp) ->
+      call_right left_mcode lp t (function lp -> Ast0.ParenType(lp,ty,rp))
+  | Ast0.FunctionType(ty,lp,params,rp) ->
+      call_right left_ty ty t (function ty -> Ast0.FunctionType(ty,lp,params,rp))
   | Ast0.Array(ty,lb,size,rb) ->
       call_right left_ty ty t (function ty -> Ast0.Array(ty,lb,size,rb))
   | Ast0.Decimal(dec,lp,length,comma,precision_opt,rp) ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
