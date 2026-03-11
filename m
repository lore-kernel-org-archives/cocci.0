Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFCC1049523
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=D7nUDKuPEo27qEdLzygrEIBg986pkmH1euYjXXqF7Ws=;
  b=fWvtKXKrS+RvpPcPfPMtlPYAlNHV0pWmncXdN0aw/hiIPxZu6OcwIJFd
   BnHh3I6i5ipNIAJnwG9170FBK4nM2XMbXntFCfWkM/Vg2Y5Kq3lBboqBN
   vlfRHExjKaTmqkyu+bCxGNddf8QIBB0gTyAQ/fIU0WWF0hhL8dL3MPN3G
   0=;
X-CSE-ConnectionGUID: GoMU5w+STdG5ve+5o2A7Ww==
X-CSE-MsgGUID: rKm/OenVQmOBPQwFQX0Lfw==
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
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267246220"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:30 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id A94A2818E0; Wed, 11 Mar 2026 10:46:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 3E697803DD
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 10:19:42 +0100 (CET)
X-CSE-ConnectionGUID: 3/5EKna8SJ2I1gFSfbTY3w==
X-CSE-MsgGUID: vRU+OqEYSKCyXRv2305ywQ==
IronPort-SDR: 69b133af_7PrDSO56rhvc0WCvp20OCWyh65fBrz18HJqxxtuAvxqsTYB
 9BK96EYmOAZTYrw3we6sQ9NytZ91jjZGkh7R/1A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GPAQAdM7FpjxCjxsBaHgEBCxIMQIFFC4FuU4FoMQRUh?=
 =?us-ascii?q?FiDTAOOJQOBE5tcgms1CAIPAQMBCwEBLiABAgQBAQMEhQACFo0NAh4HAQQzB?=
 =?us-ascii?q?g4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAQEBATkFS?=
 =?us-ascii?q?YZPDYJiAYEkXgcJOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BHgEBA?=
 =?us-ascii?q?QEDARERBA0MAQE3AQsEAgEIDgMEAQEDAiYCAgIlChUICAIEAQ0FCBqCYIIjA?=
 =?us-ascii?q?QZKAwECAqIrAYE9Aooqen8zgQGCDAEBBgQE3gkJCQEKAYEKLoU8gxcBAYFwg?=
 =?us-ascii?q?kqBIAEZhAB6J4FlQ4EVQoIwOD6ERRWDRDqCL4M0jE2GVglJeBwDWSwBVRMXC?=
 =?us-ascii?q?wcFYUIQMwMgCi8tAhQNEBIPBBYFLR1wDCcSDx0XFB9YGwcFEiEqB4FBeIFmG?=
 =?us-ascii?q?w+GaHkDLl4aDiICKBIDMgQjgQYLWgWCLAIcAwttPTcGDhsDBDp7BY1rPYIUH?=
 =?us-ascii?q?wEBgQ6BBj18GJcsr1YDBAOEHJlciDIXqmsuh2WQcyKodAIEAgQFAhABAQaBf?=
 =?us-ascii?q?iSBXHCDN08DGQ+OIQwNCRyDQo89Abl6RTM8AgcLAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23:paTpXRz8smJKUunXCzIP31BlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 xCZva0m1g+SANyTwskHotSVmpioYXYH75eFvSJKW713fDhBpOMo2icNO4q7M3D9N+PgdCcgH
 c5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFRrhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTezbr5+N
 gm6oRneusUIgoZvJKY8xgbUqXZUZupawn9lKl2Ukxvg/Mm74YRt8z5Xu/Iv9s5AVbv1cqElR
 rFGDzooLn446tTzuRfMVQWA6WIQX3sZnBRVGwTK4w30UZn3sivhq+pywzKaMtHsTbA1Qjut8
 aFmQwL1hSgdNj459GbXitFsjK9evRmsqQBzz5LSbYqIL/d1YL/Tcs0GSmpARsZRVjJOAoWgb
 4sUEuENOf9Uo5Thq1cSqBezAxSnCuHyxT9SnnL43bM03vo8HwHa0gIuHNwOv3bIo9v6O6gfS
 vy1w7LUwTnfc/9axTXw5Y7VeR4hu/GMWrdwfNLfxUcpEAPFjUmQqY3iPzOT0eQNrW2U4/J9X
 u+zj24otQJxoiO1yccql4bJnIwZwU3D+CpjxIY6O964SFVhbt6iDZRQrTuWN49xQsMhX2Fou
 SE6yrsBuZ6lZyUKyZInxwLBZPyDaYSH/hXjVOOILDp+mXlqd66xiQyo/ki81u3zSNO00FBSo
 ydFjNXAqnAD2gLd5MWFVPdz8Uiv1SiP2Q7T9+xKLlw4m6rVJZMl3rM+mIQfvEbNECLylkj7k
 q6belk49uWn9ujqZKjtqJyEN4Jslw3zNroiltaiDek8MQUCRXWX9OWy2bH54EH0Qa1GguM3n
 6XFvp3XINkXqrKiDAJU14sv9QqzAjSj3dkYn3QKLldIdReZg4T0PVzFPer2Au2lg1u2lTdm3
 /DGMaPlApXKNnXDlbjhcqx460FGyQozycpT55NSCrEdPv3zXlX9u8DfDh88KwC0wuDnB8th1
 o4GRG6CBrGVPLnPvVKM5e8jOfSAaY4btTrnNvQo5ubijXojll8ceamp04EXaHe9Hvl+OUqZZ
 WTjgtQaEWgQuAoxUfbqhEeGUT5UZHayQ6M85jY9CIKhE4fOXYGtgLqd3CilGp1afHxJCleJE
 XvwbYWLR+8MaD6OIs9mijELSb+hRJM92hGvrwL60LpmLu/M+iICr57j1d515/fSlR4o7zB0A
 d6d33mLT25vhmwIXSM53LhjoUxhzVeOybV0j+RXFdNN4PNHUR00OIbSwOJnE9zyQBzOfsmKR
 li8WtimBD4xQcg0w9AUYkZ9H8+ujhHF3yq2HbAVk6aHC4Az8qLZx3T+OsV9y3fD1KQ5l1coT
 cVAO3O6iKNj8QbfH5PGk0CDmKawaasRxDbD+n6bw2SBpE1YSxZwUavdUH4FekbYsMn36lvZT
 7+2B7QoKgtBxtCGKqtNctDnlUxISu/sNoeWX2Xko2exAReQ3vusZYrsMzEF3CzdDg0DiBs79
 GiDcwQzUGPp6WvbAHlhG0LHZ0L37fI4pmm2Q0M51AKWaFUn0KC6sFZBjPmQDvwdzpoAuTw9s
 HN6Bluw09/NCMaHv0xmZqoKJZt36U9f3HjcsBZVOp27M7skm1QDdRhq+Ujp0l8/XoxYicEwq
 XQw5A5zMr6Dlk5LajWEwNb7PbiBbiG49gihQ7DZ10uY09uM/KoLrvMipB+r6AuxGGI8/Hh9l
 dpYyX2R4tPNFgVEFdq7WUsv9112qq/XZgEj6I7Ok35hK6+5tnnFwd1jTL8uxw6gOttSLq6AP
 BH9HtdcBMW0LuEu3V+zYURAdKpZ86U/PuunceGH0eilJqwoyDmhhm9GyIF7yEOFsSRmHKqAl
 ZoAhv2VwAaDfzP9l0u69MT2n51UIz0fACD3nSThQYJceKB2VYIKEnu1Zcm2wMhuwZLgRSgcv
 BSvHVJD1MK3dB66a13mwRYW214arHCqgiikyCQylCsm5OLL0DbPhujvahcDEmpKX3V5y1n2L
 IW4gssZQE+wKQ8zm03hrQz1ybMBjKB+NHXIB0NJeTXmaW1vTOH44rWMeJRn7JIzrT4RVOW6f
 EDcRrPj9V9SmSLlA2ZagT81Zxmuu47lhFp0km+QIHtor2beYYd33xiVrIjdQ+Jc2n8JSjlQj
 TjMGkP6McOk8NmZjJTftfj4UHiuANkbOyjt0Y6E8TS6/2BmRBm2mdi3m8b7Ck49yjL8zN0sU
 j/H5l6oY4/32qD/LuN9c0UtAFb6w857AZ1l1IwrmZYL3T4dnJrDuTJNkGD2NMhz3aPlcGFLQ
 T8N3s6T7AX7kgU3L3WMwp/RUnSG3tAnY9i8f3NQ1i8juYQCQqSK6ZRakiZv5Fm1twTcZb56h
 DhXga8t9nsyne4Eokwuwz+bD7RUGlNXa2ik3RCJ6c2u6axNYSOsfKK22U5WmdG6EKrEowdSQ
 n/1d54uWyhq4Y83ZFbN1mDjr4j+fZzTYMgVuxm8lxbbk/MTKZQ/jPMGiCNrf2Xnsithg6Q/j
 BpzzdSwuI+MKE1z86+jRB1VLDv4Y4UU4D6nxfJan8CLz8WlGpJqGR0VU5byC/GlCjQfsbLgL
 QnYVHV2rnadBKqaFwuC5VthqG7PO46kOmvRJ3QDy9hmAh6HKwYX1AQVWigq25Q9Cw22w8v9c
 G9n6T0LoF31sB1BzqRvLRapFi+VoAaudydxQoSFIgF+8A5P/QHWPNaY4+Y1GDtXtNX1qA2LN
 3zebRhSA3ohREOJHRbgM6Oo6N2G9PKXUK72Zf/PZ6ie7OdfWeyg252iyM1l8iyKO8HJOWNtR
 bVv3ktFQGA8EMXXgB0RRCEN0SHAdciWoFG74CIh6oj19PXtRRKq7o+MI6VdPM8p+B2sh6qHc
 emKi2wxfTJZ0I4cgHTMy5AB01MIzSJjbT+gFfIHryGbCOqanq5REg5eZjl0OtBg66MnwhILP
 tzfg9nukLligbR9X1NEU0Hx38yzYsIRC2W8L0/cQkGZML2MPnvM2c6hJev2TbxWkfURug2s5
 R6FHEL5eDeOjT/kU1aoK+4GxHWfPRpDqMSwYgoxIXbsQcigaRChNtJzyzoszutwzjnONGgBI
 X1yaE9AsLCUxT1Xj+85GGFb6Hdha+6elGzRu+3ZLIsG9PVwDilqmuZy/ns30f1W4TtCSfgzn
 zHd+Jom6VWnlPSfjzV/UR1mtDlGnsSIsF9kNKGf8YNPEz6Q+BML8HXVBAwLoPN7BdD1/aNd0
 N7CkOT0MjgUt5qe+coaGtiRKNOfPWA/GQTmFSSSDwYfSzOvc2bFiAYVxPWT8GCF65grspX2h
 rIQRbJBEl84DPUXDgJiBtNUZN89WjIijK7ejcgQ+GaWshbcXoNZs4rBW/bUBu/gYn7NibhCe
 gtNwLXgMJg7KIL2wQphZ0N8kYCMHFDfC5QF6ClgaBIk5UZA6n5zSkUt1E//LACg+nkeEbizh
 BF8wl96YOIw5HLv7k0xK17iuiQ9ig8ylM/jjDTXdyT+euP4F4VXDTfk8kw8PojTXQl4d0uxk
 FZiOTOCQKhexfM0cWFtlR+ZvZZDAtZCQqBeJhwd3/eaY7Mvy1sK7m3twU5B+PuADJZulQICb
 5GhtTRD1hhlYdpzIrbfbuIdyllWm7LLuyKk1+kZ3gATPQAO/XmUdSpOv1YHYP1ubS6p+PF8r
 AmDgyBrZmcBTbwpr+hs+0d7PP6PhWq0179FN1D0Mu2HNIuHtGXa082FWFU90gUPjUYTufA81
 cYlblrRUkUHz6WYHBdPMtDNY0kBa8tU6WiWeCOmsvvEypEzOJ+yQKSgB+uPsrsEx0ejEBstE
 p8k8MsMBN+v3VveIMOhK6QKg1154AXtOUXACfNFZRaGix8ZrMylipx6x49QIncaG2ordW394
 rfRux9vheaPdNM3eWsBGIoCOGg/VMCzl2hepXsKRG2z0+QE2E2H8zPUoiXLECK6btxtfv6Ya
 BpgTtas9mN7u+KyiFjK4tDYKXrSK9tvoJnM5PkcqpLBDOlbB/Ept0bahpkdQXKxe3DAHMTzJ
 JXqbYQoK9vuBSD+Gha7ijQoX4L2Od+1BraHjBuuRotOtoSfmjc5OoX1QjUfHQpg4uYG7bpUe
 wIOedw4bATuugB4MLawdkPQmNGvRXu9bCNWXtFbzP6mfPpWySQ2Z+O3wXdmSYs1haHj9U8LW
 YFPlhHP7fKifJVFFyn1FGZUdwjGqWw+jWc3cq54xuY53QONqVw0LT+GbqpqZXZCstV6Akmda
 z0iDms+Wk/ZlY/r/AGhxfYR8jFbktIS1vdK5jy29JveZi+8Hbasopbesys4RdwnuLFqd43lL
 NGPuJ7XknrYVpaa+lmBUSinB79AndNTKyJZWNFMmHo5IooHv4Rb4EY8X8t4IKZAXu1k7LSrb
 yd0SDVJnHcxSYyNxnoBj/261r+ckQ2fOtx2NB0CrYUHmYBMCwZobS4E4qyuTYPbkymDUGddZ
 E9Z6QVK+RJFjYRrf8j774fSCpxB0Thbp7RzSCSBXs1s9l3mWiSNikP5YOuunvbv3g9Iyv/ol
 N4BV0g7QQJZxuBLhg4zI61vA7cfs5SMsTKSc07++mX3x6HucF1Qz9DEMkbzEJLtq2XxSGsf9
 GcSSIsJz2vQQ9Ba2Q54brs74U5BK528e1rvojkjy5ltEpGmWs2xgVUot3ALQ2GtCdULQ7Vis
 VTKSHh+bpu2spT5KtBXRWNN/JC1tVhUigNuPjS/xJ4aLNtCtHpEFjxOpyiN+cCyYNNM1NUwD
 JIWJNp7/XDnF+kMbJyQpWAm/6fv4mHW9ip6s1qgwji3XaiiQLQdtycaGwM0NyGFrVQpA8My/
 WrItFPAqFZ5+6FcHLfFxRF1oTBgDtVVAStP2Vi7IFlpCnpLqeNXLOLSacMKB7F4YR6pJgx7D
 uIjhBah5l0xmHu8ZiVzsg5T/WbGQw4uUDMYmrP83zYZr4vvbTsbTY9YKC49anyfAxmH3CVb+
 RNWakVvUpZfGcpC4bQB0JNQ74zJTkP6bWlPWB1kKxJ9zeBWnkMGs0iCfy3ZJRSneOyJsRBte
 8qV6smzI76xqANGjJ739fwi/q4OAn6rgwugRfjAoILm8N6HrE2DcOH/KeLqJTeLSDnKkAD1m
 KwuJ4fF8jKVMwdBLZR+j30+btKpXWrKOwlWYr8ALWJFWq1gL9ZLuOZXY4ljYqlfvecnAhOBW
 wOqB421of1LNU37WzvTNWOC//a5rIaV6qbSA6C0Ys2K2maCXKNtM5N38iLTBbjny8ld91Dw1
 /Mr8Vl1HxyOeSaMsNjsOCsV68S4MEjvpJskGXXRGpg62C7ry11MetQ/XSKn6tIbxYlf5XK2T
 vh3hAy7+utO+aI/wY02+Kxyj8O1I7rCb/hXrwUvVh6ICB4x3pEsG3RkAWRQZPIBbvvcY/Jdx
 Yr1ouX9HukL5RaV/e1SYN/vI0DahtL5ETiZQxUCmx0O43ZONQKZ3ffAh6J/ScCkruH98kYs+
 ESlaAUPybpko4Ce9fzM7KXMZBvcwf0JSrTCQsLosq9qv0KU+O1imLMQMCQheAanHeRYW94B7
 mPh1rwxiyYtFd7TWb7t5qgHHzgllyjvlow4E1gIF/c8A7WG58Jdk30+luifMccZOOgWhm+VG
 hO4V7MP13OvwzWYLXMjgRzU1Rz0B2Sp4wmy5WVkQDPHitviiUFITaK2AkF6WyuyJVQ+qzSSJ
 gHlut3ttqlz6kwqeCSwqNOVny6tOahcAtbkJduaCS01v04MyoY2W8ak1I4cA9WwZtEc7Cc6J
 rHAum2wuytAuLtcwY7f5NyFvPnaAzPo27PLpa6lwDFD1mN+uVA598DmOvzQsY6kWfOtgiw1S
 CRjugzHWADx4pXfolMPMEqHyg2DzIUOM9JC1H80zAfi4+s/QdU18xt2F4DcavdErjf2bmini
 W2Das46A3HNmwBcGUj4RBwhQPBUMAPYucvIkS2V4Fg0XsxqcEehgxVrDoI+IEZr6V4NwyNFH
 xJeIQuDAuSOAkLoZZABSVBFcQ6OibG+d6Qs1Et/2PWr4+zPbOt6ALQlN/BBgwrIl19eSdoNq
 aNLeLtnYBdG8bLP4A3rCozpRf/jwHM0OP6uS8ZW64YdsHg+4wG5QASI6JFf4rJdg5eNJeZfe
 ZaZmsd64g984CIXMCxAhB8qlxSiTeUVv/zu+PDev5Ot4+eqEqcrW+gTsRMzAgySlrPWh1Yu6
 ZHS3uZYEMjOjJjntRpKKDiMsZrb1B91LawPLZiqdfBu7SdPIS9WPH8IMdeMDpt0qyZwLDXe4
 UBDCcIQdJsZOsTKgwVdlkzuXvla6MPaHlaSD4o7edov6iL7zzU88J10VeiFinf+LJTS7EpEO
 f9ZyiFrl87Do+4S39LTDjQa5T+SbB00iiKOxp+RCurhqP2WwYKxNRtOFSo3XoFBYTuarFX2H
 KzsxcWvC13PrJat0/dcPAqKS3e8nboIqPNJGO9E0GDg2yRGU5ryjLSTusat721eshtGFpxy5
 FvLAvY6XN0zNBLmm82sXkU5CDH4fZSefx4ju/GfwOsWpeF5NFf/YokcPDoFza737TxeSQ4kG
 9uU9h6JGPkcYtdrUqaOp3RY6plpLaMVelyap4DrqTFPtng3BhMkbPk7qTkQJSys1EVFHq3zv
 rAHkA4VV9V07FRNFWyHM2U7/zPbVK5RgcF9EdQt+y6IBuwLWkRsaGZlRg+tnY9pcP2vlOxGt
 WVPmmV8puIr2npoXkn0tSrprqMLkTUundPw/DwFtH9eR+OSiWHMDlZfzfMMirk0CnD+5Fj6a
 34GJIf/+7hoI838+JJpuiVlJ0xyL2tfA7/mUn+4hrjtYMTHqN9GgR+RpMjCJaS+KyQfLPV1y
 B7uQWR8zhmLmR9p9GURRTDzib1sbI65OMsj2m+pAT2CJQxKu/IZ9pKv7hhSErhTCxsp2mho3
 8mZSzdYQcXOHzxwlQ04cSBed5kF7xYGFq4uizLOv69c/whSbi2Hd+btsoTWg8rM3mEwCNlww
 WeD7KSBi5Ax2XtpgZVw6S2SuXMUcPLwUslwD3y13YBag7+bBb3loqUcRY1qxa70GvYGP8q48
 G26wtNuXUy5x7MYGESRMekfy7OdWCCgAz79O6zDYy2HmDA3NVT37B+jIwgsactEmEQ6N/PLm
 p9WkwCyGaMxXCibokXXiXAyKe5PPRxjo5+pIkZZKYxZL/jZP+Ulx+cyTUcBf2OcVzUjEPe46
 BashNQpYiQ6pxyrMaK0rFugaJzIRFFBGIre5Pad4NScQWSMcT9lxRx2Zgxv8vvHUk42valae
 oqQmt7Zg5J61/QEfrFjK391vNlbgY9l5YSOtaXCORjM0pb/I83UqfmEErXeyUotYGRTTrseZ
 0v8+Yw7OtczX7CbE6FeuFwQAq0zQZppMGmUluk8NARobgvYf6i5mOHvqeuOb5pQ4X7Q8l80a
 izbvlxLy/C5SxB6c4H/h3j2J8NVJHoJpNlsBx16WYpXTppR9Uz+Us7Swf/gzYbvqCYY86cQv
 KH9C+7HzoG81oR1Bd1B4FCTeSzWD+9ti1hkieK7hrHB1IPwAIXsY4BhNqAzT2jbZ7vBBoj6J
 CiJP5e2ckpL8KWV1r5jFBGWZzz4WKyBqgWlMulp5QMwzYkyL4+xhHQ9qqrW3tf/fTQRviC4s
 XuAL4dS9nTPCuXbVhNQD/uD7GthW6YQaMGnkYVGecxny9+a7Q5p6T1E28bQOKmtoHjH3Udjf
 I7aJk/ks87WcYgMPBm7d0ArhD2Awpw8KXFTJ82tKM0rgdCJAxir7E50yzlFjotpG2z0SNPXM
 m8eiZrWWQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:kAf3dK7saJ9oCLec2wPXwd6CI+orL9Y04lQ7vn2ZFiYlCfBwxv
 re5MjziyWE8Qr5AEtQ7+xpOMG7MA3hHO1OkMAs1NCZLU/bUQqTXcZfBO7ZqAEIdBeOhNK1uZ
 0QD5SWTeeAemSS7vyKuTVQcexQteVvmZrA7YmuqgYIPGYaDdAbnnpE40SgYzlLrWF9dMgE/f
 Gnl7t6Tk+bCAcqh7OAdwk4tob41qL2vaOjSyQrQzQg7w6Dhy6p7rnVLzi0ty11Mg9n8PMJy0
 SAtxb2yJmCnpiAp3/h/l6Ww4VdmdPnxNcGP8qRl8gTJAzrjwajdK5hV7eBsD1dmpD21L9sqq
 iun/4nBagdmhHsV1DwhSGo9xjr0T4o5XOn40Sfm2HfrcvwQy9/I9ZdhKpCGyGpsHYIjZVZ6u
 ZmzmiZv51YAVfrhyLm/eXFUBlsiw6dvWciq+gOlHZSOLFuMoO57LZvoX+9Iq1wQx4S27pXTt
 WGy/ustcq+RGnqM0wxeFMfkOBEEE5DTStuCXJy8vB9mwIm10yRiXFokfD3101wvq4VWt1K4f
 /JPb9vk6wLRsgKbbhlDONEWsevDHfRKCi8cl56DG6XVJ3vAUi96KLf8fEw/qWnaZYIxJw9lN
 DIV05Zr3c7fwbrBdeV1JNG/xjRSCHlNA6djv129tx8oPnxVbDrOSqMRBQnlNahuewWBoneV+
 yoMJxbDvf/JS/lGJpP3Qf5R55OQENuFfE9q5I+QRaDs8jLIorluqjSd+vSPqPkFXI+Vmb2Eh
 I4LXnOzQV7nw6Ws1PD8VfssinWCwHCFLpLYeTnw9Q=
