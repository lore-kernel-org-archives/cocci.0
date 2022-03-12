Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49832C433EF
	for <cocci@archiver.kernel.org>; Sat, 12 Mar 2022 07:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=dj5BDs6vjrongpy7CixhHw8tUKXyoIJHCTlh+6e0V08=;
  b=M2RX17j5QVaAaafC7S4Dd3qZT5YxBCCGoBF5yeR+gXMXGEM1f8nSZ48b
   GsyL+RyuppTxOUxnKQC3vfqGC95HYJLFAEssFkr3uZUFgm7Yh1p327mqM
   yPgitbkcrOvthm2emb52kHvBb6ROoXmt3Itx0RRYmeu5MNsrNwFr8CK5R
   Y=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.90,175,1643670000"; 
   d="scan'208";a="25766571"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Mar 2022 08:00:32 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D9B4CE02A3; Sat, 12 Mar 2022 08:00:31 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 091F1E0045
	for <cocci@sympa.inria.fr>; Sat, 12 Mar 2022 08:00:27 +0100 (CET)
IronPort-SDR: hyf9FYO0y5bZv1Bh6pMopgYwr3whc1g1So7Yustz3FyEo51zfE1+yL7cMoW+9wjrhdz1d+OXoO
 JKqXzbdJDI3h/jdtzyAuxHUxk3GzHwyRfbHDlRBbjQ9PVWAwU69kTPNM1W6wkLfc2EPgeWJK2g
 EnoA+xt9mHeaRGBuVaK/1qchly28w7QkIciwHQFv91VU4uhpZfj51fBsSbHnff7ji2T0AOO42R
 bAg7nvOgSCkG6i8wFUa1an0Yrj54v6weSnBhq4y8WVis7Ta7SOTWRRDRl1VldDD0BVYZ/YrX5o
 jzx+SeNHMG5ztdZr/M3ladDd
X-IPAS-Result: =?us-ascii?q?A0DuAQDnQyxihwQP49RaHgEBCxIMQIQCaRVXKwQLRIRUj?=
 =?us-ascii?q?nOBdy4DnHOBaAsBAwENOQUBAgQBAYISgjBFAoQkAh0HAQQ0EwECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEDAQEFAQEBAgEBAgMEARMBAQEMDQkFCAoHDhAFNgZeBmQEgUsEg?=
 =?us-ascii?q?XQLNA2CNSkBg2QBAgIBIx0BAREmAQQLCxoCERUCAlcGAQwIAQGDAAGCZAEDD?=
 =?us-ascii?q?SULrkKBMYEBgggBAQaBPwETQYI0HywiUoFbAwaBECyKN4QRJxCBVUSBPAyCd?=
 =?us-ascii?q?z6CYwEBAQGBF0c/gluCZZgKVwIiDVaBOMAqNAeCEoE6gUALiT+UTAYULpY6D?=
 =?us-ascii?q?gaRaZZXIIxzlE+FGIF4gX4zGiSDOE4BAgECDQECAgMBAgECCQEBAo4dGYNZM?=
 =?us-ascii?q?4ELgRuIBkA0AgktAgYBCgEBAwmFRwEBjRwBAQ?=
