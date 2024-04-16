Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19388C4345F
	for <cocci@archiver.kernel.org>; Tue, 16 Apr 2024 11:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=z6yCp8A2RnLDBkLpXNPwXaq/ZW8mMLmH/UyxYRY5y5o=;
  b=UQJfqBQTioc8YbxJU2ebMUpA4mOzRXNxfPCcpGGEERlBH9Hz2gLPuJ36
   eQiil0azTdy5/45Z1uGboUqxbvi0ISbPA5mO/TwPexiEqZ0T1kwSQ81eN
   MwxGIKRTBcbbSK7Z7rFbG9xEb/kvvIGEuvYSFgYeiU64k3bpQOF8XCkfc
   w=;
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
X-IronPort-AV: E=Sophos;i="6.07,205,1708383600"; 
   d="scan'208";a="161844849"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2024 13:50:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DAC1DE0138; Tue, 16 Apr 2024 13:50:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E71A8E0035
	for <cocci@sympa.inria.fr>; Tue, 16 Apr 2024 13:50:23 +0200 (CEST)
IronPort-SDR: 661e65ff_JltlaifeXWUgkUDnT4+V8HFj88LMgp0C10nBgVC0opeD7Nr
 83j+UCln8yMmSpbDw8hacdvw0CzwC3RnmEJ5diQ==
X-IPAS-Result: =?us-ascii?q?A0FBAQBiZB5mhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYJDf1MzBAtIhFaROzCEO4c4h06IcYMWPg8BAwENQQECBAEBAwSEf?=
 =?us-ascii?q?wKIGgIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?QEjEwQHDhAnhW0NgmcBEIEOgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdCAQEBA?=
 =?us-ascii?q?gEjHQEBESYBBAsLGgImAgJWBgEUAQGCfIIrAQMOIwezfoEygQGCCgEBBtpZH?=
 =?us-ascii?q?ywiV4FhCYEaLgGILQGFfINGeicPgVVEgTyCSzg+aYc1gmiHR5Q0hiNUfRwDW?=
 =?us-ascii?q?TIBVRMiCwQMGgIbFA0kIwIpPgMJChACFgMdFAQwEQkLJgMqBjYCEgwGBgZbI?=
 =?us-ascii?q?BYJBCMDCAQDUAMgcBEDBBoECwd1gXyBPQQTRAMQgTIGig8MgzEpgU4pgSmDC?=
 =?us-ascii?q?QhDcRWBCAKCfYFgA0QdQAIBC209NQYDCxsGIgEdySKhIDQHgjaBYIFhDJ9FB?=
 =?us-ascii?q?hMvg3IBk0UOBpJomGIgqGWBeiSBXDMaJIM2TwMZD44gGYQUlVlBNTsCBwsBA?=
 =?us-ascii?q?QMJhUYBAYNagUgBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:V/ciSKs8yQZB2YASEue6SEr+VOfnVJNaMUV32f8akzHdYApBsoF/q
 tZmKW6APfqOajemf9BxbY3l9h8H6JOEytZmSFM/+yBjQ34SgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRMtMpvlDs15K6u4G9B4ARnDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJGEzOLUy5cZOOG5tz
 NEoKjEgSTC7qP3jldpXSsE07igiBMzsIZ9ZpXxqiz3UZRokacqaGeOQv4AehWh235km8fX2P
 6L1bRJKZQ7DfgYJF1MZEpM4k8+3i3O5fzAwRFe9/PRuszSPnFYvuFTrGIfff/3Wb55YpFy/v
 H3i+GXSEFIdE/XKnFJp9Vr32r+XxnOkMG4IL5W8/+FjhFm71G0WAgcfE1q9u/iwzECkM/pUL
 Ecf+wI1vK0q/QqqSMP8Vlu2uha5UgU0Xt1ND6sl5QvLxqe8Dxul6nYsbjtEUPY5lPYPSh8T+
 2+Lnv7OJQRAr+jAIZ6CzYu8oTS3MCkTCGYNYy4YUAcIi+UPRqlt0nojqf49TMaIYs3JJN3m/
 9ydhAQT74j/YOYO0Linu0/KiXSgq/AlrzLZBC2GBApJDSsgOuZJgrBED3CGsZ6sy67EEzG8U
 IAswZT20Qz3JcjleNaxaOsMBqq1wP2OLSfRh1Vid7F4qG32oSb+LNEMsWsuTKuMDiriUWC1C
 KM0kVwNjKK/wFPwMfUoC25MI59xk/OwSbwJqNiLM4MQCnSOSON31HoyNRbLjz+FfLkEkKY5P
 ozTasvEMJrpIfQP8dZCfM9EieVD7nlmmwv7HMmnpzz5ief2TCDPFd8tbgDUBshnt/zsnekg2
 40CXyd8404FAbWWj+i+2dJ7EG3m2lBhWsyu8pEIJ4Zu4GNOQQkcNhMY+pt5E6QNokifvr6gE
 qiVCxEGmmnsz2bKMxuLYX1FYbbiF8Q353EiMCBmeR7i13E/aMz9pO0SZrkmT4kBreZD9P9TS
 +VaWsOiBv8UdC/L1Q5AZrbAratjVi+RuySwAwSfbgMSQbtcVi3S29q9fgLQ5CgEVSW2ks0lo
 oyf7ADQQLtdZgE7EsrmUe+jlW2wmX0nnMNzQEr6Dd1Bc2r88IVRCnLQj91mB+ouOBn81j+h+
 ALOOighpM7JuJ0Q3OjSoLKt9qOFMrJZMBJBPm/56b2WC3HrzlC7y9UdbNfSLCHvamzk3Y6DO
 8NX9qjYG98alg9ot4FcLe5a/Zgm7YGym44AnxVWJ1SVXVGFEbg6H2Kn2/NIvahzxrN0nwu6d
 0aM29tCM4WyJ8LXPw8NFTUhc9i8+6kYqhvK4dQxBXfK1it90b6EcEdVZj2nqihWKplrO4IEn
 8YlnuMr6DKEtxl7Cebe0xho9FmNIEcQDIQhlJURW7HwhiQRl1ptXJ37Cw3N2q+pVeliCEcQH
 2KrtPLwvIgEnkvmWFgvJEfJxttY1MgvuggV7VosJGapu9vih91s7iJw7AYYcwVx5TdE2tJVJ
 WJEGRBUJ6KP3jEwn+lFfTmmND9gDS2j2H7a6gU2hkjGaXK3R0rxLGEZEsScznAzqm5zUGBSw
 +CF9TzDTz3vQvDU4gIzfkxU89rYUt1781z5qvCNRsiqMcEzXmv4v/WIe2ENlhrABPExjm3ho
 c1B3r55SY//BB4qj5wLMauo/pVOd0ncP01He+9rw40RF2KFeD2S5ymHG3rsRuxzfc714W2KI
 O0wAPlQViaO9jeE9REaIq8uH4VavtAU4Pg6R7e6AlJe7pW+qGJyvYPy5xrOojYhY+9TnPYXL
 qLTcDO/EVKsu0ZEpl+VrOR5PjuXXNpVQiz9w+G/z8sRHb0hruxHUB8/w5m0jVqvISpl+BOY5
 j3CQ6rsy81j1oVesI/+GYpTBwiPCI3SVcbZ1CuRothxfdf0HsOWjDwsq37jJBZzEYYKftZKy
 YS2r9/82X3asIYMU2z2n4eLE49L756QWNV7H93WLn4Auwe/Q+7pvgU+/l6nJaxzkN9y4tetQ
 y26YpCScf8XQ9Js+21HWRNBEhoyC7XFUYm4nHmT98+zMxk61RDLCPiF9nWzNGFSSXIuCq3EU
 wTxv66j28BcoIFyHyQ7PvBBAaJjAVrdSKAjJszQtz6ZMzGSuWm8mIDezDgu1TKaLUO/MpfK0
 cqQDFy2PhG/o7rBw9xlopR/9E9fRmp0he4rOFkR4ZhqgjS9F3QLNvkZLY5AMJxPjyjuz9vtU
 Vkhtof55fnVBlyosCkQ4egPmi+aAfESfMj0LHol8it4rstw6JyoWNNcGuVIuh+auQcPCMm4J
 NtY9nCY0t2Z3MRyXehKjhCkqb4P+x4Zr07kPWjinsa0Dxt27XDmEpB+NFIlaBEr2P0hWKkGy
 abZiIyErIyGpZbNLPtd
