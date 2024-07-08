Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D31C3271E
	for <cocci@archiver.kernel.org>; Mon,  8 Jul 2024 09:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=RMPhUzYfHTmZIledNLDKy1NqKXAjpCjqSPt1j8ZkZ20=;
  b=ki7Q3m9kEjPH5AydeGy+Xp5WviqqL1VRA2FibE97POFjBbP3/pHFDP3P
   /3vLEf+b51psvrQBEeiSjy+PxN9cLYcFGofA9DE4ZCRGFLQ2F+MkeGOAa
   o+Iuq0gHTx6GQM1hQAP5M7NP7I4vGCvHGOnjIxbKXpi0vJSlSq3Pxgczb
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@sang-engineering.com
X-IronPort-AV: E=Sophos;i="6.09,191,1716242400"; 
   d="asc'?scan'208";a="174422744"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Jul 2024 11:57:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AC50AE0CCE; Mon,  8 Jul 2024 11:57:09 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 990ADE0CCA
	for <cocci@sympa.inria.fr>; Mon,  8 Jul 2024 11:57:02 +0200 (CEST)
IronPort-SDR: 668bb7ee_ejmuQ1BXFraw1ylkje5pXu38K0MK1tzm1UcBnMfAeVgWOzv
 dqUUq8CNifbQfIxOJHuMU0BTVlKHtT93hUpq0yQ==
X-IPAS-Result: =?us-ascii?q?A0EcAACBtotmkCH+dcJaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDgVU0BwhIjHNfiFEghXqMa4spgX4IBwEDAQgFRAQBAQMBA4R/A?=
 =?us-ascii?q?okTIAYBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBA?=
 =?us-ascii?q?QEBIB4QCgQnhXQNgmcBgQWBEQEBAQEBAQEBAQIBAQEiKwKBCwEBAQIBQAEBN?=
 =?us-ascii?q?wEPC0YQRgYKgwkBgkEjB68FgTSBAYIMAQEG3B2BXAcJgUgBgVaGTwsBgVOHb?=
 =?us-ascii?q?3qCT4Q/PosHlkaDEYIgiWcmC4x9VIEXA1khEwFLCjVbAhYDGxgwDwkLJikGO?=
 =?us-ascii?q?QISDAYGBlk0CQQjAwgEA0IDIHERAwQaBAsHOD+BcYE0BBNEA4E3iW8Mgy0pg?=
 =?us-ascii?q?UknhGZshAGBawxhiGOCTYFjgn2BFoRRHUADeD01FBsGpz8vgRGFfYMtxgCEH?=
 =?us-ascii?q?qIRg18Bk1WScphponyGD4FnOoFcMxojgzdPAxkPjiEZg2HLaEQyOwIHCwEBA?=
 =?us-ascii?q?wmJIoFKAQE?=
