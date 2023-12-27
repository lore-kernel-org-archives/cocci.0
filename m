Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA89AC46CD2
	for <cocci@archiver.kernel.org>; Wed, 27 Dec 2023 14:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=x3qZVzZq3+yloBp7L5GBI/VqL+2rdNSrYuANupEEpR0=;
  b=SBzFy6jEgk2zRvbV3OPN1h3JEAcUfl8ewT6DEDMjPJuNqvtvHcpTTQag
   Mn7IGkARwrQqycazPsGdWuRUfK/myyl70gAj5Zq1Pubgo28r5pk1twHdN
   4jizfhXGgdqxLgATc7xDZUiNBknzNOLr1FIP75va6oDN7FVvcVGjqWkS5
   Y=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,309,1695679200"; 
   d="scan'208";a="144142198"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2023 15:47:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C5BF8E0AF1; Wed, 27 Dec 2023 15:47:26 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D2DEFE004E
	for <cocci@sympa.inria.fr>; Wed, 27 Dec 2023 15:47:20 +0100 (CET)
IronPort-SDR: 658c38f8_KEKgx1UZb55Se7F1W9b+KRxb+yFSU+BPC3mkJ713rgXO5ED
 v3Wpr6p935bkXkJ5tRzlJi6v2DNVrPvfPpoRx7g==
X-IPAS-Result: =?us-ascii?q?A0FkAABBOIxlew4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYI4f1MyBAtIhFOPQYF1MIQ7hzWHTIhvgVaBQD4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEOIRHAoc2Ah4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBJBgGDgULJ4VsDYJcARCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHQ?=
 =?us-ascii?q?gMDIwQZAQERJgEPHwEFAiYCAlYGARICAQGCfIIrAQMxB647fzOBAYIKAQEGg?=
 =?us-ascii?q?masch8sIlaBYAmBGi4BiBoBhWeDQXonD4FVRIE8g0GECoQUgmiDZoU2BzKCH?=
 =?us-ascii?q?INPkVZ9BUFwGwMHA38PKwcEMCIGCRQtIwZQBCghCRMSQIFfgVIKgQE/Dw4Rg?=
 =?us-ascii?q?j4iAj02GUiCWBUMNARGdRAqBBQXgQ5uGxIeNxEQFw0DCHQdAhEjPAMFAwQzC?=
 =?us-ascii?q?hINCyEFVgNCBkkLAwIaBQMDBIEwBQ0aAhAsJwMDEkkCEBQDOwMDBgMKMQMwV?=
 =?us-ascii?q?UQMTwNsHzIJPA8MGgIbHg0nIwIsQgMRBRACFgMkFgQ0EQkLKAMsBjsCEgwGB?=
 =?us-ascii?q?gldJgcPCQQlAwgEAyspAyN0EQMECgMUBwsHUgMZKx1AAgELbT01BgMLGwY+A?=
 =?us-ascii?q?qZNgQ6CdsUBNAeCNIFggWEMnysGEy+XJg4GklQuh1CQTyCoRoFlATeBXDMaJ?=
 =?us-ascii?q?IM2TwMZD44gDBaECY9HQDU7AgcLAQEDCYVGAQGDJjSBRgEB?=
