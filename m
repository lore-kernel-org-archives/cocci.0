Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EC1C7618E
	for <cocci@archiver.kernel.org>; Sat, 22 Apr 2023 19:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3fdQVgNkn51blqhWXKHziBJ7uc5NPdzWjASYWAFZrMU=;
  b=F60XaoNdBV7scUjpZFL//RL2eQ26UisjNUmo01EqkOyjYKrwzdiflS9X
   4vyB4gTn3zyIG4YNAli2M8qWIbyeFS5dLrzUQh3uPWeN/0H30l6aobme3
   XyoM5PVeaCjBEvaSekAgjTFsvYcEgItPly6j0Xw0mAZF1ToA8/9WTXwMp
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.99,219,1677538800"; 
   d="scan'208";a="104306983"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Apr 2023 21:35:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 288B3E01D1; Sat, 22 Apr 2023 21:35:10 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 46A3CE019E
	for <cocci@sympa.inria.fr>; Sat, 22 Apr 2023 21:35:07 +0200 (CEST)
IronPort-SDR: 644436d4_YcLe8lZahnnBFZs90kOnGm3X4ScA8OsyCv3xkd51/BGmnrc
 tvBg2AafBa55yIwXtLDS0ubFRZBnWO4x6AIQv9Q==
X-IPAS-Result: =?us-ascii?q?A0FMAACbNkRkhwQP49RaHQEBAQEJARIBBQUBQIE8BwELA?=
 =?us-ascii?q?YItgUsvBAtGhFOPEIF2MYQwhy6HPohqgVaBQD4PAQMBDUEBAgQBAQMEhH8Ch?=
 =?us-ascii?q?TwCHQcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBG?=
 =?us-ascii?q?gkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHP?=
 =?us-ascii?q?gECAgEjHQEBEScECwsaAiYCAlcGAQwIAQGCeoIoAQMOIwerE4EygQGCCAEBB?=
 =?us-ascii?q?oJlmSgfLCJUgV4JgRQtAY0fhDEnD4FVRIE8DIJHMT6ERINbgmeWGIEzdIEng?=
 =?us-ascii?q?TKBBAIJAhFrgRAIaIF0QAINZAsOcIFFX0aBcgQCFDQODBYFQiUEDgMZKx1AA?=
 =?us-ascii?q?gELdT01BgMLHwZEAh+BbAQvWHcKBkqXBIIKgUSBB8NqNAeCK4FWgVkMnw0GE?=
 =?us-ascii?q?y+DapMfDgaSJR6HXYRiixsgqACBZAE4gVwzGiSDNk8DGQ+OIAwNCYQDj0g/N?=
 =?us-ascii?q?D0CBwEKAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23:yfct3R8kbk0LCP9uWaW2ngc9DxPPW53KNwIYoqAql6hJOvz6uci4Y
 QqEvasm1QSWFazgqNt6yMPu+5j6XmIB5ZvT+FsjS7drEyE/tMMNggY7C9SEA0CoZNTjbig9A
 dgQHAQ9pyLzPkdaAtvxaEPPqXOu8zESBg//NQ1oLejpB4Lelcu62/6y9pHJbQhEmDuwbbxvI
 Bi4rwjaq9Ubj5ZlJqstxRTFpWdFdf5Lzm1yP1KTmBj85sa0/JF99ilbpuws+c1dX6jkZqo0V
 bNXAigoPGAz/83rqALMTRCT6XsGU2UZiQRHDg7Y5xznRJjxsy/6tu1g2CmGOMD9UL45VSi+4
 6ptVRTlkzkMOSIn/27Li8xwlKNbrwynpxxj2I7ffYWZOONjcq/BYd8WQGxMVdtTWSNcGIOxd
 4gBAeQOMulWsofzp0UArRW8CgawC+3i0SNIhmbs0KEmz+gsHwPL0Qo9FNwOqnTUq9D1Ob8VX
 ++v1qnIzijDb+hL0jny7IjIfAohofCKXbJ/bMHczk4hGBnfjlWTtIzlJCmZ2OsJs2iV9epgV
 OSvi2E8pgB/vDeg3d0ghZTXiY8MzF3P6Cp2zpovK9KiVE57fcCrEIFWtyyCKod7Rt8uTW5pt
 SsmyLAIuZC1cicUxZk7xRPRa/KKfoiI7B/nW+idPzl1iG94dL+9mxu+71asx+LzW8S231tGs
 CxImcTPuHAVzxHf9NWLRuVn8ku/xzqC1Rrf5vxELEwumqfXM5osz7EqmpcdrEjPBCz7lUrsg
 KKVeEgp/PWj5f79bbX8vJCcMpd5igHgPaQqncyyGeE4Mg8TX2iH4+i92qPs8lbjTLpXkPI6i
 qjZsJbEKsQHvqO1HRJZ3pg55xqhETur0s4UkWQHIV5fdx+Ll43pNEvPIPD8A/e/mVOskDJzy
 v7BJLLhGJbNLmXYkLv7crh970BcyBAyzdBZ6JJZEb8AL+zoVUPrqdPXEAc1MwqvzOn/EtVyy
 pseWX6TAq+eKK7fv0eE5vgzLOmUeI8VpDH9JuAh5/H0g342g1sdfa2y0JoWaXC4G+9pI1+Db
 nb2g9cBF30KvgskQ+Dwhl2CSyZfZ2yuUKIk+jE7FIWmAJ/fRoComrOBxju7HpxQZm9YEV2NE
 Hbod4CfVPcWci2eOM5hkjoeVbigUYAtzx+utBXix7p9MuXU4jEYtY7k1NVt++LTkg09+iB1D
 8mGyGGMT2R0nnsSSDMs3aB/p1Z9ylaZ3qRijfxYD48b2/QccBo+NJeU6+VlAtT2ElbDY9OIQ
 RCiS8qvBTUZT9QrwtZIbVwrX52ejhHOxTC7S5ocjaCKApEmuvbg33n8PdxsjVPPzrUgiVQ0a
 spJL2yvwKBloUybDInCmESxlqCwdK1a0jSe2n2EyD+rtVtbTRU4fKHLR3EZaQOCiN3j5V7ZC
 ZKqB64mNARp1sOIbKdHPI66xW5aTevubYyNK1m6nH29UFPRnuvkhOvCfmwc2H6YE00Yi0UI+
 m7AMwEiByCnqmaYDTp0FFupbVm/ufJmpiadSUk5hxqPc1Unz6C8rzscn/+BULU+2rweuSEug
 yp5FhCx0oGeEMKO8jJoZ74UetYh+BFC3GPduRZ6O8mFJrphm0VYXgB5pULo2D1oB48GncV55
 Ggywl9ULqSVmEhEayve3Z30PejPLXLu+Rm0d6PM8lTZzcrQ5aoFrvg1w7n6lCeuEEdqs3Bu0
 t0OlmCZ+o2PFw0KF5T4Tkcw8RF+4bDceCg0oY3OhzVqNuGvvznO1shMZqNtwwu8f9pZLKKPF
 RPjW8wcCc+0LeU2ml+vJhsaNeFW/aQwMouobfyDkKKsOe9hmnqhgwElqMhY21iP6jE6Z+rGx
 ZcDzNmH0wHBWzq9xFatv8brmJxVMCkIFzn3wizlCYhNI6xqKNxSUyH0eZLxn4g4282IOTYQ7
 lOoClIY1dX8fBOTawe4xghMzQEMpmThnyKkzjtymjVvr6yF3SWIzf6xEXhPcmNNWmRmik/hZ
 IauiNVPFm2hdQs0j12I4Ujgxq5UjLtyJS/fTA0bGkq+Z3EnSaa2ureYNoRq4YkrrD4RfeCye
 1GcRZbirhFc3y6pTA48jHgrMjqtvJv+hRlzjmmQeW1yoHTucsZ13R7D5dbYSJa9xxI+TTJjw
 XnSD1m4ZJyy+MmM0ozEqqa4Xn6gUZtadW/qy5mBvW21/z8iDRq6lvG10trpdGpymQryzdp3T
 mPlqBjmY4/k/7u3O6RrcwFkCUT95MxzBoxl2tFp3tdKgydc38jToTIOii/rPM9e2L7iYXZoJ
 3ZD2NPT7AX/mQViIn+P24PlRyCYy8placO9ZzBe0SY84sZWTaaMueYdx20v+AX+9F+XPasY/
 H9V0/Yl5X8EjvtcvQMsyn7YGbUOBQxDOjSqkR2U7te4paERZWC1cLH22lAt+LLpRLyEvAxYX
 270P5k4GiolpOB2KlHRyzve7o/+ed/fRc0evFuYnl2T6oodYIJ0jfcMiSd9bCjYtGcm1vV9o
 Bhgx5C8s6CYJm8r8K/zUXs6fnXlIsgU/D/ql6NXmM2bipuuEptWETIORJL0TPisHWFapbH9O
 g2JCjF5tmaDFO+VA1qE8Ek/5SGqcdjjJzSNKXIe19knWBSNOBkVnlUPRDtj1p8hSlLwnZanK
 h0moGlLuBih8EsLkL8NVVG3U3+D9l3xMHFuEsfZdUcQtkYYug/UKZDMtLspWXsCodv480rVb
 TbELwVQUTNTAxPCWAqlZ+j0o4Oco6/CV4/cZ7PPeenc+bYYDqnVg8vyg80+uGzSfsSXYis4V
 qJ9hRAFBygmXZyewWpHSjRLxXiUMIjE/lHlq3cx8Jz4qqqOOkqn5JPTWesId4wxplbs2/bFb
 rXIzCdhdWQIjNVVmyKOkuNHmgRIw2Rncz3neVgZnQjKSq+Y2qpeDhpALjh2KNMN9KUkmA9EJ
 c/cjNrxkL9+lP88TVlfBxTnnYmyaMoGLnvYVhuPDVuXNLmAOTzAwt3mKaK6R7pKiexIthq28
 T+FGk7nNz6HmnHnTReqee1LiSiaOlRZtuTfOl51DnP/Sdv9dhChGNpwkCFw3rA+wH/HdCYdP
 TV6b0JRv+iQ4Cdf0ZAdUyRK6ntoK/XBmj7MtbCCbMxM7r0yX2IoxIc4qDwgxrBY7T9JXqlwk
 SrW9Zt1pk2+1/KI0nxhWQZPrTBCgMSKu19jMOPX7MolOz6M8RQT4GGXExlPqcFiD4ilnqlKy
 cXU0o/3Ji1D9d384sYWQcTZYpHiUjJpIV/yFTjYARFQByasLn3ajldBneu683qIst4lp5Kql
 JdEGdo5HBQlU/gdDEpiBtkLJpx6CyglnbCsh8kN/XOirRPVSa2yX7jCUe+OR+riInCVgOscD
 /Pt6az1J8IfO9+js6SNQkZ3lsLGFhiJNe0=