IronPort-PHdr: A9a23:2nrR5BzUHEniG//XCzJ2wFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 xSZv6om1Q6BHd2Cra4e2qyO6+GocFdDyKjCmUhBSqAEbwUCh8QSkl5oK+++Imq/EsTXaTcnF
 t9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFRrlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5/I
 gm6oR/PusQUjoduN6I8wQbNrndUZuha32xlKUyXkhrm+su84Jtv+DlMtvw88MJNTar1c6MkQ
 LJCCzgoL34779DxuxnZSguP6HocUmEInRdNHgPI8hL0UIrvvyXjruZy1zWUMsPwTbAvRDSt9
 LxrRwPyiCcGLDE27mfagdFtga1BoRKhoxt/w5PIYIyQKfFzcL/Rcc8cSGFcRctaSTBPDZ2gY
 IsOF+oBPPhXr4/hp1sVsBCyARCgCP7zxjNUg3P727Ax3eY8HgHcxAEuEdIAvmrKodvoN6kSX
 ++6w7XVwjrBdP5W1ivx5ZLSfxw9vf2AQ7R9etfRx0k1EAPFi02dpoziPzOR2OQNqXKU7+99X
 uyykWEnrQ5xqSWoy8YikYnGnIUZykra+iV/3ok1Pse3SFVgbN6/CpRQsS6aO5JoTcMkTGFou
 SA6xaMYtp6hfSgKzpsnywTDZPyAdoiF+xTuX/ueLjlknnxqYq6/hwqs/ki6zO3xTsa63UhLo
 yZZk9TCtmwA2hPd5MWaSvZw+lus1DWP2g3X6exJPV44mLfHJpMlwbM9kpQdvETfEiLym0j4g
 q+Ye0Ei9+O16Orneq3rqoKYOoJ7kA3yL7kil86lDegmMgUDUHKX9Oqy2bDl4Eb0XrFKjuAtk
 qnFrp/aP9kVpq+4AgBLyosv9xCyBCq83tsCh3kINldFdQqHj4f3P1HOJ+j1DfKljFStlDdn3
 fHHMaP8ApXWMnTOnq3tcqtj5EJEyQozy85Q545MB70cJP/+VVX9uMHFAhI7KQC43ebqBdpn2
 o4QV2+DGqqZP7nTsV+M6OIvOe6MZIoNtTfzMPgq/fnijWUnll8bY6apxoEYaGujE/R9OUqZZ
 3Xsjs4fHmcMsQo+Terqh0OcXj5JZnayWa086isnB4KhCIfPXoatj6eZ0yehApJWfnxGCkyLE
 XrwaomIQ+0MZz6KIs99jjwEUqCsRJMm1R6yqAD6yqFqLvHU+y0drZLszsJ55+zVlREo9Dx7F
 d6R02+XTzI8omRdYjYs371k6WF5xE2C16cw19lRD99O/LVkVgkgNJjT5/N3AZb+V1SSUM2OT
 QOZRdGoGzg0Buk4xdBGN1lmEpa4gxbOxCOxK6QckbPOCZo786TR0mLwIck7wHHDgvpyx2I6S
 9dCYDX1zpV08BLeUsuQyx3xf8eCcK0d2HSI72Kf1S+Uu0oeVgdsUKLDVHRZZ03MrN2/6FmRB
 6S2B+EBNQ1MgdWHNrMMcsfg2EpdTbT5NdLTeGuqs3y5AxnNy7WDbYzndn8c2iqbA08BwEgI5
 XjTDQElHW+6pn7GSjlnFFbheUTppPZloTChQ0k51AiRR1Zo0bXw9xgahPqRRukS2L1CsyAk+
 H1vBFjo59vNEJKbohZ5OqVRZdRo+FBcyWfQrBBwJLSlJqFmwEwTbh8v5AXi2n2bE61mls4n5
 DMvxQt2c+eD1U9ZMimf1tb2M6HWLW/7+FaubbTX0xfQyoTe/KBH8/k+p1j52WPhXkM/73Vq1
 cVU2HqA993LCgQVS5f4Tkcw8VBzubjbZiA3446c22drNOG4tTrL2tRhA+VAqF7oYMxWc7mJE
 gLpGtYyHMGoJ6knnVeoaB8JJuFU++g/OMbnP/qK1ai3PfpxySq8hDcigsg12UaN+ixgD+/Qi
 s9Un7fBh1TBDWqgygz64aWV0cheaDofH3Sy033hDY9VPOhpeJoTTH2pKIuxz8l/gJjkXzhZ8
 kSiDhUIwpzMG1LaYlrj0AlXzUlSr2agnH7y0Cd90CskqKeE1Tfm2O3ke18KPGFKQmRvl1bqL
 s6/iNVQDy3KJ0A50QCo40r33f0Ru792bHPeR0pTdjPeNGhkXe69sLWDZcNC8pIuvmNcV+H2M
 jX4Avbt5hAd1S3kBW5Xwjs2IiqrtpvOlBt/kGuBLXx3oRI1YOlIzAzErJzZTP9VhH8dQTVgz
 CPQDR66NsWo+tOdk9HCtPq/XiSvTM8bfS7uxIKG/Cy1gA8iSQKklrOpl9vqCgEh+TTy0dYvW
 CPHrRDxb5Pq0av8OuViNkVlH17z7cNmF5o2y9pswshJhj5A28nTpiFPmHyWU50Twa/kaXsRW
 TMHi8XY5gTowgwrL36EwZ74SmTIx8JgY9egZWZFv0B1p8tOCaqS8PlFhX4s8wb+9FuOJ6Igw
 nFGkqhLijZSmewCtQszwz/IB7kTGRMdJinwj1GS6Nv4qqxLZWGpeLz21UxknNnnAqvRx2MUE
 Hv/ZJomGjd9q8tlN1eZmmLo48L+dd/ddtsIngadlRiFgu5aKZQ8m+ALgyUhMmX49y5AqaZzn
 Vl10Je2sZLSYXp29eGjDxhVLTTuT9ga/D6ogKBRn8Cb0pquGJonETIOFsiNL7rgAHcZsvLpM
 ByLGTs3pyKAGLbRKgSY7V9vs3PFF534f2HSPnQSys9uAQWMPEEKyh5BRy00x9Rqc2LijNyka
 kpy4Sodo0L1ugcZgPw9LAHxCy/atE+yZzs1UpWUME9h9RlMoVrZNMGS7+s1GSxEtPVNtSS1I
 3eAL0RNBGANAAmfAkz7e6Op7p/G+vSZAey3K73PZ6+PoKpQTaXAyZWq24pgtzGCU6fHdmFlF
 OE+01FfUGpRHs3Yn3MdRjEMz3mLY8PTqBqn+yJxp9yy67yyCV6pvNLQTeEPbZM0oFi/msLhf
 6aIiTx8KCpE259E3nLOxLUFnRYThyxoazixAOEAuCrKH+rbnq5aCQJeajsmbZoUqftlgU8XZ
 JKd0Yims9wwxuQ4AFpES1H7z8SgZMhQZnq4KEuCHkGAcrKPOTzMxcjzJ6K6U7xZyutO5HjS8
 X6WFVHuOjObmnznTReqZKtTlyjYJhFYtZq0aT52AG7sCd/gZRy9PdJtjDs5h7YzgzmZUAxUe
 Sg5aE5LorCKuGlAhe5jHmVa8nd/BeyNmiLf/eTFMc5N9/dmSHcR9aoS8DExzL1b6ztBTfp+l
 X7Jr9JglFqhl/GG1jttVBcd4iYOno+Aul9ufLnI7pQVE2iR5woDtC/DbnZC78sgENDkvLpcj
 8TChL6mYikX6MrapIMZF5rGJd+caCFnPRehTzfQCEFtpdGDLmjZiAlQlv6T8HCYtJk8pd7nn
 59cE9eztXQwH/IeTFZoAcdae9F7U2F9+VZ+pNUB43X7oR/eRcNXs4rGUP3UCvLqem7xsA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:6sn6yqqxx9uw/TfygdPjOuYaV5odeYIsimQD101hICG9vPb5qy
 mLpoV86faUskd3ZJhEo7u90ca7Lk80maQa3WBVB8baYOCEghrNEGgB1/qB/9SIIUSXnINgPO
 VbAs1D4bbLfDtHZKjBgTWQIpId7Z289L2wwd3T1W1sSwYCUc1d0zs=
