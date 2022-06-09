Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E398C43334
	for <cocci@archiver.kernel.org>; Thu,  9 Jun 2022 20:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/UpvqGjlso6PrvzOcybW4z0wgEYJs43PQCx22kEeGf4=;
  b=FrC1Pq1OXuv7FVZYa6iVdDiBxMzea7H/qj+wHoZfzXIQF6fnoPN4mVXd
   8zP3wPcssBLVPlViP0rKEDCvr/BjxESYTLVG7TGW0nj3Jc/qCjzYrExrW
   5D8fBhGTZhwtguWY3r8wJJQz0NeRn5TDf7dcwbhoZioGs6pHaWQAQ8xh2
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.91,288,1647298800"; 
   d="scan'208";a="40298500"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Jun 2022 22:44:55 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1D505E032A; Thu,  9 Jun 2022 22:44:55 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3CBCFE010B
	for <cocci@sympa.inria.fr>; Thu,  9 Jun 2022 22:44:52 +0200 (CEST)
IronPort-SDR: 5IMSGbu+H2zr13murcS8rXMR9FcprIkk3yuznrHitK8tReySTuQ5VDmZqmWlLIy2p7AIFTEUmR
 z35xsyRPJoD0JkGLVq3t7idbHYIHtWbB0XP5c0vH11oeDF6mKXwu42OqyusXQahFfgMBrVvMzx
 IIMIXOXV9fUBEB9CSXl3A3NNXufpr7MxKHRn27tEVaeStPZItj4IrFkOBHIQhiVJJoPA3bjUxR
 CLE/HYGcMj/AKKVArFbpCAEqQ8N/5WlhlhDw5+54gZ7sJR8Vo4lMzhM+jy1aWOEITiJzXfKKEZ
 cVtAOJA5ioEOypUeZwxyWZyo
X-IPAS-Result: =?us-ascii?q?A0BUAACiWqJih07ASNlaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YIjgVcuBAtEhE6REYQhhwmHG4weCwEDAQ0/AQIEAQGEeAoChUYCHQcBBDMGD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEMDQkFCAoHDhAFN?=
 =?us-ascii?q?gZeBmQEgUsEgXQLNA2CNSkBg2QBAgIBIx0BAREmAQ8LGgImAgJXBg0IAQGCe?=
 =?us-ascii?q?YJlAQMNIwesF4ExgQGCCAEBBoRKHywiUoFcCYERLAGNb3onEIFVRIE8glMwP?=
 =?us-ascii?q?oEPgzWDVoJlmBgnBA8DGi00EoEhcQEIBgMDBwoFMgYCDBgUBAITElMdAhIFB?=
 =?us-ascii?q?wocDhQcJBkMDwMSAxEBBwILEggVLAgDAgMIAwIDIwsCAxcJBwoDHQgKHBIQF?=
 =?us-ascii?q?AIEEx4LCAMZHywJAgQOA0UICwoDEQQDExgLFggQBAYDCS8NKAsDFA8BBgMGA?=
 =?us-ascii?q?gUFAQMgAxQDBScHAyEHCyYNDQQcBx0DAwUmAwICGwcCAgMCBhcGAgJvCiYNC?=
 =?us-ascii?q?AQIBBwdJBAFAgcxBQQvAh4EBQYRCQIWAgYEBQIEBBYCAhIIAggnGwcWGR0ZA?=
 =?us-ascii?q?QU2JwYLCSEcCh8LBgUGFgMjcQUKPg8pNTY8LyEcCioGIgEbApkIxWs0B4IUg?=
 =?us-ascii?q?T2BRAyeLQYTLYNjAZJtDgaRdpZqpzOBd4F/MxokgzdOAQIBAg0BAgIDAQIBA?=
 =?us-ascii?q?gkBAQKOHRmEDIotPzQ7AgYBCgEBAwmFRwEBiRMBAQ?=
IronPort-PHdr: A9a23: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
 t3Iib61NzpItd7Zr5N0Og==
