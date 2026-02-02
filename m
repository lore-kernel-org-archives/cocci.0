Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC81D172DE
	for <cocci@archiver.kernel.org>; Mon,  2 Feb 2026 07:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=PR7cYvwkcOPK52VL+D2b6ZD6ihBbhN/h3VGnUEZUkEc=;
  b=cmzxBFvFbar3qOZsGS89Ab9fsAkLpYwQYWPq/wPHKfYecIU0aDbP9Z7P
   SjmfTGVE1q4X7/dccyp6WcNfdUOr5EQOmqeImsh1xu3/Mm8YKILY80eVl
   7XIlcCvqKpfYJab7C1S/cXjbUQYqw0vn9jJxhS13bUfXr2JO6W5x4Gjcg
   Y=;
X-CSE-ConnectionGUID: wIECkFWZSP+GYAb6jQgevg==
X-CSE-MsgGUID: LMKGIDcLRtiMp/0GBlMQ2g==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,268,1763420400"; 
   d="scan'208";a="261377543"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Feb 2026 08:01:27 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 2D377814BD; Mon,  2 Feb 2026 08:01:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id B8AD781505
	for <cocci@sympa.inria.fr>; Mon,  2 Feb 2026 08:01:23 +0100 (CET)
X-CSE-ConnectionGUID: sDtSqY+uSdeNxQyhMZlQPg==
X-CSE-MsgGUID: 4VmINtrfRa6Kbk6N4k+YKA==
IronPort-SDR: 69804bc3_+ogy7L34OkPLohnmXfrBjt1wul6ymFHnAuIrg/w1QWnHAh+
 MjOF9rGkBC7RWrFguUM4/OQ5lCmNVDx1OCFsIPA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FfCACvSoBpgAQP49RagQmBUIJBaB8GWTMEC0mEWI9Tg?=
 =?us-ascii?q?iSEO48OA4pOgX0CDwEDAQ09EQECBAEBAwSCDIIuRgKNEgIeBwEEMAkOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDjuGTw2CYgGBJ?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBAQEBAQEBFwINOkQBAQECASMdAQERJgEECwkCGgImA?=
 =?us-ascii?q?gJWGwEBgn4BgiIBBhABAw8nBw2WCpxIgTKBAYIMAQEG2mQfLCJZgWcDBhWBC?=
 =?us-ascii?q?i6FboJlAYpnJw+BVUSBPAuCeD6CYQKBYE2DDoJpgiaBDpQyUngcA1ksAVUTF?=
 =?us-ascii?q?wsHBYEjQwOBBiNLBS0dgSMhHRcTH1gbBwUTIyYcEgIDAQICOlMMgXUCAgSCE?=
 =?us-ascii?q?3uCAQ+GdIEABS6BCQ4iAkFeUgscMAIBC209NwkLGwQ9kAhEgzsZGCKCEMZIN?=
 =?us-ascii?q?AeCOIFngWQMii6ONIcLBhADL4NxAV+TAQ4GkwWZBo4JlXaFQoFoOoFcMxokg?=
 =?us-ascii?q?wIBM08DGQ+SITPELkI1PAIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23:f28laRAI82RHI4K4k4DyUyQU0UkY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua4xygeRFtyEtaMbw8Pt8IneGkU4qa6bt34DdJEeHzQksu4x2yEGPouuJHa/EsTXaTcnF
 t9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFRrlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5/I
 hq7oR/NusUKjoduN6Q8xxrNr3ZKZu9b2X5mKVWPkhnz4cu94IRt+DlKtfI78M5AX6T6f6AmQ
 rFdET8rLWM76tD1uBfaVQeB6WMSXWoPnhdWDAbL8Qn2UZjtvCT0sOp9wzSaMtbtTb8oQzSi7
 rxkRwHuhSwaKjM26mDXish3jKJGvBKsogF0zoDIbI2JMvd1Y7jQds0GS2VfQslRVjRBAoKiY
 IsJE+oBJvtTo43kq1cTsReyGQygCeXywTFKm3D2x7U33ecvHw7J0gMuAswAsHrUotjrNqgdT
 e+7wbLUzTXadf5axSvx5JbKfx0nvPqCXahwcc3UyUQ3EA3KlE+QqY/4PzOOy+8DvGyb7+R6V
 eKujW4npBx6rz+oyMg2kInJhZ8Vykve+St2xIY1K8e4SE99Yd6rC5ZRuT+VOJBsTsw/XW5lo
 SA3waAJtpCnZiYF0ognxwLBZPyddYiF+hbuWeKQLDtkhHxoZK6yihm9/ES+xOPxWde53lhUo
 idZjNXBuH4A2RzP58WDSPZw/1qs1DaA2g3c5exKIVw5mKjdJpU8zLAwkZ8Tvl7CHi/wgEj2g
 66Wdlkk+ui18OvreKnpppiZN4JylwrwMbwul9ShDeglLAQCRXaX9fq+2bH54EH0QK9Gg/Iun
 qTdv53WP8oWqrOjDwJU1osv8QizAymo3dkegHIJNkhKeAidgIjsI1zOIO73DfO4g1m0lTdrw
 O3GPqH7DpTDMHfMi63tcqtj5EJEyQozy85Q545MB70fPf7/RFX9uMLGAhI7KQC43ubqBM9y2
 48GXGKAGK6ZMKfcsV+S4eIvJvGBaogPtzbnKPgl+uXugWU2l18Zc6mpx5oXaHa3Hvl9LUSWf
 2Hjjs0cHmgUpgY+VvDliEWeUT5PYHa/R7w85j4hB4KjFojDR56igKaa0Sa6H51WY3tJCkqWH
 nvydoWEXe0MaCOILcN7nDwET6CtS5U92hG2qA/6171nI/LI9S0fqZ3syNl16vbIlRAy8Dx0F
 96S33uMT2FyhGMIRiU50LpxoUxn0luD17N3jORCFdNP//NJThs6NZnEwuBkE9zyVRzOftCKR
 li8WtioDz4/Qsorw9AQfUZzGM+sgwjG3yqtHr8Vi6aHBZIq/a3HxXT+Othyx27b26kijlkmR
 9NCO3WpiKFx6QbdG5LEnUOBm6m3cKQTxjTN+3ubwGSWpU9WSAF+Xb3eXXAHaEvbtc7361/fQ
 bGzEbgnKRNBycCaJatKdNLpiVJGSe/7NtrHe2y/lDT4ORHdzbSHZ4vCemMH3SybBlJXvRoU+
 COjPBI9GzzpjmbQFj1oGhq7Rkr28vRl7l6/QFU1yQ6icEBrkba4rE1GzceAQu8ei+pX8Bwqr
 C95SRPkh4q+47uoogNgeP8ZetYh+BJd0mmfsQVhP5umJqQkh1gEcg0xsVm9nw5vBNBmls4n5
 Ggv0BI0MbiRhXZIbTCFxtbdPrPNK2/91A+iYeja1wKWy86Yr58G8+9wsFD/pEesH0sm/W9g1
 oxw2mGf+46MIQ4cS5P3XW4o+hI8q7yJKjIl6dby0nthebKxrieE298tA749zQ28et5ELK6eP
 Ar1DtFcGMWkbuAn87SwRjQDOu0atKs9Psf8MuCDxLbuJuFr2jSvkWVA5ol5lEOK7St1DODSj
 d4DxLmD0w2LWi2Z7h/pu93rmY1CeTAZH3augSniColLY6RufIENQW6wKsyzz996itbjQXldv
 FKkAloH3oeud3/wJxTY1BdTyF9RjHipgyq+wBRrnjtvoqfelC3CzuL+dQYWb3ZRTToqhlPtL
 I6oytECCRLxNU5zzkTjvBu8m/s+xuw3NWTYTEZWcjKjKmhjVvH1rb+ee4tV75hutyxLUeO6a
 FTcS7jnohJc3TmwegkWjD09aTyuvY302hJgj2fIZlN6tnnEYoddwRnF5drTbeFc1HwKSWMr7
 FufTkj5JNSv8diOwt3mu/q9Snnne5ldayjtwqufuSH96WAgUnjd17ij39bgFwY9yyry0dJnA
 D7JoBjLaY7uz62mMOhjcyGEHXfE4tFhUsF7m4o03tQL3GQCw4+S9jwBmHvyNtNS3eT/amAMT
 HgF2Yyd7A/g0UxlZnWHouCxHlCU2Mh8fJ+XZm0M2yQyx99HAuGY4fRIkDB0rVyxsQ/KKaIkx
 HFHk6RosSNc36kAo0I1wz+YA6wOEEU9X2SkjBmO492k7e1WaGupbbmsxR97lNGlAquFp1IUU
 3L4d5E+WC5ou58mahSWiiK1s9yiJIq1D5pbrBCfnhbegvIALZswkqBPni97ISfnunZjzecnj
 Bto1JX8vY6dKmwr8rjqZ3wQfjDzec4X/SngyKhEmcPDlaWmBJZ8AXMmWJXyTPSnOC0fv7LrO
 kzddV904mfeArfZEQKFvQ1DpmjMDovtGnWZPngfwv19SRPbKEEV02V2FH0q25U+EA6t3snod
 kx0sysQ6lDPoRxJ0ut0NhP7XzSXtEKyZzwzUpTaMAtO41QI+RLOKcLHpLEWfWkQ7ti7oQeKM
 GDeewlYETRDRBmfH166drD84N7d766HC+D4I/aGaOeLrvFCEueGwoiw25FquSmBPIODMxwAR
 7UyiE9EQGw8EcPEnT4CDTManWTBYoaS9hK75zEypdu17fDoHlvm44fWTbBVNLANs1i/06KEK
 vLVjz1yLixAkMoFw3ORjrMY2RYEgiVqPVFBCJwmsijABOLVk65TVVsAbj9rcdFP5OQ61xVMP
 sjSjpX00KR5h7g7EQUNU1upgcyvacEQRgP1fFraGEaGMqiHLjzX0on2Z627U7hZkORTsVW5p
 z+aF0bpOjnLmSPuUlijNuRFjSfTOxI72sn1ahF2FW3qV87rcDW+N8JryyI7y/s4izKCNGIRN
 yR9b1IYrrCU6nA94L03EGhA43x5aOicznzAta+CcMlQ6KYtXncR9aoS+nkxxrpL4TsRQfV0n
 HGXtdtyuxS8leLJzDN7UR1IozINhYSRvEwkN7+Kk/sIEXvC4h8J6n2dThoQoN4wQPjmoaNN0
 Z7ikKzpKTFN283Z940QCoKHTaDPeGpkKhfvFDPOWUEdSiW3MGjEm0FHuPSV62HTsZUw7JTh0
 slrKPcTRBk+EfUUDV5gFdoJLcJsXz8qprWcidYB+Xu0qBS5rCByoZ3NEP6fU62HwNmxkrROI
 RcFk+qQxWU7M4rmxwp9Z1M8kImYQyLt
