Return-Path: <SRS0=onlg=DE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7F8C4346E
	for <cocci@archiver.kernel.org>; Sun, 27 Sep 2020 20:56:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 571CF21775
	for <cocci@archiver.kernel.org>; Sun, 27 Sep 2020 20:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571CF21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08RKtuqC025061;
	Sun, 27 Sep 2020 22:55:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2E1E05F8F;
	Sun, 27 Sep 2020 22:55:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AAE434316
 for <cocci@systeme.lip6.fr>; Sun, 27 Sep 2020 22:55:54 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08RKtru3016698
 for <cocci@systeme.lip6.fr>; Sun, 27 Sep 2020 22:55:53 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.77,311,1596492000"; d="scan'208";a="469746023"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Sep 2020 22:55:53 +0200
Date: Sun, 27 Sep 2020 22:55:52 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Sumera Priyadarsini <sylphrenadin@gmail.com>
In-Reply-To: <3beb97122995eafe3f0b831e36167b1edadb47c5.1600945451.git.sylphrenadin@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2009272255220.20726@hadrien>
References: <cover.1600945451.git.sylphrenadin@gmail.com>
 <3beb97122995eafe3f0b831e36167b1edadb47c5.1600945451.git.sylphrenadin@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 27 Sep 2020 22:55:56 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 27 Sep 2020 22:55:53 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: corbet@lwn.net, michal.lkml@markovi.net, Gilles.Muller@lip6.fr,
        linux-doc@vger.kernel.org, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 1/2] scripts: coccicheck: Change default value
 for	parallelism
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



On Thu, 24 Sep 2020, Sumera Priyadarsini wrote:

> By default, coccicheck utilizes all available threads to implement
> parallelisation. However, when all available threads are used,
> a decrease in performance is noted. The elapsed time is  minimum
> when at most one thread per core is used.
>
> For example, on benchmarking the semantic patch kfree.cocci for
> usb/serial using hyperfine, the outputs obtained for J=5 and J=2
> are 1.32 and 1.90 times faster than those for J=10 and J=9
> respectively for two separate runs. For the larger drivers/staging
> directory, minimium elapsed time is obtained for J=3 which is 1.86
> times faster than that for J=12. The optimal J value does not
> exceed 6 in any of the test runs. The benchmarks are run on a machine
> with 6 cores, with 2 threads per core, i.e, 12 hyperthreads in all.
>
> To improve performance, modify coccicheck to use at most only
> one thread per core by default.
>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

I have applied this one, so just the patch on the docuemtnation needs to
be improved.

julia

>
> ---
> Changes in V2:
> 	- Change commit message as suggested by Julia Lawall
> Changes in V3:
> 	- Use J/2 as optimal value for machines with more
> than 8 hyperthreads as well.
> ---
>  scripts/coccicheck | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index e04d328210ac..a72aa6c037ff 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -75,8 +75,13 @@ else
>          OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
>      fi
>
> +    # Use only one thread per core by default if hyperthreading is enabled
> +    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd [:digit:])
>      if [ -z "$J" ]; then
>          NPROC=$(getconf _NPROCESSORS_ONLN)
> +	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 2 ] ; then
> +		NPROC=$((NPROC/2))
> +	fi
>      else
>          NPROC="$J"
>      fi
> --
> 2.25.1
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
