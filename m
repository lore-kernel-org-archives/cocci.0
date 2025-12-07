Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3635BD2CE17
	for <cocci@archiver.kernel.org>; Sun,  7 Dec 2025 10:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4gD/cPxJawkRTLJlhid191pNYmpszrn9Yby3NaiS7go=;
  b=EK+a0l0lsKg+PAoHBMvI4PgtJb0T0LXTBloJ/stYdkENI9Jef7gd1+VZ
   czwrTul4ajoCUzUlcI73FEESOM09yjchK9ir2NmscuF2hQcczCi9YpWYh
   UGGgO4r0TkI+UMTG//iQxB1FwoQM8YXz+RHcdvNxMqK27jpsPqA2RPQYV
   A=;
X-CSE-ConnectionGUID: t/Iqduh2RiqDwpC1RNeDHw==
X-CSE-MsgGUID: pSbkttn2QhiYUTRf9DW5YA==
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
X-IronPort-AV: E=Sophos;i="6.20,256,1758578400"; 
   d="scan'208";a="253166394"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Dec 2025 11:23:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B88B6E0137; Sun,  7 Dec 2025 11:23:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 15296E00A5
	for <cocci@sympa.inria.fr>; Sun,  7 Dec 2025 11:23:25 +0100 (CET)
X-CSE-ConnectionGUID: NtadbPs4Qb2XPuPuSk/L0A==
X-CSE-MsgGUID: LCG4k5pWRrWv3ncmPUtysA==
IronPort-SDR: 6935559c_puAYm2EcD9PgASMPoGiO3JX148Aw3BpcQqnRzYWkIX8EuUf
 zKEmFvcOHryLlPKS5jyn0UUhUh+RysHT6kl3XkQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FCBQD1VDVpgwsR49RaHgEBCxIMQIFFC4JAZyVZMwQLS?=
 =?us-ascii?q?YRVj1OCJIQ7hzyHVYpOgX0CDwEDAQ1OAQIEAQEDBIFMgzQCjGcCHgcBBDIHD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBOgcOO4ZPD?=
 =?us-ascii?q?YJbgSyBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMEGQEBESYBBAsLGgImAgJWB?=
 =?us-ascii?q?hUBAYJ+giMBBhABAw8nB7FqfzOBAYIMAQEG2mEfLCJZgWQJgR0uhW6CZQGKZ?=
 =?us-ascii?q?icPgVVEgTwLgkcxPogegmmCJoEOmUZSeBwDWSwBVRMXCwcFgSBDA4ELI0sFL?=
 =?us-ascii?q?R2BIyEdFxNgPRdAg0kYBmgPBoERGUkCAgIFAkA6gWYGHAYcEgIDAQICOlUMg?=
 =?us-ascii?q?XcCAgSCFX6CCg+HQoEIBS57MQIBC209NwkLGwY9lH5OhBuCOaRNjGKUYzQHg?=
 =?us-ascii?q?jiBZ4FkDJ9sBhMvg3GTYQ4GkwWZBqM8hgSBbw4lgVwzGiSDNk8DGQ+OIRmEG?=
 =?us-ascii?q?sIhQjU8AgcLAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 chXIoI=
IronPort-Data: A9a23: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
 QwhtFcfNBg=
IronPort-HdrOrdr: A9a23:T0BYuqm47Nz5vgB4Q18WieN25MXpDfL43DAbv31ZSRFFG/FwWf
 re+MjzpiWE7Qr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK7/oSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AYj3wrGpxwRAgbEnB3TjdaHjmUeY5e3HX9GyMGkX?=
 =?us-ascii?q?iOV50cKCuShi0oIoxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AARezfg1A2WJvLhmQqt7Qzlwc/zUjx4+BVENQiao?=
 =?us-ascii?q?8ofaabip7Pg+gkCWsa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,256,1758578400"; 
   d="scan'208";a="253166390"
