Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFABCE67806
	for <cocci@archiver.kernel.org>; Sun,  3 Nov 2024 07:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gl9xHtHfA3dA0h3+mLeHqiOVA3B3AdSWSrVLb4ygOY4=;
  b=TIYX81ZZOQnknr6qFT9KzMmkLv3qEFAGjClS7sQxPdz/WkGBd+rIlfuf
   VLhNyQ5sBLrxGnfrmd0m/ZekzJKOMcqLzMJ2yo8NN4Wi5jLtNZi/RXtSi
   fY8S7LAyYYuy9hr9eavNnt0hiQ3JTQJoFYAvFNVXimmBumXkidZ9q8yNq
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
X-IronPort-AV: E=Sophos;i="6.11,254,1725314400"; 
   d="scan'208";a="191849805"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2024 08:21:48 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B5CA9E0133; Sun,  3 Nov 2024 08:21:47 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 80C92E00B7
	for <cocci@sympa.inria.fr>; Sun,  3 Nov 2024 08:21:44 +0100 (CET)
IronPort-SDR: 67272488_oG67faeM58NFDF0H52711fHNP+DciJhGt0Di4bfaKOfCDHz
 ROt2EupKA98dm0O7r+empp+TtMuq1Z28iL+CWYQ==
X-IPAS-Result: =?us-ascii?q?A0HjAADSIydn/wwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDB3xUMwQLSIRWj02BdC0DhDuHOodViHWBaoFqDwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBIIMgnQCijICHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQKBCggLhTVGDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBE?=
 =?us-ascii?q?ScECwsaAhEVAgJWBgEUAQGCfYIwAQMOIweuEYEygQGCDAEBBtpbHywiV4FjC?=
 =?us-ascii?q?YEaLgGFaYJiAYYkhDwnD4FVRIE8glIxPoN8Rz+DHIJpgk18RBODTyVNhBGCI?=
 =?us-ascii?q?oEKJWiEAYNPUYVOY1GIGlJ7HANZMgFVExcLBwWBKSQsA2SBF1h/gTmBUQFCg?=
 =?us-ascii?q?l1Kgz0cgUUFN0mCSmlNOgINAjaCJCRZglCBJQQFg2+BC4NnhGpAHUACAQttP?=
 =?us-ascii?q?TUJCxsGPZ8LgjRsgR1TggI3kkueK5RbNAeCOIFlgWMMn1UGEy+EBJM7DgaSe?=
 =?us-ascii?q?Jh3IoI0pkuBfSeBWTMaJIM2UgsOD44hhC3EBEI1OwIHCwEBAwmFRgEBiWKBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:k+9f5qIW6pwW6oGgFE+R/pQlxSXFcZb7ZxGr2PjKsXjdYENS1DdTz
 TRNCmrQbKyDNmXxL953Yd+080gGsZHTn4UwTVEd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fSLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgb8s9JIGjhMsf7a8Us05K2aVA4w5zTSW9gb5DcyqFFOVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuEl/uFIorNfofTKiXmcJaKVeS9oiY+t5yZv/R3jndaPpDXmxYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes3X0GIvFLLveBCCXcKvI0LuSVDq5+dJU0IMBJwF495UAn500
 qNBEWVYBvyDr7reLLOTT+5xmoI8IcOtMI53VnNIl2iDS6x8HtaaHOOTv7e03x9o7ixKNdPXf
 ckEcnxCaBraYhtAEkgaAtQykY9Eg1GmImQI9APF/fNfD2773D4tzJLwHcrsW4aoYppYzwW2n
 ESBxjGsav0dHJnFodafyVqoj/DGmSfTSoMXHqexsP9smlyagGIJYDUdUlCwoNGim0umUpReL
 VYV82wgt8APGFeDS97gQ1unrXTCshN0t8dsLtDWITqlksL8izt1zEBdJtLsQIVOWBMeLdDr6
 rOIoz8tLTloraHTVn+XsLuZxd931e75MkdaDRLojyNcizUgnG33pg3CRJBvHcZZS/XrTCroz
 WniQDcW3t0uYA1i60l/1U/KiXSgq/Ali+LzChr/BgqY0++yWGJpi0FEJ7QWATas4bt1lmW8g
 UU=
IronPort-HdrOrdr: A9a23:Rgyct6NgA6ThLsBcTh+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:RgzaS2FnFPl2DEOgqmJd30gwCOd6cUfk3WrJG2y7FlxOF+SsHAo=
X-Talos-MUID: 9a23:TIiYtwhrhv4ESf4X9iZqmMMpJPU0/46zJVA0sM8knJaJZG9eARHatWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,254,1725314400"; 
   d="scan'208";a="191849801"
