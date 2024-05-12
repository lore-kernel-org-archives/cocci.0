Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE04C10F1A
	for <cocci@archiver.kernel.org>; Sun, 12 May 2024 13:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=tSNsJlIMhrJfbKn8dbVBfgFwRGqChGSKECwTs8P00aM=;
  b=Tt3Fc9OHe1s3lYhM90HL4XW7eiPd0Wd+MdOBuJejxOb53qt60xyquNXq
   M9DqOIuZ8ssWxEs5X2YF5cYcUQfLgPyLYziIxqdD+7mTM1pidrUtlW+KL
   4MfzbcXJqaz98jlYcN6QGkS6vAG7Ed2tBvBXnZAXqBC/DlN0qn1R1I3Ee
   8=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="165243884"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 May 2024 15:07:27 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7C1B4E0CCA; Sun, 12 May 2024 15:07:27 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 56AD3E004E
	for <cocci@sympa.inria.fr>; Sun, 12 May 2024 15:07:23 +0200 (CEST)
IronPort-SDR: 6640bf0a_Ht/sn+0cYRLQM04S3RwmixBgkMCP1IRDh0YnJ76hdP8kpm9
 aZvi6v/FZoK7+wCf5fWb9MHkkXys6ZXzd367Ugg==
X-IPAS-Result: =?us-ascii?q?A0H/BgD7vUBmhwwR49RaHgEBCxIMQIFRgkKBAFQzBAtIh?=
 =?us-ascii?q?FaRPTCEO4c5h0+IcYMWPg8BAwENQQECBAEBAwSCC4JqCgKIPQIeBwEENQUNA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFdA2CZ?=
 =?us-ascii?q?wEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBAQECASMdAQERJw8LGgImA?=
 =?us-ascii?q?gJWBgEUAQGCfIIwAQMOIweyaoEygQGCDAEBBtpZHywiV4FjCYEaL4gtAYV8h?=
 =?us-ascii?q?EAnD4FVRIE8glIxPoRDg1uCaZocgh6FNIhnVH0cA1kyAVUTFws+CRYCFgMbF?=
 =?us-ascii?q?AQwDwkLJioGNgISDAYGBlkgFgkEIwMIBAMQNAMgcREDBBoECwd1gXaBNQQTR?=
 =?us-ascii?q?AOBOIl1DIMvgXUphB0IQ2wVg3WBdw5hg1iETmaBJx1AAgELbT01CQsbBiIBH?=
 =?us-ascii?q?aZhg2BYklWyMTQHgjaBYIFhDJ9EBhMvlzgOBpJomGIgqGeBfSKBXDMaJIM2T?=
 =?us-ascii?q?wMZD44hGYQUyy1BNTsCBwsBAQMJhUYBAYNagUgBAQ?=
