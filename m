Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23860C25B47
	for <cocci@archiver.kernel.org>; Fri, 27 Oct 2023 08:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=kwp7ePqF9akyG7adzEhrCcoifyxGbboMqcXlL5Ll6/E=;
  b=gPj+X64rHHYoAPlGI8YhMqurhBCHg6TvN6kXoFQ5O7X6r2UZQZ2qvGOk
   4hixU4C0FJbOTiGaXhiSmcCHMCEJylPHx5AUVAREL3RNUY/blNfKGg6W+
   wO8nmqrFoK+J+uh8VdPhvo3fhCpWugDYaMTKk/UpRD/+fqtKaQj7E8MR4
   A=;
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
X-IronPort-AV: E=Sophos;i="6.03,255,1694728800"; 
   d="scan'208";a="133509079"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2023 10:31:09 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CACD9E0205; Fri, 27 Oct 2023 10:31:08 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 03FA8E00B7
	for <cocci@sympa.inria.fr>; Fri, 27 Oct 2023 10:31:07 +0200 (CEST)
IronPort-SDR: 653b7549_aO2PIfnqp67RmggFoujqjDmmJOsxhfbbTxb65RuZ2d2czBi
 MUF0ODjOFNnjN3DGGj2pEBdt4gya58jGTSLAlLw==
X-IPAS-Result: =?us-ascii?q?A0GOGwCHdDtl/wwR49RaHAEBATwBAQQEAQECAQEHAQEVg?=
 =?us-ascii?q?VGBTwJmB3NWDyEEC0iEU488hmCOfYhvgxY+DwEDAQ0UAQEjCAECBAEBAwSCC?=
 =?us-ascii?q?4oQAh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQKBBhOFa?=
 =?us-ascii?q?A2CNyQZgQxfCTYBAQEBAQEBAQEBAQEBAQEBAQEBFgI9CmsdAQERJywIAiYCS?=
 =?us-ascii?q?ykBAYJ6AYIpAQMxBw2rcYEygQGCCQEBBoFaCYEDrG4fLCJVgV8DBoEaLAIBA?=
 =?us-ascii?q?YduGgEFY4lFD4FVRIE8glMBg04CAgGCKoMOgmiDd40eiwGBAgVCcBsDBwOBA?=
 =?us-ascii?q?xArBwQwIgYJFi0lBlEELSQJExI+BIM4CoEGPw8OEYJDYTYZS4JbCRUMNU12E?=
 =?us-ascii?q?CoEFBeBEm4fFR43ERIXDQMIdh0CESM8AwUDBDQKFQ0LIQVXA0cGSgsDAhoFA?=
 =?us-ascii?q?wMEgTYFDR4CEC0nAwMZTQIQFAM7AwMGAwsxAzBXRwxZA28fNgk8DwwfAhseD?=
 =?us-ascii?q?SssAiEEDgMZKx1AAgELbT01CQsbBj4CnhYDbYF8ggIrgVpdkxgEkFWgezQHg?=
 =?us-ascii?q?jGBXgWBWgyIc4EjlQ0GEy+XHQ4GkkkemCCNZZUkhUiBeiaBWTMaJIM2TwMZD?=
 =?us-ascii?q?5JLhGGKZz81OwIHCwEBAwmFRgEBg1qCKQEB?=
