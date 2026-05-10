Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A50CD37AF
	for <cocci@archiver.kernel.org>; Sun, 10 May 2026 09:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=zo46Kwtm6WpZtvYKvuc0KKCTXfR136jW+cQ4MpYvT30=;
  b=PDJSjPUSzKAs5yqV3/SzjasOMaufXs4OXBKlr2E4Q9u3rea5c3k7iD8v
   Nt7vqUXDq/Rt9Q+xDvPFzSsKcxrW9JOjeVih9xjCs6QPDrL9pJNDD3bzA
   CZdJfgjlBretXz4o4WqNPo4tjUffWGf5DajLe9McfrLiZy5xWTzmUmYYr
   I=;
X-CSE-ConnectionGUID: 31Qw/wkpS3KTCO7tG33CfA==
X-CSE-MsgGUID: GdceTKOlRkKrMvgBmaj5DA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,227,1770591600"; 
   d="scan'208";a="276019212"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 May 2026 11:38:41 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id DEB70805AF; Sun, 10 May 2026 11:38:40 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id D1A5380517
	for <cocci@sympa.inria.fr>; Sun, 10 May 2026 11:38:38 +0200 (CEST)
X-CSE-ConnectionGUID: tylwB2yiSlGmkH16v+H3yQ==
X-CSE-MsgGUID: Ao2LSTJbRi2FOmTU0t9WFA==
IronPort-SDR: 6a00521e_fsub5nuUu1hQx/pPecJNEsd3RA1q88oXwf5qhLUpMH3j74d
 gsFeeanPOYZC6fESdbyr8jyQtpOhvtaS3aMJAXQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EzAwB8UQBqgAMP49RahRqBCF40BAtJCIRQj1OCIQOEO?=
 =?us-ascii?q?5tcAg8BAwENSgQBAgQBAQECAwGEdQoCjTMCHgcBBDQTAQIEAwIDAQEBAQEBA?=
 =?us-ascii?q?QEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBOwcOO4ZPDYJiAYEkgSYBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQJHRAEBAQIBI?=
 =?us-ascii?q?x0BAREmAQQLCxoCGA4CAlYGFQEBgn4BgiIBBhABAw8nBw0GtQiBMoEBggwBA?=
 =?us-ascii?q?QbaYx8sIlqBZwMGgR8uhXKCZwGJd3onD4FVRIE8glIxPoJhAYFhg1uCaYIme?=
 =?us-ascii?q?hSDVYFaiVNSeBwDWSwBVRMXCwcFgSNDA4EGI0sFLR2BIyEdFxUfWBsHBRIhK?=
 =?us-ascii?q?m5LZCxcGgMDDSE1WXUKAUkFgXQCgh4ZXyMvA06BBQIBC209NwkLGwQ9izwdD?=
 =?us-ascii?q?4E9bIEWK4FaBGoCHpJ6sxg0B4I4gWeBZAyKLpU/BhMvl1IOkwsemGiOCZs4g?=
 =?us-ascii?q?X8jgVwzGiSDNlADGQ+SVoELwjNFMgIJMgIHAgcNAwuFRAEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:KKCWba9RmBeNMAIJKcpuk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3ASjXog2qrUJMP/6X+p3O/y0DmUdw0dmL3lmbRGEu?=
 =?us-ascii?q?XDGVJEeOLCn/L6Zoxxg=3D=3D?=
X-Talos-MUID: 9a23:mxgtJAklRIyl6OjYOZg8dnpLM51M2JiMAnoMy7shvvW5bTAhBBm02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,227,1770591600"; 
   d="scan'208";a="276019201"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDE5LuOdDKYm88R0gPrsl0ZKICrjk8rXWDjvqv?=
 =?us-ascii?q?WiX3otPuBNx7SFM5LSFlYmMoxD+rIuYIzz5DKUcsjbtQ6lA0SiwqBcZ/?=
 =?us-ascii?q?QBWPGoWLqxr3mpD16sban/DaejR6igT+r4GdHxvxwr6rLFnyfpfpJ+or?=
 =?us-ascii?q?xZqN095baGQtMpW3HkEyymeg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:38:38 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNfUF-1wkxDa3oJH-00Qtbz; Sun, 10
 May 2026 11:38:37 +0200
