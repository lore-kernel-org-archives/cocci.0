Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B309E95A65
	for <cocci@archiver.kernel.org>; Sat,  7 Oct 2023 19:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=hsRMnVxEdXNQbDv8iJbkta6BVDoT/UbI/OfTI7OLzNA=;
  b=dD+rNyLHXbBMDVfobZfn6cl5A8oQk2/FoNl9VD6mBZbaUCa8dl2SRX/e
   udJ26gdGpZorXYN120+wSQyFezewOQwINcYFNMSrkhm1fo0vHWwgiKEbG
   CKYQLuhHVgnjLEgDWhNHL2vswiNQpUuVeHPB6PyBUo+UhrkivOdbOtBBR
   U=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.03,206,1694728800"; 
   d="scan'208";a="130025003"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Oct 2023 21:41:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 13BE1E0205; Sat,  7 Oct 2023 21:41:20 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D2926E00B7
	for <cocci@sympa.inria.fr>; Sat,  7 Oct 2023 21:41:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hsRMnVxEdXNQbDv8iJbkta6BVDoT/UbI/OfTI7OLzNA=;
  b=W9Aiik7bGTqpsEh2M3jhWuB0L8H+QhWpejGYv782et3LDt2en/zlR2PK
   bEaYsetnvgX+h9qouglrS1BjvbTAkxnIWUnDqJOq4FbRmFbas7FVpIjzc
   5Okky/cTMhpqRYn4NW5VuRHTTMyU0SvAxUbcf/sc+i+WAA3HdH/t0paA0
   4=;
X-IronPort-AV: E=Sophos;i="6.03,206,1694728800"; 
   d="scan'208";a="130024966"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 21:41:15 +0200
Date: Sat, 7 Oct 2023 21:41:15 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Anton Eliasson <anton.eliasson@axis.com>
cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org, kernel@axis.com
In-Reply-To: <20231003-coccicheck-v1-2-07d2d900a52a@axis.com>
Message-ID: <alpine.DEB.2.22.394.2310072140340.36842@hadrien>
References: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com> <20231003-coccicheck-v1-2-07d2d900a52a@axis.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH 2/2] scripts: coccicheck: Separate spatch stdout
 and stderr
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1251
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/alpine.DEB.2.22.394.2310072140340.36842%40hadrien>



On Tue, 3 Oct 2023, Anton Eliasson wrote:

> This helps automating coccicheck runs by discarding stderr and only
> looking at the output of stdout. In report mode the only remaining
> output on stdout is the initial "Please check for false positives"
> message followed by each spatch warning found.

What is getting dropped is the spatch command lines indicating the
semantic patch.  Is this desirable?

julia

>
> Signed-off-by: Anton Eliasson <anton.eliasson@axis.com>
> ---
>  scripts/coccicheck | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 95a312730e98..7e7c44125f47 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -146,8 +146,8 @@ run_cmd_parmap() {
>                  echo $@>>$DEBUG_FILE
>                  $@ 2>>$DEBUG_FILE
>          else
> -                echo $@
> -                $@ 2>&1
> +                echo $@ >&2
> +                $@
>  	fi
>
>  	err=$?
>
> --
> 2.30.2
>
>
