Return-Path: <SRS0=cw0N=6I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAAEC55194
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:18:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C1C82074F
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD+fg1/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1C82074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03O9IYvP021332;
	Fri, 24 Apr 2020 11:18:34 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7F3C87815;
	Fri, 24 Apr 2020 11:18:34 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 201897815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:18:32 +0200 (CEST)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03O9IUKj009621
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:18:31 +0200 (CEST)
Received: by mail-pg1-x542.google.com with SMTP id o10so4361193pgb.6
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 02:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KPCzDPIq2ilnpUksJQzqSvAiCCiGo4aSKa+4vJmVh6Q=;
 b=TD+fg1/dyeeN8VJPRZOeD5E69+UpXGJmyhO7N5rcWYuwTebrPXkV889oIiCoplbEzK
 uytNbxuBch6AtcLNLJsA/VKFzslZ3lMWLAyZ0NzaMH/KnyTldhro2oYmCZYqdqX4NOaj
 +2MZ9GAnFaNsIQpPepyjUl6NrpAoFlIYYRm5Cw+hG0uOxphbHVvPS6lTbA2P6gBxuK0w
 d0up+SdY2YyTfaWvBjxvu/egdrpQNlNulkRVZ8eKddMCYXbzonpgrqC4UFPyDGzMC+KW
 4U58191pHLvKc7eFWuEgEf/v+Sn1C8jWt+vGV1GPDO6eWFXbSG1vVR8R7pDtqyilLTVu
 LZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KPCzDPIq2ilnpUksJQzqSvAiCCiGo4aSKa+4vJmVh6Q=;
 b=LIR39Bpxc8QPbxXYBRp358swUf2eNwdNXX2tzcy4P55hvmVH95kpuQLCJUWinZ/F6x
 8NDUW0zJBxbEj/a0qRs7BMDGfgKFY/cASKnLbuPxZ2MiEDXnqJ4dlpIx52XkPgvyNyEq
 Qxt+UdxVMYkTVIiEmZ1M0TxL7V1gxIrPAfkW1Yfn9UkLOMzIGXSwxg5szd6P7g8fHSMV
 /d0VA2eoIVVXZtHJ1ztHIBhmy22t4NjPWrSdtIz6lR/OrkKPgz7LoCHdPsUDyZC4a2e8
 649kGmCNCWD8+JNSqCM+T5klDR74mF/Z2mqv0HwRvGMp5hSBRaI7/y5qGnmVpKYG392J
 VXBw==
X-Gm-Message-State: AGi0PubzvO/eIwiG0JCdK6McAG2pVr1wdXUdR+FXh5ZJ7Rh697w8tJUH
 VEBHxdBjjcoL9vo8xmTDl6tnrmEPnmk=
X-Google-Smtp-Source: APiQypLP5k1REnt8hHWoVufkgnuiOLc3+VNUcboM/8edqhEx39DaoRSDh7jtUwmTxGdqGnaTMOR0GQ==
X-Received: by 2002:aa7:9e10:: with SMTP id y16mr8585461pfq.236.1587719909734; 
 Fri, 24 Apr 2020 02:18:29 -0700 (PDT)
Received: from localhost.localdomain ([1.38.216.60])
 by smtp.gmail.com with ESMTPSA id c80sm5043933pfb.82.2020.04.24.02.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 02:18:29 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 24 Apr 2020 14:47:40 +0530
Message-Id: <20200424091801.13871-5-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
References: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 11:18:34 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 24 Apr 2020 11:18:31 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [RFC PATCH 04/25] parsing_c: parser: Add rule for multiple
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
