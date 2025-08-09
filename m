Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5CEC87FCB
	for <cocci@archiver.kernel.org>; Sat,  9 Aug 2025 06:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=zWfFYfghNzzGN2ie8tW841DkvM1XDV4FbNSi6w0UzXM=;
  b=km6kdSt+U3EMsdZUyM8HWoBFVRJ24rlqd0uh6+NoPpizeXGo3dlw4BHw
   L1mJ5zT00YVumoZyNDwFsacyZTAPbuqjN8kgpSKDbZOxWb1XMsRfgLxFT
   DTJVBev5DyIbFao/qco1zjSG0gQdumISV4BCKSzKzgQJUtcqlYHuSnHgY
   I=;
X-CSE-ConnectionGUID: Sk5MecWWTCKx/pRgPoatSw==
X-CSE-MsgGUID: lXK0J+/lQp2GyinOYrQ7Mg==
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
X-IronPort-AV: E=Sophos;i="6.17,278,1747692000"; 
   d="scan'208";a="234597628"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Aug 2025 08:44:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E6ECFE0264; Sat,  9 Aug 2025 08:44:42 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 09BF3E0171
	for <cocci@sympa.inria.fr>; Sat,  9 Aug 2025 08:44:41 +0200 (CEST)
X-CSE-ConnectionGUID: dSqQtaoUR06rtN69lUjsug==
X-CSE-MsgGUID: OQgWB4mnSkSft4lvmD+tJQ==
IronPort-SDR: 6896ee58_/Votnpqdm4cwMijGceq4JWBgsuf90E3/LxW01wD48K0ylzi
 Teu0t5QQd46noyCUzoGevdgAsfOcGQGzV/hN+Ew==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FuAACV7ZZogAQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAYJDgQRUMwQLSYRVj1CCJIQ7hzyHU4h3gVWBfg8BAwENTgECBAEBA?=
 =?us-ascii?q?wSFAAKMIgIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABATsHDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBARcCR0QBA?=
 =?us-ascii?q?QECASMdAQERJgEECwsaAiYCAlYGARQBAYJ+giIVAQMOJAezaIEygQGCDAEBB?=
 =?us-ascii?q?tpeHywiV4FlCYEbLgGFbIJjAYYng0J6Jw+BVUSBPIMDPogegmmCJoEWg2OWN?=
 =?us-ascii?q?FJ4HANZLAFVExcLBwWBIEMDKjQxI0sFLR2BJ32DDYEOhCgrT4IidYF5QRk/g?=
 =?us-ascii?q?1MeBm0PBoEVGh4tAgICBQJDRYFgGQYeBiISAgICAgIRQAIBC209NwkLGwY9k?=
 =?us-ascii?q?32sCqFBNAeCOIFmgWQMn2cGEy+DcQGTWA4GkwKZAyKpFYFpATiBXDMaJIM2T?=
 =?us-ascii?q?wMZD44hhDO2X0E1PAIHCwEBAwmFRgEBinaBSwEB?=
