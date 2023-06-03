Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3ACCC7EE2C
	for <cocci@archiver.kernel.org>; Sat,  3 Jun 2023 11:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DI3P+Dttdu9TZ+49//GIxY9yk8FM512o3hgtt4qz5bs=;
  b=nc9tthSHKRUtMpTGbFNdvFqGiSVH4DVs9Lsdyhg3jv45yXlUBpZRT5ii
   3T2EKZdvruNDV4TbrAnvtdMf02x1ax+icm/YRbEnxkfok1U8iOOJ6RpSq
   LhykJ11tLDUMvwUqV4XgYIMKqwewwiAVSwasNz02VUjAafj1ivFeOCa/9
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.00,215,1681164000"; 
   d="scan'208";a="111059106"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Jun 2023 13:20:50 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 896CEE0AF1; Sat,  3 Jun 2023 13:20:50 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 00083E0094
	for <cocci@sympa.inria.fr>; Sat,  3 Jun 2023 13:20:41 +0200 (CEST)
IronPort-SDR: 647b2209_QbVmfl1hWPS78BjBWjcN+mjZMF4ctCufCA7dQF5qvhRpaxb
 MZnD+b6yASehjTdfhxKLxxOG4ZZFiWjQeEmCO6Q==
X-IPAS-Result: =?us-ascii?q?A0E7AACVIXtkhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIudQNTMAQLR4RSiB2Iey6ENpdggVaBQD4PAQMBDTkIAQIEAQEDB?=
 =?us-ascii?q?DiBFIMzAoVhAh0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?QECEAEBASMXBw4QJ4VoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAg06PwMDIwQZAQERJgEPCxoCJgICVwYBDAgBAYJ6AYInAQMxBw2tXn8zg?=
 =?us-ascii?q?QGCCAEBBpwOHywiVYFfAwaBFS0BjGxChDEnD4FVRIEVJ4EVgW8+gmIEGIFGg?=
 =?us-ascii?q?1uCZ4IahwqFFYQ7iWmBKW+BHoEifwIJAhFngQwIZIF0QAINVAsLY4EgglUCA?=
 =?us-ascii?q?hEpExQFTHweAwcEAoEFEC8HBDIfCQYJGBgYJwZTBy0kCRMVQgSDYgqBFEQVE?=
 =?us-ascii?q?RGBJSUEDgMZKx1AAgELcD01CQsfBiYBHgIrgVcwWG8KJCSdDAOCBX16JxiVK?=
 =?us-ascii?q?QeSWZ49NQeCMIFbgV0MihKVCQYTL5cTDgaSK5gQII06mlmBYzqBXDMaJIM2T?=
 =?us-ascii?q?wMZD44gDA0JhAWEYYpnPzQCOQIHAQoBAQMJhUYBAYV+AQE?=
