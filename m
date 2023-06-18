Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308BBEB64D7
	for <cocci@archiver.kernel.org>; Sun, 18 Jun 2023 09:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kbLmclUx1yp71LF2LfeXz16MboNZ8O0XjArrvgVLeyE=;
  b=G2haSF3Pjip8qatOneyukLRIEcis0pBcDms53m8eR7n236Y6esAN2X4y
   UDyoE92vEgU886J83W4KNjHI+3UXLpgMc6+fI6q7NNabkLv7qgtqnuHrW
   EJQExnJWG9nlx0XetyLwNZTtsvDhBBPu/11eO/LSyMcZDEd4tNsF5vHe0
   c=;
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
X-IronPort-AV: E=Sophos;i="6.00,252,1681164000"; 
   d="scan'208";a="113402882"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Jun 2023 11:06:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E4B55E03AB; Sun, 18 Jun 2023 11:06:56 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 68DADE0157
	for <cocci@sympa.inria.fr>; Sun, 18 Jun 2023 11:06:55 +0200 (CEST)
IronPort-SDR: 648ec92e_88Icbr9X/tljQ4I18bDZAl4IzbLu9o8/uGxnwAn2cjVzukU
 8s1p93ZIf7DdIzlXst9Fb/PkYiYvvtkkk1b+IsQ==
X-IPAS-Result: =?us-ascii?q?A0EHCgDIyI5khwsR49RaHgEBCxIMQIFEC4IveFMwBAtHh?=
 =?us-ascii?q?FKPLYF2MYQ2hzKHRYhsgVaBQD4PAQMBDUEBAgQBAQMEgUw/gnQChX4CHQcBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBIxcHDhAnh?=
 =?us-ascii?q?WgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICRz8BAgIBIx0BA?=
 =?us-ascii?q?REmAQQLCxoCJgICVwYBDAgBAYJ6gigBAw4jB68FgTKBAYIIAQEGnA4fLCJVg?=
 =?us-ascii?q?V8JgRUtjS+DN3onD4FVRIE8gwQ+iB+CZ44xhWUHizuBKG+BHoEifwIJAhFng?=
 =?us-ascii?q?QgIX4FxQAINVQsLOyiBHFI8HoEoAgIRKRMUBU15HQMHA4EFEC8HBDIJFgkGC?=
 =?us-ascii?q?RgYFyUGUQctJAkTFUEEg1gKgQ0/FQ4RglokAgc2PxtRgXglBA4DGSsdQAIBC?=
 =?us-ascii?q?3A9NQYDCx8GJgEeAimBVzBYdCQktE2WGKBZNQeCMIFbgV0MmCCGfAYTL4NuA?=
 =?us-ascii?q?ZMmDgaSL5JUhUUgqBiBYzqBXDMaJIM2TwMZD44gGYQOjwk/PzQ7AgcLAQEDC?=
 =?us-ascii?q?YVGAQGFIV8BAQ?=
