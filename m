Return-Path: <SRS0=ajuV=3I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870F1C33CB1
	for <cocci@archiver.kernel.org>; Sun, 19 Jan 2020 13:19:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66B7206D7
	for <cocci@archiver.kernel.org>; Sun, 19 Jan 2020 13:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFVu0Ftb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66B7206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00JDJ83d007815;
	Sun, 19 Jan 2020 14:19:08 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 252A67722;
	Sun, 19 Jan 2020 14:19:08 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C624637BC
 for <cocci@systeme.lip6.fr>; Sun, 19 Jan 2020 14:19:05 +0100 (CET)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00JDJ3YL009678
 for <cocci@systeme.lip6.fr>; Sun, 19 Jan 2020 14:19:03 +0100 (CET)
Received: by mail-pj1-x1041.google.com with SMTP id n59so5729840pjb.1
 for <cocci@systeme.lip6.fr>; Sun, 19 Jan 2020 05:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+zYbXDJWvtFPM6M3BR12O6UVxhMabahLWPbjZiZqxpk=;
 b=sFVu0FtbzfwOrx7EO/YIWEZdOZLuccN7CIeGbupCv/jzt00LvcDUNmgnl0fDcaghDp
 l3M4/R4UL23FffyxFSjrVk98v/TrUU8Yhj3VddqpJKVnhTLA6eAo+pEgnWJxWuMpEg3d
 j9i8xye+FZPEGXOF/ibYEWtiFU28gzvIBcn8rSvQEalqh50BR1+D9ydxWKPlfj3UzKRa
 mDh7dn15Oj3R8sSTY0El4NVKyfcXgSMkY+uCUuESg5Dx+J2+77PQ4B1qiEcieUanjpvx
 fzXSGJNMv5EXJeEhC51OYsS5IE9Vkzsiw4KNii5XlX9Uw1jXSEdOA3qLDISASX0XGJDX
 3cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+zYbXDJWvtFPM6M3BR12O6UVxhMabahLWPbjZiZqxpk=;
 b=ZAy8cchp+CVSTePpXBMHe7Hewt1hAsWAeilxkNBb3tIbdIiKKyotfBoi54Qu1AxWmJ
 D6kzBXMmw3gumymFR+nUz8uT06xhV927xkdZ7Vo4Ygxjibr1NHgRbMCb1rGo8U4OyrBy
 ajdmK62omi9Ew4RGIIQXHjdGMRjgr9yvpYaGYar7yQCmtnpZsCFN1QKPS0DWWoRoOZG7
 acW0hL+LU8ihI0KAbF516DJs76DYFW917MfMFCkMizgSRcI1MOGFsMGdnJUSffNnen0e
 6356yguVH/8Lbc/46Aa2eLTZ6tRItoc4sYatBe1uAMacrc4otsY3/niVDQHXKP5dDEeP
 I//w==
X-Gm-Message-State: APjAAAVrQoCsBfax3WeYyYREJ8NPlyLdUX2N+d/EU+WpVWocL/238wzV
 LlmT/k7bWSr45pij54TowjQTT+JS
X-Google-Smtp-Source: APXvYqxjVrqKSg2O/7dbdQ6QUtsIqh6WPUujOWKNvdbmgYayIjdeEbd9hhVnFQLRPP/gWodogskyCQ==
X-Received: by 2002:a17:90a:7784:: with SMTP id
 v4mr18091340pjk.134.1579439942550; 
 Sun, 19 Jan 2020 05:19:02 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:167e:6ff0:778b:ad50:8d0:2129])
 by smtp.gmail.com with ESMTPSA id d129sm36746054pfd.115.2020.01.19.05.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jan 2020 05:19:01 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 19 Jan 2020 18:48:46 +0530
Message-Id: <20200119131846.23302-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 19 Jan 2020 14:19:08 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 19 Jan 2020 14:19:03 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH] parsing_c: Handle case of macro before typedef
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

For the following case:

<macro> <typedef> <identifier>

A case in parsing_hacks.ml sometimes mislabels <macro> as a
typedef ident.

If <typedef> is a known typedef (such as u8 or *_t), then label
<macro> as a CppMacro. Subsequent cases will then label <typedef>
correctly.

Following is a diff of --parse-c on the Linux Kernel v5.5-rc4:
Before
---
After

nb good = 18956150,  nb passed = 134061 =========> 0.70% passed
---
nb good = 18956150,  nb passed = 134062 =========> 0.70% passed

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parsing_hacks.ml | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/parsing_c/parsing_hacks.ml b/parsing_c/parsing_hacks.ml
index 8374731b..685a4908 100644
--- a/parsing_c/parsing_hacks.ml
+++ b/parsing_c/parsing_hacks.ml
@@ -2184,6 +2184,39 @@ let lookahead2 ~pass next before =
       && ok_typedef s && is_macro s2 && is_type type_
         ->
 	  TIdent (s, i1)
+
+  (* xx yy zz : xx is a macro *)
+  | (TIdent (s, i1)::TIdent (s2, i2)::TIdent(_,_)::_ , _)
+	when not_struct_enum before
+        && ok_typedef s2
+        && is_known_typdef s2
+        ->
+	  TCommentCpp(Token_c.CppMacro, i1)
+
+  (* xx yy zz : xx is a typedef ident *)
+  | (TIdent (s, i1)::TIdent (s2, i2)::TIdent(_,_)::_ , _)
+	when not_struct_enum before
+        && ok_typedef s
+        ->
+      msg_typedef s i1 2; LP.add_typedef_root s i1;
+      TypedefIdent (s, i1)
+
+  (* xx yy * zz : xx is a macro *)
+  | (TIdent (s, i1)::TIdent (s2, i2)::ptr , _)
+    when pointer ~followed_by:(function TIdent _ -> true | _ -> false) ptr
+	&& not_struct_enum before
+	&& ok_typedef s2 && is_known_typdef s2
+        ->
+	  TCommentCpp(Token_c.CppMacro, i1)
+
+  (* xx yy * zz : xx is a typedef ident *)
+  | (TIdent (s, i1)::TIdent (s2, i2)::ptr , _)
+    when pointer ~followed_by:(function TIdent _ -> true | _ -> false) ptr && not_struct_enum before
+	&& ok_typedef s
+        ->
+      msg_typedef s i1 2; LP.add_typedef_root s i1;
+      TypedefIdent (s, i1)
+
   (* xx yy *)
   | (TIdent (s, i1)::TIdent (s2, i2)::rest  , _) when not_struct_enum before
 	&& ok_typedef s && not (is_macro_paren s2 rest)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
