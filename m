Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9735BC531F9
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=W3JglPnWk9TBq4x0G1FeLIkVSrGWMGHIqS6ALjWfpa0=;
  b=sHOhWjWdHYbx/pkpvCqo+kA7EXTTnEgnFc3MBzEGZlmh5V5jtUqalGUG
   IIcBwsVr1b0EzUhDRVszuUAc0TE5ZY0dKkPLf8FYBgcfFaX5YjweXazlX
   YqvVO54Ih60iy6VCCya04I405jqYfsZoHn+bBAipQRuPGSh/Oxww5+8/X
   8=;
X-CSE-ConnectionGUID: lpbEeF/IRcaWKoFmYlte1w==
X-CSE-MsgGUID: bi0ipeTMQ/moxS75NIJRDQ==
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
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287734452"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:56 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id B785A803EC; Fri, 24 Jul 2026 10:54:55 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id CD07381B37
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 22:26:22 +0200 (CEST)
X-CSE-ConnectionGUID: kbzKrf0kRPyNBr05YS+LnA==
X-CSE-MsgGUID: 71ho7rR0RMeyFCc7ieXrTQ==
IronPort-SDR: 6a6278ed_3Bx9lRLRFNWf5ccYZXd1EWpiWWwnz5/0pwgp/rwUOMJ9+TG
 swxW1Ta3w513Qe7ikDRcTOa0i5JUQzUZj68cJHQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FhAQAQd2JqhY98DMpaglmCQYFoNAcISYRYkXaLZJI3g?=
 =?us-ascii?q?XwCDwEDAQ1RBAEBAQIBA4R+Ao1gAh8GAQQwCQ4BAgQDAgMBAQEBAQEBAQEBA?=
 =?us-ascii?q?QsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBAUBJhk8NgmIBM3GBJQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEdAggFXgEfAQEBAyMECwENAQE3AQ8LGAICJgICIDYGE4MCgiMBBhEDN?=
 =?us-ascii?q?wLDPn8zgQGCDAEBBtsyDYE3gSQJFAGBCi6IPCABhXeEfCeCKIRAPoIfhX8ZI?=
 =?us-ascii?q?YIwgiaBDJIuUhdhHANZLAFVExcLBwWBI0MDgQYjSwUtHYEjIR0XFh5YGwcFE?=
 =?us-ascii?q?iAqQUUjA0EmEDgLQwWBVgKBeD8jHwM5f4EvdUp3LWkBAhAXSjgkg0kCgTcDC?=
 =?us-ascii?q?209NxQZBI8eI4JAAYEOWoFOF2OPHoNOAQeDIwGbC5QmcQeEIJUChl2FfARJl?=
 =?us-ascii?q?1GTG5kIkhOXMIFoOoFchCdQAxkPji0NCYNghkDFCkUyPgEHAgcBDASBc0+PZ?=
 =?us-ascii?q?YFMAQE?=
