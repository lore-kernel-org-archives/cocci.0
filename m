Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22680C7618E
	for <cocci@archiver.kernel.org>; Sat, 22 Apr 2023 15:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TanVOSbB2nUpxvWb3tTgy2sA4D7GK0FY6OXU/Q2871Y=;
  b=P5E5fyrjcCOTB6UGFnARxt4kXU3p5VZlXL5EelVohb2uUTjO3HJkIwpP
   8COz/CJ4QD+Dj/U3xOkqriRX/Zb4rLOuqXas0iarQd3ERKAzP00aW3i53
   yyZ2iFsZ26DF0W7KOlr+irf322P9pVKAgo4v2ydeNEjdp5eRcuCmngPRx
   k=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.99,218,1677538800"; 
   d="scan'208";a="104299557"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Apr 2023 17:52:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5ACC6E01D1; Sat, 22 Apr 2023 17:52:41 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 410BCE019E
	for <cocci@sympa.inria.fr>; Sat, 22 Apr 2023 17:52:38 +0200 (CEST)
IronPort-SDR: 644402c6_Vw05Sn2PvpZHk9sx/mCDd91xsdAQmqufr7L8PFNYoRTxmfa
 UzBOXcSG3nT6iMisj6mn8F0AtKypfS08B4Dx6Yg==
X-IPAS-Result: =?us-ascii?q?A0EvAABuAkRkhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYItdVYvBAtGhFOPEIInaYNHjmyIaoFWgUA+DwEDAQ05CAECBAEBA?=
 =?us-ascii?q?wSEOUYChTwCHQcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFA?=
 =?us-ascii?q?QIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBEgINOj4BAgIBIx0BAREmAQ8LGgImAgJXBgEMCAEBgnoBgicBAw4jBwyqc?=
 =?us-ascii?q?4EygQGCCAEBBpwMHywiVIFeAwaBFC0BjR+DN3onD4FVRIE8DIJHMT6CSxcCA?=
 =?us-ascii?q?4Fdg1uCZ5YYgTN0gSeBMoEEAgkCEWuBEAhogXRAAg1kCw5wgUWDFwQCFDQOD?=
 =?us-ascii?q?BYFQiUEDgMZKx1AAgELOzo9NQkLHwZEAh+BbAQvWHcKBgElJJUnglKBQSKBf?=
 =?us-ascii?q?h3DSzQHgiuBVoFZDIoNlQAGEy+DapMfDgaSJR6XWSCNM5UneYQsgWUDNYFcM?=
 =?us-ascii?q?xokgzZPAxkPjiAZHoM7M49IPzQ9AgcLAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23: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
 Edetw==
