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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DD3C433E1
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F572070B
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+x2rMt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F572070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 055DiMIN029859;
	Fri, 5 Jun 2020 15:44:22 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7E9A0782A;
	Fri,  5 Jun 2020 15:44:22 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3B8AC7567
 for <cocci@systeme.lip6.fr>; Fri,  5 Jun 2020 15:44:21 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:42d])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 055DiGoU013109
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 5 Jun 2020 15:44:17 +0200 (CEST)
Received: by mail-pf1-x42d.google.com with SMTP id 23so4039710pfw.10
 for <cocci@systeme.lip6.fr>; Fri, 05 Jun 2020 06:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KPCzDPIq2ilnpUksJQzqSvAiCCiGo4aSKa+4vJmVh6Q=;
 b=l+x2rMt0uSRnCU7Z/zakb9jtgj+idMJpmHfjmugvHlUV4QCGZrM5U3ClQv+XGjoq1H
 4kFWttofNA12VRd5IMpxmqvFKOrH8diszMu78UBuAQmkBJSnBwnhQuJRBpHoh2FHmNnm
 uTvETUb2qzAfTSIPWTzIUo3xDeAxeis8rvA5Oju86S7Poabktk2lRQkZYV6aUq9BzVx5
 HB4sHZbiT205H8rDeR1E2RHSuIqfYwUw1JE1H3ZSZgBByVvYcASYUlVos1JaGkOWvDiA
 DXeiQm0UcIdXKetv0qwVD6Cgt1Vi4LLaRA/wx5DW0T1sNqG3SBmhXBPZ3o14zxqMa3ve
 XAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KPCzDPIq2ilnpUksJQzqSvAiCCiGo4aSKa+4vJmVh6Q=;
 b=XCJKLKAi3vVYKYuOZ8S/CVbn0ZVDCBXsXBJcn3QmNmQpy1vKCLDHLJ4uzsm+jmVI1n
 Jx3QyUuSKppiWwJvLzlfYrP81pFO6hclAe4QLvMil3D2Tm62ROlENnXD49WtKTfsJm/A
 jG+prb/xvgrDohBGlVWWnHkK1ROzbd4AtLEN4UgJYL1P8Qn7AZ5lI4GZvpEE2uNv/4/A
 mNMeiM3Ay+NrZVXDnJFslF6Af+bxSmjlfSFDajyDi4zUdTHZZG7YG5YMcioz95dR0DGe
 nXZDGxsm/KdVsAX4Sfdugp2WS15ozpfxlyK2BgOeD7VtAsz3qaUMoenWV+lgU9iKKwjg
 1M5A==
X-Gm-Message-State: AOAM532yOWVR+fZHwClkR2ZkCAXTIAT/rYuDOY1DrBbmx0PjCtZuEtmB
 XEAf0YhTiCfAYmzQZ1xvSIRZ0Irdjt4=
X-Google-Smtp-Source: ABdhPJzkCao1PPslxtrs/vozZzIkDhz/UsjFzjPQIa9CcOAizSDw17EshdoTxjnf96PPptC/ulXaWQ==
X-Received: by 2002:a05:6a00:807:: with SMTP id
 m7mr10050379pfk.246.1591364655970; 
 Fri, 05 Jun 2020 06:44:15 -0700 (PDT)
Received: from localhost.localdomain ([1.38.221.125])
 by smtp.gmail.com with ESMTPSA id w186sm7861353pff.83.2020.06.05.06.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 06:44:13 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri,  5 Jun 2020 19:13:12 +0530
Message-Id: <20200605134322.15307-5-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
References: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jun 2020 15:44:22 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 05 Jun 2020 15:44:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v4 04/14] parsing_c: parser: Add rule for multiple
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

There is no rule for productions of multiple end attributes. Add a case
similar to that of attribute_list for end attributes.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parser_c.mly | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index bfe92e18..d259f12a 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -2401,8 +2401,11 @@ attribute_list:
 
 attributes: attribute_list { $1 }
 
-end_attributes:
+end_attribute_list:
  | TMacroEndAttr { [Attribute (fst $1), [snd $1]] }
+ | end_attribute_list TMacroEndAttr { $1 @ [Attribute(fst $2), [snd $2]] }
+
+end_attributes: end_attribute_list { $1 }
 
 comma_opt:
  | TComma {  [$1] }
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