IronPort-PHdr: A9a23:RTmEIBzuP1hIFnjXCzJUwFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 hyZv688xwGUFazgqNt6yMPu8JrcEVQa5piAtH1QOLdtbDQizfssogo7HcSeAlf6JvO5JwYzH
 cBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBBr/KRB1JuPoEYLOksi7ze+/94PQbglSmjaxf7d/I
 Bq3oAjRq8IbnZZsJqEtxxTGpXdFZ/5YyWR0K1yNgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7U
 LJVEi0oP3g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RTGv5
 LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWGZNQtpdWylHD4ihb
 YUAEvABMP5boYfzqFQBowawCwmyCu7xxD9HhGP506Ih3uQ9CAHLxhAsE84QvHnWqtj+KaccU
 fqyzKnN1TjNaOlZ2S3+6IjVaRAqvP6CXbZ+ccrLyEkvEQzFhUiXpILiJTyVzOcNs3WA7+Z6W
 uyvj2AnqxtwojipycchkYfIiZwOxVze6Cp23p84KNulQ0F0fdCqCoFftz2GN4RoWMMiRXllt
 Sg5x7ACpZO2eCYExpQjyhPdafGKb4eG7w/gWeqNLzl1mnNodry9ihus/0WtxPDwW8263ltEr
 ydIjNrBu24T2hHV98OJSeN981+/1TqSyQzf8P9ILV42mKbBNpIswqQ8moccvEjbGiL7l1/6g
 aGLekk++eWl6/7rb7Hmq5KaKoR5lAX+Mrk1msyjH+s4KBUAX2ma+OuizLDv4Uv0S6hQgPIsi
 KnWqpXaKNwbpqGnBw9V1Z4u6xO4Dze7zNQUh3cGI0xedx6dkofmJUnCIPH+Dfihn1ShiClny
 +3YMrH7HJnBMHrOnK38cbt98UJQ1QU+wcha551OC7EBJPzzWlX2tNzdFhI3NBa7w/zkCNVgz
 YMSQ22BAquXMKPIsF+I4O0vLvKCZYALoznxMeUq6OD2gX8/glASZbOp0ocPaHCkAvRmJF2Ub
 Wf0jtcbDWgKphY+TPDtiFCaTTFTYGq9UL495jwgE4KnDYLDRpi3j7Cb3Se7GIdWZmFcBVyWH
 3fobdbMZ/BZbCOUP98klyAIfbygUJM6kxCouhXzx7duIqzT4CJc/ZHuzt5446jRnBcz6TtuF
 OyD3GyXCWJ5hGUFQ3kxxq876Wl800qO1eBCiu1eHNgbs/ZISxo3MdjGxv18AtTaUAXGYtOIT
 hCtRdDwRXkLT9kxysUCK3lwGtOogwrM0jDiV6UUnLyCHpAc9KXQmXHtcYI19XfJ0qQ6jxEcS
 8RPPHOrgKJl/kCHGY/GlUiCl7yCaaVa1ynIojSt122L6WRRSg1tSu3oWX4FZ03Z5YDc71nBU
 qToJLApKApHxuadJ6EMZtC/3gYOf+vqJNmLOzH5oGy3Hxvdg+rUNOICGk0Y1STZUw0flhwLu
 G2BLU44DzugpGTXCHpvE0juagXi67o2s2u1G2kzyQzCdEh9z/yt4BdAoPWGSO4ImJ8Atj0gr
 TpcA1u3md7bWJKbvwQ0RKxHepsm5Utfk2fQtghzJJuleoVrnF0DaEJau0301hN4IppNm44mo
 SBi1xJ8fISf1l4JbDaExdbwN7nQf3H15wyqYrXK10v21dGL5uEQ5f5+p1iLUBiBME0k/j0n1
 tBU1yDZ/ZDWFE8JVoq3VE8r9h98rrWcYy8n5oqS22c+ea+z+iTP3d4kHo5Hgl6pYstfPaWYF
 QTzD9xSBs6gL/YvkkSoaRRMNf5b9ao9NcerP/Wc36vjMOFllTOgxWNJheI1mmeF7SlhUajl2
 5gfwveX9hSKXXHwgRbps8z6n5xFeSBHBnC2mmDvAI9cYLE3fJ5eUz70ZZftmZMn2ti0By09l
 hbrHV4N1c63dADHalX82VYVzkELuTm8njP+yTVokjYvp67Z3SrUwu2kegBUXwwDDGRkk1roJ
 pC5yt4AW039JS0gjhi4/gDXw6ZBpaJwB3beSwFEcmKlSgMqGrv1rbeEb8NVvdkNuD9UTf/6T
 FSUUL/7rDMF3imlE2YUl1VZP3m6/57+mRJ9kmeUKn1++WHYdc9HzhDa/NXARPRV01LqXQFAg
 CLMThi5NtitppCPkovb9/u5TySnX4FSdi/iycWBsjG67CtkG0/3k/e2k9zhWQ80tE2zn/xjT
 ybVt1DRZofx1qK1Gf1qdA9kCRfw5tF7FYd3joYrzMtJgz5A3MrTpCdByDu7OM4Twa/kaXsRW
 TMHprydqBPo3kFuNDPBxo70UGmc3to0YtC7Zm0M3Sdup8tOCaqS8PlFhX4v+wD+91iOJ6Eg2
 G5Bmp5MoDYAjuoEuRQg1HCYC7EWRgxDODD00g+P95a4pblWY2Cmdf6x0lB/lJavFuLnwEkUV
 XDnd5MlBSI14N94NQeG9XTp6Zz/PvTUY8gSsBK8jBrKyeRYYsFU9LJClW98NGTxsGdwgcsyl
 x9zxteXuIadKmNi1L20CFhUO3emAqFbsiGohqFYkMGM2ompFZg0ATQHUqzjSvewGS4Tv/DqZ
 E6eVScxoXCBFf/DDBeSvQ14+mnXHcnhZBT1bDEJiM9vTx6HKAlDjRAICX8ky4UhGFnixdS9I
 h0gvHZLvAG+80ESjLsyZ16lDwK97E+pcmtmEsHFakAMsUcbugGNdpbDpuNrQ3MCp8fn9lbSb
 DXEIVwPVz5BW1TYVQq6Yf/xv5+ZorLeXLbuaKGfBNfG4e1GC6XYn9T2jNYgpmvdcJ3IZCcqD
 uVniBAaAjYmQYKDw2pJE2tNyGrMd5LJ/k7jvHIt6JnuqrK1BEW1u+7tQ/NTKYk9q0rw2Pnec
 bTK1WAgcm4Q14tQly+SjuFBgRhI0HkoLWPlB70EsWSloLv4vKhRAlZbbipyMJAN9KcgxkxWP
 tadjNrp17l+h/pzClFfVFWnlNv7LcoNa3qwMl/KHiPpfPyPOCHLzsfrYKi9VawYjeNasAe1s
 CqaFEmrNyqKlj3gXRSiee9WiyTTMBtbsYC7OhFjbAqrBMrhcQG+OcRrgCcexLopmjXVOGRaP
 TU9O0JBo7uM7D9J1/VyH2sSixgtZeKAmiuf86zZMsNM6KEtWH4r0bsHpi1mmN43pGleSfd4m
 TXftItrqlCiyayUzyZ/FQFJsnBNjZ6KukNrPePY8INBUDDK5kFojy3YBhIUqt9iEtCqtbpXz
 42FsavpKypZtf/Q89EdAcf8N8+NdnYse0mMenacHE4eQDinOHuKzVRai+2X/2aJo4ISr5/xh
 NwRR7UdWFF/RZZ4Qgx1WdcFJplwRDYtl7WW2dUJ6XSJpx7UXMxGv5rDW5p64N3qLyuFy6ZJb
 V0EzOGgRWz2HpL20QpuZwsi9GwlM1XdV5ZBr384BjI=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:qLwW9qybz46J4+yktfc1KrPw+L1zdoMgy1knxilNoNJuA6ilfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bBYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebrN5DNB7foSjjPIduoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: =?us-ascii?q?9a23=3A/NtnqGiVGe50B/RlPCVuvTDCKDJuSFf2kHOOPnS?=
 =?us-ascii?q?EWTxbaJmedlyM+/xHup87?=