IronPort-PHdr: A9a23:WW4JYBEPEAd1TJX+K7HDop1Gf1NEhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k20hmRBM6Gs6gbw8Pt8IneGkU4qa6bt34DdJEeHzQksu4x2yEGPouuJHa/EsTXaTcnF
 t9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFRrlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5/I
 hS7oR/NusULjodvKro9xgXLr3BVZ+lY2GRkKE6ckBr7+sq+5oNo/T5Ku/Im+c5AUKH6cLo9Q
 LdFEjkoMH076dPyuxXbQgWB/nQTXnwInxRHHgbJ9B71UIv/vSv8rep9xTKVPdbqQrAuWDSt9
 LlkRRn1gyoaLTE58WXXisttjKJHpR+quhJyz5LIbIyTKfFzZb3Wc88ESmVdX8ZRTy1BDZ26b
 4sTFOoKIOJUo5Dgq1cSsReyAA+hD/7txDBVnH/7xaM03eQ/HwzYwQIuHNwOv3vIo9roO6kdU
 /u4zLXLwDjZc/9axSvx5YrOfxs8of+MR7Vwcc/JxEc3FgPFjVGQppb+PziIy+oItXKf4Pd+W
 uK1j24ntgdxrSWyzcorjInJh4EVylTe+iVi2oo1Ptq4R1Nlbt6+FJtQqieaOJZtT8M4WW5ot
 yA6xacauZGlYCcKyI4rxwXBZPGedYWD/x3sWvqLLzhimHJlZKywhwy08UW41+HwSsm53VVXo
 idFkdTBtm4B2wLd5MSaRfVw8EOs1CiT2g7T9uxJIUM5mLbaJpI9w7M9mYQfvEDfEyLrhUj6k
 KmbfVgn9Oiw8+nrfKnqqoGGO4NplA3yKLkiltKwDOgiLwQDUGaW9OKh37P550L5Wq9Fjvgun
 6nZrp/aIcMbq7a3Aw9R1YYi5Q+zACyl3dgBhnkHKU5FeAqdg4jsJV7OO+v4Au2wg1Stljdry
 O7JPrvuApXMKHjMjq3tcqp6605Z0AYzzNZf6IxICrwZPv7/RlH9uMbFAhMnKQC43vjrBdpn2
 o8DVm+CDLeVMKbIvl+J4uIvLfOMZIgQuDvlLfgl5v3ujXsjll8GZ6WpxpwXZ22mEfR8J0WZf
 HzsjcoaHGcQpAU+Q+rqh0eeUTFNe3myX7gw5iolB46+F4fMWpitgKCd3Ce8BpBWYnpJC16WH
 nfsc4WJQPYNaCOXIsB6iDwLT6KtS44n1RG0tQ/10aBrLuTO+iEAr5LsyMB15/HPlRE17TF7E
 8Od3H2RQGF1hW4IXD833KVnoUNn0FuD0K54g+ZZFdNJ/f9JXB06OYbaz+NhE9/yQB7Ofs+VS
 Fa6RdWrGS89Qso+w9AQZEZzGM+sgwjN0CS3G7MVjaKEBII3/KzGx3XxKcJ9y3HI1aU4lFYrQ
 dJDNXajhq5j7wjfHYvJnFuCl6axb6sc0y/N9GGMzWWQukFYXw9wUaPbUnwFekTWqtH56lvfQ
 L+tCLQnNxNMx9aNJKREdNPnkUlLSvH7NNvDZmK+gX2wCgqQy72UdYTkY2oT0D3GCEgcnQAe5
 WyIOBQjCCm8u27eFyRuFVz3bEPs7+Z+rHS7Q1cuwQyWckNvyun9xhlAvvWaRLYz07UC8AUsr
 DM8SFu+0dzLUYLY/1sxVKpZaNI5plxA0DSKmRZ6O8mGLqNmj0VWSK+ps0700whxBs0Ul8kpq
 HoxihF1Ja+C1E5HexuC1J/2M6HaIWm05x35OP2e4U3XzNvDovRH0/8/sVi2+VjxTiLKkl1i2
 thRiD6H44nSSREVSdT3W1o28B5zo/fbZDM87sXazy4kKrG65xnF3d9hH+450lC4Zd4KNqKHE
 AbpVdYdC8W0LPEsl3CzZx0CNfxf/65yJM71P+Ce1vuTNf171CmjkXwB5Yl81kyW8C8pTO/L2
 58eheqf0gadUyr6gH+7u8/xkJxJbjFUBWfsgTP8Cttpb7ZpNZ0OFX/oI8CzwYBmgIXxXndD6
 FO5L10C39Dsc0rXdFnhxUtV2F8MqHOmnyS1yTN1lTxvpa2atMDX68LlchdPemtCRW05yEzpP
 ZDxlNcCGk6hcwkukhKho0f83alS4qplfSHVRg9Tci76InsHMOP4v6eeY8NJ9JIjsDlGGOW6b
 1eAT7fhohwcmyr9FmpazTo/enmkoJL81xB9jWucKj50oh+7MYl2xBTb7ceaXvld0yACWS90o
 SPeCV61I9Si/ZOPmtaLs+yzUX6gSowGaTPinubi/GOw4WxnBwH6nujmwIW9V1Fgl3ahi58zC
 X6byXS0KpPm3Km7L+99K0xhBVunrtF/Bpk7iYwowpcZxXkdgJyRu3sBi2b6d9tBisecJDIAQ
 yAGx9nN7U3rwkpmeziPxoH9X27b2cxtasO+f2Ua8jg04MZDFKqf7PpfkGEmxzjw5RKUevV7k
 joHnLEo6X0eivpPow0hwz+ZH7YeNVNRMirlixmD75aloe8EAQTnOaj13014k9e7CbiEqQwJQ
 3f1dKApGipo59l+OlbBuJHqwrntY8KYLdcatxnP1gzFk/AQM5Up0PwDmStgP2v5+3wj0e8yy
 xJ0j9m2u42OKmMl+6zcYFYQMDz2Y8oIvCrqgatEmtuQ06i1F5pnEykGV5uuVv/gHD8JtPvhP
 hqDC3Vm8i3dQOCZRFXDrh469DrGCPXJfzmPKWMczMl+SRXVP0FZjA0OHX07kpM/CgG21Znke
 UZ96CoW4w2dyFMEweZpOh/jF2bH8V3wMHFtEt7GdkYQt10ZtCK3eYSE4+l+Hj9V5MikpQ2Jc
 SmAYhhQSHoOQgqCDkziOb+n4Z/B9fKZD6ywNairA/3GpOpAWvOP3Z/q3JFh+mPGMMSMOnB5S
 eY81kdZWW1/F+zDkjoJQjAanCKLdMPR93LesmVn69uy9vjmQlel44qMD7JJd85o9x2shbqFO
 8aKjSl/ICpV3ZNK3nKCm919lBYCzippcTeqC7EJsyXAGbnRlqFgBBkecypvNcFM4vF0zkxXN
 MXckN+wyq9gg6t/FQJeTVK40JLMB4RCMySnOVjAHkrOKLmWOWiB3ZTsea3lAbxI0LcN70b24
 GjLVRa8ZHLazWmuDU/KU6kEjTnHbkYG4sfkKFA0UzSlFYi2LUfkeJp+iTl8qVEtrkvDLnVUc
 T11ckcW66aV8TsdmfJnXWpI8ntiK+CA3Sef9ejRbJgM47NnBSF9luQS53pfqfMd9CZfWPl8g
 zfftPZgp1a51+PfjyFiTAIIrztQn4uEvENtNKPW959NH33D+VoB4H6RBBIDu9Z+b7+n8/oIk
 J6WzuSqcmsEqo6PtcIHT9DZMseGLGYsPVLyFTjYARFEBT+nOGfDhlBMxfGf8nrGy/py4pPom
 ZcIVvpaTAlvTqlcUx4jRYZeZs4rBWBB8/bTlsMD6HugoQOEQcxbusuCTfeOGbD0Ly7fi7BYZ
 hwOyLe+LIIJN4S91VYxDzsy1InMBUfUWshA5yN7aQph6kNM83x3VSso3E7ocAew5nM7D/e7m
 BcqhwB+J/8gvmSJgR9/Nh/RqS08nVNk083imiyUeSXtIb2YU4VRFG/+5w0qN4/jBQN4dha7k
 k1iOzrCSLNXgv1rcmUh22q+8dNfXPVbS6NDehoZw/qaMu4p3VproSKi3UZb5OHBBMgqhE4wf
 JWrtX4FxxN7YYt/O/nLPKQQhAs15OrGrmqy2+s22gNbO0sd7DbYZnsToEJRfrg+e3jxprcqs
 FLS3WIcIi5UEKB2x5AivkIlZ7bal3imiuQFcxrtcbTYdf/R/mHEkYTgqrwYzEoHkUBZ8LN2l
 9wuIRP8v6EHwr+WCFEDZY/ZLB1NKc9f72PacieIvujLzpNzMsO2EeW6FIdmUY4Oi02iFRokF
 IRK9clTRvGR
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:w7MlbaEoXfPf3HHHpLqEAceALOsnbusQ8zAXPo5KOHpom+ij5r
 yTdZMgpGDJYVcqKQwdcLW7VcW9qBznhPtICPYqTNSftWXdyQ+VxcRZnPXfKl7balfDH4xmpN
 9dmsFFYbWaZykZsS+52njCLz9K+qj/zEnHv5a4815dCSVHL5h66RZoYzz6LmRGAC1rQaMjEo
 uNouBOuyCtEE53Uu2LQl0oG9POrdHKi57qCCRpOzcXrC2jyQml77P3CHGjsSsjbw==
