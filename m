Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23CFD7360C
	for <cocci@archiver.kernel.org>; Sun,  1 Dec 2024 09:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xrsgbRacmQAcEJBIo1Q985jAeMoPP4cVhmgI5CqX0eY=;
  b=vWZ0nz9/axLXIW3oz6+V5SV3YVVyzBt2FsCV+aLeir+kj48DzftNT0FP
   wFVjBBNpj/HuCl3/XQD4XDAMkNKccQ0GDFltdznTJPebHcyJDgty6VaLZ
   KAPwL7nEVS5SEas9W3O39GcnR8/chbNJ9mzWwOu3r8gl850eQCeIzXIt+
   A=;
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
X-IronPort-AV: E=Sophos;i="6.12,200,1728943200"; 
   d="scan'208";a="196671404"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Dec 2024 10:08:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 47EFEE0133; Sun,  1 Dec 2024 10:08:35 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 03C4AE00B6
	for <cocci@sympa.inria.fr>; Sun,  1 Dec 2024 10:08:28 +0100 (CET)
IronPort-SDR: 674c278c_VKaRJhOjzUvOkmtE6om7emFw5ejQmwbahfu+rz9tjb9+p6G
 dQLW1C7fW4vLZoWAuGX9nR2vuZG/Ebal2Jh55YA==
X-IPAS-Result: =?us-ascii?q?A0H1AgBBJkxng07ASNlaHgEBCxIMQIFIC4JEYiFUMwQLS?=
 =?us-ascii?q?IRWj02BdDCEO4c7h1aIdYFWgX4PAQMBDUEBAgQBAQMEggyCdAKKYwIeBwEEM?=
 =?us-ascii?q?gcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEhGQcOO4V7D?=
 =?us-ascii?q?YJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBEScECwsaAiYCAlYGA?=
 =?us-ascii?q?RQBAYJ9gjABAw4jB7EIgTKBAYIMAQEG2lsfLCJXgWQJgRouhWqCYgGGJIQ8J?=
 =?us-ascii?q?w+BVUSBPIMDPoRDg1uCaYJCgTqBLIIpJYdzJWiDfoZwgmKESYl0UnscA1kyA?=
 =?us-ascii?q?VUTFwsHBYEpISwDgXlOf4E2gVEBQoJOSoMugV4FN0eCSmlLOgINAjaCJCRZg?=
 =?us-ascii?q?k2BJQQFg2mBC4NehF6GLEIdQAIBC209NwkLGwY9ohSDRoEVgmmTHbJxNAeCO?=
 =?us-ascii?q?IFlgWMMn1oGEy+XQw4GknqYeyKpCIFtATOBXDMaJE+CZ08DGQ+OIRmEFMYaQ?=
 =?us-ascii?q?jU8AgcBCgEBAwmFRgEBjEaBSwEB?=
IronPort-PHdr: A9a23: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
 XmKxjaPi1Shj/XJ1TdtFhZD+G4juQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:EN0S96nPMXwWuYkZVBacsOm2KCHpDfLy3DAbv31ZSRFFG/Fw5P
 re+cjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: 9a23:UyicJG7k8ZF0pzwLOdss03BEJ9AJTyzm7VTvOWCSE2ZwRr6kcArF
X-Talos-MUID: =?us-ascii?q?9a23=3A7P6b8w53DN1tDt9PWYqsRvZxxoxM2LmtJWkPl6l?=
 =?us-ascii?q?ausjUKDYvYRq3tT64F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,200,1728943200"; 
   d="scan'208";a="103085050"
X-MGA-submission: =?us-ascii?q?MDHfcG9VJWNzeNAQ56RnDCCbKAlHcq1e4WgTpC?=
 =?us-ascii?q?qZEQIWSYd2Hf3wnuTJ7+X0NHKh4aCkKVo83ajnFAvFjR2mjj2o52VNEx?=
 =?us-ascii?q?yb8HUpFuNFPNjcBkO4bdz+8ux30fC1y6Lp13uPT66UulEx53izr/Juoc?=
 =?us-ascii?q?4YGGYvKlWO3MIFWJS+45we8A=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2024 10:08:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733044106; x=1733648906; i=markus.elfring@web.de;
	bh=xrsgbRacmQAcEJBIo1Q985jAeMoPP4cVhmgI5CqX0eY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YPL4J4NOASRLuv9Ei9FWAZsSnKnluiLkv17e+hPK0L16SuXbXW+HSlBxqmiioHOG
	 TWcHneDEQM3YXFCpCHYJ2LeUALhjHKLS3ode7bXHYBGIo+eLImorj15vygqE1QEEW
	 NcHALyskGJ/oFwDhADY8tl8BnalWrGVL+8t1oYELL7i5pJ74NWRfa83zsDErxJ4e8
	 o87ZxiBrt5SJAZ+ncTR49z8+dLb9Qy3vz5Ely19c3fPeMHv0cw+NMsXoQokGKHEGx
	 pEEz3803nENJU19GcG4i7OPLyEoRsMBy25U4uxIw7q3p5jfq0aTx/MsnlvAMka3zI
	 MpIm7DaEZwyZ2RhNJg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MyO0s-1tabN02atA-00sno4; Sun, 01
 Dec 2024 10:08:26 +0100
