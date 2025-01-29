Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52C2C0218D
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 09:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=RmUlpFblDQ0X0FrPNxA6WyeicYW3HpJ3EyGlM0jP5z0=;
  b=HGO4z73G+LmM24POWIBHFgmGxTwqR0spmsIwwhNrGDKM/X67Xaio6WVo
   MQ6zB3TqDCLneq1YetfBQ2gCrWXsRSEqmyzTlT5dLwFjLr/UdA1Jr35WO
   EsdvX8H9IVgKex3u8V0f4M69pLHGEQOSR6xBunnaxvyF1N4WMD8u7cZ3O
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,243,1732575600"; 
   d="scan'208";a="205536403"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 10:41:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F3D8FE0D1D; Wed, 29 Jan 2025 10:41:03 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EEB39E0260
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 10:40:58 +0100 (CET)
IronPort-SDR: 6799f7a9_bdo7gAXzyu3uQVMw9H4dqfKKEQMtRqabor73tVnZG0ejJvJ
 RAn8Pig4vch54zH3yf79oDkpY9AeyxTkrnmPTZg==
X-IPAS-Result: =?us-ascii?q?A0ELAgC89plnewsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAQGCQn1aMwQLSAiETo9PgXQwhDuYBoFWFIFqDwEDAQ09BAECBAEBA?=
 =?us-ascii?q?wMBggyCdAKKdQIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAUIOCjGFew1JARABggcBgSSBJgEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAg06RAEBAQIBIx0BAREmAQQLCw4MAhEVA?=
 =?us-ascii?q?gJWBgESAgEBgn4Bgi8BAw4jBw0GtGWBMoEBggwBAQbaWx8sIleBZAMGgRouA?=
 =?us-ascii?q?YVqgmMBhWs7CYM5eicPgVVEgTyBFIE3OD6CYQEBAoEXRz+DHIJpgjOBD4IOg?=
 =?us-ascii?q?S9nhzWFd4IWJXuFVQQRWmyJKFJ7HANZLAFVExcLBwWBKUgDKjYxI4EmBTUKN?=
 =?us-ascii?q?zqCDWlJOgINAjWCHiRYgitrBAWBLYI7hEVgLwMDAwODNoVbghSBZQMDFhABg?=
 =?us-ascii?q?yd4HIIsHUACAQttPTcJCxsGPZ1nPYMRgS9ZJIIflmcBr0w0B4I4gWaBYwyKK?=
 =?us-ascii?q?ZUzBhMvhASNBoY6DgaSey6HZJBqIotpgXmVW4VOgW4OJYFcMxokgzZPAxkPj?=
 =?us-ascii?q?iGDejOBC4NVxH1CNQIJMQIHAQoBAQMJhUYBAYhhgW6BSwEB?=
IronPort-PHdr: A9a23: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
 QMqzBRza6Ih+WW0i7/SDkXHrm08nRtp8eg=
IronPort-Data: A9a23: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
 b4bh4dA3oxO5kEuhA==
IronPort-HdrOrdr: A9a23:tspPv6zMkI6BPgfpMveAKrPw+L1zdoMgy1knxilNoNJuA66lfr
 OV7ZAmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebjN5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:a8ecrW4DiE8uyz5TbtssxmNFGsEgYlrhy27yAU23I09vbuHScArF
X-Talos-MUID: 9a23:v57ZtAroG9QFX23wW3kez25ZZeJpz/2rNG8qwJ9F4s22FC18YDjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,243,1732575600"; 
   d="scan'208";a="107630845"
X-MGA-submission: =?us-ascii?q?MDEORDQdyhr6/SmSoYzEEWN3cfcz7DcmD7Ps1G?=
 =?us-ascii?q?Fss+eE+byD6PTS9c8sX+JIOIxdfT69Qq/qtsIWMu8x0IL4nR2GF4k0r7?=
 =?us-ascii?q?4EFuzeSefxGfVmmpReeOXPs4PUHfcW6cjbvi2gAeZSJaQFcRo61opbeH?=
 =?us-ascii?q?ZRE3hy70rwAgoabksn305Gqg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 10:40:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738143622; x=1738748422; i=markus.elfring@web.de;
	bh=RmUlpFblDQ0X0FrPNxA6WyeicYW3HpJ3EyGlM0jP5z0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ibsOXJKPJKhZo8FqJFepmaYQoSFoyR2qxzl8lohWNNUQx+2NF2ManFbNjUNGq/F2
	 gbw8iml79L7rvtKd56Ir7+yYHXrAe1EUIefoTtrBNrmtFI2yM2WYsLj1b568yC1rb
	 SKGUWYn0X41jPRogXjuGLSd6Gt6171dGmUJ2Fp3bc0pBO92HArHd48fDFFdCCxzPK
	 pf78m0ogusJQNS3QQ3zn1K/mM4iA6yn4B0KggTtABnb9cI7MMqnv247Vl4f+VntcE
	 +DVoabadzyBcjKoDGRsAmxtyEkjkG+dxMfHbTqq28F/8W87L00uXvdFhKdqm9Gctj
	 xUEgsrypLeLKtXHbAg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MG994-1tgKE62NvY-00Fdf6; Wed, 29
 Jan 2025 10:40:22 +0100
