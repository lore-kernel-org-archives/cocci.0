Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBB7C87FD2
	for <cocci@archiver.kernel.org>; Sat,  2 Aug 2025 14:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+h3/ASf3qB24Lvuv4Wu8q0Ajkqn9QB8cQSPfCwRs28E=;
  b=g4KqX7H4LWd85vYL8LHHH+S5Pw0zYEbYF5UkOQ4+A3KWD2YY17Y665nC
   CrnAo7zIaPX+yy1uulAmpK3xxAbNUCB8dPof32zomDo3FGwX95MqDeCZj
   MVOPKGQRCQJ31P577RkQk7bLEvru2bCzB3NhO2xZzB/K7ypNldhuQcka1
   A=;
X-CSE-ConnectionGUID: 0Abg1fvdR3GJPDjrs96lLw==
X-CSE-MsgGUID: MqXc3mnKSoCIT7hWXZsfyg==
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
   d="scan'208";a="233959675"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2025 16:06:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 802BFE0BE9; Sat,  2 Aug 2025 16:06:12 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 76985E0171
	for <cocci@sympa.inria.fr>; Sat,  2 Aug 2025 16:06:07 +0200 (CEST)
X-CSE-ConnectionGUID: T4+LtXV+QjG2yK9bBZf3tw==
X-CSE-MsgGUID: Mw3cK/xTQduQqnqLzmJ0ww==
IronPort-SDR: 688e1b4e_AfHiUkTQugPcFoQ+edqowlc+v2vBmWdwd0Tz+nHtbWFuJo7
 aOdgEtO5vYqwwUBhRexR6qBMPc/Fe9OKFQJZXJA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GFAAAgGo5ogA4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDgQZUMwQLSYRVj1CCJIQ7hzyQToFVgX0CDwEDAQ1OAQIEAQEDB?=
 =?us-ascii?q?IUAAowaAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBOwcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BA?=
 =?us-ascii?q?REmAQQLCxoCJgICVgYBFAEBF4JngiIBBhABAw4kB7BcgTKBAYIMAQEG2l4fL?=
 =?us-ascii?q?CJZgWQJgRsuAYVsgmQBhieDQnonD4FVRIE8glIxPoRDg1uCaYImgRaDY40Eg?=
 =?us-ascii?q?gKGblJ4HANZLAFVExcLBwWBIEMDKjQxI0sFLR2BJ32DDYEOhCcrT4IidYF5Q?=
 =?us-ascii?q?Rk/g1MeBm0PBoEVGh4tAgICBQJDRYFgGQYaQAIBC209NwkLGwY9k1SDIYEJg?=
 =?us-ascii?q?QyBBpc0mwmUYzQHgjiBZ4FkDJ9sBhMvl1IOBpMFmCBmIqkfgW8BMoFcMxokg?=
 =?us-ascii?q?zZPAxkPjiGEM71UQTU8AgcBCgEBAwmFRgEBi1uBSwEB?=
IronPort-PHdr: A9a23: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
 gdO3r7ya4geZNWTM6NKdVRw2ojHSRO4YA==
