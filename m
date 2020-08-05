Return-Path: <SRS0=VsEQ=BP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00919C433DF
	for <cocci@archiver.kernel.org>; Wed,  5 Aug 2020 08:58:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7268922B40
	for <cocci@archiver.kernel.org>; Wed,  5 Aug 2020 08:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vBycW0YI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7268922B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0758w5ba029317;
	Wed, 5 Aug 2020 10:58:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E487241F5;
	Wed,  5 Aug 2020 10:58:04 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 694974084
 for <cocci@systeme.lip6.fr>; Wed,  5 Aug 2020 10:58:03 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0758w1ZE004556
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 5 Aug 2020 10:58:02 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id d19so499670pgl.10
 for <cocci@systeme.lip6.fr>; Wed, 05 Aug 2020 01:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=6z4BtSfyPhm8FSZ25vbHMUyLLqoJGugLumxHfRS+vcU=;
 b=vBycW0YI0MBJ7/ydGdDUcDOklc7CTc3aUfphBk3gy65bdHN/YsB3d+plPiLgLGNQRs
 7hfb0Q0EGuxVxKR6Vlpcpi8NLwKdbP/h9oh/E8IzjJXkbQ8TkSJp4/gj0rQUH7ddWoNB
 zuA/a+v1xU896+ZjbekFAXCJg8oSfNQf00+q4kV1hw6XUvpR85Lhfhu1DN7GQw0XvDhD
 AV//VQJdWX43bcxIXwWQjkiPPffw3fZK+/MB3SvP3YfbFKKqtAAeydWkHvHqdNkEdl8d
 QLQ/H07/kWjL0HF8iZAnSRv/57zI3MxXczMC1bxe9ZBkAp/W/EhPO9HCo3KI+McbXoZs
 dOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=6z4BtSfyPhm8FSZ25vbHMUyLLqoJGugLumxHfRS+vcU=;
 b=GCzHGeUFjNzC3wHVG1AR5Y+arasNnu6/rhSI+t5ZmD3602cvIChTyTohbkUzZvGNH4
 ++VzCv4XXyrek5XzcFkubnFRXAsfRKysK+eun1wzKYdJZAevSwnvAPK2fQr9Xm8ToSLf
 QlY0+qY9pr0HnB3dJET/PkqA1WSIZ8lzhYnQjidIjmgCa9wYcTIe60nNe0i9A37r9TBJ
 bVxcHHPLjkwm7yW8McPpYh17kr0i0VHnqV88mji6jkfyxK3NFmaykgtepYT81p8d5iBE
 G8r9413RpTYg0eCNLbHNB8DFbMlXXIhjJluVAEWMsf6noxMQJ0WlUcJ+54C0P0lMkuTM
 ucXQ==
X-Gm-Message-State: AOAM533JaowCJDyDLGMZnnDFJQjcOmjA9g96DyOSJogk9ePRgjn/mur2
 IdFUXbanaSwNYXJhyB284jI=
X-Google-Smtp-Source: ABdhPJz+qziOqDKLYQASamapIJBDEfHS/yK8/HaBDxRZ8CK+id83lz0nZysUuHIu5g63MH/VN8A/Nw==
X-Received: by 2002:aa7:8608:: with SMTP id p8mr2281174pfn.62.1596617881218;
 Wed, 05 Aug 2020 01:58:01 -0700 (PDT)
Received: from localhost.localdomain ([106.51.111.128])
 by smtp.gmail.com with ESMTPSA id i1sm2466361pfo.212.2020.08.05.01.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 01:58:00 -0700 (PDT)
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Date: Wed,  5 Aug 2020 14:27:40 +0530
Message-Id: <20200805085740.9263-1-sylphrenadin@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 05 Aug 2020 10:58:05 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 05 Aug 2020 10:58:03 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, Gilles.Muller@lip6.fr, gregkh@linuxfoundation.org,
        nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH v2] scripts: coccicheck: Add chain mode to list of
	modes
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

This patch adds chain mode to the list of available modes in coccicheck.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
Changes in v2:
	- Change coccinelle to coccicheck as suggested by Julia Lawall.
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328210ac..6e37cf36caae 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -99,7 +99,7 @@ fi
 if [ "$MODE" = "" ] ; then
     if [ "$ONLINE" = "0" ] ; then
 	echo 'You have not explicitly specified the mode to use. Using default "report" mode.'
-	echo 'Available modes are the following: patch, report, context, org'
+	echo 'Available modes are the following: patch, report, context, org, chain'
 	echo 'You can specify the mode with "make coccicheck MODE=<mode>"'
 	echo 'Note however that some modes are not implemented by some semantic patches.'
     fi
-- 
2.17.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
