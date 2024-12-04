Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D87E7716B
	for <cocci@archiver.kernel.org>; Wed,  4 Dec 2024 07:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6gv2s84rpgUGhAvK3I+ifbSOWOyLG5hkwDmPNW7qbbM=;
  b=uTKyDnxmBBFxxz8/hL35fZqgKC+wu14pJav3y7NElMV6EDIbWglmMg5k
   VJyOWwfX7Z9JxsLtsJ+h9ndqsHxvD7nVoa4hbfAgizXjqLkm2vyOuhFgX
   1XXo70PofULAzK2T70hObNdFHRXmyHDyYsRjS8apbHMO/u1vtfGkHcxEw
   s=;
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
X-IronPort-AV: E=Sophos;i="6.12,207,1728943200"; 
   d="scan'208";a="197241817"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2024 08:56:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 168E5E0D1D; Wed,  4 Dec 2024 08:56:33 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 96F09E00B6
	for <cocci@sympa.inria.fr>; Wed,  4 Dec 2024 08:56:26 +0100 (CET)
IronPort-SDR: 67500b2a_iXl1ps/oGFhBzzhCZlOlUhpV9zEWmoJrCxVkEn1Z7wZSARH
 rvoyjdkZ8heZ6B7ZXhvjQpcRjEbzjL7HzMDZE8g==
X-IPAS-Result: =?us-ascii?q?A0EECACYClBngAMP49RaHgEBCxIMQIFIC4JEgQNUMwQLS?=
 =?us-ascii?q?IRWj02BdDCEO4c7h1aIdoNUDwEDAQ1BAQIEAQEDBIUAAoppAh4HAQQzBg4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CYgGBJ?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREnBAsLGgImAgJWBgEUAQGCf?=
 =?us-ascii?q?YIwAQMOIwexJYEygQGCDAEBBtpbHywiV4FkCYEaLoVqgmIBhiSEPCcPgVVEg?=
 =?us-ascii?q?TyDAz6IHoJpgkOBNoEzgikliBhoim+RVFJ7HANZMgFVExcLBwWBKiEsA4F6T?=
 =?us-ascii?q?n+BNoFRAUKCTkqDLoFeBTdHgkppTToCDQI2giQkWYJNgSUEBYNpgQuDXoRbh?=
 =?us-ascii?q?iyBIR1AAgELbT03CQsbBj2iSYNIgRWBCaY4oTg0B4I4gWWBYwyfWgYTL5dDD?=
 =?us-ascii?q?gaSeph7IqkIgX0kgVwzGiRPgmdPAxkPjiEMFoQLwA9CNTwCBwsBAQMJhUYBA?=
 =?us-ascii?q?YoFgUsBAQ?=
IronPort-PHdr: A9a23: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
 QPNo9Qor1z0yoGy