IronPort-PHdr: A9a23:YjoFQBCCpE3ef9h90VEKUyQU5EkY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua83ygaTBs6LsLptsKn/i+jYQ2sO4JKM4jgpUadncFs7s/gQhBEqG8WfCEf2f7bAZi0+G
 9leBhc+pynoeUdaF9zjaFLMv3a88SAdGgnlNQpyO+/5BpPeg9642uys5ZHfeRhEiCSzbL99L
 xi7oxjau9ULj4dlNqs/0AbCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3T
 bpDDDQ7KG81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUjm58
 axlVAHnhzsGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7WYNEUSndbXstJVCJPDIyzY
 IUSAeQfM+ZWr4vyqEcBoxalGQmsHfnixiNUinL436A31fkqHwHc3AwnGtIDqHPao8/vNKcRT
 OC117TDwzrHb/NYwzf96Y7Ich88qvyLWrx/a9DRyUoyFwPelFmepojlPz2P1uQMtWib4PFtV
 OyxhGE8sQ1+vyagy94qh4LUiY0b1krK+j9lwIYpO9K4Ukh7bMaqHpdOtyyXKZd7TM0mTmx2u
 Ss3yKEKtYK1ciULyJopyRHRZfyHfoWI7B/vSPucLzhliXxqfL+zmxa//Ey8x+HhUMS/zVhEr
 i1AktbWt3AN0QTe6smBSvtn/0euwyyD1w7J6u1cLkA0lLbbK548wrErjJYcrUPDHirulEXsk
 qCWeVgk+uyy5OT9e7npuJCdN5duig7gKaQugc2/AeM+MggVRWSb+OK81LPk/UD/Xb5EjeU2n
 7HHvJzHO8gXvLC1DxFX34o59hqyDy2q3dsAkXUZNl5JZh2KgofzN13TL/31DO2zj0qsnTprw
 f3NI6fvDY/XLnfZlbfsZbZ95FBYyAo01d1f4pVUCqwdIP7pVE7+qsfXAgUkPAOq2+rnCdN92
 Z0CWW+XHKOVLb3evUWW6u4xIeSAfpIZtTbnJ/Uq//LuiGU2mV4Zfamnx5sXb3W4E+xhLUqDe
 3rsgcoBEXwQsgQxSOzqhkeCUT9VZ3a9RK896C80B5m8AYjeWI+hmLqB0zyjEZ1Mem9GEkyME
 Wvvd4icRfsAcDiSLdN5kjwYSbihTJcs1RW0uw700bVnKu7U9zYZtJLi0dh6/PfTmgso+Tx1C
 cSdyWCNQHtukmMGXT86xLp/rlBlylefzah4hORVGsBU5/xVTgg6NIXRz/d6CtD3QgLOZM2FS
 FegQtW8ADE+VMg9w9EUYxU1J9L3qBHI2C6jGPctnriKFNRg9KPX2Hz4PIBlwnLHxIE8iVg4B
 8RVOGuhjKpysgHXH4PS1UuDweLifqMX1y/l9WGZzGPIslsLfhR3VPDgVGoce1CegND3/ELEQ
 Pf6LL09MRZaj+OGJLFLbNLBklhMAvvuboeNK1mtknu9UE7bjoiHa5DnLiBEhH214CkslgkS+
 S3DLg0iHmK6pHqYCjVyFFXpakeq8O9kqXr9QFVnhxqSYRhH0Ly4sgUQmeTaU+kai5cNoiQ8s
 HNZGFin3tTZI8WNrUxtcfYUessztW9OznmRrAlhJtqlJqFmiEQZdlFStlntyg4xJ4FOi8kso
 1s1wQA0Ja/LmEhZeWa+2pb9cqbSNnG0/B2rbPvO3UrC1d+N5qoVwPE/tkmlowyjUEYvm5l++
 /9S1XbUppDDDQ5JFIn0Tl5y7B9i4bfTfig64YrQk3xqK6i99DHYiZovA6M+xxCscs06UuvMH
 RLuE8AcG8mlKfA701mvYBUeOelO9akyd8q4fvqC0aSvMa5uhjWjxWhA5Yl81AqL+U8eAqbt1
 owG3ure8w+JTTb6g3++v8qxlY0FLTAeE2yjyDT1UZZLb/46doIKBGGyZsyvk48n3di3ASEer
 QPlWwBjuofhYxeZYl3j0BcF0E0WpSfigi6k13lvlClvqKOD3SvIyuCkdRwdO2cNSnMx6DWka
 YWykd0eW1ClKgYzkx7wr2Pz3atGv+JSK2fJQEFHVzf7JSduX+Hj09jKK94K854uvShNBa6Za
 EqZV6W7jh8UySLlEENByTp9ezzg6fCb11RqzWmaKnh0tn/Qf8p9kAze6NLrTvlUxjMaRSN8h
 FE7H3CENsKytZWRnpbH6aWlUn65E4ZUaW/txJ+Bsy2y4StrBwe+lra9gI+vHQ8/2C79n95kM
 EeA5DP1eIr2zOKXNex9f09nLEDx4Yx2F8lyn5Axi5cZxXUBzs/Mpzxdyzi1aIgdher3dzIVS
 CQOwsLJ7QSAugUrNX+Py4/jFz2czsZne9imczYT0yM54dpNDfTc57hFkC1p51ug+FiIO74nx
 GhbkKZotC1/4alBogcmwySDD6pHGEBZOXepjBGU95Wlq70RYm+zcL+23U44nNa7DbjErBsPP
 RSxMpokAyJ06d1ydVzW13imoKTtYtrNdpQ+shOOkhHPp/dYItQ9m7BZ4EgvcXK4pnAjx+Mh2
 FZL1Iu5oZPBBmFj5qO/DTZHOzeza85ZqVSPxe5O282R2Y6oBJBoHD4GCYDpQfyfGzUXrf37N
 gyKHW50ujKBFLHYBwPa9FZ+oieFDcWwL3/Obip8r50qVFyHKUdYmgxRQDgqgstzCFWx3MK4O
 EZhumJLvwS+8EETjLsyaV+mCDeY/lrNCH98SYDDfkAPtEcYvRiTaJHYtqUpQmlZ5sHz9lXXb
 DbBOEIRUidRHRbbT1H7Yuv0vIaGrLLeX7vkaaGSMfLU+Ik8H7+J3c79gtEgpmjRcJzSbz86S
 KdlkktbASIjQpufxG9JEXRI0XqKNZHTpQ/gqHcu8YbgqrKyCVipu9fIUeU3U50n+gjq0/fZc
 bfO2WAjc2cej8hUjX7QlOpPhhhL1XwoLWL1V+5a/WvESKaa8kNOJzgcbS47dM5B7qZnmxJIJ
 daekdTtkLhxkv8yDV5BE13ngMCgI8IQcSm7MxvcCUCHOa7jR3WDytzrYa66VbxbjflF/xy2t
 zGBFkb/PzOF3zD3XhGrOOtIgWmVJhtb8I26dx9sDyDkQreEIlWjN8RriDQt3bAurnbNKHJaL
 jV2NU9A7/WR4S5envRjCjlB435ifozm026S6+jVLIpTsOM+WH0u0bgAvzJjlv0Jv0QmDLRvl
 SDfr8BjuQSjm+iLkX98VQZW7y1MnMSNtFljPqPQ8t9BX2zF9VQD9zb1aVxCqt17B9noo60Vx
 MLIkfe5DT5Y8M/Pu+YYCdLVLs2vL3crdxbkUm2xbkNNXXuwOGfTilYI2umV7WGQp4Mmp4LEn
 Z0TVvlEWVZzGv5QWSEHVJQSZZxwWD0ji7uSisUFsGG/oBfmT8JfppnbV/iWDJ0Hxx6GgLMCa
 xZamNsQzKwWMZDnnVNvYB92kdaSc6I1dc9AqGttY11syHg=
