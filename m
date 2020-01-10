Return-Path: <SRS0=VaV3=27=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237C0C282DD
	for <cocci@archiver.kernel.org>; Fri, 10 Jan 2020 17:12:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B71332080D
	for <cocci@archiver.kernel.org>; Fri, 10 Jan 2020 17:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaSVl6Bm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71332080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00AHCE8o010125;
	Fri, 10 Jan 2020 18:12:14 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2EAD677EA;
	Fri, 10 Jan 2020 18:12:14 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 30A6077E3
 for <cocci@systeme.lip6.fr>; Fri, 10 Jan 2020 18:12:13 +0100 (CET)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00AHCAHK026291
 for <cocci@systeme.lip6.fr>; Fri, 10 Jan 2020 18:12:10 +0100 (CET)
Received: by mail-pj1-x1042.google.com with SMTP id r67so1221169pjb.0
 for <cocci@systeme.lip6.fr>; Fri, 10 Jan 2020 09:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lEVYK9aqtGKNYk8ayn8obK4LdyjwwVi/XRTh47nIavg=;
 b=gaSVl6Bmz5jW/oBpEpFgWB4wgnN+xKAuUZlid0HPQ9VR2CRVIcDH87dapf7uLiicr3
 1ZgJfNw5C7tSG/2NRE4jaUoKU7sXxuDKfcH8vcmmc6NAfioXxYxiIAj0iM2/UVBdlgfe
 ROsh9XT9e2Ng8ZKe/YLfGW58XGN5KOQRSr8z/CQqsurbWEWUvl8ZGPsJSMDhFmzZgab0
 rgpZbOg1dbcEuwvr8Mnp+QO1BNToTc6qwC+hNfdbKOdOZrbGcg4qVoyFe7/kZ+LzAJw/
 lRqc8CgwoX5Dfq1xUIYxdjg52WJ61R1xutwUpYBkNHWfh2gXTxAqirSHkvEXdZg9HyKe
 W1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lEVYK9aqtGKNYk8ayn8obK4LdyjwwVi/XRTh47nIavg=;
 b=OSrITxMLMVG/i5tkGZeaB7ABwfOxn2L0ZVFsCanNay2WZdwqwwCgAtAyuXpfGtrfu1
 4SXX6WawjaWZA27NioDIh5JXs0tZMG5gy6Z0fU3qFHl5mJyvDiUWNtDlu7JaGAYsc9s8
 0lk7OsgmzIqrleawINdJzhlTunKh7gIDFf2OQ3f1jlN3mpsirjWzTmyGEEnrDr1ZTcm5
 8psrPEgslAA0fV0iIqT7Rw+DEFhjZ0Yg+udqcKa3ORPcdS9Vl23kehS1r7ixRbK4RFOU
 5CQ6C5LdyQu0c4Aifguv2BNZ2LYlDtn/GadGvf/JEIaTZlpexwoU+nlGKvdBaVBoE/Ly
 XMpQ==
X-Gm-Message-State: APjAAAUKerRQ6cVYfica/wB1yFyAO9dGzRcZX59ePSsxUbqiK+/2ElB/
 rFAfDjLM5bp+NFl9rkWa/oQC4E1Ovp4=
X-Google-Smtp-Source: APXvYqzLcDbvgHbLNW8MG1OX8FderF9d4SCHPJN7UTd9kuJq8ngUXFQIfKHIMcyofuUzbZtPvm5iug==
X-Received: by 2002:a17:902:6113:: with SMTP id
 t19mr5429388plj.201.1578676329357; 
 Fri, 10 Jan 2020 09:12:09 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:1662:5ce0:c587:cd6:22a3:e892])
 by smtp.gmail.com with ESMTPSA id b24sm3534920pfo.55.2020.01.10.09.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2020 09:12:09 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 10 Jan 2020 22:41:48 +0530
Message-Id: <20200110171150.14695-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 10 Jan 2020 18:12:14 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 10 Jan 2020 18:12:10 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org
Subject: [Cocci] [PATCH 0/2] cocci: Support user comments attached to
	identifiers
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

Comments attached to identifiers via OCaml/Python bindings can be helpful
in using Coccinelle for source code analysis. Users of SmPL can attach
these comments to identifiers for denoting some information.

This patch series is for handling these comments and adding a corresponding
test case for cases that previously caused pretty printing errors

 parsing_c/unparse_cocci.ml |   32 +++++++++++++++++++++++++++++---
 tests/id_comments.c        |    4 ++++
 tests/id_comments.cocci    |   19 +++++++++++++++++++
 tests/id_comments.res      |    6 ++++++
 4 files changed, 58 insertions(+), 3 deletions(-)


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
