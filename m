Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDE8E7717F
	for <cocci@archiver.kernel.org>; Tue, 10 Dec 2024 10:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=J8z4TeNtOjyfHomq5A0jFgCfiOcK4JHxVlUFxv73vWE=;
  b=u2ADnu7jyy4gaMH0KRni8aqU0QKcgWC3iyt+c5Un+wg9+7xQaFycOrge
   gIjeb6VXdhGebK3sY9dZEYDdcJzF3r2VSF/tzGzzJ9BvoPQkfLlvjZgQg
   3Nf84pWlMO1Td+LZAxJJzp426h55WJ+0UizHatxynMOE4AM93phG6k+XL
   I=;
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
X-IronPort-AV: E=Sophos;i="6.12,222,1728943200"; 
   d="scan'208";a="198390542"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Dec 2024 11:48:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D2783E0D1D; Tue, 10 Dec 2024 11:48:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 08835E00B6
	for <cocci@sympa.inria.fr>; Tue, 10 Dec 2024 11:48:26 +0100 (CET)
IronPort-SDR: 67581c79_tGLviS0IMfWsjPFw+yHEfnJvkGeXBlAeGhE2QO6JFa3340x
 CAxcTN/BgEoM91Ud3Zbm2zOynaLKlZC6XmZu9fQ==
X-IPAS-Result: =?us-ascii?q?A0GAAQCtG1hnj9lUsotaHgEBCxIMQIFIC4JEgVczBAtIh?=
 =?us-ascii?q?FaIfIZRgiSeGIF+DwEDAQ1EBAEBAwSFAAKKagIeBwEEMAkOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBARABAQUBAQECAQECBAYBAhABAQEBAQE5BUmFew2CYgGBJIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQINfQEBAQECASMdAQE3AQ8LCw0CAiYCAiETBR0GEwiCeYJCI?=
 =?us-ascii?q?wOucXqBMoEBggwBAQbcH4FkCYEaLoVrgmMBgWyDf4N9eicbgUlEgUqCdT6EQ?=
 =?us-ascii?q?xWDRoJpgRSBK4MXg0mUX4dJCR0DBwcODR5JDwUcA1khEQFVExcLBwVgSCAsA?=
 =?us-ascii?q?QIBgRWCBRyBPwU3Cj2CSWlLOgINAjaCJHyCTYUXgQuBFYJJShkvAwMDA4M6h?=
 =?us-ascii?q?iSCGU8dQAMLYgs9NxQbTJtmRoNYfIIEM38DpQOhBIQkgWOfezOXQ5MOmHupK?=
 =?us-ascii?q?oFnOoFcMxowdAaCME8DGQ+OIRkfiFa5YDQ1PAIHAQoBAQMJhkiKCIFLAQE?=
IronPort-PHdr: A9a23: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
 l0LzKn+IIBVMZf0iRQKVw==
