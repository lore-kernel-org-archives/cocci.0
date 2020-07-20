Return-Path: <SRS0=R2Y6=A7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC51C433E1
	for <cocci@archiver.kernel.org>; Mon, 20 Jul 2020 16:23:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB322070A
	for <cocci@archiver.kernel.org>; Mon, 20 Jul 2020 16:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB322070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06KGMoMJ015572;
	Mon, 20 Jul 2020 18:22:50 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 86FE17775;
	Mon, 20 Jul 2020 18:22:50 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F177F44A7
 for <cocci@systeme.lip6.fr>; Mon, 20 Jul 2020 18:22:47 +0200 (CEST)
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06KGMkAk020167
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 20 Jul 2020 18:22:46 +0200 (CEST)
Received: by mail-lj1-f193.google.com with SMTP id j11so20879329ljo.7
 for <cocci@systeme.lip6.fr>; Mon, 20 Jul 2020 09:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=s6tdYtNz+qDIDRhGgPrdBToU6tSHk3rys73lASsyyZg=;
 b=oCIfdO/3qzQjUaUNIYIf1I2K7Gr9BM64OdXIL/bxzR4L7B05yABGFmcHe4YEAWtcIi
 sWEqJTXuVVq2yXxxL5TaYl+yKJII7+YGINGIkaNhEm8MbnA9gI8xWWM24gfPglglOFBP
 cWNYW10sSRHYgPyt5tH9mgJ9qWFCaqtraM5WFkT2guSI2sGv7UiIOqdvN1wTIeeLlk1k
 ss0fk+ZQtcgUZIuo0EewydMVss1WKdKAiG7TB+ItyC52jTeUu1Pq5HHOEr/EDg/EZNQD
 aUuTEgoc0ioruP7hyUMWiOhHAwM2P/zDcv0hcK3hZmytK/9HX8dSDFZLn+ets1GJ+ZUp
 fwDQ==
X-Gm-Message-State: AOAM533DHwmMFVGhj/y2IPJR2nuQoIaYuZgyyIlSeoxiEf6JwW4p9uu8
 IBCV2W8MHVTB9zvMkNkgyAE=
X-Google-Smtp-Source: ABdhPJzTpx/3GEm/mdl3zCsea6GWprPX5/o5NX25tfmUNJ8qGeNGweY4sfXRocU5bYUIRUhGtCX2mQ==
X-Received: by 2002:a2e:8556:: with SMTP id u22mr11328825ljj.348.1595262166015; 
 Mon, 20 Jul 2020 09:22:46 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id a19sm925855lff.25.2020.07.20.09.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 09:22:44 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Mon, 20 Jul 2020 19:22:13 +0300
Message-Id: <20200720162216.13248-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 20 Jul 2020 18:22:50 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 20 Jul 2020 18:22:46 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH v3 0/3] Update memdup_user.cocci
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

Add GFP_USER to the allocation flags and handle vmemdup_user().

Changes in v2:
 - memdup_user/vmemdup_user matching suppressed
 - PoC for selfcheck virtual rule
Changes in v3:
 - add missing '-' for patch rule in kmalloc/kzalloc call args
 - selfcheck rule dropped from patchset

Denis Efremov (3):
  coccinelle: api: extend memdup_user transformation with GFP_USER
  coccinelle: api: extend memdup_user rule with vmemdup_user()
  coccinelle: api: filter out memdup_user definitions

 scripts/coccinelle/api/memdup_user.cocci | 64 ++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 3 deletions(-)

-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
