Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB05FD006E
	for <cocci@archiver.kernel.org>; Sun,  1 Mar 2026 18:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=JPOwL5LtmwAUEhf9msAgnUvkNWjnm5zygJD8uU9vbqE=;
  b=RMGLaV+uwo43Vhq42y5pih0E59ed4qXbZV3HqHSfLSLjLQDXCcj9FHIg
   xde04hHx5PT23850vMf9NQl5fmU/UmZqlO9NtbS33XC9YBryVGRRol3C8
   gZnYwz5plpWUAQrPmj6dcrWyiRD1w028qI+Pw88TpHWe92iNJggJ/iYUy
   o=;
X-CSE-ConnectionGUID: uEHOYt72S0KuFgGoT4TAoQ==
X-CSE-MsgGUID: 0PVwS4lFTkOdk3vPOva1cw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
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
X-IronPort-AV: E=Sophos;i="6.21,318,1763420400"; 
   d="scan'208";a="265667794"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Mar 2026 19:26:54 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 0732280FB2; Sun,  1 Mar 2026 19:26:54 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 51EEB80F20
	for <cocci@sympa.inria.fr>; Sun,  1 Mar 2026 19:26:49 +0100 (CET)
X-CSE-ConnectionGUID: bzJSZxeRQryxFm8UuZjl3Q==
X-CSE-MsgGUID: SaZlaNWxTEu+rZmdCw5D8Q==
IronPort-SDR: 69a484e8_OnUnra92nIFuCE/K5RaU7YV/X+lpKsLkmrwA1VIGjT9TNbv
 hic5Mpi0QaIunL06xmKqK3DUddDxeNlg334FwnQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ENAAD+g6RpgAMP49RaDg4BAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?IE8BwEBCwGCQBaBTzQEC0mEWIgchzeCIYQ+hzyHVYRwhAmBVYF9Ag8BAwENT?=
 =?us-ascii?q?gECBAEBAwQ3AQaBToJ0jSICHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEBAQENA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQE7Bw47hk8NgmIBgSSBJgEBAQEBAQEBAQEBAR0CR?=
 =?us-ascii?q?0YnBBkBAREmAS4BBQIYDgJeARICAQGCfoIjAQYQAQM2B6l0fzOBAYIMAQEG2?=
 =?us-ascii?q?mQfLCJZgWQBAgkUAYEKLgGFOzOCZQGFdDuDRYEhD4FVRIE8C4M2hCWDeYJpg?=
 =?us-ascii?q?yAUgWGGEAaLHYFKHANZLAFVExcLBwWBMzMDIAovLQIUHAESDwQWMh1wDCcSL?=
 =?us-ascii?q?BczWBsHBYVhGw+Ic4ELWYESAQKCFgIBC209NwYDCxsEPY5kP4FBcxY9O0wmg?=
 =?us-ascii?q?XcNkxAKgyqQR58lNAeCOIFngWQMn20GEy+XUg6TCgEuh2WQcyKpH4FoOoFcM?=
 =?us-ascii?q?xokgzZPAxkPjiGEM48BCQGzIEUyPAIHCwEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23:ApjFQBPsQ1s7AiBh9asl6nYlBRdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDvqkr1AeCB9iGt6MMotGVmp6jcFRI2YyGvnEGfc4EfD4+ouJSsioeReWoMgnFFsPsdDEwB
 89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL58I
 xi6txndutUZjYd8Kqs8yhTEr39VcOlK2G1kIk6ekBn76sqs5pBo7j5eu+gm985OUKX6e7o3Q
 LlFBzk4MG47+dPmuwDbQQWA/nUTXXwanwRHDQbY9B31UYv/vSX8tupmxSmVJtb2QqwuWTSj9
 KhkVhnlgzoaOjEj8WHXjstwjL9HoB+kuhdyzZLYbJ2TOfFjZa7WY88USnRdUcZQTyxBA52zb
 40TD+oaIO1Uq5Dxq0YSoReiAAWhAv7kxD1ViX/sxaA00OovHg7I0wI+Ad8AsGnao8n6OqoJT
 eC11bPFwSnfY/9I2zrw7pXDfBA7ofGLWLJ9ac3fxlM1FwPGk1WQspHuMTyR1uQDqWib7uxgV
 e2ygGMgrA9+uCKvxsQxionSnI4bxVTE9StjwIY0I924R1V2YNC6H5RLrS2VKpV5T9okTmp1t
 yk01qcItoSnfCgW1psn3RjfZuSZf4aG/h7uV/qdLCp5iXxqZL6yhxS//FWgxOHgSsS5zUtHo
 y5Ln9TQq3wBygLf59SHRPZ+40qs2DKC2g/X5+1YJ00/iKnVK4Y5z7Iui5Yfr17PEjHolEj0l
 qOaa0Up9vKm5unhf77ovIWTN5VuhQH7KqkumtKwAeA/MgUWWmib/vm81KH58Uz3XrpFlec6n
 bTHv5zCJMQboLC2AxNN34o99hqzES2q3MoGkXQFNl5JZRKKg5LnNl3WJfD3F/a/g1CikDdxw
 PDGO6XsDJLXIXjZk7fhYK1951RTxgo3w9Bf/ZNUCrcOIP/oVE7+qsfXAgUkPAOq2+rnEsly1
 psCWWKTBa+UKL/dsViU6e0zIumBf5QVuTb4K/g9/fHil345mVkHfamox5Qbcn64Hu5+L0Wfe
 nXjms0BHnsSvgoiUOzqj0WPXSNLa3a9Qa084TI1Bpi+AInNSY6hmKaB0zmlHpNVfG5LElWME
 XD1d4WYQfsNZjydLdR7njMZS7etU5Iu1RKvtA//07dpNuXa9SMGu5z/yNV74fXfmgw39TNuF
 cSSz3mAQXltkG0QSDE6xLt/oVRzylqby6Z1n+FWG8FL6/NSSgc6O4bTz+xkBND2XQLMZs+HR
 k++TNupUnkNSYc1wtkTcwN8QN6KihHYwzHsArkbjbWHCZU4tKXG0Dy5Dspnyn/AnI8ux3khC
 vpOMyXyj6Jl9gHVB4nYkkPfkamCfKAA0TTEsmyEyDzK9GhcXR55V6nfUDg1a0/SqtL4rhfLS
 7K+ALIrKAYHw8OGLqxMa/XjilJaQPblft/ZZjT10062BBWF2vvYZYzreGgB2SzAElkNuw8U+
 nmCOE41ASL35yrwFjVoFhrLYgu43/N3rnD9ak4cyRGSKUZm0uzxsjAPiPCGSvBb+7seuzw9s
 TJxVAKzxd/aEduD4Q9oZqZHfck65X9Kzn6fqwF2PsrkZ4F8j0RWUwNzulrw1g5rQtFBj8Ew6
 nMtyA9rN6ODzHtMbC/ewZ37OuuTYkv15h+iI4vfwEjD3c3erqUI8vs17VDqphi0G1EK+nNu1
 95alXCb48OORC8bV5PyW0Ar/lBVurfGfzE044fVnSlpOK+1sTbEx9tvC/Yj1gu4dtNbMYuNE
 QO0GMofUYzmE+UpkkKoJjsFOP1JvPovNsCvbfrA0a+vIf1ImDOgkHQB4YZh30bK/C15HKqA4
 JEBzeuR20O8XjHzxAO+qcm0g41CaCobBUKkwC7rQYNXaax0cIsRCGGhZcaww4M6z6zsX39ev
 HG+DlVOjN2ofRuUR0fwwEtd2VlRqnrxygWiyDkhtjgzrbeElAHKzf7jchVPbktCXmp/lhHBJ
 YaujtYVdFelZU4lmU32tg7B26FHqfEnfCHoSkBScn2zdjk6OkPRnr+LYsoUrYgtrT0SS+OkJ
 1aTVr/6pRIelSLlBWpXgj4hJHmxopusuRt8hSqGKWpr6mLDcJRVzA3c+ceaaPpfxDsASwFnh
 DORClXvd8Kx84CsnozY+vu7S3rnU5RSdSfxyobVkSKh5nBxRzC7keqynNLPDgUwlyP2hJFxT
 SudihH6b8Hw0riid+Jqek49HFjn989zAZ1ziKM1g4wMn2cXjNOZ8BLriE/VNtNWkeL7ZXsJH
 nsQxsLNpRPiwAtlJ26IwITwUjOcxNFgbp+0eDFe3CV19M1MBKqOid4M1SJovlq1qx7Qavlhj
 38cz/Up8nsTn+AOvkIk0CycBrkYGUQQMzbrklyE6NW3raMfY2jKE/D48UNkns26SpyGrBtdX
 nnRZZooWyN9r41+PF/KzHzv+9T8YtCDJdkXtxCSj1LBl70Pcch3zKBVw3M6fzmu2B9tg/Q2h
 hFvw5yg6Y2OKmE2ubm8HgYdLTrtIcUa5jDqi69a2MeQxYGmWJt7SVBpFNPlS+ylFDUKuLHpL
 QGLRXcZo22YBKGZMAuR8kZgoFrQHprtO3zddxx7hZ1yAQKQIkBSmlVeeTwgnYMiUC2uytbgd
 khR+T0boFL14EgpqKogJ1z0VWHRox2tYzE/Rc2ELRZY2QpF4l/cLc2U6u8b8zhwxpS6t0TNL
 2WaY18NFmQVQgmfAEilOLCy5N7G+uzeB+ykLvKIb6/c4eBZUv6Jw9qo3O4Et36pP9+MI2IkI
 vk1wEtFUlhmFs6flzhHRyEMli3LZtKWv1/mo3cx9Jrgtq22Hlmn7JDHE7ZINNRz5x265MXLf
 /Wdgip0M3cQ158Bw2PJ1KlK2VcTjy90cDz+Wb8EtCPLUOfRgvoNVkRdMXkscpIVqflvu2sFc
 dTWgd70yLNi2/s8ClMeEEfkhtnsfssSZWe0KFLAAk+PcrWAPzzChc/tMsbeAfVdivtZsxqot
 HOVCUjma36mniPqSgvpHOVCliCdMzRBtYv7fhsnWg2BBJr2Lwa2NtN6l2h85LQuhW7Rc0MYP
 yJ9dUxlsbCaqy9VyKYaeSQJ/j9uKu+KnDyc5u/TJ8MNsPdlNS9zkvpT/HUwz7YGpDEBXvF+n
 zHe68J/u1zz2Pfa0SJpCVAdz1QDzJLOp0hpPr/Vs4VNSWqRtgxY9n2eUlwD9d5iF8GppK1aj
 NTC3KuhLTBf75fE88wGGMHOJISYPXBnPReMenacBVkASiO3cGvYmkpWnbeN+3fTopVyo8rpn
 4cSD7RAXkExFbVDA0JpRZoJJ5ISPHtsmOyei9MUoHGlpx7LXIMDt5bLD7SZBvCnPj+difMsi
 wIg57T+IMxTM4T63xcncVxmhMHRHFKWW9lRoypnZwtyoUNX8XE4QHdhk0TiIhig5nMeD5vW1
 lY/lxd+bOIx9Tzt/0Z/J1zEozE1mVUwntOtiC6YcTr4JqO9FY9MDC+8u080O5L9CwF7CG/61
 VRjLyvBTqlNgqFIcGd2lEnDtJEJFfMdBaxIbRkMxO2GMvUl1VMPz0fvjURD5ObDFd5jjF5wK
 MTq9SgfnVs+KoVmQM6YbLBExVVRmK+U6yqh1+RqhRQbO15I62SKPigBpE0PMLAiYSuu5O1lr
 wKYyF4hMCABUeQnpvVy+wYzIeOFmmjF2qRAN1v3GuiRNaKftEDfmMTOTl56hSZq3wFVuKN71
 8suaR/eT0c00L6YDAgEL+LHLhxJKdVf/j7fcGzd1IeFiYIwNIK7GOfySOaIv6tBmUOoEjEiG
 IEU59gAFJ2huKk9BdjqJvgJxEd1jOwEDEqIBrJFdUDS+N/mi8S40YMxwoRXYD0QUz0VDA==
