Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C787C433FE
	for <cocci@archiver.kernel.org>; Thu, 31 Mar 2022 05:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=rgtOCaQYJg3zKcFPdllEeiUjgiabRKTrH5ORYrE4T/w=;
  b=uC6bOWUURJlLfU7tc/k+nTSOOl9Wox1cVeIaTzxNxUPeWV0JcDDmWW0b
   sZMYTzMHkBxSUawqE+H+spiGkBP+UviqlVWd+WPdAI+YD4QFOmhHwBMYw
   BXXcZVPXq9dAG9vTWhU2PFbbUhOQ2YsDUYts7NrgZ1/P9735hu+SREut8
   0=;
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
X-IronPort-AV: E=Sophos;i="5.90,224,1643670000"; 
   d="scan'208";a="29209627"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 31 Mar 2022 07:35:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 23A11E0298; Thu, 31 Mar 2022 07:35:22 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D7929E7D80
	for <cocci@sympa.inria.fr>; Wed, 30 Mar 2022 23:49:40 +0200 (CEST)
IronPort-SDR: GOmcrKq/1xrfn0w6oito0AWevcDCAmQ5d/X3y0rDzUGNub26SFebwSDDrZ6VX+qVRC7W9jxp4a
 EOVjXIwrt3JTqba6UVmNAupW0a1nzpLqLVbBzksHcz2T5mjvqAsUpV+Ha6qsFmPZUO8ZMjtNl6
 /mn8Nk8zCDcyNZslxXdgYaJgr9jbZfPDzxz1ZN/75SkRQGXXEDODZnV3NnePthBfWWyPhp1hRI
 2tQsUBM8xR9/MKtMA4PR1SLRTLSiGZKZrD0JN1acqcZxnh6Py2ABAdCtLfHVIEOvdQs+lMHyBS
 uaxVeD2q0mGjYDSxhCYZPwjH
X-IPAS-Result: =?us-ascii?q?A0AbAQDTz0RihiuhVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UgFAQELAYFRVn5XKwRPiy+KPYsqkT6BJQNUCwEDAQwBMxAEAQGFBwKEVwIdB?=
 =?us-ascii?q?wEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwLCQcIC?=
 =?us-ascii?q?gcOEAVeAWEDAUSBT4F0CwMEBicNgjUMhAICAQMSFRMGARsdAQMMBhA7IQIRA?=
 =?us-ascii?q?QUBHAcLByKCYgGCZAEDLgGiLoEEPYswgQEWBReBAYIJBoRJChkoDWcDgVkCB?=
 =?us-ascii?q?wkBCIEqAYYQAYQngxd6J4IpgUiBCYIsgiGIASIEmB8/MwFTKBMBExchAjIgW?=
 =?us-ascii?q?UeBOQGRDhStTzAxCgYBgiFzOIFBiU+Oa4V7M4VDkQGSCIR0kWkgjHiDVJBsC?=
 =?us-ascii?q?4R8AgoHBhAjEoEzDWGBIDMaI4EBbYFLCUUBAgEBAQ0BAgEBAwECAQIJAQECj?=
 =?us-ascii?q?C6BbwwNCRWDO4RZhh8nNDgCBgsBAQMJkWABAQ?=
