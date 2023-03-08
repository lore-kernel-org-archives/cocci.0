Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE81C678D5
	for <cocci@archiver.kernel.org>; Wed,  8 Mar 2023 10:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=85WRZm1EyN4RtgKUbLcW7CRynj26/Sh1hf4ZJxgYgjk=;
  b=NtDC3zJ8UrEZVwkYhgZwn5peZsQtmIZn8f3CJUJziJc1+9vjfssmhtlf
   kzqqXK492/T2l4r5/bLeRaBHkXYQy3Sjo2n37l/M/bAYwyt4Z4d7yUSvt
   aPedkm0oi3bgDPTXaPvMGDNLrKa/qjd7wI79CvG5WdPoKpt+qcZO7+8e+
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,243,1673910000"; 
   d="scan'208,217";a="96049369"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2023 11:05:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 43A3FE0C95; Wed,  8 Mar 2023 11:05:33 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 80B00E00BE
	for <cocci@sympa.inria.fr>; Wed,  8 Mar 2023 11:05:29 +0100 (CET)
IronPort-SDR: 64085de8_ez+4ni/ws44UwG46JrE2HeosqNfyjv3rJi27u6if+K3NSHY
 vG29H6ZVurLNXtGUzbND/KT711aS4B0M+RTCZtw==
X-IPAS-Result: =?us-ascii?q?A0G4AAAAXQhkgAQP49RaHQEBAQEJARIBBQUBgXsIAQsBg?=
 =?us-ascii?q?i2BSy8EC0aEU4gfhmCBdzGELocqhzeIaYFWgUA+DwEDAQ1BAQIEAQEDBIILg?=
 =?us-ascii?q?nMChTICHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECE?=
 =?us-ascii?q?AEBGwkXBw4FCQcihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RICR1M9AQICASMdAQERJgEECwsEPgICVwYBDAgBAYJ6gikBAw4jB7FcgTKBA?=
 =?us-ascii?q?YIIAQEGnAofLCJTgV4JgUABiRcBgzM0hDAnD4FVRIE8DIJ3PogcgmeMYopqC?=
 =?us-ascii?q?oE0dYEhDoE9gQYCCQIRa4ESCGiCAEECD2oLDndqByQEDgMZKx1AAgELOzo/N?=
 =?us-ascii?q?QYDCyMGWG0JJBETBQMLFSpHBAg2BQYcNBECCA8SDwYmQw5CNzQTBlwBKQsOE?=
 =?us-ascii?q?QNPgUYEL16BAQYBKCSbL3wTmHGGeKYgNAeCKIFVgVQMnwUGEy6XBw4GkiKXY?=
 =?us-ascii?q?CCndzWBLTqBXDMaJIM2TwMZD44gNxiDVo9HQDQ7AgcBCgEBAwkBgVWDcAEBh?=
 =?us-ascii?q?XsBAQ?=
