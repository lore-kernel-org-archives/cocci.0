Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EE6CE8E91
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2024 16:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/UdPgsxguQGzR/aVOXyCsU4EJwXt5NyRInBIRdXvqvM=;
  b=tECqPfEME6d+ZaT06/OYenkrjG/Wa+o9BV2atGnrE4KOYntRj+On6m43
   vpMEz7/NO8DOd1ry5VO8FjSgT3ORgpk+rRdIqR8oTHZeLrOANpvUSWgDS
   zhpGlhTd80eHV6yc2vHRQkLvvl1NaeZZK16JKr+SeBegx7ceVE7RBQrCv
   I=;
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
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190606186"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2024 18:28:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3BC51E0D1D; Thu, 24 Oct 2024 18:28:36 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C215EE0133
	for <cocci@sympa.inria.fr>; Thu, 24 Oct 2024 18:28:30 +0200 (CEST)
IronPort-SDR: 671a75ae_bW5uVFp0s/R+U/tpgfUkoukhBbE456LMKqJBqPimDQVnzYz
 IQ09NHWO9yE21GNb5vEEiKmUas9zeriC5lx1GZQ==
X-IPAS-Result: =?us-ascii?q?A0EHAACfdBpn/wwR49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDB1sbWjMEC0iEVogdhzCBdDCEO48OiHWBV?=
 =?us-ascii?q?oF+DwEDAQ09BAECBAEBAwMBggyCdAKKJAIeBwEEMAkOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBARABAQUBAQECAQECBAYBAoEKCAuFNUYNgmIBgSSBJgEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAkdEAQEBAgEjHQEBESYBD?=
 =?us-ascii?q?wsaAiYCAlYGARQBAYJ9AYIvAQMOIwcNBrAggTKBAYIMAQEGgVhB2EIfLCJXg?=
 =?us-ascii?q?WMDBoEaLgGFaYJiAYVZS4NCeicPgVVEgTwLgng+gmEBA4Feg1uCaY43g1KHb?=
 =?us-ascii?q?Yw+JW6EBo19UnscA1khEwFVExcLCQWJNQqDHCmBRSaEEQiBKxOBG4JEgWcJY?=
 =?us-ascii?q?YdlXYEMgT6BWQFGgnJKg0yBYQU4SYJNak43Ag0CN4IkJFyCT4ElBAWDPIE/H?=
 =?us-ascii?q?UACAQttPTUJCxsGPawGgVlHgl0dS1mhI6cSNAeCOIFlgWMMiieVLgYTL4Nyk?=
 =?us-ascii?q?04OBpJ4mHcijVubIzWBMj2BWTMaJIM2UgsOD44hhC2BC8h6QTUCCTACBwEKA?=
 =?us-ascii?q?QEDCQGBVYNwAQGJWYFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:cMPCUqOzxSb7mnvvrR2KlsFynXyQoLVcMsEvi/4bfWQNrUomhTMHn
 GQfDzzQOquMNjf0c4p3PYq38UIPv5/XzNdjG3M5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8mk/vgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5OZYQbNNwJcaDpOt/vb8k835pwehRtB1rAATaAT1LPhvyJNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1j6xE78FU7tJo56jGqE4aua60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/4iT8sSq9ZeeSUVTv/B/wGX7cEG3nORcJXgNIM4687ZtGG9S1
 eUHfWVlghCr34pawZq+TfRwwNsuJo/nMevzuFk6lGufV6x5B8mcBfyQjTNb9G9YasRmOP/EZ
 NcCLxdrYg7BZRJnJVodTp4z9AutriCuK2MA9gvK/cLb5UDhxi5TyabuPePFUdWDSptf2UTE4
 V3vqjGR7hYycYb3JSC+2nmrjeTOtTjqXZobUry+7P9jxlOJrkQXAQIfUV+Ts/i8gFS3HdNZM
 U0dvCQ0xZXe72SuScThGQK1qjiIs3bwRuZtLgHz0ynVooK83upTLjJsopNpMbTKaOdeqf0WO
 l61cxfBADtyrPuKRHjb+rr8QfZe/8QKBTdqWMPGZVJtDxrfTEUbkR/FCNpueEJwpsOgAin+m
 lhmswBn74j+Tqc3O2GT4l3NxT6hznQMosjZ+S2PNl+YAshFiEJJqmBmBZU3LRqNEWpBcmS8g
 Q==
IronPort-HdrOrdr: A9a23:sqi7CqNw9Sj/TcBcThWjsMiBIKoaSvp037Dk7TESdfUnSL39qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:MyJLL2FIMf8t7RSoqmJa93RPRdEXW0Tm0TTyKh+iEGh1aKSKHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AytQ/tg+f0sWOvldxZJN3sJiQf/ViwYa3FkMAqIU?=
 =?us-ascii?q?tssCLayY3OWvasx3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190606170"
