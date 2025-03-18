Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E383C282EC
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=N3Z0xfqmEBHgSTLfazDdh62Fh9l6Gok8zR9wQThvrIg=;
  b=T4WbunISWPgd9CN9o9cYwKFQPxyJ/EFTpbB5fpJBuIy8JKRo1ny8vXbp
   84DSLNjXDHx8GaZ3bCigTLKj5q7MgQ4a7x1JC/tIcZIw8bj+2GmRrCkJg
   CX76t0bRgJ7Wk9RCSVV39lXDaXC2hV/XzH/aoAvc38ZwrUeXbMmADl9jn
   w=;
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
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="213509425"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 15:21:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E13A3E0261; Tue, 18 Mar 2025 15:21:52 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A0A81E0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 15:21:49 +0100 (CET)
IronPort-SDR: 67d9817d_DJTWXB3g8PshxKBI6sFxgSjhlR7xbd2E/L/ic3fDYzpL7Zb
 7C7ao38pEVt2a8dDV8O875NsgPmEKAeEnLOXWFw==
X-IPAS-Result: =?us-ascii?q?A0HjDgB7gNlngAQP49RaHgEBCxIMQIQXYhtaMwQLSIRWj?=
 =?us-ascii?q?1CBdDCEO48OjEkPAQMBDTkIAQIEAQEDBIUAAosfAh4HAQQ0EwECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7DYJiAYEkgSYBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEdAg06RAEBAQIBIx0BAREmAQQLCxoCJgICVgYVAQGCfgGCLwEDD?=
 =?us-ascii?q?iMHDQatcIEygQGCDAEBBtpcHywiV4FlAwaBGi6FbYJjAYpjJw+BVUSBPIMDP?=
 =?us-ascii?q?oJhAQKBX4NbgmmCM4RDZ4Fsik8cLYIlilKQHFJ7CBQDWSwBVRMXCwcFgSlDA?=
 =?us-ascii?q?4EPI4EiBTQ0DjgpgWNpSToCDQI1ght8gihqBAWBJII3hD6EQYVQghGBXQMDI?=
 =?us-ascii?q?gGCMG91HINIdj6EZC1HCYFNHUACAQttPTcJCxsGPaMOO4V8AiKBScZ0NAeCO?=
 =?us-ascii?q?IFmgWMMiimVNQYTL4Nwk1YOBpJ9mH6OBZsugX4jgVwzGiSDNk8DGQ+OIYQth?=
 =?us-ascii?q?GCwd0I1AjoCBwEKAQEDCYVGAQGKVIFLAQE?=
