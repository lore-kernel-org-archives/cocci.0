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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5454FC433DF
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:20:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF845206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMcZVSka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF845206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHKQLt002064;
	Sun, 24 May 2020 19:20:26 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2E2603DC8;
	Sun, 24 May 2020 19:20:26 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 368F53D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:20:24 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHKM3p015625
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:20:23 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id p21so7678358pgm.13
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pq8yetJUuGll4o+7TETYKKtvn1z1fVukXAxcnIpDIZI=;
 b=oMcZVSkaC5+eZwAx4B+PMgjydvJStFPJJVbHgiylXbgrQbMtb42rTXFwLzgaSoDMFI
 J2JlEvtICgpF0HKswwsNvM59GH4W8kbwvrhcd5o4ZQMU8OELqV2AnMlUe9tb+8th/pR4
 Krzh6+UO4s15KaZaZ2I9+GFnf7BFFK5vSY81HTGu+w5oJf9kwVcaLxy/lCcSc10Ow5fx
 b89D7lLoRe31EozCfbrmk6UgtIxo/BpHRYx4E07T7CDrQoBgahb1PI0bBMvhAOT83yg7
 r0UA2OqYPerMhhS1YobNtpPOLGh6nexvSQqZ0KP3QmERY4vx00Lsyxh96b6g+QiM/8hp
 l5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pq8yetJUuGll4o+7TETYKKtvn1z1fVukXAxcnIpDIZI=;
 b=lxlX16besBLKzKdtSwxMhlBC3t04lkDnr2M3fY4w1K4KPibHEXWul7lujS23TbLgIo
 aVpjB/s+znZZPQB3P5XO9t3c0Tk2Xxts8Gu0o2hhBLul+oBdYyyzdLb+k8219R3zW1Yx
 /MiWVQrdybCv8wLKxp1xm/meCJdZbzKeNEfoWttVeq1ZQD/6HOG0dfayAbId16GfDGC9
 ryDRqUn7+Ijs8qn4OY0nvkhsrHXWDbpLHGHo2RuoenlWNjqINgOXoIL8l+hIvVRzpmAM
 5c5582NC2pBv86h29Xjy/ToCZpa47D4+kLXqR7b5GtuNpXoBVlAD3AMNpLVml2YExBSi
 76fQ==
X-Gm-Message-State: AOAM5302OjGsvmmFl179u/2qFgmRoidkR0VqNhlJgLL6Tt4eZBoRZlMW
 Fu1gkLN0ogBqeFnLVoTdSM9X1He3Dic=
X-Google-Smtp-Source: ABdhPJz++rwkhypYrRQZXcccUi8PFM3sE1nFZ8k1XXvOBwpoePgOU5dV6ugz2ASk56dcO4PPbzgJsg==
X-Received: by 2002:aa7:9d92:: with SMTP id f18mr13847732pfq.266.1590340821727; 
 Sun, 24 May 2020 10:20:21 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:20:21 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:09 +0530
Message-Id: <20200524171935.2504-5-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:20:26 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:20:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 04/30] parsing_cocci: unparse_ast0: Reflect
	Macrodecl attributes
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
unparse_ast0.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/unparse_ast0.ml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/unparse_ast0.ml b/parsing_cocci/unparse_ast0.ml
index fdaf6cfa..4e2a09f9 100644
--- a/parsing_cocci/unparse_ast0.ml
+++ b/parsing_cocci/unparse_ast0.ml
@@ -422,11 +422,14 @@ and declaration d =
 	  parameter_list params; varargs va;
 	  close_box(); mcode print_string rp1;
 	  mcode print_string sem
-      | Ast0.MacroDecl(stg,name,lp,args,rp,sem) ->
+      | Ast0.MacroDecl(stg,name,lp,args,rp,attr,sem) ->
 	  print_option (mcode U.storage) stg;
 	  ident name; mcode print_string_box lp;
 	  let _ = dots (function _ -> ()) expression args in
-	  close_box(); mcode print_string rp; mcode print_string sem
+	  close_box(); mcode print_string rp;
+	  (if not (attr = []) then print_string " ");
+	  print_between (fun _ -> print_string " ") (mcode print_string) attr;
+	  mcode print_string sem
       | Ast0.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem) ->
 	  print_option (mcode U.storage) stg;
 	  ident name; mcode print_string_box lp;
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
