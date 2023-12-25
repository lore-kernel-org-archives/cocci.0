Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C371C3DA6E
	for <cocci@archiver.kernel.org>; Mon, 25 Dec 2023 19:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:cc:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=G43c/x5z8EFehcUWZ+tQ6hhuFGrhE389ENE5Nr5XJjw=;
  b=BvCZiymZHe9XXgJPaEBrFp18bMpgNZ2qK1cOQ3juaMWKYGTd5uKizXU8
   mpvCQMBgL7j5oeILIXPbPZuXQgzK2lz2YhiMvGaUOWzk/+3pYFi92b5m3
   D/3iYd0HTwcSus3vJ3E4IaXYQeMGV0frvz+N3U1yyDOuKPOcPlLlfaPXS
   M=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,304,1695679200"; 
   d="scan'208";a="143994287"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Dec 2023 20:19:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1A8FFE0AF1; Mon, 25 Dec 2023 20:19:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A3A94E004E
	for <cocci@sympa.inria.fr>; Mon, 25 Dec 2023 20:19:00 +0100 (CET)
IronPort-SDR: 6589d5a5_Gk1nn/gIXSOgwvLTefdI+1YEvI5zWz9kSGdJnULlkW3Qhvk
 rPkE20bhdD7Q2jMdJKDRCrNh0jNOek1nNPbNU2Q==
X-IPAS-Result: =?us-ascii?q?A0FMAABC1Ill/07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4B4FLMgQLSIRTiB2HJIF1LYQ+hzWHTIhvgVaBQD4PAQMBDUEBA?=
 =?us-ascii?q?gQBAQMENwGBU4J0hzgCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQKBBhOFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR2sEG?=
 =?us-ascii?q?QEBESYBLgEFAiYCXgESAgEBgnyCKwEDMQevMH8zgQGCCgEBBq9YHywiVoFgC?=
 =?us-ascii?q?YEaLgGIGgGFZ4RiD4FVRIEVJwuDNoQKhBSCRiKJHAcyghyDT5FZfQVBcBsDB?=
 =?us-ascii?q?wN/DysHBDAiBgkULSMGUAQoIQkTEkCDMAp+Pw8OEYI+KzY2GUiCWxUMNARGd?=
 =?us-ascii?q?RAqBBQXgQ5uGxIeNxEQBRINAwh0HQIRIzwDBQMEMwodCyEFVgNCBkkLAwIaB?=
 =?us-ascii?q?QMDBIEwBQ0aAhAsJwMDEkkCEBQDOwMDBgMKMQMwVUQMUANsHxgaCTwPDBoCG?=
 =?us-ascii?q?x4NJyMCLEIDCQoFEAIWAyQWBDYRCQsoAywGOAISDAYGCV0mBw8JBCUDCAQDK?=
 =?us-ascii?q?ykDI3QRAwQKAxQHCwdSAxkrHUACAQttPTUGAwsbBj4CpkQHUygTTIIqknKTH?=
 =?us-ascii?q?Z5yNAeCNIFggWEMnysGEy+XJg4GklMBLpgfIKhGgWM9gVkzGiSDNk8DGQ+OI?=
 =?us-ascii?q?DiDc48JAT1ANTsCBwEKAQEDCYVGAQGDJjSBRgEB?=
