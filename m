Return-Path: <SRS0=bt/u=CL=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E1BC433E7
	for <cocci@archiver.kernel.org>; Wed,  2 Sep 2020 15:24:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4749D20767
	for <cocci@archiver.kernel.org>; Wed,  2 Sep 2020 15:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B27NRa3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4749D20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 082FO2KA002448;
	Wed, 2 Sep 2020 17:24:02 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7606C742E;
	Wed,  2 Sep 2020 17:24:02 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BB0A13F6C
 for <cocci@systeme.lip6.fr>; Wed,  2 Sep 2020 17:24:00 +0200 (CEST)
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:242])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 082FNxEa016002
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 2 Sep 2020 17:23:59 +0200 (CEST)
Received: by mail-lj1-x242.google.com with SMTP id a15so6431013ljk.2
 for <cocci@systeme.lip6.fr>; Wed, 02 Sep 2020 08:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bJN9g6XHl5Af9t91iN2fWoTn9p9DZy7KzM/HvdtvOCA=;
 b=B27NRa3Emoa6Of1Zl798T2u8PZyV4PzMDRi1aFFxgH3bJL8gVNZ0eKQU4Q+bsO2jhu
 Pyk8CrEucMA1dyaw6rbtbcNuL72qx+9D2e+2SyY7gZEwjpSGbTPS4rhlBSUgAZFxes6v
 VuolUOvPo13s+AwoIjD/vQ/I5onYCFlkWg/m4QekMnYAq8qbxGgTEa/hiDouKd+PpOmH
 bpa5Qdb8oHX/+kRuVVoLTRY37rY5oHBgJqBDomy0hyUIl4cx6/ph1N/AZYmVSoKohi6b
 cps/kELm0dQ4OOJa68LXEQnNzUeOZ2xDxWQtSY+OSqNwWNkUAQvhqp7kiR1oFlRCZUut
 AhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bJN9g6XHl5Af9t91iN2fWoTn9p9DZy7KzM/HvdtvOCA=;
 b=hy4qalMpxjmz/UQSKYSnuyDpjrxYtntItzBANnnIl5fI2C/QBrLcWTO/ncymutoOo1
 EMuPfocb6brNa0dQEmo7A5CRLrd7mdi7djf9oLSwgSwwZ60nWUydmdXR3bBqRDZQXCzt
 KYHu1nIKtB+m2ABcc3PE4cMnK2TGU9STv7ywrZDFrWJwwqVaIwl5VJPFfbNrvieSoND5
 VQMA72TLOlVw8YdgGgSIlAt3L6Ppy3m9FVCM5zMhrXwW1DVgc/fc+uhUgX6Deor1qdlE
 L+DADlefIIn7RReSwHlwQMUk/i05o+lU79RQersrXa7KY4qbfHeNVfauNEy4d04ctidG
 NlSA==
X-Gm-Message-State: AOAM533S296V8kOT2d4gCWPyWobTMl3idV2wKroxjImCCjLKENgOU+1/
 3pb4HJNhc0DVqMWVWOlxbhP94BivmWrISWZrYFaPCR9JpaU=
X-Google-Smtp-Source: ABdhPJznxOwyVo+IaOPagU1IMiceEoVK9/Q2lz2grZrBudqtOPUJsvHNLofThyHfOAhXPIvpRP2DTvRVNfvp+dRTaeQ=
X-Received: by 2002:a2e:8844:: with SMTP id z4mr3407333ljj.124.1599060238830; 
 Wed, 02 Sep 2020 08:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200902151859.403354-1-efremov@linux.com>
In-Reply-To: <20200902151859.403354-1-efremov@linux.com>
From: Jim Davis <jim.epost@gmail.com>
Date: Wed, 2 Sep 2020 08:23:47 -0700
Message-ID: <CA+r1ZhiNx+3n_u+TR==fM8jwJHNr1JdH8ijayo5hW9wvam1zJg@mail.gmail.com>
To: Denis Efremov <efremov@linux.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 02 Sep 2020 17:24:02 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 02 Sep 2020 17:23:59 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Cocci] [PATCH] coccinelle: misc: add excluded_middle.cocci
	script
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

On Wed, Sep 2, 2020 at 8:19 AM Denis Efremov <efremov@linux.com> wrote:
>
> Check for "!A || A && B" condition. It's equivalent to
> "!A || B" condition.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  scripts/coccinelle/misc/excluded_middle.cocci | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/excluded_middle.cocci
>
> diff --git a/scripts/coccinelle/misc/excluded_middle.cocci b/scripts/coccinelle/misc/excluded_middle.cocci
> new file mode 100644
> index 000000000000..1b8c20f13966
> --- /dev/null
> +++ b/scripts/coccinelle/misc/excluded_middle.cocci
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Condition "!A || A && B" is equalent to "!A || B".

s/equalent/equivalent/

> +///
> +// Confidence: High
> +// Copyright: (C) 2020 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> +@r depends on !patch@
> +expression A, B;
> +position p;
> +@@
> +
> +* !A || (A && B)@p
> +
> +@depends on patch@
> +expression A, B;
> +@@
> +
> +  !A ||
> +-      (A &&
> +             B
> +-      )
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING condition !A || A && B is equivalent to !A || B")
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING condition !A || A && B is equivalent to !A || B")
> --
> 2.26.2
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci



-- 
Jim
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
