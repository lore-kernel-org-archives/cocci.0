Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72815C433EF
	for <cocci@archiver.kernel.org>; Tue, 10 May 2022 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=OEbAM2jxx+Oxcu0OXR2H+BIfgohizDpHMUHgDkeP0og=;
  b=AoFQNx08kFtMfqRFfw//LeXqdCtHpnaLHQXy+QjPK0a3kvC7vY5A+pdW
   smHttCNygQl/gYout0TriN1CfVLiC21hWwvHVvmqkrtvhiAv0vafown2n
   TBTqPPMrmh9DQVQtzRWSbyx21uVK0aED29TjTLVDJsovXs0VYaZaDZcHw
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.91,214,1647298800"; 
   d="scan'208,217";a="35536146"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 May 2022 11:53:53 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7CFBAE027B; Tue, 10 May 2022 11:53:53 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 46B35E0099
	for <cocci@sympa.inria.fr>; Tue, 10 May 2022 11:53:52 +0200 (CEST)
IronPort-SDR: ZL6RamqV0vSHTfCunOokHgvDmDKg7X4y/PWpkxj9bWeYWDVDrOh7tl3rKHfqWoeZPd70SxpJsa
 5aXpLxTaOpH2ApLF2irt99mY7zfG06dFdvU5w1aavhzi0eBJgsHsvj4X7kD9jqHVi4JVzSUZSK
 Z7Xc8iT9iE2loQVBL94UTXV7jKV0jQZnNylu5p14mco3/yBc3rXxBQW7FWY0UylTL9KAPzgYGX
 W0Xg8TxPTQkOXI29Flzgb3Kc0mBZJJjk92qdSBbKixS8RIjq/qaAsC2fb6+uL2t6lvQnAUv6kV
 Wwv8/tUTAM9b86NUwg//J4jO
X-IPAS-Result: =?us-ascii?q?A0AaAwCGNXpif7LdVdFahHyBUi4EC0OEToEjjUOCKIsng?=
 =?us-ascii?q?QWQS4FoCwEDAQ1CBAEBhQIChT4CHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QUBAQECAQECBAQBEwEBDQsJBwgKBw4OBWABYQMBRIFPgXQLAzENgjUpAYNkA?=
 =?us-ascii?q?QEBAgESER0BGx0BAwELBgMCBAc3AgIiAREBBQEcBhMihT4BAw0kkFGPGoEEQ?=
 =?us-ascii?q?YsygRUFF4EBggkGhEsKGSgNZwOBWQIHEoEqhhYCFERKAQGHIScQgVVEgUuCd?=
 =?us-ascii?q?D6EKoNwgmUElFuBe4FxOZMbjgCMfJMLNAeDTIE7BgyIK5YKMZpNjgaWYqFkh?=
 =?us-ascii?q?SsQIxKBQ4F+TSNQMYI3TgECAQEBDQECAQEDAQIBAgkBAQKOKRaDUIpgQjE7A?=
 =?us-ascii?q?gYBCgEBAwmRbwEB?=
