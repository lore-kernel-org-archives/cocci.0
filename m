Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A509D6ACC0
	for <cocci@archiver.kernel.org>; Wed, 27 Nov 2024 11:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wsTkpJ0crrbiKCw//zEGB71MSjoQsz2INPw4o65ZODw=;
  b=F/XY6LuDOXd6nJGgw+j0oQigJV8SQHHySoJcVtFWzZrGx8N2OFAqtr8S
   yq3wOeAtpgPnGq17961peUhpSk+pcu8t8g6P8Mm8uqfXn46XrX+lG1ehh
   GRCpPRAcmlrC722qJo0vSkS407F13Gb4kLdf6fiBO8yPLgviP0vPtpXHm
   c=;
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
X-IronPort-AV: E=Sophos;i="6.12,189,1728943200"; 
   d="scan'208";a="196081405"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Nov 2024 12:45:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7826EE0D1E; Wed, 27 Nov 2024 12:45:36 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E2E90E00B6
	for <cocci@sympa.inria.fr>; Wed, 27 Nov 2024 12:45:34 +0100 (CET)
IronPort-SDR: 6747065e_O6bjMLORDID64TExURzZOrG/HMRZp7PUk1Bl7IyEFtBKyPq
 9t2xyOWFT10sJGyozkWHppbe1ZbANeXPC8N25zQ==
X-IPAS-Result: =?us-ascii?q?A0EbAACFBUdneAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDYnUzBAtIhFaIHYcwgXSEa4c7h1aIdYFWFIFqDwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBIUAAopcAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAFDDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QCAQMjHQEBESYBD?=
 =?us-ascii?q?wsaAhEVAgJWBgEUAQGCfYIwAQMxB7BegTKBAYIMAQEG2lsfLCJXgWQJgRouA?=
 =?us-ascii?q?YVpgmIBhWk7hDwnD4FVRIE8gwM+g3yBBoMcgmmCRIFNg0IlhEaCI4EvaIgVh?=
 =?us-ascii?q?hqCGCiBA4lxUnscA1kyAVUTFwsHBYEpERAsAyJuaU5/gTYogSkBQoEVgTkvG?=
 =?us-ascii?q?yELXIEpfR0UBhUEgQ4FNwo9gkppSzcCDQI2giQkWYJNgSUEBYNpgQuDXmUvA?=
 =?us-ascii?q?wMDA4IQgSuCSV2DCh1AAgELbT03BgMLGwY9oXGDSIFEgjTGDDQHgjiBZYFjD?=
 =?us-ascii?q?J9ZBhMvg3GTUg4GknqIL5BMIqkGgWc6gVwzGiSDNk8DGQ+OIYQtyCZCNTsCB?=
 =?us-ascii?q?wEKAQEDCYVGAQGMFoFLAQE?=
IronPort-PHdr: A9a23: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
 Fg6h1kmCQzM3DLr/ktxOVfA4ic9whFZpA==
