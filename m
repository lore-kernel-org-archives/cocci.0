Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09665C83039
	for <cocci@archiver.kernel.org>; Tue,  1 Jul 2025 08:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ZOkhNz62/BWXIJIfsnLoZBoaONHPlDix9aMY+mbfj6M=;
  b=DcbzHCOw0/uG3IlbcCfNEVVH0c0xyvbpniXyRQy3hILbVDUXfW0G79GJ
   noopwALwTUg4W+N8bXSLnfa7AM11eO7YTZiIz85BSSaYMZS4vPU990gbU
   Yl2op7qz5aCx3ibBKWTyteQ3jCMrCtSemJiHZ/RavX/3t8ZYWNWotYDlX
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208,217";a="229733416"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2025 10:01:13 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CE26AE0CDF; Tue,  1 Jul 2025 10:01:12 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CD71DE0131
	for <cocci@sympa.inria.fr>; Sun, 29 Jun 2025 21:27:31 +0200 (CEST)
IronPort-SDR: 686193a3_MC5JZIbCFrtORIAWv40w86yba5UxkGj9RgiteUOENyqx1j7
 YzVGBWX+0Fa4hUvjYVXH6J5qQRo9hd9iet4nUFA==
X-IPAS-Result: =?us-ascii?q?A0ENAACkkmFofDHdVdFaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBggEDAQEBAQsBgUAxUoEAWjMEVIRVjwwBQ4F0MItHMAKGcIRYe?=
 =?us-ascii?q?YVcgUA9Ag8BAwELAQFPAgQBAQMEOIRIAotyAh4HAQQyBw4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBEAEBBQEBAQIBAQIEBgECEAEBIhkHDhIphXsNgmIBgSRhAgUDOwEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCLF8BAQECARIRH?=
 =?us-ascii?q?QEbHQEDAQsGAwIJOQICIhEBBQEcBhMbB4JgAYIhAQYQAQMOJAMBlXSPQIEFQ?=
 =?us-ascii?q?os+gRUFAhaBAYINBtpfChkoDW0DgWICBwkBCoE1AYR1KVyCVgEqgTMCDod8e?=
 =?us-ascii?q?ieBY0WBPAuBCYFvPogegmkEgiKBAhQdgjqCI4Z8jDkBBwcxCQkTBggCAkgFE?=
 =?us-ascii?q?BIDBAMEBAECCwkKCQMDAg4CCAMCCAYZAT8MBgQVCAkPDB8KAggEEQooIgQOK?=
 =?us-ascii?q?woDWxUFGwgGAgIEBAIEAgoCCQICBQMEAgQNAwQBAQgCAgMqBAMGGwkIAgsFF?=
 =?us-ascii?q?BYCDAQHBzIDEgEICgYDBgMEAgICCwcCAwMDBwELCwkCAQMCAgUCAgEFAwICC?=
 =?us-ascii?q?AMCAQEJAgMCCAECAgECAgIEAQcBDQEBAgQCAiQCAQMIBgEBDQICBAICAQICA?=
 =?us-ascii?q?gQCBAECBgsECAEBAgECAgEBAQQBCAMBAQICAwMFAwUIDw0BFQsZAwQFAgISA?=
 =?us-ascii?q?gIBBwECAQEDGQIBAwMEAQsCAQEEGwQXAhYkAhkCAQUFBQEDBAsQCQMCBQQCA?=
 =?us-ascii?q?gYCBA4CBwQCGgQCAgEDBAYDAQIIAgIHBAQGAwECAgcXAgQRAQIBAwICAgkKB?=
 =?us-ascii?q?AUEAwQDAgICAQwDAQIDAgIBAgEBAwEFBg0SAgEDDwgEAgIHAgIhDwsBAgEBB?=
 =?us-ascii?q?gYDAwMKAwEKAQEGAgECEgUCAgIEAQICBgQlAQIBAgEBAQUCAQIBAgQCBwIBA?=
 =?us-ascii?q?gsBBQIGAQICCQECAQICAgECAQECBgIBFQECAgICAgMBAwYCAgICAgIJAgICA?=
 =?us-ascii?q?gUCBQMCAwUCBQIDAwICAwQDCQMDCAMGBAIDAQEBAgECAgIBAgEFAgMJAQEDA?=
 =?us-ascii?q?gECAgICAwYCBQUBAwsFCQEBAgEDBQMDBAMGAQYHBAMCBAICAgIEAgEFAwMCB?=
 =?us-ascii?q?QELAQIEAgEDAwMEBAMBAgIKBwUCBAEBAQECAQICCgMCBQEDAwERAwQBBgUFB?=
 =?us-ascii?q?gIHCQMCAgMCAwIEAwkEAgQDAwICAgEBCgICAQIBAQMDBwYQAQICAgEPAgMDB?=
 =?us-ascii?q?AMEBgMFCQEDBwEBAQEBAhQDAgQBBBEGBAIBAR4BFQIHAQQDJx4CAgIHAQICA?=
 =?us-ascii?q?gIDAgIDAwMBAgEBAgMFAQMCAgMCAQIBBgIDAwMCBQMBCQUCAgMBAwEFAQQEA?=
 =?us-ascii?q?gcBAgICDgEDAgIJAgcJBAQCARMTAgICAgECAgECBwEBAgMCBQUIAgEBAQICA?=
 =?us-ascii?q?wILAgIBAgECAgMCAwIGAQkIBgECAQEFBAMDBwIDJAMDBAUDAgICAgcCBAMZA?=
 =?us-ascii?q?g0GAQQDBQMFAwgDBgICAw8DBwYHAgcEAgQCAgICDAQCAwMHBQICAgIEAQENB?=
 =?us-ascii?q?AcBAQMCAhIDAQEBAhQCCQMjDwIBFAgTPQwHLgQEDCoBCQsUBwYlgQAQkQhbg?=
 =?us-ascii?q?mNEgQ+CS4EvAQEBlgWvCDsJAQYCYIFngQoVCi2hWQZVlzmTFi6HZZByo1YRB?=
 =?us-ascii?q?DGEdQIEAQEBAwcHESQSgTgBM4FccIFugUlPAxkPjiGEAL0TQTU8AgcBCgEBA?=
 =?us-ascii?q?wmFaYdrgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vKQD7TSyahLxI29GFFb9OnRx69Mbw==
