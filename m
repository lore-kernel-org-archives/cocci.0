Return-Path: <SRS0=cw0N=6I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA85C55186
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B3B220724
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/z9lpS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3B220724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03O9JjTR006764;
	Fri, 24 Apr 2020 11:19:45 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1A2437827;
	Fri, 24 Apr 2020 11:19:45 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7BDE47815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:43 +0200 (CEST)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03O9JfBv009462
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:42 +0200 (CEST)
Received: by mail-pf1-x441.google.com with SMTP id r14so4531588pfg.2
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 02:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bchYLZbBNBNBSZIJ1iCVYfzqRcCaJHzrdjElwsP08aM=;
 b=W/z9lpS7U4/EjKSDqT+m/0sRTxFDScOFrQzBLniiLx5Sx2d8A1HgIQbkyiQLIwbGQz
 pYr96neiIqoR+ANd9UtsjtA/0aiWf37KM3hiHCbR5SH482D1QdvLsntD4F6UvdPpCI5/
 KqpZ+EmsRDqt7Mmi/geSLEV2u1xAthqJhjRrv0GpSWUgQZwZv/X9+1lW6pFl4OA+hGv/
 tWtlQFVlcfb3wTA1sf2SjFdJzdP4TwkAAObk9PAeDpQu0Z+nNzrhoUIwtuIPuH596Ovi
 I9TNcYeG+Ggh8e1OBIyoXw0psu4MPOAevoz8XxANrx0pYmIgwBlNF1SkSadlUSa7TN26
 1Tyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bchYLZbBNBNBSZIJ1iCVYfzqRcCaJHzrdjElwsP08aM=;
 b=P2EITRUiIq8BRkDKlrEO09NgQpnifvawVyaMfc11kMFz190gmdP+HSaplFLuVTEgT1
 M5dj1kZVGnsuO52zEOsU68+FAiQuy3R49Ey1L+Cjq1V2lKHF0X+3nNlOpJ3q4pm/uCRO
 rl7Xvq6uqDsLPEM09/ivvAupCJBX6SiygeIQ23U0doWITlYwX/T+d3SabHwzeZYObvbI
 12owXPzO6rNpBgkPzmtqFxHsbLtsbVexBIGBmkjQk0+1drnm/Ft1XEuWnD/ZWzcSruG/
 v40R43+mN41O88oB8yHg8aIBM6oURVI5CZCAXxCpG6wEIqd6EPhKIcvwMdDFF8nJ1fv2
 n0/A==
X-Gm-Message-State: AGi0Puacqj2jV4HQE/AT2Yi9XLWcBF7q3Sa+dE/6ZWeosO0xXjuUGL85
 uXw8iACJ9cUVJd0U3Z/lJIcH5P8jrss=
X-Google-Smtp-Source: APiQypJT7FcSzYE8ePAoC4SuP+49dh+5wK/Gdxxo+PifIJT+FeqUdTePx3bf1mh39aMfXkKdZwbMFw==
X-Received: by 2002:a63:1644:: with SMTP id 4mr3602556pgw.444.1587719981018;
 Fri, 24 Apr 2020 02:19:41 -0700 (PDT)
Received: from localhost.localdomain ([1.38.216.60])
 by smtp.gmail.com with ESMTPSA id c80sm5043933pfb.82.2020.04.24.02.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 02:19:40 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 24 Apr 2020 14:47:55 +0530
Message-Id: <20200424091801.13871-20-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
References: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 11:19:45 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 24 Apr 2020 11:19:43 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [RFC PATCH 19/25] cocci: Add parameter attributes to C AST
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

With extended support of attributes, parameter attributes are needed in
the C AST so that the nocast test case does not break.

Add the p_attr field to parameter in the C AST.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 ocaml/coccilib.mli  | 1 +
 parsing_c/ast_c.ml  | 1 +
 parsing_c/ast_c.mli | 1 +
 3 files changed, 3 insertions(+)

diff --git a/ocaml/coccilib.mli b/ocaml/coccilib.mli
index b95f2632..0e807c9a 100644
--- a/ocaml/coccilib.mli
+++ b/ocaml/coccilib.mli
@@ -109,6 +109,7 @@ module Ast_c :
       p_namei : name option;
       p_register : bool wrap;
       p_type : fullType;
+      p_attr : attribute list;
     }
     and typeQualifier = typeQualifierbis wrap
     and typeQualifierbis =
diff --git a/parsing_c/ast_c.ml b/parsing_c/ast_c.ml
index a328e661..f25f9b55 100644
--- a/parsing_c/ast_c.ml
+++ b/parsing_c/ast_c.ml
@@ -287,6 +287,7 @@ and fullType = typeQualifier * typeC
         { p_namei: name option;
           p_register: bool wrap;
           p_type: fullType;
+          p_attr: attribute list;
         }
         (* => (bool (register) * fullType) list * bool *)
 
diff --git a/parsing_c/ast_c.mli b/parsing_c/ast_c.mli
index 555a82e5..8923a335 100644
--- a/parsing_c/ast_c.mli
+++ b/parsing_c/ast_c.mli
@@ -73,6 +73,7 @@ and parameterType = {
   p_namei : name option;
   p_register : bool wrap;
   p_type : fullType;
+  p_attr : attribute list;
 }
 and typeQualifier = typeQualifierbis wrap
 and typeQualifierbis = { const : bool; volatile : bool; }
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