Message-ID: <9ca0337d-e378-4de5-99be-1dfa1d4f8cff@web.de>
Date: Wed, 29 Jan 2025 10:40:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Easwar Hariharan <eahariha@linux.microsoft.com>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-xfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 imx@lists.linux.dev, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org,
 Andrew Morton <akpm@linux-foundation.org>, Carlos Maiolino <cem@kernel.org>,
 Chris Mason <clm@fb.com>, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 David Sterba <dsterba@suse.com>, Dick Kennedy <dick.kennedy@broadcom.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 James Smart <james.smart@broadcom.com>, Jaroslav Kysela <perex@perex.cz>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
 Josef Bacik <josef@toxicpanda.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Ilya Dryomov <idryomov@gmail.com>,
 Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nicolas Palix <nicolas.palix@imag.fr>, Niklas Cassel <cassel@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Ricardo Ribalda <ribalda@google.com>,
 Sagi Grimberg <sagi@grimberg.me>, Sascha Hauer <s.hauer@pengutronix.de>,
 Sebastian Reichel <sre@kernel.org>,
 Selvin Xavier <selvin.xavier@broadcom.com>, Shawn Guo <shawnguo@kernel.org>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Takashi Iwai <tiwai@suse.com>,
 Victor Gambier <victor.gambier@inria.fr>, Xiubo Li <xiubli@redhat.com>,
 Yaron Avizrat <yaron.avizrat@intel.com>
References: <20250128-converge-secs-to-jiffies-part-two-v1-1-9a6ecf0b2308@linux.microsoft.com>
 <565fb1db-3618-4636-8820-1ca77dad07a2@web.de>
 <2402812d-b818-4d1b-9653-767c9cd89dda@linux.microsoft.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2402812d-b818-4d1b-9653-767c9cd89dda@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VVUayMb32w7y67C7tTjgB5AAr0xhckczX0N8TokrIpC9jN6eUE9
 EFsN7wRaBX0tQgtAxOLriEuyy3B/8avbPqaD1zz3GlxmzANwcYY0B13b3+dGcse9e29fR2B
 x1FDILYMT0Hm6Op4dZPmgiuO2ynGivSf8q+hlfpEEa8MIXRg6GY1vfPop11AepKnCCaop1O
 +p76d5j2Efo5XT3k24tTg==