IronPort-HdrOrdr: A9a23:tXPlnql0F2ffC8sS2dCg22wWdxvpDfLi3DAbv31ZSRFFG/FwWf
 re+8jztCWE9Ar5PUtLpTnuAtjjfZqxz+8R3WBVB8baYOCEghrUEGgB1/qF/9SIIUSXnZ8/6U
 4jSdkHNDSZNzhHZK3BkXKF+rgbsb262ZHtq+Ob4XkFd25XgmJbgzuRyDz3LqS7fmd7LKt8L5
 aV68dDq36FdW4MZsq2QlkpNtKz3eEjXaiGXSI7
X-Talos-CUID: 9a23:/M/jIG6W4sqrLAlHBtssymQsHd8vcEHh8FDqHEaSKkVEWr+eVgrF
X-Talos-MUID: 9a23:kTPoNAQz39zUXJy1RXSwugFTOeRk5Z3+UngdrpMapdOjLQdZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,276,1744063200"; 
   d="scan'208,217";a="120233909"
X-MGA-submission: =?us-ascii?q?MDGi11uztu47xDoK7GpwWu77wTYFIfqB28kBXy?=
 =?us-ascii?q?zBNAqOGGEUicpZF/cCzqzEBRb2Br0c/6MJP9QSH3NLSEg96N1AMWsGBJ?=
 =?us-ascii?q?CJ4TYNei2zoW/9mkR3RWi++IL8j7lt1I8IUXzPQC8iEdP3rPAt84902x?=
 =?us-ascii?q?YEeDtIT7D30rMecZhW8H4kgw=3D=3D?=
