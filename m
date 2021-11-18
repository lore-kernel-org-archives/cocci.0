Return-Path: <SRS0=pbzS=QF=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2888BC433F5
	for <cocci@archiver.kernel.org>; Thu, 18 Nov 2021 08:34:10 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5138D611C5
	for <cocci@archiver.kernel.org>; Thu, 18 Nov 2021 08:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5138D611C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AwTqsAKnpVsTlnYRV4aRZ3Ino5gyQJ0RdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bp2BTy2JOWD2EafbZNmL2eYt0PI7joEIGupfRyd5nSgdl+CA2RRqmi?=
 =?us-ascii?q?+KVXIXDdh+Y0wC6d5CYEho/t63yUjRxRSwNZie0SiyFb/6x8hGQ6YnSHuClUbe?=
 =?us-ascii?q?dangoLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82Yc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTaVwPWreUPA6Ui3MQVbLKbhpq/3ZilPdgcqNCMwEO1W3hc9NZkb2hsbS7T?=
 =?us-ascii?q?gwiP+jLh+IQSTFZFTt/NOtI4tcrJFDj65LPkBafG5fr67A0ZK0sBqUT/e18AEl?=
 =?us-ascii?q?H7/cYKS4AdFaAiviwzbb9TfNj7uwpLdLwLY0Rkn5lxDDdS/0hRPjrSKLH49Je9?=
 =?us-ascii?q?Dg1j8FKW/3ZYqIxZTNpKhaGfBxLPlYeDYkWk+Khh325eDpdwHqZrLQ273PUygB?=
 =?us-ascii?q?/37zFP9/ce9jMTsJQ9m6UqyTd+HnrC1cRM8aSzyaE9Fqjg+bOmWXwX4d6PLaj6?=
 =?us-ascii?q?/pukXWcwWscDBBQXly+ydGzh0izV9NcN2QU9ysooO4o80eoVbHVVBm/p2WsvB4?=
 =?us-ascii?q?XX91XCKsx7wTl4qbd5QeUAi4AQyxKYdohnMs3QzUw0RmOhdyBLTdvqryOVXWF9?=
 =?us-ascii?q?vGeqj6yPDccKWMPfwcATA0P4sWlq4Y25i8j5P4L/LWdlsfyFXT0wiuWoTMj3uV?=
 =?us-ascii?q?VjMgR1qz980qvvt5lnbCRJiZd2+kddj7NAttFWbOY?=
X-IronPort-AV: E=Sophos;i="5.87,243,1631570400"; 
   d="scan'208";a="4264731"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Nov 2021 09:34:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2BFBBE027E; Thu, 18 Nov 2021 09:34:07 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 568A3E0220
	for <cocci@sympa.inria.fr>; Thu, 18 Nov 2021 09:34:03 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=geert@linux-m68k.org; spf=Pass smtp.mailfrom=geert.uytterhoeven@gmail.com; spf=None smtp.helo=postmaster@mail-vk1-f173.google.com
