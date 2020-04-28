Return-Path: <SRS0=bJsz=6M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33A2C83000
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:04:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE4220730
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4V2iqEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE4220730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SH4PId019949;
	Tue, 28 Apr 2020 19:04:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 646B37807;
	Tue, 28 Apr 2020 19:04:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4D0CB3DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:04:24 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1043])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SH4MPA022145
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:04:23 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id ms17so1432664pjb.0
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 10:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DpFBF9X03e6oLDFxlRK6sDsGiwnDHFexEKHASlqXDt4=;
 b=W4V2iqEfZGi8nIbsEVO6eA0m8gs3Y/czYMCeIy66SPM5BshuVzH1+kiRXy4Y66UfCP
 xJoHIFAZYRAcUShMMbXMkSfAQ12/FoNXJqpte6sP8sTvyPVyLCrrnmhn14glzBKCQcAw
 jxy/TErog5alAXLy5LCJEky+3EGGnUcadOEMLgyytX+JMEKnNdQJ+Yg0RRBlLY1yXJo6
 wy2/UVR9mA454AncM9FTvwDU4DMKwPJ1MsmE7TOr/DMtXUlX0xfjzryH0vpk4Fw/MQBJ
 WUZ2UM0jGpz3Q5GSRaerzXtmbShSItqJktqfHlOkfWyJPrTF6nsxkciIrUcUnUCOqlGX
 s0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DpFBF9X03e6oLDFxlRK6sDsGiwnDHFexEKHASlqXDt4=;
 b=LUopuTTua5YlVPT6w9qR5zuLhfpBeD4REbtoCp/NjQEkfvxaReqeXvmVsxbDKqrs19
 xJL+aSfHE72dG26qArk97Jj9+CxvWj676rjx1GXa8yzk8n2RMG8szEE/qvk/eop+RDn4
 upPSkW2XXUkPBsLi4R1dMfZLPOTb1c8+tgxejVu9V7xbg/vc016fEosrVBH2M+VACs9/
 /8/4n4TRTSgVxEGzW9GaDscjr+z8Iy4yn/z8sNx9w0D0gCc/KRHMrh5HpNJiH1BeT64m
 imbcufGpKedVmuLy1FyNSBH+p5l9OMugCIRUetGDk5dFC7zMVSvUz4P+SA+6vC3n+5oC
 ddew==
X-Gm-Message-State: AGi0PubeteAL9Qi64GuVda7EXzOgxV0KUe7Qm10D87ok77GPZbdGfsKH
 YiRd3lBXfrG0wEB8F+8yuIC8YL5YQDY=
X-Google-Smtp-Source: APiQypLBXNc6EWkIc+oqGccL0HKbLJ+N8c8adDl7gSiIJ4KsMVlq0R8VTJ+ZqXu2x9sCoe2JiRgZpw==
X-Received: by 2002:a17:90b:1993:: with SMTP id
 mv19mr6083674pjb.88.1588093461974; 
 Tue, 28 Apr 2020 10:04:21 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.163])
 by smtp.gmail.com with ESMTPSA id u15sm2505097pjm.47.2020.04.28.10.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:04:21 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 28 Apr 2020 22:32:17 +0530
Message-Id: <20200428170228.7002-22-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:04:25 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 19:04:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 21/32] parsing_c: parser: Parse Cast attributes
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

Cast attributes are added to the C AST. Parse cast attributes in the C
parser and place them in the C AST. The attributes are taken from the
type_name rule of the C parser.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parser_c.mly | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index 0abcc9b0..9e640ba5 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -818,7 +818,8 @@ arith_expr:
 
 cast_expr:
  | unary_expr                        { $1 }
- | topar2 type_name tcpar2 cast_expr { mk_e(Cast (snd $2, $4)) [$1;$3] }
+ | topar2 type_name tcpar2 cast_expr
+   { mk_e(Cast (snd $2, $4, fst $2)) [$1;$3] }
 /*
 It could be useful to have the following, but there is no place for the
 attribute in the AST.
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
