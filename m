Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3165CC87FD2
	for <cocci@archiver.kernel.org>; Sat,  2 Aug 2025 19:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=YSXQ0g4GB3/KQA/hZXZuTdxsB2i22VcQHJ8Q2bpWspc=;
  b=WpoOAJdPlFIz0iitR8H5M/X3i9ev5loHBPATX5Ih8FzdfffKwy2c/WFD
   GklihTWSs3r6ZTNi2R1bdeNB3mVRoS7KL4SF5G9bluKB6g5rvWIvVoQ3z
   GIBNacm8UB9Ms6Zh23PA4GZ8eIziBGX4NJp4W52MKsvL/YGj5UIYi/brW
   o=;
X-CSE-ConnectionGUID: eVX5Ed+4RuGedqS6VpgxVA==
X-CSE-MsgGUID: oF5U2A89TGWgKH/vxq8hpw==
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233971960"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2025 21:42:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 48AB2E0171; Sat,  2 Aug 2025 21:42:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3F32DE0171
	for <cocci@sympa.inria.fr>; Sat,  2 Aug 2025 21:42:27 +0200 (CEST)
X-CSE-ConnectionGUID: 1DeQDhLtQRarVBhHP8eJAA==
X-CSE-MsgGUID: HbPSI1aSQVC3goUZaVChow==
IronPort-SDR: 688e6a22_0Tu4NukG722stWOYWVKWBpiFbXZtirvpz3IgLnHma/NIfQk
 C3/8hSlBICxk/eBEzxNlMxOFRKvOCE4lVx6fXOw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FmAAD3aI5ogA4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgQAGVDMEC0kIhE2IHIc0giSEO48RiHmBVYF9Ag8BAwENSgQBA?=
 =?us-ascii?q?gQBAQMDAYIMgnQCjBoCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQE7Bw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQJHRAEBAQIBIx0BAREmAQQLCxoCJ?=
 =?us-ascii?q?gICVgYBFAEBgn4BgiEBBhABAw4kBw0GsDiBMoEBggwBAQaBRgUNQdhFHywiW?=
 =?us-ascii?q?YFkAwaBGy4BhWyCZAGGJ4NCeicPgVVEgTyCUjE+gmEBA4Feg1uCaYImgRaDY?=
 =?us-ascii?q?zaCM4obggKGblJ4HANZLAFVExcLBwWBIEMDKjQxI0sFLR2BJ32DDYEOhCcrT?=
 =?us-ascii?q?4IidYF5QRk/g1MeBm0PBoEVGh4tAgICBQJDRYFgGQYaQAIBC209NwkLGwY9k?=
 =?us-ascii?q?1SECVlUgTCXCpsJlGM0B4I4gWeBZAyKLpU+BhMvl1IOBpMFmQYijWabOYFoO?=
 =?us-ascii?q?oFcMxokgzZPAxkPjiGEM4ELvCJBNQIJMQIHAQoBAQMJhUYBAYtlgUsBAQ?=
IronPort-PHdr: A9a23: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
 Fg6h1knCdk=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:2MF/oamDBHorq+zYXvMku387HF7pDfL43DAbv31ZSRFFG/FwWf
 re/sjzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:jA3F0mM2Mxqn9u5DAQVqzWIUPtwcSHTH8l3QA3foBERAYejA
X-Talos-MUID: =?us-ascii?q?9a23=3A+117AQ2pgjB1kTfrm3y+lf8WCTUjw66WM2FUmK4?=
 =?us-ascii?q?/heLfOitNCT6jpzSwXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233971953"
