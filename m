Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E648CCFA1A
	for <cocci@archiver.kernel.org>; Tue, 11 Nov 2025 19:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jjkipSC+pg971z9Qrw4Yfq7KQeI46hpG3I1juPDfcA0=;
  b=aPfxRK/jUVyS+EXfKExAgEdWwiWECUNOdD5vlVJKLOwcZXoCNUby9Slu
   WDRJKZOQ0DnAXXLHl8OSjSSV53cQ0ZErRG1i8UyHE+Po3CBxLgcdJEsmR
   GdDT2D1HG2SYp/T3EoanVtdje00lpG18VPebGuG1H8Lsxvo66Gc30K+LU
   I=;
X-CSE-ConnectionGUID: AQX/w/1pR1+VW/LPfXZWNg==
X-CSE-MsgGUID: TF+tH47kTvOkZJc0xSmjbw==
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
X-IronPort-AV: E=Sophos;i="6.19,297,1754949600"; 
   d="scan'208";a="248619497"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Nov 2025 20:43:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BFF03E0B0D; Tue, 11 Nov 2025 20:43:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5BC03E0171
	for <cocci@sympa.inria.fr>; Tue, 11 Nov 2025 20:43:23 +0100 (CET)
X-CSE-ConnectionGUID: ZgupLcc6QjCnXH12n+0TBQ==
X-CSE-MsgGUID: YeEg40CORLWFai6obPHO7Q==
IronPort-SDR: 691391db_ZSwHFFWfDVZWbHKQ4P7o1ur6EFBX7EPMAIyLxWiRP9LgSSO
 ggQpUiuS5VCh3jVSexPqUUH4lkLepecZd0dAuIQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FeBwCFkBNpeAwR49RagQmBUIJAZSNYMwQLSYRVj1OGX?=
 =?us-ascii?q?4c8h1WKToF9Ag8BAwENTgECBAEBAwSEdwkCjFsCHgcBBDEIDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAUMOCjGGTw2CYgGBJIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQJHRAIBAyMdAQERJgEPCxoCJgICVgYVAQGCfoIjAQYQAQM2B?=
 =?us-ascii?q?7AKgTKBAYIMAQEG2l8fLCJZgWQJgRwuhW6CZQGJbHonD4FVRIE8C4JHMT6EQ?=
 =?us-ascii?q?4NbgmmCJoEOhieKXQaIUFJ4HANZLAFVExcLBwWBIEMDgQsjDzwFLR2BJCIfG?=
 =?us-ascii?q?BFgPRdAg0kcBmgPBoESGUkCAgIFAkA6gWgGHAYcEgIDAQICOlcNgXcCAgSCG?=
 =?us-ascii?q?X6CCg+JW3ICAQttPTcJCxsGPZUOhjo5xj00B4I4gWeBZAyfbAYQAy+DcQGTY?=
 =?us-ascii?q?A4GkwWZBqlBgWkBOIFcMxokgzZPAxkPklS/QEI1PAIHAQoBAQMJhUYBAYxWg?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23:2Wl5ARzmfcR8jwbXCzJMwFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 xeZvakm1geTBdmTq6odzbaN6Oa4Ai1IyK3CmU5BWaQEbwUCh8QSkl5oK+++Imq/AdjUKgcXJ
 4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+M
 Ai6oR/eu8QYj4ZuMLo9xxTGrndWZ+ha239kKF2OlBr4+su84YRv/itetv8v7cJMTav3c6ElR
 rFEEToqNHw468LsuRTfVwWE+2ESUn8RkhpGAgjF6A/1U5LsuSbkteRzxTeXM9TuQb47QTqt4
 L5nRQHnhikaLzI2/33ZhcJ2jKJAvRKuvAd/zJLOYIGUL/VxYKXQds4HSGVbX8ZRUytBAp6gb
 4YKEuEMM/pUo5X7qlATtha1GxWiC/3zxT9Jnn/23LM10+I9EQHdwQcsG8sCvGnIoNnpMasfV
 /2+wqvVwjXZd/5Y2jnz54fGfR48v/+BQ7xwf8rTxkYzGA3IlUmQqZX/Mj+JyugBrWqW4ux9X
 uyvkW4nrARxryCoyMg2kInJhZ8VykvZ/it2xIY1K8e4SE99Yd6rDZBdsCaUOJFsQsMhXmFoo
 zw2xLICuZ61ZigKyZInxxHEZv2JbYeH+QjvW/uPLjphgn9uZb2wiQqo/0e61u38Ste70ExMr
 iddktTBtGwA2wHP58WbVPZz8Uis1DWP2g7c9+1KLkA6mbbVJZM/w7M9i5QevEbfEiH4l0j7j
 a2be0Yl9+S07+nqY7PrrYKfOY9skgzyLLkiltKlDegmLAQDXXKX9fm+2bH54EH1Xq1Gg/k5n
 6XDvp3WON4Xq6q3DgNPz4ou7Qu0AS2839QCh3YHKUpIeBKZgIjtPFHDOPX4DfCig1Swijtqy
 e7JMab7DprQMHfPiLbhfbBj5E5A0Ac/081T64xOBr0fPv7+WFX9uMHaAxMjLgC43f7rCNBn2
 YMfXWKPDLWZMKTXsVKQ4ewgOfOMZIwIuDbmMfQr6PrujXEjmV8ce6mp0oAaaX6mEft9OUmWf
 GTjjs8bEWgWpgo+UPDqiFqaXDFPYHa9Q74z5jAgBYK9DYbDQ5itj6ab0Ce6GJ1WfGFGBUqWH
 XfmbYWIQ+0MZz6KIs99jjwEUqCsS4s72hCgrgD6z75nI/HV+y0ZsJLsz8J16PfJmREz8zx0F
 cWd3HuXQ2F6hGMEXzk207tnrkxn1liDybR4g+BfFdFL+f9FSgg6OoDbz+J5Ed7/QgzPcNiRR
 Fa8XNqmHzI/QMgpzt8LZEZ9BsmiggrN3iW0GLAZjaGEC4Is/q3B3HjxJsN9xm7e2qcugVYoX
 NdBOHGgiKJn6gfTApTGk1+FmKuybaoSxTbD+mibwWqVpEFYXhZ9X7/ZUH4Ce0Xatc/55lvMT
 7C2CbQoLA9BycmaJ6VSc9PnlVpIF7/fP4H8fmawki+UDAmBwrfEOIj3f2QUmiHUF0EAlygS+
 2yHPE4wHHHyjXjZCWlLHEjsflik3O1wsnK9QQdg6giQbFB6kZex9AQUg/O0VP4ZmL4J7nRy4
 w5oFUqwioqFQ+GLoBBsKeAFOYtVCDZv0GvYs1Y4JZm8N+V4gVVYdQ1rvkTo3hExC4NakMFso
 ml5hBFqJ/e+11VMPyidwYi2Iqfef0z75hOycOj73l/E0dCZ0rgC4rI0pgarpxmnQ3Ir6G4vy
 NxJyz2Z75TOAhAVVMfUW1w06gM8irXUeCg76KvL2HcqPaTn+iTa1YcPA+0ogg2lY88ZMK6AE
 1rqFNYGAsG1NOEws12ucw5CI+1YsqI5Vy+/X92B3qPjfONpnTb8yH9C/Jg4yEWHsSx1Vu/P2
 Z8BhfCexAqOETnm3h+ntYjslIZIaCt3fCL3wDX4BINXeqx5fJoaQWaoLcqtw9xihpnrE3dG/
 V+nDlkC1YenYx2XJ1D62ARR0wwQrxnF0WOdxiZ3jipvg66Rxi3IzMz9eRBBNmMKDGhugFHwI
 JSl2sgAVRvgZAwomR25oEfikvIC/uIldTaVGBgOJnKlSgMqGrG9vbeDfcNVvZYhsCENFf+5f
 UjfULn25R0TzyLkGWJagjE9bTCj/JvjzHkYwCqQKmh+qH3BdIR+3xDasZb5TORSwyFAaS12k
 zjRCXCjMtPv8djexPKh+qiuEnmsUJFea3yh6Iqatzago0BuDwe+mf+bhdDtVwQ3m3yetZEiR
 WDDqxDyZZPu3qKxPLd8f0VmM1T77tJzBoB0loZYaIg44XEBnd3V+HMGlT22KtBHwefka3FLQ
 zcXwtnT6Qyj2Ut5L3vPyZirHnmax8JgYZG9bAZ0kmoY5tpJFbzSwbhKhypzrXKnoAiXbfU1k
 joGyPQo4WIXmKlT4VBrlH/CROlNWxACdSX33wyF9dW/sLlaaAPNOfCr2UxykMrgRLCOrwdAW
 WroL5IrHCt+9MJ6YxrH1Hz+7J2hecGFN4tJ8EfOzFGZ0K4McsFU9LJCnydsNGPjsGdwzuc6i
 UYrxpSmpM2dLG4r+qulAxlePzmzZsUJ+zirg7wN+6Tel42pAJhlHS0GGZXySvf9Whcbr/f6L
 ECjFDMmq3GUMaXSF0mT5Q01yhCHW4DuLHyRKHQDmJ9HTQOeOVcZrQQaRjQ8kbYmGwrsyMGrI
 yIbrngBo1X/rBVL0OdhMRLyB3zeqAmfYTAxUJGDLRBS41IK9wLPPMeZ9O42AzBA88jrslmWM
 mLCLVctbylBSgmeClvkJLXr+dTQ773SGL+lN/WXKbzcrOtDS7GXyJjp3oYu9mSJMdiTe2lsC
 Ock01BPG290EYLVllBtA2QexSfKctLerhCh/CZ66N+y+rLnVUrmt46IFqcXOs5l5hS1x/6KM
 eLJwi1+LFM6ntsFl3rP1aRa10UZjDt2MWCkF7hZ8yXKSerGk6tTRXb3cgtVM81Fp+I51whJY
 4vAj8/tk6R/hbgzAktEUlronoeoY9YLKiezLgGPAkHDL7mAKTDRpqO/KaqhVb1divlVvBysq
 H6aFUHkJDGKizjuUVimL+hNiCiROBEWtpu6d15hDm3qTdSubRPeUpc/lTot3bg9nW/HL0YZN
 iVgNVxApPuc4GIQg/lyHXBA8mswLeSAnHX8jaGQIZIXvP13RyVswrgDujJgkeQTtX4CHaYm/
 Uma5sRjqFynjOSVnz9uUR4U7y1OmJrOp0Jpf6PQ6phHX3/AuhML92SZTRoQ9L4HQpXivb5dz
 t/Xmef9MjBHppjx9NEfGtOSBcaJKnsnPjL2FTSSAAZPHlvJfSnPwldQlv2f7Cjftp8htp3lg
 4YDUJdeU0EpUOwXAAJpEZZRRfU/FiNhmrmdgskS4HO4pxSEX8RWsKfMUfeKCOnuIjKU5VGhT
 wQFy/X0INZLXmUa80lld0U8g4nAXUbdD4glSsJJcQI+5klAoiEWcw==
