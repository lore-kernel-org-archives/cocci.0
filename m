Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAECAEF5866
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2026 14:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=IPgw0wFY7gdr94n2j8UudBO6okDMJLjJkEZNp7COwbo=;
  b=HD3x+Fs/h1laOYitnuVJHeT5phfmemra5UayXKWt4UzrJd87AUvbywM6
   7BKpCUULPD4myMLHi3O7q96bhfj9kVujR/W5YP6TTNt9bPvuDxJthZ7F+
   k8x/YZkhQSgKj0AYz6Qj3YNb5CX34XDH1UMqqlmFwVUPV6UQfqeO6M656
   M=;
X-CSE-ConnectionGUID: gP3chw6iR6iZvRX1EzUuag==
X-CSE-MsgGUID: 5Po2xPJFQxagx3N39q2h4Q==
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
X-IronPort-AV: E=Sophos;i="6.23,108,1770591600"; 
   d="scan'208";a="266741665"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2026 15:05:24 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 5B48F812DD; Sun,  8 Mar 2026 15:05:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 4E74A80EE2
	for <cocci@sympa.inria.fr>; Sun,  8 Mar 2026 15:05:19 +0100 (CET)
X-CSE-ConnectionGUID: f1L3tUS+TwyD6AqmujQkqQ==
X-CSE-MsgGUID: vplfOqkURiulD1kqXuxysQ==
IronPort-SDR: 69ad821e_xiF2s/g9gfJrjCQiyL7fUyQVc0yEIANpPHMdeyMWyQM3PY5
 RRolhdYkBoWFHdfgdBV3IArWuGOynrV1Myexkjg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FqGAC3ga1pgAMP49RaHgEBCxIMQIErJ4FWAmdofTQEC?=
 =?us-ascii?q?0mEWIgehzWCJIQ7hzyHVYh5gVYTgWkCDwEDAQ0UATkBAgQBAQMEggyCagoCj?=
 =?us-ascii?q?SECHgcBBDgCDQECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QE7Bw4KMYZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBEScEC?=
 =?us-ascii?q?wsaAhEHDgICVgYBFAEBgn6CIwEGEAEDDycHqy+BMhNuggwBAQbaZB8sIlmBZ?=
 =?us-ascii?q?wmBHywDAYVtgmUBhi+EPycPgVVEgTwLgkcxPoN8gQaDHIJpgiaBDpMrUngcA?=
 =?us-ascii?q?1ksAVUTFwsHBYEjQwMqLy0jDzwFLR2BIyEdFxQfWBsHBRIhKoFpeIIBD4Zoe?=
 =?us-ascii?q?QMuXhoOIgI6XEo+CgFaBYIlAgELbT03CQsbBD2Ocj6BQYJ7gQxXkzCRVKFFN?=
 =?us-ascii?q?AeCOIFngWQMn20GEy+XUg6TC5kGIqkfghYMgVwzGiSDNk8DGQ+OIT6DdckPR?=
 =?us-ascii?q?TI8AgcLAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23:PrO3AxS0u9yec++ScZdTTJI/MtpsomKVAWYlg6HPa5pwe6iut67vI
 FbYra00ygOSAcODs7ke1LeN7ujJYi8p39WoiDg6aptCVhsI2409vjcLJ4qoL3O+B9PRKxIAI
 cJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQka3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+N
 hq7oAveu8UMnYduNqk9xgXLr3ZIdelbxX5jKE6OkRr7+sq/85lv/jhKtfk87cBAS6L6f6o5T
 bxcEjsrNn0+6dPouxfeUwaB/2MQXGoOnBVHGgTI8h70UIrpviT1quRy1i+aPdbrTb8vQjSt8
 71rSB7zhygZMTMy7XzahdZxjKJfpxKhugB/zovJa4ybKPZyYqXQds4BSGFfQsheSTBOAoKkb
 4sOEeUBO/pYr5LgrFcKtBeyGBWgCP/qxjJOm3T437A10/45HA/F0gIvENwBvmnKotX7NKkdU
 /y6wqbTwDXfbf5bwyvx5JTWfh0jp/yHQLJ+cdDWyUkqDw7LiU+fqZbmPzOIzeQGrmeV7+5uV
 eK1im4nrQ5xqSWoy8krkIbJnIEVyk3f9Sljz4g1IdO4SFR6Yd6iH5tdrC+bOJVtTc84Xm5np
 j83x7sbspG0YCYE0o4oxwLDa/OZaYiI5AruWuifLzl2i39rd6yyiRmz/EauxePxWNe53lhIo
 ydZjtTBq3AD2gLd5MWaRfVw4kiv1SiR2w3N6+xKLkE5mbTGJpMn37U+lYITvFzdEiPrhkn6l
 rGaelsm9+Sy9ujqYq/qq5GaOoRpkA/xKL4ulda6AekgMggBQWyb+eOk2b3m+k35XalKguc4k
 6bHq5/WP9kUqbChDw9U1IYs9Qq/Ai+43NgFg3ULNkxJdAyFgoTzJl3DIOr0APmnj1Spijhrx
 vTGPrP7ApXKK3jOiLDvcqxn605f1Qoz1spT6Z1QCrEPOvLzW0nxtNPDAx43LQO72PzrB8hj2
 Y8GQ2KAHreZML/OsV+P/u8vJ/ODZYEPtzb5L/go/P/vjX48mVAGZ6mmx4EbaHG+HvR8IkWWe
 2DggtkbEWsSpAoxUPTqiEGeUT5Uf3u9Q6U86S0nB4KnForDXYCsgLmZ3CihBJFWZ2ZGCkqNE
 XjybYmEVe0MZDqUIsB6ijMET6SuS5c91RGysw/306RrIvLb+iIGspLt18J76vXdmx897TB0F
 dqS03+OQW9uhm4IQjg23L1joUBnxFaMz7N3j+ZFGtNN//9GTwQ6NZ/Zz+FiE978VQzOcMmVR
 lu6RNuqGSw+TtcrzN8Uf0lwA82sgAnb0SSlG7MVjKSLBJIs/6zGw3X/Ottzx27d1Kk5gVkpW
 stPOnOihq547wXdH5fHnV2WmfXiSaNJ/jPJ9W7L6WORtUVcGFpyTKHEVDYbb1TfqdDR50XYT
 rboB65xdkNKzsWJK4NLbMfohBNIXqTNItPbNke4gWStHl6lwr2WbYzlMzE41T/eFVNCvgQd5
 3eAOiAhCy3nr2+IX28mLk7mf065qbo2k3i8VEJhiljSNyWJtpKw8x8R3rmHTu8Lm6kDoGEno
 il1G1C025TXDcCBrkxvZvYUessztXFA02+RrAlhJtq4Nak3o1cEcBls+W7q2Q92DIpojsUg6
 n8nn0JpMazN6FpabHuD2IzofLjeK2385heqPovfwFLDy5C7/qkV6fI3g0rutkelGxlq6G1ph
 v9S1XbU/ZDWFEwSXJb2B14w7AR/rqrGbzMV4oTJyTtzPKPyvjKqN8sBIuwjx17get5eNPjBD
 wruC4gBANDoLuU2ml+vZxZCPeZI9adyMdn0P/2BkLWmOupthlfExSxO/Zx930SQ9iF9Vv+A3
 pALxOud1xeGUDG0hUmos8T+k4RJLT8IGW/3xS/hDY9XLqp8GORDQUKnOc6q3ZNTg5D3WnhX3
 EGuDRUK1Y7heBafaUD8wRwFzV4e8jSsnSq1ySAxkil89PPFmnaUnKK7KVxcaQspDCF4gFzhI
 Ja5lYUfVUmsNE0ykQe9oF393+5drbh+KG/aRQFJeTL3JidsSPjV1PLKbshR5ZcvqSgSXv67Z
 AXQb7fnoAYBlQ7nEXFfwj8TaDyg/Jn01U8f6irVPDNooXzVdNsljzLW/t/BXrh82jQcRS93o
 SbaDB6wMpP6mLfc34eGuee4WWW7U5RVeiS+1oKMuhyw4mhyCAG+lfS+8jH+OTAzyjSzl9xjV
 CGT6Q35fpGuzKOid+RuYkhvAlb4rct8AIB31IUq1tkc3n0Th5Pd+nRi8y+7FNxB2r/lKlcJS
 yQKxdH9/wXvnkFuZn6E3IP2UHyBz9ApPYDgJDlMhWRksoYRQK6PpKRJhy50vka1oWezKbBmk
 zERxOFvoH8WjucVuRY8myCUA7QcB05dbmTnkxWF6cz7rb0CPj/1N+LqiwwnwJb6X9Tg6klGV
 X30e4kvB3p158R7axfX1WHrr5rjYJ/WZM4SsRudl1HBifJUIdQ/jKlv52IvNGTjsHki0+N+g
 wZp2MTwmYGdKHh2uo+9DARZMDLdeM4ZvD3gx/U7/I7ez8W0E5NtFy9eFr7hV/G1C3Q/sfr9N
 gCBOCIxoDGXFPCMeG3XoFcjpHXJHZexMniRL3RM1tRuSi6WI0lHiRwVVjE3zdYpUxqnz8v7f
 AJl9ygcsxTm/wBUxLsiZHydGi/P4R2lYTAuRN2DIQpKu0tcslzNP5XW57B2GDxEuIKspkqBJ
 ySSNQFPEH1MSkKDHU/qJLXo+tTKteSVY4j2Z/KcZLKTtalUUOqOzp/pzYZsuTqBfszdO35/E
 7gwwUBeWXM/Qs3fl2xJQCsS8kCFJ8fJoRCh5mh8tcu46uytAQvp6dLJALxXecNm/xT86UuaH
 8iXgisxaTNR15dXgGTN1KBax1kKzSdnaziqF70E8y/LVqPZ3KFNXVYdbGtoOc1E4rhZvEEFM
 NPHit7zyr9zj+IkQ1ZDW1v7n8i1ZMsMa2ijPVLDDUyPOfyIPzrOi83wZKq9T/VXgoA2/1Wov
 i2HFkb4IjmZvzzuSgzpLuxGyi2WfVRftIy7bhdxGD3jQdbhOXjZeJd8iTw7x6Fxh2ufbzdGd
 2ImLAUU8/vLvkY6yr1lFmdM72RoN7yBkiedtKzDL4oO9OBsGmJynv5b53Izz/1U6jtFTbp7g
 ni3zJYmrle4n+2I0jciXgBJr2MBoYuRvlh5f4jd+INBX3ns4x8Hq2mdQUdvxZMtGpj0tqZcx
 8Ka3rr0MytH+snI8NE0As/JNISYPXBnPRejS1u2REMVCDWsM2/YnUlUlvqfo2aUopYNoZ/pg
 JMSS7VfWTTd89sFB04jENFQeP+fsRs7nLTdgMNavBJWTTHUQ9hG+I/KXLSeDKe3QAs=
