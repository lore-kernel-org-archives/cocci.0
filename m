Return-Path: <SRS0=O8dQ=7N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6269C433E0
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B27206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8htdYr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B27206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFRRUq023081;
	Sun, 31 May 2020 17:27:27 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BAEF5777D;
	Sun, 31 May 2020 17:27:27 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 487FF3C89
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:25 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:643])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFRN6W026479
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:24 +0200 (CEST)
Received: by mail-pl1-x643.google.com with SMTP id n9so87913plk.1
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V9JsogsnDuUGo21WJm29vh3LmkeAuiFz2LgdYhtFROA=;
 b=q8htdYr0t+cuOo4Pdla05P3ju+qIt1QpJskMbe1BwWCBlHdGV2h4ScBAc7rn30qDhp
 +AWjChNv1PX8DXv3oAr82n+GNF6GfL+oGNUhSpXKEKKZajTuPtPb7hwgVzmzfTif2qA5
 kD00szGZNenI2uFufCixWqTnZ/tND0fCdFD22/hMsLd1+S61xoy1lsS8BX/7jgm/Frpi
 Rbm/ne6zW6kwXVt36/p84S2ZSCEVMvUZxCRd43Hg5oa0mofJ1VJ6cO0cgj9BbKm15YsX
 f+nzZq4adUSOmwvO58iFCgurOKxbP2eh8/RAaDFpjiIBQNcNbPrd0jqDY1yTaAt9Tvr1
 7yKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V9JsogsnDuUGo21WJm29vh3LmkeAuiFz2LgdYhtFROA=;
 b=I5NFibgvo4SXEwDtCvn2Fi9+EhMw+KyUo1FEjvjihikb5OwC2MucKE/Ag0Z6oZeJCY
 BsFMW1pSI5WWX/FWOu7QN4dbmx8N7UCDIHKDHuWDnvkL4qbAm1m+EZdbiyKhx3yqZXb6
 uHPyjXkMeDiBA+I4ERMTm3N1zUs3H+U9I9o1mOQ/Xz4kLwZHevNxO1C5zUb/JyR9aWH5
 nQ0Eo1ALXG4i1lY/8hA0usC7CBLfzm6sTRM8/QGs+iEvwIb5E00r1iWTeteQUaaU+Sbe
 XVvViaTZdDK11/Ta5LciSQfp6rNLvOgA+ZrrLlG491UJE6dva3n8pQ0JsPF6IGolqNd8
 hMSA==
X-Gm-Message-State: AOAM533UnrIObejY6EV1Z8HE9OMu3GFjafc78asPaV5vLZVAiwzaYU7L
 ONTFTgcrCYnH/jeyKGvI0gMMXRH5TTY=
X-Google-Smtp-Source: ABdhPJwZa9+PebgWBijZl8ZpfPhsvVv+5fx1jKgEOnoG3OLNZ1SRDPhgyBTKBJniTxJ6H5j9CMvx2w==
X-Received: by 2002:a17:90a:1642:: with SMTP id
 x2mr17781764pje.149.1590938842814; 
 Sun, 31 May 2020 08:27:22 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:27:22 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:56:00 +0530
Message-Id: <20200531152621.2886-7-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:27:27 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:27:24 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 06/27] parsing_cocci: iso_pattern: Reflect struct
	end attributes
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

Struct end attributes are added to the SmPL AST. Reflect these changes
in iso_pattern.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/iso_pattern.ml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/iso_pattern.ml b/parsing_cocci/iso_pattern.ml
index 5b4c5f61..6cd5f1cb 100644
--- a/parsing_cocci/iso_pattern.ml
+++ b/parsing_cocci/iso_pattern.ml
@@ -998,8 +998,13 @@ let match_maker checks_needed context_required whencode_allowed =
 		       argsa argsb;
 		     match_init ini1 ini]
 	       else return false
-	  | (Ast0.TyDecl(tya,sc1),Ast0.TyDecl(tyb,sc)) ->
-	      conjunct_bindings (check_mcode sc1 sc) (match_typeC tya tyb)
+	  | (Ast0.TyDecl(tya,attra,sc1),Ast0.TyDecl(tyb,attrb,sc)) ->
+	      if (List.length attra = List.length attrb &&
+                  List.fold_left2 (fun p a b -> p && mcode_equal a b) true
+                    attra attrb) (* no metavars *)
+              then
+	        conjunct_bindings (check_mcode sc1 sc) (match_typeC tya tyb)
+              else return false
 	  | (Ast0.Typedef(stga,tya,ida,sc1),Ast0.Typedef(stgb,tyb,idb,sc)) ->
 	      conjunct_bindings (check_mcode sc1 sc)
 		(conjunct_bindings (match_typeC tya tyb) (match_typeC ida idb))
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
