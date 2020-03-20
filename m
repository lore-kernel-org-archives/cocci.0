Return-Path: <SRS0=15MF=5F=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0F3C4332D
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:02:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA4F20774
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+sugBOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA4F20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K72Ps0022423;
	Fri, 20 Mar 2020 08:02:26 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CF585782F;
	Fri, 20 Mar 2020 08:02:24 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 62A1E782D
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:02:22 +0100 (CET)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02K72J9B000890
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:02:20 +0100 (CET)
Received: by mail-pj1-x1042.google.com with SMTP id j20so2064783pjz.0
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 00:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QOy2P7xnZeB942CElSaWOrvf5AZZ+z5sEgbUodzwkbY=;
 b=E+sugBOL7VvarLIyTQ9NvrZCGdF3Wf48LyPCNJQ8248ikJL7DPydbj2WhuL6gqW/P+
 1XLm/2fFYmVJQAq8Ab0HIMUgxf3W1jUbIM1ALFksaLy50lwGzkfLXaqscqr2SI4WNsS8
 qSeIdKPS9lXqiKCkYuMHYqF1nDoY3G70CEVdIHlpYf3HdhtzZzP7szk4nH6vcPVSmtjk
 jS/q5O54DMLDWRzM7nZNZ9kNrgMiDc+dDKN7DMoYKAHsVhjg09CASYDGPhQiJHLddYor
 V9xj9T2ynwxtnL+HrNIPozkjBISRFhAdVOzncDWPXGTVZnvsrazqyPjEcoarFP8mha7i
 rfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QOy2P7xnZeB942CElSaWOrvf5AZZ+z5sEgbUodzwkbY=;
 b=PUKkuUlTSUSWuUEsCEUo+9nrWB85BzSIDeDaJkCpgddMCAK2mXSW5Za31Rx7gayz6b
 pggkLzXkChyUfnYi5BOYMmOFSd4sP0p+6dyQj0qU/HacHFyqecskZ2pt22ZMOL4IgVLa
 jY6HTjwNQD3w6x8GPHUosDymd8K40wgxlgXZV9PDD4GHdmBVkLGLNl6IGft12aHepKjR
 NVPreDkQdJGM4TmTa7U2FuhvpOFp3/Uzerrz5zC5cE//68J276lKYZ/QI2IpUcmzM6h/
 jHXiSA73FOOWrnkzls2v2+vgbMdOWJI8RLDb6bO68Wky0f3N+BALqHa9ztYdvEbSq0TG
 Yrig==
X-Gm-Message-State: ANhLgQ13X/1EmG1GUjWFVLvqGfVsm43Y/60NlFL7TEHEuZRqJq2EdKYQ
 eQ9QK8R5CRMJePkv/LfgRnX8OoJx
X-Google-Smtp-Source: ADFU+vsC1RiJReC7zceZvoDJ+Te7NqL0OEVJe3GJp8kGUOPiZZPfl/LKuBYSxmUNFu1xW1ZV/Q290A==
X-Received: by 2002:a17:90a:fa11:: with SMTP id
 cm17mr8059861pjb.78.1584687738952; 
 Fri, 20 Mar 2020 00:02:18 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2190:a751:deeb:c09d:833a:659d])
 by smtp.gmail.com with ESMTPSA id l11sm3941232pjy.44.2020.03.20.00.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 00:02:18 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 20 Mar 2020 12:31:33 +0530
Message-Id: <20200320070157.4206-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
References: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 08:02:26 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Mar 2020 08:02:21 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 02/26] parsing_cocci: AST: Add ParenType and
	FunctionType to SmPL ASTs
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

ParenType and FunctionType are types present in the C AST that
are not present in the SmPL AST. In the pursuit of aligning
both the C and SmPL ASTs, add these types to the SmPL ASTs.

For a function pointer as follows:

int (*x)(params)

The SmPL AST would be as follows:

ParenType -> Pointer -> FunctionType params -> BaseType int

For an array of function pointers as follows:

int (*x[2])(params)

The SmPL AST would be as follows:

ParenType -> Array 2 -> Pointer -> FunctionType params -> BaseType int

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 ocaml/coccilib.mli           | 6 ++++++
 parsing_cocci/ast0_cocci.ml  | 3 +++
 parsing_cocci/ast0_cocci.mli | 3 +++
 parsing_cocci/ast_cocci.ml   | 3 +++
 parsing_cocci/ast_cocci.mli  | 3 +++
 5 files changed, 18 insertions(+)

diff --git a/ocaml/coccilib.mli b/ocaml/coccilib.mli
index 5a913099..e5409a97 100644
--- a/ocaml/coccilib.mli
+++ b/ocaml/coccilib.mli
@@ -2709,6 +2709,9 @@ module Ast_cocci :
       | Pointer of fullType * string mcode
       | FunctionPointer of fullType * string mcode * string mcode *
           string mcode * string mcode * parameter_list * string mcode
