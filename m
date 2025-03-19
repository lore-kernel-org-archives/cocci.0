Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F965C35FFA
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 13:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vfv+DGp61HW41rGqxMp8M+GRgvbWnqKyhpIIVRfwl9w=;
  b=U00LqhoGDPi6nndamISRVVCrHhnDIJapw8TtFcMUjOQ0nm4IytF4GVrJ
   tEj6N8SogUy4BKg8xjgUbBpOrv+D6tXfMt33pSxVG6t/2GcjNrhxxN18Y
   WO5Q3E4EqoDVkG1yKZbFakXgJJgWcI/o9nR4qJrIH0KDjbTHUPA14swsV
   g=;
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
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213706236"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 14:07:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E9920E0D1F; Wed, 19 Mar 2025 14:07:16 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F3767E007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 14:07:15 +0100 (CET)
IronPort-SDR: 67dac184_+7Xt6rW/sIOn5MO9FbQ7ldjPyig2u83IUVKvO1Rp3lmt4S1
 34Q3lS8UfT3/MJp9tPtsNuUnhcUoTJty0HNHFpw==
X-IPAS-Result: =?us-ascii?q?A0H6BQBZwNpngAMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VOCRIFXMwQLSIRWj1CBdDCEO4c7h1OIdYNUDwEDAQ1BAQIEAQEDBIIMgnQCi?=
 =?us-ascii?q?yACHgcBBDQTAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHD?=
 =?us-ascii?q?goxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJgEECwsaA?=
 =?us-ascii?q?iYCAlYGARQBAYJ+gjABAw4jB65KgTKBAYIMAQEG2lwfLCJXgWUJgRouhW2CY?=
 =?us-ascii?q?wGGJ4Q8Jw+BVUSBPAuCeD6IHoJpgjOEQWeZeJBHUnscA1ksAVUTFwsHBYEpQ?=
 =?us-ascii?q?wMqNDEjgSIFND84KYFjaUk6Ag0CNYIbJFiCKGoEBYEkgjaEPoRAhVCCEYFdA?=
 =?us-ascii?q?wMiAYMfdxyDS3Y/hGEtUIIWHUACAQttPTcJCxsGPaNshDyDRWQPpCuhPTQHg?=
 =?us-ascii?q?jiBZoFjDJ9eBhMvg3ABEo0JhjoOBpJ9iCmQVSKpEYF+I4FcMxokgzZPAxkPj?=
 =?us-ascii?q?iGELbRxQjU8AgcLAQEDCYVGAQGKVIFLAQE?=
