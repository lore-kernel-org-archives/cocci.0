Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F329C46CD2
	for <cocci@archiver.kernel.org>; Wed, 24 Jan 2024 18:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ZjP3ERBq+ItiCpgchoOhIoMKXIxcqL6EtbFfRpX96S8=;
  b=KCW0TuUcCtifNP3jCW8ZEOd2SLYQSQpkeA3SJV6TvIbEQYf1noVNSC8M
   tFKPSHQ/1d1MlsCEoOGoms4JlSLf0ikY1Esxbg5cSePE4/odqZ0lXgIsW
   nZmroLXYGLf14krpw+7GdxJot7j6zmctK6n7pBZC292SETEnNEeNmCpci
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148463548"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jan 2024 19:03:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 26A93E008A; Wed, 24 Jan 2024 19:03:00 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F1D39E0035
	for <cocci@sympa.inria.fr>; Wed, 24 Jan 2024 19:02:56 +0100 (CET)
IronPort-SDR: 65b150d0_vqB0Rlo2423IOd81OF7Ch5xtZh/XyOcUvwYnj2vJDM4G2Um
 azFMYe/TiOmSRu64HGeJ4nR5/DdGSConeFtD+tg==
X-IPAS-Result: =?us-ascii?q?A0GsBQCUT7Fl/07ASNlaHgEBCxIMQIQIB3hTMgQLSIRTk?=
 =?us-ascii?q?TaBBYNmhzaHTohvgxY+DwEDAQ1BAQIEAQEDBIR1AQkCh0oCHgcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAoEGE4VsDYJcARCBDIEeAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBFwJHQgYjHQEBEScPCxoCJgICVgYBFAEBgnyCKwEDM?=
 =?us-ascii?q?Qe2dIEygQGCCgEBBq9ZHywiVoFhCYEaLogcAYRFgSKEOycPgVVEgTyCUjE+h?=
 =?us-ascii?q?EODW4JomBxUfx0DgQUEXA8bEB43ERATDQMIbh0CMTwDBQMEMgoSDAshBVUDQ?=
 =?us-ascii?q?AZJCwMCGgUDAwSBMAUNGgIQGgYMJgMDEkkCEBQDOAMDBgMKMQcpVUEMUANlH?=
 =?us-ascii?q?zIJPAsEDBoCGxsNJyMCLEADERICFgMkFgQ2EQkLJgMqBjcCEgwGBgldCR0HD?=
 =?us-ascii?q?wkEJQMIBAMrKQMjM0ERAwQKAxQHCwd4ghCBPgQTRwMQgRoDGSsdQAIBC209N?=
 =?us-ascii?q?QkLGwY9ApoydR6CQKJxokk0B4I0gWCBYQyfLwYTL4NyAZM6DgaSWZhUIKhNg?=
 =?us-ascii?q?XomgVkzGiSDNk8DGQ+OIIQtj0dANTsCBwsBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23:GSmj3RalaXVIl5YzJA8nFar/LTEY2oqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1g+PB9SCoKsc0aL/iOPJZy8p2dW7jDg6aptCVhsI2409vjcLJ4q7M3D9N+PgdCcgH
 c5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFRrhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTajYr5+N
 gu6oAHMusUZnIduNrg9wQbVr3VVfOhb2WxnKVWPkhjm4cu+4IBt+DlKtfI78M5AX6T6f6AmQ
 rFdET8rLWM76tD1uBfaVQeA6WcSXWsQkhpTHgjK9wr6UYvrsiv7reVyxi+XNtDrQL8uWDSi6
 6BrSAL0iCoCKjU0/n3bhtB2galGux+quQBxzJDIb4GULPp+f73SfdUGRWpaQ81dUzVNDp6gY
 4cTCuYMO/tToYvgqFsUtRawBgeiC+zhxTFVmHH206003OY9Hg/JxwEgA8sOvW7IoNnpKqsfU
 +a4x7TIwzXZaPNW3C/w5o/SfRA7ovGMQKlwetfex0krGQPFlFSQqYrqPziI0ekDtHKU7/BjV
 eKykG4rsQ5/ojyhxsc2i4nJgI0Vx0vK9Cpn24k5P8C3R1BibNOiDZBfuD2UOZFsTcM+X2Fnp
 jw6yrsetJO6YiUH1IgryhrBZvGFboSG7RDuWeWMLTp6h39pZbKyiwq9/0S8yuPyVse53EtXo
 idEnNfCuH4D2RLR58WZSPZw+Fqq1zWX1w3L9O1IPEI5mbDZJpI/2LI8i54evVrZEiL0m0j6l
 Kube0o+9uWm9ujreLbrqoKGO4JwigzzNLkll9K7AeQlKQgOQ3aU+f6h2r3i/Ez2Xq1HguEwn
 6LEqp7VP94bqbS8AwJN0oYs9RK/DzC+3dQdmnkHMU5FdAiJjof3IF7COu33Aumnj1Stljdk2
 ezGM6X/DpnQLHXPirXscahn50JBzAc/08pT6pBXB70ZJfL8QE7xtNjWDh8jNAy0xv7qBtJn2
 YMEWmKPH7SZPLndv1+M6OIvOeiMZIkauDvmJfkq+eXhgWUkllADZaWp24AYZ2iiHvt6O0WZf
 WbsgtAZHGsUpgY+VvDliEWeUT5PYHa/R74z5jYnB426DIfOXZutgbyE3CejBJJafGFGClaWE
 XfpbYqIQfkMaDiKLs97jjMETaShS5Mm1Ry2sA/10bRmIfDQ+i0crp/i1dl15+jImhEo7zN4F
 cWd02eXT2F1hGwEXTE23Los6XB6n3We1alxy9hRCtVX47sdUBo+NJeay+VlAtT2cgPHZNaAD
 li8FJHuCjY6RdMZwtkUYk87Fc/xoArE2n+PCqUWiqfDKZg66KPa0DClAs9nyGvdkoQlgUMnR
 MRnKmCswKJyoVuAT7XVmlmUwv75PZ8X2zTAoSLalTLmVCBwVQdxVf+ARnUDfg7Mqt+/4EreT
 rioALBhMw1byMfEJLEZIsbxgwBgQ/HucM/bf3r3g325UDOB3LCRd8zHf2sH3SPSIFcJmUYf8
 CXOLhAwUx+ouHmWFzlyDRTqakLo//N5rSaeR1U30hrMQklvzbuz9TYKiPbaR/5AlqkctnIHr
 DN5VE24w8qQC9eEoF95e75AZNom/Fpd/WfeqhA7IZGqaaxv7rIHWyJwuU6mlxB+C4Ea1NMvs
 Gtv1g15b6SRzFJGcTqcm5H2ILzebGforlipbObN11fS3czzmO9H4ekkq1jloACiF1Yzu3Rh3
 d5P1nKA55LMRAMMWJP1W0wz+lB0vbbfKiU64orV0zVrP8zW+nfn0sgqGfBj5xKuZdZZP4ubG
 QW0H8BbT8miJeo2mkS4OwoeNbMa/6o1MsW6MvqejfTyY6A/xnT/3D4Bv9AutyDEvzBxQePJw
 ZsflvSR3w/dEiz5kE/kqMf834ZNeTAVGGO7jyniHo9YIKNoLuNpQS+jJdO6wtJmitvjQXldo
 RSGDkkFxdTvVB6cdV370iVP2E5RrXHtyk7ah3Rk1iokqKaSxnmE5u34dwccfENPSnNji1jEP
 oW+ydwXFhvNDUBhhF6u4kD0wLJeraJ0IjzIQEtGSCPxKnlrTqq6srfqj9dn0Jozqm0XVe29Z
 QrfUbvhu14A1CilGWJCxTc9fjXsu5PjnhU8hnjPZHp0qXPYf4l3y3K9rJT5TORSwyFAaS12k
 zjRCXCjMtPv8djcm5rYs++4Xn6sTdUJKHatktnG7XrhozI6SRSk1+i+gNjmDRQ33UqZn5FxW
 CPEoQy9Kojn2qKmMP52K0xhBVvy8c1/Scl1loo9go1V2GBP3MzKuyVd1z6ia5MEifGbDjJFX
 zMAzt/L7RKw3URiKijM3IflTjCHxcAnYdCmY2QQ0yZ77sZQCa7S4qYX+Ek96le+sw/VZuBw2
 zkHzv57olsTmeIUo0wAyiuHA7YdNVZVN2rgml7birL25LUSf2upfbWqgQBblMqiEarEjwVSQ
 nf/db89ECU24sg1YzeumDXjr4rjftfXd9casBaZxgzBg+ZiI5U0jvMWhCBjNDG1rTg/xuU8l
 xArwYCisd3NNTB25KzgSE09VHW9d4YJ9zrql6obgsuGw9XlAMB6AjtSFJK6SPW1DHQNuP6hO
 wvGGW85rWqHXKrRGhWA4V1q6W3CGdanOhT1bDEQn9BlWQXYLktChgsZGio3lNg1G0ijlsnmb
 Vs87Ssb+1r77EJFzO4xcRL4VwK97E+hODIzVYTaJwFd6RtaoR7cN8DHqOl0GmlO95ml5mRhM
 0S9YAJFRSEMU02AXRX4O6W2oMPH+K6eD/a/KP3HZfOPr/ZfXrGG38Dn1Iwu5DuKOsiVWxsqR
 /QmxkpOW2x4EMXFin0OTSIQjSfEc8+col+15CR2qsm19PmjVhjo4MODDL5bMNMn/B7T4+/LL
 +mLmCNwMipVzLsJwmLUjqcS1hgehmAmdjWgF6gBqT+YTK/UnfwybVZTYCdyOc1UqqMki1MUZ
 oiE0JWsh+Q+0a5mbjUNHUbskcyoe8EQdmS0NVedQV2OKKzDPzrAhcf+faK7T7RUyuRSrRy5/
 ziBQCqBdnyOkSfkUxe3PKRCliaeaVZ7sZu+bw0rJGztVtPgZTWkPdUxgTB8kthWzjvacHURN
 zRxaRYHtrqL8SZRmelyAURE6Wd5a/aJkWCV4qOLT/Re+esuCSNymeVA5X08wLYA9yBISst+n
 y7Kp8JvqVWr+gFg4iVqWlxCp2QS7GpulVpvM+PV+8sYMZ4l1BcK8HnWFBkA4ddoWIWHhg==
