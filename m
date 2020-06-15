Return-Path: <SRS0=AA88=74=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89122C433E0
	for <cocci@archiver.kernel.org>; Mon, 15 Jun 2020 04:16:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF7A02065F
	for <cocci@archiver.kernel.org>; Mon, 15 Jun 2020 04:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBecWtfd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7A02065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05F4GoL6029723;
	Mon, 15 Jun 2020 06:16:50 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3A0527577;
	Mon, 15 Jun 2020 06:16:50 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EC8273BAB
 for <cocci@systeme.lip6.fr>; Mon, 15 Jun 2020 06:16:46 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:62c])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05F4Gk9O016137
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 15 Jun 2020 06:16:46 +0200 (CEST)
Received: by mail-ej1-x62c.google.com with SMTP id o15so15857028ejm.12
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 21:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YN3zN3mQ/BfHzTlkXTeRbeqf/iLJme8W5IzNkvzgDXY=;
 b=FBecWtfdgd5GVH/qUXE0O1v4lxZIbc6WFHvH9sBWPv2kFsFwfWYKHtulR7ejMDwemw
 U7yLZO4g5DmbenCpl4MOtZMBexoDjmfmhFPTYpWwtoqmRHwzYDDN7ZW84fpusmvRxHbW
 MZOCUmi0D9//KbVGAPhhLh+OoTDbIxXI6HR5s+2GLaSq+s676TXp3ekEtv9RapsjKqNg
 AEGQ5inFT9eDTJo0JtBc+w/w00XLKh5QrZfKmQhpjUVKSyvo9yp4PW8VczF4bmI8ACVH
 2vMZoiPIIE/YMAbXSPX9/uD3j8++FanVGauuT9FA64GQAn26qHjYdQoyrgz4ZT8NbaEG
 i4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YN3zN3mQ/BfHzTlkXTeRbeqf/iLJme8W5IzNkvzgDXY=;
 b=IYkBWTFqDdltlti7LYaZxh7WN3veJUSfVKKRFzYf4siAWozeyNF9+UQDF14zhQa09Z
 OQBQzBHCjur8BkhERV4jrQFcIgbMle44BbluqMy6CRa41nMfUGMjmxEg9xcghnEz4cGN
 Rlxd9lKoPePHFttYxlUBpCvQppDk7yUMMSHgEgNELea58Q0OE/++phr2jXpAIofJ1hon
 aCn9BA6YiqSrk3D98cIJIvFouo9mC24Q6j0021mjwzXz1+igBx0jjCVi9ktTwqOw5+lI
 v+XGAalKEtGhzlsSR43n4YPF8NNnbXlnMp/Fl+mB79+Wbs4XJTiJIBRsIDZniieBQ6BY
 jaNw==
X-Gm-Message-State: AOAM531+15TB4gO7OdpC9k0HdaQQyhJji8QEfrQ+oIiUcT469pisQacd
 VnVpVxNCQegfaY7f6FOrwos=
X-Google-Smtp-Source: ABdhPJxL3qunD1Ss96rNpTIMAEtLIAHU++EAgSYURSTQdNHyeBEIqGWL3z1l4HtegzDrl793igzgdg==
X-Received: by 2002:a17:906:7696:: with SMTP id
 o22mr22902368ejm.245.1592194606242; 
 Sun, 14 Jun 2020 21:16:46 -0700 (PDT)
Received: from homer.simpson.net ([185.221.150.7])
 by smtp.googlemail.com with ESMTPSA id n5sm7682308edq.13.2020.06.14.21.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2020 21:16:45 -0700 (PDT)
Message-ID: <1592194605.7336.83.camel@gmail.com>
From: Mike Galbraith <umgwanakikbuti@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Mon, 15 Jun 2020 06:16:45 +0200
In-Reply-To: <alpine.DEB.2.22.394.2006142137330.2849@hadrien>
References: <b14e6d1d-afa0-5c28-547a-9bb1a987f6fd@infradead.org>
 <1592115803.27290.33.camel@gmail.com>
 <alpine.DEB.2.22.394.2006140940000.2849@hadrien>
 <1592121432.2129.9.camel@gmail.com>
 <alpine.DEB.2.22.394.2006141042270.2849@hadrien>
 <1592124280.2129.22.camel@gmail.com>
 <alpine.DEB.2.22.394.2006141456520.2849@hadrien>
 <1592158913.7336.48.camel@gmail.com>
 <alpine.DEB.2.22.394.2006142137330.2849@hadrien>
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 15 Jun 2020 06:16:50 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 15 Jun 2020 06:16:46 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Randy Dunlap <rdunlap@infradead.org>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] coccinelle issues
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

P.S.

> > warning: Can't find macro file: /usr/local/coccinelle/bin/../lib/coccinelle/standard.h
> > warning: Can't find default iso file: /usr/local/coccinelle/bin/../lib/coccinelle/standard.iso

The hard coded "lib" causing this issue lives in globals/config.ml.in.

diff --git a/globals/config.ml.in b/globals/config.ml.in
index 2a4135f3b06e..5969be5aa1e2 100644
--- a/globals/config.ml.in
+++ b/globals/config.ml.in
@@ -37,7 +37,7 @@ let path =
       exec_dir
     else
       List.fold_left Filename.concat exec_dir
-	[Filename.parent_dir_name; "lib"; "coccinelle"]
+	[Filename.parent_dir_name; "lib64"; "coccinelle"]
 
 
 let std_iso = ref (Filename.concat path "standard.iso")
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
