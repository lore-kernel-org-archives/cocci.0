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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7683FC18E5B
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:05:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E79222051A
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5YCpgLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79222051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GA51wi013181;
	Mon, 16 Mar 2020 11:05:01 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CB8567809;
	Mon, 16 Mar 2020 11:05:01 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 770747802
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:59 +0100 (CET)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:643])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GA4vaL008764
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:58 +0100 (CET)
Received: by mail-pl1-x643.google.com with SMTP id t16so750574plr.8
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 03:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eY8uN9ZiTYVXH+rnlUtslQcR4wVjV9QbTbMABZr/Vwo=;
 b=P5YCpgLLSVs9G7DFYDU5cL7nVXpQfT+R91wwzHmNT6IKHtgl534g696OxN/zqaGa9j
 G/idX1Cz3GmuMJPr/SrW4kC5wit2YFY6TmwXLVpT5myRtPMX1PQxKG1eknVjr2EVu16w
 TKYrxEIQnmayiNZB4jjjzTQRsTkz0iAqtBBGRN8iILs/WEFqbwZmKo+xImrqyGgOkfyl
 cLZU/uYqxpwkE1JyFbHyKAiGb0f48zDMlumusZmld/p2tcAPUP7qytttICgLBYynu7dP
 OKazk8cFkwH5XCYGE4NnRgx9ScrP/UM8sjLUxZyK5K23jAU8NCCZQRYPxNVIoMa5gejH
 Z6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eY8uN9ZiTYVXH+rnlUtslQcR4wVjV9QbTbMABZr/Vwo=;
 b=uM6rckHMATb9tLxTfdF/dAnOppmOwGNxoq6ePpV5EYEtCqjtIwLFe09CQS6SMdLIlo
 RLRdLiOQHctniXesgd8LySMwIBwKnaQkUdZM8liuXw/gUf5J+x0m/p5EJH1GoKfCQ4X4
 MIxj15IXiAXpzQLeC2a64+xH01067+tHMlmoaxsTQ+jJew/98Kd60IcuD7KDJaYKCIV7
 W7BF3WncNGlZcI7M5vc0sgvItGpam/XMWSIu5ZlVRNrAByVrhxcJ+DR5F7iGNaMEp4k9
 zfkzYQhvkdIptB3vs4NP7Z4XfL8PJtyWSEEZsc4rmb3HiozaAFCjA9bibfK6cQJ1CDLr
 Jg8Q==
X-Gm-Message-State: ANhLgQ3CmuygdyNXPwkrSWNaqFUtuGuFE8WlqojWQkvZitPlLVy6blt6
 w+bThBm2AQ8VF0RkfcKTJYzOEGbC
X-Google-Smtp-Source: ADFU+vvT4Vmpd/OMW6ATeRCvA3hzjngeibW3R6WSp8G6wnt+DzBLOhSfoshEl0+xvuPM6tYvkmCx9g==
X-Received: by 2002:a17:902:8303:: with SMTP id
 bd3mr26657731plb.171.1584353097172; 
 Mon, 16 Mar 2020 03:04:57 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:284:a4f2:cc63:b7fc:551c:dce5])
 by smtp.gmail.com with ESMTPSA id
 u3sm19803374pjv.32.2020.03.16.03.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:04:56 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 16 Mar 2020 15:33:17 +0530
Message-Id: <20200316100319.27935-25-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 11:05:01 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 16 Mar 2020 11:04:59 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 24/26] tools: spgen: Add cases for
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
cases for these types in position_generator.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tools/spgen/source/position_generator.ml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/spgen/source/position_generator.ml b/tools/spgen/source/position_generator.ml
index 31d6cb5e..2fa630fb 100644
--- a/tools/spgen/source/position_generator.ml
+++ b/tools/spgen/source/position_generator.ml
@@ -195,6 +195,12 @@ let rec type_pos t snp
   | Ast0.FunctionPointer(t,lp,star,rp,lp2,params,rp2) ->
       let constructor ~mc = Ast0.FunctionPointer(t,lp,star,rp,lp2,params,mc) in
       mcode_wrap ~mc:rp2 ~constructor snp
+  | Ast0.ParenType(lp,t,rp) ->
+      let constructor ~mc = Ast0.ParenType(lp,t,rp) in
+      mcode_wrap ~mc:rp ~constructor snp
+  | Ast0.FunctionType(t,lp,params,rp) ->
+      let constructor ~mc = Ast0.FunctionType(t,lp,params,rp) in
+      mcode_wrap ~mc:rp ~constructor snp
   | Ast0.Array(t,lb,expr,rb) ->
       let constructor ~mc = Ast0.Array(t,lb,expr,mc) in
       mcode_wrap ~mc:rb ~constructor snp
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
