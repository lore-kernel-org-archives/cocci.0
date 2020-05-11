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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E274C47255
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E2720720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLu/XASn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E2720720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA9AvH026844;
	Mon, 11 May 2020 12:09:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 811E53E6B;
	Mon, 11 May 2020 12:09:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B55EB3DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:09:09 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA98CA025737
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:09:09 +0200 (CEST)
Received: by mail-pg1-x544.google.com with SMTP id a4so4358328pgc.0
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OPOEdbrp0+m25ziKK0qnI+Kfqtq0LVSPDHJCMCSV4uI=;
 b=JLu/XASn1/ptDxd9k9atM5fCBYOy0PtcHvhrdpbU0xYhG2dHXCNEBDqEp3iEPiBqT2
 +K/gbpq2nrjXjIVbmGpXhJytsji9Av6AyDlknbvk2GtgR+t9RtO1fbxsT2+VTHuJI34g
 1IlutDcJxri+uxzCW8ElEFsAf6G1dx5tRjuIhTOlzlgoc80QVpxK7vz+3e4/ETcZx/aC
 vERvpmRnK/QBlTiGPdcKVx1nUpUs1Ntr6o7cJgQrbeKZhwwsu1i++63ZY1+dDOYJn/e4
 FXAuU+0jNdGGAhfzdnL2eTxmg43iFLCGkkrzzn6vN+pmghWj/N8CSG4q4oOgBjFoO+kx
 TvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OPOEdbrp0+m25ziKK0qnI+Kfqtq0LVSPDHJCMCSV4uI=;
 b=LaJ0ldoidQ8WBS447trMUJkUj+Sr5gusHBzEfzSLDnpDheHcJMU12R2DEoFYDdRVge
 //2eQNXvrA29ZjiWRgrhwYib4jjR0CEvon7r5+8GRhX5gloPHtLYL45zBclkklWglWNU
 6VrwVChq/l6hn0Qu1DE78Zun8GUphH92tFiMzOQjemYLSyfEDkA+eqBklX6KmxBwVtaf
 UXaXcMrT0Tnj/Qdo+3iUp73vcW11OsOVJmH+eL+r7I3LPYtExhslk+yf2DpnDp/GnS1k
 nJZmE+6C7W10d+wD3/b5K+5ii6ESFJc8O5BmdT9HjNvnVzUNNuV2cURI6w3EWKCjWMyW
 khHQ==
X-Gm-Message-State: AGi0PuYdv3ltBINgSJN+HlnD6DVJWb3QkHqwpHLpTsoQYsYiqyKiK6O/
 7l83e+YKBeb6Tc/9JY3tKSDAubU+5Lg=
X-Google-Smtp-Source: APiQypIWAXPMULfLMGzCW+ptwFnStu/qK6p5H/x3kpoUNrvkZFBkruYRnkym4iuEhNo0+WsIlTV4jA==
X-Received: by 2002:a62:1994:: with SMTP id 142mr14718827pfz.259.1589191747389; 
 Mon, 11 May 2020 03:09:07 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:09:07 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:37:06 +0530
Message-Id: <20200511100715.19819-24-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:09:10 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:09:09 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 23/32] parsing_c: type_annoter_c: Reflect Cast
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
 parsing_c/type_annoter_c.ml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/parsing_c/type_annoter_c.ml b/parsing_c/type_annoter_c.ml
index dfd363b2..dce9753c 100644
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
+    | Cast (t, e, a) ->
         k expr;
         (* todo: if infer, can "push" info ? add_types_expr [t] e ? *)
         make_info_def_fix (Lib.al_type t)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
