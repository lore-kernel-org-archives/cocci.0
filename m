Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D1606A323
	for <cocci@archiver.kernel.org>; Thu, 12 Nov 2026 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=C1yIXIsV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/S1jGMAtcvYsSf6w346X7lBkWidIViNXK1BASqjVvdM=;
  b=C1yIXIsVTZFfAiHLX1KDC2kAz/wau8xrXeXR6BNHGKS6MRbg66tFEFhI
   FcAkjzGydqX3Xk7V0SSpTjJzTa2d4fJnwCBfEVZ8vv0AR89+OI+mjN0no
   M6QbtdcygSdfWiEZzWoPviu/LuwkGVCIMcq4eruzVUTvLgYM1Gehi4McE
   0=;
X-CSE-ConnectionGUID: EyDZlx78Toa7Ak4VJ/BgWg==
X-CSE-MsgGUID: yJxt0ZeMSlKlbCCWOwabNw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="scan'208";a="305077782"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2026 13:39:30 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id AC57181BBF; Thu, 12 Nov 2026 13:39:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 43CDF81735
	for <cocci@sympa.inria.fr>; Thu, 12 Nov 2026 13:37:04 +0100 (CET)
X-CSE-ConnectionGUID: d2ymzEvdRmaL8mLMbC6+bw==
X-CSE-MsgGUID: DjPts31aTKK1hZV2cAxTOA==
IronPort-SDR: 6af5b2f0_3fclYigBPmuAHyO9yy5/iMXmXHUZsMatSvobXEbIfVGOK1E
 5QpeHmb1ywWw55eE2OLDZV5CmM7pJdWkhfDzfUg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FXAAD5sfVqg07ASNlaHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?gUBAQsBgkCBazQEC0mEWI9TgXQwi3iHVopUgXwCDwEDAQ1OAQIEAQEBAgSEd?=
 =?us-ascii?q?AoCjh8CHgcBBDIHDgECBAMCAwEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBA?=
 =?us-ascii?q?QEBAhABAQEhGQcOO4ZPDYwaAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjH?=
 =?us-ascii?q?QEBESYBBAsLGgIYDgICVgYBFAEBgn6CIwEGEAEDECcHuy2BMoEBggwBAQbaa?=
 =?us-ascii?q?x8sIl2BawmBHy4BhXOCbgGJfHonD4FVRIE8C4JJMT6FP4JggmqCJoEMgleOZ?=
 =?us-ascii?q?4YoUngcA1ksAVUTFwsHBYElQwMqLy0jSwUtHYEjIR0XER5YGwYFEiAqQENbg?=
 =?us-ascii?q?RKBBV2BKyhdAQIfRi0VgXUCglGBIwJbAgFJQQ4HRVMJJUMSRyQiCBIJARMaL?=
 =?us-ascii?q?AqBGjU8CSYEOxUMWwwLGgUaRwgCCwIMdCgREBMdHiQvBRomPhsKfm09NwoLG?=
 =?us-ascii?q?QQ9k2KCUIFUp2KhSDQHgjmBaoFoDJ9vBhMvg3EBk2IQkw6ZCCOpIoFvDiWBX?=
 =?us-ascii?q?DMaJIM2UAMZD44iGYQczghGMj0CBwIHDgMLhUQBAYxWgUwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RoiFrEc8/R/LlyFhQre2xBjvdpa+w==
IronPort-HdrOrdr: A9a23:y573sKBQ17pr8WTlHemC55DYdb4zR+YMi2TDGXocdfU1SKylfq
 +V98jzuSWftN9zYhAdcLK7V5VoKEm0naKdirN+AV7WZniDhILeFvAE0WKN+VDd8lXFh4xgPP
 BbAstDIey1Plh/ht3zpC21CcwpztXCz6yyhejfxX9xTQdsApsQijtENg==
X-Talos-CUID: 9a23:prC5tm9SgXrCL0J4uRyVv0JOC8U3X2PR9nLZBx+9LUNjY+PWQ0DFrQ==
X-Talos-MUID: 9a23:LcMO6QoJhC+nFis5XTIezx1gDNtzuP2nNGMuyJU0hZOPHDxMHB7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="scan'208";a="305077243"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFXLIW2hoAxL1XkGstU+V+1D3BYHl/pGAxzQg?=
 =?us-ascii?q?C2s2YbvQtBARvTTytW/cQgyY98DJIyeWnqbmqBYcjZFeoCUPO4nlaibq?=
 =?us-ascii?q?u6vgaz6Jw2QiBAR+VbH3YCOD9ISfMqbxMeLoCK7rBhTkzL863WKa9lOS?=
 =?us-ascii?q?M3hVb7XMXLs16poLgidM+P7w=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 13:37:03 +0100
