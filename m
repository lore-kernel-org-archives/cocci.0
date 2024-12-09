Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4912E7717D
	for <cocci@archiver.kernel.org>; Mon,  9 Dec 2024 08:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kwpL+i0JJaYLWV+kub8k9GyfAkZbOl/8bgqt3XLi8Mw=;
  b=MO0B2qztUhwRTfxLlgd1LUewl0CL0gxuB840TMjtpN0Llp5+S4jWFvWq
   W/8qs/6jhSnr70gtOkj8XD925YjSLOeOueFeLavL44/QaM2t2KVKktcUu
   ZTTrjFS1Wk/FVutdh5UlDGdoxTevIG6aRegbWVLACdtldDw92hl//YtZd
   M=;
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
X-IronPort-AV: E=Sophos;i="6.12,218,1728943200"; 
   d="scan'208";a="198089387"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Dec 2024 09:33:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6B7A5E013D; Mon,  9 Dec 2024 09:33:41 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4AAB5E00B6
	for <cocci@sympa.inria.fr>; Mon,  9 Dec 2024 09:33:36 +0100 (CET)
IronPort-SDR: 6756ab60_KuHWnF6bLL41t597z0OS2MxfOcIqzNc/GVqbl/ggzlW/YjJ
 we4JKbC3PXirESipq0KHLjHYUuf5O4sUpuU/JGw==
X-IPAS-Result: =?us-ascii?q?A0G8AABlqlZngAwR49RaHQEBAQEJARIBBQUBQIFBBgELA?=
 =?us-ascii?q?YJDYiFUMwQLSIRWj02BdC0DhDuHO4dWiHaBVoF+DwEDAQ1BAQIEAQEDBIUAA?=
 =?us-ascii?q?oppAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBO?=
 =?us-ascii?q?wcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREmAQQLC?=
 =?us-ascii?q?xoCJgICVgYBFAEBgn2CMAEDDiMHrzqBMoEBggwBAQbaWx8sIleBZAmBGi4Bh?=
 =?us-ascii?q?WqCYwGGJoNCeicPgVVEgTyDAz6IHoJpgkGFemeKbYkqh3VSexwDWTIBVRMXC?=
 =?us-ascii?q?wcFgSohLAMuOTGCBYFbBTdHgklpSzcCDQI2giR8gk2BJQQFg2mBC4NehFqGJ?=
 =?us-ascii?q?oIZFR1AAgELbT03CQsbBj2cIIJmbERcfoILkzWdVJRcNAeCOIFlgWMMn1oGE?=
 =?us-ascii?q?y+XQw4GknqYeyKpCIFuCyiBXDMaJIM2TwMZD44hhC2+OEI1PAIHCwEBAwmFR?=
 =?us-ascii?q?gEBinyBSwEB?=
IronPort-PHdr: A9a23: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
 PIz
IronPort-Data: A9a23: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
 TBdeF2oi31XhaI8/QiMtpKV9NwkUOvT8ggV
IronPort-HdrOrdr: A9a23:Ui0YLq/klhOZK9SUK5Vuk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:ZkU1HG1NFpXcQ2Zq2otRsrxfQ558NSTv/krrAQyGCUwzSpqJdETO9/Yx
X-Talos-MUID: 9a23:Hr5jSAjOZi/7Fz/KSkC1DMMpE8Bq7bX3NHE3lLIPsPKHPwlvOgeUpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,218,1728943200"; 
   d="scan'208";a="198089353"
X-MGA-submission: =?us-ascii?q?MDHNksHOpPdv6rJS4JqR/nwAfh4lqDd1OYj83e?=
 =?us-ascii?q?obInVtfT3hpHSaEuRfrFr1XlGgQDwHLrlKMyuGnkQt0dOGZBLn4KcU+K?=
 =?us-ascii?q?Q4K/hraqOY3hF1NgaEnAkFWpdZP4J4h1nkl5lgVOgIykYuZlngcJLIfW?=
 =?us-ascii?q?h4JEIzkvbRjYjM24M6/wogrg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 09:33:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733733215; x=1734338015; i=markus.elfring@web.de;
	bh=kwpL+i0JJaYLWV+kub8k9GyfAkZbOl/8bgqt3XLi8Mw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uOKH6ruO70ykutPZgCyTHRhIEeQR+Etp3PBRXdPS79ahKo1ikHYTdJgqEYMGsBr9
	 AktTQCj4aysBXSoshG2qG6hdnCPP5RJ1t6DtiA89LO+B3wWAdypTLbfWBbooiB7o6
	 gmxPPJhP478aKSdrs7amHSmOoGo+xgK/v100j3+jkZSVjUWQlLszEIRtlAzHyqCma
	 T501klC6RfQfWE2KwEPCZX2LTwHzWJx+VppVv123Ru8dSqQ8HmD9Cg7dTX86KeqRw
	 8vgSDyFthpKD2ApPgIOh+sy9KXMDufw1Oc/DCAtE6usBlz3dc6dAlDLiRCGG0M7UG
	 c3gVNxwVSI4r1SdLiA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0qr9-1tWtQI1AVp-00uiRp; Mon, 09
 Dec 2024 09:33:35 +0100
