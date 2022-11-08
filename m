Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B87C4332F
	for <cocci@archiver.kernel.org>; Tue,  8 Nov 2022 19:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6lx4/o4N4zczKMRsSjADmhtO/Z2kNp7nn8tx+lQL7xE=;
  b=v05M2T8UVz96U+zBl61h1Rfh3DQWVlXCnNlK+cZq7vcmDgQA4lCw8CAy
   cOcpPSZQbUwEXfUZw7yz5xh+YjgBYVFa6nOcPld5KUjooHF9lyGbF5ENx
   Cfi5TgcJDhzCeWB4RYlQRnZ/Rd8MFSOvyiumBdlzcAclwVA3jhicrN0Gy
   8=;
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
X-IronPort-AV: E=Sophos;i="5.96,148,1665439200"; 
   d="scan'208";a="77328528"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2022 20:40:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 15708E0236; Tue,  8 Nov 2022 20:40:35 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4D4D2E0076
	for <cocci@sympa.inria.fr>; Tue,  8 Nov 2022 20:40:32 +0100 (CET)
IronPort-SDR: 636ab0af_Ts4z9mAemIvq3e57EUAGASIBkun8a+M6ksI9NvwfxKbrDcu
 U207N9VRrAHa2wEuAwKQG21bcbFlGJ3dECNvPVQ==
X-IPAS-Result: =?us-ascii?q?A0GqCgC/r2pjhw4P49RaHQEBAQEJARIBBQUBQIFPgi2BA?=
 =?us-ascii?q?gNTLgQLRQKETZBsCCYDaYNAjk2EX4QBgxY+DwEDAQ09BAECBAEBAwSDa05FA?=
 =?us-ascii?q?oR6Ah0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBA?=
 =?us-ascii?q?RkJFwcOEAUihWgNgjUpAXRTNQEBAQEBAQEBAQEBAQEBAQEBAQEBFQINOhg7L?=
 =?us-ascii?q?AECAgEjHQEBESYBBAsLGgIfBwICVwYBDAYCAQGCeQGCbQEDDSMHDKsFgTKBA?=
 =?us-ascii?q?YIIAQEGgUABmkUfLCJTgV4DBoEULIxcgzZ6JxCBVUSBFScMgnc+gksXAwEYg?=
 =?us-ascii?q?SQBASCDV4Jnjn+INyYEDgMZKx1AAgELOzIDCksbMScOCR8WBgoEFw0FBhIDI?=
 =?us-ascii?q?EgmBQo3DygvZyIJHBsHgQwqCR8VAwQEAwIGEwMiAg0pMRQEKRMNKydvCQIDI?=
 =?us-ascii?q?mUFAwMEKCwDCSEfBxYRJDwHVxIoAQQDAhAiOgYDCQMCIhNEcwIJJhEVBQMNF?=
 =?us-ascii?q?yUIBU0ECDkFBlISAgoRAxIPBiZHDko+ORYGJ0QBMw4OFANegW0ENWmZLYEpJ?=
 =?us-ascii?q?oFIPQJYdR4qYpIcCpIUnT00B4IegUyBTQyJdJRyBhMulm0OBpIULYccj2kgi?=
 =?us-ascii?q?zSBb5o0gXkjgVwzGiSDNh8wAxkPjiAZHoM7M4RhhUtANAIBAQssAgcBCgEBA?=
 =?us-ascii?q?wmFRwEBhRUBAQ?=
