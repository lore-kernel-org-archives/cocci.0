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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4024C83001
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:04:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA2D20730
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U17e/33A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA2D20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SH3rJe004415;
	Tue, 28 Apr 2020 19:03:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EF39F7807;
	Tue, 28 Apr 2020 19:03:52 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DC11E3DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:03:50 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SH3nXa002101
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:03:50 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id 18so10967551pfx.6
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CNxRdEPW7QUn5zzPjSnEIhrS6dlbepskoBKaR1q3VWc=;
 b=U17e/33Ap88F0tifk04WqTiqa3LOU8ocaitCgf579345Uhtd9c6gLOFC2/uFe9dW2Y
 G4YT0PFMTTj6utVMrOlQe3KuGGkcmLT8N3yEeUC1YWHydpsWl1iXiKbk3tUBvUwOquNw
 uTLWG6gIZUjcXAe6ohOL1nTSs5F2n0l1GJv8RH/YhFPVJTD9Nwv2koof1GZ0Quy1Lh/5
 NKSvQW4NPl/87Zrq3CfHlkybrVG5ssw37hEaDd+kDQauM74bQtx52MFbqu0J7SmzRIOn
 k31rcB3ysgqQSHMNOJvR8+2lt//qBRI77/pJVxUp9rvmqNvUqxT4Sm+aFR+rEzcxKN5x
 kGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CNxRdEPW7QUn5zzPjSnEIhrS6dlbepskoBKaR1q3VWc=;
 b=P/1ZoIWpcwbf0R7aynPPR3/oQT4haUdeDksoiAcudJzH0+roqOmf80ACTtc5P9kz7w
 V8T7Rd8U3x/AfDYDuRqKegAqHcODTBJwWiTjyta3okWI5kZuTi44CwXLtu9GtTLYQCtk
 GtcytnqkvIk7C4yuN56HXwQjSXqaE2+yAQh7rfznPGbCxBlrJjLkrLK+j18EWF3gZfDS
 1BxVbqfSRbREh4aVhPjqd5MNVAhWtKE0FFF/sqjac1Lel7uH6uDGy2wNWIGchuC+sXs4
 QfDYNYeltG048eKa+60nykyXnUZVzHsWRQ3gNZlkpD6dWgrya5wDZGvRBsWeBRYuqLrC
 GXFw==
X-Gm-Message-State: AGi0Puaa/W+Wcz/QvXRXEeibccW7PHmDnsWej/3bY5sD4wWNY/c9316B
 DxnGp74dJ8j/Ct+MFzJofK8OKx4mB7c=
X-Google-Smtp-Source: APiQypIHNJERwG5u0aTfu5DCCOEQN9EMy4cF+SwBlQekmww3Xh8bOTifF56XUGuGAdi3yUFp+Jv4VA==
X-Received: by 2002:a63:1845:: with SMTP id 5mr24804458pgy.69.1588093428534;
 Tue, 28 Apr 2020 10:03:48 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.163])
 by smtp.gmail.com with ESMTPSA id u15sm2505097pjm.47.2020.04.28.10.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:03:48 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 28 Apr 2020 22:32:12 +0530
Message-Id: <20200428170228.7002-17-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:03:53 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 19:03:50 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 16/32] parsing_cocci: pretty_print_cocci: Print cast
	attributes
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

Cast attributes are added to the SmPL AST. Reflect these changes in
pretty_print_cocci.ml by printing these attributes.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/pretty_print_cocci.ml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/parsing_cocci/pretty_print_cocci.ml b/parsing_cocci/pretty_print_cocci.ml
index 7628882b..2ace0b44 100644
--- a/parsing_cocci/pretty_print_cocci.ml
+++ b/parsing_cocci/pretty_print_cocci.ml
@@ -249,8 +249,10 @@ let rec expression e =
       expression exp; mcode print_string pt; ident field
   | Ast.RecordPtAccess(exp,ar,field) ->
       expression exp; mcode print_string ar; ident field
-  | Ast.Cast(lp,ty,rp,exp) ->
+  | Ast.Cast(lp,ty,attr,rp,exp) ->
       mcode print_string_box lp; fullType ty; close_box();
+      (if not (attr = []) then print_string " ");
+      print_between print_space (mcode print_string) attr;
       mcode print_string rp; expression exp
   | Ast.SizeOfExpr(sizeof,exp) ->
       mcode print_string sizeof; expression exp
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
