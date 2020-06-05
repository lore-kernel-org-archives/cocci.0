Return-Path: <SRS0=TTUf=7S=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C73FC433DF
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912F6206E6
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YS9BPeoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912F6206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 055DiHxa022472;
	Fri, 5 Jun 2020 15:44:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 93A0B7567;
	Fri,  5 Jun 2020 15:44:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2CA3C3F9A
 for <cocci@systeme.lip6.fr>; Fri,  5 Jun 2020 15:44:15 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 055DiCWi022604
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 5 Jun 2020 15:44:13 +0200 (CEST)
Received: by mail-pj1-x1042.google.com with SMTP id nm22so2603999pjb.4
 for <cocci@systeme.lip6.fr>; Fri, 05 Jun 2020 06:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p7rZYxRe2Sz/SF1CBsPRfrtZT5FjMYD5co3xZ8oxX9U=;
 b=YS9BPeoWVT3NAE1MgqyMIR06Eh4I3EvYtq3EtdvgFiFrhX1M+EQvKLR/LuqrWCKIDD
 I0WN9FEvhRp/DYIjxfBjd/OmzAsfK70Vp0GN8vWQg48sgUojc82S6GYDFETcHMgsinAU
 ZYMrBbX00HUu4YhlOcYvdIUZ2Fin17qNpavgOBRNiiSIXXZxXklsCESSZ28s6RJ6U/NQ
 /yRe3TSpH6vwUln4PiFYqIIFKovt3Pb0lVNQ3riORaN8pQx13wlBwGGzIoDEvAxDFpwO
 0uIMlQKAayxpbP+zCQabK1lwt4ERl2QUZ0L/+RtMY2uMVKEaN4VpPpBwSD64EH53Xxwu
 oUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p7rZYxRe2Sz/SF1CBsPRfrtZT5FjMYD5co3xZ8oxX9U=;
 b=dxAi6FEV8KYnDLYZ/kcE0mRpMvXp5wndaEgIJHoH0pckkEXRfXjl0mPwHc0y1TuLjq
 /2ANidwxkNWd11Yt7Gi1U1Uaea3xba4rMNjXIraFLeMlCEJnsWf0hL0NdbOdqi92GxOY
 QYVM470eaeURG8iagK8ZKPzV+c4oUDkfnmSZYyAdzcvtpuCG/jnb2HbQtlo3yVFIkMwN
 wZt/YktyREPpHgg2Ui1+Kb2ajBgDNQX3APcYIqOOchC7e2lNAKtem2PmhqxM6W5qgo6Q
 2tY5cDHEVLAvsJuhdx+5ByQm8qMng5JT2vNW3In7kbeLqxcfXNAOoIGr0fzC7IUPsEo5
 QI0A==
X-Gm-Message-State: AOAM530cYSDV7FVgMCpFR9oRPlyAQ4IaPWRmBNuZX7cRjO+IutxfTBxn
 hCvNnlDWgyPuOCVdbhnX/Xlt901kux8=
X-Google-Smtp-Source: ABdhPJzGheh4AVb8ZYVfQkI/pD4GHqiLUqaM63mhwwGFci3WdxFylQeOD5JkNhtNfKoSo+ABM+84ng==
X-Received: by 2002:a17:902:b18b:: with SMTP id
 s11mr9672263plr.160.1591364651467; 
 Fri, 05 Jun 2020 06:44:11 -0700 (PDT)
Received: from localhost.localdomain ([1.38.221.125])
 by smtp.gmail.com with ESMTPSA id w186sm7861353pff.83.2020.06.05.06.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 06:44:10 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri,  5 Jun 2020 19:13:11 +0530
Message-Id: <20200605134322.15307-4-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
References: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jun 2020 15:44:17 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 05 Jun 2020 15:44:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v4 03/14] parsing_c: parsing_hacks: Commentize
	attributes before qualif/type
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

For the following example from fs/btrfs/ctree.h in Linux v5.6-rc7:

__cold __noreturn
static inline void assertfail(const char *expr, const char *file, int line)
{
	pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
	BUG();
}

__cold and __noreturn are not labeled correctly, leading to C parsing
errors. Add a case to commentize attributes before a storage
qualifier/type qualifier/type correctly.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parsing_hacks.ml | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/parsing_c/parsing_hacks.ml b/parsing_c/parsing_hacks.ml
index 74c3ba60..0254fc7f 100644
--- a/parsing_c/parsing_hacks.ml
+++ b/parsing_c/parsing_hacks.ml
@@ -1952,6 +1952,29 @@ let is_type = function
   | Tshort _ -> true
   | _ -> false
 
+let is_type_qualif = function
+  | Tconst _
+  | Tvolatile _ -> true
+  | _ -> false
+
+let is_storage_spec = function
+  | Tstatic _
+  | Tregister _
+  | Textern _
+  | Tauto _ -> true
+  | _ -> false
+
+let rec is_idents ?(followed_by=fun _ -> true) ts =
+  let rec loop l =
+    match l with
+    | x::xs when ident x -> loop xs
+    | x::xs -> followed_by x
+    | [] -> failwith "unexpected end of token stream" in
+  match ts with
+  | x::xs when ident x -> loop xs
+  | x::xs -> followed_by x
+  | _ -> false
+
 let is_cparen = function (TCPar _) -> true | _ -> false
 let is_oparen = function (TOPar _) -> true | _ -> false
 
@@ -2134,6 +2157,16 @@ let lookahead2 ~pass next before =
 	  else
 	    TCommentCpp (Token_c.CppDirective, i1)
 
+	(* tt xx yy *)
+  | (TIdent (s, i1)::rest, _)
+    when not_struct_enum before
+	&& is_idents
+           ~followed_by:
+             (function x ->
+                is_type x || is_storage_spec x || is_type_qualif x) rest
+        && s ==~ regexp_annot ->
+	    TCommentCpp (Token_c.CppMacro, i1)
+
   | (TIdent (s2, i2)::_  , TIdent (s, i1)::seen::_)
     when not_struct_enum before
 	&& is_macro s2 && is_type seen ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