IronPort-PHdr: A9a23:3hzDlxRkvqnMb/aHFbMc5blSjtpsom2WAWYlg6HPa5pwe6iut67vI
 FbYra00ygOTB8OCtagP0rSK+4nbGkU4qa6bt34DdJEeHzQksu4x2zIaPcieFEfgJ+TrZSFpV
 O5LVVti4m3peRMNQJW2aFLduGC94iAPERvjKwV1Ov71GonPhMiryuy+4ZLebxtWiDanfL9/L
 Qu6oQrMusQXjoZpN7o8xAbOrnZUYepd2HlmJUiUnxby58ew+IBs/iFNsP8/9MBOTLv3cb0gQ
 bNXEDopPWY15Nb2tRbYVguA+mEcUmQNnRVWBQXO8Qz3UY3wsiv+sep9xTWaMMjrRr06RTiu8
 6FmQwLvhykaKj4563nXhdJsg6JHrhyhoBl/zJTVYIGTKfFyeqzQcNcfSWdHQ81fVTFOApmkY
 oUBD+QPI/tWoYrzp1QBsRSxGAujCfjzyjNUnHL6wbE23/g/HQzAwQcuH8gOsHPRrNjtM6kdS
 /q1w7XWwjXHaPNdxCrz55TIchAkoPGMQa5wetfWxEkqDQzFlEmfppLhPzOSzOgNqHSU7+plV
 eKul24ntxx9ryOgxscpkIbJh4YVxkrY+iV+xYY4PNu1Q1N0btC4CpVfrT2aN5doTcM4RWFlo
 Ck0xqEatJO5ciUHx4oryhDCZ/GacIWG7A7uWemVLDp7hX9rdrayihS2/EWgyeDxS8e53VdEo
 yZbjNXBtn8A2gLV58OaRPV9+UKh1iyO1wDV8uxEOkc0lbfBK5E93LEwmJ0TsV7MHiDogkn2i
 rGZdlki9+O16Orneq3rqoGAO4JwkA3zMaQjltaiDek5LwQCRWeW9Oqk2LH9/kD1XLpHg/g4n
 6XFrJ/XIN8Uq6+iDAJQ3Isu7wqzAyuj3dsGk3QHIk5KdReag4XpNFzDIPX1AuukjFmojTtmw
 u3KM7/vAprWKHXIja3vcqxn60FGzQo+1dBf6IxQCrEGOP/zX1X+tN3cDhMgNAy0xPvrBMxz1
 o4RV2+DGKCZMKTVsV+H4uIgPfOAa5MSuDb4M/Ql5vjugmElmVIFY6WlwZ8aZGq7E/lmOUmVf
 HvhjsobHWoFsAcyVOnqh0eDUT5XaXayRaU85jQjBYKjF4jDXJyij6KF3Ce8BJFWfXxJClCJE
 Xfpa4WER+oAZTmdIs9kiDMEVLyhR5U92hGpsQ/207xnIfHM9S0CqZ3jzMR15/HUlRwq6zB4F
 96d3H2VT2FogmMIQCc707x4oUNh1liD0LN1g+dYFNxW//NGSB02NZ/az+xgCtD9QBjNftmTS
 Fq+WNWpHSkxTs4tw98Je0t9H8+tjx7Z0CquB78YjL2KBJ0x8q3HxXj+Pdxxy3fA1Kk7jlkpW
 NFDNWO8hv03yw+GDInTmUiFv6K1c+Ia0TKJvGKIzWeOtUsbUBN5TqjEdXMSfE3bqZL+/EyGB
 7OqAKg2Kgxf4cGFLaROZ5viilACDPvqJtXSbGWus2i3AhmMy/WHa4+5VX8a2XD4AVIPngQUt
 U2NNQ0/Gjvp92fXFjdjEVWpeEjs9OhitCqTQUo9zgXMZEpkgenmsiUJjOCRHqtAlokPvz0s/
 mkldL7c99ffCt7a4hFkYL0Ze9Q2plFOyWPesQV5eJ2mNaFrwFAEIExsp0278RJxB81blNQy6
 mswxV93ILiT3VdGMSiT3ZXxJqGOAmb39RGrLaXR3wKWy86Yr58G8+9wsFD/pEesH0sm/W9g1
 oxQ2mGX65HNShEZUZfwTlpu3xd/rrDeJCI64tCczmViZI+ztDKKwNc1HK0lxxKnKs9YK7+BH
 RTuHtcyAsGvLKktnAHsYE5feu9V86EwMoWtcP7uNLeDGuFmkXrmiG1G5No4yUeQ729mTeWO2
 Z8Zwvae1w/BVjHmjV7nvNql0YZDLSofGGay002GTMZYe7FycIAXCGyvP9z/x9NwgIToUmJZ8
 1jrDk0P2cugcx6fJ1Ln2ggY2UMSqH2h0Sy2ql482zQgtKGS2CuI2O/icRsbJjdjS2xrjFOqK
 o+xzpgbUEWucwk1hU69/0+posoT7K97LmTVXQJJZ32sdzAkAvb27+TbJZIUu/ZK+W1NXe+xY
 E6XUOv4qhoeiWb4GndGgSo8fHess4n4mBpzjCScKmxypTzXY5IVp1+X6drCSPpWxjdDSjN/j
 GydA1GmNNSt+pOPnJfGs/yiDkquU5RSdW/gyobK507ZrSV6RAaymfy+gIitFAEg2iL/0J9xX
 iXNrQrgO6Hk0q27NaRseUwiVzqeo4JqX4p5lIU3npQZ33MX046U8XQwmmD2KdxH2Kj6YRLhX
 BYzysXOqEjg0UxndDeSwp7hE2+ayY1nbsW7ZWUf3mQ86dpLAeGa9u4MkSxwq1u+5QXfBJo11
 jIU0/Aj7HlcmOoJvQsx0ny1DbUbHE0eNivp3xiF9NGxqqxLaX3nK+Dhkhoj24n/Vffe+UlVQ
 xObMt86EDV179ljPV6Ey3D15oz+OZHRYd8VqhyIgkLFhulRJog2k6lCji5mNGTh+Hw9nrRj3
 Fo+gNfj4tHBdz4+mcDxSgRVPTD0ec4JrzTkjKIE292Tw5jqBJJqXDMCQJrvS/usVjMUr/Xuc
 QiUQ1he4j+WH6TSGQiH5QJotXXKRtquPmucKX0ei85pRBycOFAGqA8RVTQ+2JU+E0r5oa6pO
 Fc8/T0X6lPi/1FJw/hjOh34FHzUpAKpdittYJeaJRtSqApF4g2GVK7WpvI2FCZe8Jq7qQWLI
 WHOfAVEA1YCXUmcDkziNL2jtpHQtvKVDe2kI77ScK2D/KZAAuyQy8vlge4Et36cc9+CNX54A
 7gn11pfCDpnTt/BlWxHSjRLxXmQKZfK/FHmpnIx9oflrLzqQF69u9fJUeAJd4wxo1buxv7SU
 ozYzCdhdWQGiNVVnSWOkP5HmwRKwyB2K2vzT/Ja6X+LHPqWwugNV1Yac38ha5EOtv56h1gXf
 5ac04OQtPYwj+ZpWQgZEwW7x4fxI5RNej/1NUubVh/TZPLfemKNk4evJvnlAbxI0LcN6Eb24
 GfHVRelZnPayVyLH1iuKb0e1nnKekwD/tjnIlA1TjG8BNP+Nk/haYEx0G1wmOxuwCuNbD9UM
 CAgIRkU8PvKtnIe2a85QysYvx8HZaGSkiKdpYE0M74wtv1mSmRxnuNeujEhzqdNqTtDT7pzk
 TfTqdhnpxenlPOOw3xpSkgGrDEDn4+NsUh4XMeRvpBdRXbJ+g4M5mSMGlwLodViENjmp6FXz
 JDGiqvyLD5I99+c89EbAoDYL8eOMXxpNhSMenacFAweUTuiLn3SnWRYmfCWs3qS99009sOql
 50JRbtWElcyE7JSC0hoGsADPIYiXj4glu3+7oZA7n6/oR/NAcRC68qfB7TCXLO2dm/f0eIXA
 nlAian1JokSKIDhjklra10g2Z/PB1KVR9dG5Ctocg4zpkxJtnl4VGw6nUz/OWbPqDceE+C5m
 hkuh05we+MooX3p6k08K17N4jA7kEwwhcm8qT+UeT/1aqy3WMsFbki8/1h0KZ79TwtvOEeqm
 ld4MT7fW79Lp75pdGQujwiF/JUTQrhTSqpLZBJWzvaSLaZNsxwUumCswklJ4vHAAJ1pmV4xc
 JKimHlH3hpqcN8/IaG4zEthy1FRgueJuXbt2LxqhgAZIEkJ/SWZfyta4CTg2ZEpIiOp+qpn7
 gnQwlOrnUADUvMrprRh8UZvY4y9
