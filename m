Return-Path: <SRS0=kxF3=3K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95974C33CAA
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 08:05:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 329FC22522
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 08:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBqPWmuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329FC22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00L85MHQ024386;
	Tue, 21 Jan 2020 09:05:22 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C9F0A77E1;
	Tue, 21 Jan 2020 09:05:22 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 985DE77DB
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 09:05:20 +0100 (CET)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:543])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00L85ELm020656
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 09:05:14 +0100 (CET)
Received: by mail-pg1-x543.google.com with SMTP id z124so1020667pgb.13
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 00:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZGP9dkFNBF7qY4vfMORKTU0siRrZw5MX1d25w1d6MCk=;
 b=LBqPWmuOEU0nfp96yVYLfHWAmWfJXN1fziaUbw/fatLBiMneSMGWYOy2Y/jCrH4YAY
 jwls1qXmiOY5V2PUUvFEj21j1KM0vq72csbbobpF+gPeQzSLcz/EUqXXXTSkJMq8l5ee
 QX9kWydYrS09jUJ8Cd63o6KJFtRosd+/gdv3MhPU77OpeRWV0zVa1y2WO4bV8cEvF2qj
 XrqKZcJ8Ud+E4d6KG31uL3NIWWM5BFkn6SjZm2sIfGDB5o4p3McYsueoP3NjPfGSkQaD
 vnbYc4Lv6pgK4mOhNaTp2rlDcFmB3iDJzA7WI8BB5Te5eiSz9VF0TEeJJeltl1JpTIls
 n0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZGP9dkFNBF7qY4vfMORKTU0siRrZw5MX1d25w1d6MCk=;
 b=Xe9lsmOdId+DMRmnjfx/lxKHwqzrMgpBaRxxoxKmcW4+zGBT9LxpGya03PaDbr7RVH
 p7pELdtiH8Wr6IfOq/V6oKsGNkgpmvyuMt1h6X8lNqbUuG7NvS/bvGJwpLDZxQhZ6Nzo
 y2G7zmdYlb9tLWCNN0TQ3DQkJ0JrWEP1MnsrlnLgZjJwe0FRMyEqhiORYqppSAxV1Vp4
 5dk1nXWDfvI4AsxKrspEggp9dSex2DufQ3fOY+4biGK8VZwZShMvrhyw64lRFOvof/23
 hoLgj7VSk/bCaRzJia2XJd7DIYRjWJagQNh4nMnrzJjcyzHAkz3YXsJAYBsR/OVz8+Sd
 RJSw==
X-Gm-Message-State: APjAAAXxb8vpJfmftNdGHCKszDE1krgGJDZMIdUfgj2ADSy62CjBPOkL
 UlNQnaZPSWyXZycz6jNy3c0/Mwbtjws=
X-Google-Smtp-Source: APXvYqyJtbnK4kwL6PtjPps0PDAFXE6c04E6tiBeMczQVLRzC7P09DNzJDAXp/SVBB4QGY1PqCemLA==
X-Received: by 2002:a63:d543:: with SMTP id v3mr3956243pgi.285.1579593913545; 
 Tue, 21 Jan 2020 00:05:13 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:167e:da7:fcf8:ab67:c0bb:e29])
 by smtp.gmail.com with ESMTPSA id
 k23sm39229604pgg.7.2020.01.21.00.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 00:05:13 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 21 Jan 2020 13:34:52 +0530
Message-Id: <20200121080455.24748-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 21 Jan 2020 09:05:23 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 21 Jan 2020 09:05:14 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 0/3] cocci: Improve management of macros before
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

If <typedef> is a known typedef (such as u8 or *_t) then label <macro>
as a CppMacro. Subsequent cases will label <typedef> correctly as a
typedef ident.

Also add bool to the list of known typedefs so that cases of

<macro> bool <ident>

are handled correctly just like any known typedef will be.

Changes in v2:
--------------
- Group these patches as a series for clarity
- Add a test case for <macro> bool <ident> (Patch 3/3)
- Explain what has been improved with Patch 2/3

 parsing_c/parsing_hacks.ml    |   37 ++++++++++++++++++++++++++++++++++++-
 tests/macro_before_bool.c     |    4 ++++
 tests/macro_before_bool.cocci |    9 +++++++++
 tests/macro_before_bool.res   |    5 +++++
 4 files changed, 54 insertions(+), 1 deletion(-)


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