X-Talos-CUID: 9a23:jCdl6G8/vhnFpcwwDyOVvxVTR+0GdHSN91WKAha3J11nQoGkEkDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3Ae1/oMg5DhTiApMZHPJK2gtHqxox22ZntL1kgoK4?=
 =?us-ascii?q?lkNi0DzIqYG/AnSuOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267237946"
X-MGA-submission: =?us-ascii?q?MDEKXAd1NwUDE1EowGumQUJbxBiuVdZX5dh1DA?=
 =?us-ascii?q?2Ovyfsl8uigwpkkIqBHfo8UUmWbVw8b0T2Sz8GyEYMl0hxVo5qP/RM69?=
 =?us-ascii?q?FrOjUzYsf13SZZR6Jpqcl4uK7JIvnjnoVlkvvx7+SH+BN/hfKM+W31vR?=
 =?us-ascii?q?s+5fMRAm4W0FlXQj2fZISVrg=3D=3D?=
Received: from mgamail.intel.com ([192.198.163.16])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 10:19:42 +0100
X-CSE-ConnectionGUID: XJrC8LibTnSqtOCJsrXanQ==
X-CSE-MsgGUID: IsPsRsX7TYeuqIBqA8VubQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="61856220"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="61856220"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:19:36 -0700
X-CSE-ConnectionGUID: 46pf2HV9S7Of7BUNrfOaVA==
X-CSE-MsgGUID: TdTMS6l7SK+FX+N1UIsSHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="258314280"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:19:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:19:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:19:35 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.34)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:19:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOGRW+21ayl7yzpaMXG8IDRvFnYbGJUDpVyo3NDYSpk+0PwwjHXS2xfnxc5bTyRZwymkJpwUlVyCP6ghD8tbbbtl/Fg3xhpcwVz2+eptBybtliryDiV4MplbQYoNVDxNB/2G+Nk1uGlpwGd2wr3h6xnftI6gnJtzVFzMYX00F9H2oY5dKSc/RhKeLKMXqthsd5nDveZrGgki9C1z5ij+LomeMPYFiVXNqfcFo0iHp9VQdR0HrobjPNK9Dp33aLIfetrd85AXEQ/5tSBnmslNcFtCS14ViwXpmZ6Ku1qxom1ymoN/bwBs/S40aGP/E3cwV6cnGl5/AqRaH2xldsnzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7nUDKuPEo27qEdLzygrEIBg986pkmH1euYjXXqF7Ws=;
 b=h1RAnkHJkwi18zhB7Ptgz2ymSl8UDIiA9LjueX0p6Mca63mNvLOAIKQxqUe8OcpH29stMJstkBHagzOXxKBUDtuGsovAFt4xH/+QCoOvS85UvEgU6xnln/75CUeXedJ+4oWVFCS8DQ0oJ6zgo+LpgBVyx2goSYJ8ZVQPJ3JPMPetApWjcj+VuCyC3Bp2z2e/heg1XewrfFrdh8eLdzCoO2mdmVWN6FiTJpfV0NnwOIqVHmfVtVMAdUVVMQrRUDsTFGTJsdfgG88ACnKjSBVGRDtAyYx6NSKpyTRcuHu8MonQPJTEyx1tF0cqh32/3ioRKu5Bj63an35Cxsq8NX2KPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7897.namprd11.prod.outlook.com (2603:10b6:930:7d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 09:19:31 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:19:30 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Philipp Hahn <phahn-oss@avm.de>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "apparmor@lists.ubuntu.com"
	<apparmor@lists.ubuntu.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "cocci@inria.fr"
	<cocci@inria.fr>, "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>, "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-leds@vger.kernel.org"
	<linux-leds@vger.kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "linux-sh@vger.kernel.org"
	<linux-sh@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ntfs3@lists.linux.dev"
	<ntfs3@lists.linux.dev>, "samba-technical@lists.samba.org"
	<samba-technical@lists.samba.org>, "sched-ext@lists.linux.dev"
	<sched-ext@lists.linux.dev>, "target-devel@vger.kernel.org"
	<target-devel@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "v9fs@lists.linux.dev"
	<v9fs@lists.linux.dev>
CC: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Benjamin Marzinski
	<bmarzins@redhat.com>
Thread-Topic: [Intel-wired-lan] [PATCH 22/61] md: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Index: AQHcsKKfBp0x5V0NgUq7H82vBk96YLWpDwOA
Date: Wed, 11 Mar 2026 09:19:30 +0000
Message-ID: <IA3PR11MB898600282FF5877B7BA5F6A4E547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-22-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-22-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7897:EE_
x-ms-office365-filtering-correlation-id: 6a1600e1-fbfd-405c-1a68-08de7f4f4d43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: JlkxGI1KNes5SM4EPeAdCVfP4oDnmvDeYpX/iNiNHKxD2Q4TiSg2fEub0BCtGGhtbunsUWplSf0FvjD9bp4cllC0bxNEMK+ESQLH15YQaLFKxhnM8o8HongNJCHIzvbgdb0yU6RWc0GWS1dsVi/s/XAWyXTjrzn2OxzUgadFHkzZ6tm9d8vKWdfZstTzTNdOOAj/iP+OJRRdtFWDDrNUKp3SAZ4DzpdOegZ8drGWVpB0fG5IhZd3avRmgABsuQBrTkJU6H+jmC10KEUsswpfkjHpVWOrzzKbMINrZYJrwwJb0pAzOcRxijVBeOU1ZkVoBtMalt2F3RJ+trjGPOrDfuBBZoqhD5aMOAkEn9WFCb21dyFBK4xdDVwXKgswu3s7xcLR0OrmECftDKxvXyRYeFfTCiX3JvCjHXVFHcWCjh5X2pdKmkm3Dsdbh87PURE6gZU0FnVzsfiKGeokE1hm9fFdILMJB7cqcjfyduTWIlaEZsK0KHXLB7W3DxgXDI1CJQ4nl1xP70SU5WPmaMifl9KCQivy8YCp9oxZFvtgkcpwklu2uE42X2xVi/o/R0UvwkUPj63e1vNHa2T1IuaH2P1uDuafc9majAjExU1OEetnoXLTB3FK3suXtiKP6soCiPuRPposC1tiI+jtetlAHA49Z/aeEVUQibhPSmhST/b62+4Q8a/lDZVn4rXLYJKFLkqUROEHyLiR+lR9kBbYTGNpGfZ6jMj4ijc5WlfV+OYUZHmGb7wVPEx9TgqF4lAk82hyfk2yM8C35lO9pLVts4+4xV1kc66GQWgYvLkLo1gDicrEATJ9/5Ps1wiBkCBp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEV0Q3RJTDRzdUJuOE02Wmc2RHlmbHRBVWFkdDdBcktxNW8wUlZKMkZOZWJ3?=
 =?utf-8?B?MHJQdmxJUmJkWkxjWHdJSkVFUkJhZmczWW9VazJ6c1R5MlIxRXVpMFJqUVh2?=
 =?utf-8?B?cWFXSldIMllTWnh5L3orcWpvYlFLYmw2V2tWeGZYU0N5NmF1V3FmSThsSjRC?=
 =?utf-8?B?Z0MwNEljKzc0a0F6WGRGMlRvTVB0ejYxL3RmVVovdEpuTUU3MkF1NHBUTEZj?=
 =?utf-8?B?T1BYOUVuM3Q3eEVmMkVPZG1iTkFhQm1TQlIrVC9YMDhuQ2VSajhWUGMwZWph?=
 =?utf-8?B?QnFHVnFTRjhnRWh6WGFRSnJQbVk0bEQ1V1o3Nkc5UWhUM3Vqb3BwTUZ6TUpV?=
 =?utf-8?B?S1NZOWU5MzByUUNLYWF1R0ZidHZHZ3J0T09vYktXbmJRR2Y5dU5kRXJIUFFD?=
 =?utf-8?B?REVHanZyaXI1QjlBVmJBbHhnOGVJWWdNbXNUN3ROb0RzODAwcUYwYU5aSkZn?=
 =?utf-8?B?M3BrcE9JNVVjUHcrMG5PaFlQVUJ3a0oxRC9GZGMwZ3Z3aUYySE9pTWFXVE1Y?=
 =?utf-8?B?cVZWV25xK1RGbkZRa2tFZElheXBkODRpVTVIZldJUm1NNG1VeGJzajZ0UnJM?=
 =?utf-8?B?Sk1MdFl0QmpoTk0zVXRoZ1ROWG56d1doK01iYURUOWNqeXBDa3E1YVNBUXBu?=
 =?utf-8?B?cGY5ajVSZkNyZ09TSTNPL1hGL0ttWU9ZQ2FPbmY5Mjh2d0FMYjNNS05McmNZ?=
 =?utf-8?B?VEZDYnloOGYvV0FUcGRucWJoZkhEbHpqS1dQUlBYa2ozQUt5MGdOTGloTnp0?=
 =?utf-8?B?VU0rc1phd3d3MWVZbFFUcDhPY0hhUzlIaVdvNjMvcmljUjZLZUY5cnZ2Qjhn?=
 =?utf-8?B?aHlRbXdRaExDcEpGQnRreWQyR2NQMFpYQThUS0h4K3RPSnl6Q2dVYXhGMnFS?=
 =?utf-8?B?MzZhVjlJcUFyd2MxR0dvaXZ6NDZJVEs4eWYwL2hEZ29OVGREaFJTZGgvOEJT?=
 =?utf-8?B?U3pCMWdVcDh2VEhVK21BYlVDYno3MHhUQVJoYnF5VEdQQmhnT2dZWC85UDIy?=
 =?utf-8?B?VC9HR04xeklSQ2ZQLzlkSGQybm5QT1FsOVlZbzJaOEp1RjFuWTdwcWloR0ZK?=
 =?utf-8?B?WEFMYW84cVZtSU5mL0djdndFQTJFNStOMSs4aU5xYUxQUWJReWhPSjF5OFdP?=
 =?utf-8?B?NnpaTndGSHBLdWQrV1JJaHpWMlg2aWloS0hzVU84cytIV21Hc1hsUE1sMTR3?=
 =?utf-8?B?NFRTR0V4aUozRlJkeW92VjhtZXJoNDdlN0RxTjNBZjRmdW4rRG5ST0Q0aGhX?=
 =?utf-8?B?R3VKanhCM281NVR6MDh5V0hrb0FPdVc4RHQyM3NpeDhxVEMvUFo2N24vVWcw?=
 =?utf-8?B?Y1I5UE5ndWpKNnhrRG01MWEySWxHWlBVeS82SngwV0Z2Y2hwNU5DUEpwOTN0?=
 =?utf-8?B?THJ2ZkFBNW1IVFRLM3FYQzlKVHFGQmRrSk5pWEhReWc5c0RoRzYzdjQ3dW1h?=
 =?utf-8?B?V3FLcUFKbzI1VC8vRW5aNHQwaTZYL29GNTBhQ08vb2lrbGhmUmphMEIwZkJX?=
 =?utf-8?B?c1FaeEsxdTE3VEc5STFyQ3FVemxQVUs1eFR6RHlwclJJc2JoYnB0blpZcFFk?=
 =?utf-8?B?ZGR6ZWpoOVcycmZmcmNMK3VQSWhOaEtZWjdneVduSWRCMHE3eW90TzNDc1Fa?=
 =?utf-8?B?SjczdzlJT2tYdGhudnU0TFdnYTRRN24xQWNFek15eXM0dmdCcnkzL1RaQXFm?=
 =?utf-8?B?SGdVM0tkRXBwKzhzYXV6ZHlwZkNUTVM3SDR5N1hrWGRvWGlrbHV1VS9weGxL?=
 =?utf-8?B?U3hkeE5mZ0VBMm1vUC8zRE1YdUU3cHBrVGdEZkFSRjN6Yk14ZWcvS3pCUmRL?=
 =?utf-8?B?SFdqbmhGRWdmOWdPVUMwVjZreGR4RTVGUTFWVUlmeEFKRkdJM2twbUY5YlVK?=
 =?utf-8?B?ak5nTDZuV3NwU2ZVeTAyb3ptUGVkQk5nS0tiODVrbE9DWit3aVA3czd4UjA5?=
 =?utf-8?B?dEJuZU5oaWc3RTVLbHNRTkNMSjA3NlU3alFWcEJYVzl4OFZFWDIzNkJvMDVr?=
 =?utf-8?B?ZFFRUE9iUUVYa3czdnNNQTNGalM0d20xdlFTdTdKaTN1dXZLZTArYklMU2RX?=
 =?utf-8?B?RkljdndMdEhMV0twRk9uSGVCUExWUnd2cVpoUldYeHFIbXl6TzQrWmhMNHJX?=
 =?utf-8?B?UXVmRENGS1NBR3BnSzVKR3FBb0dqMVZRdklxNFJnL1h6a3MrcWRTOXo0SXk1?=
 =?utf-8?B?eUV5d3NCUVNSM3F4Z0lWM3haMHJQR1BCNUwyT1dldlJxR3J1ODRCNzFIS1VM?=
 =?utf-8?B?OUVZb3ZNRU1hWG5sZkt5NUZsTk9NZkpyV1dzM0RMeGVUWXUvalQvYmtpTUc2?=
 =?utf-8?B?WWk1TUI1OUtnU3lsNzRndDNPa2VLY1JkL21QZUZrbGZzSHg1aGhNMGYrZW5L?=
 =?utf-8?Q?PWCV9o1gkKx3kQ5w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: opkXWzvr9+5iDDZTc0HWriaOOVbQDkf+oFL6/qS7jlbwfRf8japWyBNENI6otrFpWubOIECWz4GCkEVTyh259InxDlE1qc3CmglEFZZLaMkw9cSq3lqA1N04/i6byJOyvyzOCZuinPiDwu51bfDjt54kKTjkj6ASrNT8smclHgAuAneHzlLALuaaX0DpSA2o1bBulkUkcVOnKg9wNx08jqKxOTy2akwzjp7I+jaGfXfJAPV+slv0zS/eJGwcGcP3ib3+08l4PlA9MlWpBbdGkKgkUOUE9lZwvc3DqRGYBnpDXH3rASakEX/Ng8jMHa1H7ygFs9vs8fxm7RUyHuwB1g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1600e1-fbfd-405c-1a68-08de7f4f4d43
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:19:30.8201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rcMSWlihf874ebTGWI5rWHXg56vV2OaJWOiuprdMU1jWfA0iXSnL6QVl+yp5XR9hl165XANg2V3jcXhiXIgSO/ilyCY8z2S33Z8g7i5MG20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7897
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [Intel-wired-lan] [PATCH 22/61] md: Prefer
 IS_ERR_OR_NULL over manual NULL check
Reply-To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 3402
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/P5Yw9hP1NKtd0gabLXrk7A>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgUGhp
bGlwcCBIYWhuDQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDEwLCAyMDI2IDEyOjQ5IFBNDQo+IFRv
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgYXBwYXJtb3JAbGlzdHMudWJ1bnR1LmNv
bTsNCj4gYnBmQHZnZXIua2VybmVsLm9yZzsgY2VwaC1kZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IGNv
Y2NpQGlucmlhLmZyOyBkbS0NCj4gZGV2ZWxAbGlzdHMubGludXguZGV2OyBkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnOw0KPiBnZnMyQGxpc3RzLmxpbnV4LmRldjsgaW50ZWwtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgaW50ZWwtd2lyZWQtDQo+IGxhbkBsaXN0cy5vc3Vvc2wub3Jn
OyBpb21tdUBsaXN0cy5saW51eC5kZXY7IGt2bUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtYmxvY2tAdmdlci5rZXJuZWwub3Jn
Ow0KPiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBsaW51eC1idHJmc0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiBjaWZzQHZnZXIua2VybmVsLm9yZzsgbGludXgtY2xrQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtDQo+IGVyb2ZzQGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LWV4dDRA
dmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWdwaW9Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gaHlwZXJ2QHZnZXIua2VybmVsLm9yZzsg
bGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtbGVkc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBtZWRpYUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LW1pcHNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7
DQo+IGxpbnV4LW1vZHVsZXNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgtDQo+IG5mc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW9tYXBAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj4gcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXBtQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHJvY2tjaGlwQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxp
bnV4LXMzOTBAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gc2NzaUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LXNjdHBAdmdlci5rZXJuZWwub3JnOyBsaW51eC1zZWN1cml0eS0NCj4gbW9kdWxlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtc2hAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gc291bmRA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29t
Ow0KPiBsaW51eC10cmFjZS1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC11c2JAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj4gd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnOw0KPiBudGZzM0BsaXN0cy5saW51eC5kZXY7IHNhbWJhLXRlY2huaWNhbEBs
aXN0cy5zYW1iYS5vcmc7IHNjaGVkLQ0KPiBleHRAbGlzdHMubGludXguZGV2OyB0YXJnZXQtZGV2
ZWxAdmdlci5rZXJuZWwub3JnOyB0aXBjLQ0KPiBkaXNjdXNzaW9uQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldDsgdjlmc0BsaXN0cy5saW51eC5kZXY7IFBoaWxpcHAgSGFobg0KPiA8cGhhaG4tb3NzQGF2
bS5kZT4NCj4gQ2M6IEFsYXNkYWlyIEtlcmdvbiA8YWdrQHJlZGhhdC5jb20+OyBNaWtlIFNuaXR6
ZXINCj4gPHNuaXR6ZXJAa2VybmVsLm9yZz47IE1pa3VsYXMgUGF0b2NrYSA8bXBhdG9ja2FAcmVk
aGF0LmNvbT47IEJlbmphbWluDQo+IE1hcnppbnNraSA8Ym1hcnppbnNAcmVkaGF0LmNvbT4NCj4g
U3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIDIyLzYxXSBtZDogUHJlZmVyIElTX0VS
Ul9PUl9OVUxMDQo+IG92ZXIgbWFudWFsIE5VTEwgY2hlY2sNCj4gDQo+IFByZWZlciB1c2luZyBJ
U19FUlJfT1JfTlVMTCgpIG92ZXIgdXNpbmcgSVNfRVJSKCkgYW5kIGEgbWFudWFsIE5VTEwNCj4g
Y2hlY2suDQo+IA0KPiBDaGFuZ2UgZ2VuZXJhdGVkIHdpdGggY29jY2luZWxsZS4NCj4gDQo+IFRv
OiBBbGFzZGFpciBLZXJnb24gPGFna0ByZWRoYXQuY29tPg0KPiBUbzogTWlrZSBTbml0emVyIDxz
bml0emVyQGtlcm5lbC5vcmc+DQo+IFRvOiBNaWt1bGFzIFBhdG9ja2EgPG1wYXRvY2thQHJlZGhh
dC5jb20+DQo+IFRvOiBCZW5qYW1pbiBNYXJ6aW5za2kgPGJtYXJ6aW5zQHJlZGhhdC5jb20+DQo+
IENjOiBkbS1kZXZlbEBsaXN0cy5saW51eC5kZXYNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcCBIYWhuIDxwaGFobi1vc3NAYXZtLmRl
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvbWQvZG0tY2FjaGUtbWV0YWRhdGEuYyB8IDIgKy0NCj4gIGRy
aXZlcnMvbWQvZG0tY3J5cHQuYyAgICAgICAgICB8IDQgKystLQ0KPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tZC9kbS1jYWNoZS1tZXRhZGF0YS5jIGIvZHJpdmVycy9tZC9kbS1jYWNoZS0NCj4gbWV0
YWRhdGEuYyBpbmRleA0KPiA1NzE1OGMwMmQwOTZlZDM4NzU5ZDU2M2JmMjdlN2YxYjNmZTU4Y2Nj
Li4zMmY3ZDI1YjgzYTE4MWEzMGE3OGM2NjNkNDhmDQo+IDc4ODJjYjk3ZjdiNSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9tZC9kbS1jYWNoZS1tZXRhZGF0YS5jDQo+ICsrKyBiL2RyaXZlcnMvbWQv
ZG0tY2FjaGUtbWV0YWRhdGEuYw0KPiBAQCAtMTgxOSw3ICsxODE5LDcgQEAgaW50IGRtX2NhY2hl
X21ldGFkYXRhX2Fib3J0KHN0cnVjdA0KPiBkbV9jYWNoZV9tZXRhZGF0YSAqY21kKQ0KPiAgCVdS
SVRFX1VOTE9DSyhjbWQpOw0KPiAgCWRtX2Jsb2NrX21hbmFnZXJfZGVzdHJveShvbGRfYm0pOw0K
PiAgb3V0Og0KPiAtCWlmIChuZXdfYm0gJiYgIUlTX0VSUihuZXdfYm0pKQ0KPiArCWlmICghSVNf
RVJSX09SX05VTEwobmV3X2JtKSkNCj4gIAkJZG1fYmxvY2tfbWFuYWdlcl9kZXN0cm95KG5ld19i
bSk7DQo+IA0KPiAgCXJldHVybiByOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZC9kbS1jcnlw
dC5jIGIvZHJpdmVycy9tZC9kbS1jcnlwdC5jIGluZGV4DQo+IDU0ODIzMzQxYzlmZGE0NmIyZDhl
MTM0MjhjYmQ1MWYzZWRmNjQyZDUuLjA1ZWFlM2QzYzdkZjZiYWViZDBiN2E0MjE5ZjcNCj4gYjY5
MzhmNmU3Zjg3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21kL2RtLWNyeXB0LmMNCj4gKysrIGIv
ZHJpdmVycy9tZC9kbS1jcnlwdC5jDQo+IEBAIC0yMjk1LDcgKzIyOTUsNyBAQCBzdGF0aWMgdm9p
ZCBjcnlwdF9mcmVlX3RmbXNfYWVhZChzdHJ1Y3QNCj4gY3J5cHRfY29uZmlnICpjYykNCj4gIAlp
ZiAoIWNjLT5jaXBoZXJfdGZtLnRmbXNfYWVhZCkNCj4gIAkJcmV0dXJuOw0KPiANCj4gLQlpZiAo
Y2MtPmNpcGhlcl90Zm0udGZtc19hZWFkWzBdICYmICFJU19FUlIoY2MtDQo+ID5jaXBoZXJfdGZt
LnRmbXNfYWVhZFswXSkpIHsNCj4gKwlpZiAoIUlTX0VSUl9PUl9OVUxMKGNjLT5jaXBoZXJfdGZt
LnRmbXNfYWVhZFswXSkpIHsNCj4gIAkJY3J5cHRvX2ZyZWVfYWVhZChjYy0+Y2lwaGVyX3RmbS50
Zm1zX2FlYWRbMF0pOw0KPiAgCQljYy0+Y2lwaGVyX3RmbS50Zm1zX2FlYWRbMF0gPSBOVUxMOw0K
PiAgCX0NCj4gQEAgLTIzMTIsNyArMjMxMiw3IEBAIHN0YXRpYyB2b2lkIGNyeXB0X2ZyZWVfdGZt
c19za2NpcGhlcihzdHJ1Y3QNCj4gY3J5cHRfY29uZmlnICpjYykNCj4gIAkJcmV0dXJuOw0KPiAN
Cj4gIAlmb3IgKGkgPSAwOyBpIDwgY2MtPnRmbXNfY291bnQ7IGkrKykNCj4gLQkJaWYgKGNjLT5j
aXBoZXJfdGZtLnRmbXNbaV0gJiYgIUlTX0VSUihjYy0NCj4gPmNpcGhlcl90Zm0udGZtc1tpXSkp
IHsNCj4gKwkJaWYgKCFJU19FUlJfT1JfTlVMTChjYy0+Y2lwaGVyX3RmbS50Zm1zW2ldKSkgew0K
PiAgCQkJY3J5cHRvX2ZyZWVfc2tjaXBoZXIoY2MtPmNpcGhlcl90Zm0udGZtc1tpXSk7DQo+ICAJ
CQljYy0+Y2lwaGVyX3RmbS50Zm1zW2ldID0gTlVMTDsNCj4gIAkJfQ0KPiANCj4gLS0NCj4gMi40
My4wDQoNClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlv
bm92QGludGVsLmNvbT4NCg==