X-Talos-MUID: 9a23:96OLrQqQMNxYLIYHC8Uezx1LHt9isoKCMU1OqbxYksCNNQBVFyjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,309,1695679200"; 
   d="scan'208";a="75412467"
X-MGA-submission: =?us-ascii?q?MDEDRbhsuR4ZEjKQZv2q9DkaCwnBHITUvxK9YA?=
 =?us-ascii?q?z9FWcd5+KRXk0DeoL4azp7IPITwrXi+1XvAbWViHUis2qsbL6j8/92/x?=
 =?us-ascii?q?e6PSujMJu0IL6fyaPmwRzFDmNbZRPXDQCpRTL/J0BghDByKD29wZpjYK?=
 =?us-ascii?q?BiQKEx5M6iJTii9cC2AlxCIg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 15:47:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703688438; x=1704293238; i=markus.elfring@web.de;
	bh=ENo4hclmxFGh3SyuMn74xYfR6nPiZ/yVfNyShc6CWic=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=jb6FhMk8ncrUT/GPmfbCWFPh1XKG5v12rU5Yc3PvGZ4PRdtEYCbvFdKmgzlC3wTO
	 GyxDflLMqLov0mle4NbmnDuOvKJB/M2LIxi+LxJFtZPoGCM67T+0TqoJFQDT/kzbL
	 /P6N2vMjAwTXbZN0jD1506ss6uZFmP6TDF80FdAy3zaDdUKF/zedEH3KmmuiqV9yU
	 b74B1JyHqelRQXLyk7WKXXHv98roR3Y5hRUF/ftrzysPsNmJWLrOElYdstfEs2adI
	 aIAmLdogIKobhpVLtDRyyygEEPrezLFVbl/JyhLbwjhOyx5vy4MnWG9Hge+OH5LFu
	 lIPYAtUUcatoIcRQ2w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MActo-1rP3gz3l6G-00BSnE; Wed, 27
 Dec 2023 15:47:17 +0100