DKIM2-Signature:  i=1; m=1; t=1794487023;
 mf=PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4=;
 rt=PGNvY2NpQGlucmlhLmZyPg==;
 d=web.de;
 s=s29768273:rsa-sha256:XknH+dMCLBMmC6AsMOgNe+MEB6lQ
   1dDEZnZVKGox4RNPD80Zd8Mn/87jQTGp6w2C+zmqQssuFfQa8OWmePkdV417uRwnNFNLbN7SksX
   UwNk9UJqrpvm2R1FAZVqiun8DwXOLdFcqZilsZgLj98bvfgQ7WzlYiLFeWQvUUsKLyip45RgB4m
   bFVkhC2IK2wM/YiqWLT+D6btbxmdQcvEvNEYy9XE/+qDvh8nX8EFsZB8V0lplfVjm5Etf9/3+5K
   7Emfq39EhdeRqMjRMhCkyS+/A9rbDDCEFdTKPs5BB28C3fxTzbL+HwRIk1j8LU5n1gUnkAjNJ3Y
   mwzMcduSA0TJpg==;
Message-Instance:  m=1;
 h=sha256:
   jLxxEbfv0jvxGg22MG70jmus/greSawAPRk/3TnL49I=:
   /S1jGMAtcvYsSf6w346X7lBkWidIViNXK1BASqjVvdM=,
  sha512:
   R7TkCf8f2o2lEj97R8oOaS2KspOgJVbF+Q4Ndzq5NpDINn7W80/VVsed4MiJtVq50/iEutQu3OU6KaPGmMmo3Q==:
   Sw+NUCkBxNAQImfvxB45PIdzvvqy0QdRynZwyaJOWsQD0aZ9kOVBY1rZpJhjxKbUjP2Ug8GBLvEkwCoyQefg9w==;
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIc7b-1xCraN2cuT-002uzq; Thu, 12
 Nov 2026 13:36:54 +0100
Message-ID: <acfa21d8-8777-4aad-b6d3-38a101f21296@web.de>
Date: Thu, 12 Nov 2026 13:36:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric-Emmanuel_Picca?= <picca@debian.org>,
 cocci@inria.fr
Cc: Julia Lawall <julia.lawall@inria.fr>,
 Victor Gambier <victor.gambier@inria.fr>
References: <45e0468b84f19a5d75ea99fb434113c0@debian.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <45e0468b84f19a5d75ea99fb434113c0@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:EyANeI7h1tjEVDgXJjzxbdUPtuWxLysmbGOOc1hpNnebW5/VyNj
 XMRvJHstWCGVlEYZRasBxL9nVtmyLLfeAfrCcnFo0WdcA6vfFLwxWiV+46TKmsOHgSrliWc
 cKwushMebRIwNFYKj5Xgo/PyRlKSdvo6eI/q5UKa1yVbAZPdn+HhVjY+cu2oW3NROb8LDrf
 /7VeWfsrhcA3PncKfHlzQ==