IronPort-PHdr: A9a23:cJjulRcSSkBwvwQfK5d/vNholGM+p9TLVj580XLHo4xHfqnrxZn+J
 kuXvawr0AWUG96Ktrkf2qL/iOPJZy8p2d65qncMcZhBBVcuqP49uEgeOvODElDxN/XwbiY3T
 4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx7xKRR6JvjvGo7Vks+7y/2+94fcbglWhDexe71/I
 RG2oAneuMQbhZZpJ7osxBfOvnZHdONayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU
 7FWFSwqPG8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XCmp4
 ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWWZNQsNdWipcCY2+c
 oQPFfIMM+VWoYbyqVQAsAWwBQesCu7xyDBHmnD40LYm0+Q4CwzKwBAsEtwMvXnSsd77NL0SU
 eewzKTQyjvMdelW2TTg6IjTbxsvrvWMXbxqccrQz0kvGB7Og1KXp4P/JTOV1fkNs3OB4+RvU
 eKvhXQnqwB3ojig3cothJfGiZkPxl/Z6yp02YA4LsC3R0Bne9CrCodQtz2EOItsRMMvW2Flt
 iYkx7AEt5C1fCgHxZU7yhPCaPGKbpaF7x3/WOuPPDt0mnJodKy/ihux7EWuxeLxWMe03ltOo
 SRIj9fCumwL2hfO5MaHTf598V2g2TaJzw3T6f9LIVoylaXFL54t2LkwloAcsUnFAyT4m132g
 beIekk55OSk8frrbqvkq5OGKoN5ihvyP6s2lsG7Duk0KAYDU3WB9em/1LDv5070TbtMg/Yri
 KfWqoraKt4epqOhAw9azIIj6xGnAjej19QYgGUHIEhLeR2ZlIflIUzBL+7gAfe+hVSjjitry
 ujYMrH8HJnBNGbPnKnjcLpn9kJRyBA/wN9H65JREL4BIfbzWkHrtNzfCx80Kwu6zPz9CNV+y
 4MeQniDDKCdMKPcq1+I5+QvI+aXaY4bpjnyMOIp6OPwgnMhn18SZrGm3YELZ3CgAvRmP0KZb
 GLxjtsZC2cFohI+TPD2iF2FSTNce3GyUL4g6TE6E4+mFofCRoW1gLObxiu7H5tWZnpHCl+WC
 3voeZ+ECL8wb3epPsJ/nzpMb7+6V4ItyVn6rgjh17drMsLb/SoUsJP4kt9v6LuX3RUz8yFkS
 tiH2mqACm15gG4MbyE50bo5okFnzFqHl69ijK92D9tWstZASAQnLtbxy+JgCtb9Elbkd82KV
 U3gb9GoGzA3QfouztVIb0srSIbqtQzKwyf/W+xdrLeMHpFht/uEhxAZRu54wnfCj+w6ikU+B
 9BILSugj7J+8A7aA8jIlV+YnuCkb/dUxzbDoUGEy2fGp0RESEhoS6yQeHkFZVbN6/n96FnDS
 bCGFrktdAdMmoaZMqUfUtTylh1dQev7ftHXYma/gWC1UDOB3LCRd8zHf2sH3SPSIFcJmUYf8
 CXOLhAwUwGmpW+WFzlyDRTvbkfrpPF5s2++R1Qowhuiakp8y/yq9xRTifH0p+o7+LUCtW9hr
 jx1GA34xNfKE5+boBIneqxAYNQ76VMB1GTDtgU7MIbyZ6ZlzkUTdQh6pSaMn11+F5lAnM42r
 Xgr0Bs6KKSW10lEfi+Z2pa4M6PeK2379hSiI6DM3VSW3NGT86YJoPM2zjer9CSgDEk/6DNK1
 9dP0n2TzorHBkweXNO5U0o68QR7u6CPejM0tMvf0XxhN7XxsyeXgYtzQrF/lVD5IpEDY8bmX
 EfoHsYXBtajMrkvklmtNVcfOfxKsbUzJ4WgfueH36iiOKBhmiinhCJJ+tMYsArE+ixiR+rPx
 5tAzeuf217Ncj7mj0q69O3zl5pFYz46AWe1jyTpTt00BOU6bcMQBGGiLtfijPB3nZ3wQDh18
 FC5BlUJ8NCkc1yeYhauuG8YnVRSqnuhlyyiyjVymDx8tauT0hvFxOH6fQYGMGpGLIV7pW/lO
 pP8z9UTXUzzKhMsiAPg/kHiga5SuKV4KWDXB0ZOZSn/aW94AOO8sb+LYsgH751N020fde2mY
 k2BDJP5rQEb1SzLAGZUgjw2Pz2noZT2mRVmhXnVdi8p6iCDJocpmFGDrNXHDeZcxD8HWDV1h
 Vy1ThCnMt+l8M/V35bPv+aiVn6wA5hacC3l14SF52Ow4WxnBwH6nujmwIS9V1Jgjmmiip82B
 kCq5F7mb4Lm1rq3K7did0hsXxrn7tZiX5p5is02jY0R3n4TgtOU+2AGmCH9K4Y+u+q2YXwTS
 DoM29OQ7hLi3RgpC3uTxJ/iEFiZzNFgYdaSfW4cnC4wpZMvau/c/PlfkC15r0Dt5yfYe/tgh
 XEwzfU06XgVq/4Eskwhw2/OZ9JaVVkdNivqmROS6tm4p6gCf2ejf4+7009mlMygBrWP8UlMH
 Wz0cZA4EWps/91yZRjShWbr5NiuK7yyJZoD8weZmBDag61JJYItw7AU0DF/Nzu1vGV5mbRi1
 1o0h8785dLZbTw3rOXjX3s6fnX0f59BoGi3y/wEwYDPgsb3Wc88UjQTAMmyFKjuSmhN8624c
 V7JSmJ0q2/HS+CGQknAsgE//iiJScz7cCvGQRtRhdR6GEvNfgoG3l1SBWhr2MZ+TF7ixdS9I
 h0guXZOvBii8kQKkqUyaFH+SjuN/l73LGhuDsHOdlwIskYYuSK3eYSf9r4hT3sep8P86lbXe
 yrCPFwADHlVCBzeQQm9Y//0voGGqbLQQ+O6K7Gmjaymj+tYWr/IwJuu1tAj5DOQLoCUOWEkC
 fQn201FVHQ/GsLDmjxJRTZF3yTKJ9WWohux4EgV5oi27ejrVQTz5ICOF6oaMNNh/AqziLuCM
 OjYjThwKDJR3JcBjXHSz71X0FkXgiBoPz6jdNZI/TbKV77Vk7RLAgQzbiRuKI1X4qh60gQMc
 c/Xh9Xp16Jp2/44D1AWMD6p0sqtZMEMPyS8LAadXRzNbu7ZY2SWhZ2kBMH0Aaddh+hVqRCq7
 DOSEku4ey+GiyGsTBe3d+dFkCCcOhVa/oC7aBdkT2b5H7eEIlW2NsF6iTouzPg6nHTPYCQ5O
 CJ/blgLg7me9yJejd1gFmYH4ncvfozm026JqvLVLJobq64hGiNvi+dT+2g30ZNQ6zxYAuN4k
 m3eo5Q9xjPu2vnKwT1hXh1Urz9Nj4/epkRuN5LS8ZxYUGrF9hYAhY1/IwsHrZ1pB4+200ix4
 t3Iib61NzpItd7Zr5N07y38N8+NdnYsY0KBJQ==