IronPort-Data: A9a23:Y6Eb2KBrJu8jJhVW/8Lnw5YqxClBgxIJ4kV8jS/XYbTApGsjhTMPz
 zcXCj2DOvyDNjD8eN8lb9uz/ElQsMDTzYBlOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6j8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuGYjdJ5xYuajhIsvja8Es01BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc51H7YiPs4PtONkwvJ4El+/dvM2pXx
 NVNfVjhbjjb7w636L61Va93gdk5J8StP44FvHxkizbDAp7KQ7iaGPSMvIAImmdswJoXQp4yZ
 OJBAdZrRBHJeBRPO00QGbo9kf2ui325dCdXwL6QjfNmszOClFErjdABNvKFQPuraPVft3+Im
 T75pWXLIzdEKNqQnG/tHnWE3bKXw3OkAer+DoaQ/flhi1y73X0WEBRQVF2hoPD/hFTWZj5EA
 0Aa5Ww1qrUo/0HtTdTnWRC85nmesXbwRua8DcUm1RDVyonawzyUH3IIcz9QcO4trf4fEGlCO
 kCyo/vlAjlmsbuwQH2b96uJoT7aBcTzBTFeDcPjZVVZi+QPsL0OYgTzosGP+ZNZY/X5Fy622
 DeXtiMzwbYel8gG0+O851+vb9OQSnrhEVNdCub/BzPNAuZFiGiNPNLABb/zsawoEWphZgPd1
 EXoYuDHhAz0MbmDlTaWXMIGF6yz6vCOPVX02AE0RMZ/pm31oCD/JOi8BQ2Swm83bq7onhe3P
 SfuVf95vc8PVJdXRf4tOtzpYyjU5fW7SY2Nug/ogipmOcUpKl/YpUmClGadxn3slkk82boyI
 4maesu3RXccAuIP8dZFb7l17FPf/QhnnTm7bcmil3yPiOPODFbLEu1tGAXVMYgEAFas/F69H
 yB3a5DSk003vSyXSnW/zLP/2nhWdyVrWM2v8J0PHgNBSyI/cFwc5zbq6etJU+RYc259z48kJ
 1nsChEK+0m1nnDdNwSBZ1Zqbb6lD941rms2MWZodRyk0mQqK9TnpqoOVYoFTZ9+/sxazNlwU
 6YkfeeECa9xUTjpwWkWQqT8i41ATy6VozyyERCrWxUFRK44dTf1ooflWiDN6BgxCjGGsJpig
 r+4iSLeb5kxZyVjK8f0csCf7U6DgmcAkrlQWWrJPdhhV0H++6d6KyHKr6EWIuNdDT7h1zelx
 wKtLhNAntb0oqgx64Pvl42fioWUT9tFAUtRGlfE4YaMNSX1+nSpxalCWr2qeQ/xeXzV+qL4Q
 8lo1ND5beM6mWhVv7pGE7pEybw04/3treR4yiVmBHD6UES5OIh/I3Wp3dh9iYMV/+V34TCJY
 0Oo/sVWHZ6rO8m/SV4YG1cDX9S5jPoRnmHf0OQxLEDE/xRIxbugU3hJHhyymSdYfapUMoQk/
 L8bg/QoyTeD0zgkDtXXqRpv1TWoDmcBWKAZpJ0lENfVqg40+GpjP73YKAHLua+qVfsdHHUuE
 DGugIj6u4993WvHKno6KmjM17FShLMIoxF782UBLFWoxPvAmvs82UBV+x9qUA9QxRRj+MBwM
 1hNKEdaC/iv/TBppc4bREGqOVhLKyO483zL6WkitTPmXXjzc1fSPUsBOeqp12IIwVJ2JzR00
 umR9zf4bGzMYsr04BoXZWdkjP7SFfpK6QzInZGcLfSvRpUVT2Lsvf6zWDAutRDiPMIWgX/Hr
 8lM+MJbS/XyFQwUkp0BJ7iq75YiYzHaGzUaWtBkxr0DIk/EcjLr2TSuFVG4SvkQG9P0q32HG
 +5cDeMRcS+h1RS+jCERXo8NBL5WoMQHxvQ/fpHTGGpXlIfH8xRItsrL+znclV0bZYxksfwAJ
 7P7cxOAFW2thkVopVLdkfkcOkSETIkFQCbewNGK9P44EsNfkeN0LmA3/LiGn1SUFwpF/CCSt
 x7IPf6PxOlEzaBpg4/nF/hHDS7pN9j2X+Ws2yKwuuRoctngH5rvtQQUi1+/JCVQH+IbdOpWn
 IS3kuzc/R36rodtdlvGir+9F6Vtzuejbtp9a87YAiFTonqfZZXK/RAGxVGdFbVIt9Fsvu+cW
 AqybZqLR+4/Atty6iVcVHlDLkw7Fa/yU6bHoBG9pdSqDjw281TODPGjxE/TQVBrTA06ELygN
 VasoNer3M5Sk6pUDhxdB/1GPY5xEGW+ZYQYLe/OpRuqJUj2pGidu4nStwsqshDKLXimLPzUw
 7z4QjrGSRDjn52Qkf94tdV+sCRCWTw5yaM1c1kG8tF7tyGiASRUZa4BOJEBEddPnja0yJj8Y
 yrXYXA/DTnmGw5Jagj4/M+pSzL36jbi4TslDmdBE4KohyaK6EeoDLV+sDxn/m19d33gwfuhJ
 NVY/Wf/VvR0LleFWs5LjsFXQ88+rh8Z+p7M0UPwicr/B1AZG7piOLlJAl9WTSKeey3SvByjG
 IX2LFyohGm4RFT3HMImfGRacP3cUPUD0B1wBRqyLB3jV0l3AQGOJDAT+w0+71HbUPk3GQ==