IronPort-PHdr: A9a23:QEH/mRyw1MH+/2zXCzKvwFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 xaZva0m1QOUBtWTwskHotSVmpijY1BI2YyGvnEGfc4EfD4+ouJSoTYdBtWYA1bwNv/gYn9yN
 s1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgppPOT1HZPZg9iq2+yo9JDebRtEiCChbb9uI
 xm6sArcu8kYjIZhN6081gbHrnxUdutZwm9lOUidkxHg6Mmu4ZVt6T5Qu/Uv985BVaX1YaE1R
 qFGATolLm44+tTluQHMQgWT6HQcVH4WkgdTDAje8B76RJbxvTDkued7xSKXINf5TbEwWTSl8
 qdrVBrlgzoJOjIl7G3ajNF7gblFqxy9uRNw34/UYJmUNPVgeKPdYcgaTndFUspISiBNHp+wY
 44JAuEcP+hXspP9qkMNoxWwCgajCv7hxCFGhnH2w6A10fguHw7d0Qw8Hd8DqmjYoMnrOKoQV
 +2+0anGzS/Eb/NTwTrz75LHcgoiofGRRrJ7bMXfyU0hFwPfj1WQr4PlNC6S2+oKqWeb9elgV
 f+0i2I9pA9xpjavxt0tionPiYIY0V7F+jtiz4ovONK3Vld2bNi5G5Rfqy+ULZF5Qt8+Q252o
 iY6zKULtIC5cSQXxpkq2QLSZuKIfYSV/B7uVPidLzd3in9kdr+yhAu+/Eevx+D4Vse631ZHo
 jRZntfMqHwAyxLe58iGR/Z740yv2i6P2hjN5u1ZP0w4j7TXJ4Ajz7Iqi5YesV7PEyHulEjyg
 6KabEsp9vWy5+njbLjqvIKQOo5yhwrjLKkuntG/Af8kMgcQRWiV5OW81bz98kDhXLlHiOA9n
 LPDv5DAP8sbo7a0Aw9L3YYn7BayFzKm0NMFnXkbNl5EdgyIgJPzN17TPv/0Ffa/g1Kynzd33
 /3KIKDtDovXInTdjrvsf6xx51NcxQYpw91T/5dUBasAIPL3VE/xrtvYDhohPgKz2ennEtZ91
 p4FWW6VDaGZNK3SsUWJ5uIpLOmBf4EUtyjmJPQ/+vHhk2c1mVkGcqaxx5sYdGi4Huh6I0Wee
 Xfgn88NEX0WsQomUOzqlFqCXCZPaHa1Q60z+jA7BZm9DYbDQ4CtmKaO0D26Hp1QfGBGC0qDH
 W3md4WeCL8wb3e1JsZv2hwJT7mnRMd10hWnuifzxqJpKueS9iBO8dro09N+5sXSkwsz/Hp6F
 ZezyWaIGkR9hGAVXHcb2K5loEpyggOm2LJ7nuceONhd/fJPXS8lOJSaw+EsWIO6YR7IYtrcE
 AXued6hGzxkC4tpm7fmAm54EtSm1FXY2jayRqUSnPqNDYA19aTV2z7wIdx8wjDIzvpplEEoF
 +1IM2Dunatj707LHYectkyDlLuxM4kY0jTM8mir0meE+k1VA0ZrSauQZXkEfQPNqMjhoEbLT
 rugE7MiZy5I082fMe1nbtPzjFNJbOjuMpLSbjH5gH++UDCPwL7Ed4/2YyMd0SHaXVADiBwW9
 G2aOBIWAyC8vyTBATYoGV+Hj1rE1+54pTv7S0Y1y1vPdEh9z/+v/RVTg/WASvQV17ZCuSE7q
 jwyEkzvl9TRQ8GNoQZsZsA+KZs0/UtH2GTFtgd8Io3oLqZsgUQbehh2uEWm3gt+C4FJm8wn5
 H0wyw86JaWd2VJHPzSWuPK4cpjeMGrv51aCb6DM21fR+Mmb8OED5bVwqlnuuh2oClt3629ug
 JFe13qR4ImPDRJHC8urFBxtqF4j+veBMUxfr8vO2HZhMLe5qGrH0tMtXq4+zwq4Os1YO+WCH
 RPzFMsTA46vLvYrkh6ndEFhXqga+agqMsehb/bD1rSsObMquTu8jnlcpq153FiN8SVUVePCm
 ZoIiaL9vEPPR3LngVGtv9qi06VNfzIPBSySzSb+BYheTrJ/d8AHBC39Rq//jsU7jJnrVXlC8
 VelDF5Tw86ldy2ZaFnl1BFR30AayZC+sROx1Cc80zQgr67FmTfL3/ynbh0MfGhCWGhli17oZ
 4myldETGkayPUAlkx6s5ECywKY+xuw3CmDJQlpTOQXyIXtjVKSYqbeIJcJCoJ8lqiRYVu2gb
 EvSEOen5UFAjGW6Qi0FjDkgPymnoJD4gwB3hAf/ZD5ooXzVdNsxjRbT6drAROJAiz8PRS12k
 z7SVRC3O9ik+8nRlo+W6LnkETj7CdsKLG+wnubi/GOh6GZnAAOyhaW2k9zjS00h1DPjksNtX
 mPOpQr9ZY/i0+K7N/hmdw9mHgyZiYIyF4dgn483nJxV12Idg8Df2HMdknrod/hf17j/anUlW
 jMBhdLYqluAugUrPjeSyoT1W2/IiO5ofdqneSU73iwn7sZFILiZ5vpIkGEmxzjw5RKUav97k
 DAHzPIo43NPmOAFtj0mySCFC6wTF01VbmT80g6F5NekoOBLdX6iJPKugVFmk4nrX9Tg6klMH
 Wz0cZA4EWps49VjZRjShWbr5NiscYvVas8P8AKZmVHMgqBcepc2i+ZPlSRgI330p3Fj1OMxy
 xBjuPPy9IHVLmJw4OezBQNePTCzeM4ZvD3gxa8Mm8GLw8WkBZ98HjZNBZLuQavuGzUX0Javf
 w/cFTohtjKQArHYBxfZsU5goyuJGJeuf2eeIH1TpTl7bD+aIkEXwAUdXTFg24U8Chjv3svqN
 kFw+jEW4Ff87BpK0ONhcRflAC/Zo0+zZzE4RYL6TlIe5xxe50rTLc2V7/5iVyBe8Jq7qQWRK
 2udLw1WBGANU0aAChjtJL6rrdXH9uGZAKK5IZ6sKf2WrvdCUv6T2Z+1+o5h4irKKciFeHVvT
 rU61kdFQXFlCpHZljEIGEl132rGa8+Wogv5+zUi9Jnltq6xB0S2uM3UWN4weZ119hu7gLmOL
 buVjSd9c3ND048UgGXPw/4Z1UITjCdnc3+sF64BvGjDVvG1+OcfAhgFZid0LMYN4bg721wHH
 MfBic7ukJN8gOQ0DVhtSlHr3M2kL59vQSn1JBbcCUCHOa7TbyXM2N3yaLigRKd4ieJJq1uvt
 DzdH0KpbVHh33H5EhuoN+9LliSSOhdT7Zq8fhhaAm/mVNv6axe/PbefYhUpzLdyin6YbAb01
 BBjfkkLorDCtUuwY916HHFdqGVoJ6+IlnTBh9Q=
