Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39460F3C249
	for <cocci@archiver.kernel.org>; Mon,  9 Mar 2026 12:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=dJ/GWF6O+/mlhifNqx8J1OMnzzjoWsROziV6+8GGExY=;
  b=H8jPWevebKLCrGQZgnNGx1uufwoIifEskTs4xOIHdK0HZDtTBpgW1rvA
   R0p6KizU29y/9QEIyrSPl0OJmxbrG98Qnp2/hHMqXMJxw3eVvaBwhobqP
   VR/rttlTRaBPwkQnBJOQjYdCzIHi5IoVmSIODXZqR/8UmBNV85VjxwH3p
   k=;
X-CSE-ConnectionGUID: ry5kQhQGRTSH74yStubu9A==
X-CSE-MsgGUID: YsNNznstTG+kv9GfkvqAcA==
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
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="asc'?scan'208";a="266890441"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2026 13:55:23 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id A83BE830C2; Mon,  9 Mar 2026 13:55:23 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 04E3683083
	for <cocci@sympa.inria.fr>; Mon,  9 Mar 2026 13:16:27 +0100 (CET)
X-CSE-ConnectionGUID: 3OUYqnQ+Tfe4L0KvUMJOWQ==
X-CSE-MsgGUID: 9lLNgk13QDykco0O2KLyCQ==
IronPort-SDR: 69aeba1a_e2NGfSmkCm633v7jsGNZlS917L7VYnUURm4krg04bYg3rHH
 6pFIqI5dCKtd2V9wCmrwmzKHWbGNtLVeiB4SxPg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HCAQCIuK5phR/86qxaglmCQYEHXzMEC0mEWINPhSyGW?=
 =?us-ascii?q?IIkhXqFeoZbHIsvFIFpAggHAQMBCAU3GgQBAQMBA4UAAo0hAh4HAQQxCA4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAQFASYZPDYJiA?=
 =?us-ascii?q?TNxgSUBAQEBAQEBAQEBAQEBHQINfQEBAQECASMdAQE3AQ8LGCoCAhBGBoMVA?=
 =?us-ascii?q?YIiByMnA6xMeoEygQGCDAEBBoEI2yKBXgkDBhWBOIFYhnAMAYFdhFuCU2l6J?=
 =?us-ascii?q?xt9gRCEBzg+hCmDdYJpgiaBDokMig9SgRQDWSwBSwo1DDMrRUMDgSlLBTdlE?=
 =?us-ascii?q?j8hHQ8cHzkCOAcFEiERGYFKeIIBD4ZqeQMjC14aDiICOlxKPmUFgiQDeD03F?=
 =?us-ascii?q?BsEjFEQIQ2CDj6DboFFTpNYs0OEJqI4g3GNE4Y7kxkumFikIoUfgWoCNoFcM?=
 =?us-ascii?q?xoIKAiDIk8DGQ+OOoRihBjDZ0I1PAIHAQoBAQMJkh6BSwEB?=
IronPort-PHdr: A9a23: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
 EZetw==