IronPort-PHdr: A9a23:bVnYuhbezdoDRvPUC/XTV5//LTEb2oqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1g6PB9mBoK8Vw8Pt8IneGkU4oqy9+EgYd5JNUxJXwe43pCcHRPC/NEvgMfTxZDY7F
 skRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCS5bL9oM
 hm7ohvdusYWjIZmN6081gbHrnxUdutZwm9lOUidkxHg6Mmu4ZVt6T5Qu/Uv985BVaX1YaE1R
 qFGATolLm44+tTluQHMQgWT6HQcVH4WkgdTDAje8B76RJbxvTDkued7xSKXINf5TbEwWTSl8
 qdrVBrlgzoJOjIl7G3ajNF7gblFqxy9uRNw34/UYJmUNPVgeKPdYcgaTndFUspISiBNHp+wY
 44JAuEcP+hXspP9qkMNoxWwCgajCv7hxCFGhnH236I1z+svHBra3Aw5Bd8CrGjYoMv3OaoUT
 Ou7zLPIzTLGb/5O3jny8pLIchM8ofGXQLl+fs7RyUc1FwPEiFWQppHuMjSS2OsXqWib7PdgV
 fm1h2AorwFxrCKvxsYqionGnY8UxE7L+j5jzIkoO9K1UUh2asOrH5VMrS+VLZd2Qt88TGFyv
 iY30rwLtICncSQWzJkq2RzSZ+GIfYWK4R/vSeScLDRliH9lZL6xiAq+/0igxODyS8W4zVdHo
 CRLnNfCuH4A1QLe58qBR/Bg/UmhwS6C2x7O5u1aO0w4i7TXJpw7zrItlJcfq1nPEjHulEjyg
 6KabEsp9vWy5+nkZrjqvJuROo9yhwrjLKkuntG/Af8kMgcQRWiV5OW81bz98kDhXLlHiOA9n
 LPDv5DAP8sbo7a0Aw9L3YYn7BayFzKm0NMFnXkbNl5EdgyIgJPzN17TPv/0Ffa/g1Kynzd33
 /3KIKDtDovXInTdjrvsf6xx51NexQYp0NxT+YpYCrQbL/LyXk/xusbYDhg8MwGsxOjoEs991
 oADWWKUGKOXP6fSsVGS5uIuJemMa5QYuTjjJPc+/fLhkGE2lUcbfaayxZQXcmy3Hux6I0WFZ
 nrhmskNHX8QvgUiVOzqlEGCUTlLanmuWKIz+i00CIO9AIfYRoGthaSB0z2hEp1XYGBGEFGMH
 m3ye4WKQfcAcDiSLdN5kjwYSbihTJcs1RW0uw700bVnKu7U9zYZtJLi0dh6/PfTmgso+Tx1C
 cSdyWCNQHtukmMGXT9llJx49G5gzlaKmYxxnPVcEZQH5e5NUw58MZfDxuh+I9H0QAPIONmTH
 hLuSdKtCjAZT9QrwtZIbVwuNc+li0Xm1jCpHqRduriFHp0y/eqI+nHrJNtmjVvC2rMgiVYOX
 cZFc2Gr0P0svzPPDpLExh3K352hcr4RiWuUrD/rJQumuUhZVFU1SqDZRTUEYVOQq93l50TER
 rvoCLI9MwIHx9TRYrBSZIjPilNLDOzmJMyYe3i4zkK5HxWV3fWhaITwemMS9DrQAg4InlNb5
 m6IYDA3HTzpuGfCFHprHFPrbVnr9LxboWm4U1Ry4gWEdUxn2JKq9xRTifHPA+gL0OcivyEs4
 y5xAE7739/SDI+YoBF9eaxHfd4nyFJAyH6fqAF3eJCtR0x7rngZdQk//0bn1hEsT55FjdBvt
 3Qyigx7NaOf1lpFMTKex5H5fLPNeCH0+1i0Zqja10u7sp7e87oT6Pk+t1TovR24Xksk/XJ91
 tBJ0nyarpzUBQsWWJj1Xw457R9/773dZyA84cvT2xgOeeGRuyXBxslvKe8r0BemcP9APanCG
 AKzW8wWCs6yKfA7zkCzZ0FMN+RT+agoesK+IqHfgujxZrkmxW3g1D4UheI1mliB/Cd9VOPSi
 pMMwvXDmxCCSy+5l1C59Mb+hYFDYzgWWGu50yntQoBLNcgQNc4GD3mjJ8qvy5BwnZnoDjR9/
 USgGkhA9cunYxuUYHTi0AcW2Uld8hnF0WOoiid5lT0ktP/V+SXUwPn5MjcDNHRKQmZKklrmZ
 4S5xYN/PgDgf00ikx2r4lz/zq5QqfFkLmXddkxPejD/M2BoVqbYWqOqW8dU89totCxWVL/5e
 lWGUvvmpANc1Sr/HmxYzTR9djewu5y/kQYowG6aKX9yqjLed6QSjV/67cbfWOUX8z4IXih+h
 hHIC1L6M9Th8diPlpjFu/yzTCr7D8cVK3O0i9rf8nLhrWRxSQWyhfWyhsHqHW1YmWfg2t9mW
 D+J5Bfwb4/31rirZOduf01mHlj5uIJxHoBzlJd1hYlFgyFAwM/PojxeziGqa4Y+u+q2dncGS
 D8VzsSA5QHk3BYmNXeV38fiUW3bxMJ9Zt68a2dQ2yQn7skMBr3Hid4M1SZzvFe8qhrcJPZnm
 TJIg94n8n0HmKckvAQ3zyOSKq8fFw9UMGa/8nbAp8D7t6hRaGu1JPKV3VB9gMvnIbWMuABaV
 17md51kESI6vaAdeBrclXb07I/jYtzZa9ke4waVnxn3hO9QMJstl/AOiHkvKSfnsHYi0eJ+k
 Q120MTwot2cM2s0tvHcYFYQJnjvasgU4D2okatOgpPcwdW0Bps4UjxZWZz1UbS3HThUufmvP
 lSLFyAg72eVHqDAFBWTrlhrpTTDHvXJfzmednwe0MknTh6AIkdSxh8ZVnM2k9YwRAWt2dCke
 1xz+zQSoAfxrBcVjOlvMnydGi/W9gKvdytxQ4OUKwBOqFhL4UuMd8eZ66plFiVctPVNtSSrL
 WqWL0RNBGANAQmfAkz7e6Kp/Z/G+vSZAey3K73PZ6+PoKpQTaXAw5XnyYZg8zuWU6fHdnB/E
 /023FZCVnFlCozYnTsIUSkeiyPKaYaSuh69/iR9qs33/u7sXUrj4o6GCr0aNtsKmVj+maCYK
 +uZnzp0Mx5d0Y4Qg2DFwv4T0R9aii1jcSWsDaVVtSPJS/G1+OcfBBoaZiVvccpQuvhlhE8XY
 5Gd04yzj+Qr65x9Q01IXlHghMyzMMkDImXmcUjCGF7OL7OeYzvC38DwZ6q4D7xWluRd8ROq6
 lP5WwfuOCqOkz7xWlWhK+ZJ2Wu+NQZdpZr7XxJjE2nlQ/r5Zxf9PNI93lhUifUkw2jHM2IRK
 202a0RWsriZ9j9VmN16HHFdqGVoJ6+IlmzKiouQYoZTuvxtDCNukutc63lv0LpZ4hZPQ/ltk
 TfTpNpjy7lDuvaCwHxrXUgWwt6krJ2GtwNuNPeAnnGhcXPD4Q5L8miaTRgH9YMNNw==