X-Talos-CUID: 9a23:6xF/2m7GZwu3Qd/j89ss90QGOdorKn7n9Gb2CVXgVFdSC5mTYArF
X-Talos-MUID: 9a23:nolfFgkk/6bG+zBaDY+Ndno9bcdvvL6UUHoonIQokMLbNCFAIQuk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152819395"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDENYNzJKaplSwZOV9qOTWlnLn72JTM5Roz1k4?=
 =?us-ascii?q?rjBrmIlot84aPP47Caoid39Qf9WgIgkY8SPIxGrOSLzBAMpRBhnwUfPS?=
 =?us-ascii?q?U4KscCLMSmaeaobweBAaEl3q4M5ZMC42FRRtKP/6rMzA7/FEBjzgGf7K?=
 =?us-ascii?q?JivRFUQUzjHYViuhWQq9mM3w=3D=3D?=
Received: from flow-b8-smtp.messagingengine.com ([202.12.124.143])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 22:26:21 +0200
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 67ABA13005AB;
	Thu, 23 Jul 2026 16:26:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 23 Jul 2026 16:26:19 -0400
X-ME-Sender: <xms:6nhiaq0GCCJ3UjZ1Tl2tjNSSOnLYa4n_DvEcQxwQC9GuOs_D83Mzog>
    <xme:6nhiaqScHvfaZ8a3YA8X-XOWjv0Qdvpj2dus8nerwH4i6u3xSe-ZOxZ6idILJxXim
    y1KXEIpiY7SW9YeE_uONa8KUBeR7Q5D2gjX1lMoCNkek2ZgELFkeA>
