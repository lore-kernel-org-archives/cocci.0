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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74680C433DF
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:22:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3A3C207DA
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bknaAKrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A3C207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHMnSM022543;
	Sun, 24 May 2020 19:22:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 675BF3DC8;
	Sun, 24 May 2020 19:22:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5B70B3D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:22:48 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:644])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHMkct029276
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:22:47 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id x11so5632102plv.9
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NBWu/XHzPYAwW6zcyT2ksTuyYehC4xbj5Y/cE5yhHZs=;
 b=bknaAKrh4Ko3mW4EF6XDbc3pnuI9qsCbyF5QexeUo80nhGacE9BSof6Qg1tFxkdh48
 8dl/5NIkW9/ch7TwF0hbsjoyTpdzghAJbSA/SssQF96YWDSXjfesyiQm274iVsTsQs3f
 AhGvcAZptFsu7ePmb/1ztMpmBB9lEtK+W6gZGVD+WZPRAzpiA2uKmMxLfwWwT1++hNPm
 sjwMjDGZhSGbWnLiAMHtpjwESLa+03zd5tN7vC3VTIPBNpELIfmu3jyFBTCTL76Hv7TH
 eJaZlNitIBGZnGtaYi+yULefNXNhBcjSi1Vzo3fs0jyeqcJYOxmvvF0KC2LKTGYvlbaR
 jCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NBWu/XHzPYAwW6zcyT2ksTuyYehC4xbj5Y/cE5yhHZs=;
 b=Pc5XZfsxefrnBIZqTsQqL7lKkg+8zC90RRIUt53Shy5Z0zQqPnlr2p0hRBx1mOgVDP
 5SnhfdjSub03Go4ZYp/kPrbRVGlwDdDgj4JFM5g6Ccz0qMo48WZ3FzjW+ZSMc0I4ZJi/
 /Mpku/8nj6NwzTNkXF8ckP5//TjBmr5AEcU4GnIXcjJFHo7/69VITfQSJ8HglvTyQSYT
 7FTGHl++QKpuUxcKm7eh6pE8IBIUZvWcgMtknGnrf3g65MGy5fClxoMMILKMQI2nYWwr
 /oCYNc8v6QbxrtLsaqufwyl30aPGTJ1E+oEaVcGsWqfjRGCjMux5Ce7fRO9AbLMSgOb8
 de3Q==
X-Gm-Message-State: AOAM533hV9I8O8hqyiTrCD0QGvLoJoJ1G0Ru+U4ERkLRZHUnbTyJk3Os
 njfIvPpJxB5BnnAFqtQ7tP7b/gOdxwk=
X-Google-Smtp-Source: ABdhPJzxsUKl2vvRNpsAgE4SJ2mSswLTVPzUz7xGdeaM7SLBorfGbz2MFN1Fl5WWfm2fgg+ymlWXiQ==
X-Received: by 2002:a17:902:7488:: with SMTP id
 h8mr24941746pll.128.1590340964647; 
 Sun, 24 May 2020 10:22:44 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:22:44 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:33 +0530
Message-Id: <20200524171935.2504-29-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:22:49 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:22:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 28/30] tools: spgen: Reflect Macrodecl attributes
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
spgen.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tools/spgen/source/meta_variable.ml      | 2 +-
 tools/spgen/source/position_generator.ml | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/spgen/source/meta_variable.ml b/tools/spgen/source/meta_variable.ml
index 2197a3f6..31456614 100644
--- a/tools/spgen/source/meta_variable.ml
+++ b/tools/spgen/source/meta_variable.ml
@@ -538,7 +538,7 @@ let metavar_combiner rn =
         meta_mc_format ~mc ~typ:"declaration " ~constr
     | Ast0.AsDecl(dc1, dc2) ->
         let dec = c.VT0.combiner_rec_declaration in as_format dc1 dc2 dec dec
-    | Ast0.MacroDecl(_, id, _, expdots, _, _) ->
+    | Ast0.MacroDecl(_, id, _, expdots, _, _, _) ->
         let expids = c.VT0.combiner_rec_expression_dots expdots in
         MVSet.union (ids ~rn ~typ:"declarer" ~id) expids
     | Ast0.MacroDeclInit(_, id, _, expdots, _, _, ini, _) ->
diff --git a/tools/spgen/source/position_generator.ml b/tools/spgen/source/position_generator.ml
index 757faf5f..618ba19b 100644
--- a/tools/spgen/source/position_generator.ml
+++ b/tools/spgen/source/position_generator.ml
@@ -419,8 +419,8 @@ let rec declaration_pos decl snp
   | Ast0.Typedef (tm, tc, tc2, sem) ->
       let constructor ~mc = Ast0.Typedef (mc, tc, tc2, sem) in
       mcode_wrap ~mc:tm ~constructor snp
-  | Ast0.MacroDecl (st,id,lp,ed,rp,sem) ->
-      let constructor ~id = Ast0.MacroDecl (st, id, lp, ed, rp, sem) in
+  | Ast0.MacroDecl (st,id,lp,ed,rp,attr,sem) ->
+      let constructor ~id = Ast0.MacroDecl (st, id, lp, ed, rp, attr, sem) in
       id_wrap ~id ~constructor snp
   | Ast0.MacroDeclInit (st,id,lp,ed,rp,eq,init,sem) ->
       let constructor ~id = Ast0.MacroDeclInit (st,id,lp,ed,rp,eq,init,sem) in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
