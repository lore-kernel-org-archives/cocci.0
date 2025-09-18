Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD61CAC5A0
	for <cocci@archiver.kernel.org>; Thu, 18 Sep 2025 12:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=WnKLRueb1iIcJSVij+hT0JlorqYL70v6D+rxnlzGjZk=;
  b=FbAEEnRkdrfMdixR8p4Gbzrq7t8/Wbjcfr2iRjSVQsyM0G+Df/jlw9LQ
   ITb3RxdgB7Wlk+XFaNI4MG1oi9CSrzsJndTjWHOneFSVz/87JbJoJDIDc
   B9GKC769N5v1LyLEloYqn7dTBZe6Syf3nKiP9uTXJby5xZeCcQWMKRkkZ
   Y=;
X-CSE-ConnectionGUID: X88hPSmgR1SAcrF4V/YIQQ==
X-CSE-MsgGUID: tuZwmII4Sa2j1xZ4U+YREg==
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
X-IronPort-AV: E=Sophos;i="6.18,275,1751234400"; 
   d="scan'208";a="239844412"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Sep 2025 14:40:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 98AACE0C55; Thu, 18 Sep 2025 14:40:24 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2423EE0172
	for <cocci@sympa.inria.fr>; Thu, 18 Sep 2025 14:40:23 +0200 (CEST)
X-CSE-ConnectionGUID: L0hIZdxQT2mDm5zsa4wOUw==
X-CSE-MsgGUID: f1+ZfEy4QRey7aOiMjlgHA==
IronPort-SDR: 68cbfdb6_8ym7RKoKfsRbWCgXRm/XWQ+UVgnbTi/a1IICrA9cOgg9Kgi
 hpaNT0BWUCVIEXDClMlMUS06Qs9fO1j807UZHWg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EDAACu/MtogAMP49RaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgT8EAQEBAQELAYI/gQIGVDMEC0mEVYgchzSCIQOEO?=
 =?us-ascii?q?5gKgVWBfQIPAQMBDUQKAQIEAQEDBDiBVIJ0Aow4Ah4HAQQwCQ4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCjGGTw2CYgGBJIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBFwINOkQBAQECASMdAQERJgEECwsaAiYCAlYGA?=
 =?us-ascii?q?RQBAYJ+AYIiAQYQAQMPJgcNBrcVgTKBAYIMAQEG2l8fLCJZgWQDBoEbLgGFa?=
 =?us-ascii?q?4JkAYYng0J6Jw+BVUSBPAuCeD6CYQKBYINbgmmCJkRSg1aHHYgyiUNSeBwDW?=
 =?us-ascii?q?SwBVRMXCwcFgSBDAyo0MSNLBS0dgSd3gweBDYNZRStPghxygXQ+GUGDUx4Ga?=
 =?us-ascii?q?w8GgRUZSQICAgUCQz6BawYcBh8SAgMBAgI6VxCBfAICBII/CEACAQttPTcJC?=
 =?us-ascii?q?xsGPZZsgn4tB3QuGFAEgTAPDMZbNAeCOIFngWQMii6VPgYTL5dSDgaTBZkGI?=
 =?us-ascii?q?o1mlhmFIIFoOoFcMxokgzZPAxkPjiGEADPCSkE1CzECBwEKAQEDCYVGAQGMV?=
 =?us-ascii?q?oFLAQE?=
IronPort-PHdr: A9a23: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
 v8ejwxjfaIy+T2q71plfjL3
