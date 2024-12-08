Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1107E77173
	for <cocci@archiver.kernel.org>; Sun,  8 Dec 2024 06:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=W0GzCy47yGbuh2NrxkwtMKuFiO1S+36PkYK9dCjaffo=;
  b=hsrI0d2hg7cnGeBDZ6Vpru6Qe7WgB+PIqrBKNfikiLWKxGQLX9uAk39p
   EzXA2r1nUMZf7daM47tjNDy831DcgPTd2Oqbz5+38T/Ey25g/YcD8l6It
   ooLdy98DJ9//udFDACc/tArygn5Nkm5IpZDzzjsBNtCt91jkU5ticNrY4
   w=;
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
   d="p7s'346?scan'346,208,346";a="197919083"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Dec 2024 07:14:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 51AA9E0D1C; Sun,  8 Dec 2024 07:14:53 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3D120E00B6
	for <cocci@sympa.inria.fr>; Sun,  8 Dec 2024 07:14:51 +0100 (CET)
IronPort-SDR: 6755395a_YxJLLKPtqs8SCRPFoLa4p4PJETBbxknVIadcyc1H4dnCUDa
 cVRF2i9EcBCebDsWu6dI3XP2+9G7iiprH8aonKg==
X-IPAS-Result: =?us-ascii?q?A0E6AABVOFVngbbbVdFaHAEBAQEBAQcBARIBAQQEAQGCA?=
 =?us-ascii?q?QUBAQsBgkN9Lis0BAtIAwGEUoEjjiqCJJ4YgUA+CAcBAwEIBT0HBAEBAwSFA?=
 =?us-ascii?q?AKKaQIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?SIZBw47hXsNgmIBgSRRVQEBAQEBAQEBAQEBAQEBAQEBARcCCAdcAQEeAQEBA?=
 =?us-ascii?q?xIRHQEBNwEPCwsNKgICAh8SAQUBHAYTIoJfAYIwAyARAxGiSoEFQos+gTKBA?=
 =?us-ascii?q?YIMAQEG2yYiV4FdBwkUgTQBgVeEE4JjAYFaEoMMhHB6Jw+BVUSBSoJ1PoIsN?=
 =?us-ascii?q?QWFOIJpgkCDJ4NKhzKDOokxh1YmJgMHBw4NHkkPIQNZMgFVExcLBwWBKSEsA?=
 =?us-ascii?q?QIBgR2CC4FbBTdHgkppSzcCDQI2giR9gk2FF4ELgRWCSUqEDoYlghoVHUADC?=
 =?us-ascii?q?2ILPTcUG0yXNwgfgQ6CbQFGg1GDBlqjQYIgoE00B4QdgV0GDIRtgzCCC5VHM?=
 =?us-ascii?q?4VbpHaYe44CmxcRI4FKATOBXDMaI1AxBoIwCUYDGQ+OIQwWg1i/SSgyAgEBC?=
 =?us-ascii?q?i4CBwEKAQEDCZBUgUsBAQ?=
IronPort-PHdr: A9a23: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
 w==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:7zlXnaBBSa4oMOjlHemA55DYdb4zR+YMi2TDGXoBMSC9E/bo7P
 xG+c5w6faaskd0ZJhNo6HkBEDEewK/yXcX2+ks1NWZLW7bUQKTRekI0WKh+UyCJ8SUzJ866U
 4PSdkGNPTASXZ/yej1iTPWLz/i+rW6GWKT6Ns2A00CceiiUcBd0zs=
X-Talos-CUID: 9a23:XqJs3Gw2WqUhujaQUpg1BgUNPOIqVFTwlk3KHG6jA35FSeCSGV25rfY=
X-Talos-MUID: =?us-ascii?q?9a23=3A6ToHRA3mxDZuZve4OAnyJVZYBzUjoI6eFBoVtM8?=
 =?us-ascii?q?8lZetMAJAAS6wvAiRXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,216,1728943200"; 
   d="p7s'346?scan'346,208,346";a="103721637"
X-MGA-submission: =?us-ascii?q?MDFqtH23v4h2Osp0q1t6KRRDXOkJAIdYLNTtDH?=
 =?us-ascii?q?tPJcefPiGCT9QgCv6O0EbSEY5tiq01R2eZikTm4Fjx/0oGI8IH7memSX?=
 =?us-ascii?q?8VcCNGzrbjfyalf6DcHDaXtuPgmyO16cVAXW8LSPdzZgZAjHMGt0ILji?=
 =?us-ascii?q?B348RrcybE1LMPabXsNTVT/w=3D=3D?=
