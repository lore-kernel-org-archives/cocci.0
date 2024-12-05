Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25197E7716C
	for <cocci@archiver.kernel.org>; Thu,  5 Dec 2024 04:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=64C2q3q8hviY2kvYtAPhZAhVXtVzGUr+7lrkYRQef44=;
  b=C5DrJPSi5cDt1EbBZvZUrlLmBT3jAmzHPq4oLWf/aeqcf7a/8tt2jVLf
   /BpXRn6kG5M5PKNrI5w/YZ822Yk0I3c6GWPNkBberfJ/wW+GBcYo95DUX
   /aPIptvhujFUbdqb6uFgwXbpGmp3wrqVqpnG6Kykv5U2n8BIPRMus5fGI
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@broadcom.com
X-IronPort-AV: E=Sophos;i="6.12,209,1728943200"; 
   d="p7s'346?scan'346,208,346";a="197440446"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Dec 2024 05:26:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0ADD3E0D1C; Thu,  5 Dec 2024 05:26:49 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2AAC3E00B6
	for <cocci@sympa.inria.fr>; Thu,  5 Dec 2024 05:26:46 +0100 (CET)
IronPort-SDR: 67512b85_v3O44Bl+7vwtF0X1VuycDfBnagwTzOQPliFnj5Kn/fU3frO
 mde1VTQ61TGs84oiB3/XivvDnPyWrFIVbxWJVaQ==
X-IPAS-Result: =?us-ascii?q?A0EfAACXKlFnfK7bVdFaHAEBAQEBAQcBARIBAQQEAQGCA?=
 =?us-ascii?q?AYBAQsBgkN9Lis0BAtIAwGEUoEjkE6eGBSBLD4IBwEDAQgFPQcEAQEDBIUAA?=
 =?us-ascii?q?opqAh4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBI?=
 =?us-ascii?q?hkHDhIphXsNgmIBgSRRVQEBAQEBAQEBAQEBAQEBAQEBARcCCAdcAQEeAQEBA?=
 =?us-ascii?q?xIRHQEBNwEPCwsNKgICAh8SAQUBHAYTIoJfAYIwAyARAxGkA4EFQos+gTKBA?=
 =?us-ascii?q?YIMAQEG2yYiV4FdBwkUgTQBgVeEE4JjAYFaEoMMhHB6Jw+BVUSBSoJ1PoIsN?=
 =?us-ascii?q?QWBKAESAYN8gmmCQ4JpgTN2JYU2g0qHMoM9kVsmJgMHBw4NHkkPIQNZMgFVE?=
 =?us-ascii?q?xcLBwWBKiEsAQIBgkd/gTaBUQGDEEqDLoFeBTdHgkppSzcCDQI2giR9gk2FF?=
 =?us-ascii?q?4ELgRWCSUqED4YqgWMdQAMLYgs9NxQbTJ0bCEqBHIMMAUaDUAeCNUqBMqUJo?=
 =?us-ascii?q?E00B4QdgV0GDIRtgzCCC5VHM4VbpHaYe44CmxcRI4FFAThscDMaI1AxBoIwC?=
 =?us-ascii?q?UYDGQ+OIQwWg1i/PigyAgEBCi4CBwEKAQEDCYx0gUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:TFpGFqgJiFMAgFc6+pOaCEsq03BQXvYji2hC6mlwRA09TyVXrb
 HXoB17726OtN91YhsdcL+7Sc29qB/nhPtICMwqTNWftWrd2FdATrsSircKqgeIc0bDH6xmpM
 RdmsNFebvN5DZB/L/HyTj9PdJl7tfvys+VbCTlo0uFjzsGV0it1WlE48+gc3FLeA==
X-Talos-CUID: 9a23:4Kpmz2BeD3G2p3/6E3g5rkpNF5gMTkbQyFLVLxW1AzxUWJTAHA==
X-Talos-MUID: 9a23:2D85kQkUmxZWVhJesxPddnpyBdo1/fr3NnwhmMsGpfePGwpUZHS02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,209,1728943200"; 
   d="p7s'346?scan'346,208,346";a="197440444"
