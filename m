Return-Path: <SRS0=m0DH=ZT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DB2C432C0
	for <cocci@archiver.kernel.org>; Wed, 27 Nov 2019 17:39:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18F12071E
	for <cocci@archiver.kernel.org>; Wed, 27 Nov 2019 17:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqNX6bR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18F12071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xARHdTaY020177;
	Wed, 27 Nov 2019 18:39:29 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5112E77E0;
	Wed, 27 Nov 2019 18:39:29 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8815777E0
 for <cocci@systeme.lip6.fr>; Wed, 27 Nov 2019 18:39:27 +0100 (CET)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xARHdMx7027900
 for <cocci@systeme.lip6.fr>; Wed, 27 Nov 2019 18:39:22 +0100 (CET)
Received: by mail-pj1-x1041.google.com with SMTP id r67so2565066pjb.0
 for <cocci@systeme.lip6.fr>; Wed, 27 Nov 2019 09:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/bgY6bWipWcem0dOb2HqcOGSQaEs3oosAqTWJP3WsEU=;
 b=VqNX6bR/K2Z3Z/7n2xKVO//wK1oDvDlcG/+QvHrc5t7U0Ib9fIPQDbG2kV1xd4rKIe
 jvBWbLT3tAJ2C4224IJtlrk6qXUf7+ZNL0pQcvTN7G4eQD4FrPq9crGP0CmnZfrf3w/7
 F1w/NhDdsMaWzCMTiemlnFapbA8iKowRUESJu5h0krQk1cshlJvrFMLTPzyHfM4Q18DG
 HDUHNVuevzO1GZ4TAwWQ8oGwLx9Er6r/aNC3scuXx/TBP2qXfOHtlhmTo88hkYNfjSyV
 JYHztKxwLcf9OyE6XyUrVkQ7QuixjspXurtnJVLCLS4LdMeYggBk2P1V9BiBZisnoPUD
 NFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/bgY6bWipWcem0dOb2HqcOGSQaEs3oosAqTWJP3WsEU=;
 b=p86rqVqYuQFwRN4uxb/ahwDj36AoD/G3tcdAMHQWTGVKpUbFy0pjW4UHearsojfD/1
 O1xZPS+yHcswErShFYSUOrREr2PVL9Jk8fAvAMbDCMn1MmoKvyZU3ZI2c1AtgoyBU19n
 fhFAZsMR1ZqxVIih01rCp4pKfzGaxkGZmPWpDUWhOeOcp5us/fWAvPvmxGZ1LGhJOXaw
 acQrjIeSpXcjnkwxLMNf2BkScs2VI0m3vEZ+VkXRiBeEFP9ImdbrCblJWokZYclDDdBo
 4TpiefwXkV0XYSg5o22l5w7Zyf+GR0sC4j3ekn3DaL5S/Sh9icj+wayQaidpNeSuHVGU
 BeEw==
X-Gm-Message-State: APjAAAVqIQl1oFyuIULYAih5ciHxx385hodWp2L3CliL5OeRxicmcqiG
 XHRl5CnyYanwHuiaKm94FcqIqDFV85k=
X-Google-Smtp-Source: APXvYqyI0WZBCjv5bYBRxEGX5OQ1RLPMyX7nqvpZSOs0hLvoIhF81UWF1trO7w7RZdiZNIGrrqrgGQ==
X-Received: by 2002:a17:90a:d353:: with SMTP id
 i19mr7666301pjx.43.1574876361190; 
 Wed, 27 Nov 2019 09:39:21 -0800 (PST)
Received: from localhost.localdomain
 ([2402:3a80:167f:97a7:3939:930e:5cf8:fd50])
 by smtp.googlemail.com with ESMTPSA id j23sm17028240pfe.95.2019.11.27.09.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 09:39:20 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Wed, 27 Nov 2019 23:08:14 +0530
Message-Id: <20191127173815.24988-2-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191127173815.24988-1-jaskaransingh7654321@gmail.com>
References: <20191127173815.24988-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 27 Nov 2019 18:39:29 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 27 Nov 2019 18:39:22 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org
Subject: [Cocci] [PATCH 1/2] engine: remove circular references in
	MINUS/NOREPLACEMENT case
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

The cocci info tag can sometimes have circular references in the
MINUS/NOREPLACEMENT case in the transformation. Pass the binding
info through clean_env to remove circular references.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 engine/transformation_c.ml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/engine/transformation_c.ml b/engine/transformation_c.ml
index bcde08b8..9f0b0ab2 100644
--- a/engine/transformation_c.ml
+++ b/engine/transformation_c.ml
@@ -380,7 +380,7 @@ module XTRANS = struct
 	  (Ast_cocci.MINUS
 	     (old_pos,Common.union_set old_inst new_inst,old_adj,
 	      Ast_cocci.NOREPLACEMENT),
-	   [tin.binding]);
+	   [clean_env tin.binding]);
         (if !Flag_matcher.show_misc
         then pr2_once "already tagged but only removed, so safe")
 
-- 
2.21.0

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