IronPort-PHdr: A9a23:8eET9RJZRKUidHs1cNmcuHxvWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCFvrMx1RSQAM2bs6sC17CM9fi4GCQp2tWoiDg6aptCVhsI2409vjcLJ4q7M3D9N+PgdCcgH
 c5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFRrhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTajb75+N
 hq7oRjeusULgYZpN6I9xgfUrndSdOla231kKUiPkxrg48u74YJu/TlXt/897cBLTL/0f74/T
 bxWDTQmN3466cj2vhTdTgWB+2URXHwOnhVHHwbK4hf6XozssiThrepyxDOaPcztQr8qXzmp8
 rpmRwXpiCcDMD457X3Xh8lth69VvB6tuxpyyJPPbYqLKPRxYL/SfdICRWpAQMlRUTBBApihZ
 IcLFuYNIPpUo5X4q1YIsBCwBxSjBPn3xzBHiH/536003eoiHw/bwgIvA8kDv27IoNjvLqoeT
 fy5wavOwD7eb/1WwzD96I3Qfx09pfGDQ6lwcdHLxkkpCgzFlFKQopH7MjyPzOQNtmmb7+x6W
 uKzim4stgZ8rSKrxsgykYnJnZgaylbZ+iVjx4Y5P8G3R1RhYd6hEZtQsTuVN5d3Qs45TGFov
 Tw1yrwCuZKhYCcKz5EnygfZZveafIeG/gjtW/yNITdkmn1lYrS/ig69/EWi1uDxS8u53UtFo
 CRFnNfCuH8A2hjR58WJRPVw/0es1zmP2g3Q6OxJIUA6mbTfJpAh37I8iJ4evFjMECL3nkj9k
 ayYdl089+S29+jqZq/qq5ycOoNulA3yLLkiltaiDek6MQUDWXWQ9/6m273550L5Ra1Hjv0on
 andt5DXPcEbqbS4Aw9Ry4oj9RW/Ayq/3NQWgHUKLlFIdAiIj4juPFHOL/T4Aumlj1uwlzdrw
 ujKPrznAprTMnjOiKntcap55kJGywc+zcpT64xKBr0cOv7/R038ud/AAh88KQO0wuLnCNtn1
 oMZXGKCGrWWMKfMvl+T/eIgOe+Ma5IPuDb6MfQq++ThjWU8mV8ce6mmx4cXaHGjE/RpJkWWe
 3vsgtMbHWgWuQo+SfTmiFuZXjFLfXa9Q7o85i0nCIKhFYrPWJihgKad0yejAp1WemdGB0iIE
 XjyeYSLQfMMaCaJL85gkzwEUKOuS5U72h20tQ/6zaBnLuvO9SECu5LjzsB55/fPmhEq6Tx0E
 8Od3nmRQGFzgmwHWz420btkoU19z1eDybJ3j+ZZFdxV/fNJUx01OYTSz+xgWJjOXVfjY9OIQ
 R6CS8qvBTV5GtAsx94HJUJ0BNymijjC2TCrCvkbjerYKoYz9/f123XqPM97x2zBnIIolVwnR
 MJTNCXyj6py7BPaAYLTlAOSnryvdKIVwC/l+2KKzG7It0ZdBl0jGZ7ZVGwSMxOF5e/y4VnPG
 vr3UexP2mppzMeDLvAPcdj1lRBdQ++lPt3CYmW3kmP2BBCSx7rKYpC5M34F0nD7D04J2xsW4
 W7ALRI3Uy6lrnnFBTpiD1WpaEr29Oh4oW+6ZkAxxgCOKUZm0un94QYb0MSVUOhbxbcYoGEko
 jRwEky62offD9ebvANncL9bJ9g0+lJG02vFtiRyO5WhK+ZpgVtNOx9vsRbI0BN6Qp5FjdBsr
 H4uy19qLrmE1Vpaaz6C9ZX5O7mSNGqruR72NP6Q1VbZ39KbvKwI7ZzUsn3FuwekXgon+nRji
 JxO1meEo47NFEwUWI7wVUA+8157oavba28z/dGc03okKqSyvjLYvrBhTOI41hatecteO6KYB
 UfzFcMdHc2nNO0tnRCgcBsFOOlY8KN8MdmhcrOK36uiPeAomzzD7ywP6YRwyVmF8SZmTajD1
 owAwveRwgqvWDL1jVPnucfy2MhFaTwUAmuj2H38HocCA886NY0PCGqoP4i23oAk38+rCyMer
 gT6QQpZiJzMG1LadVH20AxO2F5CpHWmnXD91Dloi3QyqbLZ2iXSwuPkfR5BO2hRRWAkg02/R
 Or8x90cQkWsaBAk0RW/4kOvjaFfqb9kJm/fW0AOdCHsKmBkW7exnrWHas9LrpgvtG8ENYb0K
 UDfUbP7rxYAhmnqG2ZF3zk9eyut/J7whRl7jmuBLV58qXPYfYd7whKVt7m+DbZBmzEBQid/k
 zzeAFOxasKo8dujnJDGqumiVmilW/W/aAHTxJib/Gu+7GxuWlikmuyr38bgCU482DP60N9jU
 WPJqgz9a8/lzfbyPeVid0huTFjyjqgyUoh6n5ArjZccw39cjZyP+HsBmHvyGdpe0KP6KnEKQ
 HYHzsXU7w7sxEB4ZijRlsSpCzPHmJInPobqKmoNv0B1p9hHEqKV8KBJkWNur1y0oBiQKflxk
 zEByOc/vXsTguUHog0onUD/SvgZGUhVOzCplgzdtYjv6vUKIjz1KP7pixot+LLpRKuPqQxdR
 nvjL5IrHCsrq956LEqJy3rrrIftZNjXa9sX8BySiRbJyeZPe/dT3rIHgzRqPWXlsDgr0ek+2
 FZn2Zyhp4GBJ39quqmwGBtZMDTpZusc/zjsieBVmcPcjOXNVt1xXy4GWpflV6fiGTYfru/uM
 QqUF3s3o22eGLzWAQ6350JvrnaJGJeufSLyRjFR3ZBpQx+TI1ZaiQYfUWAhn5I3IQutwdTob
 EZz4j1Crk69sBZHzfhkcgXuSmqK7hn9cS86EdLMSXgephEH/UreNtaSq/5+Dz0NtIP0txSDc
 ySaf1gaVjxPAx3cQQq/Yf/2ooOcu+mAWrjgc72UOu7I8LIGEa/PnMPKsMMu/i7QZJvReCA6V
 btjnBIEBygxGtyFyWtRDXZLxmSdN4jD403ksixv8pLgqrKyBES2tNHJU/wLYbANs1i3mfvRa
 LLW3Xwkb24ejtRVmzfJ0ORNhQZCzXgxKH/9V+xH73eFTbqMyPYIVFhCOn81bI0QqPtiu2sFc
 c/D1oGvju8+3qNzUg0VEwSmw57hZNRWcTvkahWaVADSZe7AfXqSkon2ef/uE+QOyr8P5lvr4
 3DDVBayW1bL3y/gUxTlWQ1VpAecOhEW+IS0cxI2THPmUMqjcRqjdtl+kTwxx7QwwHLML28Vd
 zZmIQtLqfWL4CVUj+8aeSQJ52d5LeSChyeS7vXJYpcQv/xxBy1oluVcqH0kwrpR5StASbR7g
 izX5tJpplinlKGIxF8FGFJWrS1XgYuQoUh4EaDQ950FR3WduRxUsjXWBBMNqN9oTNbovuEYy
 9TCkr7yNCYX89/Q+ph5ZYCcI8aGPXw9dBvxTWSMXU1VEHjxbziZ3hMNw5TwvjWPo5M3q4bhg
 s8LQ75fDxkuE+8CT19iBJoEKYt2WTUtlfiaitQJ7Dywtkq0Jo0Ss5bZW/aVGfiqJiyeiOwOb
 h8F2qjxK4gJMcvw0lZna19zgIXiFE/ZXNQLqSpkJFxRwg0F4D1lQ2s/1liwIBuq+2MWHOWok
 wQejwJ/ZaEz926p7Q5odhzFoyw/lER3ktLgy2P0Ena5POK7WodYDDDxvk46P8bgQgp7Wga1m
 FRtKDbOQ785Z15IemViiQuaspxKS6Y0pUxsZRYRwbSJZKxt3w0D+mOowkhI4eaDApxnxlNCm
 XGEoHdJ2gYlZ9kwd/W4GQ==