X-MGA-submission: =?us-ascii?q?MDE+A8sS4cDER0OXLre3etKBgmuDfPusB+zHyM?=
 =?us-ascii?q?4Ybq1dBtVi9+me6ukWHIEIy2YFi+A3VIRxfs5rvbNP99SuugAbpKpnRT?=
 =?us-ascii?q?YxipFiujP2WqHeEyu9LbZaLLqSwXajVT2CoqNLieV5aXKkqrBeOT5AVf?=
 =?us-ascii?q?MOfOK02hH+0XxIgBBIii0MYw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 21:42:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754163745; x=1754768545; i=markus.elfring@web.de;
	bh=YSXQ0g4GB3/KQA/hZXZuTdxsB2i22VcQHJ8Q2bpWspc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=F5DK4O0E2UKQguAiOxGIRp8TDYrBuGAenGiY/JYPH9ftm+DC++eHWVAg2IqcCVQ6
	 jvXHGaG7PdjbNzwbHqIyoTRW8j//kkoTMnFdtqP/TD4yl+ATGqZ5ObRxmb0GxwwXM
	 wEHvAHA9xxc6PoYy87QIztoDeARoxCS74Fv+U+DoMMq6982p5N3lCt1bl/L8YqZ8h
	 HqrT64icOXT7NOIqJz6QNPlaGn9NBMdZAeXPo2KGM+0TyWpvM02z4H5uCGH3SWNKK
	 EeFToaBO6rSRhO641HC15oooGN+X7IL/3POZTVyLXLeHg2lpbFyfYKRKsktzCy+jc
	 cF5kTLWpqHe6VFvtcg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.1]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgibY-1uALQD2XoC-00mHuD; Sat, 02
 Aug 2025 21:42:25 +0200
Message-ID: <62af4001-9e69-4f0e-929d-f748916c7a71@web.de>
Date: Sat, 2 Aug 2025 21:42:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <alpine.DEB.2.22.394.2508021326250.3428@hadrien>
 <7560a81f-ba29-4b16-b8ed-95cb4d72f3f4@web.de>
 <alpine.DEB.2.22.394.2508021353080.3428@hadrien>
 <e0519749-0043-4cb0-a12d-6a34e2076f58@web.de>
 <alpine.DEB.2.22.394.2508021409080.3428@hadrien>
 <c5042d2d-43df-4276-9611-da4f30763940@web.de>
 <alpine.DEB.2.22.394.2508021502250.3428@hadrien>
 <6239d52e-3213-4083-8d97-9b1f59d2d5b4@web.de>
 <alpine.DEB.2.22.394.2508021745180.3428@hadrien>
 <2130ab11-8ec0-4e57-9a73-5e1ac9e41f7f@web.de>
 <alpine.DEB.2.22.394.2508021803360.3428@hadrien>
 <51664351-746c-4d7a-ae45-2a610ba45176@web.de>
 <alpine.DEB.2.22.394.2508021822490.3428@hadrien>
 <5e8e1f8a-6832-49af-bca5-41d2a13b1322@web.de>
 <alpine.DEB.2.22.394.2508021935250.3428@hadrien>
 <a86ce687-61a5-4e52-92fa-6a0d53db9360@web.de>
 <alpine.DEB.2.22.394.2508022111230.3428@hadrien>
 <7743d469-fc0e-4575-b05d-72a072c1bbb4@web.de>
 <alpine.DEB.2.22.394.2508022133460.3428@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2508022133460.3428@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K4u/Zh6b+xlzn0ZXitEGIRnFBAGtImZizA1kjFXjUQRgugGt9GP
 FqykZYVwPnkH1oyjv0fjvQk0AruGI2YiHdLu0PBy3XPGdS/R/gBeeDavh22BaYS+bGq/UwM
 i/5f1I28ksSzjiNSaPNMFe9AAqfXz+zozeKZJ4ZhDbQ1JvwC74EjmtzKNIsjS15QIA5P+vD
 cQR2HH/HPqehoU8CZPtEg==
UI-OutboundReport: notjunk:1;M01:P0:N+G4d+bQij8=;YnJVmvPqTnbYKXPekYXebCek+X+
 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
 aYtn+WXSswoAeg=
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2949
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/62af4001-9e69-4f0e-929d-f748916c7a71%40web.de>

>>>> It seems that this software behaviour (according to the functionality=
 =E2=80=9Csemantic match=E2=80=9D)
>>>> was not officially documented so far.
>>>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/3aa9a6ab3b035e31=
292be31399b99a8857480aef/docs/manual/cocci_syntax.tex#L1214-1225
>>>
>>> The cited text seems totally irrelevant.
>>
>> I hope that the SmPL manual is relevant so far for the determination
>> of known (and mostly desirable) software behaviour.
>=20
> The cited text describes what happens when a match occurs,

Some information is provided.


>                                                            It doesn't sa=
y
> anything about where a match can occur, which is determined in the same
> way for all other kinds of matches, except that for ... only the existen=
ce
> of a path with the property is required by default rather than all paths
> being required to have the property.

Are there further clarification opportunities?

Regards,
Markus