IronPort-Data: A9a23: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
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:KgXIaqBdgDYT8HTlHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: =?us-ascii?q?9a23=3AyVrUyWsJieUXxja6+tvTpzRh6IsKcGX6wirXc3a?=
 =?us-ascii?q?eDFRgT+SXWWW04v9dxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ASzcj3g0l7KP/YFNQbSSzDQkaCzUjyIOlUmIri5I?=
 =?us-ascii?q?94JeUCCp9BzWhljKda9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="86803005"
X-MGA-submission: =?us-ascii?q?MDGqoWXGtLqMTC8tIIpoD5kCXFL38Ln+fnim1g?=
 =?us-ascii?q?SP9QcJENA14DVWUS1l442pp/M99jEQMyf8PrVL0smSlFS5f6fcgjI3rV?=
 =?us-ascii?q?tVPvjgxgEuWaH/3Z81G16ch/IXCIkFSdNUZwYkmtRXYNFKgvYX0DMMGf?=
 =?us-ascii?q?qeLFfcLwV49qFV96RRqWqfNg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 15:07:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715519241; x=1716124041; i=markus.elfring@web.de;
	bh=tSNsJlIMhrJfbKn8dbVBfgFwRGqChGSKECwTs8P00aM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qe6E460cljFOA4LTb1cq2Mu28n/kAZBJ/3tApUt157SmpwzJ7QYk92STztCA9FR7
	 vACxPKhfuMel6XH35/g+Nph3Z8zGbMzLrHVXqkwxBOoDPUmX+krpRL/4u5vspDF/n
	 1e/Ny9qzmsSaTKBvL1QWmCrXC+MCodRejkwm/c6aF5r9mOi+m+Wvrdwp4tuvxZcF6
	 vHli6k9Uh7qTFXpyg2n4j4I8dkRa09xuOCdHylm/U5H7/sobCBff/bdmDgdJ4gQGe
	 mb1omKJQ4tRHStNp8hpevxWurg9gRERo+GuPN+23YfW+7Q9FGm7f5ZkbcunT/nuCy
	 1eyzvEiM8HakJgX8Ag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXocY-1s531J0jW8-00YD2O; Sun, 12
 May 2024 15:07:21 +0200
