Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9496EC6FD1F
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 10:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=b/zttVBYh+vGIlogyKSNkc1pujhj6c8f1yqFb0mlMGk=;
  b=B3Uu50E4GkgQTgJIw1FYyp4pzuvM7IQBivjkyuqIIFtfDLRSMx0qQkFK
   bI/odi6Rt5VZE6PFyqQW3IKb7bY87yS/FhawPSmfekxV/GHPXTz4UTGxj
   +Sy4amvpujRxY+ReO6nC4zirxRuFqmTntK9PmdOkEiNHmQWNWz2O1Q3t/
   0=;
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
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99050816"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 11:20:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 663E4E0D42; Sat, 25 Mar 2023 11:20:21 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AA2E6E0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 11:20:19 +0100 (CET)
IronPort-SDR: 641ecae3_QHHUeNp6RaEfHbNZDM6INKgqgxVZgKJBUZHiPL5K73B62lK
 Dczx4cYr4DYuKr0Phqp6hK5m6Tb3G9dxMu8H8+Q==
X-IPAS-Result: =?us-ascii?q?A0HHAACvyR5khw4P49RaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YItgUsvBAtGhFORATGEL4csjCGEAoMWPg8BAwENQQECBAEBAwQ4gVOCcwKFO?=
 =?us-ascii?q?gIdBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBG?=
 =?us-ascii?q?gkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHU?=
 =?us-ascii?q?z0DAyMEGQEBESYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDMQexJH8zgQGCCAEBB?=
 =?us-ascii?q?oJjmScfLCJTgV4JgRQtAY0EgzZ6Jw+BVUSBFScMgzWIHIJnkSOILwqBNHWBI?=
 =?us-ascii?q?A6BPYEEAgkCEWuBEghrgX1AAg1kCw5vgUoCZEyBHiUEDgMZKx1AAgELOzo/N?=
 =?us-ascii?q?QYDCyAGWGsCCSMREwUDCxUqRwQIOQYcNBECCA8SDyxEDkI3NBMGXAEpCw4RA?=
 =?us-ascii?q?1CBRwSBCoEBBgEmJJpxAgGCZwFSO0wmggTDJjQHgiiBVYFZDJ8MBhMulwgOB?=
 =?us-ascii?q?pIjLoctkA8gp3qBeSSBXDMaJIM2TwMZD44gGR6Dbo9HQDQ7AgcBCgEBAwmFR?=
 =?us-ascii?q?gEBhXsBAQ?=
