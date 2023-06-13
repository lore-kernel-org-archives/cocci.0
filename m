Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041DDC7EE2E
	for <cocci@archiver.kernel.org>; Tue, 13 Jun 2023 10:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Bz7G5Jh439Oai00VdfSkhErzYBy5WZcU+DNHu3HJVuM=;
  b=QKZme0MEcLTXrPjtUPGljze/azSg3xsdTwaoa4ElGu34ZEPsJy328qrk
   mF0fl0DWVg+1zlt8e+OpbYcgeYJsdY73jk8O3SKqvugZ2IFfId3zPjjLf
   ngmo2+RqgiO2LhdnLdrSN4XklIebnAd4weH9O31vsskZTFIMBVeg3oxW8
   E=;
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
X-IronPort-AV: E=Sophos;i="6.00,239,1681164000"; 
   d="scan'208";a="112625619"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jun 2023 12:42:55 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 06C52E0CCA; Tue, 13 Jun 2023 12:42:55 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 45C71E00BA
	for <cocci@sympa.inria.fr>; Tue, 13 Jun 2023 12:42:54 +0200 (CEST)
IronPort-SDR: 6488482c_J/t+bUh3PqFHmIqQ4+OjeiCgvdm0ZATuERTqnT4Z4ZZKXXI
 UuMPb8WwLoC0lpeHVdK1YKUGgQpvOgG9Z6WjlHg==
X-IPAS-Result: =?us-ascii?q?A0FHAACjR4hkhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIudQNTMAQLR4RSiB2HDYF2MYQ2jnaEaIQEgVaBQD4PAQMBDTQNA?=
 =?us-ascii?q?QIEAQEDBIFMgm1GAoV1Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBA?=
 =?us-ascii?q?QIBAQIEBQECEAEBASMXBw4QJ4VoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQESAg06PwECAgEjHQEBESYBBAsLGgImAgJXBgEMCAEBgnoBgicBA?=
 =?us-ascii?q?w4jBw2tSoEygQGCCAEBBpwOHywiVYFfAwaBFS0BjGxCgzd6Jw+BVUSBPIMEP?=
 =?us-ascii?q?oJEBxcEGIFGg1uCZ44lhjSJVoEob4EegSJ/AgkCEWeBCAhegXFAAg1TCwtjg?=
 =?us-ascii?q?RxSPYFGAgIRKRMUBU17HQMHBAKBBRAvBwQyCRUJBgkYGBcnBlEHLSQJExVCB?=
 =?us-ascii?q?INYCoENPxUOEYJbLTZDG1oQJQQOAxkrHUACAQtwPTUGAwsfBiYBHgIpgVcwW?=
 =?us-ascii?q?HAKJCSfDQODD4E5gQCXTK1+NQeCMIFbgV0MihOVCQYTL4NukyYOBpIuLoc5i?=
 =?us-ascii?q?muFRSCNOppdgWM6gVwzGiSDNk8DGQ+OIBkeg3CEYYpnPzQCAQgwAgcBCgEBA?=
 =?us-ascii?q?wmFRgEBhgABAQ?=
IronPort-PHdr: A9a23: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
 J8JV6MdS1E/UP8XWBwNIQ==
