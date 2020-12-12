Return-Path: <SRS0=dAGB=FQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460B0C433FE
	for <cocci@archiver.kernel.org>; Sat, 12 Dec 2020 17:30:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8268222AAC
	for <cocci@archiver.kernel.org>; Sat, 12 Dec 2020 17:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8268222AAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0BCHU9Gh012063;
	Sat, 12 Dec 2020 18:30:09 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 796CB4743;
	Sat, 12 Dec 2020 18:30:09 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BE1A27B6
 for <cocci@systeme.lip6.fr>; Sat, 12 Dec 2020 18:30:07 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0BCHU6h8021663
 for <cocci@systeme.lip6.fr>; Sat, 12 Dec 2020 18:30:06 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.78,414,1599516000"; d="scan'208";a="482633059"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Dec 2020 18:30:06 +0100
Date: Sat, 12 Dec 2020 18:30:06 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Masahiro Yamada <masahiroy@kernel.org>
In-Reply-To: <20201212165431.150750-1-masahiroy@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2012121829560.3058@hadrien>
References: <20201212165431.150750-1-masahiroy@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 12 Dec 2020 18:30:09 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 12 Dec 2020 18:30:06 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-kbuild@vger.kernel.org, Matthias Maennich <maennich@google.com>,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 1/3] kbuild: do not use scripts/ld-version.sh
 for	checking spatch version
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



On Sun, 13 Dec 2020, Masahiro Yamada wrote:

> scripts/ld-version.sh was, as its file name implies, originally intended
> for the GNU ld version, but is (ab)used for the spatch version too.
>
> Use 'sort -CV' for the version comparison, then coccicheck does not need
> to use scripts/ld-version.sh. Fix nsdeps as well.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Applied, thanks.

julia

> ---
>
>  scripts/coccicheck | 14 +++++---------
>  scripts/nsdeps     |  4 +---
>  2 files changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 209bb0427b43..d7f6b7ff130a 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -16,7 +16,6 @@ if [ ! -x "$SPATCH" ]; then
>  fi
>
>  SPATCH_VERSION=$($SPATCH --version | head -1 | awk '{print $3}')
> -SPATCH_VERSION_NUM=$(echo $SPATCH_VERSION | ${DIR}/scripts/ld-version.sh)
>
>  USE_JOBS="no"
>  $SPATCH --help | grep "\-\-jobs" > /dev/null && USE_JOBS="yes"
> @@ -186,14 +185,11 @@ coccinelle () {
>
>      OPT=`grep "Options:" $COCCI | cut -d':' -f2`
>      REQ=`grep "Requires:" $COCCI | cut -d':' -f2 | sed "s| ||"`
> -    REQ_NUM=$(echo $REQ | ${DIR}/scripts/ld-version.sh)
> -    if [ "$REQ_NUM" != "0" ] ; then
> -	    if [ "$SPATCH_VERSION_NUM" -lt "$REQ_NUM" ] ; then
> -		    echo "Skipping coccinelle SmPL patch: $COCCI"
> -		    echo "You have coccinelle:           $SPATCH_VERSION"
> -		    echo "This SmPL patch requires:      $REQ"
> -		    return
> -	    fi
> +    if [ -n "$REQ" ] && ! { echo "$REQ"; echo "$SPATCH_VERSION"; } | sort -CV ; then
> +	    echo "Skipping coccinelle SmPL patch: $COCCI"
> +	    echo "You have coccinelle:           $SPATCH_VERSION"
> +	    echo "This SmPL patch requires:      $REQ"
> +	    return
>      fi
>
>  #   The option '--parse-cocci' can be used to syntactically check the SmPL files.
> diff --git a/scripts/nsdeps b/scripts/nsdeps
> index dab4c1a0e27d..e8ce2a4d704a 100644
> --- a/scripts/nsdeps
> +++ b/scripts/nsdeps
> @@ -12,11 +12,9 @@ if [ ! -x "$SPATCH" ]; then
>  	exit 1
>  fi
>
> -SPATCH_REQ_VERSION_NUM=$(echo $SPATCH_REQ_VERSION | ${DIR}/scripts/ld-version.sh)
>  SPATCH_VERSION=$($SPATCH --version | head -1 | awk '{print $3}')
> -SPATCH_VERSION_NUM=$(echo $SPATCH_VERSION | ${DIR}/scripts/ld-version.sh)
>
> -if [ "$SPATCH_VERSION_NUM" -lt "$SPATCH_REQ_VERSION_NUM" ] ; then
> +if ! { echo "$SPATCH_REQ_VERSION"; echo "$SPATCH_VERSION"; } | sort -CV ; then
>  	echo "spatch needs to be version $SPATCH_REQ_VERSION or higher"
>  	exit 1
>  fi
> --
> 2.27.0
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