IronPort-PHdr: A9a23:yYGquBERxAdRebRYm6gnn51GfzNGhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k30RmTAdWQsq4MotGVmp6jcFRI2YyGvnEGfc4EfD4+ouJSoTYdBtWYA1bwNv/gYn9yN
 s1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgppPOT1HZPZg9iq2+yo9JDffQVFiCCjbb59L
 xi6ohjdu8YLioZ+N6g9zQfErXRPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q
 6VAADspL2466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUjms8
 6tnVBnlgzocOjUn7G/YlNB/jKNDoBKguRN/xZLUYJqIP/Z6Z6/RYM8WSXZEUstXSidPAJ6zb
 5EXAuQCM+hXoIfyqUYOoxWgGwSsCuHgxSNHiHLtwa06yv4sHR3a0AEuHd8DtmnfotXvNKcVV
 OC41K7Gwi/Zb/NVxDf985XDfB8lofGCR7JwcMzRyUYyHA7CiVufs5blPzCI1uQWqWSV4O5gV
 ey1i24mrQFxrSOix8kyhYbSnI4a107L+Dx/zY0oKtK2VFR1bsS4EJtMqS6aLY12T9stTWx1u
 is3y74LtYC5cSUKx5kqwx3SZvyIfYWM/h7tW/icLDNmiH9ld7+ygxS//EivxOPzVse530pHo
 yRLnNTIsH0Gyh/d6tCfR/dj40utxyyD2x7N5uxGO0w4iKrWJ4Q8zrM/jpYetUvOEjX4lUnrl
 qObdVgo9vKr5unpZLjtu4WSOJVuig7kN6Qjgsy/Dvo8MggJR2Wb/OO81KD//UHjTrRFkOY5n
 rPEv5/EPcgbp6i5DBFJ0os79RqzEimq3M4GkXUZLl9JYg+LgojzN13TL/30FfK/jE6tkDdvy
 fDGJLrhApDVI3bEirjhZ7V961NHyAYpwt5f45xUCqsAIPL1VU/8r9LZAQEiPACu3unoFs1x1
 oUFVm2XGK+WLLvSsUOU5uIoO+SAeZcZuCzhJPg9+/7ukXg5lEcBcqmuwZQYdHG4E+99I0SZZ
 Hrsms0OHX0Lvgo4VuzqiUeNXSRdZ3aoDOoA4WQ4BZigAIOGRImrgaCGxjyTAJJbfCZFB0qKH
 HOucJ+LH78pYTiZav1wlDMFWKLpH4ooxzmtuRX8xr4hKfDbrGlQiZLk0dFur8LXmBAi8zFuR
 5CB3GWdZ2V1mH4UXTgw3bA5rUErmXmZ1q0tpvVCFsFIr95NXB07M5GUm8lzEdPvQUTsetmTS
 VCpasqrC3c9Q4RikJc1f09hFoD63Vj41C2wDupQzuTTbHRV2qfV3nyqYt14126Dz645yV8vX
 spIM2SiwK957QnaQYDTwA2Cj6j/U6Ma0WbW8Xubi3KUtRR9WRRzTL6DcHQRfErQovzm60mEQ
 7L9Qa8/PF55wNWZYrBPdsWviFxHQPn5P9GLRmurmHqrQzuMyKmNaoXCZGgXminQWwAfiw5G2
 3GAOEAlAzu55WLTCDs7DVX0f0bl6vVzslu+SVIoiR6HZQtt2tJZ4zYzgvqRA7MW17MA42I6r
 ilsWU26x5TQAsaBoAxoeONdZ8k86RFJzzCRsQs1JZGmI6144zxWOw1qo0Pj0Ql2AYRcgIArq
 n0t1g97NaOf1htIaTqZ2Zn6PrCfJHP1+VijbKvf21eW19jzmO9Hzf0iqEj4+iytGFAj9XpPz
 NRflXeRp93LAAcUTZPtQxMv7REp77reYyQ7+8bVzSg2aPPy6GWdnYt0QrJ5mXPCN59FPaiJF
 RH/CZgfDsmqc6kxnkSxKwkDJKZU/bI1OMWvc72H3rSqNaBuhmHD7ywP7YZj30aL7yc5RPTP2
 sNP5viC3RacERr4gk2gtM/fho1OIz0fVDnaq2CsFMtKa6t+cJxeQ0KnOc6q3ZNTg5D3WnhX3
 EGuDRUK1YX6HHjaJ0y41gpW20MNpHWhkibt1D14nQYiqa+H1TDPyeDvHPYeElZCX3IqzVLlI
 IzvyssfQFDtdA8x0h2s+Uf9waFf4qV5NWjaB0lSLWD6KGRrU634sbTnAYYHzZoysjhMFsm4b
 0qbTLHVvBYQlS/uV2dT3zE0cTi2t46xxUUgzjjHczAq8TyAJYl53l/H6cbZROJN0zZjJmEwk
 jTRClWmfpGo8diSi5bfo7W7XmOlWIdUdHqjxoeBuS2noGxyVEfmxbbpwIKhSFV8iHOosrsiH
 T/Fpxv9fITxgqGzMOY8O1JtGEe58M1iXId3joo3gpgUn3kcnJScu3QdwgKReZ1W37zzaH0VS
 HsF2dnQtULA0VdgM2nP6ob3THSbzeN+atP8bm5ciUdfp4haTbyZ6rBJh34/h1Oirh/KJ9V5k
 C0cz/QG93MQxe0E8llIrG3VEvUZGk9WOjbpnhKD4oWlralZU22odKC5yEt0md3yRKHHuAxXX
 2z1P4szBSIlpNsqK0rCiTegj+OsMMmVd98YsQeY1gvNn/QAYoxkjeIE3GJmIT6v5yR/jbRh0
 lo3h8/85dLXbD8wmcDxSh9Aam+vPplVoGuyy/8D2J7Rhd3nH409SG9SBt2yF63uSW1U7bO9a
 E6PCGFu8C7EX+WFW1bOsgE88yKIScHOVTnfJWFFn4U4AkDDeQoG3VFSBHJgwNY4Dlz4npW+N
 hgjoGpJuRig7UETguNwa0ulCziZ+13uM2ZuDsbDa0AIi2MKr0bNbZ7OtKQqQXwepMfw6lXWc
 iSaf1gaXTtPAxLZQQq4Zv/0v5GF+uycTIJSNtPoZrOD4axbXvaMnte015d+ui2LLoOJN2VjC
 Psy3gxCW2p4EoLXgWdHTStfjC/LY8OBwXX0siRqssCy9ujqUwPz9MOODbVVK9Bm5xGxh++KK
 eeRgC9zLTsQ2IkLwDfEz70W3VhajC8LFXHlCbMbqSvEV77dgIdSCAMHLTx+Po1E4uN03wVAP
 9LalsKg1rN8ia1QaR8NXljgl8e1IM0SdjvkbhWdXhnNbenAfGGYpqO/KbmxQrBRkuhO4hi5u
 DLAVlTmIizGjD7xERamLeBLiiifeh1YooC0NBh3Wg2BBJrrbAO2NNhvgHg427ox0znvPHQfL
 CM6XkdDtLyW4gtHj/85F2ELvR8HZaGU3j2U6eXVMMNcqfxwHiF9jP5X+lw/zKZJqj5JTrp5l
 WGBy7wm60Hjme6JxD19VRNIoTsen4OHs3JpPqDB/4VBU3LJlProxXqdAVIGqok9YjUAk79dw
 J7DmfCqQN+j29fT4NdaGMXebs6KYiJJDA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:RzMyGq/WzbQ/QL/8ShNuk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNWftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOb+EYZmIbsS+V2njcL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="51223211"
