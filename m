Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45646C25B79
	for <cocci@archiver.kernel.org>; Wed, 22 May 2024 16:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+BzT3SFXcdFFib4yoshGlzWP6KkIOykLxv+xCjL6B/k=;
  b=E/022fNK5wEAHsXxdUUQd8X2g9Twqgs9is5YossiFNHbEzAQZZoy3sO/
   C4/mJeQF55TBhwklMDlO66l4Y8wDgomsOribLjzljtJ1MjPreNtvXx22m
   WM0pcL4zczrW2JSx+wnbNI/Tu/qTt9HnowhYJLRDMT7swrnnVyS2lUsUr
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.08,181,1712613600"; 
   d="scan'208";a="166937510"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 May 2024 18:06:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6C115E0CCA; Wed, 22 May 2024 18:06:56 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 82B7AE00B6
	for <cocci@sympa.inria.fr>; Wed, 22 May 2024 18:06:51 +0200 (CEST)
IronPort-SDR: 664e181b_kIzNUpr7dKDxuQ+LaxCRgiAT9C7o64YgaFNM2erWkFiIIrs
 uHZlyJz7qaST30t41YrclVmMBzHZ7uQ8t0DAw8w==
X-IPAS-Result: =?us-ascii?q?A0F3CABgF05mhwMP49RaHgEBCxIMQIQTfAZUMwQLSC2EK?=
 =?us-ascii?q?Y9IgXWEa48IjAc+DwEDAQ07BgECBAEBAwECAYFJgywKAmuHWQIeBwEENBMBA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4FCyeFdA2CZ?=
 =?us-ascii?q?wEQdxd0MAIBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQINOkICAQMjHQEBESYBDwsaAiYCAlYGEwIBAYJ8AYIvAQMxBw0GsFWBM?=
 =?us-ascii?q?oEBggwBAQaBRgIMAkPYQB8sIleBYwMGgRouiC4BiUJ6Jw+BVUSBPAuCRzE+g?=
 =?us-ascii?q?kMeAwGBXoNbgmmZfJI6VH0cA1kyAVUTFws+CRYCFgMbFAQwDwkLJioGNgISD?=
 =?us-ascii?q?AYGBlk0CQQjAwgEAxAyAyBxEQMEGgQLB3WBcYE0BBNEA4E3iXMMgy8pgU4ph?=
 =?us-ascii?q?B8IQ2wVg3GBdg5hg1CFLoEQgUeBHR1AAgELbT01CQsbBiIBHaRshFApAoFRx?=
 =?us-ascii?q?iw0B4I2gWCBYQyKIZUjBhMvlzkOBpJomGOLf4F3mxSBfCOBXDMaJIM2TwMZD?=
 =?us-ascii?q?44hGYNhM4ELg1bGFkE1AgEBNwIHAQoBAQMJhUYBAYNagUgBAQ?=
IronPort-PHdr: A9a23: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
 Kc=
IronPort-Data: A9a23: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
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:Vv/jhKiCX5aVDcSFsEuIZGPln3BQXskji2hC6mlwRA09TyX+ra
 2TdZUguSMc5wxxZJhNo6HkBEDiexzhHOBOgbX5VI3KNGKNhILPFvAH0WKI+UyDJ8SRzJ8/6U
 4ZScZDNOE=
X-Talos-CUID: =?us-ascii?q?9a23=3AWKkfW2kV5xbtEPAu4OzvpV0gxjXXOVbg5lnpfU+?=
 =?us-ascii?q?BNUVCFZ/Jdnuc6JFEotU7zg=3D=3D?=
X-Talos-MUID: 9a23:5pPeCgvfVGn/a17O182nr2xLd5hku6SXMW8IrYk3nPetPGsoAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,181,1712613600"; 
   d="scan'208";a="166937496"
X-MGA-submission: =?us-ascii?q?MDGFZ+D79jvcqT6tyLHeDXznOkU8J7grye5gaI?=
 =?us-ascii?q?deqv5skFm1WMGhHG3UkDGkVat/eeBoh8cIrvcExtlw7lmNXXGf2CWZ5D?=
 =?us-ascii?q?hNJFQ1Tmox3BI7mz+cJzsn7gs2TFjvGOnbOEGeDCxZEiY2GJu+BrbjXW?=
 =?us-ascii?q?pVWRVk1lB6DMC0ffn1i8E5NQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 18:06:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716394010; x=1716998810; i=markus.elfring@web.de;
	bh=+BzT3SFXcdFFib4yoshGlzWP6KkIOykLxv+xCjL6B/k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LHOd39lWBz7YTf+7WsxqKwTmBcWBnhqtMPFbIB/h3ZSVUxZ5XxJjSebv14ojgPBF
	 +X1lDT/v3TjvS0d28w4+N5sZ9gsJvNe8Pj4vLAhy119Mwv1sfQ9bFvfxVMZbZNC96
	 rU5aG1/s8sESrpnBnnFQZKkyWvkc7X254soax8s2vjHwzoiS1Eijn9B65yMB0xUJG
	 ObftKejalzuR6sTt9KdM1+HhWGeV23muTOg/FyI45yoichXq0at7Ufm9mvyz6phA1
	 QAz+iuiDOh2ARO4Fo39hNcswA6A8ZUKE3OZzQ7q0TrgvCzyHb5RJkh+4yRkvDQ+EJ
	 X8vvgDRFHZQI2c9vaQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3Xjb-1saBJJ1NZL-010Xc5; Wed, 22
 May 2024 18:06:50 +0200
