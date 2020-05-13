Return-Path: <SRS0=ftTc=63=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA5CC2D0FD
	for <cocci@archiver.kernel.org>; Wed, 13 May 2020 07:30:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE5E205ED
	for <cocci@archiver.kernel.org>; Wed, 13 May 2020 07:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCgeMtMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE5E205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04D7UC5a019231;
	Wed, 13 May 2020 09:30:12 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A31AE7559;
	Wed, 13 May 2020 09:30:12 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3F8893DC8
 for <cocci@systeme.lip6.fr>; Wed, 13 May 2020 09:30:11 +0200 (CEST)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:444])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04D7U9P8016372
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 13 May 2020 09:30:10 +0200 (CEST)
Received: by mail-pf1-x444.google.com with SMTP id x15so7039598pfa.1
 for <cocci@systeme.lip6.fr>; Wed, 13 May 2020 00:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K7hESMUEs3wMAXsgH2nXTQiYVgpuQKZ9UaJRG5Syp14=;
 b=sCgeMtMUFEi87eKE4KtCTn7wogd+uwgVy1T3f7lB04ixJ8b5EoLRX0NPlGClqDfian
 JdnFFE4G478e9JN6XRGVHNpdv3YtfDcHi1bmDEWKOx64IkDV8crB7Zu1eXQTVs0J/gG7
 cMMpXS8X0rOHaQJtYn3vP9BL0Z4IR+7nsR5NHYFNtLhpt47do36qWovM2nS0Ns0PTiVy
 a7ICQNwDMZ2NBA3HXToimWxa3dIdJAm5XcQFozb/bqMTisrj/vfLFFeAFEk9cXdybOAh
 9IeZ4OszhIWpVmwAQH2w8oj8+dSZ36JZbacDmKV8m3d2T2dvl9EwkMXRoB/NeNQsralu
 Uhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K7hESMUEs3wMAXsgH2nXTQiYVgpuQKZ9UaJRG5Syp14=;
 b=ti2BvyWPPN1QLGyBdX+F3pdsXkG31iDx77UxUXpIlD1zvq221W2gUn2sB97hDnRZQM
 t7/SitV5RMfe+EMSp1KSoROskTFG8h94ER5POsd8iwIUeVNz96aVS/LuOw7eXBXbEt1G
 TNL8ejo7baDWwnd+EtUx/DGwS1aFGsLsRzzTF40KJENe0GNuLusvx8IJ+PqC/0ruqVYi
 pndN/EAo9f+JcFRV3Dqno9V+q76r1+whFznKL05F20eMqKp2RwQXhISjrs6urE3YpG+A
 KFpsin2X0he2LonOia07ZAQS3mQUD52pFjv0M515exmWsiuL400rVP5+6SFHxDarWDDQ
 yKSg==
X-Gm-Message-State: AOAM530s6dhxUj7Aq/Rr/c6lCFqRtSZo42/kQnwtl0LrdAB8aO8cfaeJ
 JnQO4ijPAdxT+LaGxn8A4tIec6+pwlw=
X-Google-Smtp-Source: ABdhPJxNPu0YfV0FQfNaHplINTFtJWVxqv47uz2Mwfu/4sZvI5/w7Eqq/TfdWUT1wyf4jklwnz0CGA==
X-Received: by 2002:a62:92c2:: with SMTP id o185mr1945531pfd.207.1589355008887; 
 Wed, 13 May 2020 00:30:08 -0700 (PDT)
Received: from localhost.localdomain ([1.38.219.254])
 by smtp.gmail.com with ESMTPSA id n9sm14852828pjt.29.2020.05.13.00.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 00:30:08 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Wed, 13 May 2020 12:59:50 +0530
Message-Id: <20200513072951.3453-2-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200513072951.3453-1-jaskaransingh7654321@gmail.com>
References: <20200513072951.3453-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 13 May 2020 09:30:12 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 13 May 2020 09:30:10 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 1/2] parsing_cocci: parse_cocci: Fix struct pointer
	funcall regression
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

This is a fix in response to the following bug report:

https://www.mail-archive.com/cocci@systeme.lip6.fr/msg07332.html

The following commit:

	c280375635f62dfbe052709e4e47a82140d32ce5

Introduces a regression in the following SmPL use case:

	@@
	struct s *x;
	@@

	x->func();

Where x is a pointer to a struct and func is a function belonging to
said struct. The faulty commit mislabels func as a function prototype
due to a missing case in the function-prototype-detection match ladder.

Add a case in the match ladder for a struct pointer function call.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/parse_cocci.ml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/parsing_cocci/parse_cocci.ml b/parsing_cocci/parse_cocci.ml
index 292ee5c0..798abc27 100644
--- a/parsing_cocci/parse_cocci.ml
+++ b/parsing_cocci/parse_cocci.ml
@@ -1076,6 +1076,7 @@ let find_function_names l =
     | (PC.TMetaId(_),_)::_
     | (PC.TMetaLocalIdExp(_),_)::_
     | (PC.TEq(_),_)::_
+    | (PC.TPtrOp(_),_)::_
     | (PC.TEllipsis(_),_)::_
     | (PC.TOEllipsis(_),_)::_
     | (PC.TCEllipsis(_),_)::_
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
