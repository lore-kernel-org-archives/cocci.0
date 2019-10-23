Return-Path: <SRS0=uT6i=YQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2654CA9EB6
	for <cocci@archiver.kernel.org>; Wed, 23 Oct 2019 08:59:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A47205C9
	for <cocci@archiver.kernel.org>; Wed, 23 Oct 2019 08:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A47205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9N8wxUP001467;
	Wed, 23 Oct 2019 10:58:59 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DB46677BB;
	Wed, 23 Oct 2019 10:58:58 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C424C77B4
 for <cocci@systeme.lip6.fr>; Wed, 23 Oct 2019 10:58:56 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9N8wrlh009496
 for <cocci@systeme.lip6.fr>; Wed, 23 Oct 2019 10:58:53 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.68,220,1569276000"; d="scan'208";a="323927878"
Received: from unknown (HELO hadrien) ([154.43.32.124])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Oct 2019 10:55:40 +0200
Date: Wed, 23 Oct 2019 10:55:39 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To: zhongshiqi <zhong.shiqi@zte.com.cn>
In-Reply-To: <1571819563-18118-1-git-send-email-zhong.shiqi@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1910231054250.2335@hadrien>
References: <1571819563-18118-1-git-send-email-zhong.shiqi@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 23 Oct 2019 10:58:59 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Wed, 23 Oct 2019 10:58:53 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: wang.yi59@zte.com.cn, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        cheng.shengyu@zte.com.cn, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] Configuring COCCI parameter as a directory is
 supportted
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



On Wed, 23 Oct 2019, zhongshiqi wrote:

> This patch puts a modification in scripts/coccicheck which supports users
> in configuring COCCI parameter as a directory to traverse files in
> directory.
>
> Signed-off-by: zhongshiqi <zhong.shiqi@zte.com.cn>
> ---
>  scripts/coccicheck | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index e04d328..a1c4197 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -257,6 +257,10 @@ if [ "$COCCI" = "" ] ; then
>      for f in `find $srctree/scripts/coccinelle/ -name '*.cocci' -type f | sort`; do
>  	coccinelle $f
>      done
> +elif [ -d "$COCCI" ] ; then
> +    for f in `find $COCCI/ -name '*.cocci' -type f | sort`; do
> +	coccinelle $f
> +    done
>  else
>      coccinelle $COCCI
>  fi

Thanks for the contribution.  I'm not that knowledgeable about these
scripts.  What is the relation between the last two if branches?  If the
first one fails, does that mean that $COCCI has no definition?  In that
case, is the final else useful?

thanks,
julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
