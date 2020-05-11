Return-Path: <SRS0=43Z/=6Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E5EC54E4B
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C872720731
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvuB73pk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C872720731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA7seG014656;
	Mon, 11 May 2020 12:07:54 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A91DD3E6B;
	Mon, 11 May 2020 12:07:54 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CEBA63DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:07:52 +0200 (CEST)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA7pZb006523
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:07:52 +0200 (CEST)
Received: by mail-pf1-x441.google.com with SMTP id 145so4515099pfw.13
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mDnBPl3qIHtqg930rr9qdZdP5Uw3rvrHwoa1ZEd6TMs=;
 b=UvuB73pkrbbSDjaRsaWw6Z4OjzlvvUyjf5J15tHR1ZEFkc3hY295yS4CWfbwk6j/bz
 U89l991jRgL4Tr3GvzfrTLLJS+U9klw/4qmILI3ghmuFT5EWneRN83xlApkpxQ4Og5PS
 42RvLVh3QrWfbgaeGXKaO68BmeushICNQ3UaFGEdlh2iHj9zKXW4RcrxCZCqHzy//y6O
 TtmB4lD0GHVR1y03n8H+eyEef6uvqEKP439hFY+sneZvOQmMc128oZjsCZUh7LoBXGiO
 IwWaD3KmKoDZM6eZzrPDnO9ULb5p+0oisn3zSulDS58brmMdrpE8y42wRKr+ncl7wKFY
 Ffgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mDnBPl3qIHtqg930rr9qdZdP5Uw3rvrHwoa1ZEd6TMs=;
 b=NMef5AE7qIM3VVUQuH7f67gtHaJ6NPdAaja85ohRGg5erzGq+lVnS+aeX8CBT1UWX0
 +G4NIOIu1hHwTwwuhO8yFr7T2otUEQDZxslpjEsC/UQPSsmCp1uPzyj1uBnB4lNLlIfV
 tW9u68wtCzW4rvihmGFfQdday6Cmxg0MmkM3csSCbQfu1Jho5xyLpXa4tD2rRKEopLcH
 Ditt7nk0hhLCWPXp09YELSOcRPRNfHZZ4PwfOgmFKiLbbnM4Fqar0wduCwbtjA2kgjF4
 kAOSvnkm1K3KrFwcfm/9yV7icAF8Ao6HVASZkqLni9raDeoDz0Ci4D0DsRAiCFK1ID+q
 CWfQ==
X-Gm-Message-State: AGi0PuZtCPcRaXHlFKGd4BrI3lI6rAih2soLRozMOmgCITtID2vTHi33
 1VnXdzWrNeDUbUTEBTLZB/FMZLekozE=
X-Google-Smtp-Source: APiQypIPfd3OPmMLAL9twl0izNkRQX2AIfN2tVEokA3CPTEIcYen7amDhOxC5+6GY6/JB6VDrE3iSA==
X-Received: by 2002:aa7:97b2:: with SMTP id d18mr15799048pfq.89.1589191670503; 
 Mon, 11 May 2020 03:07:50 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:07:50 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:36:47 +0530
Message-Id: <20200511100715.19819-5-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:07:54 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:07:52 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 04/32] parsing_cocci: visitor_ast0: Visit cast
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

Cast attributes are added to AST0 of SmPL. Visit these attributes in the
AST0 visitor of SmPL.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/visitor_ast0.ml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/visitor_ast0.ml b/parsing_cocci/visitor_ast0.ml
index d9e340ed..2ccdb0bb 100644
--- a/parsing_cocci/visitor_ast0.ml
+++ b/parsing_cocci/visitor_ast0.ml
@@ -184,12 +184,14 @@ let visitor mode bind option_default
 	    let (ar_n,ar) = string_mcode ar in
 	    let (field_n,field) = ident field in
 	    (multibind [exp_n;ar_n;field_n], Ast0.RecordPtAccess(exp,ar,field))
-	| Ast0.Cast(lp,ty,rp,exp) ->
+	| Ast0.Cast(lp,ty,attr,rp,exp) ->
 	    let (lp_n,lp) = string_mcode lp in
 	    let (ty_n,ty) = typeC ty in
+	    let (attr_n,attr) = map_split_bind string_mcode attr in
 	    let (rp_n,rp) = string_mcode rp in
 	    let (exp_n,exp) = expression exp in
-	    (multibind [lp_n;ty_n;rp_n;exp_n], Ast0.Cast(lp,ty,rp,exp))
+            (multibind [lp_n;ty_n;attr_n;rp_n;exp_n],
+             Ast0.Cast(lp,ty,attr,rp,exp))
 	| Ast0.SizeOfExpr(szf,exp) ->
 	    let (szf_n,szf) = string_mcode szf in
 	    let (exp_n,exp) = expression exp in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
