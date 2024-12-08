Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90522E77173
	for <cocci@archiver.kernel.org>; Sun,  8 Dec 2024 19:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ARaxTKQ4EUM4eubwfl7TGFPpHDREYZwBZ/7BI9KbG60=;
  b=awtte3XzlD62IZ4qPnQVbCd8MGsAkkqTjWrND7lbypRZ6bK+Yo5Tb/+J
   2/WtWgkiL9eo2votlL8FM/2i29q9HLijoCk/zSKsXR5jMOTOTvA5KDRRT
   oV/PQyt+bvVoITroPglKcR6TBYqe2H6O+BLqYy9tm7Czi4eqmm/w24Np/
   o=;
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
X-IronPort-AV: E=Sophos;i="6.12,217,1728943200"; 
   d="p7s'346?scan'346,208,346";a="197982459"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Dec 2024 20:11:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 04ADBE0D1D; Sun,  8 Dec 2024 20:11:41 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 099EBE00B6
	for <cocci@sympa.inria.fr>; Sun,  8 Dec 2024 20:11:38 +0100 (CET)
IronPort-SDR: 6755ef6a_wIQlThI8lRnEstbucd6N6F5RG9ck4e9JksbjuNZ4nD1b6ks
 rr9tGJKmlbyDGC00z6q72kld+Tq37Pifx2+FqbA==
X-IPAS-Result: =?us-ascii?q?A0EFAABp7lVngauAVdFaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBggEDAQEBAQsBgkN9Lis0BAtIAwGEUoEjjiqBfwUdA54YgUAWK?=
 =?us-ascii?q?AgHAQMBCAU9BwQBAQMEhQACimkCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEQA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQEiGQcOO4V7DYJiAYEkUVUBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEXAggFAlwBAR4BAQEDEhEdAQE3AQ8LCw0qAgICHxIBBQEcBhMIGoJgg?=
 =?us-ascii?q?lMRAxGiIYEFQos+gTKBAYIMAQEGUttNgV0HCRSBNAGBV4QTgmMBgVoSgwyBN?=
 =?us-ascii?q?4M5eicPgVVEgUqCdT6CLDUCA4U4gmmCQYMYg0mHMhKDKYQQhRqHdSYDBwcOD?=
 =?us-ascii?q?R5JDyEDWTIBVRMXCwcFgSohLAECAYEXggWBWwU3R4JJaUs3Ag0CNoIkfIJNh?=
 =?us-ascii?q?ReBC4EVgklKhBCGJoIZFR1AAwtiCz03FBtMly4IH4ENgm4BRoNSHRcQPgkKA?=
 =?us-ascii?q?QohID1wlAdJj0OCIIE0nxk0B4QdgV0GDIRtgzCCC5VHM4VbpHaYe44ClyyDa?=
 =?us-ascii?q?xEjgUoBM4FcMxojUDEGgjAJRgMZD44hDBaDWL8tKDICAQEHAy4CBwEKAQEDC?=
 =?us-ascii?q?ZBIgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 tsqZ2Nfdr0pGjf/IJK3BfycrSt5l9ho2g==
IronPort-HdrOrdr: A9a23:rcrSd6NGCS2I9MBcThajsMiBIKoaSvp037Dk7TELdfU1SL3jqy
 nKpp4mPHDP+VEssR0b6LS90ey7MBbhHP1OkOos1NWZLW/bUQKTRekI0WKh+UyDJ8SUzJ8l6U
 4PSdkHNPTASXd9ltjz+wS1HpINx9Od4Lm0ieq29RtQZDAvRaUlwQkRMGim+45NKzWux6BVKH
 NR3Kt6TvObGUgqUg==
X-Talos-CUID: 9a23:DTHsqGzMj4XAD4BFbuhGBgUVBpgmKl+A/k70HEqlAFhAEo/KGWG5rfY=
X-Talos-MUID: 9a23:1CDwSQSWJC6cYY74RXTCqAlzJeFszZizLwcUkcpbifmAcnZZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,217,1728943200"; 
   d="p7s'346?scan'346,208,346";a="103744697"
X-MGA-submission: =?us-ascii?q?MDE7Hvkzu8ktu3oS21XEqR1LBdNNt7W1riUlGM?=
 =?us-ascii?q?keLYMGyeO6JSduhEyIeOhs8OfFLiCrw8GrGmAVYlQ8mZ2rnQRVi+yn5R?=
 =?us-ascii?q?7W6EJT/S/zc4o2GZQ/iughKQOLdrNwHZ9THEI09sEgCz966Gb/kkEMeh?=
 =?us-ascii?q?1TXrDMDhrSO/spJTCFmJsNkw=3D=3D?=