X-MGA-submission: =?us-ascii?q?MDHftC1saKTQKHqgM7iQIXEX1/qlaaKAD0ANB1?=
 =?us-ascii?q?H01J3FqH6u+7QnOhX0VrMFA5+2jwBFegFNLSjKPHcIGcCgnDlgymkxgf?=
 =?us-ascii?q?T4GZ8qt0VXJ08No7ixgZ0+z2HBPX8+nXcq2NFpIAGoA9wfwTrJiBDRYy?=
 =?us-ascii?q?dXjW/U8q54xoKQT2X1EmxNmA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 08:21:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730618493; x=1731223293; i=markus.elfring@web.de;
	bh=gl9xHtHfA3dA0h3+mLeHqiOVA3B3AdSWSrVLb4ygOY4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f+WJqWmJ1Tup2lzh6YXQ59gwrB1Q8FEWs30GcmieLvJ7xaRbFBar878SsUOoSjj9
	 hkTiNfDQj+yU4d4ot5E0epWTNjDVSf/99FncItByhXBjQEO+TDhJvR+cA/+ZmD7ii
	 sBzEYBTDvSikbwa5hJ1KRGzjT+BGMkRMApHD2fkWc88bUw+8SICIKGgPTpZ2qbxIu
	 FCWsD3StAintDuR7glpF57udaevcGxsQ/riTn89CnwIz4diV0SGZZQ3LFhszwEy02
	 CP3lD1aM9bPQl7F4KEyU+AjeVOi6ieR6KNt4PfznPSI1g4jXVx0GN3L0h8px3IU2a
	 0axIkEFUmeizhHTBnw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1aDp-1t8sty0zXP-00FOWB; Sun, 03
 Nov 2024 08:21:33 +0100
Message-ID: <dc91ad35-d571-4d0d-b0a6-1c3fe468b9f8@web.de>
Date: Sun, 3 Nov 2024 08:21:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <922a51a3-ec27-4059-8697-09c90385ffc9@web.de>
 <alpine.DEB.2.22.394.2411021921580.15958@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2411021921580.15958@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KFxvOT6zlIaLoyVotvZU1cp/C1kNrNNzj/nn/CKw07C7PeHIdtz
 ZAdlspt1w/xDFdVdO6vsdKgmOTzv5yLljBh2UlOPiSDSAuzVjaM9blHDg191EEDGUTWSQfv
 6S//fvHncWZt5IqM4TmbsZ3SIURn5yYYSWDthN5VE3hCa7DIvh7+Dy9sR4pbz7FVrnMSjYF
 xnBr8IO+Rf00UyvwB8Hag==
UI-OutboundReport: notjunk:1;M01:P0:7iVv7RWD+pM=;W9RdWBzK9mFmgWAzeaKFOhP4TDR
 pAoqZJ3xFpBI4DmwStfY2NpUDkzg2m0tU3ZpbJ7CGmfNkJFi64FuhPfzpRnE1zZ6GsrtSP3xi
 0Hl5uYXRhTHd6uXegsCuJxKZk4Jm/T5/yKSO5qPo4LWp//0DAUav/8gl4Iu0szBIGICiqZ0l/
 4QqUaHSE57cPGLjJy4jOFgjkWbucXfg3Cy4r5sNYdGVwHTuG0zyBdBe7s/00c+z1qVFl7osQB
 NCa0L+vRZANMP8i91DzJgmGXoYDhaNwcJSSbYJKw+FPgseAbRBj7y6TcWGSyuroY9hTVBLlr+
 pm5cmZIob/AOxtOrhRPjgwc3lNJtpZICK7vnVhYN3PlFS2otsHg4CrMRwSua0MjBqEQ2kxrbG
 B0yuWS8nSrzOTYKXT5tNoZ5fNAWAPhqXPUjnpD21FKyyPgEJeGEoP5ObMkChx39ex5efm46Su
 ekcrCudt3skCO48HSehzBfEaVRKmROdtEztK+xuz54excE5TArFpy1xHTHZUJy12HcAFMU+nZ
 xkH4tkyPT7iD2GKEF9x8LKjrvw0u2nn6gjWGiQ7S0Hfnh+0814ARShXo5buepwCkSnGfO+7tB
 ZtpFv73gWRwJrZiu5ee056aT+Dq9JXn9ON7ZlZ0JCiAhU8udqB2SEbamTDN+pPAm4ppjPWS/L
 T7oalDfkKY6vyGsxQabcnIQdMTvA/ovJwKJAewFhtbnbpfKBzqD5C/DLzY71MbEErPyXZWtfd
 wN0RNElBCveI1RwADh8j7cWZOBpQm09wEmcODs1vK/bWMPOnrwcaOAGRA4GiT0zpvhbzrmvO0
 vw7eCldEhJo2Dx4GenhwQXFg==
Subject: Re: [cocci] Searching for selected identifiers in code parts (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1962
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/dc91ad35-d571-4d0d-b0a6-1c3fe468b9f8%40web.de>

>> Can the following SmPL script variant become similarly usable to find
>> remaining update candidates?
>>
>>
>> @display@
>> identifier i;
>> @@
>>  while (
>> *       --i > 0
>>        )
>>  <+... i ...+>;
>
> Use (<+... i ...+>);.

Thanks for this adjustment idea.


> Of course it looks nonsensical,

Interesting view, isn't it?


> but it will get it through the parser and an isomorphism will drop the (=
).

Further insights might follow.


> To avoid parser conflicts, the parser needs to be able to decide
> immediately when it sees a <+... what kind of <+... it is.

Will such information influence the evolution of any corresponding softwar=
e documentation?


> The choice is that it is the start of a statement in this case,

Variables (which refer to macro/function calls) are usually not decremente=
d.


> but that turns out to be wrong.
It seems to be nice to find parameter applications in such a succinct way.
Would we like to take further case distinctions better into account
(with the help of additional SmPL disjunctions)?

Regards,
Markus
