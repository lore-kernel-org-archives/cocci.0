Return-Path: <SRS0=cw0N=6I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8B9C55194
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8554D20724
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkF5DY46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8554D20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03O9JFi1006260;
	Fri, 24 Apr 2020 11:19:15 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9657B7827;
	Fri, 24 Apr 2020 11:19:15 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 29F397815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:13 +0200 (CEST)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03O9JBSP006224
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:12 +0200 (CEST)
Received: by mail-pj1-x1041.google.com with SMTP id t40so3697437pjb.3
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 02:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BSXy7p3ASCxK8X1Fpi/Kk/DjgU4d+i+CiSo8ebcoGBU=;
 b=CkF5DY46Av8t7kqNHJl/EnKarmm45YwT+fKvzf3VDrf7Bh6H+t/SyEZF6A8gYfxplu
 oOUJasKEi/OuF1iDiZTMgnj2C2YGszbFh4t9kcp3c4DLO3zd3d3EU9C8OzK4PkO3KmWr
 Bb6qs8+FEsgUOIeRchREtuuKSigoVNQCcRBXbpnDWlFi9h2JER3aaZhbsT3KMkEjFoDS
 qf13sfHpjLr+LeQGmC/Fh4s3Vv5gEeykUm/Dnd6Yh0iU+otaf3lt8TbHHoWRGqIPst+8
 1XM/aETElq1f0Ayk4OGMavCyXQHo8hTeMXfj7tKjuPU0LQzdHQBubeSXar6Ir3v9rv4e
 lXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BSXy7p3ASCxK8X1Fpi/Kk/DjgU4d+i+CiSo8ebcoGBU=;
 b=NUhaboLHu5q1E2EvHg566oWIXgV5FYLN02XMVgtncZziTwllETdBUF0GFkEvjoyn1U
 J3Pv4UxfBJhfTsMMdQ/MZwtDbrAqR7xHP5FMAiXlhur0j2uIgq2Ke+/kn8ZzRD2JcNFa
 P/7cwaFK7sKj1WBtxV0+nGNlFFDQL4XaSn88/ULt2rXXwozZpPiCyhd4b+QZGse/FeIB
 /RiO0ynookzTj3f3gswwXxdcnvaBfsXKJScqgH98xYX2+mDMeqimOeRoaFVxm2maTuyE
 nOz/xMKKZ2sNJBwuTw0qGMwnJvkrW/Gf1pDuyxaJd8Ynq1quhT6y3Azl5hkDxU2br8uz
 LplA==
X-Gm-Message-State: AGi0PuZFP3zlck4iF/Se7fbX0uaCJow4QodCA5HmCRa2n3ItNMWvySiD
 J9iO9XBGUdYs8UxLtLIa78GC4e80Nvc=
X-Google-Smtp-Source: APiQypKfKqxVyZUaah9B0bt9Oq1oy81MEEPwBHJYyG19yS8UUql75qd2rpeI6Pxf6c6CI5s+H6kwDg==
X-Received: by 2002:a17:90a:82:: with SMTP id a2mr5533209pja.47.1587719950493; 
 Fri, 24 Apr 2020 02:19:10 -0700 (PDT)
Received: from localhost.localdomain ([1.38.216.60])
 by smtp.gmail.com with ESMTPSA id c80sm5043933pfb.82.2020.04.24.02.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 02:19:10 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 24 Apr 2020 14:47:47 +0530
Message-Id: <20200424091801.13871-12-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
References: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 11:19:15 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 24 Apr 2020 11:19:12 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [RFC PATCH 11/25] parsing_c: parser: cpp_other end
	attributes production
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

Add a production for a macro call in the cpp_other rule of Coccinelle's
C parser. This parses the following C code from Linux v5.6-rc7
successfully:

  arch/x86/kernel/irq_64.c:

	DEFINE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store) __visible;

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parser_c.mly | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index eb22cbcf..da6b9c7b 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -2262,6 +2262,37 @@ cpp_other:
            (* old: MacroTop (fst $1, $3,    [snd $1;$2;$4;$5])  *)
      }
 
+ | identifier TOPar argument_list TCPar end_attributes TPtVirg
+     {
+       if args_are_params $3
+       then
+	 (* if all args are params, assume it is a prototype of a function
+	    with no return type *)
+	 let parameters = args_to_params $3 None in
+	 let paramlist = (parameters, (false, [])) in (* no varargs *)
+	 let id = RegularName (mk_string_wrap $1) in
+	 let ret =
+	   warning "type defaults to 'int'"
+	     (mk_ty defaultInt [fakeInfo fake_pi]) in
+	 let ty =
+	   fixOldCDecl (mk_ty (FunctionType (ret, paramlist)) [$2;$4]) in
+	 let attrs = Ast_c.noattr in
+	 let sto = (NoSto, false), [] in
+	 let iistart = Ast_c.fakeInfo () in
+	 Declaration(
+	 DeclList ([{v_namei = Some (id,NoInit); v_type = ty;
+                      v_storage = unwrap sto; v_local = NotLocalDecl;
+                      v_attr = attrs; v_endattr = $5;
+		      v_type_bis = ref None;
+                    },[]],
+                   ($6::iistart::snd sto)))
+       else
+	 Declaration
+	   (MacroDecl((NoSto, fst $1, $3, true), [snd $1;$2;$4;$6;fakeInfo()]))
+           (* old: MacroTop (fst $1, $3,    [snd $1;$2;$4;$5])  *)
+     }
+
+
  /* cheap solution for functions with no return type.  Not really a
        cpp_other, but avoids conflicts */
  | identifier TOPar argument_list TCPar compound {
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