IronPort-PHdr: A9a23:doyynhcUGsx87OBd5I1RkjsUlGM+MNTLVj580XLHo4xHfqnrxZn+J
 kuXvawr0AWUG9+Csbkc1KL/iOPJZy8p2d65qncMcZhBBVcuqP49uEgeOvODElDxN/XwbiY3T
 4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx7xKRR6JvjvGo7Vks+7y/2+94fcbglWhDexe61+I
 AiooQneqsUbg5ZpJ7osxBfOvnZHdONayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU
 7FWFSwqPG8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XCmp4
 ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWWZNQsNdWipcCY2+c
 oQPFfIMMvpboYfzqFQBowawCxeiBO7xyjFHhGT70rcm3+k7CwzKwAItEtAIvX/JrNv1LqASU
 eWtwafP1zrDdfBW2Srm6IPVfR4hpf+MXahxccrXxkkkCgTIgFKKpoz/PDOVy/8Nv3KU4epkW
 +KvkW8nqwd+ojW0yMYjlJLGipgIxV/a7Ch0xps+KtKkRkBhe9GkDIdQuD+AN4twWs4vTWBlt
 SU+x7MGu5O2fygExZY6yhLCZfKKcpWE7BzjWeuQITl1gHJrda+jixu28Uas1+PxW9ep3FtLr
 CdIksTAu3YQ3BLQ8siKUuVx8lq/1TqVyQzf9ONJLVopmafbMZIszaY8m54cvEjZECL6hV/6g
 ayWe0k++eWl5eLqaaj8qJCGLY97kAT+P7wumsOhBeQ4NRADX22c+eShyL3v50P4T6tRgfEsj
 6bWrojWJcUdpqGnHw9Yypgv5wuhAzu8ztgUg3sKIEhYdB+HlYTkNEnCIPXiAve+h1Ssni1rx
 /fDPrD5BZvCNGLDkLT8fbZm8UJSxw4zzd5F55JVDLEBL+n+W0Hvu9PDFBM2LhK7z/7hCNpmz
 oweQ36AAreFMKPOtl+F/uwiL/GWZIAJoDb9N+Ql5/n2gH89g1Acc7Om3Z8TaH2jH/VmIkCZb
 mH2gtgbC2sKvww+TPbriFKYSzJTaWyyU7om5j4nEIKmEZvDRoe1jbOd2ye0AoFZZmFdB1CXE
 Xbocp2EVO0WZCKTJM9hiD0EWqK7R48vzxGirBX6xKZ/LurI5i0Ysoru1MRw5+LJjxEy6T10D
 8KD3GyWTmB0n2YISCQs3K9lu0B9y1GD0bJ5g/NCD9BT6elJAU8GMsv+0uh7ApjWUx3IetPBH
 FS7RtSvRzU4Uds1x/cPZVx8EpOslEaHlxaqArIPja3DIZUu7qPa0mq5c/p9ynvczrhnqlA8X
 spJOH+Oh6hl9gGVCZSf1w2SkK2hdIwd2jTM/SGN1zmgpkZdBSt5S6bYRjgyYkXMrNL2rhfnR
 qWtFK9hHw9P08+EJYNVZ9evgVgQF6SrA8jXf2/kwzT4Ph2P3L7ZKdOyIw31vQ3YAUkAyEUI+
 GqecBM5HmGnqn7fCzpnERTuZVnt+K9wsiDzVVc6mieNaUApzL+p4lgNn/XJbvoJ3a8f/golp
 S91GlmVwN/cTdaN9EJ6ZKsJWdom+x9c0H7B8Ql0P5iuNadn03sXaQdqpAXD0xttC4NPudcnp
 jUmwVk6MrqWhXVGcT7QxpXsIvvXJ231qQiocLLT00rC3cy+/6AS9LInpl+lsAzB+lMK1XJh3
 pEV1nKd4s6PFw8OSdfqVV5x8RFmprbcay175oXO1HQqP7Pm+jnFk8kkAuco0HPCN59WLb+EG
 QnuEsYbG9nmKeoknEKsZw4FO+Ya/bA9Psevff+LkKCxO+MokDWjhGVBqIdztyDEvw91UO3Vx
 NAox/+C3w2IfyjxhhGtv4G/mIxJYy0TAnvq0TLtV8ZaYqx/e5pOCH/7eZTtgI8k2Ni0BjgEp
 zvBTxsc1cSkeASfdQn41AxUjgEMpGC/3DC/13pymi0oqayW2GrPxf7jfVwJID0uJiEqgFHyL
 Iyzl91fUlKval1jsRK/5lvhgYVfqr5+KWb7XkpCOST7ZTIHMOP4pv+ZbshD5Yl9+wBeSuehe
 ha3TrDnoh0V+zzuFS1SyXpoElPi8oW8lBt8hmWHKX91p3eMYsB8yyDU49nETOJQ1D4LLMVho
 QHeHUP0f9yg/NHP0ozGrvj7TGW5EJtabSjsy4qE8iq9/2xjRxOlzbi/ndjuEA5y1iGetZEic
 CzSrwvnJKTv2b67N+1PYURiQlPxo8Z3AYBxlIIsiYpYgyFAwM/PojxezCGvedxAkbrzdn8MW
 SIGz7u3qED+1UtvI2jIj4P1W3OBw9dwMtyzY2cYwCU4vIhBDKaZ6qABnDMg+APi61iLPr4kw
 3FBmp5MoDYAjuoEuRQg1HCYC7EWRgxDODD00g+P95a4pblWY2Cmdf6x0lB/lJavFuLnwEkUV
 XDnd5MlBSI14N94NQeG9XTp6Zz/PvTUY8gSsBK8jBrKyeRYYsFU9LJClW98NGTxsGdwgcsyl
 x9zxteXuIadKmNi1L20CFhUO3emAqFbsiGohqFYkMGM2ompFZg0ATQHUqzjSvewGS4Tv/DqZ
 E6eVScxoXCBFf/DDBeSvQ14+mnXHcnhZBT1bDEJiM9vTx6HKAlDjRAICX8ky4UhGFnixdS9I
 h0gvHZLvAG+80ESjLsyZ16lDwK97E+pcmtmEsHFakAMsUcbugGNdpbDpuNrQ3MCp8fn9lbSb
 DXEIVwPVz5BW1TYVQq6Yf/xv5+ZorLeXLbuaKGfBNfG4e1GC6XYn9T2jNYgpmvdcJ3IZCcqD
 uVniBAaAjYmQYKDw2pJE2tNyGrMd5LJ/k7jvHIt6JnuqrK1BEW1u+7tQ/NTKYk9q0rw2Pnec
 bTK1WAgcm4Q14tQly+SjuFBgRhI0HkoLWPlVL0EsWSloLv4vKhRAlZbbipyMJAN9KcgxkxWP
 tadjNrp17l+h/pzClFfVFWnlNv7LcoNa3qwMl/KHiPpfPyPOCHLzsfrYKi9VawYjeNasAe1s
 CqaFEmrNyqKlj3gXRSiee9WiyTTMBtbsYC7OhFjbAqrBMrhcQG+OcRrgCcexLopmjXVOGRaP
 TU9O0JBo7uM7D9J1/VyH2sSixgtZeKAmiuf86zZMsNM6KEtWH4r0bsHpihprtkdpDtJT/F0h
 ibI+9tnolX91/KK1iIiSx1W7DBCmIOMu0xmf6Tf7JhJH3jer3dvpS2dDQoHo9x9B5jhoadVn
 5LqnbjwNSwE3tba58oaCODLJcjBPHdrYn+LUHbESRAISzKmLzSVn0tGjPSb7WGYtLA/rYXw3
 oUDQPlXWRZmc5FSQlQgF9sELpBtWzoimrPOl88E6021qxzJTdlbtJTKPhpzKfDoNSrfkrROI
 RcFk+uQxWs7KYDxnUBvOAASdGHiBEfaG9xA8HUJUw==
