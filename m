Return-Path: <SRS0=PnfW=3F=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA6BC33CB1
	for <cocci@archiver.kernel.org>; Thu, 16 Jan 2020 05:20:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD692077B
	for <cocci@archiver.kernel.org>; Thu, 16 Jan 2020 05:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgV47qQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD692077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00G5JrdM001649;
	Thu, 16 Jan 2020 06:19:54 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CBA4177E5;
	Thu, 16 Jan 2020 06:19:53 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9A217771F
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 06:19:51 +0100 (CET)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00G5Jomb011395
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 06:19:50 +0100 (CET)
Received: by mail-pg1-x541.google.com with SMTP id x8so9293121pgk.8
 for <cocci@systeme.lip6.fr>; Wed, 15 Jan 2020 21:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ex4OpoXhleZNUbW/w3vikQv0S0zC32mRFBrGjoUHC1o=;
 b=UgV47qQ0SFDm6Qhe3ZnD87sXeV0gJAaazWschloJ2HqdPf9gVV6Kc2qEBsTPA795l6
 /+mXHEci9yxD6qKY6KLxphbBa8t/j3zstcKylDBsp+ugIVpnRLFwYBXEnVDhqKok8IVB
 4qyHboUwGx4kllH4vXW8/5Oi8kGYoWgq1s4VD8FKvExHkUXvRafbk70bixKMwYdOIQqp
 T1io+2EWUAkw4IRKoQ1RszRW1chSG0ErwVcndcgfEoQgldP6tfML45d9kdSFqqmEjoQp
 9Fh6MvXM87tUYhzaQwiC3fne3LSuvpnTSwBCD3iuQOCtZvD9tmCUTVCPE6BKBMyRjWJq
 DjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ex4OpoXhleZNUbW/w3vikQv0S0zC32mRFBrGjoUHC1o=;
 b=ZAF2c51TGF15BBQpcWH1pAxQn7G87umMbvWUaeWsFxW6luW9p6xampzPw1Hj4KyEHm
 tSL+2ENN45Q8u102RMA40NMgbdhmXcU+rfoj3Itkujj4mJBfnavDPBbmbawN57z7eFf5
 hHkUG5PGa8wYKlJZ1sdoMiwaxRceYeYlsg+i/8TEGREZ0XEJ0DYxoT93wcfRuWg1E5/H
 gskoO7x/JiTs2tj4JVQUq03iTnTtST6mWmlb3dJEJoF7qzhYavPzGrkncOIFrT1mx4/5
 xgOLwuZ9VDPZE5dkZ490uZoCtrirae4MYs9cH++ApzVkDKXFFfuHlEV5j8TxwVS613qK
 1FkQ==
X-Gm-Message-State: APjAAAWXdW/IyNSdRU4TEkcXcp/uha9fh1bgEBCaERwtWxdY+gGOkM9Z
 PVAWkJ7PJxMluURwtpGYlDwKO1ERzOw=
X-Google-Smtp-Source: APXvYqy+4mxpXAwMk/pxGcW6vkGIBjmsiXc6gO6COZF9SBrvPjyd3dcvaIN/Tb6AXwVtG4LDjjaGuQ==
X-Received: by 2002:aa7:9510:: with SMTP id b16mr35060886pfp.65.1579151989448; 
 Wed, 15 Jan 2020 21:19:49 -0800 (PST)
Received: from localhost.localdomain
 ([2402:3a80:1677:7d6f:b2c8:b07a:d4f3:9a2c])
 by smtp.gmail.com with ESMTPSA id z4sm23361087pfn.42.2020.01.15.21.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 21:19:48 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 16 Jan 2020 10:48:43 +0530
Message-Id: <20200116051843.3328-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 16 Jan 2020 06:19:54 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 16 Jan 2020 06:19:50 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH] parsing_c: Add space for tokens after *
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

In certain cases, there is no space added after the Pointer type.
Examples of such cases are * const, * __attr and * const *.

In the Pointer case of pp_type_with_ident_rest and pp_type_left, if
the * is followed by anything within the type, add a space after the
printing.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/pretty_print_c.ml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/parsing_c/pretty_print_c.ml b/parsing_c/pretty_print_c.ml
index ccf8214d..a2e35588 100644
--- a/parsing_c/pretty_print_c.ml
+++ b/parsing_c/pretty_print_c.ml
@@ -806,6 +806,8 @@ and pp_string_format (e,ii) =
           (* bug: pp_type_with_ident_rest None t;      print_ident ident *)
           pr_elem i;
           iiqu +> List.iter pr_elem; (* le const est forcement apres le '*' *)
+          if iiqu <> [] || get_comments_after i <> []
+          then pr_space();
           pp_type_with_ident_rest ident t attrs Ast_c.noattr;
 
       (* ugly special case ... todo? maybe sufficient in practice *)
@@ -885,6 +887,8 @@ and pp_string_format (e,ii) =
       | (Pointer t, [i]) ->
           pr_elem i;
           iiqu +> List.iter pr_elem; (* le const est forcement apres le '*' *)
+          if iiqu <> [] || get_comments_after i <> []
+          then pr_space();
           pp_type_left t
 
       | (Array (eopt, t), [i1;i2]) -> pp_type_left t
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