IronPort-PHdr: A9a23:OsiOfByb2Mhc39rXCzKKwFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 hyZtK4m1QWWFcWDsrQY0bSQ6/ihEUU7or+5+EgYd5JNUxJXwe43pCcHRPC/NEvgMfTxZDY7F
 skRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCS+bL9oK
 Bi7owrdutQIjYZgN609zgfFrmZSd+lZ229lJEifkwrg6su14ZVu7zlet/U9+sBaTK70Zb44T
 btWDDQnN2A6+sjmvgTdQAWM+3URTHwYngJHDAbZ4h76WIzxsjbhuepmxCaaJ8z2QqsqVjmk8
 qxmVQXniCYDNz4+7WHXlsl9h79VrR69uxByxZPfbYeIP/R8Y6zdZ8sXS2lPUMleWSNPHIOyY
 ZYTAOQOJutYs4vwqkESoReiGwWhBuXiwSJIiH/s2q061vwsHwbc0ww6HNIOrW/Up8j6OqcWX
 +C11qjIzTPMb/hL3jrz75LHcgoiofGRRrJ8a8XfyU0hFwPfj1WQr4PlMiib1+sTqGeX9fdvW
 vy2hmMhtgp+rSShyN02hYnVmoIa1ErE9SNhzYg1ONC1VlN2bcOqHpdNtyyUOIl7Tt0iTW9op
 io3yKALt5C5cSUFx5oq2RDSZuKafoWG4hzuV+KcLDl2inxlZb+ygQu5/0anyu35TMa00VBKo
 zJLk9nNtXAN1gTT5daaRft85EitwzGP1xrc6uxCPEs6lrLbJoY/zrItiJYfq1rPEjH0lUnsk
 aObdF8o9vW25+j/ZrjrqYWQOoFphg3kMakjmdazDOA4PwUIQmOV4/6z1Kf58k38WLhKjuM5k
 q3esJ3CIMQbobO5AxNP3oct9RmwFC2q38kGknUfLVJFfgyIj5TxNl3QPfz0E+2zj0qynDpp3
 fzKI7/sDo/QInTdiLvheKxy609YyAo919Bf4JdUB6kGLv3pQE/xt8HYDgQjPwK7x+bnBs991
 oIYWWKAGaKYPr3dvkSS6u0yPeaAfIkVty3lJPg/+/HulWM5mUMafaSxwJcbcGq4Eeh+I0WFf
 Xrshc8MHnsNvgUiUOPqiUaPUSVTZna3R6Iz/Cs3CIOgDYfZR4CimqaN3CmhHs4eWmcTAVeHG
 nbAdoOeWv5KZjjBDNVml2khXKKiVpRp+BWgrg78xPIzC+PO+TAD87/n2sJ04eL7ihw4szB5W
 ZfOm1qRRn15yztbDwQ927py9BQVIjar1KF5h6YdDtlP/7ZTVQx8M5fAzut8AtS0WwTbf97PR
 kz1Cs6+D2QXSdQ8i8QLf147A8+r2zXKxSm3GPk4k7KRBZo72r3R1T79KpU10G7IgZEolEJuW
 c5TLSujj697+RLUAtvsml+air3sWKASxi/L+0+cwGDIsEwLGBVoX/DjWnYSLlDTscy/5k7GS
 Oq2Dq87NwJa1cOYAq5Nd8GvklhMAvvuUDjHS0S2nWr4RROBx7fWKZHvZ31YxiLWTk4NjwEU+
 3+Ccwk4HCao5WzEXnRoEhr0bkXg/PMbyjvzR1IozwyMc0xq1qaksh8Ti/uGTvoP37UC8C4/o
 jRwFVy50prYEd2F7wZmeaxdZ5s67jIlnSr8vhZ+I4fmAqRsnF8YfCxoskmo2xg2QoRMnM42r
 W87mRJoIPHQ21dAejWEmJHob+eOcC+opk/pMvGQgwuNtbTesr0C4/k5tVj56QSgF054tm5iz
 8EQyXyXoJPDEAsVV5v1FEcx7Rlz4b/AMUxfr8vZ02NhNa6sv3rMwdUsUaEAwwyjYswZHaeKD
 g70HOUFCsLoJOFgyD3LJloUeftf8qI5JZbsUvKc27Owestkkiini2tv/413lE6BvXkZKKaAz
 9MOxPeW2RGCXjH3gQK6s8z5rotDYCkbAmu1zSWM6Jd5XqRpZs5LDG6vJ5fy3dBin9v3XHUe8
 le/BlQA0cvveByIblW70xcCnUgQpHWmn2O/wVkW23kMp7CcwTeI7uDsbhsBNUZUSWMkgVqkL
 YWvjt8cVVSldEBzzUHjvxylgfEE4v0lZ2DICV9FZS33M31vXs7S/vKZbshD5Ylp+SRbXeKgY
 EyLH7v0oh8UySTmTCNVwDE2cS3vu42sxUUgzjjHczAq8zyAI5IVp1+X/tHXSP9P0yBTQSB5j
 WOSHV2gJ5yz+t7SkZ7fs+e4XmbnV5tJcCCtw5nT0UnzrWBsHxC7mOi+39P9Fg1vmwryzdp3T
 mPlqBjmY4/k/7u3O6RrcwM7YT20o9o/AYx4noYq0ds10GIZm47T0H4Ji2b1Pv1E1Ki4YHdHF
 ltpi5bFpQPi3kNkNHeAwYn0A26czsVWbN6/emoK2yg54pMCGOKO4bdDhycwvkugoFebf61mh
 jlEg6hLijZSk6QTtQEq1CnYHr0CARwSI3n3jxrRp9Gm8PcNPTzpK+LvkhMkw5b4VuHF+Fw5O
 j6xe49+T3UptIMlag2KiSC1ssa+JZHRdY5B7ETO1U2a0K4Md9Rp0aBVzSt/ZTCn5CJjlLR91
 E00m8vm7M/degAPtOq4GkIKZmezPp1OvGiw3OAG2ZzIl4G3Qsc7Q2pNA8GuF6r3VmpV76uvN
 h7SQmdl9THEQ/yGTFXZthsh9SyqcdjjNmnLdilDi4w8GV/Hfh0Z2VtMFDQiwsxpTEbzmpGnK
 hwhoGpLrkjxrh8Gog5xHz/4VGqX5AKhazNuDYOaMAIT9AZJoUHcLc2Z6Ot3WSBe5Jyo6gKXe
 CSdYExTAGcFV1bhZRirN6Sy5dTG7+mTB/avZ/rIb7KUrOVCVvCOjZux24pi9jyIO42BJH5nR
 /E830NCWzh+FaG7030XTDcLkivWc8OBjBK75zExsc21tvjmGUru6YaJF7pOIIBv9hSx0sLhf
 6abgCd0Lyod14tZnyaSjuJFgxhL1Gc3LWrIc/xIryPGQaPOl7UCChcab3k2L85U9+cm2QILP
 8fHi9Tz37o+j/gvCl4DW0ay/6PhLcEMPWy5M0vKQUiRM7HTbxjC2cLqeuWRTbNKjeNbnwK9s
 3CXHgWwW1bL3ymsTB2pPexW2WuDOwdCvYimbht3IW3kUc6gdRCxdtN6x25To/V8ljbBMmgSN
 iJ5ekVGo+iL7C9Wtf54HnRI8ntvKeTsc8mx8OTSbJob46ID6sVckuVH/DIlxrET4CwWHJSdf
 QPNo9Qor1z0yoGy
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:csDRYaAFz+JsPvrlHemO55DYdb4zR+YMi2TDpHoBKiC9Ffbo8P
 xG/c5rsSMc7Qx7ZJhOo7+90cW7MBHhHP1Oj7X5X43PYOCOggLBQb2KhrGSpgEIdRefysdg9e
 NHb7V0DsH2AGN3lMDg/WCDYq4dKZW8kZxBno3lvhFQpOxRGthdB4wVMGymLnE=
