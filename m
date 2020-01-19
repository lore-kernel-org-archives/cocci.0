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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F09AC33CB1
	for <cocci@archiver.kernel.org>; Sun, 19 Jan 2020 13:46:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0971D20684
	for <cocci@archiver.kernel.org>; Sun, 19 Jan 2020 13:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8yVsadC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0971D20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00JDkQck024099;
	Sun, 19 Jan 2020 14:46:26 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EA88D7722;
	Sun, 19 Jan 2020 14:46:25 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1721D37BC
 for <cocci@systeme.lip6.fr>; Sun, 19 Jan 2020 14:46:24 +0100 (CET)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00JDkMxL005471
 for <cocci@systeme.lip6.fr>; Sun, 19 Jan 2020 14:46:22 +0100 (CET)
Received: by mail-pl1-x641.google.com with SMTP id c9so6686468plo.1
 for <cocci@systeme.lip6.fr>; Sun, 19 Jan 2020 05:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jdQS21ydiqH5O7l4ooG/TbyIarLFdZNwCcRFXTzEwfQ=;
 b=g8yVsadCSULub5bNPjIuuon7MP5sQOQ+uKbpLp34p0xd39uUfADL0thOAr96gxlGsZ
 bsnV3z3EIau8hNzkPWNLOeM9etBrJTDQVO3QQ9OPgUQnJn13H++1lCyrXg/lNOFUIeBA
 xTZLOXMu5gwKWSeFOEMOTlO22LQzBrYcp5XDT5/0hOX8J0ymDSVWASpnsvIES4wjx876
 eb6muTy2pVJuldAhs1AJ1J+FJkPw9uNL9Uql3fXYL21c8pw0CxJqtJLBqZNrciJCzn07
 AyZESXG2lj9OkWz0JDHVRYpqsEIvKwgUCpFPvEuCoYBNN7KCnPGEDHQHwH9cqThfge4J
 hCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jdQS21ydiqH5O7l4ooG/TbyIarLFdZNwCcRFXTzEwfQ=;
 b=QtSgbq8YbMcrx30+oV7Eh3F/Lsr/yDhXg7kEHUJLe6K61nJhxeAOz78ZLs3gVJe6vD
 P/NIuO+l955kKWZ1XNMfmFRc713gqMiT/TjPXQRJd//9YX0C2QmcLSqSWtgDIXbcghEM
 QBa1UR5cnS7lEjjtn7cs+N+tPXqNiX73H/RDMvVh4n55uMYZFm/EJEwIG4OwNTB1IlJB
 U7i+lAE0M9ZBkyE8UCAqPhgSzdE5uY02RyhhBgF4H+U/ykgTgepd69O25eniIyhYXl34
 z+OppdheFlkTR9t2syW06l1nR1+0n8CK3njf2oVLkDUR/tNo1iCb7ATJRxnqBHpuZL1E
 Ec+g==
X-Gm-Message-State: APjAAAVMhLye+uoCuJPzzLOIXYjC9IZIBYZYR1Gp0NYbcUiuhH/COLXy
 HSCuMiD+4XDJZmrw72lkdnzFev7Rt3Q=
X-Google-Smtp-Source: APXvYqzqcOHDOnTkKGQB+XSvGRU5b5uYLBPee7b0EMF3isHAsuCacEPXpVGFofwedMr3goox6AAKCQ==
X-Received: by 2002:a17:90a:22a5:: with SMTP id
 s34mr18265484pjc.8.1579441581580; 
 Sun, 19 Jan 2020 05:46:21 -0800 (PST)
Received: from localhost.localdomain
 ([2402:3a80:166b:5b82:8890:55cc:899c:7e19])
 by smtp.gmail.com with ESMTPSA id b1sm25871067pfp.44.2020.01.19.05.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jan 2020 05:46:20 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 19 Jan 2020 19:16:10 +0530
Message-Id: <20200119134610.31961-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 19 Jan 2020 14:46:26 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 19 Jan 2020 14:46:22 +0100 (CET)
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

If typedef is a known typedef (such as u8 or *_t), then label
<macro> as a CppMacro. Subsequent cases will then label <typedef>
correctly.

Following are results of --parse-c on the Linux Kernel v5.5-rc4:

Before:

  nb good = 18956150,  nb passed = 134061 =========> 0.70% passed

After:

  nb good = 18956150,  nb passed = 134062 =========> 0.70% passed

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parsing_hacks.ml | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/parsing_c/parsing_hacks.ml b/parsing_c/parsing_hacks.ml
index 8374731b..23d675cf 100644
--- a/parsing_c/parsing_hacks.ml
+++ b/parsing_c/parsing_hacks.ml
@@ -2184,6 +2184,41 @@ let lookahead2 ~pass next before =
       && ok_typedef s && is_macro s2 && is_type type_
         ->
 	  TIdent (s, i1)
+
+  (* xx yy zz : xx is a macro *)
+  | (TIdent (s, i1)::TIdent (s2, i2)::TIdent(_,_)::_ , _)
+    when not_struct_enum before
+	&& ok_typedef s2
+	&& is_known_typdef s2
+        ->
+	  TCommentCpp(Token_c.CppMacro, i1)
+
+  (* xx yy zz : xx is a typedef ident *)
+  | (TIdent (s, i1)::TIdent (s2, i2)::TIdent(_,_)::_ , _)
+    when not_struct_enum before
+	&& ok_typedef s
+        ->
+      msg_typedef s i1 2; LP.add_typedef_root s i1;
+      TypedefIdent (s, i1)
+
+  (* xx yy * zz : xx is a macro *)
+  | (TIdent (s, i1)::TIdent (s2, i2)::ptr , _)
+    when pointer ~followed_by:(function TIdent _ -> true | _ -> false) ptr
+	&& not_struct_enum before
+	&& ok_typedef s2
+	&& is_known_typdef s2
+        ->
+	  TCommentCpp(Token_c.CppMacro, i1)
+
+  (* xx yy * zz : xx is a typedef ident *)
+  | (TIdent (s, i1)::TIdent (s2, i2)::ptr , _)
+    when pointer ~followed_by:(function TIdent _ -> true | _ -> false) ptr
+	&& not_struct_enum before
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