IronPort-Data: A9a23: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
 YiwjeM=
IronPort-HdrOrdr: A9a23:SMvBYaDpBGstBljlHely55DYdb4zR+YMi2TDpHoBKiC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOk9K1vp
 0BT0ERMqyTMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: =?us-ascii?q?9a23=3An57C+GmA2mehh7gq7OXJAetqppLXOW3s/VH2EWv?=
 =?us-ascii?q?7MGZoYuONSQSw4qxvn9U7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AE5xNsg7JvK+Gno+2sQ65KK7jxow0z7iuEXEdyqw?=
 =?us-ascii?q?PmMy6NRJgOi3CrBuOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148463545"
X-MGA-submission: =?us-ascii?q?MDGaNKNldoABxgH6U6ipMBngnu/9l/oEITZ7Fd?=
 =?us-ascii?q?8gX3we06x4zTCegadgOnKpyRd+X9TRGOLo7FVufREv1pcHCQMtc+J1md?=
 =?us-ascii?q?BQirL7vo2KwCb1bZHByUxtUNovCsBgEVAcivlQ1D0+XAHWLnHRB2kQrY?=
 =?us-ascii?q?0Rmb+XiqqSkH40Ooa2TQt1FA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 19:02:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706119368; x=1706724168; i=markus.elfring@web.de;
	bh=+/OoLVN6jUSeiiXb3upZnVbwRCdSurRuo8PYKYwIgEM=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=hl4jccuIdx7ozkELrqnVSmparZBnGAte43R8uy3rPpz2dze+PhDOq41Y7PTMfffJ
	 9JDkpDQ6FglOLiKdNMYABtz5CTvefNLbIrXeSo1pJ5eyY9p1dTCJB+FiJfXflACCG
	 s6vh9eunldBvn4OdQVW626BLGfuAR1yeCxoD+DlVwVn0UYYYm/82g/JmRmB1hevbR
	 LNecd0TWWHz+8GiDaGPtWJ1kL7ecDmkk1/8wZnYmeqYBvnkfmCQfyoEX0Jeu0Ix4i
	 qPyFGuBKp+5p8uSNseCDO8Q32iLl/MCmJ0GicExhyNJnQWnN7KG1seYa9EQ2OnaXg
	 hXpITr8MulU9MHwUbQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N947J-1qzN6e3yH1-016BWD; Wed, 24
 Jan 2024 19:02:47 +0100
