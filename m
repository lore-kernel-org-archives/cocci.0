Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95CEC7EE23
	for <cocci@archiver.kernel.org>; Tue, 30 May 2023 11:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=H8KF4cb0XKJheC4o5yVlgUbq+yOn7KAX0krGBK/DWWA=;
  b=P5iUVA7ForXxOEcVKfR7OoXNGlHJWWHeLGH0mMN9UEQNJq7DBMz9iZU2
   1PidNazeuKNanPHEet02aCd+AFGNbuD/v3KPoimGV2ZbEn1i9i8smTIJg
   lZsuj+Ve+vWtfAfRDZK25r0SNZrBXbctyxCEyFq3da3VI3QEnr5RG3ArS
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.00,204,1681164000"; 
   d="scan'208";a="110265089"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 May 2023 13:34:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C776FE010B; Tue, 30 May 2023 13:34:56 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E5483E0090
	for <cocci@sympa.inria.fr>; Tue, 30 May 2023 13:34:52 +0200 (CEST)
IronPort-SDR: 6475df5c_P36oiYek+K++jRvltW0e8e7ns2O0UsOZjEtjesqNBA3vZ7t
 WkGAS5/wUKS+P9tyKjppz3L1E7hsLAq06md0IBA==
X-IPAS-Result: =?us-ascii?q?A0EcAACz3nVkhwQP49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPAUBAQELAYIueFMwBAtHhFKPGYInhDOHMIdEiGqBVoFAPg8BAwENQ?=
 =?us-ascii?q?QECBAEBAwSBTIMzAoVdAh0HAQQxCA4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBA?=
 =?us-ascii?q?QIBAQIEBQECEAEBASMXBw4QJ4VoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQESAkc/AQICASMdAQERJgEECwsaAiYCAlcGAQwIAQGCeoIoAQMOI?=
 =?us-ascii?q?weuJYEygQGCCAEBBpwOHywiVYFfCYEVLQGMakKEMScPgVVEgRUngwQ+hESDW?=
 =?us-ascii?q?4Jnjj+NJIEvcIEhgSeBAgIJAhFngQ4IZoF0QAINVQsLZYEjVT2BRwICESsTF?=
 =?us-ascii?q?AVIfA4BEQMHBAKBBxAvBwQyCRYJBgkYGRgnBlYHLSQJExVCBINsAwqBIzUlB?=
 =?us-ascii?q?A4DGSsdQAIBC3A9NQYDCx8GJgEeAiuBWAQvWnkoJJ87CIFCpDKiCTUHgjCBW?=
 =?us-ascii?q?4FdDJ8bBhMvg2wBEpMSDgaSK5gOIIIvpWOBZQI2gVwzGiRPgmdPAxkPjiAZh?=
 =?us-ascii?q?A6PSD80OwIHAQoBAQMJhUYBAYV+AQE?=
