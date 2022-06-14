Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF42C43334
	for <cocci@archiver.kernel.org>; Tue, 14 Jun 2022 06:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=GC4cC6xqLpNjJcTRVc9cbkZ2veanyHZIOpz/10KHRlE=;
  b=CocTeRQNeBAQLLcu7YJk45PbRqgZplv4hz3g28TE+UkVhM60+9dwYyXR
   MnTkc3YwAi9XmK5NhSMb7lfFAfI6r/2uyuUGHEkrM+eFlEReXkwuWSBJ3
   kdli2kjRFFhriT4ZFt1e2TTLXFCqQ40X6u1uFwEZo4FXc9/yz7nlSeqkS
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.91,299,1647298800"; 
   d="scan'208";a="40866092"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Jun 2022 08:26:59 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E9CD3E013D; Tue, 14 Jun 2022 08:26:58 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DC2B8E0038
	for <cocci@sympa.inria.fr>; Tue, 14 Jun 2022 03:50:23 +0200 (CEST)
IronPort-SDR: Ehm5Eoe+YJaObdUIBCcmjcEQFOKbhZaSL1HDebaarblFAF05dbMkZcxMXjq4zz18ED4TvJM+Kg
 edSXO1Y3VDGpwQXNXXGS+AU81IC9mCR++rZAerxLeBJzrsjY2s43GWggV1D9PVeXSrHn9tddUn
 BY4pZETnWDxoqqrGY89K1GvYc37oBgb8UKIWd79yLP36FlL8N5NlGDEuuFaGSgNb91r336H/V6
 lCqsMFxC+MC9OkpfaIFIFgZXJseUB9gfm5FUg5jewLJtNINhuPiRLCfH4NZ2sIrzN5IT2YtRB1
 yUJh6fBXYelCMJLY8au3i/B3
