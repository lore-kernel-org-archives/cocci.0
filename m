Return-Path: <SRS0=cw0N=6I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C05C2BA1A
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 572D320724
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEhYsUyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572D320724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03O9JBNP000316;
	Fri, 24 Apr 2020 11:19:11 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3789E7827;
	Fri, 24 Apr 2020 11:19:11 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 932A47815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:09 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03O9J7rb026733
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:08 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id h11so3518116plr.11
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 02:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wIhWgWsmcSnUCFYeY1Wz7dLsANz2MSWyq7Or4zgsT2o=;
 b=OEhYsUyMp0aV3TBzP6CYFnNSXBqOdqYBn0M9DtYonOyM34L167efIoM9AvN6mv81Sm
 D7FIy8NANhD+LQD3xibx1tEPZx4uYNmlNTOwmnietF61xp0xr0uJXLNiK85WpPR8Mv2f
 wylS2cCbpYKOxasJip0iCl9qIOO65gIJuLsn+xwdsGYN2Dxg7qh++b7leVXk3VgNp+3f
 z2SFgg4jubUOnj5NWZrw6HZv/xLzlFUGNx5qIRmaN8LSVhmuJkmchQELkJGG0bB0Edb8
 Ur9d+Hxtgp2KRWYfYPqGLxJmo/7wOYAtvJE1iRBqx2dI2GNeg4csVdnBimXaqJMOTGLm
 w9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wIhWgWsmcSnUCFYeY1Wz7dLsANz2MSWyq7Or4zgsT2o=;
 b=K2e6gHciE62SbV5yhyksrXotbcnyyaVPrXwSxK8xyjN7ALB5rgT8UaQ+ICgHFECqJ2
 7rIVeFRA/ZRgYTlaBOvFWuZS0ecLvOFiv2mRIokF+jA8aWCo7LZdiZN4RxVBgjopkz85
 iLpFNFC+aG82f0pyXTStZ3sbnWBWvT+rMAQUgJoLdprkmilgp3u0rSlbHUZNrX2cO7Zq
 4T8x4WTT6anEnSF4Gb2Fw0ucjEkHibmiqzcszbAJPn+BrnRF/EkNeOj3NspfB6H9sSKJ
 j2Vl3F2m401/qBC3qFI0SB9S7pi5V/YBK+yOn2BfwM+h7d6klrLBbcA9pgjcPH2mJS4m
 AL7Q==
X-Gm-Message-State: AGi0PuaoCsbQmyHbyNwRilc0aCT669lQI+4MYzJHuUHAtG/uIxWpN5Kz
 MyE9IkE9fcezEWjwCEjtRAqtU7N671k=
X-Google-Smtp-Source: APiQypI6n2rZ0urVb/rPBTkhgg00wgg9qDzbsPQKuVFGi5swsLSmpmqQHJk3Tqty80n5bINa6aJWjg==
X-Received: by 2002:a17:90a:aa83:: with SMTP id
 l3mr5328678pjq.100.1587719947148; 
 Fri, 24 Apr 2020 02:19:07 -0700 (PDT)
Received: from localhost.localdomain ([1.38.216.60])
 by smtp.gmail.com with ESMTPSA id c80sm5043933pfb.82.2020.04.24.02.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 02:19:06 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 24 Apr 2020 14:47:46 +0530
Message-Id: <20200424091801.13871-11-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
References: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 11:19:11 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 24 Apr 2020 11:19:09 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [RFC PATCH 10/25] parsing_c: parser: Add MacroDecl end
	attributes production
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

Add a production for macro declaration end attributes. This parses the
following C code from Linux v5.6-rc7:

  arch/x86/kernel/nmi_selftest.c:

	static DECLARE_BITMAP(nmi_ipi_mask, NR_CPUS) __initdata;

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parser_c.mly | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index 99ceb359..eb22cbcf 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -1598,6 +1598,17 @@ decl2:
 	   MacroDecl
 	     ((NoSto, fst $2, $4, true), [snd $2;$3;$5;$6;fakeInfo()]) }
 
+ | storage_const_opt TMacroDecl TOPar argument_list TCPar end_attributes
+   TPtVirg
+     { function _ ->
+       match $1 with
+	 Some (sto,stoii) ->
+	   MacroDecl
+	     ((sto, fst $2, $4, true), (snd $2::$3::$5::$7::fakeInfo()::stoii))
+       | None ->
+	   MacroDecl
+	     ((NoSto, fst $2, $4, true), [snd $2;$3;$5;$7;fakeInfo()]) }
+
  | storage_const_opt
      TMacroDecl TOPar argument_list TCPar teq initialize TPtVirg
      { function _ ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
