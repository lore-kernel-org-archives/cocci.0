Return-Path: <SRS0=Yx51=7L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964C4C433DF
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:10:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BFAF206F0
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAOOT5Lj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFAF206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04TCA0w3021776;
	Fri, 29 May 2020 14:10:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8A99F7783;
	Fri, 29 May 2020 14:10:00 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3C36D5D47
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:09:58 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04TC9uw9028515
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:09:57 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id y11so1086905plt.12
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 05:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OPOEdbrp0+m25ziKK0qnI+Kfqtq0LVSPDHJCMCSV4uI=;
 b=EAOOT5LjKWfFRNI3CNQQDCgj0P8ImY01RwJ4JkMauV3e8T+1anlJE6DUxRx2AGaoat
 DehaI2x+k2NRfFSeSZ7OFhYQxkDUNnLxzc7q5qc+4s8+hp7gtOVd7r/evchdvG6p7i9p
 pc/8fTyJDlV3CmnPD37Oj1P0loaTDokyxWy2sIQHCtAQn6bcZFkacy2aIuftKbx6+Bbv
 DGftNY/BRJJeD7kOrJcM6FwKXPFo9C7eLDcGPOmBR9E8CGFMzHn9sYcbnqeeFi3dLPVq
 Vb6XqpKQrfpKpWCHp/V6QUpaw0DUrUmnYq+zgvYeEmikEOF+qo5D0CqniPDRmBuK0m2s
 3RmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OPOEdbrp0+m25ziKK0qnI+Kfqtq0LVSPDHJCMCSV4uI=;
 b=HCM632X85E2FYdxyzsAa0clPl2hvIEY5Cspf4dUCSWD/zFJrNWUgjiX5WaFvvSFIN6
 AzLGPllb7BrMNY0EFHJNr6WyjUckYCa0xac18tDXDKhD2f+a2n+AVF3lTzLliLSgVyhm
 EqaebgHKrk1LxwCxh3Zc/g8Hcbq/40l81Xv5fDanmHqD3BLCTCJxnEeBjZyArnN5wxks
 13AX/lZBA1MPx2HgPqY2cMUOsRTcCwJVUAFBZYw4KPBpXBV50FyXe17w4eu4mYHFSnQA
 iF/jfxS1Dvr4Q6u5yMpyeOuY4J4hINj+QG1BtN6X177uyTEVjrYyMgfpPk740GJz4xy2
 ruiQ==
X-Gm-Message-State: AOAM531rnfHwWQBoZqoHwSUkjEuZ5bMo8I7OEeWshzfnUoBVLQMcV0m8
 85XvtSqBX5AwFyNBJv+1JACU/J+y
X-Google-Smtp-Source: ABdhPJxQGd7qupC9jCb8XA95V6MRrJnLKH6BCguHGRFRlfOWTKP6E9VPLNN65aoFIwN2KTYw0oqw3g==
X-Received: by 2002:a17:902:c40c:: with SMTP id
 k12mr8373148plk.11.1590754195880; 
 Fri, 29 May 2020 05:09:55 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:694:e576:19d1:a79b:707d:59f2])
 by smtp.gmail.com with ESMTPSA id dw13sm7975161pjb.40.2020.05.29.05.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:09:55 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 29 May 2020 17:36:53 +0530
Message-Id: <20200529120703.31145-24-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
References: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 May 2020 14:10:00 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 May 2020 14:09:57 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 23/32] parsing_c: type_annoter_c: Reflect Cast
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
type_annoter_c.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/type_annoter_c.ml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/parsing_c/type_annoter_c.ml b/parsing_c/type_annoter_c.ml
index dfd363b2..dce9753c 100644
--- a/parsing_c/type_annoter_c.ml
+++ b/parsing_c/type_annoter_c.ml
@@ -525,7 +525,7 @@ let rec is_simple_expr expr =
       true
   | Binary (e1, op, e2) ->
       true
-  | Cast (t, e) ->
+  | Cast (t, a, e) ->
       true
   | ParenExpr (e) -> is_simple_expr e
 
@@ -961,7 +961,7 @@ let annotater_expr_visitor_subpart = (fun (k,bigf) expr ->
 
 
     (* -------------------------------------------------- *)
-    | Cast (t, e) ->
+    | Cast (t, e, a) ->
         k expr;
         (* todo: if infer, can "push" info ? add_types_expr [t] e ? *)
         make_info_def_fix (Lib.al_type t)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
