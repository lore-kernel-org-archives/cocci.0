Return-Path: <SRS0=zMkO=7T=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E343C433E0
	for <cocci@archiver.kernel.org>; Sat,  6 Jun 2020 13:54:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA31206A2
	for <cocci@archiver.kernel.org>; Sat,  6 Jun 2020 13:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAwTrfqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA31206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 056DsJgE012429;
	Sat, 6 Jun 2020 15:54:19 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D9CC95D47;
	Sat,  6 Jun 2020 15:54:18 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 75E163BAB
 for <cocci@systeme.lip6.fr>; Sat,  6 Jun 2020 15:54:17 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1043])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 056DsF1U000603
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 6 Jun 2020 15:54:16 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id i12so3831734pju.3
 for <cocci@systeme.lip6.fr>; Sat, 06 Jun 2020 06:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QFD98B05ZSExaCbo2dTU/He13s/4duWpGEACJla/iM0=;
 b=ZAwTrfqtlGdwgCpV89qAjsbuVmwtSBoDVpP7QKIV98VKZvZc6f1ULMFSJ6mtSCUg/Q
 /mWOGWIaFw1EWMGFOq/y8VJIuqE5PNTq0BzmEUUY3wdw4azSi2Y8q+yRJeC/vKt9jo0/
 +VvzWwIatzf01NotPyY1KIw1GWQgUhJbFUvHDEFWZW7MMxQDx11WR7240WS6VcE9/VRl
 vtS1dlXn4Juof/ImjZxSpWJwdUXiLkQJuXNiR0vVTYWPFmM9ofP5v4JruGGr9GAH79up
 JjJVokIEWJg+AtY0YkEeVgQvJ9te6YnYdcq4h0K1ObePsv9q8Z8/yQVikk84aV6w4HKZ
 /t2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QFD98B05ZSExaCbo2dTU/He13s/4duWpGEACJla/iM0=;
 b=REUMvrqLQpcdWgeEz3IlrmGmu167FlNjBJCqayYvNiXu8d+UgcHyt0wadj+y8dkJB4
 yo/wEJ+InSzsEpa7rE28RpHGyGijoIq/DnhFvX60Ug5ZWYjFnR88NwKHAzmhv+AEQCnW
 X9qUB65Qvh72h0LN7ggGHAsRV6n5CvclT4O8t0yJ7b+n3S7SbSi1OSzDigfpXqtpHMcR
 +pdqi/QpbdCN97S1AVJpRpaP35mt1fW9yhnb0dN/URhpbsw2rmKtNKrP6FRjRY5yrquc
 fkC7jUW99qnrgf37jqUTyjvwnNk3nw7QPDpj5/U9+9nSGzyhO9jZmIj4Nb8zOrTnt45X
 eZ0A==
X-Gm-Message-State: AOAM533hxCdjRhenYDeZTGhcb55QtgkakCB0IEVPkmnK9xngcgTpy6RR
 xVgvuojTCR+zyVveRFPUnhOEriZ5
X-Google-Smtp-Source: ABdhPJxXzUl6I6eT3mV5/KCYNXCFPgzHm/oy4FIS6Kt9bne8uwStUmo6JtxUWVgKDphB6pVaeO2zFA==
X-Received: by 2002:a17:90b:384c:: with SMTP id
 nl12mr7498778pjb.108.1591451654855; 
 Sat, 06 Jun 2020 06:54:14 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:28b:e8d7:7fc3:eb75:1ea0:39fe])
 by smtp.gmail.com with ESMTPSA id
 l4sm2062657pgo.92.2020.06.06.06.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2020 06:54:14 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sat,  6 Jun 2020 19:23:42 +0530
Message-Id: <20200606135342.12584-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529120703.31145-24-jaskaransingh7654321@gmail.com>
References: <20200529120703.31145-24-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 06 Jun 2020 15:54:19 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 06 Jun 2020 15:54:16 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v4 23/32] parsing_c: type_annoter_c: Reflect Cast
	attributes
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

Cast attributes are added to the SmPL AST. Reflect these changes in
type_annoter_c.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
Changes in v4:
- Change 't, e, a' to 't, a, e' in the Cast constructor for
  consistency

Changes in v3:
Rebase as follows:
        v3 of "cocci: Add Parameter attributes to SmPL"[2]
        v3 of "cocci: Improve C parsing of attributes"[3]
        gitlab master branch (ffb87d9d)

Changes in v2:
parsing_c: parser: Pass attribute list from type_name
- Warn about dropped attributes in typeof and sizeof productions

parsing_cocci: parser: Parse cast attributes
- Mention in commit message that cast attributes are matched anywhere
  in a cast.

parsing_cocci: arity: Reflect Cast attributes
- Apply mcode2arity on attributes as well.

parsing_cocci: visitor_ast: Visit cast attributes
- Typo in commit message (AST0 -> AST).

parsing_c: pretty_print_c: Reflect Cast attributes
- Less space in front of [

parsing_c: ast_c: Add Cast attributes
- Switch places of expression and attributes in Cast type.

parsing_c: parser: Parse Cast attributes
- Switch places of expression and attributes in Cast type.

parsing_c: pretty_print_c: Reflect Cast attributes
- Switch places of expression and attributes in Cast type.
- Change printing order of cast elements.

parsing_c: type_annoter_c: Reflect Cast attributes
- Switch places of expression and attributes in Cast type.

parsing_c: visitor_c: Visit Cast attributes
- Switch places of expression and attributes in Cast type.
- Change visitor order of cast elements.

engine: cocci_vs_c: Match Cast attributes
- Switch places of expression and attributes in C AST Cast type.

ocaml: coccilib: Reflect Cast attributes
- Switch places of expression and attributes in C AST Cast type.


 parsing_c/type_annoter_c.ml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/parsing_c/type_annoter_c.ml b/parsing_c/type_annoter_c.ml
index dfd363b2..25cb6c0e 100644
--- a/parsing_c/type_annoter_c.ml
+++ b/parsing_c/type_annoter_c.ml
@@ -525,7 +525,7 @@ let rec is_simple_expr expr =
       true
   | Binary (e1, op, e2) ->
       true
-  | Cast (t, e) ->
+  | Cast (t, a, e) ->
       true
   | ParenExpr (e) -> is_simple_expr e
 
@@ -961,7 +961,7 @@ let annotater_expr_visitor_subpart = (fun (k,bigf) expr ->
 
 
     (* -------------------------------------------------- *)
-    | Cast (t, e) ->
+    | Cast (t, a, e) ->
         k expr;
         (* todo: if infer, can "push" info ? add_types_expr [t] e ? *)
         make_info_def_fix (Lib.al_type t)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
