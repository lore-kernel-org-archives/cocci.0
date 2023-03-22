Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83DFC6FD1F
	for <cocci@archiver.kernel.org>; Wed, 22 Mar 2023 14:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=j7CBFHhkThEj2vkZLTBrcS+gCBQgUDVjaqXmMJyUbrU=;
  b=tNKqcjV/T2NEyP4SXef8ZADvDLFZyexNfQryMAOqYFy0GMyH3XNpL6NC
   /n9gdXtQ5RlAA2//Gm2UU6e4KcphG6rjNxtXHzWkyZzAkfG6bIfER1iUU
   1gqWHStj95JFTbD49ocVaKptyYi/XZV9C36DL0MrtLaleGDJh/e95w4e2
   g=;
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
X-IronPort-AV: E=Sophos;i="5.98,282,1673910000"; 
   d="scan'208";a="98551121"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Mar 2023 15:45:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7BC4FE0D3E; Wed, 22 Mar 2023 15:45:28 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D4142E0131
	for <cocci@sympa.inria.fr>; Wed, 22 Mar 2023 15:45:27 +0100 (CET)
IronPort-SDR: 641b1486_+8vmQqfwq9Yv8SD2qoDxcq8GNZr9z5aOHVAl0EINhiNhvuE
 0UAJEHRuDaj2gN8C9hTR4zwSy88cKmxy/U+BTXw==
X-IPAS-Result: =?us-ascii?q?A0GpAwAuExtkhw4P49RaHgEBCxIMQIFEC4IudVYvBAtGh?=
 =?us-ascii?q?FOPCoF3LgOEL45mhGeEAoMWPg8BAwENNA0BAgQBAQMEgguCLkUChTYCHQcBB?=
 =?us-ascii?q?DMGDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBARoJFwcOE?=
 =?us-ascii?q?AUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICDToYOz0BA?=
 =?us-ascii?q?gIBIwQZAQERJgEECwkCGgImAgJXBgEMCAEBgnoBgicBAw4jBwyWLJwXfzOBA?=
 =?us-ascii?q?YIIAQEGnAofLCJTgV4DBoEULQGNBIM2eicPgVVEgRUnggKBAT6CSxcBAxiBH?=
 =?us-ascii?q?SmDWIJngimHV4N1gnqIKwqBNHaBIA6BPYEEAgkCEWuBEghrgX1BAg1lCw5xg?=
 =?us-ascii?q?UsCZE0zJQQOAxkrHUACAQs7Oj81BgMLIAZYawIJIxETBQMLFSpHBAg5Bhs0E?=
 =?us-ascii?q?QIIDxIPBiZEDkI3NBMGXAEpCw4RA0+BRwQvXoEBBgEmJJwZdFIoPyAmCYEuk?=
 =?us-ascii?q?yWSQJ4ONAeCKIFVgVkMigyVAAYTLpcIDgaSIy6HLZAPII0ymkiBeSSBXDMaJ?=
 =?us-ascii?q?IM2TwMZD44gGR6DboRhiigBPUA0AgEIMAIHAQoBAQMJhUYBAYMiglkBAQ?=
