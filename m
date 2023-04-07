Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B35C77B61
	for <cocci@archiver.kernel.org>; Fri,  7 Apr 2023 15:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+VhtFEBqWMTXGfBkwo/JTyCoP72ca7xTCEp4b4NAGa0=;
  b=X1I9gbPlBKFl55cmMV78+JZzxfcvKqJVfU4Hxvkzfz5OhYdJQ5hMbxnf
   frhziTvrH27sl4Th7ks15QPF6ozaDjWK8qq9oDPj8gV12Y3+n5+B70tbG
   8ZS0LToYnySe6c/3jjxNVahJ64oBzEw4yU0OFU94XCikjmnsS3aFxnVyv
   0=;
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
X-IronPort-AV: E=Sophos;i="5.98,327,1673910000"; 
   d="scan'208";a="101614005"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Apr 2023 17:08:18 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0572DE7315; Fri,  7 Apr 2023 17:08:19 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BEE80E7312
	for <cocci@sympa.inria.fr>; Fri,  7 Apr 2023 17:08:12 +0200 (CEST)
IronPort-SDR: 643031db_Y3CBObAKgiL5UJI7ag/IGkpCf1Fgp7GGkR8TJnAJsUHkkPf
 DQhR23Jykl4AJ6EhY4y6l603d+/xAANJ6EKpjdw==
X-IPAS-Result: =?us-ascii?q?A0HTAACcMDBkhwsR49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBT4IugUsvBAtGhFORADGEMIcuhz6EaIQDgxY+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?IILgnQChT0CHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBA?=
 =?us-ascii?q?hABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAkc+AQICASMdAQERJgEPCxoCJgICVwYBDAgBAYJ6gigBAw4jB6wegTKBA?=
 =?us-ascii?q?YIIAQEGnAsfLCJUgV4JgRQtjQqDNnonD4FVRIEVJwyCdz6ERINbgmeCLIdQh?=
 =?us-ascii?q?G6CeohOCoE0doEgDoE9gQQCCQIRa4EQCGqBeUACDWQLDm+BSmNMgXsEAhQnJ?=
 =?us-ascii?q?QQOAxkrHUACAQs7Oj81BgMLIAZYawIJIxETBQMLFSpHBAg4Bhw0EQIIDxIPB?=
 =?us-ascii?q?iZEDkI3NBMGXAEpCw4RA0+BRgQvW4EBBgEmJJ5eUihfJoIxkiuOe4NKnhk0B?=
 =?us-ascii?q?4IqgVaBWQyfDQYTL5cJDgaSJS6HMJAVIKd/gXojgVwzGiSDNk8DGQ+OIBmED?=
 =?us-ascii?q?I8JAT4/ND0CBwEKAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23: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
 9igoiAZsz8=