X-Talos-CUID: 9a23:xOVZ/27bMNcVzORzI9ssq243J+54aiTk9HrZLlLkE2R0SoevVgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AybfCZQ12ol0YxX7M+XnIv1P31DUj+vy2JG83o5s?=
 =?us-ascii?q?6vczUbBRLYw6lkw6Na9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,191,1716242400"; 
   d="asc'?scan'208";a="174422712"
X-MGA-submission: =?us-ascii?q?MDHzOD7t7I2jlhEbdm4cX28HpK+6/9cWgkJOKS?=
 =?us-ascii?q?bRpBwGSvvxHDHdtuvsWH6hdxMXG0C5uzknJThVRAFnlkn0P57ysGIyU+?=
 =?us-ascii?q?Lg7YQCMoBxgc63r5ri3C7sR8ZkdMm1vi7j6tMo1mUGy7hW4JchthtAbP?=
 =?us-ascii?q?xsrxAlN92NDyMZrGk0bOUakg=3D=3D?=
Received: from zeus03.de (HELO mail.zeus03.de) ([194.117.254.33])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 11:57:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=RMPh
	UzYfHTmZIledNLDKy1NqKXAjpCjqSPt1j8ZkZ20=; b=VBNwE++brJj6WKJ+cMp4
	3H5L9wVbqxGJoa2kMjScwg1UtMwE61TaNA5YZxTL/n8YEqmXHxc0LH4dU01M3I2Y
	/LmPpKfNaGqiAvrJaAbI+dMYBw+HbmEDqYhQgH3Xlu0fC3/7pLdlUjtQFo274vjX
	KsoH/Ix1PfNlOe5FrBPqQy8wAU/OelFWj4eoAgZrdi8bzuYNYxtXu73HJ83IC2Vx
	O9HOmZ2MC+Lhn21VvK82SIDkiLzROSXpAa+piLRQJ0S9xV9OEVcqBTg/YatxX90M
	QwAp/9r8Fy3SawrPWmmjVB2qH3h30L/kXVdl3DF071ukPNaAFOoVZ69d3a6ELflg
	Fg==
