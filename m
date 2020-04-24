Return-Path: <SRS0=cw0N=6I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6F6C2BA1A
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:20:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A876320724
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBWnCA9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A876320724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03O9JuLo010352;
	Fri, 24 Apr 2020 11:19:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7AAC67827;
	Fri, 24 Apr 2020 11:19:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7D07C7815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:55 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03O9JrqG023492
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:54 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id t4so3513018plq.12
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 02:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E10z+/hFD4F95F2UWzEOlvrQsp6vhltCH9tesb3fENY=;
 b=nBWnCA9iuGEviwjS24K8VdE7weyMYl5232YQnGeFg2ElHQK7iG1mecpRcrqNlXOiEW
 SlhUJ+ysV9T92Fxr3XpDc58FGN0HcPprEjEBo79cMUGcvS8tLGl9POhUJLRHegcOqOSY
 DdZ+sI1CzYtaXl8ma7puRCpVpHDZNwqTCLAItwxqynuce3ECsJYeJPIXARrbc5C0fGRO
 35+nZVTCn9SZz2kzvAifFo3dw7ZnoMCcMoPWsl9IbePSSx7P/YNvTay9/SpLx2IdAV9E
 OAGian2H6ave3gk0ta1pPwZpNzCv9prtQYaD7N01Y7yYj1pI014O/HRp9ae17arewWvF
 g+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E10z+/hFD4F95F2UWzEOlvrQsp6vhltCH9tesb3fENY=;
 b=DLAiUcrYt0O/Ew9m6KvhzTOpFzWQmuZCnXOAKI5wLJxUe9kFiP0FEfLeMuOw93o/jB
 +F+PiatjPi97xypLC9S+eNg+kKIhc/V+b0rGpEiqd3Do5ui+R7tz4AO7TR98pq7d8FD/
 YyDK2DvXptODxp92vGxIA62/GSDi7fAOixF75hX/6/kipckOeY8YeLgeIbFLFeRmJzCK
 gq+1k2ay/GapeZFdo7U4pGwI2zTy2x5p9kMEz45FirfLcaAnVkg1CYtbz/zWHEif7DJn
 oVH6CKy5z5hCC1c1Nv6gvzjqHvF+VkLtOgZGdR4mzncJ0iYOAZifkFFcu4veNEMY5Jbp
 Oddw==
X-Gm-Message-State: AGi0Pub68U0o2tmYaFqn2nTILK7YyCAhUNbX+K+4+NoABvSrPlvj8vCk
 n2wSy7YR4Vz6jh6IkD5zZ1rp70K1oRw=
X-Google-Smtp-Source: APiQypJXqiDs1k2YsQAEhYCVGWfRDIhpGtMqIMgBXSpKwuigCBqv6qbbLGJVgfSVpyOP/i8y/9oHEA==
X-Received: by 2002:a17:902:b48a:: with SMTP id
 y10mr8112967plr.196.1587719993028; 
 Fri, 24 Apr 2020 02:19:53 -0700 (PDT)
Received: from localhost.localdomain ([1.38.216.60])
 by smtp.gmail.com with ESMTPSA id c80sm5043933pfb.82.2020.04.24.02.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 02:19:52 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 24 Apr 2020 14:47:58 +0530
Message-Id: <20200424091801.13871-23-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
References: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 11:19:56 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 24 Apr 2020 11:19:55 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [RFC PATCH 22/25] parsing_c: unparse_hrule: Add parameter
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