IronPort-PHdr: A9a23:37WBMROi3fBSzdRWBcol6nYrBBdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDv6kr1weCBN+Lo7Ic0qyK6fumATRBqb+681k6OKRWUBEEjchE1ycBO+WiTXPBEfjxciYhF
 95DXlI2t1uyMExSBdqsLwaK+i764jEdAAjwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba19I
 RmsowjdqsYajZZ8Jqsy1xDFpmdEd/lMyW5nO16ekQzw6tus8JJm7i9dp+8v+8lcXKvgYq82V
 6ZYDDMoM2A04M3kqxzORhaR63UfT2sbjANGDxDK4x/mUJjxtDD6tvdm1ymBIcL2V7E0Vi+84
 KptVRTllT0INz898GHQl8xwkKdWqw+vqhBj34LZZpyeOeFgda3BY9wVWWtBXt5QVyNfBIO8c
 5APBPcFMepBsoXxu0cCoR64CAKxBu3g1yVIi2f106M03OsuHxzI0hI+EtIAsHrbrsn6OqgJX
 OCp1anF1ynPY+9Y1Dr/7oXDbxAvoeuLXbJ1acffzlMgFxnGjlWNsozuIjyb1uADs2iB7upgU
 +2vgHMgpg92uDev3MQsipTSho4PxV7E8St5wJw0Jd2+R052etClH4VLuC2AKoR5XNovTmd1s
 yk11rMIo4S0fDQWyJs53R7fbeSKfYeH7B//VuucIjh2iXNrdb+jhhu/7UauxvDiW8Sq1FtHr
 CpIn9rRun0P1xHe98uKR/th8kq/xzqCyw7e5/xELE0yiKHVJZkhwrsqmZoSt0TOBiz2l1vsj
 K+QaEok/vKk6+P9YrXpvpOcMpV7igD6Mqg3gMO/G/g3MggPX2iF5+uwzqHs/Ur8QLlSiv02k
 azZsJTAKcQcvK65DAlY2Zsg5RanFzqqzskUkWcdIF5bZh6KjZLlN0zOLfziEPuyjEygnTNky
 vzcMLDtH4/BI3vHnbv7frtw5UhRwxcpw99F/ZJbELQBLerzWkDvsNzYCQc0Mwmzw+b6FNVxz
 I0fVnyUDaODLazdr0eE5uMpI+aSeI8YoCjxJ+U76/L0k3M1h10QcbO00ZYXcny0A/trL12cY
 XX2g9cBFWkKvhA5TOzvkFCMViRcZ2yxX6Ih/TE3Eo2oDYPNRoC3gbyB2ii7E4ZYZ29YEV+AC
 2rneJucV/cKcy2dOtVhnSAcVbi9V48h0gmjuBHix7p9MuXU4jEYtY7k1NVt++LTkg09+iB1D
 8mGyGGMT2R0nnsSSDMs3aB/p1Z9ylaZ3qRijfxYD8Rf5+lVXQciKZ7c0+t6Bsj2Wg3bcNaGU
 lKmQtG9DDAwT9IxxsQBY1xnFNm4jxDD2TCqA74PmLCRCpw06PGU43+kGtlw/FXC2agnghwF3
 M1OOiXym+h88wXSAYOMkEKUkaelXbwR2iHQ6H2Ey2ue+k1VBko4c7jBXHlXQkLJpND9rhfgU
 ruvAPIDOxRIzcqqK61Qa9Svg08QAL/FOd/ZZ2uq01+5AReYjueKbYHtf2wGmj3UDEkUuwEW9
 HnAOxJoQm+qpGnVDRRvE0juagXi67pQsnS+G2o91QKXdAVM07Sv+xgazai5QukQw6lClSMvs
 TRyE36i0tiQB9fW9FkpR7lVfd5ouAQP7mnerQEoe8X4d8iK53YbegVz5Ab10glvT55HiY4sp
 W8rywx7LeSZ1klAfnWWx8O4IaXZf0/1+h3ncKvKwhfGyt/D364V6+kj7XjnshuoEEUK7Hhtl
 dVYgDOH/pufNAMJStrqV1ovsR1zprXUeC44sqbdz35xKu+ZtjHY2tQmLPQowFCscoQXK7uKQ
 Sn1FcBSHM2yMKoqllyuOwoDJ/xX/bUoMtmOcvybxOi0MewmkD/OYX1vxod73wrM8iN9TrWNx
 JMZ27SD2RPBUT7gjVCnu8SxmIZeZDhUEHDtgS7jTJVcYKF/Z+NpQS+nPtG3y9NihpXsR28Q9
 VitAEkD0dOofhzaZkL03AlZ30Aa6XK9ni7wwztxmjAv5q2RuU6Gi8HrbhkaIShmQGd4jFHjC
 Ze5hZYWUQngbgQkkgek+Vev37JS9+x0K2jeR1sNfjCjdTg4FPHq6fzbPogWtMBN020fSum3b
 FGER6SophIb13imBG5C3HUgcCnsvJzlnht8gWbbLXBprXOfd9sjoHWXrNHaW/NV2SILASdij
 jyCTH21Jdq05pO5k5nZs+axf32sXNtffGO4qOHI/Dv+/mBsDRClyrqWk8fkDBN8/Cv1zdhsW
 g3XoRy6boShhMHYeap3O0JvAlH78c9zHIpzx5AxiJ8n0n8fnpyJ/HADnA8fKP1j0LnlJDoIT
 D8PmJvO5RT9nVZkNjSPzp74UXOUxo1gYcO7ayUYwHB148dPAaaSpLtK+Ek96n+xtwHMer5Qm
 jkHyP0hwGEXiacFtUIhwz6cDbYbAURDdXa1zVLStY/49fgRPTrneKP4zEdkmNG9ELyOx2MUE
 G30fJsvB24478lyNk7NzGym74jlfNfKatdA/haQkhrGk61UMMdrz6BM33A4fzug+yR5mItZx
 VR00Jq3vZaKMTBo9aO9WVtDMyHtItgU4nfrhLpfmcCf28auGI9gE3MFRsiNL7rgHTQMuPDgL
 wvLHic7ryLRPLPFHhKErmpioWjOFZ+DKHydYnUUh4YHJlHVNAlEjQYYUS9v1LswDAO334rMd
 Elj5zYezkH1oF1Ax6g7Unu3GnearwCuZDAuTZGZJxcD9QBO6XDeNsmG5/5yFSVVrdWx6RaAI
 WuBa0FUHHkEDwaaUkv7MODktryiu6CIQ/CzJPzUbfCSpPxCAr2WkIm33NIu/i7QZJ/WZD84V
 aJ9gxAdGykjS4ODxlBtA2QWj36fNZfB4k3mpWsu84bnt662EAP3udnVUuEUa48wvUnpx//Eb
 bHYhT4le2wBidVTnzmRmeJZhgJCzHs/ElvlWbUY6XydFuSJxPIRVkNKLXs0bpUA7rpgjFMUZ
 oiE0JWvjuE+1rlvVB9ETQCzwJj2I5NQZTjsbhWZWAHRatHkbXXK252lMfn6EOMNyr8O5lvp4
 m7TEle/bGTZ0WC3Clb1arkK1nvTeRVavMvVng9FL2/lQZqmbxS6NIQyljgq2fgvgWuMM2cAM
 D96ekcLr7uK7CoejO8tU2pGpmFoK+WJgUP7p6HRN4oWvP13Ay91i/MS4XI0zKFQ5T1FQ/o9k
 TXbr9pnqVWr2ueVzT8vXB1LozdNzIWF2Ccqcb3e7YVFUG3Y8Qgl6GKNF1IVqtEjBtCu86Fcx
 97Tlb7ifTdP99WHmKlUT8PQKc+BLD8gKU+zQWSSVlFaC2f2cziD1Ck/2LmI+3aYr4Y3sM3pk
 ZsKEfpAUUAtU+gdEgJjFcADJ5F+WnUll6SahYgG/ynbzlGZScNEs5TATv/XD+/oLWPTqLBeZ
 AYTh578I54SMILTxEFoLFV31teveQKYTZVWryttYxVh6l1K62R7R3Yv1ljNbwSw/DkMGPTyk
 hN82W4cKaw9sTzr5VkwPF/DoiA9xVIwldvSijeUaDftLa20UOm+6gLxsFUtdIz2SUB5YF/q9
 aSBHCjJTfRdguk4HYiEoBDRs91DFKwFJZA=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:yb+zDq2cktHEMKGUr/UfqQqjBGYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,148,1665439200"; 
   d="scan'208";a="39261053"
