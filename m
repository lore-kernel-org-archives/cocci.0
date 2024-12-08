Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3A1E77173
	for <cocci@archiver.kernel.org>; Sun,  8 Dec 2024 06:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=nHfGtNEel9Ft3Re7WmOP/2cQUdd7ndyZqAJhHrrWi7A=;
  b=JecagoFDbh7BOqwn5EC9to9Qxl9X5e57+s6yuelkvPpBB+H0jMLTSjJ4
   gSM3wZcQPkLePsFPLpwDz1SbracxEyro1pP6g+W5Y7bgNppCyd3NmveYa
   GyICa/I7u9CVdCRlGZymUbieqgB9MzRWaXbSouQ+Oguj9LJS7yddQAbM7
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@broadcom.com
X-IronPort-AV: E=Sophos;i="6.12,216,1728943200"; 
   d="p7s'346?scan'346,208,346";a="197918713"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Dec 2024 07:02:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 205B0E0D1C; Sun,  8 Dec 2024 07:02:07 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8DAAAE00B6
	for <cocci@sympa.inria.fr>; Sun,  8 Dec 2024 07:02:01 +0100 (CET)
IronPort-SDR: 67553658_gVfKFZaoyfR8rusyfbIMySCThqd4lRdSG6oisv/5/uAFwLo
 92FP24AEUX831kSps8xNGm3H/nagkj1SnO+TNbw==
X-IPAS-Result: =?us-ascii?q?A0E+AADsNFVndKrbVdFaHAEBAQEBAQcBARIBAQQEAQGCA?=
 =?us-ascii?q?QUBAQsBghsofS4rNAQLSAMBhFKBI44qgiEDnhgUgSw+CAcBAwEIBT0HBAEBA?=
 =?us-ascii?q?wSFAAKKaQIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABIyAOEimFew2CYgGBJFFVAQEBAQEBAQEBAQEBAQEBAQEBFwIIB1wBAR4BA?=
 =?us-ascii?q?QEDEhEdAQE3AQ8LCw0qAgICHxIBBQEcBhMIGoJggjADIBEDEaJMgQVCiz6BM?=
 =?us-ascii?q?oEBggwBAQbbJiJXgV0HCRSBNAGBV4QTgmMBgVoSgwyBN4M5eicPgVVEgUqBc?=
 =?us-ascii?q?4ECPoIsNQWBKAESAYN8gmmCQIMng0qHMhKDKIQOhSOHViYmAwcHDg0eSQ8hA?=
 =?us-ascii?q?1kyAVUTFwsHBYEpISwBAgGBHYILgVsFN0eCSmlLNwINAjaCJH2CTYUXgQuBF?=
 =?us-ascii?q?YJJSoQOhiWCGhUdQAMLYgs9NxQbTJc3CB+BDoJtAUaCZmsGAYEOAUtbSoEyo?=
 =?us-ascii?q?mmCIKBNNAeEHYFdBgyEbYMwgguVRzOFW6R2mHuOApsXESOBSwgrbHAzGiNQM?=
 =?us-ascii?q?QaCMAlGAxkPjiEMFoEMAQ2CPr9PKDICAQEKLgIHAQoBAQMJkFSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:+hIZjaxnR5S9h6L5HZUxKrPw+71zdoMgy1knxilNoNJuA7elfq
 GV7Y4mPHrP4gr5N0tQ/uxoVJPwJU80sKQFhLX5Xo3SPzUO2lHYSr2KhLGKq1bd8m/Fh4xgPM
 xbAtFD4bPLfCBHpPe/zw+iDd46zdWLtIyuj/zP1mpgQGhRB51I3kNWDkK0HCRNKjWuxqBXKH
 Nf3Kd6TvabGEj/p/7aOkU4
X-Talos-CUID: 9a23:AVlbb2P1NP7O4O5DZC5qqGRLOZwcWHyD7XbCL3GJA0xnV+jA
X-Talos-MUID: 9a23:TjF7+gaZUECxtOBTpw3ytAw/NMhRxPqyBX8dqZgfuOKqOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,216,1728943200"; 
   d="p7s'346?scan'346,208,346";a="103721408"
X-MGA-submission: =?us-ascii?q?MDGMsgFKpLTTo2kGQpmmd6W9IzywA0sSoL4YHj?=
 =?us-ascii?q?QcqNuJwyQdzfY3f0VmYBqzXG8WPA4fBszYybBR9o7v4axr+qYJ5d6UkP?=
 =?us-ascii?q?xeHvaiKi+eIQ3ou+QLous2F10lKggsWavKezJnTh7SSomxig0qZcnoZU?=
 =?us-ascii?q?3izrA5uD31iPuqLoEhqqjM+g=3D=3D?=
