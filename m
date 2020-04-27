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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A71BC7C8A1
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B784120656
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsxt4Vbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B784120656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RC9GTa001594;
	Mon, 27 Apr 2020 14:09:16 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 97E947807;
	Mon, 27 Apr 2020 14:09:16 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EE71D7769
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:14 +0200 (CEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:443])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RC9DIi019670
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:14 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id y25so8921039pfn.5
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZyzlIWNwdkp9Rh6rKkpnyNaMorCGqrIfrYY1rTdq+DE=;
 b=jsxt4VbvC+H7KB+fFg0PHPvFz2RZWIW5bY9/LP+PsGCnt5CasL+zQ3nEafBePBes4n
 niy/9CLCiCxa/OQfzn+0XwqdrsHrhD0+m0rS2YmpMij8IOFB42gkYTxDG1GTo6dFI7zt
 +oGMUnUXKJqBAxnrK1yAoUizHoAa6vHrqAYx+DUo7R41kbqM2B/AWJ5qw8b3D3S3bxAa
 K/HXT1jiWnannVDBOvvoTWJJgFqcVoO6bE7c3W6PP0iL/9yhXe/MG1E7X79seCswIFnz
 CsCftxUgXhA0DmQWEn0j09dIs26MnnWY/R+big23xnmW2Tp7v2tUJmHP/EBcJf5gKJto
 mUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZyzlIWNwdkp9Rh6rKkpnyNaMorCGqrIfrYY1rTdq+DE=;
 b=hmIGv/vVwGUTaElucPey2COk/G9MMrk+h8zcDd+BkFG9lUMwVW3WEhztVaQae89vVL
 uxSLwZnzbp+w/3Q8T9PJBvDfFK1wsFpV4OGx8xnzGFix94H03JBbW6owcllJmT9mVAsz
 Cc1H7FhRDhyOWshZMzb27TY/cpWjBt16CfERHxRlx+iMhRcjFfSrtC33c413IocI/rVh
 W1ftZbxqkWH1o/dB/CvDy/cbTFfg5KjIvHdooMw9k2+Hi79s+LHkhc9oRs4Rdv6rPpK4
 YNrIawexDUeGfY6W7HNFJCmqWF30MxPlyipLqfEnKtuTdvOSn0t9wAmkCC6TXA+k/a6s
 zACw==
X-Gm-Message-State: AGi0PuasMV9GCmfTyYwOCAc8QtPiRhP9yCn7XuRcb3XAkkXyE68D3bpP
 nKElovof0Nqrr6tRDTGvxREvB3xwCMo=
X-Google-Smtp-Source: APiQypIknihnM7sHuHj8/UWNvDIKXC8pkdWAEYArmKla6sxpuQ49pOvT8Ziv2jRqo4QmvURsmp5WMA==
X-Received: by 2002:a63:b649:: with SMTP id v9mr20301582pgt.402.1587989352637; 
 Mon, 27 Apr 2020 05:09:12 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.114])
 by smtp.gmail.com with ESMTPSA id r17sm9623885pgn.35.2020.04.27.05.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 05:09:12 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 27 Apr 2020 17:38:18 +0530
Message-Id: <20200427120834.380-8-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 14:09:16 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 Apr 2020 14:09:14 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 07/23] parsing_cocci: context_neg: Reflect Parameter
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

Parameter attributes are added to the SmPL AST. Reflect these changes in
context_neg.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/context_neg.ml | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/context_neg.ml b/parsing_cocci/context_neg.ml
index dd768a61..98b96ac5 100644
--- a/parsing_cocci/context_neg.ml
+++ b/parsing_cocci/context_neg.ml
@@ -466,9 +466,11 @@ let classify is_minus all_marked table code =
   let param r k e =
     compute_result Ast0.param e
       (match Ast0.unwrap e with
-	Ast0.Param(ty,Some id) ->
+	Ast0.Param(ty,Some id,attr) ->
 	  (* needed for the same reason as in the Init and UnInit cases *)
-	  bind (r.VT0.combiner_rec_typeC ty) (r.VT0.combiner_rec_ident id)
+	  bind (r.VT0.combiner_rec_typeC ty)
+           (bind (r.VT0.combiner_rec_ident id)
+              (List.fold_right bind (List.map mcode attr) option_default))
       |	_ -> k e) in
 
   let typeC r k e =
@@ -839,8 +841,8 @@ let equal_initialiser i1 i2 =
 
 let equal_parameterTypeDef p1 p2 =
   match (Ast0.unwrap p1,Ast0.unwrap p2) with
-    (Ast0.VoidParam(_),Ast0.VoidParam(_)) -> true
-  | (Ast0.Param(_,_),Ast0.Param(_,_)) -> true
+    (Ast0.VoidParam(_,_),Ast0.VoidParam(_,_)) -> true
+  | (Ast0.Param(_,_,_),Ast0.Param(_,_,_)) -> true
   | (Ast0.MetaParam(name1,_,_),Ast0.MetaParam(name2,_,_))
   | (Ast0.MetaParamList(name1,_,_,_),Ast0.MetaParamList(name2,_,_,_)) ->
       equal_mcode name1 name2
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
