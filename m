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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD11C433E0
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:20:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFD6B206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPJ0VOlF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD6B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHKl7s013109;
	Sun, 24 May 2020 19:20:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0C4AE3DC8;
	Sun, 24 May 2020 19:20:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0481C3D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:20:46 +0200 (CEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:443])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHKiqT002281
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:20:45 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id n18so7868720pfa.2
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CIT4ulcINpSBAMknhc5mGb5HbX9zV5kFWcp1NsjcRxY=;
 b=BPJ0VOlFfsKKSzPec7CrqCHH8wuGv1L+AUhF2otkAmCqO3LKiHSbwDbQV0H9C+hT2d
 vlX74CyhLVLre5GWPq5p4p1IF9VD9TL6bu/UgIEJzudgJs47kPwhUOyRru89yok3UcRz
 12U/ojy0dRNO6NyShvp8ZmrFdbb64wlXnjhb1g4DfFShXh78weQfDYGUXSgqofi0g5XG
 DFoRIE5LWB6twzCOiLnVM8rfVoUqc6MVldy+pe1GoHsc/E98JGotaQnQMWjUd2VpccOx
 DfMDhCiWAXB2UsIz7etzFlAJFh7H+Z4KRB4kSfYljJdu6K8b291v3mUmXj96US/Ebe3i
 YRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CIT4ulcINpSBAMknhc5mGb5HbX9zV5kFWcp1NsjcRxY=;
 b=MfrBdcCAohXE6gJZJIjRZX1/+0bJh/H28v2Zigv8V9fXqK9GbFocSSSK6TOxKvEXIk
 B7flNZ7HRsfGYFpuaIrnuLktzI1Oq5b9A5QQViHM8bdkaRBj9LtfR0m0jntc+rIqmA3B
 GVmmSuokIQ7MKUa3pnyt9aC0kQINWwEGK6Tdrb1tt4FwOzvaA2dZ/d1G7r5viNT0Ytt/
 6vdpcQVocoGvyr04huVYMrD2j4NWq8Y8Dz7uCjtlsfsneD9CwFbRKcB57c4vtkUBxJb4
 skJNG7StFZmkv8+fHg76a9SJEq8MyHQ5lHQN0/yV6MrEnc8cuIlYXSvWTdlZiAuifFFM
 HuOQ==
X-Gm-Message-State: AOAM530Yvx9TLH4JQVz2yLxMi5yza3JDwRhZKFbfESz0xhaIp2gsWEut
 GpyqJllabdPzPP3oKZI74u8SZSY11/o=
X-Google-Smtp-Source: ABdhPJw+77kDDLQn1On68qbHo3AmPG4Qb40VIxJWOYxg7AEl3IN6KIS3iZDIjRSCpbvZg7jMzetAVA==
X-Received: by 2002:a63:348b:: with SMTP id b133mr2537096pga.319.1590340843671; 
 Sun, 24 May 2020 10:20:43 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:20:43 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:13 +0530
Message-Id: <20200524171935.2504-9-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:20:47 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:20:45 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 08/30] parsing_cocci: arity: Reflect Macrodecl
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
arity.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/arity.ml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/arity.ml b/parsing_cocci/arity.ml
index 8ee6d33f..1c74aa8b 100644
--- a/parsing_cocci/arity.ml
+++ b/parsing_cocci/arity.ml
@@ -595,7 +595,7 @@ and declaration tgt decl =
       let rp1 = mcode rp1 in
       let sem = mcode sem in
       make_decl decl tgt arity (Ast0.FunProto(fi,name,lp1,params,va,rp1,sem))
-  | Ast0.MacroDecl(stg,name,lp,args,rp,sem) ->
+  | Ast0.MacroDecl(stg,name,lp,args,rp,attr,sem) ->
       let arity =
 	all_same true tgt (mcode2line lp)
 	  ((match stg with None -> [] | Some x -> [mcode2arity x]) @
@@ -605,8 +605,9 @@ and declaration tgt decl =
       let lp = mcode lp in
       let args = dots (expression arity) args in
       let rp = mcode rp in
+      let attr = List.map mcode attr in
       let sem = mcode sem in
-      make_decl decl tgt arity (Ast0.MacroDecl(stg,name,lp,args,rp,sem))
+      make_decl decl tgt arity (Ast0.MacroDecl(stg,name,lp,args,rp,attr,sem))
   | Ast0.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem) ->
       let arity =
 	all_same true tgt (mcode2line lp)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
