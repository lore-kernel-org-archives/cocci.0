Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D35C433DF
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:20:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8537206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKmvrLRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8537206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHKZuw009576;
	Sun, 24 May 2020 19:20:35 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3265A3DC8;
	Sun, 24 May 2020 19:20:35 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 697E13D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:20:33 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHKV4o027965
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:20:32 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id w19so6606798ply.11
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zsXmpuYiU3H+YSGw86M+yfarFqH71sZdfBhnw8U00xw=;
 b=ZKmvrLRJqPSOjPNzy8DmG9skzh6XTJQ4XwHSY6sdLbwp1VLBLTu8+Tl/4OR5FIsT/e
 9N80fPvbLNUnlHRkJSZSIpD8q6aWUT4fcFPNDTeSeb/9HvbiMjhoIFXJ71wcw/NzYc25
 eD3uuNXf0a6gRTIIxAgpURI/ttoZLjl2PJ476uGJFNNCwDo1qpSjglYy6TtrQWuxQxev
 sRSjQOqqgthUkB+sEyFg3q4iDmKBAoUx8pDxFSWD4OkN86PMHZaqWbKxfZ8Om/Rna/kk
 khx5xMYoVktSDVl89ZpwZmY7OSnXVTsEgoFkQdwTyTiqj9uCsnCKpKQhRyBUbeG0drC9
 8IZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zsXmpuYiU3H+YSGw86M+yfarFqH71sZdfBhnw8U00xw=;
 b=gP5SQ7EDmwcQV9zOqXELn4QKXn02S1WdDLtd+ohHOtD7IG4c1VNBNPmrO7290jdqDK
 zGPtBei6FmWGMJJKpAMth7F0NoVOU/VYsI+dJohwYd21JEXpp4sPrNIA0jrRptebFQ83
 f7dKIowN0QPLWBzFRw8tDDdw+tfrC//w0slODDTWrq+lc5Ww0/DUKHV8V+DAv6UxYUar
 GiLb982/AG8Koy8EetClO/rHfw0YHvCSBY5QlZgIzS0IPusXXNZVZa+fibdlcoy87/BD
 +26dp4v93e46EFPNxMtUFOkNcx+50T+77euNcV8dqHhgZNo7XyftZ6NTAuxifiaryYXM
 lS7A==
X-Gm-Message-State: AOAM531DOOAmjdpZWGLOPLxybD6SFoK68SlVnIUWo1YZ/vDIuO6aMqBP
 ysgjojJ2xvOw6OuLUY8odZSP+4M9ug0=
X-Google-Smtp-Source: ABdhPJzVtPDtS/89Tx3IalM5fO6Y2YKNpKk/9iQflaYzMfQ6BEsse6zIB3IWCIKM6MgQMDFD8O+dCg==
X-Received: by 2002:a17:902:8509:: with SMTP id
 bj9mr24275180plb.151.1590340831038; 
 Sun, 24 May 2020 10:20:31 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:20:30 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:11 +0530
Message-Id: <20200524171935.2504-7-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:20:35 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:20:33 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 06/30] parsing_cocci: iso_pattern: Reflect Macrodecl
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

Macrodecl attributes are added to the SmPL AST. Reflect these changes in
iso_pattern.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/iso_pattern.ml | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/parsing_cocci/iso_pattern.ml b/parsing_cocci/iso_pattern.ml
index 9df21fb9..ebb83e23 100644
--- a/parsing_cocci/iso_pattern.ml
+++ b/parsing_cocci/iso_pattern.ml
@@ -965,9 +965,12 @@ let match_maker checks_needed context_required whencode_allowed =
 		     params1 params;
                    match_option varargs_equal va1a va1b
                  ]
-	  | (Ast0.MacroDecl(stga,namea,lp1,argsa,rp1,sc1),
-	     Ast0.MacroDecl(stgb,nameb,lp,argsb,rp,sc)) ->
-	       if bool_match_option mcode_equal stga stgb
+	  | (Ast0.MacroDecl(stga,namea,lp1,argsa,rp1,attra,sc1),
+	     Ast0.MacroDecl(stgb,nameb,lp,argsb,rp,attrb,sc)) ->
+	       if bool_match_option mcode_equal stga stgb &&
+                 (List.length attra = List.length attrb &&
+                  List.fold_left2 (fun p a b -> p && mcode_equal a b) true
+                    attra attrb) (* no metavars *)
 	       then
 		 conjunct_many_bindings
 		   [match_ident namea nameb;
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
