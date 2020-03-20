Return-Path: <SRS0=15MF=5F=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2044CC4332D
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B400120774
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWOzaRMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B400120774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K73fl0003423;
	Fri, 20 Mar 2020 08:03:41 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DA12B780E;
	Fri, 20 Mar 2020 08:03:41 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 71B24780E
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:03:40 +0100 (CET)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02K73c1b027828
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:03:39 +0100 (CET)
Received: by mail-pf1-x441.google.com with SMTP id z65so2747171pfz.8
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 00:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CW/aBVc/DvLm5AzOCaIeJv4ugR2BHIZSwBinzT7AqF0=;
 b=bWOzaRMGOyAW/rwbQuZL28TUSd9Vgf8gclOaNpfpmekshA53Jw9suNM7zkcieDsSvP
 vLK786ikJlI2PL+svJJraiIBHUNqrhQd6413iUa6Xydx40YT8BZ3NbXpOUcSmAhzvfsT
 WxiEgy5uQ9L3ShLRJdzmSUxt7kUG5XjwMovXD0wCNVYajVKmU1n3JLlOjL/odhzozGW2
 QCKd+Dupv6aJLO2oTL0xzbW1HJ0FefyDOjnKep3YAB1LGMODSSVCMxPOvs8ChX3ivRPK
 l5qr74Xv4QVJI6vZwV5t6CCHmfD3fbz+sF5an9g6sytFOygi+BNV4Iw87W+qU1t2k1dn
 bsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CW/aBVc/DvLm5AzOCaIeJv4ugR2BHIZSwBinzT7AqF0=;
 b=aD2B9Y12OyVEWwOo4uv2TPvMNjZDU17yiCugx0wErVb0MDfuWyUg+eYl7U9odU8v0/
 C5LLRK5ATBMn6EnXjR2w3GUu90OJRtb8d3fZ/8GUHvig4iQoCjbt6gfsfY/p0d/KEuAQ
 oZ1gO8HGX/HKJpc/8z5oHQUqpWKdh47BtFkPaMjWaQsk9DwA0Aj1cT+OTqWKcYEQ+IyZ
 XsXcreVpL6Wd6fbSuYgJmX264mk9yacB7VITfU0lFrv171G2RA2o3roxy8EXjzDI3E5k
 2Gh+JRJpEHqQlPRPNOzQtEA2i9TUj+HEHPdF67RxHdEB5boakNPTme+M+GwpN+SF2nlM
 4qFQ==
X-Gm-Message-State: ANhLgQ0NczustC+bknX8rhETUVuaIqbQOQd2ZZhUmHWg+51B65MUKxA3
 u+DL7U68gpsZvnthfUuKNP87J6Ou
X-Google-Smtp-Source: ADFU+vuY5+Z2rkJ9NqJDOIeqw+9wgjFNm3Dq/Jz6Cmdhq3EscU8fdxvvLuX/8+z0tI+kzt2KSHt0iA==
X-Received: by 2002:a62:1b12:: with SMTP id b18mr8205160pfb.258.1584687817097; 
 Fri, 20 Mar 2020 00:03:37 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2190:a751:deeb:c09d:833a:659d])
 by smtp.gmail.com with ESMTPSA id l11sm3941232pjy.44.2020.03.20.00.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 00:03:36 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 20 Mar 2020 12:31:54 +0530
Message-Id: <20200320070157.4206-24-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
References: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 08:03:41 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Mar 2020 08:03:39 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 23/26] engine: Match A.ParenType and
	A.FunctionType
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
