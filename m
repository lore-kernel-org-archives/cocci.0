Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A31C4332F
	for <cocci@archiver.kernel.org>; Sat, 24 Dec 2022 12:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=uyXsiyueiTc8v5MlNRur4jIQ7A6s63yrjzYIjyka/fE=;
  b=lfrdZ0RPvU9D5bW+rXqnaz8wt4O7ZWKrWBSdeDslGpO8F58bT49LUthF
   h2cMwUsqa2J8PUiPabNvPjWWAPlENLBbf4y5+eYxf13zyTnrn4lTFPmgK
   FHXetK3xtLiEsb2zuaE7OWKFR5Q98jfi2htvt66By2Hqmw6EZJLZR+Jr2
   U=;
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
X-IronPort-AV: E=Sophos;i="5.96,271,1665439200"; 
   d="scan'208";a="84927041"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Dec 2022 13:28:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C5839E0133; Sat, 24 Dec 2022 13:28:06 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 04153E0128
	for <cocci@sympa.inria.fr>; Sat, 24 Dec 2022 13:28:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uyXsiyueiTc8v5MlNRur4jIQ7A6s63yrjzYIjyka/fE=;
  b=Te36gCRS4d3KXHDAb2wNQ70s//5flt8MMQnMQo4meBZ37/Zd+Ot9TtiR
   iJAtkOm44u1U5wQLzU2hQicsvau9kWWCgCg/WQUk31h9teVrPs82cc5o6
   MDbFhPb0yYsBt/gtWlRVEvarXp3fiPMgHmhamjjgDbDtiF9/k3wOtzKrX
   8=;
X-IronPort-AV: E=Sophos;i="5.96,271,1665439200"; 
   d="scan'208";a="84927040"
Received: from 214.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.214])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2022 13:28:04 +0100
Date: Sat, 24 Dec 2022 13:28:04 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
cc: Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org, kernel@pengutronix.de
In-Reply-To: <20221224115657.kqyocti356cwm7hc@pengutronix.de>
Message-ID: <alpine.DEB.2.22.394.2212241326310.2711@hadrien>
References: <20221224115657.kqyocti356cwm7hc@pengutronix.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1137191680-1671884884=:2711"
Subject: Re: [cocci] coccinelle: How to remove a return at the end of a void
 function?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 783
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/alpine.DEB.2.22.394.2212241326310.2711%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1137191680-1671884884=:2711
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Sat, 24 Dec 2022, Uwe Kleine-König wrote:

> Hello,
>
> I work on a patch set that eventually makes the function
> rtsx_usb_sdmmc_drv_remove() return void:
>
> A simplified spatch looks as follows:
>
> -------->8--------
> virtual patch
>
> @p1@
> identifier pdev;
> @@
> -int
> +void
>  rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
>  <...
> -return 0;
> +return;
>  ...>
>  }
> -------->8--------
>
> This results in:
>
> -------->8--------
> diff -u -p a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -1379,13 +1379,13 @@ static int rtsx_usb_sdmmc_drv_probe(stru
>         return 0;
>  }
>
> -static int rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
> +static void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
>  {
>         struct rtsx_usb_sdmmc *host = platform_get_drvdata(pdev);
>         struct mmc_host *mmc;
>
>         if (!host)
> -               return 0;
> +               return;
>
>         mmc = host->mmc;
>         host->host_removal = true;
> @@ -1416,7 +1416,7 @@ static int rtsx_usb_sdmmc_drv_remove(str
>         dev_dbg(&(pdev->dev),
>                 ": Realtek USB SD/MMC module has been removed\n");
>
> -       return 0;
> +       return;
>  }
>
>  #ifdef CONFIG_PM
> -------->8--------
>
> which is as intended. Now I want to remove the useless "return;" at the
> end of the function, however adding
>
> -------->8--------
> @p2 depends on p1@
> identifier pdev;
> @@
>  void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
>  ...
> -return;
>  }
> -------->8--------
>
> to the spatch doesn't (only) do the intended:

The problem is that Coccinelle is following the control-flow through the
function, and all of the returns are at the end of a control.flow path.
The simple, hacky solution is to change the return;s into some function
call Return();, then do like the above for Return(); and then change the
Return();s back to return;s

julia


>
> -------->8--------
> diff -u -p a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -1379,13 +1379,13 @@ static int rtsx_usb_sdmmc_drv_probe(stru
>         return 0;
>  }
>
> -static int rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
> +static void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
>  {
>         struct rtsx_usb_sdmmc *host = platform_get_drvdata(pdev);
>         struct mmc_host *mmc;
>
>         if (!host)
> -               return 0;
> +               {}
>
>         mmc = host->mmc;
>         host->host_removal = true;
> @@ -1415,8 +1415,6 @@ static int rtsx_usb_sdmmc_drv_remove(str
>
>         dev_dbg(&(pdev->dev),
>                 ": Realtek USB SD/MMC module has been removed\n");
> -
> -       return 0;
>  }
>
>  #ifdef CONFIG_PM
> -------->8--------
>
> It's obvious to me, why coccinelle also removes the first return, but
> it's not obvious to me, how to prevent this and only drop the 2nd one.
>
> Do you have a hint for me?
>
> Thanks in advance and happy holidays,
> Uwe
>
>
> --
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |
>
--8323329-1137191680-1671884884=:2711--