X-MGA-submission: =?us-ascii?q?MDFazty3IVGRZP6rCDILRW7r8vtjP/O6/5x0kP?=
 =?us-ascii?q?J7GTA0nNLoQDXlzGUyD7IkZa5sKo4Ia6c3cqaa/r9kdYBFXnyXqugKdw?=
 =?us-ascii?q?2BQOImarlmH4qRsdfrBdz6ptJqq7Iu2qk4n98N2S7vjJdSpYNlMaitRE?=
 =?us-ascii?q?A2MPyL4uBr3U3HIBSXx5i+kA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 11:23:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765103002; x=1765707802; i=markus.elfring@web.de;
	bh=4gD/cPxJawkRTLJlhid191pNYmpszrn9Yby3NaiS7go=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Z3mMr50avhTcFqUfpBFQOXXtMD0LMfGFyZoxIf63ZfdBtTxNwT9gTQLNsbxwU5Ya
	 ZHBmQEr5/GYcLQfG7Nwj5XlILeEyK7yiObc52Cv25Q6NUnSkBhiZ+OPal5xMkPcTz
	 g+ecxnmMiSBwrZ68zo6nevqF0y1kGwnP5WTQIJT/j5M4BT2pcRdulIOPvZZhhcFOJ
	 T9k6ugdl/LcsPdEgkQ6ORdVuSTLOvxQ3WUDNGS8tkHJzO5wRgMdUIMk+SKhYDRLz7
	 9zJhqfamRmVMdWfx+2jRSYiAL2pT0poNGbAm9eg9XEAeUaqhaK3EryhQLLbK6hzos
	 9cYA1MFC6PB+QpIUPA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.183]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MT7WH-1vcKxS3z6V-00Vy3W; Sun, 07
 Dec 2025 11:23:21 +0100
Message-ID: <60d18d38-7cce-4525-ab88-480b66719034@web.de>
Date: Sun, 7 Dec 2025 11:23:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <agruenba@redhat.com>
References: <CAHc6FU46Pusn-rq2TeCV+nBOiW5YUEGOuVRLQHOatniVJaT8pg@mail.gmail.com>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAHc6FU46Pusn-rq2TeCV+nBOiW5YUEGOuVRLQHOatniVJaT8pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BoY9SJxKyje4LG8TqaTawRj8xjFo3kIQoawiJQGyPe1+Dnoz0MY
 hbhKdTkbVRhGWqx6OWNctu/sqe+tU6eCNPiaZZvQwpqtP3dp8q8VtlmPXFLUw1Q8Ayy7orv
 VMtNprL37M8CR5AVhSkV/g9igM1N5qPiCb/ixs+oFFqmLyilDtBSZLhVRjHbN7VCSa14hTh
 4BhLz5qG5AqpXbo0tNbyQ==