IronPort-Data: A9a23:i+vGLa0pbzQmng62nfbD5YZ1kn2cJEfYwER7XKvMYLTBsI5bpzRTn
 zNJWziPPP6NajP0c9h+a9+08U1Uv5aHz4RgGQFk3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAhk/zOH/ykVbOs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82AyaDt8B56r8ks14qyp4GpA5zTSWNgS1LPgvylNZH4gDfrpR5fIatE8NvK3Q
 e/F0Ia48gvxlz8xCsmom6rMaUYDRLjfJ2Cm0hK6jID/6vTqjnVaPpcTbJLwW28P49m6t4wZJ
 OF2iHCFYVxB0psgNwgqe0Iw/ylWZcWq8VJcSJS1mZT7I0buKxMAzxjyZa2f0EJxFutfWAlzG
 fIkxD8lZAKhvNCmzYiCUPh8qMFzEdTZPodEgyQ1pd3ZJa5OrZHrRqLX+ZlH0T12is0m8fT2P
 ZNDL2A1M1KZPlsUUrsUIMpWcOOAo3DlcCBD7n+Rq7A25Wf70wF7lrTgWDbQUoXWHZ0Exh/H+
 Qoq+UzCCyMePfqg2Qao7zG2tOrDtjymdNIrQejQGvlC2wHDnjdDV3X6T2CTqv6ygU+WQMNaM
 0VS+yw0rKF0+lbDczXmdxi/vWLCoRMWHdZdewEn1O2T4qDGwT2rFmU+dyRQePIj5PIrdz4uj
 WbcyrsFGgdTXKuppWW12pr8kN9fES0SMHNEeiIOCwcIizUCnG3RpkOfJjqAOPTu5jEQJd0W6
 23VxMTZr+hC5fPnL43hoTj6b8uE//AltDLZGTk7rkr+slMhP976D2BZwVnc6/FbZJ2UJmS8U
 Iw/s5HGtogmVMnT/ATUGbllNO/zu56tbmeC6XYxRMNJ32r2pBaekXV4umEWyLFBaJZcIWeBj
 Y66kV852aK/y1PwNvcoMtnpV5V3pUUifPy8Ps3pghN1SsAZXGe6EOtGPCZ8Bki8zhZ+orJ1I
 pqBb8enAFATDKktnnL8RP4Q3fVvjmoyzH/aD8KzhRm286usVFjMQ5c8MXyKcr8Y6oGAq17r6
 NpxDZaB5Ched+zcWRPp17AvA2oEFlUFIKznitd2c7eDKzV2GWt6BP72x6ggSrNfnK9Ut7np+
 yijVn9h1Valu3zjLD+OS3F8aYHAWYR0gmI7MBcNY3ep+SkHSqS+4JgPc6AYeeEcy9Vi6vpvX
 dwpSt6lEN0WbhjmohMzNYLcqq5mfzSV3TO+BTKvOmUDTsQxVj739c/BVSqx0is3Vw6cl9Y0+
 p+k3SPlGaszfRxoVpvqWaj+3mGKnCYvncxpVBH1OfhVQkLn9bZqJwHXjvMaJ8ItKw3J9gCF1
 jS5UAspmu3Qn7AbqNX5p7iIj4OMIdtMGkB3G2r677HvEQL4+mGl45FLUcfWXDT7eV73xp6fZ
 rRu/6mhCMEEoVdEiJojMrBJyall2cDjiYUHxStZHVLKTW+RNJVeHle80/JijJZ9no1ihVPuW
 2ak2MVrBrGSCca0TH8TPFUEa8qA59E1mx7Tz68HH2Tn1gBK/Z6sc0ZbDz+TggNzcZp3N4IEx
 786mcg0sgaQtDsjAuykvAt1qVueC2MmaLo2kK0aDKvAqBsZ+nsbbbPyUibJsYyyMfNSOUwUE
 xqoravlhYUE4HHdcnA2REP/7cAEibsg4Bl1nUI/fXKXkd/4h9gy7h1b0RIzai93lhxn8eZCC
 lJHBn1PB5el3mlX3ZBYfmWWBQt+KgWT+RXxx3s3hWTpdRSUeVKXHlItG9Sm3R4/yH1dTAh57
 bvD6WfCUBTWRu/T8BY2e3ZYr63EcYQs2CzEwNuqDuaULakcODDFuJKjVUAMihngAP4yunH5m
 PlXzL5OTpP/ZAEtoPwdKoiF1L4vZgiOC05cTNpAoq4YP2HuVwuj+DqJKkzrRMJpIsbO0E6nC
 v5BItBEeAS+2R2v8BEaJ/8oCJ1lkME54OEtfuvQGlcHlL+EvB9FjYn19BWitFQ0Qt5rr9kxG
 rnRex2GDGaUo3lewE3Jk+VpJUu6ZoMiSDDn/eXo7tgMKY0PgNtsfW42zLGwmXefaylj3hCMu
 TL8d73k9PNjxatsjrnTPP16XSvsEuzKVcOM7AyXmPZNZ4mWMc7x6iUkmmO+NAFSZbYsS9B7k
 IqWi+HO3WTHga0XVl7IkJzQBohL4sSPBNBsCPzVF0UDvyW+W57L2SAhqlCIcckD1JsX48S8X
 AK3ZfehbdNfCZ8X2HRRbDMYCBoHTbj+aqD7vy6msvCQEV4n3BfaKM+8v2rcBY2BmvTk57WlY
 uM1hxqv2jychIFLGQNCGPxsRZN1SLMmtW3KaPWp3QR0zEHx6r9BhlcmvQUt43fHBxFo1e7kt
 IndSEGWmAua4cn1IRIwj2C2lgIaBjBxjIHcu67bF8Fe01iHMYLNEQjR3VjqxH2ZfuweGawUv
 A3wUVY=
