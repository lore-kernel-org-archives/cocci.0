Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C3DD3ABD1
	for <cocci@archiver.kernel.org>; Mon, 11 Nov 2024 17:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=mBCCqAoqxGdq7HJPPdgxsMMqe+PLLKVlNDC4cHz7cCg=;
  b=OgLWA+dT39qZ9/ml9ykKSieEjnAJEYAJuC/lzEjrfy5NJHo9uvD7rRGP
   Drf1lPeAKSYaeqFCTj8AeSgtLqKI3YmS6jXlEfTlXCKnkjp+FRBiuBRhV
   rt4WMyjKSUtVNyBgCvo0MFXTdanO3fP7irzTwYC+HsGvRiG/IHX88zDUm
   Y=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.12,145,1728943200"; 
   d="asc'?scan'208";a="193201688"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Nov 2024 18:12:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 64428E0D1C; Mon, 11 Nov 2024 18:12:38 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C62E9E00B7
	for <cocci@sympa.inria.fr>; Mon, 11 Nov 2024 18:12:34 +0100 (CET)
IronPort-SDR: 67323b02_RJrr37U8cOFK46+HMHQUkuFHWLS+tSxq0ZZ7VAIHFvX3x44
 +M+CIguGCiYBSB55r8EuiQD2yYJ0wo0hf/CWI6w==
X-IPAS-Result: =?us-ascii?q?A0EzAAAtOjJnhY0kQ7laHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBgkOBVzMEC4UeiB1fiDBFEZ4EgX4IBwEDAQgFQgIEAQGFBwKKOwIeD?=
 =?us-ascii?q?AUrCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQFASYYIg?=
 =?us-ascii?q?mIBg38BAQEBAgEjVgULCxgqAgJWBoMUAYJBIwcBr196gTKBAd4zgV0QgUgBg?=
 =?us-ascii?q?VeEEoJXCwGBWokGJxuBSUSBFYMqPogeOoINIgSCQ3yEICWBFod/mFlSgRcDW?=
 =?us-ascii?q?TIBSwoTFwsHBThxIiwDglF/gTmBUQGCVUpKgzyBXgU3SYJKaU0QAwMDAwMYA?=
 =?us-ascii?q?g0CNoIPFV4fgk+FHYELg2SDToEZgXIxHUADC209NRQbBpsbCEqBHIdkAQqVa?=
 =?us-ascii?q?bMthCSBYwyDAJxQTROXOpMAmHejYYVCgWc6gVwzGi6DLU4DGQ+OOsk2Q3ACB?=
 =?us-ascii?q?wEKAQEDCYVpE4k7gUsBAQ?=
