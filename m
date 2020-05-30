Return-Path: <SRS0=5T8e=7M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44E9C433DF
	for <cocci@archiver.kernel.org>; Sat, 30 May 2020 20:54:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB092074D
	for <cocci@archiver.kernel.org>; Sat, 30 May 2020 20:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB092074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04UKs99S019028;
	Sat, 30 May 2020 22:54:09 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DE9343E1D;
	Sat, 30 May 2020 22:54:08 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CDE573C89
 for <cocci@systeme.lip6.fr>; Sat, 30 May 2020 22:54:06 +0200 (CEST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04UKs6mh017926
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 30 May 2020 22:54:06 +0200 (CEST)
Received: by mail-lf1-f41.google.com with SMTP id r125so1683678lff.13
 for <cocci@systeme.lip6.fr>; Sat, 30 May 2020 13:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xw605j63H08pFbKFHsgPllo2g2mBV5dsiKNt9j9qDLc=;
 b=OH0jEJDgx9qiw7UPITBYPV1YOTt0fMRm3wgm96c06qhT21/538InIPEmf9QCqbbXfL
 /P69tbQ0oU9tmFO2PTFwppMIm8kL+ui79PMl/DbkbsXdKfW+G8uyWyZ7Aj11oGzcpnqG
 zwWHJfYOznBQGwm1Yrpg4RnnKnPWiN17KiYBU+Sl11UTBJ0IKLf8OL+035PVdSfcwpgq
 hFm/vTuDXmJsx6NqqVXe9ZZLEHYY1D6YCc8VVr2thLuyGhZm49IcnuYqYdgNmNOeHFVo
 OZ5vhvikzUJsqw6rbPjGXu01/uOkqfDUCwWdYFsJxd7hSg5MPxYi27V448/3UYHYYGLt
 keVg==
X-Gm-Message-State: AOAM532Q0XM/8t8m1wxEXysOY/fSLXK4mUMTAwVs5cVRHorLCyJOGqLx
 jAnqWjvPC2aW8Xo9eWS/9RQ=
X-Google-Smtp-Source: ABdhPJzSEX8QyOMAA1V//YoNaGqRWRM7xSXsjtYzlT6TUuXeEa9s4HUs0M09UkMHrrAXbFMqG0jCJw==
X-Received: by 2002:a19:be55:: with SMTP id o82mr7363818lff.168.1590872045818; 
 Sat, 30 May 2020 13:54:05 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.196])
 by smtp.googlemail.com with ESMTPSA id f6sm2816670ljn.91.2020.05.30.13.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2020 13:54:05 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>, Joe Perches <joe@perches.com>
Date: Sat, 30 May 2020 23:53:46 +0300
Message-Id: <20200530205348.5812-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 30 May 2020 22:54:11 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 30 May 2020 22:54:06 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH 0/2] Update memdup_user.cocci
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

Add GFP_USER to the allocation flags and handle vmemdup_user().

Denis Efremov (2):
  Coccinelle: extend memdup_user transformation with GFP_USER
  Coccinelle: extend memdup_user rule with vmemdup_user()

 scripts/coccinelle/api/memdup_user.cocci | 53 ++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 4 deletions(-)

-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