X-MGA-submission: =?us-ascii?q?MDEYri7MLDAYjy08Zx4vppTpicMTrgmXj91Dr1?=
 =?us-ascii?q?XtMpViQW0F+E0iPyZtGYg0PtVMcJzseQiDsaI2uvHIaPpff2hUF1/kXl?=
 =?us-ascii?q?64dYa5x65JkSctEvyIQDl1LvaaRWX2Cjv2sVVlr25fCHG8884gH9GV0R?=
 =?us-ascii?q?qzk1MxJFy5ya29kya+rAoaJA=3D=3D?=
Received: from mail-yb1-f174.google.com ([209.85.219.174])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 05:26:45 +0100
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e3983426f80so681297276.1
        for <cocci@inria.fr>; Wed, 04 Dec 2024 20:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733372804; x=1733977604; darn=inria.fr;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=64C2q3q8hviY2kvYtAPhZAhVXtVzGUr+7lrkYRQef44=;
        b=R9qDY6a+tVjxVIfm+oWzipgitP5JGlttVBjzpFlshM9PrPHqIly99GAId68GeOHCMj
         J889fHqqIXFe55KSBr9Ad1K8Lv4rcRfO/5U44o1cTdQaEFn48dZemNqExf9yrgYCDwbp
         G/WNp3mCTDBTWdvAR8VdjJXNkjtpyCdp0yJYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733372804; x=1733977604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64C2q3q8hviY2kvYtAPhZAhVXtVzGUr+7lrkYRQef44=;
        b=Q7IutOABjLmu86fPRei6qkRmOjdMzLoIrBG+C2EQtKPxlI1fuC71vl2NVZXzyYp9ni
         arz1WdEx5VPmkTWaAVj1GpLT/6uZOpL/CleICaQUJr0HxMN62zlVENVTsGk2CxuSM8a0
         WonGhLjH5a4+AqnrPOolFasT3Od6A3K5CvDYuzGIyv38XtSW+4HVq7Gzmlmcd4qyvZGY
         RVtj+98ZGty7E6qOt3A6T9q50GVwMFUipfQGrG6fwiHr+NwK2kaENZNi5Ra2NepBy81h
         w0nW8Z/N9d8I5qmSkNi1H4DXc31nlcDIv/wCTJlCgjD8rxF97bZ7hYw0lzg9RmL0CkwN
         Ec2A==
X-Gm-Message-State: AOJu0YwpTsHrmb54tj/9zgduxCsIsF4qgKgIx79/SdVGqPP+AlbxAc5R
	LNLzZDZmsc1UP38gc3Z1N+FSSp+doI8ieBd/cZaxefas/c/X0ICxODhYdU2cpLsMCywDgktCBU7
	aYKSSxSX1oudCPFqUpIjgAj88ZmG3Db0LjZCn4qyHHMj1JEFX/g==
X-Gm-Gg: ASbGncvaJEq77/UdzAZbhyHM2YJAm7mjjarfFvluCwzWhXBNTFCyGAbNOD5Mt2DTE67
	CW0LkVLkiZrfhIbwGZWL48qKvKghFk0H1
X-Google-Smtp-Source: AGHT+IGFMU0LKOPzWiBDvw6tDdE4E02HIp1tNvqJnF3R9aoMWGBC3UN+YH+weTxgd2jsadpbPzkA6yoRUyscmMWuRJo=
X-Received: by 2002:a05:6902:27c7:b0:e39:a88c:d0d0 with SMTP id
 3f1490d57ef6-e39d3a252b1mr9134215276.17.1733372803916; Wed, 04 Dec 2024
 20:26:43 -0800 (PST)
