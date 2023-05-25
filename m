Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33017C7EE29
	for <cocci@archiver.kernel.org>; Thu, 25 May 2023 19:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Sn9i0CKzMIwK5omSWmKW1nZGsT/UCNPDDqeDEaPN9eo=;
  b=TTi+XO4kU7oSJSFGMmXo3fCYnDyObVFvnINrKDSe9czXDhU6MJgeJaQ+
   zzBZi0nw0XxcMRtWHHoeufFfbVIdxA9OgdwBqnPgmr4E/JOmID7j6e1s7
   qGFHhoGiLaJW7app9+mwTDcP9QibdXJvM+V7SsOr26wwxz5lV35hCyETy
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.00,192,1681164000"; 
   d="scan'208";a="109740511"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 May 2023 21:24:19 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CFDB9E00A3; Thu, 25 May 2023 21:24:20 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DD642E0082
	for <cocci@sympa.inria.fr>; Thu, 25 May 2023 21:24:12 +0200 (CEST)
IronPort-SDR: 646fb5da_BDSpKKarQcVv2SuocfKkorRmoBzNtD+IYcZx0phuW1RDFVu
 dCh3vr4gNCFi78GOkC87cenRnoGhOiP4w3WrnWg==
X-IPAS-Result: =?us-ascii?q?A0EJAABHtW9kh07ASNlaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE8BAEBAQELAYIueFMwBAtHhFKPGYF2MYQzhzCHRIhqgVaBQ?=
 =?us-ascii?q?D4PAQMBDUEBAgQBAQMEgUyDMwKFXQIdBwEEMQgOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECBAUBAhABAQEjFwcOECeFaA2CNykBEWSBCAEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBEgJHPwECAgEjHQEBESYBDwsaAiYCAlcGAQwIAQGCe?=
 =?us-ascii?q?oIoAQMOIwevTIEygQGCCAEBBpwOHywiVYFfCYEVLQGNLIM3eicPgVVEgTwMg?=
 =?us-ascii?q?ng+gQUBgz6DW4Jngh6HM4VcjUuBMHKBI4EogQICCQIRZ4EOCGaBc0ACDWQLC?=
 =?us-ascii?q?2yBO1pDH4FKAgIRNA4MFQVYAoEEEAETAwcEAoEOEDEHBDcLGAkGCR0dGC0GX?=
 =?us-ascii?q?QcvJAkTFVMHhCsDCgqBEiUEDgMZKx1AAgELOzo9NQYDCx8GJgEeAiuBWAQvW?=
 =?us-ascii?q?nsGASQkoXaVZoMjjz2ePTUHgjCBW4FdDJ8bBhMvg2wBkyQOBpIrLpdgIKgSg?=
 =?us-ascii?q?WUBN4FcMxokgzZPAxkPjiAXAoQOj0g/NDsCBwEKAQEDCYVGAQGFfgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 d0NgKYf5f3BYAl5
IronPort-HdrOrdr: A9a23:foVds6sDjVgt/pHPnkCWBO1n7skDotV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:IX8NdGG//BLx26maqmJBpUEuAt0jdUTg90nZDFGcVWE1WeWsHAo=
X-Talos-MUID: 9a23:1fLZuwsqO4+VUaSogc2nqSk4O+NC/K+SCBo/lbopiuaDEClfAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,192,1681164000"; 
   d="scan'208";a="109740504"
X-MGA-submission: =?us-ascii?q?MDHOD1WvreNRy/QkKo4KUHGoL9INPDaUjDjBBK?=
 =?us-ascii?q?eCba/y+k5GFWySQ0DXmlRY+W30Gq/4OH1fnveIOokBjcbHWa3Y3ePwke?=
 =?us-ascii?q?iULUSKEkMHAoSvpbr61mB60AkGoeIHBbMtjgKRxRgAbHBfOSXWR46BL7?=
 =?us-ascii?q?9D8TuSzQbPzd0xq4YseiiHGw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 21:24:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1685042644; i=markus.elfring@web.de;
	bh=Sn9i0CKzMIwK5omSWmKW1nZGsT/UCNPDDqeDEaPN9eo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=G8O91UGoVsytO45XYiWggJ6kYz08HAB0oErKvEajW8ac1EwA8FxsH2YOchV1KAxFy
	 jvi0/llhIQYKOsfIEXvaQ+3hEskK1L9CEoqOXsXMHnJh975UbJjx351NSQL1HZIJIz
	 l8iGMY6+YXKQXhoJGHugVqxo0yYdPYZ8YqhkiiEqNnNM8v4Q2WxdSYxJz5PEcDwt+x
	 NFwxVUB9i5G0sLfvNsIGLJN0ZWX5zg7QkFY2orGxhJ80FYQpw+HO9+cKMZz89KZNNC
	 j/y7vrv1SxIWY0qDZa2j5sppDkkpGqAFthMHVywTvM5z5I/HF8dKZz+v4oVgEJDrPh
	 k6Xd9TnRgxGJA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MD5jv-1pt9lN0Hir-0096dF; Thu, 25
 May 2023 21:24:04 +0200