IronPort-HdrOrdr: A9a23:hj3IxqD5AjVRNlzlHelT55DYdb4zR+YMi2TDGXoBMyC9Ffbo6/
 xG/c5rqCMc7Qx9ZJhOo6HmBEDtewK5yXcx2/h1AV7AZniEhILLFvAa0WKK+VSJcEeTygce79
 YDT0EUMqyJMbEVt7eA3CCIV/kn28eO662liKPzyH13XRh2Z6wI1WhE48WgfHFedU1pAZI4Ed
 67/cpIpz2pfDAyYt6gDncIG8jvzue78q4OrSRmO/fv0mmzsQ8=
X-Talos-CUID: =?us-ascii?q?9a23=3AGghVvmlwoDXX1kesnyH6vJqmwBfXOWHg3S/QAEG?=
 =?us-ascii?q?YM2twUrGoSE6Iyqh9ouM7zg=3D=3D?=
X-Talos-MUID: 9a23:LffsOApv/Y3ZgToPIE0ez2FYE+ZF066HMVAyzapcuvulE3JsPTjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,222,1728943200"; 
   d="scan'208";a="198390525"
X-MGA-submission: =?us-ascii?q?MDGXTvltiqh241dMn4Ayp5SQVuNW2wNvEoqPrR?=
 =?us-ascii?q?MJyCpbq3yuSu/QZXC5cbydeH1xfV1OHM7A2QcL0SjyxWBiXBD+nC+rfw?=
 =?us-ascii?q?6kFXJLy4YrJO27xaBWAHLfWsDiHF3ApXhr3NtWvtcpRdk7qO6oB6JUO9?=
 =?us-ascii?q?jPf+LuFiURfJuexTJJKMiI0g=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 11:48:25 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 753745C6278
	for <cocci@inria.fr>; Tue, 10 Dec 2024 10:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA937C4CED6
	for <cocci@inria.fr>; Tue, 10 Dec 2024 10:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733827702;
	bh=nDEcLzOXkw5lDX1vPhdxB5fFLH1KL7iUs8wX2ih2tvI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rZUbCMnGKijYAbOD+iJiA2AJD4TUKmia96A8ESRJMaHOSuuJaYAoESy9gHyjgoAsf
	 rTc4WoJatds2hlG8od+kr2D+xetVcW5fVXaB4d5gXoKjtpS1o7Ie46rqtdFWPef73Q
	 rsh7nHp78qCcvhwrC/c9tYJw8WLVrpcQr7d594t7sNbGyPEZpDd/nAFxqBcCCPZyZO
	 uHWF4gTHP876Mm+mAKaz4VNtn8DhUbPu97WumR3qkoF7z9PfsgYsh3nz3x/XZbWuUz
	 /1g46OKqMSsEV2POvfVnQYg4IrBMJoQ5VmebMm7Xl0b0W2pvt4PMktLf4EtFinVNi8
	 NZHJKXkuumsFQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53e399e3310so3395042e87.1
        for <cocci@inria.fr>; Tue, 10 Dec 2024 02:48:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6iyI/yK7bb8hr2awBPYdHwwdZcX5HDlTgEkO61DihqJx80hhsypru3bYYbaZ+VMIB95mw9w==@inria.fr
X-Gm-Message-State: AOJu0Yz1yPQCLepEXgDrP9PTVQwge8G+GjVkSpmLkVNrKX73ce6pjXU5
	4fNBlClzUKUjljmYZa1UcC5jFzuUigCJVrXp53fF+xwCsjwWc2esgeE7i+JNk4wY9dx1fGs/Kqj
	wdPIwjjL9dLfOzjETYdyjWFFV7XE=
