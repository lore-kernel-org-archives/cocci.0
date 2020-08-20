Return-Path: <SRS0=jUR0=B7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11A9C433DF
	for <cocci@archiver.kernel.org>; Fri, 21 Aug 2020 13:52:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDDE920656
	for <cocci@archiver.kernel.org>; Fri, 21 Aug 2020 13:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXTks0qC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDE920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07LDphBq021054;
	Fri, 21 Aug 2020 15:51:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D7FD9758C;
	Fri, 21 Aug 2020 15:51:42 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DD041428B
 for <cocci@systeme.lip6.fr>; Fri, 21 Aug 2020 01:56:12 +0200 (CEST)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:344])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07KNuAgb024793
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 21 Aug 2020 01:56:10 +0200 (CEST)
Received: by mail-wm1-x344.google.com with SMTP id g75so102874wme.4
 for <cocci@systeme.lip6.fr>; Thu, 20 Aug 2020 16:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eSKa4Ey8gdfGZw4O7eXF+v0TKjbgoL2h7/Rum3+7vIE=;
 b=KXTks0qCaDbUf6bPSUK7xs/HT8S55LvPXgC8K2DVaaR3efaGdhX3rHNOPE1ocnOqyX
 Lu64TfQ2jxfdtUu4eG/nhLqYSCijXr41c/h4MZx+ib0IWXeiKV8rWaTPSbNiZvwHUIi0
 LfX0BCHPrg4tK9DYHGpkocyUuAkqbO5vVyCEf6kU5VoKTOV8IZQLZzJ772H6tXWoPjSx
 De5MzZKc0RJeG+jhckjzf7zD5PLYvWYrIqyLqgXUrKZ8Yvgu5rBLNPT4QCv9HK9tNjHx
 frl3rvvz9Hk6wxrtuz9gc9vRuMSTg8JVPn2y93jWV1MqV1vS+pAeL6Ack1RYwyyXsLgR
 NN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eSKa4Ey8gdfGZw4O7eXF+v0TKjbgoL2h7/Rum3+7vIE=;
 b=dEeTl+QgyGZFbBDy3o+qYhjev/VsTOxB+5iSmwdjWdSZbANLPKPb2oSO3ZOKX5obiJ
 qenvaZ7vbrZ/DlFG7oZ/47+ghdFP0tVJ+NzGZCgvtoAWAYbtdT7DMt7ObbHAFFSta3MW
 nsLBdj2wpRqOzaxSoUDa2F4IlnB02FPRewm6iapP5xWL7xDEhjHZNP7z2gwcl9RusHdj
 nVTpajvk9yUl7X8gb+3QhSJwaq9Qm95EBAmilQzbSeRCyQjPpS/YHp61hkwGs7uuNV8Z
 w/WjOD/NOiS8/aIkd8ur5F9Lx6ldKWbWh4FLD5ro8G80oqSri2bFEdwqhVAKIBccIP55
 EX0g==
X-Gm-Message-State: AOAM530ngJDqM5GlhpxkEg3j6LNbNj7C/3xTypSpZ3yrp3B9PHvpeqPQ
 XYlcSQAj0UgfvhD5CtUxhks=
X-Google-Smtp-Source: ABdhPJwDGeYpHJYWEawHyyzdBiI9Dk7vOO5oGyMaLBb8yJU/pvhi6QWe4Hh/d9CEuDOAQsmEiul5gw==
X-Received: by 2002:a1c:2808:: with SMTP id o8mr820101wmo.108.1597967770566;
 Thu, 20 Aug 2020 16:56:10 -0700 (PDT)
Received: from localhost.localdomain
 (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
 by smtp.gmail.com with ESMTPSA id s20sm561046wmh.21.2020.08.20.16.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 16:56:09 -0700 (PDT)
From: Alex Dewar <alex.dewar90@gmail.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>, Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Date: Fri, 21 Aug 2020 00:55:57 +0100
Message-Id: <20200820235600.326346-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 21 Aug 2020 15:51:43 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 21 Aug 2020 01:56:10 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Fri, 21 Aug 2020 15:51:41 +0200
Subject: [Cocci] [PATCH] coccinelle: add patch rule for dma_alloc_coherent
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

Commit dfd32cad146e ("dma-mapping: remove dma_zalloc_coherent()")
removed the definition of dma_zalloc_coherent() and also removed the
corresponding patch rule for replacing instances of dma_alloc_coherent +
memset in zalloc-simple.cocci (though left the report rule).

Add a new patch rule to remove unnecessary calls to memset after
allocating with dma_alloc_coherent. While we're at it, fix a couple of
typos.

Fixes: dfd32cad146e ("dma-mapping: remove dma_zalloc_coherent()")
Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 scripts/coccinelle/api/alloc/zalloc-simple.cocci | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
index 26cda3f48f01..b3d0c3c230c1 100644
--- a/scripts/coccinelle/api/alloc/zalloc-simple.cocci
+++ b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
@@ -127,6 +127,16 @@ statement S;
   if ((x==NULL) || ...) S
 - memset((T2)x,0,E1);
 
+@depends on patch@
+type T, T2;
+expression x;
+expression E1,E2,E3,E4;
+statement S;
+@@
+  x = (T)dma_alloc_coherent(E1, E2, E3, E4);
+  if ((x==NULL) || ...) S
+- memset((T2)x, 0, E2);
+
 //----------------------------------------------------------
 //  For org mode
 //----------------------------------------------------------
@@ -199,9 +209,9 @@ statement S;
 position p;
 @@
 
- x = (T)dma_alloc_coherent@p(E2,E1,E3,E4);
+ x = (T)dma_alloc_coherent@p(E1,E2,E3,E4);
  if ((x==NULL) || ...) S
- memset((T2)x,0,E1);
+ memset((T2)x,0,E2);
 
 @script:python depends on org@
 p << r2.p;
@@ -217,7 +227,7 @@ p << r2.p;
 x << r2.x;
 @@
 
-msg="WARNING: dma_alloc_coherent use in %s already zeroes out memory,  so memset is not needed" % (x)
+msg="WARNING: dma_alloc_coherent used in %s already zeroes out memory, so memset is not needed" % (x)
 coccilib.report.print_report(p[0], msg)
 
 //-----------------------------------------------------------------
-- 
2.28.0

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