IronPort-Data: A9a23:NRSi3Kj5aNppI7If/SLq0TgwX161DBQKZh0ujC45NGQN5FlHY01je
 htvUTuAP6mNZmT2L41ya4+xpkIC6JDRx4RgHAY6q39nQi9jpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+e6VaidfHgsGGeIcQ954Tp7gek1n4V0ttawBgKJq
 LvartbWULOf82cc3lk8teTa+XuDgNyo4GlF5wVnPKgR1LPjvyB94Kw3dfnZw0TQGdE88t6SH
 47r0Ly/92XFyBYhYvvNuqr7aEADXonJNgGIjHdMM4D66vSVjnFaPg4TbZLwWG8P49m7t4gZJ
 OZl6fRcfTwU0pjkw4zxZfX3/xZWZsWq8JefSZS2XFf6I0fuKxMAyN02ZK060BFxFk+azgii+
 NRBQA3hYCxviMqEz6+jbuJn2P0hB8/bHNpFvDI48RvgWKNOrZDrG80m5Pdd2yoswN9DF7DSa
 qL1axI1NU6GOUcQfA5ITstk9AurriGXnzlwjVuPprcspUXXwhZw1rfFL9ffPNCHLSlQthzE9
 jyfrjioXnn2MvSuxBeKriqHodXrog3yWdwVHoWY0aFT1Qj7Kms7U0FGDQDr/pFVkHWWUNVUI
 E084TsrtaF09UqxT9C7UQfQiHqNoRcYX/JCEugw8gjLy6zO4g/fCHJsc9JaQNkhqdNwWjEgk
 FOE9z/0OdBxmI+aVGq5/bzKlDGZPxg1dDUEJnc4ZzJQtrEPv7oPYgTzosFLPIPdszEYMTT33
 izMsyU0wbke5SLq60lZ1QGd695PjsGXJuLQ2ukxdjz9hu+eTNP0D7FEEXCBsZ59wH+xFzFtR
 kToZPRyHMhVUcHVz3zSKAn8NLCu4fGeeCbR6WNS820a3231oRaLJNgAiBknfRsBGpheJVfBP
 hWN0SsPv8U7FCXxMsdKj3eZUZxCIV7IT4y9Dqi8gxsnSsQZSTJrCwk0NR/Njz2xyBZx+Uz9U
 L/CGfuR4b8hIfwP5FKLqy01iNfHHwhvmz2BdoOx1Bm9z7uVaVicTLpPYhPEbfk04OnA6E/Z+
 spWfZnCgRhOcvzMUg+O+64qLHcOMScaA7LyoJdpbeKtGFdtN1wgLP7z+okfXbJZsZ5brcryx
 UHlaHRkkAL+oVblNTS1bmtSbeKzfJRn8lM+Ey8eHXep/HkBOrSQzbotWKY2WZIF9+VT6+F+Y
 NdYWseHA9VJEi/m/RZEZ7bDjYVSTjaZriPQADiAfx4EYI9GewzF3vTGbznf3nACIQTvvPRvv
 oD68B3QRKQyYjhLDeHUWaqJ9Eywt31Mo9BCdRLEDfcLcXq97bUwDTL6i8I2BMQ+KR/j4D++/
 CTOCDc6odj9maMEwOPrt4ul8bjwS/BfG3BEFVb19by1bCnW3lSyyL96DdqnQ2rva3PWyo6DO
 8Nu0PDOAN8Wlg1rsq19MYpR44AQ2t/Nn4JenyNYRCjlTlLzEb5xAGi07e8WvI13+7Jpkw+XW
 EWOx9pkBYu0KP7VSGA2Gg50QdmAhNc1mybT58sbOE/VxjF615vZXFRwPyujsj18Lrx0PNkbw
 MMkgso36hO+uDUuIN2pniBZzEXSD30iAoEMlIAWP5/vsSUvkmp9WJ37DjTkxb2ycPBODxUaG
 SCVj6/8mLhs/ErOXH4tH3zr3+AGp5AxlD1V7V0FfXKlp8Hkg6Ip4Rhv7jgHdARZ4RFZ2eZVO
 GIwFUlUJ72Lzgh4lvp4QGGgNAFQNiK3onWr5QMyq1TYaE20WkjmDm43Y7+N9X9E1VNsRGFQ+
 bXAxVv1VTrvQtrK4RIzfkxYsN3mc81681zTucKgHvndJaIAXxjevvaMa1YL+jzdOuFgoG3cp
 OJvwvR8Vr2jCw4UvJ8AKte70ZY+dUm6AVJsENBbwbMxPGDDeTuN9yCEBGKvd+hsefHb00+KJ
 PZ/B8BIVh6BhX+ChW1AN5EtPo1bof8Nz/gBc4PNOmQpnea+rD1okZSI7Qn4pjYhbOtPmPYHC
 LH6Vmy9AEmPo3pLiUrhkdJhOFfkUeIbZQb54v+5wN8JG70HrutoV0M4iZmwgFm4Lypl+Eiyk
 D7YRqqL0dFn95tgr7HsHopHGQ+wD9H5D8aM0QKrtuVxfcH9CtjPuywVu2vYEVxvZ5VJYOtOl
 JOJrNLT92HGtuxvU2nmxr+wJ5MQ7sC2BOdqIsb7KUdBphS7Weju3gAi/l6pIpkYgfJf4ciaH
 zGDUvWSTuJMedlhxyxyURN8QiYtU/G9Ku+qoC6mtP2DByQMyQGNfpvt6XbtanodbSMSfYH3D
 gjvofu1+9REt8J2CQQZA+19SYpNSLM5tXDKq/Wq3dVZMoWpvr9Gkr7liAZm9jzBTHWJeCo/D
 VQpWTCmHCleeomRpD2aj2C2lgIaBjBxjIHcu2oDrsVuhWnS4HEudIwg3FZvNn2QujP/3tf0a
 VkhqYfk5TrVBVx5TPk33DgvsspzyADD1hcV6wHFJ3+pVho=