Message-ID: <d0f5e617-4319-37e9-9289-9f486d1061e0@web.de>
Date: Thu, 25 May 2023 21:23:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To: Helge Deller <deller@gmx.de>, kernel-janitors@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Javier Martinez Canillas <javierm@redhat.com>,
 =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Zheng Wang <zyytlz.wz@163.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 1395428693sheep@gmail.com, alex000young@gmail.com, hackerzheng666@gmail.com
References: <069f2f78-01f3-9476-d860-2b695c122649@gmx.de>
 <97807a2d-ccf2-1fbf-06f7-085bb1bdf451@web.de>
 <c551c670-7458-ed50-eb2f-5a2b7ba421a8@web.de>
 <7e5643de-5d64-272e-cb36-bbe1e5c187ec@gmx.de>
 <1d7228fb-f1f8-364c-aa29-5719a9da1fc6@web.de>
 <446a2a2a-155b-1fe3-44f3-89033b80ad34@gmx.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <446a2a2a-155b-1fe3-44f3-89033b80ad34@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fH0wWYnhiEpH+9EtpG5472RkEcj8eQzAMlS7hzgXGfpOR57L+91
 Xtv5UitowKkbFuFBdi62VwfC7FrvmuDUF5rQZ9VNu1DCEYW1LZlHY6g4tcNWz6b3rxGKM5V
 ZBZhH2ukzaRCEmFAd0qRW5TZfK73HfrPdlUkKqc9bITfOqQe9hadTYT1A18M68XV/AZa37n
 WfYdIDVgdpVlOzKVGORtA==
UI-OutboundReport: notjunk:1;M01:P0:Q0UyGoA0bns=;ZHnkJSjR88eCL+tadRmu/H6emKG
 NQYPpsj5v4PCj42w9BCRrgL/XVHx6paT1fsUxhLJ84+JJ4g0OBhrVLguCS2sirzJvHZklZtTz
 WUa7qCj4xCoWLMrfxNZOHmoS2O/k5LkZxeVNaHzeq8EBDwtzlzScZgDT7ZIzpJHkFm/nt7NxL
 ubNivBY83sSEp/57YsnBFW2zCc+fMKf+7HrS9SFPysQGcn49mMHn75i0ZOiI5tcVlJ6nkcP0I
 0+tuse2C/3n+pu930efKu6d89MLrxnZh6UzFrdJ26W4Rk46awXaNxqEUgKOHVKCtmRzEoMaJv
 H7ThBsjr2Fc2lkBJLE/Ktk6evsF8AQOWEn4y7V48j0CjWcD2D4ujHKzVlj+i0JvpiLjJY7XnF
 D8DMJKU7ERin6OuQGS8Av/9sHBRKKYEh/kMEP7jvdMLIAQNSmSejFM1qbnbwGPNQLGbocJ0Gc
 HKULwcf00VG8SzXS04zmKGRSHRWQqVht6h41t/sogKgpsoR2ZzRt3zSrX9JUbs82wIVeeE6wV
 9Xx8KVWYI3SiLkGjT876q6WWme0akng5camWR16XmC5YobAzVsvNKsh58ESuUyy5swO3sAs82
 N+3oYr/agt/574dQDxQ0FvQYyCY0Dqc/mqfayFrbAIpsRtRZYz7M143XivvBU++1y/gZ/rvZ+
 MlRya0MzulvuvHEzFIulhZ3TmBaEYRpR4EX5qqYngv5mPfT1Z/2Wovp7ArpekUt+zWLy7Bup9
 FyWz2Gb3dcgK5MX19dXbXZnt5Nq7wCD3IuGsyBRug81ZnS7oyy9Wnt1kDEP1veT/ARyw53N+O
 rdmyqd+9HUymtaiGgnYqj/wt3u5/kTHWfv8aYjYcdGbadnlTLlY0j7I9HH+enEPy2l42nF2I+
 RDhqHUzFZPNhjEIQQsdJvaTTno0KgRDD1Ua7cCWow/vobEKYHiNLn8Mkgu+jEJZypJRXat9kQ
 Sa5t5g==
Subject: Re: [cocci] [1/4] fbdev: imsttfb: Fix error handling in
 init_imstt()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1159
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/d0f5e617-4319-37e9-9289-9f486d1061e0%40web.de>

>> Can it be helpful to distinguish involved error codes better?
>
> No.

I find such a feedback surprising.

May the error code be preserved from a failed call of the function =E2=80=
=9Cfb_alloc_cmap=E2=80=9D?

Regards,
Markus
