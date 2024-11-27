Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20072D6D248
	for <cocci@archiver.kernel.org>; Wed, 27 Nov 2024 23:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Yth6qd/RwWvR5hC8TOMqbvr4OOwRNP4FtiI/dC3hnfk=;
  b=NsvQ+XnFaHqfjYxY+uTCaTQNoz1Y///nEti81GrDf+ZHLG8ecoljmK3v
   AmpeNX/LzE0j43JF7Xj3zPY/En66mTnfxWJP6gIewfScrQh7om42x7+eu
   76hJV7h2cLFw8bdD0t4K/dJPvXj8DNsGB9fx2T8UyHkCMWxiDUwJ7t8dH
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.12,190,1728943200"; 
   d="scan'208";a="196185911"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Nov 2024 00:17:12 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F27D1E0D1D; Thu, 28 Nov 2024 00:17:11 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 825BEE00B6
	for <cocci@sympa.inria.fr>; Thu, 28 Nov 2024 00:17:08 +0100 (CET)
IronPort-SDR: 6747a873_L/dEa45X3cUsoKItsmQDoFG6aB1bKFUhc8U7rdemdklfSDF
 YKQiHe9lvo2UgyPBJhQZ2YZ45CHHuuJiIFHRgkg==
X-IPAS-Result: =?us-ascii?q?A0EPAAAxp0dnj9lUsotaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YJDfVozBAtIhFaDT4ROX4hyA5MeinmBfg8BAwENMRMEAQEDAQOFAAKKYwIeB?=
 =?us-ascii?q?wEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBAQE5B?=
 =?us-ascii?q?UmFQQY0DYJiATNxgSUBAQEBAQEBAQEBAQEBHQINfQEBAQECASMdAQE3AQ8LC?=
 =?us-ascii?q?wMKAgImAgIhEwUdBhODAQGCQSMDsRh6gTKBAYIMAQEGgQjbF4FkCYEaLgGFa?=
 =?us-ascii?q?YJiAYFsg30bg2J6JxuBSUSBSoEGbUo4PoRDFYNGgmmBFIEwZ1OCX3YlTYRpg?=
 =?us-ascii?q?j2BDYN+iDt4HoRPgSqIJCYJHQMHBw4NHkkPBRwDWSERAVUTFwsHBWBJISwBA?=
 =?us-ascii?q?gGCRn+BNoFRAYMQSoMuHIFCBTcKPYJKaUs3Ag0CNoIkfYJNhRmBC4EVgklMG?=
 =?us-ascii?q?S8DAwMDgzyGMD0dQAMLYgs9NxQbTKFCAUaDSwF7EwEbgSsyKxsBCykykmqSF?=
 =?us-ascii?q?ot0lQ+EJIFjijOVRzOFW5Fokw6WG4Jgo1qFToFnOoFcMxowdAaCMAlGAxkPj?=
 =?us-ascii?q?A6CExkfgmSFcsNUNDU7AgcBCgEBAwmGSIsAgUsBAQ?=
IronPort-PHdr: A9a23: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
 UJg/A==
