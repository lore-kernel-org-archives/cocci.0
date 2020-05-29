Return-Path: <SRS0=Yx51=7L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D789C433DF
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:08:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E11EF206F0
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnSZglLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11EF206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04TC8qx2023062;
	Fri, 29 May 2020 14:08:52 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1E0AB7783;
	Fri, 29 May 2020 14:08:52 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 801E35D47
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:08:50 +0200 (CEST)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04TC8mmx021795
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:08:49 +0200 (CEST)
Received: by mail-pj1-x1041.google.com with SMTP id k2so1268140pjs.2
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 05:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JQPm62EJTusk3BHa3zj98mruaelNhthwbsiJ/5V4Hvk=;
 b=MnSZglLcaFdl61M12iRUTm/JbKjOJQbfUf2ApmtY5bgaw97OQhxmyaqxY40fjm4ygu
 IWIEQ2RVeGa/6sFh5uB1cnnmYU//njsP4i+31xJMsIPeNxHc1JEedP+5f9FgjIWDgbz0
 /kRQcxrvmHgzPnHM7r8soUOSvIL/sWIwMXjEm5GXNdhkp+uhwg5I6fFDGSPAxwu2AL/p
 27dlqbEzdfqtLhTdKJLjTAajjTmZdmRTnokpD52cpl8VCTqwQaPmzpKde2T7IADgwcHB
 dcgOAnFe07yK4+9PB8mQCLPtBj+vHC3P4h5CUeVvVgZOetqJVsg/kAzkQcGdZn6+X4ui
 mNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JQPm62EJTusk3BHa3zj98mruaelNhthwbsiJ/5V4Hvk=;
 b=F3X2GUdFBNIzDI2BMLl0KTNleozYWafaAWmiSujL+lSST+omnNlcpc69d4WE2CkLQV
 4X+xoGcNu019FctAcMhl9N71xMK4IBDS5u1M8Khnk2CPlqKiCg4M5rDtl/EjSj/Is71N
 BnMDq19rij+wDz9gyu8QW0q94UFluQbYb/hSiGJ+WvhXNmIqVVxO+se6n6kOIk0X40hN
 6S3A2pUb/ujlZ57Lus1L77aMyYGhTkFbxKbBJ4k5ZYdoprNXreXHSSykXKGcoD6sjgpA
 EEBd7X2hyNuANjHpSjsKdsJbWKym1EoCgVF80EsyvM/rTd3Spp+BYLmpgq7qIzIFkJFc
 AdNg==
X-Gm-Message-State: AOAM530NtCjF9R42+zqQ2hFM0ReJTD7HGM86AVH1iYheWkRB7fYbSm4c
 Gy/WWhgyoDnmEHk+mPsdAfNm/8R5
X-Google-Smtp-Source: ABdhPJxgTjppAibAa9ql0lql3r0Grxc/1ZFnsYM7bmYG2NxiahjbsClCtTHlXe/mJ9yLdHHVxEIvfA==
X-Received: by 2002:a17:90a:a017:: with SMTP id
 q23mr9285058pjp.4.1590754127913; 
 Fri, 29 May 2020 05:08:47 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:694:e576:19d1:a79b:707d:59f2])
 by smtp.gmail.com with ESMTPSA id dw13sm7975161pjb.40.2020.05.29.05.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:08:47 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 29 May 2020 17:36:37 +0530
Message-Id: <20200529120703.31145-8-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
References: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 May 2020 14:08:52 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 May 2020 14:08:50 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 07/32] parsing_cocci: iso_pattern: Reflect Cast
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
iso_pattern.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/iso_pattern.ml | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/parsing_cocci/iso_pattern.ml b/parsing_cocci/iso_pattern.ml
index b751f3e8..6e75c5c3 100644
--- a/parsing_cocci/iso_pattern.ml
+++ b/parsing_cocci/iso_pattern.ml
@@ -575,7 +575,7 @@ let match_maker checks_needed context_required whencode_allowed =
 			(* all caps is a const *)
 			Str.string_match all_caps nm 0
 		    | _ -> false)
-		| Ast0.Cast(lp,ty,rp,e) -> matches e
+		| Ast0.Cast(lp,ty,attr,rp,e) -> matches e
 		| Ast0.SizeOfExpr(se,exp) -> true
 		| Ast0.SizeOfType(se,lp,ty,rp) -> true
 		| Ast0.MetaExpr(nm,_,_,Ast.CONST,p,_bitfield) ->
@@ -586,7 +586,7 @@ let match_maker checks_needed context_required whencode_allowed =
 	      let rec matches e =
 		match Ast0.unwrap e with
 		  Ast0.Ident(c) -> true
-		| Ast0.Cast(lp,ty,rp,e) -> matches e
+		| Ast0.Cast(lp,ty,attr,rp,e) -> matches e
 		| Ast0.MetaExpr(nm,_,_,Ast.ID,p,_bitfield) ->
 		    (Ast0.lub_pure p pure) = pure
 		| _ -> false in
@@ -757,10 +757,16 @@ let match_maker checks_needed context_required whencode_allowed =
 	       conjunct_many_bindings
 		 [check_mcode opa op; match_expr expa expb;
 		   match_ident fielda fieldb]
-	  | (Ast0.Cast(lp1,tya,rp1,expa),Ast0.Cast(lp,tyb,rp,expb)) ->
+	  | (Ast0.Cast(lp1,tya,attra,rp1,expa),
+             Ast0.Cast(lp,tyb,attrb,rp,expb)) ->
+              if (List.length attra = List.length attrb &&
+                  List.fold_left2 (fun p a b -> p && mcode_equal a b) true
+                  attra attrb)
+              then
 	      conjunct_many_bindings
 		[check_mcode lp1 lp; check_mcode rp1 rp;
 		  match_typeC tya tyb; match_expr expa expb]
+              else return false
 	  | (Ast0.SizeOfExpr(szf1,expa),Ast0.SizeOfExpr(szf,expb)) ->
 	      conjunct_bindings (check_mcode szf1 szf) (match_expr expa expb)
 	  | (Ast0.SizeOfType(szf1,lp1,tya,rp1),
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