IronPort-Data: A9a23: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
 aTZiIyKrIxXiaI8LCq4R0NoJQ==
IronPort-HdrOrdr: A9a23:fMLWfq3+9V9KxpGCceZ/SwqjBGwkLtp133Aq2lEZdPUnSL36qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFg7X5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YFT0EUMr3N5DZB/KPHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:K50ly2xTx2EkNFhsRw4vBgUQPsAhTWaej07dLneaGHhEZaPNUlyPrfY=
X-Talos-MUID: 9a23:DWYTvQi+jSK71H+B29Ga48MpHZdSz4CIUwMxl5Atqs++FnB5NW++tWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,219,1677538800"; 
   d="scan'208";a="54048499"
X-MGA-submission: =?us-ascii?q?MDHNkSerJb9j+9PeUYNVgqI1gm/1hgBXUiA1QX?=
 =?us-ascii?q?YBBFyvzPzdAr8WZz8l1+kSggz6qRx2pY1g37Bymy5fW7Uu1J/cZdSGaN?=
 =?us-ascii?q?1MTaJ7rzPfXP6Y8g3ELTGKCd6CwfzIMOQ5Ed38b3MpIwHBbyOL9JVv2n?=
 =?us-ascii?q?BINDEi4q2ulPadRyvjf0tT2w=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 21:34:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682192083; i=markus.elfring@web.de;
	bh=hxPWUP6gSYIk/Xrp5Wx6LNlET2MUDOh63rJHlB0wOIc=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=iQUtwyGws5ZeHAC48YRihbZXx3ws0hr/wrEhMdhSVaCe1upabGyW+2dn3GYatl2Ix
	 1/snJRDQnCG/dJrmCh9w8wWaUa40tLldm3xrJfQ25P3QM39jMbGoowj7/aETNWZFAK
	 Xwm00YXPR+wc0cJfuNxrMEN/Z4xXHRKnMkNC5w8NIdfh7Tlj9Sa/Lr338snXoPodVH
	 y0C6qy7FCmQwjyO/1rtP07CrmGvc5bvjEDd83I76meII0PpwFDdkctJKWxZA6DNP5I
	 uFkKb32IXm1QbbQjidT55ZqL+VWlXy/rGvJ4BkZNSE549ORwltjvkXwD6tB76pJT5t
	 LLmkFqYDTa5iQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mty5w-1q9DKx0X1A-00uPYs; Sat, 22
 Apr 2023 21:34:43 +0200
