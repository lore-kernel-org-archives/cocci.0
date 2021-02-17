Return-Path: <SRS0=7S2e=HT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D00C433DB
	for <cocci@archiver.kernel.org>; Wed, 17 Feb 2021 21:18:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B01A64E58
	for <cocci@archiver.kernel.org>; Wed, 17 Feb 2021 21:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B01A64E58
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11HLHxAb026325;
	Wed, 17 Feb 2021 22:17:59 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AD94877C0;
	Wed, 17 Feb 2021 22:17:59 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8A78824DD
 for <cocci@systeme.lip6.fr>; Wed, 17 Feb 2021 22:17:57 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11HLHuH8027681
 for <cocci@systeme.lip6.fr>; Wed, 17 Feb 2021 22:17:57 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.81,185,1610406000"; d="scan'208";a="373371849"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Feb 2021 22:17:56 +0100
Date: Wed, 17 Feb 2021 22:17:56 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <20210216160326.1341741-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2102172208030.3081@hadrien>
References: <20210216160326.1341741-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Feb 2021 22:18:00 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 17 Feb 2021 22:17:57 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: misc: add minmax script
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



On Tue, 16 Feb 2021, Denis Efremov wrote:

> Check for opencoded min(), max() implementations.

Some cases that could be improved:

diff -u -p a/drivers/platform/x86/asus-laptop.c
b/drivers/platform/x86/asus-laptop.c
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -1195,7 +1195,7 @@ static ssize_t ls_level_store(struct dev
        if (rv < 0)
                return rv;

-       value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
+       value = (0 < value) ? (min(15, value)) : 0;
        /* 0 <= value <= 15 */
        asus_als_level(asus, value);


diff -u -p a/sound/pci/ctxfi/ctatc.c b/sound/pci/ctxfi/ctatc.c
--- a/sound/pci/ctxfi/ctatc.c
+++ b/sound/pci/ctxfi/ctatc.c
@@ -382,7 +382,7 @@ static int atc_pcm_playback_start(struct
	apcm->started = 1;

        max_cisz = src->multi * src->rsc.msr;
-       max_cisz = 0x80 * (max_cisz < 8 ? max_cisz : 8);
+       max_cisz = 0x80 * (min(max_cisz, 8));


> +func(...)
> +{
> +	... when any
> +*	(x cmp y) ?@p x : y
> +	... when any
> +}

In all cases, this would be more efficient as:

func(...)
{
 <...
* (x cmp y) ?@p x : y
 ...>
}

There is an optimization that causes this to be just a search through the
nodes of the control-flow graph, rather than following the actual control
flow from the beginning of the function to the end.

> +@script:python depends on report@
> +p << rmax.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for max()")
> +
> +@script:python depends on org@
> +p << rmax.p;
> +@@
> +
> +coccilib.report.print_todo(p[0], "WARNING opportunity for max()")

All of the org cases should be coccilib.org, not coccilib.report.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
