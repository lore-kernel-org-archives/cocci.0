Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC47C02188
	for <cocci@archiver.kernel.org>; Mon, 27 Jan 2025 23:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=c9sTKCd80xAwfgqnfaDIdl8rLTuHJwgOobd8L66Fk1o=;
  b=WvZo1J4UZ9blCWiU1u+TCTEoVwjPlken/jc1RIh1/oV7Fpa+tDkdninw
   JnQ3Zh+O1aAO/SeDcJaREEHznnigvV1Zw9r8xanW+t88G/KuSfr7eybHE
   OFWokuA1tRD/CPtFiGtFa76VmIw3xo98Rtr2eEdAPnmuSULOPPMUXZq4V
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=quwenruo.btrfs@gmx.com
X-IronPort-AV: E=Sophos;i="6.13,239,1732575600"; 
   d="scan'208";a="205280204"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 00:08:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C535CE0137; Tue, 28 Jan 2025 00:08:51 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A9C13E0035
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 00:08:48 +0100 (CET)
IronPort-SDR: 67981200_+hj3WsnTwiEJ5zlJ0Rs0ISPKKPotsOIL4+PyvjSosAWbHfY
 aL0euy/Bjoqxj/AGAuUtXTBQ2fbMfNINk+2zMkA==
X-IPAS-Result: =?us-ascii?q?A0EGAAA9EZhnfhYR49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYIbKH1aMwQLSIRWg0+ETocygXQtgRaDKI5ji?=
 =?us-ascii?q?SSBVoF+DwEDAQ0xEAECBAEBAwEDOIRIAop1Ah4HAQQwCQ4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOECuFew2CYgGBJCSBASwsPwEBH?=
 =?us-ascii?q?gIBAyMVCAEBNwEPCQIaAiYCAlYGARICAQGCfgGCLwEDMQMEmkGRB4s+gTKBA?=
 =?us-ascii?q?YIMAQEGgQjZUgFLA3aBZAmBGi4BhHODWgGFaxsgg0J6J4IogRUngRSBNzg+h?=
 =?us-ascii?q?EODW4JpgjNLg12BDIFsiU14Hh0dL4IpgS+EZ4sUUi9MHANZLAFVExcLBwWBK?=
 =?us-ascii?q?UgDKzYxIw+BFwU1Cjc6gg1pSS0KAg0CNYIeJFgKgiFrBAWBLYI7JYQgYC8DA?=
 =?us-ascii?q?wMDgkxseoRjghSBZQMDFhGCNXJ5HIFwHUACAQttPTcJCxsGPZ1CATyEAgF7B?=
 =?us-ascii?q?A8BG4EgCzIrJykvA5Jrj3+jGAsHg3MrgWOKNZUzBhMvhVuRfZJ7lhyCYCKjP?=
 =?us-ascii?q?QuFQ4FnOoFcTSODNwlGAxkPjiE4dgEIgWVeyVYwNTwCBwEKAQEDCYVGAQGKY?=
 =?us-ascii?q?YFLAQE?=
IronPort-PHdr: A9a23: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
 y7C6NVppgP/+gFu4j9gTQYIpTNbwoSGoRc6UZg=
IronPort-Data: A9a23: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
 ajZiF2omH2GdHM=
IronPort-HdrOrdr: A9a23:vBaBpaAdGbBHg83lHelv55DYdb4zR+YMi2QD/1xtTxZPYtWE/v
 re+sjzGyWE6gr5K0tQ/exoX5PwOk80lKQFmbX5WI3IYOCIggSVxe1ZnOzfKnjbalTDH41mu5
 uIEZITNDSYNzET4PoSojPIdurIq+PmzEnHv5a8815QbUVNd7xq6Rt/Bz2WC0tsWWB9dOYE/d
 anh/auvFCbCA4qhymAdwQ4t2Ovnbf2qK4=
X-Talos-CUID: =?us-ascii?q?9a23=3AgFhjSWh9sDIazjo8O8u8lDj83TJuV2+CkXbLZH2?=
 =?us-ascii?q?DBV1Gc7u3Rn26p/p/qp87?=
X-Talos-MUID: 9a23:XjmNCwr6FJMFyVfnG7gezwp7D4Rz3a2WM10MkLAUl9uZOydvHTjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,239,1732575600"; 
   d="scan'208";a="205280203"
