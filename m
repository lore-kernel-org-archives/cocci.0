Return-Path: <SRS0=mjN0=CH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B962C433E6
	for <cocci@archiver.kernel.org>; Sat, 29 Aug 2020 19:36:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B3D2076D
	for <cocci@archiver.kernel.org>; Sat, 29 Aug 2020 19:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B3D2076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07TJa7vc003646;
	Sat, 29 Aug 2020 21:36:07 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D7411777D;
	Sat, 29 Aug 2020 21:36:07 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 66CAD3F6C
 for <cocci@systeme.lip6.fr>; Sat, 29 Aug 2020 21:36:06 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07TJa5aL004890
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 29 Aug 2020 21:36:05 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; d="scan'208";a="465220839"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Aug 2020 21:36:04 +0200
Date: Sat, 29 Aug 2020 21:36:04 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <20200811210127.11889-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2008292133360.3629@hadrien>
References: <20200811210127.11889-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 29 Aug 2020 21:36:08 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 29 Aug 2020 21:36:05 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>, cocci@systeme.lip6.fr,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [RFC PATCH] coccinelle: misc: add
 uninitialized_var.cocci script
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



On Wed, 12 Aug 2020, Denis Efremov wrote:

> Commit 63a0895d960a ("compiler: Remove uninitialized_var() macro") and
> commit 4b19bec97c88 ("docs: deprecated.rst: Add uninitialized_var()")
> removed uninitialized_var() and deprecated it.
>
> The purpose of this script is to prevent new occurrences of open-coded
> variants of uninitialized_var().
>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Applied, without the commented out part.

I only got three warnings, though.  Perhaps the others have been fixed?

lib/glob.c:48:31-39: WARNING: this kind of initialization is deprecated
drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:316:7-10: WARNING: this kind of initialization is deprecated
tools/testing/selftests/vm/userfaultfd.c:349:15-22: WARNING: this kind of initialization is deprecated

julia

> ---
> List of warnings:
> ./lib/glob.c:48:31-39: WARNING: this kind of initialization is deprecated
> ./tools/testing/selftests/vm/userfaultfd.c:349:15-22: WARNING: this kind of initialization is deprecated
> ./drivers/block/drbd/drbd_vli.h:330:5-9: WARNING: this kind of initialization is deprecated
> ./drivers/char/hw_random/intel-rng.c:333:15-18: WARNING: this kind of initialization is deprecated
> ./drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:316:7-10: WARNING: this kind of initialization is deprecated
> ./arch/x86/include/asm/paravirt_types.h:455:15-20: WARNING: this kind of initialization is deprecated
> ./arch/x86/include/asm/paravirt_types.h:455:30-35: WARNING: this kind of initialization is deprecated
> ./arch/x86/include/asm/paravirt_types.h:455:45-50: WARNING: this kind of initialization is deprecated
> ./arch/x86/include/asm/paravirt_types.h:475:15-20: WARNING: this kind of initialization is deprecated
> ./arch/x86/include/asm/paravirt_types.h:475:30-35: WARNING: this kind of initialization is deprecated
> ./arch/x86/include/asm/paravirt_types.h:476:2-7: WARNING: this kind of initialization isdeprecated
> ./arch/x86/include/asm/paravirt_types.h:476:17-22: WARNING: this kind of initialization is deprecated
> ./arch/x86/include/asm/paravirt_types.h:476:32-37: WARNING: this kind of initialization is deprecated
>
>  .../coccinelle/misc/uninitialized_var.cocci   | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/uninitialized_var.cocci
>
> diff --git a/scripts/coccinelle/misc/uninitialized_var.cocci b/scripts/coccinelle/misc/uninitialized_var.cocci
> new file mode 100644
> index 000000000000..e4787bc6ab9c
> --- /dev/null
> +++ b/scripts/coccinelle/misc/uninitialized_var.cocci
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// uninitialized_var() and its open-coded variations are
> +/// deprecated. For details, see:
> +/// Documentation/process/deprecated.rst
> +///
> +// Confidence: High
> +// Copyright: (C) 2020 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +//
> +
> +virtual context
> +virtual report
> +virtual org
> +
> +@r@
> +identifier var;
> +type T;
> +position p;
> +@@
> +
> +(
> +* T var@p = var;
> +|
> +* T var@p = *(&(var));
> +//|
> +// TODO: Actually, I'm not sure about this pattern.
> +// Looks like it's used in wireless drivers to determine
> +// whether data belongs to the driver or not.
> +// Here are all matches:
> +// https://elixir.bootlin.com/linux/latest/source/net/mac802154/util.c#L14
> +// https://elixir.bootlin.com/linux/latest/source/drivers/staging/wlan-ng/cfg80211.c#L48
> +// https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/intersil/orinoco/cfg.c#L21
> +// https://elixir.bootlin.com/linux/latest/source/net/mac80211/util.c#L37
> +// https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/rndis_wlan.c#L544
> +// * T *var@p = &var;
> +)
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +coccilib.report.print_report(p[0],
> +  "WARNING: this kind of initialization is deprecated")
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +coccilib.org.print_todo(p[0],
> +  "WARNING: this kind of initialization is deprecated")
> --
> 2.26.2
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