IronPort-PHdr: A9a23:eryB2REcbgF0vNasOG9a051GfzRGhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k21hmRBc6Ct6ga1qL/iOPJZy8p2dW7jDg6aptCVhsI2409vjcLJ4q7M3D9N+PgdCcgH
 c5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFRrhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTezf79+N
 gm6oRneusULjoZuNKc8xxvUqXZUZupawn9lKl2Ukxvg/Mm8+4Jt/TpNsPw77c5AVqv6f6U8T
 bNGCTktLn446s72uxTdVAWD/nQTXHkYnRpOGAjF8Qr1XoztvSvgt+pywzeVMMvrRr0pQzui7
 qNrSBj1iCcbMjMy7W/ahtBsgK9dvRmsvAJ0zZLKb46JNfp+ZqLdcs0cRWpdRcZaSihNDpqhY
 4cTE+YNOOBVpJT/qVQTtxuzHQqiCu3gxTBGm3H4w6M63vohHw7EwAMuEMkDsGjNrNjvKKseT
 f65wavOwD7eb/1WwzD96I3Qfx4mu/6MR7FwcdfKyUIyGA3FiluQqZbkPzOT2eQGrm+W4e16W
 uK1iG4nthpxriKgyMcohInJnIMVylbL9Shizoc6O8a3RFRmbtG6CZZdsTyROIRqTM04WW5op
 Do6xaMcuZ69ZCUExpQpyRHQZvGZfIWE/wzuWuiTLDp7i3xreK6ziwiz/EW+yODyVsm63VRFo
 CRFjNTCuX4A2h3T58WFSvVx4Emv1DCS3A7d7eFEJFo7lavdK5M53rEwk4AcsUfdESPsn0X2l
 qCWe0M58ear8+TqeqvqqoKCO4NulA3yLKYjltaiDek4KAQDUHCX9OCz2bH580D1Xa9Gg/8qn
 qXDsZ3XIcIWrbOnDg9Rz4Yj8Aq/ACm80NoFnHkGLUxKdQqbg4XvJlrAOur3De2ljFSpiDprx
 +7JPrnmApjVK3jDl6rhfapn509S1gU81spT6I9KBb0ZIfLzXFH+tMDAAxMnLgC43fzrBMtj2
 o4cQ26DH6+UPLndvFOQ4+IgOeiMZIsbuDbnLPgl4ubjg3gjll8HfqmpwIAXZGq3EPRiLUWZe
 3vsgtEOEWoRsAsxUvflhEefXjFNf3qyWbkz6SkhCI26FYfDWpytgLuZ0SulBpFWfHxJCkiQE
 Xf0cIWJQ+sDaCWOLcB9kzwJTqOhSo8k1RG2rgD20btnLuzO+i0Zr53vztZ15/fLmREo6TN0F
 9id032KT2xskWIIWjo207pkrE18y1eD1LN3g+ZCGtBJ5vNJVB06NZ/GwOBgBdDyQFGJQtDcZ
 VqpS8/uIjE4RdI438UfakA1T9aihxvD1jawErYT0bGHC5Uu2rnAwnT8Ido70X/bkqAk2QoIW
 MxKYEivnK1i7ED+A4DTkkOW3/KPfL4fwTWL2WON12uIs2lHXQQ2XaiTDiNXXVffsdmsvhCKd
 LSpE7lyd1IZkaZqS4NPY9zt1xBdQev7fc7ZaCS3knuxAhCBwvWNapDrciMTxnaVE1AKxiYU+
 3vOLg0iHmG5uWuLKTV0Fk/0JW7o//N/rnyTUUI+iQ2HPAV6z7TgwhcOnrSHTu8LmLcNuSMvs
 TJxSXO0xdHLEJytowR7faNTScww6hFL2DGRrBRza7qnKa0qnVsCa0J3skfpgg1wEZlFmNM2o
 WkCyQ1vNeSH3VkHez7wMYnYHLrRJyGy+Rmub/STwVTCyJOM/axJ7v0kqlLltQXvF0w48nwh3
 cMHm32bro7HCgYfS/eTGg4+6gR6qrfGYyI8+5Kc1HtiNrOxuyPD3NRhDfUsyxKpddNSeK2eE
 wq6H8ofDsmoYOsk/jrhJjcNJuNP7+gZO828dv2J8LGmNqBskXPujGhK5px8zlPZ7zB1GabD2
 5cIxe3d3xPSDW6myg377YauxMYYNlRwViKlxCPpBZBcfPh3dIcPUyK1JtGvg895jNjrUmJZ8
 1iqAxUH3tWocFycdQ+Yv0UY2EIJrHiggSb9wSZzlmRji6OF3zHVhcnmegAGPGFjW2Roy1vha
 9vR7ZhSTA2zYg4lmQHwr2Pz3atGv+JSK2fJQEFHVzf7JSduX+Hj09jKK94K45QuvyJNVe26a
 l3PUb/xrSwR1Cb7FndfzjQ2H92zkq3whAcyyGeULXIp6WHcZdk13xDUotrVWf9W2DMCAih+k
 zjeQFambZGl+tCdlpGLte7bNSrpc5RJcjTwi66EujG642JCHhC12fy+0tHqCgk11ybn2sIiD
 3yS6kymPc+yiuLmeet8NlFlHlr999Z3FuQc2sMriZcc1GJbzpSZ8HwbkHviZNBS2Kbwdn0IF
 nYAx9/Y5hSg2VU2dCvTgdijCTPEn409NLzYKisM1ykw7t5HEvKR5b1Ax25up0ag6BjWar57l
 ysczv0n7DgbhfsIsUwj1Hb4YPhaEE9GMCjrjxnN4cq5qfAdQW+1cqWrkmd6k8qgCr6qvQxWH
 nr0MMRHf2c4/oBkPVTA3WemoKTtYtrNdpQ+shOOkhHPp/dYItQ9m7BZ4EgvcXK4tnojxekhi
 BVo1pzvp4mLJVJm+6ehCwJZPDn4NIsDvyvghqFEkoOKzpiiS99/Ty4TUsKiHpfKWHoC8O7qP
 AGUHHggp2eHTPDBSBSH5h4upiDKFI23cW6aLj8VwJ1rFhyaOVAakA4TRiozhJJ/CQ2ggsDsF
 SUxrjlD41nltl5Gzf9uPBS5TWrV4gulIj5mTZ+CMF9d9Qtf40STaMWY4rs1FCZdm//p5AXfL
 2uGe0FDFmoOQFTCXlnlMuDo7t7Fu/6RAu70RxfXSZOJr+EWF/KBxJb1l5Bj4y7JLMKEeH9rE
 /w83ENHG3F/AcXQ3TsVGWQRkGrWYsiXqQ3ZmGU/p92j8PntRAPk5JeeQ7pUP9J1/hmqgKCFf
 +eOjSd9IDxc29sC33jNgLQY2VcTjWlpeVzPWfwYsjXRSavLhqJNJxscdj81K8ZCqa4xn0FMN
 cPdltLpx+t4g/oyWDInHRTqnsCkY9BPInnobgqdQhzRa/LfeHuXkKSVKeumRLZdjftZrUi1s
 DefSQr4Oyib0iPuXFapOP1NiyeSOFpfvpu8e1BjEzuGLpquZxulPdtwlTBzz6czgyaAEGcGM
 iVnNW5JoKeR6yxwnfh1XWBMpCkAT6HMi2OC4u/UJ4xD++NsGThxnvlG7W4SzrxI8GdbSfYzl
 CaY/bsM6xm21+KIzDRgSh9HrD1G0ZmKsUtVMqLc7pBcWHzA8XrlAk2PBh5Mq9Y3U7UHXohPx
 9KJmK+hcF+qEvrR+tYAQdfZIoSLPSh5WSc=