IronPort-Data: A9a23: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
 abZiIyErIyGpZbNLPtd
IronPort-HdrOrdr: A9a23:WcXKtqrQusHuZ/WIuPF/r2saV5r1eYIsimQD101hICG9vPbo8P
 xG785rsSMc6Qx8ZJhEo7u90ca7L080maQFh7X5eI3SJTUO21HIEGgB1+TfKlTbckWSygce79
 YET0EUMqySMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCajpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,243,1673910000"; 
   d="scan'208,217";a="49549849"
X-MGA-submission: =?us-ascii?q?MDHbA9Rt5jIshK5eWJcS9IYQic5hp0g1Lgz+Ut?=
 =?us-ascii?q?PQm/6V+vc6q1gi5zUjGlAJMMwTSoWP1h4C/QT5RZ/ImpeYPYaz0Hgm51?=
 =?us-ascii?q?0OQSFS52XD6nFVibWSw421cIUepyN6GT7ykxF72TTCGq+ZP1kxbc4K3O?=
 =?us-ascii?q?XCgflgvxnupK2AmqelLROTng=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 11:05:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1678269927; i=markus.elfring@web.de;
	bh=6qtsdjBwVeMV6f8xrWJWLmmmRcOdAi7Yr4sqQZROSzU=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=lhkcM1z9mJtZKqTYL4JUrg9Rkh5HVd6x+mDRPA5V2Pprp2zDo6Q0Hy7OGEYR+RJot
	 Ig7XNLkacFygbyCXR8eDjCMl2UvX8oISrPpU5Km1D6vweZhUZNxVVsSiULL8biCcec
	 LXnHlOYkFGinnhFyQItA55DROddRwc3QNn0o/f1yP6fc1OZ3DGtfDZGNeJbM2RX2gR
	 dVx8O9BVcShSL79iy5q3gxDbHesXnIt7K43CWYdUFebX83aDQxkpLdbHlTy2zoGQIe
	 wCdjO8WcPFTPMxqhl0heERaJTmQgIXiRm+nTFVI7gUsJ21iyGriwRg5XuVT+Yz8VOA
	 02OobqyAIfJAw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8n46-1qfZqL1xKw-0165TS; Wed, 08
 Mar 2023 11:05:27 +0100
