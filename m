Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35ECC87FD2
	for <cocci@archiver.kernel.org>; Sat,  2 Aug 2025 16:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=oYMQSKkz0FLTIzblhZKS+jQ5NpLs/qSr4KJ7aDapTRw=;
  b=r5rnVtmSq8tNVoXC1p9y1vRhS196yBLxowhLFfFP3FzuUkXD72t1w1IN
   9dJLx7ccAqdyuwQErfeaQwpwjsxrcu+Tn0ikmGFDjRe9oOfm4gK6sGlQF
   esevqwimFsO2NRusFws537ESqOeBK4HYOF1Nu4AyKAje4jPE0Q1o5ISY3
   k=;
X-CSE-ConnectionGUID: g5q9CL4KRjCZxSahZWpTaA==
X-CSE-MsgGUID: IzCiTHMlQJqN1vbNbWsvSQ==
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
   d="scan'208";a="233966406"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2025 18:36:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3EF0CE0BE9; Sat,  2 Aug 2025 18:36:03 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7AB96E0171
	for <cocci@sympa.inria.fr>; Sat,  2 Aug 2025 18:35:58 +0200 (CEST)
X-CSE-ConnectionGUID: Pj/UwKTkQ3u2SwQny9tFgg==
X-CSE-MsgGUID: jrgE7vkCTbio6rO8QmYIxw==
IronPort-SDR: 688e3e6e_pbAUbsb5f+tM9byKZsz2/Vz+PsngNQWUi88knGreB1ZmG/C
 OtTlq5Fxb+UMMtjoK83s/d1db9TMbFdfO0nsV6A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HDAACgPY5ogAMP49RODB0BAQEBCQESAQUFAUCBQQYBC?=
 =?us-ascii?q?wGCQ4EGVDMEC0mEGTyPUIIkhDuHPJBOgVUUgWkCDwEDAQ1OAQIEAQEDBIR8A?=
 =?us-ascii?q?gICjBoCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQE7Bw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEMEQYdA?=
 =?us-ascii?q?QERJgEECwkCGgImAgJWBgEUAQGCfoIiAQYQAQMOJAeUFJxGgTKBAYIMAQEG2?=
 =?us-ascii?q?l4fLCJZgWQJgRsuAYVsgmQBhieDQnonD4FVRIE8C4JHMT6EAQEDPoNbgmmCJ?=
 =?us-ascii?q?oEWg2ONBIhwUngcA1ksAVUTFwsHBYEgQwMqNDEjSwUtHYEnfYMNgQ6EJytPg?=
 =?us-ascii?q?iJ1gXlBGT+DUx4GbQ8GgRUaHi0CAgIFAkNFgWAZBhpAAgELbT03CQsbBj2TV?=
 =?us-ascii?q?IU2cWyWXa9sNAeCOIFngWQMn2wGEy+XUg4GkwWZBiKpH4FvBC+BXDMaJIM2T?=
 =?us-ascii?q?wMZD44hhDO9NEE1PAIHAQoBAQMJhUYBAYtbgUsBAQ?=
IronPort-PHdr: A9a23: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
 DMXzLm+IYlBb+XG
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:u9cyd6sG888TieTZcm/jFoG/7skDotV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: =?us-ascii?q?9a23=3A7pTpmGknoJkxHoRY1suKPOl/8fvXOUXfi0rPAHO?=
 =?us-ascii?q?7MD10EoaKcFmBqb9KnMU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ATyo4jQ6ajvbtVdlDtIgt1n3Mxoxq+auDV14Ouqk?=
 =?us-ascii?q?Mus7aLwsgAjKsrSSoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233966401"