IronPort-PHdr: A9a23:E1mEYxDooYgXZjJRFUl1UyQU4EkY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua8wygSZAs6Au7ptsKn/jePJYSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pHNYwhEnjSwbLBwI
 Rm5owjctdQdjJd/JKo21hbGrXxEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2V
 KRUAzs6PW874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VDq+4
 6t3ThLjlTwKPCAl/m7JlsNwjbpboBO/qBx5347Ue5yeOP5ncq/AYd8WWW9NU8BMXCJDH4y8d
 ZMCAekPM+lXoYbzukUArRW+CwSyBuzg1jBGi2Tq3a0jyektDR3K0QIiEt8IrX/arM/1NKAXU
 e2ty6fH1y/Db/BL2Tfm9YPGfRQhof+WXbJxd8rRxlQkGgTCgFqKs4zlPC6V1v8Xv2aU6+pgW
 /ivi28hqwF+uTWuyNkjhZLTio0I1F/J7CN0y5s6KtOkUkB0e8KkEIdOuCGAMYt7WsMsT392t
 Cs5xbALuoK3cScExpkoxBPRZOKLf5WI7x/iSeqfLzR1inJ7dL+wmhq//kauxOL+W8S60FhGs
 iVLn9fKu3sQ1BLT8tCKRuVg8ku/wzqDyR7f5+NeLUwplafXMZEszqY0m5ccq0jOEDL6lF/1g
 aOLbEkp+eal5uL6abv8vJCcLZV7igTmP6QuhMO/BeM4PxALX2ic5OS8yKfv/EPnT7pRlPE5j
 7fWvIjbJcQduKG5HxdY3pg+5xqhFTuqzsoUkHsdIF5YeB+LlYfkN0nLIP/iDPe/h1qskC1sx
 /DDJrDvBY/CLmLAkLf8ZrZx8UFSyA49zdBF5pJUDL4BLen9W0Dvr9PUFAI2PBKsz+bhE9pyz
 pkeVn6XAq+FLKPStkeF6vw3L+mWeIAVoCr9K+Qi5/P2iX82g1EccrOt3ZsTc325H/VmI0CCb
 nr2mNgNC2YKvgwkTOzrklKOSzBTZ2yqU6Im+j47EJ6mDZvERo21nLOB2zu0EYFXZm1dEVCNE
 XLod52eVPsWaSKSJNVhkj0eWrS7RY8hz0LmiAiv4L5uM+bV52UyuIDl2dE9s+bXnAw+9CEyB
 cmP1WyEZ2R1lXkPTD83xOZ0pkkrjh+I1qNzgtRZE8ZS7rVHSENyNpPGyeF+TtL7XAPdec2SY
 EipT8/gAjwrSN81hdgUbAI1OcimjxmL+yO1CrsR3+iJGZg1++TY1mf4I8JVynDc1aBngUNwB
 oNpNGahgqdkvzDaA4/Z2xGflq2tca0HmjbE8GaT5WuLtU4eXhQmAovfWnVKQ0LMrsnirm7GQ
 aWvD7tvZi5I082fMe1nbtPzjFNJbOjuMpLSbjTiyC+LGR+Uy+bUP8LRcGIH0XCYURBc++hy1
 XOPNAxlQzykv3qbFzt2U1Tmf0Lr9+B67nK9VE49iQ+QPAV6z7Tg3BkTiLSHTu8LmKoesXIEo
 i93AU378tbYEduGqCJ+ca8abd5uqExf2zfhvhdmdoelM7gkg1cfdwptuEa78hxtCZhb1+Uuo
 mkrygVaNq+Sll9MJHuDxZ6lHLrRJyHp+Qy3La7b3laLyNGN5qIG8+g1sX3muxy1UFUv+TNr3
 rG5ylO64ZPHREoXWJP1CQMs8gRi4qrdem877p/V0ntlNe+1tCXD0pQnHrltzBHoZNpZPK6ec
 W26W8QHG8ijLvArkFm1f1oFOu5V7qs9I8KhcbOPxqeqOO9qmD/ug35A5chx1UeF9iw0TeCtv
 d5N5viC3RacERr4gk2gtM/fho1OIz0fXyK+xSXiGI9Nd/hqZ49YQWyqIsCx2pB/n8u3AiQer
 gT8QQpbnpP6HHjaJ0bw1gBRy0kN9HmumC/jiidxjylsta2HmirH3+XlchMDfG9NXmhry1n2c
 u3Wx5gXWlalaw8xmV6r/0H/kuJ+rb58MnKVbENGZSnwIEl9X6H2urfIMKstoNs49D5aVuixe
 wXQb7fnoAYBlQ7nEXFfwj8TaDyg/Jn01U8f6irVPDN4q3zXftt1zBHU6YnHRPJf6TEBQTFxl
 TjdAlXU08CBxdyPjN+Dt+m/UznkTZhPaWzwypvGsiKn5GpsCBn5nvapm9ShHxJomSP80tBrU
 23PonOeKsHO3r65LPkhU01mHl765OJlF4s4noZ4iJwL2Hccj4mY5jJdyD21a48En/ujKiZFT
 CVD29PP5Qn5xEBvSxDBj5n0UHmQ2IopZtW3ZH8XxjNo6slLDKmO67kX1SBxo1e+sUfQea0nx
 21bk6FxridHxb1a3Whlhj+QCb0TA0RCaCnllhDTqsu7sL0Sf2G3N765yEt5m9mlSrCEuABVH
 njjKfJAVWd96NtyNFXU3Tj98IbhLZP1ZMgQqwbSvhPOlelTJ7oum/BMiSctagef9TU1jvU2i
 xBjx8TwmYGdKHh2uo+9DARZMDLdeM4ZvD3gx/U7/I7ez8WkGZNvHS8OVZ3jQKezET4cgv/gM
 h6HDDw2rnrIUaqaBwKU711q6m7eC53+fW/CP2EXlJ8xIXvVbFwamg0fWy8224I0Bhz/jtK0a
 193v3gQ/gKq8EIWjLgyaF+mCDmZ/V34LW1pLfrXZBtOslMYvh2Ta5bBqLsuWXkfpMDprRTRe
 DbCPUISVz5PAxPCXxe5YfGv/YWSqbHHQLXkaaKfO/PU9bwZDabtp9rn05M6rWbWcJzRYz87U
 qx9gg0ZAzh4A5iLwWxQDXNN0XiVMIjD403jsixv8pLlqautB1ipvNrVTeUOdo8xnnL+yaaba
 7zA3mAgd2sejMldgyaTkPAexAJA23soLmfwV+5b7WiXFuqVk6tTRXb3cgtVM81Fp+I51whJY
 ovAj8/tk6V/lrgzAktEUlronoeoY9YLKiezLgGPAkHDL7mAKTDRpqO/KaqhVb1divlVvBysq
 H6aFUHkJDGKizjuUVimL+hNiCiROBEWtpu6d15hDm3qTdSubRPeUpc/lTot3bg9nW/HL0YZN
 iVgNVxApPuc4GIQg/lyHXBA8mswLeSAnHX8jaGQIZIXvP13RyVswrgDujJgkeQTtXwCGK8Q+
 mOatNNlrlC4n/PazzNmVEELsTNXnMeQul0kP6zF955GUHKC/RQX7GzWBQ5ZwrktQtDppa1Uz
 cDC0azpLzIXuffd58gBHI75LMydMXwuGQXkEnjYAUFWKFzjfXGanEFbnPyIozeNqYMmr5H3h
 JcUYrpcSUBzCf4QTEhoVo9nQt8/TnYvlriVi9QN7Hy1oUzKRclUiZvAU+qbHfTlLDvxZVhsY
 hwV3fXnII5VOoCpgySKj3FlkY6MF0eCBbilTQV+YwVyrEgfqRBD
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:NSBqxaG24pGoC9L3pLqEPMeALOsnbusQ8zAXPo5KOHtom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h0AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:goeFMm8JRmt4XjthWBmVvwkIIfEGYHPn9S2Kem+JDn5bE6a3VUDFrQ==
X-Talos-MUID: 9a23:q5OcAwmzmzUAAaEp70LFdnpDGMBKsvqxM3orkLE5sZGaLA5AFC2S2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,204,1681164000"; 
   d="scan'208";a="57330689"
