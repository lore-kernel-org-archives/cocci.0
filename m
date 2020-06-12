Return-Path: <SRS0=FQJD=7Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4ACC433DF
	for <cocci@archiver.kernel.org>; Fri, 12 Jun 2020 06:46:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8589E207F7
	for <cocci@archiver.kernel.org>; Fri, 12 Jun 2020 06:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpCgNK44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8589E207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05C6kPKd011456;
	Fri, 12 Jun 2020 08:46:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3982744A7;
	Fri, 12 Jun 2020 08:46:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D86533BAB
 for <cocci@systeme.lip6.fr>; Fri, 12 Jun 2020 08:46:23 +0200 (CEST)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05C6kMCd011181
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 12 Jun 2020 08:46:23 +0200 (CEST)
Received: by mail-pg1-x542.google.com with SMTP id t7so3689840pgt.3
 for <cocci@systeme.lip6.fr>; Thu, 11 Jun 2020 23:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5TFnz4lPJiP/gesszZznbRbJ5EYTo2GON/fiHmKhvIc=;
 b=hpCgNK44K21axee+YJbBF4tgKfeEljEf2RvIotnfsf1uQ8/0uiM4MK/z4mvTMBQ85b
 uDj2GAa//AtoTN5r+vp6zm9PI3Ma0BD1TpohFcPIO3tzruIb0nYefR3xeQYzRwbp35WP
 dypLaMrBTdNqA0yygTOZHy0hX53I8UVuaCqyqm0I6cKiNlImknE/zPpqZCs1+32zzdbz
 wS0tSUTU/AtsJD9e2TlbRpBneK0NfaU3H2LvRQGTi1qXSxCgQbjhDGExkyqOVz2aErp7
 hYR5SLAUcquuKU7miIdymmDsGTCLk6d+7so9+t7EImGUrjkHGVAYfroJEiZ5W8fozrx5
 lHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5TFnz4lPJiP/gesszZznbRbJ5EYTo2GON/fiHmKhvIc=;
 b=XkIG+A5VSpxG1PuP4SJ1vGZwVMwNh3iGi0Bq8Usg6F+kG8ZhmNkKfgj5l/BwBgjLka
 3/nLC3vxT+pnpBxGOwJyxrZhdbJwyUGKcBBSByJ/LLh2gkiqLwJvkiS9xDKRtix2m2ep
 y7JmAbfD+SkLvNhXRbZMrHiO8iy5+VsgvYgcfgtGRGm8nr+YnDxtDJ0QeaN9eQc3HVUR
 9we7cL0EEUJ7ug0CVhtCo2I5DOJ+XD+qaHhkICwJcqhXkNyu8Hh2VSjrH2+ycPFnhOen
 2ZtGbWuyw4Kr4uwZDjDUtXvLPwrm1xbXh9kC7jgVULg90+DyN0uc37/9FOJUjHNLOH7t
 q0gQ==
X-Gm-Message-State: AOAM5307RIAMaT9ajeD1kWGiRqIXcANTaBf44uLdPOFgNF+qXzauGfVb
 SiItruRURwc4YcmJ7IYad1sVbo7k
X-Google-Smtp-Source: ABdhPJxwX4t7bb9/xuU+pfIaJ7tPz8tF/47c15RhsxXquIzJNlfal9NZsK3LlLlK0lb3ruMt0ecp9Q==
X-Received: by 2002:a62:7993:: with SMTP id
 u141mr10993826pfc.110.1591944381454; 
 Thu, 11 Jun 2020 23:46:21 -0700 (PDT)
Received: from localhost.localdomain ([1.38.217.229])
 by smtp.gmail.com with ESMTPSA id w192sm5087476pff.126.2020.06.11.23.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 23:46:21 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 12 Jun 2020 12:15:44 +0530
Message-Id: <20200612064544.30194-4-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200612064544.30194-1-jaskaransingh7654321@gmail.com>
References: <20200612064544.30194-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 12 Jun 2020 08:46:25 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 12 Jun 2020 08:46:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 3/3] parsing_cocci: unify_ast: Apply unify_mcode on
	macrodecl attrs
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

The following commit introduced some poor management of attributes in
unify_ast.ml:
	b4b8653bd5a9607922e0050fe2fede10d422b218
Apply unify_mcode on macrodecl attributes in unify_ast.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/unify_ast.ml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/parsing_cocci/unify_ast.ml b/parsing_cocci/unify_ast.ml
index 752e9283..788c8fdc 100644
--- a/parsing_cocci/unify_ast.ml
+++ b/parsing_cocci/unify_ast.ml
@@ -413,7 +413,8 @@ and unify_declaration d1 d2 =
        else false
   | (Ast.MacroDecl(s1,n1,lp1,args1,rp1,attr1,sem1),
      Ast.MacroDecl(s2,n2,lp2,args2,rp2,attr2,sem2)) ->
-       if bool_unify_option unify_mcode s1 s2
+       if bool_unify_option unify_mcode s1 s2 &&
+         List.for_all2 unify_mcode attr1 attr2
        then
 	 unify_ident n1 n2 &&
 	 unify_dots unify_expression edots args1 args2
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