IronPort-Data: A9a23:yKPdRqzqLOEcxHq/AnV6t+fwwirEfRIJ4+MujC+fZmUNrF6WrkUBz
 WIXXWCOP6vcazD2KNBzPoyz/U4O7JKGnIJnGgRspVhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliOfVAOO6ULOZUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYqdDtEg06/gEk35qmq6WpI5gZWic1j5TcyqVFFVPrzGonqdxMUcqEMdsamS
 uDKyq2O/2+x138FFtO/n7/nRVYBS7jUMBLmoiI+t3+K33CuDgRrukoKHKJ0hXV/011lrPgto
 Dl5jqFcfC9yVkH6dEvxZDEDe812FfUuFLYquhFTu+TLp6HNWyOEL/mDkCjalGDXkwp6KTgmy
 BAWFNwCRjTbh8OEzKKCdrNpqsF+PtLiYJw4h241mFk1Dd5+KXzCa6DN+MMewzo6wMxDdRrcT
 5BAM3w1NkuGOkAJYT/7C7pm9Ausrlz2aT5FsxS4oaQt4m7c5BN82v7hPbI5f/TTH5gExhrF/
 jKuE2LRDEhZBtKy2Ga8yH+92ebonAb5XI0yPejtnhJtqAbPljRIWEJ+uUGAifK+gUW/c8lOL
 lQdvCsot6k7skKxJuQRRDW9p2OY+AERUZxcHoXW9T1h1ILwuwa4NGQUdwIbbfAj6d0tTGA18
 WKWyoaB6SNUjJWZTneU97GxpDy0ODQIIWJqWcPiZVRdizUEiN5r5i8jXupe/LiJYsrdNRyY/
 txnhC05mqlVksMBkam2lbwmv95OjsmTJuLWzlyJNo5A0u+fTND8D2BPwQaChcus1K7DEjG8U
 IEswqByFtwmA5CXjzCqS+4QBryv7PvtGGSD3A42RMJxpmX2oyDLkWVsDNdWexgB3iEsJmCBX
 aMvkV8Ovs470IaCNv4uMtnvYyjU5fK6So6/PhwrUja+SsMtJFfcrH4Gib+43mfrl1NkiqxXB
 HtoWZbEMJruMow+lGDeb75Fj9cDn3lirUuNH8yT50r9j9K2OiXPIZ9bawTmUwzMxPnUyOkj2
 4wPb5PSo/ieOcWiChTqHXk7dAlSdyJqVcim9qS6tIere2JbJY3oMNeJqZtJRmCvt/09ej7gr
 y/jCHxLgkHyn2PGIgisY3VuIuGnF5VmoH5xeWRmMV+00jJxKcyi/YUORasRJLMHze1EyeIrb
 v8nf87bPO9DZA6a8BsgbL78jrdYSjKVuSy0MRGIXh0Dbr97ZgmQ+tbbbgrlryYPKSystPoBm
 b6r1yKFYJ9aWQhSNdvaMsyu61aLuVkch+NAcE/aKfZDeEjX0dZLKg6gqtQVMs0zORH46T/C7
 DmvADAcvvvoj74u1cvg3ISojt6OPbNlP0x4G2L70+6HBRPC9DD+/b4aAfe6Qz/NcUjVpoOgX
 Lxx5NPhOqQlmF1qjdJNI4xzx/hj2+q19q5o9SU6LnDldF/xN6hBJEOB1sxxtqFg4L9VlA+1e
 0CX8OlhJrS7F5L5IWEVOTYaQLyP5dMMlhnWyMYFEkHwySt03biACGF5HR2Hjg5DJ7pUbqIh5
 8ocu/At1g/usSpyb+66jR1V+V+ccV0GcaEs7a8BDKHR1wEE91BlYL7nMBHQ3q2hUdt2DxQVE
 memv5aa37V47WjeQkU3DknIjLZ8h4xRmRVkz20iBlWum/ietMAWwS9+zDUTZSZWxyVhzOhcF
 DVKNUp0BKPW5BZuppFJcF6NEjF7Ji+y2xLO2X4WslbGXm+UVmDpB08sC9anpUw23TpVQWlGw
 eu+1m3gbwfPQOjw+SkDAWhetP3pSI1KxD3owcyIMZyMIMgnXGDDnKSrWGsvrinnC+MXgGnsh
 7Fj3MR0WJ3BGR8gmY8JIKjE6u1IUzGBHnJIft959qBQHW38RiC76QLTF2+PIPFyN9742m7mL
 fdxJ/B/dQW0jwePiTE5OZQiAZFJmNwR2d5TXY+zeEAnteOEoytLoaDg0HH0pFUWTuVElec/L
 YLsdAy+LFGAuEsMm0LwqJhrB2npR/gFewz2486t+sorCZ8okb9hYGMy4JSOrlSXNwprpSyVm
 Ab5Y47X0O1Q5oB+lKT8Eqh4JluVKPGicM+q4QyMo9B1QteXCvj3tiQRsUvCEzlNGLksB+RMi
 rWGteDo0HP/vLoZV37Tn7+DHfJr4fqecfV2MMWtClVnhgqHBdHR5iUc91CCKZBmlM1X4u+lT
 VCabOqybdskZMdP9kZKaiRxEwcvNIqvV/3O/RiClvWrDgQR9SflL9n9rH/gUjx9Rx8yYpb7D
 lf5huaq6tVmt79zPR4jBcx9IppGMVTmCLoHddrwiGGiNVOWoGi+45nsqRlxzgvwKCi0IJ6vq
 9aNDB3zbw+7t6z03clU+d469AEeCHFmx/I8ZAQB8tpxkCq3F3MCMf9bC5gdF5VIiWbn4fkUv
 t0WgLcKUk0RnAiocCkQJPzmWRqDQPMDMJH1K1TFOq9ShzieXOu97HlJr0+MIEuavhP8wevhJ
 dx2FrjYIE2q2p8wLQoMzqXTvAqkr882AloX9Eq7n8Ga79Pyx1kV/CQJITehnhAr3y0AeIsn6
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:xNEvXq/vEhnFMgriI9tuk+AMI+orL9Y04lQ7vn2ZhyYlEfBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIK6PoSjjPZL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3ADH1EA2l4kUc0eg0e3/LxmHVNfVnXOVmFzFbiL1+?=
 =?us-ascii?q?BNTxsZLjIW0SZpLxDrtU7zg=3D=3D?=
