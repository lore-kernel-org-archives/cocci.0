Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D93FC433FE
	for <cocci@archiver.kernel.org>; Fri, 25 Feb 2022 15:30:16 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,136,1643670000"; 
   d="scan'208";a="23255358"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2022 16:30:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5A7E1E0B4F; Fri, 25 Feb 2022 16:30:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 537B3E037F
	for <cocci@sympa.inria.fr>; Fri, 25 Feb 2022 16:03:59 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=Johannes.Schindelin@gmx.de; spf=Pass smtp.mailfrom=Johannes.Schindelin@gmx.de; spf=None smtp.helo=postmaster@mout.gmx.net
IronPort-SDR: vRLLE33X8O+0ogRjDVI2QCPp3z2MUjVVdjIWULrFKAc58qUlecyOPpTsLRU2fgISPTPlN/63c4
 VC/JyS5gSDTvzE8er3KxSxmpoFjJ2UzcSWXCe1fRx94gD40pXp9b9g3esJHON4xz17MHjdu5/o
 Jx4mIGZMhMj2noKYful09cIvtpY8GbBuLWTRdIlpyIkfOQ/Z3YQdGPk4LLnHbyaDez5oDJid6x
 G/LevsZg4Ypdw+o5J2eJBhUCrSWPP0G3IFKD4XWj7KoINN+CfObB0XfuIq0jO9DsiPCnwfg949
 APttzFkDfmUrgaZvuOOxYTTr
X-IPAS-Result: =?us-ascii?q?A0AJAQBb7xhihxUR49RaHAEBAQEBAQcBARIBAQQEAQGCG?=
 =?us-ascii?q?oIogVUrBAtEhFSOcoIliyaRS4FoCwEDAQ0+AQIEAQGFBwKEDAIdBwEENBMBA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIDBAETAQEBDA0JBQgKBw4QBTxka?=
 =?us-ascii?q?IFPgXQLNA2CNSkBg2QDAyMdAQERJgEPCy0VAgJXBoMXgmUBAzKjVIsygTGBA?=
 =?us-ascii?q?YIIAQEGhEcBSwNxgVsJgTyKB4NDeicQgVVEgUiCdz6DfoEGglmCZZUSCCArL?=
 =?us-ascii?q?xuBaRlBHj2VEYwgniw0B4IRgRkhgT8Lnk+WSZFQllGBJ54Kh0OBeIF+cYM4T?=
 =?us-ascii?q?gECAQINAQICAwECAQIJAQECjh0MDQkViBSGBkA0OAIGAQoBAQMJhUcBAY1EA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 RYUk+uQEA==
IronPort-Data: A9a23:8hr0rK/CVNr41cnVkdJQDrUDjniTJUtcMsCJ2f8bNWPcYEJGY0x3x
 2BOCjiDOazeZ2r3KNh1aNzk9xgHvJ/dzNFlSwNor39EQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHvylYAL9EngZqTVMEU/Nsjo+3b9h6mJUqYLhWVnV4
 4mv+5e31GKNglaYDEpEs8pvlzs05JweiBtA1rDpTa0jUPf2zhH5PbpHTU2DByOQrrp8QoZWc
 93+IISRpQs1yfuC5uSNyd4XemVSKlLb0JPnZnB+A8BOiTAazsA+PzpS2Pc0MS9qZzu1c99Z9
 41L5ZGCEA0QPPfcusEhUUNEESNUBPgTkFPHCSDXXc27ykrbbz3jxuUoCkwqVWEa0rwuWycUr
 6NecW9LNEnra+GemNpXTsFOgcQqKs/mJ8UksXFhyz3UCfcgaZ/GU+PG6Le02R9q3ZoSQquHO
 aL1bxJFXB7+QBJGAm0bFbUgse6Erz68bQBx/Qf9Sa0fujWPklUojtABKuH9cduBTsR9hVedv
 muA/mLjAxhcOsb34T6M7XuogsfdnCbxQotUFbui9/csjkf7+4AIIBgRSEf9rvypzEizR7qzN
 nD45AIR9a5i+X7yROD/BQ2ahUKG5AIeWfBpRrhSBB629oLY5AOQB24hRzFHacA7uMJeedDM/
 gDQ9z8OLWM12IB5WU5x5Z/J9W/pY3R9wXsqOn9dHVFtD8zL/dlr5i8jWOqPB4aZo7UZ8xnVx
 DaWpSI3mq97YSUjivvnpAivb96EnJjETwgx7wPbG1qr5wdrDLNJiqSt7kXHq/lFPMCfQ0XpU
 Jk4dyq2vL5m4XKlzXLlrAAx8FeBuazt3Nr03wUHInXZ327xk0NPhKgJiN2EGG9nM9wfZRjia
 1LJtAVa6fd7ZSX2MPArO93uUphyk8AM8OgJsNiLP7KihbAuJWe6EN1GPhH4M53FzRR9yv5hU
 XtlWZz3UC5FYUiY8NZGb75AjeFyn35WKZL7HN6ihxWhzbeEYnOJAb4KWGZinchphJ5oVD79q
 o4FX+PTk0s3eLSnPkH/rNBPRXhXcylTLc2n86R/K7/YSiI7STFJI6GKm9sJJdc695m5Y8+To
 xlRrGcDlAGg7ZAGQC3WAk1ehETHBs4u/SpmZnV3ZT5FGRELOO6S0UvWTLNvFZFPyQCp5acco
 yAtd5rSD/JRZC7A/jhBP5DxoJY8JhuulUSCMnP9MjQ4epdhQS3P+8PlJ1e+qnNRU3Dv7cZu8
 ae90g77QIYYQ1gwBsjhbv/ynUi6umIQmb4vUkaReotTdUzg/ZJEMSv0ivNrccgAJQ+dlDSfx
 0CaDE5A9+XKpoY09vjPhLyF9tv4TbEhQxACR2SCtOS4LyjX+Gan0LRsaufQcGCPTn7w9YWje
 f5Rk6P2PsoBkQsYqIF7Cbtqkf8z6taz9b9XygNoQCfCY1ixU+kyJ36bwY9As70LwLJF4FPkV
 kWK89hcGLOIJMK0SQVIe1t7NryOhaMOhz3fzfUpO0GmtiV5y7yKDBdJNB6WhS0BcbZ4bNE/z
 eE6tJJE4gCzkENwYNOBkzwS+GGcaHoNT/x/5J0dBYbqjCsty01DMMWHU3CnvsnXZoUeKFQuL
 x+VmLHG2+ZWyH3EfidhDnPKx+dc2ckDtR0iIIXu/LhVdgcpR8Pb3SG9NRwySRlJiBpCw6R1N
 3QD24iZ40mR128AuSSBdznE98J96Nmx9UnhjVcE/IEcZ1f9TXTDdQXRJs7UlH30MAtgkvxz8
 7SIjmroOdovkAcdwQNqMXNYRzffoRCdO+EMdA1L3yhIInXiXQfYvw==