X-ME-Received: <xmr:6nhianaCq0-8aK30F5jYwZGN-zCrvAD2Sd6SGgBH9Eu3eu1y9EjCtytpO_M1R6a-kZg2BJEbUUYPYJms-lGCWOBvUA9tEM8>
X-ME-Proxy-Cause: dmFkZTGtHfvCGLFNFtcVRq1cHrKjv7HYmoxFw1SEsPfggLpPF3+EigNttIIi46yncFHb8w
    RNhYQ07T1sllTu+sciGyBlKNcqXi+ymeT8cw3/9uVWtj/55kw2wskM5if1ZNL/3AIR5RA7
    JKSkKWovXVlh7x77H2TM7Fwa4ev5Ev2uAIZzQMb9G24Gxj0uSSfHKfofOICsmDLLuGJSqQ
    arq+kkHAqnBsywojtxH84aBy8syhUvWsWbGXXq4laZV35SkdUVXHQX8BaFHGaJFjYDX/ty
    4nfo9ODP4B4TvmLO5jB3ku72GvF+yhV8RnLjRs4UWFh7UVF90OGDAER6ybUj5upM1dXNGZ
    F03sjgtZ4n7EW2/LRPbX33fsmxdTQZM4Vw5QGKeQRTtYxEOchEyqIxRBu4LbkRDn73kWsj
    LxYHgAovK+XVj0yrC2GlG4PIwCuhaVZl4PNrkMgjuuHaVnpbrMOazhWf+XHy5e4/kzdEPK
    ESIrNm8TOPUo7esJ9Bowy13hBURoivHoZBN+d4ZkKnSoXGR5vuSaTyzTxQ+Hzaay0E7Lfr
    xq6M32C+odLuFXo74tayix0UXXCfsRftO/iWF6RnjQkHlRCv1V8SQ1MYK7N3gRXqdouc8l
    jyXZqRQAN02lAaHt2bHhaQRmnjivyIfZ3NUs7hofb60faFpc5bKWXMeqNoIw
X-ME-Proxy: <xmx:6nhiaoCXzbGIALywOyKdXlCmgNNav7K7UV8hqKi_9N-GTFvh7oRdGw>
    <xmx:6nhiauBmaHuLQ1nKqA7wC38CXfEeYaFqFWIRA7sNALBbywVskdn7Lw>
    <xmx:6nhiakG0cjRTw4Z4znK2C-2aTt_TaksxSzeagr3CTWcsXG4N-rNvpA>
    <xmx:6nhiahnCr7pm_ynLAL8AGOG2tvn6-_tx8d1jY7ys3gGWLrP5zNJxoA>
    <xmx:63hianEYvSz2qubeSY6ig3NYWooFgtsXupJs-9XDOyc4f82FAicO-1U8>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 16:26:17 -0400 (EDT)
Date: Thu, 23 Jul 2026 22:26:16 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Julia.Lawall@inria.fr, Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Eugen Hristev <ehristev@kernel.org>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
	Michael Krufky <mkrufky@linuxtv.org>,
	Hans Verkuil <hverkuil@kernel.org>, cocci@inria.fr,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org
Message-ID: <20260723202616.GE2273555@ragnatech.se>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-13-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260723184538.3888637-13-ekffu200098@gmail.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 12/36] media: remove conditional return with no
 effect