IronPort-Data: A9a23:+uaIh6I99gZtNdu1FE+RuZMlxSXFcZb7ZxGr2PjKsXjdYENS02ZUy
 mAZWG6PbKmDNGSjKY11OY3koUNUvpLcm4NqSAod+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefSLlbFILas1hpZHGeIcw98z0M68wIFqtQw24LhXVvc4
 YmaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhwfFBz
 9NHiaeMEiwzFavqk8hEAj4JHHQrVUFG0OevzXmXtMuO0wvZfnGqz/gG4EMeZ9RHvLktRzgfr
 7pHeFjhbTjb7w6y6JeyUOpxnYIOKMfxPYUQkm5tx3fVAJ7KRLiaHf6UuIIHhl/cgOhpJvTMQ
 /EwZwB0YRrFXzRJPGUaCLMHybLAan7XKmAE9gvM+8Lb+VP7xwt627nFK8vQYtXMRMNPn0/eq
 Hiu12DwHRgeMPSNyD+P6Hvqh+nVnCq9Vph6KVGj3vttnUHV2WEZThEbPbemnRWnohCfa9VZI
 XAvxnEFt4M00keHF4jaDhLt9RZooSUgc9ZXFuQ77iSExazV/xuVCwA4c9JRVDA1nJJvH217j
 Tdli/u4WW026NV5XFrHru/8kN+kBcQCBUMvDRLooCMA5MT/5p4+hFTDQ76P8ZJZbPWlR1kcI
 BjQ9EDSYon/a+ZVj81XGniZ2VqRSmDhFFJd2+kudjvNAvlFTICkfZe0zlPQ8OxNKo2UJnHY4
 iVYxJnPsLtWUsvT/MBofAnrNO75jxpiGGKN6WOD47F9rlxBBlb+IdEOu2sWyLlBaJxdI2WBj
 LDvVfN5vcIPYiLzM8ebkqroRZ1izK78GM7jW+ycZ9UmX3SCXF/vwc2aXmbJhzqFuBF0z8kXY
 M7HGe7xUypyIfk5nVKeGrZFuZd2l3tW7T6CFfjTkU/9uZLAPyH9dFvwGADTBgzPxPjY+1q9H
 hc2H5fi9iizp8WnOHmNodZLdwFaRZX5bLivw/Fqmie4ClIOMAkc5zX5mNvNoqRpwPZYkPnm5
 Ha4VhMKwVbznyOVNgiALHxuMeu9UZF6pHM9HCotIVfxhyl9O9nytv9HestlZ6Qj+cxi0eVwE
 asPdfKANfITGD7JzDIQMMvmp4t4eRX33g+DZnL3YDU2c5N6aRbO/9voIlnm+CUUUHiouMF4r
 7D5jlHXRp8KRgJDCsfKaavzng3r4iVHwLp/BhKaLMNSdUPg9JlRBxbw1vJncdsRLRjjxyeB0
 1jECxkvpd7L/90//u7PiP3WtIyuCeZ/QhFXEmSHv7a7MS7WojiqzYNaCb/aeDfASCXr9a/ka
 egMl6PwN/gOnVBrtYtgEu83nPxkuIa1/+dXnlZ+AXHGT1W3Ebc+cHOI6sl4sPEfzLFuvwbrC
 FmE/cNXOOnSNc65QkQdIhEpMraK2f0Ow2CA6PMoPAPl6SUx8LfeCRdeOByFiSp8KrppMdp5k
 Ll755NMs1Sy2kgwL9KLriFI7GDSfHYOZKUQsM1ICoHcjAd2mEpJZobRC3Ot7ZyCAzmW3pLG/
 tNJaGv+a7VgKo7qdn0uCT7S0OAbiZlmVNWmCrMdDwzhpzYHrqZfMN5tHfAfUQlfiBlKuw62E
 nY+LFV7fM1i4B8x7PWunAmQ98VpGxCTvED8o7fMeKs1UGHwPlHwwKYB1SphMazXH6+wvtSWw
 V1A9FvYbA==
IronPort-HdrOrdr: A9a23:y9vWW6C5xhNG8G7lHemI55DYdb4zR+YMi2TDGXoBLCC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QF5SWY+eRMbEVt7eZ3OD1KbcdKMLsytHSuQ4y9QYWcelSAZsQkjuQgWugeHFLeA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,288,1647298800"; 
   d="scan'208";a="16365572"
X-MGA-submission: =?us-ascii?q?MDF81lWzbmdUIVyrIAW0NRjJiJ7NvY3ybno9GQ?=
 =?us-ascii?q?yEBXQaJy0vOmqbVutnM4lN5hf0DUatkvT0XcAQRKreP+QHO9LgbmAA6v?=
 =?us-ascii?q?Gio7jQa5UU2mEtImfP2lmv3AM/43chCX8drO7rmbtLFFoj1EJ0tbG7tE?=
 =?us-ascii?q?k1+V6os9qvl5FfYWQpR4YUBA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 22:44:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1654807489;
	bh=j7mmTIvOl2+BXtZGyyayXYhFLi5f6cO3+vAt47XHzv4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TD1pCctVsYOlCH5zxUKCnqpR9fQiupPsMFFRX4LFkRwM9xTy8BhmZZFyUh+6r2okA
	 5I6EmTNuJhhIu9y7nBpWmdCVMGDRU/pqJY5zdyecktVeVnSwurpLIQOW4kv+piWZl5
	 Pi+PRnh6E1lD6i7tFpScwjPjtRxCXbnV6lAa8PAA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.155.143]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MD5jv-1nquZt45HF-0097l1; Thu, 09
 Jun 2022 22:44:49 +0200