X-MGA-submission: =?us-ascii?q?MDEQgv8EiRrjgQjFBX8Q6uuvoQoqdJjiUgXVjV?=
 =?us-ascii?q?YxUR5c4kS84eTIOhO8WfPHKlAS9d9TeobFfUEPDcw0zUcd6AuRM7X4xS?=
 =?us-ascii?q?mBDQJOdHS2MwUeJp71nvD9eRfMl0o97TLgWBqIHAifp5s2doswf1dUKd?=
 =?us-ascii?q?i8qiwgSRnBsnzPmoEUowrJRw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 20:40:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1667936429; bh=Nr3FrC2BYDIbDkuIB1Wk3I1Hp8BrgAfeaAXno+Qv89s=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=M31sCZt5NRQ9OenVLlYjmt1U/QHJOcpLJJJ3B68E2/gN5uax3OYnnvBRbDgbGbB0c
	 3lJXiv1wrEG9hOidXxR6Vl80KYG0jEw8JJ3KAAtiGn69JpECShrrj5mjKJyLel+YQn
	 yulbRw/76/mvW73EJUWMKhFgoFaXNpIhtjjGxv2KInoCxO5TPGaizmkWyTQ/0jImK6
	 +iE2SjUm+2K3x6sk+/KJVPYrLAbxn8M7FOSUF/EX5dcqRZZlGzcGvnuAv2r4LEkSIL
	 4PcrGEZ2FVyahfuBXQiheSJFEhSMS8oXKEuxtTA1KeujuPQ8WJ+Z1a7EYrnalRGaBn
	 UJ5iEF0M5nDeg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MT7aV-1oQlec0dBf-00UXBi; Tue, 08
 Nov 2022 20:40:29 +0100