IronPort-PHdr: A9a23:SV6dtR9yJnUkj/9uWTq1ngc9DxPPW53KNwIYoqAql6hJOvz6uci4Y
 QqDvq0m1QWBdL6YwswHotKei7rnV20E7MTJm1E5W7sIaSU4j94LlRcrGs+PBB6zBvfraysnA
 JYKDwc9rDm0PkdPBcnxeUDZrGGs4j4OABX/Mhd+KvjoFoLIgMm7yeC/94fcbghGmDaxbq5+I
 AurpgjNq8cahpdvJak2xhbVuHVDZv5YxXlvJVKdnhb84tm/8Zt++ClOuPwv6tBNX7zic6s3U
 bJXAjImM3so5MLwrhnMURGP5noHXWoIlBdDHhXI4wv7Xpf1tSv6q/Z91SyHNsD4Ubw4RTKv5
 LpwRRT2lCkIKSI28GDPisxxkq1bpg6hpwdiyILQeY2ZKeZycr/Ycd4cWGFPXNteVzZZD42/Y
 YUAAOQOM/tGoYTjqVsArRmxChWjCu701j9FhGX70bEm3+kvEwzL2hErEdIUsHTTqdX4LKAcX
 vqvzKnL0DXDdO5d1zj56IjGaBAhoPeMXb1tesfWzkcgDRnFjlaNqYz+JT+b2eANs2aB7+phU
 +KvhHUqqg9vrTe03Msjl5fGi5sTx1vZ+ip33Jw7KsekSE5nf9GkCp1QujmGO4ZqXM4uX39kt
 Scmx7MGvZO2eCoHxIopyRPcdvCKb5SE7B39WOiRPTp1h25odbahixuu8Uas1OzxW8a63ltWq
 CdOj9rCtmgV2hDN98SLVOFx8lm/1TuNzQzf9+NJLVopmabGM5IsxrE9moAdvEjeBCP7m1n6g
 LWVe0gq/OWj9v7pba/8ppCGMo95kgH+Pboqmsy4Gek4Nw8OX3WH+eim2rzs41b2TK9XgfIoi
 qXZsZbaKtoHpqOhHQNZz5gv5wyhAzu40tkUh2QLIVBfdB6akoTlI1TOL+r5Dfe7jVSsijBrx
 /XeM7PmGJrNNHvDkKr6fbpn5EBczAQzzcpe55JSBbEMO/zyVVHqu9DCExA2LRS4w+D8B9plz
 IMRRXqPArOFMKPVqVKE+/ojI/OQa48NpDb9N/8l6ubygn8+hVASYaip0IAMaHG4G/RmO1+Wb
 WDtgtcHC2cKvxAxQPbkiF2YAnZvYCORRbAt/SMnD4zuLoDRQoeym7+AlHO4BI9HfXJaDV7KE
 nD6c4KbQPQNQCaTJMZ7lXoDT7f3D8cl1BezpErz0b8iK/HR0jMXuIil19Vv4eDX0xYo+ng8A
 8mD0mqAU3t5k0sWSDIsmqNyu0pwzhGEy6c8y/9VD9pe47ZLWwE7KZnG1MRkBN3oHAHMZNGET
 BChWNriSRg7Q9Z5/dIVag4pEt+vilbd0jGjK7sUkbWRA9oz6K2KmzDYIcpsg1nc07I6xw0vT
 dFILnaOhaNl8QXXQYnTnBPd34yocr4alAfL+GqZ1nGJugkMWQh8XL/eRncZTkjbt9L04gXFV
 bD4TfwMNQ1G04auLaxOZ8yh2V5BQvD5e9jCS2G8gWG9AVCP3LzaKMLJfGMH1SmVJFkOmAEUt
 SKFMg4kDyvnr3PUBz1pPVbuZUr29q95snztCgcOyAvCT0B7zbuz9VZBn/uWS7AfwpoHtT0np
 jEyG0yyiYH4Ed2F8i9oZqZBepsQ5Fld1GTW/1hYN4ajMrskq1oQaQVxsGvx2h8xBogWwptil
 28j0AcncfHQ61hGbT7NmMmoYtU/S0H39RGrMOvN303Glc2R4uEJ4eg5rFPquEeoEFAj+jNpy
 YodyGOSs7PNCgdaSpftSgAv7REvgrjAYTQmoa7Q22dtN6acrTLInd4kV6M+0hj1R95EK+ufE
 RPqVcgTBsygMusvzn2gdBEZJ6Z/8KAuPsWpX+SL0uinMbUohyqo2EJA5o01yUeQ72x8R+rPi
 o4C2O2d1xCbWi3UiVC8robolIoCaTx68nOX7y/iCcYRY6Rzed1OEmKyO4iswc04gZfxWnle/
 VrlBlUc2cbvdwDAJ1r6lRZd00gauxnF0WOx0iB0njc1r6GewD2GwuLscwACM3JKQ28qhEnlI
 Iy9hdQXFEayaA1hmByg7Ef8j69VwcY3Z0zaW0RVZG7bK294U62/nqWPaYhD5dJgsClaVvi9f
 UHPUqT08FMR1yLuGXcbxShuLWjw/M+jwFoj1yTEdSUWzjKRY8x7yBbB6caJQPdQ2mFDXyxkk
 XzMAUD6OdC1/NKSnpOFs+akVmvnWIcAFEujhY6Gqia/4nVnRBOlmPXm0PjuCwsnymnW09dwV
 CPHhAnxaM/n2u7pVIAvNlktH1L658dgT8tbm5EzmYpW9HwUnJST8lIYnG21PdgRisecJDIdA
 DUMxdDS+g3s3kZue2mIy4zOXXKY2sJ9ZtO+bwv6wwoF5ttRQOeR5b1Axm5up0ag6BnWeb57l
 ysczv0n7DgbhfsIsUwj1HfVDrcXFEhedSvi8nbAp/W3tqZKfyCCdbaq1Uxxtc+sBveOr0lQV
 W34dZErASJrpp8mahSWiiK1s96iIYCYZMlbrhCOlhbck+VZTfB53uEHgyZqIyO1vHEozfI6k
 Q072Ji7uIadLGA+tKm9AxNeKnj0f5ZJo2ur1/wB2J/Jmdn2TfADUn0RUZDlTOylCmcXvPXjb
 EOVFSEk72ycAfzZFBOe70FvqzTOFYqqPjeZPip8r50qSR+DKUhYmA1RUi89m8tzMwmwx9H6N
 mp96CoQ4FHQtRZGjO5lfUqaMC+XtEKzZzE4RYLKZj9f9AJf/AH4NcKE7+R8Nz5V9NutoUbeT
 w7TLxQNBmYPVEueAlnlNbT7/tjM/d+TAe+mJufPa7GD+qROEu2FzpW13s567i6BY4+Ra2J6A
 aRxiS8hFThpXt7UkDIVR2kLmjLROoSF8Qyk9HQ/r9jjoq6yAkS1v9TJUuEMd4w1q1fs3MLhf
 6aRnHorc28CkMlWmjmRlf5HmwRPwyB2K2v3SO5G73SSCvuP3PcQVUFTajsvZpERsORjhE8Ua
 JSd0I+lkeQp65x9Q1ZdCQ6xwIfwO5FMejzscguAXhjDNazad2eSnIeoO+XmEeIW1KIO6FWxo
 WrJSRa8eGvZ0WC4DVbxbaYW0kT5dFRfoN3vIkwrUDa+Coi8O1via4c/jCVqk+1uwCqUaChGa
 mA6KRkF67SU6WkwbuxXPWtH4zIlKOCFn33c9OzEMtMNtuMtBC1oluVc6XB8yr1P7SgCSuYn0
 C3V5sVjpV2riIztgnJuTQZOpzBXhYmKoVQqOKPX8YNFUGrF+xRF5HuZChADrd9oQtP1vKUYx
 t/KnaP1YDBMlrCctdMbHNTRIdmbPWAJNB30BHjLAQFDQTPqfWDTikpBke2Do32Yqp9pz/qk0
 JEKS7JdSBk0DqZAUx4jRoZdZs4oGGp9wtv5xIYS6HGzrQfcXpBft5HDDbeJBOn3bS2elf9Cb
 gcJxrXxKcISMJf60gpscAof/syCFkzOUNRKuiAkYBUzpRAH1XFkTXAonW/hZBms5nA7CvO+2
 BI7wFgbA6xl5HL37lE7K0Cf7jM3i1U0kM75jCq5dTnsMOGvUIsQBye+5C1TetvrBg1yawO1h
 0ltMjzJEqlQg7VXfmdukAbAuJFLFJa0qIVbbRVWyfzFP53AMHxZrTi7g1BK763JBMk6/OPFW
 YGhpTRM1lA6BOM=
