Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03778C00140
	for <cocci@archiver.kernel.org>; Mon,  8 Aug 2022 10:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2pifeV5fxdcRQVqv+VRQcmV/Ce34621ZJIlxk7X7aK8=;
  b=gsQIz2fJYvGhoymBEyoJlcf9VB5dRXWZxjfo5S1qKRU2QEHu/+YGRc/n
   PCxNR6m7ffljAetX9d1bWNNt/CBW5JUZE6MhgevuM5cOC6m5LBk3BK5rL
   w9mS5e7QS4oZNR9dTbrXi2mtrxYfksSEC8+k7Uf9Trktn9M1i5wBHsxZc
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.93,222,1654552800"; 
   d="scan'208,217";a="48245157"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Aug 2022 12:36:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C3A52E0235; Mon,  8 Aug 2022 12:36:43 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A33D6E0235
	for <cocci@sympa.inria.fr>; Mon,  8 Aug 2022 12:36:42 +0200 (CEST)
IronPort-SDR: lResfc0dR3M94Za+Nu29OxFoqoldAvEo4BhmqjaUxrb7UqRhfwgjver5Ir4ub3JbA1ZDlTl0xn
 nbffFycylulON6wx1ob9OIPYn+Ekd6unGq5hlwQjCO99qwHiZ74jLD+zOslf4j7xApu0gml24s
 7ZDn5aXZ8xMyBjePHmm8XaP3iHHzVe5bm0PN3IS15BQTXzvd2u7pllI/EIa5zpvk+tqwYplZAe
 QhYBfVa5chwtHzGFiPKoDbp+lsZd6OreVojdVMbpK7Md54a7pQLLNtG+PYj+dNv0gAXX3vWz4M
 q+CHk1w0cCNa3AGgJ/aaxraw
