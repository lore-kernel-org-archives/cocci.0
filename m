Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A8AF46424
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2026 09:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Cv27tQBqBwNZAYauHnozwmK0M5q/9UDFirvXZMJEKbc=;
  b=u2fp9OY4vB5msQKjXp/FBSQjZTF7x51j2hWB0f2CRoNVhHBs3YZNVxiT
   J/gKwdyrBy40bMCqfYABYQX9ZsifK6XSdXU68d5hs4riv+iZzpvW1UVSJ
   g6aDcDl8YhJ+HuPYfgg01F2Gai6B5WJROSttghvzcFjoXDyMnMH5mPc+a
   o=;
X-CSE-ConnectionGUID: 8XFdfND8TWKojDk3XoJuaQ==
X-CSE-MsgGUID: /p86pwhySFWc8D5wyxerdA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,123,1770591600"; 
   d="asc'?scan'208";a="267915544"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Mar 2026 10:29:30 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 4363281F69; Mon, 16 Mar 2026 10:29:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 340DE80E67
	for <cocci@sympa.inria.fr>; Sun, 15 Mar 2026 23:05:21 +0100 (CET)
X-CSE-ConnectionGUID: PKpakfkIR/G2C9Jp1qiwOQ==
X-CSE-MsgGUID: kJFE/fmoSzO3lDpLipn3RA==
IronPort-SDR: 69b72d20_44t5wldwTzpCZOcgTg7Mfop6pEhUlCFsEhTgp4FmNODWD4L
 qoBp5+X+v/aAAC/lKCYftJAZxzsHT6/2fWIvwjg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FwAQA3LLdphf4EaaxaglmCQYEHXzMEC0mEWINPhSyGW?=
 =?us-ascii?q?IIhA4V6hXqGd4svgX0CCAcBAwEIBTcaBAEBAwEDhQACjSMCHgcBBDAJDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBAUBJhk8NgmIBM?=
 =?us-ascii?q?3GBJQEBAQEBAQEBAQEBAQEdAg19AQEBAQIBIx0BATcBBAsLGCoCAhBGBoMVA?=
 =?us-ascii?q?YIiByMnA7M1eoEygQGCDAEBBoEI2yKBXgkDBhWBOIFYhnAMAYFdhBeEAHonG?=
 =?us-ascii?q?32BEIQ/PogegmmCJoEOiQeKJVKBFANZLAFLCjUMMytFQwOBKUsFN2USPyEdD?=
 =?us-ascii?q?xwfOQI4BwUSIREZgUR4ggEPhmp5AyMLXhoOIgI5XEo+XQWCLQInA3g9NxQbB?=
 =?us-ascii?q?IxfECENghA9gwcoPyKBIzg1xnyEJqI4lz+TGS6YWKlBgWg6gVwzGggoCIMiT?=
 =?us-ascii?q?wMZD446hGKEGMQCQjU9AgcCBw0DC5IcgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:78/sE6N/TDSo0IXvrR0mk8FynXyQoLVcMsEvi/8bNLWB5Y4Qp3Zem
 TxOHSzEb+HbITHFz+oGaYzl80tT6JXcyIdiTwNkrilhE3xH98ObXIWSIB79YXicIpTPRhg+4
 8hBYIbNcp44Q3LS/UfzYrG5piIsjajTGtIQZAK81gVZHGeIHw9x0kkLd5cFv7NVbfiF7yKl5
 4ijrZLUaQKo0mEsaW5K5a+KpEk/7fijtWxEtQM3NKxisQ6FnRH5LrpPfPDrdyOQrqp8R7PhG
 b6blNlV2kuDon/B3/v8yu6TnnUiG+OUYE7XzCILBsBOuzAazgQqyKE3KfEAXklejjSNjrhZx
 c5E3XCKYV5B0pbkxqJHCHG0LwkkZfcYoOSefCDm2SCu5xSun0XEk60G4H4eZtVwFtZfWQlm6
 fEeITYRWRGP78re6K67UORlmvM4J8DtOo4F0lk4pd0OJatOrTjrGs0m1PcAtNsCrpgm8cX2O
 6L1XQFSgCHoOHWjDLu45KUWx49EjlGnG9FRRcn8SaAfuwA/xyQpuFTh3Ua8lnVniqy5k27Bz
 l8q8VgVDTkiF8SWyjSG00jrqbXkzAHjAZsTC5qBo6sCbF27ngT/CTUKUkH9uv6kkEWzHdFSM
 UoZ/mwpt6daGE6DF4anGUTg/TjY+ERBB7K8EMVigO2J4qPQ8y6aC3ICQzoHb8Yp3CMzbWZ0i
 Q/UwomwXVSDtpWWa1ywsbmRqgigHnMRAXcmZDcCFjEstoyLTIYb1U6QEocyS8ZZlObdEjb7y
 DGitzk7n7xVjMgR1qz980qvqzaluZHNSiYn5wDdRGvj7wVjZYfjaZbA1LTAxepHNsCCSUSbt
 3VCmMWE6u0KS5aXm0RhXdnhApmRxO6MMzPfoGQoMMMKpha1omeiYqdptWQWyFhSDioSRdP+S
 GT60T69CbdPO2HsdqhqeYm8Tccn167tEZLiTP+8gjtyjnpZK1LvEMJGPBH4M4XRfK4Ezf5X1
 XCzLZfEMJriIf47pAdavs9EuVPR+szB+Y8jbcunkEj2gOH2iI+9QLQMNVKPJvw056OCpwHS/
 NdSLIOLzR4ZONDDjt3s2ddLdzgidCFrbbio8JY/XrDYfWJb9JQJUKS5LUUJINc9x/w9eyah1
 i3VZ3K0P3Ki2yKacFrRNygLhXGGdc8XkE/X9BcEZT6As0XPq672hEvGX8poJesU56Z4wORqT
 vIIXcyFD74dAn7E4jkRJ9215oBraB3h10rEMjuHcQoPWcdqZzXI3dv4ISrp1i0FVRSsueUE/
 raP6wL8QLg4fTpEMvr4UvyU4mmKjSAvo94qB0rsCftPSXro67lvenDQjOdoAsQiKifj5zq91
 iSMMyc6uNvyvJI/q/vPpKGbrrWGF/l1MVpaElL6s5e3F3j+1UiyzbBQVN2neWjma1r136G5d
 MNpz/3YG98WrmZg6oZTPe5i8vMj2oHJubRf8DVBIFzKSFaaUpVbPXiM2Jh0hJ1nn7N2l1O/Z
 ROSx4N8J76MBcLCFWwRLioDasCo96kduhvW3MQPDHTK3g1F15vZbhwKJDiJsjJXE5VtOoB8w
 esBht8f2zbitjUUaOS5ngJm3EXSCEcfUpcXlIAQW67qrQsJ9mtsQ7LhDg3O3ZXeTOkUb2cLJ
 GePibvgloZs4BPIU0AOGEjn2ctfgpUzuy528mISGmTRpP37gq4Y4R4A1xU2UQVf8Ttf2c1RJ
 GVAFhN4NIeOzRhSlelBWGGlQT9QDhin4Wj0mko7hUzCbkySTmeWBnYMCeWM20E48mxnYTlQ+
 o+D+lvlSTrHeMLQ3DM4fExY98zYUt168zPdlPCdH8iqG4cwZRzniPSMYVUkhgTGA8RromH6v
 shvofhNbJPkOR4qo6EUD5eQ0ZISQkumIE1AWfRQw7MbL1rDeT2d2Sm8FG7pQ5ljf8f1yE6fD
 9BiAultVB7kjSaHkW09NJ42erRxmKYk2coGdrbVPlU5irq4rAdykZfu5yP71X4KQdJvrJ4HE
 bnvVQm+S06euXgFvFX2jphgGnG5atw6dgHDzLiL0OEWJaki7sBoU28Pi4WRgVvEETFa7yq1v
 RzCbZD41+ZN65phtKqyH7RhBzebE8LSVuOJ/C/iovBIS83DAeXMhThIsGvXHRlkAqQMUY9Vk
 5WMr9/F80fXt5kmU23iusegFosYwe6QTeZoIsbMA30CphS7Wejo+Aolx2C0DbdrgeFtzJCra
 CXgYfThaONPfclWwUNkThR3EjEfOvzRVbjhrybslMa8IEER/iKfJez26EKzS39QcxIJHJjMC
 gXUnfKKzfIApaRuAC40Pd1XM6VaEnTCB5R/L8bQsAOGBFaGmlmB47vutSQx4AHxV0WrLpzI3
 oLndDPfKjKJp6D6/PNIuddTvzoWLkpHr8seQ0Y/w+Ny2heGVDMoDOJEPZs/X8Qe1mS40Zzjf
 zjCYVczESi3D3wObRz458+lRQuFQPAHPtDiPDEy4keIcGGMCZidBKd6vDJVi5usluAPEMn8Q
 T3fxpHxAvR16o1uX6AI4eGhiuohxf7AwH8Mv0fnnKQexvrY7aoijBRc8MhlDEQr0P0hUG3IK
 HIzSGQCR1u0IaI0Odg1YGZbQXn1oxu2pwjFrk6zLBL3uIiByuBEjvrlNIkfF1HFgNsifNYze
 J88e4dBD616FJDeVWvFdu/FWZNJNM8=
