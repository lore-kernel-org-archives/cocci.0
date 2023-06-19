Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701C3EB64D9
	for <cocci@archiver.kernel.org>; Mon, 19 Jun 2023 07:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hJlelltpRd8eXMFpr9OcMnZGmuRQdbLj57bwE1KRmT4=;
  b=mD+nWC6FZTt0iXpEIVABTFiQauGU7rhO6bOHYQnmtkjqQwfy0myZaUF6
   4n925xcTwKUyrHAc9FSTW27/eSqN+nAdD8Rto3fG1UAwZB2Ca0zywxtAq
   9nIYxMU1VYgDMRIeeKg8U1gHheGyg68T5ZyzV33Htx+aImaZcxOr8hsq5
   g=;
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
X-IronPort-AV: E=Sophos;i="6.00,254,1681164000"; 
   d="scan'208";a="113483335"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Jun 2023 09:42:53 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 446D9E03AE; Mon, 19 Jun 2023 09:42:53 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9F5A5E0157
	for <cocci@sympa.inria.fr>; Mon, 19 Jun 2023 09:42:49 +0200 (CEST)
IronPort-SDR: 649006f8_dz8o9D2EtZMxDE6WYiIZdGTIez0NHKPoGSwGfWRu2JrE/OH
 lkYxjuubKoxBEqzm6/UeS0ZtyX6mwWsGElHK69A==
X-IPAS-Result: =?us-ascii?q?A0GfAACuBZBkhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIudQNTMAQLRwOET4gdhxCBdjGENo53hGiEBIFWFIEsPg8BAwENP?=
 =?us-ascii?q?QQBAgQBAQMEgUyCbUYChX4CHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFA?=
 =?us-ascii?q?QEBAgEBAgQFAQIQAQEBIxcHDhAnhWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBARICDTo/AQICASMdAQERJgEECwsaAiYCAlcGAQwIAQGCegGCJ?=
 =?us-ascii?q?wEDDiMHDa1RgTKBAYIIAQEGnA4fLCJVgV8DBoEVLQGNLoM3eicPgVVEgTyDB?=
 =?us-ascii?q?D6CSxcEGIEIPoNbgmeLLw4MgmeDNIIxAwSLOYEob4EegSJ6AgkCEWeBCAhfg?=
 =?us-ascii?q?XFAAg1VCwsPVIEcUjqBRgICEScTFAVNeBsDBwOBBRAvBwQvCRYJBgkYGBclB?=
 =?us-ascii?q?lEHLSQJExVBBINYCoENPxUOEYJaKzY/G1GBeCUEDgMZKx1AAgELcD01BgMLH?=
 =?us-ascii?q?wYmAR4CKYFXMFh1IySgDAODE4E7IIEtxQQ1B4IwgVuBXQyKE5UJBhMvhAGMb?=
 =?us-ascii?q?IYoDgaSLy6HOpAxII07lRyFQYFjOoFcMxokgzZPAxkPjiAZhA6EYYooAT4/N?=
 =?us-ascii?q?AIBAQssAgcBCgEBAwmFRgEBhgABAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RzyNJE90thdD6yFndou28E=
IronPort-HdrOrdr: A9a23:gwKPz6vfNl6KMi0jFtT7vqwG7skDotV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:yBTQ1m8zqwBiYWsjGlqVv3MQC5pmdT7P8C7vJ0PoLkBrSp6kWHbFrQ==
X-Talos-MUID: 9a23:rQafXwndV02bwWd9vcTXdnpuKphYx/j0GnwSmK5WpfvfLiNJATy02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,254,1681164000"; 
   d="scan'208";a="59080764"
X-MGA-submission: =?us-ascii?q?MDHP6TovW/nzzwlNEiXcsBrLmwC5xGw6b9KE5d?=
 =?us-ascii?q?lT68wqiFFWMEYwjsEVm1SCRSB9aHctuSOgKjE92OUbSliaMPn9aFeUTW?=
 =?us-ascii?q?cdMBoiVtfXEeZSLN7ZWiyw9cueuGLvmcm+L5MxSQZEtjmTnDYPmYTVoz?=
 =?us-ascii?q?eg7xlWavqeG4Q/QzbLNfKvEw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 09:42:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687160567; x=1687765367; i=markus.elfring@web.de;
 bh=hJlelltpRd8eXMFpr9OcMnZGmuRQdbLj57bwE1KRmT4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=FA4xXsCLrVvSbEeEmUUAraJPTSYjAAdEkJwvfgiW9cyZAqi5rkLnQNNxYwmNaQtdoF4AOPh
 W6EUikFUMyiwRkmDB+qP75Htwe0Bb4HnNT+IZ/WZ18FaL0b0JSHE9tV/35ovSJKdSW6a+YR2v
 yY8Sx2KWcmp6gIAB7pHBTFOGwKx5HYjtXg2yBkood+VAbUUCN11lAZosRITKz9w6FNI3AwEx3
 y4xVUjlZ6wfjxdQUf4/YmNA6N6omLKvK4CXd3EP0bMrZ6xfFn8xnTpFMEBbpYLgWCapeYolC4
 h0bgIclk6LGkewx1klmzRSp6+g8eAhobaHPT8VqLozSF2NX2FwBA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MEUSE-1qIMOL1eJ8-00GHPa; Mon, 19
 Jun 2023 09:42:47 +0200
