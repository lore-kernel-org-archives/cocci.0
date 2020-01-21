Return-Path: <SRS0=kxF3=3K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FF6C2D0CE
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 12:25:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01043207E0
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 12:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vcJByH8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01043207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00LCPNBJ026581;
	Tue, 21 Jan 2020 13:25:23 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 79ABF77E4;
	Tue, 21 Jan 2020 13:25:23 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2586E77E1
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 13:25:22 +0100 (CET)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00LCPGbC010618
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 13:25:16 +0100 (CET)
Received: by mail-pg1-x542.google.com with SMTP id k25so1402422pgt.7
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 04:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1brXa2k7mZVlrYO/2Iox/x78nooL7rko+woUwHappp8=;
 b=vcJByH8EX/HyjBddbY8rRwClzMwpAORu307BToJxvW4wNwk5XdOOL4kYv9g9OllwZd
 849ZH2dKM6amiQCblT4eKtKe3bPE+l+L+Ot40ogX7B+UybW8UCW/CXtv7FfnWhakXAf/
 lqOZ/wQnnOt6J1OiKaAcHTQYlS9VYSfRFl1dSBKe2hHTCVbXMqzpTgqBntPfhSeL6rno
 6bydeMZrDkEOR0EXxdARRafei5GsPsTAqgyhF+DC1JLQujFad0o6KOGHyb/i+dm9AUOZ
 tZjZHhWto2pqzN+MZqrvuhK2x0bWtRIX/84krJ/AW7CvGvM3o5Iv9y/cjS0AyKmI3P/o
 YVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1brXa2k7mZVlrYO/2Iox/x78nooL7rko+woUwHappp8=;
 b=IqzXpx4O73+f9FN88eFzzE09KgjT5/EGsvjpanUeBYR6AaGIuI85oLEhSQzco4gNNu
 g+5Ouk5msrC8M43jLjutC722/QXemKgLRm2u0rAynnCGntxrpctWy3mXFZCU6CCjl9CR
 v+SAGq/NcIDkbFiAVi67ytL3R3vwXLlgyn5geSHaPc0W9MyhTBuL7vVnzxxotywbfkqX
 EYQ+tV5Rly5fQ0bYCCcZGYRQaH90Hj54gDdSCuAjlYte9BLZY4OWTWyXZ8F/zCyKGP0V
 pwy00hEIj/7cse4Sno6n5V16k1Ozw1EQjxvfdRUWtU/32vbhcfMvqRS7o2ynCvrnq0H/
 v+2g==
X-Gm-Message-State: APjAAAXTP6WvQe4veY0kkvI7yuv/i+ghTH3dCMh7brYumuoOpruHmd5g
 VElozKxlN1JJ8f+Ep+bBf4A+t7z0AbQ=
X-Google-Smtp-Source: APXvYqxGWol6flMmuT0EUQSjed7DunPgVYs1ZdoMOi+/6oR8cqLxrzGAVaNBDKW5NHz9kD9L1hsaGw==
X-Received: by 2002:a65:4c82:: with SMTP id m2mr4987048pgt.432.1579609515942; 
 Tue, 21 Jan 2020 04:25:15 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:167e:da7:fcf8:ab67:c0bb:e29])
 by smtp.gmail.com with ESMTPSA id
 h11sm40479560pgv.38.2020.01.21.04.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 04:25:15 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 21 Jan 2020 17:54:56 +0530
Message-Id: <20200121122458.5513-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200121080455.24748-1-jaskaransingh7654321@gmail.com>
References: <20200121080455.24748-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 21 Jan 2020 13:25:23 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 21 Jan 2020 13:25:17 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 0/3] cocci: Improve management of macros before
	typedefs
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

This patch series is for improving the management of the following
case:

<macro> <typedef> <ident>

If <typedef> is a known typedef (such as u8 or *_t) then label <macro> as a
CppMacro. Subsequent cases will continue to label <typedef> correctly as a
typedef identifier.

Also add bool to the list of known typedefs so that cases of

<macro> bool <ident>

are handled correctly just like any known typedef will be.

Changes in v3:
--------------
- Change "subsequent cases will label" to "subsequent cases will continue to
  label" in commit messages of Patch 0/3 and Patch 1/3.
- Change the term "typedef ident" to "typedef identifier" wherever
  suitable.
- Add metavariable symbol false to tests/macro_before_bool.cocci to
  suppress warning.

Changes in v2:
--------------
- Group these patches as a series for clarity
- Add a test case for <macro> bool <ident> (Patch 3/3)
- Explain what has been improved with Patch 2/3

 parsing_c/parsing_hacks.ml    |   37 ++++++++++++++++++++++++++++++++++++-
 tests/macro_before_bool.c     |    4 ++++
 tests/macro_before_bool.cocci |   10 ++++++++++
 tests/macro_before_bool.res   |    5 +++++
 4 files changed, 55 insertions(+), 1 deletion(-)


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
