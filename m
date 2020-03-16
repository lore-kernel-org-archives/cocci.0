Return-Path: <SRS0=+m3J=5B=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126E3C5ACD9
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 838B420663
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSNw2yXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838B420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GA4Sb1005145;
	Mon, 16 Mar 2020 11:04:28 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0B9EE7809;
	Mon, 16 Mar 2020 11:04:28 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BE4377802
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:25 +0100 (CET)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:443])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GA4OQ7003984
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:25 +0100 (CET)
Received: by mail-pf1-x443.google.com with SMTP id 23so9664455pfj.1
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 03:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3ygx96IxyS2akEP4EeCRpwZ4nwc7zGtWqkbktFc+B10=;
 b=dSNw2yXVmPcuMf9gfqPmZj6Ss+f4QW+vCMdXMhlIh7QZ9lmJGNsQ0oxKVMPatHtkbU
 aKG4f5gnHasuf31M6j4MgXbnKznebKbScdUQTwN7f7F5u96XS/kbpt/TSbYY2VQkHz3T
 RuLYYcZ2QOj862X426i0KDjP8kC1ONqAmWJWW1il21c8JW3XiopsHY31fue+vfckPzpH
 Lhbi1B04tYXCU4EfwHQL2MFNxTc/pAUvR+29UeQgMzgOsnUOG6uG8v5zRLV6oovlqU2K
 nuG7iRIXz8PxWeZhADCIu3YV1LGXrU4PuwIj0dRnr54za9xyI6I9rMyRkzTnT3re0E+J
 QjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3ygx96IxyS2akEP4EeCRpwZ4nwc7zGtWqkbktFc+B10=;
 b=Ll1m47osIdHwIDxQvwitaq+pW04byxHunYt8QBYUXZ0pv1BK1wNWSdYUpPXu/rQVcI
 oNk2FXGvrJHSmyRuClDYO98dMekEQxyeRCHiQoibDzdbgyS6LGrF0pFmwVaTHyy8KBlF
 H+8mSQq4SMyBKsG/jtc+46vKiaDyHWzUmAoTj05qu5kQB1ihU/8XgkgGQYJp4Ev6sh0h
 xYkuIs1d90WhH9Sy26lYeRMnxFz0tJHBoAu3ljm81gXdbAeyUDfggBDQa3fkadOlaO45
 qWeuTvlGs9JaY7bMdbTDUgBoj+sOE+TqQyqpWGDjcTlvP3FhKRYzF2xzoSXcl1TaNYha
 l95A==
X-Gm-Message-State: ANhLgQ1kzS5bmbjEV5pKTgQtdKSndJvM6h3lrMk78Msm68DqQYpU1hNJ
 jmKsBiz4dG/lwxAvfP2HfoxligC/
X-Google-Smtp-Source: ADFU+vvMzxyl1SPINYJdtB5eYRPcgduDxmFxiNTG3KUUbeBYjOU41vQEdWWSzDrKrnOjkabDydEwtA==
X-Received: by 2002:aa7:86ce:: with SMTP id h14mr25041645pfo.311.1584353063403; 
 Mon, 16 Mar 2020 03:04:23 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:284:a4f2:cc63:b7fc:551c:dce5])
 by smtp.gmail.com with ESMTPSA id
 u3sm19803374pjv.32.2020.03.16.03.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:04:23 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 16 Mar 2020 15:33:08 +0530
Message-Id: <20200316100319.27935-16-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 11:04:28 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 16 Mar 2020 11:04:25 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 15/26] parsing_cocci: compute_lines: Add cases for
	ParenType/FunctionType
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
index f4b6f4d8..8231a0e7 100644
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
+      mkres t (Ast0.ParenType(lp,ty,rp)) ty (promote_mcode rp)
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