IronPort-Data: A9a23:lobuMKJraHDtYvHiFE+RDJMlxSXFcZb7ZxGr2PjKsXjdYENS1TxTy
 TYdCzuBP/uLY2Xzftx3O9m/pE1UvpTRn9ViSwEd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefSLlbFILas1hpZHGeIcw98z0M68wIFqtQw24LhXlrV4
 YmaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhuOo2k
 PR05bGLTBobZaL1wr4YVUNjDHQrVUFG0OevzXmXtMWSywjYcCKpzawxXAc5OooX/usxCmZLn
 RAaAGpVP1bT2qTsmuv9E7Y87iggBJGD0Ic3s3Vt1irQC/o8RtbISr/P5NlRwDYYicVHHPKYb
 M0cAdZqRE2bPUMfYQpIYH44tP26oTrZYTl4kl+2mJps6WX5xgwr2qe4ZbI5ffTTHZkP9qqCn
 UrC9nvwBhUyJt2awyCMtHOqnO7G2y3hMKoZE7az99ZxkViLzyoSDgcXXB21u5GEZlWWXtteL
 wkK+XNro/FtpAqkSd7yWxD+q3mB1vIBZzZOO8oAr1ms8/r52AOENDMLd2Qbbdp8j9BjEFTGy
 WS1t9/uADVutpicRnSc6qqYoFuO1c49fT9qicgsHVtt3jXznG0gpkmQEYs7QcZZmvWwSG6gm
 WnbxMQrr+xL1ZZj6kmtwbzQb9uRSnXhSwc04kDJXTvg4FomNMiqYIun7VWd5vFFRGp4crVjl
 Chf8yR9xLpWZX1oqMBraLtVdF1Oz6jdWAAweXY1Q/EcG82FohZPh7x47jBkP1tOOc0ZYzLva
 0K7kVoPucUKZiL3PfIsP9zZ5yEWIU7IRYSNuhf8PoomX3SNXFLvENxGPhPPhz+1ziDAb4lmY
 8nAK65A8kr2+Yw+lGbsLwvs+bAswS86yAvuqWPTnnyaPU6lTCfNE98taQPQBshgtf/siFiLr
 r53apTSoz0CAbWWSnSGquY7cAFaRVBlX8yeg5IMLYarfFE2cFzN/teLntvNjaQ+z/oL/goJl
 1nhMnJlJK3X3yOYc1naMSAzAF4tNL4mxU8G0eUXFQ7A8xAejUyHtc/zrrM7Iusq8vJN1/lxQ
 6VXcsmMGKUdRTHO+jBbZp749dQweBOujAOIHiykfDlvJ846F1KVoofpLln16S0DLiurrs9h8
 bCt0wXsR5BcFQlvCcDhbu2ikgGqtn8HleMuBEbFe4EBeEjl/IVwBTb2i/s7f5MFJRnZl2mV0
 g+XBVETouyU+90599zAhKalqYa1ErsmThAKQTWDtbvvbHvU5Guux4NEQd2kRzGFWTOm4rima
 MVU0+r4b68KkVNMhIx2TORmwKc40N3w/uMIwwlhGkLLWFSlELZXJHeLgJtUvapXy74F4Aa7V
 x7d+tRePrnVasrpHERLeFggZ+WHkO8Xw3zctKtlZkr94yBz8fyMVkALZ0uAjylULb1UNoI5w
 Ld+5JRHtVTn0hd6YMybii109niXKiBSWasQsJxHUpTgjRAmyw0fbJGAWDX65oqDN4dFPkUwe
 GPGgaPDg/FCxROHfSNsRT7C2u1SgZlIsxdPlQdQK1OMk9vDp/k2wBwBrmhtH1oNlk1Kg7BpJ
 2xmF0xpPqHSrT1ms85OAjK3EAZbCRzFp0H8xjPlToECo5VEi4AMEIE8BQpJ1EUQ8mYZYDsCu
 b/BlzajXjHtc8X8mCA1XCaJbhAlocNZrmX/dAKPRqxp3KXWpRLqh6avYSwDrB6P7QYZmhjcv
 eczlApvQfSTCMPTypHXz6GV0L0RTFaPI2kqrTSNOk8WNTm0RQxeEgRi56x8lg2h6hAKHYKF5
 xRSG/9y