Received: (qmail 245733 invoked from network); 8 Jul 2024 11:57:01 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Jul 2024 11:57:01 +0200
X-UD-Smtp-Session: l3s3148p1@1Y45b7kceswujnsa
Date: Mon, 8 Jul 2024 11:57:00 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
Message-ID: <Zou37OqG4xxBxKdm@shikoro>
References: <8d145e35-33af-4f81-a77a-2bbc5c734045@web.de>
 <ZoqY5GQlpKwZ3SEo@shikoro>
 <1d7aa71d-be7e-4750-b1cd-c1ee34e877c3@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IFNj5eEoC6rq7TeI"
Content-Disposition: inline
In-Reply-To: <1d7aa71d-be7e-4750-b1cd-c1ee34e877c3@web.de>
Subject: Re: [cocci] Deleting unwanted semicolons (with SmPL)?
Reply-To: Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Loop: cocci@inria.fr
X-Sequence: 1806
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/Zou37OqG4xxBxKdm%40shikoro>


--IFNj5eEoC6rq7TeI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > How should coccinelle transfer this incomplete function body to an AST?
>=20
> I hope that the support will grow also for advanced handling of abstract
> syntax trees and semantic graphs.

What approach would you suggest to create an AST from an incomplete
function?


--IFNj5eEoC6rq7TeI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmaLt+wACgkQFA3kzBSg
KbYH9w//b2bQduaqy9BUOzzRhxwtGELHo9mfyjMfe876UkBGUxdKNlfmx+DcbdzP
heP9n/YnBTwQnAtw92cgxt8imX6Ohgc5VwMSmlD9GrvTXJWDLFTh5eyIRZL+P8jk
6A1XDay0UaERqpWSxatidblppVf516T5Cs9F9Jo0jawkeGjQ6nnMvUSEK8UAujDp
Mst78PAdG2UFIs/UcJL20gbUbm10KmEq+/4tuD+f3ecfPIfgef5+lthcfzDH/V8x
i2zXRqkE86IdHCQohL/s4rep+/t4PY9YiVQyWxHmhn8JfDs4sjC09ARjQsSXxb6V
DHsl5KdSFcZHvhg5eLDg25Xwm3V/9IuxahR9d1XF3+71pmcKEuUy9upg/uiRmeq/
WRVEWZAF7r7gqI4hBTKZ2ST/XWHdyMwzCYJ8ulxRfzytBSJb1w+zwiyNPyW1sSok
E86EBgDVCWJR4TxffZag2MEl/VI1K2Ecn6DhlEJd+VP9MtGES5be1SDvMBVKx487
JIwf1/RUhgGGjxLZvY2VXNb5SUnmX9Ar//fqWmhu940Jqr19dllrhuQUHszzCeGW
BIRqy1cVXCSb0mT2eIOv2VJSFsuIhHiO2FgPFgCCM5LX1c81VR2xQaBKPhnoPyAG
yP2AXFomUeTW2HNIkmSALYA+yPKU8kGp7JoLg7etILTFSl+oQPI=
=StH+
-----END PGP SIGNATURE-----

--IFNj5eEoC6rq7TeI--
