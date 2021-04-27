Return-Path: <SRS0=KM+6=JY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21540C433ED
	for <cocci@archiver.kernel.org>; Tue, 27 Apr 2021 13:57:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F47061185
	for <cocci@archiver.kernel.org>; Tue, 27 Apr 2021 13:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F47061185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 13RDvULu005339;
	Tue, 27 Apr 2021 15:57:30 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B46317634;
	Tue, 27 Apr 2021 15:57:30 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 152393DD8
 for <cocci@systeme.lip6.fr>; Tue, 27 Apr 2021 15:55:10 +0200 (CEST)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 13RDt8si002681
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 27 Apr 2021 15:55:08 +0200 (CEST)
Received: by mail-ot1-f51.google.com with SMTP id
 z20-20020a0568301294b02902a52ecbaf18so2982858otp.8
 for <cocci@systeme.lip6.fr>; Tue, 27 Apr 2021 06:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qezdgbyatE1l8zypI4FJQjmH7o9oUZIhojul/qRpkU0=;
 b=pyCsTL2r+H3RJV/dCQgVgvnXwxSt74gGmQ6UZv1rosHA+9txl1QpF40QX27og5PTv4
 Rz5MhXgdmp7S99rsDWvxbG7+Dp7HrGCCS4HpkTCxEMrh170B18WazPvbshSRewgP54ej
 LgAcGPFuUM9+w4g+yGh+5HXWDSEbLx790VF0rQmtliO6pZ3jTbroxS8tPs/hc+UHP9vL
 yUDGNvxl47bEY3yiHyVnPukr/V/iT6RUkKYH0SlvJgqsloAwJoeOwcU8xW8qoORj43zQ
 56jBV9TbAJNNE4zlKnZ5JUYtd+CFIFip7vohCoALVWfQ80pZCQzd3K/KltNzdnCTd6It
 S0vQ==
X-Gm-Message-State: AOAM532r1h8ejUrV1JCEHCw/sJ2ud1jPzBVn4Ayz8ICuMsLvSrHA8EDE
 siHyEMTpB7oQZipDfDDYo2F1IuEHe4eTRy1UN593+57X
X-Google-Smtp-Source: ABdhPJxCYPLWLZ+In6uL5ea3rfA/sRsYCBbR83vXiHsXVds9LKZjv4AmhBg/RtM2rhV2GrS2/X/KWjb6BDPFY05bQlc=
X-Received: by 2002:a05:6830:55b:: with SMTP id
 l27mr19534881otb.260.1619531707610; 
 Tue, 27 Apr 2021 06:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210427125834.2477467-1-Julia.Lawall@inria.fr>
In-Reply-To: <20210427125834.2477467-1-Julia.Lawall@inria.fr>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Apr 2021 15:54:56 +0200
Message-ID: <CAJZ5v0ib-RegkeXf7G3mHjp2oRu7cSpCYBH_3BqGfKSe39fh4A@mail.gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 27 Apr 2021 15:57:30 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 27 Apr 2021 15:55:09 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 27 Apr 2021 15:57:28 +0200
Cc: Michal Marek <michal.lkml@markovi.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        kernel-janitors@vger.kernel.org,
        Zhang Qilong <zhangqilong3@huawei.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v3] coccinelle: api: semantic patch to use
	pm_runtime_resume_and_get
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

On Tue, Apr 27, 2021 at 3:51 PM Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> pm_runtime_get_sync keeps a reference count on failure, which can lead
> to leaks.  pm_runtime_resume_and_get drops the reference count in the
> failure case.  This rule very conservatively follows the definition of
> pm_runtime_resume_and_get to address the cases where the reference
> count is unlikely to be needed in the failure case.  Specifically, the
> change is only done when pm_runtime_get_sync is followed immediately
> by an if and when the branch of the if is immediately a call to
> pm_runtime_put_noidle (like in the definition of
> pm_runtime_resume_and_get) or something that is likely a print
> statement followed by a pm_runtime_resume_and_get call.  The patch
> case appears somewhat more complicated, because it also deals with the
> cases where {}s need to be removed.
>
> pm_runtime_resume_and_get was introduced in
> commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to
> deal with usage counter")
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

This patch looks good to me, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

