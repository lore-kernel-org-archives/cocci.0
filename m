Return-Path: <SRS0=4Vt5=DS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5766C433E7
	for <cocci@archiver.kernel.org>; Sun, 11 Oct 2020 10:31:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15771207F7
	for <cocci@archiver.kernel.org>; Sun, 11 Oct 2020 10:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atsoKcpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15771207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09BAVH2m012615;
	Sun, 11 Oct 2020 12:31:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 509BA778E;
	Sun, 11 Oct 2020 12:31:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E05E7578C
 for <cocci@systeme.lip6.fr>; Sun, 11 Oct 2020 12:31:15 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09BAVDUa015004
 for <cocci@systeme.lip6.fr>; Sun, 11 Oct 2020 12:31:13 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id w21so4104560plq.3
 for <cocci@systeme.lip6.fr>; Sun, 11 Oct 2020 03:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=qUbbonkvmJI/PJT7XYEgXBBQWmM8xuj/vukAq6acOQg=;
 b=atsoKcpA55UYV64jggSZrb3ULedRugy+lwNE37vqe1BPXujehi9wIVO6s5gtd1aAjQ
 1MQS2/rZxlgFbxPlefPOvfzfppp35hW7slcDPoQEpR2Vvvws9ZOS2aFckB5PlEBU5UJS
 JexYM7AyCjrDzwRy0m5HmpiUxJeeMBll8VJ58tlVf6/Lpv7Y82EeUeIRUmxXF4t/rZLe
 BI4tovth7mP+qWSdG1heminPKTiq81HpeGMbagfXaB9AA/7xkIVnvHis/UD033ArHl0N
 mywJmKyowxhfA7H9Ovl8dECZPBZeOEaypg57/D37Ho/lzdUokDRpAOaigniDMMHfHe3O
 rYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qUbbonkvmJI/PJT7XYEgXBBQWmM8xuj/vukAq6acOQg=;
 b=YD4qaLUfeaGHl+gGBciREQhsgh6AjG+3EY5SA5Fo5RZyprJPYcFFmi4rMIPLqh5InL
 enUo/788ykzMGrS9iJvW/86DrNYdUjHdGAgGRp8OXJTZr1rZCcNopcAwiT70OPGzZ1Yj
 WkGp6cfbPO0HTatu81E7hSbY5mIABeKi1nqt+wykJTWLfKWkpFgCAAh/oqi/rcxCmqn9
 p6wSLFYVImUV0rvGLmpTh90sFx3WCmMKFLQg+V6+eibt5OA+cZe3o2KizEvfUSjJkJjY
 tlUCn9RaAdHj1WQwQRHiauvhswwjxSc0MzE2oUQCgiVNsuVXrTqP0Dy8jqVoXiYEIumA
 JRZA==
X-Gm-Message-State: AOAM531tkKFwlD/xh5ehf3a/NZ163po1Y/VSImiOKSBHGduGOU6MB3Fi
 CaeG/G8zbVZQ6NhCj0ISiFw=
X-Google-Smtp-Source: ABdhPJxzk0tcJh/JkNlmWArqX0vyYcSVvNqk7B169R1YAufNKFrOqTA7nPOqA4jjTG49STxQWhmFSw==
X-Received: by 2002:a17:902:8202:b029:d2:2f2a:6712 with SMTP id
 x2-20020a1709028202b02900d22f2a6712mr19441292pln.15.1602412272824; 
 Sun, 11 Oct 2020 03:31:12 -0700 (PDT)
Received: from adolin ([49.207.215.73])
 by smtp.gmail.com with ESMTPSA id o4sm4394694pjj.38.2020.10.11.03.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 03:31:12 -0700 (PDT)
Date: Sun, 11 Oct 2020 16:01:07 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Message-ID: <15c5f36aea99a8947847a31cc0f982f9e829a12b.1602410019.git.sylphrenadin@gmail.com>
References: <cover.1602410019.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1602410019.git.sylphrenadin@gmail.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 11 Oct 2020 12:31:17 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 11 Oct 2020 12:31:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, linux-doc@vger.kernel.org, Gilles.Muller@lip6.fr,
        corbet@lwn.net, nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH v4 3/3] Documentation: Coccinelle: Modify
 Parallelisation information in docs
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

This patchset modifies coccicheck to use at most one thread per core by
default in machines with more than 4 hyperthreads for optimal performance.
Modify documentation in coccinelle.rst to reflect the same.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 Documentation/dev-tools/coccinelle.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 74c5e6aeeff5..530d8d313601 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -130,8 +130,10 @@ To enable verbose messages set the V= variable, for example::
 Coccinelle parallelization
 --------------------------
 
-By default, coccicheck tries to run as parallel as possible. To change
-the parallelism, set the J= variable. For example, to run across 4 CPUs::
+By default, coccicheck uses at most 1 thread per core in a machine
+with more than 4 hyperthreads. In a machine with upto 4 threads,
+all threads are used. To change the parallelism, set the J= variable.
+For example, to run across 4 CPUs::
 
    make coccicheck MODE=report J=4
 
-- 
2.25.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