Message-ID: <4045abdd-fb88-4c1f-a947-cdb3d4e59aa6@web.de>
Date: Wed, 27 Dec 2023 15:47:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <74183091-4c8d-4c92-b3f9-cebaacb41efd@web.de>
In-Reply-To: <74183091-4c8d-4c92-b3f9-cebaacb41efd@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OYIJmlZiVv3gMIO0Joo/qfFTlG1BRQ6vZQXJAYujZsR+yqMSQlg
 YUQ1u0jm8hFI7QwcNmMqIOGC1Yw+g5VgIXV0uFEhbxC11wtnsBvPNZj1dHfxUPdwAjJeLk2
 YhOciknrWm6X7bCdFPLimteTNxlUTv/xalPSJTKhbzBq4Dg0GZAbecvv6x3Hk+9JbMU7IiH
 0/VIEyuZ7Woycz3SOt/jw==
UI-OutboundReport: notjunk:1;M01:P0:nTbrXtVW0Ek=;9SXT7VBtC7psLaI3e5DfbupJ4Xk
 RCauIZbHor2BgN+90TjGkfgolk1x3MF/bVcJwL1qziklyA+m21E4Aj2YM+YaMS1kYI1blUyhF
 Yaww5laVRJaJiSCHqahF6uhzpPGFZ+qg5BmPeVVJendUtGfZSr7F+vTVEdSEk3RoVqGP/dsqN
 t8Caq9vVu703baEUjFXaRTIyjNRP4djyJeaU4dxTPyA+D8YGkRrWdiJ5TNZ/sN6U6hInNMj/g
 psV+E5g5WUa02vmiNFBEaxL0s/nf45y/hKeQQq5FcNfA7gpZWRnwzqMbZG6x62yYw6/9cSAPg
 0jIknk9zEyKSk+lcQ/Nz5JvUV035PSv27TPwTcw365zJpARJ3puJpANcyggg//tA4dnZQmV93
 /OdwZ9M+8tB46fKGkR8P9XW59L2uYtWolYmQ5gFstKtYns2qBwJvGOEmw88Ug18rUbWgOvE8F
 O18q0kKwF+xSN0FdIgWcApb8Uv8BzW9RHDJQEdUVzDWAkofn2o+b3l0hkrVFnhzxzZ1WFUdxy
 z4HpN4/076xAjoRUjBuNGgUYyMAHudg6aysb8a98egU03qZLqNUZ2s4O3emW3qylLZvmPol7H
 bQBO7bdaEI0Mli+Fz88C6D1OQgOSk/UaBLmft160Ljeo9wnzA01Bz3tH2IwzsQhcN2AHs1zSB
 rOpyjMV2gXVpKvPF+j4KgRDAxyGISDZlu9q5ZJiqrcoD2IhV6K196SBK3I2WX/eQ83PQfjnQr
 VHCXQvrkl2rOOawe6AXcBbQMWy9Q4iRHIMaPSykrTfHBRoV3G20Y6IA3lfTpy61odxpopJd/4
 u7ba2JmoBlOudkDe1x1h8X8emp8XrAUF9gpIJdKqzB/dv/oCl/pSTy2mcgj6qbcGUcgZxfqgW
 1DKBHlgjCH7neJQvKjIXKBxOYQWWLEdMvRIap6uVnz1Hjrh/34T0vTGfrmRgQbJvp0vLjEwby
 vP0xtAIRKkTKmxR2pv7zSqF6ywQ=
Subject: [cocci] [PATCH 2/3] mtd: ssfdc: Fix indentation in ssfdcr_add_mtd()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1415
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/4045abdd-fb88-4c1f-a947-cdb3d4e59aa6%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 15:17:58 +0100

Replace eight space characters by one tab.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/mtd/ssfdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ssfdc.c b/drivers/mtd/ssfdc.c
index 3ee8535d4515..e6de25087647 100644
=2D-- a/drivers/mtd/ssfdc.c
+++ b/drivers/mtd/ssfdc.c
@@ -351,7 +351,7 @@ static void ssfdcr_add_mtd(struct mtd_blktrans_ops *tr=
, struct mtd_info *mtd)
 out_err:
 	kfree(ssfdc->logic_block_map);
 out_free_ssfdc:
-        kfree(ssfdc);
+	kfree(ssfdc);
 }

 static void ssfdcr_remove_dev(struct mtd_blktrans_dev *dev)
=2D-
2.43.0

