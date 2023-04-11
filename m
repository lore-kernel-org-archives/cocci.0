Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C082EC76196
	for <cocci@archiver.kernel.org>; Tue, 11 Apr 2023 13:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=knUBK16JTi7GaC2XqZVg6agpJlzeFqOmJRQQswq/l8E=;
  b=BDN4sBQPOZ/o8zpsqX5YvIj9lXnyUqtXVynFPT1UyjxrGliD+oWqzaTk
   iYMf4KG3SqaK1S+CglNrs3xJbHVtO13IpWGIux1JGA8zKCcb3lBHCB3QU
   VILWhmz7QmUoI+MBcuyzyJCl02NulzXZw+rMcnfYXCPqOhHsAmDGYrOmo
   4=;
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
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="102455352"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Apr 2023 15:50:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 31D76E7314; Tue, 11 Apr 2023 15:50:31 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 12607E72F8
	for <cocci@sympa.inria.fr>; Tue, 11 Apr 2023 15:50:29 +0200 (CEST)
IronPort-SDR: 643565a4_WjHRT9dtKCIMbWYywJMnWmX+Z8CouukPyiN8l4VCfb2vVii
 ghjvphaLGycTHylrQLn8HVgntC9EM+m76Krctdw==
X-IPAS-Result: =?us-ascii?q?A0EdAAB7ZDVkhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIHokPA4Qwhy6MJoQDgVaBQD4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEOIFTgnQChT0CHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQFAQIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEgJHPgMDIwQZAQERJgEPHwYCHwcCAlcGAQwGAgEBgnqCKAEDMQesX?=
 =?us-ascii?q?38zgQGCCAEBBpwLHywiVIFeCYEULQGNCYM2eicPgVVEgRUnDIJHbogfgmeRY?=
 =?us-ascii?q?4hLCoE0doEgDoE9gQQCCQIRa4EQCGaBeUACDWQLDnGBSWNMgXsEAhQ6JQQOA?=
 =?us-ascii?q?xkrHUACAQs7Oj81BgMLHwZYawIJIxETBQMLFSpHBAg4Bhs0EQIIDxIPLEQOQ?=
 =?us-ascii?q?jczEwZcASkLDhEDT4FHBIENfAoGASYknXlyAVI7TIIdDZI7JrBVNAeCK4FWg?=
 =?us-ascii?q?VkMnw0GEy+XCQ4GkiUuhzAtj2ggp3+BYzqBXDMaJIM2TwMZD44gGR6Dbo8JA?=
 =?us-ascii?q?T4/ND0CBwEKAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23:HzKZaBE3/z56fMrsiNeZcJ1Gf0NBhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k30RmTDdmQtaIMotGVmp6jcFRI2YyGvnEGfc4EfD4+ouJSoTYdBtWYA1bwNv/gYn9yN
 s1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgppPOT1HZPZg9iq2+yo9JDffQVFiCCjbb5xI
 xi6ogTcu8oLioZ+N6g9zQfErXRPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q
 6VAADspL2466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUjms8
 6tnVBnlgzocOjUn7G/YlNB/jKNDoBKguRN/xZLUYJqIP/Z6Z6/RYM8WSXZEUstXSidPAJ6zb
 5EXAuQCM+hXoIfyqUYOoxWgGwSsCuHgxSNHiHLtwa06yv4sHR3a0AEuHd8DtmnfotXvNKcVV
 OC41K7Gwi/Zb/NVxDf985XDfB8lofGCR7JwcMzRyUYyHA7CiVufs5blPzCI1uQWqWSV4O5gV
 ey1i24mrQFxrSOix8kyhYbSnI4a107L+Dx/zY0oKtK2VFR1bsS4EJtMqS6aLY12T9stTWx1u
 is3y74LtYC5cSUKx5kqwx3SZvyIfYWM/h7tW/icLDNmiH9ld7+ygxS//EivxOPzVse530pHo
 yRLnNTIsH0Gyh/d6tCfR/dj40utxyyD2x7N5uxGO0w4iKrWJ4Qvz7Iokpcevl7PEyHrlEnsj
 6Kaal8o9+um5unhf77ovIWTN5VuhQH7KqkumtKwAeA/MgUWWmib/vm81KH58Uz3XrpFlec6n
 bTHv5zCJMQboLC2AxNN34o99hqzES2q3MoGkXQFNl5JZRKKg5LnNl3WJfD3F/a/g1CikDdxw
 PDGO6XsDJLXIXjZk7fhYK1951RTxgo3w9Bf/ZNUCrcOIP/oVE7+qsfXAgUkPAOq2+rnDs5y2
 ZsEWW2TGq+ZLL/SsViQ6+4yO+WMfpMauC7hK/g54P7jlWM2mVgBcqa13Jsac2u4H/RjI0WBe
 3XgmNYBEWEQvgo/VuPmklOCUSQAL0q1CqEx/Dc2DMekBIHCWoe3m5Sf0yqhWJ5bfGZLDhaLC
 3isP4yBV7IDZjK6Js56jidCW6KsRoMszhKysxe8zKBoaqLY4CxduZ/92dxd4+zIiQp0+yZ5A
 siQyGKRSHkymXkHA3cf2Kl56Wh81x/X8aF/u/1eGpp35u5hWwI2c5Xbyro+Q/n2VxKJUtqUQ
 1arWJ3yCDU8Xts3z9IUJUpwBt6igwrr1i+mRbQSkurPTLUw/7KU/2X3KI4pwnLLxO8hkl8pa
 sJKOSutgasps0D6A4PZnlTRtKGmfKIRwmaZ/WOOznGDvQdbVwJ5V6jbdXoSYk+Ttsu/7UTHG
 fvmIKk9OwFAz8KFYpNLbtngjB0STer5Md7fZW623X+xARKBx5uFaYascGIYimGVIkgNlR0L5
 3+FPBM+TgKmr2/bRGhkFVvpflv2+Op3s3P9S0g4wgSibkt92r7z8RkQ07jUYPoV0rMPtW8Fq
 n0gF1+709PdBpyEpiJoeakaatQ4thMP/mLQrQhwOJHoC6F/zgoVcw1tu07o2lNzC5homM0m6
 ngtyVw2YYmYylJaazKR29jTpLvWJSGm9xC1arXK21jYltWR96EO59wxrlmltwasQA5q33xh0
 tRRm0WR+onHFkJGXZv3U0sz3xZ0uLXeJCI9scec+XRyMKX8mz7Y39MkTL8sywykftpTGKyBH
 Q72VcYdAp7qYMAjhVmlJi4NMOdR87Qzd5eqfuWH1KS3NepnnzW8ikxa+5g72Fjas2JRUP/Ll
 7wfxPXQigadRjS6hk2mtuj+nIwCbjYXSC735jLpC8ZyfKp7fcMrAH2yJsSxjoFxnZPiWH5w8
 F+lGkMI39KvdROOblv7mwpK2hJT6VyunDmxhxl9kz8uqbjXiCzHxvbrMh8OOmBMQ3tKhFLgZ
 4OzioZeFGihdRI43CSo41r+zq5X7PB/JnPJUAFXci7qK2hkXoO5s7bEaMlKvtdgkSxIU+W6b
 hioSrf7rFNO8yr8HGpYy3YJdzistb3wmhA8g2WYejI7rHfDYsx2jQjCrIjcSORK0zwWX29nl
 BHeA1T6NN6sq5HctZbKqu24WCqKVppVfmG/z4KJrCa96ithARq5kNi3m9v6AU4z1S7x3tNjE
 y7PqUC4Kqv20eyePOMvKkt1Ahn45stSE4Ry1IA3gcdUkVwXgd2x/DJTinr1Kdhd1uT6bVIEQ
 DJNyNnQtkyt/UxgL26Aj6b4Tm6ew4M1Yti5Y38fnCY899tJCY+d6bAClixw9B7wlwXde/lym
 X8myOIz5X8Aiqldgg0h1CSSBfYpHFBFMC32njyB6tz4p6JSMiLnSqS50k5zjJiQBbeN6lVnR
 H//fpozWx556MpXOVfAlnb079egMOXZapohthqJ20Pchu8TOpI2i6MijC9rf2n6uCthg9I8i
 FRU3IHy6JSdKnVF5q+1AhdEcDbyYpVXsg/shrpZhI6k34moVsFfGz4XW4Guf/KhFxobsPihP
 AGLRnl0lX6KH7eXOQ6ZoBNZpmPJHtaPNne/LXwVi95lQU/ZbHNShgIVWjpyup8kXlS1ycrjc
 UF2oDQQ+3bxrxcKweVtYV23YmbZpBqpIg89TtDLHBtQ7hxDoX/cN+SX6+41FCZdqNnpnQ21J
 2qULy9IBGBBDn2FP13lMf+F5dDB2+GdCqy1KP6YJf28qeVYH9OJ2Nr7wItv+XCIN9inN3xuS
 fY83xwQc2p+HpH8ki8MVjdfuibDdc+dq1/o3yRtrd2kttnvVhju44SnFLZYd9lirUPlyZyfP
 vKd0X4qYQ1T0YkBkDqRkOB3ND86jihvc2PoCrEcrWvXS6mWnKZLDhkdYic1Nc1S7qt60BMec
 dXDhIbT0bh1xuUwF08DTUboz+Sgf88XOCeQMF3dBUCEHKuLL3vHzpK/eruyHIVZl/4crBiso
 XCeGk7nMC6EkmzMXgqsLPoKoSWVJh1Yt6mifxwrBWWwBMn+ZEidN9l6xSYz3aVyhn7OMjsEN
 iNgdkpWsrCKxSZfn+k5BGFLqHZoRQWdswCe6eSQapMfsP8xRz9xi/of+nMxjb1c8CBDQvVx3
 irUtN9n5V+8wKGJzXJ8XRxCpywu5srDtFh+Oajf6phLWGrVtBML42KKDh0WptxjQtTxsqFUw
 9LLmer9MjBHu97T+MIdAYDTJqfleDIEOADqBSWSIQ8LVz+tOknAikYbnPzTvnyZo54mq4T9z
 YIUQ+wTX1g0G/UGT0V9SYZbetEtBGxiyOPd151thzL2thTaScREs4qSU/uTBa+qMzOFlfxeY
 BBOx7rkLIMVP4m92kp4a1A8kp6ZfiiYFd1LvCBlaRc55UtX930rBEg6wUH4cUWA5HEJFPi7t
 gE7gE1ybK5+kVWkq0dyPVfMqCYqxQMUkM/mnCvXXTr/Nqa2UqlJBiCyu0V7YfaZC05lKAa1m
 0JjLjLNQblc2qBheW5cgwjZoZJTGPRYQMWoeTcozOqML7Ut2FVY8GC8wFNfoPHCAt1knRcrd
 pilqzRB3RhiZZg7P/6YKK1Mx1lWzqWA203gnsU42gwDPAAg9G2IeSgHkFMFPP8qKmKk8/dt5
 gqLhzZYMDJVDbxw+K0srx57YKyJ1Gr43qRGK1ytOuD6TevRoGXGmcOSAxsx2k4Oi0hZ7O1z2
 MYnfVCTUhNnx7+QGhIVcMvafFsMNYwIrieVJHvI6raoo9o9JYi2G+H2QPXbsa8VhhjhBwM1B
 8EW6c9HGJCw0UbeJMOhLbgfyBxr6h64QTfNRPlPZh+Ply8K5s+ly5oil6xUPDIAGiNQNSut5
 7DYjhAniryPUZ1lBxVSFptBLX8wVMCgzmR8tm5DESLx/+YX0gmE4Bfjqy6WADS2PL8BLL+EI
 BhrDt+x4zA29aO73EXW/pvpLGb/Ld1+u9XL5LBSt9OdBvhTV7U4r1bEltwSWSmxS2CWW43QR
 dC4e8w2YNfzEHr/TlGvl2d/UZLqJNj0ZqmQ3VOyHNwS6tPEmml5a4nkTGFZQUoVxalL5bogN
 1daOdxhO0Gu7ll4b+vlfU+Zyon8GT/3b2EMEL8GkqPiIOYIhys0Mr3gkSRmEct8lrjttxRRF
 NZQ33S8jb6if9UMAXK1QyIAPVyS9Gxh0DI/fucqnrVlmUyO7gNaaWjUMrQuMjMMvslgVwnLf
 jMpUCxhFgXa09aEuFDJvfha/jMBzYYOl7Qb7T6k5M6ZOWn0EK2z9ceF6Wx5M4Vg+fYpd9a5a
 o6PsJeU9tDGZL/XtADNECuzFv4A38NVPDodWv5D32csJc0Bv4NFr0s3TMY3YbJVWuEqofixZ
 DxoADR3r2dRXp6c3DEEnua32qfL3haWfpM4NRUYsZJEytIDWi9yaykaqeetTYLT32ODT2EKJ
 k8U42EurEoYkZRse+n+/IfSZJpL1iIQvP9+FCfGV9Fp+1b9VmCKkA34RfGmwInLlUpZyPPh1
 MVeWQYqUxEHgbwMyQ1xdfcseMxy9sbQvzSFdF33pjfoweqifhxKzNHMMkf/B8zDvHb9VSsV/
 TsVQ5VOwTfRD8d38UIxZaA1qVFLOI3jdFz54mlu4o1zHKSjE+2vyUwkq3kuWCqgVdZMQbID0
 hqfSHh+bpanpY+wcY1VWXNV8YaBpk1xlUJwL2imxJAaJ8wHsVtuFHBf5D6autW1UshK38R7W
 oQNLtlIsHD4AKpYOZKVrhXeVZTwx3Wf9z1u6T9SJR22HLKkCf1U9SsSF1dxT4x7glYiBa0g/
 zWKmm0=
