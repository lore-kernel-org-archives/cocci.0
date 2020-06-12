Return-Path: <SRS0=FQJD=7Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C19C433E0
	for <cocci@archiver.kernel.org>; Fri, 12 Jun 2020 06:46:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E52207F7
	for <cocci@archiver.kernel.org>; Fri, 12 Jun 2020 06:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJLSc/Ow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E52207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05C6kEW6023016;
	Fri, 12 Jun 2020 08:46:14 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D773444A7;
	Fri, 12 Jun 2020 08:46:14 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6F4333BAB
 for <cocci@systeme.lip6.fr>; Fri, 12 Jun 2020 08:46:13 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05C6kBst008363
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 12 Jun 2020 08:46:12 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id z63so2927480pfb.1
 for <cocci@systeme.lip6.fr>; Thu, 11 Jun 2020 23:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5zzNr5y1d8VFjowbDn4IgbzrWJxjXgTuZtBl3FeVQOc=;
 b=lJLSc/OwfbYii0YL/Qi//+/D3OHKaDKwDHZ2WbsUBzfJjKxJwK4KSxGlMY8LZSZVLR
 7ukcagmNPVeJa/v0HoL8ubrVUr01cmrjN253SGv6YFlR5uJMMYcc5oADGoR5ONHhp/As
 YTAOS2DErG7lihlFBOxFsiqTHp5uMxC7w22VQr52OdmSD/6+DrY2FV9drH72DATFOdTZ
 khfubmn/huoCquIo6SYW7NmGADD+KsrnLVej0hi3Gs2jJPDZAl6DuVzPTYuZz+dAdZnY
 8oalqTJMud5hpk7h+ZtKnuomN8Sx9qXDSr9FzBAkoJanpx4EHLd4Eplek3tFw0kvJpcM
 qJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5zzNr5y1d8VFjowbDn4IgbzrWJxjXgTuZtBl3FeVQOc=;
 b=hCEqFI1kUGVCTiyRqQekD2hyGZhXE2G98kwZoq8m79Y1IOhN4rTajf7rEUYcvgaa3I
 5Y2reY6kuADuh/AdpM7eI4qj0cCfDwNGnucx0EO1zEEGRuNisih0i1H2G+7cYPRwmtcA
 zlf/GoswkzPrDHjWnxk5oIhwJbvsGwtBVd7kTYloUPgG4KbFsLvsFm+X/4lH86gCB5Lv
 RuIKoFA6IUBtJVw3q5s47M90jvHLVPD4mL6zl2zn06y1gzG5ywQIFE+YT8lSBGOgaG/U
 FDxFcYpsQ/wXCpTZYBjwW1x6z60a56qFqmu/I1S3KQEzw5dFW//bgo2y7a2OXscf3UE/
 T1EQ==
X-Gm-Message-State: AOAM5332HXgsPw5d+aiZSxoqkUuDN6ZrV2uEBnY+1kerZYKGFx/klCGy
 AYWTpvjYtTww2MDd31stX385evn9
X-Google-Smtp-Source: ABdhPJwHaIAnyADzI21yW34jkEpUtM4dPRrugZVq1bDgeLJNBtutl2hquDYJri43WpxRebva+bR8sA==
X-Received: by 2002:a63:4cc:: with SMTP id 195mr9706157pge.294.1591944370820; 
 Thu, 11 Jun 2020 23:46:10 -0700 (PDT)
Received: from localhost.localdomain ([1.38.217.229])
 by smtp.gmail.com with ESMTPSA id w192sm5087476pff.126.2020.06.11.23.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 23:46:10 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 12 Jun 2020 12:15:41 +0530
Message-Id: <20200612064544.30194-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 12 Jun 2020 08:46:15 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 12 Jun 2020 08:46:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 0/3] parsing_cocci: Improve attr management in
	context_neg et al
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

Introduction of recent patches[1][2][3] for adding additional attributes to the SmPL AST introduced some poor management of attributes in the following files:
	parsing_cocci/context_neg.ml
	parsing_cocci/arity.ml
	parsing_cocci/unify_ast.ml
This patch series is for fixing these issues, by modifying cases wherever necessary.

[1]
[PATCH v3 00/23] cocci: Add parameter attributes to SmPL
https://lore.kernel.org/cocci/20200511101300.11101-1-jaskaransingh7654321@gmail.com/T/#t

[2]
[PATCH v3 00/32] cocci: Add cast attributes to C and SmPL ASTs
https://lore.kernel.org/cocci/20200529120703.31145-1-jaskaransingh7654321@gmail.com

[3]
[PATCH 00/30] cocci: Add macrodecl attributes to C and SmPL ASTs
https://lore.kernel.org/cocci/20200524171935.2504-1-jaskaransingh7654321@gmail.com


Jaskaran Singh (3):
      parsing_cocci: arity: Apply mcode2arity on macrodecl/param attrs
      parsing_cocci: context_neg: Apply equal_mcode for cast/param attrs
      parsing_cocci: unify_ast: Apply unify_mcode to macrodecl attrs


 arity.ml       |   26 ++++++++++++++++++--------
 context_neg.ml |   12 ++++++++----
 unify_ast.ml   |    3 ++-
 3 files changed, 28 insertions(+), 13 deletions(-)


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