IronPort-Data: A9a23:MjpGxK4yxGIxK4s3cF6tTAxRtCLDchMFZxGqfqrLsTDasY5as4F+v
 mUaUWqEPqyLMWfwfY8nb4rj9k8P7JbQyNRmQFNp+Xw1Zn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOC6UoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE0
 T/Ii5S31GSNhnglYgr414rZ8Ek05Kiq52tC1rADTakjUGH2xyF94K03fvnZw0vQGuF8AuO8T
 uDf+7C1lkuxE8AFV7tJOp6iGqE7aua60Tqm0hK6aID+6vR2nRHe545gXBYqhei7vB3S9zx54
 I0lWZVd0m7FNIWU8AgWe0Ew/y2TocSqUVIISJSymZX78qHIT5fj68VKE3BuIIsUweFUID8N2
 qQxNQ83Sw/W0opawJrjIgVtrsEkMdWtI44V/H1tpd3bJax/G9aZGfqMvIAehW5YasNmRZ4yY
 +I8YCBscQ+GThlBIFYRB7ohke3uinSXnzhw8QrM+/NssjmKpOB3+OHDc9Trc+2zfP1qnnm9+
 X/n30TiHihPYbRzzhLcry7y37aR9c/hY6oZE7az99ZxkViLzyoSDgcXXB21u5GEZlWWXtVCN
 woL9yBooaVaGFGXosfVbzmnkSaZuBInXPlxTa4VsCiQ9ZDx/FPMboQbdQJpZNsjvc4wYDUl0
 F6Vgt/kbQCDVpXLGBpxEZ/L9VuP1TgpwXwqOX5cFVBeizX3iNFv1E2TJjp2OPPt1rXI9SfML
 yeigAVWa187rscR076h4FDK695HjseXF1Vqjuk7dkis4g5/IbG4fZC05F3R4OxPRLt1o3GEu
 2UY3deT5qYCAPlhdRBhos1dTdlFBN7faFUwZGKD+bF8p1xBHFb+LOhtDMlWfhsBDyr9UWaBj
 LXvkQ1Q/oRPG3ChcLV6ZYm8Y+xzk/i4RYy4BqqKN4MWCnSUSONh1H4wDaJ39z+y+HXAbYlka
 f93jO7xUClBUP0PIMSeHrdHjONDKt8CKZP7HM2nkU3+j9JylVbMB+5NMV2SY/o/4b/MqQq9z
 jqsH5vi9vmra8WnOnO/2ddLczgidCFnbbir9ZA/XrPdc2JORjl8Y9ePm+9JU9I+xcx9yLyXl
 kxRr2cDlTITc1Wcc1TSAp2iAZuzNatCQYUTZH1zZQn2iyR6OO5CLs43LvMKQFXuz8Q7pdYcc
 hXPU5/o7i1nGmufqQcOJ4LwtpJjfxmNjAeDdXjtKjsmcpIqA0SD9tb4d0G9vGMDHwimh/sY+
 reA7wL8RYZcZgJACM2NVumj4WnstlcgmcVzfXDyHP9tRGvW/rNHERfB1s0MH5lUKDHo5Cer6
 AKNMBJJ+cjPu9AU9ffKt4ClrqCoMbBMIWtHLUbm7JKdFyrTzky8y6BuDceKejH8Ujvv2aOAP
 O968dD1AMclrn1r7bVuNqlN9r0vwefvq5tx7BVWLF+SY3uFUrpfc2S7h+9Rvahz95plkAqRW
 HPX3OJFOL+MafjXIHRIKCULNu28hOwpwB/M5vEIIWL/1i993JyDdW5wZxCsqihsHIFZAbMf4
 9UKmZApslSkqx8QLNy5oDhe9D2MIlw+QqwXjMwmL7GxuDU76GNpQML6Onft7YCteud8FBAgA
 gWpiZrog5VewUv/cEQPK0Xd4NoFhboylUBL6HQgO2W2nsH0g65r/R9JrhUyYAdn7jRG9ONRJ
 mIwCRVRI6mKzjY1h/p4fnuNHjtZD0az4X3ByFoulUzYQXK3V2fLEnYPBOaV8G0d8ENeZjJ+7
 pjC7ErAThDRY9DX4is+fWVHus7TZ4V92SOakf/2AvnfOYcxZATUp5OHZE0KmkPBOtwwjkiWn
 tta1r98RoOjPBFBvpBhLZeR0IkRbxW2JGZiZ/VF14FRFEH+fACC4xS/G3qTSOhsecOTqVSZD
 vZwLP1hTx69jSaCjg4KDJ42foNboqQb28ogSJjKe0g266CSvxh4gqL2ryLevlImc/9qsMQ6K
 77SSQ68L3yttSNqvFHJ/eZ5OTueQNgbZQfD8vi/38cXGrki7ux9U0EA/YGlnneSMQc9wROwu
 TnHRq7Jzt5NzZZnsJvsH55iWSS1C4LXf8aZ/D+jt+9haYv0Dv7PkAcOuHzLAh9zP4ZNa+9ol
 L+IjsH77HnFsJkyTWrdvZuLTItN2umfQ8tVNZjRAERBvC7fRvLp3QQPy1q4JbNNjtlZwMutH
 Cm8ScmocO8qS8Vv/2JUZwdeAiQiJfzONIm4nhyErtOIFhQ5+i7EJon+9XbWMEdqRhVRMJj6U
 gLJq/Ki4+5Dl7t1BTgGOaBWM8ctahurE64rbMb4ujSkH3GlyAHK8KfrkR07ryrHED+YGcL9+
 ojIXQX6aA/0gqzT0dVFqMZni3X71pqmbTUYJSrxOuKaigxWyEYDKvkBd4oLANdYn0QeEX0+i
 C7lNAMf5efVBFyosikQJPz8Uw3ZCuFm1hLROGky503NA8upLNroPVainxuMJ19pdzGlwOzPx
 RTyPJHvFkDZ/6yFjtr/KhB2bSmLCx8aKr81FZjBrvHP
IronPort-HdrOrdr: A9a23:Y6B7hKuuXkVrjFeqa51CnHU37skDotV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,327,1673910000"; 
   d="scan'208";a="101613991"
X-MGA-submission: =?us-ascii?q?MDHKKHOxyRGihdCJViZcaO/V94nNBzbpg6DIuc?=
 =?us-ascii?q?KudM3S9BG9hSPlAWOqehPpMIHvQSByRsYeeDatVnF4fvdRnMYdQMSQwp?=
 =?us-ascii?q?Z+kGcAU53s/1vGMCPoGN++pZHo7FFufM6EWB1+qS86oNode+N231B1lk?=
 =?us-ascii?q?g+CXT4itbF1F2HIes0zwKaBg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 17:08:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680880068; i=markus.elfring@web.de;
	bh=+VhtFEBqWMTXGfBkwo/JTyCoP72ca7xTCEp4b4NAGa0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=uYHaBrzGcLlL7PID0Tub5m98FVH3XUBZsE2UNEVhDRoroyA2kWAwcaYFh3k8J/L8Z
	 Y7QKWSDM4Icz0/x4U1ODh5jXOdxdpEVNmPy3mcdt0a2KEBMfwPLcbey6GLpcD7pXDM
	 FXK1UZbYhLMI9CPEn6m3i42rRS38cC+lwpuV/Frrk2mtiv1N3Q27C9wWhzr8Qb0boR
	 OfUzIJWE/qeeZ2bzkRh9fckIGDGl3zcPt9NY6UI812KAthij+em3IwcSvjEASg25Iy
	 PT3GckTHCvfzAfcB2CsVl6Ck3ChgSKZ2BtB4XatGdgJ865He0UN2ooKleOFCyA6/Up
	 wI8xryDJwqZQw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzCED-1qYDBf0fHH-00vw9l; Fri, 07
 Apr 2023 17:07:48 +0200