IronPort-Data: A9a23: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
 T3TFrMc8/RxLlxUqT4v28GG
IronPort-HdrOrdr: A9a23:xfzN461cGwYGbklpekPPSAqjBGYkLtp133Aq2lEZdPWaSL39qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SPjUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyWMbEQt6bHCWeDYrMd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="102455333"
X-MGA-submission: =?us-ascii?q?MDGoVRMnVh43RFmliolqiHkKAhcobKmp5QGYSs?=
 =?us-ascii?q?10SPe89kpmP6RtrQYMPMKZafcolTYxo2vU8QDuPQmUWhL8i0eCVNxm2J?=
 =?us-ascii?q?ZPTWO2D/RHfmJXz+VNzWen2uKuEVMpgHl0Tx9UMLeae+Hx8W63AHLxKP?=
 =?us-ascii?q?/mMdseJbFXb9taFuuwgASEIQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 15:50:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681221015; i=markus.elfring@web.de;
	bh=QqBrh1iOG7Q4T2t0pkmEGvdBD1d8O9i9GYWCZGAT47g=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=K6zzEBWXsxSPB8XPajfrExmE1NNHZ4KP6iVFmus2wBQ0rmBPTYdrSxaYi4RfKihpT
	 rzCLvMmAorDLVby9zT5RYHOE+dSSyqgk9LrId8SMeFeYMjQlhP573CDN3INoyyIZj6
	 u0R37cj2oLma2/CrLudYSsPsvyaA+4fYB8MuFG6jhjgm8VNNRU9ATuCMjzzPyr7jk/
	 Uyi9s2X3+kBQRXeeqhwqkCLipnTZTofM3CQrpxeKcOlIgrrORwxS2pjEA950Fi2UcP
	 p1gnJruNKzQVT4jBK0pofhiBjYpJiDf9FGEIu3/9kP6oyyR+38Eub90LFSZJfat+D3
	 WQl7n6Wl9t43Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ml4B6-1qDpud2ScO-00ld3e; Tue, 11
 Apr 2023 15:50:15 +0200