IronPort-Data: A9a23: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
 XcdHQh5fa1wdaI9/QuMtZKY9NH1cQ4DFwkVUBo=
IronPort-HdrOrdr: A9a23:kwnp6anTy7HySw4KqslA4G8YgNLpDfLQ3DAbv31ZSRFFG/Fwwf
 re5cjztCWE9gr5N0tNpTntAsa9qDbnhOVICad4B8bBYODNghrKEGga1/qb/9SCIVyAygc+78
 ZdmvNFebrN5DFB5K6Q3OD7Kadb/DDgys6VbIzlokuFODsaF52ImD0JdzpzfHcdeOBuP+teKL
 OsouBAuyG7dTA2Y62Adxw4dtmGjdvWj4jrJTkPAxJP0njrsdrR0t7HLyQ=
X-Talos-CUID: =?us-ascii?q?9a23=3Aso9782gChTbubtwcaRRPnVLFbDJuTXTD9V7MEkO?=
 =?us-ascii?q?DCmdDC57IZl7A1Y9hnJ87?=
X-Talos-MUID: 9a23:3TI/cQZnt3Sm/uBTmA30oihrBuRU+P6LWWILuLk9kMCUDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="213509404"
X-MGA-submission: =?us-ascii?q?MDG7za2IOEX36pDVGj6LFFoedc49/ZzjKInRvA?=
 =?us-ascii?q?eCztPWtKmOpoWukbF7rJHI/sTKHWraaNss+tSBDx9+L/tDHWjAMD8GvI?=
 =?us-ascii?q?Yd6g2vhoNpMV8eINjYe4yXGjavellD2ZetQYCJn3fAnLpbF1osIu4kwT?=
 =?us-ascii?q?Q3BKLeOf6SEMOlmul+oQJNig=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 15:21:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742307707; x=1742912507; i=markus.elfring@web.de;
	bh=N3Z0xfqmEBHgSTLfazDdh62Fh9l6Gok8zR9wQThvrIg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uMKMTvrTwbgT4m6XwuN/EvdDwi13hz93QhCUL+whrnRpk70BqMz8GG98idUpkbPn
	 CQGOud7tJQ6+H5mPBU0MhJR+mXTFWnKByFk9+U54YFodvmRv4l1j5xPwnMdqG/EHW
	 Lao6w7HjQOMMkMMHmrWDqsbocq+NpO/91b/qXM+NYYQaug6U1u+AYjxNXl0nPx/ld
	 zPlCKPR39wEeBbglE23txUiLMQAuBw7zVtIVLn7u0AKozHOqmZ6iLj4jpN9tO1KuF
	 86e0EP4OlqMkcCusQbkBSa92yAbrTCE0lFUPIb2DpQ6uFSM/V+J0Ml/lqHH8ZvlEG
	 4nkIc1NIL1ONtedTTw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.69]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2BMA-1tByi52KFC-010tfu; Tue, 18
 Mar 2025 15:21:47 +0100
Message-ID: <618afb48-b750-404d-98f2-d26a461fc357@web.de>
Date: Tue, 18 Mar 2025 15:21:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Edgar Khachatryan <khachatryan.edgar@student.rau.am>
References: <CAN1=rvJBSpCq35PY-tTFomZ17wNBRN=bNV4vwKTV-TgYe38FdQ@mail.gmail.com>
Content-Language: en-GB
Cc: cocci@inria.fr, Ella Ma <xutong.ma@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAN1=rvJBSpCq35PY-tTFomZ17wNBRN=bNV4vwKTV-TgYe38FdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ty14yHsl7yTz6mWtDPJmqYB/xIOQdbgNnbuL9sLu/432figdgKy
 rmjVA6bRsiHF9GLd79EdgKZanHoJqFbI/UVqnhJNwGAy1Yi+MpMnHWo06vFSSnPrcnMEOw8
 9fyPcp1qEMHyGheINKL9mGI3sExlxMkbfDCZ/L2s5DP9D1ZPRtvwzo0Y2sbKPl0bgh5HnRk
 7RdkMANVRbSx2aIxCmH8w==