IronPort-Data: A9a23:oyzgMKudLkUFxpbrVir8QcBknefnVGhaMUV32f8akzHdYApBsoF/q
 tZmKWvSM62NY2uhe90jOYu08RxSu5LSzNRrHQQ4r3w0Ei0RgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRNscpvlDs15K6u4WlA4gRnDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJEtxG7Ya3PxJPVxHr
 NZfMTcxZC6+msvjldpXSsE07igiBMzsIZ9ZpXxqiz3UZRokacqaGeOQv4AehWp23aiiHt6GD
 yYdQR9mdhfdeFtiPlkNCZQxtPiljD/zflW0rXrM9PVtvzGDlFYZPL7FN9TVIoelfdluz22Dj
 Dnd4mbJJhEaHYnKodaC2inw1reUzXyTtJgpPLa//fVrqEaCw3QaThwQT1qy5/ej4nNSQPpaL
 FEIvDUjp+4++SRHU+URQTWy51i/vDgGZeZtGrQQrxiK9qDq3huwUz1soiF6VPQqs8o/RDoP3
 1CPns/0CTEHjFFzYS3EnltzhWzpURX5PVM/iTk4oRwtz/SLnW3ephfIU8olD6O/yNH4cd0R/
 9xohHlk71nwpZdVv0lewbwhq2z2znQuZlBujjg7pkr/smtEiHeNPuREE2Tz4/daN5q+RVKcp
 nUCkMX2xLlRVsrXyXTTH7VVTOjBCxO53Nv03g4H834JqGXFxpJfVd0KsGEWyLpBaZ5ZJWe5C
 KMtkVkLuMANVJdVUUOHS9ntW5xxnfeI+SXNV/fSacEGeZUZSeN01HEGWKJk5Ei0yBJEufhnZ
 /+zKJ/wZV5EU/gP5GTsGY81j+Rxrghgnjy7eHwO5073uVZoTCTFEe9dWLZPB8hlhJ65TPL9q
 ocObpLQl00HC4UToED/qOYuELzDFlBjbbieliCdXrfrztNOSTF7WczCi6gsYZJklKlzn+LFt
 CP1EExBxVa1wTWNJQyWYzoxIPniTLRun0IdZCYMBFeP32R8QICN6KxESYA7U4N6/8NezNl1b
 cI/ReO+Ptp1RA/qwQ8tNavGkNQ6dTCApx6/AC6+UT1uI79iX1Po//HnTCvO9Q4PLHGFiuojk
 ZKd1yfwY5kKdyJ9Bun4NdOtyFKQuyAGueRQBkHnHPhaSH/OwqNLdRPjv6QSGN4eDDn+3R6Y6
 lqmOggZruzzvIMFytnFqqSapYOPEeElPE5lM0TEzLSxbw/2w3GCxNJebeO2YjztbmP416G8b
 +FzzfunEvkmnk5PgrVsAYRQ0qMyyNv+lYB0lj0+Mi3wUG2qLbd8Ll2t/8pF7PRNz4AEnzqGY
 BuE/90CNIiZPM/gLkUqGzMkSea+ztARpCjZ6KUkAUf95RIvxoG9b2dpA0CuhhBefZxPC6F05
 cc6ucUT1R6ztQpyDPaCkRJv1jqtKl4ubvwZk680Ua7RtxoT61BdYJbjJDf8z7ORZv5tbEQ7A
 D+mq5DTprZbx0D9IiM/PiWW79V8mKYhhRFu530BLmSvhdDqqKIW3hpQ0DJvVSVT7ExN/NxSM
 1hRFX9eBPux7RJ3oslcBUa+NhpkFjTA3mDQknwnzHb4SWusXUzzdFwNA/6Hph0lwjgNbwpl8
 6G940e7dzTTJeXa/DY4AGxhoNzdFe1BzBXIwp2bLp7UDqsBQGTXh4G1bjA1sDrhO8Q6gXPHq
 cRM/Opdba7aNzYak5YkCru1hKghdxSZGFNsGf1R3rsFPWX5SgGA3TKjL0OQeMQUA9fo9US+K
 dJlJ+MRdhCY+RuNkAsmBv83E+cppMIq2dsMQaO0BGgkt7DEkCFlnqiN/QfDhUgqYe5Ur+ADF
 q3reQi/T1Og3UlvpzeVre1vGHaJXt0fVQitgMG36LooErwAgsFNcGYz8OCGgFSIAiRa/ja/n
 gDKV4nJxcNMlKVumIrNFP1YJgOWcNncasWBwDqRgf9vM+zdAJzrjBwHj3XaJCFUAOchYMt2n
 rGzr9LH5kPJk7IoWWT/mZPaNa12yeitfehQaOTbEWJ7mHacZcrS/BczwWC0BphXmtd75MP8Z
 Q+ZatO1ROEFSeVm23xZRChPISkzU52tQP/bmhq8iPCQBjw28w/Ndoqn/EC0S1BrTHYDPpmmB
 zLkv/qr2Mtjk71NIx05HNBjPY5zJQ7yeKkhduCpjwKiMEuTvgqgtIfhxD0a0hOaOkncRYy+q
 djASwPlfRu/hLDQwZsL+8ZutxkQFzBmjfN2YksZ/MVshiunCHIda94QKogCFooehxmaOEsUv
 90RRDBK5eTBsTV4ndHU5dP+QkGAC+ZINtqRyvnFOa+LQ3/eOW9CKOIJGuRcD7NeZTbpiu2qQ
 T3b0mOlJQC/m/mFWs5KjsFWQo5bKjfy2X8Cv0zw+yA379DyHp1SvEFc8MFxueAr3i0DeIgn5
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:PURVJKwR6R4+Ku0RUIrtKrPw8r1zdoMgy1knxilNoG9uA6mlfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8Q3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 VdmsNFaOEYY2IK7vrS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-Talos-CUID: 9a23:PJZ3NmME3bCWJ+5DUm5Bz0wyAP4ZT3SE5jDJJHOyN1t0YejA
X-Talos-MUID: =?us-ascii?q?9a23=3AoYQmKAyTBtEZavTwFkiKLWNepmCaqKOgCBhWvq0?=
 =?us-ascii?q?agJivLgYrICqfvBC3QqZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,207,1728943200"; 
   d="scan'208";a="197241802"
