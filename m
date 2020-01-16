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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB60C33CB1
	for <cocci@archiver.kernel.org>; Thu, 16 Jan 2020 10:45:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B4E2077B
	for <cocci@archiver.kernel.org>; Thu, 16 Jan 2020 10:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVZYiDIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B4E2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00GAjc7i019222;
	Thu, 16 Jan 2020 11:45:38 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5521977E5;
	Thu, 16 Jan 2020 11:45:38 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9A235771F
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 11:45:36 +0100 (CET)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00GAjU2X017005
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 11:45:30 +0100 (CET)
Received: by mail-pj1-x1044.google.com with SMTP id m13so1396299pjb.2
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 02:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ex4OpoXhleZNUbW/w3vikQv0S0zC32mRFBrGjoUHC1o=;
 b=fVZYiDIgl4V3ZpZPlOo0xQj10TQS//dYIo0u6LdZ3puzdiC9kkMQEhH59CHEliLA+V
 +bGoCENguiIQQdRLSyeQ2ZIKrG5YFRwEDwk2Ww/RfEeluh4ZLGbkugQNVZdcv1ottEV6
 aunBWpxmhtw+tG7lu7MlKArDxjKalA8Ta5KgTW1g3OmcWKjQ+7Rei4QX+A+c1SJXbTYz
 6s/rVZwzPPUUa6yuvSXU9tc0JRePyf0X/+ThNvwfjqxXdr+ri5QAZDftcpF9YlqIDZYg
 eCzulJoH/1jwNMYMNmocnW6b+IcoNDuhmdUr/8LtwG2tvsAqSGjpap5KqeLCMsjS1pkz
 DSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ex4OpoXhleZNUbW/w3vikQv0S0zC32mRFBrGjoUHC1o=;
 b=UnQ5kZ0wCgVx43TzyFp3ryfuI9NsqFu08mKK2E8dlDwdnobbuoGYgU2mqjBUvt7mox
 taXwvMksdwIz0vJ0hQGXqR4PJTDdy2rpRSXjyy9Ztv7uvUKps+oEnk/ifjv7fKxrmBs2
 Ifpab86oiVK4XFqvPpqxEWKzDqidm8a1/P/dMK63pV6czhx/5+Pn/MP39fKWx2fVunLm
 bu5KQKj3qf/J11FZI1IxcSw5jm5KwZsOc02wB3SC63BLdwAeEcnnKyqRg55I/Kkcxz/O
 EM1RmF7m8DYGkKTD74gAaqpeqRDBwoAT2M4D/xSVYUWzXsd7JYGgap1nz13kw9vHJSYW
 wVXA==
X-Gm-Message-State: APjAAAU/xO13gIAwO6hoDyBgGGW9N24MWDyM6ObbbOUt0YfJFquuorTs
 AplhgMIRXM6tpvdRlQTQ0cHF8per
X-Google-Smtp-Source: APXvYqwTZugt0ddkHy4toL2lxGjPf2mMr3yhNemKd5cMKfEWiMmHJvTTNK5eRrq/y92NcTOoTRAeNQ==
X-Received: by 2002:a17:902:248:: with SMTP id
 66mr38245416plc.158.1579171529408; 
 Thu, 16 Jan 2020 02:45:29 -0800 (PST)
Received: from localhost.localdomain
 ([2402:3a80:1677:7d6f:b2c8:b07a:d4f3:9a2c])
 by smtp.gmail.com with ESMTPSA id a69sm25948799pfa.129.2020.01.16.02.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 02:45:28 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 16 Jan 2020 16:14:47 +0530
Message-Id: <20200116104448.15539-2-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200116104448.15539-1-jaskaransingh7654321@gmail.com>
References: <20200116051843.3328-1-jaskaransingh7654321@gmail.com>
 <20200116104448.15539-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 16 Jan 2020 11:45:38 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 16 Jan 2020 11:45:30 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 1/2] parsing_c: Add space for tokens after *
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