IronPort-Data: A9a23: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
 bAJeF15
IronPort-HdrOrdr: A9a23:9u33FKlt0V09OalFW3gSF0CVsTLpDfIi3DAbv31ZSRFFG/Fw9v
 re+8jzsCWftN9/Yh8dcLy7V5VoIkmsl6Kdg7NhWYtKNTOO0AeVxedZnOjfKlXbcBEWndQ96U
 4PSchD4Y3LYGSTz67BkWyFL+o=
X-Talos-CUID: =?us-ascii?q?9a23=3AWmUbs2i3FJ7tVc0NA6j7GmJRzDJuX3qH4FXqOBW?=
 =?us-ascii?q?DVkFjdIO2aE+V5L1qqp87?=
X-Talos-MUID: 9a23:ByDfiwiyJyLCKSqVXAex+cMpO8Jq0o+uCkYxl7Ybo8mZKwlxFAmvtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213706235"
X-MGA-submission: =?us-ascii?q?MDHQorEdN9Hz0PVXcM2nbJNVHWVWj951mQSh6q?=
 =?us-ascii?q?FCtWVPu1MlFapNBtx+5duTUBiMabQV2aJpeu1YYW2D9cYvnAbYHvdxUE?=
 =?us-ascii?q?rmXzEfZ2ly9mgYyRYT3exf4109nEE1ei4BPPB9LvFSm6BDbGH+MDP2KS?=
 =?us-ascii?q?UkpB4z3Ba64OfffiLJeMMMNg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 14:07:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742389629; x=1742994429; i=markus.elfring@web.de;
	bh=vfv+DGp61HW41rGqxMp8M+GRgvbWnqKyhpIIVRfwl9w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZvMtUFEXS5FlL3BvlG3U3FoD2LTdxkp7CpT+5TVxtejqVpZtxl27/0kg/Zw1Mash
	 /ADmGau1gtXGbEwsR1dvxE9tpT+7KJt+7YEMfMigQthFJZ7+53i/fanJb1fcomfox
	 72OoxW3C9uECWcB3n2GQb5D6OBGAAL4rTqM1tMvfLWs8wLna1UiKOmYq0cSCXcf9W
	 H9zDYS0Ay/wYlkv2ctaWqQbot8tth7+pSRhFxmDTqclazH4G/KUAuzxqtEQgZpMuV
	 /1dgu1RzzCtaS1+6O2pFUv0KbtglFFMjRv+QYV8K9kFdekjCKB9pZ3OARA77D6m6F
	 nRyzGDda7kLYN+6UBg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.16]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M28SL-1tsyG415Oj-000v8k; Wed, 19
 Mar 2025 14:07:09 +0100
Message-ID: <b105e7e8-2576-41f2-9ba8-0185c0a1bd7b@web.de>
Date: Wed, 19 Mar 2025 14:07:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Olaf Hering <olaf@aepfle.de>, cocci@inria.fr
References: <20250318111305.281abcca.olaf@aepfle.de>
 <2b3232fa-ad32-c17f-8e97-8144c648c19c@inria.fr>
 <27f57368-6a2d-4ea4-8a81-b8bee42e2d5d@intel.com>
 <20250319134816.3b7d026c.olaf@aepfle.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250319134816.3b7d026c.olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PO6kQZOscTT1nZMloZEzkpKH2fWgPIgmV/ptIROc8heIMhlJb3r
 BJpJoO3nygqsekPtux9r4ix6ss9dvy1+vNKVCz/m8I03H0qL3Kaphh4m0qBjb/jMPL9MnjK
 nRhiTXqko/sHMEVmeMq/xClg/9Tg3uU9GpMY/OcBP8sACE+hRE2azp5SEvgRzA8tZ41l5u0
 +0PlkoKi1u6g9sVd6/TuA==