IronPort-HdrOrdr: A9a23:okJ0cqlW0QGrpfn6TGtcxu47ChLpDfJJ3DAbv31ZSRFFG/Fw9v
 rCoB11737JYVoqMk3I5+rvBEDwex/hHPdOiOF7AV7IZmbbUQWTTL2KlbGSoAHdJw==
X-Talos-CUID: 9a23:jKlV1G+8I5hfAQhAaoWVv24RH/gPbV3k9XjzGmKIC2dEb52tZkDFrQ==
X-Talos-MUID: 9a23:+qM70gbwlMaFouBT6jXppW1Ib8pS+YO0F2QKkL4U+M6jHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,205,1708383600"; 
   d="scan'208";a="161844826"
X-MGA-submission: =?us-ascii?q?MDGgXmFd6tzM2E7sgBYHFyiWjPko0TA1aQfP7w?=
 =?us-ascii?q?4zGYXNJH5b/iBFFwWknmWd6dKxvWTlzMh8EHLNp+wV6M1l02T/MffSdH?=
 =?us-ascii?q?h74IMpZ5USiCWCNt7Q6gVs3iD7ReGYr8sHWEyEPeJIc/vIYC2X2aSAqt?=
 =?us-ascii?q?+QrFotR0cWeKLWb5oC7LhR9w=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 13:50:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713268222; x=1713873022; i=markus.elfring@web.de;
	bh=z6yCp8A2RnLDBkLpXNPwXaq/ZW8mMLmH/UyxYRY5y5o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GzkmVhX3uhJHoqwJCF8XTrDcUimnut9xdxj2AlqD9ZK7PwkTlSlEVvdGIXPdmxTY
	 H/sXe4XsPFSPiBq7A5f/kLGqJlNQegWq2rFFZfFrDJHfnwZZextihTv3IZMsFvvq5
	 wHtXb2SlJdQ+Wq+aA+kJq8vHhjsINChRnvRAMNqMPuy5QEdb3mnNEBq2XFHdPbCyy
	 wU5+iG3Z8Sz/fiQMXSkqfpJA6jH1+S4WB/GJ8YhR6i1ufvDRN7sktToIazuH0DIzF
	 JxnTp5WrXYmxGH03dM8sg7Cu/g9Zc8cDt0YN3aJvHp4iKjRSoygr/eAPeCcwZUCxt
	 DjklRVhxEaEjQ9qeuA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3Eut-1rtfzH1vPZ-003Ku4; Tue, 16
 Apr 2024 13:50:22 +0200