IronPort-PHdr: A9a23:YdaM9Rb8nwElL6Tu8Ek5q2D/LTGU2oqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1wSPBd6QsqgZ2rqempujcFJDyK7JiGoFfp1IWk1NouQttCtkLei7TGbWF7rUVRE8B
 9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUhrwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9I
 Ri4owjdrNUajIVtJqos1BfEon9FdudLzm50OFyfmArx6ci38JN/6Spbpugv99RHUaX0fqQ4S
 aJXATE7OG0r58PlqAfOQxKX6nUTSmsZnQNEDhbK4h/nRpv+vTf0ueR72CmBIM35Vqs0Vii47
 6dqUxDnliEKPCMk/W7Ni8xwiKVboA+9pxF63oXZbp2ZOOZ4c6jAZt4RW3ZPUdhNWCxAGoO8b
 pUAD+wdPeZDsoLxo0ICoQaiCQWwAe/izCJDiH3r0q0gy+kvEg/I0wMuENwTrnrZstv1OqcQX
 u+pw6fF1inDYvFM1Dvh9ITEbBIsrPeRVrxwa8rRzkwvGhvCgFqKs4zlPC6V1v8QuGaU6+pgW
 /ivi28hqwF+vzOiwcAihZPThoIW11DE7j91zokxJd22Uk57YNikEJRLuiCUKYR5WdkuTHx2t
 ysjzLANpJG0cjQQxps92x7fd+KIc5KO4h/7VuucPzd2iXNrdb6hmRq//0etx+niWse73lhGs
 zdJnNfQun0CyhDf9MaJR/Rz80u8xTqC0x7f5+FYLE0pm6TWL5gsyaMzmJoLqUnPADL6lFvsg
 KOIaEkp+PKk5/nnb7n8qZKQL4t5hw7kPqkgh8CzG+U1PwwUU2SG/emx27vu9lDjTrpQlP05i
 KzZvYjaJcsFoq65BBdY0oMk6xaiEzeqytoZkmccI15fZR2IkZDlO1DIIP/mEfeym0qgnCp1y
 /zcILHtHJfAImLenLrhZ7pw5FZQyA8pwtBe45JUBKsBIPX2WkLps9LXFAU5Mw+pw+b8Etlz2
 YceWWyVAq+YNqPSvkSF5+wxLOaXfoMapSjyJ+A/5/HylX85hUMdfa6x0JsTcn+5EO5pI0GdY
 Xf3g9YBEGIKsREkTOPwklGCUDhTZ2yzX60m/D07BpimAZ/ZRo+xmLyBwDu7HppOa29aDVCDD
 Wvnd4SfVvcXaCOSJ9dhnSYeWbigTY8hzxCuuxXgx7ppNOrY4isYuon729hv++LTjQ0y9SBzD
 8mFzW2BV250kX0PRzE1xq5yuUJzxFib3ahinfNYC99d6elRXwc/Mp7c0vB6B8r8Ww3fZdiFU
 kupTcu+DT4sTdIxwtoObl5lFdutgB/NwTakDqMTmbCTGZM097jT32LtKMtl03jIzbEvgVY+T
 stULW2miLZy+RLPCoDUjkuVj72qdbwS3CHV9GeM026OvEZAXQBoSKvLRX8RNQPqqoHb+0fDR
 veKAKsuNg8JncyfLqpDLNngklxCQN/iPs7faiS/gTH0TR2PzbiNRIvsYWQUmivHW2YelAVG2
 H+cNhUlTgqlrXjfCjMmQXfmeUDx6q9TrH2hT0k75x6HZQtt2uzmqVYumfWARqZLjfo/syA7p
 mAxRQ7ltzq3I9+Jpg47Ob5Zfct4+lBMk2TQqw16OJWkaaFknF8XNQpt7Av1zxsiLIJGnIAxq
 W8yihJoIPe92UlCaije8JT+ILzRJUHt8RrpZ6OFkkrG3oOu87wUoO89t02luQioEkQ49HAy9
 tBP0GaHoLjOAhATV53ZTUs9sRR39PnBeidowYTS2DV3NLWs9D/P39V8HOw+1hOpZMtSKouBE
 xLuVdIXDY6iJYTGgnCPaRQJdKBX/a8wZYa9cueenbSsN6BmlS6nimJO5MZ81FiN/mxyULyA2
 ZFN2Pye0gadMlW0xF68rsD6n5xFbjAODyK+zybjHotYeqx1e84CF26vJ8S9wtg2iYTqXjZU8
 1uqBlVO38HMG1LaSlXn3hBLk2kTr2amnySQ0DF+1T0k7+Ke0CHI3+X+ZU8fIGcYDGJmjFrqP
 c21l4VABRLuNVJ20kL4oxqposoT7L5yJGTSX0pSKi3/LmU4F7C1qqLHeclErpUhrSRQVu24J
 1GcUL/05RUAgEaBVyNTwi42czayt9D3hRt/3Si4JWxwsWGfVMV+3xbZ6/TDSPQX0jdMF0waw
 XHHQ0OxOdWk54Desp7Zsf2lEU+lWIdSdybD0o6K8ie2rz4PY1X3j7W4ndvpFhI/2Cnw2oxxV
 CnGmx37Z5Hiy6WwNe8PklBAPFbn8II6H4h/ltF1n5QMwT0AgZ7T+3MbkGD1ONEd2KTkbXNLS
 yRZi9LS5QHk3gVkIBfrj8rcX2+e39AnSt20eGIQ1Qoi4soMBKrc4LFfnCRzq0a1tkqLOKI7x
 G1Cj6JzriJSivpBoAc3yySBHr0eeCsQdTfhkRiF9ZH2ralaYnqubanl0UN/md67C7TR6gpYW
 Xv/ZtIjBXoqt585agiTliSurN23HbuYJcgevRCVjRra2u1cKZZr0+EPmTIiI2X2+3ss1+88i
 xVqm5C8pomObWt3r8fbSlZVMCP4Y8QL93Tjl6Fby4yz1pqsA44nNzEFRpruQtq3HThUufmtZ
 GPsWHUs72yWH7bSB1rVzU58rG/UVb2vOWuWInYx0thoAhWQbh864khcTHAxmZg3ERqvzcrqf
 RJi5zwf0VX/rwNF1uNiMxSsGneavgqjbS04DYSONBcDpB8X/F/baIbNi4A7VzEd5JCqqxaBb
 3CWdxgdR39cQVSKXhjqbLyp+MWG7OWSQOazZ/KcZLKTtalOWfCS2pu13s158jzKOsjqXDEqB
 q8+3VdfGHp+BsLSlnMQRiZRmy+FZpyeowqgvyZspN2787KyUQTjvM2EDL43U50n8kKzhrqfc
 uWLjyFjMXAB35UAnDnDz71XylcWj2sGmyCFN7MGuGaNSavRnvUSFBsHc2ZpM8AO6asg3w5LM
 Mqdi9Xv17c+gORnQ1FCHUfsnM2kf6loaym0KU/HCUCXNb+HOSyDwsf5Zrm5QKFRi+McvgO5u
 DKSGUvudjqZkDyhWxeqOOBKxCaVWX4W8Jm6aQpoAHP/QcjObxqmLJlogDdwzbB1znLGOGgAM
 CRtJkNAqrrDiEEQyv57GmFH8j9kNbzewnzftbOHbM9L96c4Z0Y83/hX63k71bZPuSRNRfgv3
 TDXssYruVat1O+G1jtgVhNK7DdNnoOC+0t4asC7vtFNX2jJ+BUV4CCeERMP8pFAA8fsprsW5
 9zBjqP1Jx9d/tiS8cZWVK22YIqXdWEsNxbkAmueFAweUTuiLn3SnWRYl+yOsGKYpN42p9K//
 fhGAq8eX1szGPQAD01jF9FXO5Z7UAQvlruDhdIJ736zxPE0bNpXtNbLW6DKaR0AACmUh/9Ia
 klRqVsZBYEUK5G9xEFoLFV3ztyiJg==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:BsmjRKq0tP1TsOgoRu7GRo4aV5r/eYIsimQD101hICG9vPbo9f
 xG785rsSMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadC/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: 9a23:LSwFNWAh/Ey9bbz6EyVc7XcIE8cYSCWD1mv2fR68NGRyVbLAHA==
