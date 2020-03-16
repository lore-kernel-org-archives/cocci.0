Return-Path: <SRS0=+m3J=5B=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411B7C0044D
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:05:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB9CE2051A
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIiGBhuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9CE2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GA5Ad6026909;
	Mon, 16 Mar 2020 11:05:10 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 52E7F7809;
	Mon, 16 Mar 2020 11:05:10 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D2D4B7802
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:05:08 +0100 (CET)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:543])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GA55kY006728
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:05:06 +0100 (CET)
Received: by mail-pg1-x543.google.com with SMTP id t3so9471312pgn.1
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 03:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tmcsVGk4SUFgwf9gcnr4bcFVeXLGhm9CDcwKlVjnNSU=;
 b=TIiGBhuumZo/dz3cJHU8eYlIatN3z3q3nYAUCY/+rUqntuYEpTQoOw0XCDm22XzRgT
 Y7zxMhUW4BZToJw9peZLabfqXd4KlctfILGC33XhLj+GF52lW5yF9dziMp8Ax8CbVqEP
 Sjo6nxfuVHjm6EgLa5nqgFjFa5MTbhWMh45vi1I5aqnfXHAuGOsbZi1yVAV1rxCjc11h
 iSQUEfMGKyTFIlgsRElxjthIsF7DyOASsCm76b12MVg5/S9i69BQY2kdzGwJ4/IQ4rsU
 xvYAP8P16ds4W0trA9YENnDy0N7gmThBr26ccFA6wlmlUqy0yFIpVZfGnkwV2WDjzcZo
 CjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tmcsVGk4SUFgwf9gcnr4bcFVeXLGhm9CDcwKlVjnNSU=;
 b=hQRuBZaRkHeEyVaHpops57YZiL+b49wzdxZXWm3GHzu4NpiTEXLTdJp40u+3CKHBCh
 7Bp6OBUgdoSF+6EFQrQf6jg/fVjDm/9uHWBz7O9SHj9vA4AlP++9VjmdZx5VLvvUhlME
 YXlg7QTK4vPxhFHqzCA3QB3EO/7lXkl6y0ZBMX3ntNtmzTrbXwwufni+60Y0GNH8oqCG
 hNsrZjQIPtV43UjAuXdgikw56OyWRx+avZqPZxS/2/ZeXjITa+H5bsImNMVlfGzbvRS3
 4zHJwavAtnLinjeea1HmtzEY8zBY/1XJ/VlOINQ+T2wWG0efreGW1EvQB0wdbz3ZY6ke
 FyNQ==
X-Gm-Message-State: ANhLgQ36Gn0asRewT83rUwzvDKob6Rq39ZAy1RI7DfbH2uGvMbhq8iU9
 l6sg6v68KyOqZCirEFZpAeZiLwgc
X-Google-Smtp-Source: ADFU+vtKPbUpMfGCiBIE9hewJE/DuoruuHCZ+nnlW+kJwa1e4aw50p36XEbaqlap18zXyvyIjJnOgg==
X-Received: by 2002:a63:e14c:: with SMTP id h12mr26269333pgk.393.1584353105046; 
 Mon, 16 Mar 2020 03:05:05 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:284:a4f2:cc63:b7fc:551c:dce5])
 by smtp.gmail.com with ESMTPSA id
 u3sm19803374pjv.32.2020.03.16.03.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:05:04 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 16 Mar 2020 15:33:19 +0530
Message-Id: <20200316100319.27935-27-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 11:05:10 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 16 Mar 2020 11:05:07 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 26/26] tests: Add test case for array of function
	pointers
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

Add a test case to match against an array of function pointers.
This would previously not work due to differences in the C
and SmPL ASTs.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/funptr_array.c     | 1 +
 tests/funptr_array.cocci | 9 +++++++++
 tests/funptr_array.res   | 1 +
 3 files changed, 11 insertions(+)
 create mode 100644 tests/funptr_array.c
 create mode 100644 tests/funptr_array.cocci
 create mode 100644 tests/funptr_array.res

diff --git a/tests/funptr_array.c b/tests/funptr_array.c
new file mode 100644
index 00000000..dac29ac6
--- /dev/null
+++ b/tests/funptr_array.c
@@ -0,0 +1 @@
+int (*x[2])(int x);
diff --git a/tests/funptr_array.cocci b/tests/funptr_array.cocci
new file mode 100644
index 00000000..8027bcf4
--- /dev/null
+++ b/tests/funptr_array.cocci
@@ -0,0 +1,9 @@
+@@
+type T;
+identifier x;
+@@
+
+T (*x[2])(
+- int
++ char
+  x);
diff --git a/tests/funptr_array.res b/tests/funptr_array.res
new file mode 100644
index 00000000..72e1a14a
--- /dev/null
+++ b/tests/funptr_array.res
@@ -0,0 +1 @@
+int (*x[2])(char x);
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