Message-ID: <5341f677-4192-3c17-fb76-faddcf5ac9a1@web.de>
Date: Tue, 11 Apr 2023 15:50:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alan Liu <HaoPing.Liu@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Bhanuprakash Modem <bhanuprakash.modem@intel.com>,
 Candice Li <candice.li@amd.com>, Charlene Liu <charlene.liu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 David Tadokoro <davidbtadokoro@usp.br>, Eryk Brol <eryk.brol@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, hersen wu <hersenxs.wu@amd.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Jun Lei <jun.lei@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mikita Lipski <mikita.lipski@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Tom Rix <trix@redhat.com>, Victor Zhao <Victor.Zhao@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Zhan Liu <zhan.liu@amd.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <2258ce64-2a14-6778-8319-b342b06a1f33@web.de>
In-Reply-To: <2258ce64-2a14-6778-8319-b342b06a1f33@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k4el8X+ATWGE1XAQw5UGkyMRjJ5All74JHlKkerIl79dJWrOxCn
 7GN2s7L3Bvap3zkoSW9jkSUD0g6BSw0Sa4NTWMnH5XbYYHjAIJCwwnbFL+XV9YqjBwygSjh
 mNWO47vTH33VRRqJkPvREbx3aMRa1p9BjYk8Y6QhmznUv/ILmPjx15aeWJGkUxGPKZ1Tygh
 DNk3+P8IesUjo0hDhbIgA==
