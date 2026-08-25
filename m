Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76ADC5DF97
	for <cocci@archiver.kernel.org>; Wed, 26 Aug 2026 10:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=WFJmJ2IMQ4i2jbxq+srgTPfcro6aedZSu+qPbgnIiCI=;
  b=lEaRFgls4nJJDzmDfqG2KlG/tGaZVR7zW/iUeWVEcwIl9RiCnHGaz9Fr
   VxzVjYkjLYIVbC3kFTs9HY6RnsfgkdM9HZP4B3TubYnMiGhF/pMGQQbFb
   gseqDTTER6sTqb0WrA4Z+FYiLS5xByTXAT01BmzYm5nmSWIXKsLvLPKkz
   A=;
X-CSE-ConnectionGUID: Us3h6zMFSiecSc+cQ1FQIw==
X-CSE-MsgGUID: BSmGBrAJR+61V1ECMbHg2A==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,244,1779141600"; 
   d="scan'208";a="291620387"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Aug 2026 12:57:38 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id A3F0F804F3; Wed, 26 Aug 2026 12:57:38 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 95D7880E85
	for <cocci@sympa.inria.fr>; Tue, 25 Aug 2026 21:28:08 +0200 (CEST)
X-CSE-ConnectionGUID: QjhoBqvxSyGpy26kOiDLWg==
X-CSE-MsgGUID: hcwB2+TFSLC5BPy/XB1pUQ==
IronPort-SDR: 6a8decb8_VGnIwMUbsaFKBFixF2EM1I7ZNQp5GqW7p/mwzQe3aq1+/Do
 l+Xr4xO5+nesF27ZWntIjhYvZqpbw1C+DZaMR8g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0G6AQAV7I1qgAwR49RaHgEBCxIMggULgkGBaDQEC0mEW?=
 =?us-ascii?q?I9SgiSEO4c8h1WIeoFVgXwCDwEDAQ1OAQIEAQEBAgSCC4JzAo1tAh4HAQQwC?=
 =?us-ascii?q?Q4BAgQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQE7Bw47h?=
 =?us-ascii?q?k8NgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJw8LGgIYDgICV?=
 =?us-ascii?q?gYBFAEBgn6CIwEGEAEDECcHv3iBMoEBggwBAQbaaR8sIl2BaQmBHy6FcYJtA?=
 =?us-ascii?q?YYzhEEnD4FVRIE8C4JIMT6EQ4NbgmqCJoEMk2JSeBwDWSwBVRMXCwcFgSNDA?=
 =?us-ascii?q?yovLSNLBS0dgSMhHRcXHlgbBgUSICpBRCMDPoEZQQKBdT8jGTZ8gQlegSspY?=
 =?us-ascii?q?QIQF0YuFYIHAoJagScCXAIBSUMOB0c+C209NwkLGQQ9j2Efhk3GMzQHgjmBa?=
 =?us-ascii?q?IFmDJ9vBhMvg3EBk2EOkwuZCCOpIIFoOoFcMxokgzZQAxkPjiGENctoRTI9A?=
 =?us-ascii?q?gcCBw4DC4VEAQGMVoFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:tsrSDq7kp9MmzgiNkwPXwO/XdLJyesId70hD6qkRc20vTiX8ra
 vFoB11737JYVoqNE3I4OrhBEDYewK+yXcX2/hyAV7BZnifhILAFugLgLcKpQeQfhEWndQy6U
 4PScdDIey1IFR+jdn3+xnQKadG/DArytHPuQ6b9QYVcSh6L6Vt9R1wBAq4Hl0efngjOaYE
X-Talos-CUID: =?us-ascii?q?9a23=3A/Zx0QWv+sJ39Prj72oNJl18E6IsccH3a5m7OM3S?=
 =?us-ascii?q?pJn54EuOWbl683Jxrxp8=3D?=
X-Talos-MUID: 9a23:dvME7wapY7Uy7uBTtzTzrmshCOlTx4/zIngc1qUs4tG5DHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,243,1779141600"; 
   d="scan'208";a="291523277"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEWDPwE6fNtkhZvpU1EvnRmN1lRKWhTkrX696?=
 =?us-ascii?q?5bIc7DZHn0lCCSOqKlMoFYkkZiGD9N4c4aDlVCtIbKr5BcEoHPyaLWmS?=
 =?us-ascii?q?6x/zpe7BlsaEK2IVKGrN/mBKh5thl+Td8wzFEy8+Q3IiutSGN91CdUzA?=
 =?us-ascii?q?Pc5pk/TbyPagFOdRcpR0nrEw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 21:27:52 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFrxl-1x95wW3BLL-00CKsW; Tue, 25
 Aug 2026 21:27:51 +0200