IronPort-PHdr: A9a23:wGLkchYIWNh1SgPgstKTNdr/LTF42YqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1g+PB9+AoKse0qL/iOPJZy8p2dW7jDg6aptCVhsI2409vjcLJ4q7M3D9N+PgdCcgH
 c5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFRrhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTajYr5+N
 gu6oRvfu8UZnIduNLs9wQbVr3VVfOhb2WxnKVWPkhjm4cu+4IBt+DlKtfI78M5AX6T6f6AmQ
 rFdET8rLWM76tD1uBfaVQeA6WcSXWsQkhpTHgjK9wr6UYvrsiv7reVyxi+XNtDrQL8uWDSi6
 6BrSAL0iCoCKjU0/n3bhtB2galGux+quQBxzJDIb4GULPp+f73SfdUGRWpaQ81dUzVNDp6gY
 4cTCuYMO/tToYvgqFsUtRawBgeiC+zhxTFWhnH4wLM33PguHwzdwAwgBsgDvGjIoNnrNqofV
 /2+wqnSzTXEavNbwTDz55LSchAivPGMRq97f8XVyUkhDQPFj1OQqYP4ND6S0eoCqXKb7+l9V
 eK0kWIppAVxoja1xsctjInJiZkYy17a+ipi2oo6OMO3RVd9bNW5H5ReqzuUOJFqQsM+XW5oo
 iA6x6UItJKlYSQHx5sqyRDCZvGEcIWF7RztWPiMLTp3hH9pZq+ziguw/ES8y+DxWde53VlFo
 CdYk9TBtXQA2wDT58WFTPZ240Sv2S6X2gzN9+1JI1o4mKjFJ5I737I9koQfvV7BEyL1gEn7i
 KCbel8q9+S18ejqYbXrqoWYOoJ0jAz1L7ojmsiiAeQjLggBQXKb9/m91Lzi40L0WKlGg/srm
 afDqp/aP94UpquhDg9VzIkj7xG/Ai+j0NQfgHkHMEhJeRyZgIfyIV3BPe73Ae++g1Sqjjhr2
 +jLMqP8DpjPNHTOkqntcaxg50NY1gY/19JS6pFMBrEEOv3zW0vxtNLCDh8+Ngy52+HpB89n1
 oMdRGKPGbWVPqzWsV+G/OIvIu+MZIAOtTfzNfcq/OTigmInllMFe6mmxoMYaGqkEfR+P0WZf
 X3sj88cHWsSpAoxUPTqiEGeUT5Uf3u9Q6U86S0nB4KnForDXYCsgLmZ3CihBJFWZ2ZGCkqNE
 XjybYmEVe0MO2quJZplkzoZRf29RoA73DmwuwLgjblqNOzZ/msfr52nnNt4/evekVQw/Dp1E
 8OHyEmTQGxu2GAFXTk72OZ4u0M5gnWE16Fkg/VeXfxO4e9ESE9uN5naxvB6AtbycgTff9uIQ
 RCtRdDwRXkTU8ktwtlGWFp8B8nq2hLexDarBaQJlqCXLJMz9a3Y0j76IMMrjz7l2aQ6x3IhR
 cgHYW6ri7V08A/QL4XJiUKclruvM6MG03iJvEKCzmmJ9HlVShJsTKPIWzhLY1Pbt8jl+0XPS
 ZeoF7UrMwIHwsmHfO8CVt3ogE9cVb/ZNdjfZW35z3uwBBuS3KLKdofmemMS9CrYAUkA1QsU+
 CDVGxI5A3KEqnjdEScmOFbheULq/qEqjXqhTVIviSyOYVdg0bWd5RMfw/CRHaBAlokYsTss/
 m0nVG222MjbXp/Z/1IJlMR0ZNo85A0CzmfFr0lnOZfmKal+h1kYegAxvkX01hwxBJ8T2dMyo
 iYMywx/YbmdzEsHbymRiLX5IL7KMS/f+B61aqjZ8k7T2pCa9/RH8+w2/m3qpxrhDU8+6zNi2
 thR3WGb48DvBRARTIm3f0I57Rl8qJnFbyN7646HnWZ0P/yStTnPk8ksGPNjyhukeIJHN7iYE
 QbpD8AAL82pNfBshFWjKB4JVAxL3IgzOc7uN/6P2arxef1lgCrjl2NMpoZ0zkOL8SN4DO/Ox
 ZcMhf+CjEOBUH/ngVGtv9qS+8gMbCwOHme51SnvBZJALqx0c4ERDG6yIsqxjtxgjp/pUnRc+
 RatHVQDkMOufBOTaRT602gynQwyqGakhDD+4jh6iTAvoYKA0SaIz+mjPBsLN2hXRXVz2E/2K
 Nv8hNQbUU60KgkxwUH8ugClne4C9f45cDmAJCUANzL7JGxjTKaq47+LYsoVrYgtrT0SSuO3J
 1aTVr/6pRIelSLlBWpXgj4hJFTI8t30mQJ3jGWFITN9tn3cLItVzA3c+ceaaPpfxDsASwFnh
 DORClX2bLzLtZ2E0ozOtOyzTTfrc5RJcjTwi66EujG642JCHhC12fy+0I6Cc0BywWrw0N9kU
 j/NpRD3b9zw1qi0Bulge1FhGF7278cS9phWqoIrn9lQ3HEbgs/Q5n8biSLpNt4d36vibX0LT
 DpNwtjP4QGj1lcxZn6Owov4UD2azK4DL5Gfa3kVxzl7wsREEqaS45RbkCEzrlfwoQ/KYPd7l
 ysQ0rN0sSFc3LtP4Vt3iHrNSrkJVVFVJyntiwiF47Xc5O1MaWCjfKLxnEtykNa9Da2T9wRVW
 XL3YJAnTmd76sRyNk6J0WWmsNi7PoaKK4tC7FvLw0Sl7aAdMp86m/sUiDAyPGv8uSdg0Osnl
 Vl02pr8uoGbKmJr9ab/AxhCNzSzadlAn1OlxatYgMuS2JiiW5t7HTBeFr7hV/G1C3Q/sfr9N
 gCBOCIxoDGXFPCMeG3XoFcjtH/JH52xYjuyLWMa0M4kaR2TPk1ZjygLUT98kpNzRWXIjITxN
 Ux+4D4W/FvxrBBBn/lpOxfIWWDavA60az0wRcvXPF9M4wpF/UuQLd2G47c5AXRD5pP45l/oS
 CTTd0FSAGoOQEDBG13zIuzk+4zb6+bBTuumc6mUOO/I87YBEa7Sm9T2iNshpWvpVI3HP2E+X
 adigAwZBy8/Qpmfw3JVFmQWj36fNZfB4k3mpWsu8Ybnt660EAP3udnVUuQUbo8pokHsx/3fZ
 6nK1UMbYX5Zzs9elSWOkeZCmgdP2mc2MGPzWbUY6XyXFf2WxfURVUZELXs0bpQA7rpgjFMUZ
 oiE0JWsh+Q+0KJyUQkgNxSpm9n1N5xQZTjjaRWdXhfNbe/ebTzTn5OnO+XlF+AW1r4M8Ufq8
 SCSF0upVtiavx/uUR3nceRFjSXBeQdbpJn4aBFmT27qUNPhbBS/dt5xlzw/h7Mu1DvMMiYHP
 D5wflkozPXY5D5Egvh5B21K72Z0ZeiClSGD6uDEK5EQ+fJ1CyVwnuhe7Tw00bxQpC1DQfV0n
 mPVoLsM6xm+lfKTzzN8TBdUgjNMmZ7Nokhof6nUt9FBVXvC4BMR/DCQBhAN9L4HQpXkv6Fdz
 MSKlbqmcm4dtY2Ou5JNXY6LeJHiUjJpKxfiFT/KARFQSDeqMTuanElBiLSI8XbTqJEmq5/qk
 Z5IS7lBVVVzGOlJbyYtVNEEPppzWSsp1LCBi8tdr1+3thrMX4N3up7dV/SdKeriInCVgPMXA
 nlAiaO9NokVOoDhjgZ6bUJmmY3RB0fKddVKvzEncQI+5klAuisbLCV7ywfubQWj52UWHPi/k
 0stiwdwVu8q8S/l/1Y9IleiTMQYj0Q739no02n5mN/ZKaCtQcdJBiCyu0VjavsTpi5qYAf0k
 UE2bF/5
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:7ccJJ6lA61E89eh37DIyqKYAiS7pDfL03DAbv31ZSRFFG/FwWf
 re+MjzpiWVtN93YgBHpTngAtjmfZq4z/VICOYqUotKMDOW2ldAT7sN0WKB+VHd8kTFn4Yx6U
 4KSdkaNDSfNykYse/HwE2fD8sqxsWB/ZulnOHE0h5WPHpXgu1bjjuQEWygYzRLreR9dOIE/B
 Hw3KB6mwY=
