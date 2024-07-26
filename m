Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDADC3DA4A
	for <cocci@archiver.kernel.org>; Fri, 26 Jul 2024 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=amQwNSGH+Ek6WH7rYGTgLXSpUVwja5W8NFEjRjohP5w=;
  b=mSfupPOjHE1C2XaD+PEh1gXJ6fhw43CUZNdFfXyB+Eu/tETGFzQXnmiy
   /BZXWbpi3U8Ac1gcxh4T7SAe0dAVoiNwTZddwMtnDR0/I45zNJiOx1Eds
   n3gN/S2Eq765TVmdMsuzgKbKOtVHYs38YTngu6CjpdLGv+aLzIeni3Ti4
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.09,238,1716242400"; 
   d="scan'208";a="177127593"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Jul 2024 17:32:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 65992E0138; Fri, 26 Jul 2024 17:32:44 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E6DFCE0035
	for <cocci@sympa.inria.fr>; Fri, 26 Jul 2024 17:32:41 +0200 (CEST)
IronPort-SDR: 66a3c19a_IIuKwQBDn/lguGoG0lJDEB8NpL/wvcTSqqmnj0OLjAf0N/j
 UtLOkFry/tEitFcrDDSjV+PIq5PtCKtWSQ6lmzA==
X-IPAS-Result: =?us-ascii?q?A0GNAAAOwaNmh07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDYiBUMwQLSIRWiB2HLoIlhDuHOodRiHWBVoFAPg8BAwENQQECB?=
 =?us-ascii?q?AEBAwSEfwKJOgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQE6Bw47hXUNgmcBEIESgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdEA?=
 =?us-ascii?q?QEBAgEjHQEBESYBBAsLGgImAgJWBgEUAQEXgmWCMAEDDiMHrU2BMhNuggwBA?=
 =?us-ascii?q?QbaWR8sIleBYwmBGi4BiDwBhgyDTXonD4FVRIE8glIxPoRDg1uCaY9BgwOIL?=
 =?us-ascii?q?AODTSaNTlR7HANZIRMBVRMXCwkCBRCJYAqDJSmBSSaEGwiBLRWDZIFrDGGHd?=
 =?us-ascii?q?mKBD4E+gV8BSYJ3S4NoHIFlbB1AAgELbT01CQsbBj2lKoEJgQOCQFvEHYEKN?=
 =?us-ascii?q?AeCNoFigWMMn08GEy+XPA4Gkm4emE8iqG+BZzqBXDMaJIM2TwMZD44hGYQUz?=
 =?us-ascii?q?ApBNTsCBwEKAQEDCYVGAQGDWoFKAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:HiSCM6Bn2woMDOPlHel455DYdb4zR+YMi2TDGXoBKyC9Afbo8/
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: 9a23:R0bxyGAWtTgHWg76EyI78BQKIM0jS1iHi2bBJBCGEn0wQaLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AArrwhQ8LQ6gKfTzX9L60rWCQf+hz47T3OkIKrZA?=
 =?us-ascii?q?ltPSHPhN5Bzy7kyviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,238,1716242400"; 
   d="scan'208";a="177127569"
X-MGA-submission: =?us-ascii?q?MDH0Mxr0HYfUW4z5GsJ131ySq8/BWPjB78FhoF?=
 =?us-ascii?q?ZxmZEIfPSVxqs4UndrUzWxULIboTwHs8cMhsSD7HiKM6BAjpW4wkOSK2?=
 =?us-ascii?q?siob16ctKBSwOygmWJGwpm3DgUVacOGsRxOFgO0gTwxIFYiaqZFYIwCs?=
 =?us-ascii?q?uXYcn5A+NGX1oHHDlaDiiaFA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 17:32:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722007956; x=1722612756; i=markus.elfring@web.de;
	bh=amQwNSGH+Ek6WH7rYGTgLXSpUVwja5W8NFEjRjohP5w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nFzZGDXp4JYTq93rs61BAHi/rOOHC2iaDU7iG8GbExAtuXByokX3S9ouWEA9uvq8
	 v7yzfAdtRpt789Bm7dcBzzahg4BuvcNkwk3DIUsHu3AlZMU4HbPbJQvtzGJjtc86Q
	 RKq1Oq5f6LkD1HuAyvRP5RewaT1MipsxNL9kkJy0hDPYdTfzk7cAyMb6BwgRganJZ
	 ZoB0TFAF8x26Tm9S+cLV1tim45FR2KhS0KTSoWi+EiCriXEAnD4wxcKINkd4Zr/VR
	 W1teYvZOilEYlZ7ddgd96s9fJzrhJvd17vkCV3O0Qs1eQA48YQxlZBDSjIpd6cYe0
	 i67u9PD75yiyonm6MQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MK52q-1srfEz3uhS-00Lp7V; Fri, 26
 Jul 2024 17:32:35 +0200