UI-OutboundReport: notjunk:1;M01:P0:eSW75jHMXxI=;v4o8hKmgHB5jWT4VBqdKzIJodql
 gPfUnAmInX5m2pInwpAh7nAkqGe/AfxthncM/iuAgKfHkENJyIJS8bN4d+ZV7VgsHvBU4Tv57
 gjNlM0FdnzUoGs93UcxJeDQSY7HblZn1xRjJR124DOX85gvUTtT0krukcwExJ6ROoKmSNGxFT
 wVa7uUJnlH8l4qSfjMpt0IuriEXiO65Kzp2L26oUg0ca5AekHzAuxiPv52W+nKOqVk+4u8Asw
 GvmKVbkCRDtpNXOEd8M91w/jgzgwoB8o4x8S5bjLKEiBA7q5LAjOV4Hq6uYcCtHQcFQ9WlvGz
 03Eq6jI9u/LzKve+zS+/x2fcIt8EWBO4cEh24XeBfSAGg/Bub/nrqaDzLhajgneVUmC4IPk31
 1iaV6Ww95ygjFz0WBeLwOU6teWcq0SnF+1bO6XQJEFjA1spfZJ3Rzdn8F6urb73tmQt3LVnKj
 OthKCdfCZa8mikL7nzJ4MfgBNdFP0TNYGNI181VgKv14IoNaJBPTWsXG8z6mzXwgu8+QEUxIf
 tleOVm+ktHEwJfRyb0Sm9bBCxTMbGsPAXsftuSME7yFauUivb/r+wMFvM2ZTqjcxk8PpV4du9
 jVdgIXPfqLo8izxOPsCypHwXFpb96U/R2IdtJUACiyO5jjEGD74iDryTzh9oeq/hkjwOHeTJy
 /h9DGpD7vMRGank0rTx8NcqEQi3n4VD/ZF1mvfLQ8d3Xjz/B/UIovSujhTRSdQzxCsyE8CWv/
 R9oLFnRdAcj/VN9JOfcjlv8FGrfwEJQEfw2q4sbCR56zCQ7Tf5gdt/Mh18LixIzM1hXY0ncQg
 kKuzINQPxtCTJVGvnlqRwTi8AAuDj5EtHHk5s1qvg1bHRO4uHszOh6L6DIYDLAAQt42+WGjKs
 wyB4h67eSTgiAEIL56H20jsQO/i2z7m/Drb6o5HKYAYyB/Q+hJhqhq20S/TQQ8Iu8CbjRju+m
 UMIQaoHxwbB3sDkva4h5U6HpubIYcEaDwWoFKfYoVfB73C/6BKGmD48rhHg0lTB5sQlRIMhm1
 KRUVE4ewsxRKii5xi4uwkmDBlbD+RKwlC0ASHh3Gp5KJT2TxU770dZjnTVAAAkSsrhXDeYzu/
 xxV6DIVuHvZBtMr/GRCtu0mqRLLS8cx2v6W+r3aWveC/42GoBpUDSBfuN6tG89SWR9EuZnS4F
 qHu+o8mi7avWicJhARFOKl7mnfHVE1GDHr982P/GRI3GLXT+usS5SJYd2Ux8AZF5d9DHImeZX
 nxMXnZqbZm6jjroFJxllP9kLMpbEhxyNpksuCMoeFD5R29r4VVBtjmzCcThTc1PNuB18U7UaM
 HwIZvkI8U9ck1+PI8kOKUpyuyzMI6JKMqshgwU5HxT6qfxFcAo5OKm6KQ5S8y9luRPGefDK1P
 3HoRdnmyTC/JiBgArLZIBYoNxvxl1bw9y5IrVlE5md7ZHg5r7fqHV4c00etB12rSkYEDsuSah
 8DVuPDPKIG1w+H3Dr1lSEQmovYhAsNU1xxhIpQITjRYhYU0KT
Subject: Re: [cocci] the future of bundles in coccinelle.git
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2648
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/b105e7e8-2576-41f2-9ba8-0185c0a1bd7b%40web.de>

> In case one has to actually work on coccinelle.git for whatever reason,
> there can not be any convenience, except 'opam install coccinelle'
> which will install all required development packages.

Please reconsider such a view once more.

I can occasionally prefer other software development requirements.

Regards,
Markus
