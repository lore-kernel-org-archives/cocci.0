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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E004DC4332B
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:02:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B7A20774
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbtbgpZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B7A20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K72kId007517;
	Fri, 20 Mar 2020 08:02:46 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B1293780E;
	Fri, 20 Mar 2020 08:02:46 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F2AD73B93
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:02:44 +0100 (CET)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02K72hM9005336
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:02:44 +0100 (CET)
Received: by mail-pj1-x1041.google.com with SMTP id hg10so2065538pjb.1
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 00:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8WQLiIaOsmFjHM1HjEy2R4Nr4kZ1TGFicBFeXYCuWCQ=;
 b=bbtbgpZ2nZ/2juk9T43M+RcW4qEbBlMIdLhqMgYThuxk2/V46gxNgSfbk3buku6cLr
 3LkJQ262CCdHufYNJwqbTRaoZAGuB0G/oHBpEBewET0ENCD+IIbkF7DRvbsQflpbZhPw
 hrkNHyFF/78Pg6rSLbc6SxEs8wQNE1vLDr0sDqvlhVAKNbRGpQRhZMidIMmrPUhV2Nva
 A0KA4aM/SWUWuUGJAhPHgkyC/UuKha5NROYIoVX1RaVmNbiW7oWcrVKS5CcaKF3ZYw2U
 gHutM0lWtN40ZztxFtylVjJETmKP+2k7qG108BAfiw4+CON3LPZmP9/V6hNPxnKsieDH
 2+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8WQLiIaOsmFjHM1HjEy2R4Nr4kZ1TGFicBFeXYCuWCQ=;
 b=Ebak0tHrz3E94MCuYuO0Re7Jqe53fOGBTkYw/ChM+TrLTZ8P7DF+gBF7puIoeVm2jd
 XID9+2O9N5mLdqKv/uPd7aVHATymIHkz1GZGjgXdwAhqKQTTTtYswz2z+VaFYOIgrBWJ
 EPS5Xxl3H8qBTEZ3WDBVFKXKROj1EUNDuBGdvt11bRuKaDpGRKHP1USimvPlpgC/HUDD
 uX9rGC1Ux7Iu/GCJ1+zyhqx7JyzU+0pVRbOUlZQ9k5NryByKiQdTabrM1gNi4Tsd/1Af
 RD/VwYbwkEBHoUK0IFudSomIRJSB6p04VTcXktW+gcbMFV/2VWK09DKJX39k6VdpfxEb
 2l1w==
X-Gm-Message-State: ANhLgQ1V5ugLYKlyjQdz279mcF+tti0bTXUszXEOhkQ4RzwR52/B1oNV
 d+Ejjflmh03E+PfElfS5XIIvvkpG
X-Google-Smtp-Source: ADFU+vu9JCc4Hu3P/IpdXFLx5fLMzJ+6GGaCojmFfdEXpLWz24m0xzk6mip9/1y2J6vZd1UAit+FPA==
X-Received: by 2002:a17:90a:d081:: with SMTP id
 k1mr8285753pju.57.1584687762515; 
 Fri, 20 Mar 2020 00:02:42 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2190:a751:deeb:c09d:833a:659d])
 by smtp.gmail.com with ESMTPSA id l11sm3941232pjy.44.2020.03.20.00.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 00:02:41 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 20 Mar 2020 12:31:39 +0530
Message-Id: <20200320070157.4206-9-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
References: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 08:02:46 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Mar 2020 08:02:44 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 08/26] parsing_cocci: context_neg: Add cases for
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
cases for these types in context_neg.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/context_neg.ml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/parsing_cocci/context_neg.ml b/parsing_cocci/context_neg.ml
index 7bbf743d..b3a52daf 100644
--- a/parsing_cocci/context_neg.ml
+++ b/parsing_cocci/context_neg.ml
@@ -663,6 +663,10 @@ let equal_typeC t1 t2 =
       equal_mcode sign1 sign2
   | (Ast0.Pointer(_,star1),Ast0.Pointer(_,star2)) ->
       equal_mcode star1 star2
+  | (Ast0.ParenType(lp1,_,rp1),Ast0.ParenType(lp2,_,rp2)) ->
+      equal_mcode lp1 lp2 && equal_mcode rp1 rp2
+  | (Ast0.FunctionType(_,lp1,_,rp1),Ast0.FunctionType(_,lp2,_,rp2)) ->
+      equal_mcode lp1 lp2 && equal_mcode rp1 rp2
   | (Ast0.Array(_,lb1,_,rb1),Ast0.Array(_,lb2,_,rb2)) ->
       equal_mcode lb1 lb2 && equal_mcode rb1 rb2
   | (Ast0.Decimal(dec1,lp1,_,comma1,_,rp1),
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