IronPort-HdrOrdr: A9a23:eSwK7apB/QIYkv6r9kTpeD4aV5okeYIsimQD101hICG9vPb4qy
 mLpoV96faUskd0ZJhEo7290ca7LU80maQb3WBVB8bFYOCEghrMEGgB1/qA/9SIIUSXnYRgPO
 VbAspD4bbLbWSS4/yV3DWF
X-Talos-CUID: 9a23:lXjWqWxyQwtlCBahvZ3QBgUsOdgscXPe7U2XDBWTWERxEaSUVniprfY=
X-Talos-MUID: 9a23:xAYEwwvLHVpqld03ss2nhxNMGYBm5qOVGmdWlbken8icM3dKEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,122,1770591600"; 
   d="asc'?scan'208";a="267855210"
X-MGA-submission: =?us-ascii?q?MDFW2xJmM2CfVsk06UDLetqoFlNvoIbS/viRwn?=
 =?us-ascii?q?Yk/fwFpMb498bg7LVSTjDr6NKZ00eFbUB/Lr5Y+tm7q8Zgim/O0mLdRa?=
 =?us-ascii?q?PRkcW9RlcxZoN+jIU0Rw3jlDVtg5M6WxSMTR8WX9XzDBDvD0fT+MRvCI?=
 =?us-ascii?q?wBmAQ50ful2VGijCzVjGpLEw=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 23:05:20 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5BCF961881;
	Sun, 15 Mar 2026 22:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E4DC4CEF7;
	Sun, 15 Mar 2026 22:05:16 +0000 (UTC)
