Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE90C46CD3
	for <cocci@archiver.kernel.org>; Sun, 24 Dec 2023 16:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vucww3P2rn86OnoZx3quJZipDAxzu9wcZVN9I8hRXg8=;
  b=gQmHpeting1Q3mmGd1pSV8OhWC/hPRjC+FAVH6LeH0hO6XBO8xxNDvcM
   TQNyw+QLGa61pVg2ESSHVDiO1cwh9qmxujn6+peCqmAbSBxjoTC+XHd2t
   oBqlg0qCoVN0S1/Bq3uN1r2/HFkDwKIZVvFn2De48Q541pgNMeiN7opPm
   I=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,301,1695679200"; 
   d="scan'208";a="143935252"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Dec 2023 17:50:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 65E68E0CCE; Sun, 24 Dec 2023 17:50:54 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0E9ACE004E
	for <cocci@sympa.inria.fr>; Sun, 24 Dec 2023 17:50:50 +0100 (CET)
IronPort-SDR: 65886169_XEWMWL/cTIfgytM7y1buZJ4dUiULMlLzAIAeB6hj6OkPtPO
 4uYOW58GSJuJ2PVwPWKp/BL4aXT8k0JSwOoOW1Q==
X-IPAS-Result: =?us-ascii?q?A0FIAAD6YIhlewQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYI4fANTMgQLSIRTg0+NZzCEO48BhGuEBIFWgUA+DwEDAQ0xEAECB?=
 =?us-ascii?q?AEBAwEDOIRHAoc2Ah4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBJBgGDhAnhWwNglwBEIEMgR0BAQEBAQEBAQEBAQEBAQEBAQEBF?=
 =?us-ascii?q?wJHQgMDIwQZAQERJgEPHwEFAiYCAlYGARICAQGCfAGCKgEDMQevMX8zgQGCC?=
 =?us-ascii?q?gEBBoEHrlEfLCJWgWAJgRouAYgaAYVng0F6Jw+BVUSBPAuDNogegmiJHQcyg?=
 =?us-ascii?q?hyDUJFafQVBcBsDBwN/DysHBDAiBgkULSMGUAQoIQkTEkCBXYFSCn4/Dw4Rg?=
 =?us-ascii?q?j4iAgc2NhlIglgVDDQERnUQKgQUF4EObhsSHjcREAUSDQMIdB0CMjwDBQMEM?=
 =?us-ascii?q?wodCyEFVgNFBkkLAwIaBQMDBIEwBQ0aAhAsJwMDEkkCEBQDOwMDBgMKMQMwV?=
 =?us-ascii?q?UQMTwNpHzIJPA8MGgIbHg0nIwIsQgMRBRACFgMkFgQ0EQkLKAMsBjgCEgwGB?=
 =?us-ascii?q?gldJgcPCQQlAwgEAyspAyN0EQMECgMUBwsHXAMZKx1AAgELbT01BgMLGwY+A?=
 =?us-ascii?q?qQQAYI5AXoTgnaiQaJANAeCNIFggWEMihiVEwYTL4VXkU8OBpJULodQkE8gq?=
 =?us-ascii?q?EaBag0mgVwzGiSDNglGAxkPjiA4g3OEHoprAT1ANTsCBwsBAQMJhUYBAYNag?=
 =?us-ascii?q?UYBAQ?=
