Return-Path: <SRS0=J+r8=6L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9322CC54FD0
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:21:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A696206B6
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/77hY4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A696206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RCLeTf017206;
	Mon, 27 Apr 2020 14:21:40 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 360AB7807;
	Mon, 27 Apr 2020 14:21:40 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 14AF17769
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:21:38 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1043])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RCLat5014326
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:21:37 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id t9so7462677pjw.0
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 05:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GYYLVUG1uEXHHk2zeWVmVA7BFjrGO/QyFUFlkFzKPn0=;
 b=V/77hY4C48yk/yuaOhDUjCmPrqnK2EIh3NQXWrsIV+FpuNkB2PlCxOMY7UBDeokrcW
 VudrBhZuzzUW+O56lBXSVTHkBcOOPKAK4//qQ+SDLfTI+kz48ngsRPIU49W9YtL+Rk7G
 x9r3jLGFkyHsf1QAFsD83HyUh9JIM8L3UKEmiGQz+E075g5myQiehblG2oHfPglu//ye
 UFvCal6zpqt1ehamauF2BMkoDKkggWIkznJiXKK55XrcQ/KDUQTm5Fg7WUGWie9gusiv
 T1/CuZsuEBfMDWlLFRMU0ETs1Pg3IaoQZzUxOhXDzgk3blBBcVKtUlFHewsLciK+E1fR
 sS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GYYLVUG1uEXHHk2zeWVmVA7BFjrGO/QyFUFlkFzKPn0=;
 b=GwtzhlcNtcsBz6uvJ+1sGi5XANJghqhz1nEexdjfUdmCuRZdpGMrWPMgy+1x9S+DpF
 4uJKrOzTYFGa5jvbaA2E/l9DdTV8C17SsFADoCC3yI21+1d+jrswOWbwml4mqqF5mOO8
 dPSzsaquWNgbt7nfIkWXaPwVxI0DUfL2CYKx3Qcw9akBmwfwwgFTQK6w29nc3c6hk3no
 2AmuJ67/P3AcMqTzUmRO2lCkW4mpHWX2la2hLYbakQy+10qOa58FqE52SjVZSbX1Wr70
 NUZcVpkhoUgjT/aMtEDTfctEk2zXHsYQY3j/C8KLc69wMDTxWTREQ4bACuQ1ddNZHCzv
 rujw==
X-Gm-Message-State: AGi0PuZM0K3Wu8NIlr4NohEp1CHx/2x3e76UcFfO9u4W6e3PUfMlY2qb
 Rjlvuukk/bZE1EBZKOM4N7NWm3RnO5w=
X-Google-Smtp-Source: APiQypL2l7Y428aP/zfI5RcZYIsmWQr3E5LbzMUpmyllNi0vt0A1vOVRcvO6hPCS3VK/31w4m0z8Sw==
X-Received: by 2002:a17:90a:7486:: with SMTP id
 p6mr23227557pjk.62.1587990095574; 
 Mon, 27 Apr 2020 05:21:35 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.114])
 by smtp.gmail.com with ESMTPSA id o198sm12424584pfg.183.2020.04.27.05.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 05:21:35 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 27 Apr 2020 17:51:13 +0530
Message-Id: <20200427122113.18442-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 14:21:40 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 Apr 2020 14:21:37 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 08/23] parsing_cocci: function_prototypes:
	Reflect Parameter attributes
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

Parameter attributes are added to the SmPL AST. Reflect these changes in
function_prototypes.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
Changes in v2:
- Removed unnecessary function name change (collect_ident_strings).

 parsing_cocci/function_prototypes.ml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/function_prototypes.ml b/parsing_cocci/function_prototypes.ml
index 71bf1a2a..966369b8 100644
--- a/parsing_cocci/function_prototypes.ml
+++ b/parsing_cocci/function_prototypes.ml
@@ -261,10 +261,10 @@ let rec attach_right strings ty =
 let rec drop_param_name p =
   Ast0.rewrap p
     (match Ast0.unwrap p with
-      Ast0.Param(p,Some id) ->
+      Ast0.Param(p,Some id,attr) ->
 	let strings = collect_ident_strings id in
 	let p = attach_right strings p in
-	Ast0.Param(p,None)
+	Ast0.Param(p,None,attr)
     | Ast0.OptParam(p) -> Ast0.OptParam(drop_param_name p)
     | p -> p)
 
@@ -297,7 +297,7 @@ let new_iname name index =
 
 let rec rename_param old_name all param index =
   match Ast0.unwrap param with
-    Ast0.Param(ty,Some id) when all ->
+    Ast0.Param(ty,Some id,attr) when all ->
       (match Ast0.unwrap id with
 	Ast0.MetaId
 	  (((_,name),arity,info,mcodekind,pos,adj),constraints,seed,pure) ->
@@ -308,7 +308,7 @@ let rec rename_param old_name all param index =
 		 ((nm,arity,info,mcodekind,pos,adj),constraints,seed,
 		  Ast0.Pure)) in
 	  ([Ast.MetaIdDecl(Ast.NONE,nm)],
-	   Ast0.rewrap param (Ast0.Param(ty,Some new_id)))
+	   Ast0.rewrap param (Ast0.Param(ty,Some new_id,attr)))
       |	_ -> ([],param))
   | Ast0.Pdots(d) ->
       let nm = (old_name,new_iname "__P" index) in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