UI-OutboundReport: notjunk:1;M01:P0:mnPqPBJJIHA=;7vxqSL+DR2zreZ5Xn4j6gBqu/AK
 DMOoX/QPTVG+hJiJmivXNmZuT8zEItsJcIjU3IiSZ1OM9mJOxXM9EhQXsW7ToYgeq9oU1KBW4
 mTOf5gV64BQDYYsaZ9GLoHYnuPKAJIETUJqLuuQFHe1vgm4sy5aSr5X5WTorUsZC8FI4D41yy
 DeaO3JSlhp5N9oZJ4f+qq6XErgTAQ3DlSBmc3BeVPeFs0WhzfZ+Fpe31XddgK8ewSvbguV2NH
 4XCG3I1FJzfEFPjzxwHFq0oAjLZEKr44/8A8VHW6yFqxYLD2vZWXRPo2KVhgTwpeeJOR9FvFf
 wcW2pbE+cxi0+QvU09wAUS+Zx2SKoHDfmVqw03//OF1CxDaDMozyKWAt93Yy2NsTzTgF5z1S0
 jZlN1dKaXYSgqvTXtEWFBF3s4eyZ8Al9jbSxcIwveD7uNUCilQ68TQ7jbX1MV/R55OloxjtNr
 4QoUDBVzwOuiqrKCyU61wPz5Kxhg2gActZ+5pzRmWQrKTTd6iTz1+rD9hMJeVTWTo6mjaVKqx
 0tikWwuKjlmWiV8nRmtFOOXIE0yeRLrZXOQg1r+7h+InOsXw1YF3HjorVds/gxW2QGcMPOZxw
 A5afSj5swu+5Fg9CURpmoZFx9oFxNEroxfPyYXINzroxnsbQ3mHApGf3jvJFpWa5SjEPb4EV2
 7pCYdbDDpP/KxCJ0NKakpIWFkL+KcplkMzeceZG6ycQ3ICAQTGJHCo1soKR4C3KnxYceH8T5v
 hlYXvrk1Txpw3sLOrufAO2Qu4KMOlm5ExH4og/tMjPOW/PzsXT/atRzXtqcrp6YaOurkaRsfk
 HMEsRaEw+UPmHeLIBtv85qV0VExXp6iftOtHL8mxijJYoW0BtqGURRsv5SxMdzWuTY8Yls1mj
 nipN0UQBsh3CW+SyCVU1h6tIhyKN7oXfAUv1awug4DRDnAw1VH+jmOVRs
