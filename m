Return-Path: <SRS0=Bmfd=ZL=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413FEC43215
	for <cocci@archiver.kernel.org>; Tue, 19 Nov 2019 09:35:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B51522303
	for <cocci@archiver.kernel.org>; Tue, 19 Nov 2019 09:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2TNBod+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B51522303
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAJ9ZRoY017863;
	Tue, 19 Nov 2019 10:35:27 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E173874EC;
	Tue, 19 Nov 2019 10:35:26 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 245FB24C6
 for <cocci@systeme.lip6.fr>; Tue, 19 Nov 2019 10:35:25 +0100 (CET)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAJ9ZKwO018104
 for <cocci@systeme.lip6.fr>; Tue, 19 Nov 2019 10:35:20 +0100 (CET)
Received: by mail-pj1-x1042.google.com with SMTP id a16so2447088pjs.13
 for <cocci@systeme.lip6.fr>; Tue, 19 Nov 2019 01:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=C5Xd4M81fImO3/kEvtaMUcgFwYoI1za0ht4Hkwi0Pas=;
 b=t2TNBod+gT6gy5nr335xeqzR678kaEZH7MmuWg7ax6S/VYsz7RxhUOINJP1qPNaATK
 EdGJWGe+Af4fv9+2/GVqd3f+ma7rDyQgKikTcHDCpkiUeXXoWO1byT1xyEJ/A/GgXbUZ
 ONy54QNJEFFSZO/mYhlzTnBc/F+KOP9iXvSV7/WKPkejUKWKaR05NQOcU7Eza+AMFsOZ
 3sOuXEbye9hD5Tju1S5M8hhWiOqsq1j7Ovn1MgCYllgZPOii3Q7OoWfQ+agUPSTOylOP
 4F6JoP2YYgU+OLABN0q0mzIuyTDqgq7jrqGyjEMw3JSBouENduSZNWOKjMe9yt4Omwi0
 n5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=C5Xd4M81fImO3/kEvtaMUcgFwYoI1za0ht4Hkwi0Pas=;
 b=BCH3tZET6ZhkZmmCj9+w/JbJsuoYSV36nzcpcZTX86rmriBeegD3x52rNX2TIwFQY3
 Q/xJE5mWwayb00sKC+HKwBzeZ6V/Ik3lCa2WuKuJLFUOdZwA2SDcCF0XkFeyU+iAx1e6
 W5BB49lM+83KHfNetuLnPnOtAwW4XaJiQ3Ls7K2RiCwiz9EKpEaclhqLYUAeEeuN0U0x
 JVFGWFVs38RVBiqLpQfoWm/h1cfS7FVkZ1vmk71A7x3CjuFL+fo+ONeIwxUKupGtoj4s
 /mQjV9m/yK0zLMdN+dAYDjmiJar1fx2dxc/UAJYjoit8TUwDKN+qU6IKEphmZa+yqKSJ
 x5hA==
X-Gm-Message-State: APjAAAVE3ubR6qRqiwihfcnZ37j9Z5jR2cnZv01HreIJnejmvHTAgJH8
 t3RfanPqFsjoxcVmodJ6j+ovoOo30iI=
X-Google-Smtp-Source: APXvYqxXoXqEz1ufn4CCX5LFA6C1yC6sJ72v5Vf8S/DMLsouB+JgknLi3fYbpsaaScZ5lvsXvpgb8A==
X-Received: by 2002:a17:902:900b:: with SMTP id
 a11mr32678325plp.116.1574156119022; 
 Tue, 19 Nov 2019 01:35:19 -0800 (PST)
Received: from localhost.localdomain ([1.38.144.63])
 by smtp.googlemail.com with ESMTPSA id 83sm23636616pgh.86.2019.11.19.01.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2019 01:35:18 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 19 Nov 2019 15:04:07 +0530
Message-Id: <20191119093407.23603-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 19 Nov 2019 10:35:28 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 19 Nov 2019 10:35:20 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH] parsing_c: handle space and ctx newline around
	minus toks
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

Handle the following case:

	space + minus + context newline

In this case, the space should be dropped except if it is followed
by any newline. This should be done just before the minus tokens
are removed from the token stream.

This is useful for situations like the following. Here, the space next to
the right paranthesis should be dropped:

	if(a)
	-{
	-result = b;
	goto c;
	-}

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/unparse_c.ml | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/parsing_c/unparse_c.ml b/parsing_c/unparse_c.ml
index 778a59ab..c6478c5a 100644
--- a/parsing_c/unparse_c.ml
+++ b/parsing_c/unparse_c.ml
@@ -1300,21 +1300,28 @@ let rec drop_space_at_endline = function
     drop_space_at_endline rest
   | ((T2(Parser_c.TCommentSpace _,Ctx,_i,_h)) as a)::rest ->
     let (outer_spaces,rest) = span is_space rest in
-    let minus_or_comment_or_space_nocpp = function
-      | (T2(Parser_c.TCommentNewline _,_,_i,_)) -> false
-      | T2(_,Min adj,_,_) -> true
-      | (T2(Parser_c.TCommentSpace _,Ctx,_i,_)) -> true
+    let match_till_context_nl = function
+      | (T2(Parser_c.TCommentNewline _,_,_i,_) :: _) -> false
+      | (T2(_,Min adj,_,_) :: _) -> true
       | x -> false in
-    let (minus,rest) = span minus_or_comment_or_space_nocpp rest in
-    let fail _ = a :: outer_spaces @ minus @ (drop_space_at_endline rest) in
-    if List.exists is_minus minus
+    if match_till_context_nl rest
     then
-      match rest with
-      | ((T2(Parser_c.TCommentNewline _,Ctx,_i,_h)) as a)::rest ->
-        (* drop trailing spaces *)
-        minus @ a :: (drop_space_at_endline rest)
-      | _ -> fail ()
-    else fail ()
+      let minus_or_comment_or_space_nocpp = function
+        | (T2(Parser_c.TCommentNewline _,Ctx,_i,_)) -> false
+        | T2(_,Min adj,_,_) -> true
+        | (T2(Parser_c.TCommentSpace _,Ctx,_i,_)) -> true
+        | x -> false in
+      let (minus,rest) = span minus_or_comment_or_space_nocpp rest in
+      let fail _ = a :: outer_spaces @ minus @ (drop_space_at_endline rest) in
+      if List.exists is_minus minus
+      then
+        match rest with
+        | ((T2(Parser_c.TCommentNewline _,Ctx,_i,_h)) as a)::rest ->
+          (* drop trailing spaces *)
+          minus @ a :: (drop_space_at_endline rest)
+        | _ -> fail ()
+      else fail ()
+    else a :: outer_spaces @ (drop_space_at_endline rest)
   | a :: rest ->
     a :: drop_space_at_endline rest
 
-- 
2.21.0

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