UI-OutboundReport: notjunk:1;M01:P0:MuAR79mXdN8=;TyMFtUbB1imkrfpalFGebqd4f1Q
 s5yUOmiumJt0z0aJkY6wKD0EZKO25MZSYfqr2xab5WayHADK6SoOFEEe8edKbfPqzc+9bmcUE
 JlyV/QuTAY0w1DWRKnH5vOd0rLgH4fR1PO8Ueg1K+zkHSvFzu9kGvP5eTLSXMnQOD5ImnZEVY
 EgQx/FctYlp0oYhqLOaOXlg8O9xzM3+/Zneiein7biXxMTeglofGf0ya4b1vlhA7BIZxFb436
 EghMOmwu1UEvml1tDv/uMjAdwNw9LGMZmhJ/TqBtOFWWC379WSd+iGw91ES4M6M/qx04UJEic
 lAvSWwhQn6dYtv/TkT23OSn7D4DmTHD9fzJX/adcLbNtfSUvGJvJypXFNYXSbuZqlIMrukG78
 Tkkn1hfM9s+xm6Qb3h+r72R7xq0eEDYSS/2gaxZmZOw9m343fXK6ZvJRqi9b0RKULBpIDhGp2
 MUxzCeSNYvhvgo/05Byi2u2WjNzApacjZxuyAzh9mdYJAc7eRMaddW8o55wFuTp+v7d8QXYtT
 AK4OLC5ZIHij98sgP8ptxpysFCDDgJWd9jholhIVr5wuTGwVa762FZ69/fuPZOL5amt7LpKAe
 RcWM36SwW084IP3sHlxxzE1PF/bDclj+gCkUiv9Ye5imrNtk6t3yv4L1KUwc88r6Su/gkd4WY
 oEFbu7CbuJJGA7kPH6b4pLx6Qf9bo7UGUBBCGy0V8FdDUBG73pFlIYeL8693wlVmsJILYilQA
 9gUdKQVuSxkMlO8XXK8qLcGIH7RF23S5hAMgYpE5piJROHAQTXD4umMQfD1I17SLxZF8/O7Wt
 C8wOgx793Bz7sSLHBTqoFV/0NW4rqQtvBtzV+css4dn3b3kwuTtrcge8D+JqC4n5oL+tl77Q3
 4LrN8DyFCXOMBvu9IHXTVhXh6fwOPR+U5bvjm1sIR+U3esJQ63zO6XFkwrLE2+ImPasTDDF23
 BTfs/9UJd5QAf6wxzgmKZ2FkSdAnw6Lp1BkS42ZSs5HMlLCeGPzX2Y9nYoxIKQ2PjWFI417im
 DusZHP5DbhNQgvZrZTecB47Q7GNRY7yA5tHWWYVxd9hzCGBFAdqYgfROG4bhJ32nn1ngE3HHv
 mGkZ91OAToBikbzshMxUw2RQLJYaFptmVfDHi+Y7Dh2oDEb4IxKPTj0udlRBsX0/n85obLk7m
 yv5SfBGeoPqYkCF3JYf974Pz3rVVeGi+k7Ly/4LeDwHrDhmNGHRJGuGfxMJ3DYcey0H2ACz0r
 ym1aqxqtRNbXDK7moyar+DUOqTrShsFJmn5b3RW2a6T6KtciUv/opLC29x/vRgBpd2qUPPUxH
 VVZ504/zQ8x1zt7z4WoRFEngmnwubr7wnFIq7DHiakmq87JLSwbBNdfbWwt0Po0NQscdUAK/7
 lKDpDMuwRCiLVq3yWQCP9RXjhsRfTU1et8aKuI5jbPeebmyqYGYDifJofHPLi89DVGFpXTPEI
 TiiWTIQVDfAOpIzyWaufLJ0BqXGK/J+UMEttXzQq9RMdqXfiilhH6jxRkP/tw+oixYrwHjCpQ
 fbzt9Zl+Lu0xs/U+oNvCtaC5gG+Z+AaOtDCT92g5szqcIfkZHzXhYT64rO1m5UE9fvmwaXBhn
 dYFKVu3wFHBsKTf1Oh8OlPjb9kVks4jKMxbOxRipQEmjs8hevAlJy1KxdnGV8QV9V3+Eg3l+K
 ini4RWSQOzXpRwiFBKCcNCu20OFUuEhdloLfdN9xj6r2UAGl4XCXFh6TYfwJGO9oZacvKFofq
 e9oik6norDoTzt3HLsA4c5tf3VUXDRx5L57qzb/y645FPaBzbuEVVRZKUEIuSvQM366aGMl/J
 KOHFRLA0hOr1vTBw2YyFOp6JbLh4NPfGK2/2a8Dq33Qc7sCrrMiOT8H+i8hPZyQIJDVRV5pwH
 97hKuoUqSJyL5bVISSz8uoatRHlYGEpI+ugy8hcWPbGvDb5sPPLNg3N9+gYcwikgAgAQCiRx0
 PTzHkrYAwKe45EgX+i9wuCzqyKBG7b/FIPpruOxjry8m2hEQzaUjDSV+h87Tpivlhv8wJr6su
 8tdLPQy7zC19D/DFFb/THSS4TfZBtEHr82k4+XsJ7ZaICRbEiMfzQu0p8ZF51vu3knVvNak+O
 GohUUzwRgVjdnizzlUcP+Mk8g18Su+Tv+Vrzk9n0FGbcNzfCXyauLvvZxr0sil+dpiAhCjijE
 DgKMvczk69hKNdXqhG8udnuy+clcq51tcmgYI6OU1A4azmpWjP6U4da4WJtCKfZnQTKQDVf0D
 C4n9dxoBznYSVlcYVH0kRaenW+tx8H1w7fOWtmt9bWn7CYwMZeddd57UrUvzMTpxDD6UCCw9q
 Z6W7vYTWc5AX5ygka+/q0PRR+hSj1mwre2bSEP2caQBl5Ymy7HX0FCT1JG1rTYAHpwF2oBoLu
 JcCgSaKyEHK6dCT1iDX/1jSp5TRAI++Uqi+wdmBUkFEpnJmn2KH2uOLLC7X3KU5McIUJ5dwmr
 cSfc8CUNAucYlju8J/57RskVNcub1DIdW4yHwvIVMoSLlk/ZLc6K7eE4b6sr3Ewa9psHQj0Lm
 JG2q3V1wQmr8gUT9l04XpettNDX3ApoSRF/5O0s73/GsSX55SmIx1ZCg1wOV2NS3bvqT+2Nvj
 WU+/RzMmQ6pRlgjMkRTkIPJO9Iconvkn3c3nCMmL8ZR1ggwPBZqC11jTnIx1ybHGjjkV+lqv5
 e1WWq0KIeZmN5ujuHoe6fQcLjtEsQwHgAO/adn1OKNlriOMVvbZNVlKx/Q8gCoOi4sGAomlBN
 W6X9fx8uxGOLyXwyR6NlOjGpEBanutRwRk9kptMfBgHzyh8uWo48y6wQ/fwukMaPcXiD8KWkp
 2cWgNZZ6D45qKbZk5s1JtIMDtgcfg/kGlc1TD2v2Flne7qiRME2ynXQm7yoTP2z/FBPaauNS3
 02udm4FJoUCWsffpbCLPccja6KhDT0uY5R4QwKbOuCZasmLF6ils6G/5ci96dsjz85pPMzFfz
 Zc4r4m6FcpFctCsdshc++U/lhPR5OWqS6yEIPY3AbCggWPtUy7SjyPJnERc5ym40sXwCQone2
 CUcQYP1G+dIvNBKBj6UNjD2zTp6FFZJg7ekMS+Wau8eeMLQeB+fnmW5T3ZpX5KLls56NOVX81
 ExuYMJUXKj/an4I6JSNpydPMqP89NcLNVkB08I2Za2WkEgoKxMg3iOCHusJ6RBt5M6Qj1hO1h
 RHHvXFpCP6zNWLDUhs6SYrPBezeU19CuBKL6TGmvYETJuPFgbzrGRU228cFTVlJSoTYJpH3N8
 AbN6z1JP047fPmnZxeUzCT1+1aClTMjcq9XHE1cy3dlHagH5C6DygB1hTRr2np4zbwXoyZ61a
 4S4zXBHdSZyPxOm1cXykc5h+t6kfl1t6cGCtwTId6R5Xd0dgOBNAJa7/wQIMbk10SGTdAvLZK
 rFLrC6HUlv2YZVJKSTzx1Jj2orKMrcZuPmObT/sQpMrPTnyaRWr+BRg/8VH8IhpygvzHDQC14
 qXme8o8rFI0/w4S59RrjPOON0WkvDnd0cadqtVEVqBcWlGBbRPSakXT7GYqNKxTiCMilflQCP
 j4/eNqszgajC+PRz6pQTPoE34dqNxj1BbEfVpGk8VUIUQJJ0BysK/dQq+FMwbw8XdifGGE65S
 gYdxTJ5PQgODsleaPQAe5gId9KU6f9LOoxYgWZuTZ2Wn8xYiUqD+uCemVCFpOff3IYXXmlNmh
 AjtRjpnfa+DSWeW8MGfy1itNWzw68NmEV3yJ2pdDSQKbv8+/uFXydCuexr7eH/WHllfWx2Ds6
 fKGrbMfcch4AHCu55hNsqvmZJley4UqvK9bJE6rbf/7//7mt0oiIEB/qKnlLF60LrPvii9upN
 UcwtzVEsOpnloPFZYfbcDJCZOZ+8k/r4c5WG+wf1zSxIuslvYL6tarRsg9b33WQbEh4FUTRwk
 hb9X4t0x71x/XkKw+uOt2AY9OZTwKgBhvQeHO09Ny0FGduIO3u22QdiAorueUk2NC3woZp9Rp
 wD7MJPipjy+Pb7wAnloFp/9Ym7SRTk8wYshQ1lleoDtBBeXBZlw/PDPFR33fwTTKFYKbPBkrQ
 jrRde4zmsgN98vGU8Qn4fWTtTiUW0/QZe5YrCeyo6lhOx1zTyrOax/mKu8WiBkTXy8BdioVI0
 K5QRaSbydjKW++p1itT9+JG9dN5B/ggDJcBu1JMadkLSn3ofT9bW+ngda3FXhykNiGDjsH2PX
 ZSvN46qINPlSabCvUxyWERf5kxFCk6Bo9bHCJRYLeJYhQN2jsFz/CKzF+VVyh7nLdHlZSpMmO
 RY/fqX9idfOYr+n0IKJz+PGiVh+A5jEbqZ0AyJLvLptboj2vmWndUOKyfdhEmBAbPwslfAeWD
 T63O2x0H0/63B8Ki4kxU7Jleq2AVFNZu7+CH1l60VmIPMr+CyLyIjOHLMGH/jKKcHqNFNmnHo
 osAydOycYBbp/EkczODWXz6JMCEtOJc4UHaNPAIsNrpyDE3OEUSSXnjOCKl6FCi++/jwyFac4
 Jyw6BpI9VLKuBz8nWwJjeXcica6fuQiL9n/PRFxKwCx6J9NZ3eGNkcl+dXd4FvJ9zn8p3ZddI
 ik0bjWT3V/JaxHXvnW+Z/AuOGn/mIqq+cqRuuQMb/xTfpf54zvEmd6p3AhSjpKluBmqT56I3p
 pwAHPzoXVoXgU2JQibdqelbbCkzgNF9/lvEytg+moiPHCTf09Tf0IbLYte+ChbRDgAuNBaWdn
 sUe1Qk1sxHYfUZ+czPwqULHVPWStbHYVltcbnIFNaTisFk1VskKvE6+/S7dFuWKPjwE6be+Sm
 Ma4dg1HSmpcCzUa9u0JQwDGCd8UD2pojxmx9fQBy6CRFHIyGsKCxqcYeJka16bychSecOK95I
 wPx4G4sw4qmzMQKcbbwtQq+aB9xks+co3qQqxxcjsJ2dpOvxjJ0KfHgSb+C25OzOUuyfQtKHA
 Ddw0dDIOhYlFZy+4Er4e0xcgOZb1oRpa9bihWNtT6rUCegGPfXYR+x1VqnZu/GxrFYZoSxEFd
 C2Cx5T0FtwCvRePIIV9pc6ZtFCRfYWnwpL9UJUGEFVsLWsL8yVNBRhYtSfkQQiPEbElLMPVet
 QZ8cz5yD+kgotyUHeW8MUuf7uvI1nUXw6HWKbHQCUdzTB7zeOp/elWwBL05euVvNv1A5dwGo/
 F9HXh+NGFd2UnRGXHxdzabe8ncMSmJEq+OBtJ6I0TRTlsQbS9G9M/R7CvKha+tyEv/7uHzno8
 OOgk48SIAr9PsIWmxc+qST3MvHiHUFvw1StDckn4DZSdHCmZPVZh2siqwcVi1EcHURv5bi1LO
 J8a+YE8Ih7fHSfNIAWxNQMcM3WeL6StHxmLQwivY30MN1drzBPQ1x1s14TkIHz4m7aejhD6/z
 bvIdNR+LzgeyV6nldcIE6opL9o9WQ/eDaxjIc/otmHyyCi4k98mg3gO1beRyRRFXwNkFJ283E
 oYbzGfbiyalXoD7egMqyto0aLfCclcH2MaFdMaj0AsqnjTaPD6KplikweH/+SR0R1D+LgURt9
 Y2YcWGZ/XEASHN51np0sKTv5bGv0hlbM4bVx4Ib9XmZOBmH44HLf8WAIvXczU2OToBvAVN7El
 ZGYXTSrQBs4kLw6xgW8p+WVtfmBh9xDOH/h5fuv6F2P8B1Sk/NBsjw+FHgprP1UTipKnWWltX
 runT1++uL5JvPSVQkFsbrUVoNpjSHlpYHMHrp26UWDuYlmUbTv+yuSfnJJLDES9RHLtfBtse+
 aWjS1V+YRo+HtHw/sK9993QvE0J4V1KUal1MuPb8gnytr3kM2JteaccR0rVtk0jXJHuULN08C
 E7LbOnpA9JyOrhPbYR7OXy06ZSi6Cyj76rdJnQlLleon8GNF6TJTrJIpFPbAUaD7r/KZKKPhj
 J1xAq3Yjnc5Pkdbl8cNadS7tTMWuni+S/RGz/ZKBgFbueE/zZKtsSqo693YnORAdCvlT2anFW
 z7/M/4OwmdvIXvF8dZxoYYbxQ6EsAh74Df3sY2dBsSeLm964Lbz5SUS/+5w0a1irrgZon1QEC
 Xz0BrAbuqRba5P6e0bc11kH/PgHAJ2H/0UgvyiJT8+ahUeLQ5ezuA7+3OT/HLYkbyKe5a0Mxt
 am1rd/87Bov4cWPjEeppvSUrAM2xRmXNFvg1i2ZwtQkhUcVpMUk9kpBKI/Qmuir+myMbQNOYq
 ToigwAuG4HUCSU0X02g1KanEOAaOMG1kXqZgpZgEJjQX17rSSerrKZqAIV4Zki9rOVjTsQNw3
 Ll8Uz4vBm//1ixwOwJHHSUT9pDOOEcJstuZDOlNU+1wxoDaEW6tVPJtX2wIx4q+tciOqzraml
 uLMY09Ag60Yhif9r9SJxc2DNeNXQolxOCDX0aKK56mZtqF5qIsiXZDSDOjnCcZwa0D3+i72DL
 uE7q98d8oobcnS4QepeJExtWPlEkhsFMcrIfDBdSJT2Plgl6nZAnmNn9D8fI4PLUTGnWPxYFt
 h6dN81Nk2ydf0jL4L8kAI900dBkDe/CjQEcAhloYLGMUa0KDe0lDo/8dRgLUc6R5Buw5o+YB+
 f6+c8pcC6tIAnqLa+ZP73fkDNWcTSWF5r9dSjT/3rvIRuRbq2Z1IvZHmtUwt0QzCVircq5K4Q
 3j/AzgMXcTZIGZiNxa6G6QjHbhVl0XvT4uQZ5c7btWuLgfjFwoh+Vd7teV0I0hgcUilnfjBjQ
 bsH3D0m5dVsvj/3/jjZsxLWki0Ezu0/xc0TtR2ik3q9bLzjUpndyLY3RWnMIUtyoEosLzHPfB
 KVcsm1iJfGALoUaO7iymXJUyyrZ10+f8A8WTUO28lDxZUrLHggocg5z8GBNvKHuEQ3uiFkZOd
 IK2saZoDfZSo/i8+8P75Y409XCJxlch1yXmZCmkJpzub50Cip0KQ1ko+j4j4B7ZZgd0LY+8TW
 iCGQFHBcnsEsQBKzney06/8o9Rf94GV/wL8gTIsJiR88hkdsvBfK+MCn2kDN+OgvRroPRhISd
 cwU6UFp7zhPWm6F5WnFWkEoQQCzeP3rUkMmRjncN9LGw5KWc0HXbmKAyeroAI+d0X0DZpi8fF
 zDGo6njDHd45mGXedSQYWrzxBJdOrIvtsPd++fQWOsQly7AaqgFMS7EkL3yVsvyLEMEp+al5C
 RT7e85C2A3xGNWm7//0iXLFuvdo2VuYN4P7QoSy52nlxlh5EzxdRr1I7Fd8F04e8UAiefKmLk
 qzXebacJJkzQ8aBCeap6j1pVz56q7a5O1BGN89UoaBrP5JntFrfV627iqmyipjITu/sS27s+k
 8E3Yd5UuD1jkG67NTbNzwrTDjgUHZIUSMHo4ZwBBLaxapo1J9nM6K9exuG22rRlGCU5iTGl41
 TZ6uZMZLWi0c+bUrQGLMgoqhfftd12dpByOAZjp08pYwppSKX66A5bpx4LBPitCE5Q4=
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Bug dans la parseur de coccinelle ?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3797
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/4-FUgyf-Mp3FCwjkSzJ2Cw>
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> here it is

Are the attached source files and the mentioned SmPL script stored in a public development repository?

Regards,
Markus