IronPort-Data: A9a23:bD2XcKnO4QopS76h3vdI3y/o5gxiIERdPkR7XQ2eYbSJt1+Wr1Gzt
 xJODW3UM66KNGL9Kth2YIq//ENX6p+Ex4VgTAtpryAyRltH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTres1hlZHWeIcg944f5Ys7N/09YAbeSRWVvX4
 4up+JWHZDdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /1UnJqbTBtqDJeQhaMyQiBqDSsmJbN/reqvzXiX6aR/zmXDenrohvJpVQQ4YdZe9eFwDmVDs
 /cfLVjhbDjZ37PwkO/9E7c1wJh4RCXoFNt3VnVIyDjDBvsiRtbYSKXP5MNEhR8/g8lPGbDVY
 M9xhT9HNkWZM0QRYQ5/5JQWmOu4rSj8fjlimkOfmbobpGiNzFd2+e24WDbSUoXSGZ89clyjj
 mnB9G/4KgoLMcSWjzuD6HOlwOHV9Qv/UZ0bELmQ5P9vikeagG0VEhwfE1WhycRVkWa7UtNbb
 ksTo28g8fN0+0usQd3wGRa/pRZooyLwRfJJOusR7R3O+JCI/kG2F1E2UDQZcMIf4ZpeqSMR6
 neFmNbgBDpKubKTSG6A+rr8kd9UEXhFRYPlTX9UJTbp8+UPs6lo1E+WFY8L/Lqdy4yoSGmvm
 VhmuQBn3+1L5fPnwZlX6rwub9iEjZHPUgkzjuk8dj34t1siDGJJinDB1LQ2xfNJLYLcSV7Y+
 XZYwI6R6+cBCZzLnyuIKAnsIF1Lz6bdWNE/qQQ1d3XEy9hL0yP5FWy3yGwvTHqFyu5eJVfUj
 Lb74Gu9HqN7MnqwdrNQaImsEcksxqWIPY27CqCKMIcWOsAsLVbvEMRSiai4jzCFfK8EwfFXB
 HtnWZvE4YsyVfw3nWPuGY/xL5dynn1jnQs/uqwXPzz+iebEDJJkYbgCN1SKY4gEAFCs8W3oH
 yJkH5LSkX13CbWgCgGOqNJ7BQ1UcRATWM+uw+QKJ7brClc3QwkJVq6BqZt/IdANt/oOzY/go
 CriMnK0PXKk2RUr3y3RNyg/AF4uNL4jxU8G0dsEZgjwgSF5MdfytM/ytfIfJNEayQCq9tYsJ
 9FtRilKKq0npu3v92tPYJ/jgpZlcRj31wuCMzD0Mjc6dp9kAQfO/4a8LAfo8SAPCAuxtNc/8
 +XwjFOFHcJbSlQwFtvSZdKu00i14ioQled0aE3CfYtedUDqx451JnGjlfQwOcwNdU7Oy2LCh
 QabCBsVv8fXpIox/IWbjKyItdb7HO53H04cFG7etO7kOS7f92ul4IlBTOfYJWCHBD2ooP2vP
 LwHwev9PfsLmEdxn7B9S7s7n7gj49bPpqNByls2EXjOaWOtAOwyL3SD2/5JqfQRlLJUvA2BW
 nWP9MNfDrOHNZ63C1UWPgckMr2O2PxIyDnf6fM5fBfz6CNtpuHVVExTO1yLj3UYIucudowix
 ugltYgd7Anm0kgmNdOPjyZ18WWQLyxfD/926MlCWIK72BA2zlxiYIDHDnOk6p+4bdgRYFIhJ
 SWZhfafirkAlFDOdWE/SSrE0eZH389cvRlLyBoFIA3MlIaewPAw2xJV/HI8SQEMlkdL1Od6O
 25KMUxpJPXRo2052pAbB238SRtcABC5+1DqzwdbnmPuSUT1BHfGK3cwOLrQ8U0Um46GkuO3I
 F1FJKfZvTfWkAXZ2yIzXQtirKWmQ4AqsALFn8+jEoKOGJxSjf8JREOxTTJglvclKZpZaI77S
 S1C8+N5aKm9PikVy0H+I5fPzqweEXhoO0QbKcyMP8o18aX0dzS72DzIIEe0Ei+Iyzom7mfgY
 /FTyglzu9hSGcpAQv33xULBHlOsoMMU2Q==