X-MGA-submission: =?us-ascii?q?MDFBoHxt/ChlXUwWWTqJRwFXnqwJxodBpyZTfw?=
 =?us-ascii?q?yMEkVpazDjQAFpMTER8m0fQuc/RtvhaI1QsF3MF42rp7z5q9/WFS9e8w?=
 =?us-ascii?q?K+ZhDqYuD2MFHDIvVcv6ePqzYlUwxmAl0ac1CBRxYdiNCOPba5AvPC2+?=
 =?us-ascii?q?5wiMzAl89dUEPCxBCQEmWZdA=3D=3D?=
Received: from mout.gmx.net ([212.227.17.22])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 00:08:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738019320; x=1738624120; i=quwenruo.btrfs@gmx.com;
	bh=c9sTKCd80xAwfgqnfaDIdl8rLTuHJwgOobd8L66Fk1o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mHABvHp0nHbALFLDnjhV0CuyXLsXBkmSc0IC+YgRjfQlNkwXmG7X6H/OXJo2OK6y
	 e7xPS3TYf310w7Hzap6QpNnGArblTcvNAnbNXKhd78T84IZDqngpsFJXTEidufWd6
	 Qp5xF/YM9QHSB1CF7VJHK3ICpdvPPOxO+COdxCUzi8ARyZmzDetIp0dPW9Lrf1obJ
	 58j+2dCSCpK0PzPOnEJPNRn84sfQIc3vq/LwDV5uqmCAeKLYNA6fgo1f00Vwq34j9
	 NX+8hGRHZ+hZSgXjBh73Em/YoNEMSUA3cSCLhNBHEmQHCrPRXcH8IlORoyVXRIEVx
	 Bt9yPL+Zh7y6xP4zzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2E1G-1tTSLh2w8c-012qgn; Tue, 28
 Jan 2025 00:08:40 +0100
Message-ID: <fa460e59-65b0-438c-bfa7-70cec50ef747@gmx.com>
Date: Tue, 28 Jan 2025 09:38:36 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 cocci@inria.fr
References: <20241110013649.34903-1-masahiroy@kernel.org>
 <20241110013649.34903-6-masahiroy@kernel.org>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20241110013649.34903-6-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EnyAVBIrVMjZeyH5g/05RdUCLARXBRWOzPAlkCe9TaIWRb6bxwc
 bsbkqSaPxzsw/MM+Iokvi/mEm+3mE5YQotGqRmznk7Vw0gIVkWfAxJ+frWXuaJ6VWAbCe52
 PMvND452g+MnzNg4sNfvUf/k8IaD6msEZ2dbVIwqweMAdKH/loutZ8JfwRujJEQFIZ7LI0q
 ksWKf7Ej2Yau0j1o7F1kg==
