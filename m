Return-Path: <SRS0=13qy=BU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AFFC433E0
	for <cocci@archiver.kernel.org>; Mon, 10 Aug 2020 18:00:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21EF120791
	for <cocci@archiver.kernel.org>; Mon, 10 Aug 2020 18:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URRQu2Nh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EF120791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07AI0DS1009870;
	Mon, 10 Aug 2020 20:00:13 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BE41B7780;
	Mon, 10 Aug 2020 20:00:13 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8A95F5F8F
 for <cocci@systeme.lip6.fr>; Mon, 10 Aug 2020 20:00:10 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:644])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07AI08M5029006
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 10 Aug 2020 20:00:09 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id g19so5421128plq.0
 for <cocci@systeme.lip6.fr>; Mon, 10 Aug 2020 11:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=0LG55qG51rpCI41PmpiglFHzTiH9YaKX8Oz0iDSp87M=;
 b=URRQu2NhmUP+sYGDjX7MTZsDaNn04ufx+5HSlggp5zPp8N5Vay45mQ5I+ZIW2EthCG
 5ixlBaL9OLQVvRBDSPdKwJLIG+SOQfG9SEWpFWyu4M0wwbsCKd5eNkYXVJmdQOuzxnAi
 VI5goqxRFBr5V7EBy3hXA7ylcxYEQ7aXO0om/F4nbxda8XHX/+EP7Zi6WxtZgAnWAjzl
 gZDdFx7WXQvprftcPeOK0tAAO7di6xdIZTMJfz66t7HhsbEuOo6IILtG22l+oX2pGkft
 tP15405Rfis21jNmX0k9NR5+vK4wmuM4GnYFegGxX/xzIcqc/O3RFFePFJc+ZGdBzw7+
 xmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=0LG55qG51rpCI41PmpiglFHzTiH9YaKX8Oz0iDSp87M=;
 b=KZEFnRtuRMvGmlb6uuWAocQdk6ZtbPC0HvtGOmCxFEpPaMyjgg8JVQI21BAtGhk7g3
 yRn+vbBXUSm+GFMePqeZfVQXZSJC8iUbRIgb7gUIpV9My/ZJZNTC1ZPmaQKc6xTxak87
 jqeANx+aye/iaa+fiL4Kak5yagyy9GfVD13JK9guM2rT3+CgFnLpnZyMOEV4kgDjjkU4
 2cSQbFdONahlkEkLVVPMmKrqEl8WHkcarnixkVncPoAU/yFH4v7oBkb3lPxZwPXXuary
 JDl8ex8lqr4vjX3OL+2X+i88keFKFt4coyEbdT9oVaiSQ30FiW6OD7K80Srpc3Jd4HYH
 o8/w==
X-Gm-Message-State: AOAM533nFkkIPYMqHUPsGMK963G3bikhSVMP8tezmcwYy5rEUSrcU+2Q
 w3Wlj+S+eHa4WupEd5Qhb7g=
X-Google-Smtp-Source: ABdhPJz3jnM2YrQz8Nk9zaTHHn8Y527vevBQb2fK04cFNM5Oo8Cr9oVQISUOASOqI2oQuxzpiMs1XQ==
X-Received: by 2002:a17:902:76c5:: with SMTP id
 j5mr4536166plt.87.1597082407541; 
 Mon, 10 Aug 2020 11:00:07 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:548a:bff1:8079:d08c:8652:dd80])
 by smtp.gmail.com with ESMTPSA id n3sm22275250pfq.131.2020.08.10.11.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 11:00:06 -0700 (PDT)
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Date: Mon, 10 Aug 2020 23:29:48 +0530
Message-Id: <20200810175948.14090-1-sylphrenadin@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 10 Aug 2020 20:00:14 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 10 Aug 2020 20:00:09 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, linux-doc@vger.kernel.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, Gilles.Muller@lip6.fr,
        nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        Markus.Elfring@web.de, cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH v3] documentation: coccinelle: Improve command
	example for make C={1, 2}
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

Modify coccinelle documentation to further clarify
the usage of the makefile C variable flag by coccicheck.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

---
Changes in v3:
        - Remove quotes as suggested by Markus Elfring
	- Change in wording, and punctuation, as suggested by Julia Lawall
---
 Documentation/dev-tools/coccinelle.rst | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 6c791af1c859..74c5e6aeeff5 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -175,13 +175,20 @@ For example, to check drivers/net/wireless/ one may write::
     make coccicheck M=drivers/net/wireless/
 
 To apply Coccinelle on a file basis, instead of a directory basis, the
-following command may be used::
+C variable is used by the makefile to select which files to work with.
+This variable can be used to run scripts for the entire kernel, a
+specific directory, or for a single file.
 
-    make C=1 CHECK="scripts/coccicheck"
+For example, to check drivers/bluetooth/bfusb.c, the value 1 is
+passed to the C variable to check files that make considers
+need to be compiled.::
 
-To check only newly edited code, use the value 2 for the C flag, i.e.::
+    make C=1 CHECK=scripts/coccicheck drivers/bluetooth/bfusb.o
 
-    make C=2 CHECK="scripts/coccicheck"
+The value 2 is passed to the C variable to check files regardless of
+whether they need to be compiled or not.::
+
+    make C=2 CHECK=scripts/coccicheck drivers/bluetooth/bfusb.o
 
 In these modes, which work on a file basis, there is no information
 about semantic patches displayed, and no commit message proposed.
-- 
2.17.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