IronPort-Data: A9a23:k0a3tKwXxs4VlQDUOAV6t+fhwirEfRIJ4+MujC+fZmUNrF6WrkUCx
 2QZUT+AafaPMWGme990Po6x8k9T78WEndFnQVc9q1hgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjgmQc3l48sfrZ9Eo25quq4Vv0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFPD2q0yBRoZZ7EDufstJ2tt+
 uM1Jz0SO0Xra+KemNpXS8Fpgdk/atbmNsUTtxmMzxmDVKxgG8qcBfyVo4YCtNszrpgm8fL2Q
 sMDaid0KjnEbQdOPFg/F5802uul7pX6W2QA8g3L+vRruwA/yiQv2YfJYNjSZOXSH59ko2upq
 XDY52HAV0Ry2Nu3kmbVqin82YcjhxjTXIsNHbm83uxrhVeJzyoSDgcXXB21u5GRgUm1UNN3M
 F0R4iNorK4o9UXtQMOVYvGjiHuDowJaRNdaVeE3gO2Q9kbKyymAXjQNFREbVMdlqZUQTx8ly
 XKGksy8UFSDr4apYX6a876Vqxa7Ni4UMXIOaEc4oe0tvIOLTGYb0UmnczpzLJNZmOEZDhnc7
 li3QMUWgrIOkYgU2q/98V2vb9OQSnrhHlBdCub/BzzNAuZFiGiNOdfABb/zs60oEWphZgPd1
 EXoYuDHhAz0MbmDlTaWXMIGF6yz6vCOPVX02AE0Rcd9qmT8oiP5JOi8BQ2Swm82Y67onhe2M
 SfuVf95ucQMbBNGkIcsONzqW5hCIVbIT4i7D628giVyjmhZL1PXpHo+OiZ8Lkjsl04riukkN
 P+mnTWEXR4n5VBc5GPuHY81iOd7rghnnD+7bc6hk3yPj+DADFbLEu1tGAXVMYgEAFas+l29H
 yB3bZPSk003vSyXSnW/zLP/2nhUfClhXsGt9Jc/myzqClMOJVzNwsT5mdsJE7GJVYwP/gsR1
 iDtAB1r2xDkiGfZKA6HTHlmZfm9Fdx8tH83d2hkd1qhx3FpM87l4bY9ZqkHW+At1NVi6vpoE
 NgDWcGLWcpURhr9pj8yUJjara5ZTiqNuz6gBSSfXWUAT8ZSfDCRot7AVSnzxRYKFRuy5Jcfo
 aX/9wb1QqgjZgVFDeSNWs2O0mGegHk5s8BxVnvuPdN8VhjN8o9rCiqpld4xAZgGBivizwug9
 TS9IEknt9iWhrQq4vzluLuhrbr1I9BhH0FfIXbX3Yy2OQbe4GCn541KC8SMQhzwS0L2//+ES
 dhO7vShLsACoklGg7B8H5lv06g6wdnl/J1e7wZ8GUT0f0aZMaxhLlaGzPtwmPV0nJEBgjSPW
 2WL5tV+EpeKMpm8EFcueSwUXt7a3vQQwjTv/fA5JXvh3xBO/Z2FbF5zOiedgykMPZp3N4IYm
 d0agvA00DDmqBQWMYehtBt2pkCsNX0LVps1uq4KWLHLjhUZ8XAcQJj+JBKv3rSxRYRtCHQ6G
 h6Vm6vIuJpEzGXgbXcYNCbAzMhdt7s0qTFIy14IGAXQlvGY3c0I/QBj3gk2ai93zRx39f15F
 UY2Fk9yJISIpyxJguoaVU+SOghxPj+r0W2v9Eksi0vYUBOOREHWCX8UYMKh3Rk+3TpHXz55+
 Lq49j7UYQzydpus4hpoCF9XlfPzaPdQqCvAoZmDNOaYFcAYZTHFvPefVVAQoUG6PfJr1Vz1n
 sg0zuNecqahCDUxpZc8AIyk1bg9bhCICWhBYPN59pMyAmDuV2Cu6AeKNnyOVJtBF97S/W+8L
 v5eFMZFehC99SSJ9xQwJ6oHJZ1ql/8IuvsGXJ7WJlA9jrjOlQox7ars9RX/ilQ7HPRos8I2c
 b3Kexy4T2e/uHpzmk32lvdiBFaWW9c/STfH7LiHy9lRT5Mnm8NwQH42yYqx7im0MhM43he6v
 zHjRq7xzs45+7tNgrnDL6RnLCe3IOPVS+6n3l2SsdNPTNWXKubIlVofhWfGNjRsH4k6eopIh
 4XWleXozmbpga0TUV2Fq6KeFqJM29q+bNBXPu3zMnNeuymIA+3o3Dcu5EG6LsZvvO5Gx8z6W
 Ta9VtS8ReQVV/hZ2ndRTSpUSDQZKqbva5bftTGPlOuNBjcdwD74Aouer1GxVl5idwgMJ5HaI
 S33saz35tln8aJ9NCVdDPRiW5JFMFvvXJU9TOLItB6aM3KJh22Tsb6zhDsi7jD2UkO/KvjY2
 q6cZBbCd0WVgprqneFp69k4+lVdCXtmmuA/c34M49M82XjwEGcCKv9bKpkcTI1dlivpzpzje
 TXRdy0YBD7gWShfOwDJiDg5stxz2sRVUjs4GtAow69QQyKxGZ/GH7ZrsCtti5uzlv0P08n/Q
 ezyOFWpVvRy/n2tbfke7Lq3jI+LA9vEk2kQ9xmVf9PaWn4j7HZj6JClNBVAX2rLHqkhUakNy
 XcdHQh5fa1wdaI9/QuMtZKY9NH1cQ4DFwkVUBo=
IronPort-HdrOrdr: A9a23:AUApzq/0sEly+QObmLhuk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re+cjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:S1TsoGGERGdrrg7eqmJI7RZIE5sKKEHGj2qKBUWbBnlER7CKHAo=
X-Talos-MUID: 9a23:A9qqtQrBs2p1RBULDdIez29rC+M44aOwMRhXy6Q7lviLJzJoPg7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,189,1728943200"; 
   d="scan'208";a="102767640"
X-MGA-submission: =?us-ascii?q?MDHz09g4D7273kKvGWi2XCaS3qpu9utvnBJgf6?=
 =?us-ascii?q?ULXUzUxb1nD2YMQ7ea14CrKaUm51G1QXI98kikx80p9IGf6lzl0fftvs?=
 =?us-ascii?q?khAAMcnglTYPGq5T5F17FzQqvUnFuDzWCFiUX3MR25tNPQrjze6QLg1u?=
 =?us-ascii?q?JtjRaq8JQQ9rAYM2fxE7FI6w=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 12:45:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732707919; x=1733312719; i=markus.elfring@web.de;
	bh=wsTkpJ0crrbiKCw//zEGB71MSjoQsz2INPw4o65ZODw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UMmasBpdiKjjnuub+miyWcxiisBtRmQsorQ9Q1IDBk1b/eLv69QnVXvMjUNLpKEH
	 C7r0hlGNMVj2hXu1PSnsJ6qPxbIIPnZi5ppqP0OhrbiLmdbHxehp1oUV1QxmPCgMo
	 RybkAQZG55e+YUx1ND9jzNg91n9zFegTh9aNzUt0ut3PuPzrnGMNmZL2F4ANnxiuO
	 oGRxiJUsJ7Po+V0yM386x6YQvbmfMamAX4BmH0Mj+kEigmxYlVBCPB8cHXGGEjGYN
	 gmnIjqpTGTljUizj9HUaB5eXzrZQU9jdcT01f07DyOhaqADT3blT+IDwuN3xMAvC2
	 4Rvcv07JRFLq3gH/Mg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrOdp-1u0vBA07lv-00lKvI; Wed, 27
 Nov 2024 12:45:19 +0100