X-IPAS-Result: =?us-ascii?q?A0A5BQAk5vBif62nVdFahHyBVy8EC0WEToEjj0UFi1WBB?=
 =?us-ascii?q?pI8CwEDAQ1CBAEBigECHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QECBAQBEwEBDQsJBwgKBw4OBWABYQMBRIFPgU8lCwMxDYI1IoQEEQQZARseA?=
 =?us-ascii?q?xIDBgEGNwIkAREBBQEtEBqFSAEDMgONBIx9gh+BBEKLMn8WBReBAYIJBoROC?=
 =?us-ascii?q?hkoDWcDgVkCBxKBK4ZBAhpHTQEBh2OBZUSBS4JEMIVPgwmCZQSYJwQHAwQFA?=
 =?us-ascii?q?QYOAwMCIQECAUQeAgkDIxEDCxARFRgECAEEAwEBAQ4CBQcCBgMDAgICAgUBA?=
 =?us-ascii?q?goCAQIEAwYGAgMQAQIEAQoEAgMIAgcDAgYECgQCCAIEAQUDDQEDBQIDAQEDA?=
 =?us-ascii?q?wIEAQIBAQMIAQMCAwMCAgICBQIDAgICCQMEAQcDAgMBBAMBAgoEBAMEAgIHA?=
 =?us-ascii?q?gcCBAcCAQIGAwUGAQECAQcBAQQKBAMDAwMCBQICAwIGEgYGAgQBAwQCCgICC?=
 =?us-ascii?q?wIHAQECAQEBAQIDAgcFCwEBAQMCAwYFAgEBAwgGAgEEAQUDAQQFAwcCAQUGA?=
 =?us-ascii?q?gkDAwkDAQEFAQMEAwMDAgcDAQIMBAgDAwIDBAICAgIBAwIHBQgEAgkCAgIBA?=
 =?us-ascii?q?gIGAgEDGgECAwUCAgkLAQQCAgMBAwEBAggECQQCAwQCAQEDAgECAgEFAg4GA?=
 =?us-ascii?q?QEBAQIDAwECAwEGBwIIAhwKAQMDAwICBQICAQIDAgIMAQEEAgECAQIGAQMBA?=
 =?us-ascii?q?gIDAQMBAgIDAgYJAgQBBQMDAgIDAQEFDwUCBAIBAgYFAgEBAQQBAwQEBgICA?=
 =?us-ascii?q?QMDAg4CBAEEAQIBASMDBAIDAQMXAQIBAgMDAwQGBwUCAQITAQIBAQEFAQIBA?=
 =?us-ascii?q?QMEBAcKAwICBAMDBQEBAgMCAQEBBwwCAgITAhMDAQYBDgUUAwIEAgIBAgIKA?=
 =?us-ascii?q?wECAgEDAgkCAQIBBSADAQEPJAEBAgICAgMEBwIBBAYDDQICAQEBBQYNAwIDC?=
 =?us-ascii?q?A0CBwMCAQMFAwICBAECBAoJAQICAQIEBQcCAQgEBQ0FCQsBAQIBAwcEAxECB?=
 =?us-ascii?q?QMFBQMDAgEKBQIDAQIBAQMEAQMEBgEBAgMCAgEGAgIBAQMDBAMBAgYCAgcCA?=
 =?us-ascii?q?wIBBAIDAwEBAQQCAgICAgMDCAMCCAcFAQYBAgEEAwICAQIHAQQBCAIBAwMFA?=
 =?us-ascii?q?wQBCgMPAwUDAQMDAhQKBQEFCAYJAgQFAgUDAgQCAwMCAggDAgQDAgsDAgYCA?=
 =?us-ascii?q?gIHBA8HAgMCAgUCAgICAgUEAwECAgICAgIFAgQCAQUBAgIBAgICBAECAgcEA?=
 =?us-ascii?q?gMBAwQOAwMEAgIHAQICAQYCBwMBAgEEAwEBBAIEAQIFAgQBAwECBgIEAwoCA?=
 =?us-ascii?q?gMCAgIGCAMDDAkCAwUCBgEBAgcEAgILAQYCBwICAQIDEQEDAgEEBQUDAwMJA?=
 =?us-ascii?q?gIDAgQCAgoBAQEBAgIBBQUCBAcPAgICBAICAgECAwICAQECAgUECRIBAQIDB?=
 =?us-ascii?q?gQGBQMCCBgBBgICAQECAgIDAwIGAgECCAIEAQQFAgECAgICBAEDBgIDAQECA?=
 =?us-ascii?q?QICAwMCAQQCBAMDAQECAQICAgMCAgIDAgIBEAIGBgECAgICAgMCAgECBgECA?=
 =?us-ascii?q?QIEAgcCAgQDAgECAgUCAgIDAQEGAgIECwEDAgcGAQMCBwUCAwECAwQDAwsFD?=
 =?us-ascii?q?AgBBQEDAQUfAgMCAgkCCAIBBQIDBQEPAwICAwICAQQKAQIDBQIEAgECAQQJB?=
 =?us-ascii?q?wIEAQIRAQZkmGGDeZJuEZAxiziTEQeCQ4ERBYE/iECWGjKoZ5cAohsTgUKDW?=
 =?us-ascii?q?BAjEoFDgX5wgQGCNk4BAgEBAQ0BAgEBAwECAQIJAQECkg+KZjwxOwIGAQoBA?=
 =?us-ascii?q?QMJjwcBAQ?=