X-IPAS-Result: =?us-ascii?q?A0CKAgAL6adifzHQVdFaHgE8DAILFYFPgiSBVi8EC0SET?=
 =?us-ascii?q?o5ogiiLKoccjB4LAQMBDUIEAQGFAgKFRwIdBwEEMwYOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQMBAQUBAQECAQECBAQBEwEBDQsJBwgKBw4OBWABYQMBRIFPgXQLAzENg?=
 =?us-ascii?q?jUpAYNjAQEBAQIBEhEdARsdAQMMBgULCgMCAiYCAiEBAREBBQEcBhMigluCZ?=
 =?us-ascii?q?QEDDSMDoCqBBEKKOHqBFQUXgQGCCQaESwoZKA1qgVkCBxJ/LYRQgUuBKocpJ?=
 =?us-ascii?q?xyCDYFLgnQ+giCFeoJlBI1EinwBAwcDBAYFDwMDAiIBAgFGIwICAQELAgYGB?=
 =?us-ascii?q?AYDAQEGAwkCBAISAgIEBxgKEggUAwIGAiAFAQcFAQQDEgYMEQEIBgYBBAIKA?=
 =?us-ascii?q?QICBQUMAwERAQQCBgIEBAQYFAQCBAcGAgkJBwUWCwQKAhYBHAIGDAgCAgICA?=
 =?us-ascii?q?gQVBwENBQICBA8CBwYDCwIDBQcDAwQHDAYMDgEDAQcBBAUDDQQBAQYCCwMFC?=
 =?us-ascii?q?gIBAgMMAQEHBAgBAQICCgIBBAIHAQIFAwIDCAMCAwMCAgEBBBECAwQDBAIDA?=
 =?us-ascii?q?QUBAQUDAgUBAwMCAQMDAwIBBAMGCQoECAEEBAEBARECBwcCBgMDAgICAgUBA?=
 =?us-ascii?q?g0BAgECBAMIBgIDFAECBAEKAQUCAwkCBwMBAQIHBQoCBwUCBwICBAEFAw0BA?=
 =?us-ascii?q?wUCAwEBAwMCBAECAQMDCQEDAgMDAgICAgUCAwICAgkDBAEHAwIBAQQFAQQDA?=
 =?us-ascii?q?QIKBAQDBAIEAgcCBwIEBwIBBAYDBwYBAwIBBwEBBAoEAwMDAQEHAQIFAgIDA?=
 =?us-ascii?q?gYSBgcCBAEDBAQKAgIMAgcBAQIBAQEBAgMCBwUMAQEBAwIDBgIFAgIBAQMIC?=
 =?us-ascii?q?AMCAQQBBQMBBAUDBwIBBQkCCQMDCQMBAQUBAwEJAwMDAgkDAQICAgsEAwgDA?=
 =?us-ascii?q?wIDBAICAgIBAwIHBQgEAQQKAgICAQICAgQCAQMaAQIDBQICCQwBBAICAwEDA?=
 =?us-ascii?q?QECCAQJBAIDBAIBAQMCAQICAQUCAw0GAQEBAQIDAwECAwEBBgcCCAIzEwEDA?=
 =?us-ascii?q?wIBAgICBQICAQIDAgINAQEBBAIBAgECBgEDAQICAwEDAQICBgIMAwgCBwEFA?=
 =?us-ascii?q?wMCAgMBAQUPBQIBBAIBAgYFAgEBAQQBAwQECAICAQMDAg4CBAEEAQIBASMDB?=
 =?us-ascii?q?AIDAQMXAQIBAgMDAwQGBwYCAQITAQIBAQEFAQIBAQQCBAQHCgMCAgIGAwMFA?=
 =?us-ascii?q?QECAwIBAQEHDAICAhMCBAoJAwEGAQoGBhUDAgQCAgECAgIKAwECAgEDAgkCA?=
 =?us-ascii?q?QIBBSQDAQEPJAEBAgIBAgIDBAcCAQQGAw0CAgEBAQUGDQMCAwgMAgkDAgIDB?=
 =?us-ascii?q?QECAgIEAQIEDAoBAgIBAgIEBQUDAgEIBgUNBQkLAQICAQMIAQQDEQIGAwUFA?=
 =?us-ascii?q?wMCAQoFAgMBAgEBAwEEAQMEBgEBAgMCAgEIAgIBAQMDBAMBAgYCAggCAwIBB?=
 =?us-ascii?q?AIDAwEBAQQCAgICAgQDCAMCAQgHBQEGAQIBBAMCAgECBwEEAQkCAQMDBQMEA?=
 =?us-ascii?q?QoDDwMFAwEDAwIVCgQEAQUIBAQJAgQFAgUDAgQCAwMCAggFAgQDAg4DAgIGA?=
 =?us-ascii?q?wQCCAQQBwICBQICAgUCAgICAgYGJwEBBWSYZIJZmAUBjR2dUGsVS4J4hBiVf?=
 =?us-ascii?q?YV9MahclmuRB5YcECMSgUKBf3AvUoI3TgECAQEBDQECAQEDAQIBAgkBAQKSD?=
 =?us-ascii?q?4prNzE7AgYLAQEDCY59AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:rthIe6q/1++ENddSYMs5hFz1coVeBmLQYxIvgKrLsJaIsI4StFCzt
 garIBmPbv+NazT3Ld13bo2w80wBscfTytAwTFM//H02FyxE+OPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKicfHoZqTZMEE/Nszo68wICqtMu0IHR7z+l4
 4uo+ZWBYQT9gVaYD0pNg069gEM31BjNkGhA1rAOTagjUIj2yhH5pLpGTU2AByOQrrt8RoZWd
 M6fpF2NxV41yj92Yj+TfhkXRWVRKlLaFVDmZnO7wMFOiDAazsA5+v5T2Pbx9S67hh3R9+2dx
 umhurTsY0B1F7+Sh90EaD52Gh5bMJx09OPYdC3XXcy7lyUqclPpyvRqSUw6ZMgWprcxDmZJ+
 vgVbjsKa3hvhcrsmOP9GrQq3JxzapW6VG8ckikIITXxCOsqRpbMR6TD49BR1jw8rs9LFPfaI
 cEebFKDaTyZPUMSawhJVPrSms+NiX39STcDjmitmoE7uWvo5wFB+//EZY+9ltuiHJ0JxC50v
 Fnu+23mCxUeHM6ezDCf+zStgPXOlGX1Quo6H7qz/f9Cm0yW3mVVCRsMVFL9r+PRt6Klc9dWK
 khR9yZ36KZupQqkSd7yWxD+q3mB1vIBZzZOO7EQr12k2PTL2h+iIUYNcRtMWe4q6NBjEFTGy
 WS1t9/uADVutpicRnSc6qqYoFuO1c49fT9qicgsHVtt3jXznG0gpkmQEYs7QcZZmvWwSG6gm
 WnbxMQrr+xL1ZZj6kmtwbzQb9uRSnXhSwc04kDaUjvg4F8oIoGiYIOs5B7Q6vMowGelorup7
 SBsdyu2trhm4XSxeMqlHrll8FaBuartDdEkqQQzd6TNDhz0k5JZQahe4StlOGBiOdsedDnib
 Sf74F0MucYPYSPwMvUuP+pd7vjGK4CwRbwJsdiEPrJzjmRZKWdrAQk1ORLKgDiz+KTSufhgY
 szAGSpTMZrqIf0/kGDeqxY13rgsySQzrV4/triqpylLJYG2PSbPIZ9caAXmRrlgsMus/VuIm
 /4CaJPi40gOCIXWP3iMmaZOfABiBSZhWfje9ZcMHsbdeVoOJY3UI6WOqV/XU9c1wfo9eyah1
 i3VZ3K0P3Kl2iKcd1jXMCw/AF4tNL4mxU8G0eUXFQ7A8xAejUyHsM/zrrM7Iusq8vJN1/lxQ
 6VXcsmMGKUdRTHO+jBbZp749dQweBOujAOIHiykfDlvJ846F1KVoofpLln16S0DLiurrs9h8
 bCt0wXsR5BcFQlvCcDhbu2ikgGqtn8HleMuBEbFe4EBeEjl/IVwBTb2i/s7f5MFJRnZl2mV0
 g+XBVETouyU+90599zAhKalqYa1ErsmThAKQTWDtbvvbHvU5Guux4NEQd2kRzGFWTOm4rima
 MVU0+r4b68KkVNMhIx2TORmwKc40N3w/uMIwwlhGkLLWFSlELZXJHeLgJtUvapXy74F4Aa7V
 x7d+tRePrnVasrpHERLf1ggZ+WHkPwYw3zcsaVzL0L96yt6urGAVBwKbRWLjSVcKppzMZ8kk
 bh94p9Is1Tnh0p4KMuCgwBV63+Ici4KXZIhu8xIG4TskAcqlgxPbMCOECPw+53TOdxAPlNwe
 W2RjavGwrlQnw/MLyt1Gn/K0u5Qw58JvUkSnlMFIl2InPvDh+M2jEINq2VpFlwNw0UVyf93N
 0hqK1ZxefeE8QBuiZURRGurAQxAWECU90GZJ4HlT4EFo5REl1AhLVHR/c6I9UEdtm9QJ31Vo
 ODex2HiXjLnOsr220PenKKjR+PLFbRMGs/qwahL3Php27E1ZDPkhumlYm9gR97PH5YqnEOez
 QV11L8YVEA4XBL8Z4U0DoCb0fIbTxXsyKmuhx1+1PthIFwwsw1eFdRDx45dty+NyzH3HZeEN
 vFT