Message-ID: <056e599a-f1f3-4ef4-a0d9-04cbe99f198c@web.de>
Date: Wed, 27 Nov 2024 12:45:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 linux-security-module@vger.kernel.org, cocci@inria.fr,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Serge Hallyn <serge@hallyn.com>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
 <20241125104011.36552-11-cgoettsche@seltendoof.de>
Content-Language: en-GB
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>,
 LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241125104011.36552-11-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c3z75ebXs5Vvec51bTijuBJ89sciEkl5vT69C//yxvbWjzQ69bj
 6b2xXMO5j383+Av9ioHLroYrBtP+7cR6EkqAx2WX1bE3Ek126hEo0YbN2n98AGKuHu9cSOo
 BD86XgkY7y10I1YH70J/WzQaFoKcwmbzZfhGYncJWBp7G2E9nseOmODgxfD175nBkJV+Fc4
 OhW4+0CaIDBMKrlezuo2w==
UI-OutboundReport: notjunk:1;M01:P0:EERdwdgsqjs=;tQJriFa/CF00kg9HEyf9Jz2Xzfg
 GEbf7XRlswfFTo92k73LvwyyjuldmWapj2wOkdCfJDf2pQV7blO/e7Tn5Awo/9wDA0Or/awyB
 oaK1p8zNZtwoYgNo7K0eRRLW6+e0ZwyN0Dt3k9PTXbkFepcbh4pO3E6/57K21t9TbmYjXerZR
 Xr62/8itvY/6SN73rueLJZG1w9wSilsyzsTCB0Wb01KKtjYc0iBfmvIVv7y5DYPDmoJCnNV9x
 jFuknWRua9wRYshpPINz2iO8JZHco+c8kyptlQwC0Q+PEDhTjQz7BQwCigFt74ON8p4pR47F+
 RK2nV9Jlz5fGqrP1+yc0Vx79aSrCnsazHyf9IdzQMGieupwbvU25gpFA3mIUTlqebWR3RZxil
 eb+uPL0nGufuv4XbDM8+Xr+xnGG0QVO1jPoUXB6gT1uYYY5JfuIccYU7uJdfe41Qv2wT+EWWz
 Hc3tNJW4uXG4Yk8WcNFNUII8dNnDiJsoGPsRI39jy0mYwD23bTzZ0bxReQgg3pMYZaf1ILHzc
 JmTOM0aNg3dRpgRUPRAagNSUtEAuWkVlNhR6p6NQV9DRNygBxMZuiBf4XDZfVfPdx4Q+4C3vG
 7QNKo76SXHq0lzER7XVha1QnrshPRDVkOdJvHLq2MD+3MVQTejfZtKCXJbodEy/iJpIqB3Gr2
 5a+nfjF7+ObvnemK+Hht0BAXIyWcHck1bOLJPSqJszkGCRDibuLHAH1JY2dLkkT9yXFyzm3Ai
 CQJP3JUrkz5OR4YXaxKiZWPhUojq0J5KUUtyLnzBgldKe9U8rth+ryVwYfKpNaaiern4A6F6y
 tjNW2dbtuDHxT4x3UbdUvbeBg++TvD+dKc7KCJUfpbWrfWjjaipMxBokmqeE8CdsHy7hUH6fg
 mouxJv5LetFST1feBWxFScP+4rDUtbEwMAJh8o/OI3N07zJAnXGbNYwGT
Subject: Re: [cocci] [PATCH 01/11] coccinelle: Add script to reorder
 capable() calls
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2136
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/056e599a-f1f3-4ef4-a0d9-04cbe99f198c%40web.de>

=E2=80=A6
> +++ b/scripts/coccinelle/api/capable_order.cocci
=E2=80=A6
> +@ depends on patch@
> +identifier F =3D { capable, ns_capable, sockopt_ns_capable };
> +binary operator op,op1,op2;
=E2=80=A6
> +-  F@p(EL) op E
> ++  E op F(EL)
=E2=80=A6


You would like to reorder expression parts.
How do you think about to increase the precision for such
an SmPL change specification?

* May only operators be taken into account for which
  the commutative property holds?

* Would you like to support a varying length for the affected
  operator chain (=E2=89=A5 2 operands)?


Regards,
Markus
