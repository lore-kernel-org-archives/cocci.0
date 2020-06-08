Return-Path: <SRS0=02ua=7V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD9EC433DF
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 12:21:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF9312074B
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 12:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS3/9IJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF9312074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 058CL86h024420;
	Mon, 8 Jun 2020 14:21:08 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 51F7D7783;
	Mon,  8 Jun 2020 14:21:08 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5F10644A7
 for <cocci@systeme.lip6.fr>; Mon,  8 Jun 2020 14:21:06 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1035])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 058CL4VK022767
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 8 Jun 2020 14:21:05 +0200 (CEST)
Received: by mail-pj1-x1035.google.com with SMTP id k2so5682759pjs.2
 for <cocci@systeme.lip6.fr>; Mon, 08 Jun 2020 05:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V61hFh062MPOVM6xadp3R7XyrJnfYC9d8EOqi4vVvvo=;
 b=TS3/9IJXWVQKNjleb6c45nn3uwJdId5IKPBDPBZsQOLlTdbRg5QoA3yJg0DpqGzyxT
 RembV061Vh8r8C/Pygn0r3S4CKNrwg7l/DHd8WwYbHshU6Y8ae4WxM9W5TNqgYN9nOhS
 C+qSPyQS0yVip5CLCRdAC7ebqd29yHLFiFqDre/R1qqExwfe7oVcv7qEEkoSpjfbrwRa
 ZzcOMjt8A3AvQ9UeHZfCFXKSVhe8mMAjwwwexLzg0eiYre1Ruifh9xFAXVQiLy4H9Cqx
 O2IPlnsybfaANqOWyfgHi7ktaULaUctnFb82wRtCNkZFdQdiOYk97VMlw7dwAOojRyyr
 LLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V61hFh062MPOVM6xadp3R7XyrJnfYC9d8EOqi4vVvvo=;
 b=NTjDH+n1hm7YXbiOsdH5jWzmNGJAo/xxwlcwB5HFX7/4thcinj9sy+bIvx72R9JEyG
 9sHTQoTdKtv6TMurfP6AEzzSFNBK/ZObuNKZZfXu9kBk9RT3meClucUllZk7ZS18rOuo
 BpDo2R5/jVz5DJE58j0zb8O7cMEKSB17pvtutyaRMZ84y6gduGuTNXfqzAuWR+G0dIqP
 d4mEX7mYdOW5Q5kzNJelwvK5mexteQz6y3mFWynB8E/cM0S3Jbnvou7iQA5uuUEpWQ8l
 Hrn+SMbTBuyvmslZRzifIysgBebOzCfShLnGfhZqUX8pLlLSyowJk6RkuVFY79tX0/Wt
 nq5A==
X-Gm-Message-State: AOAM533Mv9GHqYoQDg6Fmnc9KDvjEgd6bIA8fuHw0TeOcgr6hQ92d7+S
 34tyXYL52WzVow3BvvaCqvh+HwE9
X-Google-Smtp-Source: ABdhPJxEp/w5rHlhfY5OzIkoKwW0J8sfVn60llfvuCtqnPZx4idjz+WpoQ+Uain97dx+18+Ak9JkPQ==
X-Received: by 2002:a17:90a:a405:: with SMTP id
 y5mr16621347pjp.15.1591618863674; 
 Mon, 08 Jun 2020 05:21:03 -0700 (PDT)
Received: from localhost.localdomain
 ([2402:3a80:1863:7add:d8e9:7114:e8b0:51a9])
 by smtp.gmail.com with ESMTPSA id i5sm15747657pjd.23.2020.06.08.05.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 05:21:03 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon,  8 Jun 2020 17:50:37 +0530
Message-Id: <20200608122037.28019-5-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200608122037.28019-1-jaskaransingh7654321@gmail.com>
References: <20200608122037.28019-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 14:21:08 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 08 Jun 2020 14:21:05 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 4/4] parsing_c: parser: Use end_attributes_opt in
	cpp_other
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

The cpp_other rule has redundant code due to an additional production
for end attributes. Use end_attributes_opt to resolve this.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parser_c.mly | 34 +---------------------------------
 1 file changed, 1 insertion(+), 33 deletions(-)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index 61bb1ca0..10cd4435 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -2202,39 +2202,7 @@ cpp_other:
     * the rule are slightly different, they can't be statement and so expr
     * at the top, only decl or function definition.
     *)*/
- | identifier TOPar argument_list TCPar TPtVirg
-     {
-       if args_are_params $3
-       then
-	 (* if all args are params, assume it is a prototype of a function
-	    with no return type *)
-	 let parameters = args_to_params $3 None in
-	 let paramlist = (parameters, (false, [])) in (* no varargs *)
-	 let id = RegularName (mk_string_wrap $1) in
-	 let ret =
-	   warning "type defaults to 'int'"
-	     (mk_ty defaultInt [fakeInfo fake_pi]) in
-	 let ty =
-	   fixOldCDecl (mk_ty (FunctionType (ret, paramlist)) [$2;$4]) in
-	 let attrs = Ast_c.noattr in
-	 let sto = (NoSto, false), [] in
-	 let iistart = Ast_c.fakeInfo () in
-	 Declaration(
-	 DeclList ([{v_namei = Some (id,NoInit); v_type = ty;
-                      v_storage = unwrap sto; v_local = NotLocalDecl;
-                      v_attr = attrs; v_endattr = Ast_c.noattr;
-		      v_type_bis = ref None;
-                    },[]],
-                   ($5::iistart::snd sto)))
-       else
-	 Declaration
-	   (MacroDecl
-             ((NoSto, fst $1, $3, Ast_c.noattr, true),
-               [snd $1;$2;$4;$5;fakeInfo()]))
-           (* old: MacroTop (fst $1, $3,    [snd $1;$2;$4;$5])  *)
-     }
-
- | identifier TOPar argument_list TCPar end_attributes TPtVirg
+ | identifier TOPar argument_list TCPar end_attributes_opt TPtVirg
      {
        if args_are_params $3
        then
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