IronPort-Data: A9a23:vT11kK/O9dFocV1zWwMbDrUDAHqTJUtcMsCJ2f8bNWPdYAuX7wSz/
 BJcAD7Ya7vPIDfrKpolWDmFhUoGvJeEz94xTAtqpH0wF38XpJKdX93DdxyrZS7JdsPNRh075
 JoXM4iYcM5lQCWM/UbxOOProCYsi6uEGeShBLCs1kydPeNBYH5JZUVLy7Vi6mIRveWEPu+th
 T/Ti8eCZlSsgTcrbztKs/nc8Exm5q+stmJJswZvaatGsVTTvnREV5h3yYOZfyKpGNEMdgKZb
 7+el+/hpjuxEzMFUI7NfmPTKxVSKlLqFVHTzCcQAu7630UqShUais4TLOAbZVpclwKHltVwz
 MQlnZGrQG/FBIWV8Agme0ceSXoW0ZFuouedfyDk6Z3LliUqTlO1qxlQJBFuVWEn0r0vaY1+3
 aRwACwAaBmFm9W3zNqTIsFwht4uJdXcJ4gWvHdt11nxVZ7KlrieK0lizYYwMAYY3qiiL96GD
 yYqQWYHgCD7XvF6Egx/5KTSMwufriKXnzVw8Dp5rEesioTZ5FQZPLPFaLI5djEWLCn8c4nxS
 m/upgzE7h8m2NO3kh24w2uqv6zzky6nfNoxCoCd1NlVuQjGroATIEV+uVqTuvSwzFW5RshUJ
 goX9zAooKx081akJjX/d0Tn+jje5UJaAYcKVbZjgO2O4vK8DwKxD2wUZj1MctorsIkxXzNCO
 lqhxo+xWm0+6ePFIZ6b3uaQiRW9OnFOFEMTZiQDFSxfwP3yi7hm23ojSf44TPHp34yucd3q+
 BiBqyM1hp0InMsT3uO6+0rGinSivPDhSgcq7wHTdnCk6wljbcikYZap4B7V9559wJ2xVVSI+
 mMDhtKV4aYNAIuLmSjLR/8CdF202xqbGGb7vG92GaBiyzqgp1r7Xp5txRNZG348Z67oZgTVj
 FnvVRS9DaK/0VOxYKYxeIWsEc8ni6vtD9LoUrbTdNUmjnlNmO2vo38Gia24hTqFfK0QfUcXZ
 cbznSGEUC5yNEif5GDqL9rxKJdyrszE+Y8seXwL50/7jubPNSX9pUYtOViHa+k4pL+JqwXT9
 NJYOMqH0F1eVua4ChTqHXooBQlSdxATXMmmw+QJLbTrClQ9Rwkc5wr5muhJl3pNxP8Nzr+gE
 7DUchMw9WcTclWeeFnSMy06OOKHsFQWhStTABHA9G2AgxALCbtDJo9EH3fuVeh4rL5Q3rRvQ
 uMbes6NJP1KR36Vs34edJTx5sgqPhiimQvEbWLvbSkdbqxQYVXD2ublWQ/zqwgILC687vUlr
 5Oaiwj0fJskRiZZNvjwVs6B9V2LgCUiqLpAZHeQeth3U2fwwbduMB3036MWIdlTCBDtxQm69
 gexADUCl9nvvr0K78TD3oKCjoa2EtlRGlhRMHnb4I2Xawjb3DuH6q1RXNmYeQvyUDvPx5yjQ
 uFO3tfAMPEjt3RbgbpWSrpE4/o32IrymuV80A9hIkTuU32qLbFRel+9wshFs/x29I9z4AeZd
 BqGxYhHBO+vJsjgLV82ITglZMSl0dU/uGHbzdYxEXXAyB5Hxpi1emQMAEDUkw1YFqV/D609y
 +R4uMI21R22uiB3Dvm41BJr50a+BV1edZ44t6MqIp7h0Ssq7VBgXabyKAHL5LO3VtEdFXVyf
 xG1gvLZiqV+13jyVSM5NULw0Np3gbUMvxF3z2E+GWmZp+qdhtEL8U1Q1R8VUjVqyg521rMvG
 2pzaGxwC6a83xZpo8lhTVKTNhxKXkzA8UnXz38MiGnSShSsXEeQMmY4Muep12Ia+lJ6YTJ00
 uy5ymHkcDCyZ+D3/HI4dnBEoszZb+5a11P9iuH+OOrdBLg8Qz7uopH2VFoysxG9XP8A3hzWl
 9dl7MNbSPPdNxdJh4YZFoPD97AbaC7cFVx4Wfs7oZ84RzDNSgqThwqLBVu6IP5WBvrw9kS9N
 cxiC+RPWzm61weMtjorPrENEZAlgM8W4Mc+RZ2zKV4kq7e/qh9bgKDU/AX6h04pRIxKuuQ5I
 YXzaTmDMzKxgV15pmzzl/RHa1GIOYQ8WA7B3e6O4LooEbAHu7pSak0c6Oa/kEiUFwpFxCiqm
 j3/SZXY9MFY8rQ0rbDQSv1CIy6WNeLMUP+59VHvktZWMvLKH8T8lyIUjVjFJTZmH6YjZMtqn
 ++vtv/2w0L3k7IkWE/Jm5S6Nvdo5OfjeMF1I87IPH1hsi/aY/DV4jwH4HGeFZxFtPh/9/uXb
 VK0R+XofOFERuoH4mNebhZvNio0CoP1X//Gnjy8pfHdMSot+1XLA/3//EC4cFwBUDEDPqD/L
 QrGu/yOwNR8h6YUDT8mA8BWObNJEGXBa4AHKeKo7SK5C1O2iGysorHhzBosyQ/aA0m+TfrV3
 8j3eQjcRj+T5ofz09Brg65jtEY2DVF8o9UKUGAzxtpUsw2+XUk6dbkzEJNfBp9tx3m4kNmyY
 TzWd2ItBBnsRTkOI122/N3nWRzZHeAUfMvwIjsy5U6PdiOqH8W6DaB88jt7qWJDEtc5IDpL9
 flFkpExAvSw/n2tbf0e77qghvp9zf6cxX8S/0351cvoDH7yxFnMOGNJRGJwue7vSqkhV3kn4
 UA2SHpCTUX9TlT+eSqlU2AAAwkX5VsD0B1xBRpiA7/jV0Gzz+BazvD7febp3dXvqSjMyKEmH
 RvKeodG34xaNrH/d0fkVxLFTJKY0c62I/U=