X-MGA-submission: =?us-ascii?q?MDHxjfKamqs60srAEPKACJE80hZT60pNd+qwg5?=
 =?us-ascii?q?BEBpM3eB2YzCHbADK249l3L0HlhgB2dH5hSZA34Fh8x6FK0u8Y+1Z8Hx?=
 =?us-ascii?q?vNyen+zMMpWnbm2VvzPfxmyCRZu576zfOOQb4eRF32lvt/3xU4VkR2VD?=
 =?us-ascii?q?+0DdJSU/ZT1/E2tRLzN9CIuw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 08:56:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733298985; x=1733903785; i=markus.elfring@web.de;
	bh=6gv2s84rpgUGhAvK3I+ifbSOWOyLG5hkwDmPNW7qbbM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BAtzd3UQWZV1g7Ztm07o4CoUINOVu/Lq9Isxfm7dbkB9wCgixW1F8Jknswuph2kH
	 f3z6uUXByKgStMsIriEkzIgJ/BOeboDJTMR6OHj/T130NnQEkJihLwAtmNPyOCZdN
	 GhFMwzk0kc1L+/nq+/QQYhcF4WLRXzDiwXTy9eqNGilv6g22acu4E4XxDtiZZfyxy
	 TSAy3NHwnsry+++LDPaE+sG7ecJe3UAHNZgbo/OP68PxasUfS6A4NIpA7ukz/wI/x
	 /zuSb5HC+CdBcPSlDmHz+rhB1k4wpBheEtbegs/xt3UeFMG+QMgJwPC8QOvnTAc1X
	 PGJLylMQoYLiqAwRcQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mfc4q-1tptCr28ZE-00eEQB; Wed, 04
 Dec 2024 08:56:25 +0100
Message-ID: <dff4cbd9-00c1-47a9-b2f7-fb2e98d04433@web.de>
Date: Wed, 4 Dec 2024 08:56:16 +0100
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
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2wB71ha7IwpyozuF5xxJEV+d5F7+/FXVowBenwbgHSFdxuQ6bDV
 yfp9M/NlUwFLhCfV46oyM+HmlNmzv5FpsOcB2SYHF5BomGbyje7Pq3fAZdf9uAiIw1HixEd
 6Ut22JtghaCXsljMpyqSMC0aLg7tbqjc/xC1UBpeBhpLwazsJsY2v7iXOaQm/v9J6WEsUTA
 jVXGzrdsh01RhnKdwKdCQ==