IronPort-Data: A9a23:BgHXQ69PKYFRsd6wBIsBDrUDX3qTJUtcMsCJ2f8bNWPcYEJGY0x3m
 2BKWz+BM6uPMzCkethya4uz/R9QvpPcytJrTlZkrXhEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjPzOG/ylTraZZ0idfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRNtMpvlDs15K6v4GNA5wRkDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9FIs+liLvybnoRSbfUOwWU4lIOM0R1qkUqSoQai87XBdJEAatlo23hc+NZl
 L2hgaeNpTIBZcUgrgiyvy5wSEmSNYUekFPOzOPWXca7lyUqeFO0qxli4d1f0ST1NY+bDEkXn
 cH0JgzhYTi/26GS3IKFCdBuqZ4yD5jhFrER4W1/mGSx4fYOGfgvQo3P4sJEmig9jIZCEJ4yZ
 eJDMGApNk6fJUQSfA5LYH49tL/Aan3XVjRCq0+O44cz7XLSygNZz7XndtbYEjCPbZwPxBjG/
 jyWrwwVBDk/K4eU6n2Vzkugm9bWmzrfSocwTKKno6sCbFq7nTBDUEZGCjNXu8KRgUm1UNN3M
 F0R4iNorK4o9UXtQMOVdxmxv3eAujYOWt9aCeR86QeXy6OS7RzxO4QfZjtGdcBgq8I8AzAnv
 rOUoz/3LQAz85mJeUzez7W79yKRaCI/H2FZeTBRGGPp/OLfiI00ixvOSPNqH6i0ksD5FFnML
 9ai83FWa1I70pZj6kmrwW0rlQ5AsbDlY2YICuj/W2W48kVmaYTja4HABbnnARRofd7xorqp5
 SZsdy2iAAYmU8vleMulHrxlIV1Rz6zZWAAweHY2d3Xbyxyj+mS4Yadb6yxkKUFiP64sIGC0P
 BeM4loPus8PbRNGiJObharuW6zGKoC/SrzYugz8M4MXPfCdiSfcrXg/PhD4M57FyRJywfhX1
 WinnTaEVipKUf83k1Jats8c1rks3WglyAvuqWPTn3yaPU6lTCfNE98taQPQBshgtf/siFuPr
 753aZHUoz0BC7eWSneMruYuwaUidyhT6Wbe8ZwPLrbrz8sPMD1JNsI9Npt/INM1wPsOybygE
 7PUchYw9WcTTEbvcW2iAk2Popu1NXqmhSNlY34fLhyz1mI9YI2iyq4aetFlNfMk7eFvh7o8B
 fUMZ8zKULwFRyXl6gYtS8D3jLVjUxC32iOIHS6uOwYkc7BaGgfmx97DfynUzhcoMBaZj8UFj
 oeb5lvpeqZbHwVGJ+TKWc2r1GK07CQ8mvotfk7mIetzWUTL8aoxGRPQk80YHsAoAjfAzwu8y
 Ay5L0o5p+7Mgolt6/jPp/mOgLmIGttEPHhxPjfk/5OpExLF70yfwYNke8SZTwD3DW/b1v2rW
 rRI8qvaLvYComdvj6N9NLRalYQF+Nrlou5h/DRORXnkQQyiNeJ9HyOgw8JKi6xqw41ZsyuQX
 mak2IFTGZeNCfPfPG8hHigXRcXd6qhMgRjX1+o/H2vi7iwu/Lanb1RbDyPRtANjdolKIKEX6
 sZ/nvUJ6j6PqAsgafeHqSF2y16iDFI9V4cfi5VLJ7Oz1yQKzAlZbI3+Gx3GxsiFS+9xP3kAJ
 h6Wg6v/hIpg+HfSTkprK1/z2btyuJdfnjFL014IGHqRkPXnmPIc/UNc4BY3fCtv3zRF1ON/Y
 FZqE0hPIYSP4DZaq8xRVE+8Gwx6JUO4+26g73ArhWHmX02TeWiVF1IEOMGJ51I8319HWzpmo
 IGj12fuVAj1cPHL3icdXVBvr9rhR4dT8jLutd+GHcPfObUHehvg37GTYFQXpyvdAc8egFPNo
 c9o9r1SbYz5LSshnL0pObKF1Lg/SAG2G0IaeKtPpJg2JGD7fC2+/ROsKErrI8NEGKHswH+CU
 sdrIppCagS62COwtQskPK8rIYJvvfsX9dEHK6LKJ2kHjuOllQBXkqnsrwrwuGx6ZO9Vs5cZC
 pjQfDe8AGCvlSNqu2vSnvJlZEu8Q/c5PTPZ4s7k0d80B6oisf5te34cyrGbnWuYGyo58gO2v
 DHsXb73zetjw7s9xofHT/5xOCSpG/zOVcCj0gO6g/JRZ/zhbObMsAI0rAH8HgJ0ZLE+ZfV+p
 Y6vgvXWgnzXmakQUn/LvrW8DIxL2JmCZ/VWOcfJM3VqpyuOd8vy6R8l+WrjC5h2vP5Cx8ugH
 S2UVdCRcIMLZtJj23FlUShSPBIDAaDRbK27hyecreyJOycNwz78M9Kr2n/4X151LhZSFcXFN
 Tb1nPKy6vRzjodGXkYEDs47Ja5IGgboXK9+euDhsTWdMHKTvWqDnbnfjjsl1yDADyiVMcT94
 K+dfCPESjaJhPjqwu1a4qtIhT9GPEYl1KN0NggY9sVtgj+3MH8eIK5Ped8aA5VTiWrp2Iu+e
 DjJa3A4BD7gWShfNy/x+8nnQhzVE9lm1g0V/dD11xj8h+aK6IK87H9J8yB9/zFpdzGlwOzPx
 RTyPJHvFkDZ/32rbb97Cj+HbSNP2f7QgH4Fkaw4u9KnGA4QWN3my1Q4dDeglkX7/wXli0jBY
 2Q4LYyBrIdXVmapeftdl7Vp9N31cd8hI/jErctC/ToHh7im8Q==
IronPort-HdrOrdr: A9a23:idf/26jaQfUttEPm7wqT1z/V1nBQXgMji2hC6mlwRA09TyX+ra
 +TdZUgpHvJYVMqM03I9urwQZVoLUmskqKdy7NhXotKJTOHhILwFuBfBOjZrwEIZReOlNK1vJ
 0IG8ISNDSXNykdsS+Q2meF+rgbsaO62ZHtqeDCz2p8CSFGApsQkjuR0zzranGekjM2fqbQP/
 enl696mwY=