IronPort-HdrOrdr: A9a23:eA+y166Hmh9t9gBx8APXwCzXdLJyesId70hD6qkoc20wTiXqrb
 HIoB17726FtN9/YhEdcLy7VZVoBEmskKKdgrNhTotKPjOW21dARbsKheCJ/9SjIVydygc378
 hdmt1FaeEYemIVsS+V2mWF+p0bsb+6GeiT9J7jJy0Bd3ATV0lCgj0JcTpyUiBNNXR77dRVLu
 vh2iIIzQDQCEj+3KmAdwM4dvmGutnCjp6jehIdGxs7gTP+8g+A+frmFxCD0lMAXyhUwbEkmF
 K17TDE2g==
X-Talos-CUID: =?us-ascii?q?9a23=3AQ6IkCmjduV0RNMcml5suNkV72TJueG//90XALnW?=
 =?us-ascii?q?BE3d5ZrjFdEKi+qc/qp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AqKqSkw5HsD2fA59qNIh6fa9YxoxT6paqAWYygak?=
 =?us-ascii?q?rpoqeByl8ECjAoGSOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,318,1763420400"; 
   d="scan'208";a="140090177"
X-MGA-submission: =?us-ascii?q?MDGecyz2KylZYNMxHb4tz1eHOBtv4yd+rfqJzv?=
 =?us-ascii?q?LF/4lsotsoKBeHJ+je1T65d+Ub+OJZSnPuDXzCbW16lSjZDZPQuHP5WZ?=
 =?us-ascii?q?2ngENWyPQACmMeMs+vgXrL2DiWxx7W3U/tJbBWAZXifApYquiEfGuS3+?=
 =?us-ascii?q?MZYeVPsAi5oTX1KNwk5x7WJw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 19:26:48 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6pUQ-1w2q1f34wQ-00CoBd; Sun, 01
 Mar 2026 19:26:01 +0100