UI-OutboundReport: notjunk:1;M01:P0:KVmEQpPemZ4=;ileUsBmlWPq2YLz9ZXi+cCnKPXL
 ShrX/QLtgWPhBXfCyoh6Pgj6e7/Zmrow5cI66hFnxaJFNe3dFwCkJglU5Y9dZo09k4CJeIgGn
 TFbuTvxenStGZKKatH30498O6bZh0x6mcPz2dchYfRUS3rmq5K1audWQ5QJ9SapEbEkspouft
 cr1dA4DL9LLq1E2klyVnsk8AMnzqOqyjg3YFCo6DHi0nnD5+vfF/dow1zo5Bo5kGTGwR+Np30
 faHOZTvHPTU9z1wpTMqKDVkoVtY9/gmOL9pxIsabcaT44okTa2ABntjMoBwkpV56p2NMUsdcR
 TyLMiHTsCBCdLDjNaf0qXCtUJ/1x3He8TyJ5UrMLqJuZGJOYhzvskSt94/0Ia9UElVTyWJNy6
 8sRojp9VlIdr3lZ4DcNYOyjQTbnTgMNsGQGFWe9xrp3mgIhCKc6g3wnKEpfgKiAzo8h4UdV3t
 guFazhoJdOgB7Ize8HUnAdkqkRaN2QDZ87f8iPxuu5rOJPPoPqw9oFIg6EemIZafsJfqjtR4b
 oWxPWU5Rl1fTNSETLg/Dn9dJCRjpTAHpza5KbnqqX7itMJUGU2GbptL4c1lYmpH4JKY1qBh7G
 D5Z5umCGi4LYL4ecx5iFY9B25e8ofe/a3rHrVdh1qeu0wO0r6dvPz/FLdpzK4lO9+vjtKDw3W
 uB+N4ZwXVikhlaNB3CjHKfitoINOuHb+gI9X/vkl1K0yy3D7aOIjAw6MIK5NQxsuLsISfH+nK
 slUvBD9vTac+8+rrFlncy/iUfqvUUGQer1A9QPLQsKsneyaPLFbR9pLR0J7W0aonLd9g+KA5L
 vShOlA2ZskfmF//iPu4zztZrjaGZGvzPJRD3TijKpRlywuQghr25onIjOMIkJj28a+qj6II3r
 t18mi05xs/JFoaDpXR5Qy9g42qVtJFo2w90I/g/6HBjpHUeDHxhBOVWc1rABo6o18U47K/uQh
 bK9lEKtkMbearsk/BgbAq7iXksLUb/HrDjIaJZYtL6jYoJ+gJww5ah3zpuINHyyCn5qhBSEjj
 dD8GueMt1jLFtTrI96ynw/M4hTlL3zmNR7JoICKON10ugXD/kmBVVD56l+yLQYOwj7mcB0YQn
 SRPsu73NM=
Subject: Re: [cocci] Replacing type names
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2145
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/dff4cbd9-00c1-47a9-b2f7-fb2e98d04433%40web.de>

> From the sample_case.c I linked before the two constructs I'm having a
> hard time matching are function names in definitions and type names in
> parameter list, i.e. in
> static bool SomeDeviceLocalCompare(SomeDevice *localDevice)
> neither SomeDeviceLocalCompare or SomeDevice seem to matched via idexpression.

* Did you find scripted SmPL constraints more attractive somehow
  than script rules?

* How do you think about to choose more appropriate context information
  and corresponding metavariable types?


>                                   What I decided to do is simply use
> Coccinelle for the things it's perfect for, which is all the code
> transformations that are easier with semantic understanding.

Do you find any related aspects still improvable?


>                                                              For the
> camel case to snake-case I just have a "finalize file" python script
> that simply does:
> for line in text.splitlines():
>         matches = re.findall(r'\b[\w_]+\b', line)
>         for word in matches:
>             if needs_rename(word):
>                 line = re.sub(word, camel_to_snake(word), line)

Why do you think that you would need to repeat line and word splitting here?


> For now that pipeline is easier to maintain than trying to come up
> with a way to match any arbitrary type, parameter or identifier with
> Coccinelle.

Will the awareness grow for the means of the semantic patch language?

Regards,
Markus