X-MGA-submission: =?us-ascii?q?MDEcqSA7f+uzBOSZBkg//iB4/QsLCDoobOGpf5?=
 =?us-ascii?q?qygUrGiBa5hndDdy7pBvyX/eolbyeGdErn4UjM1NHe3obrEEJNrC1pyL?=
 =?us-ascii?q?hqkWMXNNPhmgfHdB49p+8sc5q1ushCXGV5MRJv5fjh442tkXvIMIZ22N?=
 =?us-ascii?q?vl5y+eJsVzgKnhMoKF1GOM2w=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 11:20:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679739609; i=markus.elfring@web.de;
	bh=bFZdS95EZCvqbts31DMuKK/942COzZbBIGADAnA0LnY=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=Lf0EhCnrpp6Yc1TU6VjVSCyKwjYAPGASPRRiFBTUAl1CARFtBMiDfLGMhYykH31Wn
	 PCt2v98/s/FYeG9PpVCLsXBpbeRtj4KWOoFH0eArrG3pK3Uf4J3qA5ZAm8gkCJAo+a
	 uRUGMMY6Wr5cuP6+JmvjQJ/w7sdVOk/2g6gqv2OdozVPvfoAijsog8lF/hJJSd5YSr
	 Ck5Yb6YH5NYqgrIbCxZPCbKDV0nWEPsZst6beatSk7/pboH36c1hJyBddO6hK3ESVU
	 rXQzBYC3OhxA/hdAD46+on2wCNCN+qU1bqCxuF1sPnb81YdrFvW0vxVfVDBLxhzdZl
	 0M7S55PF1ButA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMpCS-1pwRvZ0g6e-00Imbp; Sat, 25
 Mar 2023 11:20:09 +0100
Message-ID: <6cf238a9-fdb2-14cb-0373-0abb93936be2@web.de>
Date: Sat, 25 Mar 2023 11:20:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <15fa53e5-916f-dac8-87fb-9cb81021418c@web.de>
In-Reply-To: <15fa53e5-916f-dac8-87fb-9cb81021418c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XKqAvwDFbSdWwOJK5AzE1UQqDPNtKaZPqF3O2i9NzkeJFiDUpm5
 BXlcQLfbAAnNM9GHQCs/bzRoDokasA27T0x6bYKgvPQcDdi1ONblcvt61NpiZGTFAGlapmO
 S4dViA+yih4n31AabEQM9SO0wDvFfOUGMFy7nyee5Nb88F1gs9FY7C+zZbkhLTXHXHTSl30
 bxm5u47aU63+eb2oV1FpQ==