Message-ID: <fedc061f-c66c-2985-65e9-2bc289d59e85@web.de>
Date: Tue, 8 Nov 2022 20:40:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 cocci@inria.fr
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
References: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
 <bd13da2d-6d18-4f33-0987-a193e3c9b761@web.de>
 <20221107200815.u7hcwejileeabnct@pengutronix.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20221107200815.u7hcwejileeabnct@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3JuhAPeWOsFkG9uoZuWUQTEhgXQjY3oMpJzFrqSsGW1ccsLzwEo
 QAVYyBFqHkVhNLfUKL/47JkLVd7aDOsx95UxoL56iMw2rGs4BKY9vZLDAdVqXZyPByG8XqQ
 B9tcBeFE1rWdiPNEVkn9ujhELpj8QKVD8Y4hLduzCF8sCBGL9DfqgpmseQFHcE7Ff9bkZBS
 QjPLj0aDjkvWBcRdwQx0g==
UI-OutboundReport: notjunk:1;M01:P0:mXNRmMp8TIE=;qIxiHeXzHgHNPZ9rfpL3kV7bmMl
 EewfESIt1qGm/o0gvJR6sq46ubQE4F9+gmz/xpm4HEAtXlXWFEV1uOiqoEnYJ0q2K9NKodvv3
 xFwVEGX61Tob6CrAsTtZCq4xtxVTCuoY7cg7UB1RDCc8wnk8NAHCoSRC01abeV1+dbDOtG1Kh
 jueDZLIU3mG+axSKaB10j1OijjgH+5FGxF54/j3FVDDQeie/eh7A4Fn6ZRrm96zqeXq9XBq9w
 NdlExj2M3dkuueAISqS0wk4haJmuGuFbBm6CFsYVmEjxIS4If3qTMU7YhO241u2a6bW8t1GnF
 +120yqs3ssm4QKuFy1tkCtPiioQiXCRtqFXzuLbiDa9Vp+tnYHSJwt/FkTBVFouH7sZcK9HmD
 TidFSKA9rTLKd4TdFCVTTEZO7vWhL036ylYe0FG+H91HAAMrtjgimWD2Cpg6n91aGIA9er7iD
 jAmnwjtKnMUPByTuJHPDLHWOI6d3YpEjovRfhpQ3OovoMCcGgzkf1oZEtGHyY22KyeAcDXxep
 bJUjvkKFxYCFzYHWNMKnA+PzBvhdUWhhmtbUxVOmU1rVHt3SKFTu/wSkk8Iv9k3dBBAR8hruF
 w0HStfxLrLLrxNtMdNEd6N9Ihgk9oMQyPTRpYBXQoaSfXOTg3gbzA87ujUq//Sjuis7sXrtr0
 8E9i5DHcWBVF4hSKBJBsLrlLL2ShgHgcn6Le7wbYGxDlRyDL7wfj7RksDWbkK/ladpjHwO4CU
 w/Ok//UX44cVONLypIakl4XkognbgO+jr+PP5cnzqkpcV+WDu5X8pRYtNzQKcb0KLnmmDXbpL
 sbmoXnIsEgVLQz3tnovvLknDLPTV/OnM/iR3RH45YNcB2rEawEX3z6HtbG5jlQnB3USveSuNl
 8ueZ2S1ybkKwTLI2YQnQSYMZImcQ/Le3Qnp+4/OSEgbRdX0Ov0Kkws+6/IoYaU/jutf+5BVHZ
 61qINg==
Subject: Re: [cocci] [PATCH] coccinelle: api: Don't use
 devm_platform_get_and_ioremap_resource with res==NULL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 725
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/fedc061f-c66c-2985-65e9-2bc289d59e85%40web.de>

>>> devm_platform_get_and_ioremap_resource(pdev, index, NULL) is equivalen=
t to
>>> the shorter devm_platform_ioremap_resource(pdev, index).

Would you like to add an imperative wording to the patch description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.1-rc4#n94



> I have no idea about org and report modes.


Do you get any additional development ideas from information of previous m=
essages?

Example:
2020-09-07
[PATCH v2] Coccinelle: api: Add SmPL script =E2=80=9Cuse_devm_platform_get=
_and_ioremap_resource.cocci=E2=80=9D
https://www.mail-archive.com/cocci@systeme.lip6.fr/msg08157.html
https://lkml.org/lkml/2020/9/7/960


> After uninstalling python2 this ends in:
>
> 	Cannot find Python library
> 	coccicheck failed
> 	make: *** [Makefile:2076: coccicheck] Error 255


With which script language versions are you going to work further?


> So a critical glimpse by someone more knowledgable than me is recommende=
d.


I am curious how such patch reviews will evolve further.


> However I don't know how to react to "I doubt ... is appropriate",
> I'd need a more constructive feedback to act on.

How do you think about to improve the knowledge for applied data output fo=
rmats?

Regards,
Markus