IronPort-HdrOrdr: A9a23:SA4LNK6M6zAEvVl2aAPXwBzXdLJyesId70hD6qm+c202TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:guTyUWELosVs94HeqmJV+1MMPssuLETf53HgAxbiDyUxdJesHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3Ac+9utw2C8//Ryr5ma2Exy/JNuDUj0qmDBxxVurI?=
 =?us-ascii?q?8n/aqPC0uPD2lrBPoe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,297,1754949600"; 
   d="scan'208";a="248619494"
X-MGA-submission: =?us-ascii?q?MDEFqPnMEN41yC3C70geLIF0KlmUqof2GJP3Mf?=
 =?us-ascii?q?Ux/SUadX4hkgGPQQIhEIPLvNMFpF/qpxtXYK5WnoxSAOqPiIFXsTl9ry?=
 =?us-ascii?q?TzCjEpR/JXiSiRIUnPO0TQjOrOJ//QGNbJ/NhCEs5pgKljKJ4ouIXJir?=
 =?us-ascii?q?7AKhqsZgnuRO6LaDWtEh2iZA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 20:43:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762890202; x=1763495002; i=markus.elfring@web.de;
	bh=jjkipSC+pg971z9Qrw4Yfq7KQeI46hpG3I1juPDfcA0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iAEu2QB0LOyjrsPGZbJk5KzV9g+p+8kt4VRdE9tX3yfxpwRzYxe+wxo26NcEA6L3
	 93VPFfL5IUON82O4+iNCwB1zPGXtLxwb50Uc1XDzcpin9orPx/3gel5I17eXwaKoC
	 TC4JjON7XqqEoptucuVrG3DxMn2qenHkjM2dDnlsFoHAsiu3mFvXv2ISE5aINLE6l
	 jhpPo+4y28Og7WRJX6qwfLKgtC8M2A/zrz3/elSLU/wzd2JBIEZM2lETNgoOD7sJW
	 6UDEgKom9JTpVLGRVCFnIYpEEpNPcojAmzN7We0x+pENF7yzm9ccmweTL2RUK/iRs
	 xuXXWVba6Q1mx3F8GA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.1]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MidDR-1vnpVN0UCt-00gyIU; Tue, 11
 Nov 2025 20:43:22 +0100
