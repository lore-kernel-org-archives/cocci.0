Return-Path: <SRS0=43Z/=6Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8035FC47255
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B9620720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAHF4eLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B9620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA9V4T001100;
	Mon, 11 May 2020 12:09:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 71BB13E6B;
	Mon, 11 May 2020 12:09:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E47A73DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:09:29 +0200 (CEST)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA9SSI016939
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:09:29 +0200 (CEST)
Received: by mail-pg1-x542.google.com with SMTP id a4so4358682pgc.0
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tnmadx4ChwXWJFTYu0SdF/be9OfsuCxM51pURrHXSuQ=;
 b=IAHF4eLlbjiId+201+2fZ2vwo3Ae8ah9/vZdAiU8Qj724U1skQQV82SSQttsEqxiOm
 1jbMBJUGeAWLs7aVZB5hSa9Qfib5i8xO3WW8cSYrMNC1/C5Dj2PIxKqh103ddy3xmVFY
 gqbv5T4hknwd5gbok34wozQRt44AOdt4e/gycBJF2HIAFyIE4l44ih9Htv4OPUVuRDy2
 GKVTgRzf7qjHCmV9weHiXs3QvHFacqRMx0ZsZfWWtIEtTkNeH8Lv9pCkUfvPi+8iKyrP
 xHYJcjG3JENeUZgZJ2HoCuvCZTQeytrIHda212GFEI8kQhB0sTGx0GiUmZE4KUbJclXc
 2X8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tnmadx4ChwXWJFTYu0SdF/be9OfsuCxM51pURrHXSuQ=;
 b=KWa5hAGiI5ybLM2o/2mlbVVZG0gpf2OJ7QWCCcKUS3xde+WAQh+hAKx5czg0gAJyne
 HCBFe2FiC26FV/g43kTF6SVrkNRVN1X9jEzNYApwL4B0ptbRHOjZrkbaea5dhRDjwK3H
 ztCvB5YZhb0/vQh+eOL+2UUf25QYR0G4GmPZo7BiNatwRmFxHGw1Dbk738YzTEg9Goy9
 +5hpf+PLb83iS2dn0CYoti92D6H+XHraYyGymI2UHMnLkKQYwIEhvCtm7ZnoLSEKp4Ah
 PpbnkSMufNJcrsBr+fyrCJBs4pfG3jEW4iw4xoobyLFLWDJVb0M/X+2DVYVFbHPrgQfv
 V+2A==
X-Gm-Message-State: AGi0PuaH78WKXI6CWHHFfeU99nP3wdmTzqhQkWCuDQ/3K+lJgWEVrjqG
 ts+LrWFus5J/g5XSqtuXBEo88OpE4Fo=
X-Google-Smtp-Source: APiQypI7cpXU1X0EEk0VX5oNWZRaw8z/D8HMApDgODhGcXYEqCkI9SR6ayjV9tz0rq8c6QgFOHn+qA==
X-Received: by 2002:a63:1d4:: with SMTP id 203mr13405381pgb.74.1589191767518; 
 Mon, 11 May 2020 03:09:27 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:09:27 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:37:11 +0530
Message-Id: <20200511100715.19819-29-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:09:31 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:09:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 28/32] ocaml: coccilib: Reflect Cast attributes
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

Cast attributes are added to the C and SmPL ASTs. Reflect these changes
in coccilib.mli.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 ocaml/coccilib.mli | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ocaml/coccilib.mli b/ocaml/coccilib.mli
index a305d616..ab583c1d 100644
--- a/ocaml/coccilib.mli
+++ b/ocaml/coccilib.mli
@@ -146,7 +146,7 @@ module Ast_c :
       | RecordPtAccess of expression * name
       | SizeOfExpr of expression
       | SizeOfType of fullType
-      | Cast of fullType * expression
+      | Cast of fullType * attribute list * expression
       | StatementExpr of compound wrap
       | Constructor of fullType * initialiser
       | ParenExpr of expression
@@ -2569,7 +2569,7 @@ module Ast_cocci :
       | ArrayAccess of expression * string mcode * expression * string mcode
       | RecordAccess of expression * string mcode * ident
       | RecordPtAccess of expression * string mcode * ident
-      | Cast of string mcode * fullType * string mcode * expression
+      | Cast of string mcode * fullType * attr list * string mcode * expression
       | SizeOfExpr of string mcode * expression
       | SizeOfType of string mcode * string mcode * fullType * string mcode
       | TypeExp of fullType
@@ -3305,7 +3305,7 @@ module Ast0_cocci :
       | ArrayAccess of expression * string mcode * expression * string mcode
       | RecordAccess of expression * string mcode * ident
       | RecordPtAccess of expression * string mcode * ident
-      | Cast of string mcode * typeC * string mcode * expression
+      | Cast of string mcode * typeC * attr list * string mcode * expression
       | SizeOfExpr of string mcode * expression
       | SizeOfType of string mcode * string mcode * typeC * string mcode
       | TypeExp of typeC
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