Message-ID: <c46a86a3-aa3d-4934-85d0-801915c9edca@web.de>
Date: Wed, 22 May 2024 18:06:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
 <594a83eb-b693-4f5b-b330-c0c4cb655661@web.de>
 <9b4af55-40c-3082-52f3-12b4b535376f@inria.fr>
 <0bc588b1-afc9-453d-b79c-151963e88092@web.de>
 <d51167c4-af9f-6b82-9ab8-9a807c98186b@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d51167c4-af9f-6b82-9ab8-9a807c98186b@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0a+5bG+BAJBtIKprSdz/3JY7C8KG04ubzGVnapCMGt5XSGj9Aby
 slEIXSkqTImOE61dgfXW1dHPzRMlIlHKb08oPZjj5i/vGVK5CKjSbzxQKKQy04W7vHb/K8h
 JtYUPsU4XqkPKqH37a2FWzBcSr8P6BPzZ5wwfJ+xB5+3f8ZPn4gZ3OPcRpAbALnppEck8Tj
 O2tHmQbgYhdOXbgk5ly4Q==
UI-OutboundReport: notjunk:1;M01:P0:kX+HaS2a+3o=;T7p9d3EtD3kMdzIkkha7YB45sxb
 G9QrGoKqU6dnrXZf8RunrIOB2u5hqLpqjmayAuNnAOo9nziPd+ovuBCDRl7qsR40G8hRTOXnM
 l9P92AHhAnMdZhKhKUpxKt5UuRBjbpGIGMAKoiHSzjNDqtHIfFD+liNmfcF4BR+Mfkth+lw2I
 IassrAqJIEzzsuNI/mLTjfnbPRngrtYxnRMvlr8Q8F3UEbhQntwLFPQbW49gw0FizhCKkb/EQ
 vPvtIIH9DQnKzKw72xSE4CL1hU/D23QixtDFZqJMhFVI0nujPb1XtvwB76Uef+MLv0puGdXtK
 ug3AnNq63XfmAkkivZ2yjP3GcLgMu8ynMhmmEQcJiOY+RRz6tc77FsLwXOEzEnFzdUcnYzmbI
 Old7HvwzZEBz94dNMlZT5XRhmyulIoiVJ3kvmHVw14JWChtIT+7+fozu3KzbABxHhJhncKWbE
 VTf8h/X8v1Ed/rAEJaXzfGk7Dsm3Xq1ifHkkOULFnl/Nv2Ga5gd3bjK9EHXJjWPMlFAxKEaR3
 yDqhansBd9Jr3Tq4t0iiTejBkDpbrx8Hv0i47H5HIjoBCm354zSUcSLAwkX4MXJ9qlymOzZM0
 c00DZJi18DmBaQspCuI0Tn+cYRFXnl11DYXSHIfBcFNxpKav35QNPfJe/jd4H0gWHslRsfPQU
 iXPd0SdmHfcsc/D3gqTQNejg85oB1REejI3phbz71NMfWNcyx7ueDqdBZ/h9R4LggFqYDsBL5
 NJuGFr/I5eLyorkJjgc8pbcbUxvbEKyvk8CWxTz1q5zQ7ydNAPPjULfmfO3FamfVXQPCadzzm
 RdyyDzvTYjFuoggKKdvN4DFdnWskkiAAL4e4loY/9IZKE=
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1754
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/c46a86a3-aa3d-4934-85d0-801915c9edca%40web.de>

>>> --noloops mean that the back edge of a loop is ignored.
>>
>> Should the program parameter =E2=80=9C--no-loops=E2=80=9D influence als=
o the handling
>> of Linux =E2=80=9Citerators=E2=80=9D (like =E2=80=9Clist_for_each_entry=
_safe=E2=80=9D) anyhow?
>
> No idea.

How do you think about to take another look at further diff outputs
which can be generated by a simple SmPL script example?

Analysing statement sequences in consistent ways (with SmPL)?
https://lore.kernel.org/cocci/4c2812f7-d54d-412b-ac79-c650ceedcecd@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2024-05/msg00076.html


Source files for corresponding clarification opportunities:

* ath6kl_set_multicast_list()
  https://elixir.bootlin.com/linux/v6.9.1/source/drivers/net/wireless/ath/=
ath6kl/main.c#L1232

* batadv_frag_merge_packets()
  https://elixir.bootlin.com/linux/v6.9.1/source/net/batman-adv/fragmentat=
ion.c#L258

* iavf_reset_task()
  https://elixir.bootlin.com/linux/v6.9.1/source/drivers/net/ethernet/inte=
l/iavf/iavf_main.c#L3097

* bch_pending_bdevs_cleanup()
  https://elixir.bootlin.com/linux/v6.9.1/source/drivers/md/bcache/super.c=
#L2691


Regards,
Markus
