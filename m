Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2CAD7360E
	for <cocci@archiver.kernel.org>; Sat, 30 Nov 2024 22:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=jZ6H8e0MPY9uNlUNZd8U9fkTK1aeE91BJLTMqOookFM=;
  b=hayHPlGA4TBQtu0km6wCTmb0tpTW7LqikGpNXW/4TfSRGLAy/ivqAI9S
   Lc0Rb1fMTanYHJE34qOOsQQz4zy7yWtSTDpBELFI43bRFBAAbf2fzGXCm
   42d4U8+NXVGEPFrvbNELh21zuQVTUh2UA5V3H5amJQsNafAiY1XcO1rQZ
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
X-IronPort-AV: E=Sophos;i="6.12,199,1728943200"; 
   d="p7s'346?scan'346,208,346";a="196648861"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Nov 2024 23:49:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 25E7BE013D; Sat, 30 Nov 2024 23:49:36 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C6C85E00B6
	for <cocci@sympa.inria.fr>; Sat, 30 Nov 2024 23:49:33 +0100 (CET)
IronPort-SDR: 674b967c_qEzEe1WEV+dzTwILurNgY0BJQ/UYCjpmyWcnnau2Tgda1S2
 3BkFpNV4Pzb1xjFw1vNrhBJVBUl2FXXvU1PbBjQ==
X-IPAS-Result: =?us-ascii?q?A0G5AQCnlUtngazbVdFaglyCRH0uKzQEC0gDAYRSgSOOK?=
 =?us-ascii?q?oIhA54XgUAWJQMIBwEDAQgFPQcEAQEDBIUAAopjAh4HAQQwCQ4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBIhkHDjuFew2CYgGBJFFVAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBFwIIBQJcAR4BAQEBAgESEQQZAQE3AQQLCwsNKgICA?=
 =?us-ascii?q?h8SAQUBHAYTIoJfAYJBEhEDEaQMgQVCikR6fzOBAYIMAQEG3B+BXQcJFIE0g?=
 =?us-ascii?q?ViEEoJiAYFaEoMKg2+BAXonD4FVRIETN4J1PoIsNQIDhTiCaYJCgTOBM4IpJ?=
 =?us-ascii?q?U2EaYNKhzGDPZB5JiYDBwcODR5JDyEDWTIBVRMXCwcFgSkhLAECAYJGf4E2g?=
 =?us-ascii?q?VEBgxBKgy6BXgU3R4JKaUs6Ag0CNoIkfYJNhReBC4EVgklMhBKGLEIdQAMLY?=
 =?us-ascii?q?gs9NxQbTJxSCEqBHIMEAUaDRoEVLF2BQluSYJAFgiCLcZRbNAeEHYFdBgyEb?=
 =?us-ascii?q?YMwgguVRzOFW6R2mHuOApVlhTIRI4FEOoFcMxojUDEGgjAJRgMZD5IbxmQoM?=
 =?us-ascii?q?gIBAQcDLgIHAQoBAQMJkWuBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ITATJ6tx3HqxFb1fl2I+ovEk7skDWtV00zEX/kB9WHVpmwKj5r
 iTdZUgpGTJYVMqMk3I9urwXJVoLUmskKKdpLNhX4tKPzOHhILLFvAE0WKK+VSJcBEWtNQttp
 uIGJIObuEYY2IK9PrS0U2XF5IPzrC8n5xARt2z856ud2xXgm1bgTuRwzz7LnFL
X-Talos-CUID: =?us-ascii?q?9a23=3AzQ5za2linQOvj3eLh1pri5Lne6jXOXbbnXf0IRT?=
 =?us-ascii?q?kMm9oFKeQYGKS6P1OlPM7zg=3D=3D?=
X-Talos-MUID: 9a23:ceyQnwS+AgoYMiUfRXTnog1vaMVM/p6zCUBSwbw0kuy8LAJJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,199,1728943200"; 
   d="p7s'346?scan'346,208,346";a="103072245"
X-MGA-submission: =?us-ascii?q?MDG3rjJfj1z8yvDLJlZSy+HZClSVgbDFZ4n4T2?=
 =?us-ascii?q?A+k2IMv8dIN1FTSyjW/OZ0hmlAmH0BT46mVhIPllfIdFnZKWq+fbaWOu?=
 =?us-ascii?q?01+89zpk9+/DG/TTrGjLkOEIQNgEQnRVxkQTQc6r2g7WHacryCoErp3J?=
 =?us-ascii?q?dlwitxlUEvUe0XfMnPoajR/w=3D=3D?=
