Return-Path: <SRS0=jpx+=MF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E033C07E95
	for <cocci@archiver.kernel.org>; Tue, 13 Jul 2021 09:30:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E725660720
	for <cocci@archiver.kernel.org>; Tue, 13 Jul 2021 09:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E725660720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 16D9Ufn3004927;
	Tue, 13 Jul 2021 11:30:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4EA94776E;
	Tue, 13 Jul 2021 11:30:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E05ED3F5A
 for <cocci@systeme.lip6.fr>; Tue, 13 Jul 2021 11:30:39 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:102d])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 16D9UcME018528
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 13 Jul 2021 11:30:39 +0200 (CEST)
Received: by mail-pj1-x102d.google.com with SMTP id
 v18-20020a17090ac912b0290173b9578f1cso1560170pjt.0
 for <cocci@systeme.lip6.fr>; Tue, 13 Jul 2021 02:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=tzajH0/3fcrwOCNjaaz7vzFJGOq3f72ld3Euy8fxClE=;
 b=cjV1QRY96K0RgMvbNrgdK7pCjJho+90EZ8WTgs0ms0LYcMCfbOw1nLS9rKkulxKysD
 plcDPlrQjmhOt5heqLNBVBQgftA23P8LMdVT7sXZohkIlzOcMZpAfE3p0epdsqb4CRBx
 VaVfrVh8bM6alaBvLUfKlkrU77mvXaaiYNj9Oy/VDmjMZVYcxczF4PUeCgfW74FzPZ3G
 FNlKzA/a2nWxP4fIUDKTPExwf7uH5Gw8lTh7OTXnMi4VUzoLGz2/ftu8Y5nDfDsxUcYm
 3pj0QYGO0eXCJQWYs1+ZQJRUBv3WZdYOSrebrFeZIcCh0BZgmw2A22wh7K3L0R+ooFWr
 KULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tzajH0/3fcrwOCNjaaz7vzFJGOq3f72ld3Euy8fxClE=;
 b=TJ8Fca0FWDVWMfTQ/YOGV/dCJ5+7Mp4REmHbB69KMOak1jz66wsthwQdp4aCEuwVRS
 6Ubx+UfGvFemUkV2Vnboc9cSGUf8HpVBSZMZLl/YouWM/1hJYKJ5sV2xvXjWc1pHruhV
 /pQhADlvtUnbYfnZFT0Q5puscn60vkSb1Z8MdzAGqAjV+XeoqcraZTJ+HH1bre8kTUnq
 IG2SrEPmJ79iQmidesTbJQCfbPhour6IMdKxNYRF1x51eKMxbXMOMIGxE0d7i1AAeYyM
 OA2SvQuoyhswgYckvNLEOYsHA4o8/N5VtqhSj1aGYAunBJY7sNFlL4+5dYoKc/lxKpCW
 i1Ig==
X-Gm-Message-State: AOAM53157G/kG7JR1QoXXwRM0ZJskVlso61MHQp9bzZ5c06mbp0RoiWs
 YebyjZY7xisln13vxPylbfg=
X-Google-Smtp-Source: ABdhPJzM9iptF/gkeSwsMm6Uo5i0LYE+SxgHFvpcdNE9CJR2trY8FqIzDJ1bV1w4GNG/YhL+8rhdqw==
X-Received: by 2002:a17:902:74c7:b029:12a:f5c7:49f7 with SMTP id
 f7-20020a17090274c7b029012af5c749f7mr2848329plt.82.1626168637721; 
 Tue, 13 Jul 2021 02:30:37 -0700 (PDT)
Received: from adolin ([49.207.196.203])
 by smtp.gmail.com with ESMTPSA id g2sm17600078pjd.55.2021.07.13.02.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 02:30:37 -0700 (PDT)
Date: Tue, 13 Jul 2021 14:59:38 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: julia.lawall@inria.fr
Message-ID: <0ecb5ef3d290b95cde1bba88e047a40d754f6b52.1626167690.git.sylphrenadin@gmail.com>
References: <cover.1626167690.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1626167690.git.sylphrenadin@gmail.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 13 Jul 2021 11:30:41 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 13 Jul 2021 11:30:39 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH V2 2/2] docs: manual: Add option description in
	spatch_options
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

Add documentation for the "use-patch-diff" option introduced in
the first patch of this patchset. This option allows for
applying a semantic patch to only those files in a directory
where code additions have been made.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
Changes in V2:
    - Change "use-patchdiff" to "use-patch-diff" (Julia)
---
 docs/manual/spatch_options.tex | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/manual/spatch_options.tex b/docs/manual/spatch_options.tex
index a372aaf8a..393d254e3 100644
--- a/docs/manual/spatch_options.tex
+++ b/docs/manual/spatch_options.tex
@@ -220,6 +220,11 @@ intereted relative to the target directory.  If the filename is an absolute
 path name, beginning with /, it is used as is.
 }
 
+\normal{-{}-use-patch-diff}{ This option allows for applying a semantic patch
+  to only the files that have been modified in a directory. The directory needs
+  to be specified by the user. Note that an absolute path needs to be used if
+  spatch is called from outside the target project directory. }
+
 \normal{-{}-use-coccigrep}{ Use a version of grep implemented in Coccinelle
   to check that selected files are relevant to the semantic patch.  This
   option is only relevant to the case of working on a complete directory,
-- 
2.32.0

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