MIME-Version: 1.0
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
 <6b81d431-36e9-7a7a-687b-2d7fc7aa6c31@inria.fr> <CABQX2QP0Vk5UZPDFDXThvzuw-gkam-4wU_xq3rbSmwi9x7cBHw@mail.gmail.com>
 <dff4cbd9-00c1-47a9-b2f7-fb2e98d04433@web.de>
In-Reply-To: <dff4cbd9-00c1-47a9-b2f7-fb2e98d04433@web.de>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 4 Dec 2024 23:26:32 -0500
Message-ID: <CABQX2QPZB9uHMxKKoZA6f=+4f0ifHfft-rHcqd-Ck9rjo7-ShQ@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000042a63306287e4e51"
Subject: Re: [cocci] Replacing type names
Reply-To: Zack Rusin <zack.rusin@broadcom.com>
X-Loop: cocci@inria.fr
X-Sequence: 2159
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/CABQX2QPZB9uHMxKKoZA6f%3D%2B4f0ifHfft-rHcqd-Ck9rjo7-ShQ%40mail.gmail.com>

--00000000000042a63306287e4e51
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 2:56=E2=80=AFAM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> > From the sample_case.c I linked before the two constructs I'm having a
> > hard time matching are function names in definitions and type names in
> > parameter list, i.e. in
> > static bool SomeDeviceLocalCompare(SomeDevice *localDevice)
> > neither SomeDeviceLocalCompare or SomeDevice seem to matched via idexpr=
ession.
>
> * Did you find scripted SmPL constraints more attractive somehow
>   than script rules?
>
> * How do you think about to choose more appropriate context information
>   and corresponding metavariable types?

Sorry, I'm not sure what you're asking. Nothing has changed since my
first email. Coccinelle is a wonderful tool, but currently it doesn't
work for this use case. The type replacement is matching multiple
times and to my knowledge there doesn't seem to be a way to convert
arbitrary function and parameter type names. This is an all or nothing
type of problem - either all of it can be replaced or a regex script
has to be used (clang-tidy with readability extensions also misses a
bunch of constructs) to convert from camelCase to snake_case. So
afaict there's no way to solve this problem without using some regex
replacement script.

z

--00000000000042a63306287e4e51
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVLwYJKoZIhvcNAQcCoIIVIDCCFRwCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghKPMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGWDCCBECg
AwIBAgIMYT8cPnonh1geNIT5MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyODA2NTUwOVoXDTI2MTEyOTA2NTUwOVowgaUxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjETMBEGA1UEAxMKWmFjayBSdXNpbjEmMCQGCSqG
SIb3DQEJARYXemFjay5ydXNpbkBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQCwQ8KpnuEwUOX0rOrLRj3vS0VImknKwshcmcfA9VtdEQhJHGDQoNjaBEFQHqLqn4Lf
hqEGUo+nKhz2uqGl2MtQFb8oG+yJPCFPgeSvbiRxmeOwSP0jrNADVKpYpy4UApPqS+UfVQXKbwbM
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHE8
n68UkkdYuJaJpkhVpnJ/jRCg7904s28k/vqGZ+opMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI0MTIwNTA0MjY0NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJ
KoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAMLGHzmgY+UDRRC8pKnern
kFGvz4iivLtDm6f3GWXhFN0C2MoaP/UZ09ZqVY5xkHbcvoamrTqh5FpqGQ4WSei7fGxfgY7Xoogp
hJZbEvXPeadMjkFd1COcllSyYYS/zuBV8RFZY7vkDsQltTji12yVA7Mq4iS242o+pLvWbtwl1+BX
X7UCbMR4+oMMHYOUembFbCijRlQZIOCSy2xh9vPZSiILIsZLVO5XmEV0KSY7fRx/9rDHFqYAH+jd
/0gwfrsBRcvo7WJYuhRteForcAyeGEiN+i24l6eJHvEUpqHDQQqB61sW5dqtDFHtjDyBUXJpoU29
HCApHbDcKLw65SeS
--00000000000042a63306287e4e51--
