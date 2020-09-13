Return-Path: <SRS0=hLsS=CW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CA7C433E2
	for <cocci@archiver.kernel.org>; Sun, 13 Sep 2020 20:12:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75558221E3
	for <cocci@archiver.kernel.org>; Sun, 13 Sep 2020 20:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75558221E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08DKC5M2024708;
	Sun, 13 Sep 2020 22:12:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 27512778A;
	Sun, 13 Sep 2020 22:12:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6B6004316
 for <cocci@systeme.lip6.fr>; Sun, 13 Sep 2020 22:12:03 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08DKC2Ki020071
 for <cocci@systeme.lip6.fr>; Sun, 13 Sep 2020 22:12:02 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; d="scan'208";a="467425457"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Sep 2020 22:12:02 +0200
Date: Sun, 13 Sep 2020 22:12:02 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Sumera Priyadarsini <sylphrenadin@gmail.com>
In-Reply-To: <20200913120548.bwl3elfl7ss66eyh@adolin>
Message-ID: <alpine.DEB.2.22.394.2009132211430.2368@hadrien>
References: <20200913120548.bwl3elfl7ss66eyh@adolin>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 13 Sep 2020 22:12:05 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 13 Sep 2020 22:12:02 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Gilles.Muller@lip6.fr, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [RFC PATCH] scripts: coccicheck: Improve error feedback
 when coccicheck fails
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



On Sun, 13 Sep 2020, Sumera Priyadarsini wrote:

> Currently, coccicheck fails with only the message "coccicheck failed"
> and the error code for the failure. To obtain the error logs,
> one needs to specify a debug file using the DEBUG_FILE option.
>
> Modify coccicheck to display error logs when it crashes unless
> DEBUG_FILE is set, in which case, the error logs are stored in
> the specified debug file.

Applied, thanks.

julia

>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> ---
>  scripts/coccicheck | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index e04d328210ac..dbeafa21f359 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -126,8 +126,14 @@ run_cmd_parmap() {
>  	if [ $VERBOSE -ne 0 ] ; then
>  		echo "Running ($NPROC in parallel): $@"
>  	fi
> -	echo $@ >>$DEBUG_FILE
> -	$@ 2>>$DEBUG_FILE
> +	if [ "$DEBUG_FILE" != "/dev/null" -a "$DEBUG_FILE" != "" ]; then
> +                echo $@>>$DEBUG_FILE
> +                $@ 2>>$DEBUG_FILE
> +        else
> +                echo $@
> +                $@ 2>&1
> +	fi
> +
>  	err=$?
>  	if [[ $err -ne 0 ]]; then
>  		echo "coccicheck failed"
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