X-MGA-submission: =?us-ascii?q?MDGKK0xI7UPPYLPosSO9ZIYhlvTATAaQ60b1Ct?=
 =?us-ascii?q?FQ1t4uSRkSRvMRm3OZ5V2BGOXpTC/8lcvcSBfrnCmjHEdkAE0M1G+aDD?=
 =?us-ascii?q?i8X7F/T8YtSbWuXM8hJo9Del/sf8Lnw7AXsJ9oodJc5SB4Q4O/z9UWv0?=
 =?us-ascii?q?RZfxCTUcq07n2cZBzgrVqrbQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 13:34:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1685446489; i=markus.elfring@web.de;
	bh=H8KF4cb0XKJheC4o5yVlgUbq+yOn7KAX0krGBK/DWWA=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=gKsXOgTLw2oL6zTtkpBWcdJYtj7QfkEaKynHZ4PqjH/b0tAk/XybymXGMDYgpXzbR
	 ARfZxQTLHTkFwNV6dV7ac+rBTdrZGII3TXhIrKmFPzInMryWo90hQ2LmPKzQGv1NYo
	 CWR3nA9m0+LBWaQhVyr0MwuwFx9CadQvfJGWS4rA1lFbvaUUtB5EymX/UHs38sgu1v
	 0NOxMm1GGOWCsf5zV9vonolUHxhi/ZYcIvV/mf7CpOSPTlch+OsH3eQ88XWlC593ak
	 rycSrt4Ser9JXHZQGCJXi6yw9Vxg9zdATP4VDj/NgDgMpofXuzXvGdTUzIS0hNlWKV
	 Dde0otDdjHsfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6pUQ-1q1B8J0fZ0-008Gka; Tue, 30
 May 2023 13:34:49 +0200