IronPort-PHdr: =?us-ascii?q?A9a23=3AEQHACBLph+5Rrk024NmcuFNhWUAX0o4c3iYr45Y?=
 =?us-ascii?q?qw4hDbr6kt8y7ehCFvbM81RSUAs3y0LFts6LuqafuWGgNs96qkUspV9hybSIDk?=
 =?us-ascii?q?tgchAc6AcSIWgXRJf/uaDEmTowZDAc2t360PlJIF8ngelbcvmO97SIIGhX4KAF?=
 =?us-ascii?q?5Ovn5FpTdgsipy+y+4ZnebxhHiDe9Y755MQm7oxjWusQKm4VpN7w/ygHOontGe?=
 =?us-ascii?q?uRWwX1nKFeOlBvi5cm+4YBu/T1It/0u68BPX6P6f78lTbNDFzQpL3o15Mzwuhb?=
 =?us-ascii?q?dSwaE+2YRXX8XkhpMBAjF8Q36U5LsuSb0quZxxC+XNtDtQLsqRTqt8btkSB7wi?=
 =?us-ascii?q?CcGKTE59n3Xitdth65fuR6tugBzz5LRbIyTKfFwfL7SfckCSGVOUMZeVSxPDI2?=
 =?us-ascii?q?/YYUSEeQOIf1Vr5Xhq1YUsReyGRWgCeHpxzRVhnH2x6o60+E5HA/HwgMvAcgOs?=
 =?us-ascii?q?GjJp9r7NKYSTfy1w7fSzTXDaPNZxyn955bOchs8pvyMUqx/ftTLyUkzDA7FilS?=
 =?us-ascii?q?QqYr4PzKaz+gNtmmW4uljVe61jG4nsQ5xryGpy8wxhYbHmpgbxUrY9SVl3ok1P?=
 =?us-ascii?q?9u4RVZnbdCqH5ZeuD+XOoprT84tTWxkpjs3xLMFtJO5YiUHyYoqyhHDZvGEc4a?=
 =?us-ascii?q?F5h3uWumfLzp6mH5ofKyyihev/US9zOD3S8q60E5SoyZbjtXBsmoB2h/T58SdV?=
 =?us-ascii?q?Pdx4Fqt1SyS2w3R5OxIOV44mbbfJpI7wbM9loAfvVrdEiPogkn7g6Cbe0M58ea?=
 =?us-ascii?q?y8evneK/pppqEOo90lA7+NqMul9S6AesiMwgOW3GX+fq/1LH+5EH5TqhGg/84n?=
 =?us-ascii?q?6XDv5DaIsMbpqG9AwBLyIos9xG/DzK+3NQZm3kIMk5FdQqZg4T1P1zCOvP1APe?=
 =?us-ascii?q?lj1iyjjtn2urKMqDjD5jDNnTDla3ufbd5605S0gozytVf6opbCr4fPv3zQFPxu?=
 =?us-ascii?q?MbFDh45Lwy03/joCM991oMZR22PHLGWMKXJvF+H4+IgOeiMZIsPtDnhLPgl4ub?=
 =?us-ascii?q?ijWUlll8FYampwZwXZWi8Hvt8LUSWe37sgtMaHGYLvwo+SffliEeYXjJJZnayW?=
 =?us-ascii?q?bg85jAhB468A4fDXJingKad0yejAp1WemdGB0iDEXftaoWEX/MMZzyIIsJ6kz0?=
 =?us-ascii?q?EVL2hRJQ71R60rgP6yrxnLvDV+iICr57j2sJ17fXJlR4u7Tx0E9id02aVQm5om?=
 =?us-ascii?q?WMHWyM53KFkrExmylaD1LB4jOZCGdxS4fNJSAY6OoTGw+x0EdChEj7GK/iUTx6?=
 =?us-ascii?q?UQtigDjIsT5plzMIJcUZwHdqhkxHrwSu0BPkekLndV7Iu9aeJ8HX8Pdo19mfay?=
 =?us-ascii?q?KQ7j14rXMZJfTmpi6Nl6yDXBojUgwCcyfapM6MG03iepy+40WOSsRQAA0ZLWqL?=
 =?us-ascii?q?fUCVaPxOOxTwczkfDSaK+TLF5YggHztSNePMigjzBiFxHQLL9O42bbTvuwCG/A?=
 =?us-ascii?q?hGHwr7KZ43vKT11NMr1B00NkgRV9nGDZ1FWOw=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Agsxze6O5TTx7tcBcTsijsMiBIKoaSvp037BN?=
 =?us-ascii?q?7SxMoH1uH/Bw+PrPoB1273DJYXMqKRQdcK67Scq9qALnm6KdiLN5VdzJYOClgh?=
 =?us-ascii?q?rLEGgI1+rfKlPbaknDH5ZmpMBdT5Q=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AeAQASaxphf63dVdFagQmBWYN5a4RHi?=
 =?us-ascii?q?QSGRYInm2iCBwEDAQsBAUEEAQGHTgIdBwEEMAkOAQIEFQEBBQEBAQIBAwMEARM?=
 =?us-ascii?q?BAQ0LEAg4JoV1gjUpAYNkAQUSEQRSEAsLDQICJgICIhIBBQEcBhMihVebCIEEP?=
 =?us-ascii?q?YsyfzKBAYg3gWMJAQh+KocNhmYnHIINgUuBBYFqPodbgmQEhn6WAYlRjQqSHQi?=
 =?us-ascii?q?DKoE3nRsrgTuUDpEstl2EUAIKBwYQI4E9ghR9CGwGgjJQGQ6ccUAyOAIGCwEBA?=
 =?us-ascii?q?wmJdQEB?=
X-IPAS-Result: =?us-ascii?q?A0AeAQASaxphf63dVdFagQmBWYN5a4RHiQSGRYInm2iCBwE?=
 =?us-ascii?q?DAQsBAUEEAQGHTgIdBwEEMAkOAQIEFQEBBQEBAQIBAwMEARMBAQ0LEAg4JoV1g?=
 =?us-ascii?q?jUpAYNkAQUSEQRSEAsLDQICJgICIhIBBQEcBhMihVebCIEEPYsyfzKBAYg3gWM?=
 =?us-ascii?q?JAQh+KocNhmYnHIINgUuBBYFqPodbgmQEhn6WAYlRjQqSHQiDKoE3nRsrgTuUD?=
 =?us-ascii?q?pEstl2EUAIKBwYQI4E9ghR9CGwGgjJQGQ6ccUAyOAIGCwEBAwmJdQEB?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="399745554"
X-MGA-submission: =?us-ascii?q?MDGex92kvgJglmcxgOi05dWAy07Ug5BHosPXHG?=
 =?us-ascii?q?gEMbIX9NHTutsPLJlPolXdchG4xcpxn9Ug/T5HpiAXV036oboq11EY5W?=
 =?us-ascii?q?b5dArQ9cJIOdKOYZM2rhwG4XbUIhpvdA+7pOqfsUi0weSn5mCXKg1v0O?=
 =?us-ascii?q?Z+1V2Uu0ukJAhjk1u9WVeVTw=3D=3D?=
