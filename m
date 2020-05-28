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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE33C433DF
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:25:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1A6220888
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="va5UpSO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A6220888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04SCOwW2026830;
	Thu, 28 May 2020 14:24:58 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7E72A5D47;
	Thu, 28 May 2020 14:24:58 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 10F8E3E1D
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:24:57 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1035])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04SCOtCr003176
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:24:56 +0200 (CEST)
Received: by mail-pj1-x1035.google.com with SMTP id k2so2086741pjs.2
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 05:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KPCzDPIq2ilnpUksJQzqSvAiCCiGo4aSKa+4vJmVh6Q=;
 b=va5UpSO/cXZ2NtO8USp8dRLbvEukT18HMjGuk6aP2zN2SZmrckme+LuviVyxPzrR0N
 Y1Y5N6GUuHkaaZYmZ60MG5p3cEjpI+cz6Tfl4c3GA4WtHi8NvwSWsbhDTG/kbAFPBdcT
 4FPImaZA60zEPO8UHICjFB87K8DrJNPZQQHf/Avu6l1mBsCkoTTwTHt0AOI+v/1CkGJS
 CTPzoafB0f3JTyhuGUxu4oyjng771kDEky3TE2MLtwRcprO9WPwqDG9TSHfY65vLGwzS
 Y2gj65pbzIPic7w+LxqdgpwSexEYJtmH3oKEa8HpumJfYOPOfHHMr7aN5KGnXPCAzJmB
 vA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KPCzDPIq2ilnpUksJQzqSvAiCCiGo4aSKa+4vJmVh6Q=;
 b=C/XlEBTY4MzCkwMZ8T8Biyt35l5DkTQv5qAiaiJpEFCTFIPJe5D8oEBE/RR94D9K9p
 3FOVXUEPZCRR1JkdoF7LrogDNShy0WC+SMlUc2PXyFqDZoIzsla8J4eZQhN7bjIOSTP6
 CsAX4V4wiMTunmXAm7k9f0oWWd/NxgJAWV1ZIma/lntNq52znfTKgvr9dx0GcEiGf77M
 QVj4eJEa621uB6Bira8VAWfeYVSautIRbTieHmsou7geOy2OjPPiJoIb5c1OYf2cwDoK
 83gv7pe0KRUNQlPy/PlOmQszLpTM2YLWVprRpi6xSCQLmFCLmt8spn+gZPu8kfrokuuw
 noFw==
X-Gm-Message-State: AOAM532YMdOoK0Un8x8TpV/3cbeRossQY9N6pacbEfBG+10bXgxB/cg/
 g9KiFviLyht3oxvPlsdG9SHT+MOn
X-Google-Smtp-Source: ABdhPJzfbzXJZEEHbvpnWJfgPhzMp7w1aqkVThhazi27ubhg29/MZB+XAREKvmcdWAoXD6DcxbeUjg==
X-Received: by 2002:a17:90b:882:: with SMTP id
 bj2mr3293620pjb.186.1590668694610; 
 Thu, 28 May 2020 05:24:54 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2183:e360:deba:7bf4:98ef:5568])
 by smtp.gmail.com with ESMTPSA id 1sm5722888pje.26.2020.05.28.05.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 05:24:54 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 28 May 2020 17:54:06 +0530
Message-Id: <20200528122428.4212-5-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
References: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 May 2020 14:24:58 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 May 2020 14:24:56 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 04/25] parsing_c: parser: Add rule for multiple
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