Received: from mail-yb1-f170.google.com ([209.85.219.170])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 07:02:00 +0100
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e3a0acba5feso1459132276.2
        for <cocci@inria.fr>; Sat, 07 Dec 2024 22:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733637718; x=1734242518; darn=inria.fr;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nHfGtNEel9Ft3Re7WmOP/2cQUdd7ndyZqAJhHrrWi7A=;
        b=b8nKT3gVXOeToYG4vFePpK/k/zBTiCGJQRO7Wv1noZNVh8K5ZdH8/fjeMDsKmi3pHN
         mPJIToyCgHLJthxuT9AI4+0wYIYvZugXKA3mpObj07JeM2xVOcDVePnFO6SVqXe/cxFo
         sguSpfbSzj1IHWe+N+vSBXw74P1tJEQtZf15o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733637718; x=1734242518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHfGtNEel9Ft3Re7WmOP/2cQUdd7ndyZqAJhHrrWi7A=;
        b=U1HgYKcbkMDQKsHEkB6trFJws72KnTxgJ/YPP3hGN4Jm3YZQt8OPdBthqc1go4FUgt
         OHZMR5UAvTZIFP0Tca9EkmYRImUnHPorURD9Nrcfg3JEkcmG+6G6q4xSe2tkN8nV8DWd
         p+bFR8YoXbGpYWAThN+8WclgesEI53Ykkt+rieXMN+fiRSyfAM2d4UdWCo1ByuNPhxHJ
         /yOKtK5LGrNIUgIweRHUUwafJ/ZVuHx2E7Bg5zXt/5G4wzg6v9mriDTaDNWlK/rfuI1W
         1qRTZUw5UZAFm2eH7EfkL4DerozWBJoiLNPwfyWuCv6tHu/od4IZzX2eKB+uvdBBG3Zv
         9cJg==
X-Forwarded-Encrypted: i=1; AJvYcCWA/2G/p0TL3OBHFXGxfN+6F5/2WiZjewGjEjfIq4t/T5Nr3aLd2lL3+KJYDbi9TXB+mg42SA==@inria.fr
X-Gm-Message-State: AOJu0YybxtIS8BazO6t6vP9z36luPaMMNlT02IxVJAS64BorsCYZsDJK
	0VXhD8WC0VYz3fb19Dh2Mc8PoJS3MtADPBW7pubQoYYILqU6yR6+hMihVaI6BnmFC36eylCBIit
	Vb0HM1XYllSQeM0wyWHqBNCQ6R1cnNJmNil/b
X-Gm-Gg: ASbGnctumIMGBlNIcrjTZZQaaeJJB+3L8tP9awFfKhTEIkRzTF+GUOHDXOUC127idB4
	+FR7rA2qlH75WsT11UG2lzEHcV+KccqIR
X-Google-Smtp-Source: AGHT+IGB9v3zsD5WPPRgfeYNCxmx9rAjv7gFwU2XW6vU2kkxvhJdi5oaEGCu3Fz9zkij4SM7wmJah24dihatf+A3i+I=
X-Received: by 2002:a05:6902:110c:b0:e30:d89f:1342 with SMTP id
 3f1490d57ef6-e3a0b134d8bmr7207920276.24.1733637717986; Sat, 07 Dec 2024
 22:01:57 -0800 (PST)
MIME-Version: 1.0
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
 <6b81d431-36e9-7a7a-687b-2d7fc7aa6c31@inria.fr> <CABQX2QP0Vk5UZPDFDXThvzuw-gkam-4wU_xq3rbSmwi9x7cBHw@mail.gmail.com>
 <dff4cbd9-00c1-47a9-b2f7-fb2e98d04433@web.de> <CABQX2QPZB9uHMxKKoZA6f=+4f0ifHfft-rHcqd-Ck9rjo7-ShQ@mail.gmail.com>
 <1995b696-6825-a144-fcb-c5f9f3b1094@inria.fr>
In-Reply-To: <1995b696-6825-a144-fcb-c5f9f3b1094@inria.fr>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Sun, 8 Dec 2024 01:01:47 -0500
Message-ID: <CABQX2QOb9C4G3Kejo_ght3Dgo0qxHW5A6it4GB6TdgoU0Bo7sQ@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005fedea0628bbfc6e"
Subject: Re: [cocci] Replacing type names
Reply-To: Zack Rusin <zack.rusin@broadcom.com>
X-Loop: cocci@inria.fr
X-Sequence: 2163
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/CABQX2QOb9C4G3Kejo_ght3Dgo0qxHW5A6it4GB6TdgoU0Bo7sQ%40mail.gmail.com>