IronPort-HdrOrdr: A9a23:/uQo36iObMqjE97HbxIZ989JiXBQXgAji2hC6mlwRA09TyX4rb
 HWoB1/73TJYVkqNE3I9eruBEDEewK/yXcX2/h2AV7BZniChILAFugLgLcKgQeQfxEWndQttp
 uIHZIeNDS9NykcsS7gijPIa+rILeP3i5xBvI3lvg1QpYoGUctdxjY8O0KgHkp6SBIuP/QEPZ
 CXj/Ammwad
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,136,1643670000"; 
   d="scan'208";a="23247516"
X-MGA-submission: =?us-ascii?q?MDG0Ofht3HlwltKiQ9L7MSS/SglTdQk9uuQhBp?=
 =?us-ascii?q?1ZwH/Z1e1Pk3voBM7s0ZIjDsqzfVDHytvOyRBatoH5dOAjR9QVB1PGLz?=
 =?us-ascii?q?SgW/7CO6FeVGaNirrP+eGOTMAu5B9TeZhNGiKGMQ738Z2gHXTJkNTs7J?=
 =?us-ascii?q?EzmGa7wIrjP69eAt17BEb+KQ=3D=3D?=
Received: from mout.gmx.net ([212.227.17.21])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 16:03:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1645801437;
	bh=NeE9FyxvssWJUy5bMvKsfR7FglpJ5n2/hZqSFxnSCg0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
	b=NWuq5U2+zAqWPW1L0M+T4DFkcBMwP9BzAqlGTB39nTMg4/6hmpZoyjkUeMPNKBXPf
	 xfH3loD9iX/fHZXLkIvW6/SAIufrENnZDiM0MVO45Ecd5PkWnuWyEr7+/NkO9KSou8
	 qjgXtg/4Y2lybhjhxPeoRo0Bht4bIpUvgD5Lw9Ok=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHXBp-1nSGq42JCD-00DVXH; Fri, 25
 Feb 2022 16:03:57 +0100
Date: Fri, 25 Feb 2022 16:03:55 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: Julia Lawall <julia.lawall@inria.fr>
cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, 
    Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>, 
    git <git@vger.kernel.org>, cocci@inria.fr
In-Reply-To: <alpine.DEB.2.22.394.2202221436320.2556@hadrien>
Message-ID: <nycvar.QRO.7.76.6.2202251601040.11118@tvgsbejvaqbjf.bet>
References: <220221.86tucsb4oy.gmgdl@evledraar.gmail.com> <20220221173357.8622-1-chakrabortyabhradeep79@gmail.com> <nycvar.QRO.7.76.6.2202221152230.11118@tvgsbejvaqbjf.bet> <220222.867d9n83ir.gmgdl@evledraar.gmail.com>
 <alpine.DEB.2.22.394.2202221436320.2556@hadrien>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1687200457-1645801437=:11118"