Message-ID: <3fbe8383-ef99-4a9f-bfeb-4c8f156ee789@web.de>
Date: Sun, 10 May 2026 11:38:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <ffd64e55-beb3-4030-8b7d-763ba6f8f563@web.de>
 <1f97d99-bf20-44f9-8781-26162f5824b@inria.fr>
 <ef0539dd-b1d5-49b0-9c20-74c5e5d977b1@web.de>
 <e5a66d9c-5462-2f54-6abf-d2ec2cfd1d9@inria.fr>
 <26e1d3aa-13f1-4e55-88d1-68b9d027ded0@web.de>
 <806afe75-8e1-17d8-dc3e-c2e33f4ab64@inria.fr>
 <049a046d-3952-4192-9b9f-a7c2162c6ea9@web.de>
 <2437833c-e02c-736c-e96f-7ded7eb263c1@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2437833c-e02c-736c-e96f-7ded7eb263c1@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:soeVSVlJV1ZfZfYJfaEoVvsdDl59oXvjNIko8zctsZAma8daa7E
 eOTooicOqdWgKiWI9UysxasAKJY47dfNQC6aG6g9VQsT4eJSX8fNYH+hETNCoWJWuzwNoHi
 U9eeYIPatDTZVhdezTBdgi22mgad9q/s9x6heVZ2z3umN59AuYJ3FokBT1H79QF+GsbHTFH
 895BaYY0LqTZrN5N74RDg==
UI-OutboundReport: notjunk:1;M01:P0:SPBIrZpeSR0=;NvpPj5RF0veGHCcyc0GQl87GcFL
 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
 WkYgVfanu7LBZlMoqyjGuXckJz1cfov73eN8=
Subject: Re: [cocci] Merging results from parallel data processing?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3494
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/IyND-XZEy9HvXmcnxL3Rww>

>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/03a1af0a3316ddfc2b=
54d827b8b9627a841c85c9/tests/merge_vars.cocci
>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/03a1af0a3316ddfc2b=
54d827b8b9627a841c85c9/tests/merge_vars_python.cocci
>=20
> No idea what is the point of these links.

You offered another bit of background information.

I find it still unclear how much these code examples can help with the des=
ired
clarification for parallel data processing.
They are not referenced by the SmPL manual so far.


>> Do you distinguish =E2=80=9Cmerging=E2=80=9D from data concatenation in=
 such code?
>=20
> No idea what this question means.

???


> You can declare variable in OCaml or Python to be the result of
> concatenating the results from the different threads.

Would an other algorithm than =E2=80=9Cconcatenation=E2=80=9D be occasiona=
lly preferred here?


>                                                        There is nothing
> more to discuss about it.
>=20
> It's true that the above tests are overly simplistic.  Maybe
> tests/names.cocci would be a better example.  But it doesn't have a pyth=
on
> counterpart.

Will such information trigger further collateral evolution?


>> How will such a view evolve further according to the use case =E2=80=9C=
parallel data processing=E2=80=9D?
>=20
> No idea what this means.

???


>> Data users tend to prefer some information ordering, don't they?
>=20
> You look at the data and order it however you want.

Will additional development approaches be needed to achieve a preferred or=
der?


>                                                      The user has no
> control over what files get handled by what tasks, so it doesn't make
> sense for Coccinelle to provide any ordering guarantees.
I came along further application requirements through the years.
Data are usually processed by the involved computation units in a known wa=
y,
aren't they?

Do you distinguish tasks from threads (or background processes) anyhow?

Regards,
Markus