Received: from mail-yw1-f171.google.com ([209.85.128.171])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:11:38 +0100
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ef66a7ac14so40994217b3.0
        for <cocci@inria.fr>; Sun, 08 Dec 2024 11:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733685096; x=1734289896; darn=inria.fr;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ARaxTKQ4EUM4eubwfl7TGFPpHDREYZwBZ/7BI9KbG60=;
        b=P1mrg6JlkHXQlemz+7ypkBByoqv+DxMx2RZl0ggkbG3ZlHXsUo8YAaBghiIpMYw0hR
         t83NG/2IkmBzqgcgToUYCgzFSTqLoG96EB+8YCmpz365FVnvUJk0cvCNxUa6LTJQh64p
         FgyRV58Zj3FoCtoKfN0pJj149WibVOsHlbm54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733685096; x=1734289896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ARaxTKQ4EUM4eubwfl7TGFPpHDREYZwBZ/7BI9KbG60=;
        b=A2XGKnUqHa23jnVyayCblYM2RCMp6Wxb+rT02yDGoW6hPviITc4J1LDtCmPNea1hxQ
         lV7u7xvNFnlo+/872g1G1pbcqI56jtj7ILyQjDD72AcqseVNZEhUKoO9YroLcoztU64W
         VjE/xTHzfkLBNVC+mj9y/MhlbeP2GX9hyEvEuDV90v2IvJFeZDURJW5WG3f8xAu3FKo5
         QOLj/9Zpi9BCTgfQ28HurklyKw6B79SoDbei1CKNNaHu1Mit30mvfVtm94TvG9yHJ4Ap
         EAioYjRsBAHKdUoSI17NMg6lYEJRdWtXia2Aeg0mmv1xQSpHxdQU8QGwP4KFQas4QZb5
         PrgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2O5E/ip/6DE4A6jeQJz5l2yy6RQBPwos3qepwVnVM8PCPVk7SbD7nV9FQPeN0ITveT9MiZw==@inria.fr
X-Gm-Message-State: AOJu0Yz6v4VqwnapGZkeQRY2+6/1BYXd5qPQgFgOBaajts/Y5Jot/laB
	2aFSzeP759OSg9T4VBWHAciZs0b0kIjo/GHj1YybrCjvOnM3docraElqMHba9Tz9yICWZVfBxH1
	ziZoDJ8xxlHB3NnTxIr9wXbq365896tJIz/9SO8z0pzOyhU9IWg==
X-Gm-Gg: ASbGnct5UVwvb3CGEUL2Bt3H4XhjlBvLsSem9bgJMmJqFn+0+Cbg1LZVrUyyKZrOp+t
	Jvpod0mT6SzxRKkP4LkztGlkN9LLF+SJI
X-Google-Smtp-Source: AGHT+IFS9qF/4Qfve1o3eaL4p0cTeJfHDpp91VUfOnbbuMRy7++0SoBQGbMxyQ3xbdK4dDF9eZy8G1KRvKgBMAR8uDg=
X-Received: by 2002:a05:690c:6108:b0:6ee:6a2a:a517 with SMTP id
 00721157ae682-6efd04daademr116381807b3.18.1733685096038; Sun, 08 Dec 2024
 11:11:36 -0800 (PST)
MIME-Version: 1.0
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
 <6b81d431-36e9-7a7a-687b-2d7fc7aa6c31@inria.fr> <CABQX2QP0Vk5UZPDFDXThvzuw-gkam-4wU_xq3rbSmwi9x7cBHw@mail.gmail.com>
 <dff4cbd9-00c1-47a9-b2f7-fb2e98d04433@web.de> <CABQX2QPZB9uHMxKKoZA6f=+4f0ifHfft-rHcqd-Ck9rjo7-ShQ@mail.gmail.com>
 <1995b696-6825-a144-fcb-c5f9f3b1094@inria.fr> <CABQX2QOb9C4G3Kejo_ght3Dgo0qxHW5A6it4GB6TdgoU0Bo7sQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2412081042370.3332@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2412081042370.3332@hadrien>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Sun, 8 Dec 2024 14:11:25 -0500
Message-ID: <CABQX2QMwBGJHnehxy4j0gHgmUWBBuFqncLWbDZWEdENtGOrZ3w@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000529b020628c704d2"
Subject: Re: [cocci] Replacing type names
Reply-To: Zack Rusin <zack.rusin@broadcom.com>
X-Loop: cocci@inria.fr
X-Sequence: 2168
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/CABQX2QMwBGJHnehxy4j0gHgmUWBBuFqncLWbDZWEdENtGOrZ3w%40mail.gmail.com>

--000000000000529b020628c704d2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 8, 2024 at 4:47=E2=80=AFAM Julia Lawall <julia.lawall@inria.fr>=
 wrote:
>
> > No worries, like I said, it's not a big issue. I don't quite
> > understand what you mean by "match the function definition". I need to
> > match basically every non-keyword in a c file, because everything
> > needs to be renamed: types (i.e. struct names and typedefs), variables
> > (global, local, static, const...), struct members, function names
> > (both in the definition and declaration) plus all parameters (types
> > and variable names) in signatures of those files. Every one of them
> > needs to be renamed.
> >
> > With:
> > @types@
> > type t;
> > position p : script:python(t) { needs_rename(t) };
> > @@
> >
> > t@p
> >
> > @script:python adjustment@
> > input << types.t;
> > p << types.p;
> > updated;
> > @@
> > coccinelle.updated =3D cocci.make_type(camel_to_snake(input))
> > @replacement depends on types@
> > type adjustment.updated, types.t;
> > position types.p;
> > @@
> >
> > -t@p
> > +updated
> >
> > structs are replaced three times, which is the first issue. Then:
> >
> > @vars@
> > idexpression func;
> > fresh identifier func_name =3D script:python(func) { camel_to_snake(fun=
c) };
> > position p : script:python(func) { needs_rename(func) };
> > @@
> >
> > -func@p
> > +func_name
> >
> > doesn't match the function name in definition/declaration or the names
> > of parameters in signatures. And even if it did I'm unclear how would
> > I go about replacing it (i.e. I'm assuming this is where the
> > metavariable would come in because there's no cocci.make_parameter so
> > I'd probably have to use cocci.make_expr or such and then somehow
> > replace the parameter list with a metavariable that's really an
> > expression?)
>
> Function name:
>
> @r1@
> identifier i : script:python(t) { needs_rename(i) };
> @@
>
> i(...) { ... }
>
> @script:python adjustment_fnname@
> ...
> @@
> ...
>
> @@
> identifier r1.i, adjustment_fnname.updated;
> @@
>
> - i
> + updated
>   (...) { ... }
>
> Parameter name:
>
> @r2@
> identifier fn;
> type T;
> identifier i : script:python(t) { needs_rename(i) };
> @@
>
> fn(..., T i,...) { ... }
>
> @script:python adjustment_paramname@
> ...
> @@
> ...
>
> @@
> identifier r2.i, adjustment_paramname.updated;
> @@
>
> fn(...,
>    T
> -  i
> +  updated
>    ,...) { ... }

Ah, that moved the conversion quite a bit. The "identifier" doesn't
seem to accept the script:python, but I was able to reuse position p
with it. Based on that I added type replacement for parameters:
https://gist.github.com/zackr/85ab3864fb70905738cdead35d787f9f
is the most complete version of the script but it's not there yet. It
renames quite a bit of the sample_case.c - misses the struct
declarations and the struct accesses. I was trying to fix struct
declaration matching with:
@r6@
identifier i, i2;
position p : script:python(i) { needs_rename(i) };
@@

typedef struct i@p {...} i2;
but that results in parse_error around i2. Also while the above linked
script works on sample_case.c when I point it at actual source code I
get:
ocaml exception: <capsule object "ocaml-capsule" at 0x76b7c27ec4b0>
failed to parse type const brc_device_params *
Error in Python script, line 96, file "camel_to_snake.cocci": Python failur=
e.

I'm going to give up on this for now. Pure regex camel-to-snake works
well enough for me and even in its current form the cocci script is
pretty complex and it's still not handling all the cases so the odds
of anyone else on the team being able to maintain it are very slim. I
do appreciate your help! It helped me understand quite a bit more
about Coccinelle in the process. Thank you.

I'm going to leave the
https://gist.github.com/zackr/85ab3864fb70905738cdead35d787f9f up in
case anyone would like to continue down this road

z

--000000000000529b020628c704d2
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEN8
M/Kg8ISrdnlltlOmapp5u56B0fvUABm5S4lmkw1MMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI0MTIwODE5MTEzNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJ
KoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCktyJpRJ6DlGN7GU+gpXJk
SHvpZ9bViNhA9e9T/ub8crxtUh7/eD5OZvSALFhm2l8N0+Uy+pEXHDbDg4TvvOGyz7Z82zLkZsNU
ecAnrxABBInz08dgZ59RoQXk/UYmVKG93c9xAQwd6yRaw/ncVTuUlv5GwwX+wms4EIGeob79cgrK
Js5/UizqLp9I6aZoyEUSnWjans9EKenkIDWkMd1DBkLq4fdwuh6+gffJi/iWnUgF76w7Zx9Aq++a
CHtB0+92oygTBTDq6s38cUr6ChJftnaBKsGolmcFOWSLs5TjzqnXAvgqlK7G8A1UBKN1eWpqsFTN
ZM6SAQJsf8oy1pTq
--000000000000529b020628c704d2--
