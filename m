Return-Path: <SRS0=k3NR=DT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CB7C433DF
	for <cocci@archiver.kernel.org>; Mon, 12 Oct 2020 08:38:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 614D92074F
	for <cocci@archiver.kernel.org>; Mon, 12 Oct 2020 08:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614D92074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09C8cVsP022845;
	Mon, 12 Oct 2020 10:38:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0F4FD74CE;
	Mon, 12 Oct 2020 10:38:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5857C4500
 for <cocci@systeme.lip6.fr>; Mon, 12 Oct 2020 10:38:30 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09C8cTnv013515
 for <cocci@systeme.lip6.fr>; Mon, 12 Oct 2020 10:38:29 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.77,366,1596492000"; d="scan'208";a="472083358"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Oct 2020 10:38:29 +0200
Date: Mon, 12 Oct 2020 10:38:29 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Sumera Priyadarsini <sylphrenadin@gmail.com>
In-Reply-To: <76ca49efc2ec4b8279e70c4bc4052fb7b543bc86.1602410019.git.sylphrenadin@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2010121038200.2901@hadrien>
References: <cover.1602410019.git.sylphrenadin@gmail.com>
 <76ca49efc2ec4b8279e70c4bc4052fb7b543bc86.1602410019.git.sylphrenadin@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 12 Oct 2020 10:38:31 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 12 Oct 2020 10:38:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: michal.lkml@markovi.net, linux-doc@vger.kernel.org, Gilles.Muller@lip6.fr,
        corbet@lwn.net, nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        Julia.Lawall@lip6.fr, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v4 1/3] scripts: coccicheck: Add quotes to
 improve portability
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



On Sun, 11 Oct 2020, Sumera Priyadarsini wrote:

> While fetching the number of threads per core with lscpu,
> the [:digit:] set is used for translation of digits from 0-9.
> However, using [:digit:] instead of "[:digit:]" does not seem
> to work uniformly for some shell types and configurations
> (such as zsh).
>
> Therefore, modify coccicheck to use double quotes around the
> [:digit:] set for uniformity and better portability.
>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

Applied, thanks.

> ---
>  scripts/coccicheck | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 6789751607f5..d67907b8a38b 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -76,7 +76,7 @@ else
>      fi
>
>      # Use only one thread per core by default if hyperthreading is enabled
> -    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd [:digit:])
> +    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd "[:digit:]")
>      if [ -z "$J" ]; then
>          NPROC=$(getconf _NPROCESSORS_ONLN)
>  	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 2 ] ; then
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