IronPort-PHdr: A9a23:ndjZ+BDc9sSyDm2REK9VUyQUmkoY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua89ygWTBM6KsrptsKn/jePJYS863d65qncMcZhBBVcuqP49uEgeOvODElDxN/XwbiY3T
 4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx7xKRR6JvjvGo7Vks+7y/2+94fcbglWhzexe61+I
 AuroQnessQanJZpJ7osxBfOvnZHdONayH9yK16Ugxjy+Nq78oR58yRXtfIh9spAXrv/cq8lU
 7FWDykoPn4s6sHzuhbNUQWA5n0HUmULiRVIGBTK7Av7XpjqrCT3sPd21TSAMs33SbA0Ximi7
 7tuRRT1hioLKyI1/WfKgcFrkqlVvAyuqAB+w47MYYGaKvx+fr/GfdgHQWZNR9tdWzBdDo+5a
 YYEEugPMvtCr4TlpFUAoxSxCgexCu3v1DFFmHH20q8m3OouCgzGwBUgEsgSvHjIstn4NqEfW
 v21wqnSyjXDautb1zDn54jScRAhvOqMVq9/f8rVx0kvDQLFjlOfqYf4OD6b0f4Cs3KY7+p9T
 uKjkWEpqwV/oji1x8csjIbJi5kby1/a7ip12ps6KsOhRUN9fNWrH4deuTuAOItqXsMtXXtou
 CAix7AIupO2eDQHxZApyRDfb/GKcYqF7w7sWuuMIjp0mHxrday+ihi880Wt1OPxW8ep3FtOo
 CRInNjBu24O2hHN9MWKTOZ28ES52TuXyQzf9/9ILVoqmabFKZMt2KM8m5oJvUnMBiP7nEr7g
 LWYe0k54OSl6OTqbq/iq5KcMYJ/lx/zMqAzmsykHeQ3LBIOUXWa+eW9yrLu5VH1TbNXhfMsi
 KbZqorVJcEDq665HQBV1oEj5g66DzehzdQYgWMLLVxbdx2clYTmJk/BLOj5Dfe5nVusjC9my
 +7bMrH/GJnBMGbPnbX7cbpg60NQ0gU+wcha551OC7EBJPzzWlX2tNzdFhI3NBa7w/zkCNVgz
 YMSQ22BAquXMKPIsF+I4O0vLvKCZYALoznxMeUq6OD2gX8/glASZbOp0ocPaHCkAvRmJF2Ub
 Wf0jtcbDWgKphY+TPDtiFCaTTFTYGq9UL495jwgE4KnDYLDRpi3j7Cb3Se7GIdWZmFcBVyWH
 3fobdbMZ/BZbCOUP98klTkNTZC/RII7kxKjrgn3z/xgNOWQsikZs4/zkdNx5MXNmhwosz95F
 cKQ1yeKVW4w1mAFXTk72OV9qEp81lCZyoBmjPFCU99e/fVEVkE9L5GYh8V8B8G6YQLMYNyJR
 VClRZ3yCDc9VNMghcQOblh2G9ikjRfr2yusHq9TlrqXCZhy+aXZiTy5DMJ01nrHyeELgksgT
 8IHYWaij7Nz9hWVDYPblUiQv7q3ZaMamiLA6jHHhU+Pt0FRXQo4bbjfRG0Selfb5YD8+l7YV
 qKjFagqGgFI2MqDILFHLNbuiAMCDM3kMpz+bnirmmG/TUKSwbmMRInnYWMQ2GPaEkdS10go4
 XueNQU4Tg2msm6WWCdkEkPjS0Dh6+9zrDW8VEBii0m2Yldmn5mv+wUJgrTISOkSxa4DkCQss
 TN5GBC6xd2AT5K8oAxwNIFdZ98y+lpBnTbFsApsFpW8KKVjilNYeANy6RDAzRJyX6BJi8s3t
 zsHyARoKKSXmAdkfimbwIu2F7nZMGj08ziwZqSQ1lyIg4XewbsG9Plt8warhwquDEd3tiw/i
 7G9slOZ75TOV08JVI7pF10w7158rq3bZS8048XV02dtOO+6qGyKwMonUc0izBvoZNJDKOWcD
 ganNsQABNW1bsEulUKoaB0sI+1YsqI5bIu9b/XT4KewJ657mS6+y2FO4YRzyEWJog91UO3Vx
 NAox/+C3w2IfyjxhhGtv5O/gphKMBcVGGf30i34HMhRa6l1KJ4MEnurKtary89WgpnwRzhH+
 VTlC15uNNaBXx2UYhS92ARR0R9Sunm7gW6jyCQylTg1r62Z1SiIwuL4dRNBNHQZDG9lxUzhJ
 4S5lbV4FAChchQpmR255E3727kTpaJxKHPWSFtJeC6+Jn9rU6+5vL6PK8BV75ZgvSJSWeW6K
 VeUL9y16z4TySD+BC1zwD4hdjelkor0lVp2hSPVLXp+qmbYZdAl3Q3Wt5TXQf9c2CZDRTEt0
 2CNQALmYJ/woJPIxPKh+qikWmmsV4Nea3zuxIKE726g4HFyRAa4h7a1k8HmFg4z1Wn60cNrX
 GPGtkWZAMGj2qKkPOZgZkQtCkX77p8wP4hkkZYrwrwU12IbgJq94ncN12v+e4Y+u+q2fD8WS
 DgHzsSAqi3swk5+NTSkw4zjV3OS6tRsbZ+2bylFv0B1p9APA6CS4rtemCJzqVfttgPdb892m
 TIFwOcv4noX6w0QkDIk1T7VQrUbHE0DeDfpiwzN9Nem6qNeeGeod7G0kkt4h9GoSr+Y8ElQX
 3Pwe5FqGiEVjI03FVvW02DorKzgdsPRa907qRCe1RvNx+RYM5M+kPMWiDEvYzun+yd/lKhi0
 FoylZih9JCKMWBs4L60Dns6fnXuasUf9yusxadSk8CK3py+S5BoGzEFRpztHrqjFDMfs+iiN
 h7bSmRm7C3BRvyGQEnDuyIE5zrVHpumNm+aPiwcxNRmH1yGIVBHxRsTRHM8l4I4EQajwIrgd
 l1473Yf/A2dyFMEx+R2Oh34Smqaqh2vb2J+bZGFLwdNqCxG6V3UN8O28e95WS1VtM7EzkTFO
 imAagJEAHtcEGmNHVP+Jf+D4dfa8u6XLvWzJb3CbP/dzI4WH+fNzpWp3Ix8+j+KPcjaJXhuA
 cow3U9bVGx4EcDUyH0fDjYanCXXY4uHtQ+xr2dp+9un/q2hC2eNrcOfTqFfOtJ191WqjLefY
 qSO0T1hJ28Q14tQlyWRkv5FhgFU0nswMWD3QfNa6EuvBOrRgvMFVUdBLXkpa40RsuRkmVMQc
 c/D1oGvj+Q+1KRqTQ4aEwSmwJ7hZNRWcTvkaxWYXgDSZe7Af2GbhJumBMH0AbxI0LcE7Vvp5
 2vdShKyeGzEzWehVgjzY7sV02fEZloE4N77KlE3ViDiVI60METkdoAty2Rnm/tq2jSQawt+e
 XB9ax8f/ufWtH0FxK8lSioYtSItLPHYyXbDqbCGd9BM6qMtWH48gete5D5SJ6J9yiZCSbQ1n
 SLTqoUruFS6iqyUzSIhVhNSqzFNjYbNvEN4OKyf+IMSEXDDtAkA62mdEXFo75NsF8HvtqZMy
 9POiLO7KTFM9MjR9NcdAM6cIdyOMX4oOx7kUDDOCw5NQTmuPGDZz0tT9ZPavmWStYQ/o4Pwl
 YAmT7hGSBoqG/lcBkkkVN0OLZFrXy81xL6WiMlbgBj25BLVRchcotXGTqfIWK+pcmzGy+AZI
 UdbpNGwZZ4ePYD6xUF4P1xznYCRXlHVQcgIuSp5KAk9vERK9nF6CGw1wUPsLA23sxpxXba5m
 AA7jgxmbKEj7jDpth0SL0DJuTB2vU0/g9TjjhiOfTS3IKr6DuQ0Q2Lk8lM8NJ/2WVM/dQqpg
 UltLyvJXZpUiKZ8M39mgknQtNEcfJwUBb0BaxgWy/aNYvwu2lkJsSSry3hM4u7dAIdjng8nG
 XZNh3dHxh4lc9M/Y6DddvIhJr14ma+E+COlhLhZKOA2OEsHtm+fKndghQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:9Q7C+KMJHI50wMBcThWjsMiBIKoaSvp037Dk7TEUdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFg7X5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YGT0EUMr3N5DZB/KPHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:nxALDG9EhqaBT1U2RZeVvxYWN+AUL0Hx9WmOCheYL39jUqaLE2bFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AhjY7NQ9AyTzM5d7JYpk9QM2Qf+NYvq70MUswqrA?=
 =?us-ascii?q?LhMi+HBVrB2mPgg3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,301,1695679200"; 
   d="scan'208";a="75293473"
