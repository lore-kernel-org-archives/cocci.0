Return-Path: <SRS0=8ujx=BV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AA2C433E0
	for <cocci@archiver.kernel.org>; Tue, 11 Aug 2020 00:24:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7365C20716
	for <cocci@archiver.kernel.org>; Tue, 11 Aug 2020 00:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqH51J+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7365C20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07B0O5ac022129;
	Tue, 11 Aug 2020 02:24:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DF5747780;
	Tue, 11 Aug 2020 02:24:04 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D28C75F8F
 for <cocci@systeme.lip6.fr>; Tue, 11 Aug 2020 02:23:59 +0200 (CEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:443])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07B0NwRd021165
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 11 Aug 2020 02:23:59 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id f193so6639462pfa.12
 for <cocci@systeme.lip6.fr>; Mon, 10 Aug 2020 17:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=+99HTk829z77UgrecGTfuYR3c4AUA/fCCf1uyPq3Gps=;
 b=JqH51J+5OOrX2djgbNaNaswnXP/HlQYtcQsCZ5oN0ZvyhpWFZell4QyQU4zgKJEVbc
 vkebOn22n3aGaSC8IT4+7RtXE/YpspGqTsD8JPB0hqP09ihP0ZBFcdRTfKFdy3QpgjL+
 r58+nuzJ14sxJlF0ONVMBgbShhkuvGEXl2e4gYTGB8NwVac6y4QH8FpbBaCJT352KUni
 e/WCMEb5szl294cAlvU/CfWSDjpkZkqBqglVQ/znM/mYAS8eH1HnER13PvGrrEqcgXei
 jjToFVGYEPyAcBxi4OXL/MfZAMf+yhLJJF0O/587iJ52eUSbysCXZW6NDOJL6bu8el4g
 dvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=+99HTk829z77UgrecGTfuYR3c4AUA/fCCf1uyPq3Gps=;
 b=HUCu0tM2r7F6W/olchXwAAQK6JKGO+x2aQXwpSzcyu2ucgxvvXxwsdbN562+0lTxrw
 5zBiX2oazGhW6XngxufXfsfpG2869JjxqGYbexiz1cPMPTA9T3t4djcWP8OOj+4ckNTS
 Frzf6ekGU9j+4Bbz5aFWKgSUePmQ9DWvRUNkQG5+74CFq1UvuWgtDmW6iIGqsDberal9
 d2U3Zml8wVMTRdj3XtKB43MLg7r7r6R7dghXLQvgSbyVcSrXnEWRKQkz27kvcxc7vSX4
 jMJuOJGZNTEGhV+V7KvkQdaQjhhIAvL+WlG5umyfm+O8cufxL+P9Yi9db3DSVttAjNTT
 JssA==
X-Gm-Message-State: AOAM530NbgWRFcHJjBP80fDVHHpvV5e3gwwoIGSCzWo54PZl3pYge6ql
 UtpRYaI8UJCiiC1Hvtk3/A4=
X-Google-Smtp-Source: ABdhPJygP9COsdnZLeCPz6eyeYXL2sj3Yj037OMMH/cI1UNtw6rIKfKl8cj8poOchjTYWMKukr5JVg==
X-Received: by 2002:a62:e30a:: with SMTP id g10mr3419621pfh.66.1597105437549; 
 Mon, 10 Aug 2020 17:23:57 -0700 (PDT)
Received: from localhost.localdomain ([106.51.104.221])
 by smtp.gmail.com with ESMTPSA id i1sm24132356pfo.212.2020.08.10.17.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 17:23:56 -0700 (PDT)
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Date: Tue, 11 Aug 2020 05:53:50 +0530
Message-Id: <20200811002350.5553-1-sylphrenadin@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 11 Aug 2020 02:24:05 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 11 Aug 2020 02:23:59 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, linux-doc@vger.kernel.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, Gilles.Muller@lip6.fr,
        nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH v4] documentation: coccinelle: Improve command
	example for make C={1, 2}
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Modify coccinelle documentation to further clarify
the usage of the makefile C variable by coccicheck.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

---
Changes in v4:
        - Modify commit message to clarify C is a variable
---
 Documentation/dev-tools/coccinelle.rst | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 6c791af1c859..74c5e6aeeff5 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -175,13 +175,20 @@ For example, to check drivers/net/wireless/ one may write::
     make coccicheck M=drivers/net/wireless/
 
 To apply Coccinelle on a file basis, instead of a directory basis, the
-following command may be used::
+C variable is used by the makefile to select which files to work with.
+This variable can be used to run scripts for the entire kernel, a
+specific directory, or for a single file.
 
-    make C=1 CHECK="scripts/coccicheck"
+For example, to check drivers/bluetooth/bfusb.c, the value 1 is
+passed to the C variable to check files that make considers
+need to be compiled.::
 
-To check only newly edited code, use the value 2 for the C flag, i.e.::
+    make C=1 CHECK=scripts/coccicheck drivers/bluetooth/bfusb.o
 
-    make C=2 CHECK="scripts/coccicheck"
+The value 2 is passed to the C variable to check files regardless of
+whether they need to be compiled or not.::
+
+    make C=2 CHECK=scripts/coccicheck drivers/bluetooth/bfusb.o
 
 In these modes, which work on a file basis, there is no information
 about semantic patches displayed, and no commit message proposed.
-- 
2.17.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
