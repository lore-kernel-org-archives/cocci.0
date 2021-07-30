Return-Path: <SRS0=v5gi=MW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B514C432BE
	for <cocci@archiver.kernel.org>; Fri, 30 Jul 2021 10:59:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 924E960F0F
	for <cocci@archiver.kernel.org>; Fri, 30 Jul 2021 10:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 924E960F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 16UAxt6n011735;
	Fri, 30 Jul 2021 12:59:55 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D89197801;
	Fri, 30 Jul 2021 12:59:54 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8D1F73FE7
 for <cocci@systeme.lip6.fr>; Fri, 30 Jul 2021 11:59:18 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:436])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 16U9xHNO013101
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 30 Jul 2021 11:59:18 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id j2so10542151wrx.9
 for <cocci@systeme.lip6.fr>; Fri, 30 Jul 2021 02:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L8Pxe8lLduahkjt47S3R5pZsRevGx6MbH7exEXrhDL8=;
 b=nP7UARZ9M3AyP+yeBpmEXBrEr47Ihy0JlhkSGI7LEOe4ol/rwgtlE9JCLG8LXBvjIq
 5yw2qt3bh7bnA6p8ciiLwQB//WBDVN9tVwzZiUaaMRZVsZ4j27Fb2BKObiobgO3yk/pP
 cMs4sRKC9kD954VX3myXew8RVwI4IBXAtkGxkMHFrLBM1uuVPvcF2h2YXtHzufvhEOUl
 ilYtSjDeToa+qpKu0J05vWsiUCMPpImg8neM0SAkerRqHEhQdrEohukOm0dcM1cY/vl2
 bo0OAaBZoW+iS3x9omNHa2vDoX24u2TLE25PPMfjGtAigvGAIFSl4hYZ45tcSIIfBOIH
 wRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L8Pxe8lLduahkjt47S3R5pZsRevGx6MbH7exEXrhDL8=;
 b=Jd6jyaJpvTwhlrNROsIrfin2N8wz4DZvr5P7sDgdYP6oZvDooeMDUdGEMFyh9PFQ7U
 l5JkPti4KwU6YkIbtrlFKA0D2lsvHyj9vNRfq2um5Q6OQSVAe4Df1aJLu5QwapJ/1dhe
 53mdKX8aK5ImfXdV4Lf5LCSito9DGIn09JOCvoBC84kcreeTQy6+UUxQTHOpdsjJcDot
 gjpX3GIMrfZ/T7VL8Eu+Jq0i1ED+PdJ94ZQZFuFXYN6jrlY+v8SEgOru/7nBYTCODWTl
 3CH9fXRUEc6++WbNnI/N2CLYzHx+n+nGPTMMvs7L7s/4tzDT0fjvIfQaedckhBEgdI19
 Pjsw==
X-Gm-Message-State: AOAM5317ooo3+szcCPyFbrh5jl0+JAMzQjrFZQALgx3ZVJrsZjHw6KLA
 nzalFS6I8rMrJzj83PpTp6M0Cw==
X-Google-Smtp-Source: ABdhPJzBopbT+/Qh9WULFjmHf5wY+MNNMhpx3FM6u/zemdxXOfOxPhhDLNX2y3xCQUW73sTgvS2Zow==
X-Received: by 2002:a5d:508b:: with SMTP id a11mr2264917wrt.244.1627639157651; 
 Fri, 30 Jul 2021 02:59:17 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net.
 [80.7.220.175])
 by smtp.gmail.com with ESMTPSA id l7sm1090016wmj.9.2021.07.30.02.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jul 2021 02:59:16 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Julia Lawall <Julia.Lawall@inria.fr>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
Date: Fri, 30 Jul 2021 10:58:56 +0100
Message-Id: <20210730095856.2038286-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 30 Jul 2021 12:59:55 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 30 Jul 2021 11:59:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Fri, 30 Jul 2021 12:59:52 +0200
Cc: Daniel Thompson <daniel.thompson@linaro.org>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH] scripts: coccinelle: allow list_entry_is_head() to
	use pos
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

Currently use_after_iter.cocci generates false positives for code of the
following form:
~~~
	list_for_each_entry(d, &ddata->irq_list, node) {
		if (irq == d->irq)
			break;
	}

	if (list_entry_is_head(d, &ddata->irq_list, node))
		return IRQ_NONE;
~~~
[This specific example comes from drivers/power/supply/cpcap-battery.c]

Most list macros use list_entry_is_head() as loop exit condition meaning it
is not unsafe to reuse pos (a.k.a. d) in the code above.

Let's avoid reporting these cases.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    I'm pretty much a complete beginner w.r.t. SmPL. This is written
    entirely by finding previous fixes and emulating them!
    
    However I did test it by running the checker across the current kernel
    tree. The changes reduced the error count by four... which was small
    enough for me to eyeball each one and check they match the pattern I
    was targetting.

 scripts/coccinelle/iterators/use_after_iter.cocci | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/coccinelle/iterators/use_after_iter.cocci b/scripts/coccinelle/iterators/use_after_iter.cocci
index 9be48b520879..676edd562eef 100644
--- a/scripts/coccinelle/iterators/use_after_iter.cocci
+++ b/scripts/coccinelle/iterators/use_after_iter.cocci
@@ -123,6 +123,8 @@ hlist_for_each_entry_safe(c,...) S
 |
 list_remove_head(x,c,...)
 |
+list_entry_is_head(c,...)
+|
 sizeof(<+...c...+>)
 |
  &c->member

base-commit: 2734d6c1b1a089fb593ef6a23d4b70903526fe0c
--
2.30.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
