Return-Path: <SRS0=+m3J=5B=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D69C18E5B
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7C420663
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMAkz2y6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7C420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GA4Iv8012215;
	Mon, 16 Mar 2020 11:04:18 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 220F77809;
	Mon, 16 Mar 2020 11:04:18 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1631C7802
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:17 +0100 (CET)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:643])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GA4FxC011394
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:16 +0100 (CET)
Received: by mail-pl1-x643.google.com with SMTP id ay11so7788794plb.0
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 03:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LowBblvxuIcW1zcDuNk5uVX3z82/+a6o2QZfaKC6TiY=;
 b=UMAkz2y6omE2d6AQY8uu/InxrnWpXaJiU2nBS2xci2zQUxUCCzxeBTl917PINm25dU
 HTVeQlctluHKJ4hLiZ/HsOixZD1CapHHqUI+6USLi8uHsbIAvskWm14Etybl4GpPJ1dA
 JCOBM2yfJxmyd/CkCpJwZ/0IakisnjtR6tkJNEzMg/BPPDlSIGi9Qt2mwzEEIrfYhhGH
 DLMqvvIITIiP44g9RpniDOPXs2O8t/ba7Rl2mRRMPfDuqB2iSNyLLirPrr9Ff55JMid9
 2lnp/IFDH/fVNeOXByc1ku394jKTPnYWL7QdejMLp5ItVFAyQAe3IhFG95R6HfGucyJX
 CM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LowBblvxuIcW1zcDuNk5uVX3z82/+a6o2QZfaKC6TiY=;
 b=sGDWR3QvKEuHFSr0dE3zjk3X6xlNmSovfaNDDJIpYkTP4TWeDhyh/GSXU9TK0P8BWx
 TwkyaSw1UrQXAoVXO/QrywyMMho21tUIxpFuZfhiaDv1GkGC9UCtZLxU2GZz8BCfpLKn
 b6lgTaxs3WYVwrnIEkss0JtiXdtgx1339seI4QE+X46G16CmewUtwQC0OHyR/XKLlhay
 MgqPUPkqEo9pvobPFq0P7sSgO6bZ862c1EicDOipYYID5t8XpQMcs09cWux+PFJFb2Lm
 Q0C59ZGmsUSqSFXjoeZoymk9LxaLzqa5N4azSeS8rEFPRc1bK+fX2JbgZXAs0Bk0BtdN
 1FqQ==
X-Gm-Message-State: ANhLgQ2cBVx23I107J0HoQ2+S+viclWgdlgsPJ6XL0p5MUZ79fXZtsR/
 QfQlQayay6gj6jK4LrZ9a0rWDvoE
X-Google-Smtp-Source: ADFU+vtitsMxENXb1Hg80coMBmOOUvnulCqfImP5eNkhErqBlAMdUTq8j7kefjEH8D3HctxzPYjmtQ==
X-Received: by 2002:a17:90b:3c3:: with SMTP id
 go3mr25565418pjb.10.1584353054611; 
 Mon, 16 Mar 2020 03:04:14 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:284:a4f2:cc63:b7fc:551c:dce5])
 by smtp.gmail.com with ESMTPSA id
 u3sm19803374pjv.32.2020.03.16.03.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:04:14 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 16 Mar 2020 15:33:06 +0530
Message-Id: <20200316100319.27935-14-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 11:04:18 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 16 Mar 2020 11:04:16 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 13/26] parsing_cocci: iso_pattern: Add cases for
	ParenType/FunctionType
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

ParenType and FunctionType are now added to the SmPL ASTs. Add
cases for these types in iso_pattern.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/iso_pattern.ml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/parsing_cocci/iso_pattern.ml b/parsing_cocci/iso_pattern.ml
index 5ceb2bdb..6d51b072 100644
--- a/parsing_cocci/iso_pattern.ml
+++ b/parsing_cocci/iso_pattern.ml
@@ -1818,6 +1818,11 @@ let instantiate bindings mv_bindings model =
                           Ast0.rewrap ty (
                             Ast0.FunctionPointer(
                               renamer ty', s0, s1, s2, s3, p, s4))
+                      | Ast0.ParenType(s0, ty', s1) ->
+                          Ast0.rewrap ty (Ast0.ParenType(s0, renamer ty', s1))
+                      | Ast0.FunctionType(ty', s0, s1, s2) ->
+                          Ast0.rewrap ty (
+                            Ast0.FunctionType(renamer ty', s0, s1, s2))
                       | Ast0.Array(ty', s0, e, s1) ->
                           Ast0.rewrap ty (Ast0.Array(renamer ty', s0, e, s1))
                       | Ast0.Signed(s, ty') ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
