Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9713C6FD18
	for <cocci@archiver.kernel.org>; Wed, 19 Apr 2023 15:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=mZXtJ6fNtvkIltdDYa8v3MhZsN0r27fPYvulUxn1iyQ=;
  b=R0h17k3hAURNX7+84+VbK1CXyqh1GIcKCriBhhOtM6/Bd2O0ypgw1imU
   EciwuEgXmXf2qaJqqavveo9wOlEgh0jconVuC6rzs5CSe8SpdEagWUsvY
   v1YdbIoYRHezg7Mh4PqsasTFC1sd7an7v1535CHECsdJZ9gk6C/oscZTg
   Y=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.99,208,1677538800"; 
   d="scan'208";a="103846710"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Apr 2023 17:51:23 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 30C1EE0133; Wed, 19 Apr 2023 17:51:23 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E9388E0138
	for <cocci@sympa.inria.fr>; Wed, 19 Apr 2023 17:51:17 +0200 (CEST)
IronPort-SDR: 64400de7_Lg8hTeDfccO2fOaafPMVp6g6bPrJ/XzwpJxMXjs/bh6y0Sf
 tB1cdS5GNmybYyWMPurvKtqBqmjPaxnHF3RP07g==
X-IPAS-Result: =?us-ascii?q?A0FPAABlDUBkhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItdVYvBAtGAwUihCmIHYkZhDCObIRnhAOBVoFAPg8BAwENOwYBA?=
 =?us-ascii?q?gQBAQMBA4FJgnA8CgJrhFECHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFA?=
 =?us-ascii?q?QEBAgEBAgQFAQIQAQEBGgkXBw4QBSKFaA2CNykBEVYOgQYCAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQESAg06PgECAgEjHQEBESYBBAsLGgIfBwICVwYBDAgBA?=
 =?us-ascii?q?YJ6AYInAQMOIwcMBqsSgTKBAYIIAQEGnAsfLCJUgV4DBoEULQGMVD+DNnonD?=
 =?us-ascii?q?4FVRIE8glMxPoJiAQOBXoNbgmePBosjRYE0doEgDoE8gQQCCQIRa4EQCGo5g?=
 =?us-ascii?q?UBAAg1kCw5xgUljTIF7BAIUNg4OGAYXJQQOAxkrHUACAQs7Oj01BgMLHwZWa?=
 =?us-ascii?q?wIJIxETBQMLFSpHBAg4Bhs0EQIIDxIPBiZEDEI3MxMGBVcBKQsOEQNOgSIfB?=
 =?us-ascii?q?gQkC1x8CgYBJiScUoJmgTnGCDQHgiuBVoFZDIoNlQAGEy+DagESjGaGJg4Gk?=
 =?us-ascii?q?iUuhzKQFyCNM5pMgWM6gVwzGiSDNk8DGQ+OIBkegzszjwkBPj80AgEFNQIHA?=
 =?us-ascii?q?QoBAQMJhUYBAYV9AQE?=
IronPort-PHdr: A9a23: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
 CSdljEFdGVeD5IX