Message-ID: <ea5c0b0b-7aa5-d4eb-def9-fa279d69cd44@web.de>
Date: Mon, 19 Jun 2023 09:42:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Dan Carpenter <dan.carpenter@linaro.org>, Fei Shao <fshao@chromium.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-clk@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Linus Walleij <linus.walleij@linaro.org>
References: <20230617160901.1.I2b151cdf7a72d9e3ecc7ab2ff38409ebe6d65d6b@changeid>
 <71168ceb-8273-4067-d0e0-c6c219d4618e@web.de>
 <CAC=S1ngN=TFQa0Y4FoSCOTUs8HRi4NEP1OwY8WccUEUMG_UDeQ@mail.gmail.com>
 <8366a35f-bc2c-4aee-b2bb-5fc9b2a7072b@kadam.mountain>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8366a35f-bc2c-4aee-b2bb-5fc9b2a7072b@kadam.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yrlfpoD8Hjm605Ti7XMsgkGpx6Lj7lQqYtf7bdHpHIOGcCLN9py
 os9j68Dy6w4KlAkkWQ4B1VQQDRT+RGiWpJOkQNI7VayRjvcTP8BrSgiblxp+5/odwOZvNVQ
 WidZ8j3RYbjoPhuDEgknAmBGCXsIbXtXk8soiEff6yLHNAePAGEVdQINeOajfbkdo/ZdH16
 N5NpWolL/jPswDQl+15TA==
UI-OutboundReport: notjunk:1;M01:P0:EqxcxMXFM04=;PCVP2qZI8cvJ5KPCMJcZ6DRcfM4
 fPpPeIimoHCkL5AteDSIO4icM0sqi0EsK7UOtuQz6CMxEsNpSwFCB1xJ1sxdv8NBGpxhmrReI
 6EVH60VxQPUCt44RH3VlgQr2Wd2imGRqDYWzCsbCv9yHZ2JUrhqOJnMecL+uOt4DMTe4xmj7J
 jbWUizSZhWkbk+ccp21CvlCoP/qM5tsMk4AZ0C545UI8Qd8oFKeNzn0O4fUoQs3rTcc4VydIz
 edKLtYcMhD3CRHI7padjqXA+cmZ/Ifb7Lw0IlYsuP1cooDx3+SuYpN4I7oNbHOHKMUOQJhfUW
 WPdthpD6eXkHMR34bCnN9E+fqUiWOXwTuA35kCqr+nq0g2FjBqcpZtbIJ7DwTq7YkKdcthHqG
 EdqXomqmqL4wV8i2f4E8T5BoiG3OGmFOgU+CGyHpsdJRCDIHChImexHjqgy+KYFZDo0A1LWpI
 JDe5TSbYADc+9mV2HbY4bxiygcj03ek8Z99f9JcxvjONtVYyBlAVZKG/lu8H0RlBR8jBWcXZc
 57pYZ9tPZFW0oqgMkznt2K1l3B6RLlthJBmLE9dPWPG8dPo0bxdekthVzJv7WfrBSLdDm+2cC
 +81+ziEzrucGxd9VoJ3M5liUAuQfKBj7A3lWNCv5o8VC004uRFf8E/z1AjUfp3lkPaUqx1GlB
 adXI3HqtJvx+DgcS6eUjY1ViSCz2rFGnuX9Pf7fi6Pw+kpGLW9ADr5e91zVWdkyA+gG67LVPi
 ttedzdvexWG8oskRmv+tbnMg1VecreCvvob8I7xr1kc8cFcz1B6bcvSCJKZ8/KHYo3NNiy6n5
 BDC3mtnz1Tv8rNL7BnQCtCwMpGa+rYdWqgEdUIu3FIwkrx4CMHsEBnMR/erH8GBs1oYQ6+Pri
 MCzLnimzHqohO9jFUCODyjCYxtzzfUZ7mrxTOvln8OkJrKZ2U8E2qYJM1K5s7GI8j7ay2Y2Ag
 E3vT2Q==
Subject: Re: [cocci] clk: Fix memory leak in devm_clk_notifier_register()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1192
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/ea5c0b0b-7aa5-d4eb-def9-fa279d69cd44%40web.de>

>>>> This fixes the issue.
>>>
>>> Please replace this sentence by an imperative change suggestion.
>>>
>>> See also:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.4-rc6#n94
=E2=80=A6
>>
>> Thanks for the feedback. I just sent v2.
>
> Markus is banned from vger lists...

I hope that such a communication system configuration can be reconsidered.


> He doesn't have a very accurate perspective
> of what is important and what is not important.

I offered various hints for desirable change possibilities.
The change acceptance might evolve in more constructive ways, doesn't it?

Regards,
Markus