IronPort-HdrOrdr: A9a23:pJk6W68Mi5hZmxYhy2Ruk+DXI+orL9Y04lQ7vn2ZhyY1TiW9rb
 HIoB17726RtN91YhwdcL+7VJVoLUmyyXcx2/h2AV7AZniChILLFvAA0WKK+VSJcEfDH6xmpM
 VdmsNFaOEYY2IVsfrH
X-Talos-CUID: 9a23:mLu2v2+tfYGyw8ApW8CVvxUzJ/E8dESe8Hndf2vgKnhUbZ+ydmbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A7M5tDQ+NneMuh8frF1OymD2Qf5Zsx4KhCxlWqLk?=
 =?us-ascii?q?XuMKDbQsqGBOMpw3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="asc'?scan'208";a="140799168"
X-MGA-submission: =?us-ascii?q?MDHdmvb4hoiivmTysW296ZT+y2PRJ6K/SPx3Q3?=
 =?us-ascii?q?FveJNIfBMx19EEJvYSZectNBHBWRoztELJxWR7vpq0IwbG8Hul47ITwd?=
 =?us-ascii?q?UJQlsVOmqqJmU77/v4X8uUQRcmMfyRnie2ndmntpUO276sA0+fIIkN6E?=
 =?us-ascii?q?V46qsCrZtT1VrXE2GMmGZUiA=3D=3D?=
Received: from sea.source.kernel.org ([172.234.252.31])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 13:16:25 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 02A3D4416B;
	Mon,  9 Mar 2026 12:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EFBC4AF09;
	Mon,  9 Mar 2026 12:16:22 +0000 (UTC)
Date: Mon, 9 Mar 2026 13:16:19 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr, 
	Nicolas Palix <nicolas.palix@imag.fr>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org, Kees Cook <kees@kernel.org>
Message-ID: <aa65s_alHWW3woUb@devuan>
References: <cover.1772752564.git.alx@kernel.org>
 <f1c9dff525752dc5a839760269a1c96d6e0870b4.1772752564.git.alx@kernel.org>
 <cab3d2a8-4c3f-45e6-9e7f-8bdca48a6209@web.de>
 <4aa2fc38-3c32-75a1-161-1c90709252be@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kqlfy2xevpf6bsix"
Content-Disposition: inline
In-Reply-To: <4aa2fc38-3c32-75a1-161-1c90709252be@inria.fr>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH] scripts/coccinelle: Add script for using
 ARRAY_END()
Reply-To: Alejandro Colomar <alx@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3358
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/vNx-Mut5D5c8L-NbI9COuQ>


--kqlfy2xevpf6bsix
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr, 
	Nicolas Palix <nicolas.palix@imag.fr>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [cocci] [PATCH] scripts/coccinelle: Add script for using
 ARRAY_END()