IronPort-HdrOrdr: A9a23:04o3TqoLjbylFWkM2ls8uMgaV5oUeYIsimQD101hICG9vPbo7v
 xG/c5rrSMc7Qx6ZJhOo6HkBEDtewK/yXcx2/hzAV7AZmjbUQmTXeVfBOLZqlWKJ8S9zI5gPM
 xbAs9D4bPLfD5HZAXBjDVQ0exM/DBKys+VbC7loUtQcQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,214,1647298800"; 
   d="scan'208,217";a="13668357"
X-MGA-submission: =?us-ascii?q?MDG7gKh6R5mE55pmjGOjBODJif70YYWDLixEaG?=
 =?us-ascii?q?NiD94H6gvVmgHA5XIO3hrz8IzN6gzBKogxY4vw19Pm/iYjVMXs+Ik8sV?=
 =?us-ascii?q?7QCRKkjCEWnLcB8jCixpZ8e4PPR5cLio+ahqJvyPSS+tp4yQf2r11mJR?=
 =?us-ascii?q?ZpXvYkmf5W0FIqfMKsIpbQfA=3D=3D?=
Received: from mail-vk1-f178.google.com ([209.85.221.178])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:53:51 +0200
Received: by mail-vk1-f178.google.com with SMTP id s68so8158754vke.6;
        Tue, 10 May 2022 02:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OEbAM2jxx+Oxcu0OXR2H+BIfgohizDpHMUHgDkeP0og=;
        b=Ufpus+WbM4pSCjp7/6H0MqMhRUTRlSyNdNRenZ5wgMpVMqR2dDGdNuIEpYSZ9MAmzK
         +967eQ23uJC3c9YdkX9+C2Xe78PbNJ+Tgb5DKEE0FZw+HvSTM2SG0NLIQhY4mSKPVtMd
         odM9QGK0QO5QRMFWMyt9mgtH46j1q7eee/pYs0WekxiHlTKFnGMUIEVpFFtKMsrV82JY
         JlHWRR+x3yqfI4RZSsgHG0qDmLVxVVFc7LaEai9A987ztCF0GmlNPwRJkrlhOjUEhAou
         9jl7BveuOWfSvYU422e+/SSIxLoLWpa+0Y4j8uXWSGC5Qvc9LrybSaxZzl+XQSokkkvS
         BniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OEbAM2jxx+Oxcu0OXR2H+BIfgohizDpHMUHgDkeP0og=;
        b=RYZonu+CCsZ2QtJ4Blll6l3dZOc1xxIG1yGmc1ENDwX6wxjT+VT7zkUDj9iZSCHJk8
         QLyfaNF0lFXHEK2sNtayFBV6Pef4yCMUcxwtyRyEpMvAeGlEJ5m30cB65UdUJdNq9m6C
         BFRKoCbWcBUhslccHwLmsyZJEAOr6YT/hrnLbEliwFVOgjwy4kqHNAVi58Djo15rQ8I3
         pi3C/Gah9JRAxyq0TgVCiiTh5bDlpcvLttkRqy91m9Qm0lL3Rm+ppXuvWKSrJrxUjFva
         02RrSNTpv0USOqIQHo+VOaQzbwmCh9WF7TKfUAJvxTnFCzGZeE3USMKX3EQs6LvmTJhx
         YEeA==
