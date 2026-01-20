Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2047BD2ECF7
	for <cocci@archiver.kernel.org>; Tue, 20 Jan 2026 08:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=h3HKHv6zIA02OKKcGA0DW6UI6MHKP4Ru9t7x9Ez+Ydw=;
  b=LeLf9m7WbGXWepAwQrq3jt4ZXgOJWpQX3saqy2eMOymT41ezDYiNzG0y
   KrRW1T1b/bP4SUpOrQ/IycsFClrYTmIVPcmEeaTt5C6/llFg7DzGkF7jn
   Q8DDdQu9uAdrD0VRwPtnO2lQKOzoiA8FLKarLSaf8DNprawRwjq/x4zOi
   I=;
X-CSE-ConnectionGUID: 2f5+7CmrQZeIBNEzH7gsUw==
X-CSE-MsgGUID: ijUIXuNJS4OlPaWLsprAuw==
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
X-IronPort-AV: E=Sophos;i="6.21,240,1763420400"; 
   d="scan'208";a="259379138"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jan 2026 09:01:21 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 34E6A8066C; Tue, 20 Jan 2026 09:01:21 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 8C0DF817E4
	for <cocci@sympa.inria.fr>; Tue, 20 Jan 2026 09:01:17 +0100 (CET)
X-CSE-ConnectionGUID: 1OkYbxJ0Sx6Z5PtIexDVMw==
X-CSE-MsgGUID: GeENzMwETfqvnZL12D26ag==
IronPort-SDR: 696f364d_X/Dw0SvxUmHTsWQ2735VlQukHCchJoTS4dHbRGlWJ8nTZCe
 N2yqjXQZoUTkROtnp2UlgS2lR6Axi6x7TzDvCGg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FTAwAaNW9pg07ASNlagQmBUIJBaB9fMwQLSYRYj1OCJ?=
 =?us-ascii?q?IQ7m1wCDwEDAQ1ECgECBAEBAwSFAAKMeQIeBwEEMwYOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQE6Bw47hk8NgmIBgSSBJgEBAQEBA?=
 =?us-ascii?q?QEBAQEBAR0CFDNEAQEBAgEjBBkBAREmAQQLCxoCJgICVgYVAQGCfgGCIgEGE?=
 =?us-ascii?q?AEDDycHDa9FfzOBAYIMAQEG2mMfLCJZgWcDBoEfLoVugmUBiW16Jw+BVUSBF?=
 =?us-ascii?q?ScLgkcxPoRDg1uCaYImgQ6DH5BvUngcA1ksAVUTFwsHBYEjQwOBBiMPPAUtH?=
 =?us-ascii?q?YEjIR0XEx9YGwcFEyNsBhsGHBICAwECAjpTDIF1AgIEghN7ggEPhxGBAAUub?=
 =?us-ascii?q?xoOIgJBUgIBC209NwkLGwQ9kAlHgTKCNoIxFyCxL5RjNAeCOIFngWQMii6VP?=
 =?us-ascii?q?wYTL5dSDgaTBR6YaI4Jlg6FKoF+JIFcMxokgzZPAxkPjjolg3U3xyJCNQI6A?=
 =?us-ascii?q?gcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Qwhp1fOxckwsfqovPk8DBnest+jO9Ez
IronPort-HdrOrdr: A9a23:UUjZWajZMXUYnPeEIcsrbRWWZHBQXg4ji2hC6mlwRA09TyVXrb
 HNoB1p726RtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykesS+Q2mmF+rgbsbq62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: =?us-ascii?q?9a23=3AEmdm1WmjAfO/0LGInWmS6CCxzkHXOST6z0baM23?=
 =?us-ascii?q?gMnY3euCtVX6d6I9attU7zg=3D=3D?=
X-Talos-MUID: 9a23:7MiKfQsru9cU7hlXv82nqzxPEtVN/ImSBlkTl6ci4pOob3J5NGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,240,1763420400"; 
   d="scan'208";a="259379078"