Message-ID: <ac848508-8b0f-418a-a2b0-45cd68176d7c@web.de>
Date: Sun, 12 May 2024 15:07:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
 <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr>
 <6f5533b1-cbf8-421e-8d7d-8435aa28b360@web.de>
 <alpine.DEB.2.22.394.2405111803140.14453@hadrien>
 <c26d41ba-7d55-402b-92a0-5c3d4112893a@web.de>
 <alpine.DEB.2.22.394.2405120932360.6747@hadrien>
 <ac4b8c84-abb1-496b-9377-4f47c1f7cbb0@web.de>
 <alpine.DEB.2.22.394.2405121451530.6747@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2405121451530.6747@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Nw+alooZozyw1YHQlFOSC9UTbfUk1i03G0yVq5JyisDIPkZkE7V
 4/O862+PVeeDzPvmCYOWd9X2YqExbr4XR2LcQlNbXtoeIF25LFLxsOs8GiJUYMzOssdp8KV
 Ljp9yYvu/y938IBV4jzSI47FnSF+eAa2V8EOUPDk1AY68n716tWFM45wymI/NCnHhcAYWyB
 NqXZPt9Yc6U3ndSpGgjJA==
UI-OutboundReport: notjunk:1;M01:P0:Pxjryzh3oUs=;qZXKrKWxIi9AJb1bcm8zggZvVat
 pxKhkwQ/r+Eyv54h4Cp+tR8IGyE7l7sCn0pJHn+WJN1eQbwKsKGXoUDjX7CX2GqM5B4VtBycd
 UU687y2elUpOI/2Cr8+wF8SJQwoSAeivBGQy+1vKk0pNaCGKTw0yoJJWW6VLhap+cVfYtMqEk
 qf/opYRrJQqh0h/T3qy1tUifyZwjmd+PSnfbcSqKFsZjL4BPPSdiFoLS3t5dtmguhFD3PHh5W
 RO0RTOhTMTCsRaBxBaywgD6Ep3dzXaB6glMbVXfj3hddJr39Z9WqchR2EcGnlIf5I08WF4MhI
 +EUEbjaFUjYRAnpcV789k0L0LaQPGKId0NxoxLbamIKskXwpTOELaM64oDW3I3UrvLUzNM8G/
 rduqQwL5+GiFr0iFFXLsv21HzNCJGk9XMLgxacJCbdTxDoX4PISzbPrGjryXgSZJ4AE20ifp+
 sVx33xH9cAdEngeqat1qfRTq/IqvtvGHr+zZMFR3DBJXalFPsdqnjWUyCtgfYtccJta8Ox2nZ
 82EypDHE6GswfZZ52EiR4COrrqn5QXoMRsZsUWZ4Bd5+m2d9+ghXUHqIcQIGrPGoE+GvWbKkR
 IVd9Q89N4CnXXj5zIDReFWMdTceOY9KGfKi6a3psfwrtdY+kzVuIyR8y7FzcBrRsgdQIfb5IX
 9o+r0RFFBGmoSnLKcFN6vt3z+Iy8xR925fUdAvqrNjwFAvB+vji37TM6EeMfQ5QifrV9NWDM+
 +kkBzg04/S+7FX0snJnVe9jWL+VV6dfODCF/oBdW8G9fMciR9F0Sj0x4gbuhxcmMWS5m/3oLz
 gLnBJeEWc5v+gamlTtNW2FAEZb7tk0s0pxAaEXJMeOKiQ=
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1731
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/ac848508-8b0f-418a-a2b0-45cd68176d7c%40web.de>

>>> Probably you should start with ... when !=3D my_action(...) to be sure=
 to
>>> get the first one.
>>
>> Should any SmPL search item which is specified at the beginning of
>> an SmPL rule be handled by the Coccinelle software as the first source
>> code filter also without an extra when constraint?
>
> No.  Surely you don't want that.  If you ask to replace all X's by Y,
> then you normally want to replace all of them.

Such a transformation depends on context code which should be replaced fin=
ally.


>> Can it be checked if such a primary condition is really evaluated
>> in the desired order?
>
> No idea what this means.  "desired order" is just something that exists =
in
> the head of the person who wrote the rule.  Coccinelle doesn't know that=
.

I am trying out to determine once more if the presented use case can work
also without an extra when constraint.

The following SmPL script variant can generate a reasonable diff output
for a test case.


@adjustment@
@@
 ... when !=3D my_action(...)
 my_action(
-          ...
+          0
          );
 <+... when any
-my_action(...);
 ...+>


But I find the shown duplication of SmPL code questionable and therefore i=
mprovable.

Regards,
Markus
