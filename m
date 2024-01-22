Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC75AC4725D
	for <cocci@archiver.kernel.org>; Mon, 22 Jan 2024 06:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=nseMvP+PR5N4h48ZxlM/LviieiNOXZd2CDGHxfRIQ38=;
  b=i3CalN6cV9BDVP4/0vtTlwS6qzLaL6LlhVrmki4N0cG3IUZHChqXviTT
   SSqNNzGbNeGlb3WgNUh9ZoUmNVqZdQORvndCSAnhhMpmCxlZVJa5UlLwd
   KT0daebrsHS0PHZexWrJs6M1hAw/LPj8+DHohJTevbdjcuvTmZzVSVqKG
   0=;
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
X-IronPort-AV: E=Sophos;i="6.05,211,1701126000"; 
   d="scan'208";a="147837852"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jan 2024 07:33:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A8F99E0CD8; Mon, 22 Jan 2024 07:33:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1D32DE0035
	for <cocci@sympa.inria.fr>; Mon, 22 Jan 2024 07:33:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nseMvP+PR5N4h48ZxlM/LviieiNOXZd2CDGHxfRIQ38=;
  b=XeCbHbFwZutEiqKfoV5iqy/y3Ru4pIvvAuPvroGFbOe6fnV/FCtBusSz
   Ks+vv9riwnbpV0w6p8vJHW3tLBF282/YGTE4jge3tr3jHcHogIGhhSZ/6
   kEDWVPLcdRqTXNp7ZrN3mNwz2Oi4hgH1fWgw9icxIuq1z/EwdHIaGlu2Q
   4=;
X-IronPort-AV: E=Sophos;i="6.05,211,1701126000"; 
   d="scan'208";a="147837845"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 07:33:39 +0100
Date: Mon, 22 Jan 2024 07:33:38 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Li Zhijian <lizhijian@fujitsu.com>
cc: linux-kernel@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>, 
    cocci@inria.fr
In-Reply-To: <20240122032800.33026-1-lizhijian@fujitsu.com>
Message-ID: <alpine.DEB.2.22.394.2401220729490.3204@hadrien>
References: <20240122032800.33026-1-lizhijian@fujitsu.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH] coccinelle: device_attr_show: Remove useless
 expression STR
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1465
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/alpine.DEB.2.22.394.2401220729490.3204%40hadrien>



On Mon, 22 Jan 2024, Li Zhijian wrote:

> Commit ff82e84e80fc ("coccinelle: device_attr_show: simplify patch case")
> simplifies the patch case, as a result, STR is no longer needed.

Oops, yeah...

thanks,
julia

>
> CC: Julia Lawall <Julia.Lawall@inria.fr>
> CC: Nicolas Palix <nicolas.palix@imag.fr>
> CC: cocci@inria.fr
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
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