IronPort-PHdr: A9a23:oNRFZBC/5Q/t+Yd6x9gbUyQUEEkY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua82ygWSDc6BurptsKn/i+jYQ2sO4JKM4jgpUadncFs7s/gQhBEqG8WfCEf2f7bAZi0+G
 9leBhc+pynoeUdaF9zjaFLMv3a88SAdGgnlNQpyO+/5BpPeg9642uys9ZDfeRtEiTS+bL99M
 hm7qRjau9ULj4dlNqs/0AbCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3T
 bpDDDQ7KG81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUjmk8
 qxlSgLniD0fOjE28G/ZhM9+gr9Frh29vBFw2ZLYbZuPOfZiYq/Qf9UXTndBUMZLUCxBB5uxY
 ZEVAOoFJ+lYqYj9rEYNrRu5GAajGvjvyzFSiX/sx6I61fkqHAbe3AM6G9IBqnLUrNTvOKcRS
 u21w6zIwi/Cb/NSwzvy9I/IchU4rPyKQLl/ftbfx1M1GAPZklWft5blPzWN2+kTt2WV4PZtW
 P6ghWMkqwx9vDmiytsvh4TNmI8byl/J+CR5zos2JNC2RkF2bcClHZZUtiyXM4R4T988T29ou
 Ss3zKANt52jfCUS1pgr2xrSZ+aEfoWI+B7vSeecLDViiH54er+yiRC/+lW6xOLmTMm7ylNKo
 zJFktbSsnAN0ATe6s2dRft8+ketwDGP1wHO5u1dL0A4iKjWJpA7zr4/kZoTtkvDHivol0nsk
 KCWcUAk9vCp6+ThfLrmuoeRO5Fohgz6KKgjmcyyDf4lPgUPXWWX4/mw2b/t8EHhRbVFlPw2k
 q3XsJDAIsQbo7a0AxdP3YYn8Rm/CTam3M4bnXQcI1JFfQiIj4ntO13UPP/4CvK/j0yqkDhw3
 //GJKHuAo3RLnjfl7fsZatx51ZGyAUv1dBf+45UCrYZLf3vXU/+qMDXDh4iPgyvw+fnDc192
 ZkEVWKOBK+ZKqLSvkWS6uIhOenfLLMS7T36IPMkz//ol34w31EHLoez2p5CUHm8F/Jna0aeb
 Xf3nd4bGGFC6hI3SOXsiRuBeTFWbne2Gak742doW8qdEY7fS9X10/S61yChE8gODognIlWFE
 HOyMp6BR+9JciWZZMlojj0DU7GlDY4nzxCn8gHgmPJ8NuSB3CoeuNr40cRtofXJnEQq/Dh9C
 cXb0EmCSmh1miUDQDpllLtnrxlFw0yYmbN9n+QeENVS4/1TVQJvLZfYxup7TdPaVQfIf9PPQ
 1GjEZ29GT9kaNU3zpcVZlplXdWviheWxy2xH7ocjKCGHrQx+6PYmn/wfoNzkimdkqYmiFYiT
 41EMmjOardX0Q/VCsaJlkyYk/zvbqEAxGvX82zFy2OSvUZeWQo2UKPfXHlZaFGE5dL+rljPS
 bOjE9FFekNI1NKCJ61Wa9bokUQORfHtP87ban6wnGH4DAiBx7eFZo7nM2sH2yCVBE8BmgEVt
 XGIUGp2Tj+op2vYDXptPV3qakLot+J5rTLzT0M5yR2Lc1w0z6C8qVYegf2RTe9W36pR4n9w7
 WUpWg/jgJSPVIHTwmgpNL9Rat48/lpdgGfQtggne4elM7gnnFkVNQJ+o0Lp0RxzTIRGi8kj6
 n0wn28QYeqV1k1MczSA0NX+ILrSfyPq9RSmba+Q2XnR1d+X/uEE7/Fy+DCB9Em5U1Ev9Xlqy
 Ywfy3KY75PLSgk6Xpf4U0Jx/B9/7eKScmw24IXa0mdpOK+/v2rZ2t4nM+Aizw6pY9ZVNK7s+
 BbaK8QBHIDuLeUrnwLsdRcYJKVI86VyOcq6dvyA0artPeB6nTvgg34VqIx610uN8WJ7RIuql
 94dyvWR2ArBVB/ziV6gtob8noUMaTwJH2W5wDTpH8YLPvw0LdtNUDnxZZTonZ13nNb1VmRd9
 UK/Cl9juofhYheUY1HnnEVR2UkRvX27iH69xj1wnSsuq/nX1yjPzuL+MRsfbzQTFS8y0BG1f
 9fy1o9BDy3KJ0AzmRCo5Fj33f1eraV7dSzIRFtQOjLxJCdkW7exsbyLZ4hO7okpuGNZSrfZA
 xjSR7jjrh8dyy6mEXFZwWVxbzius5P42R9Sh2eULXI1p33cM5IVp1+X9JnHSPhd0yBTDjFxj
 TDRBx6/F9as9NSQ0ZzEt6rtH3LkXZpVfy7xyIqGvybu/mxmDyq0mPWrk8HmGww3gkqZn5F6E
 D/FpxHmbsz3xry3ZKh5K1JwCga2uIJqX5tzmYwqiNQM1GgG09+LqGEfnz6WU50T2LqiPiFQA
 2dam5iPvFejgAo5cjqI396rCCnbmJA6IYDkOiVOnXtsp8FSVPXKsvodxXEz+hzg6liJBJo11
 jYFlalwtjhA37BP6FJrlmLHWvgTBRUKYnaqzkjOtoHk6v0QPTbncKDshhUi24n7Uffa5FkbA
 SicGN9qHDcsvJwnYBSVjyK1use8P4OJJdML6k/NzEyG1rkJbsp3zr1T22JmIT6v5yV0jb5my
 0U0jdfi+9HYTgcltKOhXkwCb2OzOpNVo2C3y/4Zx5fe3pjzTM84RHNRB8quFqjuSHVL5LzxP
 gKKWlXQs1+9HrzSVU+a4UZi9TfUFoyzcmuQLz8fxMljQx+UIApehhoVVXM0hMxxEAfi38Hnf
 Epjg1JZrlflthtBzP5pPBjjQy/eogmvcDI9VJmYKlJf8AhD407fNcHW4Ph0GmlU+ZiorQrFL
 WL+BUwAFWYSRkmNHEzuJJGr7NjEtu+ZX6+wdqSVJ7qJruNaWrGDwpfumopq8jCQN9mea3lvC
 /povygLFXt9Gsnfh3AOU3lNz3OLP5Pd/UnjvHQo9ZPakryjQg/k6IqRBqEHNNxu/0rzmqKfL
 6uKgy0/Lz9E15QKzHuOyb4F3VdUhTs9ElvlWbkGqyPJS7rd36FNCBtOITt6MMJO7uQ/9gZIM
 M/fzNjy0/Qr65x9Q0cATlHnlsyzMIYSJHqhMVrcGEuRHLGPJDmOxMCuJK3lFuYWg+JTuBm9/
 z2cFgWwW1bL3ymsXBepP+ZWiSidNxELo4CxfCFmDm37Rc7nYBm2WDeWpTg/wLlxgXKTcGBFb
 mM6fERKobmdqyhfh6cnc4SkxnVgJOiA3S2e6ruAQn75mfRuCyVw0eld5SZjo4Y=