Reply-To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
X-Loop: cocci@inria.fr
X-Sequence: 3637
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/GrEd_XRvUPZKcGoFjpZI4g>

Hi Sang-Heon,

Thanks for your work.

On 2026-07-24 03:45:14 +0900, Sang-Heon Jeon wrote:
> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
> 
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  drivers/media/i2c/mt9p031.c                          |  6 +-----
>  .../media/platform/microchip/microchip-sama7g5-isc.c |  7 +------
>  drivers/media/platform/qcom/iris/iris_resources.c    |  6 +-----
>  drivers/media/platform/qcom/venus/pm_helpers.c       |  7 +------
>  drivers/media/platform/renesas/rcar-csi2.c           |  6 +-----

For rcar-csi2.c,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

>  .../media/platform/samsung/s3c-camif/camif-core.c    |  7 +------
>  drivers/media/usb/dvb-usb-v2/mxl111sf.c              | 12 ++----------
>  drivers/media/usb/gspca/jl2005bcd.c                  |  7 +------
>  8 files changed, 9 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/media/i2c/mt9p031.c b/drivers/media/i2c/mt9p031.c
> index d21510caf45a..2b09e8315c8e 100644
> --- a/drivers/media/i2c/mt9p031.c
> +++ b/drivers/media/i2c/mt9p031.c
> @@ -452,11 +452,7 @@ static int mt9p031_set_params(struct mt9p031 *mt9p031)
>  	ret = mt9p031_write(client, MT9P031_HORIZONTAL_BLANK, hblank - 1);
>  	if (ret < 0)
>  		return ret;
> -	ret = mt9p031_write(client, MT9P031_VERTICAL_BLANK, vblank - 1);
> -	if (ret < 0)
> -		return ret;
> -
> -	return ret;
> +	return mt9p031_write(client, MT9P031_VERTICAL_BLANK, vblank - 1);
>  }
>  
>  static int mt9p031_s_stream(struct v4l2_subdev *subdev, int enable)
> diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
> index b0302dfc3278..7383341ec51d 100644
> --- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
> +++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
> @@ -598,13 +598,8 @@ static int __maybe_unused xisc_runtime_suspend(struct device *dev)
>  static int __maybe_unused xisc_runtime_resume(struct device *dev)
>  {
>  	struct isc_device *isc = dev_get_drvdata(dev);
> -	int ret;
> -
> -	ret = clk_prepare_enable(isc->hclock);
> -	if (ret)
> -		return ret;
>  
> -	return ret;
> +	return clk_prepare_enable(isc->hclock);
>  }
>  
>  static const struct dev_pm_ops microchip_xisc_dev_pm_ops = {
> diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
> index 773f6548370a..872bd09656b1 100644
> --- a/drivers/media/platform/qcom/iris/iris_resources.c
> +++ b/drivers/media/platform/qcom/iris/iris_resources.c
> @@ -78,11 +78,7 @@ int iris_enable_power_domains(struct iris_core *core, struct device *pd_dev)
>  	if (ret)
>  		return ret;
>  
> -	ret = pm_runtime_get_sync(pd_dev);
> -	if (ret < 0)
> -		return ret;
> -
> -	return ret;
> +	return pm_runtime_get_sync(pd_dev);
>  }
>  
>  int iris_disable_power_domains(struct iris_core *core, struct device *pd_dev)
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index be1cbd5cfe84..e88e66be4f6d 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -781,7 +781,6 @@ static int decide_core(struct venus_inst *inst)
>  	unsigned long max_freq = ULONG_MAX;
>  	struct device *dev = core->dev;
>  	struct dev_pm_opp *opp;
> -	int ret = 0;
>  
>  	if (legacy_binding) {
>  		if (inst->session_type == VIDC_SESSION_TYPE_DEC)
> @@ -829,11 +828,7 @@ static int decide_core(struct venus_inst *inst)
>  	}
>  
>  done:
> -	ret = hfi_session_set_property(inst, ptype, &cu);
> -	if (ret)
> -		return ret;
> -
> -	return ret;
> +	return hfi_session_set_property(inst, ptype, &cu);
>  }
>  
>  static int acquire_core(struct venus_inst *inst)
> diff --git a/drivers/media/platform/renesas/rcar-csi2.c b/drivers/media/platform/renesas/rcar-csi2.c
> index 7305cc4a04cb..6635f5782175 100644
> --- a/drivers/media/platform/renesas/rcar-csi2.c
> +++ b/drivers/media/platform/renesas/rcar-csi2.c
> @@ -2273,11 +2273,7 @@ static int rcsi2_init_phtw_v3u(struct rcar_csi2 *priv,
>  			return ret;
>  	}
>  
> -	ret = rcsi2_phtw_write_array(priv, step4, ARRAY_SIZE(step4));
> -	if (ret)
> -		return ret;
> -
> -	return ret;
> +	return rcsi2_phtw_write_array(priv, step4, ARRAY_SIZE(step4));
>  }
>  
>  /* -----------------------------------------------------------------------------
> diff --git a/drivers/media/platform/samsung/s3c-camif/camif-core.c b/drivers/media/platform/samsung/s3c-camif/camif-core.c
> index 14eedd1ceb27..bb06847f3a63 100644
> --- a/drivers/media/platform/samsung/s3c-camif/camif-core.c
> +++ b/drivers/media/platform/samsung/s3c-camif/camif-core.c
> @@ -301,7 +301,6 @@ static int camif_media_dev_init(struct camif_dev *camif)
>  	struct media_device *md = &camif->media_dev;
>  	struct v4l2_device *v4l2_dev = &camif->v4l2_dev;
>  	unsigned int ip_rev = camif->variant->ip_revision;
> -	int ret;
>  
>  	memset(md, 0, sizeof(*md));
>  	snprintf(md->model, sizeof(md->model), "Samsung S3C%s CAMIF",
> @@ -316,11 +315,7 @@ static int camif_media_dev_init(struct camif_dev *camif)
>  
>  	media_device_init(md);
>  
> -	ret = v4l2_device_register(camif->dev, v4l2_dev);
> -	if (ret < 0)
> -		return ret;
> -
> -	return ret;
> +	return v4l2_device_register(camif->dev, v4l2_dev);
>  }
>  
>  static void camif_clk_put(struct camif_dev *camif)
> diff --git a/drivers/media/usb/dvb-usb-v2/mxl111sf.c b/drivers/media/usb/dvb-usb-v2/mxl111sf.c
> index 870ac3c8b085..6404eb74db32 100644
> --- a/drivers/media/usb/dvb-usb-v2/mxl111sf.c
> +++ b/drivers/media/usb/dvb-usb-v2/mxl111sf.c
> @@ -987,11 +987,7 @@ static int mxl111sf_frontend_attach_atsc_mh(struct dvb_usb_adapter *adap)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = mxl111sf_lg2160_frontend_attach(adap, 2);
> -	if (ret < 0)
> -		return ret;
> -
> -	return ret;
> +	return mxl111sf_lg2160_frontend_attach(adap, 2);
>  }
>  
>  static int mxl111sf_frontend_attach_mercury(struct dvb_usb_adapter *adap)
> @@ -1007,11 +1003,7 @@ static int mxl111sf_frontend_attach_mercury(struct dvb_usb_adapter *adap)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = mxl111sf_lg2161_ep6_frontend_attach(adap, 2);
> -	if (ret < 0)
> -		return ret;
> -
> -	return ret;
> +	return mxl111sf_lg2161_ep6_frontend_attach(adap, 2);
>  }
>  
>  static int mxl111sf_frontend_attach_mercury_mh(struct dvb_usb_adapter *adap)
> diff --git a/drivers/media/usb/gspca/jl2005bcd.c b/drivers/media/usb/gspca/jl2005bcd.c
> index a408fcc3a060..4988fbf5005e 100644
> --- a/drivers/media/usb/gspca/jl2005bcd.c
> +++ b/drivers/media/usb/gspca/jl2005bcd.c
> @@ -148,17 +148,12 @@ static int jl2005c_start_new_frame(struct gspca_dev *gspca_dev)
>  static int jl2005c_write_reg(struct gspca_dev *gspca_dev, unsigned char reg,
>  						    unsigned char value)
>  {
> -	int retval;
>  	u8 instruction[2];
>  
>  	instruction[0] = reg;
>  	instruction[1] = value;
>  
> -	retval = jl2005c_write2(gspca_dev, instruction);
> -	if (retval < 0)
> -			return retval;
> -
> -	return retval;
> +	return jl2005c_write2(gspca_dev, instruction);
>  }
>  
>  static int jl2005c_get_firmware_id(struct gspca_dev *gspca_dev)
> -- 
> 2.43.0
> 

-- 
Kind Regards,
Niklas Söderlund