IronPort-Data: A9a23:bWPkwaxQhCcjPA8Rmfp6t+f1wirEfRIJ4+MujC+fZmUNrF6WrkUHy
 2MbX2nQaPnfNjb3c9snYdmw9E4Cv8eHnddkTVRp/1hgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEALjim8c3l48sfrZ80sz5q6q4lv0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFPW+95pKGg2PrYl4/RmID5Q8
 bsRMTMSO0Xra+KemNpXS8Fpgdk/atbmNsUTtxmMzxmDVKxgG8qcBfyXo4MwMDQY3qiiGd77b
 tAadCEpQRDOeRxJNX8IBZh4kOrAanzXKmUE8gPE+Pdsi4TV5Ddzz5HwE9zFQMaPY+pSn0yav
 m3l+2usV3n2M/TGlGbbqyvy7gPVpgv/UZ0bELmQ5P9vikeagG0VEhwfE1WhydGlj0ekR9NZJ
 mQG+y8kt6F09UqxT9C7UQfQiHWDtRUdc8FBFvUzrgCL0KvdpQiDblXoVRZEb8E68tA7T3om2
 zdlgu8FGxRViJaSbVud9YyptCGjGHcLKSgLfCwbGF5tD8bYnKk/iRfGT9BGGaGzj8HoFTyY/
 9xshHZv71n0pZFTv5hX7WwrkBrx/8aSH19dChH/Ajz8tF4RiJuNOtTwgWU3+8qsO66/ajFtV
 lA2ltaT6uoDF56AkkRhq81RQ+/zjxppGBvbm0JvV7M7/j6k/WLLQGy9yDR5OVsvLcsOPzPkC
 KMyhe+zzM8CVJdJRfUuC25UNyjM5fWxfTgCfq2FBueimrArKGe6ENhGPCZ8JVzFnkk2ir0YM
 pyGa8uqBntyIf05nGDvH75Ni+B3m31WKYbvqXbTkErPPV22OyH9dFv5GADRBgzExP7Z8FiEq
 r6zyePTmk4BCIUSnRU7AaZKcAxUdCFlbXwHg5UZL6aCJBZrAmcsF7fYztscl39Nz8xoehPz1
 ijlACdwkQKh7VWecFniQi09NNvHAMguxVplZ3BEFQjzgRALP93whJrzgrNsINHLAsQ4kaUrJ
 xTEEu3caslypsPvqmhMMsis9NU/HPlp7CrXVxeYjPEEV8YIb2T0FhXMJ2MDLQFeUXLlhth0u
 LC6yALQTLwKQgkoXo6ca+uiwxn19TIRkf57FRmAaNRCWlTewK4zIQzIj9gzP54tLzfHzWCkz
 Aq4O0oTitTMhI4Xy+P3o564gb2nKdYjIXoCLVLnte63EQL44lucxZRxVbfUXDLFC0Lx1qaQR
 cRU6PDea884vUt4nLd9N51JzqsOwcTliJEH7wZjHVTNN0+KDJE5KFa4/MB/jI9/7Z4HhhmTR
 WS05ch8BbWFHOjHAWwhDlMpQcrb3M5FhwSIy+o+JXvLwRNe/Z2FYB10BAaNgikMF4lFGtop7
 sl5sfFH9jHlrAQhN+uHqSVm926sCHgkeId/v7E4BL7bsCYa+mtgU7f9VBCvuIqubu9SOHYEO
 jWX3arOp4pNz3r4LkYcKyL/4vp/t78v5jZ6lEQPNnaYqOrj3/UX5iBcwR4zbwZSzyhE7d5NB
 3hWBxV1C5mjrzZMr+pfbl+oADBEVUG4+FSu6l4nl1/5bkiPV07RJjYDYcKL8EQo8j9fTAN65
 5Cd8n7uChzxTfHy3wwzeE9rkOPiRtpP7T//mNirMsCGPpsiax/3q/WKSU8XjSD4EOUNhEHjj
 st7ztZaMKHUG3YZnPwmNtO8y78VdiGhGEVDZvNQpIUyAmDWfWCJ6wikckyeVJtEGK3XzBWeF
 cdrG8NoUia+3gaoqhQwJ/YFA51wrc4TyOsyQJHZDk9YjOLHtRtsiozayQbmjmxyQ9lOr9c0G
 rmMSx28SF6vlVlmsE6TivkcIWepQ8g2VCul1sCPzeg5PZYisuZtTEIM7oWJr0ilaAtKwhbFk
 z7ANon3zvNjw7tCh4HDMLtOLCTqJMLRVNanyhGSsdNPYYnxMOPLjQc0q0bmDStSL7A+S9R6r
 pXTkd/VjWfunqc6bHDdoLaFT5J23MSVWPFFF+7KN1xYoHeyY9Dt6B495GyIE5xFv9dD7M2BR
 QHjSs+PWfMKetVanlt5VjN/FksDNqHJcavQnyOxgPCSABw70wacDteG92fsXF5LZB0zJJzyJ
 Q/licmAvukCgtx3OyYFIPV6D7tTAlzpA/ImfuKskwioNDCjh1fat4bykRYl1yrwNUCFN8TEs
 KL1Hk20MFz4vazT19hWvrBjphBdXj43neA0eVlb4NJszSyzCGkdN+kGLJEaEddunzfv0I3jL
 iT4BIf45f4RgRwfGfk93DjiYutbLukJJ8u/OTEjuU+ZA8tz6EVsH5M5nhqMIV8vEtcg8A1jA
 c4T8Dv8M3BdB7l3EP0L6KXTbfhPn5vnK7Fhxaw5u9P/CVASDN3mEZCn8BVlDUT6Li0GqKkHy
 aXZi4yJrIFXhHMdyfpdRkM=
IronPort-HdrOrdr: A9a23:yBzQL63BcjDvzhtW3kTtwgqjBGYkLtp133Aq2lEZdPWaSL38qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyVMbEQt6bHCWeDYrQd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:OoK83GFvMLWHHhuGqmJdzGUTPuklcUbg1WXBAhCmDSFgUb6KHAo=
X-Talos-MUID: 9a23:iP4QoQjY5J0FXrudQI1VgsMpD8V3yrmNDlA3i5AglM6FPy5oNBSZg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,218,1677538800"; 
   d="scan'208";a="104299553"
X-MGA-submission: =?us-ascii?q?MDEee2JIC5XnuII8Ja+iYGq1zm1AU5Ny8F2mcO?=
 =?us-ascii?q?S20SDNMeyjoYTbU8x0TfWzyDvnKEh8PQOdaTi4FDTY5JbGJQYHNCNl3s?=
 =?us-ascii?q?uq6RcQrKWOuVJNiJ2lH8AHemYS43KncH+1iCUFcIRaG/umXHHpsGWTV4?=
 =?us-ascii?q?NFLe86ZBp8S0IiIRU1tE0ksQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 17:52:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682178757; i=markus.elfring@web.de;
	bh=PcjBkGVIHYCmrN3jJYqvaXOT7tuO6/mFkZODgHZKl+k=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FMNcTof8D1kNKcCdZt5apyhvJe8w3i0DrrjJY4fv8cpdlKl3m7HWcLGkbmIKl0nQM
	 vdc4c2POJbaON3v0307YIv5h05jW0stnvI/l5AyfQQUETEUE0DuzvnEx2Vqm+kdLRB
	 qXdOSx37UHNWwhJ+LWy575zkEn1/aoKnWT1UsIQI2jLcmUa7ItO7B7GjwKSw5eXMLj
	 aN9KJN6kqCLfIX/vkSUSO0d1TJgAey2tqQwEvsztIe4I7O54k15AuMbDJiPCiMUGLG
	 IVi9kuc4TzRqrVjrXwvRang8+ZWRkbdoGt0kaxj6OcAE4bitGCXZOJ5GUdkFxRylRX
	 rDveqd9Et/0RA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3GgY-1qHR4h16Fm-010Qri; Sat, 22
 Apr 2023 17:52:37 +0200
