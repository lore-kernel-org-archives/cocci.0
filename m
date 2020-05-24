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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC63C433E0
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:20:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF56E207DA
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVmUROJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF56E207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHKKKd003413;
	Sun, 24 May 2020 19:20:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2B2B67829;
	Sun, 24 May 2020 19:20:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 064AF783C
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:20:18 +0200 (CEST)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:444])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHKDUO001307
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:20:14 +0200 (CEST)
Received: by mail-pf1-x444.google.com with SMTP id v63so7852345pfb.10
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8PXTaNekHVw8RwigDgdt/Lh4SU9vlQcFnioxggbCotQ=;
 b=WVmUROJGqRfZ//qiP35iQ2hDZBpsH4KCtBN8fCkwHFk2RKrmXmnr0h7VF0qjGpbBhf
 uRkDOT5zubn7bonK3uGHhCB9/nmfuKRenNJhp496gbr4q1oohI1f/ptV7F3jusIADWlF
 mzAfR4oZDIMy5REPS4ZXD3fhfLGPZZW2//Qb4SXa1l12XtoTYkBMD5nysGYQMFDyuH/i
 P+56a3j2BVHWpaoNRvem4Vr7PimFDy0X2yte2GOB6FEXIxvJ/rxWD8lyS5vT+qoO2Og7
 txNq096fOLQ2FkGaJW7KCdFTvtchO088APY52xVrscfFdvVhQM2HHzRz8+gNsgXHvb7L
 uhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8PXTaNekHVw8RwigDgdt/Lh4SU9vlQcFnioxggbCotQ=;
 b=SyKM6zru4BF+z6iXSmmlxZC9EXlOgqwNCSa0B07R/2vxuMP8KdvOTrGBlipwcj7cZP
 glg6TaPBeg66IHKKz/dqXXJ0UI0Dng/GvKKvewZwjrQ424AyZFJfmIwB/OP9uoYwbbvq
 kCKSPpMbXIysgqbT1WRtfYBRUjFxEs75BlZSdEbfGpSUgICvzbK9vi3iYaiwDYniLeyx
 bUrgbMO4z9twZ58zDhRAurREVl2ryPkjCoI4ETWGF16WYkBdPUiwf7VazibMEj46uEtv
 5PUz3DtJg3o9GXimTlemxnRNWZS6eRaqO9Fu6LapcWVP6xsSCEHDhajd19R6FeEPSxYu
 R+Cw==
X-Gm-Message-State: AOAM530Wil6DRorELiyquDhpGDJ8cQRMqEgfrHYGnNuDUpdl276SmgOd
 bwt+lLdiM3eCGiPDq/HpCJ17sR8Up2Y=
X-Google-Smtp-Source: ABdhPJy7yLcwMTXwkuXfDw97DzoQ0MmikG/FEaVVnMFPPaMmIrPH5BLWM4UV/GoiOz0ShAIHR+iPPw==
X-Received: by 2002:a65:5287:: with SMTP id y7mr22283905pgp.86.1590340812435; 
 Sun, 24 May 2020 10:20:12 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:20:12 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:07 +0530
Message-Id: <20200524171935.2504-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:20:20 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:20:14 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 02/30] parsing_cocci: parser: Parse Macrodecl
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

Macrodecl attributes are added to the SmPL ASTs. Parse these attributes
in the SmPL parser and place them in the SmPL AST. The added production
only supports attributes before the semicolon.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/parser_cocci_menhir.mly | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/parser_cocci_menhir.mly b/parsing_cocci/parser_cocci_menhir.mly
index db5661bd..d5d5df8c 100644
--- a/parsing_cocci/parser_cocci_menhir.mly
+++ b/parsing_cocci/parser_cocci_menhir.mly
@@ -1710,9 +1710,9 @@ decl_var:
       [Ast0.wrap(Ast0.Init(s,fn idtype,id,a,P.clt2mcode "=" q,e,
 			   P.clt2mcode ";" pv))] }
   | s=ioption(storage) d=decl_ident o=TOPar e=eexpr_list_option c=TCPar
-      p=TPtVirg
+      ar=attr_list p=TPtVirg
       { [Ast0.wrap(Ast0.MacroDecl(s,d,P.clt2mcode "(" o,e,
-				  P.clt2mcode ")" c,P.clt2mcode ";" p))] }
+				  P.clt2mcode ")" c,ar,P.clt2mcode ";" p))] }
   | s=ioption(storage)
       d=decl_ident o=TOPar e=eexpr_list_option c=TCPar q=TEq i=initialize
       p=TPtVirg
@@ -1758,9 +1758,9 @@ one_decl_var:
       Ast0.wrap(Ast0.Init(s,fn idtype,id,a,P.clt2mcode "=" q,e,
 			   P.clt2mcode ";" pv)) }
   | s=ioption(storage) d=decl_ident o=TOPar e=eexpr_list_option c=TCPar
-      p=TPtVirg
+      ar=attr_list p=TPtVirg
       { Ast0.wrap(Ast0.MacroDecl(s,d,P.clt2mcode "(" o,e,
-				  P.clt2mcode ")" c,P.clt2mcode ";" p)) }
+				  P.clt2mcode ")" c,ar,P.clt2mcode ";" p)) }
   | s=ioption(storage)
       d=decl_ident o=TOPar e=eexpr_list_option c=TCPar q=TEq i=initialize
       p=TPtVirg
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