Received: from mail-wr1-f49.google.com ([209.85.221.49])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 21:27:31 +0200
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso1160256f8f.1;
        Sun, 29 Jun 2025 12:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751225250; x=1751830050; darn=inria.fr;
        h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOkhNz62/BWXIJIfsnLoZBoaONHPlDix9aMY+mbfj6M=;
        b=fXUhAsTw1rXaBvsNMskyoP0p+543IM6dsyeP6n4QU8ntI403BVhxmQbr7KR+2IwWQ8
         lItwgaz4bFmQRCfI2ez6aB0a/Qib7SCDfXpVMCU+Ns55pBqoA+e8lZCKJwu9KqPsIgZ2
         ojhNu/Q0lXadtwLlYdLO8/a3kwLLFhxgZ/wblAvfgpiEdO5pneP/bhyUpQ+as0cr4BEk
         z4u80DlpCKhw/DpZHbjPQfAHQ/JPotmF8OjFXX21rCKmf4u8/cR2H7hqthtlgYwcmaY8
         MTQ9SxMCBN9tjeZLLQv2CB0iB1HU4kQ1z8aM7UmlJy3NecfZcmZqCwnBglh4zjNkDw+A
         0oWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751225250; x=1751830050;
        h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOkhNz62/BWXIJIfsnLoZBoaONHPlDix9aMY+mbfj6M=;
        b=F/AMnZi0PHnd6GtGFw/tlsP+P+JIbTPB5Vr9YQdWMSDqGb8V4g9D536R81oKNyIFJ8
         gWWRKbJmjJfaA0xjrO1fKCgV09hlF6ZTuuLulOPji7s8rhhgG9NkfVEcAae3N7DweLFG
         Nib6k9TZ/iy0lKzC7kjSkVwbKQO/wQsMk+qkmYSa6mitH1yG7q8KY4c/sngtdV20PcXr
         krAbJL04yARhg+cGafF9phQcSM9+RKADkSMy9rIOGDWvTSE4Fl+g3Hs5LkAeAiCgCE4C
         nEnKqipEjxY83Rw+SZrwliJvzjQV4ku9Z6TyFbQp0l7uUPU3Pi1Cc9kC+R+WY/Cavqdj
         c5QQ==
X-Gm-Message-State: AOJu0YxzBxmQd8fyVxSSuRzmJXQkHiIlhDkpwq/jZ7Cwqz0Nymdcy5Qi
	R8FNc2A+mmg6Yebsu/xfDq2y3cTPrnew0XHwboSB/UinpSHllaq4dqIM5ybQKw==
X-Gm-Gg: ASbGncvyBxwg7zBF2MmI6/Iz1XS4v0pogo6/pdJrwGyWKeX30iAulyESfL2utBplImF
	NczPgav+20opraUdS3j9+MottOGYA91guJgeJkEbZ1MDvF3AaKKJBE1VylzgKLhJ7a8+LD0t5k6
	7D/Yz9WoI2sH2Xe3wxiu+uce4h1oAIo5bHVqqeo8HZoSLCUq3v/rRlfh08BnPmkZZpkHxZ0QxYZ
	uVo6HNvI/u7WNgAy/hY2iLNQdqIybHGvJCCpim7p1zKDsGtJxY4xj83HLcnKPm6SU6fJ64/hzzt
	UseKb3qjb7DVo2xxKin8sNuJxGF/xivUSmjKZ8lbamVGMDJ3X+r6WPiBgtknK8w/JavS9V+czv0
	v5l4CvgVGjyDN5plbXOy48QY2TIzyc0mfNA==
X-Google-Smtp-Source: AGHT+IFN5S04u/DK1T95LviPBSdh3UeAmoRkE7ECOu941FstYOXS2tpalamsMasL6aLbcvFjRNnchQ==
X-Received: by 2002:a05:6000:26c4:b0:3a6:d7e9:4309 with SMTP id ffacd0b85a97d-3a8fdeff965mr9652295f8f.29.1751225250149;
        Sun, 29 Jun 2025 12:27:30 -0700 (PDT)