IronPort-Data: A9a23:jf7oBaseHCTTaCwYbarHf2KLmufnVDRaMUV32f8akzHdYApBsoF/q
 tZmKWuGPayJZWH0et4jaITjpkMF7JDRmNVkQAtv/Hs8QnsUgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOhTrOCY2YpGFIMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMTdJ4RYtWo4vw/zF8kgHUMja4mtC4ARlPaAT5TcyqlFMZH4hDfHpR5fHatIMdgKKb
 76r5K20+Grf4yAsBruN+p7nclcHS6LlJgOHjHxbQcCK2nCucQRvukqTHKN0hXZ/011lrfgpo
 Dl+ncDYpTMSA0H5sL91vy+0vM1JFfYuFLfveRBTuCEIpqHMWyOEL/5GVCnaMWCEkwre7K4nG
 fEwcVgwgh6/a+2ezuufEfVRvYcfM9jHYqoGv2xi9DLANKNzKXzDa/2iCd5w2TAtmoZREPyYa
 8dxhThHNk2aJUcVZRFOVdRl9AurriGXnzlwjVuPprcspUXXwhZw1rfFL9ffPNCHLSlQth/E/
 j2frzmoUnn2MvSB0T6L1Wuvu9XOgCfXAYELJKCo5+VT1Qj7Kms7U0FGDQDr/pFVkHWWX9tAI
 kgQ0jgvqKIo/QqqSMP8Vlu2uhastRkXUNt4CPw/8AjLy6zO4g/fCHJsc9JaQNkhqdNwWjEgk
 FOE9z/0OdBxmLPMbSmBy4zXkSyjFXY8NGofZxYHVDJQtrEPv7oPYgTzosFLPIPdszEYMTT33
 izMsyU0wbke5SLq60lZ1QGX695PjsGXJuLQ2ukxdj/1hu+eTNP0D7FEEXCBsZ59wH+xFzFtR
 kToZPRyHMhVUcHVz3zSKAn8NLCu4fGeeCbR6WNS820a3231oRaLJNgOiBknfRsBGpheJVfBP
 hWN0SsPv8U7FCXxMsdKj3eZUZRCIV7IT4S9Dqi8gxsnSsQZSTJrCwk3PRDIgTC9zhlEfGNWE
 c7zTPtAxE0yUcxPpAdajc9EuVPy7nFgmzHgVtrgwg650LGTQneQRP1XeBGNd+01pufM6gnc7
 98VZYPAxgR9Qd/ORHDd0bcSClQWclk9J5T98PJMesC5fwFJJWAGCt3q+40HRbBLpapuu9ntw
 mCcQW5dkVr2um3GI16Fa1dlc7LeYqx8pnMaYw0pZEik60E+bdyR7YMaTZ8WfKYmxsNn3/VbX
 /kIQOTeI/VtGxDs2SURUon5l6NmLC+UvAOpOzG3RRQOZLtyblXt1v69WSW37wgILC68lfVmk
 o2azgmBHKYyHVVzPvjZeNeE7g2Xv0FEvMlQQkGRAN1YWHu0wbhQMyar08MGeZAdGy7imAmf+
 R2dWyoDhO/3pIQwztnFqIaEo6qtEMp8BkBqJHba35nnKRjl+nef/qEYXNaqZTz9UEbGyJemb
 8hRzND+N6Qjt3ROuIxeDb1q7Pwf4/3Cmrxk9TlnTU77NwmTNrBdI3e9zZZusI9JzeRnogeYY
 B+E1eRbHrSrA/nbNmAtCjArVNne6sFMqALutaw0BG7Y+B5I+KG2VBQOHhuU1w1YArhHEKIk5
 uYD4/wpyhGNpScrFv2kjSlk0XuGAVJdcqcgt7AcWJTKjChywH58QJXsMA3Ey7DRVMdpLW8RP
 S6yuKrOo59+13jyWSM/OlaV1NUMmKlUng5ByWEzAmigm/3Ht6cR5wJQ+zFmdTZl5ExL/MwrM
 1c6KnAvA7uF+gppo81xX2qMPQVlLz/B82zTz2o5rkHof3OKZEfsclJkYf2s+XoH+V1yZjJYp
 bGU6Fj0WAbQIf3e4HEAZl5HmdfCE/pK6QzwqOK2FZ+kHr47QwbfrI2AWG4qkybjUOQN3BDph
 O8y5+thS7zJBQhJqY0BNoSq/7AxSheFGW98fc9c7J45RWHxRTXj9gWNemaQe9xMLcPk6UWXK
 dJjDeMRWgWc1BShlCE6B6kNL+VKndos3t4je6zqF0ECobCwvjpki7OO1ync1UsAYcRirtY5E
 azVLwm9K223gWBGvkPwt+xGBzaIWsYFbwjCw+yFyuUFOJYduuVKc0tp8L+Lk1iKEQlgpTS4g
 RjiYvLI8ulc1ohcpYvgPaFdDQGSK9moduCp8hi2gutef+H0LsbCmAMEmGbJZz0ME+MqZO12s
 rCRvPrc/kDP5u82Wl+EvaixLfBC4MHqUddHNs7yEmJhohKDf83R+DoGxXGzLM1YsdFa5/T/f
 TCCVumLSYc3VetelVpvUAoPIyZFXu6zJu3lqDimpvuBNgkF3EaVZJm7/HvudidAejVOJ5T6D
 RTutu2z4sxD6r5BHwIAG+osFqoQzIUPgkf6X4aZWfik4miUbpeqv7z/iVw/5DuNBnTs/AMWJ
 37abkCWSfhwkPigIBJlX0haoRAdSnpw6QX1VlxI4MZ40lhWE0ZfRdnw8vw65lV8jSH4kp31D
 N0IgK3OFg2lNQl5nd7ADBgPk+tR6iHi+js0G9Dxw36pVg==
