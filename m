Return-Path: <SRS0=43Z/=6Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D052C47255
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B1520720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXkJAxER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B1520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA92ZZ020843;
	Mon, 11 May 2020 12:09:02 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B60F63E6B;
	Mon, 11 May 2020 12:09:02 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 34F9F3DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:09:01 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA8xSD016666
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:09:00 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id a4so4358184pgc.0
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qMGzGQX4xag0BRPp1FUVQwszM0e/kjVDxxhuMsIg5uE=;
 b=hXkJAxER6S0X0GoCUgTSoGKfmtVu4ERRxlbVkVhbtGlesY+4ILqR4NRD+vRUZGa9B3
 nBoJC00SSjCpD/1Nn8XZlqf9wqmUNB7N9e/PHK71VD/J11+S7kEtrDFG9ckWHeuAaRA+
 I7bQQWa1EEqu0FCuCJEKum+j9ucUzrHdhBXXaLkQxd5RRw0sYIV5wCbICGFdKgm3e5JP
 ZpP8PKMI4GoUzi3QixZ8y69asYpE4ooMdOVm3erOHYq/9Pht+ywaBZgWaXGzHW5T7aEi
 9pL/qaRkWD99ufu8soGpDva9UsLi70gNopppRADjyCbplYO2XVpPx8ygtpyy3ud0aU30
 kB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qMGzGQX4xag0BRPp1FUVQwszM0e/kjVDxxhuMsIg5uE=;
 b=DqGd5LH5Xr9u9p2ZHhCtphFBVZ0CNjxFMDIxRvWft++2FzeT3Kn91n+g5QvvCvmbHj
 YLSSAeNcHqU1woh9tek9DvlhabEEB5BxQj+DF6Fetc7Xa2akSfpJWefGJTVecdl6fUnq
 BMM/p5eAZgMDPMKr/JdXj/Et3rb5FVRhpcsEONRr0blW0SPljnJ9vC+Xs6m0D5fFmZh2
 Q9tq91RdqGC/mEbigWzmioEYSpTyu5y53tKprAFrqejvepaW/dyVBtLezKIQJh7+kcQ/
 Dnl8Rt/A6CZuKS3IdKEIGymqmfwM9PO4HLtAzWovY5ZDkCBxbOY/ABvUMWVMYrG+FNPA
 ldUw==
X-Gm-Message-State: AGi0PuZ1qJs2YncJyeXScsH7+V9c1DdthQv77DXa1RAMPIBUBnXPrV/A
 LBQwNFTKp7yu2AvMGmYGkgQNjw63C/I=
X-Google-Smtp-Source: APiQypK5gKBfqdTGy8es+OZDKuBQCvc+0gppK4pUX9rchUKUN5VVrQysfMn+3rg/Jv5i/p89cDZHJA==
X-Received: by 2002:a63:ed08:: with SMTP id d8mr13756991pgi.309.1589191738814; 
 Mon, 11 May 2020 03:08:58 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:08:58 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:37:04 +0530
Message-Id: <20200511100715.19819-22-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:09:02 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:09:00 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 21/32] parsing_c: parser: Parse Cast attributes
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
index 34d234d2..ccdfd7f6 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -818,7 +818,8 @@ arith_expr:
 
 cast_expr:
  | unary_expr                        { $1 }
- | topar2 type_name tcpar2 cast_expr { mk_e(Cast (snd $2, $4)) [$1;$3] }
+ | topar2 type_name tcpar2 cast_expr
+   { mk_e(Cast (snd $2, fst $2, $4)) [$1;$3] }
 /*
 It could be useful to have the following, but there is no place for the
 attribute in the AST.
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