IronPort-HdrOrdr: A9a23:wVCWgqsXZuO9EIykCqVDEpsH7skDSdV00zEX/kB9WHVpmwKj5r
 mTdZUgpGfJYVMqMk3I9urwXZVoLUmsl6KdpLNhXotKPzOGhILLFvAH0WKK+VSJcBEWtNQ86U
 4KSdkYNDSfNykdsS842mWF+hQbreVvPJrGuQ4W9RlQcT0=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,298,1647298800"; 
   d="scan'208";a="16659764"
X-MGA-submission: =?us-ascii?q?MDFvKL1T72gxySymmKCYShhmkPkSe3t97ow4wp?=
 =?us-ascii?q?5B+XGmkE4I85aKOqUdJVv2JZJgJdhScbzuv6wSM3WeNu85Pckpk9ndbG?=
 =?us-ascii?q?lj2Aq88crOdfwfhkly2y7HcDzfFciUhfooE8XvaAj7HeelPhpNWXB8Qj?=
 =?us-ascii?q?J1Gv/iG50W1pUPckzahZJFeQ=3D=3D?=
Received: from mail-ed1-f49.google.com ([209.85.208.49])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 03:50:06 +0200
Received: by mail-ed1-f49.google.com with SMTP id w27so9560790edl.7;
        Mon, 13 Jun 2022 18:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GC4cC6xqLpNjJcTRVc9cbkZ2veanyHZIOpz/10KHRlE=;
        b=SylH0oLhpiSNSMQ24eXb2MxaYkBgTx3hdy3OloWuxF7tYYVBMSbP5jX6Ug6AFkCwkH
         TCJYe5Cj8MOkhwk7mQCXwMK+/57yzF6puQAJGzz1VaEn7JAZrtThZJ9Fa93puXpEmugT
         OEHbE1yvtIgLWKc1yeI+7T3TbRxRWpY6BCKGFbSeYHyd5qcIiPGsVR+oCUpRb9HfWCzl
         PpIGBpmjN6epxVKue9GJzjze86HTIAbW1iRJqA7tWN/874C56e4Lac80MEURqohZoo31
         tHCgmuRDQ1XRNOUu5wmACYTWUqjSOn5o9XsJHM4dPJ+wOkwydFJjSWdYeJ97QSUHQbZX
         Kmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GC4cC6xqLpNjJcTRVc9cbkZ2veanyHZIOpz/10KHRlE=;
        b=ewnflXbTQs8v1DqcCRG+kxyxtLz9My9xtJr1NLZjzPIVDrs+2na8y4SNEbSDfCSs2S
         KUB5Kq0ssx5dnaB+X/PO18xp6Go8h+47RfFJKCmuSkI9MIoLEIujdAuYAM811nrP80kc
         8sXXSE9J9u04iA8u3XWm55lQipAkmCk1YB0dBqEjHFSw2gyZ3dXaG5LeaCPAgNvifoYD
         Z5Br91ZfIXKaH5sw88o18LRtrlMt8J3o5aQ35uwfsaCbRV50APLykaE0fBHrjgKGQZX+
         EZAhSOWsFv/Te2T47avqfyS6RvVVwpHp8bDvE5purBoPUkJ7l2/UqH6SHbMRaqa66vtc
         KFsw==