Message-ID: <44203b94-0d4d-4411-9f9e-103ef19172b6@web.de>
Date: Sun, 1 Mar 2026 19:25:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, de-DE
To: linux-i3c@lists.infradead.org,
 Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Aniket <aniketmaurya@google.com>, Frank Li <Frank.Li@nxp.com>,
 Fredrik Markstrom <fredrik.markstrom@est.tech>,
 Ivar Holmqvist <ivar.holmqvist@est.tech>,
 Jorge Marques <jorge.marques@analog.com>,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Zilin Guan <zilin@seu.edu.cn>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 cocci@inria.fr, Jianhao Xu <jianhao.xu@seu.edu.cn>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tSXVZHBbIK5xjwZhaygDWeHXQZPsCZsck/676Wjtcvh4u93PeYr
 0MwtMi79p0bxd9QiIcGKOAgyYWxB+S8AvQ7GfgW0Rm7krpt7bJDAKiKW6eD48rHe0bl9uHe
 7xunibjpnZI4Q55zfBU2GPKafg+EkE3p5y8dq+By6sgAZEX34SaCCGgF0p6oCid2U0caWha
 zZ4PzW4uVqB9qt9r8gg9g==
UI-OutboundReport: notjunk:1;M01:P0:zqdcEdI4ORA=;buusgYwo/qga8Ub7nO0ll3/K1dD
 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
 Q4FDUr9OZDEcdvidTmam
