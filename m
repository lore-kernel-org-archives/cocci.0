Return-Path: <SRS0=ajuV=3I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CABEC33CB1
	for <cocci@archiver.kernel.org>; Sun, 19 Jan 2020 13:48:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9122073A
	for <cocci@archiver.kernel.org>; Sun, 19 Jan 2020 13:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfXTmHCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9122073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00JDmOF9021498;
	Sun, 19 Jan 2020 14:48:24 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7F3907722;
	Sun, 19 Jan 2020 14:48:24 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D993037BC
 for <cocci@systeme.lip6.fr>; Sun, 19 Jan 2020 14:48:23 +0100 (CET)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1043])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00JDmJtR005300
 for <cocci@systeme.lip6.fr>; Sun, 19 Jan 2020 14:48:19 +0100 (CET)
Received: by mail-pj1-x1043.google.com with SMTP id n59so5750512pjb.1
 for <cocci@systeme.lip6.fr>; Sun, 19 Jan 2020 05:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KFHaW7MANPO1iW2XlXlYVMWARibm82NfIaz0X5hu9ko=;
 b=UfXTmHCapRCZVqnEyrWLhDG8Gz+30Cetg5aLpo1OU2tSNhT3VMFAsZXY8M0otHEWuE
 TkX1Nyyk/zSAoDNLveAjIl6MdzrLJo+DiwFqB0tA8XRFT1lAze82PHIRfoyzuV5RrEBe
 90fcUmI8L2Opwq6vmxXj4iLf5xIbQrJZnBQsTiL+ev2bjIckAgVjMlW/9tRmQa5nM4pX
 ZYVxKnPh43hgxr3yr0MYf91VWOJFn/9aeHOVpk4F7bLuqugJL1pHZDQ4iCkrjuj+mo9C
 G6cPQD/jufcAW+35SHr1pkIbtgIjroz2cTQEH8DPK5BQVJbpaFZZW5nVALehKxOW0Ev3
 7/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KFHaW7MANPO1iW2XlXlYVMWARibm82NfIaz0X5hu9ko=;
 b=TGK6CIiOyEU52vs6OMgQMrJGYI9Npff7phq+7/fVePZOT8Qj93ZARtiHXLqmyn7x45
 Lqmb3kLf3WiJfMdiy+ykkkaa8ztqzW/i4QCpxEqJgYAfR3HsGDuJ6yyhG/NzmJfxGeKj
 VZkPGhRfNWjoE3yXIujXAsutHQoe8xtp3rq4z8C+Joij6dYO1Gr6HKDJwxtxKwvha2EE
 e9aOm+GWipEJir+5krEqqy6EmV2v9DMyODNUvA4f4odBaFnVuauisy5mhBpZ5YguU83E
 GrGBIs3Lq4fCf9hChilx4vJtijsSjuhqL14tmrDaFPzaD7ukehbdbbv6cAAfQjlrkbTK
 dK2g==
X-Gm-Message-State: APjAAAVOFHYIwcIxOekZ4yWbloUBa2q1kVVpWdQCj6jCAiEoeEWqqZKO
 1dpxM559q6zZ5EYz3d/6J94QDUNz8ic=
X-Google-Smtp-Source: APXvYqyABcNzkeGKQkH7M1VcF4h+O2QCtjA+cokYpzSlGAOmiD/9wvxTiYhgLnVQvXabAnGugM7zDQ==
X-Received: by 2002:a17:90b:8c6:: with SMTP id
 ds6mr17248562pjb.111.1579441698963; 
 Sun, 19 Jan 2020 05:48:18 -0800 (PST)
Received: from localhost.localdomain
 ([2402:3a80:166b:5b82:8890:55cc:899c:7e19])
 by smtp.gmail.com with ESMTPSA id q63sm36625740pfb.149.2020.01.19.05.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jan 2020 05:48:18 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 19 Jan 2020 19:18:12 +0530
Message-Id: <20200119134812.32748-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 19 Jan 2020 14:48:24 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 19 Jan 2020 14:48:20 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH] parsing_hacks: Add bool to list of known typedefs
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

bool is widely used in the Linux kernel. Certain cases of
parsing_hacks.ml would mislabel bool.

Add bool to the list of known typedefs.

Stats of --parse-c on Linux v5.5-rc4 are as follows:

Before:

  nb good = 18956150,  nb passed = 134062 =========> 0.70% passed

After:

  nb good = 18956150,  nb passed = 134073 =========> 0.70% passed

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
The above diff has been obtained after applying
https://www.mail-archive.com/cocci@systeme.lip6.fr/msg06706.html

 parsing_c/parsing_hacks.ml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parsing_c/parsing_hacks.ml b/parsing_c/parsing_hacks.ml
index 685a4908..5e3301a0 100644
--- a/parsing_c/parsing_hacks.ml
+++ b/parsing_c/parsing_hacks.ml
@@ -61,7 +61,7 @@ let is_known_typdef =
       | "u_char"   | "u_short"  | "u_int"  | "u_long"
       | "u8" | "u16" | "u32" | "u64"
       | "s8"  | "s16" | "s32" | "s64"
-      | "__u8" | "__u16" | "__u32"  | "__u64"
+      | "__u8" | "__u16" | "__u32"  | "__u64" | "bool"
         -> true
 
       | "acpi_handle"
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
