Return-Path: <SRS0=c99d=35=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E2EC35250
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 11:55:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3116420726
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 11:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVyqha9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3116420726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 019Bskug028558;
	Sun, 9 Feb 2020 12:54:46 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AA94A772F;
	Sun,  9 Feb 2020 12:54:46 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 77E1B7718
 for <cocci@systeme.lip6.fr>; Sun,  9 Feb 2020 12:54:45 +0100 (CET)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 019BshGe016575
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 9 Feb 2020 12:54:44 +0100 (CET)
Received: by mail-pj1-x1044.google.com with SMTP id 12so2944617pjb.5
 for <cocci@systeme.lip6.fr>; Sun, 09 Feb 2020 03:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/iME+4RwX541eER4UFLDExBQMUtAjsX8GSiFR3pPKgU=;
 b=MVyqha9Sa5zHgcf5bNsRdThWGx5kGOztS5Or5uZTb6eIfRBouKtb/NcbBvNjr8ZuNM
 NlUuSMsLJt+BwXbdmma02N1hv6OIOAFRfEewc9m4UFYHMFS59ooOIW76ufVuAhBmtmri
 W//6Au8OCegF5Cw6lvUDWPoK3D2sma466HIB8AnvDtV/D624RGGo7eKzYL9jDm+CgwTs
 hNWmsXvIwGlY2R78RREZMTIkPP7ub3VjxENjjZk+NjlO33AKNjPcdjviGQBw3aeqaRVm
 QD3joGnudn9VFkCb8fCQxhfNraz/fs9wZEqiqrcslowmaQGtTILd+qH+ub6bp2vPJCGD
 vZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/iME+4RwX541eER4UFLDExBQMUtAjsX8GSiFR3pPKgU=;
 b=nWfVQYLYRbkvAv/maHVCXG60Jsx2JeQ7GPSiQnwXe1rD0rpt6N0typSByDOUYuXQsI
 OK5yWltwesuqzN8xHMJQtTtVwAcGAMgKl0nrZkCXGzZl8F1PpkcycfEMXcdMvimKL26t
 sZ0FjGOz3jV1a2/+LdFzPFWiM9qwMegfbz718WW3+FI1mYH0UMPs3+nphlEYQpEg470V
 vURIEzeuRpbJL5pWoizhuUCMyDBZK15XyZVxVVoFar6e/pOT9uvi/1Ze3HqwJlUVgWg+
 tBr2wI1bRMX8Sg9RVgtLIVRnzeS3haBfZVD2f3zIGaWQyznpWUKOlg6AEci69hksSSpl
 nI1w==
X-Gm-Message-State: APjAAAW281nK6amHeTVaoNfKogCBzLnZQDVjkencEtxR5g7CsQyvYF23
 c9Jr7ht5bWthzawOmhBF2mslsbmpAi4=
X-Google-Smtp-Source: APXvYqzluqmHHV0yGzKIlet6ryKkjTMelOOuq0INHWHmj8rTC+xWe/6aljqzPH479iLYNfj1RYl8cQ==
X-Received: by 2002:a17:90a:ec10:: with SMTP id
 l16mr14621404pjy.19.1581249282769; 
 Sun, 09 Feb 2020 03:54:42 -0800 (PST)
Received: from localhost.localdomain
 ([2402:3a80:166e:dca2:8d98:ad42:3c3b:8544])
 by smtp.gmail.com with ESMTPSA id y6sm8947429pgc.10.2020.02.09.03.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2020 03:54:42 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun,  9 Feb 2020 17:24:16 +0530
Message-Id: <20200209115419.32337-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 09 Feb 2020 12:54:47 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 09 Feb 2020 12:54:44 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 0/3] cocci: Align the C AST and Cocci AST for
	pointer
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

This series is to address the type matching problem in Coccinelle.

Patch 1/3 is for aligning the C and Cocci AST so that
pointer to const pointer and its variants can be matched.

Patch 2/3 reflects the pretty printing changes made in 
1/3 in the ptrconstptr test case. A space is added between
the * and const.

Patch 3/3 consists of a test case for matching a pointer to
const pointer and its variants.

Changes in v3:
--------------
- Add a space between the * and qualifier in Patch 1/3.
- Add Patch 2/3 to add a space between * and const in the test
  case ptrconstptr.

Changes in v2:
--------------
- Change body and subject of Patch 2/2 as per suggestion of Markus
  Elfring.

[PATCH v3 1/3] parsing_c: Align C AST and Cocci AST for pointer
[PATCH v3 2/3] tests: Add space between * and const in
[PATCH v3 3/3] tests: Add test case to match const pointer variants

 parsing_c/parser_c.mly      |    4 ++--
 parsing_c/pretty_print_c.ml |   12 ++++++++----
 tests/constptr.c            |    7 +++++++
 tests/constptr.cocci        |   19 +++++++++++++++++++
 tests/constptr.res          |    7 +++++++
 tests/ptrconstptr.res       |    2 +-
 6 files changed, 44 insertions(+), 7 deletions(-)

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