UI-OutboundReport: notjunk:1;M01:P0:fokNiM7Zu9k=;4uKGIQNI/xJMiGD44Z4HYsLv7IN
 tdmyGBXskQWVd1jOZnTAvSMMi4iGVql7dJ0l3Px2S2DuWYQk3ExzoNbp6gu19jERSOy6Ov9Vh
 SXmJI8GBaDQ3BMsjQWSgoO8eFI6i+byf77mVGCjoAP0bMyQQ7t0yGMgX4PvPpd4kdmI2C3Jmf
 KJprc4VM1gbqIWNfCtF5vajK+HMGXfS3Cn2jCu9DrVRc0JAZ6PR6bznf+jNDi3CuNNCXjSloU
 ofd30FVx5Wz0HLrryFBfqJT07630YsT4FX26/LF3jA+anuI9Izr3A269bjlc8oBUIISuswPbx
 DXxgQBBhezNkjTvLVOjoXIEOC785fLeSESWH73xoItRy0zNWI0ReL6T3YW7AgKlCDcUvxJLSY
 q0ReRc3pHXq3/Z2qFxbLqU3mUp+9myzP56GUTa/5jqOEoV4HRxMGwodp02e1Q2Cex/o1PwOZV
 kbI96ZzPTX5WA11cOibb4BcmO4vfFf/L32VhfBtYOPT9BIPncTAN6PyLDiQVbY5EzV7sHHwjA
 drjaky6Pk3Ep3B1XZT4QEdsYJaBNxkpyFyHMROQqJWd/cGI2FI6cw/CZ1rDb+IK8smAYUIbdp
 xNtcfC4V7FKgokdkrEWKL4tF+ZHcTJ89YNpgMIEBDDBibrcPEzj7r7/MMe0Ueb9G6d1Cnq2g7
 IMo7L12fJAT5uhy/Z0EUGruSwFNeiv3Od/XWngh2YNczBPhumEHjN2LqeN63yHSyrt1HzDMhX
 3wzuKqEGpZTcObIw9b/sT5Xu0IKVPYdClossCfrRCdHFWWpYkaRIHekjBlIesub9WU9dyoePY
 rmfNcf2Exf+esOt6qhEDX9v3W4bzMoK/wunB6eVUC6HF4KktcS7Ey9M7EITxuapDIGTx9st0l
 gXIbhM4Hva1YsZnry1QeJFM0S2tldEPdaQAhkNoCphSH439FTsa8tXiPe
Subject: [cocci] [PATCH resent] irqchip/partitions: Fix exception handling
 in partition_create_desc()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 937
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/6cf238a9-fdb2-14cb-0373-0abb93936be2%40web.de>

Date: Sun, 19 Mar 2023 21:38:47 +0100

The label =E2=80=9Cout=E2=80=9D was used to jump to another pointer check =
despite of
the detail in the implementation of the function =E2=80=9Cpartition_create=
_desc=E2=80=9D
that it was determined already that a corresponding variable contained
still a null pointer.

* Thus use more appropriate labels instead.

* Delete a redundant check.


This issue was detected by using the Coccinelle software.

Fixes: 9e2c986cb460bf97154f18e85aa833739a1e8dc7 ("irqchip: Add per-cpu int=
errupt partitioning library")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/irqchip/irq-partition-percpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-partition-percpu.c b/drivers/irqchip/irq-=
partition-percpu.c
index 8e76d2913e6b..80e1c73af87e 100644
=2D-- a/drivers/irqchip/irq-partition-percpu.c
+++ b/drivers/irqchip/irq-partition-percpu.c
@@ -212,21 +212,21 @@ struct partition_desc *partition_create_desc(struct =
fwnode_handle *fwnode,

 	d =3D irq_domain_create_linear(fwnode, nr_parts, &desc->ops, desc);
 	if (!d)
-		goto out;
+		goto free_desc;
 	desc->domain =3D d;

 	desc->bitmap =3D bitmap_zalloc(nr_parts, GFP_KERNEL);
 	if (WARN_ON(!desc->bitmap))
-		goto out;
+		goto remove_domain;

 	desc->chained_desc =3D irq_to_desc(chained_irq);
 	desc->nr_parts =3D nr_parts;
 	desc->parts =3D parts;

 	return desc;
-out:
-	if (d)
-		irq_domain_remove(d);
+remove_domain:
+	irq_domain_remove(d);
+free_desc:
 	kfree(desc);

 	return NULL;
=2D-
2.40.0

