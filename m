Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CB2C6FD18
	for <cocci@archiver.kernel.org>; Wed, 29 Mar 2023 13:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pcy2vEud90v5aJa5j1EeGp+gurheBlDD/plR6zrfr9g=;
  b=c0/P0b4S1O8vEn07mcXpk8m7UbUfPAy5syvvFL7UE8QwJUTrZpWBxDoZ
   qfkCpxrLcwk0wVLZR+DH/r8HlthDgCJcpKHxtcaMt2RiYeyaWW+I1n8iR
   VlCqb+11Y8FmlQhU7ikpeQOwBIm/oqEmrwLvGiGBj6xERVUye28qttS76
   c=;
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
X-IronPort-AV: E=Sophos;i="5.98,300,1673910000"; 
   d="scan'208";a="99723120"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Mar 2023 15:42:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8FA42E0B51; Wed, 29 Mar 2023 15:42:21 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F1754E0B2D
	for <cocci@sympa.inria.fr>; Wed, 29 Mar 2023 15:42:15 +0200 (CEST)
IronPort-SDR: 64244037_DVuCgwmdVNU8RE6s+3JuOuE2GqCGhXPrRW5WGULC9kMSoby
 z6i36iPnUjiWdFR01ukxgzVfAnaE1/rtpbJYvxQ==
X-IPAS-Result: =?us-ascii?q?A0GIAADqPiRkhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYItgUsvBAtGhFORATGEL4cshzqIaYMWPg8BAwENQQECBAEBAwQ4h?=
 =?us-ascii?q?EYChTkCHQcBBDMGDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECE?=
 =?us-ascii?q?AEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RICR1M9AwMjHQEBESYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDMQetY4EygQGCC?=
 =?us-ascii?q?AEBBoJjmScfLCJTgV4JgRQtAY0EgzZ6Jw+BVUSBFScMgzWIHIJnmUcKgTRzg?=
 =?us-ascii?q?SAOgT2BBAIJAhFrgRIIa4F8QAINZAsOcYFKAmRMgSElBA4DGSsdQAIBCzs6P?=
 =?us-ascii?q?zUGAwsgBlhrAgkjERMFAwsVKkcECDkGGzQRAggPEg8sRA5CNzQTBlwBKQsOE?=
 =?us-ascii?q?QNQgUcEgQ18CgYBJiSdaYEOgnahTqFYNAeCKIFVgVkMnwwGEy6XCA4GkiMul?=
 =?us-ascii?q?zwgp3qBeSSBXDMaJIM2TwMZD44gGYQMj0g/NDsCBwEKAQEDCYVGAQGFewEB?=