IronPort-PHdr: A9a23:f2tDPxVr9baS4JH++cgi6WBYU6vV8Kw/XDF92vMcY1JmTK2v8tzYM
 VDF4r011RmVB9idsa4ewLSJ+4nbGkU+or+5+EgYd5JNUxJXwe43pCcHRPC/NEvgMfTxZDY7F
 skRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCS9bL9oM
 hm7ohvdusYXjIZgN6081gbHrnxUdutZwm9lOUidlAvm6Meq+55j/SVQu/Y/+MNFTK73Yac2Q
 6FGATo/K2w669HluhfFTQuU+3sTSX4WnQZSAwjE9x71QJH8uTbnu+Vn2SmaOcr2Ta0oWTmn8
 qxmRgPkhDsBOjUk62zclNB+g7xHrxKgvxx/wpDbYIeJNPplY6jRecoWSXddUspNUiBMBJ63Y
 YkSAOobJetWrIfzqFQAohWjGwehGu3vxD9KiXDq0qM3yPghERjc0QA8A94DvnbZodPoP6kSS
 +C1y6zIwC3EYfxMwzf965XIcgs8qv+DWbJwf9DRyUgpFwPKk16drovrMCmP1uQOrmib9PBsW
 +2ri24psQFxoz6vxsg3h4jHmI0a0UrI+jhnz4ssI9CzVUF0b8K+HpRKqyGaK5V5QtkkQ2xwt
 is3xL0ItIKncSUW1Jgq2RzSZfybfoWK/h/tWuKcLDV3iX9hZb6ygxW//0akx+D/V8S51FhEo
 yVHn9TMt30D1xre4dWJRPt6+0euwzeP1wbL5+FHP080j6zbJIAlwrIqkZoTq0vDEynrk0v1l
 K+bblso9vW25+j9fLnquJ2RO5Vphgz+KKgih8OyDfw8PwUBRWSW9/mw2Kfg8EHkWrlHjfM7n
 6/Eu57AP8sbvLS2AwpN34Yj9Rm/CzCm3cwdnXkAMVJFZAiLjob3NF7VOvz3EOmwj0ytkDdt2
 f/GIqXsDovQInTdirvtY6hx5kxGxAYuzd1T/Y9YB74ZLPL2QEDxtdjYDhEjMwyzxubqENJz2
 ZkEWWKMH6+ZK7nev1CM5uIhOemMZYkVuDnmJvkr+fHhlmU1lkIDcqWx25sYc2i3Hu56LEWBf
 XrsntABHH8XsgYmVuzllEWCUSJPZ3a1R68z+jY7B566AofCXY2tm7yA3CKjHpJMfGxGC1aME
 W3pd4qeQfsMZjiScYddlWkuWL6jQoog01mBvQ71zbN9IqKA8CAet5vm1d4z6OTSmhc77zBcB
 MOZ12iHSHt92GgPQmlylKNyu0pwzhKB2K55n/tCDvRN6P5TFAQ3L5jRy6p9Ed+2EgbAeMqZD
 VOrTtSvKS8+Q8h3wNIUZUt5XdK4gVSL2yusHq9QjbuAB5c087r023nqO907ynDIzqAtglAqB
 MxVOinur6Jl9gHVT7TAj0SE3/Kjeb4d1SiL7m6fzHemt0ZcVAd6Vr/MG3sYYx2S5fnr61rfT
 rKqQZsuKABAwIbWJ7lHc8DogFFuWv7lN8nXeW6wknytH1CDwbbKZZC8Py091SPGQHYJiQMO/
 HLOYQggCz2ivmPaSTdvDlnoS1P3reB6rDW9ShlwhySDcldmn5G84AAcgfybA9gT07INsm91r
 j50EVa01frVBsCGqg4ne79TN5d12FdG0WPBr0RPN5atK+g2nhgMeg56u2v22hN4F5lals4rv
 DUmwVwhB7if1QZkfimbwIu4F7nZMGj081j7TqfM2UzFlvuS9L0O7vsQtFjp+g2kQBlxu0572
 sVYhiPPrq7BCxAfBNeoCh5fH3lSorjbZnJ4/IbIzTh3NrHytDbe2tUvDe9jyxC6ft4ZPrnXX
 BTqHZg8AM6jYPcvh0DvdggNacVb7q0pJIWLc/Wc2aikFPltlnSqgDcP+5hzh3qF7DE0UevUx
 9AAyvCc0BGAUmLZhU2ir9uxtIRKfzAUEUKgxCKiCIMCLrZqc9MtDmGja9ay2s04h5PpXCtA8
 0W/AlodxMKzUR+VckC7wgBak0gayZC+sQ2/yTE80zQgr67EmTfL3/ynbx0ffGhCWGhli17oZ
 4myldETGkayPUAvk1O+6ED2yrI+xuw3JnTPQUpOYyn9Ln1zGqq2uL2YZsdT6ZQu+SxJWeW4a
 FqeR/bzuRwfmy/kGmJfwng8eVTI8t3clgZ5lXnbAXJ9tnvfdulvyB2Z6NGdDf9d0zwaRTVp3
 CHNDwv0NN2o8NOI0pbb57rnDST7DMIVKHStlN/T0UnzrXdnChC+gf2pz9juEAxhlDT+y8EvT
 iLQ6hD1fojs0a2+d+NhZEhhQlHmuK8YUslzlJU9gJYI1D0UnJKQqDAimH3wLM4d9KbwdnsLS
 hYUztST7AWviygBZjqZgpn0UHmQ2J4rQtCgYX4NnA854dpLDqi887FO2yd46Andz0qZcb12m
 TETzuEr4XgRjrQSuQYj+S6aB6gbAUhSOSGEew2g19mlt+0XYW+udeP1z09ihZW6C6nEpAhAW
 XH/c5NkHClq78w5PkiemHH074jlfpHXY7dx/lWxmg3DkvMTBZY/jPsMigJ4NGi7sXBtx+Mgj
 BNo1I23p8Ddcj8rpvjmREcFcGSpL8oIsingl6Nfgtqb0+XNVt16FzMHUYGpBfOkHTQOtOj2Y
 gOHETkysHCeSvLUGQ6S7lsjrmqaScnxcSvNez9AkJM7GEr4RgQXmg0fUTQkk4RsEwmrwJeka
 0Jl/nUK4Ua+rBJQy+VuPh25U2HFpQ7uZC1nLfrXZBdQ8AxG4F/YdMKE6ecmVQRR5J68t0qgL
 mKBZgJHJX4EUAqIChqwW9vmrcmF6OWeCuekerHraK+NtPcYevOG35Op3aN58jzKOsjFbRwAR
 7Urn0FEW35+AcHQnT4CHjcWmyz6ZMmevB6g+ydzo5P34LHxVQno/4fKF6pKPIAl5UWtmanaf
 b315m4xOXNC25gL33ON1LUPwAtYlXR1bzf0WbUY6XyXFfiWwPUISUdBNWUqbpsPtf9ZvEEFO
 NaH2ImsjPgi1KFzUgoDDRu7x4mofZBYeTjncgmdWwDSa/LeYmeUi8DvPfHmEOIW078S7kzq/
 2zHQwi5b1Hh33HoT0z9YbsK1X/GekUD6cflNUwzQWn7EIC8M0L9b4Ux12Vph+Vz3CyCNHZAY
 2IlLAUS9PvJvHke3Kk4QTIkjDItLPHYyXbDqbCGd9BM66otW38s3+NCvCZqkf0MsnwCHqct3
 nGI5ptnp1Xs+gWW4hxgVhcG6jNChYbQ+F5nJb2c7Z5YH3DN4BMK62yUTRUMvdpsTNP16ehWz
 ZDUmaT/JS0nkZqc9NYAB8XSNMOMMWYweRvvFjnOCQIZTDmtfWjBjk1ZmfuW+zWbtJ8/4pTrn
 ZMPTPdcWjlXXrsCDV95GdUZPJptdjYjjKLdk8MCo3az7VHQSMhcopHbR6eSDPHoe1P7xfFPY
 xoFx6+9LJxGbNShnRY4NR8jwcKTRxm1P5gFuCBqYw4qrV8Y9XF/SjZ2wEf5cka252dVE/eon
 xkwgw84YOI39T6q7U1kQziC7CY2jkQ1ns3oxD6LdzukZoK5R4JLEGzZs0YrM5X0axl4Z0u+k
 AY3UVWMD6IUlLZmeW1x3UXEvoBTHPdHUaBeSBoX2O3RePgil1hR4HbCpwcP9a7ODp1skxEve
 Jinoidb2g5tW9UyILTZOKtDylU4bkOmuyi1yqYuzQVYK0tfqAt6lwYXtUZOOrR0fkJAG8Rz5
 AbElzYRIAAx
