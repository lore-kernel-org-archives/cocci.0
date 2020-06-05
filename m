Return-Path: <SRS0=TTUf=7S=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1CAC433E1
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 280DB206E6
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDFcko70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280DB206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 055DiC8R009421;
	Fri, 5 Jun 2020 15:44:12 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1F86E7567;
	Fri,  5 Jun 2020 15:44:12 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F2F923F9A
 for <cocci@systeme.lip6.fr>; Fri,  5 Jun 2020 15:44:10 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 055Di9Sc005910
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 5 Jun 2020 15:44:10 +0200 (CEST)
Received: by mail-pj1-x1044.google.com with SMTP id q24so2749800pjd.1
 for <cocci@systeme.lip6.fr>; Fri, 05 Jun 2020 06:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hdwzt3tFXKWyJadRRPoBDmhsTEk2PAGDfRjvzOl8MPs=;
 b=LDFcko70pw8/n7/GUICQ8cEO8bGtODs3MymW1NmMFof3ALae60HxrqR4pFznTZ8XOR
 LJ9iawXn+bpnSqpv4lcgoJmEXrduRDrwm5xE2a+mwgshwoEC97nIuIaOZR1ytr/GdNvT
 dABd9pbFSsNXHEE6tbRylmalJQjRu4uOEdyJZo0zYdNwU4N1xzxpeNzpHIX+qkhGwyIR
 u3MA82ytEwHJccY3WUbhLsEtO2XiYsN9wHHoXvvfl8c9nTUKJaIqHHvMGBgqMP3tWVXe
 ixJki5rpFe93Zw03mrQzYi1GRNFA4V48zykB3wgXdCvbl2SX9ooH8D+3i/K9MzOv5Azc
 RBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hdwzt3tFXKWyJadRRPoBDmhsTEk2PAGDfRjvzOl8MPs=;
 b=hIz3d8yOqPMMSkF5I0d7+Vk3wgW1H/FmktdeVd+tmfIyKYusO8LP/8WBqBKYch1Wi2
 Pztcl0LKGfJe4P+gnqUFVmDAtKQH5OgTjp2utBslBM/3+/GAo3HBkkZuol1FCHcd73CV
 umWXlX2Vsso+nxUgj0kA3ixtHpV0/KyyIT1gHIefDAR26I2ckt0vkb+1f/zn18x12HFm
 Ym19OytOSG0RZoqUbkittjcyzPdaK4ACKy8Gmgdu7Vx9fJ4ktGPm5nA6zaMHwIk2GnKX
 pZMWXhyR93k0AAjKjZ0ukqhZxPsVBuNSiJMKUYUkV2kGIsif6TR8e/PPwX7scfNalaT+
 nsWw==
X-Gm-Message-State: AOAM532hfBJySC3RfEPnbyWi92jPbABFJ6Lu8VWFZp/GL2TMmmw4DE4K
 ryDOcW/KDXulDpeJc5HytYeZMn1zDoM=
X-Google-Smtp-Source: ABdhPJzthzi5USsasNOBcEtOTn5iGPgWCSsrAKLGZUE8mnkT5SBcjxOgUHYe7jOF8Sm4SGwLQWJM8g==
X-Received: by 2002:a17:902:9a02:: with SMTP id
 v2mr9718687plp.37.1591364648619; 
 Fri, 05 Jun 2020 06:44:08 -0700 (PDT)
Received: from localhost.localdomain ([1.38.221.125])
 by smtp.gmail.com with ESMTPSA id w186sm7861353pff.83.2020.06.05.06.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 06:44:07 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri,  5 Jun 2020 19:13:10 +0530
Message-Id: <20200605134322.15307-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
References: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jun 2020 15:44:12 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 05 Jun 2020 15:44:10 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v4 02/14] parsing_c: parsing_hacks: Label end
	attributes correctly
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

Due to certain conflicts in the grammar, a separate token
(TMacroEndAttr) is required for attributes before a semicolon or an
assignment operator. Prior to this, multiple end attributes were not
labeled correctly, i.e., only the single attribute before the semicolon
or assignment operator would be.

Add a case to label multiple end attributes correctly.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parsing_hacks.ml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/parsing_c/parsing_hacks.ml b/parsing_c/parsing_hacks.ml
index 0ee0c6c6..74c3ba60 100644
--- a/parsing_c/parsing_hacks.ml
+++ b/parsing_c/parsing_hacks.ml
@@ -2771,6 +2771,10 @@ let lookahead2 ~pass next before =
 	  msg_attribute s1;
 	  TMacroAttr (s1, i1)
 
+  | (TMacroAttr(s1,i1)::(TPtVirg(ii2)|TEq(ii2))::rest,_)
+      ->
+	  TMacroEndAttr (s1, i1)
+
 (*  (* christia: here insert support for macros on top level *)
   | TIdent (s, ii) :: tl :: _, _ when
     can_be_on_top_level tl && LP.current_context () = InTopLevel ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
