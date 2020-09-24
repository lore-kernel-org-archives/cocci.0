Return-Path: <SRS0=fIkn=DB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B70C4363D
	for <cocci@archiver.kernel.org>; Thu, 24 Sep 2020 11:24:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E8D2395B
	for <cocci@archiver.kernel.org>; Thu, 24 Sep 2020 11:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMBUvIGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E8D2395B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08OBNRLM020987;
	Thu, 24 Sep 2020 13:23:27 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9FB51778D;
	Thu, 24 Sep 2020 13:23:27 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 580094452
 for <cocci@systeme.lip6.fr>; Thu, 24 Sep 2020 13:23:25 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:631])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08OBNNji028904
 for <cocci@systeme.lip6.fr>; Thu, 24 Sep 2020 13:23:23 +0200 (CEST)
Received: by mail-pl1-x631.google.com with SMTP id u4so1520785plr.4
 for <cocci@systeme.lip6.fr>; Thu, 24 Sep 2020 04:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=0Yw4y12mYXqqzBAefSKmQPErnuJA8Bd/3bClQhft1f4=;
 b=rMBUvIGc+BcQpRaPLrLivcdmH5/cNfPYvjpayM+lekuyx8VuxAhksOC6eg4D/J9YEe
 Mx4Xx3+Ru6ERuUByDfqCq5nDbZfyAoWjwZkapKrhQ4x20ah5C+kkeds3Op/Ip+IHxR0K
 eYZs1Sts6KLRBwFzGasrN1PUVPZylc+Su+BsvPnXeR9qjCakGD5GttsJKcS1SPdWL0aN
 jBup4W2fDsIe+iqtQmc2Ts8DDrtg5QekDonZnvDcfwKFkZlJUszutBsiIJRThNxgjmXs
 i8czb5FnZOoyVWEHlafhNN3qbPx9ZBcwhkTu6qJhUzFwsDw20o4i+nzfkVXynAWn0fJq
 nS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=0Yw4y12mYXqqzBAefSKmQPErnuJA8Bd/3bClQhft1f4=;
 b=Yz1WuZgtxprGlBPQ4UPRgfRShNGVZfVOQulZ1ZX4RU9S72tvO/k6PLRiV7kMAV8GN8
 rbwlgiUPdli/9OxLkwOqqNQRRowTzzyEP1M6gDLMibaZX6wwuZ1w5NYWCe0lx/KynlGQ
 lCkFIDO0AVQCBbyhtU1bImo0LYucNwqFQaa+S6EqbAYjb/oa8N/3mMthFZh+WzNdkOne
 9WegjyP90zhhgpzNExCcjyboRR1T+VdcnifpqDeKTnRDjGNnM/NgXkCDk9uiV23SYfjp
 k+hyM5IL+ZzlGySLxd8sw5lc/GBwCf0r8Xu2817Ys0Nijb7daEHUcVhK81rc9naTxhP0
 E/Dg==
X-Gm-Message-State: AOAM5334bCV21prXSA397dwgTZBw5toRuMiEIUsWJzOe0YClcDAjyXKh
 HNVqJLBRKZ0kdqxob4qbqpQ=
X-Google-Smtp-Source: ABdhPJxNrpc1T1RzR987qCLYFRPoqeSupCopENIpU/JLVTz9WxgvLwLNb59t0zxAPzjfTznserHVnA==
X-Received: by 2002:a17:902:82c7:b029:d2:2a0b:f0c7 with SMTP id
 u7-20020a17090282c7b02900d22a0bf0c7mr4053217plz.30.1600946602591; 
 Thu, 24 Sep 2020 04:23:22 -0700 (PDT)
Received: from adolin ([49.207.208.43])
 by smtp.gmail.com with ESMTPSA id k3sm2768096pfp.41.2020.09.24.04.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 04:23:21 -0700 (PDT)
Date: Thu, 24 Sep 2020 16:53:16 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Message-ID: <cover.1600945451.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 24 Sep 2020 13:23:28 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 24 Sep 2020 13:23:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, linux-doc@vger.kernel.org, Gilles.Muller@lip6.fr,
        corbet@lwn.net, nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH 0/2] Improve Coccinelle Parallelisation
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

Coccinelle utilises all available threads to implement parallelisation.
However, this results in a decrease in performance.

This patchset aims to improve performance by modifying cocciccheck to
use at most one thread per core by default.

Sumera Priyadarsini (2):
  scripts: coccicheck: Change default value for parallelism
  Documentation: Coccinelle: Modify parallelisation information in docs

 Documentation/dev-tools/coccinelle.rst | 4 ++--
 scripts/coccicheck                     | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.25.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