IronPort-Data: A9a23:ZNGY1aJ0vh2AJi+MFE+R4JMlxSXFcZb7ZxGr2PjKsXjdYENShTdWm
 GBLCmrVO/qOZzenf953adu28R4A7ZPWmIVgSwYd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefSLlbFILas1hpZHGeIcw98z0M48wIFqtQw24LhU1vd4
 YqaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhj9Eq1
 txAuIGLZVkHFf2QxbsaSwJ1KnQrVUFG0OevzXmXtMWSywjBciKpzawxVwc5OooX/usxCmZLn
 RAaAGpVP1bT2qTvnu39E7Y37iggBJGD0Ic3onhkxDfYS/UOTpXKQqGM7thdtNs1rpweR6qDP
 pdFAdZpRCmaWhFmYgY9Mcszkdyoi3nfMCcHgWvA8MLb5ECKlFAruFT3C/LefdeBRO1Oj0OAr
 yTH+X74C1cULrSiJSGt93utgqrInHq+VttNT/u38fllhFDVzWsWYPELabeliem40VC3Vt9CE
 GBK1AF+8fVt81SwY+CoCnVUv0W4lhIbXtNRFcgz5weM1rfY7m6l6o4sHmEphDsO5J9eeNA66
 rOat4i2WmE34dV5XVrYp+jE92rjUcQABTZaPXdscOcT3zX0TGgOYv/nS99iFOuyj4SwF2ivm
 HaFqy8xg7hVhskOv0lawbwlq2P0znQqZlRujukyYo5Dxl0hDGJCT9LxgWU3Fd4acO6koqCp5
 RDoYfS24uEUFo2qnyeQWugLF7zBz6/bbWyM0AE3RcR8q2jFF5ufkWZ4sG8WyKBBYpZsRNMVS
 BK7Vf55v8INYiP7PcebnaroWpx2kcAM6ugJptiNNoYUCnSAXACA+y5qaCatM5PFwSARfVUEE
 c7DK66EVC5EYYw+lWbeb7pDjNcDm39mrUuOFMiT50n2itK2OS/FIZ9bagfmRr5it8us/l6Fm
 +uzwuPQlH2zpsWlMneJmWPSRHhWRUUG6Wfe8pAPKLbfels4cIzjYteIqY4cl0Vet/w9vo/1E
 ruVAye0EXLz2i/KLxukcHdmZO+9VJpztyNpMiklPFLu0H8mON794KAafpoxXL8m6O0zla4uH
 6dZI52NUqZVVzDK2zUBdp2i/oFvcRKcgwjRbSeoZT4IeYFtGl7S8dj+cwqzryQDV3LltcY3r
 7C6+BncRJ4PG1ZrAMrMOaCgylqwuT4Wn+crBxnEJdxaeUPN9ol2Knyp3qVnfZ1UcRian2mUz
 QebBxsctNLhmY5t/Ymbn72AoqeoD/B6QRhXEmzd2rC8anvX82+l9olfCbracD3YUlT0z6Wsf
 +Biyf/xba8cl1FQvosgSrtmwP5s59broLMGnA1oEG+RMwauA7JkZ36HhIxB7/IWgLBevgSyV
 wSE/dwDYeeFP8bsEVgwIgs5b7TciatFxGGKtfllcl/n4CJX/aacVRkANRe7jiEAfqB+N5kow
 Lt8tcNKuRazjAEmboSPgixOrTjeK3UBV+Agt8hfDta00UwkzVZNZZGaASjzucndZ9JJO0gsA
 zmVmKuS2OgGlxSaKyI+RSrXwO5QpZUSoxQWnlUMEFKEx4jejfgt0RwNrDk6Q2y5FPmcPz6f5
 4SqC6F0GUlK1zJhhcwGWGH1Xg8YW0bf9Uv2xF8E0mbeSiFEk4ALwHIVYY6wEIIxqgqwvQS3O
 JmXzW/kVXDhe8SZMu4aRxt+s/K6JTBu3lSqpS1kdvhp27E1ZDPkhumlYm9gR94Lxy8urBWvm
 NSGN9qcpUE22eD8bkH750SnOWwsdS25
