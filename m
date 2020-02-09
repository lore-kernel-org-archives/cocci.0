Return-Path: <SRS0=c99d=35=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2320BC35250
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 15:35:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7302E20726
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 15:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9Qi+Nqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7302E20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 019FZ81c027160;
	Sun, 9 Feb 2020 16:35:08 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2B85D772F;
	Sun,  9 Feb 2020 16:35:08 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2426A7718
 for <cocci@systeme.lip6.fr>; Sun,  9 Feb 2020 16:35:06 +0100 (CET)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 019FZ4nh012373
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 9 Feb 2020 16:35:05 +0100 (CET)
Received: by mail-pf1-x442.google.com with SMTP id q8so2386377pfh.7
 for <cocci@systeme.lip6.fr>; Sun, 09 Feb 2020 07:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ImjBmad0Y7KkkpXWrulDc58ZF4Njp59A+rW6CHlZR+U=;
 b=Y9Qi+NqvUn1+xgdPS/Nn8zddkgudP2nSfjzIBBqsklwud4NLjIDg1eZnVOMobvgm+L
 7SiAzhppcFAzl1INZEm8iXL4WKEMBMQK4Nh88WcIX2DOW+4puvHEE8PnEV11qR2UjOzb
 xDaZ0LGTfnCbblzCaSN20r5tNqrFR6aUqIs78bbOihafC8x7Du4pqnasHWgSRxPpIGo8
 iDjK9ALoID7TxL/l77XIBvA1WyLN2A1yBV+c77GI0R8eYerVxESRyf+z8abg2DlXQP/h
 4zKPa5jum7zvKdcR8Rf2yVtkrdeTlHR5WBA3oNPU1LpWwh3kgqlc7s4yXqQV/5f6A0us
 8yCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ImjBmad0Y7KkkpXWrulDc58ZF4Njp59A+rW6CHlZR+U=;
 b=pAYyPtCpY+yQknHgcspog9Ljbe++a7IpI4jlgApe17A5HL59sSQgoOtH7+uVWjfTGy
 MB2hOkfOalzKIxLER5yvtwKMA8hwZ6aXZIAuqUBVass0PXXJ213hhcWuhu9GjNBfSgof
 EkNAhFCUA0mtvTZwRQtP6BEXySfJrlp0jNXN4uPa/vfLBTqvUNFgp1D5wIuBqbMh11FV
 H6DlZniHchczmifbxcm+gVdnzg5iWOrERKOduCu8tnuB2tLuxNxuoJs8ho+G7KskGhp0
 Yvd1f9off6tc5kN6whTTWQrIMwKijmsmHdUYJVzW2VvGQkgSvj+P2y7ahKVc3/GfyK5r
 qY6w==
X-Gm-Message-State: APjAAAWqxxgYsCmxoUKdnH6GfC95Vn81ZPwYR08U/VPgT8LmhcXMSrS/
 WJWynXq8am5bucb5z12U2ZLX0LAh
X-Google-Smtp-Source: APXvYqxRwSyHg7aaX3NIfUKtjWJRm7LL8+kQ7sFstIo+nZhmfOQhp8ibI4cqrhmCdUpmi2BqbJGF/g==
X-Received: by 2002:a63:3349:: with SMTP id z70mr5505854pgz.408.1581262503659; 
 Sun, 09 Feb 2020 07:35:03 -0800 (PST)
Received: from localhost.localdomain ([2405:204:22ac:7250:d1c8:6411:2f12:731d])
 by smtp.gmail.com with ESMTPSA id c11sm9451702pfo.170.2020.02.09.07.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2020 07:35:03 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun,  9 Feb 2020 21:04:49 +0530
Message-Id: <20200209153452.11837-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 09 Feb 2020 16:35:08 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 09 Feb 2020 16:35:05 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v4 0/3] cocci: Align the C AST and Cocci AST for
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

Changes in v4:
--------------
- Change coding style w/r/t placement of comment with List.iter and
  the qualifier printing function.

Changes in v3:
--------------
- Add a space between the * and qualifier in Patch 1/3.
- Add Patch 2/3 to add a space between * and const in the test
  case ptrconstptr.

Changes in v2:
--------------
- Change body and subject of Patch 2/2 as per suggestion of Markus
  Elfring.

[PATCH v4 1/3] parsing_c: Align C AST and Cocci AST for pointer
[PATCH v4 2/3] tests: Add space between * and const in
[PATCH v4 3/3] tests: Add test case to match const pointer variants

 parsing_c/parser_c.mly      |    4 ++--
 parsing_c/pretty_print_c.ml |   14 ++++++++++----
 tests/constptr.c            |    7 +++++++
 tests/constptr.cocci        |   19 +++++++++++++++++++
 tests/constptr.res          |    7 +++++++
 tests/ptrconstptr.res       |    2 +-
 6 files changed, 46 insertions(+), 7 deletions(-)

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