X-MGA-submission: =?us-ascii?q?MDHIyd+iu3NWmPA8lK5Rol36r25LDrMCTH5ChF?=
 =?us-ascii?q?x94g5d3OeXw8iTsoBBGguIgTVHznDCbIzKhAqUn1r6YYy9DnL5RMkJ6+?=
 =?us-ascii?q?CEah/CBZPSWKvtpxS0JvR6LAYl7WhLQe1HKoJNZOmkhAA55kfhuMDXsJ?=
 =?us-ascii?q?nzyDqT9hRVKuQq56QWTUY49g=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 17:50:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703436643; x=1704041443; i=markus.elfring@web.de;
	bh=QWfrLn5Mvq6EClrCdDR9YcOT+EUQjWH56hvUXCNkDTo=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=jGND4Y9IkHAqEg8K4v4mIC6aIbTEe1Uas731nInK8zy0ZcCzTY49LdfFIN1go8ZW
	 Abnf5nEK1Ddy0PlNpMcwgr3IbNJcFzHTK1Roj1m+Qn5OHuGVs7uhC0ZW2cV8Xxi7q
	 kRsQmYlV2l07IMjeOaqRx9yXYiIyLG0MfGU4Wz7MMeHxUpz+vu5xyGsnb3cFAqMa3
	 euIAFisPQWRcEKHtGa1irfcEgL31RXDhG4zc8/ZADELBqD2tL0gaE31btDACBWcp4
	 D2iVi9rUlTxuEYZi808tP+FacL1d/N4qQ3F5/FW4pIbR1YqTxJ2cMfVA3xUrVz4+o
	 5kF7eaXVXOqQ4MsKuQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MtyA4-1qypRP30ai-00uSde; Sun, 24
 Dec 2023 17:50:43 +0100