IronPort-Data: A9a23:jpbgr6gK0PVjGSLEaEST2XrvX161phcKZh0ujC45NGQN5FlHY01je
 htvWWiDM6yLamT0fdt0aonnpxtSuceBx99kHQJt+CoyRS5jpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKidUsxIbVcMpB0J0HqPoMZkxN8w6TSFK1nV4
 4mq+JSFYAbNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 NpljaaPexwwFK32hKc7TzNcHgdHbKcBweqSSZS/mZT7I0zudnzx37NxAUtwMYBwFuRfWzgUs
 6ZCd3ZUM1bf7w616OrTpu1Eo805L9Tweq4btGthyz7xEvssB5zOK0nPzY8DgGtu2Z4m8fD2S
 8caNGJES0j5bQBeFGtGVckMuOCHiSyqG9FfgBfMzUYt2EDXxRN41LzFItvQcMaDA8RThEeR4
 Gzcl0zyBRoRNfSE2D+d+zStgPXOlGX1Quov+KaQ8/l3nBuMy2ZVBBB+uUaHTeeRsnSBaclGA
 Uwu5mkIsYI2+WqSH9O6ZkjtyJKbhSI0V91VGuw8zQiCzKvI/gqUblQ5otNpbds7qIkpSDZs2
 lLhczLV6d5H4OH9pZehGlG882na1c89czZqWBLotCNcizUZnLzfeinnF445eIbs1oOdMWipn
 1ii8XZi751O059j//jqpTjv3mP3zrCUH15dzluMBAqNsFgmDLNJkqTztDA3G94bcN3GJrRA1
 VBY8/WjABcmVsjcynbSHL1TQNlEJZ+taVXhvLKmJLF5nxzFxpJpVdk4DOhWKBg7P8AaVyXuZ
 UOP6wpd6IUNbmSnZ+l7btvpWcgtyKHhE/XjV+zVN4YfPMIuKVXfpCw+N1SN223NkVQ3lf9tM
 5mscfGqUSQQB5NhwWfkXOway7IqmnszyDqLF5D2xhiqy5SEY3uRRetXOVeCdL5r866O5gnYq
 o4NO8yPwhRZcev/fiiOrd9Ndw9XdyBjCMmv+cJNd+OFLg53I00bCqfckeE7Zohov6VJjeOWr
 HuzbU9vzgatj3PwLwjXOGtob6niXMokoH82YX4sMFKv1yRxaIqj9v5GJZ4wYKVh6+Fpi/J5F
 qFXd8KFC/VJazLG5zVEMcij9tM/LkzziFLcJTehbRg+Y4VkGV7D9OjkSQ2zpiMAOSy66Jklq
 Lq62wKHGpcOG1Z4AMDNZK79xl+9pyFEyud1QleOPdRZPknhqdA4Jyv0h/4xAscNNRSammrEj
 VnLW09AqLmfuZIx/fnImbuA8dWjHdx+KUwGTWPV2rC7aHvB9W25zI4cC+uFcFgxjo8vFHlOu
 AmU8x39DBHDtFNNrpY6DLthi64zjzcqS3m20Sw8dEgnrXzyYl+jHpVC9dZCvOtBy9e1fCOoD
 1mX9IAy1aqhYavY/Z14GObhRvuO37cYl1E+KBjzzFrSvEdKwVZMbame09RgRsCQwHuZ/b7JG
 dschfM=