IronPort-Data: A9a23:cNRnuKvLgnHcGVS12N4qJPQyz+fnVL1aMUV32f8akzHdYApBsoF/q
 tZmKW6PbqrfN2WjeNgiO4u18UlT7MCEz9ViSQVtrSFkQXsTgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRNscpvlDs15K6u4WpC4QRlDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJBEEDaQa/t5+ODtT5
 KIyIhARbS+8g9vjldpXSsE07igiBMXlI8UEvWx6xjyfDvs8R53HBaLQ6re03h9p3ZEIRKmOI
 ZpFL2A2M3wsYDUXUrsTIJc3h+6oh2P4YhVbpUiTqK5x5HLcpOB0+OG8boOFJ43SG625mG6ho
 HOB1HTQUipdPc2ClGfeqk+9qvPQyHaTtIU6T+DgqK412TV/3Fc7AxodXlqTuui8kkf4WtRFK
 kVS9DBGkEQp3EClUZ/mWACiq3PCvRMGXddUVeog52lh15Y4/S7JNFgtTDp5YeV8qd5obzYKy
 ly2oNfQUGkHXKKudVqR8bKdrDWXMCcTLHMfaSJscefjy4e+yG3UpkySJuuPAJKIYsvJ9SYcK
 g1mQQAyiapVlskWza62u1PKmTShot7OVAFdCuTrsoCNsV8RiG2NPt3ABb3nARBocNvxor6p4
 CNspiRmxLpSZaxhbQTUKAn3IJmn5uyeLBrXikN1Ep8q+lyFoiH4J94MvWEvfRgwbK7onAMFh
 meN5Gu9A7cNYROXgVNfOtLsYyjX5fm6TIq9PhwqRocQOcUZmPC7ENFGPhPIgTCyySDAYIkyI
 Iqad8e8RW0XE7pmxzetD+Yb2vlD+8zN7T27eHwP9Dz+ieD2TCfMEd8taQLeBshnt/nsiFuOr
 L5i2z6il043vBvWPnKPqdZ7wJFjBSRTOK0aXOQMKbbeeFM9ST16YxITqJt4E7FYc21uvr+g1
 hmAtoVwkTITXFWWeVvYWWMpc771Q5d0oFQyOCFmbx7i2GEubczrpO0Tfoc+N+tvvuFy7+9Gf
 99cceW5A9NLVmvm/RYZZsLDt4BMTkmgqj+PGCuHWwIBWaBcaTbHwOK5QTu3xhIyVnK2keAcv
 4yf0hjqRMtfZgZ6U+fTRvGd73Kwmnk/gtBCfVb6HcZOch7O9qlrNC3DofslKO4cKRj452W71
 iTHJTw6tOXys4sO392Rvp+9rqCtCLFYDGdBOmvmsYaNKijR+1S8zb96UOqneS7XUEX28v6AY
 dp54u7dMvpdunp3qKt5TqhWyJwh6+vVp7N1yhpuGFPJZQ+JDpJiOny34tldhJZSx7N2uRqEZ
 WzXw4N0YY62AcLCFEIdACEHbe7ZjPEdpWT03MQPeU7/4Hd6waqDXUBsJCKzsS16LoZuEYYb0
 Owk6d836Qu+t0IQCey4rBtorkaCEn9RdJ8clMA+IJTqgQ8V2F19ccTiKivp0qquNfRIEGcXe
 wGxuoSTpo5y5ET4d1gLKUPsxstY3JQHhwBLxgQNJnOPgdv0ucU01xxwrxUyUgBey0hD2ckuJ
 GNuPExRDoeN9gdOm8JscT2NGQZAJRvB4W336QIDu1P4RnmSdF7mDTMCK9fW2XsG4kRgfjR/1
 5OJ+lbPCDrFUpn44XovZBRDtffmc+1UyiTDv8KWR+K+AJgwZGvesJ+EPGYnhUPuPpIsuRfhu
 +JvwedXbJ/7Pw42p4kQKdGT9ZYUeSC+CF1ye9NT14JXIjiEYxC34yaEFG6pcMAUJ/Dqz16xO
 /YzGu1xDSaBxAS8hRFFI5UTIo1Evu8jv/sDXbLJGVQokZWiqhhRjZaB0RSm2UEKRY11nNcfO
 7HhUWuIMlatiEt+n07Pq8h5OVSEX+QUWT2k3M6J3bUIM7khrNBTdVoD1+ronneNbypi0RGmn
 CLCQK70zN5kwplnxdq1GaBlAyGxNdf4UbmM+ivurd9LZtLrGuXNvjMztVPIEVl3P7wQetIvj
 pWLkof9833ktYYMcVLyuse+BZgSwP6tTcxrMs7TB1tLrxuoAcPDzUMKxDGlFMZvjthY2PiCe
 yK5T8mBLfguRNZXwSxuWRh0ShoyJfz+Ufb9mHmbsf+JNxk61D7HJvOB8VvCTzlSVg0MCq3EJ
 j7EgdSczfEGk90UHz4BPe9sPLFgKly6WacGScz4hQPFMkaW2GG9qpnQvjt+zwrUC0u0Mtfwu
 rPEYRncSC6cmo/1yPNhjogjmSFPUVhch7A8cHtIrpQyw3q/AXUdJOsQDYQeB9sG2mbu3ZX/f
 3fWYHFkFSz5Wi9efA7h5Mj4GD2SHfEKJsyzMwlBE5l4sMtqLNjo7HpdGiZcD7NedjX8ivqgN
 MsV9zvzMwK3z5UvQvwcjhB+bSGL2duCrk/kO2ik+yAxP/raKbYHznpsGExKTyOv/wTlihDQP
 WZsLYxbaBjTdKMyePqMv1ZWFQsfsTepyC8nBctKLBAzpK3DpNB9JDbD1y0fH1HNgAnm5FLDe
 J8ve1aw3g==
