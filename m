Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FD4D3B7C1
	for <cocci@archiver.kernel.org>; Tue, 26 Nov 2024 09:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=yNnAL/vCo4ijmb1bSZbH9/oJixVa5x8Rz8ueUiZ8Myw=;
  b=AECiJ6UXNM4O1kA/97s9wncOOud9Nv7pUIKkitcNHX0f9y/TPve/Vk23
   jKhPgNIK8TCcRwYhbegjPvizGZMN1h1b+ETnCkXvhS8cfvF5Hx3RoaooX
   jzjBGkKarfbF4rkpReKfuQqO0qfCBM9sJLsRsnYgH7podXgQng4qpv6Hr
   g=;
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
X-IronPort-AV: E=Sophos;i="6.12,185,1728943200"; 
   d="scan'208";a="195815541"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Nov 2024 10:21:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 78D77E0133; Tue, 26 Nov 2024 10:21:28 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0C0AAE00B6
	for <cocci@sympa.inria.fr>; Tue, 26 Nov 2024 10:21:23 +0100 (CET)
IronPort-SDR: 67459312_/WMNeaeJRho6QqpMlSPAsElGqMsVnRUF4X6vASMzKXktaf4
 Z2mysfduF+RBbr7rBV4X7CrhUXP/psNQRhGvVOA==
X-IPAS-Result: =?us-ascii?q?A0H1CACnkUVneA4P49RaHgEBCxIMQIFIC4JEYiFUMwQLS?=
 =?us-ascii?q?IRWj02BdDCEO4c7h1aIdYFWgX4PAQMBDUEBAgQBAQMEggyCdAKKWwIeBwEEM?=
 =?us-ascii?q?gcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABQw4KMYV7DYJiA?=
 =?us-ascii?q?YEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBEScECwsaAiYCAlYGARQBA?=
 =?us-ascii?q?YJ9gjABAw4jB7ApgTITboIMAQEG2lsfLCJXgWQJgRouhWqCYgGGJIQ8Jw+BV?=
 =?us-ascii?q?USBPIJSMT6EQ4NbgmmCRHmEFiWIGGibVlJ7HANZMgFVExcLBwWBKSEsA4F5T?=
 =?us-ascii?q?n+BNoFRAUKCTkqDLhyBQgU3R4JKaUs6Ag0CNoIkJFmCTYElBAWDa4ELg16EX?=
 =?us-ascii?q?IYYHUACAQttPTcJCxsGPaFnhFfIdDQHgjiBZYFjDJ9ZBhMvl0MOBpJ6HphdI?=
 =?us-ascii?q?qkGgW4BMoFcMxokgzZPAxkPjiGELcgWQjU7AgcBCgEBAwmFRgEBi1aBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:L2A3baiurykm5XOgUSzBlFhaX161sRQKZh0ujC45NGQN5FlHY01je
 htvWm6BPauCZDfzfYxxa4nlpk0E7ZaGnYdrHVA+rns8QitjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UqieUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYqdDtOg06/gEk35qir4WlG5gVWic1j5TcyqVFFVPrzGonqdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv4+lpTWhRiro/6ZWBiuFIOM0SRqkQqShgJ70oOHKF0hXG7JNm+t4sZJ
 N1l7fRcQOqyV0HGsLx1vxJwS0mSMUDakVNuzLfWXcG7liX7n3XQL/pGJm0IMJE85shOI3hV8
 fIBChcAMxegiLfjqF67YrEEasULKc72IMUAt3smwTyx4fQOG8mZBf+QupkBgXFp2qiiHt6GD
 yYdQR9mdhfdeFtiPlkNCZQxtPiljD/zflW0rXrM/fBpvzKJkVIZPL7FHcLYQYykdexvpAXft
 l3J/jSoDAABK4nKodaC2inw1reUzXyTtJgpPLmx6fduhHWBx2kZEhRQVF2hoPD/hFTWc9lYI
 EcV0jE/qLA7sk2tVNj0GROiyENopTYZXMdMVfI34keBx8I4/jp1GEAuYgBMdPg6mvYUXCcu2
 EaruN60Ah9g5ej9pW2myp+Yqja7OC4wJGAEZDMZQQZt3zUFiN5o5v4oZok4eJNZnuHI9SfML
 yeigAVWuln+pcsMyrn94l3NxT6hznQocuLXzlWGNo5GxlonDGJAW2BOwQaHhRqnBNjCJmRtR
 FBex6CjABkmVPlhbhClTuQXB62O7P2YKjDailMHN8B+rG7wpi//LdEBvm4WyKJV3iAsJm6Bj
 Kj75lI52XOvFCb2Mf4fj3+ZUJ90lvi8fTgbfqqJNYoeCnSOSON31HoyNRbLjz+FfLkEkKY5P
 ozTasvEMJrpIfQP8dZCfM9EieVD7nlmlQv7HMmnpzz5i+b2TCDPF98tbgDUBshnt/zsnekg2
 4wHXyd8408HCLWmCsQWmKZPRW03wY8TXs+t95wPKLbYcmKL2ggJUpfs/F/oQKQ994w9qwsC1
 ijVtpZwmQql107UYx6HcG5iY77JVJNy5yBzdy81MFrinzBpbY+z5e1NP9E6bJs2xtxFlPRUd
 vgif9nfI/JtTj+cxS8RQ6Ogp6NfdTOqpzm0AQybXBYFcaVNeSn16/7/Xw629CAxHiu97sQ/h
 Lu71zLke5kIRiU8LcOPdv6f9k6950YcvOdIW2rJPdhhV0H++6d6KyHKr6EWIuNdDT7h1zelx
 wKtLhNAntb0oqgx68vsqZGfiYWiA89SO1V8JHbKy4q2OQ3x3HuR8aUZXMmmJTniBX7JooO8b
 uBr/tTAGfwgnmcSlbFjErxunJkM1/G2q5B0lg1bTWj2NXK1AbZdI16D78lFlotJ4pR74QKWe
 Ea+yuN2CIWzGvHOMQAufVI+T+G5y/srtCHY7q01LGXE9SZHxue7fnsIDSacqh52DeVTC5wk8
 9cDqcRNyg2YizgWCPikoB1Q1VyxKi0nb/16mLAcWJTmmyg6+GFkOJb8MBL70LuLStdLM3QpH
 AOqubr/t+xc63fGIlUOFinr/OtChJ4xlghA430cKn+oxNfUpP8F8ydA0DYwTwgP8BRj1th3G
 2l0Nn9aIbeF0CdoifNiAUGtOVBlLz+I9nPhz2AmkDXicHCpcWjWdksvFP2o7mlA1059Jx91p
 Kq5zkThWhbUJPDB5DM4AxNZmqayXO5P+R3ns+H5Oca8Rr0RQyfv242qbko28yrXO9s73hD7l
 LM77dRLSPPJMAALqPcGEKic77MbTS6EKEFkQf1M+KAoH3nWSAqt2AqhelyARcdQG8PkqUOIK
 dRiBsZqZSSM0CyjqjM6B6lVB5RWmPUvxsQJe5K1BGognoackAFUs8PrxnCjvFMoftRgqtZiC
 4XzcznZLHecq0EJkEDwre5FGFGCX/86WCPG0tqIrdo5T6A4jLk0cGUZ8KeFgHGOAQ42ozOWp
 FziYoHV/cxDyKNtvdDeLYReNSqJKPfYdueBwCasuftgMPLNNsbvsVsOi1/FZg55A5oYa+5Vp
 5+s7uHl7Rjgh6kkdkzkgLyDKvV53tqzV+9pLc7HFnlWsi+cUsvK4RFY2WSHBbFWsdFavO+Le
 hCZbZauSNsrRNtt/n1ZRCxAGRI7Ca6sTKPBpzu4nsucGComzg3LA9O2x0DHNVgBWHczBKT/L
 Qvot9KFxNNS9t1MDSBZIcBWOcZzJVu7VJY2c9H0iyKjMVCppVG/oZrnqwsr7GDaK3uDEfui2
 6n/eDrFSE2Qtp3LnfZjiK4jji1PWTw5yaM1c1kG8tF7tyGiASRUZa4BOJEBEddPnja0yJj8Y
 yrXYXA/DTnmGw5Jagj4/M+pSzL36jbi4TslDmdBE4KohyaK6EeoBbx86mF/7n0wdjaLICRL7
 z0B0iWYA/Rz6sgBqSUvCjiTnuptgP/Xrp7N0V6oiNT8Wn7yHp1TvEGM32NxuejvDMzH0knGT
 YTwqaaoX2njIXPM/Q1cl7K51f3XUP4DD9nlUMtX/Ovihg==
