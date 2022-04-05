Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D436EC433F5
	for <cocci@archiver.kernel.org>; Tue,  5 Apr 2022 06:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=hys+baV0s/BB2X6ZjEsxUpZuW1LBvcMEwkegMMpJQ3M=;
  b=Wn4wXIgcQJUprSyDOdmphvv/+4Df0GiYa8R2ooccF2Gxv1XPmJYIHyRt
   HqF3dSK6I1erMuwUApOe318ebSqlGzZ8swcc0xAbk530iMSDQPR280HKp
   7/rnU5L8cx6juryXP7ffE4h5O3WT1i3FM/JytqBzC4xn3XyNjOQxPDOzs
   4=;
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
X-IronPort-AV: E=Sophos;i="5.90,235,1643670000"; 
   d="scan'208";a="30042059"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Apr 2022 08:17:59 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A8CF2E002E; Tue,  5 Apr 2022 08:17:59 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 40790E002D
	for <cocci@sympa.inria.fr>; Tue,  5 Apr 2022 08:17:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hys+baV0s/BB2X6ZjEsxUpZuW1LBvcMEwkegMMpJQ3M=;
  b=cqrtI2hEUJKTeUbxl1WD+MaczjMypTi0waEARWdg0vsuXS1Rekv2scya
   l9S0ZqR7h3qnI7eq/FG+x/wbhX5TbXf53zE4sAXfUWbo3uVyArnkDAsro
   tbyvlQb21VAhQ6TZ8RNg8y9vh7zDd2bSs7IyWMJB9Vudt67JMRIk7ydTH
   w=;
X-IronPort-AV: E=Sophos;i="5.90,235,1643670000"; 
   d="scan'208";a="30042054"
Received: from lputeaux-656-1-153-249.w217-128.abo.wanadoo.fr (HELO hadrien) ([217.128.47.249])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 08:17:57 +0200
Date: Tue, 5 Apr 2022 08:17:56 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Nishanth Menon <nm@ti.com>
cc: Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org, 
    cocci@inria.fr, Kirill Smelkov <kirr@nexedi.com>
In-Reply-To: <20220404215926.14811-1-nm@ti.com>
Message-ID: <alpine.DEB.2.22.394.2204050816560.2185@hadrien>
References: <20220404215926.14811-1-nm@ti.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH] coccinelle: api/stream_open: Introduce
 metavariables for checks
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 353
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/alpine.DEB.2.22.394.2204050816560.2185%40hadrien>



On Mon, 4 Apr 2022, Nishanth Menon wrote:

> Coccinelle spatch version 1.1.1 reports the following:
> warning: line 134: should no_llseek be a metavariable?
> warning: line 141: should noop_llseek be a metavariable?
> warning: line 223: should nonseekable_open be a metavariable?
> warning: line 290: should nonseekable_open be a metavariable?
> warning: line 338: should nonseekable_open be a metavariable?
>
> So, introduce the metavariable similar to other check instances.

This changes the semantic from matching the specific thing to anything.
So are you sure that it is what is wanted?  If it should always be the
specific thing, then you can get rid of the warning using eg symbol
no_llseek.

julia

>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>
> NOTE: This is currently reported in next-20220404, though I have'nt
> bisected for exact fixes tags to be used.
>
>  scripts/coccinelle/api/stream_open.cocci | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/scripts/coccinelle/api/stream_open.cocci b/scripts/coccinelle/api/stream_open.cocci
> index df00d6619b06..d33732f35710 100644
> --- a/scripts/coccinelle/api/stream_open.cocci
> +++ b/scripts/coccinelle/api/stream_open.cocci
> @@ -129,6 +129,7 @@ identifier llseek_f;
>
>  @ has_no_llseek @
>  identifier fops0.fops;
> +identifier no_llseek;
>  @@
>    struct file_operations fops = {
>      .llseek = no_llseek,
> @@ -136,6 +137,7 @@ identifier fops0.fops;
>
>  @ has_noop_llseek @
>  identifier fops0.fops;
> +identifier noop_llseek;
>  @@
>    struct file_operations fops = {
>      .llseek = noop_llseek,
> @@ -216,6 +218,7 @@ identifier stream_writer.writestream;
>
>  @ report_rw depends on report @
>  identifier fops_rw.openfunc;
> +identifier nonseekable_open;
>  position p1;
>  @@
>    openfunc(...) {
> @@ -283,6 +286,7 @@ identifier stream_reader.readstream;
>
>  @ report_r depends on report @
>  identifier fops_r.openfunc;
> +identifier nonseekable_open;
>  position p1;
>  @@
>    openfunc(...) {
> @@ -331,6 +335,7 @@ identifier stream_writer.writestream;
>
>  @ report_w depends on report @
>  identifier fops_w.openfunc;
> +identifier nonseekable_open;
>  position p1;
>  @@
>    openfunc(...) {
> --
> 2.31.1
>
>