IronPort-Data: A9a23:gSpCHKB+o3EstRVW/znnw5YqxClBgxIJ4kV8jS/XYbTApG4hhmAFm
 mMWDTuFM/eDZGH0ctAlOo20/U8D6sXdyNE1OVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6j8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuHYDdJ5xYuajhPs/za80s21BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc53z9WSPR0vNuMGc7Bagh99t7Xmhj+
 sVNfVjhbjjb7w636Le8V/UqmckpasXmVG8dkis5l3eDV6lgGM+FGvyiCdxwhF/cguhrFOzde
 tFfRD5hdhXGbDVQN11RBJ9WcOKA3yClLWcF9gvFzUYxy0fU7TBM84HTC+vcVOeBXut/m2Wqr
 22TqgwVBTlDaYDBkGPbmp62vcfEmijwWaoJBbig/7hrhkeSzyodEnUruUCTpP6klgihVtgZJ
 0F8FjcSQbYaxXeBFuTsWR2EhnO8mycRZtYPGsA10VTYokbL2DqxCm8BRz9HTdUpss4qWDAnv
 mNlefu2X1SDV5XLGBqgGqeoQSCaZXlNdTRZDcMQZVtZuYa/yG0mpkiXFr5e/LiJYsrdNRyYL
 9qijyEkg64JkM4Gv0lQ1Q+Z2mnzznQlZiQ86gjRG1249B9laYuvapangWU3AN5FK5uFCEaMt
 j4IlqByDdzi77ndxURho81XRNlFAspp1hWC2zaD+LF8p1yQF4aLJ9w43d2HDB4B3jw4UTHoe
 lTPngha+YVeOnCnBYcuPdLvVpV2k/O8SYW1PhwxUjaoSscgHONg1H4+DXN8I0i2wCDAbIliZ
 8zHLJvE4YgyU/02l2LeqxghPU8Dn31imzqKG/gXPjz+n+PWZXiJRK0DPUfGZ+9R0U93iFW9z
 jqrDOPTk083eLSmPEH/qNdPRXhUdSVTLc6s96R/KLXZSiI4Qz5JNhMk6eh8E2CTt/8Px7+gE
 7DUchMw9WcTclWedlzQNi4+MuqyNXu9xFpiVRER0Z+T8yBLSe6SAG03LvPbpJF3q7Qx/u0+V
 PQfZcSLD9JGTzmNqXxXboDwoMYmPF6njB6HdXjtKjUuXY9SdyqQ8P/dfyzr6HYvCAizvpAAu
 LGO7F7QbqcCYAVAN/zoTsyT4Wm/h0VAp9IqbXD0eoFSXG7O7LlVLzfAi65rAsMUdjTG6Dio9
 yeXJhY6/tvygpIH3+TIoYumrI6ZNfR0MWQHPmvc7JewbTL7+Ej6y6B+ce+4RxLvf0Kqx7eHe
 sNu0ODaDP0LuH1oorhMOe9n4oxm7uS+uoIA6BpvGUv6SmiCC5RiEyGg5tZOvKgc/Y1pk1K6d
 WzX8+YLJIjTHt3uFWMQAw8Xbu6j8/UwsRuK5NQXJHTK3gNGzIClY25zYSbV0Dd8KYFrOrwL2
 e0i4c4ayzKugyoQb+qpsHpmyHSuHFchDYMX7ooXEa36uDoNk1tiW6HROgXywZOIauhPDHUUH
 y+ptPLCqYhxlkvmWFgvJEfJxttY1MgvuggV7VosJGapu9vih90r1kZvqRAxQgBkz0hE4dlSI
 UluDVV+fo+Vzgdrhe9CfmGiIB5ADxun4X7My0MFuWnabkuwXEnfBTcZFcOS2nsG4kRgfjR/1
 5OJ+lbPCDrFUpn44XovZBRDtffmc+1UyiTDv8KWR+K+AJgwZGvesJ+EPGYnhUPuPpIsuRfhu
 +JvwedXbJ/7Pw42p4kQKdGT9ZYUeSC+CF1ye9NT14JXIjiEYxC34yaEFG6pcMAUJ/Dqz16xO
 /YzGu1xDSaBxAS8hRFFI55UOLJlvu8b1PxbcJPRGGM2mb++rD1ojZHuyhbDlFIbG9VDrMJsB
 b7SJhSjE3ORj0R6g2XijtdJEUvmbMgmZD/T5vGU8uIIG8g9scVpS0UT06S1jVqRIgBI7xKZh
 yKdRq70nshJ65VgoJvoKYpHXz6LENLUUP+a1SyOqPFMUI//CtjPvAYrtVXXBQRaEr8PUdBRl
 77WktrI8G7anbQxCUb1poKgEvRX2MCMQ+ZnCML7A31Ely+kWsW3wR8i+Xi9GKNZguFm+cira
 AupWvSeLedPdY9m+0RUTCxCHzI2Kaf9NP7grBzgicW8MEEW1AifIe638XPsU3pgSRYJHJ/AW
 z/E46PkopgSqYlXHxYLCs13G5IychepRaIicMa3rjWCSHWhhlSZoLb5iB488nfxB2KZFNrhq
 4fwLvQkmM9eZImTpD2Yj2BzgvHTJHN6nPV2YU8XvdJ749x/4KjqMsxFWajqyLkN+sAx6H08T
 C7AZi0uBE0RmBxaJA7k7o2Lshi3X4Qz1xSQGtDt11yZYWG6CetsxVenGjhIux9LR9co8A1rx
 RzyNJE90thdD6yFndou28E=