IronPort-Data: A9a23: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
 t3SRDNKNBgRlgiovfkxDBoPk+tf6iEz1g/FGwEU
IronPort-HdrOrdr: A9a23:i7v9DKEgk3YYVUaypLqEPMeALOsnbusQ8zAXPo5KOHtom7+j5q
 WTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h0AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:mXj7VG18M2RDrqwtx1m9TbxfAew5SWTsj2rrL0KeGV94SJinTWao9/Yx
X-Talos-MUID: 9a23:/V1hwwb5KA2UKuBT6wHppRd+LslS6vqNAkNTt8kF+PinHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,268,1763420400"; 
   d="scan'208";a="261377374"
X-MGA-submission: =?us-ascii?q?MDGfwkruy0zsGIn6+zDAzfsAuJpeIVC45YedwV?=
 =?us-ascii?q?mGtstc3tOBcSiOZACx9h2DR51rbWC98sswwP3Y0bhoNl/bUNgm0nb3Hz?=
 =?us-ascii?q?i7f0pckXNGRRh83B/6tkCkWfvYyY6C8d23YGnVXSPJ0O0U5o66txursB?=
 =?us-ascii?q?KYZ+mTdqINJ5Y/jWJvlBylFw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 08:01:23 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.223]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mx0N5-1vchg11Xp5-00yURh; Mon, 02
 Feb 2026 08:01:22 +0100