Message-ID: <aa65s_alHWW3woUb@devuan>
References: <cover.1772752564.git.alx@kernel.org>
 <f1c9dff525752dc5a839760269a1c96d6e0870b4.1772752564.git.alx@kernel.org>
 <cab3d2a8-4c3f-45e6-9e7f-8bdca48a6209@web.de>
 <4aa2fc38-3c32-75a1-161-1c90709252be@inria.fr>
MIME-Version: 1.0
In-Reply-To: <4aa2fc38-3c32-75a1-161-1c90709252be@inria.fr>

Hi Julia,

On 2026-03-09T12:59:48+0100, Julia Lawall wrote:
> > > +
> > > +//----------------------------------------------------------
> > > +//  For context mode
> > > +//----------------------------------------------------------
> > > +
> >
> > Please omit such extra comment lines.
>=20
> No problem to put such comments.

Okay; thanks!  Although I tend to prefer without them, so I've removed
them.  Also, a majority of existing scripts don't have them.

> > > +@depends on i&&context@
> > > +type T;
> > > +T[] a;
> > > +expression b;
> > > +@@
> > > +(
> > > +* (a + ARRAY_SIZE(a))
> > > +|
> > > +* (&a[0] + ARRAY_SIZE(a))
> > > +|
> > > +* (&a[ARRAY_SIZE(a)])
> > > +|
> > > +* (&a[ARRAY_SIZE(a) - b])
> > > +)
> >
> > Extra space characters may be omitted directly after SmPL asterisks.
>=20
> No concern about the spaces either.

Okay; I've kept them, as the majority has them.

> > =E2=80=A6
> > > +@r depends on (org || report)@
> >
> > You may omit parentheses here.
> >
> >
> > =E2=80=A6
> > > +@script:python depends on report@
> > > +p << r.p;
> > > +@@
> > > +
> > > +msg=3D"WARNING: Use ARRAY_END"
> > > +coccilib.report.print_report(p[0], msg)
> >
> > Would the following command variant be a bit nicer?
> >
> > coccilib.report.print_report(p[0], "WARNING: opportunity for ARRAY_END(=
)")
>=20
> Either way.

I've taken the suggestion.  Thanks for the review!


Have a lovely day!
Alex

>=20
> julia


--=20
<https://www.alejandro-colomar.es>

--kqlfy2xevpf6bsix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmmuuhMACgkQ64mZXMKQ
wqlD7Q/+MC8nUpjlK/p9rr3OlX/h0Gt6qYb3vFL+1+Y7660U0CQL2Vm6fbrGNXci
P8etesjkt76rIR95FJTNxXhAXMeESb6GBm06BCg++RRDACo45PbueJuv7tqlgccS
1dKN7qEvwrEiNbZpGD4vNMaNoXk0MFmjU5weHHmqjNm1MmM/CqLnsiM7nQdFoHkn
cxqiG7VQSNKPWZ0/p4eGPphqPDQWSsMW4SRdF1FqwCCbgnyTZIMbLHZ9SqP261v1
nkcnkQU/ZNJqNUTwunB916S8dI5PsOBYRs8rl07iFXJPOCApnL/uC8Px+UI5WZIv
5dZt9YdZag5sUx7Ln91UjwKINUrjneAOTuAPPuUAf4HZuJmIPKL2vKvS44rdEtsO
idSu0Bly2q3cpcDcNS3ou9J1+zdJsSu3PoFfLesXX28uCYdF6oT9s8m1XxvQM5zi
aSoKoG8ZD2O5YGA45xXJ0ZUsxQIq6HC+myPcVPtLWVHIHo/yBnk7b6TmCn6HgMQQ
TSDgxF3YVCqS3xOPoz6LRdTBBPFxz9VF3lV8XKSpMaMnVJgVRoyHmxcJurIOzui+
9Z8UxtTUfNFOVW4y8b7lyqYFU2bfVLQUbFJ7dHk/at8FZvmFEcnbR4WhWxKXPQ5r
LYGj+lCzmOtl912j6MjLeJNv/8sNRWNXYxFpVjNqs2ha7o91Y+Q=
=Fthy
-----END PGP SIGNATURE-----

--kqlfy2xevpf6bsix--
