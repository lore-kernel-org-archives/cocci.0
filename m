Return-Path: <SRS0=15MF=5F=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37428C4332B
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91A820774
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOS3W/Ym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91A820774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K73BPE013000;
	Fri, 20 Mar 2020 08:03:11 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 631247812;
	Fri, 20 Mar 2020 08:03:11 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 957D73B93
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:03:10 +0100 (CET)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02K738Jg009692
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:03:09 +0100 (CET)
Received: by mail-pg1-x542.google.com with SMTP id k191so1454116pgc.13
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 00:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zfYnEbx61yhOCIqXMvTQw7fB1w6DQFfm7YkB1uzwYqQ=;
 b=tOS3W/Ym7JpHK2iz3K3v8tH7B+nDUOr15Ds9x3LKWJZLmAEGwPwudtQDeuZsuNLLkg
 bKwu+oS1StwDRfitu1J0g0zxnA0bzcdA+aMa/ihQmNaXQk2NxExUScu1NEtAQACE4oWZ
 uQGupTTbviTdqg2dA3VWiGWrUf3bcetQQN2S/C6qgyrgG1I571vej00udQzqHZbMuPEQ
 ahcnChyHKugFjyNkifSxKmcnMIJA4nu/HEI0mi1Irte4u+u+F9uTJP0fhigrxe8mxpLI
 AUqK/mt6f9bhkVM+U7MOP1fWgucJOmHGasBgxa6aRUcXeBb6/EJG0do3slvje8b1T2Hw
 6gNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zfYnEbx61yhOCIqXMvTQw7fB1w6DQFfm7YkB1uzwYqQ=;
 b=GmOu7T7Ohe+7jfNAtyvPmTFAsT04N1xXZgCCwyEkw6YmHHbW5m2w2QLssFH4a8ignM
 Crkdx/JltmBkktS3u6vpufjxnD8FeLXgCZSUtd3qK2jLobkxlCJhHn2/ACQiC48q6vmC
 wRN2559xVduBzmzf89PK7XJ5kSlkWMVinhBZilIP4skRioUxQ/IANTUsskeg1Z1T2itf
 UZTNjjwbbQVGXMTxxA0l9RMPAuraC88zlpBrG++Z2LyODgIr0p5a7AyX6d9svMtP/JXs
 rhpHdqdNpURj3et+AL68Tlr7kDDHAMN/ajVZhLrxj0SZ9IyNyCueIU4Y1eKE313YVwGM
 w4kA==
X-Gm-Message-State: ANhLgQ0ns0GPongKh+fZehVm9ornhT1XqnCQ3U/Nhp7uCT5TW/6808AO
 RoaSMSO5xg0j02gzeK5DUVvjgGdV
X-Google-Smtp-Source: ADFU+vtvz8SncTUmFE6LnEo2iE9UNNZleBSEhZqRhxiGmL6CfgGTRxXzvrZ5iU5sDjHdO0ZXtxpFZQ==
X-Received: by 2002:a63:1c4d:: with SMTP id c13mr7083828pgm.4.1584687788154;
 Fri, 20 Mar 2020 00:03:08 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2190:a751:deeb:c09d:833a:659d])
 by smtp.gmail.com with ESMTPSA id l11sm3941232pjy.44.2020.03.20.00.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 00:03:07 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 20 Mar 2020 12:31:46 +0530
Message-Id: <20200320070157.4206-16-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
References: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 08:03:11 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Mar 2020 08:03:10 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 15/26] parsing_cocci: compute_lines: Add cases
	for ParenType/FunctionType
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

ParenType and FunctionType are now added to the SmPL ASTs. Add
cases for these types in compute_lines.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/compute_lines.ml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/parsing_cocci/compute_lines.ml b/parsing_cocci/compute_lines.ml
index f4b6f4d8..c47a06ba 100644
--- a/parsing_cocci/compute_lines.ml
+++ b/parsing_cocci/compute_lines.ml
@@ -574,6 +574,17 @@ and typeC t =
       let rp2 = normal_mcode rp2 in
       mkres t (Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2))
 	ty (promote_mcode rp2)
+  | Ast0.ParenType(lp,ty,rp) ->
+      let lp = normal_mcode lp in
+      let rp = normal_mcode rp in
+      let ty = typeC ty in
+      mkres t (Ast0.ParenType(lp,ty,rp)) ty (promote_mcode lp)
+  | Ast0.FunctionType(ty,lp,params,rp) ->
+      let ty = typeC ty in
+      let lp = normal_mcode lp in
+      let params = parameter_list (Some(promote_mcode lp)) params in
+      let rp = normal_mcode rp in
+      mkres t (Ast0.FunctionType(ty,lp,params,rp)) ty (promote_mcode rp)
   | Ast0.Array(ty,lb,size,rb) ->
       let ty = typeC ty in
       let lb = normal_mcode lb in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