IronPort-HdrOrdr: A9a23:I95ta6BuZTy2dtvlHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:/eaAoG3dbZPfs+nWe/p3aLxfMOwbf2H50FnpAVajDWhwapqYFFiz9/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3AsPFlyg4lWRanGk14WRREYJbQxoxF+6mVWG49uK8?=
 =?us-ascii?q?8+I6UCiNxa2aTnS+oF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,185,1728943200"; 
   d="scan'208";a="102642256"
X-MGA-submission: =?us-ascii?q?MDHLtaYNDS11t8gp6YzQroTjfprQqeOgX/L/dd?=
 =?us-ascii?q?UKe7bOaYCBdK5IDtC1RadFuWrCk/4lhlsy0aIC3P5Pkl1nIolq+khLcJ?=
 =?us-ascii?q?clPERi1mdCatwjyT/TIHJnqAOuZGydOLarWUNHbXuiVGqsn28XiZbBEI?=
 =?us-ascii?q?aFvB5KEX0doFuMBm6+14Lj5g=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 10:21:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732612881; x=1733217681; i=markus.elfring@web.de;
	bh=yNnAL/vCo4ijmb1bSZbH9/oJixVa5x8Rz8ueUiZ8Myw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UlOLrNkTNZVwcO11npx8gJrkkQ7S44frkY8jHXEGnIgXn826Qz/fNuZ3s3zSRtzG
	 Gng+77P0cZeyNahXQGuuuAtsJDneW0+F5IMTwioVu9dZRMt+TjmA64WBgGnBSzlII
	 4XvsbPRX0pi38Y9YRkWkNIMSZvGuLs7659qKs5lljDA0K2IygeTnAop7hhrn0o/V3
	 7bnGwVrUu5q7U28L+savQpT/bRc4TcaxrnPZ/olAC2x3KJbJ7pGDEMoh1xUEqtziL
	 7yLLl1G+lLWjRZz3BVKDMO5FkMWzHxS8IO5iiwQL2lyVjK5viNYnjXsFFVlbbvdox
	 /puT3tevdwGJKzwGLQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9431-1tjn0w1MJD-011tch; Tue, 26
 Nov 2024 10:21:21 +0100