+      | ParenType of string mcode (* ( *) * fullType * string mcode (* ) *)
+      | FunctionType of fullType *
+          string mcode (* ( *) * parameter_list * string mcode (* ) *)
       | Array of fullType * string mcode * expression option * string mcode
       | Decimal of string mcode * string mcode * expression *
           string mcode option * expression option * string mcode
@@ -3353,6 +3356,9 @@ module Ast0_cocci :
       | Pointer of typeC * string mcode
       | FunctionPointer of typeC * string mcode * string mcode *
           string mcode * string mcode * parameter_list * string mcode
+      | ParenType of string mcode * typeC * string mcode
+      | FunctionType of typeC *
+          string mcode * parameter_list * string mcode
       | Array of typeC * string mcode * expression option * string mcode
       | Decimal of string mcode * string mcode * expression *
           string mcode option * expression option * string mcode
diff --git a/parsing_cocci/ast0_cocci.ml b/parsing_cocci/ast0_cocci.ml
index 77dc46f0..0acbeaa4 100644
--- a/parsing_cocci/ast0_cocci.ml
+++ b/parsing_cocci/ast0_cocci.ml
@@ -203,6 +203,9 @@ and base_typeC =
   | FunctionPointer of typeC *
 	          string mcode(* ( *)*string mcode(* * *)*string mcode(* ) *)*
                   string mcode (* ( *)*parameter_list*string mcode(* ) *)
+  | ParenType       of string mcode (* ( *) * typeC * string mcode (* ) *)
+  | FunctionType    of typeC *
+                  string mcode (* ( *) * parameter_list * string mcode (* ) *)
   | Array           of typeC * string mcode (* [ *) *
 	               expression option * string mcode (* ] *)
   | Decimal         of string mcode (* decimal *) * string mcode (* ( *) *
diff --git a/parsing_cocci/ast0_cocci.mli b/parsing_cocci/ast0_cocci.mli
index 274c6bc2..33bd12b2 100644
--- a/parsing_cocci/ast0_cocci.mli
+++ b/parsing_cocci/ast0_cocci.mli
@@ -194,6 +194,9 @@ and base_typeC =
   | FunctionPointer of typeC *
 	          string mcode(* ( *)*string mcode(* * *)*string mcode(* ) *)*
                   string mcode (* ( *)*parameter_list*string mcode(* ) *)
+  | ParenType       of string mcode (* ( *) * typeC * string mcode (* ) *)
+  | FunctionType    of typeC *
+                  string mcode (* ( *) * parameter_list * string mcode (* ) *)
   | Array           of typeC * string mcode (* [ *) *
 	               expression option * string mcode (* ] *)
   | Decimal         of string mcode (* decimal *) * string mcode (* ( *) *
diff --git a/parsing_cocci/ast_cocci.ml b/parsing_cocci/ast_cocci.ml
index ba6ec29e..f8e6dee6 100644
--- a/parsing_cocci/ast_cocci.ml
+++ b/parsing_cocci/ast_cocci.ml
@@ -343,6 +343,9 @@ and base_typeC =
   | FunctionPointer of fullType *
 	          string mcode(* ( *)*string mcode(* * *)*string mcode(* ) *)*
                   string mcode (* ( *)*parameter_list*string mcode(* ) *)
+  | ParenType       of string mcode (* ( *) * fullType * string mcode (* ) *)
+  | FunctionType    of fullType *
+                  string mcode (* ( *) * parameter_list * string mcode (* ) *)
   | Array           of fullType * string mcode (* [ *) *
 	               expression option * string mcode (* ] *)
   | Decimal         of string mcode (* decimal *) * string mcode (* ( *) *
diff --git a/parsing_cocci/ast_cocci.mli b/parsing_cocci/ast_cocci.mli
index 5f21664b..7fb54e4d 100644
--- a/parsing_cocci/ast_cocci.mli
+++ b/parsing_cocci/ast_cocci.mli
@@ -325,6 +325,9 @@ and base_typeC =
   | FunctionPointer of fullType *
 	          string mcode(* ( *)*string mcode(* * *)*string mcode(* ) *)*
                   string mcode (* ( *)*parameter_list*string mcode(* ) *)
+  | ParenType       of string mcode (* ( *) * fullType * string mcode (* ) *)
+  | FunctionType    of fullType *
+                  string mcode (* ( *) * parameter_list * string mcode (* ) *)
   | Array           of fullType * string mcode (* [ *) *
 	               expression option * string mcode (* ] *)
   | Decimal         of string mcode (* decimal *) * string mcode (* ( *) *
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
