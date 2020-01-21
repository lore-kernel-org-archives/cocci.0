Return-Path: <SRS0=kxF3=3K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C9BC2D0DB
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 08:06:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0184222522
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 08:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+7JaGCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0184222522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00L85eLX029797;
	Tue, 21 Jan 2020 09:05:40 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AEDE877E1;
	Tue, 21 Jan 2020 09:05:40 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 497F577DB
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 09:05:39 +0100 (CET)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00L85VRu011041
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 09:05:31 +0100 (CET)
Received: by mail-pj1-x1042.google.com with SMTP id kx11so980418pjb.4
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 00:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SiAOjSQQBJyQRmqiwiRWCNQp66CEeV/KpK/nhQbCexA=;
 b=I+7JaGCj9wVBADAlwc38iJULpgvxoy6fbNyYOxIpgGlcUkVvjMO/If1Y9autpRGTWF
 3Z22P+rQhruktxtqQEZgfUzOwI09MuEj+UbpjtdPVSSNAGE4ajWmwrolZQrJT7rZn72w
 FEDl8jKyVPXh8ObSHCwlXMYzv+NhWO8T9zEBwMDCYgWls6LG3cAsRORhqnNQSBez4ejm
 Zljl3HyyMvEbAMWKtvAkPf1u+jfDZIJRQuaBiZVax34oNPAUcu/4qCS2GtrcYaJpKNpS
 5wHnijvpXxMF0/FEPdkx51IhA5arSNRStcB1GkPjw9wmxlD36FSTkF2E2LOlxo3+J4hb
 vkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SiAOjSQQBJyQRmqiwiRWCNQp66CEeV/KpK/nhQbCexA=;
 b=AhNCdAd7EGR+8dRFruHpZbatljdR496TI3/8t78Xl07/8l1GVfR1u2wGrWJ63aQIoi
 kYuWDe8WevgrwyOugkh43bPxG77KH4lOHlm3BB2IV7ndVa++b054EY7FExVvuPtuavid
 jThJO+yovxU9TcyE5ADB4qkuZQguOM+mv8F159NHML/iIazywzGf69wsLlRJ6z6NnPZN
 9WD8DJSEkzpj4EabXOnn5UC/3BXTBOYuFd8SarsNexfEdFWMkWVxSwsymEhfWLNWV87g
 6kCOrR03OPZgo6xF1tarq9mS854ouz4wjXSk1pqFA1jwKHQtAYZOD4CqT0f/3KE3MKER
 Jqfg==
X-Gm-Message-State: APjAAAXBocjzCQDLvFkeGSLXtejeygLV85V50dsJ5HPhVzk+BxLxN0dp
 zOVi+9ldSMkEOtHKmqpSB5Udq02eFqo=
X-Google-Smtp-Source: APXvYqxtN6INbGZdFPyIBPJJKijDHVSIyBfFB77Uwmd1tHGWM6g0liiSakFzhcqN98IenRDP6M0qvQ==
X-Received: by 2002:a17:90a:23ad:: with SMTP id
 g42mr3819252pje.105.1579593930908; 
 Tue, 21 Jan 2020 00:05:30 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:167e:da7:fcf8:ab67:c0bb:e29])
 by smtp.gmail.com with ESMTPSA id
 k23sm39229604pgg.7.2020.01.21.00.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 00:05:30 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 21 Jan 2020 13:34:54 +0530
Message-Id: <20200121080455.24748-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200121080455.24748-1-jaskaransingh7654321@gmail.com>
References: <20200121080455.24748-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 21 Jan 2020 09:05:40 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 21 Jan 2020 09:05:31 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 2/3] parsing_hacks: Add bool to list of known
	typedefs
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

bool is widely used in the Linux kernel. Certain cases of
parsing_hacks.ml would mislabel bool.

Add bool to the list of known typedefs.

Stats of --parse-c on Linux v5.5-rc4 are as follows:

Before:

  nb good = 18956150,  nb passed = 134062 =========> 0.70% passed

After:

  nb good = 18956150,  nb passed = 134073 =========> 0.70% passed

The increase in passed tokens is due to functions in
kernel/trace/trace_kprobe.c using nokprobe_inline. For instances of
nokprobe_inline bool, nokprobe_inline is labeled as a CppMacro.

Examples of this in the --parse-c diff are as follows:

Before:
  passed:bool
  passed:bool
  passed:bool
  passed:bool
  passed:bool

After:
  passed:nokprobe_inline
  passed:nokprobe_inline
  passed:nokprobe_inline
  passed:nokprobe_inline
  passed:nokprobe_inline
  passed:nokprobe_inline
  passed:nokprobe_inline

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parsing_hacks.ml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parsing_c/parsing_hacks.ml b/parsing_c/parsing_hacks.ml
index 23d675cf..42ad9ccc 100644
--- a/parsing_c/parsing_hacks.ml
+++ b/parsing_c/parsing_hacks.ml
@@ -61,7 +61,7 @@ let is_known_typdef =
       | "u_char"   | "u_short"  | "u_int"  | "u_long"
       | "u8" | "u16" | "u32" | "u64"
       | "s8"  | "s16" | "s32" | "s64"
-      | "__u8" | "__u16" | "__u32"  | "__u64"
+      | "__u8" | "__u16" | "__u32"  | "__u64" | "bool"
         -> true
 
       | "acpi_handle"
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
