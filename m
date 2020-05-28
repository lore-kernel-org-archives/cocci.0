Return-Path: <SRS0=FJ6B=7K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC9BC433DF
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:26:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D2B020888
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVEvRzmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2B020888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04SCQCgd008561;
	Thu, 28 May 2020 14:26:12 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D00565D47;
	Thu, 28 May 2020 14:26:12 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4CF373E1D
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:26:11 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04SCQ9At017850
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:26:10 +0200 (CEST)
Received: by mail-pj1-x1042.google.com with SMTP id k2so2087872pjs.2
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 05:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iL12afvc8E+4S7BFOl5ZbAwj/mn8D1h40NLooKUmeGU=;
 b=PVEvRzmIcmPXRIl3XvMWrOh0jr1LViI4YhJE/LtaSgBj1/yyvz35BzcqMrEwQu4/mT
 MMWsdVW/KvDo7F36bmplXpxP5UMxkFMOANZtx6FekaX+nkhaVM7PuCA8KCTNOIFLl1Z4
 yr3LNko8G78jF42ML0AyEk0Ot/toWcuQRt2bMj98Er105iXl8M0bs9zTn0j5287xEYNo
 635DwRD2tVvj4ynNk1lrVZ4Cfviv67bmD3O5FvT5Qg8SjyZQtr6uODooMgOQ/VWEJMD0
 xjKeX9CZVzDR7C8O1Zv2kmGUrEDuQpsU84hoWxkkpwp0q2yC8HIsXbpkWuZZzyXQiaIU
 lGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iL12afvc8E+4S7BFOl5ZbAwj/mn8D1h40NLooKUmeGU=;
 b=KfTPP0dKeK1ET8mHx1JvEQkucYiatpxJJCy0qKBBzFloIoIuRToxIeUXV8/epWcyd4
 53016mxUFj6ez07ip5uA3bBIYdPDrIQgDLrKDKTA2P2DkaBr9b/iah5Ekj1P3amkoY5l
 MZzNDjlObg7ETdImO/ERFRTO+cxHJ0J8H/EfpyH4ZnIPZkTAwvbLIjBmvxtU/JFbUR6a
 AVr4sXK2a1LetheBRLewmbUkQqnDubdAd2+ZpGtJbC6ziPhc+ahmVla8+zy7VP9PjUpO
 riTRLtuPESXzDTyeTlcD2kHsQ9yj0D3nW//HaIahZuMV3yzzxgldKose3gmRp5QAZZpz
 PMDA==
X-Gm-Message-State: AOAM531hVhd18XFEK+lfmBuII/hUXdo23tvIWidR0j2M9IazLLPKwl24
 d4GTOeumZe+/1AvX7mw3Vw8F1Clk
X-Google-Smtp-Source: ABdhPJwQ0u1Ad3MSxCrPEy405IEcMpj02itAQnL6mnAJNj0jTtTqT+OnhLPHKjUhFA9yYH2AoYhbZw==
X-Received: by 2002:a17:90a:b28a:: with SMTP id
 c10mr3164462pjr.223.1590668768780; 
 Thu, 28 May 2020 05:26:08 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2183:e360:deba:7bf4:98ef:5568])
 by smtp.gmail.com with ESMTPSA id 1sm5722888pje.26.2020.05.28.05.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 05:26:08 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 28 May 2020 17:54:27 +0530
Message-Id: <20200528122428.4212-26-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
References: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 May 2020 14:26:12 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 May 2020 14:26:10 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 25/25] engine: c_vs_c: Match parameter attributes
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

Parameter attributes are added to the C AST. Add an expression to check
if attributes are equal on both sides to the parameter case in c_vs_c.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 engine/c_vs_c.ml | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/engine/c_vs_c.ml b/engine/c_vs_c.ml
index e2bd7408..b569c244 100644
--- a/engine/c_vs_c.ml
+++ b/engine/c_vs_c.ml
@@ -135,9 +135,11 @@ and typeC tya tyb =
           let iix = iia in
           acc >>= (fun xs ->
 
-            let {p_register = (ba,iiba); p_namei = saopt; p_type = ta} =
+            let {p_register = (ba,iiba); p_namei = saopt; p_type = ta;
+                 p_attr = attrsa} =
               parama in
-            let {p_register = (bb,iibb); p_namei = sbopt; p_type = tb} =
+            let {p_register = (bb,iibb); p_namei = sbopt; p_type = tb;
+                 p_attr = attrsb} =
               paramb in
 
             let bx = ba in
@@ -145,13 +147,15 @@ and typeC tya tyb =
 
             let sxopt = saopt in
 
+            let attrsx = attrsa in
 
             (* todo?  iso on name or argument ? *)
-            (ba = bb && same_s saopt sbopt) >&&>
+            (ba = bb && same_s saopt sbopt && attrsa = attrsb) >&&>
             fullType ta tb >>= (fun tx ->
               let paramx = { p_register = (bx, iibx);
                              p_namei = sxopt;
-                             p_type = tx; } in
+                             p_type = tx;
+                             p_attr = attrsx; } in
               return ((paramx,iix)::xs)
             )
           )
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