X-Google-Smtp-Source: AGHT+IG+NBDQ+Wr2u+Ka9B5mjOl9WuBsaKYe1AoAeVspIENEADbvb4snVH0SrUJ7CXgH2/wrBk+9ssaNF1V3JZNVpC0=
X-Received: by 2002:a05:6512:23a4:b0:53e:3a01:cf45 with SMTP id
 2adb3069b0e04-53e3a01d067mr3740331e87.13.1733827701466; Tue, 10 Dec 2024
 02:48:21 -0800 (PST)
MIME-Version: 1.0
References: <20241110013649.34903-1-masahiroy@kernel.org> <20241110013649.34903-6-masahiroy@kernel.org>
 <82FA2E02-05A5-4297-B364-9D7D89001D9D@linux.dev> <1116D946-05F3-4463-A61F-DE221F258A3F@linux.dev>
In-Reply-To: <1116D946-05F3-4463-A61F-DE221F258A3F@linux.dev>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 10 Dec 2024 19:47:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ1MvB_wXa6F8aZB_srrLTQupRXNsz6Rav27fyjznXZJQ@mail.gmail.com>
Message-ID: <CAK7LNAQ1MvB_wXa6F8aZB_srrLTQupRXNsz6Rav27fyjznXZJQ@mail.gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] [PATCH v2 05/11] kbuild: change working directory to
 external module directory with M=
Reply-To: Masahiro Yamada <masahiroy@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2173
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/CAK7LNAQ1MvB_wXa6F8aZB_srrLTQupRXNsz6Rav27fyjznXZJQ%40mail.gmail.com>

On Mon, Dec 9, 2024 at 10:56=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> On 9. Dec 2024, at 14:46, Thorsten Blum wrote:
> > On 10. Nov 2024, at 02:34, Masahiro Yamada wrote:
> >>
> >> Currently, Kbuild always operates in the output directory of the kerne=
l,
> >> even when building external modules. This increases the risk of extern=
al
> >> module Makefiles attempting to write to the kernel directory.
> >>
> >> This commit switches the working directory to the external module
> >> directory, allowing the removal of the $(KBUILD_EXTMOD)/ prefix from
> >> some build artifacts.
> >>
> >> The command for building external modules maintains backward
> >> compatibility, but Makefiles that rely on working in the kernel
> >> directory may break. In such cases, $(objtree) and $(srctree) should
> >> be used to refer to the output and source directories of the kernel.
> >>
> >> The appearance of the build log will change as follows:
> >>
> >> [Before]
> >>
> >> $ make -C /path/to/my/linux M=3D/path/to/my/externel/module
> >> make: Entering directory '/path/to/my/linux'
> >>   CC [M]  /path/to/my/externel/module/helloworld.o
> >>   MODPOST /path/to/my/externel/module/Module.symvers
> >>   CC [M]  /path/to/my/externel/module/helloworld.mod.o
> >>   CC [M]  /path/to/my/externel/module/.module-common.o
> >>   LD [M]  /path/to/my/externel/module/helloworld.ko
> >> make: Leaving directory '/path/to/my/linux'
> >>
> >> [After]
> >>
> >> $ make -C /path/to/my/linux M=3D/path/to/my/externel/module
> >> make: Entering directory '/path/to/my/linux'
> >> make[1]: Entering directory '/path/to/my/externel/module'
> >>   CC [M]  helloworld.o
> >>   MODPOST Module.symvers
> >>   CC [M]  helloworld.mod.o
> >>   CC [M]  .module-common.o
> >>   LD [M]  helloworld.ko
> >> make[1]: Leaving directory '/path/to/my/externel/module'
> >> make: Leaving directory '/path/to/my/linux'
> >>
> >> Printing "Entering directory" twice is cumbersome. This will be
> >> addressed later.
> >>
> >> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >> ---
> >
> > Hi Masahiro,
> >
> > I get the following error since this patch is in master, but only when
> > using COCCI=3D in combination with M=3D<relative or absolute path>.
> >
> > It works when I either use COCCI=3D or M=3D, but not with both.
>
> Using the absolute path of the cocci script fixes my problem, but this
> used to work with relative paths too.
>
> $ make coccicheck COCCI=3D$(pwd)/scripts/coccinelle/misc/flexible_array.c=
occi M=3Darch/

M=3D looks a bit weird for the upstream code, but
I think using the absolute path is the right thing to do.


--=20
Best Regards
Masahiro Yamada