X-MGA-submission: =?us-ascii?q?MDEtMhWB1VRuuJ3yPQtfNnrkLtD84Yt3Rz7uPZ?=
 =?us-ascii?q?5Y0V2dHkBqocmwDYrnzjqe/4J3FxqfZoTtgsacBIPu0jniLxkVy+D0UT?=
 =?us-ascii?q?9ELYjtAVCRscRPTCvD1483mCM+RIHlZVMatf83ZtNBR65meE6vomRMnm?=
 =?us-ascii?q?pNxe5fWplFhNmSXyJvqoCEsg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 09:01:16 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.179]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjxiM-1w6PwZ4476-00fXaJ; Tue, 20
 Jan 2026 09:01:16 +0100
Message-ID: <3eb7e985-02b5-4be3-9414-78d7e155bf84@web.de>
Date: Tue, 20 Jan 2026 09:01:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <e12b2a95-f1e6-4f8b-ab62-151c9789e798@web.de>
 <3857229-a98-854f-225f-5a63ca19cb7d@inria.fr>
 <15bca19e-5a87-4efd-8da7-c6ea2cad27f1@web.de>
 <ca324487-4858-9054-14e8-dbeabae9728a@inria.fr>
 <78df0ed3-2bb4-438a-bba5-c858dd20c1f1@web.de>
 <2e04b3-525f-c970-4d51-ae20a9cd7a2@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2e04b3-525f-c970-4d51-ae20a9cd7a2@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:id2Wh0ojAP8SPewgGB//+HjpqpHB26kcfRkgYmykzZew3bsqcjc
 FGbHQRuOAL1gd1977xBxit791Z4ErUzq8LPjBv7oryvoyLHhllowNp/0mw13itEbxTg+4DM
 HjK3nkEbdwABnWII4jjRpfncha6F+PRVtNJ9r3mVN4a5vnAkQPmzi6WRwQVKYj3vmzkBpbt
 i50TFxfSaBETwytTqbN+g==