IronPort-Data: A9a23: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
 RoiFrEc8/R/LlyFhQre2xBjvdpa+w==
IronPort-HdrOrdr: A9a23:9KbguaxOQhLpjkkfIU4QKrPw+L1zdoMgy1knxilNoNJuA6mlfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebnN5DNB7foSjjPIceoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:8Mvb8m7ZpzS2liVfKtssrEIfAs81WHDhlEjwMkipWF1RWKLFVgrF
X-Talos-MUID: =?us-ascii?q?9a23=3A68eEoQ93Hj9FFY5Srn4awXCQf91TvJrpVhE9rZQ?=
 =?us-ascii?q?lksyCDSpAJBuwtjviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,252,1681164000"; 
   d="scan'208";a="59032774"
X-MGA-submission: =?us-ascii?q?MDG/0MjZucG3XRps30favXB7BFWnod1qlSpgJX?=
 =?us-ascii?q?WEhn4iVBGuD5qYQ+TkJB6r/Og51s19VtRJJjESF57q+IOKADo4TPgG2x?=
 =?us-ascii?q?B81HWLFhXXyfGhTpTJlefTs3Eq3kNiz+YhwSS8JmQe9VJSerklx1raNw?=
 =?us-ascii?q?dJBpKxNNJYaA32OCU9BdMtfQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:06:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687079213; x=1687684013; i=markus.elfring@web.de;
 bh=kbLmclUx1yp71LF2LfeXz16MboNZ8O0XjArrvgVLeyE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=TJ0hDby86fz57rURhkFmvy64u62b9gfZO+Q6XjDScXV4pNs8O5BbeakEK1ogrO055stEj/Z
 5r3ft7N72Es/f7N9CkOG31yrkPbkYwuiNW41bzDxqNv4KfggrIlT+aruX8tu+igkIFVUkyDBR
 pZ4xmliT4aX3Up+19K1nX2H0ezw8epssm/DPd/yzj9vmLY4bJGtMpvkjAnqzFRi0PnBheLR1E
 tU5rCpdmvr8b6aOrSlRcNAeHTRpif2JtqFi27FUwQpWHeoZgJxCv/R1qfKWwJ9qft4urN7btv
 7vSePhXzL/L10y6+7Nt/hrNEoF1/b0KAY0rS/IW+WRk8/soRw2Cw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mi53D-1pgASC0gnB-00e2yj; Sun, 18
 Jun 2023 11:06:53 +0200