X-Talos-MUID: 9a23:tiHUNQrNsqpJnNZdfkgezxZbO/hCv6GoM0M2n4lav9eBGW9sGQ7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,278,1747692000"; 
   d="scan'208";a="234597627"
X-MGA-submission: =?us-ascii?q?MDHHGo3oxvLoYXKeYC4pdsoQfXFRt/pCCqMaDg?=
 =?us-ascii?q?LTRY/5ota7vIA2IOcOF/2AxVxvPHpU2yAbnkzX3nnJd23q/kg/lfr1aG?=
 =?us-ascii?q?PeHLeVwvfGyqOJHiKFM8Ep4d/t242SbaaIJa9wY+0ZCvIfWocFkCAjGo?=
 =?us-ascii?q?oQBf8QjFEQenpqXoJjXfoDcQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2025 08:44:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754721866; x=1755326666; i=markus.elfring@web.de;
	bh=zWfFYfghNzzGN2ie8tW841DkvM1XDV4FbNSi6w0UzXM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lpoKEvf/V8VnUHsa2PwrfYuGMyo5WOtMRrwbTGUPmvwnfJEimJoakxH0ScyrvbIK
	 mPtNkCmL20crDXBLhvdfX/8RapT/QH9AqxeLgQ1HxNWVXCuB9L14pWYSDnPfBG1DS
	 jVU0MdLYqZ5prpTw2QoPH2cl5NtRElpAMoxS7c9z3EP1wviuSAclcJ2J8ZKi1J3lM
	 jZMoOUsSzlJGsB6AXm9lwFG8cz73vT5JrgQc2XsOIJ7KAdM/VeUp/Nfn6VjjCnvFd
	 W6BRvvw2VLjtFl8sfxThnUoKfVVhk/bwMjfgHMDFAR1No+C2b34AQuzzfx70cI5zp
	 eDUGgS5D48Dm4hvqrw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.194]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeDMR-1u9uzF14xr-00lxyJ; Sat, 09
 Aug 2025 08:44:26 +0200
Message-ID: <0618c7d1-e0b8-459d-a94e-06446e26593e@web.de>
Date: Sat, 9 Aug 2025 08:44:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Michele Martone <michelemartone@users.sourceforge.net>
References: <0bf5c015-bb4b-42ff-9734-d7de549417e1@web.de>
 <3a88b6dc-cdca-79d1-9a4-72ca8c465c5@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3a88b6dc-cdca-79d1-9a4-72ca8c465c5@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:z0Sn/yK04UnbiyV6Ul+znwGqhoXzroy7hl9CCv6/pzNLVcHHFyE
 Wk36uKaDdVwS7zYcC/lSDdTScN/EXJN+m3wCnNmO1UtTMhxbAnng+ByNjfW89EVsTLtLfmN
 cN07oWr5rHUd6FVSF6BosTLBAUemFsH3hkwao3/J3PhCy6QlZVFBbXVxa7rl1W+4Rzv4d5k
 pGOCieiGF7gF7QIaBi6wA==
UI-OutboundReport: notjunk:1;M01:P0:HNRhxoU2R2c=;XFdZBkgQfhhqmx4TELLwC5VISWR
 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
Subject: Re: [cocci] Searching for C++ delete expressions (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2972
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/0618c7d1-e0b8-459d-a94e-06446e26593e%40web.de>

> In general, I don't think you can put ? on random subterms.  You could do
> what you want with a disjunction.

Will another SmPL script example trigger further collateral evolution?

#spatch --c++
@display@
expression e;
@@
(delete[]
*e
|delete
*e
)


Regards,
Markus
