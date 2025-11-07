Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AF3CCF9F8
	for <cocci@archiver.kernel.org>; Fri,  7 Nov 2025 08:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=h62J5s12u1Z3LDBp06HlNWyDoCyt78LQdWdmaRcR/Bs=;
  b=B8CvYTB0VjkRNKPQahYck+t0eI5ne3TeOev1ssNsY/tmGMyMxgxiv8jx
   3/jSjnxKTebsJd75HV3CW1SZpkOFoRqTmmHAjleA6Yq6l+JB9dJ1rwLEr
   GOM9sBAmF450JfMzAV3Kyckka0rXsh62St//9HhLmkqe+q6ylvmfK50ur
   0=;
X-CSE-ConnectionGUID: fE05O8eIQxmXquHBiuIxZQ==
X-CSE-MsgGUID: hv2OLaWUT0+cnnyZTgwJNQ==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.19,286,1754949600"; 
   d="scan'208";a="248092624"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2025 09:05:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 03D54E0BE9; Fri,  7 Nov 2025 09:05:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 55FD5E0171
	for <cocci@sympa.inria.fr>; Fri,  7 Nov 2025 09:05:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=h62J5s12u1Z3LDBp06HlNWyDoCyt78LQdWdmaRcR/Bs=;
  b=PT+4v/lrrjmXw2vsFEn8w+x4d13E1RBqDc6hQRT0w3h59Q/m+FKLChU6
   gMG8xm9vEhbarzAhgSWkf8VjhZOGaobJAzPhJsiDi7nSK80s8GbvAINjO
   OdrV282s4pKU3SEWnLZ1B7Fg/LOvZ3+rkeauxoEojYEEiIjkiODJY14Hf
   Y=;
X-CSE-ConnectionGUID: 7EDbXYedSSenYFVhZ0PRJw==
X-CSE-MsgGUID: iNz7rgcIRZ6sKqcIqLMiJw==
X-IronPort-AV: E=Sophos;i="6.19,286,1754949600"; 
   d="scan'208";a="248092612"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 09:05:24 +0100
Date: Fri, 7 Nov 2025 09:05:24 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Songwei Chai <quic_songchai@quicinc.com>
cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com, 
    quic_jinlmao@quicinc.com
In-Reply-To: <20250606060936.2756980-1-quic_songchai@quicinc.com>
Message-ID: <f4376c72-b255-4cc-959a-8c947addb4ca@inria.fr>
References: <20250606060936.2756980-1-quic_songchai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v2] scripts: coccicheck: filter *.cocci files by
 MODE
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3139
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/f4376c72-b255-4cc-959a-8c947addb4ca%40inria.fr>



On Fri, 6 Jun 2025, Songwei Chai wrote:

> Enhance the coccicheck script to filter *.cocci files based on the
> specified MODE (e.g., report, patch). This ensures that only compatible
> semantic patch files are executed, preventing errors such as:
>
>     "virtual rule report not supported"
>
> This error occurs when a .cocci file does not define a 'virtual <MODE>'
> rule, yet is executed in that mode.
>
> For example:
>
>     make coccicheck M=drivers/hwtracing/coresight/ MODE=report
>
> In this case, running "secs_to_jiffies.cocci" would trigger the error
> because it lacks support for 'report' mode. With this change, such files
> are skipped automatically, improving robustness and developer
> experience.

Pushed to my tree (for-6.19 branch)

>
> Signed-off-by: Songwei Chai <quic_songchai@quicinc.com>
> ---
>  scripts/coccicheck | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 0e6bc5a10320..89d591af5f3e 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -270,7 +270,11 @@ fi
>
>  if [ "$COCCI" = "" ] ; then
>      for f in `find $srctree/scripts/coccinelle/ -name '*.cocci' -type f | sort`; do
> -	coccinelle $f
> +        if grep -q "virtual[[:space:]]\+$MODE" "$f"; then
> +                coccinelle $f
> +        else
> +                echo "warning: Skipping $f as it does not match mode '$MODE'"
> +        fi
>      done
>  else
>      coccinelle $COCCI
>
>