IronPort-HdrOrdr: A9a23:u5XI5K8kvAPA20ok6kRuk+D8I+orL9Y04lQ7vn2ZhyYlFfBw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNOftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njbLz9t+ri6GLvDv5ak856Bd3ARV0lYhT0JdzpymSBNLjV7OQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,175,1643670000"; 
   d="scan'208";a="8344676"
X-MGA-submission: =?us-ascii?q?MDH4oE1IPE+6r9dA/y1Lptzfucn+tcX1NZrUwG?=
 =?us-ascii?q?kgLeT3Kvjo5C+JL/eDWscaoDSOlNVm4TdvBZ/7/1yrznY9ZkyZSdPRiu?=
 =?us-ascii?q?BpkJ4Q8PW26wEZ5uxFnofu2FuvGXl7M9OuWdbd+sIvpUZjle1EXe1dXs?=
 =?us-ascii?q?r8O/kFihvvcIn8BpgSSa36jQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 08:00:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647068423;
	bh=dj5BDs6vjrongpy7CixhHw8tUKXyoIJHCTlh+6e0V08=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=sXTEFMLrL+QSV8Bu+BFfrX6XG09+KGqqZltjX5EMlvtp0ibTNDTGfTXFDj3uu3VW4
	 S8iAyG1vecjXgTw/6UTpIIbeUo/ed6Y4jFaajWxv8ANBtaCdzJV9JuP0AamwvlvKqR
	 G8ptLYhgop/sULaLpnonFl3HLBqcU7Po9eKOe2LU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.146.255]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3Gkg-1oBaFA47SU-010R3K; Sat, 12
 Mar 2022 08:00:23 +0100
Message-ID: <4f76ef4f-7d7e-ebfc-8732-8bba53d7ed5d@web.de>
Date: Sat, 12 Mar 2022 08:00:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>, cocci@inria.fr
References: <4fc9237-ca2-518a-3221-9770f6112c6@ewheeler.net>
 <alpine.DEB.2.22.394.2203090654100.4094@hadrien>
 <a32a6aea-bc17-2e56-947a-99325ab91265@ewheeler.net>
 <alpine.DEB.2.22.394.2203092218430.35182@hadrien>
 <ce6ae8a0-9976-4177-bce7-446d54bdc4f1@ewheeler.net>
 <trinity-819ef152-a230-487d-a730-fa70e5275ce3-1646903810019@3c-app-webde-bap20>
 <e683d80-5764-7550-d729-273e61b607c@ewheeler.net>
 <af50234b-f84c-72ed-df93-acc7bc41bb82@univ-grenoble-alpes.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Eric Wheeler <cocci@lists.ewheeler.net>,
 Julia Lawall <julia.lawall@inria.fr>