IronPort-Data: A9a23:Ou1vrale6fxVCYm5yCcwr6jo5gyTIkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xJMDDvUOfvZNGT8f412PIq+ph8PvpfSzdVhHgI/+yo1HltH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvymTrSs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82MyYzN8B56r8ks156yu4WJA5zTSWNgS1LPgvylNZH4gDfrpR5fIatE8NvK3Q
 e/F0Ia48gvxl/v6Io7Nfh7TKyXmc5aKVeS8oiI+t5uK3nCukhcPPpMTb5LwX6v4ZwKhxLidw
 P0V3XC5pJxA0qfkwIzxWDEAe81y0DEvFBYq7hFTvOTKp3AqfUcAzN1NKBwUALVF4twuQjlD1
 qw5cQEwMiGc0rfeLLKTEoGAh+wmK9T3epwSsDdswFk1D958GMqFGf+Vo4YFmmxYasNmRZ4yY
 +I8YCBscQ+GThlBIFYRB7ohke3uinSXnzhw8QrO9fZpvjiNpOB3+OTGHsHFKs2vedR+pmSYu
 lnjz1jiUyhPYbRzzhLcry7y37aR9c/hY6oZE7az99ZxkViLzyoSDgcXXB21u5GEZlWWXtVCN
 woL9yBooaVaGFGXosfVfDnlgkO84wYmApkIHs5qyVi89/bl/FPMboQbdQJpZNsjvc4wYDUl0
 F6Vgt/kbQCDVpXKEBpxEZ/L9VuP1TgpwXwqOHZaFlpUizX3iN1t10iSJjp2OPPt1rXI9SfML
 yeiigxWa187v8MV2qOx8ErIjjTESnPhElFrvG07skqD6RllZMaPfYWi4F7Hhcuswa6cSUSd+
 mcJkY6S4Yji7K1hdgTdEY3h/5nzvp5p1QEwZ3YxRvHNEBzwqhaekXh4um0WGauQGp9slcXVS
 EHSoxhNw5RYIWGna6R6C6roVZRznfS6S4+8Cq+MBjarXnSXXFDXlM2JTRHPt10BbGB3wcnTx
 L/GLJbxXC9y5VpPlWvvHrt1PUAXKtAWnD6PG8mikXxLIJLHKifdSLEZPUGIY/xx5azsnekm2
 4Y3Cid+8D0GCLeWSnCPr+Y7dAlWRVBmW8yeg5EJJ4arfFA6cEl/UKW56e16JORYc1F9zbqgE
 oeVARMDlzISRBTvdW23V5yUQOm2BcYi/SlhbHdE0JTB8yFLXLtDJZw3L/MfFYTLPsQzlpaYl
 tFVJJ3SMecFUTnd5TUWYL/0qYEoJlzhhhuDM2DhKHIzdoJpDV6BsNL1XBrdxA9XBAqOtOw6v
 +KB0CHfSsE9XAhMNpvdR8+u6FKThkIjvtxOcXHGGOQOR3W0wrNWc3TwqtQVP/AzLQ7yw2rG9
 gSOXjYdi+r/g64019jr3pK7jpqbPNZ/OmF4HGDry6m8GgeH32ikwK5GCP2pexKEXkzK2aySX
 8dn5NCiD+8ig3BxrJtaL7Zn6Ykc9unfjeZW4So8FUqacmnxLK1rJ0e3+PVmt4pP9+d/ghS3U
 EfewetqE+yFF+29GWFAOTd/SPqI0MwVvTzg7f4VBkHezw0v9ZqlVXRiBTW9uBZ/HpBUbrx8m
 fwAvfQI4TORkhApa9aKrh5F/lS2c0Avbf8ViYE4MqTK1CwbkkpPcL7NOB/QuZuvUehBAmMuA
 z2ThZfBuYhi+1r/QyIzO0Tgjet5rrYSiS9O124HdgiomMKap/oZ3y9x0DUQTyZJxE55i8Z1N
 mxaNhB2F56v5BZtvtBIBEq3KjFCBTqY203/8EQIn2vnVHuVVnTBAWk+GOSV9mUL2jh4Uh1E2
 oqH2UDZUTrOV+Pg7BsYAEJKhaTqco1sy1fkhsuiIfWgI7A7RjjU2omVemsCrkrcM/Mb3UHoi
 7Fjw7dtVPfdKyUVnqwcDrua35Q2TDSvBjRLYdNlzZMzMVDsQhOA8hnQFBnpYeJIHeLAzmGgA
 c83Js5vaQW35BzTkh8lX5wzM51Gt993wupaYb76B380g53GpBpTjZ/g3CzfhmgqftZQrfgAO
 r7hLzKvL2jBqkZXyknsrdZFMFWWedMrRhPx98Hr/fQrF6AsivBNc0Yz3uGKvlGQCg9G/g2Vj
 izHdaT53+xv8qUyvorOQ4FoJRS4FsP3b8uMqDuMitVpacjdFOvzrCYXlwXXBBtXNr4vRNhHr
 7SBn9rp1kfjvrxtcWTmt7SeNqtOv+OeYfF2N5/pEXxkgieyYs/gzB8d8WSeK5YSstd85NGid
 jSoevmLat8ZdNdM9kJ7MxEEPU4mNJ32SaP8qQeWjfeGUEEd2DOaCuKXzybiaGUDexIYP5H7N
 BTPhM+vwdJm/bR8XEpOQ7ksBpJjO1bsVJc3b9C753HSEmCshUjEobf40wYp7TbQEHSfDcLm+
 tT/SwPjcAip8rT9pD2DX1eeYjVMZJq8vQUxQq7Z09txliz8E2MMa+gQWXnD5le4jQSqvKwUp
 hmUBIfhNck5dStJe1Pw7bwPmy+BU/cWNI6RyiMBpiuphuTfOG9EKKRs/GFs7h+av9clIP6Pc
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:Urvrgaz2WmmK8FN8QunoKrPw+L1zdoMgy1knxilNoNJuA6mlfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebnN5DNB7foSjjPIceoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: =?us-ascii?q?9a23=3AR0Ja3Wg60ncLYNWGC9GzWtOgSzJuUVmA7krofle?=
 =?us-ascii?q?CUCUxRZ7FaAahxf9VjJ87?=
