Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE0BC433E0
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:22:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593D5206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAaFWMPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593D5206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHMrpV006860;
	Sun, 24 May 2020 19:22:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DF1713DC8;
	Sun, 24 May 2020 19:22:53 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AB42F3D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:22:51 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:643])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHMoLs026005
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:22:51 +0200 (CEST)
Received: by mail-pl1-x643.google.com with SMTP id w19so6607879ply.11
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iot3YpvPhbkQaEWFBXHrzH0ghpjjXBCENeQTA2CY0Ok=;
 b=eAaFWMPhkDyT/LbSs8bw45R1tlLuaJrqGZ2IlT4tN9b9pQrLdEfjnnHeGmGCOUnTqX
 tJ5rLhQdHv3cEUp9XoqzMsH6lgAxsq+MMvw2fAMnPrEVs2UpH5VeJ4F2Os+E4ZegcqPg
 NUE2ZBUADmVkj4dUHQjAao62bn6epF25pJLR67XvgAdA63h321ZQZWygn41xEhESBVgS
 9kRedosiYheR57rqGrAs4bi8pvlF6gBDdJsV1bpda11dBTke8kyUVTgOzwanLW8CgyBo
 9BGFaytkiaD0mxnB3S+PN6VdlM59Ko4K6foRFRW7sFpV36fVWDGxpD6HLohjNexG1BuM
 LxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iot3YpvPhbkQaEWFBXHrzH0ghpjjXBCENeQTA2CY0Ok=;
 b=aj1YCn2np1ZUxc6R/yH1NeVkF7AoYf5U+1KDbysSYMtJvH6LNhWx1puRKNzOLZjvXJ
 W99mibH/qM9FvhI9owYF/+wXW9QwCydJdXtVAeZTrtVWWToGHfKvxQVZ4JnYheLoSCx6
 9lefIUJIp9TeIPe15WP2ITslqrZc91MIhaDu7lvt7qg23jI5BdnJ1K/kg9NYuU6RylkN
 9hJehcotNE2FWhTsaKRzv1jN5n5OJLQ0b+zAprf12Eo5T3I5uerIgNF6ElQ1CFaby6Os
 nLWyKP2pEW+STVlmXzwdG4cOBmIOn3e+05DyU9B/d56/6fL+Xg8Dn1wWW6d0N/cRVXNz
 4FJw==
X-Gm-Message-State: AOAM532yCvi2WjMYoVbXQwDi6lrJLFvt6lUoF6nv4V+tDS5qhPgghRcT
 4IPacx1gcug8tsxcuW+NLU1hrBv9P6E=
X-Google-Smtp-Source: ABdhPJzP5uvv06QVmYq4CHeD9+4UkkdPXA7Wg8/YthwotWe+XwEU/ONGNKkcOztnz4vAlXLKttFIlQ==
X-Received: by 2002:a17:90a:6f41:: with SMTP id
 d59mr3163664pjk.141.1590340969336; 
 Sun, 24 May 2020 10:22:49 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:22:48 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:34 +0530
Message-Id: <20200524171935.2504-30-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:22:53 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:22:51 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 29/30] tests: Add test case to remove macrodecl
	attributes
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

Macrodecl attributes are added to the SmPL and C ASTs. Add a test case
to remove a macrodecl attribute.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/remove_macrodecl_attr.c     | 3 +++
 tests/remove_macrodecl_attr.cocci | 8 ++++++++
 tests/remove_macrodecl_attr.res   | 3 +++
 3 files changed, 14 insertions(+)
 create mode 100644 tests/remove_macrodecl_attr.c
 create mode 100644 tests/remove_macrodecl_attr.cocci
 create mode 100644 tests/remove_macrodecl_attr.res

diff --git a/tests/remove_macrodecl_attr.c b/tests/remove_macrodecl_attr.c
new file mode 100644
index 00000000..73ed6d63
--- /dev/null
+++ b/tests/remove_macrodecl_attr.c
@@ -0,0 +1,3 @@
+#define __macro_attr MACROANNOTATION
+
+DECLARER(a, b) __macro_attr;
diff --git a/tests/remove_macrodecl_attr.cocci b/tests/remove_macrodecl_attr.cocci
new file mode 100644
index 00000000..cd0c44bc
--- /dev/null
+++ b/tests/remove_macrodecl_attr.cocci
@@ -0,0 +1,8 @@
+@r0@
+declarer name DECLARER;
+attribute name __macro_attr;
+@@
+
+DECLARER(...)
+- __macro_attr
+;
diff --git a/tests/remove_macrodecl_attr.res b/tests/remove_macrodecl_attr.res
new file mode 100644
index 00000000..38e4add5
--- /dev/null
+++ b/tests/remove_macrodecl_attr.res
@@ -0,0 +1,3 @@
+#define __macro_attr MACROANNOTATION
+
+DECLARER(a, b);
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