>
> ---
> v3: add the people who signed off on commit dd8088d5a896, expand the log message
> v2: better keyword
>
>  scripts/coccinelle/api/pm_runtime_resume_and_get.cocci |  153 +++++++++++++++++
>  1 file changed, 153 insertions(+)
>
> diff --git a/scripts/coccinelle/api/pm_runtime_resume_and_get.cocci b/scripts/coccinelle/api/pm_runtime_resume_and_get.cocci
> new file mode 100644
> index 000000000000..3387cb606f9b
> --- /dev/null
> +++ b/scripts/coccinelle/api/pm_runtime_resume_and_get.cocci
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Use pm_runtime_resume_and_get.
> +/// pm_runtime_get_sync keeps a reference count on failure,
> +/// which can lead to leaks.  pm_runtime_resume_and_get
> +/// drops the reference count in the failure case.
> +/// This rule addresses the cases where the reference count
> +/// is unlikely to be needed in the failure case.
> +///
> +// Confidence: High
> +// Copyright: (C) 2021 Julia Lawall, Inria
> +// URL: https://coccinelle.gitlabpages.inria.fr/website
> +// Options: --include-headers --no-includes
> +// Keywords: pm_runtime_get_sync
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> +@r0 depends on patch && !context && !org && !report@
> +expression ret,e;
> +@@
> +
> +-     ret = pm_runtime_get_sync(e);
> ++     ret = pm_runtime_resume_and_get(e);
> +-     if (ret < 0)
> +-             pm_runtime_put_noidle(e);
> +
> +@r1 depends on patch && !context && !org && !report@
> +expression ret,e;
> +statement S1,S2;
> +@@
> +
> +-     ret = pm_runtime_get_sync(e);
> ++     ret = pm_runtime_resume_and_get(e);
> +      if (ret < 0)
> +-     {
> +-             pm_runtime_put_noidle(e);
> +             S1
> +-     }
> +      else S2
> +
> +@r2 depends on patch && !context && !org && !report@
> +expression ret,e;
> +statement S;
> +@@
> +
> +-     ret = pm_runtime_get_sync(e);
> ++     ret = pm_runtime_resume_and_get(e);
> +      if (ret < 0) {
> +-             pm_runtime_put_noidle(e);
> +             ...
> +      } else S
> +
> +@r3 depends on patch && !context && !org && !report@
> +expression ret,e;
> +identifier f;
> +constant char[] c;
> +statement S;
> +@@
> +
> +-     ret = pm_runtime_get_sync(e);
> ++     ret = pm_runtime_resume_and_get(e);
> +      if (ret < 0)
> +-     {
> +              f(...,c,...);
> +-             pm_runtime_put_noidle(e);
> +-     }
> +      else S
> +
> +@r4 depends on patch && !context && !org && !report@
> +expression ret,e;
> +identifier f;
> +constant char[] c;
> +statement S;
> +@@
> +
> +-     ret = pm_runtime_get_sync(e);
> ++     ret = pm_runtime_resume_and_get(e);
> +      if (ret < 0) {
> +              f(...,c,...);
> +-             pm_runtime_put_noidle(e);
> +             ...
> +      } else S
> +
> +// ----------------------------------------------------------------------------
> +
> +@r2_context depends on !patch && (context || org || report)@
> +statement S;
> +expression e, ret;
> +position j0, j1;
> +@@
> +
> +*     ret@j0 = pm_runtime_get_sync(e);
> +      if (ret < 0) {
> +*             pm_runtime_put_noidle@j1(e);
> +             ...
> +      } else S
> +
> +@r3_context depends on !patch && (context || org || report)@
> +identifier f;
> +statement S;
> +constant char []c;
> +expression e, ret;
> +position j0, j1;
> +@@
> +
> +*     ret@j0 = pm_runtime_get_sync(e);
> +      if (ret < 0) {
> +              f(...,c,...);
> +*             pm_runtime_put_noidle@j1(e);
> +             ...
> +      } else S
> +
> +// ----------------------------------------------------------------------------
> +
> +@script:python r2_org depends on org@
> +j0 << r2_context.j0;
> +j1 << r2_context.j1;
> +@@
> +
> +msg = "WARNING: opportunity for pm_runtime_get_sync"
> +coccilib.org.print_todo(j0[0], msg)
> +coccilib.org.print_link(j1[0], "")
> +
> +@script:python r3_org depends on org@
> +j0 << r3_context.j0;
> +j1 << r3_context.j1;
> +@@
> +
> +msg = "WARNING: opportunity for pm_runtime_get_sync"
> +coccilib.org.print_todo(j0[0], msg)
> +coccilib.org.print_link(j1[0], "")
> +
> +// ----------------------------------------------------------------------------
> +
> +@script:python r2_report depends on report@
> +j0 << r2_context.j0;
> +j1 << r2_context.j1;
> +@@
> +
> +msg = "WARNING: opportunity for pm_runtime_get_sync on line %s." % (j0[0].line)
> +coccilib.report.print_report(j0[0], msg)
> +
> +@script:python r3_report depends on report@
> +j0 << r3_context.j0;
> +j1 << r3_context.j1;
> +@@
> +
> +msg = "WARNING: opportunity for pm_runtime_get_sync on %s." % (j0[0].line)
> +coccilib.report.print_report(j0[0], msg)
> +
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
