Return-Path: <SRS0=jj0h=6C=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A92C38A2F
	for <cocci@archiver.kernel.org>; Sat, 18 Apr 2020 13:38:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 949DD20753
	for <cocci@archiver.kernel.org>; Sat, 18 Apr 2020 13:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949DD20753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03IDbuZS014828;
	Sat, 18 Apr 2020 15:37:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1EA22781A;
	Sat, 18 Apr 2020 15:37:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 937F93DC8
 for <cocci@systeme.lip6.fr>; Sat, 18 Apr 2020 15:37:53 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03IDbpT6018084
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 18 Apr 2020 15:37:51 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.72,399,1580770800"; d="scan'208";a="445728780"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Apr 2020 15:37:48 +0200
Date: Sat, 18 Apr 2020 15:37:48 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Tiezhu Yang <yangtiezhu@loongson.cn>
In-Reply-To: <1587200408-32602-1-git-send-email-yangtiezhu@loongson.cn>
Message-ID: <alpine.DEB.2.21.2004181537130.9868@hadrien>
References: <1587200408-32602-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 18 Apr 2020 15:37:56 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 18 Apr 2020 15:37:51 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Julia Lawall <Julia.Lawall@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] scripts: coccicheck: Fix invalid download link
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



On Sat, 18 Apr 2020, Tiezhu Yang wrote:

> When I use coccicheck, it fails with the message "spatch is part of the
> Coccinelle project and is available at http://coccinelle.lip6.fr/", but
> I can not download the source code of spatch due to the URL [1] was not
> found on this server.
>
> Use the download link of GitHub mirror directly to fix it.
>
> [1] http://coccinelle.lip6.fr/distrib/coccinelle-1.0.8.tar.gz

NACK.  I will try to fix the link instead.

Thanks for reporting in any case.

julia

>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  scripts/coccicheck | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index e04d328..14608a8 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -11,7 +11,7 @@ DIR="$(dirname $(readlink -f $0))/.."
>  SPATCH="`which ${SPATCH:=spatch}`"
>
>  if [ ! -x "$SPATCH" ]; then
> -    echo 'spatch is part of the Coccinelle project and is available at http://coccinelle.lip6.fr/'
> +    echo 'spatch is part of the Coccinelle project and is available at https://github.com/coccinelle/coccinelle/releases'
>      exit 1
>  fi
>
> --
> 2.1.0
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
