Return-Path: <SRS0=+m3J=5B=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19499C2BB1D
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:05:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4A720724
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGOlDPp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4A720724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GA4v6W010715;
	Mon, 16 Mar 2020 11:04:57 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 586D97809;
	Mon, 16 Mar 2020 11:04:57 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 90A8D7802
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:55 +0100 (CET)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:643])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GA4rng006103
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:54 +0100 (CET)
Received: by mail-pl1-x643.google.com with SMTP id t3so7766602plz.9
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 03:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CW/aBVc/DvLm5AzOCaIeJv4ugR2BHIZSwBinzT7AqF0=;
 b=JGOlDPp54GAwTqVhVkFWnZesLL1cvRrat9MVlcAXDnyy0RHuiZf1o+siqitRRy2ySS
 GESgMbtBQn2e11Fk00Z5qUE+z+IjUq0BoaplWP/ZYfPfQTIMhUmEaWmaxzXaCofUleDW
 Fj1OPM0aeflhhiT3Y2u5dS0cYkoeqna02y4xSwd/yT+eN56A+RfBdZ2FB2sNQLoSR2f4
 Fvq74PUbIEaIfS5bKP2pk/RE5oH8x7/CTCIgWqkpRH2Pj2DrrWoQ+jUwJVjEo9Gae0P4
 q0EhlpWgNX40nA0gaVp35q2QSkR8PhQuG9ZBGAbfrMVdEUgIxKYP2lrKa9xGnOEfgbg+
 FIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CW/aBVc/DvLm5AzOCaIeJv4ugR2BHIZSwBinzT7AqF0=;
 b=EDWyeomcC4K5868O0WPA0ew+eGsNK4fVbAFIFxlfDIyhw19FtuejCnREkJw0l+YqJH
 0nrgOfM+I5NZHoC91xWVRBy8FQZ7F++8leTrDt8EvievI4AqZSxMKPiYMFB7oqbM8wEN
 7thWCb9YXwuXgpsQDZU7TPm5dWLhZDxPsOUNPhhRMTb1ynVQ2IDEo2EAukBle+j5ZbyZ
 PV5y+fabulfcIU6Xiq9uf1QlnEhAVlK3tEvXnIr0a8kxdG5xmPUvjMz19oFYRPVohhds
 V3bakVumNhhjNFgFPdTZfFZK8UfnHaxacCLiOCraT1LxJb2K7YTNm4jYJ019bFYi7Nnr
 n7Xg==
X-Gm-Message-State: ANhLgQ2nhwmz7bngLEf7P0PrI1RI3FznzRxyUtVzOCLP0rjYdiYovjHB
 OmsrNkM3fb4neLbEFfENf1BbUo21
X-Google-Smtp-Source: ADFU+vtJsmax0DwQC+Cf9NjJglYaRBWbACQoic2tLn6yf66YW/uZVM0OuXW3/yAdCegbFry1bM5ujw==
X-Received: by 2002:a17:90a:a791:: with SMTP id
 f17mr8620356pjq.22.1584353092970; 
 Mon, 16 Mar 2020 03:04:52 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:284:a4f2:cc63:b7fc:551c:dce5])
 by smtp.gmail.com with ESMTPSA id
 u3sm19803374pjv.32.2020.03.16.03.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:04:52 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 16 Mar 2020 15:33:16 +0530
Message-Id: <20200316100319.27935-24-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 11:04:57 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 16 Mar 2020 11:04:55 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 23/26] engine: Match A.ParenType and A.FunctionType
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

ParenType and FunctionType are added to the SmPL AST as types.
Match these types correctly.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 engine/check_exhaustive_pattern.ml |  2 ++
 engine/cocci_vs_c.ml               | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/engine/check_exhaustive_pattern.ml b/engine/check_exhaustive_pattern.ml
index 5a047f73..872c060c 100644
--- a/engine/check_exhaustive_pattern.ml
+++ b/engine/check_exhaustive_pattern.ml
@@ -149,6 +149,8 @@ let dumb_astcocci_type = function
  | A.SignedT (signa,tya) -> ()
  | A.Pointer (typa, _) -> ()
  | A.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) -> ()
+ | A.ParenType(lp,ty,rp) -> ()
+ | A.FunctionType(ty,lp,params,rp) -> ()
  | A.Array (typa, _, eaopt, _) -> ()
  | A.Decimal(_, _, _, _, _, _) -> ()
  | A.EnumName(en, ena) -> ()
diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
index a4a0e53b..3e0eb50e 100644
--- a/engine/cocci_vs_c.ml
+++ b/engine/cocci_vs_c.ml
@@ -3785,6 +3785,29 @@ and (typeC: (A.typeC, Ast_c.typeC) matcher) =
         | _ -> fail
         )
 
+    | A.ParenType (lpa, typa, rpa), (B.ParenType typb, ii) ->
+        let (lpb, rpb) = tuple_of_list2 ii in
+        fullType typa typb >>= (fun typa typb ->
+        tokenf lpa lpb >>= (fun lpa lpb ->
+        tokenf rpa rpb >>= (fun rpa rpb ->
+          return (
+            (A.ParenType (lpa, typa, rpa)) +> A.rewrap ta,
+            (B.ParenType (typb), [lpb;rpb])
+          ))))
+
+    | A.FunctionType (typa, lpa, paramsa, rpa),
+        (B.FunctionType (typb, (paramsb, (isvaargs, iidotsb))), ii) ->
+        let (lpb, rpb) = tuple_of_list2 ii in
+        fullType typa typb >>= (fun typa typb ->
+        tokenf lpa lpb >>= (fun lpa lpb ->
+        tokenf rpa rpb >>= (fun rpa rpb ->
+        parameters (seqstyle paramsa) (A.unwrap paramsa) paramsb >>=
+        (fun paramsaunwrap paramsb ->
+          let paramsa = A.rewrap paramsa paramsaunwrap in
+          return (
+            (A.FunctionType (typa, lpa, paramsa, rpa)) +> A.rewrap ta,
+            (B.FunctionType (typb, (paramsb, (isvaargs, iidotsb))), [lpb;rpb])
+          )))))
 
 
     (* todo: handle the iso on optional size specification ? *)
@@ -4361,6 +4384,10 @@ and compatible_typeC a (b,local) =
     | A.FunctionPointer (a, _, _, _, _, _, _), _ ->
 	failwith
 	  "TODO: function pointer type doesn't store enough information to determine compatibility"
+    | A.ParenType (_, a, _), (qub, (B.ParenType b, ii)) ->
+	compatible_type a (b, local)
+    | A.FunctionType (a, _, _, _), (qub, (B.FunctionType (b,_), ii)) ->
+	compatible_type a (b, local)
     | A.Array (a, _, _, _), (qub, (B.Array (eopt, b),ii)) ->
       (* no size info for cocci *)
 	compatible_type a (b, local)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
