Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99520C7EE23
	for <cocci@archiver.kernel.org>; Sat, 25 Feb 2023 19:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=f6R3HmduZHcf6R+sXIBtcJrtmGgHEVbOUtaiMM/BHsM=;
  b=VeEUScYnI3w/25PvBhRLdhakpudIlkSXz6YQXezLC6L1oUTY9r4nZtRl
   qEZvKf2WCqT+BgfrpcZ4wbsPLqtxIFpdQL/yaD5OpFkLh5hv5tp6j/2/e
   907fZNV/JxPWCgl7+HzwDi5d2ykn0aMYNqoTFBcTCoQphJmp/m8Uc5HlH
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.97,328,1669071600"; 
   d="scan'208";a="94345904"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2023 20:28:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9F4E7E0150; Sat, 25 Feb 2023 20:28:03 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 03870E00A1
	for <cocci@sympa.inria.fr>; Sat, 25 Feb 2023 20:27:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=f6R3HmduZHcf6R+sXIBtcJrtmGgHEVbOUtaiMM/BHsM=;
  b=VJTeoZLwU/jq1q1IuLexQNhSIjGfs5a+TNA7ObPcbwmaQYFIOfkZOybX
   8wknmymiYZOZ/ni9o8WJ/GwVjuUcROBq5MsbQ24JRx2NNRcO/mThq/s/A
   UebUvpSBsAbkw4zK/8xdEIHMRaG/ynQTg2xoXjExOzXGNkBPvcSX6F+w/
   k=;
X-IronPort-AV: E=Sophos;i="5.97,328,1669071600"; 
   d="scan'208";a="94345893"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2023 20:27:57 +0100
Date: Sat, 25 Feb 2023 20:27:56 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Peter Foley <pefoley2@pefoley.com>
cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
In-Reply-To: <20230113-cocci-v1-1-0f4ae50494d3@pefoley.com>
Message-ID: <alpine.DEB.2.22.394.2302252027390.3036@hadrien>
References: <20230113-cocci-v1-1-0f4ae50494d3@pefoley.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH] scripts: coccicheck: Avoid warning about
 spurious escape
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 864
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-02/alpine.DEB.2.22.394.2302252027390.3036%40hadrien>



On Fri, 13 Jan 2023, Peter Foley wrote:

> e.g.
> grep: warning: stray \ before -
>
> Signed-off-by: Peter Foley <pefoley2@pefoley.com>

Applied, thanks.

julia

> ---
>  scripts/coccicheck | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 2956fce8fa4f..fb492f032c5f 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -18,7 +18,7 @@ fi
>  SPATCH_VERSION=$($SPATCH --version | head -1 | awk '{print $3}')
>
>  USE_JOBS="no"
> -$SPATCH --help | grep "\-\-jobs" > /dev/null && USE_JOBS="yes"
> +$SPATCH --help | grep -e "--jobs" > /dev/null && USE_JOBS="yes"
>
>  # The verbosity may be set by the environmental parameter V=
>  # as for example with 'make V=1 coccicheck'
>
> ---
> base-commit: d9fc1511728c15df49ff18e49a494d00f78b7cd4
> change-id: 20230113-cocci-12936b2c06c3
>
> Best regards,
> --
> Peter Foley <pefoley2@pefoley.com>
>