In-Reply-To: <af50234b-f84c-72ed-df93-acc7bc41bb82@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kIv8sDSHG2FXHYL+Ne1C4girn2xBIi0z1uUp4VBqq5PicgH0TVv
 QIHlGur/ieqGpLqp65n0G7dgbI+hHREQwuxOFRBbZ6i2abPBGpUgOChnJtV2TapylxQ5fhx
 QVKDbMfwnqr6SHbnALWcdUhoE3M4XHj5nep6Q1o/iIFNvLuUIs0YnoaMTNPW5Z6yB0u6J/l
 PGkxmZsBa8zv6E6Z+UXuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zHP5uUL7Y1g=:jKlPc6cuhvHaFuSHq/aUKy
 5YKGyqj1E0Ovb7gMLirLsYeXXTdTS+GeiR4DaMhOw1mfniheWBXTjDUSNt73xkuFHleIK0kcG
 RDl2FvxN+i95HJFysKRbZ3TeJUkhy4Zsugv4A3k1hte6Uz9/9cEhA0JUUfLboEExRiVk70Ses
 96tCYS8sIyjmCPyrRGU21OE+FFxlnEwKe/c29rgEDITlKq7XH7MbMsKU/nW9NWr+bG9KGQyw8
 fPtIooB0n89UiOfm3z+xJMrB10VdGTzNuE496KSR7L3Bk0jF4UZC2T92W48GGrOaj5R6qKQ4G
 JlGpahTQzeQFgz/k2qSaHiirSWf1WwWpLffbfow/EdFysZzh300tCCS0t+VPeN08S2fDi/RsK
 NBODTryA6/oSC9k+SK2NZaMMDHltGDQy8WiQuu/ms/kAEK8+wRVuEobyKmcxH4gP3bGLxryT0
 b7lE87b6tNGvF4ZzYDVnkHYuPKAv+B+Qjjb09UVkLp916XM9TmKoayePPthZFs47bsdy/TReI
 8saYAyLxRmLP5nJ4qGQkWa8lw3MenUDtN1lNb10rSw+6EtNvvvBLz/N7lV2xftw9BSyoDKyce
 c785iJ4I1C/1hojK5bLxVj5uTtiCIxA6V4ylV0cOLULdht12EElFItRB5pXq9O/8hNKE7MzVQ
 t9S3Ef59nLZ+/h6PMqBcnmHP2GDuIWxFL3duZvL3BtutAy+4vgz6xM+uSNezRABh99s6l2C6R
 S3K0rS6WvjS6xfw7KIP56RxG2ixXVDf9RYW+SUDv8sg7fgl3Zy95qLQfCBRyngN658qhYu40N
 tK+1p/0pp/WQLmtHxZql+lZMd+XlYRrFJ8NEdXwooYcQq7VRq9GAZzp4pd0jCyGwjs6BG+GfN
 MgSf647UiBOAZZ+b1yRgy16jSmeCwyZYTFjDyUMGS0gPug241UglA4p39xGHt5OkW59GQrF4P
 rJGD81WXzyEWNjuPT4zsxFWKKWN4kr57DcuzyU3Ta1oriS6OojQnDuvWJQRaJAEeFLpNNPkdA
 VnqUfy97W6dstPz3dUsIl2LrFi2IdT9WqwiyHCaly6HGaH1KSGKz5vMabSW/EAFh0/+HOeGUb
 kQCbzPQgLtNTpk=
Subject: Re: [cocci] Does SmPL support regex groups?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 206
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/4f76ef4f-7d7e-ebfc-8732-8bba53d7ed5d%40web.de>


> I like the C@1 notation to get the group,


I suggest to reconsider this specification approach further.



> but how would you say to concatenate it with a prefix/suffix either stat=
ic or variable
> (from another metavariable) ?


I would like to point other software design options out.

The syntax for the @ operator of the semantic patch language is described =
in the way
that it should be connected with variable identifiers.

https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5479fc964d209209e84dd=
d5caf3f395667721e7c/docs/manual/cocci_syntax.tex#L410

https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2=
e537f97ab62a/docs/manual/cocci_syntax.tex#L410


One of the supported metavariables has got the type =E2=80=9Cposition=E2=
=80=9D.
This metavariable kind has got the special property that it refers to
a concrete source code place (and not to a syntax element).

Thus I propose the addition of support for the metavariable type =E2=80=9C=
capture group=E2=80=9D.

See also:
2015-08-27: Feature request =E2=80=9CReuse of content from capturing group=
s in regular expressions=E2=80=9D
https://github.com/coccinelle/coccinelle/issues/46


I propose also to take the support for named capture groups into account.
https://www.regular-expressions.info/named.html

Thus I imagine that there is a need to enable the specification of an inde=
x
for special metavariable types.
The corresponding index can be specified as a number or an identifier.

I guess that path specifications can become relevant for references to cap=
tured contents
from nested groups.

Regards,
Markus