X-Talos-CUID: 9a23:yLIJjmy19qRQ1V14voQMBgVPAe0mQGON1k3SBF/kDW9KQ52UTAOprfY=
X-Talos-MUID: 9a23:8bAe9QnYFstVtYZQn3gjdnp4Kvg5vIryC3oqz5tbmcm0GHVQYzOk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,255,1694728800"; 
   d="scan'208";a="133509067"
X-MGA-submission: =?us-ascii?q?MDEt+C2hpHtdO0BmvsIiQlGEihOX2gnZOf208I?=
 =?us-ascii?q?XiWttWVAsNS3WG+bCYpsBQzaYeMtnLtPlOh+Qgm4qwSNscohk6wPgnv3?=
 =?us-ascii?q?S+iQB8i7Xq/XzBQ7GecZP/iEgj2JB30eGQy4JaYzg+mLJjb8TVd/OyY7?=
 =?us-ascii?q?XyhdIGn8e6K742UDvdrV1Jhg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 10:31:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1698395457; x=1699000257; i=markus.elfring@web.de;
	bh=pcm4xCk4wzUaC+/ag3Qk0xAR7J6ny3EpZ+H+JaTQJF8=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=MZ5NCzSbaQeGugaXyOxjXgeN9INWDO1a9wlTJ5QVMMs+HaZ4dHjFQb4I2WUggm60
	 Rf+IP7L/zur3xz7rMETIZkLWKxdZayoypK4uYnwR/LTgif19jmCREOLCzNY+aF+wo
	 3OKiuQuU+duo3xOhb6Q6SDua4GlOaOvTZLtp+cmTwrPDGjMbAmvGcfdgAb/bM/sJ4
	 dO4pul6vhwKMqCJsQj59SGevw5fp4DVd/cIh166uECkF1trDrtMValcobaovOupWI
	 VVxqv69neL395Hok0a8pB6fEIkEytgxOymzg0jqD2eDtakrQ87zYbH5C+2I9+lhAA
	 R9PC6beDqXMVRDWMHw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlsOP-1rLyH63H1v-00inID for
 <cocci@inria.fr>; Fri, 27 Oct 2023 10:30:55 +0200