UI-OutboundReport: notjunk:1;M01:P0:GGKxUgYyV48=;ChJldn66fGvESpwLkoFZizaAe8n
 YFltkp/WntjN33fvw2V5DhCUXwn2eZ3KTTa44OqFnqohNYU9IX+o021iADbfiwDOUAv0l9Dbv
 cnXQDMInqnb3QlIt4vSG9L6HIrPmlZIeX1RPYCAwZXjlIm8Rn6PSHZrZQux+iNbPmMdwDd9bx
 91txNrbRMlx3D4YMYRnfH3Pf4qgf9Re0Qzmf4wkUku/iJs4EyYntzrqxWEr71begpzCYd9lbP
 bNIRQnNaJ+Ipab9EkBnE39tgUjsHdHufGba3gTBX0+FkocQskEdMEQTyUcCpWLOrcaPgHHdDX
 PEJVFFPSiUxSLWevvq/VcOo59ehNyGHJNkpajXIqiUn8WStPRkkeyk6Lsm2Nnv6ZfP2BJxB7D
 ycwAWpkbFPqao3wH1qGYOVBqCOtYoWRvIsI3ACd8TLGMo/qflA71HWNw6EzYKVrATXiVaWKyn
 ga9WrDQvrJeXnftGm7PQ2LGwEh1T3OjJuav5suejZEpPa0feuoivci0ywFxaa+fjoh5v8Yre3
 QhyxG/uLrffA0hkUFZjXGC/bSBudzuvXSinmyH7pDQQ0IeOiJqU9rfgHyO4GB2/KhyH6zEJPa
 q91g3GMmqYKadwazAGWDDZhXPVqoK1axvEJxR3dhUtqOKK+50oEBsIUkpzEsPPqwenVGYh/0u
 53Vr7RNhAwgasndghOI6MNlIWO22wEgGEt7kYLqqRdfN1/n1qrP2ml3nzun36v2zFiffhGhIL
 3Mj+8aBvM0Mz1AveS81luGaeHuqEUQ6NTfcQ1CTTrwfOJ5uFZwRdA2DcwA9WMYdKgj8IEqxIX
 VgK0Q8NjqzRU9bzam/zbyEz1nfygl1Z7YZ2MQQ0EiOogMN0svVKnabn6FUbpUJfhwJzHetTEF
 U35Qv0eocTps74cTWN9QmSuvNJZlv/s+01PiuXGl+oWjiUs09odMimBqrIqOWVTAIc+Pu4+1n
 Hp1ZZCYsTV+6wmNq08tBzcF2tAQthSG8RPI5dAbscMZMVh12tX8o/1iRFE1oatwKZPmTvI/Is
 fGHHl/BHTiv3Zk1VuEL461dwz9vWANqD4uXouOiUWAOfwA2Be7T/Mz5WW2ikiTLAT74KoZyBw
 rS81/8bfIDZiNH7/pkADJs3YHvQkcz0f05W8JeQLU6LPIWiyA/s3mq2CjILgtuKbLNvune6CQ
 bXKyTnmTW4c7ZqZCgx1SjLdnd5MCUBqDJXSev27PfRQ==
Subject: Re: [cocci] [PATCH v2 05/11] kbuild: change working directory to
 external module directory with M=
Reply-To: Qu Wenruo <quwenruo.btrfs@gmx.com>
X-Loop: cocci@inria.fr
X-Sequence: 2239
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/fa460e59-65b0-438c-bfa7-70cec50ef747%40gmx.com>

Hi Masahiro-san,

Thanks for your contribution, but it looks like this is breaking quite
some vim/nvim quick fixes.

If there is some compiling errors/warnings, the path will be the one
inside the module directory, no matter if it's out-of-tree or upstreamed.

Is there anyway to get back the full filename so that vim/nvim quick fix
can work again?

Thanks,
Qu