Subject: [cocci] [PATCH] i3c: dw: Complete exception handling in
 dw_i3c_master_i3c_xfers()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3319
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/YcPrbk1RyapSnZTN1XzMEg>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 1 Mar 2026 19:11:51 +0100

A dw_i3c_xfer structure is allocated by a dw_i3c_master_alloc_xfer() call.
It is not released after a failed pm_runtime_resume_and_get() call.

Thus use an additional label so that the affected memory is always be free=
d
at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Fixes: 62fe9d06f5709caa1fa68055873ff279e05ade37 ("i3c: dw: Add power manag=
ement support")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/i3c/master/dw-i3c-master.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3=
c-master.c
index d87bde3f7700..723f185584d0 100644
=2D-- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -953,7 +953,7 @@ static int dw_i3c_master_i3c_xfers(struct i3c_dev_desc=
 *dev,
 		dev_err(master->dev,
 			"<%s> cannot resume i3c bus master, err: %d\n",
 			__func__, ret);
-		return ret;
+		goto free_xfer;
 	}
=20
 	for (i =3D 0; i < i3c_nxfers; i++) {
@@ -994,10 +994,10 @@ static int dw_i3c_master_i3c_xfers(struct i3c_dev_de=
sc *dev,
 			i3c_xfers[i].len =3D cmd->rx_len;
 	}
=20
+	pm_runtime_put_autosuspend(master->dev);
 	ret =3D xfer->ret;
+free_xfer:
 	dw_i3c_master_free_xfer(xfer);
-
-	pm_runtime_put_autosuspend(master->dev);
 	return ret;
 }
=20
=2D-=20
2.53.0