UI-OutboundReport: notjunk:1;M01:P0:tcxCLGC+RCc=;ey0yBxZW/tRSJQW6qo2D+Q6kDrW
 B7ti/3QUhXC8WrcBjNzI4u6z+d1rV4adoqTUoUSMt/DqJcKI/DlrivOEoz806s/5+Kn56DDqL
 LU9xtxxU9vsLyCTP7I8gL7dl6Qx1gz/cso735SydkffMPYwAsbCaRqy9WGoFqBlIQ9QCxafc3
 W4RbDo3aQwMCu9VcGvB6j+H5tbohMyIwgg8IKKOqedJ1nboWwMgz4OIZ7EST+13jVvGHzPDUP
 RMgEYGdAiBMWyxIajIWHh0tiMSE3p1A+yPFCKxzA51+Jsl4lqfDwp6i6xfZI0wLLB4pLlY9o9
 4q4fn10BcFNZy38f62U9iuLflyBSQy3IDj2SnmtLJbJzYINTq3rTIPHq21PIW76G8fDbFN0aG
 3ac6gqwYlxfQhltWeUu6Jf+r0y/8ZDSvg6BenYTc1SAFAqZHEM4upcrvZQorHyWClmJeL4R1d
 pwRYkmLBgkDzN9R/bb0jfrgkgXUIzdRpQYEu62HTHwYHvlMnYXeCcivCQRHgqKox7R6hNuIrn
 rxTrTFacoaE+vqTHL959kdf+7baowrszBGfdV4G67c90sFgZ24V7UDmogT/jAdPtbbKWpCJ3F
 kMrOyabr3gWq6SX50hyVFHIUca6hdwNAbHNQqpbFNzCXjeuhFqIkBldPkgoHIWodZqGhWHxbJ
 rh9yga8+A7Xz90bS7If3X8UB0JOiOJoqee5k8VuGqGUor7M8/IYAWxEzk0sfRhZN5x9gzYIwj
 z5v+Opf6qMCYFMEpDc5oZNLzukYChx6b04HyYvuAIbzbqHM64L8pCx9PjiofRQqAAUENSsyVK
 wSLOByWJNd0hj3dnFK4MWKIc72WDX2na+gBRF+CITUiUaTapl8UB+IMJ1+mNkz1dW85FtBpIj
 tD/0moj9gcbkIb1LR6m5OI0uHLkCOXIBTrIfx3IHv6b13SsYXuqGkV/RzTBhQpQUsnir3VJIj
 cVkG88L1qB1XMwvpL5WZaIlaVUahCedhQsFB49sgDWhVH58n5+/Z9aWfVKo9SGwG1/1EYyVhs
 xdj7mKATCRxJL8YFYbK1K5zFB2c5chXeAOrRuI6GfbxLg4Jr5TwIV+gUIoOLkM9oBMdE3PZmY
 FmuKpySVCwL9uRLQ0lYfPXIDXqcQix+7IQpKOnC7/mKJSccV7o1cXqpz0osAScgdxIeUIW7Oo
 TT3dPmTAxqyMA5HLb2IdqDbNqBt78hG7Vp0fBYOvquK98imV2V34SSApTC+PTRD9nO5SEk1WD
 M5c0DPUlZtR3e/lmnDioWB77iUkT5JV0a7FRF40QmlHGvbSs8vfTQg9ZFgjUq8jYaGVb32YjP
 AEhromp4VpaoN9T5CJol8F+orrIemlZIcgjTh9W5NmdUN4pRCbHOUfJ/tbXwdPtCw5lPPfB1R
 5kdsgtTCg2hWVnV9uMjqAZCd/Sr1UngGlxpd0=
Subject: Re: [cocci] [01/16] coccinelle: misc: secs_to_jiffies: Patch
 expressions too
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2304
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/9ca0337d-e378-4de5-99be-1dfa1d4f8cff%40web.de>

>> =E2=80=A6
>>> +++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
>>> @@ -11,12 +11,22 @@
>>>
>>>  virtual patch
>> =E2=80=A6
>>> -@depends on patch@ constant C; @@
>>> +@depends on patch@
>>> +expression E;
>>> +@@
>>>
>>> -- msecs_to_jiffies(C * MSEC_PER_SEC)
>>> -+ secs_to_jiffies(C)
>>> +-msecs_to_jiffies
>>> ++secs_to_jiffies
>>> + (E
>>> +- * \( 1000 \| MSEC_PER_SEC \)
>>> + )
>>
>> 1. I do not see a need to keep an SmPL rule for the handling of constan=
ts
>>    (or literals) after the suggested extension for expressions.
>
> Can you explain why? Would the expression rule also address the cases
> where it's a constant or literal?

Probably, yes.


>> 2. I find it nice that you indicate an attempt to make the shown SmPL c=
ode
>>    a bit more succinct.
>>    Unfortunately, further constraints should be taken better into accou=
nt
>>    for the current handling of isomorphisms (and corresponding SmPL dis=
junctions).
>>    Thus I would find an SmPL rule (like the following) more appropriate=
.
>>
>
> Sorry, I couldn't follow your sentence construction or reasoning here.
> I don't see how my patch is deficient, or different from your suggestion
> below, especially given that it follows your feedback from part 1:
> https://lore.kernel.org/all/9088f9a2-c4ab-4098-a255-25120df5c497@web.de/

I tend also to present possibilities for succinct SmPL code.
Unfortunately, software dependencies can trigger corresponding target conf=
licts.


> Can you point out specifically what SmPL isomorphisms or disjunctions
> are broken with the patch in its current state?

Please take another look at related information sources.
Would you like to achieve any benefits from commutativity (for multiplicat=
ions)?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/bd08cad3f802229dc629a=
13eefef2018c620e905/standard.iso#L241
https://github.com/coccinelle/coccinelle/blob/cca22217d1b4316224e80a18d0b0=
8dd351234497/standard.iso#L241


Regards,
Markus