IronPort-HdrOrdr: A9a23:ZGXGT6iL8XtZbNlQJ3pwL5w98nBQXvcji2hC6mlwRA09TyVXrb
 HLoB0+726PtN9xYgBapTnkAsO9qBznhP1ICOUqTNWftUzdyRaVxeJZnPPfKl/bakvDH4dmvM
 8KE5SWSueAdGSS5fya3ODSKadG/DDoytHMuQ4c9RtQpMNRBp2IIz0XNu9TKCNLeDU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,223,1643670000"; 
   d="scan'208";a="29181631"
X-MGA-submission: =?us-ascii?q?MDF2Klviq5oKAPZOFQ+pQW5lkPQusQUnalXBa9?=
 =?us-ascii?q?HYZTTejuAc97X5gPDV2kxTnEEOLofPYGkp3w0smuvbs+UoLqccaPXN5a?=
 =?us-ascii?q?MoGgWYR6ju3tFlZbdi+KCTFOoiSOusvtibs61cuep38nWqS9GiIg7ReO?=
 =?us-ascii?q?N8WhVHAi6UpcnoMkecQq6Y4w=3D=3D?=
Received: from mail-oo1-f43.google.com ([209.85.161.43])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 23:49:39 +0200
Received: by mail-oo1-f43.google.com with SMTP id y27-20020a4a9c1b000000b0032129651bb0so3842103ooj.2;
        Wed, 30 Mar 2022 14:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rgtOCaQYJg3zKcFPdllEeiUjgiabRKTrH5ORYrE4T/w=;
        b=hcRkM3UUJebrww/R5w9mUzbe4kbD7nt8Zr27Ne3DO2YKmNtyuBhz7MdfCl7QN9pr1D
         p63Ln8FOd31sVxrxoAo1uiMPRE8nRqiSuFQf6SFMvEOSFOu+ouzalkWbW0gNGOI0yQUY
         9sVh6K6DMQ6mgi2LzfhO3DslOGMXYCnUM8GL4OvwzHclSR/J4xXUXaA2l6YBYM3lvmg9
         YM/st1cfT2fSt/TDAIJQZvX8ugc7IgzXs3SPFH/amVDI4+euD8VgKR3xncVgSbTNF+8m
         lwW9a6fkepdrD8e5r1rDJkNqoLeBMRRP497JdMNpDh5pP8recQEFKuAr5+TUbzkI6Yc4
         YcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rgtOCaQYJg3zKcFPdllEeiUjgiabRKTrH5ORYrE4T/w=;
        b=Myr8KYIXCJuzVX+q532skozjufCg9fxrptDc29Io8Opw9XVDkZrTCDxYz84RgApgjm
         eVWYBIvCHcSTcW5rRdwktQFhdxz/KE5CZuUdlARsZPeyVcNShtnPHO/GzQLBglp00wQL
         9kKAeMgiMNlcSjnyFmdkz4TfYutUrqECTFiEW7QqKP7jgnSPWuO7JDwrZ/TI1rvt77Nx
         ACTRvhs8e8uce5qdot42fgKg2Q2WzRT16OBugoWOGrpd90dJzrOepzZDYf73eu8fgFxs
         +Z8c+cENyuiNGTKBGlXprC+dU6neaavVuWGmgNGPNJQTJogiXI0Df0JV3QWlzftLRSJv
         iFiQ==