Content-Type: multipart/alternative;
 boundary="------------Vd0seSIT0yrlQtlEMcnds0cG"
Message-ID: <a68b1738-568d-1289-9929-51687b06941e@web.de>
Date: Wed, 8 Mar 2023 11:05:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To: Julia Lawall <julia.lawall@inria.fr>,
 Thierry Martinez <Thierry.Martinez@inria.fr>, cocci@inria.fr
References: <20230307104945.3125611-1-tt.rantala@gmail.com>
 <ec7c6da4-6e56-60d1-ba61-dbc72db8a662@inria.fr>
Content-Language: en-GB
Cc: Tommi Rantala <tt.rantala@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ec7c6da4-6e56-60d1-ba61-dbc72db8a662@inria.fr>
X-Provags-ID: V03:K1:BZmPKkA2xy/9I22G3mJ7qcl+dMakzW1P/aJgcgh3x1PORb5NGbG
 b2X1vmJqn5M0dxOGk1lErKtHeK8YQthuVyjQKGdVLBZhAPF8WIeoi5opd6/QEBj6VG20veD
 yoZtCYUw/gsQfxYiBy9UZevKlz2y6Ib3Lh19pwq7LiyVOEhrRkoU0Y3oSMBjvEPUrUZ1yVp
 xvDsZg5xo/nkem8WT/ZIg==
UI-OutboundReport: notjunk:1;M01:P0:qMROBCbHVH0=;kwuwNaWPAET5Xs4eh/E3fvUPiL2
 dr6yhEy6Nnl0PSIAY4tzGgoCmxRdW44TX2wdTOHT5ClS5wDf9TiVidU3bCo+tzD1TZ5blZmxu
 C7QYp/6v5kCehMd0jdegCDzQSDZ3H8z+Vhslf4UfTANFfbW+U+SsQcETVgAQDpUZnIwfxzq6N
 CoHAYoPpoppEOh8iwkXdP+xAna61yFc9iT92RaUognY2CLmKchQcjIHh/936598QCvCDKIpsj
 5XyEeGboXRtrWdAt5Y/N92U5lpwAGb/UfrTerVEjveYOSvrXMC2dNwGnrFODfS5t//7h7NgFy
 RsHsc6i9uY2ku8VdI3szdZfd1UcbvvJrUZ5vnFC8XroZ17Dtugm93jf9DSoP+u3sFFKKHL8kz
 dIKhYTdwTcNT08xqQIgpIDIaESrEuf5zq8378fMFa4VO06JntF++eRPG2tMMetyKXhUHa0ywg
 dGJS5QRjQd+FzTuBkbGl/pJbd/EyoXgF9bY3eXPbG6unR0qkzlHQuhfNzFsn5uOo8ldIbj2Vi
 dOM308vaq8ZBS8goUA1zshMKdgI9vVuZ6l5Y3vl6KCJM24VuvbM+f+gyJbT9E/MF4RtoeYpOW
 fcKWzouLarLQWOtV3NK6JrqFW5+Mv8IfFQxxUA+TBHR5ygef2WU3eN6639ITQULvki5dtdoCz
 y+Vwo5TTb4PneyfdwlwX21EO3EP2qMXj1d8FaDz+xaMI7ZtPP0HYzjchcoWfjMG/zOCZLzCF9
 6H/NMeKZ2rIJMND0slUdFPjTeWi2zGOhyZ97PXctVlBMMiL3ByOAKQeu3JsoC5XgcazXjtF3j
 cmH9g+Ytgp0ISPMQ7k0Gp+LBa/7Ha7QDJXT8NHMj1jFBytOqQcl9TjArrLW3r4QflOR36pI7L
 emwxQ/VHt4t7mIPFarh7pnaB1HmcL4x2lkuCa3p4FcoQ4V3hIBu6IDrB8zsfsv84tIxiYL4c2
 PIIo0w==
