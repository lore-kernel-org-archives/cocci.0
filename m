Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44574C4829E
	for <cocci@archiver.kernel.org>; Sun, 18 Feb 2024 08:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=TbmdbBSVviIHkden+8PwXOmL2cJJEkvmat341wz5Mec=;
  b=RR9uTyee3DwYGLvnum4DfgChLGxiZuokDqLcryRD++nM83hbI8FFXy2/
   29kcirhb8tmA70KGhwgoLpEIGzkEiFlBTB3irxw9xPGJRDyQ1S3Nw5f1m
   O6tnIz4q9JnwAMB227tUwLN2i1ZacG+atvvRQWA8wPyi1krvei7fD+MBJ
   g=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.06,168,1705359600"; 
   d="scan'208";a="152482698"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Feb 2024 09:17:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A6BE1E0CD7; Sun, 18 Feb 2024 09:17:53 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E23BBE008A
	for <cocci@sympa.inria.fr>; Sun, 18 Feb 2024 09:17:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TbmdbBSVviIHkden+8PwXOmL2cJJEkvmat341wz5Mec=;
  b=Jq//bwLzhgBvbsqBjUGJY9ON/bmAoi0QCjuyyOEyyK5SEAdZWt9+vR83
   UTjE/qMsY1YB7Ufzcu060MEMNWM30E/+FY1YiPfdAOKAkXEDxmPQcTg1H
   XJ5wBI5Vsrxwt7KXbysrEooLeq+XO58wisnJeqwLgbeJUjMz3CCtIIXNC
   U=;
X-IronPort-AV: E=Sophos;i="6.06,168,1705359600"; 
   d="scan'208";a="79934373"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:17:53 +0100
Date: Sun, 18 Feb 2024 09:17:52 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Li Zhijian <lizhijian@fujitsu.com>
cc: linux-kernel@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>, 
    cocci@inria.fr
In-Reply-To: <20240218080054.719008-1-lizhijian@fujitsu.com>
Message-ID: <alpine.DEB.2.22.394.2402180917060.3095@hadrien>
References: <20240218080054.719008-1-lizhijian@fujitsu.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v2] coccinelle: device_attr_show: Remove useless
 expression STR
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1577
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/alpine.DEB.2.22.394.2402180917060.3095%40hadrien>



On Sun, 18 Feb 2024, Li Zhijian wrote:

> Commit ff82e84e80fc ("coccinelle: device_attr_show: simplify patch case")
> simplifies the patch case, as a result, STR is no longer needed.
>
> This also helps to fix below coccicheck warning:
> > warning: rp: metavariable STR not used in the - or context code
>
> CC: Julia Lawall <Julia.Lawall@inria.fr>
> CC: Nicolas Palix <nicolas.palix@imag.fr>
> CC: cocci@inria.fr
> Fixes: ff82e84e80fc ("coccinelle: device_attr_show: simplify patch case")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Applied to my tree

> ---
>  scripts/coccinelle/api/device_attr_show.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/api/device_attr_show.cocci b/scripts/coccinelle/api/device_attr_show.cocci
> index 550d1d2fc02a..dfcf9304195f 100644
> --- a/scripts/coccinelle/api/device_attr_show.cocci
> +++ b/scripts/coccinelle/api/device_attr_show.cocci
> @@ -28,7 +28,7 @@ ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
>
>  @rp depends on patch@
>  identifier show, dev, attr, buf;
> -expression BUF, SZ, FORMAT, STR;
> +expression BUF, SZ, FORMAT;
>  @@
>
>  ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
> --
> 2.29.2
>
>