IronPort-Data: A9a23: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
 RwjFqXMAyWM
IronPort-HdrOrdr: A9a23:TEWQH6+gMjLvztJAjU9uk+AMI+orL9Y04lQ7vn2ZhyYlF/Bw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,282,1673910000"; 
   d="scan'208";a="50938751"
X-MGA-submission: =?us-ascii?q?MDFnVjNLDWnLCmv/4bO2PyWuphR9lzLoHEYlT0?=
 =?us-ascii?q?VwwupsWUqrQ+bV3exmrv/g0kB9IHnbi2oCKvHpVkAPa9XfofSpaCF0kf?=
 =?us-ascii?q?rn58XRmCdAyavGhVRanLRsaNKOgnztKTAqmzvkYPCHDy/zuzXbYdwKLq?=
 =?us-ascii?q?sw1ycq9yPEkaJjtEv3byxWdA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 15:45:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679496324; i=markus.elfring@web.de;
	bh=j7CBFHhkThEj2vkZLTBrcS+gCBQgUDVjaqXmMJyUbrU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CN+O1t/aEuBKXqs9lzYLWScXYTTsjnQ3ZUEDRzQ1tq5ReklFX579wiva9Ikqoky9o
	 QV5X5NHyGaxlWTDoro45FcLaVD6r+ODCtujBuobGsrWLYKxYes+26IVqXg71ah0NTT
	 lSGpdyR4VdhOlxwC9gAW4/nl0g1O4BtY1XqvkPfQ3YzEVuA5BOOYObP/wiLhwPlHY6
	 FawUPQ8hsg46F+w+e8E809AgqPzJ7es9CNHp8d0JmKdTNv8pIUhU+2NMeEKi+IFruV
	 5+2saU9f1U9Mw0ZcicWE2FyYuKWPBANYhInhItzx3TQuhTVGBk3rYf46Ub0b+xvghT
	 8cI0kBO4Y0ovQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLifk-1pwf7k194i-00HmZ2; Wed, 22
 Mar 2023 15:45:24 +0100