IronPort-HdrOrdr: A9a23:80ZKo69oRYyphy5Jeutuk+AGI+orL9Y04lQ7vn2ZOiYlF/Bw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhPpICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtt5
 uIGJIfNDSfNykYse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-Talos-CUID: 9a23:yhkCpmByTh0drnb6Eyc+0BUIJ/tmTmLM4Cn5OkqlC19qUYTAHA==
X-Talos-MUID: 9a23:0F01bQYp4sElweBTqSfoihZ7N/pS4rmqJBkOiKUbq9ifDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,108,1770591600"; 
   d="scan'208";a="140718598"
X-MGA-submission: =?us-ascii?q?MDG1xsVHU6+u4YexQrpFw1jD66FfTMERcZYkbA?=
 =?us-ascii?q?HtfG+QjVZPtGoXj9OP8RpCjc9KPO1JYZiV5YUkg6M3m1qPAtw3EP4JmG?=
 =?us-ascii?q?GIEEhwOtD/SB/QD0V2BYuTZR/zsFJeUWmbscRjeZ2gJabkWb/eZ0E8Yh?=
 =?us-ascii?q?jGuVpxoehsap/g+kn/6J5QGQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 15:05:19 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXoca-1w9GnB2xNE-00OUhN; Sun, 08
 Mar 2026 15:05:17 +0100