X-Talos-MUID: 9a23:useS9wotVQpV2a9wtp8ezz87d/VmzrXyMXoAgMoPnMihNyh/Gx7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,275,1751234400"; 
   d="scan'208";a="125904508"
X-MGA-submission: =?us-ascii?q?MDGimwIslsOBSmyM5Mo4jFD21WEodfwWBl6DbZ?=
 =?us-ascii?q?1P9muX/5+UKEtZ1/XnaAm+Hn5JrDFegpylZJral3UGUPB1P5ZAQYqZEa?=
 =?us-ascii?q?5hKvvsbLWACO6bP4jQjUGGPMaomT2N9cjaxZudxjXpp9C5AjKxSXSlir?=
 =?us-ascii?q?BQ/fFQt9YSvLSekn+n2yiqkA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 14:40:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758199221; x=1758804021; i=markus.elfring@web.de;
	bh=WnKLRueb1iIcJSVij+hT0JlorqYL70v6D+rxnlzGjZk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sj7Safh4YA2cmIDLPWD4aruhZ7R7yz5iIKWtW+4jJu76CRxlzUsDxIvacgFuLfbB
	 MR39xz9eTgIGbLQnYttGsOsTGnTnKnHJFr2xN3D6px+SK1eFS3XD6sAAkFYQEN+gN
	 c438xBRFBZMGL2Q5AKojgavxosEslWzqiXDu5MFV8/wsfLiJk/n68Lwk46tIllaih
	 XCi5KfEl3m2lrXmbenS4Ip5eloHKvE49WkGcKzU0RJrC0LQ45dRojueR1DcGeoGj+
	 pNTqYIvWrgFTMPQisPIkWuN1wZPjxqBD604bQ6JhLQrpnXkrFeVYQ+JOgIJkAavS8
	 mpyD635TinKtrYz1ew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.192]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1aIB-1uwBvq1MiJ-0016Qp; Thu, 18
 Sep 2025 14:40:21 +0200
Message-ID: <681e64d4-4a10-4c7e-9680-97de27ca5482@web.de>
Date: Thu, 18 Sep 2025 14:40:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Erick Karanja <karanja99erick@gmail.com>, cocci@inria.fr
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <64c3889e132a96853a361791c44fcea1a0aaac8c.camel@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <64c3889e132a96853a361791c44fcea1a0aaac8c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M/Ph8pyryd9dbnbDsDx9cir269Kcqk7y4QnPT63EMqWkqlPCoA/
 +P1y23KO7u3BZx8bFk6oSVYOPFehL0+A9MaVPwtGHPc0kIGP9EENnt3eJoHHmTj7z2Fidln
 sUa9pXpQgPESdpBnPG0wBaEMqs5Rr16Ntmd3cRbl8IA/Lqh+qF8LfQYBL2TpK32OtqzYVTX
 3Z9omelvRnM2BIR/uNkFA==
UI-OutboundReport: notjunk:1;M01:P0:vZ9dkwuB56g=;IWXynzrCscrrnYd3kTnmoGJALPP
 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
Subject: Re: [cocci] [RFC] coccinelle script: scope-based resource cleanup
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3028
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/681e64d4-4a10-4c7e-9680-97de27ca5482%40web.de>

> With the guidance of my mentor Julia Lawall, I have developed a
> Coccinelle script that assists with scope-based cleanup in the Linux
> kernel. The script aims to convert lock/unlock pattern to use guard
> cleanup macro.
> Link: https://github.com/Erickkaranja/scope_based_cleanup.git

Thanks for your growing development interests.

I added some review comments for further development considerations.


> When developing the rule some key consideration was taken to ensure the
> correctness of the transformation. This involved enforcing some strict
> rules and not transforming some patterns at all.
> For instance though, some transformation were correct to use guard,
> CLANG raises some warning and thus required a strict use of
> scoped_guard in this scenario. Refer to this commit
>=20
> https://gbmc.googlesource.com/linux/+/97f4b999e0c894d3e48e318aa113013203=
1815b3

How much will compiler versions matter?


> In cases where no transformation is applied, it is because performing
> one automatically could risk introducing errors or unintentionally
> changing the function=E2=80=99s intended behavior, so such instances hav=
e been
> deliberately left unchanged.

Will transformation requirements push also any improvements for the Coccin=
elle software?


> Examples
> case 1:
> In cases of inversed lock  pattern i.e where unlock happens before the
> lock.

Under which circumstances will =E2=80=9Clock-free=E2=80=9D data processing=
 parts become supported?


> case 2:
> Scoped_guard implementation uses a for loop, transforming code sections
> that braces a break statement within the scoped_guard could lead to
> unintended changed use of the break statement.

Will further collateral evolution become helpful?


> case 3:
> In scenarios of conditional jump, if there is some function call before
> the unlock, there is the danger of moving the function call to the
> critical section and if the function sleeps could lead to deadlocks.

I would appreciate clarifications for such a wording.

Regards,
Markus