Message-ID: <4285b7fb-00d8-8273-1bc5-bba31b94484a@web.de>
Date: Sat, 22 Apr 2023 21:34:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>,
 Thierry Martinez <Thierry.Martinez@inria.fr>, cocci@inria.fr
References: <037507d2-ab0a-7d93-bf3b-10e51e70fbc6@web.de>
 <alpine.DEB.2.22.394.2304221031370.2766@hadrien>
 <e170b7fd-c7ff-c3cf-db35-0427833a8215@web.de>
In-Reply-To: <e170b7fd-c7ff-c3cf-db35-0427833a8215@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rNKHmnNp2YKtj/FNN2b2i9nidhrLrL8F2UvmcTXtcCxVpZAJEht
 q78UcoBxCoh6k/m+aDiFUxlptRvEuRkQul5cVGcFFmb+PXlnhPGb0FSIxogXONpFxVjSHg9
 5OTsiepfEoD9ZYTIZ6KZV7Gyha7v1VQep+BJq3jhxz7bkPpotuGPzWy6Np2ovkVdabamhax
 +d84JgGdVsRa8HGiI7fTQ==
UI-OutboundReport: notjunk:1;M01:P0:f5hnWVnsyl4=;NqFSpp1NsRLPBxdFDQW3S9T1sLc
 d+qbj7tQ+aIKQVxNnaiw88Fdmagl8ES5ZeUowSYciywhF1Sf7OdQNdYOXMl6/WkbO2HcCF+Z9
 1AXE5nPbP09fjd0hGinnmu6CUbtIKRGLzhWjJgdeipnLLlQMcm0KQiaR4H0i3/QjrnZmisvHg
 kKhYMDdXJsOLVXLm9Gi1i3pfvMo8SkxHswiYjLP5YTnnz6pDmEqKueCD50fqDIVimeP/QLIZt
 Pg4h7ENasaR5YdUxpK0mSli4vllipmr85atfaFd2I0pCLGSe5CfPbQOCRIGGs5vPzRt2+zM3n
 tPwDNDQWG+QlS5JyWVDWkyAssVgrB2/G8tZnFkay2upHMdBWmTJyXMvTCVbBO574PCbJjWCZ5
 xzUzX5frVBUnFaozy15pypGvYy6xd7juOjpQLVAnHjsZZKGOLUKOrkC4IA7KONwAGp45ox2SL
 9KaSXHo0yZ+H6K1Icc8LUsRif5xTjpj1RFcHvWyMlg96TNWAyezWPEWW8L0S2q5kivY/TmWdR
 a8KIZQfm/sXA+CZjhi29gay/h91yz33AEvzc4ArubQUGNb6TjWmg3N2gqa2TPc6kGZq7eyPyI
 l6XKpqRY+WmYaHwuTHa0mdsqGgPclT//kp0vdm1P8CPFaQnPKo0hBz8Lmr2nNWaHjC/mUqrHx
 NeQ0H2Dz/sibM+z0OF9WUcVf9Z4k+J/RAe8fUu798WtALtUI6Lh2jvqJxixRIKUjBHdrwI2uP
 k6B7lmXJApUvA8XSKVU8SrNO8IIbzrIwfDvWaUJ7aw+m2vnI/PvNzd8Q2ePlX19B0tfDTClJx
 iUszN5XjDmFiDLCFWNP/qCzIjij4eZFccUmCk82ZRcMQeeMR54HbwAtymwDrs2ATO23ousKDJ
 /nj0iDAXP2z2N5HhwlpLOeYYafoFc9VD4ddxQIdc6Z8MFgQ6b5wenqQXpoFz+SapoaeaXSXZq
 lxzNcA==
Subject: Re: [cocci] Checking data processing order for SmPL rule
 evaluations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1121
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/4285b7fb-00d8-8273-1bc5-bba31b94484a%40web.de>

> Another corresponding source file example:
> void f(void)
> {
> action(x, "X");
> action(y, "++");
> }
>
>
> How reasonable do you find the following test result?
>
> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch check_s=
tring_literal3-20230422-debug.cocci string_literal_usage4.c
> =E2=80=A6
> text:   "++"
> no match
> text:   "X"
> no match

I find that another detail will need further clarification.
The debug output indicates that data were processed in the opposite order
according to the shown two function calls.
May I expect that the original control flow order should be preserved?

Regards,
Markus
