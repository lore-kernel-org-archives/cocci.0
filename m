Return-Path: <SRS0=15MF=5F=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D837AC4332E
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56FCF20775
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBwAxwPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FCF20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K736sw000382;
	Fri, 20 Mar 2020 08:03:06 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 09690780E;
	Fri, 20 Mar 2020 08:03:06 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 763CC3B93
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:03:04 +0100 (CET)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:443])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02K7320T003621
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:03:03 +0100 (CET)
Received: by mail-pf1-x443.google.com with SMTP id i13so2764506pfe.3
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 00:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LowBblvxuIcW1zcDuNk5uVX3z82/+a6o2QZfaKC6TiY=;
 b=iBwAxwPcdbyf6ajcTN+g33HlnFfAGf1IVU+lT+q4JxKP9ShbBPl+K4++6HY3Erwl7p
 sZyd3jvE2NmhkCiYd/Zylrybb0pm4ps1TNwVFxiTDElbKxVJs+LI6U1X7JFoIrRNDkrr
 ZZHDbUzfiO4ewhsdspjkujdjiar95qe/opKrgU2htDaTOhMwvNqWTXAioflBzG9voNDQ
 RKz9t9rZ+acsh5cFzLi/FbAL6qD4NKVrpAqd9z9/nIJ22YVFRZF0HIF/b4oEqYVFRDbO
 mS3cDJa6lZN8YTFqYP9YKAvRdyUn04gmrTVRSBsPKC8wvAJm3LELAtXe6aOYqsy2XGiW
 +tVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LowBblvxuIcW1zcDuNk5uVX3z82/+a6o2QZfaKC6TiY=;
 b=TFkHz54HOBKESntFY9W1RvsbFqCZq0WjtcR9wEpDUGELOp48EhAvaB7UYBlL6TX6rB
 5d36yNKXSlI6y1DwVhFp3L87K1f4AHRRLbEepx11+xOAmj14FeDD5W0jSjCODl/Jnlsd
 7V3CfPLWSQ2Juvy1x/9GL4d43twxttjTc65LVDLhxzr7Y1FLlifIm/Nsniq6xuD3pEFu
 f5H+2TIPQ3OWzk/xY8i8A2cfUYoiFOUd2nxMLHr5wj5cMj5cbbNHT2JShOju52Rm7eSD
 t3AFgTletIQ+eJu26gBB0L7jM9/3vPlS0jdH33q3R8trfJxDp0xtX1xrYJyrzJxSehXx
 iu/w==
X-Gm-Message-State: ANhLgQ0bbBP7x1Oa/D9tPpTZTbGoey/axErayH73D1JH/1ytj0tFNfcP
 t1LY2ldAR6y6MeButVHY6NctjP4l
X-Google-Smtp-Source: ADFU+vscuCjMSmCrUXt9CQjjIzhxXUv2VyUWI+xkbBYtoypv3vUsSP4WD8qiSKeMv5ZZ3BCNG2XsMQ==
X-Received: by 2002:aa7:9467:: with SMTP id t7mr8143156pfq.97.1584687781847;
 Fri, 20 Mar 2020 00:03:01 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2190:a751:deeb:c09d:833a:659d])
 by smtp.gmail.com with ESMTPSA id l11sm3941232pjy.44.2020.03.20.00.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 00:03:01 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 20 Mar 2020 12:31:44 +0530
Message-Id: <20200320070157.4206-14-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
References: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 08:03:06 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Mar 2020 08:03:04 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 13/26] parsing_cocci: iso_pattern: Add cases for
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
cases for these types in iso_pattern.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/iso_pattern.ml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/parsing_cocci/iso_pattern.ml b/parsing_cocci/iso_pattern.ml
index 5ceb2bdb..6d51b072 100644
--- a/parsing_cocci/iso_pattern.ml
+++ b/parsing_cocci/iso_pattern.ml
@@ -1818,6 +1818,11 @@ let instantiate bindings mv_bindings model =
                           Ast0.rewrap ty (
                             Ast0.FunctionPointer(
                               renamer ty', s0, s1, s2, s3, p, s4))
+                      | Ast0.ParenType(s0, ty', s1) ->
+                          Ast0.rewrap ty (Ast0.ParenType(s0, renamer ty', s1))
+                      | Ast0.FunctionType(ty', s0, s1, s2) ->
+                          Ast0.rewrap ty (
+                            Ast0.FunctionType(renamer ty', s0, s1, s2))
                       | Ast0.Array(ty', s0, e, s1) ->
                           Ast0.rewrap ty (Ast0.Array(renamer ty', s0, e, s1))
                       | Ast0.Signed(s, ty') ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