Message-ID: <7c943dcb-83a7-c92d-da50-06dbfb671c31@web.de>
Date: Sun, 18 Jun 2023 11:06:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-GB
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <20230617204118.61959-1-krzysztof.kozlowski@linaro.org>
 <78cc123f-3899-5102-09bf-b00d95311475@web.de>
 <b00a058b-035a-a792-cd3b-e1501e824b47@linaro.org>
 <95c66851-e570-353a-a174-7a885f7fea01@linaro.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <95c66851-e570-353a-a174-7a885f7fea01@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:XrNfxBotLQY+YA4UgxLdaG9vcX97qmnHOy4tOlzyNNjkt758Plr
 wv/NMDBnK7n62OZ0NpmvTDEdOtHwSWZMx+vNJ3qJg3Dp882GLGDCDqXD0cck76P8HxOx/B/
 pEwUxJAhJ1aT8EJcBf/FxICCCOzVMAvT/Mf1HuGc1sc7NdvW+BIldevKi25c9CefuQKTeWy
 b4o92rq2EZFs1jOoRM/NQ==
UI-OutboundReport: notjunk:1;M01:P0:nErDzyDewto=;QEJeNKz4AAa9CmLe0pLAFSM5ZCw
 MHnDtTzvP4lwS2Tod2GyjbTYwUQ6D66HfutuoQrJ+QsLusZA504DBteDJcK3i6L31b5V7Tp+7
 zLVbbIq7A8x0WMne5M87+IsBPsc+Vkqvr0IUSSqgZw/+QWU17e8IZMsMvgaiHmSU+OGr1pbsP
 0KZFvjgH5x240exuUM/DIqcQfJv7ZTtw5SQLZSeUCBc08HN6US1IPBe65+NExbGun+NXtTAwT
 qIm8E8RBVCssHa8ddq7Us/ABC8r+jVkT6eJj3AjhpdIhopUStERVRdXjhe8xivyM6u2H9emMY
 I+4Y++CKFPzJ/gq7ufbDamV7+obg6Pq5kPBrtGYhLq4safRIg12qcXwf9A0U+lIPnwEv7hozQ
 8P4C3rsYXbtLU4ZHLSYxV7WYw2cb/Lh/sHl4t5vD99xonVfzu7ERpbbI97jpiY/BACjGTW8cE
 LpN04BDkXiCywnpuchPvdXx5X8zitsFDu/YsiFMcvx48ZjOXyvoI4e0BVDddDNZsQFhcTNan2
 RvNIfS1XpCf/tqrTWKqu1Xo49Nk2d+X2Vfmjzgse2x8dWJhBAH9XMkYUYXa18Muhuw6C5Yc5L
 Y6QLubSWCi09N7V1DiIh8IIm7fQisdJL4JOnkmlR7kRiA6Fo287kmOpUbH+HYshjasmpixvfp
 0L7zgq8xu/MuMCXrY2kToXQgAj9G47lXxh3CCnuWu4IZKx7d89ciWchRQpb0tZEHvHRb94QPG
 tbPAdylXQQX1xRee6IL+svvXSCO6lWaYajtHVppQYVnx6dHMFXtEiHRNFAWsS9VGmYm4Ms9JY
 ovDW/eMyq3ZuSfdfzkUuse8Fhc+xGK8kOzfNZi3tdnT0DmCTGbUVMFtdDPuR407h+52f0gl8p
 GLVxpEFM2bdpRs/KyBcp9H+aJSoQh0PbGZh/+w60U7o7jNdoQ2nrTJG/pDFEh1x9mdPt+CI5+
 rHhpCah5CpiXgkxiJSYDwaAPSg4=
Subject: Re: [cocci] [1/3] arm64: dts: qcom: sm8150: Fix OSM L3 interconnect
 cells
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1191
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/7c943dcb-83a7-c92d-da50-06dbfb671c31%40web.de>

>>> Can such a small patch series become a bit nicer also with a corresponding cover letter?
>>>
>> No need.

Do other contributors spend more attention on the proper usage of cover letters?


> Ah, I forgot you are banned.

Further software adjustments and corrections were achieved despite of
a questionable development situation.

Regards,
Markus