X-MGA-submission: =?us-ascii?q?MDFv19Ws4JxvWcpAb1VOCjTR4R6V7n0vnS7dai?=
 =?us-ascii?q?+oul2IaY/TSPk9ZxMxAK5K0ZK4nhlRZipf/SOodMcI+unMfQJ+bnQy6g?=
 =?us-ascii?q?hMklgZWe0wDUVJ9Res7zN2Q9viV/OTJNpIoHfPlJ4ixbC9gc3ZWkZBuW?=
 =?us-ascii?q?fOuXPc/2KuPVj1wM75vDFiTQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 18:28:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729787300; x=1730392100; i=markus.elfring@web.de;
	bh=/UdPgsxguQGzR/aVOXyCsU4EJwXt5NyRInBIRdXvqvM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mk7pZlCMFKnwku3U1mdxz5QXr9if4E4o6oL+gc0Rvdw+wuTvRGtW5m+1EcW5gZxF
	 aj7O0iTTxm1zQUFJlOrOHaRWD16K0sfg1CD+oZgcSDwpEugXoJUkHKFY807Dnd486
	 IaqtPMGp0LIJtlvcl5YN0cFrXuu5rv4+mOFGfzr7V8YIm00rAJOwrOOMuybiZwHo0
	 t+vU9OmRyxHVmen8QcwaNi9lGCs7ART3WE+ByZRvNrRkmizZScrfB0X0oUW1s59pP
	 cko82bpZNxtmZI7LwqXgtvddiPwQ0kR0kOboPOPNNkEzn0aw4hzZP/PjRl3xpQzQE
	 uJT8NQCINUCgj8nMbg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCGSW-1tCE9h44DC-006P3g; Thu, 24
 Oct 2024 18:28:20 +0200
Message-ID: <5db2ee72-568c-4134-a2e7-59660164be2f@web.de>
Date: Thu, 24 Oct 2024 18:28:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: "Derek M. Jones" <derek@knosof.co.uk>
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
 <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
 <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
 <bd7afa99-024a-4543-bb72-0db2282943d4@web.de>
 <alpine.DEB.2.22.394.2410241818100.3352@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2410241818100.3352@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aY2zETQli0TQas1yU/rm4EhKqCMoiN3fdFAiiOGJKBeg7H9xyob
 9rA0GSRPk5lQD4//kGKK/AKh8P7oqQoPBtA+O+0KMOwARxttzFf78aiDP+ml6ALbYwl7vjp
 WIg/lCMpFImswJr/5kC/htS3SBNkRUXI2gNXk3YeOzWVVPmcn0tHoi6CeYlhO7lca1wkhKx
 1FKuTuCcG35D8qsEhu0JQ==
UI-OutboundReport: notjunk:1;M01:P0:KTkrxaGJdEw=;ScIXFDbQJSScQYu4qNc6MmmZwjM
 DCyqy2aR+j+3ZjwEWwyBstKW4a9mImT/x5VqOxKQ2U/DkzPeSAH+iZMsdZwL/XyktqPIAzo4C
 sc/7xXMIZAb4JkaNqQ33NSZFKELRnX36lo3ap6clvkKJOaD42upFLmMm/dwFnwqm/Auc6VJY3
 8apTqHHgNeunzrvy/HnpG1bJhbz0+GVf7eXafG93uTjahdjYYkbLnIlkKlNdMHIFbbUok2dhL
 RLbaMpekm3gq3ZqZLp+zuUV78R5cv8hxFjkBVlItgFaglNIOXD5X3vqTXp1R+jPMG/yDC86Ax
 vLoFnVLDTqWsOdFhAg3sX+JF5+X6ZLajbSqydSA3BFxDJBkug3bv6hvmNFcegntzIzpn807Dk
 UJNgwVzkKoFbdWwG/JsTuq3j+TuUvCw5DGLzukxYc2uuyWZgFsE3f+IbKaEBniQGxhyYx4Ilg
 rKfDQRVPMH5592tY20U4O1STkqogUqX5OFoQL69AbsS8aIYQK39uj80WTh1IV/H2yl99yes4o
 X9wDoon4PMd1sPwYfqTzVrehOm7850R04Q+vBgReEsmgZ3ltEutbO7EUN2Kwa1dO8hGd56w35
 twAkaoz/tVVdYARYn68kiREJ2gDXgF7HUBhM/d3WPO41IGCzK5OxKL057i+/Jl+z2lKBNziUm
 iM5nR6KGcLkH6SK4do4gRxkVnyHcP9FDkEAI3SFS2f4Ew0ILk4OxoT/16h1I3GgW2SDVSr2vP
 +xu5Aj76M1BPkEdM1QKJ63l2PMfEnXEEvF5l9tgPBas52+SKKF60L49tN0BdT5/mgVHbLRwW3
 4+Ie6v2NnlebrU6RHFj9jWCg==
Subject: Re: [cocci] SmPL position variables =?UTF-8?Q?=E2=80=A6?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1932
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/5db2ee72-568c-4134-a2e7-59660164be2f%40web.de>

>>> Every position variable contains complete information about the enclos=
ing object.
>>
>> Will such information trigger any improvements for the software documen=
tation?
>
> man Coccilib already shows the information, at least in the OCaml case.
Can the information representation still become nicer anyhow?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/7bc8a7acf4673a3143cae=
7aa00ef9374c9fdf893/docs/Coccilib.3cocci#L36

https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/7bc8a7acf4673a3143cae=
7aa00ef9374c9fdf893/python/coccilib/elems.py#L1

Regards,
Markus
