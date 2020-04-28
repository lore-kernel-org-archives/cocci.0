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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60563C8300A
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:03:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0040520730
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CD9CpE0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0040520730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SH3AKd019911;
	Tue, 28 Apr 2020 19:03:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9AFBF7807;
	Tue, 28 Apr 2020 19:03:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E0B833DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:03:08 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:644])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SH37vL001525
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:03:08 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id z6so8614631plk.10
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 10:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1+jQvFfCERdvlbrN50zvK3j7kjY87WUidq4SpOe7Ai4=;
 b=CD9CpE0ZcDsD096tn/LfQi72UOFFm/mZQ7h1GX8jMMq+p322SNMX1VP1dZAouyX4Xw
 /5LjfRFC7HSXgJ3RNbHw2/vc7dkL5SDaX/AkoW8HDSqLYvnNjrfE0HUf6KpcF7UsY3b1
 OdROMvpGictNUgKewgL1vNrRnzUIEPR+qGvgmcFgbhZt/0NZQGVSSZhD6XManMcchft5
 TjYU+kD37Ysljd06c49Gdq0dON1XbyLBL0LZ2m1+XgaVDr+GvhFaJyyNe5mhMTiuph/1
 U94qUM0j77yWos66zroYwGf5QK5IvcOkF4N8+MA1QzVrOIT0vcS3W4Nzmok5tX6W7YRy
 uJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1+jQvFfCERdvlbrN50zvK3j7kjY87WUidq4SpOe7Ai4=;
 b=hxnZQvxXDcdcrZdKkTec8k14SpGy57ihCKUTOqLZ9BaMLXL7gyuBxwsX4Oei+UVJ2S
 siSpHUvc+ObTvY5FHd8CtUiaOvmWrSYPu7No5dNm2S9OEof1sT0kAO2VQEdMSxEm2AHX
 Ej4LF35OX6qhyztHajCe2Zq3BK1zI8KVR3PQUToTEsNsXzod/PcAqBFJnoZ9NujgW7u8
 fX0NqkToBBrhU8o6QI0JNwHTYGzByUjCHHMydXHmqAOjKa4OzSy8dozcf/mloQcOTg+b
 Jg/31wRItJ1B8avL5y2UV3H1PnCa3NNxxpPLv/Pbnr0SJGUFXZKDaUGcl4G6aH6zTq1l
 EDzg==
X-Gm-Message-State: AGi0PuYzY9bROVyuPLsTOKeacz7j0s+zKPDY+ztURHRYgg/u658oFwgm
 fsbapQVN+9Wu8ceZIqKj6qV+h1x7SGY=
X-Google-Smtp-Source: APiQypLazU1ABKBDta8T60ejhqmMSo1HERY5RPq/XDSu4IgvChf5+vJHposT9X6Gica+rEbtokKmjg==
X-Received: by 2002:a17:902:8d91:: with SMTP id
 v17mr28045418plo.53.1588093386551; 
 Tue, 28 Apr 2020 10:03:06 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.163])
 by smtp.gmail.com with ESMTPSA id u15sm2505097pjm.47.2020.04.28.10.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:03:06 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 28 Apr 2020 22:32:02 +0530
Message-Id: <20200428170228.7002-7-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:03:10 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 19:03:08 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 06/32] parsing_cocci: index: Reflect Cast attributes
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
index.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/index.ml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parsing_cocci/index.ml b/parsing_cocci/index.ml
index f7ae48b4..a3b92c12 100644
--- a/parsing_cocci/index.ml
+++ b/parsing_cocci/index.ml
@@ -61,7 +61,7 @@ let expression e =
   | Ast0.ArrayAccess(exp1,lb,exp2,rb) -> [27]
   | Ast0.RecordAccess(exp,pt,field) -> [28]
   | Ast0.RecordPtAccess(exp,ar,field) -> [29]
-  | Ast0.Cast(lp,ty,rp,exp) -> [30]
+  | Ast0.Cast(lp,ty,attr,rp,exp) -> [30]
   | Ast0.SizeOfExpr(szf,exp) -> [98] (* added after *)
   | Ast0.SizeOfType(szf,lp,ty,rp) -> [99] (* added after *)
   | Ast0.TypeExp(ty) -> [123] (* added after *)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