X-Talos-CUID: 9a23:zsyV7G2l6rnZKVdlp9EpTrxfJpxmVmHt8jTpIWDiGEU4QpenRwSM5/Yx
X-Talos-MUID: 9a23:+cLXYwrPVBZMM2EqlxAezxR9b8xLpLSSMUwQqIwAou2WMA4oJCjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="122660688"
X-MGA-submission: =?us-ascii?q?MDFPKH7mGj1IA/eIg+4GTf8nEwJvsnp9Yqdhye?=
 =?us-ascii?q?gyxZrwOqPQMxvmoolnYTsGj9zm7CRSTSd0UIJRmX46XrteEx9Ltqr79N?=
 =?us-ascii?q?O5e+tAODJTftzMvQmP92TOpbDDup5NcmGMoCGefQECLdSRXkBklHkeza?=
 =?us-ascii?q?4WlTytQbb3KB2FhK5i/RDIWQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 16:06:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754143565; x=1754748365; i=markus.elfring@web.de;
	bh=+h3/ASf3qB24Lvuv4Wu8q0Ajkqn9QB8cQSPfCwRs28E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GtRn9nBqmdBfr8Ffy1MEXCkMV4MnaRAeCeb8W6GgR3fv9QVG5afv9/B8ffTtKoKc
	 4ISpuiO18LXNqTdioe7sTL9b4IbQ1ko5YOIDDbz/kobxpSg8W8zIpJAQPRXS+bUPm
	 XEFqSD3jzeG0ukUi6XMlY54lBCAO69B8vWY5QzUTmAJ0gcb2TXyIUmp0/X51Wky8V
	 QdLlLUxAVyEkBA12U0t/HlgOoWH/3PL+zkkU4745nGfayyJO3BjsGGNlacAr+RyYM
	 PJ+U1O7V+II4LrFnAHz6aavvaRyWA0dlLIkSEx/KVANrl0R9SJObmQ2Wdof9rBi+G
	 /M6oqi5TdoDDZicNgg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.1]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZB01-1vDMej3P0b-00IHAi; Sat, 02
 Aug 2025 16:06:04 +0200
Message-ID: <44f4f54f-4bb9-4a5d-b977-926d88340876@web.de>
Date: Sat, 2 Aug 2025 16:06:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr>
 <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de>
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
 <04403bf5-82f6-4c23-a217-0063f802e8ed@web.de>
 <alpine.DEB.2.22.394.2508021541010.3428@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2508021541010.3428@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E2x0QMPyAnDVVQCcyclSYIGQxtBjaRouz/ttp9/jjwdZngaQ5kr
 8XXtD1WeLGKygDiCG9fGYU2Y1mYVSSht3ZJVpyny0yC9efbYRvEq0Y5NND3CVGisw8W99Ft
 weVUUzrPl46yCJ+Ebp2IJ4kwFbIPrHa5X1o1QdDDjbsbnA72QR7jYnyLKc353otcXkldgqZ
 2MmcSN3wJKCmwzBEZ2aBg==
UI-OutboundReport: notjunk:1;M01:P0:X5yFLcbI3ao=;rclosNaemuRwTkoMuGOk78hVEVi
 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
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2936
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/44f4f54f-4bb9-4a5d-b977-926d88340876%40web.de>

> In the two matches I mentioned earlier there was no intermediate lock ca=
ll.

How does this feedback fit to the mentioned SmPL code?


@display@
expression x, y;
@@
 action_lock(x);
 ... when !=3D action_unlock(x);
*action_lock(y);



>> I hope still that a better consensus can be achieved also for safer app=
lications
>> of the SmPL asterisk functionality.
>=20
> I have no idea what is considered to be unsafe. In any case, * is only
> intended as a convenience.

This is generally nice.

It seems that presented test results can point disagreements out
which are waiting on more pleasing solutions.


>                             It works well with emacs to jump to the
> affected region of code.  Then you can study it and see what you really
> want to do.

The probability for the presentation of false positives can hopefully
be adjusted better.


>>>> Can the path distance be determined anyhow?
>>
>> I would appreciate a more helpful answer here.
>=20
> No idea what this means nor why exact path distance is relevant.

It seems that we represent different development views for the term =E2=80=
=9Cshortest path constraint=E2=80=9D.


> The point is that there may be some longer paths that start and end with=
 A and
> B, but that also contain instances of A and/or B.  By default Coccinelle
> doesn't return them.
>=20
> But * doesn't reflect the result of a single match.  It reflects the
> result of all possible matches.  So they can overlap.

I imagine that this information can trigger data processing confusion.


>> =E2=80=A6>>> independent.  There is no guarantee that one match will no=
t cross another
>>>>> one.  Furthermore, (just in case this is the concern) when you menti=
n two
>>>>> different metavariables, there is no guarantee that they are not bou=
nd to
>>>>> the same term.
>> =E2=80=A6>> Will it become more desirable to distinguish metavariable c=
ontents in an
>>>> unique way?
>>>
>>> If you want something you have to express it in Coccinelle.
>>>
>>> foo(A)
>>> ...
>>> (
>>> foo(A)
>>> |
>>> *foo(B)
>>> )
>>>
>>> ensures that the marked foo(B) involves a different argument than the
>>> matched foo(A).
>>
>> Would you like to provide a =E2=80=9Cguarantee=E2=80=9D here?
>=20
> Sure, it is guaranteed.

Does this feedback indicate a contradiction to your previous description?

Regards,
Markus