IronPort-PHdr: A9a23:lUqbQxcfTCcvgTMpap7KE2zIlGM+0tfLVj580XLHo4xHfqnrxZn+J
 kuXvawr0ASQG9yBoKMZw6qO6ua8AjRGuc7A+Fk5M7VyFDY9yv8q1zQ6B8CEDUCpZNXLVAcdW
 Pp4aVl+4nugOlJUEsutL3fbo3m18CJAUk6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uM
 Rm6twrcu8cLjYd4N6o91BTFr39Idu9LwW9kOU+fkwzz68q+4JJv6Thct+4k+8VdTaj0YqM0Q
 KBXAzghL207/srnuwXdQwCS/HUcSGIWkhRJAwjB8h73W4r6vzX5uORgxiSUJNX6Qr8oVzus6
 adrUwLohzwcNzEl6mHXi9d/g7xdrRm8uhFw2Y/UYIWSNPpjYqPQeM4RSGRdUspNUSFKH5ixZ
 JUTAeUfIelYrpH9p1oQohu4GQmsH/7kxjtRinPrwaE2z+EtHAfb1wIiAt0OqmzZotv1OqkMT
 +270arGzTvMYPxKxDjy6pPFch89rfyWR798bdbdxEspGgjYjluQs4vlPzaN2+oKsmiU8+pgW
 vyri2E5tgp/pSKgxt0wionOgIIa1E3P+CJ8wIY0OdK4SFB0Ydq6H5tVrS6aLZd2QsQkQ252o
 ys616YGtoChfCgR0pgn3Bnfa+Gdc4eU/B3jWuGRIS13hH17Yr6/gQi98VS5x+D6S8K730pEo
 DBfndnQqnACyQbT6s6fR/Zj40utxziC2hzd5OxZL004iLbXJoIgz7A+lJcfr1jOEjPrlUj4i
 KKbaFgp9Oeo5unlYrjoqZGROpFohwz+L6kjnNG0D+cgMgUWQmSW+uSx2Kfi8ED7WrlHgPw7n
 rPEvJ3VOMgXvrO1DgxV34o56huyDS2q3doZkHUdMV5IeRaKgo70MFzQJPD4EOy/g0iynzdx2
 v7GP7zgDYvVI3TflrrqYKxz5FRGyAUpyNBS/5JUBa8FIPL0QkLxsdvYDgIlMwCo3urrEs191
 oQFWWKTHKCZN7nevkKW6e43IumMYpEauCrlJvQ45PPjjWU1lF4fcKWz05YaaWq0EulpLkmEe
 Xbsh80OEWYOvgowVuzqj1iCXCZWZ3azQ6085i80CIa4AofGXI+tmqCB3CC9HpJIfW1GF0uMH
 mnyd4WfQfsMcyWSItJ7kjMYS7ehRYgh1QuhtADk0bZnKPTb+jEAuZLlz9d6//fTmg0q9TxoE
 8Sd1HmAQ3xskmMSWzA2xLx/oVB6ylqbzad4hOBXGsBS5/5SSQc7NZvcz/RgBNzoWwLBeM2JS
 Fe8Tdm8DzExVIF5/9hbRk9nGMi5xj3H0TCrBbBdw5mCHp8p6eTx23brJsBy42nL3u8tgg91b
 NFIMDiDh6V/+gzeT6vAiVmekaviIaEd1y7A8GqGxHCSu0dVeBNrXL/eG2sYe1HdoNr+/EzPC
 bmjFeJ0YUN61ceeJ/4SOZXShlJcSaKmYYyGC4rQs2K5BBLSg6iJcJKvYWIWmiPUFEkDlQkXu
 3eALwk3QCm78CrFFDI7M1Xpbgv39PVm7muhRxoxzgqKYkls0rOv5hkTiNSBUP4JxfQfvzo7o
 Dh6G0yy0pTQBsbT7xF5cvBnZt0hzl5G0SrCshBleJmpLqRsnFkbJgF2tEPj0xhyA59cls4nh
 G4xwRBpb7mfzUlKej2fx5/9fLvaNjq65wihPojR3FyWy9OK4uEP5fA//k3kpx2sH1E+/m9P1
 t5IzyPFoI3NFxYfVtT9Xy7b7jBcoLfXKmk47oLQjzh3NLWs9yXF0JQvDfckzRCpe5FeNrmFH
 Un8CZ9SAc/mM+Esl1WzC3BMdOlP6K45Od+nfPqayeaqOuhnhjevkWVA5sh0zEuN8yN2TuOA0
 YwCxrmU2Q6OVjG0i1nE0Ii/nIFPZTwWE2+20zTjAoN5e7Z/Z51NEmCzOca6yNJkiJOrXXNEt
 RaiC14AxM61aE+KdVWuuG8YnU8ToHGhhW6512ktw2xv8PXZh3KImri7J39lciZRSWJvjEnhO
 92xhtEeBg2zahQx0QGi7gD8zrRao6J2Ky/SR11Jdm74NTIHMOP4u7ycbspI8J5tvz9QVbH2Z
 FGRSrP5rh4TyT/kGWZ22Ss2bSrsoZLkhRd3hmWHI3s1qnfFM5IVp1+X9JnHSPhd0yBTDix5g
 jnaAlW5NsO1+tOZv4rYv/qlEXmmS4dYfCfs14yN8i22+Sc5ZH/31+D2kdrhHw8g1Cb93NQ/T
 iTEoiH3ZYzz3ri7O+ZqFqVxLGT75dZUE4B62ss1jZAUgz0Bg4mNuGAAmiH1OMla3qT3aDwMQ
 yQKypjb+lqt1EpmJ3OPouCxHnKTis5gbNm3Zm4T0zgh6MZHILqP4aZf2zByv0CzoAzWe/dw2
 DEQ1bMv8zYbheoNuQwgwm2BBfgUGlU9X2SkmxmT7t+4pblaLD//LP7uiwwlw5b4UOjKqxoUQ
 Hvjf5Y+ASJ8pt5yNl7ByjyWiMmsedXda84SqgzBlh7Bi+ZPL5di3vEOhCdhJSf8pSh8m7N90
 0Mohs/85dTeeAAPtOqjDxVVNyP4fZYW8zDp1+NFm9qOmpqoFdNnEykKW53hSbSpFigTvLLpL
 VXrcnV0p3GFFL7YBQLa5l1hqieFFpGgN3yTKXwQ18llQhS1OVdSmhtSRzInhJU0GAewy8Gnd
 kplrGN0hBawul5Xx+RkOgOqGGLerwelbjoxQYKDKxxbxhxZ6l3Od9eZ8/h4Ei9f5JKs6gqAN
 ibIAmYARXFMUUuCCVf5O7Co7tSV6OmUCN21KP7WaKmPo+hTBL+YgIii2Yx883OQJ92CazN8W
 uYj1BMJDhUbU4zJ3i8CQCsNm2fRYt6H8V2irzZvoJn38ey3Cli2u83WU+YUaoUppVigiKOHf
 YZ8nQ5fLjBVntMJzH7Mkv0E2UIKzjtpfH+rGKgBsijESOTRnLVWBlgVcXE7MswA9K860gRXX
 KyTwtroyr51iOI0AFZZRBTgnM+uf8kDP2C6MhvOGk+KML2MITCDzdvwZOuwTrhZjeMcsBPV2
 37TC0j4IjGKjCXkTTiqNvxQ1HjdJBtFpIy6NBpgSCDiQN/gdhynIYp3gDkxkthWzjvBMW8RN
 yQ5clsY9+3Nq30HxK4hXTUdtykAT6HMgSuS4ujGJ4xDtPJqBn4xjOdG+DEgzLAT6ihYRftzk
 S+Ur9h0oljgnPPcr1gvGBdItDtPg5qG+Et4PqCMvJxBUnbJ+B8I5H+MDBIHj8Z+B8f0/btX1
 8LEmaz0MjhPtdTZ4YFPYqqcYNLCK3cnPRfzTXTMCxAZSDewKWzFr0laje3KrzuNqYMmp5+ql
 JdEGdo5HBQlU/gdDEpiBtkLJpx6CyglnbCsh8kN/XOirRPVSa2yX7jCUe+OWaypMDGCkbRDI
 RcFk+uQxWs7K5b2wVckcV5nho/HFU3KUt0LpCB9PFRcSKBl7WNzVHZ1wEX4cAig7ngJGvPym
 BMq2FMWXA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ZVzJK6kxIUNdsJ3AG0wdkfnyTLTpDfIl3DAbv31ZSRFFG/FwWf
 rBoB0+726RtN9xYgBEpTnuAsS9qB/nmaKdpLNhWotKPzOW2ldATrsD0WKK+VSJcEfDH6xmpM
 RdmsNFaeEYY2IUsfrH
