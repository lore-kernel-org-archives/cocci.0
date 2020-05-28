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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC7BC433E1
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:26:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0F220888
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5z9UFvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0F220888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04SCQ3ki026256;
	Thu, 28 May 2020 14:26:03 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4A4185D47;
	Thu, 28 May 2020 14:26:03 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0CAF13E1D
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:26:02 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:643])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04SCQ0o9020726
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:26:01 +0200 (CEST)
Received: by mail-pl1-x643.google.com with SMTP id bg4so6200850plb.3
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 05:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E10z+/hFD4F95F2UWzEOlvrQsp6vhltCH9tesb3fENY=;
 b=B5z9UFvKkh/ezQ/VRF5StAPDMcPEXvClnnPfqhSy1SxJGFt3BXQtFZQntJivLHK7Qv
 Vk/uTkQ0WEot1fLt+vqkdn1q88nnoKvld0tTmeHh6oB68gFAIpYIAZTrMZtTBCOYpn/l
 l/wOFDVLtnRJGcUEr7Sqq8i/m063cRfBp0yXbjNeEjIAAs/+io4UG0oGyvhDl3N4xgu9
 A5Q8NPn20hgWZo5GnU/yr97U1i7UgiTpphmY3RD7jvUlQ8uUDSGQ0RAh0DbL0H63vWmU
 TVbichWUndiJkt88Vz5Ki3w7E3vd5pUI5THA1Po++B6p5uE8DFjAD9220pE5k6Wk8+6V
 yTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E10z+/hFD4F95F2UWzEOlvrQsp6vhltCH9tesb3fENY=;
 b=FjMhPNA5MNAoQT0teLhR4dXQh8kbnSc+Wofgl64yLwZldvISJOQ56tSsV5fFQWR5n8
 9dwGidQiWqsNrTAj2xwSkqJfc5d4w8dIC1Y4RlxqnxhnUe6FDMOUdfVbcX+Z7NSyaSCh
 1CAjFqawshIUmG2YL++714/6lnGBxanRZocdBf3sWRhc3jyCemSFiMEvZBPHcgJPgvk8
 eBlnzjESOBJGTOuQWaVwQgq/0k16UpAhti2AZKrOXov6rRZPJH2817v23ll9aORqtL3V
 ybcyeCovXom2xpdYNu7C2sivJAEQskKBSfnJswlciloWQl6dQRYh2nna6//mILkV2Ul4
 ZmhA==
X-Gm-Message-State: AOAM533OupghmOp4jTbeJ8FdnPyBVsRlvIH2KyD0xnn26X+Na9yZ0nTQ
 n+ew7Ivg083mwU0Khg8luKzncF87
X-Google-Smtp-Source: ABdhPJyL+GnBQ5vgCbLPVgw6kLoiSq6Fcue5Oc8pkYMX3t03wgyU6niFoZMLc1OHpIxTEGlTMCXlkA==
X-Received: by 2002:a17:902:fe03:: with SMTP id
 g3mr3404561plj.323.1590668759563; 
 Thu, 28 May 2020 05:25:59 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2183:e360:deba:7bf4:98ef:5568])
 by smtp.gmail.com with ESMTPSA id 1sm5722888pje.26.2020.05.28.05.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 05:25:58 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 28 May 2020 17:54:24 +0530
Message-Id: <20200528122428.4212-23-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
References: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 May 2020 14:26:03 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 May 2020 14:26:01 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 22/25] parsing_c: unparse_hrule: Add parameter
	attributes in record
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

Parameter attributes are added to the C AST. Initialize the parameter
attributes field as empty in a case in unparse_hrule.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/unparse_hrule.ml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/parsing_c/unparse_hrule.ml b/parsing_c/unparse_hrule.ml
index f2605d82..fca985ca 100644
--- a/parsing_c/unparse_hrule.ml
+++ b/parsing_c/unparse_hrule.ml
@@ -207,7 +207,8 @@ let print_metavar pr = function
 	(function _ -> pr " ")
         {Ast_c.p_register = (false,[]);
          p_namei = Some name';
-         p_type = (({Ast_c.const = false; Ast_c.volatile = false},[]),ty)
+         p_type = (({Ast_c.const = false; Ast_c.volatile = false},[]),ty);
+         p_attr = [];
         }
   | _ -> failwith "function must have named parameters"
 
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