X-Talos-MUID: 9a23:oig+iQvcCJ4YEmBF1s2n2BpML9c48oGSGWs1s5UagOy0CTchAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,208,1677538800"; 
   d="scan'208";a="103846586"
X-MGA-submission: =?us-ascii?q?MDEBv1cyYqihPE5hPRfve/pYHJ4DQ6CVxcHecm?=
 =?us-ascii?q?T5tc+6A3NAyTwLuwV2KM173rW5aisRq2o6ZnQQpBg9dHATiIt6VpK7Oz?=
 =?us-ascii?q?3XhVJlPnj1OS7APjsaX2tJgx40QJSf2+6PgcHj5FMGNtMC/0Gbx8mGzg?=
 =?us-ascii?q?ytLJayCCe6tVo7AtFfohoyKg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 17:51:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681919453; i=markus.elfring@web.de;
	bh=mZXtJ6fNtvkIltdDYa8v3MhZsN0r27fPYvulUxn1iyQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BFopDl9iB632j1+gM/dotHZV0G9rN8hgrNvLAi1MC2cZeJkoAVj5EdWy0hYDNebev
	 g9nTk2pfuRbQ3ZQh8PKpS6Ff3Z6PFb1KNG9MfWHGHvyweKOKBmkVWjKLVGZeMR3hBc
	 DO6EJEgmci3xBErMgrihsUpcs/hTlKu1P/HxbBwyGqGxkOoDLuZrESL/uBj5I/dR2I
	 ebJtFM2baKrEUf4TfYurFFocgX/PmqFazjh6WP1CXK2/GS4qz71xESL9VjzyMSslli
	 Vgkw7+ca/HJQCmZPKBhN0UkLsOzTEJG608fVVcxbq9WFeVVGfYbKEB/I3zE0FRQNrf
	 BAusb8Xl1p6Og==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MA4fW-1q0jsF1ugc-00C0xb; Wed, 19
 Apr 2023 17:50:53 +0200
