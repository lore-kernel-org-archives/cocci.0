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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43630C433DF
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:24:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D73D620888
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osaOr30i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73D620888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04SCOpAn027853;
	Thu, 28 May 2020 14:24:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AFE177829;
	Thu, 28 May 2020 14:24:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B2A9B3E1D
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:24:49 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04SCOme8024661
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:24:49 +0200 (CEST)
Received: by mail-pj1-x1042.google.com with SMTP id a45so669645pje.1
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 05:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hdwzt3tFXKWyJadRRPoBDmhsTEk2PAGDfRjvzOl8MPs=;
 b=osaOr30ibutOXeO7u8Q/af6xtS5AxKiJ8tjIr2a2XqdqHKMWmhSQTtVYQkCVLh74Gx
 DRnzm+Ogzo9+zJntpQ93b5vU2L12bezl5Ap9bWZ8lfplVrvbF/qrDDUjF4H1bBwKrDHD
 r89BNNeBwdgl0Vzml1sy4toTTvkP3XbrTBNZkfV+O/ejoCJUBNAYAtd7/WTvnz6DMfRJ
 G4RPbqNSeMVQIg2CvIMeXXtE1lbWl0jGPPBzdH1DgsSd2PfJgmnXzEhI2+15Zg5PNfBt
 dJUh7R1yRjHy0y/unZ9FxxU9AIEw6SCokpMaXn250Fb/1DfEKhZfbRbqOa+v/mlbVQxi
 C6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hdwzt3tFXKWyJadRRPoBDmhsTEk2PAGDfRjvzOl8MPs=;
 b=D4isfhY8KRtgWNi15r6jLwY9QIE+JQ9Nq2wFSKTYWiS++zEw7JklVGbgqLKYjFyGEj
 HPDdF6O8fSE+Q0VdCyHBZryidv7huC/bfipUURkAJhLqrlBrQvJnftjGnVpjGkatl5Eb
 pQIgIGBrJpOPCOVwkLCTBOl0h1mdfE81MVGbLAnpOh4KGHQSXrD8sMFTyd8j4byjQoMb
 ZZ4mup7eDme7gbpMkrIPBMab6n8KX4IC1LKfrZ3dBhuLyJa/VMzZFbihMfcz4fsueoYy
 Jpbx0JcFlkRBCPNxjyRKau3D8W2DQ/pKRRulL3SQGye4MO0gDzV2z6MmMTVmgd503QLw
 WolA==
X-Gm-Message-State: AOAM531WzT5RdS4shwT9b1jKDCsj2Jz2YwTWpm7pQi8ZFLDnfzrhhPzT
 cZErTcdD5d7kLDldCtI08SxzNWUk
X-Google-Smtp-Source: ABdhPJzdk/nFgua8nnwDiV8pxsUPopJp4Ej7KqRGiESqc/FLCHdB5vrUehxLR6Vz+z7VDCSgdG6MRw==
X-Received: by 2002:a17:902:6b02:: with SMTP id
 o2mr3415163plk.25.1590668687208; 
 Thu, 28 May 2020 05:24:47 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2183:e360:deba:7bf4:98ef:5568])
 by smtp.gmail.com with ESMTPSA id 1sm5722888pje.26.2020.05.28.05.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 05:24:46 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 28 May 2020 17:54:04 +0530
Message-Id: <20200528122428.4212-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
References: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 May 2020 14:24:51 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 May 2020 14:24:49 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 02/25] parsing_c: parsing_hacks: Label end
	attributes correctly
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

Due to certain conflicts in the grammar, a separate token
(TMacroEndAttr) is required for attributes before a semicolon or an
assignment operator. Prior to this, multiple end attributes were not
labeled correctly, i.e., only the single attribute before the semicolon
or assignment operator would be.

Add a case to label multiple end attributes correctly.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parsing_hacks.ml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/parsing_c/parsing_hacks.ml b/parsing_c/parsing_hacks.ml
index 0ee0c6c6..74c3ba60 100644
--- a/parsing_c/parsing_hacks.ml
+++ b/parsing_c/parsing_hacks.ml
@@ -2771,6 +2771,10 @@ let lookahead2 ~pass next before =
 	  msg_attribute s1;
 	  TMacroAttr (s1, i1)
 
+  | (TMacroAttr(s1,i1)::(TPtVirg(ii2)|TEq(ii2))::rest,_)
+      ->
+	  TMacroEndAttr (s1, i1)
+
 (*  (* christia: here insert support for macros on top level *)
   | TIdent (s, ii) :: tl :: _, _ when
     can_be_on_top_level tl && LP.current_context () = InTopLevel ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
