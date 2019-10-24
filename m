Return-Path: <SRS0=bkjO=YR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA94BCA9EAF
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2019 06:20:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0854921655
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2019 06:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0854921655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9O6K2ag015094;
	Thu, 24 Oct 2019 08:20:02 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3F48377BB;
	Thu, 24 Oct 2019 08:20:02 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3372277B9
 for <cocci@systeme.lip6.fr>; Thu, 24 Oct 2019 08:20:00 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9O6Jwhg023140
 for <cocci@systeme.lip6.fr>; Thu, 24 Oct 2019 08:19:58 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.68,223,1569276000"; d="scan'208";a="407883262"
Received: from ip-121.net-89-2-166.rev.numericable.fr (HELO hadrien)
 ([89.2.166.121])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Oct 2019 08:19:58 +0200
Date: Thu, 24 Oct 2019 08:19:57 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: zhongshiqi <zhong.shiqi@zte.com.cn>
In-Reply-To: <1571897060-32374-1-git-send-email-zhong.shiqi@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1910240816040.2771@hadrien>
References: <1571897060-32374-1-git-send-email-zhong.shiqi@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2055800385-1571897998=:2771"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 24 Oct 2019 08:20:04 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Thu, 24 Oct 2019 08:19:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: wang.yi59@zte.com.cn, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        cheng.shengyu@zte.com.cn, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v2] coccicheck:support $COCCI being defined as a
 directory
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2055800385-1571897998=:2771
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 24 Oct 2019, zhongshiqi wrote:

> Put a modification in scripts/coccicheck which supports users in
> configuring COCCI parameter as a directory to traverse files in
> directory whose next level directory contains rule files with Suffix of
> cocci.

While I thought the original was fine, if we are going to strive for
perfection, there are some things that could be changed.  First there
should be a space in the subject line after the :

Second the commit log could be more concise as:

Allow defining COCCI as a directory that contains .cocci files.

In general, at least in simple cases, it is not necessary to mention the
name of the file you are modifying in the comit log, because one can see
that just below from looking at the diffstat and the patch.

thanks,
julia

>
> Signed-off-by: zhongshiqi <zhong.shiqi@zte.com.cn>
> ---
> Changes in v2:
>         1.fix patch subject according to the reply by Markus
>         <Markus.Elfring@web.de>
>         2.change description in “imperative mood”
>
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
> --
> 2.9.5
>
>
--8323329-2055800385-1571897998=:2771
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-2055800385-1571897998=:2771--