X-MGA-submission: =?us-ascii?q?MDFFkvme6vME/zEb7F8EZ7MemwGXZbGh7b4tt/?=
 =?us-ascii?q?Et24iy2Y23Sd0I/vcN/zgC9HBr1XCvDjsTfRP8GDkxE+v3IkxeH+gu6u?=
 =?us-ascii?q?CwegFIFMtO8njRTt6/ZMMgcjiyQR8Lk2GFssmwAudsHsv6go26jo7Jdc?=
 =?us-ascii?q?wWHoowGlhn+RS7hSArq6YeWQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 18:35:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754152557; x=1754757357; i=markus.elfring@web.de;
	bh=oYMQSKkz0FLTIzblhZKS+jQ5NpLs/qSr4KJ7aDapTRw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PkMnYcl5SLjamKdIY7syQKDf1kQHkUV9xu6MiskqKkVtxDav/tMgAybOanjFkQFk
	 B6xJNEeBq18UEIQtU/C3aUGohS2D1wbbDIkm1iY7/FD4a1R07qHeInz0lm8Mcq/S2
	 B5jkPxddaYoc6afu77TrawOUMlP5rE6WQbUc5uJKDX5Sdk3Yo0ZIRpEEQFL657SI+
	 4a25pdJWpy6etzZNhurRvMUwm4oh0BYjFFPeA7Ky3pU5hYmQTibPFySIWpop2pUxw
	 rNkVuiUoA0aqW2BO3XzSD33QRpVDINqWT05osZ2u2eR3tSTQSt+bHDvEit+trmjhr
	 UTfmBLt819w5LP6anw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.1]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MElZP-1usuJi0kZ9-000SvC; Sat, 02
 Aug 2025 18:35:57 +0200
Message-ID: <5e8e1f8a-6832-49af-bca5-41d2a13b1322@web.de>
Date: Sat, 2 Aug 2025 18:35:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
 <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
 <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de>
 <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr>
 <70a43c52-f898-4fa3-a4b3-16c54bd4f9cb@web.de>
 <c1d74aa4-44db-4618-ba59-e9b6dab28c0e@web.de>
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
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2508021822490.3428@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LP3+iXLqzjIEa4vR4oQlzYIkyvL4yKLmOCSAwuvL2o3R2g42iY9
 D6s55fh98F4cH6Xk66r0/WuZ6eiPPXq4gpSN9qXZiZJmusl+9ZSxb+JelHJzTiAiVlveRu9
 SEfB4ylYElCKAXfaUp0iHb07NytSAz7c253NdlRPUxkMOATJ5dHxdDGtX0yTwixFGx3PM9P
 RtOKkdW5+oqIOxfhECfSQ==
UI-OutboundReport: notjunk:1;M01:P0:QygrZPaXRYg=;xDh1ZEzEmihy2hql34uUDPfLT/K
 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
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2943
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/5e8e1f8a-6832-49af-bca5-41d2a13b1322%40web.de>

>>>>>      The one in the if is matching with the call closest to it,
>>>>
>>>> I interpret this hit as a false positive.
>>>> (The first lock call in the if branch is not the relevant companion c=
all
>>>> from the function implementation.)
>>>>
>>>>
>>>>>                                                                 not =
the
>>>>> call at the beginning of the function.
>>>>
>>>> This is an essential requirement for the discussed source code search=
 pattern,
>>>> isn't it?
>>>
>>> No.
>>
>> I hope still that a better common understanding can be achieved.
>>
>>
>>>      I don't understand why you think that.
>>
>> The source code search pattern tries to find a pair of lock calls.
>> Is the passed expression determined for the metavariable =E2=80=9Cy=E2=
=80=9D after the second
>> lock call was found at the beginning of the function implementation?
>=20
> I don't understand this at all.

Does this feedback indicate another communication problem?


>                                  Coccinelle doesn't care about the
> beginning of the function, unless you start the pattern with a function
> header or a ...

Where does the statement =E2=80=9Caction_lock(&blockage1);=E2=80=9D appear=
 in the implementation
of the function =E2=80=9Cmy_action_test=E2=80=9D?


> In all cases, Coccinelle looks at every node of the control-flow graph a=
nd
> tries to match the pattern there.  It doesn't care about beginning middl=
e
> or end.

But should the analysis tool care more for selected function call combinat=
ions?

Would it be possible to determine that special control flow from an if bra=
nch
would be inappropriate according to the mentioned SmPL code?

Regards,
Markus
