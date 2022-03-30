Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5F4C433EF
	for <cocci@archiver.kernel.org>; Wed, 30 Mar 2022 06:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=VJfyV/K+WkAa8SHWm5l3kRcOQEKyBsgKUzf/6D/EAis=;
  b=LUEhBMy8iyKGwfntquhCUEivjRcqsNTSc/kyUensgy2WUEgn6vyTrwqm
   d9pOorunPr+mg3gAHcb0HN8Wo30RK922oMPuZRYeJ3AhWaWsfoMXBhpCz
   BwqsgZ7BwpVKWCgFVHXOE7EWODRqJXGEVmSFViIF8l333KG9SOCG3/3Fs
   8=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@google.com
X-IronPort-AV: E=Sophos;i="5.90,221,1643670000"; 
   d="p7s'?scan'208";a="29007523"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Mar 2022 08:39:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B27C9E7D93; Wed, 30 Mar 2022 08:39:32 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 39FCDE7D80
	for <cocci@sympa.inria.fr>; Wed, 30 Mar 2022 04:33:55 +0200 (CEST)
IronPort-SDR: /hCGRleWg6+RRpWKRLULl4Msv2sqT5hyjkRUkZWqXkw+QRMaXEauqQSn4cejJB6mVWnErryFda
 u6jnJJfUQLfYFSTtCVYeqL+CD0JCV209U3AZNf6SMCqgc4gnIX2G/WvsEfYZWrw5fMeqJXnIWv
 /BftIGDxJoTCPDltpD7FIykgjAG1w18izVjVJ6WRoTJ1f73Y8UPBSCg+7mzc+Q1Bu0lt3h08FR
 yoo3pQJz1+ahwJU4kZg1Daqr59apZX0+u0/AqF05fTqJiuSmgpkC6O7ejAxJWGuun3RFwiRkkG
 EFwbfkO/kkJJbEAZ+86mTzwY
X-IPAS-Result: =?us-ascii?q?A0ANAABQwUNifzWAVdFaHAEBAQEBAQcBARIBAQQEAQGCB?=
 =?us-ascii?q?gcBAQsBgieBKiosBAtEhFSBIYcFhk2CKIsSkVOBJQNUCwEDAQgFQwQBAYUHA?=
 =?us-ascii?q?oRTAh0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQENC?=
 =?us-ascii?q?wkHCAoCBQ4OBT5kaIFPgXQLNA2CNSkBg2QBAQEDEhEdAQE3AQ8LCw0qAgICH?=
 =?us-ascii?q?wESAQUBHAYTIoJjgmUDHhCiYoEEPYsygTGBAYIIAQEGhRMNZ4FVBwkSgSoBg?=
 =?us-ascii?q?VOEPYEnhxInHIFJRIFLgnQ+giFCAoR6gkMimHqBCoJFonmdMWuDU4FBDIQig?=
 =?us-ascii?q?XyBJJBrhXszqEeEdJFpkGyQdoUVECOBPnWBIDMaCBsVbAaCMk4BAgECDQECA?=
 =?us-ascii?q?gMBAgECCQEBAo4dN4M7ims3MTgCBgsBAQMJkWABAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:r2YRxKIGg+cX//PaFE+R7ZMlxSXFcZb7ZxGr2PjKsXjdYENS1DZRm
 jEWUWvSOv/fYDT2foojbdzg80NU6MLdyIVnTgId+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefRLlbFILas1hpZHGeIcw98z0M78wIFqtQw24LhWFjV4
 YqaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhu8lI7
 opy8riMEF0oI6TttrxNdglHKnQrVUFG0OevzXmXtMWSywjZdiKpzag1Sk4xOoIc96B8BmQmG
 f4wcmhcKEDewbvskPTmEYGAhex7RCXvFI8WpHBswjbGJfkhRp/HTuPB4towMDIY3JAfTamAO
 JJxhTxHaCqcURoUEUotU8gfpeShj13zKRhTkQfAzUYwyzGLkFYZPKLWGNHScdeLbd5Em16R4
 GPA5WXwRB8AXOFz0hKA+3Oow/DKxGb1BdlUG7q/+fpnxlaUwwT/FSH6S3OfuMCf1XH5f+4Gc
 U0J8wsA9fgX5FOSG4yVswKDnFaIuRsVWtx1GuI86R2Qxqe83+p/LjhUJtKmQIx23PLaVQDGx
 XfVxo64WmIHXKm9DC3GpufF8FteLABMdTdaDRLoWzfp9DUKTGsbsRvXVtdlH6OvlZXbEDX02
 FhmRwBn3ehC1abnO42d8E+PsjW2pfD0ouMd4wzWWie661o8atP+IYOv7lff4LBLK4Pxori9U
 Josy5b2AAMmV8nleMmxrAMlQujBCxGtbmS0vLKXN8N9nwlBAlb6FWyq3BlwJV1yLuEPciLzb
 UnYtGt5vcEPbCb6NPIrPtLvUazGKJQM8/y1Bpg4ifIeMvBMmPOvoUmCmGbMhzC8yRBy+U3BE
 c7DLJv0ZZrlNUiX5GPuG711PU4DySc5ymfeLa0XPDz2uYdykEW9EO9fWHPXNr5RxPrd+G39q
 o8DX+PXlUg3eLChOkH/rN9LRXhXfCNTLc2n+6R/KLTfSiI4QzpJI6GKkdscl3lNxfs9ehHgp
 SHjBCe1CTPX2RX6FOl9Qi06MOq0B8cm9xrW/0UEZD6V5pTqWq73hI93Snf9VeBPGDVLwaEmQ
 v8bVd+HB/gTGD3L9y5ENcvyq4ttcBntjgWLZnL3bD86dp9mZgrI5t60IVe1pXdWVnK65Zkkv
 rmt9gLHWp5fFQ5sO8DbNaC0xFSrsHlBxe9/BhOaItRadEj23pJtLij90q0+L80WcE2RyTyd2
 AKbRxwfoLCV8YMy9dDIg4GCrpuoQ7QiRBsERzGD4O/vZyfA/2elzYtRa8qyfGjQBDHu5aGvR
 eRJ1PWgYvcJq1BH7thnGLFxwKNiutbiquMIzglgG3mXPV2nBqk6eSuD1MhL87JIn/pX5FDwV
 UWI9d1Xf76OPZq9QlIWIQMkaMWF1O0VymaOt6VreB2i6X8l5qeDXGVTIwKI1H5XIoxzPd532
 uwmosMXt1Gyh0Z4KNqAlSwIpW2AImZaCPciv5AeRZDu008llwoEbpvbBSv7ppqIbowUYEUtJ
 zaVgovEhqhdlhWeKSttTSCV0LoPn4kKtTBL0EQGewaDlO3Di6JlxxZW6zk2EllYwxgvPzif4
 YS325CZ5Jli/guEQOBGVmGoXh5EXViXpxe3xFwOm2nUCUKvUwQh6YH71fmlpCgkH6B0J1C3P
 410DE7qVjHleMy31Sw3MaKgg+K2VsR/r2Uuh+j+d/lo3PAGjf7Njaipam4F7RDgBKvdQaEBS
 fZCpI5NVEEwCcLcT2DXxWVXOXT8hS1o/FB/fMw=