Message-ID: <66c0fefd-0963-4cab-a29f-82c1a7a9dfc3@web.de>
Date: Sun, 8 Mar 2026 15:05:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <349a12a9-f70d-4c8f-a730-9f8ec90b593f@web.de>
 <f25025ab-4500-4315-b41c-53cd5775c69f@web.de>
 <20a815aa-5fa9-4b34-ab81-d6985ed193c0@web.de>
 <bc3eaab-b09e-4e67-054-b522d723c6a@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <bc3eaab-b09e-4e67-054-b522d723c6a@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:rG9cqnBqA4SwnxyvK0Z2ybHqGVZiJtoLVMo/inLdx9rYpPab3T2
 OsMzBP59w6a65TJXv0YxWYW064xeoxFwJLDzZe6raqhZIKW+JJuP3RL2N9rOd1ryUqLy0VN
 Nyvfj4QJJaxIw9QniVe1+MP6r1FhwGRc2fzmVUQd//4iCwhlNMlE/qShUIvgNS4wr6Orq2x
 ULstd1zvCHG3wVUEwetAw==
UI-OutboundReport: notjunk:1;M01:P0:u0NaYyCLKRs=;nPNzAQlBlQign2cKoVlmRnTQwc6
 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
Subject: Re: [cocci] Reconsidering source code search challenges for nested
 compound statements
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3330
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/9FupX23hlb-iDQrPUeUCrQ>

>> Additional context information can become relevant then.
>> How would you prefer to handle control flow recursion in safer ways here?
> I have no idea what result you would like to see.

I would appreciate further data processing refinements.

A) I would find it nice when selected source code transformation patterns
   can trigger usable patches from minimal SmPL script variations.

B) Ambiguity should occasionally be avoided in more succinct ways.


>                                                    The whole point of
> Coccinelle is that if some context information should be taken into
> account, then you can provide it.

I hope that known software limitations can be adjusted accordingly.

Regards,
Markus