X-Gm-Message-State: AOAM5318Hr5UlRhPB6Hf2FlwXRtAum7c8m+ozdEfc9bWR7BO3KaEInIk
	A8AcGFiEMxxk1laPeagHWBs=
X-Google-Smtp-Source: ABdhPJyslGYd+OW+6Ie3G5pBE4WtxdK370h79rqT9IOF4vx5o9fKxTiYz+BQffxhQlVGrM1qsRu15A==
X-Received: by 2002:a4a:3c47:0:b0:320:f0d5:25a7 with SMTP id p7-20020a4a3c47000000b00320f0d525a7mr3914783oof.58.1648676978240;
        Wed, 30 Mar 2022 14:49:38 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:30c:b6b:3900:e3fc:1545:cb91:17fb])
        by smtp.gmail.com with ESMTPSA id q40-20020a056830442800b005c9274907a0sm11613815otv.10.2022.03.30.14.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 14:49:37 -0700 (PDT)
Date: Wed, 30 Mar 2022 18:49:33 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: corbet@lwn.net, mchehab+huawei@kernel.org, dlatypov@google.com,
	davidgow@google.com
Cc: linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, cocci@inria.fr,
	smatch@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, dan.carpenter@oracle.com,
	julia.lawall@inria.fr
Message-ID: <7d793c1b9f87d9cb8ac0e858e561e108c2bf0176.1648674305.git.marcelo.schmitt1@gmail.com>
References: <cover.1648674305.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1648674305.git.marcelo.schmitt1@gmail.com>
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v3 1/2] Documentation: dev-tools: Add a section for
 static analysis tools