Message-ID: <b11039e4-69c6-4247-b4ba-c442b9427231@web.de>
Date: Sun, 24 Dec 2023 17:50:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Tero Kristo <kristo@kernel.org>,
 Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <20849a8e-e0f5-46df-ad8a-9eae6cbe337b@web.de>
In-Reply-To: <20849a8e-e0f5-46df-ad8a-9eae6cbe337b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/MWeLp3bl5k34XvHfUI/W2lEnDBpqKjkeUU/BEXyT8r+Vr6kXuW
 JYz6AV7/4XrRs/G+WutGLHoSbx3hEdcxD2epWe7JxWXQy84XynjtfQsvXuXobN8Di7EBNIL
 hLQVGXzSJhu3uXEemeWbbf54hrJsAaZb4ualaE/1rrEJJ+pxVgoiRCxqOmeCJevBn5RHYFe
 6WWYY+6KdYDsUZKQ9TvkQ==
UI-OutboundReport: notjunk:1;M01:P0:Hj4f7rq9WDs=;5Np9XTbAJN9ju3o5KWqwGcQaRfV
 FwzOFVEUh3j4f+NVlPqWktWkN2BjHcej/W9EavpqEfF+LehycYYBa3Lamy1GsNyaiKPVTFWKI
 1xDr2+WignlNX1ZZz18UcW5Nsrvx31+vW7I37liaKDaf3GgPtXC32li8fuJhSquJLZ0kRT9hs
 QylzSF/HsxauthrLGkM6fJK0Ob2reR5YPGTPvIZkBr7959ZG9uwgsc3i20fj23jLFQIHuPzYP
 0O0N/kyAtIE3sJyXlrNxG7+JkR70vl9nsnq21VpEMrS9G0zDecO0TDBXSxupJOQkc91YhpCIO
 snE9VEaP2nFlJP6izdvGXotTOqi8vl69htKAuCcoGe8O7d2KqMgfN8HcN3oBTOePTTec/lvPV
 jnkh4n8AxTxD5hHTKnCABwiBkwT8Y4TsKs2pC6407r52AS3YYLyeYdgsXC/vyoYZMxjpNUv79
 sOvoOWYRrO3wTBKBoll04BhVV9TzXruwsq8k3WwUbD6aXArCuVjcpGpw3awTMZAjUgi9CLzsu
 0GP4hIAwy50GUPHSPIKluo9v4w6w9vdwnO4h4U84rgwqFVr8fgmGT+7uqJyXm5EJqm8vZvD7I
 qg4RViMGHVuZt46+pGHa6FvfzRk8uOH86WqqIhXRQ5FHAAtQLdlGftRxoA6sotCT5YVWOw0R9
 Q7lVahjVV4LeyFl+WInH5R/bBBxNQlKo0sXdAqv2wp+KbgbCGAXg55m3B15pwqghhwzY985Bn
 oU9Bkbf8JLjB7QhVmZANidHRQF3k/yW8Zd/Uyx6Pnz8Catp3lNuKkRQxRk95GK/bDVMhgwg9e
 zbaPDIorLQ25DUl13YrPB17nK5bWCv/tRV6Uab726rVrQ4zvjAU85arVBT0aqp2A2lCYy2RC3
 XU3JgEN5bKJEEGYjIzfE7hpgbKFyiZaFH3wDV4HffeaUl0jtLXj2Zsv610tErma89RdfTx58p
 8pH+vQ==
