Return-Path: <SRS0=m0DH=ZT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8832AC432C3
	for <cocci@archiver.kernel.org>; Wed, 27 Nov 2019 17:39:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A932080F
	for <cocci@archiver.kernel.org>; Wed, 27 Nov 2019 17:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTg0p3lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A932080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xARHdPe0005844;
	Wed, 27 Nov 2019 18:39:25 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3F89D77D4;
	Wed, 27 Nov 2019 18:39:25 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DD6D577D2
 for <cocci@systeme.lip6.fr>; Wed, 27 Nov 2019 18:39:23 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:533] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xARHdJBX023574
 for <cocci@systeme.lip6.fr>; Wed, 27 Nov 2019 18:39:19 +0100 (CET)
Received: by mail-pg1-x533.google.com with SMTP id t3so10783775pgl.5
 for <cocci@systeme.lip6.fr>; Wed, 27 Nov 2019 09:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hAdHg+nMpBBpnhQAb4eQYvBwAsK1HxagWWhgNhFJul8=;
 b=eTg0p3lupqzPqMOI2f1yhQdYjVCeKMOc+YaPpSgPujuist0u/SSCeFXY4DtCM7Gx/Q
 VIaSJsK6buyzzDpimQ2PuLelc8gVzPjFq7eNKhF2InyJaGG4g4FP/5+WqH0pYdo5ME5C
 /X1/PzrdX1AlIt5qa8E1+7gHnJM7D/bM15EP5yCPXRHYDS/IFZjZ1kHU5OusQCqxptQa
 u/3ADnUDKo5YZtqbjMp5dzXaKtyQhjFstDaggAjt6GeZXuNxA5IOGoxH92jkNaQA0Ikt
 E5uHJYUF5okAtmCdoWtul03aYKnZylvmCfWEHPJ3wm9n+0+yzchwTcs7FvLEUsIcQF7X
 4y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hAdHg+nMpBBpnhQAb4eQYvBwAsK1HxagWWhgNhFJul8=;
 b=cdI8fzboM45ox7478IpvzgKWY8dkZpZnCUEgI/FpfpmrkK4Tbbsrx2RAc4O9EU5I9F
 gENMzeSSL02nK+vLx9B6vQ27dBbcFp22zcgImcv/TVU3WvQIWMynYJyXKTRNwvQ6XeE8
 lSKchnKt7/1O1qyzSmFXO6oaTrCXCS/d2xEocBf/hfc81VXoK9JWaVetIS6HiFhn+lEq
 xet2DUnrGeaRzWxjsYEdgmkyZBI2sSjKg9MYlf0M2x6Pe+UGfP1Q8vW5LM5Zp496q6KH
 LDKL679lFAFv/Uk6H4QanD8NcV4VEDKd30WO4y8Zm6Nrw/4MnEP4qWr6U8GgVUr5PGpZ
 7IVg==
X-Gm-Message-State: APjAAAUva3HVXxPRupchRkniXPuj5DMtl82O50I70LBRtrkinoV0QUgt
 KJZVh1ctL+19CgE3ri28xyzF8Tn+3tc=
X-Google-Smtp-Source: APXvYqxjM0+LoGgNkAM6hzc8u+gHxKQq9hjlbYUWAaAZVMfXG1sCKWFiRJaFUPuqOOvzj9rwHoBQTg==
X-Received: by 2002:a62:e105:: with SMTP id q5mr48917809pfh.105.1574876358295; 
 Wed, 27 Nov 2019 09:39:18 -0800 (PST)
Received: from localhost.localdomain
 ([2402:3a80:167f:97a7:3939:930e:5cf8:fd50])
 by smtp.googlemail.com with ESMTPSA id j23sm17028240pfe.95.2019.11.27.09.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 09:39:17 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Wed, 27 Nov 2019 23:08:13 +0530
Message-Id: <20191127173815.24988-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 27 Nov 2019 18:39:25 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 27 Nov 2019 18:39:19 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org
Subject: [Cocci] [PATCH 0/2] cocci: Fix continue statement of death and
	similar cases
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

The following patch series is for fixing the "continue statement of
death" report here:

https://www.mail-archive.com/cocci@systeme.lip6.fr/msg06199.html

Changes include removing circular references that cause the crash
and adding a corresponding test case.

 engine/transformation_c.ml         |    2 +-
 tests/stmt_removed_and_added.c     |    8 ++++++++
 tests/stmt_removed_and_added.cocci |    7 +++++++
 tests/stmt_removed_and_added.res   |    8 ++++++++
 4 files changed, 24 insertions(+), 1 deletion(-)


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