IronPort-HdrOrdr: A9a23:OJeNeKOayqBm7cBcThWjsMiBIKoaSvp037Dk7TEVdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YFT0EUMr3N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:XMXI/GNcEtkBje5DaRJNrHMFHMAZVHDl6U7dHkPnAEtmcejA
X-Talos-MUID: 9a23:M253nglBJ6o7WFFUM+1ldnpNM+ZU3oeXNns8mLs9sNKqHylTCT6S2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,239,1681164000"; 
   d="scan'208";a="112625618"
X-MGA-submission: =?us-ascii?q?MDGfdlHfoe4Vnc0/CZLCZUp/Gqs+DVavfXiipr?=
 =?us-ascii?q?lyvJDyPp1PDtHMqw1jDtwriWSuMtfWhzVxwP7Bep+pdHDFrzA8PFifm/?=
 =?us-ascii?q?pVo/uI8bdqcZEG6mFpaBG3t4HQAwOthBKR88tVFeUcOfQ1imWs35Pgnd?=
 =?us-ascii?q?V4OD+4V7e1AXb7/AAhPgCtww=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 12:42:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1686652953; x=1687257753; i=markus.elfring@web.de;
 bh=Bz7G5Jh439Oai00VdfSkhErzYBy5WZcU+DNHu3HJVuM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=C4KRSeLDmy/cMIzrWmYyXhSHGUVWNUYMCJnD8+Af4yZhhYQbZU2KDM6QCgKpzy+rmBV7uPM
 wl1lY7Oh8LsnOeYBFaG2N5zaFDeaMyN5qtcsD2iqRWR6Ki+t3Lfpshx+LSuwVqvyb0pMLh01G
 +uhBpYsta0+B2cO61i1FSfQNmPx5k3DBHrqI9JSw+RBsRfOaRJBCKbSF0CSlmZeJk6u4D+Xhn
 onnXEP2/KCGHVBbscEj9zaNC7w+vkAbUj+I6IFO+cNpb0e/AA5L0HpIddgGTBVzloZGa8/yKv
 gY6iKwUnTVhTW6gTTmUlqCaRU4U07CgUxGLT7bVLL7lWjjpBy5vQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLAVc-1qR6b52Zqk-00IEh9; Tue, 13
 Jun 2023 12:42:33 +0200
Message-ID: <f658d4be-d594-39ca-6ad4-7496627ea570@web.de>
Date: Tue, 13 Jun 2023 12:42:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-GB
To: Linus Walleij <linus.walleij@linaro.org>, Lu Hongfei
 <luhongfei@vivo.com>, Wells Lu <wells.lu@sunplus.com>
