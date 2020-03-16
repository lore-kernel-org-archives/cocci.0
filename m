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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A85C18E5B
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4671D20663
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3R+v6jv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4671D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GA4aiF027651;
	Mon, 16 Mar 2020 11:04:36 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D09F37809;
	Mon, 16 Mar 2020 11:04:36 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 43D557802
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:35 +0100 (CET)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:443])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GA4XlN008418
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:34 +0100 (CET)
Received: by mail-pf1-x443.google.com with SMTP id 3so1801052pff.4
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 03:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kd2vYYIgWVNqEV4R66099cZMd/G/FFbUiirYb9tf7F0=;
 b=q3R+v6jvD1ALns0G2KPJHU1Tt0k8f0wqiPyqlel5B2vLkspsRJe8rWpRp7PZRiV5Yv
 eEO+dP9JDbcOIdBMmfhzEZiyqTNaChfcltU0GVYhfS6phUNIN0AcD8IQPAxvHnek14tH
 CIBqb7DgtvYDzH1ZdGYZ/JCBVVBv3uJ+n6diilLK4dEx5ejwc67+S3qiKKFE0mItbgAV
 gGvj7dEqiiUfSpQMwWgvZVtp0V0oDsXaFwg5udmkz4iTZPgg3kBc25kluN6e029K6bmc
 L609PaiDko1aXdEG5MW7kAZzn25cgj5wZ7QZZCV5lJFP00LDycF/fRVMlVrInJyvBN+N
 koKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kd2vYYIgWVNqEV4R66099cZMd/G/FFbUiirYb9tf7F0=;
 b=EDW5tQ6lh6Qv3IBb7Rv2Uk7DRKlVdzwCqBhZNDDyknO4Fo8KzXzXZ1qp9w24e1olhm
 /Yhf8xYn7zDNLV7HkFJ191sVccTEKzEWt94yFMdu5e3okXupzpgWGhjrRjWeKXNFJc6n
 CYW8NmlUWZm01RF5/K5lrs5l2tvISxdLpMHiBdkm+lXgkLZDdCTuAwWLMdzGwylI8TYF
 3QovDm79f0wQwLZKQGTzPEDus1SW1d9m+DUt+Mr7LYtu3ncY60NEjteT1HYVdb4YeStS
 VGUk6wL+8BOoKhaYZL+XtmdFbjHf7VxX2rkEV4FpTcU8dfy1kKKe1TjuyfRS9xt6atqu
 mg+A==
X-Gm-Message-State: ANhLgQ3Bb+ZRTCfHADHFhhlsLNkc5z7iBKUwjmTvK5qxtVYAYue7DNAb
 Mb3rqcVWMAaBsWFvroIvadVhfoHQ
X-Google-Smtp-Source: ADFU+vv7ABMOLTUNYSDdsn0BUNFIUXTrxl0zspD/+HWgTgXJXWGPFUZSNknTBfDwjfXw1v1qfmX5Rg==
X-Received: by 2002:a63:c4e:: with SMTP id 14mr25926566pgm.444.1584353072898; 
 Mon, 16 Mar 2020 03:04:32 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:284:a4f2:cc63:b7fc:551c:dce5])
 by smtp.gmail.com with ESMTPSA id
 u3sm19803374pjv.32.2020.03.16.03.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:04:32 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 16 Mar 2020 15:33:10 +0530
Message-Id: <20200316100319.27935-18-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 11:04:37 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 16 Mar 2020 11:04:34 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 17/26] parsing_cocci: type_cocci: Add
	ParenType/FunctionType to types
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
cases for these types in type_cocci.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/type_cocci.mli | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/parsing_cocci/type_cocci.mli b/parsing_cocci/type_cocci.mli
index c1ccb58f..6f24adf7 100644
--- a/parsing_cocci/type_cocci.mli
+++ b/parsing_cocci/type_cocci.mli
@@ -16,6 +16,8 @@ type typeC =
   | SignedT         of sign * typeC option
   | Pointer         of typeC
   | FunctionPointer of typeC (* only return type *)
+  | ParenType       of typeC (* only return type *)
+  | FunctionType    of typeC (* only return type *)
   | Array           of typeC (* drop size info *)
   | Decimal         of name * name
   | EnumName        of name
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