IronPort-PHdr: A9a23:9hEgTx1NgSQtcX8fsmDOHQ4yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BaCo68w0hSXA83y0LFttan/i+jYQ2sO4JKM4jgpUadncFs7s/gQhBEqG8WfCEf2f7bAZi0+G
 9leBhc+pynoeUdaF9zjaFLMv3a88SAdGgnlNQpyO+/5BpPeg9642uys+5DfeRtEiTq8bL99L
 Ri7rBjau9ULj4dlNqs+xRzFr2dSde9L321oP1WTnxj95se04pFu9jlbtuwi+cBdT6j0Zrw0Q
 rNEAjsoNWA1/9DrugLYTQST/HscU34ZnQRODgPY8Rz1RJbxsi/9tupgxCmXOND9QL4oVTi+6
 apgVQTlgzkbOTEn7G7Xi9RwjKNFrxKnuxx/2JPfbIWMOPZjYq/RYdYWSGxcVchTSiNBGJuxY
 YgBAeUOM+lWsonzqUUQoBuwBwajGOzhxyRUhn/vx6A2z/gtHA/E0QEmAtkAsG7UrNLwNKoKV
 u661rPIzTbeb/NNxDzz54zIch47ofGNW7JwftfaxE4oGQzflFWQqpHlPyiP2uoCt2ib4fBgV
 eOpi24osAxwrCagydw2hobUmI0Y01bJ/jh2z4gpP9O3UlJ7YcK6H5tKsSGXL4R4T94gTmxpu
 ys21L8LtJ60cSUOy5kqxxHRZvibf4aH/B/uUPidLDd3iX9her+yhxm8/0egxODzSsS53lhEo
 y5Dn9LRtX4NzwTe5taaRvdj5EutxyiD2gLJ5u1ZIU04j6TWJ4Ylz7M/jJYev1nPEjX1lUj2l
 qObdUsp9+614Or9eLrmvIWTN4pshwH+LKsunsu/DPw9MggJQmib5f6w1bP98kLiWrlFk+M5n
 rHYsJDcO8sbura0DxFI3oo98RqzESmq3dYCkXUaLF9JYhyKg5DsO17UIfD4Cfm/g06rkDdu3
 /3IOafuAo/OLnjei7ftZ7lz60pSyAopzNBf4Z1UB6oPIf3tQUD9rsHXAQEhPwyy2OnoEM992
 Z8GWWKTHq+ZN7vfvUKQ6uI1P+aMfJMVuCr6K/U9+/HuimM2lkMcfaSyxpsWaHW4Hux8LEmDY
 HrshM0BEWYQsQYkQuzqkg7KbTkGZHuoWa84ozMyDoO6Cp3Ybp6ijabH3yqhGJBSIGdcBRTEH
 W3ie8CIVukkbCOJPtQnlj0CX7m9DYQm0FXmnw/gyqF7KfLUsgeGtZf83dx56vebwRoy7z1vE
 8OF0yeHSGx0m3wBQzM7xoh7oEp3y0vF2q991bgQMdVJ/LtkVgM3M5TR1eMyX9T7QBmHc9ONR
 VCsT8+pKTUwSNgw35kFZEMrX52ajhHH3jKyS4UYlqeNCYZ8prrc3nzwP9470XvHz68slXEiQ
 81FNHHgjal6oVv9HYnMxmCQjaW3buwx2CDX9WGMhT6rtVtbTRU2fKHLR3EZaWPJoN6/6k6UH
 OzmMqguLgYUkZ3KEaBNcNC8yAweHJ8LWfzbamO1wCKrAAqQg6iLdMzscnkc2yPUDA4FlRoS9
 DCIL1t2HT+v9kTZCjEmDlfzewX06+ArjXqhTVIviSyOYVdg0bWd5RMfw/CRGLsIxrxRgC46s
 H1vGUqlmdffCt6OvQ1kKYBVe9Ag+xFq0WzDtgpyFoOtJeZuiw1WaBx56mXp0Rg/EYBciY4qo
 XctmRJ1Mr6d2Uhdeimw2JftJvvIJ2O08B3Hh7f+/FbY3Z7W/64O7K99sFD/pESyEVJk9Xx70
 t5T2n/a55PQDQNUX4ijGkAwvwN3ob3XeExfr8vdyGFsPK+oszTDx8NhBe0rzQyldsteN6XMH
 RH7EskTDcyjYOIwnF3hYhUBNeFUvKk6WqHuP96Pwq22J6BNmDy8jGJIyJ9w2ASA+ms0S+LF2
 YoE3+DNxhGOBH/3iFastNyymJgRP2hIWDDllm69WcgKNcgQNc4RBGyjItO63IB7jp/pADtD8
 UK7QkgBwImvcAaTaFr02UtR014WqDqpg3jdrXQ8njc3o66YxCGLzf7lcU9NH2dRR3R5y3roL
 5K1id8yQ0WiKQQk3kjAhw6y1+1AqaJzInOGC2JBZSvrNCdPVqWqt7yNS9FC4tUkvG8ENYb0K
 UDfQbn7rRwA1irlFGYL3zE3eQahvZDhlgB7gmaQRJpqhELQYto4hRLW5diHAOVUwiJDXy5gz
 z/eGlm7OdCtu9SSjZbK9O6kBSqtUZhacC+jyo3l1mPzwGRwAgCk2d23lMfmFwcSziLxkdVnH
 SnFtxfzZID32r/ya7s9OBMyWxmltowhUohl2pM9npQRxWQXivD3tTIcnGH/PM8akaPyYXwRR
 CIaltvc4QzrwkpmfTqCw4P0UGnYw9M0PYDgJDlMhWRksoYRW8L2pPRekCB4o0S1t1fUaPl5x
 XIGzOc2rWUdm6cPsRYsySOUBvYTG1NZNGrijUftjZj2oaNJaWKoabX12lB5mIXrKbiYoRxHH
 lv9dI0jGyBY8ch1dl7Bmi6WiMmsaJzLYNQfuwfB2TLJletIM9QckvQQhCxoEX3wtzspxqRo6
 H4mlYH/t4+BJWJ3+au/CRMNLTz5afQY/TT1hLpflMKbjMi/W49sETIRUN70XOqlRXgM4O//O
 V/EQ1he4j+LXKDSFgiF5AJ6omLTRtq1YmqPKiBRzM0+FkPEfgoF2l9SBW9k2MdjRkfwmamDO
 A94/mxDvAei7EEWlaQxal+nFT2C7AawNmVuEcLZdkAJqFgdoR+Sa5PW7/ovTXsBodv+9krUe
 zbdPVgYSjtYPy7MT1H7Yuv+v5+ZrbXeX7fvaaOJO+vGqPQCBa3RmtTwiM08p2nKboLVYTFjF
 6FpgBMcGy8jXZ2IwXNRF2tNyUevJ4aavEvuqncx957itq6xCUS2vtPHCqMOY4U1vUno3OHZb
 LbW3nwxbD9c0tlkKWbg7r8Z0RZSjihvc2LoCrEcrWvWS7qWnKZLDhkdYic1Nc1S7qt60BMfc
 cjcwsj40LJ1lJtXQx9MSEDhl8e1ZMcLP3D1NVXJA1yOPaiHIjuDyt/+YKe1Q7ldxOtOsBj4t
 TGeGk7ldjON8luhHwioKv1JhTqHMQZ2vYagblByBGKlQN+nIhy3PdlrjCEnlL05gnSZUAxUe
 TN4ck5LsviR9XYC2685QTYeqCM4a7LX/kTRp/PVIZsXr/ZxVyF9luYBpW8/16MQ9yZcAvp8h
 CrVqNdq5VCgiOiGjDR9A38s4n5GgpyGuUJ6NODX7J5FDDzh9QgO8H7WJhAEvdpjBfXwtqoWx
 tWFx8eRYH9StsnZ+8cRHZ2eMMWcLH8oKgbkAhbRCxYZCyGmPyfTigYO9ZPavm3QpZ88pJ/2n
 ZMIQbIOT105GMQRDUF9FcADKpN6NtvFubuckdJO+ne06hXcFp0yVnXvSf+YR/niem7xZVZse
 BYCh7/1f917Cw==