Message-ID: <ea112fdd-7af0-d1f1-442c-306e6ec54a5b@web.de>
Date: Wed, 22 Mar 2023 15:45:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 kernel-janitors@vger.kernel.org, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Adrian Ratiu
 <adrian.ratiu@collabora.com>, Ezequiel Garcia
 <ezequiel@vanguardiasur.com.ar>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <e3aaeecf-8e74-2e74-c58a-d80e153e98f9@web.de>
 <5d5c8c7b-b926-8397-7994-623ac9b37e83@collabora.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <5d5c8c7b-b926-8397-7994-623ac9b37e83@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HTLH6hwZcOtQE0Jx1xZMn5Mg8ZiEE1Rqd2aWsdKY3bk4KgH53ES
 0M6LzJO48gNIuQEiCZc+u3Jw7dhomNTX4c4oGRmsmTEjqzB/ETIJeotYMpGMiqDyPEPqyKK
 w7J8oAoqOCfJALXvMgo0tGpUwMAU9R8mhnnXWvAG6urhnU8inaDVRBC7s8bOFpav5WHPFF0
 xzUZPPKboggd+TFDEUu4g==
UI-OutboundReport: notjunk:1;M01:P0:6YDjGxqN3c0=;9voaMO/gi6TzlekQ9SBC2alyGZ1
 zAtXKklrbVZrJ1sahr9sGOFHinfwdxbr28X284XIqlXcKCGjo25z5XNw7iVxkoAM23jVFRGQF
 o+2vlGtxAGlVnY19UjInGzg4d7iKdSTY7iTLitw7uOfPUyBm9F8hudm2BVwRKnKCra23jxioz
 yonTcJoziMDuyPFsY858bTjINxWYzO18N2jJBDHu46jJAPRHP9+VLaeBWXkKYNDAB/ecVBw7M
 48lnhh6JUBmDpu4tEIxjObNUeGZUfOSe2LackxBYQbX7T9TgvxkmSSP72+cEhtEQZIgPyFx9C
 kdoCevNwB8JFzoxjDTeNJKKbpmr6S41LDkhelwuvu/A9r4/tvOnHUvh9tFDI8uBBAsZ1pjFyQ
 Lr/H7AUJTEXm7/8SBc8mLojpfDI6tZEjhy5rnjZX7hbNTWX5c9rwu9rBr0r2VUawSjV2+en5L
 CWBz6orrYSfWg8LR8UIjQkYo3Jd90Mzba66IGfEd4zzn2n6++0bfUxZv4bxx5AqyXOzk4UtuZ
 gdyjRh8xovyMccbkCPPBhu0smCS5W131J7ADWw3nRamOhm8Y3euzKrwORxhf5FmIJbdBzm5Ls
 wlZYxwOPdXkSGePr3AkuUS3OgFnMz8N3KuP0HYkc5m2GJFV+77yugqkyHQADzSd46Cai0NKi1
 BCecPwA3iQCkC9NFOEOaQndKzZbzIkpDG2oeb0UIyzGgNGbOWr3YQCNKx8FLUBwYXhAzq0KLH
 DJmhRhVSumZ3kjxXFH9aOc8vGHTEm9i/t8AS9eGovfQ8hmreZ3nPzYiM2kGuXNJzr0jlo2ASK
 Zhj4XDf2KKcp4jMLqkoZ8lOXzTpzM82g3xVCgoFqgvgq7rxOY3Q4A+2AY52cT/c/frIchzot7
 yBr+DKds7Ze6fQYDRl6RAmwHX2jJBVaNP7pqro13nhiWaB9vmcOyj3DaE
Subject: Re: [cocci] [PATCH] media: hantro: HEVC: Fix exception handling in
 tile_buffer_reallocate()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 910
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/ea112fdd-7af0-d1f1-442c-306e6ec54a5b%40web.de>


>> The label =E2=80=9Cerr_free_tile_buffers=E2=80=9D was used to jump to a=
nother pointer
>> check despite of the detail in the implementation of the function
>> =E2=80=9Ctile_buffer_reallocate=E2=80=9D that it was determined already=
 that
>> a corresponding variable contained a null pointer because of a failed
>> function call =E2=80=9Cdma_alloc_coherent=E2=80=9D.
>>
>> * Thus use an additional label instead.
>>
>> * Delete a redundant check.
>>
>>
>> This issue was detected by using the Coccinelle software.
>
> If you want to optimize the error path

I would find it nice if more contributors can pick such an idea up.


> I think the best option is to return -ENOMEM when hevc_dec->tile_filter.=
cpu is NULL,
> remove
> =C2=A0=C2=A0=C2=A0=C2=A0if (hevc_dec->tile_bsd.cpu)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_free_coherent(vpu->dev, h=
evc_dec->tile_bsd.size,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hevc_dec->tile_bsd.cpu,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hevc_dec->tile_bsd.dma);
> and reorder the two other dma_free to get something clean.

It seems that my understanding was too limited so far for possible improve=
ments
of this function implementation.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/media/platform/verisilicon/hantro_hevc.c?id=3Da1effab7a3a35a837dd9d2=
b974a1bc4939df1ad5#n70

Would you like to apply any other design variant?

Regards,
Markus