=E5=9C=A8 2024/11/10 12:04, Masahiro Yamada =E5=86=99=E9=81=93:
> Currently, Kbuild always operates in the output directory of the kernel,
> even when building external modules. This increases the risk of external
> module Makefiles attempting to write to the kernel directory.
>
> This commit switches the working directory to the external module
> directory, allowing the removal of the $(KBUILD_EXTMOD)/ prefix from
> some build artifacts.
>
> The command for building external modules maintains backward
> compatibility, but Makefiles that rely on working in the kernel
> directory may break. In such cases, $(objtree) and $(srctree) should
> be used to refer to the output and source directories of the kernel.
>
> The appearance of the build log will change as follows:
>
> [Before]
>
>    $ make -C /path/to/my/linux M=3D/path/to/my/externel/module
>    make: Entering directory '/path/to/my/linux'
>      CC [M]  /path/to/my/externel/module/helloworld.o
>      MODPOST /path/to/my/externel/module/Module.symvers
>      CC [M]  /path/to/my/externel/module/helloworld.mod.o
>      CC [M]  /path/to/my/externel/module/.module-common.o
>      LD [M]  /path/to/my/externel/module/helloworld.ko
>    make: Leaving directory '/path/to/my/linux'
>
> [After]
>
>    $ make -C /path/to/my/linux M=3D/path/to/my/externel/module
>    make: Entering directory '/path/to/my/linux'
>    make[1]: Entering directory '/path/to/my/externel/module'
>      CC [M]  helloworld.o
>      MODPOST Module.symvers
>      CC [M]  helloworld.mod.o
>      CC [M]  .module-common.o
>      LD [M]  helloworld.ko
>    make[1]: Leaving directory '/path/to/my/externel/module'
>    make: Leaving directory '/path/to/my/linux'
>
> Printing "Entering directory" twice is cumbersome. This will be
> addressed later.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v2:
>   - Introduce a new 'srcroot' variable and clean-up code
>   - Reword Documentation/dev-tools/coccinelle.rst
>
>   Documentation/dev-tools/coccinelle.rst | 20 ++-----
>   Documentation/kbuild/makefiles.rst     | 14 +++++
>   Makefile                               | 80 +++++++++++++++-----------
>   rust/Makefile                          |  4 +-
>   scripts/Makefile.build                 |  2 +-
>   scripts/Makefile.clean                 |  2 +-
>   scripts/Makefile.compiler              |  2 +-
>   scripts/Makefile.modpost               |  6 +-
>   scripts/coccicheck                     |  6 +-
>   scripts/nsdeps                         |  8 +--
>   scripts/package/install-extmod-build   |  7 +++
>   11 files changed, 85 insertions(+), 66 deletions(-)
>
> diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-=
tools/coccinelle.rst
> index 535ce126fb4f..6e70a1e9a3c0 100644
> --- a/Documentation/dev-tools/coccinelle.rst
> +++ b/Documentation/dev-tools/coccinelle.rst
> @@ -250,25 +250,17 @@ variables for .cocciconfig is as follows:
>   - Your directory from which spatch is called is processed next
>   - The directory provided with the ``--dir`` option is processed last, =
if used
>
> -Since coccicheck runs through make, it naturally runs from the kernel
> -proper dir; as such the second rule above would be implied for picking =
up a
> -.cocciconfig when using ``make coccicheck``.
> -
>   ``make coccicheck`` also supports using M=3D targets. If you do not su=
pply
>   any M=3D target, it is assumed you want to target the entire kernel.
>   The kernel coccicheck script has::
>
> -    if [ "$KBUILD_EXTMOD" =3D "" ] ; then
> -        OPTIONS=3D"--dir $srctree $COCCIINCLUDE"
> -    else
> -        OPTIONS=3D"--dir $KBUILD_EXTMOD $COCCIINCLUDE"
> -    fi
> +    OPTIONS=3D"--dir $srcroot $COCCIINCLUDE"
>
> -KBUILD_EXTMOD is set when an explicit target with M=3D is used. For bot=
h cases
> -the spatch ``--dir`` argument is used, as such third rule applies when =
whether
> -M=3D is used or not, and when M=3D is used the target directory can hav=
e its own
> -.cocciconfig file. When M=3D is not passed as an argument to coccicheck=
 the
> -target directory is the same as the directory from where spatch was cal=
led.
> +Here, $srcroot refers to the source directory of the target: it points =
to the
> +external module's source directory when M=3D used, and otherwise, to th=
e kernel
> +source directory. The third rule ensures the spatch reads the .coccicon=
fig from
> +the target directory, allowing external modules to have their own .cocc=
iconfig
> +file.
>
>   If not using the kernel's coccicheck target, keep the above precedence
>   order logic of .cocciconfig reading. If using the kernel's coccicheck =
target,
> diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/m=
akefiles.rst
> index 7964e0c245ae..d36519f194dc 100644
> --- a/Documentation/kbuild/makefiles.rst
> +++ b/Documentation/kbuild/makefiles.rst
> @@ -449,6 +449,20 @@ $(obj)
>     to prerequisites are referenced with $(src) (because they are not
>     generated files).
>
> +$(srcroot)
> +  $(srcroot) refers to the root of the source you are building, which c=
an be
> +  either the kernel source or the external modules source, depending on=
 whether