IronPort-Data: A9a23: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
 RzyOpE9A/Rp/qxUeA==
IronPort-HdrOrdr: A9a23:mDX5ka1gvo1iGzfSjZ8x8QqjBGYkLtp133Aq2lEZdPWaSL3+qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SODUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrQd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3Ad8QtMWodC6PO5JdOCzAzQwXmUYNiVyzX/ifJH2O?=
 =?us-ascii?q?pFHlXZu2EaEKbqZoxxg=3D=3D?=
X-Talos-MUID: 9a23:9E0YygWz99kzllHq/BLcnzhmD8FK3523M20cgaQgo9G+FRUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,215,1681164000"; 
   d="scan'208";a="57761574"
X-MGA-submission: =?us-ascii?q?MDEdnsc4BPyzbtw8ZMMS1CQFDNZ/gduHyZCThP?=
 =?us-ascii?q?dGx5YDiRR7fpFl589iwQs7f++IQrYh411MeWSPVuE2EHpIGFqaAy6fFR?=
 =?us-ascii?q?VeRqlM3PiZTY6Jb7nkbTxcqVWL6fC88/7mYFI7fKwheihhhTcPqkVSlY?=
 =?us-ascii?q?9EaxIOyeB4pjwcJKD67YU7Cw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 13:20:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1685791238; x=1686396038; i=markus.elfring@web.de;
 bh=ZgtBTxKDQY0CJoSzcZyuKuOZIhk9PCwX8WBZuE0VhxM=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
 b=XMI0Zl7qcrWWa4JT4H8taFHoVw7kOfewzZpvJpHtoGBbE+RpikPpTlNGTWirP2fUjeCrieD
 Q0LJaDR8suVsikMao5/mhY6ibkmmIui3MF+T+HpUZSNM4Qy3pBLzjmEibpy6bclchR0ysulYV
 TFVue1UbvDqbGB+T8Z+fSlHQHAIVzhDShFMdBZ536nph28cyS4SepACOy+L5EVbNy7y+On/GS
 x9zg+hO+MqPVbkWGACZEuRkBhVQfB9aixMzYVZyaX2vEZG0+RI8srAv5Pe05Nr6J3DTSBUm4+
 qDhAAA4FndtzRnx7pWPwHXZYBgqgcV/i6tPEDfCROiZsC2MYL7VA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N30dV-1qD1D91wKr-013Pws; Sat, 03
 Jun 2023 13:20:38 +0200
Message-ID: <8b23bb42-0b20-850f-b155-c407b671fdda@web.de>
Date: Sat, 3 Jun 2023 13:20:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-GB
To: Steven Rostedt <rostedt@goodmis.org>, linux-trace-devel@vger.kernel.org
References: <20230603054450.1e83841a@rorschach.local.home>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
In-Reply-To: <20230603054450.1e83841a@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i4Ssv694UgmprswPqEx228tZiHJ6IEWptSMJ0d57NrAIKXRofCv
 YxDY3Qr5JBghf4fHi94g1y4GtBjgL226r97DMV+p4xdtOn6JCJ1oMs5cxPzuTHrK54RUy8o
 maq4Q2KJporM1D+pZCOYHRip10mAMGMAxuOxb491RsKb4cW/46KTJOW+oeRr3p5OZoqjfbm
 S70ezt27lZWGmjZL3znWA==
