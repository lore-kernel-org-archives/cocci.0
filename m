Return-Path: <SRS0=Ekfz=33=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEEAC2D0B1
	for <cocci@archiver.kernel.org>; Fri,  7 Feb 2020 06:10:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC5320838
	for <cocci@archiver.kernel.org>; Fri,  7 Feb 2020 06:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDNNWLWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC5320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0176A18X018826;
	Fri, 7 Feb 2020 07:10:01 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 230D877EF;
	Fri,  7 Feb 2020 07:10:01 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3D033772B
 for <cocci@systeme.lip6.fr>; Fri,  7 Feb 2020 07:09:59 +0100 (CET)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 01769v80012234
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 7 Feb 2020 07:09:58 +0100 (CET)
Received: by mail-pg1-x542.google.com with SMTP id l24so578773pgk.2
 for <cocci@systeme.lip6.fr>; Thu, 06 Feb 2020 22:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T4sLQ+yI9jhZw7bh/zJf2U1VnqtoyxbY1frYKtrY/R0=;
 b=mDNNWLWUjDxuCXdaSF0Q2QW0Gf49iK+0Pfn3phmeotKSk+LR1dawX+gcaXeoG7+3Ye
 erg0aDnausUAaEW8XNVvAJ5+TKCuDaIKqnhxqv1PFUh+zq6wrJEVGke4R+8/eQEIF1oT
 ayEuc4sQk4IBIUGehA8dCq945gaMBcixni3iSR2hNUAjPZXwa30EPvDY3aT+aDYCp4y3
 8zsC2JBWUSuTKWnxvuXFzC0kvi/WjGICnX/Jd8duR83I0YBCnN1Sst4Rd3Go8WriiBxI
 JNEgJGb/1yJ8ahkS11g8eE5oonSWfTBIGXCmbyJtqjmGdCSrtLIJAPZheZ3wZlcQnHzJ
 125A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T4sLQ+yI9jhZw7bh/zJf2U1VnqtoyxbY1frYKtrY/R0=;
 b=PEJ5s7v5Rot6TYjg4CTvVlD1lXcX4hcuabbV7e60wuNInqCne8afoeXPHgzaLaFCjA
 4Ht+/vjmPVoeVk0mL9/EChqVJEYomMOWqpUrAWVwyYc0qk0I68G0atyVmDBrPi1JDvLt
 lFHDkXZEuXwCbp951ZnFZHUC6WrVAczvcIKTFyvZf4WdJbKGoLL/LhRTPpueaehND2ke
 y3KNff6fumFYhH6+zdJtFM3eGdNnS2GhXpO1hACGnNEcTH+pLvpn8HB0dkERRNaoQM8E
 PCz87V3PGPT5I8VPPBbTdrBUffnBvCfHoCA+T+xomnbQ9qoYlU39vTyztfyNlfgpDQcK
 JeeA==
X-Gm-Message-State: APjAAAWD1hlhvcLkpWggsynPcFDe5zgq8YWSIOvULIb8F8Utb1EOZSdV
 3Top8pj2/uokzIxZypy8b5CxOMn5
X-Google-Smtp-Source: APXvYqx6DK2awN255gnmj2F5KXWBAbdPnG9/UxzxHZSIAc5NotLSZcQRoVu3kLbVupSQiGGhioGZTQ==
X-Received: by 2002:a62:7683:: with SMTP id r125mr8310239pfc.132.1581055796656; 
 Thu, 06 Feb 2020 22:09:56 -0800 (PST)
Received: from localhost.localdomain ([2405:204:30e:4a31:b268:7a3:7dc6:f288])
 by smtp.gmail.com with ESMTPSA id
 b130sm1243438pga.4.2020.02.06.22.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 22:09:56 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri,  7 Feb 2020 11:39:37 +0530
Message-Id: <20200207060938.9531-2-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200207060938.9531-1-jaskaransingh7654321@gmail.com>
References: <20200205130327.6812-1-jaskaransingh7654321@gmail.com>
 <20200207060938.9531-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 07 Feb 2020 07:10:01 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 07 Feb 2020 07:09:58 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 1/2] parsing_c: Align C AST and Cocci AST for
	pointer
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