Message-ID: <b7131a29-b82d-1de5-b434-61a91ab38953@web.de>
Date: Thu, 9 Jun 2022 22:44:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, kernel-janitors@vger.kernel.org,
 Nicolas Palix <nicolas.palix@imag.fr>,
 =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>
References: <AS8PR03MB760365A0DE3A8522136471BE93A59@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <415ca02b-9618-b447-6471-6bcd0e2215e8@web.de>
 <alpine.DEB.2.22.394.2206072138160.2960@hadrien>
 <15a253a6-469b-9632-8c7d-983554604451@web.de>
 <alpine.DEB.2.22.394.2206091740520.2380@hadrien>
 <da86bc36-36af-7bd7-6bee-861e160ba6a4@web.de>
 <alpine.DEB.2.22.394.2206091824560.2380@hadrien>
 <8f9bbad3-1812-6448-52e6-2570e6368f0d@web.de>
 <alpine.DEB.2.22.394.2206092139370.2949@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2206092139370.2949@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:We+o8XFh7O5a3ayIwdK5LKPG+hCDGBtUEOQoBddZY6FgG55mAbu
 hkdoHNsY5A/EH0TiFhEWsY+cetL0pwNi3kWXf1vXSSieoMB5T4KFIM5U97VsIfFBseTruXB
 SR3zOFaVC7hkUnCzr/XfPg/C2C33y69ntLoGdAuOMyJu2259euuLKe6HZXdUt04J+1VvmAr
 hheKaFslzEhu58zvREraw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dJKLJTe7/cA=:+owsoc+h0dO6UXYKEv9XBH
 o3jMl/hYpcHwnSOcTNO+SahyPYePO89f6z88oWdpYQIp82qF2UVzSHfjY5IYdBrtxDDeyYAEm
 oSYqseRGic9UHSwAs0NHINfw8EJxPFWWWcQGlesT+NjzfnAwa2MyxVtG1YitE1JcY7Um8c1fP
 y3sq1PrcGIjt9gZgqWW2NLpEOIMORAlWhxGN6RY2TTf4MkrurCtn7ChONSyvtpVlAToUDItZp
 a7Viy3ei0zd1VzaoaNlmeQdf8kVCxgr3uTrOpt1mSVMOnhe84jrJ/P0j9+yY7d+RpmuqQold4
 gdhs2qguQmeQfYLnsw2pUTsCT4FWP7Au+MCMeya2t+fadpauy2FyDFejGaUEoc/4Q+4lGV5hW
 USqujFs9IAXPVuv30NqjOQgFZu3zdK0vE2ICQUksap5RcxxnFJD2iJBe8/vq7LGAgpuo5jf8g
 bGW1+HhuLMUNNpGA22Hv2s5Mz3IELsDTgLUccmFR5mb8uEM9OBXHLC/EU1w8aVFSUqW0ifUIA
 oqLAJg0Tm7VEM39sQYHaIwjfJxN9kBbByuwjSVmwn27vBrn5CnLGwxFxI3CyPcWKdyT0e7Bvm
 M2HjjzlgkOmg5wSZg1p5bnqliVjyEQhTWWGXmc1HjTtXXKRZD8+FbwD5bEn/1TEvcAh4n+KS+
 mxd6mh76Gv26AjPnrjIOXHx441Ca7wft4KZAMXHahZvNpruJrZj7ylB2lUGdWV6r5hj/Bre47
 NdX4Kh2kJdFyrREd9GwFWWc4JnJUcL3YmaFAysnktsn+RipMxc/yxGMCIB2qQd4kI2g8x8y/X
 1O4FKiE+K73RmN6qXo6P+MncG4e4kS825yIq849btlcKCWfsSJyYyjZc5Sqr9zbcP3Zh46rzr
 PeeBRd4ZIOdKEtPPf8VPgR09yiBlthuuATBscuiT0vdjnFCpKpr3AyXNPExINTaoukPjo2Ff6
 EJBtgAbHUrh/79ZzqiAuZKzy89OAEpE79mgogdi7L3/7LqZeloP7oNgSbna4wNsGNPZ7pmTTo
 QyYEFMa5wya8nC15g4BJ/9yj14fw4l5ai83sJlhS/aZ8062U1tIdG95E1kxrgqmW4wpKaF/yR
 IKprVLG9ZY4QuIdScTJOPoEd+ZQ6FEFPPw/oYt8ioImH3o9wy3Mio8oBg==
Subject: Re: [cocci] coccinelle: ifaddr: Find address test in more complex
 conditions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 432
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/b7131a29-b82d-1de5-b434-61a91ab38953%40web.de>


>> I would expect that the usage of the address-of operator within extra p=
arentheses
>> should also be marked for reconsideration of such source code.
> It's not a test expression.  The bool type is not relevant.


It seems that we stumble on opposite views for the involved expression =E2=
=80=9Ccomplexity=E2=80=9D.

Regards,
Markus