Message-ID: <f19beace-2981-47c6-91ea-d2332a8acbd7@web.de>
Date: Tue, 25 Aug 2026 21:27:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <228c50a2-bb15-4abe-bef9-b0f9b95f6992@web.de>
 <7cea8a1d-31ad-4475-be80-ef1cb1e3b2d1@web.de>
 <5c799ed5-7f3b-4b24-bce6-05a4c5bf7bcc@web.de>
 <16cb39e5-999b-aa-3123-3f45cfe44cdb@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <16cb39e5-999b-aa-3123-3f45cfe44cdb@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aKdwUOHyCG7yi1YjUZp521W651EDhi60GB8CVcQ+qpghKb2dNUk
 p3KAvrp1O9K1nDR/lZKFQ946x6wdzmhYi74GWicenMOH69UM9Nw01C2TZv558d9XJW+yv2D
 K8dEs441nqc+vBeC94RyqsZgV/V0e9J0N+egKl3Di8TQoMU1nH7NtGbffk9Qa6EGp9wVFYD
 NXJVQ2dhKkKaUhFLROPKA==
UI-OutboundReport: notjunk:1;M01:P0:b2tH+DihRJQ=;xS6L2tDLFCokg64pfyabm5G38Z6
 /V22fFUTAZmIG2YfwKqGj2yG8OnVmh6cQmRuvx/SuT/PoHBdQvUz2/ru1inPvqUNF3EkglJ7L
 MiAzfDUWdFixCeRYN5uOq/tlczCGEIkXCGquTe15ge4a/wqNiS9FVDvAdpVd2VUak5D/oolK4
 vXMWtY34XIHSb/UuEz1l9Wz6bOYC/dsPi3gPTqCyM49gTiYK4KHF2D0rqfkfOr/fkxpoZ/65E
 tT05sUIMh9n8hnos/wlAWV3fTJLj/Em/XqOSD+S2r1DdGCnPqfkQVXOStFfCFXX4TDf8L412k
 mIiVgDgmERrrLYBro+A7PnE2ShUNJ34ybjKftBTyDJTN1tlzZzhkxEeU2KjkFAfyFYPMEFQLa
 GZxgBGMDiTnbZXLwlihMxbtfcKrUtv3IJYfjg1sg5osJcE2dnK9Z4JS9vkChjuIxIKKv/AJgb
 GEQHAmjrbafR6tjaHHd6S5MLGgG7yyDa1G0nCzwFFmLtCJxMfOg5Px+KJi5aJB3LfoQm9ADvO
 oyARc0q6qdTIks9wm8JTKCZrAajCIg/HG3sTyVLontJv8xEOo+g1HYAyMFR553qiWplSlSaLP
 mVQCsIOp6TSkPSrNxBTpeKcJgT7dNwbQU2Ms3m9Jbmi6LLAIxiEhXqvfOlNqOeg7nIZ0H5sVa
 m6l9qHrWv4PepCeGTFjGhXrKAu8iF2hT5MkDCqNuWyc5pJyAtJbL+DB2j+I0Ji46bXcHAl0Yu
 9p/BueZF/Zu9ObmaGllghEmwUSNmXaDvQHC1peM43oAvO1tuIq19j9yShhx6hYdG2dTsJWYHm
 amoRVB4hR6VLQ7WiMb2jCM4NVyq+ISsE95/NMeiEs5nMK2sumluGVAVr2ruZakE6GYWWHTbCH
 k+/CNXdDcbnHhb5vM9y6ciJE/dCEl6dCQ0pcOxy2x0tskP1YGHLGqtaPEPdB7OuZ01QWTNRGf
 XaLpEOhnTRKXMibvHPmB+Fb4uEbAlTdByaCxXRL/WWEhyuyT6u17DTNsHKAcuIM4PSetuDG3j
 JLmkgJGsb4EREPtGY2UTlMFsqT0BSRacK5bEgaRQUfv8tsAtH760IRS1Q62wHFGbCqMzB4+0k
 Z2H08/DEMmCi2L+AS1GyBgaJhdnhIa9vX6GJh7oBtQfv2VSMMn/GsZ//btsmXr8EcmuRbe8vw
 KtJHFSbY2j5Mb2RXV7wDenZNNFQ4uEPTvNRyZ/ywwn+Ingz3Q2TqnAg+Gpwz64stRxVhMEU/S
 PWMzCzMmx0eNY1wkjLKYdF9Zxs7AKNLxX0FI4T96I9IaeTXKE/40TqCZ5VG1v+HACMpWhnmGM
 SifNC/VsHbdUiEkstdYCuDRmYwSIPP761kQ8szs8di1IphYqrjXbmPYyJzkw6dkF81k6880DP
 y14IeniEqpBEaAF4WByKfCpwOSicNnsWE5BbY2L/SoPSqjypLXkHNpS3P97/hqKxpLZFg7FU5
 fw9z/1Y5pGiIdlGBGg+WpKR0YVbVGkH/uKRSekUJ9/hHbqj4ujXQf5jl+xWsgj6H2zhIHFa4E
 /caLrnzSzCwTigVRY7ORxWg3LZLSriJScVnxjFu/81iFDXiQ/VK/NiXca+gJTZO6fzAxvj5tS
 1Hzal3IOXOpbxW2Era5uqciJrqThWIrZ0fu1eSK2h5K/7TIIimn1K0IP6VSKVK//lvU+9gdGm
 /xrTTKja57ridmwgQBAvJnYyKPzXes9Bq+kf1a7Wceag7BEsspKbYoK3ADeEc3Mdtpa0aF0JN
 YxP+5Z6c/E1c8VY+C4HeLeA7/pJIOb5LkZY5+8bdc+5HtP3Q9u7NqdsNxr/59CrsX6/OVFhZw
 ej3oaH5H5Bm30pn5/Driu4JAA4YA+bb76MtDCnZKptKqzFVxQZRHV1wQyowdlx371qEpYRS4w
 eh3npLrPJMIuBY9Rrc2DkBYNa0dSwgFEjArzfmTmxZTIMDaffI45UFuucVuotkFO0cjASXd95
 XblRUXltVDYoUW9CthxECV9iir9z1M3gKx7X9tt77bvhGXh4/ldKgblw5Rzzo2MVAD8Fl8bXz
 /G946tkyG7XLLi9dX73ZYIfkilfPnBiqd4gvM6dQSs67/+QwoGP6Yl2KaYhsYdAeVDxHmAvkG
 JWt/7mgp2u7jKQ4+YIWZ/EmVcBbnIe63v+KUCZEP/+6byMHJPTriuxxdqbg/Z4mlSNtt00iUj
 HVgxSnDZ2jxJOCsxf/9yS9SL2a+TKYWiNg58dFbGktMZo5FYhZgmNDMjflBrfNxHdJem6inb/
 WmpYNIWOMv7/V6QLdpa8pD/+gTqXxFzYcMH3YAPqumuauoicKvcP8isDIC1hQ4HrPaOkehPiY
 P0IXfP0x59/m8W5soDac7WNR6I7jSKlvY2j+oF2qKpERilbRcVHz+IhCpIfIccGrMTewPhSoW
 2yi3Hie1LT5OYsLbYrWBhY6TBd6XAE55JR6Y4gHWZ4zwi2L8deDdaXTQb7u4Lan7gR/3OKPeJ
 L0IKRonNo4lSawkBPrHNNuPKdJ7rCk3uEdPxrcFWU/1Wyfh3RgkV55EaLNemQfBzUbDxk16uZ
 upAwvQcHN42qHl6sAAyqZIQLvh5E3q/01ZVnmev4uX3qjog8WqziNr+pK8OPORIPnpl4hp3C0
 FcWY0RF1NLWfHwdt9d1kLP6ke6RDUaVkUKgeuP8ZHUqSdrWLrLoccQ7s54Fl99iUVx1WqPzl3
 YhIOkeUy4q3QKzRhAXt2UrJ0RTQ6FraE+QycvL1CrhhYTyu8SMB0LQ9XdJlkHN6Q+nXEyzr/2
 kj3Q0LKGJDm/FBdEraA3cY62dbqzLY4ppTKGe/ZzOZfdUvuOjpMhF5VCpWksfl4CJt75QbNgJ
 qBj89T8MQWLhDPi/q4xW4u/S+w4OzyLMl0mCoxI2JKWjtYWDCw8hY19eDgBEM2AWQdRod5rPe
 NY49hBewzkmh+Xv9aW5/6dZK65bMTk5xAZa7Nu8xofknQ1DN+GUvYHRqFjBPu0F+WbXoZHa1p
 HTyvvvH09trRUxy5glYoOxI0Je3gROUBSmiXpNU3QjVRXUTR/0IiCP0XQcQtUhQjkJ+vcpUM8
 lUhRT8KXJn4DPWy+YuC4W3nl/qLsJfqNnPHVpjhO5TtH77M6vYQyqqf/VZ17lCf+QswbkYtsY
 9NpbCmpycEPTOnzZe9bwPsZ8HjXdPD3bvZJqNiqO776W4OIcaXJl8OXOQIxZWCQP2cJglYGaj
 fRYyuzz7yjfwIeV+YktNoVhV52UGc1lHNbzcmFyH0Tt64luDtz+cBjpz/Og34lIdbBum4o8Mr
 /DdOrRAWGEVsPU/rstyZalTSASxbkKR1Qclm1DcR5paV+gMzBppq0nAqtUq/9P3zrmIICH5qs
 hA0w5DS1oj1aHIogcDCjxNZZJg12ui9OsLmXJKsXmChe6+5ReUPDFszELm5i6O++xBpODecGL
 I92eQJ0MJKe9EUA9gMDU1v8UoRxIl4GZAFFdQJmUwYkaPP0SIDa/HB1745a1SPMh0Dzse3CE2
 ZG6WCImuxSnbuR7aKMIN2nEdugh3cdLrs/6mQEVn0HP7GJKaoSnecdH2H+7pA3OeCvdCdvTpu
 QUsfrNTie6zoREqECArY9on3B6ihPugOeEU6Z4HKetCTNvxa5FrVM72V1UHa6BEhqaLG7uA+h
 GFIuL1TAYAprYZc8qWIPhpq9EdObfsEl/8rA7jz0Js8lZu5PIqsGq/7FT48OwbAjDQx+Q3IH3
 d6k7D7bDeKRRcp/88xejqgABDara+nb29r3pjjAzol+h38ngVS3SE8LMG+wkd3Yd6r6F1xLSf
 Fa1u+PDD2TfybTbKEsntgWz6iDIMnf66nW9oDQD7mI9c3uNi2SgsZASdMJ2HqSCewWcXVyF95
 UCihmDIolgrHuiHbMHXweHTLaIl2PwWata8wEvFbVKnlsOmbZsBr1tBcD0hJL+joy7C86hGFh
 ZgLy9zMi03J0EVQ/56WzdhXpne3ePXnIAonnj0zYMjD68kwFUgSQfEMOhrROzmsdPSwmGyY1W
 YJc0iuqF1KEEXhwvuSVqIr+sBrqdeBYwZ4yYa4bMVdX13oxgWQ7gg+i4xnDsxRZDqmX+Eh6Yb
 AbXpAebVzCtkroSUTaGu1Ng0mGl6A1UW1m+fn8EIaZV59oc+SqJfZ1U4PFF5G4VIxDiqWxpZz
 1zrrhv9QQ2dwIFKG1nDu0F7YtSOidZDoIh6r6zTI+j5sULkkFdwoI2ZALNFhXXUOxKBpoGYjE
 OzkISk6ukLlWS5ur85HnGotBtgbAtdFtk4C6YTuAjRWMOsPQQGIX5u374AW4EaraVc5cpHWH/
 OvhlGs0qlrZ6YhiVyyte4smK5qexWUg/N6mNxmp7LJ2fj3Qjn9zS6gyrp71evBoUzVoFN5izJ
 wnmY4XSFohxOKd1qH5Ky1w9FEM1zzU6RS2N0a9b6Cwdu3ZjC2wmpDdInY+QbZV5kCoxaIXbFt
 t8sUo7hvzoq/wNAn18WBfqfwFCqNrzU6NdR8uW/8wd7UBpG0nnNq1ugVwfAIfUTKABWA+a+2C
 M8n3LWuTKEcZsRflyWAkzXdKbVLlCIWPnwbGMTttP/UT8q+BaPk9e4aV1um/zTAKlkFnnxGjc
 iwrFq6Zyu6YFnQoQqDYyJN2N7m3pKra3mDVt4V6DMfzOzS8aSNkNviKPTZqkpRitUKhQRu3NN
 0WJzW/W7aonGF+Ou+jdo/MfcktjV0pZ41JHXcOScw6Ky9TwBdCIG0RpdzYB8n5xZ7V+4jAms/
 jp8mDaKS6mw/uopV6e9Tb5/YYS/BdpFhxqRB06Mj5qoARUhCf7UL8yVidQcWn/jt2z4FfNlRw
 aJ43USE0XoudBugTk5EqTK8v0WOTpeAh1zkjUsNVl8J3FEMWtPPAOGmHt4jMRZAsnSqYJkUCx
 Cx3rPKkG1Av37t5aBiYdlscpji/xuF2B2Pvj9je74WJ7ndThRtBGCFltMddsCo8Zgok2+XZiZ
 NL5ZEc2ZtXhScz3CTQWvb32OPwAYJI5/9VAXu1nYyc9P1SV8NLrMIYD2bqScfEoSqW8M/2d+u
 BCseeYVkW7ga0tz49+SUghbGBze4y6+xX5gSCbNHfnz3lAAC6pAkzLTfqjX/Sb62jth639oRD
 V+QGfIUUXMDnABnBhlODdaqdHGtyZOrCZjP/w/J/hOyY5VFsDCo96mAawS1Q1E7IkkmkIWYcF
 jUqKCTSkDlKrnv5+Z6/hhYqPFA5F8zv+VNlJlgklMtTk+W+1F/nt5whnp9Gf0oUIJK3u16Lz2
 boPLVqnn8Iz5tbRiqIoiLZLF84WCUJkbII+gCkk7+8Mfv8eG25JvZSwwavDb1nDO3DhZ4ctO/
 ntUzMTY7XkbtGj79YE3DLrElwkULw+aJ/33IfugtWzK7Kcl1JKyKoeGFbFoz5OXuiT7OPaFwh
 p6hYrySxPf1JguuwLa32Zlm8p7wj0R1c+eGVqGR4MwzNZpHL9VxXHUfdLDFeCuyRBZZGr2dlU
 VnRFHjAWLf6/xZF9xfxUd0ss7zaDJGTqiUZze37hVFIweasG8qHA3ARp7utp5nYX0BFVaAWvh
 wQ7ZQ8bF/KRs0WvYicd1eb636WC8Rd9v2WLUvlXQk/omJM9GnBLe7j1VK2wS9ON29oHXNvb4F
 l01Hieoib2lCo75FHcKTTTABzF5/sF5Q1ssqcXX8TlBfMtPOpMwfH2TadblrVYNUEsueO4L19
 eoYAtq62msb/DtRcDFUaaWoj6Xwmf4KGCyNXwdNH3J4CO2JrZ0GUSdk4y41yvFOMj5rZ+mupy
 vLr0GLg5+fL1glj/fuFEmx5EAQghpDSnqr4inMPurygrf6KcOBR/PvX80WPUV8/fh5Ge/upWU
 jLcaregrivCzo/m0u7rUpybXVf7znvKc9NSkvFgaMj5r1qTZK+UxgYmIUHaDNH1fVFTtesgaP
 cHima4MzPK2Fm1AgYMhDtw69PllowsvQdgpVMlvqVgOwAB+TmrBaAUDF3h1BMMrM0s8GXDNL/
 7qGygJUIuUCFH624yGIHVjhkcAWGmS3LYz/T4vr+2JPUMAklCEGwhQpc4F+nucQ2qLRAjQzIM
 HSndkdRnWElP1F0qdvKs68rJtTZLcFAVhr1wnfLl9A/JLoeDWz8qUKjgiW0vRLvJTWIHybl8A
 +Hlf/xKp4kFDON33OxYiUuXTkQR2p8UkU8cvm12SrSI7c/d7egTe5Z7bVyJ22sqc8k1d0Mijl
 A0Qv8FhUNK7q5Ixn1BCiakr5Xtl7O5T+PsaJgC3l3uISJczHZ9HER4oXq0aYyF8voyB03f6v6
 DeMv30mfdNkUasEb3sXRJt7LoPj396S6Eg6FwEd4v9O+zjSH1zLFA3hzKLlenU3bzLrQBFYE4
 91sdA31O0B7+k8yfz0OIv+madgVCruW1EdPH3NOoQuofchfGS8rLNYylSqG8q1wybN0afIDwp
 gjuwD699I6oTeg93NLThZhSehp7DvltPsfIBlKtS4JUa/s+CGqw+D29kH/CFFaMfIJN1B/oyN
 LxZZ0fekwz+E8WpZkutb5hEK3pm+XHhibgUiL9dLtkEvHPch0WQg4zs04pAaIY778OVAv49YF
 wEDjJs6qKisdE+uMg==
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Avoiding duplicate elements in SmPL disjunctions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3712
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/N3yao_7TVV3u9UdIoENj4w>

>> Can a command like =E2=80=9C`spatch --parse-cocci --sp '! 2' | sort | u=
niq -c -d`=E2=80=9D
>> trigger further test considerations according to Coccinelle 1.3.1 and 1=
.3.2?
>>
>> Questionable test result:
>> =E2=80=A6
>>       5
>>       3 @@
>>       8 |
>=20
> I have no idea what this means.
Would any more software users dare to retry mentioned test commands?

Regards,
Markus
