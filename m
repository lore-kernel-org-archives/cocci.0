Return-Path: <SRS0=sKaj=25=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B84DC282DD
	for <cocci@archiver.kernel.org>; Wed,  8 Jan 2020 15:06:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E3D62067D
	for <cocci@archiver.kernel.org>; Wed,  8 Jan 2020 15:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPuQ83UW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3D62067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 008F63rE023880;
	Wed, 8 Jan 2020 16:06:03 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5367677DB;
	Wed,  8 Jan 2020 16:06:03 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 104097718
 for <cocci@systeme.lip6.fr>; Wed,  8 Jan 2020 16:06:02 +0100 (CET)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 008F5ufb027156
 for <cocci@systeme.lip6.fr>; Wed, 8 Jan 2020 16:05:56 +0100 (CET)
Received: by mail-pf1-x441.google.com with SMTP id n9so1750829pff.13
 for <cocci@systeme.lip6.fr>; Wed, 08 Jan 2020 07:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mUwJ27XEFpUuBXgMRS/BEIIAe4hyJ5l1iuWvozEVZ6U=;
 b=dPuQ83UWydIqsWeSchcRRy05lexLKAJQxOaDOmHV67/vUo0qZgjPZ3zkI0Hkp51WFT
 t6kLq+i+ylXpJY5sfrKHpZ5yvjGlnxShRumYMajf/k4l9Se+q2YESIUC3sKccpdmWvKm
 Pr4nYzAPFxQy1uRWfAt+2aOI9CSDsQ7um6YgQMcbTocGLJDRx/c2aZr4AnKpEBiD5LpJ
 vkVgoamKZFGJYTRcSj2Wevl3so+oGQIh3Us5DSxTbdYSEG0EGReojSNbDgVVegT0SlJ+
 6I4W26tpHiKDnr+SavNPD69Wk5Gshy1FYO8xpgaHMmdEOxvBFVONuXL/rGZFrMIWFXOU
 X+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mUwJ27XEFpUuBXgMRS/BEIIAe4hyJ5l1iuWvozEVZ6U=;
 b=okd9DTJT9Jlstd1IKWTZyKnbYxNkIqlEoWzWt++bKTzDzGO/Ey+Y465061ARNQE8UT
 ifeLwFvYRL5JrJP025i2N1tIhGYwsHqms73YpdwYpmivU0F51G/31631kMJmaK/95VuV
 t3cMGN2EVwXyLPT+o7KhdHeRFzhnj8cl0QnFwof3HNoxGqHSLquuLawHbv3LPr+bfzJ6
 yaZvkhAMvKRpQIJQZKiQlqzHR5pNYS3+N6ikxRnEi10rhhiCj0HNadX8FyABE/Z277kG
 roVFvzVzrsc4Ah/vVsGZNyGXUKCMM0WVEXv5H6Yhd2rZa0Fpdj9CuPva7epZqsGqdZ4x
 g8ww==
X-Gm-Message-State: APjAAAW8YR8+zeRRcpCFnysXiJ5KY9LZl4zNGObrIu0xTxwNEgD54f4C
 2RfgpUy8gKK1oZX0Aa8WtudgSH3sY78=
X-Google-Smtp-Source: APXvYqykSMYgSd5K55qxQI3Y4D6Yabu9lKEy+aBE8e00zyETqHIkaJFZ4yTSW55KznAU4ue8BJgf5Q==
X-Received: by 2002:a63:d108:: with SMTP id k8mr5567009pgg.434.1578495955555; 
 Wed, 08 Jan 2020 07:05:55 -0800 (PST)
Received: from localhost.localdomain
 ([2402:3a80:166c:23ca:1508:1c17:9fe8:b5e0])
 by smtp.gmail.com with ESMTPSA id 3sm149584pjg.27.2020.01.08.07.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 07:05:55 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Wed,  8 Jan 2020 20:35:18 +0530
Message-Id: <20200108150518.6241-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 08 Jan 2020 16:06:03 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 08 Jan 2020 16:05:56 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org
Subject: [Cocci] [PATCH] parsing_c: Handle case of annotation in function
	proto/def
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

[const_vol] <type> [ptr] <annotation> <identifier> <open_par>

The lookahead function in Parsing_hacks would mislabel <annotation> as a
CppDirective, causing pretty printing errors.

Add a case in the lookahead function for handling this case.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parsing_hacks.ml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/parsing_c/parsing_hacks.ml b/parsing_c/parsing_hacks.ml
index 43421647..3f031f21 100644
--- a/parsing_c/parsing_hacks.ml
+++ b/parsing_c/parsing_hacks.ml
@@ -2066,6 +2066,20 @@ let lookahead2 ~pass next before =
 	&& is_type type_ ->
 	  TCommentCpp (Token_c.CppDirective, i1)
 
+        (* tt xx yy ( : xx is an annot *)
+  | (TIdent (s, i1)::TIdent (s2, i2)::TOPar _::_, seen::_)
+    when LP.current_context () = LP.InTopLevel
+	&& (is_struct_enum before || is_type seen)
+	&& s ==~ regexp_annot ->
+	  TCommentCpp (Token_c.CppMacro, i1)
+
+        (* tt * xx yy ( : xx is an annot *)
+  | (TIdent (s, i1)::TIdent (s2, i2)::TOPar _::_, ptr)
+    when LP.current_context () = LP.InTopLevel
+	&& pointer ptr
+	&& s ==~ regexp_annot ->
+	  TCommentCpp (Token_c.CppMacro, i1)
+
 	(* tt xx yy; : yy is an annot *)
   | (TIdent (s, i1)::(TPtVirg _|TEq _)::_, TIdent (s2, i2)::type_::rest)
     when (is_struct_enum (type_::rest)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