Date: Sun, 15 Mar 2026 23:05:13 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr, 
	Nicolas Palix <nicolas.palix@imag.fr>, Kees Cook <kees@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Message-ID: <abcsydFAe1S7KR8q@devuan>
References: <cover.1772752564.git.alx@kernel.org>
 <9fd8d3d1e7ef3efb6e6dae0972dd515ff02e42bd.1773058287.git.alx@kernel.org>
 <806bcb6d-3ebb-4454-973c-f9d6530a17c2@web.de>
 <aa7XD-rk_KWQvTQX@devuan>
 <abblv3nCut5aRk7q@devuan>
 <105cf750-4bab-2a39-e62e-debceca68466@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="si2bjrmmkvasqwhc"
Content-Disposition: inline
In-Reply-To: <105cf750-4bab-2a39-e62e-debceca68466@inria.fr>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2] scripts/coccinelle: Add script for using
 ARRAY_END()
Reply-To: Alejandro Colomar <alx@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3435
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/J1qQ3zBXjA0zZMfa5HuqZg>


--si2bjrmmkvasqwhc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr, 
	Nicolas Palix <nicolas.palix@imag.fr>, Kees Cook <kees@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] scripts/coccinelle: Add script for using ARRAY_END()
Message-ID: <abcsydFAe1S7KR8q@devuan>
References: <cover.1772752564.git.alx@kernel.org>
 <9fd8d3d1e7ef3efb6e6dae0972dd515ff02e42bd.1773058287.git.alx@kernel.org>
 <806bcb6d-3ebb-4454-973c-f9d6530a17c2@web.de>
 <aa7XD-rk_KWQvTQX@devuan>
 <abblv3nCut5aRk7q@devuan>
 <105cf750-4bab-2a39-e62e-debceca68466@inria.fr>