Message-ID: <c41c9f8e-acdd-4e04-8c2a-8f1589e50785@web.de>
Date: Wed, 24 Jan 2024 19:02:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <4604ee8e-a876-4545-b0cb-e4fba2e187a2@web.de>
 <c5407d97-913-f788-7ffb-11b65373cb5@inria.fr>
 <23ff96d1-8cf2-4736-be84-c00600b15a73@web.de>
 <297bf3e1-8262-a599-20ff-dc8086d5b87a@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <297bf3e1-8262-a599-20ff-dc8086d5b87a@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DdZ7jEFmfxwiYAifSjjjNssIO5W6mSRmAKj1U0kWG2xe4oPZME8
 N3IEynSzGFneE+XFauYrUZfOAtvtGfxCoEZ2yQbAAkBYygBe6dPxC5krEUeGzEmtFJSAycU
 xxIkGrhkLsOfkcoqNr5W2fEo+mT1JhvGE1pXqb70zOlCOGE3gKPrciyoTKhReVzh7wq/Tdk
 0hrxexQNE7KE/20nzuycg==
UI-OutboundReport: notjunk:1;M01:P0:04Xwm6/40Lg=;mBD0xJJHYnqRG/9nUdmmZp1xXWB
 T3qN1LbDzj8xEkjhUbD6aRYSnIYzJtNkOPhnYdd/49jwBX7u2RyEt9YG/F/epdmxhQmpG9HYo
 sB1V4biD2Nmd1vzb9AHbTS5NSRr5z7gLBZbQlwhzuPBNCbBZlwlV0u7KJDxWXTbkhFWaBCDnY
 +1SW7RuUY6pmoCCUTU9klpz/AqWiJeBbaOnGI1TwfuJtPmGXymZraoneQiydJDXUswiSUlMo7
 eMu+0oEoAq8jYMVhh/P3MUnlfwo57MKsx9Aul5vVuW3Hr2wBwZZfvZNGI68Wl5ycCQVXnJU3/
 HFNmQBj/bYoVtJ6zRY+NKAhRxCrXFvWW+gMEqYeJGHb2y0RK4RxGQIXte+miRFHoBCuZUPJRP
 8SzbJZZ0KzZ+ZBt0dMhWwBSbaQFBy4EpZyfqEQRUKzJ9SExfUT1/XLqNPVwVLyDQS4amihOKz
 vbIuXdKIZt8QoL3GJp3LCdUzPiVJLAWVZvcWA0FoLnz3j6fDF4uyuZvV81gUM1SGHq75wfCGn
 Vz4GHZYVOZ+C3GLlQMT65QhoIkqNt2L+DWzYqZhB9Bns+UfTlTlZVIBwW1nPU7Ws5Ve9tQnO6
 Rkjrw+yjSxlNJlHaeIW1NREZl5yThHzQrOYLeC3Y7iut+1ciApWg06GhN4y2cN7V3qtyaqsK/
 v4yEzsYemBd3z1MpVfcAJ+Qwep0WBSuYsthz7o3mfVrho1FBLj2EY5GWow2EhH6DoOXzkLtrr
 KkRW7jW9LhCm5I/+h9t4neVmgrV/tQfLuDKC1NkkoX+iRrsGLxNSQv8nyu1wa4RuV4Wbikcph
 eD5pW23451QAn7eHl1+F0UgrLS44k8qismHXRR3Id4KOAp4btJdzXq8ZG8VYbBryljathI+TY
 QC9eReQvkVWbO3buomVDJlx1hgIdTJcXmoFEOWPlMYclhjRnuvBUL2YYR31KfFIJj/hTfLDa5
 mxOa0g==
Subject: Re: [cocci] Checking a parse error for detailed SmPL rule
 properties
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1480
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/c41c9f8e-acdd-4e04-8c2a-8f1589e50785%40web.de>

>>>> May SmPL rule identifiers be chosen freely?
>>>
>>> It seems that they should not be keywords.
>>
>> Should such SmPL identifiers be independent from an applied programming=
 language
>> like OCaml?
>
> It has nothing to do with OCaml.  or is an alternative form of || in C.

Why would such a technical aspect influence the identifier selection
within the name space of a rule for the semantic patch language?

Regards,
Markus