Message-ID: <5d066b97-94b0-4ff0-a88d-b1c2b3044ce5@web.de>
Date: Sun, 1 Dec 2024 10:08:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zack Rusin <zack.rusin@broadcom.com>, cocci@inria.fr
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
 <6b81d431-36e9-7a7a-687b-2d7fc7aa6c31@inria.fr>
 <CABQX2QP0Vk5UZPDFDXThvzuw-gkam-4wU_xq3rbSmwi9x7cBHw@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CABQX2QP0Vk5UZPDFDXThvzuw-gkam-4wU_xq3rbSmwi9x7cBHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1RqtruP7+OS9Mff21/kRL/5uWu5Rxu2cjHrgwLxDbb5wWNuoNH6
 KoFo1dq4faA9AAhVjo6JiT/+g08ue34g3nyPPouF0GvinTJPAA1qkAUk/nrHVVT9fLEQ8v6
 bqEQxGORbOQI1/nKux3nGtP+QcFujGX/NpO25FpID1xDHVHr367vjZ/KgfFcQyKuN1Ublel
 DZJ5A7/dQjSLHXn1fykZA==
UI-OutboundReport: notjunk:1;M01:P0:Xv/xZESdWvw=;3V7mhioCP1xzhb36aNw8Tz35wqy
 ay6JjZMb97S/8w+e2YfQyhAlEmpRdGu7RG6DlkLECZ48TkHs0cAd8W/myoVua2Yx7mrlZzABv
 AQvD1+dBluHOghpLb1qgmPcmJo6lN1c+/VPZbjgUPb1Ojo1Bo8HiaqRuJcR+1OVD+Wskvb4+U
 auI+bz95IExCYXMleKWhU7J5zM6Vijfw4O1OPr6iIP29nh3Y9h6AK0SaeRAf8Vvt3DKIZNG9t
 z9p1vrp8qiUHZFJbPgx75CpaTQMHfJsKyxJwvUg7tXKgafeD0KVuR/egwjl8M2M4opkE0Ew/k
 ZAjEmBGxrQPUn9s8SLD7CeqcjXxJ1ryHAy+6SAKCPtjTIOPQHd/nola1jYWFSyyDvNgYarV8r
 5HBXD2zsVVTy9FaBZOyVn/6Zu0sseOtSf34rZx4HPsBMcgdIOxJXmpq3tOSwrs5qGDz5f9ACa
 J6jCAkPQh2YvMsxA5QExhjBqrkljmzItMxIVFnKgufQBQuFGfDNNirIAx9fkkCJj8epg8Ao3t
 pSwCQRzgFmjsefxs1k80YxMvd60lnwxPB9FeNs9+RUQpcO9BmW+Q53BsrvyU8vHd56oIGI6/E
 HyS3PBJddT6gmZZXV4tuKhu2awjIi81BRBaDMw+gowdp6pK6kNYVfA2tbpM7A7hSLH1L1pxo9
 DDS0lqTpI2g3fw6pIyUvCpR9Lsi/yLFKvhcYpv4Aa8g5vA6tQML0APAZ9ZAGGooJZFPZjEV6Z
 WOFLM+9QlQ9cuDBnFqsYu2hU5j+ZEjn4aR0G5pVZaIZjxDF17Jc+OLsExt3BRTSH6jUIF1JNf
 CZAZN9XX289PoP0rsp1fh/KuAiLokKj+C1xH3I4by1gcpQOttRjz1+Hf5v22io+sIOfgWYhN0
 Rcv+5OfTo+h3+06th5Cbcq3bLuA605gDOdaTaCTD+qI2ZgI3xfx9zBebSlI/dGy2H8JU9/NtK
 XL9QsUEZrf+BpfA4euO3UVcxYkR0jRH4UoYip1k5fg6hBBbdwbrDlGfM4J9BPD6fwWfvdgKAr
 IitOYEm0KPUJS6BhanZu6znUM3IVfagKc3eljnsrI0a6x/gnNmvWkTglbqkTnYRUXTYmzY02V
 1X+l7J9kk=
Subject: Re: [cocci] Replacing type names
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2144
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/5d066b97-94b0-4ff0-a88d-b1c2b3044ce5%40web.de>

> I'd like to handle those too. In general almost everything. The only
> thing that gets skipped is macros, i.e. anything with only uppercase
> latter and underscores, like SOME_MACRO remains as is.

Such requirements will trigger further software development challenges.


> From the sample_case.c I linked before the two constructs I'm having a
> hard time matching are function names in definitions and type names in
> parameter list, i.e. in
> static bool SomeDeviceLocalCompare(SomeDevice *localDevice)
> neither SomeDeviceLocalCompare or SomeDevice seem to matched via idexpre=
ssion.

How does such feedback fit to the support of the metavariable type =E2=80=
=9Cparameter list=E2=80=9D?


>                                 =E2=80=A6 What I decided to do is simply=
 use
> Coccinelle for the things it's perfect for, which is all the code
> transformations that are easier with semantic understanding.

Are you looking for further ways to make such data processing safer
and more convenient?


>                                                              For the
> camel case to snake-case I just have a "finalize file" python script
> that simply does:
=E2=80=A6

Further improvements (including documentation adjustments) will help with
the application of corresponding programming interfaces for advanced data =
processing.
Do you see opportunities to extend knowledge accordingly?

Regards,
Markus
