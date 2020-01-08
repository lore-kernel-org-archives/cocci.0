Return-Path: <SRS0=sKaj=25=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837E0C33CA1
	for <cocci@archiver.kernel.org>; Wed,  8 Jan 2020 11:32:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A89206DB
	for <cocci@archiver.kernel.org>; Wed,  8 Jan 2020 11:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNX63wCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A89206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 008BVeWJ008145;
	Wed, 8 Jan 2020 12:31:40 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9434D77DB;
	Wed,  8 Jan 2020 12:31:40 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D15D77718
 for <cocci@systeme.lip6.fr>; Wed,  8 Jan 2020 12:31:38 +0100 (CET)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 008BVXPL009748
 for <cocci@systeme.lip6.fr>; Wed, 8 Jan 2020 12:31:33 +0100 (CET)
Received: by mail-pj1-x1042.google.com with SMTP id s7so956752pjc.0
 for <cocci@systeme.lip6.fr>; Wed, 08 Jan 2020 03:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mmpGWOZDYQ5ojK2uvdV+A7iyhXIqlE+RBSaDjGZtHUY=;
 b=TNX63wCrk6mNjQmg9sqVJXkzXyOs7JhMVG5hZRIxVlVkI0anwd0k0x/XyVDK/MPo5b
 lt0TWV2o9FvG6Pl4gx/+8F8ltUHMGAjM8fw1FzMiVTMAQdcSboilbpxY1SVytKuvASEV
 2ZXnwAWVc+b7yLgRxh66Z/WWnaboXW0CGphwesc4tIXIlfIKjSKpZSUgAi0eVWoc0DgM
 FcBPF+vLC/G9KtPO9Zm1HWImH/ZagYK+vjnx1p2ITa0nWM5jH/0f0tEM2FH2+9q4OL5V
 juaRN5XoYldZoTl4zXDkqoH/Q9b5ap6v2/ysW8zVfVXGsRv2VVr7JYwMSlmn0ER2eZSS
 /XXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mmpGWOZDYQ5ojK2uvdV+A7iyhXIqlE+RBSaDjGZtHUY=;
 b=aEWBDL68h/AENfggDLvDlD+q6wZPHpgN9Z4JORcS7d4PcbCqf2mRncEBWeMcGyoUXm
 w7uPJE2f37hfgdVo2cAEKIwvFqbxoUNYE01kzaRVUdg/su9kIpCbQNxnK6ohFUYtRflW
 VbYZim2tuAReSAQ4noKvs3WyzYudSZpS/cq4WKwWGk1XTCjR6ijx0Yk1pcScQNPBSmpg
 7qwqiAgG9ulhPHxb8ZEZ4e77h4kyLFeNNo1MOxhFvvIJhrlnC9ZrkQcIgSzQu0x3H/CP
 ZLMAB4xr19zVT67t+xyd+neq7shpMp+vnBaJ2dMAjGLG4g0GJUj+UeeM01ZEs287i2Qt
 7TLw==
X-Gm-Message-State: APjAAAVayYTMmFEc1Z4qmKgygmAFLqGo/aplmInx9pOLdUZwbcLsoIzz
 6lQc/XzLk/6ayQG0gaHFn0bPej6s
X-Google-Smtp-Source: APXvYqwzZIL1LGhOIVMeAzHippgyJC3n6ZDHdul5qRLHRW/oiDJfvwIbdoP86hAkNZ+t4sPXPiG2rQ==
X-Received: by 2002:a17:902:d902:: with SMTP id
 c2mr4590852plz.298.1578483092431; 
 Wed, 08 Jan 2020 03:31:32 -0800 (PST)
Received: from localhost.localdomain
 ([2402:3a80:1676:e740:1cd3:2fce:2b3d:8fee])
 by smtp.gmail.com with ESMTPSA id c1sm3314747pfo.44.2020.01.08.03.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 03:31:31 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Wed,  8 Jan 2020 17:01:12 +0530
Message-Id: <20200108113112.26209-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 08 Jan 2020 12:31:41 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 08 Jan 2020 12:31:33 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org
Subject: [Cocci] [PATCH] parsing_c: Handle case of annotation and ;
	or = after ident
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

[const_vol] <type> [ptr] <identifier> <annotation> <semicolon|eq>

The lookahead function in Parsing_hacks would mislabel <identifier> as a
CppDirective.

Add cases in the lookahead function for handling this case.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parsing_hacks.ml | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/parsing_c/parsing_hacks.ml b/parsing_c/parsing_hacks.ml
index 56857f3c..43421647 100644
--- a/parsing_c/parsing_hacks.ml
+++ b/parsing_c/parsing_hacks.ml
@@ -1887,6 +1887,11 @@ let not_struct_enum = function
     (Parser_c.Tstruct _ | Parser_c.Tunion _ | Parser_c.Tenum _)::_ -> false
   | _ -> true
 
+let is_struct_enum = function
+  | (Parser_c.TIdent _)::
+    (Parser_c.Tstruct _ | Parser_c.Tunion _ | Parser_c.Tenum _)::_ -> true
+  | _ -> false
+
 let not_opar = function
     TOPar _ -> false
   | _ -> true
@@ -2061,6 +2066,32 @@ let lookahead2 ~pass next before =
 	&& is_type type_ ->
 	  TCommentCpp (Token_c.CppDirective, i1)
 
+	(* tt xx yy; : yy is an annot *)
+  | (TIdent (s, i1)::(TPtVirg _|TEq _)::_, TIdent (s2, i2)::type_::rest)
+    when (is_struct_enum (type_::rest)
+	|| is_type type_)
+	&& s ==~ regexp_annot ->
+	  TCommentCpp (Token_c.CppMacro, i1)
+
+	(* tt * xx yy; : yy is an annot *)
+  | (TIdent (s, i1)::(TPtVirg _|TEq _)::_, TIdent (s2, i2)::ptr)
+    when pointer ptr
+	&& s ==~ regexp_annot ->
+	  TCommentCpp (Token_c.CppMacro, i1)
+
+	(* tt xx yy; : yy is an annot, so xx is an ident *)
+  | (TIdent (s, i1)::TIdent (s2, i2)::(TPtVirg _|TEq _)::_, seen::_)
+    when (is_struct_enum before
+	|| is_type seen)
+	&& s2 ==~ regexp_annot ->
+	  TIdent (s, i1)
+
+	(* tt * xx yy; : yy is an annot, so xx is an ident *)
+  | (TIdent (s, i1)::TIdent (s2, i2)::(TPtVirg _|TEq _)::_, ptr)
+    when pointer ptr
+	&& s2 ==~ regexp_annot ->
+	  TIdent (s, i1)
+
 	(* tt xx yy *)
   | (TIdent (s, i1)::TIdent (s2, i2)::_  , seen::_)
     when not_struct_enum before
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