IronPort-HdrOrdr: A9a23:2sg4G6qtUHOvSwj326GyUqYaV5oUeYIsimQD101hICG9vPbo7v
 xG/c5rrSMc7Qx6ZJhOo6HkBEDtewK/yXcx2/hzAV7AZmjbUQmTXeVfBOLZqlWKJ8S9zI5gPM
 xbAs9D4bPLfD5HZAXBjDVQ0exM/DBKys+VbC7loUtQcQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,221,1643670000"; 
   d="p7s'?scan'208";a="28987670"
X-MGA-submission: =?us-ascii?q?MDFcaV2UidxroNqkoupbptom0ld9tRoZSAA4G8?=
 =?us-ascii?q?JiVFCPU5d90KJZOWqJJRULGVhCFgqefR7sPekbCNClsZSfne1rKuL5bj?=
 =?us-ascii?q?u2yT2eCuMpOWAV80MaiNpzW2tJod+uGNWB7wKnHKCfpDfkeLhMz4QiLV?=
 =?us-ascii?q?nxjCvdc2eEUzn1QGaRzqkx0Q=3D=3D?=
Received: from mail-wm1-f53.google.com ([209.85.128.53])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 04:33:39 +0200
Received: by mail-wm1-f53.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso352388wme.5
        for <cocci@inria.fr>; Tue, 29 Mar 2022 19:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VJfyV/K+WkAa8SHWm5l3kRcOQEKyBsgKUzf/6D/EAis=;
        b=g58Wp95yL9hGIZmYf+t/TBv6gXOWHREG7lCYl8p8dy2AQKz9p5u8T78q+heYBj1No9
         rxu1/Jb0heRLDfYSMje3iarIp/l/d/3TNWUBRvYmFTFBqes/Y8wC68Q0mrJdBnaK215M
         hAZsKDbmmwS8cf5k+9/GWtdlCOmtgUrb/VfdLZgX5MZB/cdDDVDSJGcyKP+TKUtqm2Sd
         Je3xKmcQ29ZmPMqLZeoWHhEL29/iTzoD/wX1xvYp9/qBQD+1PzLIyyMoJPKk1rokt+1R
         6k4mKZ4cOctc9Z4yO+KAardqH8P/WjQNECYWmq0Gtn0KORFgPNd/N/BT67yYBN+R1Op7
         KKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VJfyV/K+WkAa8SHWm5l3kRcOQEKyBsgKUzf/6D/EAis=;
        b=7o+wVCrBdrWT6D4607f0/KyLwH8P8Kv3hbS4q5K6ab3uNIoVbjw38PkAqQrVrtOTpb
         /xgFwS1XPwAfadlpy40lrIISRBRAjv8Gm0X8cHtEZXpPxBtbkxUir9g5/EhZWllwrNWm
         mfsaRgkRWWKBzv1HPJYeCF+3R9W2M1oqS9xqMGzsDQKdIKKNoR1rqv8KTq/9gidUviOP
         6R8qpK1ehuDU2ugb7D/J6mvfvUatYWuQMb6gDazFffPN/wC631W9kVUIhbItc0AyB0GF
         5+1n1n3zilVjCS0LLoWkM+xs92ooscSAqV6YfnF7xF240x3yd5CTa82j6yK6lWG/ygD3
         YQlw==