Message-ID: <d5bd4be2-9a50-4e67-b924-2c3bdc736a9d@web.de>
Date: Fri, 27 Oct 2023 10:30:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:qL2cN2WjichLINRvQQSIrmJEASi4e7QqTzKUV1gCzP2zVWk19kB
 ntZTAI7uHxxTdVBN0zfPZCf91VyZhgLZZs5hFR8TIOCcdH4SYO57fW6NzRO0ppUr4+/5Gfw
 I3kzUe6WmZyYa/izjpaI6jfRJq6Nyhm3skJK5EwH4NfpH4H6qFZ5qQhDAVivqz2o8/9PVW/
 FeYfyQtWHnuP+SNnajDaw==
UI-OutboundReport: notjunk:1;M01:P0:WJVHK3LjD6g=;ueaggjJyiSIQesZ8rM3SAFl+lok
 XK5+v4MtmeNNQOiEELZJxZ+BKj/JWBIg001ciEaTCa0j9Jm7hOADP71M2PcuV/g+ONYEEB0Ya
 qUI4eFNFUfvgEwbZ+6U8eLENFOhEOCxmxIDpeeFFDK+G0oV35S7Lgtxd9qPxfPGutKyj2mXXJ
 786GyVf+rie4cZctmFFYHE5eqci5/5C3wLCe1lyLMvChY5CDP9M8u0hI3Nbk9nF6sSa/XGyXG
 8uWQawKPEFuh+amaEaBspcyFI1+AGWOv9tDbHLY5vQm40B3kgwxlxeMpeXmWqDrWg/NYcQwZB
 3j//Jed7IYo75skaUMhBnaOuOg2XZLQFpUcJTzBc06vWtcOqG9MIHjJ70H81SxIjHxQTFqFjD
 PShUxMtMOlArvsSJi1CvoMDmAcPHqGWUfuesPJ78iz2AMFlOkcIpjna8wWMBdXpcKWFycQmfU
 5gIxfZsmIEfvATiOcsMiL4Ud6ep5zwz/SItt+W/Qdx2CvnTljeISKIDosggBIAbXGVWwa9Ij2
 qJyysh+D/1Bf/a0FDb4K7WMcH7LFAduXnl6j1Q8XbRKqHVBMf6XvFQBJSzKDPrE5M8SFNTHuo
 n6WmijWFHWQPpfZMlLFme+cM/JvMMkSwKMnwlPHMBZT4CiOkz/mEjYSB9K2/IguxrDqm3wApW
 3WZeEvfcOoI1fWEyPeQWrAS9a5MN3heZ87GhlbYqQWJlG0hYnVQzmxgaTZ6q/7ijnIceVtMi+
 U6G4QlkUxJsuq2TcAKWCzWFZLd3tgYThQ==
Subject: [cocci] Designing data processing services
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1280
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/d5bd4be2-9a50-4e67-b924-2c3bdc736a9d%40web.de>

Hello,

The Coccinelle software contains components which were combined in the way so far
for the application of a few programs that perform batch data processing.
https://en.wikipedia.org/wiki/Batch_processing#Modern_systems

Some parts parse input files and convert them into internal data structures.
https://en.wikipedia.org/wiki/Parsing

* How do you think about to provide such data conversions as a service?

* Would you like to benefit any more from a service-oriented architecture?

https://en.wikipedia.org/wiki/Service-oriented_architecture


+ Will any additional development resources become available according to tools
  in involved technology areas?

+ Do you know any services which could be reused better?

+ Can corresponding service descriptions be designed and improved accordingly?


Regards,
Markus