IronPort-HdrOrdr: A9a23:9ZdoV6P5+8NCacBcTj6jsMiBIKoaSvp037Dk7TEKdfUzSL3lqy
 nOpoVn6faQslsssR4b6Le90cW7MBfhHNtOkOws1NSZLWrbUQmTXfhfBOLZqlWKcUHDH6xmpM
 VdmsNFeaXN5DZB/L3HyTj9PNA63tGd/aykwcvYxWx8VBxnZshbgDuRyTz0LmRGACdDDZo9UL
 yG5sRGoDKkPVAadN6yCHVAf8WrnaysqHsrW3877tcciDWzsQ==
X-Talos-CUID: 9a23:sNtNRW9AFI6YNRGlYkOVvx4mKukndkXU9S3NMhGSA0Z1S4KqTWbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AJHPfnw8qNmF+28/gTwek1oiQf/5u8uOFGGldqtI?=
 =?us-ascii?q?PqtTZaHcoBiaxkCviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,190,1728943200"; 
   d="scan'208";a="196185906"
X-MGA-submission: =?us-ascii?q?MDE3xcJqDNBSlxKgi9lKEwq4LZ5HrVufWh38MW?=
 =?us-ascii?q?ZHATsHDdZynA6yCOA/dK8QrctcJhYyh44GSwcryLP3GZvwKt67GF8zy8?=
 =?us-ascii?q?7IC59nU+trwU5SyK1oCY8K3REVrSAqvDnzUpdbafAmJM/10hDGSMdIKM?=
 =?us-ascii?q?FkxsvegxYLM2JR8bPSh7YSuA=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 00:17:07 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9AEE75C4609
	for <cocci@inria.fr>; Wed, 27 Nov 2024 23:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B8FC4CED4
	for <cocci@inria.fr>; Wed, 27 Nov 2024 23:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732749364;
	bh=6Qu8uz2fjJ8iZDLh3BxDKj48BBZNQb8qilSVdb8Tki8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MMedw67Is8BjeF2fb0WoMSDFzZCeWmp6Vbpkb7p2BGIOVy6rMvlZNKKYTLPU/LGRs
	 55pdufL8AJR8lza9cmnNMbGR1JNtl2x0/eZRh94bC5Jn6hmlNzsYBqpveJ/53u/N14
	 +JTJR0+sI9vcUG81a18A2+0RVeeCC6UR8BGHpdcdZDEo42EMQImEdvJVgGG0oMnTP9
	 PLw7A+lvA5lTZ8U1SUTS5zxp1iObfK6u46wDH8BT+nVwegDCHK3/GuJJtFnpnks/Vh
	 ZD+JEeUtTX6cp/AfdkG60JhkeXkiWMmQVjW09d6zvBK56sxOiyXu/yjBf1Z6fV2MKv
	 vIDVmX2AmiKCw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53dde5262fdso208382e87.2
        for <cocci@inria.fr>; Wed, 27 Nov 2024 15:16:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVhQozzBhKA9yIa+C5SjgG1XYUwVZ6nPrM6O7exaG1ExcnNdBwm67C9KSzSUvjBEBeMdgoIFA==@inria.fr
X-Gm-Message-State: AOJu0YyU+/1qLGX2tsJHnWsYRgt8zpydExLAubDClzLeAceRlBqDgTc1
	ubT1CLGrjSkRM58qEhBW3kRcYRBqSN/5lXW0wrX1kHP1NZPS4DZ7euR4QQiYea+VL22ALMb5Drj
	7/T+0XaXvmLH02g4KyFujZRswhWQ=