Message-ID: <9692b27e-900e-4e8e-9ca0-4e2576fdcfda@web.de>
Date: Mon, 9 Dec 2024 09:33:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zack Rusin <zack.rusin@broadcom.com>, Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
 <6b81d431-36e9-7a7a-687b-2d7fc7aa6c31@inria.fr>
 <CABQX2QP0Vk5UZPDFDXThvzuw-gkam-4wU_xq3rbSmwi9x7cBHw@mail.gmail.com>
 <dff4cbd9-00c1-47a9-b2f7-fb2e98d04433@web.de>
 <CABQX2QPZB9uHMxKKoZA6f=+4f0ifHfft-rHcqd-Ck9rjo7-ShQ@mail.gmail.com>
 <1995b696-6825-a144-fcb-c5f9f3b1094@inria.fr>
 <CABQX2QOb9C4G3Kejo_ght3Dgo0qxHW5A6it4GB6TdgoU0Bo7sQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2412081042370.3332@hadrien>
 <CABQX2QMwBGJHnehxy4j0gHgmUWBBuFqncLWbDZWEdENtGOrZ3w@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CABQX2QMwBGJHnehxy4j0gHgmUWBBuFqncLWbDZWEdENtGOrZ3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sz4/LioY1pSAmqbJXzEQ4knlqkDkx89hl1tWp+Cr9KRDnaAqGYK
 YpdX1V5A1ZMuFevKPuyv3iKFon0pr9RF4HkuevyhmIeu88TB3wK2ClO2BVERLaisb+L7vqd
 CHnEVQ6h52HbACpAm+4iIprkAMRSEis1oh2blQ2fxLxdgA/3y+xHn3sZS7CKgHq204f3jy2
 K+VReFtsbsO00Np0kS1nA==
UI-OutboundReport: notjunk:1;M01:P0:akaPbwECXJs=;NVacNITZnK0IT/2QlptdAozXlnl
 tdaBj9KGa/yQjWVEe71eOevTBl3g4gUcGKrEM0/3jKbqGCvqsNpT9fyupdIQC/g+g2o/I5h6S
 Z/a6Kf2xhNvql3g5SZVqILBZR/sn/UYdFBPduEWIQz7VYXFP4JMKGPPLJfKaba7UQQSdvMgLS
 Q7irr6QTz9eR4rQVq4G+OQbKeqgbpRcU0VpGLtLEachKt5Z/fyY+5ztpXjlbzZa8NPwEifk8M
 3+aP3V4NSIShKGDjuXXcAcaQ5PqRYW0RVU0MiWH4J6xOsIFWHeQPxZp0gMbCZUQqfjjOCl3rI
 5s+PUlSn4da8l45VJy/ytsOMYKDMK/k7QHMSj7XCZo2BiEAbHRFzV57gKdN6YQSYoEJ7ArceS
 ddM+XZ/VqljbGph6JKLRSklYUmkd7BfQBNRTTL1JpehDwtRqfC0Re6jQUop/tlcKQbU03ETmP
 PyTPQre3xlkfiNynZ4issA1fuUAXWm8+Ue02+vJQyAHGLCeNlO/mrmoo2J/rubmp7GduKkGu6
 JKAx8hcVRKdpl62Jycon1SC6q+zExx+0BGIdnocT2oLNJSe9hWXKWi2rlFUN5kZYrBDY6/OOo
 jx4ErNFv2710V4Ciawkor4Pdfs39iUE/vrmf9R00dG9UrwGYX+vPnGqhjvm8xTWbKTp+SkK0u
 7BImBS+vewyQGO2+oN04gLT5hhQQf2mLrb9Fj9pnxL6KEmaDe1iSTlT4QBMCoQ8IHq2Yj7FzG
 njH/8dLzx1DJhztB99NlEr9gMlFhu5U8D2FkxPH6synwH2sOv2wN0xXSAYt3W+vB/fHfle/6e
 zZw98s/vcztsuHAhL7sKNRzTpZ4a8oxalrSUloCruyrMshOBtcVcs2qN18JZ9vI6YCLNkJvZ8
 59BDWCcz/M1rOHsD38+7FMc8RQZB6VPab6G2136giQPE0nr8D9I27zVHTRw2kSUjC1sMy4Zlx
 qDPcb/a8aDzOysVogu2+LULz1SUtqW0zSO+QEI+sy7KsIgFgSCSyPUinwVc/QTCXmMw8Rj2fB
 vWvwqtMCJpqvxSd0UnwScnp6yXQTTkCVMJVyPA7Wpn5/tPkTTtlYzgTQpa01B2JeQNeF5Np42
 gH+yu6+2g=
Subject: Re: [cocci] Replacing type names
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2170
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/9692b27e-900e-4e8e-9ca0-4e2576fdcfda%40web.de>

>                                       I was trying to fix struct
> declaration matching with:
> @r6@
> identifier i, i2;
> position p : script:python(i) { needs_rename(i) };
> @@
>
> typedef struct i@p {...} i2;

Under which circumstances will you get into the mood to omit the usage
of such a scripted SmPL constraint so that more desirable data processing
can be performed by subsequent script rules?


> I'm going to give up on this for now.

This is a pity.


>                                       Pure regex camel-to-snake works
> well enough for me

Despite of known development concerns around applications of regular
expressions for source code analyses?


>                    and even in its current form the cocci script is
> pretty complex

Such a view can eventually evolve further also according to the discussed
use case.


>                and it's still not handling all the cases

There are additional possibilities to consider for better handling of
corresponding case distinctions.


>                                                          so the odds
> of anyone else on the team being able to maintain it are very slim.

How will development interests and related resources evolve further?

Regards,
Markus