Reply-To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 318
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/7d793c1b9f87d9cb8ac0e858e561e108c2bf0176.1648674305.git.marcelo.schmitt1%40gmail.com>

Complement the Kernel Testing Guide documentation page by adding a
section about static analysis tools.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Acked-by: Daniel Latypov <dlatypov@google.com>
Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Julia Lawall <julia.lawall@inria.fr>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
Change log v2 -> v3:
- Added Julia's acknowledgment tag

Change log v1 -> v2:
- Brought generic tool characteristics to the intro paragraph
- Made explicit that these tools run at compile time
- Added a note of caution about false positives
- Updated Coccinelle info to make it sound better and be more skimmable

 Documentation/dev-tools/testing-overview.rst | 31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
index 65feb81edb14..b5e02dd3fd94 100644
--- a/Documentation/dev-tools/testing-overview.rst
+++ b/Documentation/dev-tools/testing-overview.rst
@@ -115,3 +115,34 @@ that none of these errors are occurring during the test.
 Some of these tools integrate with KUnit or kselftest and will
 automatically fail tests if an issue is detected.
 
+Static Analysis Tools
+=====================
+
+In addition to testing a running kernel, one can also analyze kernel source code
+directly (**at compile time**) using **static analysis** tools. The tools
+commonly used in the kernel allow one to inspect the whole source tree or just
+specific files within it. They make it easier to detect and fix problems during
+the development process.
+
+Sparse can help test the kernel by performing type-checking, lock checking,
+value range checking, in addition to reporting various errors and warnings while
+examining the code. See the Documentation/dev-tools/sparse.rst documentation
+page for details on how to use it.
+
+Smatch extends Sparse and provides additional checks for programming logic
+mistakes such as missing breaks in switch statements, unused return values on
+error checking, forgetting to set an error code in the return of an error path,
+etc. Smatch also has tests against more serious issues such as integer
+overflows, null pointer dereferences, and memory leaks. See the project page at
+http://smatch.sourceforge.net/.
+
+Coccinelle is another static analyzer at our disposal. Coccinelle is often used
+to aid refactoring and collateral evolution of source code, but it can also help
+to avoid certain bugs that occur in common code patterns. The types of tests
+available include API tests, tests for correct usage of kernel iterators, checks
+for the soundness of free operations, analysis of locking behavior, and further
+tests known to help keep consistent kernel usage. See the
+Documentation/dev-tools/coccinelle.rst documentation page for details.
+
+Beware, though, that static analysis tools suffer from **false positives**.
+Errors and warns need to be evaluated carefully before attempting to fix them.
-- 
2.35.1