UI-OutboundReport: notjunk:1;M01:P0:O1OAaiPOTBQ=;iRVgUFpq/JlyKBfMOZmfRHDbaCR
 x7ogNe8zMcrNqGcQepUOFWZzDZgwOne16SaP6YHMiP45eE6I31GuM95v2/yU7VZBudWvRnvhg
 PSUeblxEuWvEUK6F0O2J9N/XhVhV3PLL9VeYsb7Iyus1+9/ZO2F50xxfEq8UyPTLQVUHv80fk
 nn7VkMcIkvRuZx87/VeAh6dJ8pQ8dAfIucO4vAyYacDTDjZxCIQ/BtNirfc+ejP80Z46dj9Zo
 7NMw9xbSM7GEl5ltSCQIxRGOUVJNF0mUP/Q4AFjaxyb2Bp/kBnd0WcUOBfU6HHRSj2lxfhHKO
 NaqpYt4QHYtWUoDeM6tmdxoNnydVLeXFI3/OertQQWqvaB4qQBAF6euxTwglvayidJil8Th7h
 Q2f3qPkPOeBJ1YYABK5w6seVsXPdp/ETFOB08ssGNZaBY7msEA7SoLblbCRtR29i1qVOzRnM+
 IaqO4XAB/BgOkhCsEQW5S10swFDSqd93v2+ggYZNY30nQvLTd6afUt7ZXaqGrTAtfgBCeiS4Z
 z4IqwvZmC5DAbpCcpfwGQyKzqQ4NQb2TZb9HMiF9g/7WCD5GiLUuLmx96gphTRpA6byr/B05L
 vwZvHA/lD8yP78XOibPwew72Wwx4pkhWsfmFbCPL/dkerYYzAjDWLwSF0kXdcUt+Ze6LFnVp4
 42LXrm+5A8yl1SAsMUrH/g3s2YAR5n26RC1YWwS/uu5LDv9LhJwMfOCuK3/rMydi4vmf1NCKF
 CHGF5hgUxMY1mgV+TtsjBQzeDkxfBGuJBlBbU2b8yjXFaQy2ASJtjeRaK7RvVrvjbTr/8MATH
 Nvd95fjiuQkvIzKEZjKS9rAJJ72mr++58QfdTxeON7xQWs/xXKlrqnZFO7bT+MYaB8vgKN8Ny
 ar3aw5RTAmA1XcTrIuiOo7lxF7zgwJQcSLdpeoSVtqJOK6entfKQ0jfRLzQr8dcykStw3S7nc
 sB3JqiDbDldvfRy61jPa5B71otQLFQMvdcj1D4NOKsq+te7D3EiB0sZUKxkosZk1eDYl8In0f
 IeascGkLGPj4M893xwlbkkIke7vVrM7nuP0Pp/UzM3C1tKi7p1m+XSEp6xiq7eGAZH2s+RlgM
 MGUk7Nfc9wWkG+n26S308QQJOgwzLvM9f7n2wJR+78G8pPGL3l8/5sAPvR3I7mC2SC75MeWkq
 YPt5bwm4+Ho9yHmnPycSqo+P9XcJW8oukkAmGHFEsOs2gQlaAVDWz4xKaUcEQeqbIR6K8Kkev
 xQz+qzHPNQOKcvj+S2fYQfbKfXoGsP63xyqX++kgifPDuHtjcaT8fm34z9v8biyTxaBYiiKNE
 PTsEJhzuCP19g+uwdTQV4DMSvDpjpd77c5l74tJ+wdP6+qjwrQMJ9VMZogQRMuoUO35jBoDhp
 MydvPp27lmeAnQnVXFwwZ28DSMGv5xvDvu51LPBNhi3wirCfd7Uh7kC0YLEV8eu0xwvrN4v6S
 ra98QaJT+k45tThC4aIdJGs6pjLtWaJfrh1DA7G/iT2E/xXYR
Subject: Re: [cocci] Analyzing CMake Projects
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2623
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/618afb48-b750-404d-98f2-d26a461fc357%40web.de>

=E2=80=A6
> Additionally, I would like to know if there are any recommended ways to =
run Coccinelle on CMake-based projects.

It can occasionally be nicer to separate clarification approaches
for different issues.


> Is there an established method to integrate Coccinelle with CMake builds=
, or any workarounds you would suggest for analyzing such projects?
You can eventually benefit more from customised commands
and corresponding build targets.
https://cmake.org/cmake/help/v4.0/command/add_custom_command.html

Regards,
Markus
