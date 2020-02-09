Return-Path: <SRS0=c99d=35=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68659C35250
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 15:35:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8D4620726
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 15:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qM2tNFvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D4620726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 019FZIfx022637;
	Sun, 9 Feb 2020 16:35:18 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D86BD772F;
	Sun,  9 Feb 2020 16:35:18 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DB3387718
 for <cocci@systeme.lip6.fr>; Sun,  9 Feb 2020 16:35:17 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:102e])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 019FZGdP020527
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 9 Feb 2020 16:35:17 +0100 (CET)
Received: by mail-pj1-x102e.google.com with SMTP id m13so3079055pjb.2
 for <cocci@systeme.lip6.fr>; Sun, 09 Feb 2020 07:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5rugtx9GBe1lG9uj6KsKtPWifj61Jj2aO+D5dGd+5dc=;
 b=qM2tNFvWPLge7LBrhpy+xLO1v5Uhd5qpyh/dO5PR6dwQTwNsp1eQGj1JLbvwo+v8zG
 EzyhyiX/B1B2wo7RUqWaostrw3YqaoSr0zdTa6bSfUtL+ksDIoaRclEd9a0bjllR3pLo
 F6Nax7GXdnPFyytidQXPbSTmzoOJZmbxcKbRUWCU4nb4cZluMUaNyZKlIPL1sS7J9Yh3
 C2Ol5NFeMoUseWtYnuYIzjLkM10FRj2/Bx3Xjf6WecNil/2WyfkturPAlTwIENPZh0O2
 1Rlg+la3rRtb9fguSj3BgE8TXuT8szRzcLFLKbPYyZIGY+piucI1kU06v56GCIJpAkQx
 h5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5rugtx9GBe1lG9uj6KsKtPWifj61Jj2aO+D5dGd+5dc=;
 b=JmP1DGiJbWRoE+m9ppXEEGxLxUg4gi/m9y7FGL2zhMLgRbZqSl7Z6xIoC/zpJQqNr3
 IiuUmCwXMwQY3mS06qAp/j456wnBsI0412ItLRDY7SWDUkIEREwCPK5Ocwu+qldAMz43
 YanICOk6k2hEQd3XGzaurUySKTsHyWseRhLKGoDoewNjuowj/blEBdyJ6ECMIE/xOk8Y
 ByzxUKh7PRoOJW+UUxGH0l35CviAbUX9Shqa0733c3QtI1Cby/L037JE14qJ3aQioF86
 9KNCb6ux+/fLYWaRMVNJ1dIJbhuqY8sqtui16jnYqgo3wEEuqn7hA69jtdJSz3eiJTNR
 Np9g==
X-Gm-Message-State: APjAAAW5RbC5awXtCe0Zrj4FULSC/BnrfmUUefzZYvSxhoe2RrPi6osW
 tpsJa59oaXVLsdi+oaI6Js9LlifL
X-Google-Smtp-Source: APXvYqyct8n7HYbRu8eOdkmI8XTZ7FRIztv38xD0azxyi8Z05d/iKhf9XpyM8NfNGhLUk/qReaSQHA==
X-Received: by 2002:a17:90a:2351:: with SMTP id
 f75mr15778296pje.133.1581262515323; 
 Sun, 09 Feb 2020 07:35:15 -0800 (PST)
Received: from localhost.localdomain ([2405:204:22ac:7250:d1c8:6411:2f12:731d])
 by smtp.gmail.com with ESMTPSA id c11sm9451702pfo.170.2020.02.09.07.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2020 07:35:14 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun,  9 Feb 2020 21:04:52 +0530
Message-Id: <20200209153452.11837-4-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200209153452.11837-1-jaskaransingh7654321@gmail.com>
References: <20200209153452.11837-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 09 Feb 2020 16:35:18 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 09 Feb 2020 16:35:17 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v4 3/3] tests: Add test case to match const pointer
	variants
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

Pointer to const pointer and its variants would not match previously.
Add a test case for matching these types.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/constptr.c     |  7 +++++++
 tests/constptr.cocci | 19 +++++++++++++++++++
 tests/constptr.res   |  7 +++++++
 3 files changed, 33 insertions(+)
 create mode 100644 tests/constptr.c
 create mode 100644 tests/constptr.cocci
 create mode 100644 tests/constptr.res

diff --git a/tests/constptr.c b/tests/constptr.c
new file mode 100644
index 00000000..13fe064c
--- /dev/null
+++ b/tests/constptr.c
@@ -0,0 +1,7 @@
+int main()
+{
+	const char * const * id;
+	const char * * const * id;
+	const char * const * * id;
+	const char * const id;
+}
diff --git a/tests/constptr.cocci b/tests/constptr.cocci
new file mode 100644
index 00000000..29f0aa96
--- /dev/null
+++ b/tests/constptr.cocci
@@ -0,0 +1,19 @@
+@ r0 @
+identifier id;
+@@
+const char * const *
+- id
++ id1
+;
+const char * * const *
+- id
++ id2
+;
+const char * const * *
+- id
++ id3
+;
+const char * const
+- id
++ id4
+;
diff --git a/tests/constptr.res b/tests/constptr.res
new file mode 100644
index 00000000..0af4de9a
--- /dev/null
+++ b/tests/constptr.res
@@ -0,0 +1,7 @@
+int main()
+{
+	const char * const * id1;
+	const char * * const * id2;
+	const char * const * * id3;
+	const char * const id4;
+}
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