Message-ID: <556cf30d-6fee-4f8d-aa84-c47cc7b98c52@web.de>
Date: Fri, 26 Jul 2024 17:32:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Chen Ni <nichen@iscas.ac.cn>
References: <959b8771-76a1-4cee-a7b1-2b391deb23cc@web.de>
 <1584412e-94b-4c10-6f96-9da68f4ed1d@inria.fr>
 <d3f11294-5751-442e-b7d4-616c3bd217b9@web.de>
 <bea5cf4d-0e4-d141-1365-4d5f76bcf513@inria.fr>
 <f7cb87e7-3a17-44b7-87a1-8fec22e649ea@web.de>
 <fea78c48-494a-ee18-97ee-fc6930fce7d@inria.fr>
 <c1c3f2b0-4581-41f0-a29e-b6964da045c2@web.de>
 <c135404e-ddd3-7324-9f35-963bfb202ba9@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c135404e-ddd3-7324-9f35-963bfb202ba9@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bMAXW4ZtOi6SfgP62Utnc7NP7nO/SKfbvC9JlUEWddvlNPbn1wp
 YfqE+AgnrmyPePdNZG7xCetyZOpfscWrdIh/jIkyXsqAQl+fKslO1+SRXkB/dCHzfzoPeux
 Vp/NPaR9zmVazHgUcgBQlrc95NUOqR1Do7wePV8Q08yk3FhWufphVfdoTlDTou9MUR+pOXJ
 /acyZfFP0GOx/airTFTTA==
UI-OutboundReport: notjunk:1;M01:P0:iOdy3a8wsqU=;yxxa9nbctu8yPPnn6jP9AEkHRre
 8e2M+Gt++2BxCfCrDiww/oBWzEon0ITy+ONwQ58rnQlfHyRbUTIS78CAGmuMmSb1AHnr/1v0L
 ldhnFIQpuRkRTjSewja48xUxrvy399/OJTS/92rIvXgGheQ1llkF1xWva8pShlY0BI7apJlIz
 aeKkngC+XtRfX56Py7bKXplM2Sp+GWYGFQZNh1ydTkD8x2Nm75Q9Zg/9HaBC7C59wAUZu2xCf
 0izTq+zJLCaIEccYFf7vAGm08tuK8iIykIZl+M8I2kZGw/Fe1yNY7IbMyHCzG2yrPHig7Gsr5
 4DeMQhNunmswGrvg91RtTtISjF85zSqQ7pUio1jgJdJW3buJxYrY1JpVM53p3fRci20b2j/Cv
 A5MpTNH4qfF/+Fn2uQcYqBvGJb30M1cS0O6O5xS7qUZx/M8H9S9PmOFyfVxacZ6ZO1UwB4GOO
 tVDVwZ6QkhIDEJEV+3kLYDNQf/Q4ABTxbjCbdAZbgGK3hq28afPCbJqEJ0vSOKkxEF3NCcVwD
 jZmqlZZWk5tIdOWoYvEUzYHv7i6N2Ehe6AYknoRKjRYuDZR+PhoZFbQGz2Murjyq78iwxLUqU
 /9er6QGVCRV4CU2E6yIlxnDrkvnAXccSjqODgOvTa6VWncejPwcADNC/47g+auk3F/rVjrepb
 rhESZPOcbRsttecADRRWoCNyNCcAZQLvj5xpdJNMFjBgBQuJVH2mteDS7g+dxiZPasrT7FxMF
 Ds6lcsUkt4HhGoav+KYBxYl1gAEN8OUtCb28Ys/SdNT3D2y5Il9zLGD/p9DKK1ifjbl9Zr10x
 aklWonSUG4Aj9/Hr9HVGprKQ==
Subject: Re: [cocci] Data processing challenges according to the comma
 operator
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1823
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/556cf30d-6fee-4f8d-aa84-c47cc7b98c52%40web.de>

>>>>> The comma operator expression has the form
>>>>> lhs , rhs
>>>>>
>>>>> That doesn't end in a comma.  There is no rhs within the <+... ...+>
>>>>
>>>> Can subexpressions be supported by the semantic patch language
>>>> for such a =E2=80=9Cbinary=E2=80=9D operator?
>>>
>>> A subexpression is also an expression.  There is nothing specific abou=
t
>>> this operator.
>>
>> How do you call the construct of an expression together with an operato=
r
>> (like a comma for example) on the right side?
>
> Nothing.

Such a feedback hinders a bit the development of a solution,
doesn't it?

I would find further clarification helpful for a corresponding terminology=
.


>>>                 The rule in Coccinelle is that when you write <+... ..=
.+>,
>>> the term in the middle has to be a complete expression or statement.
>>
>> Will additional source code search operators become relevant here?
>>
>> Do further development resources need to be allocated anyhow?
>
> No there is no interest in supporting random fragments of terms.

Different development interests are distributed between involved parties.
Syntax items can hopefully be better discussed.



> They are hard to parse and it's not clear that the generated code would =
be even
> syntactically correct.

Such application concerns can eventually be clarified better.

Regards,
Markus
