Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC67C25B74
	for <cocci@archiver.kernel.org>; Thu, 16 May 2024 12:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=aFxyfGZ3JdszyuLUT1bywfNbcyGIPZ8rnTb5XJTRAJQ=;
  b=FwY4L3ivD716wB6fhx8MFEjekSx4dMh905ybRuLEFqbxSC1WSt18Ck7B
   5gfOTV3wVhcff0BYybxcqM5hkF5g07Tm/Y54DZM7lFrkDFys9J4MCJV1E
   57kce7O0k3nnnL2VIwjGEYsgtty/D0wjWko3/yh5GSlhM+ICLOie7t1yJ
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.08,164,1712613600"; 
   d="scan'208";a="166056565"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 May 2024 14:21:13 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EC795E0CCE; Thu, 16 May 2024 14:21:12 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 24BDEE004E
	for <cocci@sympa.inria.fr>; Thu, 16 May 2024 14:21:07 +0200 (CEST)
IronPort-SDR: 6645fa32_oBy2/m+Xyi1RdJqGFHN7QWEknITcSUtxekW3W1tHbonAOUZ
 YhmcOTYorh/6Z5WSv61fCRS6dqoKF36ffvVo9BA==
X-IPAS-Result: =?us-ascii?q?A0E/AABo+EVmhwsR49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YJDgQBUMwQLSIRWiB2HK4F1MIQ7hzmHT4hxgVaBQD4PAQMBDUEBAgQBAQMEh?=
 =?us-ascii?q?HUKAohBAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBASMTBAcOECeFdA2CZwEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBA?=
 =?us-ascii?q?QECASMdAQERJwQLCxoCJgICVgYBFAEBgnyCMAEDDiMHrzGBMoEBggwBAQbaW?=
 =?us-ascii?q?R8sIleBYwmBGi4BiC0BhXyEQCcPgVVEgTyDAz6IHoJpmhqRE1R9HANZIRMBV?=
 =?us-ascii?q?RMXCz4JFgIWAxsUBDAPCQsmKgY2AhIMBgYGWQYaFgkEIwMIBANEAyAzPhEDB?=
 =?us-ascii?q?BoECwd1gXaBNQQTRAOBOIl1DIMvgXUphB4IQ1oSFYNzgXYOYYNRgUqDAWOBF?=
 =?us-ascii?q?IEyHUACAQttPTUJCxsGIgEdqhcxgSmjY6EgNAeCNoFggWEMn0QGEy+DcgGTR?=
 =?us-ascii?q?Q4GkmiYYiCoZ4FlOoFcMxokgzZPAxkPjiEZhBTFUkE1OwIHCwEBAwmFRgEBg?=
 =?us-ascii?q?1qBSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 4T4qaCojXxXkXLMLPs=
IronPort-HdrOrdr: A9a23:Y5VKraMSv5vSHsBcT17155DYdb4zR+YMi2TDiHoddfUFSKalfp
 6V98jzjSWE7gr4WBkb+exoS5PwOE80lKQFl7X5Uo3SODUO1FHHEGgA1/qq/9SDIVyYygc178
 4JH8dD4bbLfDtHZLPBkWyF+qEbsbu6Gc6T5Nv2/jNId0VHeqtg5wB2BkKwCUttXjRLApI/Cd
 61+tdHjyDIQwVdUu2LQl0+G8TTrdzCk5zrJTQcAQQ81QWIhTS0rJbnDhmj2AsEWT8n+8ZpzY
 GFqX212kyQiYD19vbu7R6c032Qoqqh9jJ3Pr3BtiHSEESttu/nXvUjZ1TIhkFMnAjm0idQrD
 CLmWZpAy070QKtQom4zCGdoTXIwXIg7WTvxkSfhmamqcvlRCgiA84Eno5BdADFgnBQye2U/Z
 g7rF5xjaAnfy/ojWD4/ZzFRhtqnk27rT4rlvMSlWVWVc8bZKVKpYIS8UtJGNNYdRiKn7wPAa
 1rFoXR9fxWeVSVYzTQuXRu2sWlWjA2Eg2dSkYPt8SJ23xdnWx/zUEf2MsD901wgK4VWt1B/a
 DJI65onLZBQosfar98Hv4IRY+tBmnEUXv3QRKvyJTcZdA60l722uDKCe8OlZ2XkbQzveQPpK
 g=
X-Talos-CUID: =?us-ascii?q?9a23=3AMIHxkWujzSjuR+uPyPmyYb7B6IsrKSPT5kyMBHO?=
 =?us-ascii?q?3Ij1ub5qMQ1ad2YVdxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A6/gMyg9P2mJ2+KK0mB+y13KQf5hr4oGkEVsdqL8?=
 =?us-ascii?q?H4NKvEjI3OzKElzviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,164,1712613600"; 
   d="scan'208";a="87220707"