Message-ID: <1942de3c-08df-45f7-a2d1-9d6b6a8d519f@web.de>
Date: Tue, 26 Nov 2024 10:21:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <434d257c-f0a5-483d-9fcb-3303301ad867@web.de>
 <9e8d6626-f8a2-19a7-33d3-b0cc48d2fa68@inria.fr>
 <100663c2-6281-49cb-bb9f-55656dff80ca@web.de>
 <d05cde6b-6189-4c2-a452-a0851430dcb@inria.fr>
 <ee6bacc9-eece-40b5-b86a-fa022532af9e@web.de>
 <76e08376-fc21-cef6-ec3-6ccfb33ed6a1@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <76e08376-fc21-cef6-ec3-6ccfb33ed6a1@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cLOg2AoOuFwGFmkuqVMW6u7wHxdZJFWjpB3r7xrMnjOJZChmeQu
 19iWFrchWmhe/3xDWWnPaTcgcHRVo4FlOZV/bwpxwzhSCn5QkroMJQ+s/KWFNJmJlHIUJQa
 TqrCCU5LJdpXa7KsrYHvm/+Pi6MfRDIWB1p9RkxRX/C/NU316wgGGc90PTbDD1Lfl5k2Wv5
 S39OFx43z8fRQ7mjmgqmg==
UI-OutboundReport: notjunk:1;M01:P0:es5tK6zgS0c=;UfBg4snFuE18XL2zYJ/kjsOOhGH
 Z0Si4Szqmu2zNkBdqETw/9syWZi7e6v6LwlHHCAFzU6aLwIKGTjTjH499dV+GSrKguFsuXIIJ
 QZ/td14giZ7JTPpL/GsTxPJWUFjDEkKs4HOrla/FrzA05sFfv7rLfqj4CqdTwZHK8h+PqSW6c
 yzWoWqsNbYyhI8y7F+2WKZ8LQWNIS1zDHfYYQiBvVdTABF+6vmXlvisyoDSW85eTH6ThnZOl5
 uOjQYBw2EG4tkvfY1DEycTzGq0A2nkYRZXouBzTuvWx8dFQH87RBaqmMLZ+2mb8og/sudKTdr
 NJgzochHFKT6C1YL4/IdMJhdl9M+PKoxLgQbK3Rsc30HEULVwQvtQCQwVBJmgh1IUKBc08/fv
 1YUT4gbA7Awa2ofRkJ/sbTUL4yMThYN22gZHJRhT7Gz5/VVe+WXlp0gpxy6OtUuWW/v62h+Db
 HJOrTOGeOU20nTy6jKr1ugaWGvZnf92C026Jc1/pACRgY7GcXnf388IatEQhnmqMaYBLR0VrF
 5UVu7x2S+5bUXotq8j6cEZzBM0Ht/I8CHLhzbtOJXRuT+Qp+XL0NHMKp01eOTImfpIrvYlTbP
 TlKgwVjPnVE/2GJzIiWfIBcbgoM6wTejeeqFLlSUYZtlVKD08nO6q6gd7maN6RmuJngZSXmaz
 yxLY4mfauw0UmpXLYKMD70rk3fNqH0P0EECVmmL1WL9eCV3o8nV07+4I9KQFr/B6LdEM1BzU5
 OxO+O9wF2dTB5M+SrQOP+6zYYZpeEaclFS8EZ1NBCTBvFftP2FiCgc+w0iOJUq0nwXSpoJBYA
 8OPJXMaLognXVUZPj0I7bz751lW4XstvS7cgxe96xR3rnjP2C2RoAoPefuY8/p6ub3ockHZBk
 KKbU7RbBxq6Y/LzPsovkdUA+ScHeGyTHmNwKKZgJNk5r8+3rnzeQus0D1
Subject: Re: [cocci] Data processing challenges for source code analyses
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2128
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/1942de3c-08df-45f7-a2d1-9d6b6a8d519f%40web.de>

> You can use options like --all-includes or --recursive-includes to get
> more information from header files if it is needed to obtain the type
> information.
>
> But I have no idea what is a "data processing challenge".
Another example:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> ls -sk driver=
s/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h
23392 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h


* Under which circumstances will software development interests grow
  also for the amount of preprocessing code in such header files?

* Would you like to take another look at any size statistics for source fi=
les?


Regards,
Markus