X-Talos-CUID: =?us-ascii?q?9a23=3AQs1L9Wnz5I+jUAbSQDDNHS8qr9rXOSOA4GmOc3S?=
 =?us-ascii?q?eM3dod6PFYgLI6Ll0gvM7zg=3D=3D?=
X-Talos-MUID: 9a23:9lKRPwSpI6kxT+VCRXTuqzdZGP9R/p2UGXhTzrBZu+uKOQlJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,304,1695679200"; 
   d="scan'208";a="143994281"
X-MGA-submission: =?us-ascii?q?MDFl6LQa6o2Mie0s45Nt4teDt52Aswj5R+GpCr?=
 =?us-ascii?q?Gc8ObP24aroOXVRkxvz0PkeypBbpyM/my7fsyE3LlXLpRab0A6Toa3Fs?=
 =?us-ascii?q?PveKydyIlC1BMzkO+G0I5nlmgvdmuAzYibk/noDYGMkzNMSbRVd33m/e?=
 =?us-ascii?q?JYdy4iMXeU362C3n2FXjH8jw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 20:19:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703531926; x=1704136726; i=markus.elfring@web.de;
	bh=IaAm0WH4z0TXKCwsXTfWMMZiVW5H3xtLRNKz36NJgmM=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=ewJKlnWBon/YFQvM0LsjiHpYgHYALpKQn17J9D8AEMznf7v7cDZctq6JcEzh8nz3
	 AEMIQOKMjDrnG9b7E0y5sAYyp1o35gXrHKAAR8s1FZU0Ng3EBYnX771dmtyYA6rTp
	 QLZh5827+wkZonIYpVk1d1MxzteLtswFeTsKjdp/UqoGcjy2G/roXUcCh3nZvRD5N
	 WiMrpll4WYbMlH6h0Jt/YYSfKCENFYU2a1otZPgqNAF9nJMyaIwOTtArk/kxbKoYy
	 Y8NfzW5NBqUcyziXtkwsWo/Wle3sq3U+kead83/rXt+naPytC8d3gnywNt0F1Lh26
	 tz9cjlkqnC9ahn7Y1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mo6Jl-1qtoKb1un5-00pEOD; Mon, 25
 Dec 2023 20:18:46 +0100