Received: from mail-vk1-f173.google.com ([209.85.221.173])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 18 Nov 2021 09:34:01 +0100
Received: by mail-vk1-f173.google.com with SMTP id q21so3341322vkn.2;
        Thu, 18 Nov 2021 00:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZHqYNDJJeUEUo7A1lpPpFJOTlOxuy2hnNwzoc1obFj4=;
        b=5E4q8Dnsvrw/arzDNffGHDXQ6aUx7WhfNgg4AVIcE8raiYDHfT4rG8DMGvPRL2AnOY
         ApxKadAqa5XCH4sVVvewhO13dgjQ6X+ZBhVJ/izRLgCk67JGP4fH9uFddWCT+2epIB8i
         XoMwpAvHdr75Pi3DUpwySemDUw6fjT/v9XobhdIvMTSgHJYHPUAxUiCx7i2ui9UTSQec
         6sfGwfc3ebkMWWwN3euv7cQvdmX52f7Nq9/ndMG4JJOCMRerHDCrQQ+cjPcy7+8Rr7EC
         hMICq2Sxh08GQ50trXZB3IaaaJMmZQsSh3Pu7OHWBlmWF6TORV3VIbTVY9jDqqCsjGYV
         EgbA==
X-Gm-Message-State: AOAM530/jbfyZax4lSRXG1Yp5wXCa7i6ROQQnau8HK3+zl8zvxV51kum
	XGsgZwE8izijevbe7tDl3jJzPXl6uLFhUA==
X-Google-Smtp-Source: ABdhPJydPkrxxWKMGpyobBOzaJjXx/uDpomP3b2S7/gtadcH5EY7TO1kew2uUw0lqlfXMSKplfW50w==
X-Received: by 2002:a05:6122:929:: with SMTP id j41mr101810264vka.18.1637224439667;
        Thu, 18 Nov 2021 00:33:59 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id g21sm1435947vkd.26.2021.11.18.00.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 00:33:58 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id p2so11878597uad.11;
        Thu, 18 Nov 2021 00:33:57 -0800 (PST)
X-Received: by 2002:a05:6102:e82:: with SMTP id l2mr78426134vst.37.1637224437450;
 Thu, 18 Nov 2021 00:33:57 -0800 (PST)
MIME-Version: 1.0
References: <20211117121829.11141-1-guozhengkui@vivo.com>
In-Reply-To: <20211117121829.11141-1-guozhengkui@vivo.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Nov 2021 09:33:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWxSBSb0zA=_Httx53ocJ5qtKUHArq_+pCAWKB9ppzn1g@mail.gmail.com>
Message-ID: <CAMuHMdWxSBSb0zA=_Httx53ocJ5qtKUHArq_+pCAWKB9ppzn1g@mail.gmail.com>
To: Guo Zhengkui <guozhengkui@vivo.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, 
	"open list:OMAP FRAMEBUFFER SUPPORT" <linux-fbdev@vger.kernel.org>, 
	"open list:OMAP FRAMEBUFFER SUPPORT" <linux-omap@vger.kernel.org>, 
	"open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, 
	kernel@vivo.com, Julia Lawall <Julia.Lawall@inria.fr>, 
	Gilles Muller <Gilles.Muller@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [cocci] [PATCH] video: omapfb: Use scnprintf() instead of
 snprintf()
Reply-To: Geert Uytterhoeven <geert@linux-m68k.org>
X-Loop: cocci@inria.fr
X-Sequence: 106
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/CAMuHMdWxSBSb0zA%3D_Httx53ocJ5qtKUHArq_%2BpCAWKB9ppzn1g%40mail.gmail.com>

Hi Guo,

CC cocci

On Wed, Nov 17, 2021 at 1:58 PM Guo Zhengkui <guozhengkui@vivo.com> wrote:
> Fix following warnings:
> ./drivers/video/fbdev/omap/omapfb_main.c:1382:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/video/fbdev/omap/omapfb_main.c:1306:8-16:
> WARNING: use scnprintf or sprintf
>
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>

Thanks for your patch!

> --- a/drivers/video/fbdev/omap/omapfb_main.c
> +++ b/drivers/video/fbdev/omap/omapfb_main.c
> @@ -1303,7 +1303,7 @@ static ssize_t omapfb_show_panel_name(struct device *dev,
>  {
>         struct omapfb_device *fbdev = dev_get_drvdata(dev);
>
> -       return snprintf(buf, PAGE_SIZE, "%s\n", fbdev->panel->name);
> +       return scnprintf(buf, PAGE_SIZE, "%s\n", fbdev->panel->name);
>  }

I guess all of these should use sysfs_emit() instead.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
