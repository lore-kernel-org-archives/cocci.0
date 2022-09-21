Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CA2ECAAD8
	for <cocci@archiver.kernel.org>; Wed, 21 Sep 2022 19:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=66rcljKTkOZrwZgqNEXo+xZF7AoDxDT9ScP9aV+15Gc=;
  b=thl9Hk8wm8F/u5vPaa48g7i3LGA0vn4yJcYMbGAo5jWWH1f21vgmYaNd
   JZfZDYHNCYaTSh+hUnr+R4ulgp2AxFActc2bN5c7BnecPovLcvzS5aTaK
   rIl/5BON7RLIv8M9DtqwJf+eyaKZ9+R0trKt+FQLLgDMiRyfIRMweEgq9
   c=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.93,334,1654552800"; 
   d="scan'208";a="53913216"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Sep 2022 21:26:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3B7A2E0120; Wed, 21 Sep 2022 21:26:17 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AF0F8E008B
	for <cocci@sympa.inria.fr>; Wed, 21 Sep 2022 21:26:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=66rcljKTkOZrwZgqNEXo+xZF7AoDxDT9ScP9aV+15Gc=;
  b=rVC//fao0B9QMsmbV5dysTAr4nSlIY7m9ISq3FAz53+FQ9oxEMyp3Bk8
   NRkCoHPbjvA3n9vo6pM9oMPUTDPZ/HaE+DkFlbIzz8CmOQPLP9b8cP4o8
   MZPDwjSxm6NAhj6BmH/2EEVHw851vN4QJNN5u/R6vKSslehwh59e/M3f2
   s=;
X-IronPort-AV: E=Sophos;i="5.93,334,1654552800"; 
   d="scan'208";a="24337809"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 21:26:11 +0200
Date: Wed, 21 Sep 2022 21:26:10 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: cocci@inria.fr, linux-kernel@vger.kernel.org, 
    Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <20220921091341.217365-1-gregkh@linuxfoundation.org>
Message-ID: <alpine.DEB.2.22.394.2209212125590.2783@hadrien>
References: <20220921091341.217365-1-gregkh@linuxfoundation.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH] scripts: coccicheck: use "grep -E" instead of
 "egrep"
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 565
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/alpine.DEB.2.22.394.2209212125590.2783%40hadrien>



On Wed, 21 Sep 2022, Greg Kroah-Hartman wrote:

> The latest version of grep claims that egrep is now obsolete so the build
> now contains warnings that look like:
>         egrep: warning: egrep is obsolescent; using grep -E
> fix this up by moving the vdso Makefile to use "grep -E" instead.
>
> Cc: Julia Lawall <Julia.Lawall@inria.fr>
> Cc: Nicolas Palix <nicolas.palix@imag.fr>
> Cc: cocci@inria.fr
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied, thanks.

> ---
>  scripts/coccicheck | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index caba0bff6da7..2956fce8fa4f 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -47,7 +47,7 @@ FLAGS="--very-quiet"
>  # inspected there.
>  #
>  # --profile will not output if --very-quiet is used, so avoid it.
> -echo $SPFLAGS | egrep -e "--profile|--show-trying" 2>&1 > /dev/null
> +echo $SPFLAGS | grep -E -e "--profile|--show-trying" 2>&1 > /dev/null
>  if [ $? -eq 0 ]; then
>  	FLAGS="--quiet"
>  fi
> --
> 2.37.3
>
>
