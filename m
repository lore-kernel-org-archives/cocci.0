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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451F6C54E8D
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B63C720731
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9/NkjuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B63C720731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA8DXO027127;
	Mon, 11 May 2020 12:08:13 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B42F03E6B;
	Mon, 11 May 2020 12:08:13 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2B8613DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:12 +0200 (CEST)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA8AcU025837
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:11 +0200 (CEST)
Received: by mail-pj1-x1041.google.com with SMTP id k7so2630582pjs.5
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Gpk4lBaaGHI5NGUnDaQ574zEtv7q++ZgEpjSn1EPR0A=;
 b=b9/NkjuB/3i6lGXK8YsL71EIk5TFXBLjTaS94eNEYgMlUOmib2oS0Dlm52VNxjCQ9f
 MY+vRFNInJGjpDpWWCbZE8zGGV2oQSIXstZjFH7QFVJviZ3ZK67Nh6JHd7UeJPG0O8Z/
 GAm37jkXqVlA+3Ls2ot0/aKBLKXAw6ULWE5HjBvX4g9PbxRyqyjzLVmn6TmKQrzYVRel
 kxjLbYzF61gCJIW2Bu2760AWhxvRGWrcK8MtwFRBMTR+IAaIDteUr1um5WxE66xnMCWa
 xbrnqQw8vl32okHGdY6mUd0AlgGOkmr+iCwkOdm/ToFNcAh4gYBoXMwVFgwC1w5iXnir
 7W3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Gpk4lBaaGHI5NGUnDaQ574zEtv7q++ZgEpjSn1EPR0A=;
 b=mtmkjfbnlQ6KYp4SjynlLVMEBTyMJbonfTUYoc5ErC6C3uYA6rhJqiPT4EIqUyvSEr
 RYr2M2dSkMTQH5F0zzG+HbBfDCOXd2PudPCO/xha8htIBh1LKJJ3U4FenVAsH6aBt4Bv
 rKLAJuYpNsoXtuwA4/lTdT6kWpW2/LTKMYyYASMqlIHXSR28OuzTJC9riWRe8QzcMvrN
 bnP5/LtcRqFP8NcFSJovBkSUQivjQhuTqEtftIlSDFvbu238QdmkXKir7hPuphEgbwFS
 +kYcuhS1CmYHaXJGgPgWkx+wDpIeTwXxwDqwsSc+5bxqu/MUl1WtUgQCXJ8Y/5NZC8FW
 bFfw==
X-Gm-Message-State: AGi0PubjOETwOvo/EbQRImSHJAxNkFD2QSnSBR0lYOe6+uVxe04QwFbt
 OST1TRG3R2W/nIkF3pAWFfYUFd+ewAA=
X-Google-Smtp-Source: APiQypKpOT8bOI9Y2czDmLDFeyLalvEYktHvxwAPooX+Nmygv00o0x8+4d/wHzvPbdoArD3X5nDuew==
X-Received: by 2002:a17:90a:c702:: with SMTP id
 o2mr21304795pjt.196.1589191689859; 
 Mon, 11 May 2020 03:08:09 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:08:09 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:36:52 +0530
Message-Id: <20200511100715.19819-10-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:08:13 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:08:11 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 09/32] parsing_cocci: arity: Reflect Cast
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
arity.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/arity.ml | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/parsing_cocci/arity.ml b/parsing_cocci/arity.ml
index 8ee6d33f..2aff6c36 100644
--- a/parsing_cocci/arity.ml
+++ b/parsing_cocci/arity.ml
@@ -254,13 +254,15 @@ let rec top_expression opt_allowed tgt expr =
       let ar = mcode ar in
       let field = ident false arity field in
       make_exp expr tgt arity (Ast0.RecordPtAccess(exp,ar,field))
-  | Ast0.Cast(lp,ty,rp,exp) ->
-      let arity = exp_same (mcode2line lp) [mcode2arity lp;mcode2arity rp] in
+  | Ast0.Cast(lp,ty,attr,rp,exp) ->
+      let arity =
+        exp_same (mcode2line lp) (List.map mcode2arity ([lp] @ attr @ [rp])) in
       let lp = mcode lp in
       let ty = typeC arity ty in
+      let attr = List.map mcode attr in
       let rp = mcode rp in
       let exp = expression arity exp in
-      make_exp expr tgt arity (Ast0.Cast(lp,ty,rp,exp))
+      make_exp expr tgt arity (Ast0.Cast(lp,ty,attr,rp,exp))
   | Ast0.SizeOfExpr(szf,exp) ->
       let arity = exp_same (mcode2line szf) [mcode2arity szf] in
       let szf = mcode szf in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