Message-ID: <60df00eb-41ca-417f-8b8b-90dba6eaaf65@web.de>
Date: Tue, 16 Apr 2024 13:50:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ricardo Ribalda <ribalda@chromium.org>,
 Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, Denis Efremov <efremov@linux.com>,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <20240415-minimax-v1-1-5feb20d66a79@chromium.org>
 <fbf22b53-7b68-4e60-99c7-ab38a77a53c8@web.de>
 <CANiDSCuvXvjfhw2mjSef1wR8RiL=9KrDEoh+3o1ed4+8P+AqGw@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CANiDSCuvXvjfhw2mjSef1wR8RiL=9KrDEoh+3o1ed4+8P+AqGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:erpsgFEDzw3lU2+TiQWtHiU0faieFL+3p022YHoNrdra8FXwoCM
 OE0z2LsY7kfeawiB8EsNyrHF3rtmFua9waEdXv45XloHRdxLsk1xBDAT3bD63VHoJrxNdr7
 iO4CGFnuxIKxx/J4itXVpXvPlfyUpkFLk7spsPbRJ6d+F4BmrQLi3FBKwXI8fLaLvujhEUK
 fDAG95jXl6ZZd9MlSPbKQ==
UI-OutboundReport: notjunk:1;M01:P0:YPpAdII74q0=;7Yw/E+JgPK1W6ly78FwvzfQVjWO
 oVjtCdY+0oBjOEDSWHAdKGIlGEB8j0r/BHQ3pOXTb1u4pZGmhLKtTqmCPLcbP0R1cDVES527p
 W+9Mv3OySq/yF+FanhB0As8WQTMfeUwqhOvf5UWPYF8iNvr40CI2FlZOZ5nb6uXxYsf2pv62i
 CXXhC8Q2dymv95mt5dKOvnT85h75g0MCqpvdLKxu6zFFS7ssO8yHd9Q6oVx4lgLDHq1rbbu4h
 TFpzN/1A7DifFPw1Os1ejlcsTi+XUGU32AbYXkgz7SrMflncb+gnXGxOlDXpiOswGTywB2R/8
 0giLhLS8wCgWn24YQtbEPpZaddTV+jmGNH8TOnpwYXP7OxTEhNaLy+hI6SVK8eUBMaO3QXG9j
 FRBYs3EAkEnyOQQMl4nm544kznz7LMoPNItu78wqtT7ZCoKCLZ3ah+/iuDtkC914RDvrUmX9m
 NpOEwFoz7B4F7kqSwQ3r+xYtq6updkBbTjCzDvXSUtu33CLkZrxLPC9guiBV982iu3Ay9GwGt
 65rT4Dz2kVZPAVLYJoA+8NYXp0UBE02IOuj3c44+X8o55luPL3PDXzFmCxbDGtzeMxL3Xbt1p
 h6U3jco27mQD0GwZuxovsKJHMTdqkcUQtvXcWIrbzyFH5hxBzk+hkpiGP2HkBOsyYRa8prL8G
 +CixP8GTnMD2A8bw5/qCFxbkdGIPJZa2GASStPckFzP1L856ouDNFYmHsfybSba0C+oiwnEUz
 Hk7a+kNpfRnmsz/DjbooDO3Wpz/8qNTdcaCYLX+7Kdy9SsH55W6uEaJy4MJsMz8yBEqbD4D9F
 FDqw9LdZOb82XAw3zakC/bntC4p8UHhyGpuMIONvIxvrE=
Subject: Re: [cocci] [PATCH] coccinelle: misc: minmax: Suppress reports for
 err returns
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1655
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/60df00eb-41ca-417f-8b8b-90dba6eaaf65%40web.de>

> I think errcode needs to be executed in report and in patch mode,

Adjustments for functionality of coccicheck operation modes can be clarified further.


> but there might be a better way to do it.

Corresponding design options depend on varying development efforts and resources.

Regards,
Markus