UI-OutboundReport: notjunk:1;M01:P0:zTew4+1Nd00=;pFsVCxkTdlC5n/j4LnRxaA1Lr4u
 EB7VHsiEIfDGpGwA0C/NQtUcSloFxLK/f7L0iTohgiBRaKzIKLHd/OU5FQrOQ0+gU2lbqm7wG
 P57fr3F2OViOJTtzcwBhG+4QVqZ3JK9rKeD/q2QVREjL1oUGYakwUmKIxj3VO6Xvm43zC3Rka
 280x2eH7LNLmm8r4vXLkF0d58b25S8fCpzKFShRR3UEZhIui9W6fMm+pKJRtfDSBd2ScAwuu7
 vkuhPrZrQ8tibifngu6iNJB5F5pyuM4ToNkGPxzaCUK3VWH3PaVqpgpl1fpkBBjx55hw1BiHB
 7vg4gKJrf/dfSQZ8UmTuSmTJ23nifYSMMXU5naQprjeE2r4jgsSj7Qg91pK+ktZXgpRZXbEKh
 GRNdLmi48+G9VdwHZ3BYSoUX4tmYORswSkicNla/Y3Z2iNGq0ImW3w8uF0O8NTmSJeTc3K0CF
 zUVC+WudlP7LiHNW1g179KxQD7ClIJwETOXluasWC0TaUg5NrikA9ej1lGINUT414YldM4LY/
 AHEs26AYgqf+VZ9q7jjqjxHIfHTCv/oEY5YdqIYjrz6zX13dvdTeJcAi/0UX8anny38rRiOgb
 ckDUmMlwekMYblLWeWxonvBt7tIsjJq6Hr/kpfsvEDK+KUkB6uIviQ0dy5B+QYSd05KcIWD8e
 vuxCiNNcCkkG3sxXMaqCU07K13q5rYz9L/wFAbzAEa+aQaqhIbA+GYaIbw2mLjMLop+azKjPO
 6YDy+pC91wNaKZRyqUHcrC0fb4LqHsuoaBo2a7aRmn7Xc6V5GuM3f6lFODb8CAGNfMHVCccsu
 nq6DuhLiCt6nMSq75meC2vluxEcDgb+temOajvEuJwTbvCfoepfhCIzEWp8Y5B/85lj55bcSU
 VxeoOKVzir5X57zctYmZWeLDn4y9wYoflE4S/OacseKayGARpjQJkdgk6/e4SuqMyltzaejNI
 ckb3pCOIk+Tp7rd+TQfZobq9TsdIQvAh7KoslkPNFQqnQy7PP97YHl2JraptIr+jYLbTbNQBu
 Xeckh/zaeTaU/DRqIixNHhECl2Kuy29cW5qI9WewLKDfnkcVlU/BQKt5iBXh32G4v1cTiUwpu
 DlCDBlsqEEDdOrFx7+ra9m0A4Wyzes3A5Mm3Ka7NxxZX1IZoSZRnJ4t7S3OfgJRwwfNtYeBGh
 kGWL4LD56AAPAu8teN7riY3hUbLwALZxfXqn6ITbAwvxPEOp2kiOJUGLlCySiTC3CvcYqPFhv
 Jb3qJ/K+YtMUyRfOalt5mPhLilQupLvM3eLCu719031MjPD54xipJswMwfMzNgAG40u4QX59u
 eO2DYXu1gkp896aVcfjob38vi8XPtfwuVHnYrn7QY06LcErL4Wnlx24b6gc4Q5gfAfhdu8cQV
 MVDKfe0pAO96sBVkK7nemZXrYJDLDTpi4x3o1WcGTVI/RXWjePM6xMfYdU93ubMezkGbD7UIU
 4Ztbt1tOkoROo56x73DLvTqzV9xUj45SHtm18PGUMzyISk5WJE5EAuvnBWqsVy0bqDtazUueN
 ZJCFgaZ5c1RVbF/UBMaigIN+iezrXfu3eproc4drKIhxLy12fNl4ZJAIEvgRdZFIT7SYLIUSE
 3mX4UKHo3kBBSCi78NP1B69TNSWNLsRvDlk/ZROFtYW7vK2UlezYd0XdwWDdldxhwU/+1NiHV
 JeIDcOpDbCPwXeJlP05Mu1ZE4f1CsByGUyWZVMImGnSB/7IugaQA/cc9mtflGHOi8FbZVg/vx
 HWaG1oUtAfg6sw1tcpAzBKx0s+r/QPDfOEEygM1Cym+fM32MD0aEGUqkYjH0jDqZwK8SGtmYt
 opwGEaDx2ft4D2IlM9UdBGKnOaAgs3KvFlwgRRqJPzsaXFp5YStZokPBaQeQwwSfr0hjkHwBv
 1X1EsGWlCse/m48RFd9zVe+/+Y7Hd+xOkgKmrgN75DG0KT+ADS+a1s9mIxHvhB5H0vVYymnel
 3A9+hnsfyLTkJlQY/3VRSMvgMdyimHdG3xsnG+y+HjlU9T8NpEIL8gwJqontwl92CWVUUnJO/
 XVwM6fEezk4uWcM3WKW4yHON7lRnTV9eA3RKccr1gj/C8rzKOH5jHx9PQdm2Lo79dat/5OG2G
 LO0HtpdK+RPv2M+Z5v3ylOTlRyWJMk6a8rueYgurU+iyYxTbhPBLBmWyJU9Vv9Pq9VQfqOoMy
 9sLR+85OJF0ylhWXeH47th7r4LPI+YrPJDz/qvVM9mx1fO4uA/9C8EvT1jyxS+pyzj1Qb3egP
 yQ24va1sDstDU874DQNAflfqfhLYbERJ71Heqi/VQ77RE2rHJQpOy/tuR7nbUuZ05aDTFI11o
 A2bF18c8t2X5rZnHU0z5YnMITlXhUUDbt792LpQc/Qop/QAeeFjfXxM7kUZ3Jp2nN4LP7a7y6
 Gm1Z3oJIcu/G9J2AoBjper7PBs4lBIxbznbptYt1y8TwDFDpS2E3nmWArt2oN9/akslrVWhqy
 BMuhfsWf3RRPtK9xm8y+nj/Im9Up44LM8zmuR6FUXzamCyra4l+cdpoBaGPhosmN0CChOukc+
 0hPwRpXMiol63f4PV2YvbTyBheS2JLgsfGUTiU3SOGD81y6IvPxi46IwkA+grH6s+nsZ0JBpa
 fd1s2dyDAi9QTQpelfoDyAbo93hc9cHV5KJDcrCrxMP3vfbo7HRvlWcapzTmTkg7qcdU/iohw
 D5ri2lvHrSLo39p7Ty6st5HsqPrFT0oHadqxpU7/Gzy4uJYxfq58TkWJ0IegjynSplp4FdEpy
 UoOipk3XJu0IfYNQ2Us4Wm6wM6+1SFQwciCh0K2qiY4nPNEf41taV7NxOzOqgYTcp3Q4XF8R8
 +DT1Qh9tN1Gs910PEB5ftriLJYYoxBfnvEAjfF4ULvDJ7k4KHFf2iqSRefVFnfHGnJ9zHg9Bq
 rqxqTrIT0/FoluVGRagRypTI3ADqj0xIwVT9U5nrd6DPPKy+kUF8KnHLj0WkMN39PF9qKA+Vh
 2jWoMGiUQVKPO+xBC6oSAv5JcP2XKwOrSItf/AIfZQCz/nQE1292qjXf8ovRyfQeEYft9n/Y2
 dwDne0iQ7gm1fREv3YrSDEyOXZdmdtSR6PTExK38aG7rhbAJQyAkAeTulcVJicG7GszmIfZA8
 qlNQn+gCkaKXtxDz1mfWGX/6sqb9EQAanjc+EshLIwkxRm5i3JeQpM2zLaU9gJL7jnn2TWQ6Z
 XbD0D/6Js6u6XQfivDHSHRprhgad80tHMT+wzT8Rk6Ii3PZY7JPIXJ7KoNcjVZ9P/PTpNf3KY
 Zs0tApJq8Vb2fL1sbWno1TBgpbYk6uYh5nD47mG6CWZG1kLYFku2lnqXcNFZCie0XJTrPuD+H
 zW9J5/4ygMbo3i71glZaXFjmNqdsb1ChHePzeIdfSSh3db2AHUylpe1cbYjoHrnAlSYwpHVk4
 etkVunqFeAuMh/SwNPVB1IiqF9wc5TipqwVfm0KuUXKrV+3YFgHGpD5nKRcdYLDGw5K09SRBt
 ZM3Ws7m2OxJjxsAVuo5Ej15CZHpcU4AFNEYhPYI+uVgmfkwduLyYAR8Bk8t2FKuCOuRWyFSbT
 C3pcxxnQRJcZV5jT7pxrMMJzuNfpHY4z++2i9+xTbMFYI3mNUUDJftoM6PY/VcIRiPrbZgQnE
 Ubxzj8tKxfMXJf04AByiECbEfcpzOzIisWSgKHMa4u7lqDtOkps662KKcu69CROUejV4bi9fM
 GoI4W7S9o99hcivPQfazu++8p1BNFZ73DAF3L3xKaOK0tca04KhhmqVD9/n0vCCtRlyyl7olw
 GNOnZ8ORnqpy7SUsj8ZmQIVT/evSPo6xcDinenCsPFRoWyEHe++sHDuRyDot6ojF0l81h0bwt
 MKFjq3bV3sBZMtJF+AZpFxrz419+QOORxezhgO+llC6fUzTa9bamF8EDm03KMjGtj6ueJEy+M
 BQX3BX7VBlMsP8Tmkpj5YKsXEUjhr0LEGVwAScm9Y8qSE1D6yLvpkf/SgF6B7m5pe6TkmlH9k
 Oxc6oas1nsEw92+dV5yheKNUPHPkzuYNXjx6qArPbnyrCIXOOniixHWmwoaUdC9Smm5tgIzPO
 Yale6o1HZg5BBp9s8kZcATP7lexsrkJ9l+DKDrbDzkFHzB413vhDsNxACUOUv14pzb5XkldoO
 i7QuzQguyf3qzDjwibaFfhgXD+/xJKpjKTOmJKaIEBPnoYX2eJTDc1TcKEPcgRejL7qFsg3Wh
 U8CER5pWB+LkuqyDqy+GjBXzL68DgXkVMApAXWaY9Qj6Ol4SY6UvEkcXayEr4De6gaENI4Eiy
 djklyhSgmmiQfrOUxjE2Dzg23yXnVGPuQqvjEvc0OuVe7aPra8tydTsN2RYlOxIGBQi/L8QKI
 1cvd/APt6OM0lHSGkdBWeKzcAFZwvkAcx20qAbxgjlZfjG6ApXpevAjCVbm1JdFj/Mxfr2yGJ
 F+m2k4RKG8qhuWAdoP2Wb6tWE3m4jbS3fvMDKtr5OkYxrw6EWSN+9glrbljcukfe/wIR5NPL9
 6ubBOp6j6sW9nbTJHMGOl129uAcivaQayggZliNZJ/EhlFnGiVzTH0TnmnOGKa1P0iRy7XZni
 BbcTBmgrUR+/vvpenlMZZWbW5nElN+2eIba5dLwaiwneW0vv6ctNZA7yeoNnLgmxMQvoatxzK
 QTDk9syIvXy9phw7pq+cgNtYE5qtyOpBfH7jexSCdSeguUDig4NLS/128Y2iAVS8indAd3yjr
 wIGBVJinsEi+HnYIuXBhGP6EizXOtvsfHakabD8RPtiXgUTzfZ4i0BmwuCCd7Nth9JH6xHUpe
 PfeP4nZSQwoOwfmuRkzKgqBlto3FXeAKZO3kDExMUyOANLYnz3imAp34QbDd/KNX+bj8ylVvY
 fGHwsBPlHJ1LNSofDvGobwgBB8RgNqyGZxPCKXUe/1CvLpxLJQ3o0mhMoDW/9awFqFMJJPu7H
 KDNzoYkz6CTMM56ypn80t3Kwo0T83BYhvwVRRNk0CioO+69Hy5HhY5Wfh7N/3P+OFlmTgXN/v
 NZWYcuadzUHh//NK9MIpL9Df5Gtn/o5rVU6I4B9MvgEefQKODuVYQbrW8NuVZ9eb6Gsv/Ps1n
 7Yorj8ORzrAvLQVgT5OFNCBLCc/zdUJAxKUn+Hw9qR4s0mp/RC0GITf0h4ctgwye8zw7G2O84
 lZNkVHp5IT0vFv9wujLc4BhgJiRvQbn32teHzRMFypnrFze+veLo+eZM86vETDDPtIIWtwnH3
 /SjUJM+rA17xMROlKqppsVr81ViYn8Jv0yYjmUEQMLO2hR+2PWy+FfGuEmu+aaaoTzZlx+f4G
 sPBLzyO6aR1eVNkcORR7DXHnvYI2TLQaDTgA9ZFRfA==