Message-ID: <6089720a-574c-c607-c9d5-7bb026806feb@web.de>
Date: Wed, 19 Apr 2023 17:50:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
To: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>,
 kernel-janitors@vger.kernel.org, linux-media@vger.kernel.org,
 linux-staging@lists.linux.dev,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <d8ed4e5d-49d4-ca7e-1283-1ec166bf643d@web.de>
 <ZDmJsemYldOsMMrH@smile.fi.intel.com>
 <9b243f3e-92ad-197f-f0a6-b22eaf71238a@redhat.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9b243f3e-92ad-197f-f0a6-b22eaf71238a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DLjqWpg9bOFnVLWT6MWNo18Pxf59m4of0cfkZHDwBZLf39gjeUO
 RtU6KTgpcLLbiAc5IfxscYK2ykatgWJpF0k4spFWKuuX/Lkjo/eM60BWk22drFQiwza/ZDc
 twldF7/LN/ulMiEv+oI00I9P1yUYgwZiFoqsajYn9/+ZWas1dCj3qgIENn2BqqIY4KRNbdE
 8504T3y4QatdTyHS/C1FQ==
UI-OutboundReport: notjunk:1;M01:P0:87qkBYVd3W8=;sNHOOakk3oUaBOA4EY394fAKrCV
 ZdrY96O2K8VED16RqNxDgB6BDDkTf/oxSYq4YHjiCLJox6iNiDRzgVYbrHLv86Pz5dIfsdXPk
 S+C7ozw0vF57LIWxKAVh40OPpHz+RghLJRQzZ5dO/GwqsEZkooDkhHT4vHzPpxv0JMpnGDMnd
 zm8gBrTXFtydnVjTXzWiMT35/xduxDNY0u0+M2Dc9pD6y6G1VdD7oCrpo/hbrCTxDlSKYiuvG
 IcoBWoTp750dqdTrNealvrMqQzbUl/rUmnuI3EinivFZaheOqtNtK+d1ZA/1k3//bYqgdpzC1
 Od6XuKQHiN3kQjQS7K8TwFq1OTxBptlRj3t8xpQ6Z8Ayhp04f4Y9svJ/KE1YBC1ttSdTjcyLP
 meJFh4MLN9OB+AFRqISDbOn+p0UMcIdFHKa5bR7GAWGKWbhWgHEVqmJY7cjZ6hwexdzu4RUFM
 V10ejeH5Mnewi7IEOuWKCGeNPx/VGhH4xccyjgGrMkxV5BIY+2AzB7PIM02R46/f/E0BpbaY0
 RpSPoszbdbBQ+q1xiLEbjy3rt0Rwlx5PHcaKJZAiBIE4zEsT7Tmu5bHQyevQJT1TRPsLJYVHM
 QCHdsIwGm8AEl3fn69RRpS1u7lYNCQueHUqGB8DrTkQaCulw8KkxqB9f9p1fvGnAiNky2I/h/
 MCzX14Jd9GipEmsYCgTQc9g4jJXo9LI3DAbIldERzFJ1WIyGtK8jpf8ylbNgKYhXmVlWsXddJ
 0V65AmG+QDCUf+JNecbdyyOw3Y7RdRSD1zFnqnsBO0675HTeHjOEJfiKgDmSFxgcx0/3SB6Hk
 hE6Hj3xKvuF44gqeRhozsbvlMbU22SR4uJ2I4C7ClKuDFCw6Eifsi2xyauoODuuM8owjSVlhu
 lx7JbN4vSQKH+363t7oe6FqHPM+Sa3mkCyU5ukPQ0T21yw08r1WL8BDph
Subject: Re: [cocci] [PATCH] media: atomisp: Move a variable assignment
 behind a null pointer check in atomisp_cp_general_isp_parameters()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1094
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/6089720a-574c-c607-c9d5-7bb026806feb%40web.de>

> Instead of this patch, can you please audit the callers of this function=
?

Would you like to add any advices for a similarly affected implementation
of the function =E2=80=9Catomisp_set_parameters=E2=80=9D?
https://elixir.bootlin.com/linux/v6.3-rc7/source/drivers/staging/media/ato=
misp/pci/atomisp_cmd.c#L3619

Regards,
Markus