X-Provags-ID: V03:K1:s5ntb5VsLNKSNojXg+N/+x2yMHxWS8FysZL6UoDT+S1QjOoFDNM
 ImrHj/jN50UKGPFp9ngr/xAB0q70GYVBou9QUKd0KpF+pwJtHiXreyDNQcEXstgIc54UEEm
 bXalHW4MBvuUMispSi32vsDSsChY73BZigQlbiBEFANlIguT2HzBScuGD5wZQ3l7ZAZDVvR
 DkplhiEkOdnT+CLpSuiRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q5Ik57tstAs=:40eb6fueA/mjwERCyqL2PF
 vaTXJzM+h/wHdfon7iSeb5w6fRGeoTB2fyyc2gUY2yRRnXX1j48GP3qBmZlm59aPTY53sdbKl
 eHjuoAh3Z5XTc8R79uOJ02psmqn1ic2Ol9jY48jt7Y9va85kA6VeGcHSee3gLTZI5QM4XPVC4
 /uvuqcOcsJjx5n7MulN8rKVwIzc7bdNRjWG4OMZaFpyj1Ayi3bR5ad97BF/bVaCFv7SE7r//k
 LXcP0+TuaEhob0KmSsezlIseKU0Im3MmE3/X7LTOlFpE9JRJXcEiaHeqadQ2ZKiLGCD/18F4m
 ATm90sArArG4PRDKYJhME4jHgKtAtX2DBREBk/Aa9qeHnZtT/otinJT+91Ckrj6u7yiK2PYnv
 kWcV/XiU7l0gBXA+5pB+trpwK9YkhZ69DDEkklYYzTGGBhx9nKfAzvUNeHKrOZ3qDT5MHZgBl
 N0Oz3Qr1olipJF/m80gwLrVg1IkthJEHHQ32PRHrUbscJIX4Q2DjiME8hT0M98bwWJ1CbgpG8
 bfhNgkMJ9FYgwbnEncQH0Oso/AlADkR9WKcE2T5nSaW5sIF5RHOQRImb/5s2p+im1qn2M4I4U
 0hWVuQfXBH3XFBPVtfNu8E42pPqEFGulI/Sa1ZGwFyxmtW970GqAOGGbuS0YlidPAD4GlC9L3
 QVEdvS3cldQWNiVbTeSYBrVxHA2zkErXk2VI0v8ipPBiJbSeFvhb45apYlYoERzQjcjOmx0uN
 F7eu6+vvjhqjUbD7yRCqBhnEviddK5hRPby4Lsu6eOcuB3lpLP/pJHmEFtjYYwZJj9iJ4VfSu
 HWMIiQwWVagBFr8Rl8iIM4h2PoGF4ilYHk7p4Cy/VVOef7ICm4HUagPQ/+Upt2Y5XU6IAR7rg
 7ZN+fsh6kcoLrr6FtNTkJj5nbHm/e0v9XxeqnUjdgryhgAHXF7XyM8ezCTVOOZmqouv/+VIsQ
 E5WN2vzhydx7FxRSR6UGYQkhZA2U99rRiIp4rXzURG0VpWNtrynz/7bjRn5zh45XC6oRQtMo4
 LVOYG7insxzwJzgXEym08tuqlf29+d1dZSY381hOYJjh+foHR5OO/o6ONWOHLZheAyhXI4oGj
 BbbvNmsjzDdGE0=
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] add usage-strings ci check and amend remaining
 usage strings
Reply-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Loop: cocci@inria.fr
X-Sequence: 152
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/nycvar.QRO.7.76.6.2202251601040.11118%40tvgsbejvaqbjf.bet>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1687200457-1645801437=:11118
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Julia,

On Tue, 22 Feb 2022, Julia Lawall wrote:

> [I]f there are some cases that are useful to do statically, with only
> local information, then using Coccinelle could be useful to get the
> problem out of the way once and for all.  Coccinelle doesn't support
> much processing of strings directly, but you can always write some
> python code to test the contents of a string and to create a new one.
>
> Let me know if you want to try this.  You can also check, eg the demo
> demos/pythontococci.cocci to see how to create code in a python script a=
nd
> then use it in a normal SmPL rule.
>
> If some context has to be taken into account and the context in the same
> function, then that can also be done with Coccinelle, eg
>
> A
> ...
> B
>
> matches the case where after an A there is a B on all execution paths
> (except perhaps those that end in an error exit) and
>
> A
> ... when exists
> B
>
> matches the case where there is a B sometime after executing A, even if
> that does not always occur.
>
> If the context that you are interested in is in a called function or is =
in
> the calling context, then Coccinelle might not be the ideal choice.
> Coccinelle works on one function at a time, so to do anything
> interprocedural, you have to do some hacks.

Right. The code in question is not actually calling a function, but a
macro, and passes a literal string to the macro that we would want to
check statically.

I did have my doubts that it would be easy with Coccinelle, but since =C3=
=86var
seemed so confident, I tried it, struggled, and decided to follow up with
you.

Thank you for confirming my suspicion!
Johannes

--8323328-1687200457-1645801437=:11118--