IronPort-Data: A9a23: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
 ewjFrbM0tRdD32nqSv/JhB2vAu/+s7n+w==
IronPort-HdrOrdr: A9a23:H7zpNq3+/q09a3YoObN3VQqjBGYkLtp133Aq2lEZdPWaSL39qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SPjUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyWMbEQt6bHCWeDYrMd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,300,1673910000"; 
   d="scan'208";a="51604165"
X-MGA-submission: =?us-ascii?q?MDFwgYkRliM04l1/DPTmjw+ozb36Vz7PKAKI33?=
 =?us-ascii?q?V9ZrTdAd8wP8gU1Cidue+0DjeXFhZmuRUtfHLLhp8c7C5SBahkiDzfzz?=
 =?us-ascii?q?ZWrNXTINNWIdRGv4mw9u/axOf9TYAYb6kC/i0VKQ5p7wdEGrIqWngpfH?=
 =?us-ascii?q?mD57JypUVlcEo0q4UUHG4G7g=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 15:42:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680097328; i=markus.elfring@web.de;
	bh=m00OaWTBWWXyFNelyApPwUNe86kZs+8A+dU6Z+tZiRQ=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=i4hVYBsWEs68EWAYy9+nLW5Yj/xndluuxGfudrPae2Jsg8rY8v1vLsBhsYR/N8GvE
	 ZpwygAQXQIaII5FeYtpfHcanXMi7aHyOqySYeZxhg2MezSdloxgtQFOWbO5IBKBBYM
	 ZjcDqPIjPRn6k0mJfEhkg3Ji/T8RogLrbzxVsogUFqfDaUrdc3HYGRHR2abssK1iWk
	 R6K3SweaSLON1IA9t3CrQA9qIq3XSdwVU2Q6z/7qmi3ZSJa4HhoNhDjaPhoEKB9ajS
	 gWDx4zezyYphijTb7R74DRPdt7pCVj9t2Hhk3i7mA32iyydH2beOVUwwpa0yOeqVvL
	 VDPu+sEWRYhJA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsaS7-1qbQ2V27yt-00u1mt; Wed, 29
 Mar 2023 15:42:08 +0200