Message-ID: <78c25b4e-89af-6148-754f-b8214c602a5c@web.de>
Date: Fri, 7 Apr 2023 17:07:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
 kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Mark Brown <broonie@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Yang Yingliang <yangyingliang@huawei.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
 <82aebf6c-47ac-9d17-2d11-6245f582338e@web.de>
 <e3e704f5-3719-637a-8bc5-3a24e2e7cb92@microchip.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e3e704f5-3719-637a-8bc5-3a24e2e7cb92@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4ljIYJQWAoLNox7PswPxx//sD/E0zR3N5YE49Ohuzq3kkQDB9B+
 TjwTR2N9Mxm44bb82WCzmv913HjzNCFbfh4oSOp0hyaaEUljlAdoMzQv0tKM7XkgbSZxvW0
 6q3NGfergygg+yeLFitAq3iy/xGPiSRnLrJe/cbxS+Va+7ebzFkNu1pCLhL+fvgex6K9Uwi
 ftcheAFKtkJei61LDww/w==
UI-OutboundReport: notjunk:1;M01:P0:iNdXV6/2WoI=;z1DsLVGa7+LuogD9W4eXZSBnEJm
 UJ3/Nf+zJ3/MowyF+Ccif6aldGDJ65g2esleISR7jxEVVkrUXt0/gJJdzTbrBMSSCtzPlushQ
 xgt/uAhGbJ3FPs8NgACvAF5eraA9kW0AykhbMXmBsQ2PneoeaKmqjzDVxEgFReZU4lEOmhKpM
 fcW05pz4cfJEoUH7ap0ntTo07Nbc63QMfiDn1LyHAbd1cE2c52xXIjNWzwHF1Wm6iOZeoOSnk
 Ccp0f/mK4cVjPOZbFmXVgC9KlO625llqFmNDJoE1TFiCk0wOHXPPlxGQtlPSWJNQniMPOrsJH
 wQInnCcDodA4Xsz+1OgvK8PG4c1Cg6ZOQ+0K4xkrDlAxF/8AOmVKpRp68frPUWCzn3ipbQM68
 F5i5VDsM5OchskJjdfNSL6UOWBOy+wNwp1kBljMtvnydECAvxbo5Lou6fMAmSgnl4YUDPWFfN
 YeEbu98OTbEVdIRdZxrIc0oYEmblTKBhLPYX4TXLeLU6634A0RvjCMjZjuY/NUsNkomxDL3Ze
 XZY4vMmmQXWqMxIeCaHJI0rSTR9GOimsNz1r3c/A/2n7hwM27ffD5ozTTfBwZV2Q7sM/1Sz0w
 s0QLeRmOoaBnb0kfZmTOCSPf16YWCRxpPiCTJRi1oHllfdLOpNA1JNqdHy8snZ87HbDyClNSN
 t+1moFa9Fn7lqF6OFryC258WlWDpSe7TzihtfBKS8BGN7502WKbKmnwFK1/FOP12stRpdi72F
 ZNOwOJ6425y/ki/vV/76EPI4m7SACL4Zi2aImsGnHwJQ1Bg9xSNDQMj2hN+/EtZyUdsxwvMRD
 suDocvRSvZo0uOr9hUeHRw7Cvu1NzQGWCYPEYMgcyZvg5itJ9cRB2AeSXLoMk9JMH5UpKcKrl
 yTfrfgEQF3Ai42zh+4noUAkUos5r0yVBPXyhr68HTZfL/hnrbeKmimewH
Subject: Re: [cocci] [PATCH] spi: atmel: Improve exception handling in
 atmel_spi_configure_dma()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1012
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/78c25b4e-89af-6148-754f-b8214c602a5c%40web.de>

>> The label =E2=80=9Cerror=E2=80=9D was used to jump to another pointer c=
heck despite of
>> the detail in the implementation of the function =E2=80=9Catmel_spi_con=
figure_dma=E2=80=9D
>> that it was determined already that the corresponding variable
>> contained an error pointer because of a failed call of
>> the function =E2=80=9Cdma_request_chan=E2=80=9D.
>>
>> * Thus use more appropriate labels instead.
>>
>> * Delete two redundant checks.
>>
>>
>> This issue was detected by using the Coccinelle software.
>>
>> Fixes: 398b6b310ec85eef9d98df5963d5ded18aa92ad8 ("spi: atmel: switch to=
 use modern name")
=E2=80=A6
> It's becoming a pattern, but still:
> NACK.

What does hinder you to work with more jump labels for improved exception =
handling?

Regards,
Markus