Received: from mail-yb1-f172.google.com ([209.85.219.172])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 23:49:32 +0100
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e3982e9278bso2053677276.2
        for <cocci@inria.fr>; Sat, 30 Nov 2024 14:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733006970; x=1733611770; darn=inria.fr;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jZ6H8e0MPY9uNlUNZd8U9fkTK1aeE91BJLTMqOookFM=;
        b=MBPunl2c+11Vq2RuhRE4Oqsd7QUf2xfpCUblCsP15gEk4EQWCQF7ROSHgIPzXAIHcF
         IfjI5aMuk6qO8lAFfFaYtCp8NlzmKjmttzYEA9k4DsA7MR4Qq2HgNzCeOWKuM1L5Vcvn
         TFQ1kE0JuyYt1tljAk2SHNvRhDqkPz2U4UfqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733006970; x=1733611770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZ6H8e0MPY9uNlUNZd8U9fkTK1aeE91BJLTMqOookFM=;
        b=JHVQeyalQ6mTs8v8S3kgWpOA8JfY7Qv4UuwfDiowLmHzPEXNZaY6l+5e7aCtAg5Q8q
         lKq9HUgfhrj1hsBSOgraGG3nCiha/zTPPwlqwcbSwtdqJpejQsw7uMwEINDflHneK1b8
         VX4gv5JDxBjiT7RpOiOrd+Oalujnj5ho9aBwxWpmqKr0ybjv9IJrv9ZnY/4Bj+n+0f97
         Yct1Em/6JVq4/tYC9aEkCvC6fvrVTGqWgMxjlvUhZ4vVFO35MWoCw2xuYxJETivYL+RF
         RyklBzLB4t+Y0saDKh2+64pA6gWX0RAg4DupwxHRdHhdWR8/ebWVVnWiwOLEmp8P+fAY
         WlLw==
X-Gm-Message-State: AOJu0Yzb55koqIUHnsJklAi7BCgQorKOwVQTqjn8FfpmGv/wzo7xy4vp
	IBdxScPCEa3uHtgGY0xL1ZTJAlsKDm80pH7R8iRijMue3plSLwi9PQ1LxJ4fKXQBjw8beTb8bbw
	qgbs2Lb6jUOoQ1dXmB1BQrslO66RMljoo7hHy3eldPb81n6ViIw==
X-Gm-Gg: ASbGnctn2OgBz2PSAfSNoBuQFnr2qsxAzGw1ltpj9oT9akh0lvalTEHjsm0VOXcOM+Z
	joyNUFiMQMRy+dOrHcQ6PTQ3E7UmpIykf
X-Google-Smtp-Source: AGHT+IHn+KJiVR8z+HGx7q8nM4MfvYCh3lvykByJX2XMf7nSee1p7bCqY4QrTig/EPo3qBjm2FP6ZrBEZyezgIUlWqU=
X-Received: by 2002:a05:6902:2006:b0:e39:9fbd:545c with SMTP id
 3f1490d57ef6-e399fbd5e15mr1913949276.24.1733006970643; Sat, 30 Nov 2024
 14:49:30 -0800 (PST)
MIME-Version: 1.0
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
 <6b81d431-36e9-7a7a-687b-2d7fc7aa6c31@inria.fr>
In-Reply-To: <6b81d431-36e9-7a7a-687b-2d7fc7aa6c31@inria.fr>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Sat, 30 Nov 2024 17:49:19 -0500
Message-ID: <CABQX2QP0Vk5UZPDFDXThvzuw-gkam-4wU_xq3rbSmwi9x7cBHw@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e6087c06282920af"
Subject: Re: [cocci] Replacing type names
Reply-To: Zack Rusin <zack.rusin@broadcom.com>
X-Loop: cocci@inria.fr
X-Sequence: 2143
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/CABQX2QP0Vk5UZPDFDXThvzuw-gkam-4wU_xq3rbSmwi9x7cBHw%40mail.gmail.com>