X-Gm-Message-State: AOAM533Fgx45nejZjkRvGw6N5qTkQFgQzerUzE/vJG8uTW0kxj8Zj7Il
	/8ebIQyJ8CSJGj669/tM5jmqle6EI5ST17p/9zWZL5HiLfU=
X-Google-Smtp-Source: ABdhPJwn52ly+TrfMqo4Oo2a4VQIWJJwru7IjdG0rSVY+4Exo2tLqZl5QeqgzwH6YWihMM9Ba1IVhol82kfUvQXAVr4=
X-Received: by 2002:a1f:d481:0:b0:34e:af4c:5bd3 with SMTP id
 l123-20020a1fd481000000b0034eaf4c5bd3mr11605558vkg.39.1652176429253; Tue, 10
 May 2022 02:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2205091216530.2394@hadrien> <CAPp5cGRMAOanfvuhV1LAV9eZka8ZJHRPy6ncMwO=Q+C=GUA2gA@mail.gmail.com>
 <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com>
 <6a926cad-e15a-5c04-1fc9-34d20bd18618@web.de> <CAPp5cGQRKxk5RXn7a=7R3s4y=fsvi_O9aFUj6HudPSX+06-_2w@mail.gmail.com>
 <alpine.DEB.2.22.394.2205100957160.2667@hadrien> <CAPp5cGS+4snNh+8S3vFw01MMbUjYgpL2qm0tUPrZ1FUtK8bz9Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101123120.2667@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2205101123120.2667@hadrien>
From: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Tue, 10 May 2022 11:53:13 +0200
Message-ID: <CAPp5cGQMuy3aM5cLYk4HH8Ny=uH_t2yhWasfmT2AS7M12YDiWA@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Content-Type: multipart/alternative; boundary="0000000000002c06bd05dea54daa"
Subject: Re: [cocci] List global variables with SmPL
Reply-To: Alessandro Carminati <alessandro.carminati@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 375
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/CAPp5cGQMuy3aM5cLYk4HH8Ny%3DuH_t2yhWasfmT2AS7M12YDiWA%40mail.gmail.com>