Subject: Re: [cocci] Checking data structure member accesses after function
 return value assignments?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3278
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/NjydY9NtiurtLHpuBHfGnA>

>>>> Another SmPL script example:
>> =E2=80=A6
>>>> @display@
>>>> expression action, pointer;
>>>> identifier member;
>>>> @@
>>>> *pointer =3D action(...);
>>>> *<+... (pointer)->member ...+>
>>>>  ;
>=20
> I think I was right in the first place.

You got another view.


>                                          This is as initialization of po=
inter,

Just an assignment for a variable eventually?


>          followed by a sequence of statements containing
> (pointer)->member, followed by an empty statement.

I dared to indicate that selected source code should be terminated with a =
semicolon finally.


>                                                     The third doesn't
> exist in your code, so the pattern doesn't match.

Can the handling of =E2=80=9Cempty statements=E2=80=9D be better documente=
d anyhow?


I can try another SmPL script example out:
@display_without_extra_semicolon@
expression action, pointer;
identifier member;
@@
*pointer =3D action(...);
*<+... pointer->member ...+>


Test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/show_questionable=
_statement_combination4.cocci drivers/regulator/fp9931.c
=E2=80=A6
@@ -438,91 +438,7 @@ static int fp9931_probe(struct i2c_clien
=E2=80=A6
-       data =3D devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
-       data->regmap =3D devm_regmap_init_i2c(client, &regmap_config);
=E2=80=A6
=20
-       return 0;
-}
=20
 static const struct dev_pm_ops fp9931_pm_ops =3D {
        SET_RUNTIME_PM_OPS(fp9931_runtime_suspend, fp9931_runtime_resume, =
NULL)
Note: processing took    28.3s: drivers/regulator/fp9931.c

real    0m28,332s
user    0m28,267s
sys     0m0,050s



Do you imagine any further data processing refinements?


See also:
https://wiki.sei.cmu.edu/confluence/spaces/c/pages/87152449/EXP34-C.+Do+no=
t+dereference+null+pointers

Regards,
Markus