Cc: kernel-janitors@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <1685277277-12209-1-git-send-email-wellslutw@gmail.com>
 <9ace5c4c-5e17-4207-5a02-6a47ba0aee22@web.de>
 <CACRpkdbe2AjD69tpgDDJKf0ge__hoTs72OuT9M-p21_q+z3f8w@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CACRpkdbe2AjD69tpgDDJKf0ge__hoTs72OuT9M-p21_q+z3f8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cJShvDUug0C3u6N0chGFCkr3nSksKup/sTaPWxR+bSN6hTjRLG3
 NvOpqTb0HfOnNvEvXTGsYDA0UBj3eeBWM/q48iMf3NFAn+NHZBPlGi7IwDBwkLwA85HzU8i
 afMInEaRsQQzz/6HL66aCe5lkFU9t6/kNtmNI0v0VPQoalBc9lUTgQKpSizzYPh7Dbc35fO
 V0+aJ7bu+NdJVsXcDeQLw==
UI-OutboundReport: notjunk:1;M01:P0:TUbpzpROkpM=;04Dcd1SpSIYDA9zmvK20Ke1zgiW
 m4KB3H+5avf8MzkBcvhmh2WHgRTbzPNq70YJIj8hyOHNnxoVKnCrfJirtNl2DHUO05iyqR3uY
 LKOXrY7WzHgtg20Wd/7lxJ0+xUH7Gafa7isFeZdKdsTu7m62zHmfwZVxS4gpyvOhG5aLXqz6U
 wSifZsmbT0r9S+gfsGY+AmHqe6EOGEPy/C/PmUivLCUtjE9EpKsG+E1+7FRr7Y2j4n1/spy7U
 Grdh100Qt7NzvIUFJXD+RzmZDVnhusmOPtymdc7K8immr5MCFXyXcnfQxRAgLx1GISABNmoe8
 56vSU+1AD7IBbMw8c9gTTj2SILvpFQg0RY5HygumTPzYsONGZKbsUXBogvN+dR1XabdOVHgln
 UceGQjuvWEDgSNTiV93ZKf3jVsuRzcbZwJ4u6DIm436X+7gDCkD/T7B6nCjzeJEHxj8V30kDP
 95So6iFSRU1LW4sN87U9rqCyUsMOLboKbHwOFIj6MkFO+2i6yXINlW1Emx9OEg1Rbs5qnzbWk
 weOr54Qz65lkkMzcpaEVTb1KMQS507/QMH67zJ5b3zMAZ4r9JtqEEr8k3w84ulGbpfbjT2bR/
 5KP5tU8gIaOPla9AnuIuCZXTSsxRffRN/Bow6tnw4xFdRM5D/IuLITFSoJBwSL3w6AZ0WwR0b
 jZ87oQAABjb85pXaO7VeyioRXqj3O3cOiFTNe7ai/x56RX0nr2y2i80CKjWYoiOhgJwZYsODc
 JLxS/cWAvZYAJQsnhMwmKh5+Q97dKH9X62ukrALwxrkcHK/d+/pVfObJx2OszqLTeCbpuLPHx
 nehy4nBfH6JmoA4TdHzAoonBUlx96XcA4csR1ppt1HovwQY9FZ5QNMt5P4glIjAKorDGl9xQ0
 g/vKGBQrMZMrVcWwpvkbCIeh4DqEiLOnZpIbL5r9O0/DS2hg/GXXnnABdAt44WDQf3FdUHOdc
 0RWG1mMMIdwpccr2nJCZXlM1YTc=
Subject: Re: [cocci] pinctrl: sunplus: Delete an unnecessary check before
 kfree() in sppctl_dt_node_to_map()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1181
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/f658d4be-d594-39ca-6ad4-7496627ea570%40web.de>

> Lu Hongfei sent a patch changing the code around this location

To which contribution do you refer here?


> so I rebased it manually and applied, check the result, thanks!

I noticed another commit with the questionable subject
=E2=80=9Cpinctrl:sunplus: Add check for kmalloc=E2=80=9D.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit=
/drivers/pinctrl/sunplus/sppctl.c?h=3Dnext-20230613&id=3D73f8ce7f961afcb3b=
e49352efeb7c26cc1c00cc4

I find such a commit message inappropriate for the applied
source code adjustment.

Regards,
Markus