Message-ID: <92736910-a93f-4a91-9356-f6f6c1aebd8b@web.de>
Date: Tue, 11 Nov 2025 20:43:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <ca1862a2-8a84-49b8-bbfd-fca9f15c6787@web.de>
 <c5aa7f4a-4efc-5384-3295-823dea0ea10@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c5aa7f4a-4efc-5384-3295-823dea0ea10@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WAld1hiezNq/l5immjJeEXOjrU/0j8r842bo2dG17RZDkAueg4O
 yrmTTuI6mEN0hevjD0e/b+Yqj1NB4K4820yBijRvLp/Xw2KquAd2Wc5XYSwf5BvMdkfsMRv
 r+/ZrscsC46XwOAm6F1fBQ8emD4uO6Ha1Ytsrw0Cq/w0vtBvZ0ccME9654W4N65SGld7KhY
 86dXyxTnFXySPy7AF0qTQ==
UI-OutboundReport: notjunk:1;M01:P0:9uNifZfNLzo=;d5CNoHay1HUgqiVxIXMCktUD4so
 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
 Nqu1g==
Subject: Re: [cocci] Checking SmPL support for two special expressions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3164
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/92736910-a93f-4a91-9356-f6f6c1aebd8b%40web.de>

=E2=80=A6>> -( uint64_t ) * ( ( uint64_t * ) & val )
>> +I642U64(val)
=E2=80=A6>> -( int64_t ) * ( ( int64_t * ) & val )
>> +U642I64(val)
=E2=80=A6> Coccinelle doesn't know these types.  You have to declare them =
with typedef.

Are type definitions really required for the handling of casts?

Regards,
Markus