Received: from [2a04:ee41:3:2418::ffff] ([2a04:ee41:3:2418:ec97:de8:ed49:4bc4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a390bf8sm115612325e9.4.2025.06.29.12.27.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jun 2025 12:27:29 -0700 (PDT)
Date: Sun, 29 Jun 2025 21:27:23 +0200
From: devnoname120 <devnoname120@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <1a234d32-e87d-414b-8566-490618417f6c@Spark>
In-Reply-To: <alpine.DEB.2.22.394.2506292109470.95572@hadrien>
References: <7c65be39-dfc3-4b9c-9acd-dd94d1225db8@Spark>
 <alpine.DEB.2.22.394.2506291925100.95572@hadrien>
 <55f3b1f1-2537-4bc3-88d3-d7da1136060a@Spark>
 <alpine.DEB.2.22.394.2506292109470.95572@hadrien>
X-Readdle-Message-ID: 1a234d32-e87d-414b-8566-490618417f6c@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="686193a0_6eb5bd4_1255"
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [HELP] Using macro `randomized_struct_fields_end` as
 context?
Reply-To: devnoname120 <devnoname120@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2827
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/1a234d32-e87d-414b-8566-490618417f6c%40Spark>

--686193a0_6eb5bd4_1255
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Unfortunately this solution adds it to the very end of the task=5Fstruct =
struct.

=40r depends on file in =22include/linux/sched.h=22 exists=40
field f;
=40=40

struct task=5Fstruct =7B
...
f
=7D;

=40=40
field r.f;
=40=40

struct task=5Fstruct =7B
...
f
+=23ifdef CON=46IG=5FKSU=5FSUS=46S
+ u64 susfs=5Ftask=5Fstate;
+ u64 susfs=5Flast=5Ffake=5Fmnt=5Fid;
+=23endif
...
=7D;


=E2=9D=AF spatch --sp-file include/linux/sched.h.cocci --in-place --linux=
-spacing include/linux/sched.h
init=5Fdefs=5Fbuiltins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coccine=
lle/standard.h
SPECIAL NAMES: adding u64 as a type
HANDLING: include/linux/sched.h
diff =3D
--- include/linux/sched.h
+++ /tmp/cocci-output-56533-5a9482-sched.h
=40=40 -1471,6 +1471,10 =40=40 struct task=5Fstruct =7B

=C2=A0 =C2=A0 =C2=A0 =C2=A0/* CPU-specific state of this task: */
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct thread=5Fstruct =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0thread;
+=23ifdef CON=46IG=5FKSU=5FSUS=46S
+ =C2=A0 =C2=A0 =C2=A0 u64 susfs=5Ftask=5Fstate;
+ =C2=A0 =C2=A0 =C2=A0 u64 susfs=5Flast=5Ffake=5Fmnt=5Fid;
+=23endif

=C2=A0 =C2=A0 =C2=A0 =C2=A0/*
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * WARNING: on x86, 'thread=5Fstruct' contains=
 a variable-sized


It needs instead to be added right above randomized=5Fstruct=5Ffields=5Fe=
nd, which is what closes the anonymous struct.

Thank you,
Paul
On Jun 29, 2025 at 21:18 +0200, Julia Lawall <julia.lawall=40inria.fr>, w=
rote:

> Coocinelle has a file standard.h thta gives dummy definitions for some
> macros.
>
> This file already contains
>
> =23define randomized=5Fstruct=5Ffields=5Fstart
>
> So it seems quite reasonable that it should also contain
>
> =23define randomized=5Fstruct=5Ffields=5Fend
>
> which then enables sched.h to parse.
>
> With that change, you can use the following solution:
>
> =40r=40
> field f;
> =40=40
>
> struct task=5Fstruct =7B
> ...
> f
> =7D;
>
> =40=40
> field r.f;
> =40=40
>
> struct task=5Fstruct =7B
> ...
> f
> + int something;
> ...
> =7D;
>
> That is, first match the last field in the structure. Then inherit thta=

> field into another rule and place the new stuff after it. The final ...=

> is important to force the added code to be attached to f. This will kee=
p
> it on top of the end marker, and on top of the associated comment as we=
ll.
>
> julia
>

--686193a0_6eb5bd4_1255
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<div>Unfortunately this solution adds it to the very end of the task=5Fst=
ruct struct.</div>
<div>&=23160;</div>
<div style=3D=22color:=23000000;font-family:Menlo, Monaco, 'Courier New',=
 monospace;font-size:12px;font-weight:normal;=22><span style=3D=22color:=23=
e50000;=22>=40r depends on file in =22include/linux/sched.h=22 exists=40<=
/span></div>
<div style=3D=22color:=23000000;font-family:Menlo, Monaco, 'Courier New',=
 monospace;font-size:12px;font-weight:normal;=22><span style=3D=22color:=23=
af00db;=22>field</span> <span style=3D=22color:=23e50000;=22>f;</span></d=
iv>
<div style=3D=22color:=23000000;font-family:Menlo, Monaco, 'Courier New',=
 monospace;font-size:12px;font-weight:normal;=22><span style=3D=22color:=23=
e50000;=22>=40=40</span></div>
<div>&=23160;</div>
<div style=3D=22color:=23000000;font-family:Menlo, Monaco, 'Courier New',=
 monospace;font-size:12px;font-weight:normal;=22><span>struct task=5Fstru=
ct =7B</span></div>
<div><span>...</span></div>
<div><span>f</span></div>
<div><span>=7D;</span></div>
<div><br />
<span style=3D=22color:=23e50000;=22>=40=40</span></div>
<div><span style=3D=22color:=23af00db;=22>field</span> <span style=3D=22c=
olor:=23e50000;=22>r.f;</span></div>
<div><span style=3D=22color:=23e50000;=22>=40=40</span><br />
&=23160;</div>
<div><span>struct task=5Fstruct =7B</span></div>
<div><span>...</span></div>
<div><span>f</span></div>
<div><span style=3D=22color:=23098658;=22>+=23ifdef CON=46IG=5FKSU=5FSUS=46=
S</span></div>
<div><span style=3D=22color:=23098658;=22>+ u64 susfs=5Ftask=5Fstate;</sp=
an></div>
<div><span style=3D=22color:=23098658;=22>+ u64 susfs=5Flast=5Ffake=5Fmnt=
=5Fid;</span></div>
<div><span style=3D=22color:=23098658;=22>+=23endif</span></div>
<div><span>...</span></div>
<div><span>=7D;</span></div>
<div><br />
<br />
<span>=E2=9D=AF spatch --sp-file include/linux/sched.h.cocci --in-place -=
-linux-spacing include/linux/sched.h</span><br />
<span>init=5Fdefs=5Fbuiltins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/c=
occinelle/standard.h</span><br />
<span>SPECIAL NAMES: adding u64 as a type</span><br />
<span>HANDLING: include/linux/sched.h</span><br />
<span>diff =3D&=23160;</span><br />
<span>--- include/linux/sched.h</span><br />
<span>+++ /tmp/cocci-output-56533-5a9482-sched.h</span><br />
<span>=40=40 -1471,6 +1471,10 =40=40 struct task=5Fstruct =7B</span><br /=
>
<br />
<span>&=23160; &=23160; &=23160; &=23160;/* CPU-specific state of this ta=
sk: */</span><br />
<span>&=23160; &=23160; &=23160; &=23160;struct thread=5Fstruct &=23160; =
&=23160; &=23160; &=23160; &=23160; &=23160;thread;</span><br />
<span>+=23ifdef CON=46IG=5FKSU=5FSUS=46S</span><br />
<span>+ &=23160; &=23160; &=23160; u64 susfs=5Ftask=5Fstate;</span><br />=

<span>+ &=23160; &=23160; &=23160; u64 susfs=5Flast=5Ffake=5Fmnt=5Fid;</s=
pan><br />
<span>+=23endif</span><br />
<br />
<span>&=23160; &=23160; &=23160; &=23160;/*</span><br />
<span>&=23160; &=23160; &=23160; &=23160; * WARNING: on x86, 'thread=5Fst=
ruct' contains a variable-sized</span></div>
<div>&=23160;</div>
<div>&=23160;</div>
<div>It needs instead to be added right above <span>randomized=5Fstruct=5F=
fields=5Fend, which is what closes the anonymous struct.</span></div>
<div>&=23160;</div>
<div><span>Thank you,</span></div>
<div><span>Paul</span></div>
</div>
<div name=3D=22messageReplySection=22>
<div>On Jun 29, 2025 at 21:18 +0200, Julia Lawall &lt;<a href=3D=22mailto=
:julia.lawall=40inria.fr=22>julia.lawall=40inria.fr</a>&gt;, wrote:<br />=

&=23160;</div>
<blockquote style=3D=22margin: 5px 5px; padding-left: 10px; border-left-w=
idth: thin; border-left-style: solid; border-left-color: =231abc9c;=22>
<div>Coocinelle has a file standard.h thta gives dummy definitions for so=
me<br />
macros.<br />
<br />
This file already contains<br />
<br />
=23define randomized=5Fstruct=5Ffields=5Fstart<br />
<br />
So it seems quite reasonable that it should also contain<br />
<br />
=23define randomized=5Fstruct=5Ffields=5Fend<br />
<br />
which then enables sched.h to parse.<br />
<br />
With that change, you can use the following solution:<br />
<br />
=40r=40<br />
field f;<br />
=40=40<br />
<br />
struct task=5Fstruct =7B<br />
...<br />
f<br />
=7D;<br />
<br />
=40=40<br />
field r.f;<br />
=40=40<br />
<br />
struct task=5Fstruct =7B<br />
...<br />
f<br />
+ int something;<br />
...<br />
=7D;<br />
<br />
That is, first match the last field in the structure. Then inherit thta<b=
r />
field into another rule and place the new stuff after it. The final ...<b=
r />
is important to force the added code to be attached to f. This will keep<=
br />
it on top of the end marker, and on top of the associated comment as well=
.<br />
<br />
julia<br />
&=23160;</div>
</blockquote>
</div>
</body>
</html>

--686193a0_6eb5bd4_1255--