Message-ID: <07ca2474-560f-4cbb-9740-db987227416a@web.de>
Date: Mon, 25 Dec 2023 20:18:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linux-tegra@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, Justin Stitt
 <justinstitt@google.com>, Kees Cook <keescook@chromium.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1Dx6vLiujrwX/styXNp1tR5nNZwKVUpxfUgckaGAeQMhLhd72JR
 g0k1oxnB2Q1MhQ/TSR/IL3LKWsuqy+7AKhSTDj3Pr6sfEtwvaC2JVFbseTlG2oBlnCls4d8
 SBqOZFh5sZKijbwlfQLmykM/YS3eFE59/s0L5WrFqcju9/NvOeKEbFzQwJRp+XdiaJVbkhV
 GX2BiN4pFB+1gRGNF4drQ==
UI-OutboundReport: notjunk:1;M01:P0:9EhpqDUh4eU=;/MCHgEjnuTlr8ORYlyOXc1Ibztp
 P/eDlh0Xd+VwkT1u2/mXCgGa0USATF/EuWmdAFDe1/szSxKf5GLUmE3cd9TZX4wh0DdT6Buf2
 J0ZBXt2zDnr9ABwV80Nc26px4XJct7b1M/KpCpPv73FF9vZ4HD/1I2hi7XSoLRSsg+yn62Qcj
 clL/Do5LfXZ81gDQOCaQtImxCDgY4aqmnfviideEoQ4Vx/PgUY58pHe3she58E7CxCwKdVPw1
 ABQxnrQ0mx2iuIvYf7TfPWlgx1rH+gghNu8XFJftZw4NIlZ5W6CW9XiZGWyqKqAPnb3ABlag4
 HClPdWbN6x5Duk/c1zdKLE9o7GrGzzrAjm/0VCKuxiUxZBpKcUyBjdDYRg1jL12t9VLUc8eUR
 I9fEWTWTLwvgqpztDIoNn7rkdeu90iqM0xZi5JN6TFQ/m3DKF6NuCqfTWrO/arBGuMpY29VWM
 YUtI6to0e8O7Z6c10nfbFW0ZkvcT+tFVUxxDD7yCuKUv2ZFsm+bpCb6fiBB/LnWN4+kDtRAzP
 X3vkUQZA49LI2dgeQHtjJIibEY0notIcdDLkW9KLjN1fvEeSWVgWln9i8DVCi6sWhpOiGEwp6
 s5I7FzyatBNPgruwLuADNTDj3rfXrFlo59zgn7S1zSkLcs6OGiA3dGAjagN5AB+RrjKFI8mdn
 /N07gXIcvYNZJBAfSzp/hJVxyplUFjV6zCEYZcUXlOLgcdqPOduphTekxQO+59rix1Ihy5+IC
 n7LxF9c1hOHSxdnhwUklF0FuSVtboT4ZmkQrckEYwtMNtBrQ+LXaET6fs957iv88kN7CvIdAr
 EI742ipRd1pzF7p1KBU/rbkVLqSAuDL5o70sxru9jvvJfkoASUH1WcfO8nXsSlGp+V1ERAjya
 NAHQTFWsfnKtsoObvMiACa3sRALKBRGVgmz4lugo9HFoVV3kNKYqT6Dw2+pFBYuoXz5M+FOHL
 7jfSNg==
Subject: [cocci] [PATCH] firmware: tegra: bpmp: Return directly after a
 failed kzalloc() in get_filename()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1392
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/07ca2474-560f-4cbb-9740-db987227416a%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 20:03:56 +0100

The kfree() function was called in one case by
the get_filename() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus return directly after a call of the function =E2=80=9Ckzalloc=E2=80=
=9D failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/firmware/tegra/bpmp-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/tegra/bpmp-debugfs.c b/drivers/firmware/tegr=
a/bpmp-debugfs.c
index bbcdd9fed3fb..4221fed70ad4 100644
=2D-- a/drivers/firmware/tegra/bpmp-debugfs.c
+++ b/drivers/firmware/tegra/bpmp-debugfs.c
@@ -77,7 +77,7 @@ static const char *get_filename(struct tegra_bpmp *bpmp,

 	root_path_buf =3D kzalloc(root_path_buf_len, GFP_KERNEL);
 	if (!root_path_buf)
-		goto out;
+		return NULL;

 	root_path =3D dentry_path(bpmp->debugfs_mirror, root_path_buf,
 				root_path_buf_len);
=2D-
2.43.0