Subject: [cocci] [PATCH 09/10] clk: ti: Less function calls in
 _ti_clkctrl_clk_register() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1377
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/b11039e4-69c6-4247-b4ba-c442b9427231%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 16:06:34 +0100

The kfree() function was called in a few cases by
the of_omap2_apll_setup() function during error handling
even if the passed variable contained a null pointer.

* Split a condition check.

* Adjust jump targets.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/ti/clkctrl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 5a1bd176160c..cdc3cf1ddddf 100644
=2D-- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -296,11 +296,13 @@ _ti_clkctrl_clk_register(struct omap_clkctrl_provide=
r *provider,
 	init.name =3D clkctrl_get_clock_name(node, clkctrl_name, offset, bit,
 					   ti_clk_get_features()->flags &
 					   TI_CLK_CLKCTRL_COMPAT);
+	if (!init.name)
+		return -ENOMEM;

 	clkctrl_clk =3D kzalloc(sizeof(*clkctrl_clk), GFP_KERNEL);
-	if (!init.name || !clkctrl_clk) {
+	if (!clkctrl_clk) {
 		ret =3D -ENOMEM;
-		goto cleanup;
+		goto free_init_name;
 	}

 	clk_hw->init =3D &init;
@@ -324,8 +326,9 @@ _ti_clkctrl_clk_register(struct omap_clkctrl_provider =
*provider,
 	return 0;

 cleanup:
-	kfree(init.name);
 	kfree(clkctrl_clk);
+free_init_name;
+	kfree(init.name);
 	return ret;
 }

=2D-
2.43.0