X-Gm-Message-State: AOAM5333/ASYDocXV+Q+YWPwxHbOZrrKvzbVexEGWm+hQ8BnbTcdtfMl
	/jXVFz9cFhTbYDAfkJnjBGUnBnXBtifV8ttlrmfWwQ==
X-Google-Smtp-Source: ABdhPJx0p3YlVcfgQZDaUWH6xoG2F2i9plm2830vRu83fbPpGb+sj1AedTJ//sDT6nzf4GZvo8a5xPbvdQlcplOZOAU=
X-Received: by 2002:a7b:c541:0:b0:38c:b0ed:31c4 with SMTP id
 j1-20020a7bc541000000b0038cb0ed31c4mr2199011wmk.141.1648607618418; Tue, 29
 Mar 2022 19:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648593132.git.marcelo.schmitt1@gmail.com> <9b8233e89227617a2cb47d85c654603c6583323d.1648593132.git.marcelo.schmitt1@gmail.com>
In-Reply-To: <9b8233e89227617a2cb47d85c654603c6583323d.1648593132.git.marcelo.schmitt1@gmail.com>
From: David Gow <davidgow@google.com>
Date: Wed, 30 Mar 2022 10:33:27 +0800
Message-ID: <CABVgOSk7dc_gn14M5Z5WRtHvyFcwrhpmCjf8cE=gypTim9FdPw@mail.gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Daniel Latypov <dlatypov@google.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	linux-sparse@vger.kernel.org, cocci@inria.fr, smatch@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Dan Carpenter <dan.carpenter@oracle.com>, julia.lawall@inria.fr
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007cec1d05db665f02"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 1/2] Documentation: dev-tools: Add a section
 for static analysis tools
Reply-To: David Gow <davidgow@google.com>
X-Loop: cocci@inria.fr
X-Sequence: 311
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/CABVgOSk7dc_gn14M5Z5WRtHvyFcwrhpmCjf8cE%3DgypTim9FdPw%40mail.gmail.com>

--0000000000007cec1d05db665f02
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 30, 2022 at 7:22 AM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Complement the Kernel Testing Guide documentation page by adding a
> section about static analysis tools.
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: David Gow <davidgow@google.com>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> Change log:
> - Brought generic tool characteristics to the intro paragraph
> - Made explicit that these tools run at compile time
> - Added a note of caution about false positives
> - Updated Coccinelle info to make it sound better and be more skimmable
>

Looks better to me: most of the things which I feel are still missing
are added in the next patch.

I think it would be possible to combine the two if you wanted to,
which might make the overall descriptions of the tools a bit stronger,
but this works either way.

This is still
Reviewed-by: David Gow <davidgow@google.com>

-- David

--0000000000007cec1d05db665f02
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
G7p3AiuB2sgfq6cOpbO5MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBsL34EJkCtu9Nu
2+R6l1Qzno5Gl+N2Cm6/YLujukDGYa1JW27txXiilR9dGP7yl60HYyG2Exd5i6fiLDlaNEw0SqzE
dw9ZSIak3Qvm2UybR8zcnB0deCUiwahqh7ZncEPlhnPpB08ETEUtwBEqCEnndNEkIN67yz4kniCZ
jZstNF/BUnI3864fATiXSbnNqBwlJS3YkoaCTpbI9qNTrf5VIvnbryT69xJ6f25yfmxrXNJJe5OG
ncB34Cwnb7xQyk+uRLZ465yUBkbjk9pC/yamL0O7SOGYUclrQl2c5zzGuVBD84YcQGDOK6gSPj6w
QuBfOooZPOyZZZ8AMih7J980MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDJ
QPa2DAGV1L56N90xcIwTWh/m7TNe/V4GYv6RGdg/6zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAzMzAwMjMzMzhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAccQVg7q2QE30EtQxS7V1
pTxBp2qFu2IWhuuMnyjojM2NVsVf4fVERx/rn/dV2/BxpEchf1DnLI5xuMAYV4bCKDLZ0wq6lytn
1LB/oyDhzDR4dhiKPOsdjJntYmA6dOcEbP6jcTKtQr+1YDTf/rszbUQTnYGGD4Btn5Ab4gQA3Zu3
DlXMy1BvthP6UXAO7Ccgkk95SAGtX+oDBD4ZQVupYZ+9vNEFNxsi3bC3j0ZyPYC1qyaM6y/+tZyk
GTF7ZkSu8LOucBCvKUSeoe5ZuBKjy1TQBrFnMDCcv9TkC/ohBF/jtaQ43cwrwZoUiQDIQiBWfOee
oognkJJPpinB3Evdng==
--0000000000007cec1d05db665f02--