UI-OutboundReport: notjunk:1;M01:P0:cBuLfiZ78J4=;h8OYxdQeas68P6Dra2t+PBN8j5v
 rDphfrMTyvnWjBSh4xvzram8ATqDWWdJZfQb5cRfuXSDnJ0CKY7EzWMa+NgKuGawv7fymPiBy
 H2Ok0rCVksbzEs5V1GW0MBa2USDbYf70V+yGU/mVZ1IAza4SxzpqU2ilu+ZOfpZOpTiASIdhG
 swPbhhY9gWYwLxdkLM9WUNYF7EtpA79sy0UvRxshqF/yelVN4R74lvjpqpj9dXhZLNRGNIj99
 vRHtpsaFwDvKSu2GguRW2aKxIqPzjD9MBANAfGpUUwzVRWagUB/ax80YHTWlChOMBHt98KKZR
 dgTaeEFjnwfJC16qomttzruZCExu8i2GwVSOwLTOd6m1sRWxQ5/mx4JXfKp29qcTYGlLvhjbZ
 HVViUumk7j8GlH/wBy6AbYPwCVbL9+n2QA2/R7y1fWihC6YBCJ587/JtMYzdmatooUeLrZpYK
 Ta5+vi7weYeLzqXTGJhcs10wI2Yz2Jo37OTlHfdOfe1qoWY5miqIy8xalA551ivI5IKuNw7S2
 Er17ZrdiajM7+1x1VxTJWyIQb9eQV1h4by6UusUrJGFxNGhGVOm1Z161PVgLusxboPww9zyAi
 aj3jhHrrSoXOxj9oQfv6fRgrmtSyCLkW9AYJFRnWkfeeNYJqn0kto4E7Y7NW7FTyOrmhh9o1o
 MaV/txMB4EobQSwJdk8DDwn/dIxN6+cSbsYizFbdevJANUwvdv95UGzuatbqgLBj2R7PXuzpE
 tHVn4PQmYFCBPwL64cGWmT37vBKKujgM0r7TiNcUg0F4PzhnW6hCKIEtLoBMkjU4WGa9rzZbZ
 hNYngCzAPe8HcXVvl31pTuycokY2cUBTwusO6sL3efo/Oz+jDTl2po5QqA4/es66hY1TDOg3c
 FQBaNI1QIBqh3hPpjiEVU1OjS5U9CRXeE9g+N2st9Lh6fgATzLJWQr1qwNfiEpeYow69r0S4r
 DDba4Q==
Subject: Re: [cocci] [PATCH v3] trace-cmd: Check all strdup() return values
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1166
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/8b23bb42-0b20-850f-b155-c407b671fdda%40web.de>

=E2=80=A6
> to find all the locations that did not check the return value of strdup(=
).
> As the coccinelle script adds a FIXME to the text. Then I went through a=
nd
> updated each location to handle the action appropriately.
>
> Signed-off-by:
=E2=80=A6

Will it be relevant to refer to any previous bug report for the discussed
source code transformation?

Example:
Completion of error handling
https://bugzilla.kernel.org/show_bug.cgi?id=3D217126


=E2=80=A6
> +++ b/lib/trace-cmd/trace-msg.c
> @@ -1229,6 +1229,8 @@ static int get_trace_req_protos(char *buf, int len=
gth,
>  	while (i > 0 && j < (count - 1)) {
>  		i -=3D strlen(p) + 1;
>  		plist->names[j++] =3D strdup(p);
> +		if (plist->names[j++] =3D=3D NULL)
> +			goto error;
>  		p +=3D strlen(p) + 1;
>  	}

I suggest to reconsider the usage of the increment operator in such a stat=
ement combination.

Should the pointer from this strdup() call be assigned to another variable
before a corresponding null pointer check is performed?


=E2=80=A6
> +++ b/lib/trace-cmd/trace-output.c
> @@ -230,6 +230,7 @@ void tracecmd_set_out_clock(struct tracecmd_output *=
handle, const char *clock)
>  	if (handle && clock) {
>  		free(handle->trace_clock);
>  		handle->trace_clock =3D strdup(clock);
> +		/* TODO: report error if failed to allocate */
>  	}
>  }

How will this place be improved?


=E2=80=A6
> +++ b/tracecmd/trace-split.c
> @@ -367,6 +367,8 @@ static double parse_file(struct tracecmd_input *hand=
le,
>  	int fd;
>
>  	output =3D strdup(output_file);
> +	if (output =3D=3D NULL)
> +		die("Failed to allocate output_file");
>  	dir =3D dirname(output);
>  	base =3D basename(output);

Would an error message like =E2=80=9CString duplication failed for output_=
file=E2=80=9D be nicer?

Regards,
Markus
