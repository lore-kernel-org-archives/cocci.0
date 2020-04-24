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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48F3C2BA1A
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:18:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7064D20724
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkRUy1RA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7064D20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03O9IUql018566;
	Fri, 24 Apr 2020 11:18:30 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1940A7828;
	Fri, 24 Apr 2020 11:18:30 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E2B427815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:18:27 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03O9IO4q009024
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:18:25 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id f8so3536384plt.2
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 02:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hdwzt3tFXKWyJadRRPoBDmhsTEk2PAGDfRjvzOl8MPs=;
 b=EkRUy1RAwjITi0v6gxlEi+rD+tbojjQ9pGKqNa6yRiuSBja//NWZWDHKZ1FEK2bL6r
 xxqFLZrnMfXMEqGXpsaUH8BwgNkuzlCzf+2L+1y5z4wM4zr1SiK6HN5kb+1NavmFVu/o
 5xY5cM4tLGJ0zdVCO962km3EgAEWfrA7chhb8ueLvXPPv7VL6C3S/PTkuCvIDpI5/uok
 WAEKdRLWUjFlR1QLh0uP3JIXgpa0eUz+U7IAFdES6vfZNzha9NfK3H5gAIt/lOFhmzC6
 CmOONucaBa7Nozir4bjP4n3Rv/+ZDAp0hIRzna10s/EJck1OiHHTe9HTjGkrbcuQEbyX
 z2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hdwzt3tFXKWyJadRRPoBDmhsTEk2PAGDfRjvzOl8MPs=;
 b=ogQIxsxC+idD5sC+T7j7LaLdA2+Yl5893rGF/QE4DucmIOhH6adbLmCsQ8H7VIWTVx
 fFRElH8VaP4usTazfdl5ITE1UpDJLEuAbbIZYMFrFRDRPpP5dFLyQWxQoFelMVeGomaU
 DD2y6D69l6XejanqHbMs9lWFjC7PVzsW7VpBJRJestPOGBOkPmETJMzjdfCUGabfbAo3
 kKKlfFM+nYjmTeMp82NK299H72Dnk9bj5wpU88lDhpTbWPX5PexOBJXB3LoU7KUwKVLV
 wBDQ5WQ9QaOd0/xsHX90jvNGWE/SmsldV168+2Ec/P4ltPCnHoZ44loWleUMsHJ+hxHm
 YIpw==
X-Gm-Message-State: AGi0PuYlY8pvnmuemY9VFNl9hmj4sWh3i4EsOetN138qryNO6ssGJM5a
 pKOO+uafhYhJDfdmZWrTB56r+FU5ppk=
X-Google-Smtp-Source: APiQypL6jYEOd29iJXapjRE3ZoCg2bT3wZvtRFUJ/YB0NXLwSQrNBQqqr7Big2tfODuD4FBbYTjXhg==
X-Received: by 2002:a17:902:b48a:: with SMTP id
 y10mr8106695plr.196.1587719903698; 
 Fri, 24 Apr 2020 02:18:23 -0700 (PDT)
Received: from localhost.localdomain ([1.38.216.60])
 by smtp.gmail.com with ESMTPSA id c80sm5043933pfb.82.2020.04.24.02.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 02:18:23 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 24 Apr 2020 14:47:38 +0530
Message-Id: <20200424091801.13871-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
References: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 11:18:30 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 24 Apr 2020 11:18:25 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [RFC PATCH 02/25] parsing_c: parsing_hacks: Label end
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
