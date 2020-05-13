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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DECC2D0F8
	for <cocci@archiver.kernel.org>; Wed, 13 May 2020 07:30:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EBBA205ED
	for <cocci@archiver.kernel.org>; Wed, 13 May 2020 07:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1HBj7BS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EBBA205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04D7UKQl004276;
	Wed, 13 May 2020 09:30:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1F7357559;
	Wed, 13 May 2020 09:30:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6F69A3DC8
 for <cocci@systeme.lip6.fr>; Wed, 13 May 2020 09:30:18 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:102f])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04D7UGe8021295
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 13 May 2020 09:30:17 +0200 (CEST)
Received: by mail-pj1-x102f.google.com with SMTP id ms17so10601179pjb.0
 for <cocci@systeme.lip6.fr>; Wed, 13 May 2020 00:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SFsW3bIOVcFHipmxwkC0H0m1z04X3WyFGADGmsB+qJs=;
 b=g1HBj7BSbECQY90MFDpv0gSLVc0an55Q5f0WVj2EfdwDbrGC63nq4Klmi3y8GM1UhH
 Pqkw3NnPJ4DR8IvJ0ON/axoDfEB6djHJD+r1SDQwnDA48SuiuySo6UQyHzkAAsXQtny8
 mYNL1fqlhWE5w8nzy1fVtFIUs3FZcnAV/P9viWpadAjNOG9WHaA4lPqDMCGQJdCKrkjn
 z0ewqHKHSCmVQ1dsgnTRtIhY0pFkOKNdsuTDZU+xAGDfU6BjutjthtYB00Xbfk76S9Dp
 vIE9N7S1LnqP1EOxku3bqxYGTPAb8ThjcN/ywhkN50cEHYGi6t//++4YffopAoBX3NFg
 ejeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SFsW3bIOVcFHipmxwkC0H0m1z04X3WyFGADGmsB+qJs=;
 b=deYDVtURdRs/o/IXuqxbt/qRAF3x7z27N17R6kQJe4QJiC8FRYvnqIzdISmAbqpcZy
 ofiSZwrwZfmhWgvhmXNvclzD1g/1tBfRZaIXOLP8pVZT6s9wOitFWVDvzQUKX3/qOfWd
 ZEAaKia7XdnUHSH5bPdz9v6jebtv7bi02ciVIgd7k0vGi+qr42+UX3sx124sIe5kzLWP
 Pxb+6GMYx2P115172eW41Tnwy5n9oo5d1gkmgq9vlMrZz/bB/U+zU+VUwIcL0dQrmVXn
 BVW+AjGXgsJqRGnr28XmFrsESTfIfwyHnm8HdQ1hfsA1RHU4k98hJK3JqUAdldK1dLC1
 o1ow==
X-Gm-Message-State: AGi0PuZLL74Pbl5w6S837v4KNppu1tvvk2ikwr3bsiWtRm1oqQEaEFp5
 huUygXXfmhSVToCvd6MsFxad4OysWWE=
X-Google-Smtp-Source: APiQypKvO2gBnsZ8oA6lmTiXfr0Wmq6XMUelEr1mCpV1WdYMWnBIKaazYFxG6unWhPLpPwE2x36W+w==
X-Received: by 2002:a17:902:9a06:: with SMTP id
 v6mr23892927plp.343.1589355016109; 
 Wed, 13 May 2020 00:30:16 -0700 (PDT)
Received: from localhost.localdomain ([1.38.219.254])
 by smtp.gmail.com with ESMTPSA id n9sm14852828pjt.29.2020.05.13.00.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 00:30:15 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Wed, 13 May 2020 12:59:51 +0530
Message-Id: <20200513072951.3453-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200513072951.3453-1-jaskaransingh7654321@gmail.com>
References: <20200513072951.3453-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 13 May 2020 09:30:20 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 13 May 2020 09:30:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 2/2] tests: Add test case for struct pointer
	function call
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

This test case is in response to the following bug report:

https://www.mail-archive.com/cocci@systeme.lip6.fr/msg07332.html

Add a corresponding test case for a struct pointer function call.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/structptr_func.c     |  5 +++++
 tests/structptr_func.cocci | 12 ++++++++++++
 tests/structptr_func.res   |  6 ++++++
 3 files changed, 23 insertions(+)
 create mode 100644 tests/structptr_func.c
 create mode 100644 tests/structptr_func.cocci
 create mode 100644 tests/structptr_func.res

diff --git a/tests/structptr_func.c b/tests/structptr_func.c
new file mode 100644
index 00000000..e65dc4ce
--- /dev/null
+++ b/tests/structptr_func.c
@@ -0,0 +1,5 @@
+void func(struct socket *sock, struct sockaddr *uaddr, int peer)
+{
+	sock->ops->getname(sock, uaddr, peer);
+	return;
+}
diff --git a/tests/structptr_func.cocci b/tests/structptr_func.cocci
new file mode 100644
index 00000000..cf725d96
--- /dev/null
+++ b/tests/structptr_func.cocci
@@ -0,0 +1,12 @@
+@@
+struct socket *sock;
+struct sockaddr *uaddr;
+int peer;
+@@
+{
++int ___addr_len;
+...
+- sock->ops->getname(sock, uaddr, peer);
++ sock->ops->getname(sock, uaddr, &___addr_len, peer);
+...
+}
diff --git a/tests/structptr_func.res b/tests/structptr_func.res
new file mode 100644
index 00000000..1b2d437c
--- /dev/null
+++ b/tests/structptr_func.res
@@ -0,0 +1,6 @@
+void func(struct socket *sock, struct sockaddr *uaddr, int peer)
+{
+	int ___addr_len;
+	sock->ops->getname(sock, uaddr, &___addr_len, peer);
+	return;
+}
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
