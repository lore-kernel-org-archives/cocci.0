Return-Path: <SRS0=15MF=5F=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4051EC4332B
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:04:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD9F920774
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seUGDje/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9F920774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K73xol011322;
	Fri, 20 Mar 2020 08:03:59 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9DFA0780E;
	Fri, 20 Mar 2020 08:03:59 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 493523B93
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:03:58 +0100 (CET)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1043])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02K73uYr014955
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:03:57 +0100 (CET)
Received: by mail-pj1-x1043.google.com with SMTP id ck23so2060530pjb.4
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 00:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tmcsVGk4SUFgwf9gcnr4bcFVeXLGhm9CDcwKlVjnNSU=;
 b=seUGDje/JjVz1jVsXGpTHGH18N9++CYlGkDLaJnEymtt6BLoAKl1p7wfLMuZ4cLwaq
 sK4Ndmz1Fb8YNnpTCc/EhE9yGzOdzMNHSOZkY/YDDLCo2IdxJxRV6LBtDRmy/ila/Zf3
 04MTQQsumHGhdLFG3vPMdo7VFIggMs+K7Rh01T3muDyRJk7m31nyLPJ/s4t9/K3wEMbM
 LcM05jQFcnCoISCQJimjdbjK7nPzJM+2MvHUzCAnZJWeoHZ4Fel8TIJFKzawP+qzxovZ
 +WpAQsnjliDoNaurS43esUsPKtXDo+W3zrYxBJXCB1H7dzQiqzFNpbnLyx81IPv5qW6R
 hbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tmcsVGk4SUFgwf9gcnr4bcFVeXLGhm9CDcwKlVjnNSU=;
 b=XbFt6ufu1ykJI9mwtAnWvzm9R1VPlTHao5F/NqBTB8clISJqh8Pyl9KCpTYwqjEA0b
 ozu2Q4YNqsqwN6ssJD570nQUOSGTFsaP1b+K03WgkEOIjtME6N5OVVaoeXbhtzIUys+p
 kbX1o3DpFbdBrzO9QyDkjKL5qQbcJsIo1n/IZDIvrnRtzCp3qAluNcZy37rpOctj2Viw
 WQ1s27yqSiI+PORVrgA7dWVLCb7jkGfQmXyhHT1/yJ4fZXHVWHIalfSxAsauzAJTSJ4H
 Mcq+yED25IPUKAYDWgniv99u1b1c1vCA6ejGJodx1ARUJKlGeDIJMR7HJQ7xqDdRcHhh
 ASsA==
X-Gm-Message-State: ANhLgQ3calQh686KGbrYldu2BXbnr5k+WJ0uNirqvjmmZEGsm8RROvfp
 1QSsq7xWQsK6ffqMcK3EJWQS1vea
X-Google-Smtp-Source: ADFU+vscZajQ9CDH5RyZV707gQojJP4BxF9R15BxCbAmPIQZFK1rxe9nAoNwpjLgyco7aKwyQHfT1g==
X-Received: by 2002:a17:90a:ab0a:: with SMTP id
 m10mr5451764pjq.173.1584687835923; 
 Fri, 20 Mar 2020 00:03:55 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2190:a751:deeb:c09d:833a:659d])
 by smtp.gmail.com with ESMTPSA id l11sm3941232pjy.44.2020.03.20.00.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 00:03:55 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 20 Mar 2020 12:31:57 +0530
Message-Id: <20200320070157.4206-27-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
References: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 08:03:59 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Mar 2020 08:03:57 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 26/26] tests: Add test case for array of function
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
