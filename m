Return-Path: <SRS0=pTva=3Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BE2C35254
	for <cocci@archiver.kernel.org>; Wed,  5 Feb 2020 13:04:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B782F217F4
	for <cocci@archiver.kernel.org>; Wed,  5 Feb 2020 13:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3K3EBL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B782F217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 015D40Xg016253;
	Wed, 5 Feb 2020 14:04:00 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D0CF2772B;
	Wed,  5 Feb 2020 14:04:00 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4F0B77718
 for <cocci@systeme.lip6.fr>; Wed,  5 Feb 2020 14:03:59 +0100 (CET)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:444])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 015D3vET000350
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 5 Feb 2020 14:03:58 +0100 (CET)
Received: by mail-pf1-x444.google.com with SMTP id y5so1172583pfb.11
 for <cocci@systeme.lip6.fr>; Wed, 05 Feb 2020 05:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T4sLQ+yI9jhZw7bh/zJf2U1VnqtoyxbY1frYKtrY/R0=;
 b=A3K3EBL1QRuFMDBs0znyuc4E9dv/nt7AJOZBFb8l8+1duBy7DDVZwnCX0OiZKiwELU
 5/3t1a9Ql6KldFNvvmfmi2wdTbrRi0/wn11u5DjuMjiQJ1JKERGaXyxzPsi34icXZ/qp
 mcPKH0Dg610caJAv9mlswkhcI+F7psDd1YIH7vKFmzuKx3vilSeH+vys9jQBYz+YduUc
 Yj/mEm2Sd1NIr1tmENASa0Snja6w3h1b5FT1znUBDoBL6SfuJw8ytIMJHK4wnkUiNnaJ
 8dw/sGV5FH5shvlDF3y0MtaqlCOYfVoRQ0u1D92vKfRDATDE77/wxMTz+VuagrocEwaZ
 D9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T4sLQ+yI9jhZw7bh/zJf2U1VnqtoyxbY1frYKtrY/R0=;
 b=mfoqqaZBg7uU9ugLQ5nXyIc8dYqDrZkH485Rka7kPosLXbV/omi4wvf5l7UJKjKlRy
 eZm7aMPAbjxT+jpoeOyqU0GCb6j/SbkfpI8HdiMLzZ0HU4PtR0gaI1Nam+97WyfAK1DD
 TIJre7N+3ifjD5K023ElV8N3QA75KjKJgYmLYJe+w3vyGXoZx8vag0zuXm0QFBWrfGuB
 av8S/woHVQrOVju+je9FwpR3FwA9f9niIg8RzRK0VHZVYOy95lR8TXk4SgqZlrcBLgYt
 yO1REayfiQjtDKlJXyvz6CggUh304zPdMrgkyNsYYsK+S/jqfkxvjPc1Bx7OR8UCHQHv
 qsoA==
X-Gm-Message-State: APjAAAWWDIHlzfZTE7ssELv+zpHxN37XqKLozNjfERcQppP1OqWkeNxg
 1pt1FvZabGjMgAuJRG27dpEKiujBeLU=
X-Google-Smtp-Source: APXvYqyhGdZ0ThCNxogrLhW45GWXOZVFOCGmQOXBGaDHxjSjVjB51HYpcxItMLMFlYVamj+laMi9Iw==
X-Received: by 2002:a62:7bcb:: with SMTP id
 w194mr37228503pfc.216.1580907836543; 
 Wed, 05 Feb 2020 05:03:56 -0800 (PST)
Received: from localhost.localdomain ([2405:204:30e:4a31:b268:7a3:7dc6:f288])
 by smtp.gmail.com with ESMTPSA id
 q6sm28137098pfh.127.2020.02.05.05.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 05:03:56 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Wed,  5 Feb 2020 18:33:26 +0530
Message-Id: <20200205130327.6812-2-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200205130327.6812-1-jaskaransingh7654321@gmail.com>
References: <20200205130327.6812-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 05 Feb 2020 14:04:00 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 05 Feb 2020 14:03:58 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 1/2] parsing_c: Align C AST and Cocci AST for pointer
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

For a pointer, the C parser constructed an AST dissimilar from that
of the Cocci AST. This caused failures in matching with certain
pointer types. For example, for the following case:

char *1 const *2 id;

The C AST constructed would be:
const Pointer1 -> Pointer2 -> char

The Cocci AST constructed would be:
Pointer2 -> const Pointer1 -> char

Change the pointer rule in the C parser so that an AST similar to the
Cocci AST is constructed.

Make necessary changes in the C pretty printer so that the pointer type
is printed correctly.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parser_c.mly      | 4 ++--
 parsing_c/pretty_print_c.ml | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index 8d7b761e..4c74f15a 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -1333,14 +1333,14 @@ pointer:
  | tmul                   { (Ast_c.noattr,fun x -> mk_ty (Pointer x) [$1]) }
  | tmul pointer
      { let (attr,ptr) = $2 in
-       (attr,fun x -> mk_ty (Pointer (ptr x)) [$1]) }
+       (attr,fun x -> ptr (mk_ty (Pointer x) [$1])) }
  | tmul type_qualif_list
      { let (attr,tq) = $2 in
        (attr,fun x -> (tq.qualifD, mk_tybis (Pointer x) [$1]))}
  | tmul type_qualif_list pointer
      { let (attr1,tq) = $2 in
        let (attr2,ptr) = $3 in
-       (attr1@attr2,fun x -> (tq.qualifD, mk_tybis (Pointer (ptr x)) [$1])) }
+       (attr1@attr2,fun x -> ptr (tq.qualifD, mk_tybis (Pointer x) [$1])) }
 
 tmul:
    TMul { $1 }
diff --git a/parsing_c/pretty_print_c.ml b/parsing_c/pretty_print_c.ml
index a2e35588..40b89fe5 100644
--- a/parsing_c/pretty_print_c.ml
+++ b/parsing_c/pretty_print_c.ml
@@ -804,11 +804,12 @@ and pp_string_format (e,ii) =
              (FunctionType (return=void, params=int i) *)
           (*WRONG I THINK, use left & right function *)
           (* bug: pp_type_with_ident_rest None t;      print_ident ident *)
+          pp_type_left t;
           pr_elem i;
           iiqu +> List.iter pr_elem; (* le const est forcement apres le '*' *)
           if iiqu <> [] || get_comments_after i <> []
           then pr_space();
-          pp_type_with_ident_rest ident t attrs Ast_c.noattr;
+          print_ident ident
 
       (* ugly special case ... todo? maybe sufficient in practice *)
       | (ParenType ttop, [i1;i2]) ->
@@ -885,11 +886,12 @@ and pp_string_format (e,ii) =
       match ty, iity with
 	(NoType,_) -> failwith "pp_type_left: unexpected NoType"
       | (Pointer t, [i]) ->
+          pp_type_left t;
           pr_elem i;
           iiqu +> List.iter pr_elem; (* le const est forcement apres le '*' *)
           if iiqu <> [] || get_comments_after i <> []
           then pr_space();
-          pp_type_left t
+          ()
 
       | (Array (eopt, t), [i1;i2]) -> pp_type_left t
       | (FunctionType (returnt, paramst), [i1;i2]) -> pp_type_left returnt
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
