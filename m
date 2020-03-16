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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D3EC2BB1D
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87AEF2051A
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOOlAVXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AEF2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GA49OG003923;
	Mon, 16 Mar 2020 11:04:09 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C254E7809;
	Mon, 16 Mar 2020 11:04:09 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 22D5B7802
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:08 +0100 (CET)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:543])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GA45bK026629
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:06 +0100 (CET)
Received: by mail-pg1-x543.google.com with SMTP id 37so9452513pgm.11
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 03:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/yG6jmrgNVmdX8cemKmNhpv4ahVdrMFnSV8o9QTHxaI=;
 b=kOOlAVXD2KL+mvUNoIOGkuZMUgeYNFvcnpZMQmcCBadrMjE7vzttzfEWCFArnKHcMO
 bYCUeEBscn9Tx8tEQ1ZTBG5aowhNWxoI9S0H5qSFI1Q/diVvXzreaG2aZIVl55HHXJIG
 BWOcn5CQklRLDr4cVTnBY/cRpjvfBL/grOLgRX0SJXHh7RTO6aduB2PTPQ+jau1JLjeE
 ZPE/bTqKFP8cCsNoAzgGNR8CLA3/Q7cM+Gr3KbjOKov4AWkq+U1Nw+XUOqBCpHu7EcDL
 juubw/v/Z3jNW+5A3vakRU68Ya1hHpvnqolEtU63BwsqKtqxZ+F44zN9OXecyqHgEMJW
 heQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/yG6jmrgNVmdX8cemKmNhpv4ahVdrMFnSV8o9QTHxaI=;
 b=MRjSnyHQ7NpJz4DtSpDpGiby+wfeorFbtdhdnKz+hJZSHwRmUCZAaVMHzOHWe72c/n
 l59w9z9S0u40JagmPI4hlYIdAo4u0ZVU4VPIGCLn8D2SQvsqg+qqZ0n6/uhjiygFLJhD
 ur4RtsfOFClYmNcjbNHoo+7DmDOBEF7xdMhCOmoekP3CD3lOgnYmJ9jmIPlL9QqBL9JF
 2yA3XETEHJOonRXff1DWs+veLs4HWxKX1FGnaK/Dstf6KED2XHIYFtbMoVAyF/Vt7zzk
 hMJITgNR8KAZqXb1b7PLRu3KdMrDqSbjV7Q+fIqojP8BTomO1EzZQTHI40jwbu+IF4o8
 Np2A==
X-Gm-Message-State: ANhLgQ0emO46ul5bpK6aEmYaJaz2qWLQznCY/BP7QB/SR0+5bfU54xk0
 GfnmU283oq3eoJmnU70hG6IkLe9p
X-Google-Smtp-Source: ADFU+vt9JMyhaH8MLEAWhPIxEXOIObfJHv2oIwNsUYIiR7bUlHatRtwTohx13jBaUqQNplTN24SZDA==
X-Received: by 2002:aa7:9906:: with SMTP id z6mr28181939pff.112.1584353045063; 
 Mon, 16 Mar 2020 03:04:05 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:284:a4f2:cc63:b7fc:551c:dce5])
 by smtp.gmail.com with ESMTPSA id
 u3sm19803374pjv.32.2020.03.16.03.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:04:04 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 16 Mar 2020 15:33:03 +0530
Message-Id: <20200316100319.27935-11-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 11:04:09 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 16 Mar 2020 11:04:07 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 10/26] parsing_cocci: single_statement: Add cases
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

ParenType/FunctionType are now types in the SmPL ASTs. Add
cases for these types in single_statement.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/single_statement.ml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/parsing_cocci/single_statement.ml b/parsing_cocci/single_statement.ml
index 46408b73..48d77b5a 100644
--- a/parsing_cocci/single_statement.ml
+++ b/parsing_cocci/single_statement.ml
@@ -166,6 +166,8 @@ and left_typeC t =
   | Ast0.Signed(sgn,ty) -> modif_before_mcode sgn
   | Ast0.Pointer(ty,star) -> left_typeC ty
   | Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) -> left_typeC ty
+  | Ast0.ParenType(lp,ty,rp) -> left_typeC ty
+  | Ast0.FunctionType(ty,lp,params,rp) -> left_typeC ty
   | Ast0.Array(ty,lb,size,rb) -> left_typeC ty
   | Ast0.Decimal(dec,lp,length,comma,precision_opt,rp) ->
       modif_before_mcode dec
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