Message-ID: <f03b9407-0336-e949-e98d-9e0ddf3bfa57@web.de>
Date: Wed, 29 Mar 2023 15:42:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, drbd-dev@lists.linbit.com,
 =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Philipp Reisner <philipp.reisner@linbit.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <33226beb-4fe2-3da5-5d69-a33e683dec57@web.de>
In-Reply-To: <33226beb-4fe2-3da5-5d69-a33e683dec57@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xccVgmSl8Ha0ghYApF/nCSMpGmsbgj2/qvRn4ePluMGJgjseRbX
 Fk559z9Xyv+xFgsDmtcWdmC520ERk6/YsGvMvbz/URQHXIY87+PTLGYbKHvXJYLfWCgFQjJ
 EKWIaJuBEI0TMqerq8mArhH763ShL8ChFJFmEt9ns/gXwgITt0uNnD3NN0ex1Pgzu1BZFom
 9i4qsBdT30SUKyEWGZX3A==
UI-OutboundReport: notjunk:1;M01:P0:9L+04TnmdBg=;/foYZBKFaueN/GYunkiH6spo0hj
 KPmE36zrUnzXtiFtOFRnVpazqJx/GYKhjYS64xXisco3EC5imx5j6em1ItwpdPKWhJV74BU96
 OPZ88OQlVqTiaoFE4vnVuL5stV+96qHk8WksjZJJO9JBJSGeEFobrRpaS4lkdzbXUPsXw5hyG
 UHMae5ryaHt8bgBzMF4l8DxnvnlxJon6cHRMUq7lcUf4NbR88lRHf/acJtYFwIAJn//xZ5r7n
 BGmdmRyktQ9AkPbD1sDuXK0dK74wpb7EhTpyh4mbbJuNx/x+9wrE07AsTnAOFgRx2jg78BXDG
 S2J+XAsSpHjkZYfYjW/S3bJoQXSWq9HoIJeorVMTtd0HjZXq3xIeELSTPKDC7vQyO58V4p8kw
 2uihjDa4Nx1u3tyOwy1FTDhSYiLgRDu878dKAAU76az876rpAwbJ3mgcFeRpE5H2aefABn4Lf
 nVj8mA5dzjF/PO3eJcf3tLTLF3ltZLKlrMZtIEZa5ZKinallBUdktNzmhLBTLXVjyPxAgN37l
 htm3NEsHBNsnOf29FQbIF5cg6PLrk7zSO53saZ1QAf67YYsoGYq4almg3SgJvCjmKlXjIEsed
 kcvHsMmzfsA0Z7z8VAmWPmPvh7CsVULU3cs6kWmsQqqd15M+Aoc1V5NDTgrUGDYqs8433zmIh
 JDw6NnwHkgsFFvrtcPX+8ifOwRQ58DNRPRclTqgd5wNChRKC5MjnqgVlPjhuegmIleREXdsv8
 XufJKBJaMiFBj54OV/S25hnsFjhNAHQzJMlSfwxDvwdwewXTwVoMB1Dw1xQB6anpyVxqAw48C
 rYvYlY/PBH9DO3J2WGNs2Cn3kwbkGZO4tREk82pN5sCAY4GainPmqnXxIPe0KkhVcofpP0aco
 Fd3ZkZHGcPthbqUiRdlWunUwkkVm8yWNDthA27LFpz2NNKrq21XHGfWVP
Subject: [cocci] [PATCH 2/3] lru_cache: Improve two size determinations in
 lc_create()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 985
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/f03b9407-0336-e949-e98d-9e0ddf3bfa57%40web.de>

Date: Wed, 29 Mar 2023 15:00:13 +0200

Replace the specification of data structures by pointer dereferences
as the parameter for the operator =E2=80=9Csizeof=E2=80=9D to make the cor=
responding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 lib/lru_cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index e0db27b3a2d7..31820f03b146 100644
=2D-- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -94,11 +94,11 @@ struct lru_cache *lc_create(const char *name, struct k=
mem_cache *cache,
 	if (e_count > LC_MAX_ACTIVE)
 		return NULL;

-	slot =3D kcalloc(e_count, sizeof(struct hlist_head), GFP_KERNEL);
+	slot =3D kcalloc(e_count, sizeof(*slot), GFP_KERNEL);
 	if (!slot)
 		return NULL;

-	element =3D kcalloc(e_count, sizeof(struct lc_element *), GFP_KERNEL);
+	element =3D kcalloc(e_count, sizeof(*element), GFP_KERNEL);
 	if (!element)
 		goto out_fail;

=2D-
2.40.0