> +  KBUILD_EXTMOD is set. This can be either a relative or an absolute pa=
th, but
> +  if KBUILD_ABS_SRCTREE=3D1 is set, it is always an absolute path.
> +
> +$(srctree)
> +  $(srctree) refers to the root of the kernel source tree. When buildin=
g the
> +  kernel, this is the same as $(srcroot).
> +
> +$(objtree)
> +  $(objtree) refers to the root of the kernel object tree. It is ``.`` =
when
> +  building the kernel, but it is different when building external modul=
es.
> +
>   $(kecho)
>     echoing information to user in a rule is often a good practice
>     but when execution ``make -s`` one does not expect to see any output
> diff --git a/Makefile b/Makefile
> index cf1d55560ae2..e5f7ac7647a7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -180,7 +180,24 @@ ifeq ("$(origin O)", "command line")
>     KBUILD_OUTPUT :=3D $(O)
>   endif
>
> -output :=3D $(KBUILD_OUTPUT)
> +ifdef KBUILD_EXTMOD
> +    ifdef KBUILD_OUTPUT
> +        objtree :=3D $(realpath $(KBUILD_OUTPUT))
> +        $(if $(objtree),,$(error specified kernel directory "$(KBUILD_O=
UTPUT)" does not exist))
> +    else
> +        objtree :=3D $(CURDIR)
> +    endif
> +    output :=3D $(KBUILD_EXTMOD)
> +    # KBUILD_EXTMOD might be a relative path. Remember its absolute pat=
h before
> +    # Make changes the working directory.
> +    srcroot :=3D $(realpath $(KBUILD_EXTMOD))
> +    $(if $(srcroot),,$(error specified external module directory "$(KBU=
ILD_EXTMOD)" does not exist))
> +else
> +    objtree :=3D .
> +    output :=3D $(KBUILD_OUTPUT)
> +endif
> +
> +export objtree srcroot
>
>   # Do we want to change the working directory?
>   ifneq ($(output),)
> @@ -230,35 +247,33 @@ else # need-sub-make
>
>   # We process the rest of the Makefile if this is the final invocation =
of make
>
> -ifeq ($(abs_srctree),$(CURDIR))
> -        # building in the source tree
> -        srctree :=3D .
> -	building_out_of_srctree :=3D
> +ifndef KBUILD_EXTMOD
> +srcroot :=3D $(abs_srctree)
> +endif
> +
> +ifeq ($(srcroot),$(CURDIR))
> +building_out_of_srctree :=3D
>   else
> -        ifeq ($(abs_srctree)/,$(dir $(CURDIR)))
> -                # building in a subdirectory of the source tree
> -                srctree :=3D ..
> -        else
> -                srctree :=3D $(abs_srctree)
> -        endif
> -	building_out_of_srctree :=3D 1
> +export building_out_of_srctree :=3D1
>   endif
>
> -ifneq ($(KBUILD_ABS_SRCTREE),)
> -srctree :=3D $(abs_srctree)
> +ifdef KBUILD_ABS_SRCTREE
> +    # Do not nothing. Use the absolute path.
> +else ifeq ($(srcroot),$(CURDIR))
> +    # Building in the source.
> +    srcroot :=3D .
> +else ifeq ($(srcroot)/,$(dir $(CURDIR)))
> +    # Building in a subdirectory of the source.
> +    srcroot :=3D ..
>   endif
>
> -objtree		:=3D .
> +export srctree :=3D $(if $(KBUILD_EXTMOD),$(abs_srctree),$(srcroot))
>
> -VPATH		:=3D
> -
> -ifeq ($(KBUILD_EXTMOD),)
>   ifdef building_out_of_srctree
> -VPATH		:=3D $(srctree)
> +export VPATH :=3D $(srcroot)
> +else
> +VPATH :=3D
>   endif
> -endif
> -
> -export building_out_of_srctree srctree objtree VPATH
>
>   # To make sure we do not include .config for any of the *config target=
s
>   # catch them early, and hand them over to scripts/kconfig/Makefile
> @@ -711,7 +726,7 @@ endif
>   # in addition to whatever we do anyway.
>   # Just "make" or "make all" shall build modules as well
>
> -ifneq ($(filter all modules nsdeps %compile_commands.json clang-%,$(MAK=
ECMDGOALS)),)
> +ifneq ($(filter all modules nsdeps compile_commands.json clang-%,$(MAKE=
CMDGOALS)),)
>     KBUILD_MODULES :=3D 1
>   endif
>
> @@ -1107,7 +1122,7 @@ export MODLIB
>
>   PHONY +=3D prepare0
>
> -export extmod_prefix =3D $(if $(KBUILD_EXTMOD),$(KBUILD_EXTMOD)/)
> +export extmod_prefix =3D
>   export MODORDER :=3D $(extmod_prefix)modules.order
>   export MODULES_NSDEPS :=3D $(extmod_prefix)modules.nsdeps
>
> @@ -1799,14 +1814,10 @@ filechk_kernel.release =3D echo $(KERNELRELEASE)
>   KBUILD_BUILTIN :=3D
>   KBUILD_MODULES :=3D 1
>
> -build-dir :=3D $(KBUILD_EXTMOD)
> +build-dir :=3D .
>
> -compile_commands.json: $(extmod_prefix)compile_commands.json
> -PHONY +=3D compile_commands.json
> -
> -clean-dirs :=3D $(KBUILD_EXTMOD)
> -clean: private rm-files :=3D $(KBUILD_EXTMOD)/Module.symvers $(KBUILD_E=
XTMOD)/modules.nsdeps \
> -	$(KBUILD_EXTMOD)/compile_commands.json
> +clean-dirs :=3D .
> +clean: private rm-files :=3D Module.symvers modules.nsdeps compile_comm=
ands.json
>
>   PHONY +=3D prepare
>   # now expand this into a simple variable to reduce the cost of shell e=
valuations
> @@ -1948,7 +1959,7 @@ $(clean-dirs):
>
>   clean: $(clean-dirs)
>   	$(call cmd,rmfiles)
> -	@find $(or $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
> +	@find . $(RCS_FIND_IGNORE) \
>   		\( -name '*.[aios]' -o -name '*.rsi' -o -name '*.ko' -o -name '.*.cm=
d' \
>   		-o -name '*.ko.*' \
>   		-o -name '*.dtb' -o -name '*.dtbo' \
> @@ -1981,7 +1992,12 @@ tags TAGS cscope gtags: FORCE
>   PHONY +=3D rust-analyzer
>   rust-analyzer:
>   	+$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is_available.sh
> +ifdef KBUILD_EXTMOD
> +# FIXME: external modules must not descend into a sub-directory of the =
kernel
> +	$(Q)$(MAKE) $(build)=3D$(objtree)/rust src=3D$(srctree)/rust $@
> +else
>   	$(Q)$(MAKE) $(build)=3Drust $@
> +endif
>
>   # Script to generate missing namespace dependencies
>   # --------------------------------------------------------------------=
-------
> diff --git a/rust/Makefile b/rust/Makefile
> index b5e0a73b78f3..742740816c4b 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -362,8 +362,8 @@ rust-analyzer:
>   	$(Q)$(srctree)/scripts/generate_rust_analyzer.py \
>   		--cfgs=3D'core=3D$(core-cfgs)' --cfgs=3D'alloc=3D$(alloc-cfgs)' \
>   		$(realpath $(srctree)) $(realpath $(objtree)) \
> -		$(rustc_sysroot) $(RUST_LIB_SRC) $(KBUILD_EXTMOD) > \
> -		$(if $(KBUILD_EXTMOD),$(extmod_prefix),$(objtree))/rust-project.json
> +		$(rustc_sysroot) $(RUST_LIB_SRC) $(if $(KBUILD_EXTMOD),$(srcroot)) \
> +		> rust-project.json
>
>   redirect-intrinsics =3D \
>   	__addsf3 __eqsf2 __extendsfdf2 __gesf2 __lesf2 __ltsf2 __mulsf3 __nes=
f2 __truncdfsf2 __unordsf2 \
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 64cd046f8fd8..1aa928a6fb4f 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -3,7 +3,7 @@
>   # Building
>   # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> -src :=3D $(if $(VPATH),$(VPATH)/)$(obj)
> +src :=3D $(srcroot)/$(obj)
>
>   PHONY :=3D $(obj)/
>   $(obj)/:
> diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
> index 4fcfab40ed61..6ead00ec7313 100644
> --- a/scripts/Makefile.clean
> +++ b/scripts/Makefile.clean
> @@ -3,7 +3,7 @@
>   # Cleaning up
>   # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> -src :=3D $(if $(VPATH),$(VPATH)/)$(obj)
> +src :=3D $(srcroot)/$(obj)
>
>   PHONY :=3D __clean
>   __clean:
> diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> index e0842496d26e..8c1029687e2e 100644
> --- a/scripts/Makefile.compiler
> +++ b/scripts/Makefile.compiler
> @@ -13,7 +13,7 @@ cc-cross-prefix =3D $(firstword $(foreach c, $(1), \
>   			$(if $(shell command -v -- $(c)gcc 2>/dev/null), $(c))))
>
>   # output directory for tests below
> -TMPOUT =3D $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/).tmp_$$=
$$
> +TMPOUT =3D .tmp_$$$$
>
>   # try-run
>   # Usage: option =3D $(call try-run, $(CC)...-o "$$TMP",option-ok,other=
wise)
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 12e7c15d099c..78d2ca4f25f5 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -111,13 +111,13 @@ endif
>   else
>
>   # set src + obj - they may be used in the modules's Makefile
> -obj :=3D $(KBUILD_EXTMOD)
> -src :=3D $(if $(VPATH),$(VPATH)/)$(obj)
> +obj :=3D .
> +src :=3D $(srcroot)
>
>   # Include the module's Makefile to find KBUILD_EXTRA_SYMBOLS
>   include $(kbuild-file)
>
> -output-symdump :=3D $(KBUILD_EXTMOD)/Module.symvers
> +output-symdump :=3D Module.symvers
>
>   ifeq ($(wildcard $(objtree)/Module.symvers),)
>   missing-input :=3D $(objtree)/Module.symvers
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index e52cb43fede6..0e6bc5a10320 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -80,11 +80,7 @@ command results in a shift count error.'
>       NPROC=3D1
>   else
>       ONLINE=3D0
> -    if [ "$KBUILD_EXTMOD" =3D "" ] ; then
> -        OPTIONS=3D"--dir $srctree $COCCIINCLUDE"
> -    else
> -        OPTIONS=3D"--dir $KBUILD_EXTMOD $COCCIINCLUDE"
> -    fi
> +    OPTIONS=3D"--dir $srcroot $COCCIINCLUDE"
>
>       # Use only one thread per core by default if hyperthreading is ena=
bled
>       THREADS_PER_CORE=3D$(LANG=3DC lscpu | grep "Thread(s) per core: " =
| tr -cd "[:digit:]")
> diff --git a/scripts/nsdeps b/scripts/nsdeps
> index f1718cc0d700..8ca12e2b5c03 100644
> --- a/scripts/nsdeps
> +++ b/scripts/nsdeps
> @@ -19,12 +19,6 @@ if ! { echo "$SPATCH_REQ_VERSION"; echo "$SPATCH_VERS=
ION"; } | sort -CV ; then
>   	exit 1
>   fi
>
> -if [ "$KBUILD_EXTMOD" ]; then
> -	src_prefix=3D
> -else
> -	src_prefix=3D$srctree/
> -fi
> -
>   generate_deps_for_ns() {
>   	$SPATCH --very-quiet --in-place --sp-file \
>   		$srctree/scripts/coccinelle/misc/add_namespace.cocci -D nsdeps -D ns=
=3D$1 $2
> @@ -34,7 +28,7 @@ generate_deps() {
>   	local mod=3D${1%.ko:}
>   	shift
>   	local namespaces=3D"$*"
> -	local mod_source_files=3D$(sed "s|^\(.*\)\.o$|${src_prefix}\1.c|" $mod=
.mod)
> +	local mod_source_files=3D$(sed "s|^\(.*\)\.o$|${srcroot}/\1.c|" $mod.m=
od)
>
>   	for ns in $namespaces; do
>   		echo "Adding namespace $ns to module $mod.ko."
> diff --git a/scripts/package/install-extmod-build b/scripts/package/inst=
all-extmod-build
> index 7ec1f061a519..64d958ee45f3 100755
> --- a/scripts/package/install-extmod-build
> +++ b/scripts/package/install-extmod-build
> @@ -51,6 +51,13 @@ mkdir -p "${destdir}"
>   if [ "${CC}" !=3D "${HOSTCC}" ]; then
>   	echo "Rebuilding host programs with ${CC}..."
>
> +	# This leverages external module building.
> +	# - Clear sub_make_done to allow the top-level Makefile to redo sub-ma=
ke.
> +	# - Filter out --no-print-directory to print "Entering directory" logs
> +	#   when Make changes the working directory.
> +	unset sub_make_done
> +	MAKEFLAGS=3D$(echo "${MAKEFLAGS}" | sed s/--no-print-directory//)
> +
>   	cat <<-'EOF' >  "${destdir}/Kbuild"
>   	subdir-y :=3D scripts
>   	EOF