Message-ID: <8682abda-5722-502d-7bc7-4f646e68e6bc@web.de>
Date: Sat, 22 Apr 2023 17:52:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Thierry Martinez <Thierry.Martinez@inria.fr>
References: <037507d2-ab0a-7d93-bf3b-10e51e70fbc6@web.de>
 <alpine.DEB.2.22.394.2304221031370.2766@hadrien>
 <e170b7fd-c7ff-c3cf-db35-0427833a8215@web.de>
 <alpine.DEB.2.22.394.2304221724070.2766@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2304221724070.2766@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D8xAkuMXIu5vlTPfQXTxhefnIN3w+WYiJSD1/0gucawPhPtPCFx
 pPXiFILOhUhTVhXIVQ6T7UgKqs2RwfC/X+9m/+Wpj1LZ+uQexpo5j8H+ZMdvZs/h19RLxFI
 2PMI9ofaWJNMTY5azTwqFTsvkodPzyDMaKaGWmwupBzgYxBmKSMiL7xiwCcNtlSMyfFMeEm
 NbcseHhNP4JuLWs0pkbdQ==
UI-OutboundReport: notjunk:1;M01:P0:LRCcWlbYeok=;FlnlDu4sSnaR0GL5L4fnLxbHF0c
 N98g6EaUgE/ZSKNa8MNxGcwGzgQLPpVdJgJ+w3z2cO9gT52PqH6yveglBRaNshQ+ux2cUQknb
 YG8MUFtrgGPypGJP8RAysw8pjkaSDLSypm8IxjpKnBvd4zggI8pH5/frKzJks8yGiDjqSWF4t
 3SCnYxtsuP5RhBK/GOD/rm5WE3GyzDnHxhqQbC1EsAioKx3AEQ6ea9EGUq0eMkvVpY9ts/01w
 dPQ0UiepA9R1CzV/7Uy3iKzayvCdzFexJLbUnoV3dN0DgijB+/LEf3SSg7sj9PewKH7+I83b6
 41blGPA01aCyaX8tHHUE3GELRjdl1SAhmlmo3FU8pfJU2CUMNiqr+FSsQVBTMdKfXyvHoF0yZ
 U2fJXSqnu0RZ7lK3reQAsi+kpP1fsa0juZef1ftR2CuActxXs/RpoIa4qUFWHj8jwuivLA+gn
 zMYwUjLjx2xIn5HA9baZKEXLstf6kCSqI/JhKdx/7fdsZetGetNrrn5tt03Zo2kZANx7+jGEC
 KyqzEXXZQwrQznLKpMAHv2VTHyKbqGOk2bsRzudJXYdeFweaybFi64wwi5zOKkHlR+Mu814xJ
 ZK2eHYm7Xoda1le0IhHTijw+5dVZhummD2N15eP3ovadX9zJaBPcCMYKx9RLXoE4r+GOimECE
 47FZy6mPaWERAB8CyWDWr03nMxoA58XzYK9c/H8MkeltpGscx+SH+3hjZKtqll8ANsxJffHhl
 cHVKaGfTEld+z9xs7o3bHpFmATWJrXaQcwOya4t2HRNnxcFHfKFBUMgOqAgSVrG1/J2jx/2q8
 rpw0Y/WkqPeJPmqvVA/w7BddYXSRtknPW5A1yWFE7EzI1JaQvpQPnOqoEdYTNwYiLKJPgFd6Q
 JltjvCypp1FEVosNzuWnVD4ASQsxmYv6UI10JAWob+j9tCp+uIiSooRpmznVzq+8WSWKiFEOE
 nCCkOP0zzrafrLj+JfJCTJQCEyE=
Subject: Re: [cocci] Checking data processing for capturing groups in
 regular expressions (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1120
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/8682abda-5722-502d-7bc7-4f646e68e6bc%40web.de>

>> How do you think about to omit extra white-space characters here
>> before a double quotation character?
>> https://en.cppreference.com/w/cpp/language/string_literal
>
> OK, maybe not.  Maybe you are concerned about something related to white=
 space.

I would appreciate another bit of data type safety also for this use case.

How much repeated data format checks can eventually be avoided accordingly=
?

See also:
2016-01-06
Support for string literals by another metavariable type
https://github.com/coccinelle/coccinelle/issues/55

Regards,
Markus