Received: from mail-yb1-f182.google.com ([209.85.219.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 07:14:51 +0100
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3985aabf43so2665317276.3
        for <cocci@inria.fr>; Sat, 07 Dec 2024 22:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733638489; x=1734243289; darn=inria.fr;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W0GzCy47yGbuh2NrxkwtMKuFiO1S+36PkYK9dCjaffo=;
        b=NALptHjKi3N2+nGPnR3xbiJMbfYP50BBIZbdsSzVySPhg7UESCS5zCHg3TAEjMdwu/
         nijF4wKz0FMP1Mda+qQoD27SnGNVmnxOaFWCDqVE3Ub3om3aH9Ed65j8haeT/LOM56FZ
         V3tQU7I1jaVmGJnI1RKHl9T82eT8wrmFfWIIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733638489; x=1734243289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0GzCy47yGbuh2NrxkwtMKuFiO1S+36PkYK9dCjaffo=;
        b=ZplnTBG7REAVzLA4r+GdLoX1iSBMgWwX0dXUSdPY46Y9Ut6aCP9l8LTL1xi5+hZF+j
         mSsnudfcHCCFtavC9UcsQHqAJ+H8uGhvNgISyIWBLAVlBYTZnQAChfTET4RODibUhqZr
         jBFHpnFF6TgOXy9Xwrac5ZrWVfuEH0IhtUmVjRR94Q4U1GTLqn/diaoN5RYIRjyggs1Y
         bZ6lrNbUcqodk+uoxS7jEEMPIg1eZbKPzjhfZofUI+vrlL+syc2luz2ry37kwPZsTb1z
         OWk1EYAvT28UiB3IY4xIodgK6zaSCuM8OlCbum+G7Chf3z+GQTASE5dYba/NelAkWxh6
         lbMg==
X-Gm-Message-State: AOJu0Ywq2d83VZcmy6HvyIULJOKn/aK9ScTIxE0PP66HYWl06u+5LZ4Z
	Y38iG6h6HcjCyq3becjkc0ZS3vQKGcddyYf+5aU7Hi2ytAV/7NSi/Xdjme83uhLuMjBm6T4k51Y
	Mg5OXnU5jKF0COZyEJDVvP2/HhkEJeidteLp4wakadiRB/Ik=
X-Gm-Gg: ASbGncuxkozzAuQBX96MP2s7TWRjR7z3ep54ho6HeD8gwltuHRZSfgPaFDf0dNU74PB
	pXvp3/10XfUeO7eVcweSnT7uVCfcmccW4
X-Google-Smtp-Source: AGHT+IHshgIwwuIkuiRD6sn9VWvnnz5cU6sQ2PoqKX/WWRo9MeZCxihAXLdvpTGvhLSUxQT160HmC+xvqZ0v0IyCWvA=
X-Received: by 2002:a05:6902:2488:b0:e39:8462:8bc5 with SMTP id
 3f1490d57ef6-e3a0b70158amr6736629276.51.1733638488968; Sat, 07 Dec 2024
 22:14:48 -0800 (PST)
MIME-Version: 1.0
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
 <6b81d431-36e9-7a7a-687b-2d7fc7aa6c31@inria.fr> <CABQX2QP0Vk5UZPDFDXThvzuw-gkam-4wU_xq3rbSmwi9x7cBHw@mail.gmail.com>
 <dff4cbd9-00c1-47a9-b2f7-fb2e98d04433@web.de> <CABQX2QPZB9uHMxKKoZA6f=+4f0ifHfft-rHcqd-Ck9rjo7-ShQ@mail.gmail.com>
 <ffbdf21e-3807-4a35-8f53-60957606c9e5@web.de>
In-Reply-To: <ffbdf21e-3807-4a35-8f53-60957606c9e5@web.de>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Sun, 8 Dec 2024 01:14:38 -0500
Message-ID: <CABQX2QONmtNAScz_-g0Cj3BRmDtoNyFfk-MSoTCMCbNa-FwpmA@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005190d60628bc2abf"
Subject: Re: [cocci] Replacing type names
Reply-To: Zack Rusin <zack.rusin@broadcom.com>
X-Loop: cocci@inria.fr
X-Sequence: 2164
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/CABQX2QONmtNAScz_-g0Cj3BRmDtoNyFfk-MSoTCMCbNa-FwpmA%40mail.gmail.com>

--0000000000005190d60628bc2abf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 7, 2024 at 2:24=E2=80=AFAM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> >>> From the sample_case.c I linked before the two constructs I'm having =
a
> >>> hard time matching are function names in definitions and type names i=
n
> >>> parameter list, i.e. in
> >>> static bool SomeDeviceLocalCompare(SomeDevice *localDevice)
> >>> neither SomeDeviceLocalCompare or SomeDevice seem to matched via idex=
pression.
> >>
> >> * Did you find scripted SmPL constraints more attractive somehow
> >>   than script rules?
> >>
> >> * How do you think about to choose more appropriate context informatio=
n
> >>   and corresponding metavariable types?
> >
> > Sorry, I'm not sure what you're asking.
>
> Does anything hinder you to extend data processing for a source code sear=
ch approach
> like the following?
>
> @find@
> identifier i;
> parameter list pl;
> type t;
> @@
>  t i(pl);

Well, it's just that this isn't the problem. The problem is not coming
up with ways to match constructs, it's coming up with a way to match
constructs that could be overwritten from script. In this case I don't
see how we'd convert every type and every parameter name in the
parameter list (or how to create a subsequent replacement rule for
identifier, type and parameter list).

z

--0000000000005190d60628bc2abf
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJa7
pq+R0vZheY8SudIcPafPqI/kW7F0xk5X3v4x8E/9MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI0MTIwODA2MTQ0OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJ
KoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBR3RHLnihgvuzw46Ww+j6R
bFPqpcBhOABu/m7JucvCtlsZnJpbfdyO1C5WdnsGGZcpv6VZzMoBE02gx3bWFKMDTGqZdD/NcBMB
NHEgasPKGtLT1zg4C9kFe1aPVAy3yiOGBi53wWcSlLoHmsZN9cGQ97RToEyhs1OJQ9TPaTpUPs+F
0M1ytEGZ4Yqr4REm4heEVpWRHeE2l8A5MY9qPB4xMzerYfjp5AkG0MGEORFXsrUuJ3q862D0Ca1r
gX+ooOpViydQJdyeD3cLfR4vJYYXSSdaPjkUhyycjlWn+Uxzx7vfA0Xgtf9KOGJ5VhoAcoS/eu+n
2fyDLyBGgE6xALgb
--0000000000005190d60628bc2abf--