X-Gm-Message-State: AJIora9AS3d0uGzBzA9ClUnNQwT37MYcfnK1nWzSuTN49CdxV8o4lt2z
	ozH/eISyBO4xlUxv2zEwW+nuFQFloVXfGmvj3IjYCo2HjXR2PmUe
X-Google-Smtp-Source: ABdhPJwnROWsbMWlDeqxyGahZkqEhUbMS48bk+kBqxa4mCeEmj/YxhYUX7snuSgtPgK3zSD2HRg/Po/pa2lotiC/bIY=
X-Received: by 2002:a05:6402:3681:b0:433:2b63:4866 with SMTP id
 ej1-20020a056402368100b004332b634866mr3065276edb.295.1655171405197; Mon, 13
 Jun 2022 18:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220613071243.12961-1-dzm91@hust.edu.cn> <Yqbu8TwmaXdBiIBs@debian.me>
 <alpine.DEB.2.22.394.2206131212160.2812@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2206131212160.2812@hadrien>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Tue, 14 Jun 2022 09:49:30 +0800
Message-ID: <CAD-N9QUOk938-+1CtGfWNKUvWowknKScLuFXXkFAv59M=-F84g@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Nicolas Palix <nicolas.palix@imag.fr>, Jonathan Corbet <corbet@lwn.net>, cocci@inria.fr, 
	linux-doc@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] dev-tools: fix one invalid url
Reply-To: Dongliang Mu <mudongliangabcd@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 443
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/CAD-N9QUOk938-%2B1CtGfWNKUvWowknKScLuFXXkFAv59M%3D-F84g%40mail.gmail.com>

On Mon, Jun 13, 2022 at 6:12 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Mon, 13 Jun 2022, Bagas Sanjaya wrote:
>
> > On Mon, Jun 13, 2022 at 03:12:42PM +0800, Dongliang Mu wrote:
> > > From: Dongliang Mu <mudongliangabcd@gmail.com>
> > >
> > > Fix the invalid url about Semantic Patch Language
> > >
> >
> > I think what this patch doing is to point SPL reference URL from old
> > Coccinelle documentation (doc root) to actual SPL doc entry on new
> > Coccinelle page, right? If so, "fix invalid URL" may not be right patch
> > description and title.
>
> Agreed, thanks for the suggestion.

Okay. Let's modify the title to "modify SPL reference URL to actual
SPL doc entry".

BTW, I modify this URL because the previous URL cannot be accessed.

>
> julia