Message-ID: <bc7fbb11-cafb-47ab-2de9-e17b01c8d4a4@web.de>
Date: Tue, 30 May 2023 13:34:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-GB
To: Claudiu Beznea <claudiu.beznea@microchip.com>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <20230530074044.1603426-1-claudiu.beznea@microchip.com>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20230530074044.1603426-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pl2/cchOH4FGM0spePv/GczznK3GxTTzceSSBMy2J7ZoeZvDVNq
 iFAlG1gK5zjJV2gYoYBPpOu02KH6XsEjw7oTafbqy2D/qn/EPaON3YSQktTfdsSX6wghRD5
 nZ1+RLgsZ9VwadnSPTJ3Pu7BDP8PfJs0dwFYZIxQie/qUmwrxoWBtmgprDhsKXkmeKGEuLr
 9DnaSGZ14bQE7W4aKuCkw==
UI-OutboundReport: notjunk:1;M01:P0:21Rs5YHjsH8=;0l+pJeE+HPbyp1/+rliL7gW2xml
 HmQBPkC+iZk5s5rNTWC4Fcev53uWvTqW9P42ksCH4x1CQXfrYkoADmbOz1fguiB6O6l+cSvbJ
 NF/Dhkryw6mPAY7LjEIyB0qlpWoV7sXnx0V5ajHxpx1XZ9qoJOGaLTv3BxG6skyjaHevVmM42
 1GxAl3I0JdNZQvddoRCmBXuafTKpnmixuFiId02uuX336+1LwPjVqgpsh3jJ/fRCLUK0L3K64
 SKhUiw4WjU/oSkQgBSITiEFQMuMG1vSRb1IUH4oBjfTmFbEdhnqa3lJEyeXAk5xfZFLeVtmLM
 ulfIBnpZeEK5cdmYLxOjqFgc4iosdzoiBvS9rVYR7ZFSi229BtZ1BGDhTo4OHyDk34tW4hkiT
 8qcMLiHIq6jxIUFtBvx5QwMuOvVkpzw9Oy1xCKNSyx5cyAF4MzjHYdwf4cTlIls0kIgW7EG0N
 FCGncKkLMlT0Io+KnCKY/0XTICJmmV7uM5VhAi0acGPGtpai9zmSgkJB1ILbgCMvVaKSXbV4Z
 HJTa+iaLnQhldfNwwIJ8PqlwWb/NhfTvNVElA5R5y2jgjiQwgyg6ko8vlNqzYpOIUMRhYl92B
 4SS7wVdhPeR08oOOnzcoxV1yCB0dEY2OZEJnH7aqJy3eZu4lWwZLhcU1DsvBC/9Tv0kxK9CqQ
 Qp6BQd8ARMxG9YMhwxPgfRXEvTbep4JXdRZ/MpQD4Qj8P4SkQ2aVSmoQXtkNwFdQuHhd29hrz
 6Mgnnq/38FW3zhlZcgfYlnFg8QkQmCQEyIySKpqCrejN0EEeAJ9J9Xdo5jsHVTM1uo3jFFKXC
 AJWd87GdWmdvrCRvcd1JYTBogru0lFJqwIBL9osjR5IePqUZNGvLx9pWE16dhTCiN7IG8WPER
 ruHqzz+YBQEXgWz73F2E7qmd0sUnU2Do4MVc2dhr3PQw+W18xIZSZHOkn4ucNwOylNNcx9XIh
 I4Um8Q==
Subject: Re: [cocci] [PATCH] Coccinelle: kmerr: increase check list
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1161
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/bc7fbb11-cafb-47ab-2de9-e17b01c8d4a4%40web.de>

> There are other functions allocating memory who's return value could
> be NULL in case allocation fails. Update the list with these.

How do you think about to add also a function name like =E2=80=9Cmemblock_=
alloc=E2=80=9D
(and related variants) to this SmPL script?

Regards,
Markus