--000000000000e6087c06282920af
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 3:15=E2=80=AFPM Julia Lawall <julia.lawall@inria.fr=
> wrote:
> On Tue, 26 Nov 2024, Zack Rusin wrote:
>
> > Hi,
> >
> > I'm trying to write a  script to snake case all type/function names
> > but I'm having a hard time matching some types. I think I'm missing
> > something silly.
> >
> > My input script is:
> > https://gist.github.com/zackr/198db11e5e5243adbdc59b9844d8eb6b
> > which when applied
> > spatch --sp-file sample.cocci sample_case.c
> > on the following sample_case.c file:
> > https://gist.github.com/zackr/97cb903c6e0306b25dcb8fa9f696077c
> >
> > ends up doing a little silly things like:
> > -typedef struct SomeDevice {
> > -    uint32_t sampleVariableUnsigned;
> > -    int32_t sampleVariableSigned;
> > -    float floatVariable1;
> > -} SomeDevice;
> > +typedef struct some_device {
> > +    uint32_t sample_variable_unsigned;
> > +    int32_t sample_variable_signed;
> > +    float float_variable1;
> > +}struct some_device {
> > +    uint32_t sample_variable_unsigned;
> > +    int32_t sample_variable_signed;
> > +    float float_variable1;
> > +}struct some_device {
> > +    uint32_t sample_variable_unsigned;
> > +    int32_t sample_variable_signed;
> > +    float float_variable1;
> > +}SomeDevice;
> >
> > I'm guessing t@p somehow matches three times on the typedef structs...
>
> This is clearly not what we want.  Thanks for the report.

Thanks for looking at this!

> > Does anyone have any tips on how to match both types in definitions, i.=
e.:
> > struct Type {...}
> > and
> > typedef struct Type {...}
> > declarations i.e. Type var; and parameters/function return i.e. Type
> > func(Type var);
>
>
> I think you would want to take care of the typedefs first?  Then you can
> make a rule that does the other structs.

In general I want to handle everything.

> > Plus is there any way to transform arbitrary function names? I'd like
> > to endup with:
> > https://gist.github.com/zackr/c37683157f10b2728dfd3576c88e64f7
> > in a generic way that basically can transform any arbitrary type,
> > function and identifier name.
>
> idexpression x;
>
> is an identifier that is also an expression.  This will cover function
> names and variable references, but not variable declarations.

It doesn't seem to cover function declarations:
-static bool SomeDeviceLocalCompare(SomeDevice *localDevice)
+static bool SomeDeviceLocalCompare(some_device *localDevice)
 {
-    return localDevice->sampleVariableUnsigned =3D=3D
aDevice.sampleVariableUnsigned;
+    return local_device->sampleVariableUnsigned =3D=3D
a_device.sampleVariableUnsigned;
 }
So even with idexpression SomeDeviceLocalCompare doesn't seem to be matched=
.

> identifier x;
>
> Will cover the variable in declarations, but it will also include
> structure field names.  I don't know what you want to do with them.
>
> If you don't want to do structure field names, you can do something like:

I'd like to handle those too. In general almost everything. The only
thing that gets skipped is macros, i.e. anything with only uppercase
latter and underscores, like SOME_MACRO remains as is.

From the sample_case.c I linked before the two constructs I'm having a
hard time matching are function names in definitions and type names in
parameter list, i.e. in
static bool SomeDeviceLocalCompare(SomeDevice *localDevice)
neither SomeDeviceLocalCompare or SomeDevice seem to matched via idexpressi=
on.

Either way, it's not a huge deal. What I decided to do is simply use
Coccinelle for the things it's perfect for, which is all the code
transformations that are easier with semantic understanding. For the
camel case to snake-case I just have a "finalize file" python script
that simply does:
for line in text.splitlines():
        matches =3D re.findall(r'\b[\w_]+\b', line)
        for word in matches:
            if needs_rename(word):
                line =3D re.sub(word, camel_to_snake(word), line)
For now that pipeline is easier to maintain than trying to come up
with a way to match any arbitrary type, parameter or identifier with
Coccinelle.

z

--000000000000e6087c06282920af
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIM4j
KsMT/dC8jlrge/rgCIW0S2EGSGcrNHNRGer2nERtMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI0MTEzMDIyNDkzMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJ
KoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA1pnILFcCb+XjaGDjHidw9
E9dBHXkorsGHf+9bblgyKHcJRKLtpdZrR7n4XI3PDu8KrVkzvk/hr13lhHPhckBqhEkToIQPPL+z
Ul0PULcSjgov8YEqe1at+Aj4VTlh+WS6quo6xg7KgNuC61NVQPsz/E7RKQ2BlAFhK86Jf3kOBAJr
ATPB0hPYJ5Lnr1wHOjyFYut7ATIQk/lm5MO+VMeFadfSIPnVQwff8w29uyW76v/B1JBoSWNvmYM4
j69dKwx4yQNAZUYEz9n+B+G4ll5DDM0BGa/yGo7vljbeEeQOzQvNzWuawEcDsfed59EuyuKfjv0H
PZ0tsBoa98vJNRUj
--000000000000e6087c06282920af--