Subject: Re: [cocci] Checking the software build dependency
 =?UTF-8?Q?=E2=80=9Cbundles/pcre/pcre-ocaml/src/pcre=2Eml=2Ein=E2=80=9D?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 878
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/a68b1738-568d-1289-9929-51687b06941e%40web.de>

This is a multi-part message in MIME format.
--------------Vd0seSIT0yrlQtlEMcnds0cG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> The change is available on github.


I performed commands like the following accordingly.


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/20160205> git pull && m=
ake distclean &&./autogen && ./configure
=E2=80=A6
configure: creating ./config.status
config.status: error: cannot find input file: `bundles/pcre/pcre-ocaml/src=
/pcre.ml.in'



How should this software surprise be fixed?


Regards,
Markus

--------------Vd0seSIT0yrlQtlEMcnds0cG
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-=
8">
  </head>
  <body>
    <blockquote type=3D"cite"
      cite=3D"mid:ec7c6da4-6e56-60d1-ba61-dbc72db8a662@inria.fr">
      <pre class=3D"moz-quote-pre" wrap=3D"">The change is available on gi=
thub.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>I performed commands like the following accordingly.</p>
    <p><br>
    </p>
    <p><span style=3D"font-family:monospace"><span
          style=3D"color:#000000;background-color:#ffffff;">Markus_Elfring=
@Sonne:=E2=80=A6/Projekte/Coccinelle/20160205&gt;
          git pull &amp;&amp; </span></span><span
        style=3D"font-family:monospace"><span
          style=3D"color:#000000;background-color:#ffffff;"><span
            style=3D"font-family:monospace"><span
              style=3D"color:#000000;background-color:#ffffff;">make
              distclean &amp;&amp;</span></span></span></span><span
        style=3D"font-family:monospace"><span
          style=3D"color:#000000;background-color:#ffffff;"><span
            style=3D"font-family:monospace"><span
              style=3D"color:#000000;background-color:#ffffff;"><span
                style=3D"font-family:monospace"><span
                  style=3D"color:#000000;background-color:#ffffff;">
                  ./autogen &amp;&amp; ./configure</span><br>
              </span></span>=E2=80=A6<br>
          </span></span></span><span style=3D"font-family:monospace"><span
          style=3D"color:#000000;background-color:#ffffff;">configure:
          creating ./config.status
        </span><br>
        config.status: error: cannot find input file:
        `bundles/pcre/pcre-ocaml/src/pcre.ml.in'<br>
      </span></p>
    <p><br>
    </p>
    <p><br>
    </p>
    <p>How should this software surprise be fixed?</p>
    <br>
    Regards,<br>
    Markus<br>
  </body>
</html>

--------------Vd0seSIT0yrlQtlEMcnds0cG--