Message-ID: <06735191-095a-4e26-932a-e991fe2a70a5@web.de>
Date: Mon, 2 Feb 2026 08:01:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <87v7i7g615.fsf@mmap.at>
 <af6a88ac-fe87-47d9-8e55-b570f205afc4@inria.fr>
 <c393376f-a5b7-4e7c-b593-052528b9fcb0@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Victor Gambier <victor.gambier@inria.fr>, Manuel Wiesinger <m@mmap.at>
In-Reply-To: <c393376f-a5b7-4e7c-b593-052528b9fcb0@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q+uOuDWXDjxUzMWu2XdJN2M+iI0fPR0hSKEl6WgOwkBMuqO4kMo
 +7UNC6jKIH7ZNnGJtwe2y/B1WJCVTDmDd2JRq0t8vXoJ4V705+QlWXOYY6o4EjYwELGuO3i
 ObSGx/eN8fgpueyzIW3GxyoWJtEv2ZQoTREXo/IQ13/qezYdJ+BLt2wX6kaMhz9eoUcChMV
 /vsnkjgcmxzciYTsBoBQw==
UI-OutboundReport: notjunk:1;M01:P0:rLp/zo4J5yE=;JR5ERD4bJuY9n4Abd+qY3EQmxy0
 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
 E+teLPzhj62TTqoW8AsxpxSNS0QNR8dxN+DeQx
Subject: Re: [cocci] Improving software build systems?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3303
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-02/wJOCir6nDyo-bdP6zqZSAA>

> The patch is on master (b231de0db). Feel free to send feedback if you no=
tice=C2=A0any=C2=A0issues=C2=A0=E2=80=A6

https://github.com/coccinelle/coccinelle/issues/

Do developers dare to improve the build system also for this software?

Regards,
Markus