X-MGA-submission: =?us-ascii?q?MDGXkomsCMzOB6RkOsKE1cv0bsrOq+TLKmLZMd?=
 =?us-ascii?q?hgBeEPb7DzslI32ih/OiILAikTc1MO1OQh00af8rGU+CHr8HegDr1WDK?=
 =?us-ascii?q?WhmytivHtYBzdLlaGX1lkAYeOiqP4Q+AmvQf91vQ47z179fMO57jxZN0?=
 =?us-ascii?q?Yt+/OKuUyOXzQH1f7HpHoi1w=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 14:21:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715862065; x=1716466865; i=markus.elfring@web.de;
	bh=aFxyfGZ3JdszyuLUT1bywfNbcyGIPZ8rnTb5XJTRAJQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gGiJkhyUlara6kC7WZm4W4H1iChQcdQXDIziWgxaGCAgFBJ7/Fkb+e+l9qbdN/EV
	 A1tCrhwZBTcp89DnMI/D92Faa8rzEz0h7FG+o3KBcFdru0z40xek7WFc29Z2JDL6q
	 QPSzejzutsUAgipBWMPjG3q0A2T8NixB8e4wctQGJY2ubOrPgK5nqzqLOxU8wa15X
	 6HWfElGtAe2RZdeW8LWwOcBBwu0XfCJQ4O3bTEDGGQCMeXKRhTUEyC/kFd61WXFxW
	 m4eSsnnXAHguQdIRPpq6Gca2r3Sapl+jhhhnARn3jl5bTMP4WwT2xNSTKVVj17w3r
	 xKVAhvUUzp8law9oZg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MiMAO-1skTcl1SD8-00ii62; Thu, 16
 May 2024 14:21:05 +0200
Message-ID: <c86c44fa-8b46-467e-9cf0-07e5c951e976@web.de>
Date: Thu, 16 May 2024 14:21:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <48e0b9a3-dfa0-4e39-b049-93faa76c0735@web.de>
 <d65aaff8-48a0-c670-fc16-abc97415a99@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d65aaff8-48a0-c670-fc16-abc97415a99@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:grbnBV8Vt5dzJ1YFGhIqUnHJI4wz1WD8CntMH3txzvVynf6l5wm
 io1M046m7KjtnTtUiUdf0KTpxnU+RpD+Jdv2ySPthuRwGaQvvnfXyAxYliDlTxbIyo1nuhL
 HKtwlzgd4Y+i2Ma6EHwhhBy07soeN0BS0gGPj9+1xqDf+PRQX7yqOtlH7Fiou0MscYUMJXr
 Y6oeG7tddKu1DHOZAe4Gw==
UI-OutboundReport: notjunk:1;M01:P0:Duwlv5frcqI=;eH/gvLTEN9/KrLTyffKzYm+auL9
 StFjBnVoMiHVFI1Fczueyh4XfqzmqaCK0MrHBoMD0/30m127YVU51FYu+Z7Z6hJJFoK2ZyzOP
 k0PPou2+KKn/D6OxNIz5lSG7B4tm2F/lBlYJ0jRBbsHhB+rhE/bmxE3DAY1ENJxwMuly0i6wv
 AN4RCGe5crQ4zxW2ef1ln4aUvM/28qPVZbLK3uIDhHISjYKsdgWWc0YmnkCWQTTLdWqyWerRo
 G8e2EjSGkLur6wJphEXFSecTD9Dw5NI4KXRCIgqyd/4eFbFgRd1p/zpOz94/qEsTRGwnxFQsQ
 9Qm4QF85iZVxc4K2XLSINMynP9pgRceHsXj6b260kNrYnE/4FDYKOWhrWVwuBNicueOYBtFQj
 a8KCJlbPEU2v6mvp+7D2BWxByC4SeaEm0yhzvgauYPrLvILZaD0VmfoJzwNx5oC0G/jwS3zrG
 m9LuSpV5++1mJA7/AgbDTnRps/Cs39W078XWN81Nd+Y8DWewgmkJ7gMSz5VSbweBeXaVAbb8X
 CbQIJIb4b224VIpKpzVAwrAeK/wiYfLPRrN8KHZ72XHSN/nxYKPNWGS1FnFx13woQ/3twzBf6
 176+h/m+p1gVJKPNAIJy9EwcSmXQHkB9Dt5K7MCzVNBCMejLGw3T5ki+yvEHjy6GQ0YRG1pzg
 GkTanxn+WaNCyR19911lszQOPr8cp3ElBgjsFwVv//6liP+ai0vt9PMfhJwK/dm4HIyR/4Xmd
 NPqTajCfVqP5XqRZA213Udz6gWBxO3QzACKC6yD8aW3fhOx7/dnWuAnNb/pHDxlZ18e+dJ23P
 86sE+Hxc6YRTHWGN4rXceXT6fZ5jtYKvILDsav3MHEKXM=
Subject: Re: [cocci] Checking CTL code?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1745
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/c86c44fa-8b46-467e-9cf0-07e5c951e976%40web.de>

> On the other hand, you can also hand write CTL formulas and pass them to Coccinelle.

Would you like to extend descriptions anyhow for program parameters
which would be relevant for the handling of computation tree logic variants?

Regards,
Markus
