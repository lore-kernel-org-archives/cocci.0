Return-Path: <SRS0=ygl1=BW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A0FC433E0
	for <cocci@archiver.kernel.org>; Wed, 12 Aug 2020 20:15:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A016206DA
	for <cocci@archiver.kernel.org>; Wed, 12 Aug 2020 20:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A016206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07CKFaeC007799;
	Wed, 12 Aug 2020 22:15:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A368D7780;
	Wed, 12 Aug 2020 22:15:36 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1926A5F8F
 for <cocci@systeme.lip6.fr>; Wed, 12 Aug 2020 22:15:35 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07CKFVUV005613
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 12 Aug 2020 22:15:32 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.76,305,1592863200"; d="scan'208";a="463289246"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 22:15:05 +0200
Date: Wed, 12 Aug 2020 22:15:04 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Sumera Priyadarsini <sylphrenadin@gmail.com>
In-Reply-To: <20200812182722.4553-1-sylphrenadin@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2008122211330.2468@hadrien>
References: <20200812182722.4553-1-sylphrenadin@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 12 Aug 2020 22:15:37 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 12 Aug 2020 22:15:32 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: michal.lkml@markovi.net, Gilles.Muller@lip6.fr, gregkh@linuxfoundation.org,
        nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] scripts: coccicheck: Change default value for
 parallelism
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



On Wed, 12 Aug 2020, Sumera Priyadarsini wrote:

> By default, coccicheck utilizes all available threads to implement
> parallelisation. However, when hyperthreading is enabled, this leads
> to all threads per core being occupied resulting in longer wall-clock
> times and higher power consumption.

I have the feeling that the above sentence is not quite optimal.
Actually, using all of the available hardware threads would not be a bad
thing, if it was giving a benefit.  The point is that it doesn't.  It
makes the performance worse instead.

> Hence, to improve performance,
> modify coccicheck to use only one thread per core atmost.

"atmost" is not a word.  It would be clearer to say "to use at most one
thread per core".

> In the cases where the total number of threads is more than 8 and
> hyperthreading is enabled, it was observed that optimum performance
> is achieved around one-fourth of the total number of cores.
> Modify the script further to accommodate this use case.

It would be nice to give some performance numbers and some information
about the machine used.

thanks,
julia

>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> ---
>  scripts/coccicheck | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index e04d328210ac..dd228dcc915e 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -75,8 +75,17 @@ else
>          OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
>      fi
>
> +    # Use only one thread per core by default if hyperthreading is enabled
> +    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd [:digit:])
>      if [ -z "$J" ]; then
>          NPROC=$(getconf _NPROCESSORS_ONLN)
> +	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 2 ] ; then
> +		if [ $NPROC -gt 8 ] ; then
> +			NPROC=$((NPROC/4))
> +		else
> +			NPROC=$((NPROC/2))
> +		fi
> +	fi
>      else
>          NPROC="$J"
>      fi
> --
> 2.17.1
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