--0000000000002c06bd05dea54daa
Content-Type: text/plain; charset="UTF-8"

Hello,

Il giorno mar 10 mag 2022 alle ore 11:24 Julia Lawall <julia.lawall@inria.fr>
ha scritto:

> > There are also problems with some "__randomize_layout" statements, but
> I've not yet isolated the minimal statement that can report
> "__randomize_layout" as the global variable name.
> > My assumption is that I can add defines as done in the
> init_defs_builtins: /usr/local/lib/coccinelle/standard.h, but using the
> -define argument with a file containing these defines does not solve the
> > problem.
> > Sorry for keeping this thread long, but your advice would be very
> appreciated.
>
> -define is to indicate that a configuration variable is true.  You want
> --macro-file <file>
>
--macro-file is probably what I needed. But for some reason, it did not do
what I expected. Appending "#define __randomize_layout" to the
/usr/local/lib/coccinelle/standard.h does what I expect and the
"__randomize_layout" is removed from the results, but the argument
 "--macro-file local_def.h" with the file containing the same single
statement does not.

Also, for the other problem I had with the statement:
```
__printf(3, 4) __cold
void _dev_printk(const char *level, const struct device *dev,
         const char *fmt, ...);
```
I assumed the problem to lay in the first two defines "__printf(3, 4)" and
"__cold", but at least the "printf(a,b)" exists already in the default
standard.h, and adding the second does not make disappear the _dev_printk
from the results.
Instead, it seems my problem pertains to the variadic functions. Removing
the three dots by the function declaration, the entry disappears from the
results.
I have no clue here. Again, help is needed.
Thank you



>
> julia
>

--0000000000002c06bd05dea54daa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" c=
lass=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr=
"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><br><div style=3D"display:inl=
ine"></div></div></div></div></div></div></div></div>Hello,</div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il giorno mar 10=
 mag 2022 alle ore 11:24 Julia Lawall &lt;<a href=3D"mailto:julia.lawall@in=
ria.fr">julia.lawall@inria.fr</a>&gt; ha scritto:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">&gt; There are also problems with some &q=
uot;__randomize_layout&quot; statements, but I&#39;ve not yet isolated the =
minimal statement that can report &quot;__randomize_layout&quot; as the glo=
bal variable name.<br>
&gt; My assumption is that I can add defines as done in the init_defs_built=
ins: /usr/local/lib/coccinelle/standard.h, but using the -define argument w=
ith a file containing these defines does not solve the<br>
&gt; problem.<br>
&gt; Sorry for keeping this thread long, but your advice would be very appr=
eciated.<br>
<br>
-define is to indicate that a configuration variable is true.=C2=A0 You wan=
t<br>
--macro-file &lt;file&gt;<br></blockquote><div>--macro-file is probably wha=
t I needed. But for some reason, it did not do what I expected. Appending &=
quot;#define __randomize_layout&quot; to the /usr/local/lib/coccinelle/stan=
dard.h does what I expect and the &quot;__randomize_layout&quot; is removed=
 from the results, but the argument =C2=A0&quot;--macro-file local_def.h&qu=
ot; with the file containing the same single statement does not.</div><div>=
<br></div><div>Also, for the other problem I had with the statement:<br>```=
<br>__printf(3, 4) __cold<br>void _dev_printk(const char *level, const stru=
ct device *dev,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *fmt, ...);=
<br>```<br>I assumed the problem to lay in the first two defines &quot;__pr=
intf(3, 4)&quot; and &quot;__cold&quot;, but at least the &quot;printf(a,b)=
&quot; exists already in the default standard.h, and adding the second does=
 not make disappear the _dev_printk from the results.=C2=A0</div><div>Inste=
ad, it seems my problem pertains to the variadic functions. Removing the th=
ree dots by the function declaration, the entry disappears from the results=
.<br>I have no clue here. Again, help is needed.<br>Thank you<br></div><div=
><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
julia<br>
</blockquote></div></div>

--0000000000002c06bd05dea54daa--