IronPort-HdrOrdr: A9a23:MgC8DKl8pmxov3QmOGPm7zwaeMvpDfIh3DAbv31ZSRFFG/Fw9v
 re+8jzsCWftN9/YgBCpTntAsm9qBDnlKKdg7NhX4tKNTOO0ACVxepZnO7fKlPbaknDHy1muZ
 uIsZISNDQ9NzdHZA/BjjWFLw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,222,1654552800"; 
   d="scan'208,217";a="48245154"
X-MGA-submission: =?us-ascii?q?MDFN7TL1f7WtYPQhBrVw2Ha0De2G45JFyzO5nI?=
 =?us-ascii?q?z74/GoynRhNmErImCSEZf1dXGi3H4dUifY7ShyB4Lck5Gfy+RGJyqyuk?=
 =?us-ascii?q?WlkTZRgHL15nL6/lsyIfby+in87Dtt6IgTVJ8mEshexuiT3t/WhRjyBx?=
 =?us-ascii?q?ah2x5EgqVQD8VCuDPtQI5MQg=3D=3D?=
Received: from mail-oi1-f173.google.com ([209.85.167.173])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 12:36:41 +0200
Received: by mail-oi1-f173.google.com with SMTP id n133so9935786oib.0
        for <cocci@inria.fr>; Mon, 08 Aug 2022 03:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=2pifeV5fxdcRQVqv+VRQcmV/Ce34621ZJIlxk7X7aK8=;
        b=qrfQwtcOFRUENOTy1FMr8vazvoFTYDThgi4aQ9LkQrRcyThEmfiJVytLkNsNnEsp9j
         d7iBojO8T1zF9F01iqVt3fNcdSZL1ar/j91MxIhd7E2uttMpxynNV1FOXbODEyOHrNdq
         P7vRZIW/+NHIBHZNSsLeIwsNj0J9uo0886iWJHqbIGmRJIYP3rYUQ5+Ec/XggDCZu4wp
         srK6tIRAi2bnnag/akHLLLyIMqKj6cw3yIUL8+Xc7tOsnMr9WH2fxVQB5VArtAzH8o3g
         hbtGU8ccyP3cRsQF9rh+/qlMyvQb8XZdevJ733FQGoSSm5f0Z/SGIWk96cZMpLR9rA7i
         hJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2pifeV5fxdcRQVqv+VRQcmV/Ce34621ZJIlxk7X7aK8=;
        b=cvPVB8D7mPtRfyQs4guivOtdO//0LVT70dBma1dpb+6E18nehucSTZbSvYM+hKbHWf
         D/C0bJW3HSlyTO7vs+jwpZVJVafJPehQ96BajGkEZvYlrsMPm+THp1XqWgXPNdAr7Hsa
         ThpAuWpq2PGrRoriIhvkS29V8eSh6HiW0h3fB7PrjzQA+RUnvZaZ5bZ/JrPT5s62dHOy
         /10D55mg4yaFW3XDdkllGSBjVy53PJUWuI5cvK2oOn6VuIiaEqA5OPK2XYuEweByD5aG
         my/ycAN5e6MX+kjWpKM4m0oWRiehd0MVwJ20c3XN+C8d+f25qQF75nFpTGDEoEp2XoJ3
         DuYw==