Subject: [cocci] [PATCH 5/5] drm/amd/display: Move an expression into a
 return statement in dcn201_link_encoder_create()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1033
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/5341f677-4192-3c17-fb76-faddcf5ac9a1%40web.de>

Date: Tue, 11 Apr 2023 14:04:57 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Cdcn201_link_encoder_create=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the usage
of an expression into a return statement.

This issue was detected by using the Coccinelle software.

Fixes: 3f68c01be9a2227de1e190317fe34a6fb835a094 ("drm/amd/display: add cya=
n_skillfish display support")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/dri=
vers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
index 6ea70da28aaa..a1b44c7bd34b 100644
=2D-- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
@@ -791,7 +791,6 @@ static struct link_encoder *dcn201_link_encoder_create=
(
 {
 	struct dcn20_link_encoder *enc20 =3D
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_ATOMIC);
-	struct dcn10_link_encoder *enc10 =3D &enc20->enc10;

 	if (!enc20)
 		return NULL;
@@ -804,8 +803,7 @@ static struct link_encoder *dcn201_link_encoder_create=
(
 			&link_enc_hpd_regs[enc_init_data->hpd_source],
 			&le_shift,
 			&le_mask);
-
-	return &enc10->base;
+	return &enc20->enc10.base;
 }

 static struct clock_source *dcn201_clock_source_create(
=2D-
2.40.0