X-Talos-CUID: 9a23:AICAKWGgokVphvzHqmJixGgxPcsdW0HnklzzKUqRFntUR7K8HAo=
X-Talos-MUID: 9a23:GVpPaAYn83a44uBT7hC03zw4Fd1SyrXzKUUxscgdhsmJKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,145,1728943200"; 
   d="asc'?scan'208";a="193201686"
X-MGA-submission: =?us-ascii?q?MDE7ACu0FSJIklIIUdfjf6BCIJWujZweoCQdg6?=
 =?us-ascii?q?o4GlknhLK/8JJ9HJJ+1wNOwsLEwMkwQGSK8GtLB+qcBa5PwOFoPMGB/T?=
 =?us-ascii?q?lslNzPoQgs22rbe+qO5OasyKGT+kQJbZCtmBgsDY801n/3aZ9sB+TGTJ?=
 =?us-ascii?q?bu9Y4aEy9OWcfkuGGmUr2Sug=3D=3D?=
Received: from mout01.posteo.de ([185.67.36.141])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 18:12:34 +0100
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id E907A240027
	for <cocci@inria.fr>; Mon, 11 Nov 2024 18:12:33 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4XnGM52vL0z6tvr;
	Mon, 11 Nov 2024 18:12:33 +0100 (CET)
Date: Mon, 11 Nov 2024 17:12:32 +0000
From: Michele Martone <michelemartone@users.sourceforge.net>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
Message-ID: <20241111171232.GE10291@localhost>
References: <2406a49d-1609-4af1-9af9-ee3496e48606@web.de>
 <20241111162413.GD10291@localhost>
 <1ecbac88-9afe-42a4-bb46-de3abe59b500@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JwB53PgKC5A7+0Ej"
Content-Disposition: inline
In-Reply-To: <1ecbac88-9afe-42a4-bb46-de3abe59b500@web.de>
Subject: Re: [cocci] EBNF for Coccinelle file formats?
Reply-To: Michele Martone <michelemartone@users.sourceforge.net>
X-Loop: cocci@inria.fr
X-Sequence: 1989
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241111171232.GE10291%40localhost>


--JwB53PgKC5A7+0Ej
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20241111@18:01, Markus Elfring wrote:
> >> Will grammar descriptions become available as extended Backus=E2=80=93=
Naur
> >> form for involved input files?
> >
> > Such descriptions would have half a thousand of productions
> It is probably unclear how big a related grammar would become.
> > and still be incomplete,
If you
 grep '^[a-z_]*:'
through the *.mly files you get a few hundred non-terminals,
each with a handful of production rules.

In a few words: LOTS of rules.

> Can such a development concern be clarified better?
>=20
> >                          because missing token-level
> > manipulations, which escape that notation.
>=20
> Which details would you find problematic so far?
As I wrote:=20
 "because missing token-level manipulations, which escape
  that notation." ("that" referring to BNF forms)

> > Would that be desirable?
>=20
> Would you dare to look for alternatives besides tools like
> =E2=80=9Cocamlyacc=E2=80=9D and =E2=80=9CMenhir=E2=80=9D?
Not now: not enough resources for that.

--JwB53PgKC5A7+0Ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQQdu1Va6jWbiq8Ma4jg5mnI7xJYuAUCZzI6/QAKCRDg5mnI7xJY
uOjXAJ94qMK+XTjYwlKpTSWp716VZ250YQCfYhViYWJLhBaifOcne/ILFTdvH78=
=rdnG
-----END PGP SIGNATURE-----

--JwB53PgKC5A7+0Ej--