X-Google-Smtp-Source: AGHT+IEyHrrQl9hSawuoz0PS/8OAj87EVIxpEAzyG91hApou/NM0qZq5mVbPvsbR4lHlrb58foootrE9HBCMQu5cAyE=
X-Received: by 2002:a05:6512:400f:b0:53d:a93c:649e with SMTP id
 2adb3069b0e04-53df0109024mr3254947e87.35.1732749363227; Wed, 27 Nov 2024
 15:16:03 -0800 (PST)
MIME-Version: 1.0
References: <20241110013649.34903-1-masahiroy@kernel.org> <20241110013649.34903-6-masahiroy@kernel.org>
 <20241118-dazzling-gifted-bettong-133eb7@buildd> <CAK7LNATomVVvxHgy=e7rwq7EPgP7Z2UUERkyDJGQe63n6BuW3Q@mail.gmail.com>
 <20241127-maize-hippo-of-innovation-ad1c54@buildd>
In-Reply-To: <20241127-maize-hippo-of-innovation-ad1c54@buildd>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 28 Nov 2024 08:15:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ5zkcFwLpbLxKa2C_RFCOHmTZsRi-DPEmR7Rc2uXCPCg@mail.gmail.com>
Message-ID: <CAK7LNAQ5zkcFwLpbLxKa2C_RFCOHmTZsRi-DPEmR7Rc2uXCPCg@mail.gmail.com>
To: Nicolas Schier <n.schier@avm.de>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] [PATCH v2 05/11] kbuild: change working directory to
 external module directory with M=
Reply-To: Masahiro Yamada <masahiroy@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2137
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/CAK7LNAQ5zkcFwLpbLxKa2C_RFCOHmTZsRi-DPEmR7Rc2uXCPCg%40mail.gmail.com>

