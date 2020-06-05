Return-Path: <SRS0=TTUf=7S=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8E5C433E0
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E0F2206E6
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJoWhA5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0F2206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 055DiP2L025756;
	Fri, 5 Jun 2020 15:44:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0D8FC777D;
	Fri,  5 Jun 2020 15:44:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7F1B83F9A
 for <cocci@systeme.lip6.fr>; Fri,  5 Jun 2020 15:44:23 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:102a])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 055DiL8M003368
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 5 Jun 2020 15:44:22 +0200 (CEST)
Received: by mail-pj1-x102a.google.com with SMTP id m2so2750533pjv.2
 for <cocci@systeme.lip6.fr>; Fri, 05 Jun 2020 06:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FmDSG3GkcZPx+14FSLQSYV7N874MdZ48KVa17LyO06w=;
 b=vJoWhA5olVMMoYjND31oyX3Tm3XOvbtGXZSx3D82iZyJn39cRMzcvzdQl5qQPKYG6B
 Dc/P2Btj2vzJQ3uk1/QpIM2xzz4CJoiHIa++Uw/EwPF1/kV+o5bku2KMQIMQG3Wh7kc0
 cMbdGf0x2LKgE3igsXgf4poEsiFYW0YDXpmL4EiX+1X4kg8hUY4DTS7UUbYPRgtssfVU
 Pp438d12DB/bWl8YEWiZRDp3yCvgwug+S9DQ/FArit/dJbWiwE9k1GQddpR9bKQfgW4U
 C7TWQAs7It9suuPtxFccTrHzshze4jdkjf8YlhpwOpJ9BSGU7kTeKvBJkPxhWj3VpOXp
 e4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FmDSG3GkcZPx+14FSLQSYV7N874MdZ48KVa17LyO06w=;
 b=j4pSYM53wvA/IAa7506T5yDDCxF5pmIT2HLEbU/lwMVJMf0MjlKjnBZWj0iI+uqvzR
 XXYUKQNXYe7E09G0raYPLeStoVz4MtXS/wdVn7719iRS+s/I0wJ8aiQwwpMcFWYiDn28
 ZIJ2X0vqGTPLSRJpbfd+g4n2OV5kpbMcw7oRuVoEWOMmpyZ+vQU8coxxD5Ed3b78BG4D
 Ik5Pj6Kg4RYURbo5G6LXerw/ZRN+Z3wE/0JvcZdYCCEBcHhcTNEoOzCx+Sq71ccrKHVP
 ue94I1sGuyYcnMhnAgzjqg0tEg1UVobIe1Rdih3DewCAxchg85pVvBEd5t2cQeztghah
 DxOg==
X-Gm-Message-State: AOAM530dQ1c2kLo8O4g0j3gDhicgKDlo4HLuGHPs9C1PphVBq+1oNi3v
 CmS5yDtdXGDkJXu9Towo6tGT4m/9YHk=
X-Google-Smtp-Source: ABdhPJxh4HUKQHLCwJ0+rQVXSbMmo107P2NMd4grDW0GI12jAUM/TF0powxJtyKLPgJKgfS6LrmKiw==
X-Received: by 2002:a17:90a:376e:: with SMTP id
 u101mr3145901pjb.126.1591364661057; 
 Fri, 05 Jun 2020 06:44:21 -0700 (PDT)
Received: from localhost.localdomain ([1.38.221.125])
 by smtp.gmail.com with ESMTPSA id w186sm7861353pff.83.2020.06.05.06.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 06:44:20 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri,  5 Jun 2020 19:13:14 +0530
Message-Id: <20200605134322.15307-7-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
References: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jun 2020 15:44:25 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 05 Jun 2020 15:44:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v4 06/14] parsing_c: parser: Add rule for optional
	end attributes
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

A few attribute centric productions cause a lot of duplicate code. Add
an 'end_attributes_opt' rule to dispel duplicate code caused by an
additional attribute centric productions.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parser_c.mly | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index e4352a61..443ac59f 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -2408,6 +2408,10 @@ end_attribute_list:
 
 end_attributes: end_attribute_list { $1 }
 
+end_attributes_opt:
+ | end_attributes { $1 }
+ | /*(* empty *)*/ { [] }
+
 comma_opt:
  | TComma {  [$1] }
  | /*(* empty *)*/  {  []  }
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