UI-OutboundReport: notjunk:1;M01:P0:gI/3j9PkTt0=;4Tze14rPbUOanRpHIppuuzz8Xgi
 TD6KD8QrR9SEl+3fSSoUx8TeczFdA0xvKeBkJbBQTEEFoRjVI2gYCSQwW7Zzmw18CB0DzyPjH
 wrGjsPr6xDO8a4lw6gn2noq/kWArIvYdtkx+WApj6PrSGnbCs/yjTSGBvNxURCGvB90256/vv
 jAnVVvT6K//2Rm5jAgr0Lq0YgTPF42RAuGJIgceFMaHK/3duNE6bMin6cCjBU4uiWvC9r3ZsP
 wHSUBJj+I9HBU6lvBEOkjLdrKaAUlck+emevaQ5WQtgEwfjN0+KbZQRJt1LYFZbD9AH80xqsY
 VofuRLiJCa2YHa58oDTIbfj1PpIjEUmRmMCCrVHmo9ZGv+1gOV8EuwAF54eQrgU+fzzmswSoy
 0Hadf9cPUTiT9tSBCSa7Fld0otnW0c76ycjVhZZomS/ZbzH75jq8NV1uK/O7Abvvf6G4zTd+c
 PQCzxYuQNr6gk3bHMZaFrbxI6moYI60iHoIhe+KzxTiFIq/pmiLAEAf7CQ0DCFwRnPKjP65aH
 Hw2llny+6euKZOSXn1wLcRR3VVr4gIMy7S3nMkLq/sohhPqNF74AOjG57/Qs7f/RK/CKTEE79
 PmHMFSFfhDdD4ky2v9umdi3y6eWJhgVmffb1b3tMubAPjpyuvPIBO+QbnNToUwKILBh8yDZe8
 3Mr/upB9aOO+p1jzKacX0hiUy87pop5nL6+PPL6pl4IWaK0V4+gcN2JYn00DWSGopUBq5a7pr
 UJH0MvQP5PttkkeC31yGZtGuN92H+VutW75ObMhZ7QRVYHssW54MD2WVoM2fq54FWhs5eSQ4e
 LofJpSzM1orBsHCtIUsnUZa4KXwCxDSi4uQcfuAH8cMKk7eFGPpSfdU2ZpK3KfHVdZbd7zI34
 2Rme+Ss/FT8OANMNp9TSLkZp7jMAuwJV2Nv1n1f212e37lv1pMxWswmvZWhM2givGw8ozohXN
 xgoiUOVApTEhEIX/1RJvwTEGJ2g86l6nGR6oY4WxXOX608k7f+WxtaikxZKa8+j++ntKqVSaR
 sb1aFTSIi8NW9GYq3a4wlEHmp/2CaDFD3m5ddpIIsLHBhDT12olE0giSZHfDPDHHpfUY+geX9
 8nRje9CBV5qMC15GYrn5jduDPu7OVh1/ih+L3Ckv4xT1DPeP7eGOhexm31/pbejFr9PVuZb7c
 GcaAx6JyMtcH98YE93omCnPTqOC832Jb6d5M23qgqwd60F1UkK2XFA2E0MAoNeiwSOUzBlQ1M
 8Rn9wgWNLGkk+Ov0ytNFMFA2LtSYINNT9mtxIYV/YLHMtRUN8VT6RKkZ1JfjORaIgsxEnwEA9
 FX0u2x3J5S+5uiBVlzzJkERbmHNPRhhDsSjLEpKVB0/4xADxLws+xGnw/f8xR99kX/0iKPh2P
 dxyEWos+OVn1wzh2L4D461g+2mYdRYZMsIA+U+Vffe4KVjayyGlnBbgdGMBz1+74f2Qh8AeOp
 jYXWgl337y3cMyb77ngtt4MqSl2BLUK/PVJHTeLP45DpQ4NK612VW7nyQZEaZl/rLrwf5gOXt
 l/VVBbLFz8NA8JUBUAaySud28s1aMlLy7QuvRjvUJyNgYRlr7ZbfPjpCNvvup7NWQJTYInqby
 Qlk38YuQUWde7RaesXoOJ2AiYhT6xw7fOYfxauxqG26kyM/i2iJKnIYhbhhdqtTgra9rCsbDf
 nlL1XMIo+7vhf/7sojc0oXnrlZH3hbFuIfImZER8VZ4vOjbo++kWGZkueFLxnkln+ZOkhBA2V
 O1YXgW5eK/kbT93/lE0nyf8NEYw8Hvr8Q9oof2SxPvpUCrBdOqyLdPKp8ArG4l3ZFdLEGY0Dy
 6Lq5F+uFjhviX12Aodf57LKLrgVpngkS/54octDNiqKDATbn6eqybMmt5W03XQAXZ4kx6sJvh
 GJ0rhxHpnAp99k0ihORwt86/lfwMLgBRnRu/92td/6bJkWRGsrUbFVAhCepgC3lkYZ62dvTef
 AXDZ5r4n6BoWQNNFL1twVLIMqLQwkPqlRBtWI34ik/hc8mbF+z6uytpYmZrnmf1tZofQtjHFQ
 Px12s0g288MPs0UHbrlKkC10kmkigI4cPKrmofohoCny1aVh+7B1AnU3zUd6wABgutx8BS/dF
 15X/X+GiFsEFnr9njt1AmJg2QnuG/2g/PO3DwxjJBUDs+Xutb3zf0m86McUdy57HWVZc+E+4e
 In/BJA/9yZO5DLN0NtT5Js2j+GoGaH0tnQPcB1boIEubtLMjdfbZupLEy9AdTpba6od1Jkw4q
 UZIiMNjgN2oslUNlOCqt5KQRv8oE2/obhGKLCtY6hc0GgTfC1nRSMnxoFptuO424gEdYRAsxq
 XkhpRNAxttWlE/340ZUpTbYMTxKgXcftdUcG392koPoiuYrneXLVy5FXy5gKYboe8wLAE0iv7
 S+Wk5mx5DHUoe1WBXC/bM0KZW7g69/rVFhVQo1g2gdqrBmtrnFkrybUy0wY9YbPHgPY5aayiR
 4ekEpu3u1TIyQEeQO9WlwJ+ECfzV6kd6mPaOLaHU64gzH80OXnE1Z36dRTPqkcQgNJfvRqNsp
 rcDdPjjROihsSfUc2/DJw3VU0mK5MX6M1VRjaOORHKc9dv18eQZaqoWkdBaMUTVJigDEvdNcI
 +UUVUZNaMbbVy7TznVYx09O0T9FzzpNmJvzlw+FdwqbfFJutKlK990gIh2nrXqo0FkarbKK8w
 leiMuHxbBYVqKOOgXATrDybC3NE9dZEf7t5egJYuUTfvLEEwe/48aQ1c9R33zq1mcQ8o2Vd/i
 JFPWNrjnJJMU8aGQHrGojVOHu68iiIp40dLN0PH3F1q3KamT8rsuQwLT67iRAqO0d0WtM5PAi
 vfUigMxCrLxul0G2MT59kMCaXUhpst0gryCARmKi6N2bAuBASaeZkqU1D+iC2RmWZook1qJA4
 exml+1f7B9eYCFb/US1O4GrQaIESxiQP324xiRKJkU9WuEAubyhmJdfIFPEXjtrXp+Lj83N1x
 5Vy7aC0UwgBPQFcwCem/BDnDNvo1rNJKxdTx0Xvo7Nwt5PV7ES730FwuNiWDM7CW8qnqUF1OP
 WwfKFY17SG7aqr4WbLRO8fEqF+qNeepmdPBZPcOsObzm9Sw6U2dEUbkPXN3aGfvmrLx2GV84y
 BUPAD9t42tgUh6EzI2AHYAeWf4GzUuMeFoW36vRbHvoZY7a3aXT3js6KXqsSx/4GAV5pEFB5p
 7qIi/4vekJOvtFbAEqDG2YaMIl8Ejy/8FIYxkEFAOwHZLj8dDXP97YGjiYSpY83xA7XsZ4Gi5
 VGlPAquo4tDslsotPb/Ref08C9Vy7dqo2sq4tnyIgIK41OwxPxf9jW+pz1Y7kkkP2+Odwf5IY
 o/ApChDBoRLTCZZIA3wDfX87NJBFFoAtApdCkn3lKI87vI1Ye+eAPer9zKFA9lkaQgMLKw48F
 utUVgB9tgPmII74Nm9Ta+C2Pby2eIwlnfzM0qGp3WHHaTRBijSt6XAuR0ZI9569Q3GL0jAKyD
 z/+LN0C+ZbnY0a+UIYot50CpS3BnOaLVsMY9jMQnzuxwvXTFFimiD9QB329vi50aEClSKFpYP
 cPhdl5OpsK6LFHY64c2fWmUbfLVzzvI4rEOAb8ui4fTpHcOt8FrOR8vwv1aluRBivaGc1Zsaa
 N3Z+plcsy0OwFlMQUlpz7xtCGvcqIA1mhq+Mwgp/Q8kKC/Ck75XHp3uSY+2C+FW5fe2uY6VWE
 UbLsbk0xqlHtGAoQrEVHrA+WT5QfxppnPkQ/fnR5hqDqElbqukDrAHC47eQ/l+K2V5NNCgMY8
 x99e30spJRrwW7vh/aSAVQq4V3dQjlNPVZCjP98L7Jj5XyGmIUQbfBd4tqnuSkF+t0GOLD2h+
 ARjtiHxKpIZWxDMoAY7BIZqTv4SBRN7+NtLGuwBfrdL5ju2HMwqgjwR1D9ZY2x7ozdLWUQOY2
 PAcVJRLJUH/phrwzQfnmLyF1Y35zQ43cL7wD6GDXYK4UJdDI+GC5AmWK3TjBBuU56vlv7VzZe
 D667PKIpHigNeFtkyZ4/fNASyQCUDTbfNnb//mQ1HkwDFidviC6mIgrFcAS3iL+uI9D089DWl
 XxI3jz9LtQtG+LCPkxVIOvp6Rl0NlRu6HHDw0m4k2CoTgw5ADSO12DarDHtKFmKG4g0mH83K1
 DBfFAK3cTYUYIqXLtpU88bE53oXSnFD57VgciI8lcQgClYlASwIWaEg3EmQkHKMfA86sylbkd
 rvd0QBSnvZ0IZhCFw0GvwxMluBB7jE2MkgNGstl6DzPughKigdzn5zcmfHf4inHtdtxJR9xJd
 YUICLlZWoMqX2vv9fXfWzY+X9A0CdONY5vw3ggypQ8UvtjJXAjr5YK1IY5RCa9ZqwEQuFTplP
 qFYOZo4hlouaWP8KWsAhE1pMbIyZ41m76W07Hv9+0LwQuECNlqVw1FuaTP3fXNpCSxVyKJg1w
 7dP3I8ETG8ZRB9gMFNZB0zClV0Lx4oekERyR45Peh4QX5ZToQbdkabHVpgKdj1oR9diGE5OXu
 eSrG6wgn9syUU/KzNavBXG6AniaaEUr3CRYGQ4wKGVsUrnQFmUyhD6G3mTPRoVt0elr/FkUNr
 rSu5Z+f7sYs2VF+BKN0V6IlBwBHIMBQjl2ybMfIhgfuSlkNvMsmydOSPjHeRoAD7BDZ1u6FHF
 23ITyRk/BSzy7sy4HG9ZMpL4cYuQN6ZjXUmLvNl2BAJy0YA8h1raO1JG4pocUH6xaz6M26Vbz
 6heWI+t/gLvbBDrAqoV+SbMWAQjKybeWyq11JXPGqaF+7aewISSAMoIuEd9dIhk5vML7C/x5l
 zNuBh8Ilg5DCdrJGr1y3abY3bIu9C7mmODOwGaMTOdUz1xhwqnVcFKu0pFMPfIaAQF66vNnFU
 FLnaxKMWVUuNGlxzSzDafg4yI0hA25nOPYhLQtC4hIbJz1fEkAIKN5uFJAHEs+CvROY+4OPCN
 zfYBchRk59s57Lyvd2XsGPJCaCMpziXsrXXmf4S7jyhflAtcyKoXNxX98KDCTCEfDvWSgnwlu
 hAq1QeXj2EAp9doYzblwJuH/8LeEKB1AeERGB5QD1R5sXqd2TdgI0PxVLk4enaQwJ9qI40lfr
 XjBZpJraJ/UYYshPjizblyKJnd4DoX0KbohF9BcLOKOKsgWXxf/eX6rTlrNEDYq6gQkmbhvr2
 FvK2v8d27cfGCiJvySdgu70v3tV+5ppkuAjF00
Subject: Re: [cocci] Matching objects as well as pointers to objects?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3246
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/60d18d38-7cce-4525-ab88-480b66719034%40web.de>

> Both cases are equivalent at the C code level.

I suggest to reconsider this view.
Different access operators are involved.


> Can Coccinelle recognize this kind of equivalence

Which kind of pattern recognition would you find more convenient here?


> and is there a way to match both cases with a single patch?

The SmPL code can be refined.


@replacement@
expression bio, errno;
@@
(
-bio.bi_status = errno_to_blk_status(errno);
-bio_endio
+bio_endio_errno
          (&bio
+          , errno
          );
|
-bio->bi_status = errno_to_blk_status(errno);
-bio_endio
+bio_endio_errno
          (bio
+          , errno
          );
)


Regards,
Markus