X-Gm-Message-State: ACgBeo0El6Ek7fnY9N9K1mcQLxHSBsOFQ1lc/B2TJ7yD4h8UWMEOGCOd
	8D/K4+NhHxuBL2ZvFjplgI5wikPhboDEmW7WVEkstVwweh4=
X-Google-Smtp-Source: AA6agR6qaQ6nUgVKMW0NFUX/20Tqfe6TO5uUlkobd7r6GiMl95VBAJ8D2xKUkw9URHx7EnAmFAcri6BMFjI6qN1n5EU=
X-Received: by 2002:a05:6808:1985:b0:342:aa10:287 with SMTP id
 bj5-20020a056808198500b00342aa100287mr7812686oib.234.1659955000269; Mon, 08
 Aug 2022 03:36:40 -0700 (PDT)
MIME-Version: 1.0
From: Palani kodeswaran <palani.k@gmail.com>
Date: Mon, 8 Aug 2022 16:06:28 +0530
Message-ID: <CAASoEDTjytDuj6quFJpmhcppBZxEUXpTOSk5eZDhS8gUm6hAzA@mail.gmail.com>
To: cocci@inria.fr
Content-Type: multipart/alternative; boundary="0000000000002260cf05e5b864e4"
Subject: [cocci] Replacing struct field references with field references
 from a different struct
Reply-To: Palani kodeswaran <palani.k@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 503
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/CAASoEDTjytDuj6quFJpmhcppBZxEUXpTOSk5eZDhS8gUm6hAzA%40mail.gmail.com>

--0000000000002260cf05e5b864e4
Content-Type: text/plain; charset="UTF-8"

Hello,

I am trying to replace field references inside a struct of given type with
references from a different struct (that is passed as an input parameter
for a function).  I have the following coccinelle rule that is not working

@vlan@
identifier p,c,fn;
type t;
struct vlan_hdr *v;
@@
t fn(struct xdp_md *ctx){
...
- v->h_vlan_encapsulated_proto
+ ctx->vlan_proto
}

However, I have a similar rule that works for another struct type.  I am
not sure what I am missing in the above rule compared to the one below. The
only difference I can see in the source code is that the above rule needs
to transform a piece of code inside an if block. I believe the three
ellipsis (...) would handle that anyways?

@rule3@
identifier p,c,fn;
                                                    type t;
struct ethhdr *e;
@@
t fn(struct xdp_md *ctx){
...
- e->h_proto
+ ctx->protocol
...
}

Appreciate your help.

Regards,
Palani.

--0000000000002260cf05e5b864e4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>I am trying to replace field ref=
erences inside a struct of given type with references from a different stru=
ct (that is passed as an input parameter for a function).=C2=A0 I have the =
following coccinelle rule that is not working<br><br>@vlan@ =C2=A0 =C2=A0<b=
r>identifier p,c,fn;<br>type t; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>stru=
ct vlan_hdr *v;<br>@@ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <br>t fn(struct xdp_md *ctx){<br>... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>- v-&gt;h_vlan_encapsulated_p=
roto<br>+ ctx-&gt;vlan_proto =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>=
}<br><br>However, I have a similar rule that works for another struct type.=
=C2=A0 I am not sure what I am missing in the above rule compared to the on=
e below. The only difference I can see in the source code is that the above=
 rule needs to transform a piece of code inside an if block. I believe the =
three ellipsis (...) would handle=C2=A0that anyways?<br><br>@rule3@<br>iden=
tifier p,c,fn;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type t;<br>struct ethhdr *e;<br>@@ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>t fn(struct xdp_md *ctx){<br>=
... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0<br>- e-&gt;h_proto =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>+ c=
tx-&gt;protocol<br>...<br>}<br><br>Appreciate your help.<br><br>Regards,</d=
iv><div>Palani.</div></div>

--0000000000002260cf05e5b864e4--