MIME-Version: 1.0
In-Reply-To: <105cf750-4bab-2a39-e62e-debceca68466@inria.fr>

Hi Julia,

On 2026-03-15T18:54:32+0100, Julia Lawall wrote:
> > Here are more false negatives that I found manually.  The semantic patch
> > didn't find them.  Does anyone know how we could improve it or why it
> > didn't find them?
>=20
> Typically, some things are not found when Coccinelle is not able to parse
> the relevnt code.  You can see this with the --verbose-parsing option.
> BUG indicates the line where the parsing problem was detected and bug
> indicates the other lines that were ignored due to the parse error.

Ahhh, thanks!  It seems there were issues parsing unrelated code, so not
a problem of the semantic patch.  I'll remove the comment about false
negatives and send v3.


> julia

Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es>

--si2bjrmmkvasqwhc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmm3LRMACgkQ64mZXMKQ
wqksZw/6AmUWEVoAZdvuU4aGOd7QuUuQqPwwo47e42fX1tDVDY5ZrNQT+E2EjB9z
3pSCGFGnooSsUl699VOkDhse34GGiXK6LBea6C6BSc7I+kk0dTf2DpS52FhgTP8L
4FHTRJSLSZx1BvCbechCLCkYmdl70Ag84vp3Y07siinszxcgGe9FN8js7mvZE/yb
U7Nc/q6N8JgATbOfcvjE1H3xnVwHuRO2dvTwCWRhNTNzb/Q0api1+MHJO6A/Jg7X
cET+Gteee6xsOYfZpAf+h2puDRl5JqOpM2vg7dNQYI8k+cl9FZkUGhd6ILQrBk5e
vGxQrpbkVafIGVD22elv/x6R/sO2nAHAD35LpmDL1FxTbz9jUCyAVtebLGxYwLTB
b251mM6gUVgOkcN6NB0XP8WAr3nI0s87KscKBNC2sREcjeZTyj4BFbDpwoL9wo/V
EeTgrWeOhc6h7PTGuytiG2qxPFqy3jwtPPyR+oIFiMRLB6XSPMUOPRD6F8tlzXwE
vJUIV+VtPQ1cdv2foCNnrqcA6HKTDnRedx0vAJBaYpfDZIYtnF5uY3PaRtgdnBnk
jfvf8iQ3cueqY5NESg+ZiA/PTnsi6gcNc16LuowT/6dl4dFCJzEp8w1YAivykS7j
TQw1yVQ4mqBGWAkEc7ThvOtGLU9KSAxB1n51+l25MrlfezTl3AY=
=c/0o
-----END PGP SIGNATURE-----

--si2bjrmmkvasqwhc--