--0000000000005fedea0628bbfc6e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 3:52=E2=80=AFAM Julia Lawall <julia.lawall@inria.fr>=
 wrote:
> On Wed, 4 Dec 2024, Zack Rusin wrote:
> > On Wed, Dec 4, 2024 at 2:56=E2=80=AFAM Markus Elfring <Markus.Elfring@w=
eb.de> wrote:
> > >
> > > > From the sample_case.c I linked before the two constructs I'm havin=
g a
> > > > hard time matching are function names in definitions and type names=
 in
> > > > parameter list, i.e. in
> > > > static bool SomeDeviceLocalCompare(SomeDevice *localDevice)
> > > > neither SomeDeviceLocalCompare or SomeDevice seem to matched via id=
expression.
> > >
> > > * Did you find scripted SmPL constraints more attractive somehow
> > >   than script rules?
> > >
> > > * How do you think about to choose more appropriate context informati=
on
> > >   and corresponding metavariable types?
> >
> > Sorry, I'm not sure what you're asking. Nothing has changed since my
> > first email. Coccinelle is a wonderful tool, but currently it doesn't
> > work for this use case. The type replacement is matching multiple
> > times and to my knowledge there doesn't seem to be a way to convert
> > arbitrary function and parameter type names. This is an all or nothing
> > type of problem - either all of it can be replaced or a regex script
> > has to be used (clang-tidy with readability extensions also misses a
> > bunch of constructs) to convert from camelCase to snake_case. So
> > afaict there's no way to solve this problem without using some regex
> > replacement script.
>
> Sorry I haven't been following along with this.  Could you remind me what
> part doesn't work?  Just because something isn't matched using
> idexpression doesn't mean that it desn't work.  For the function name
> just match the function definition, declare an identifier metavariable,
> and change the name.  I guess that there is currently nothing like idtype=
,
> but you could have a type metavariable with a regexp that prevents the
> match from containing spaces.  Or perhaps it would be better to just use
> script code to reparse the type, to address cases with * [] etc.  This is
> a bit more clunky than one would hope for, but it seems like it would be
> safer than a regexp.
>
> On the other hand, we don't propose anything to do updates in comments.

No worries, like I said, it's not a big issue. I don't quite
understand what you mean by "match the function definition". I need to
match basically every non-keyword in a c file, because everything
needs to be renamed: types (i.e. struct names and typedefs), variables
(global, local, static, const...), struct members, function names
(both in the definition and declaration) plus all parameters (types
and variable names) in signatures of those files. Every one of them
needs to be renamed.

With:
@types@
type t;
position p : script:python(t) { needs_rename(t) };
@@

t@p

@script:python adjustment@
input << types.t;
p << types.p;
updated;
@@
coccinelle.updated =3D cocci.make_type(camel_to_snake(input))
@replacement depends on types@
type adjustment.updated, types.t;
position types.p;
@@

-t@p
+updated

structs are replaced three times, which is the first issue. Then:

@vars@
idexpression func;
fresh identifier func_name =3D script:python(func) { camel_to_snake(func) }=
;
position p : script:python(func) { needs_rename(func) };
@@

-func@p
+func_name

doesn't match the function name in definition/declaration or the names
of parameters in signatures. And even if it did I'm unclear how would
I go about replacing it (i.e. I'm assuming this is where the
metavariable would come in because there's no cocci.make_parameter so
I'd probably have to use cocci.make_expr or such and then somehow
replace the parameter list with a metavariable that's really an
expression?)

z

--0000000000005fedea0628bbfc6e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJkMIICYAIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFIA
dRYa6XixfJLks9XK8p6LhHRBa401q093utLtslOuMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI0MTIwODA2MDE1OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJ
KoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA8KKcqD0kBJDj2VBu1uh4/
353J/sIP/FqpF9L5Vjzfz3fB9Nicjpy9CXbg3CHRiALOdErFCBPI+Ncz/XitIvQXHCNrqfyE0h3j
OHWmBRqXdN6rrDp8eBbqo+7HO63MsrhUUpEZR/sHobSZS8a7j8Brili6omjYBwPVo7Ifg7SIuQLS
ctGL0WKNLxXLBJl10knBHebXt+JwfDlARk9ycJqhqEF8dc2hVVaUl8NRjQh0eQcrIptU0RxB5Bs+
jWLTiYfd+Eb+YoRqq6E0sAdtVj+OsgejplJ1Zy3eMbQEaXCBppxiQywDwk8BX3CNKmemxEm3tLjV
XwM1Y2f0HCQWC9v+
--0000000000005fedea0628bbfc6e--