On Thu, Nov 28, 2024 at 12:29=E2=80=AFAM Nicolas Schier <n.schier@avm.de> w=
rote:
>
> On Tue, Nov 19, 2024 at 02:02:05AM +0900, Masahiro Yamada wrote:
> > On Mon, Nov 18, 2024 at 11:47=E2=80=AFPM Nicolas Schier <n.schier@avm.d=
e> wrote:
> > >
> > > On Sun, Nov 10, 2024 at 10:34:33AM +0900, Masahiro Yamada wrote:
> > > > Currently, Kbuild always operates in the output directory of the ke=
rnel,
> > > > even when building external modules. This increases the risk of ext=
ernal
> > > > module Makefiles attempting to write to the kernel directory.
> > > >
> > > > This commit switches the working directory to the external module
> > > > directory, allowing the removal of the $(KBUILD_EXTMOD)/ prefix fro=
m
> > > > some build artifacts.
> > > >
> > > > The command for building external modules maintains backward
> > > > compatibility, but Makefiles that rely on working in the kernel
> > > > directory may break. In such cases, $(objtree) and $(srctree) shoul=
d
> > > > be used to refer to the output and source directories of the kernel=
.
> > > >
> > > > The appearance of the build log will change as follows:
> > > >
> > > > [Before]
> > > >
> > > >   $ make -C /path/to/my/linux M=3D/path/to/my/externel/module
> > > >   make: Entering directory '/path/to/my/linux'
> > > >     CC [M]  /path/to/my/externel/module/helloworld.o
> > > >     MODPOST /path/to/my/externel/module/Module.symvers
> > > >     CC [M]  /path/to/my/externel/module/helloworld.mod.o
> > > >     CC [M]  /path/to/my/externel/module/.module-common.o
> > > >     LD [M]  /path/to/my/externel/module/helloworld.ko
> > > >   make: Leaving directory '/path/to/my/linux'
> > > >
> > > > [After]
> > > >
> > > >   $ make -C /path/to/my/linux M=3D/path/to/my/externel/module
> > > >   make: Entering directory '/path/to/my/linux'
> > > >   make[1]: Entering directory '/path/to/my/externel/module'
> > > >     CC [M]  helloworld.o
> > > >     MODPOST Module.symvers
> > > >     CC [M]  helloworld.mod.o
> > > >     CC [M]  .module-common.o
> > > >     LD [M]  helloworld.ko
> > > >   make[1]: Leaving directory '/path/to/my/externel/module'
> > > >   make: Leaving directory '/path/to/my/linux'
> > > >
> > > > Printing "Entering directory" twice is cumbersome. This will be
> > > > addressed later.
> > > >
> > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > >  - Introduce a new 'srcroot' variable and clean-up code
> > > >  - Reword Documentation/dev-tools/coccinelle.rst
> > > >
> > > >  Documentation/dev-tools/coccinelle.rst | 20 ++-----
> > > >  Documentation/kbuild/makefiles.rst     | 14 +++++
> > > >  Makefile                               | 80 +++++++++++++++-------=
----
> > > >  rust/Makefile                          |  4 +-
> > > >  scripts/Makefile.build                 |  2 +-
> > > >  scripts/Makefile.clean                 |  2 +-
> > > >  scripts/Makefile.compiler              |  2 +-
> > > >  scripts/Makefile.modpost               |  6 +-
> > > >  scripts/coccicheck                     |  6 +-
> > > >  scripts/nsdeps                         |  8 +--
> > > >  scripts/package/install-extmod-build   |  7 +++
> > > >  11 files changed, 85 insertions(+), 66 deletions(-)
> > > >
> > > > diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation=
/dev-tools/coccinelle.rst
> > > > index 535ce126fb4f..6e70a1e9a3c0 100644
> > > > --- a/Documentation/dev-tools/coccinelle.rst
> > > > +++ b/Documentation/dev-tools/coccinelle.rst
> > > > @@ -250,25 +250,17 @@ variables for .cocciconfig is as follows:
> > > >  - Your directory from which spatch is called is processed next
> > > >  - The directory provided with the ``--dir`` option is processed la=
st, if used
> > > >
> > > > -Since coccicheck runs through make, it naturally runs from the ker=
nel
> > > > -proper dir; as such the second rule above would be implied for pic=
king up a
> > > > -.cocciconfig when using ``make coccicheck``.
> > > > -
> > > >  ``make coccicheck`` also supports using M=3D targets. If you do no=
t supply
> > > >  any M=3D target, it is assumed you want to target the entire kerne=
l.
> > > >  The kernel coccicheck script has::
> > > >
> > > > -    if [ "$KBUILD_EXTMOD" =3D "" ] ; then
> > > > -        OPTIONS=3D"--dir $srctree $COCCIINCLUDE"
> > > > -    else
> > > > -        OPTIONS=3D"--dir $KBUILD_EXTMOD $COCCIINCLUDE"
> > > > -    fi
> > > > +    OPTIONS=3D"--dir $srcroot $COCCIINCLUDE"
> > > >
> > > > -KBUILD_EXTMOD is set when an explicit target with M=3D is used. Fo=
r both cases
> > > > -the spatch ``--dir`` argument is used, as such third rule applies =
when whether
> > > > -M=3D is used or not, and when M=3D is used the target directory ca=
n have its own
> > > > -.cocciconfig file. When M=3D is not passed as an argument to cocci=
check the
> > > > -target directory is the same as the directory from where spatch wa=
s called.
> > > > +Here, $srcroot refers to the source directory of the target: it po=
ints to the
> > > > +external module's source directory when M=3D used, and otherwise, =
to the kernel
> > > > +source directory. The third rule ensures the spatch reads the .coc=
ciconfig from
> > > > +the target directory, allowing external modules to have their own =
.cocciconfig
> > > > +file.
> > > >
> > > >  If not using the kernel's coccicheck target, keep the above preced=
ence
> > > >  order logic of .cocciconfig reading. If using the kernel's coccich=
eck target,
> > > > diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbu=
ild/makefiles.rst
> > > > index 7964e0c245ae..d36519f194dc 100644
> > > > --- a/Documentation/kbuild/makefiles.rst
> > > > +++ b/Documentation/kbuild/makefiles.rst
> > > > @@ -449,6 +449,20 @@ $(obj)
> > > >    to prerequisites are referenced with $(src) (because they are no=
t
> > > >    generated files).
> > > >
> > > > +$(srcroot)
> > > > +  $(srcroot) refers to the root of the source you are building, wh=
ich can be
> > > > +  either the kernel source or the external modules source, dependi=
ng on whether
> > > > +  KBUILD_EXTMOD is set. This can be either a relative or an absolu=
te path, but
> > > > +  if KBUILD_ABS_SRCTREE=3D1 is set, it is always an absolute path.
> > > > +
> > > > +$(srctree)
> > > > +  $(srctree) refers to the root of the kernel source tree. When bu=
ilding the
> > > > +  kernel, this is the same as $(srcroot).
> > > > +
> > > > +$(objtree)
> > > > +  $(objtree) refers to the root of the kernel object tree. It is `=
`.`` when
> > > > +  building the kernel, but it is different when building external =
modules.
> > > > +
> > >
> > > Thanks, I think it's nice that there is now such a clear definition.
> > > $(srcroot) sounds fine to me.
> > >
> > > >  $(kecho)
> > > >    echoing information to user in a rule is often a good practice
> > > >    but when execution ``make -s`` one does not expect to see any ou=
tput
> > > > diff --git a/Makefile b/Makefile
> > > > index cf1d55560ae2..e5f7ac7647a7 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -180,7 +180,24 @@ ifeq ("$(origin O)", "command line")
> > > >    KBUILD_OUTPUT :=3D $(O)
> > > >  endif
> > > >
> > > > -output :=3D $(KBUILD_OUTPUT)
> > > > +ifdef KBUILD_EXTMOD
> > > > +    ifdef KBUILD_OUTPUT
> > > > +        objtree :=3D $(realpath $(KBUILD_OUTPUT))
> > > > +        $(if $(objtree),,$(error specified kernel directory "$(KBU=
ILD_OUTPUT)" does not exist))
> > > > +    else
> > > > +        objtree :=3D $(CURDIR)
> > > > +    endif
> > > > +    output :=3D $(KBUILD_EXTMOD)
> > > > +    # KBUILD_EXTMOD might be a relative path. Remember its absolut=
e path before
> > > > +    # Make changes the working directory.
> > > > +    srcroot :=3D $(realpath $(KBUILD_EXTMOD))
> > > > +    $(if $(srcroot),,$(error specified external module directory "=
$(KBUILD_EXTMOD)" does not exist))
> > > > +else
> > > > +    objtree :=3D .
> > > > +    output :=3D $(KBUILD_OUTPUT)
> > > > +endif
> > > > +
> > > > +export objtree srcroot
> > > >
> > > >  # Do we want to change the working directory?
> > > >  ifneq ($(output),)
> > > > @@ -230,35 +247,33 @@ else # need-sub-make
> > > >
> > > >  # We process the rest of the Makefile if this is the final invocat=
ion of make
> > > >
> > > > -ifeq ($(abs_srctree),$(CURDIR))
> > > > -        # building in the source tree
> > > > -        srctree :=3D .
> > > > -     building_out_of_srctree :=3D
> > > > +ifndef KBUILD_EXTMOD
> > > > +srcroot :=3D $(abs_srctree)
> > > > +endif
> > > > +
> > > > +ifeq ($(srcroot),$(CURDIR))
> > > > +building_out_of_srctree :=3D
> > > >  else
> > > > -        ifeq ($(abs_srctree)/,$(dir $(CURDIR)))
> > > > -                # building in a subdirectory of the source tree
> > > > -                srctree :=3D ..
> > > > -        else
> > > > -                srctree :=3D $(abs_srctree)
> > > > -        endif
> > > > -     building_out_of_srctree :=3D 1
> > > > +export building_out_of_srctree :=3D1
>
> Nit: Adding a space between ':=3D1' for consistency?
>
> > > >  endif
> > > >
> > > > -ifneq ($(KBUILD_ABS_SRCTREE),)
> > > > -srctree :=3D $(abs_srctree)
> > > > +ifdef KBUILD_ABS_SRCTREE
> > > > +    # Do not nothing. Use the absolute path.
>
> Is this a superfluous "not"?
>
> "Do nothing. Use the absolute path."?


Thanks. I folded both.



>
>
> Thanks, again!
>
> Reviewed-by: Nicolas Schier <n.schier@avm.de>

Thanks for the review!


--=20
Best Regards
Masahiro Yamada
