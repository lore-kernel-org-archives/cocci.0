Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9678DCCD195
	for <cocci@archiver.kernel.org>; Fri, 17 Oct 2025 10:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=wj+WCRcYc5nfyqI/50vIC5NGiZlcs4drP/9wRD28+Yw=;
  b=OqEpAMuCPgWgw5bqeHQ0ie/OrMGIveLa7CtuP17vYwnSlsWtBNcR2t9u
   HUqH/JwCaW/hhgKi1WALj1pFt1c7dY1jSAHyZFmFP77Uqti6rLRxb5KVr
   6fqm+cWk+ybVE/6WTnodZyTpIt7VhvCr4gazqVb1nX35FXHifSFUUsoeB
   w=;
X-CSE-ConnectionGUID: MKevsjf9SBucOFm/4qrhRQ==
X-CSE-MsgGUID: qkxvIxSCQni6yfCynhPtaw==
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.19,236,1754949600"; 
   d="scan'208";a="244796296"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Oct 2025 12:32:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CA95AE0C55; Fri, 17 Oct 2025 12:32:47 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 831EBE0171
	for <cocci@sympa.inria.fr>; Fri, 17 Oct 2025 12:32:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wj+WCRcYc5nfyqI/50vIC5NGiZlcs4drP/9wRD28+Yw=;
  b=ADsVBid6B80mQ9HaRrHY35ByFAMAF2ifC821wGU9nkR0o6WhQeN6BeZU
   sbrCno0MZlyz9sHTwOB2HMEPioyNQsqF6hzgYnnAAiz2NP3fOe9c01EFt
   CmQ5u+IZQcSLIn9DEp55lTB6ShuzWggC9eI8CACTGf9//B3CG638jAQ3a
   A=;
X-CSE-ConnectionGUID: feMLIk4kTgiffT72J1gSHw==
X-CSE-MsgGUID: O3Me8zbdRKeVb0rGoo63Ww==
X-IronPort-AV: E=Sophos;i="6.19,236,1754949600"; 
   d="scan'208";a="128488925"
Received: from bb116-15-226-202.singnet.com.sg (HELO hadrien) ([116.15.226.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 12:32:42 +0200
Date: Fri, 17 Oct 2025 18:32:35 +0800 (+08)
From: Julia Lawall <julia.lawall@inria.fr>
To: Thorsten Blum <thorsten.blum@linux.dev>
cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
In-Reply-To: <20251017103032.75686-2-thorsten.blum@linux.dev>
Message-ID: <ec9e6ef-d047-d084-1e29-514246869336@inria.fr>
References: <20251017103032.75686-2-thorsten.blum@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH RESEND] Coccinelle: pm_runtime: Fix typo in
 report message
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3074
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/ec9e6ef-d047-d084-1e29-514246869336%40inria.fr>



On Fri, 17 Oct 2025, Thorsten Blum wrote:

> s/Unecessary/Unnecessary/
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Julia Lawall <julia.lawall@inria.fr>

> ---
>  scripts/coccinelle/api/pm_runtime.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/api/pm_runtime.cocci b/scripts/coccinelle/api/pm_runtime.cocci
> index 2c931e748dda..e29ac3a87d96 100644
> --- a/scripts/coccinelle/api/pm_runtime.cocci
> +++ b/scripts/coccinelle/api/pm_runtime.cocci
> @@ -110,5 +110,5 @@ p2 << r.p2;
>  pm_runtime_api << r.pm_runtime_api;
>  @@
>
> -msg = "%s returns < 0 as error. Unecessary IS_ERR_VALUE at line %s" % (pm_runtime_api, p2[0].line)
> +msg = "%s returns < 0 as error. Unnecessary IS_ERR_VALUE at line %s" % (pm_runtime_api, p2[0].line)
>  coccilib.report.print_report(p1[0],msg)
> --
> 2.51.0
>
>
