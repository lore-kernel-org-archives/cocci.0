Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14233C46CD3
	for <cocci@archiver.kernel.org>; Tue, 26 Dec 2023 20:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=faaawBSY1NgjHEBcblTo418oU7X5Y1eOM+YLsfmhgjg=;
  b=oHt5yabEExi2RV9ipAhkmsNn0ukh5sWGB9wav/lHmca9dS3KWD63n3An
   iN87DywKMnj5k16FYrXR7F1lCZGG9LpwvF45yD1J6fo0ONrPDgwQNh2/+
   jJUE6rJZagGwh0iCmBYTobgPd2qSBLZnDAcbEneaHnpi2OfRCi815wdVL
   g=;
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
X-IronPort-AV: E=Sophos;i="6.04,307,1695679200"; 
   d="scan'208";a="144075404"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2023 21:08:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BBBCDE0CCA; Tue, 26 Dec 2023 21:08:25 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 500F2E004E
	for <cocci@sympa.inria.fr>; Tue, 26 Dec 2023 21:08:24 +0100 (CET)
IronPort-SDR: 658b32b7_hdfw9fvE4n8gXdfnNmU5ONNpQLFMQQ8S5DxalT+hGJXwTC9
 eyfqynpTbvYZhNmJsykv6PNHWHFYvv4pXy5VJPQ==
X-IPAS-Result: =?us-ascii?q?A0E8AACnMYtlewwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4f1MyBAtIhFOIHYckgXUthD6HNYdMiG+BVoFAPg8BAwENQQECB?=
 =?us-ascii?q?AEBAwQ3AYFTgnSHOAIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABASQYBg4FCyeFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RcCR2sdAQERJgEuAQUCJgJeARICAQGCfIIrAQMxB68jgTKBAYIKAQEGr1gfL?=
 =?us-ascii?q?CJWgWAJgRouAYgaAYVng0GBIQ+BVUSBPINBhAqEFIJoiRsHMoIdg1CRV30FQ?=
 =?us-ascii?q?XAbAwcDfw8rBwQwIgYJFC0jBlAEKCEJExJAgy8KgQE/Dw4Rgj4rNjYZSIJYF?=
 =?us-ascii?q?Qw1BEZ1ECoEFBeBD24bEh43ERAFEg0DCHQdAhEjPAMFAwQzChINCyEFVgNCB?=
 =?us-ascii?q?kkLAwIaBQMDBIEwBQ0aAhAsJwMDEkkCEBQDOwMDBgMKMQMwVUQMUANpHzIJP?=
 =?us-ascii?q?A8MGgIbHg0nIwIsQgMRBRACFgMkFgQ2EQkLKAMsBjgCEgwGBgldJgcPCQQlA?=
 =?us-ascii?q?wgEAyspAyN0EQMECgMUBwsHUgMZKx1AAgELbT01BgMLGwY+AqZFB1MoE0yCK?=
 =?us-ascii?q?pJyCpMTnnI0B4I0gWCBYQyfKwYTL5cmDgaSUwEuh0CQXyCoRoFjOoFcMxokg?=
 =?us-ascii?q?zZPAxkPjiA4g3OPR0A1OwIHAQoBAQMJhUYBAYMmNIFGAQE?=
IronPort-PHdr: A9a23:N96ZWBUoDeft6NKtef5otAR1/zPV8Ky0XDF92vMcY1JmTK2v8tzYM
 VDF4r011RmVB9WdsagbwLOO4+jJYi8p39WoiDM4TNR0TRgLiMEbzUQLIfWuLgnFFsPsdDEwB
 89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9sL
 xi6txvdutcUjIdtN6o91hjEqWZUdupLwm9lOV2ckxHg68mq+5Jt7zpesO87+c5aVqX6caU4T
 bhGAzkjLms4+s7luwTdQAWW/ncTXXkYnRROAwje8RH1RYzxvTfgtup8wyaVI8v7Rq0pVDu47
 qdrTBjoiDobNzM87WrahNB8gL5drRm8vBF03ZLab5+JO/p/ZqPdfM0VRWxdXsZKSidNBpqwY
 5YTA+YdOOpVqZT2qVkTohukHQSiB+3hxTBGiXHow6A00/kvHh3J0gE7A9IOqW7ZoMnpOKsMU
 +24yrTDwzXZb/NR3Dfw8I/GfQo7ofGPQLJwatfax0YrFwPLlFWQqIrlPzyI3ekKtGaU9fBgV
 eGyi248sQ1/rTyvxsk2ionIgIIVxUvJ9Ctnz4kuP9G3VVB0bMeiHZBNuC6UK5F4Tdk+Q2F0p
 ik60LsGtIalcCYE1JgqxALTZuGGfoaH/h7uVOScLCp4in55ZL+ymgu//Eyux+DgS8W4zUhGo
 zZFnNTPq30A1hje58eDR/dh+EqqxDWB1xjL5+1aPEw4i7DXJ4A/zrMyjJYfrEbOEjXrlEnol
 KObckop9vKm5uj6eLnrpZ+RO5Vwhwz+NKklh9KyAeAlMggVQ2iU5/682qDi/Uz4XrpHluE6n
 6/Eu57AP8sbvLS2AwpN34Yj9Rm/CzCm3cwdnXkAMVJFZAiLjob3NF7VOvz3EOmwj0ytkDdt2
 f/GIqXsDovQInTdirvtY6hx5kxGxAYuz91T/Y9YBq8ZLPL2QEDxtdjYDhEjMwyzxubqENJz2
 ZkEWWKMH6+ZK7nev1CM5uIhOemMZYkVuDnmJvkr+fHhlmU1lkIDcqWx25sYc2i3Hu56LEWBf
 XrsntABHH8XsgYmVuzllEWCUSJPZ3a1R68z+jY7B566AofCXY2tm7yA3CKjHpJMfGxGC1aME
 W3pd4qeQfsMZjiScYddlWkAVL68W8og0wmzqCfkxLd9aOnZ4CsVsdTkztcxr+7ejxc/8Xl2B
 sKcz2aXVElqkW4SATw7xqZypQp60FjHmYR9guBCBJRv4OlOUQc9K9aIw+l7F8rjHB7GZNCKS
 FG4atqjCDA1CNk2xolKK2F5GsuvlFjsxSO3H7Jdw7uPBYI56OTTxXHsO8tVyHHN06ImiV8rS
 ddILyutgasps0DuGIOBsEGUlqCnMIeC2i/CvDOei2mKsUBeXUtzVqjDXH83fkbQosnl/ETET
 q/oBblxdkNQxIaSK61FYd3kix0SVfqlKNXYbGmxlmGYFwqFgLiLaczhfTNO8j/aDR0hmhoQ4
 G3OGAwwHCanrCqKKTV0Fk/0JW7o//N/rnyTUUI+iQ2HOR4yn4Gp8wIY0KTPA8gY2agJ7WJ48
 20c9DeV2tvXD4HFvA99ZOBHZst75l5b1GXfvgg7P5q6LqkkiERNOx9vsRbI0BN6Qp5FjdBst
 GkjmS97M6GFyxVscz2C3Jb/EqLaIC/+8UPncLbYj2nXy83e4aIT8LI9olTnshuuEx8H+m9kz
 sIT/n+S/JTMAyINXJi3XktkvwNiqeT8ZS8wr5jRyWUqMaSwtWra3Mk1AeI+1hu6V9JYLb/CC
 wL4VcEXbyS3AMotnVXhLhcNPeQJsbUxI9vjbPyenqiiIOdnmjuiy2VB+oF0lEyWpWJ6TabT0
 pAJzuv9vEPPXirgjFqnrsH8mJxVLTAUEG2lzCH4BYlXLqRsdIcPAG2qLoW53NJ7z5LqXndZ8
 hakCTZkkIeMcACRcke78Alez0URrlS4lCH+wzE12zAlo6yD3TDflvz4fUlPMWpKSW9+yFb0d
 NLt1ZZABhfuNldvzUH2gCSyj7JWr6l+MWTJFEJBfiytanpnTrP1rb2aJchG9JIvtyxTFuW6e
 1GTDLDn8H54m2vuGXVTwDcjenSkoJL8ylZfgXieMW01gX7XY8B2yj/A6daaSfMbjV9kDGFoz
 CLaAFSxJYzj2NyOlIrY9M26WXigUJJ7biThi4+N/njehyUiEVi0mPa9ncfiGA4x3Hrg1tVkY
 i7PqQ71fojh06nS3ftPRkBzHxe87sN7Hto7iY4snNQL3mBcgJyJ/H0BmGO1MNNB2Ku4YmBfD
 TIMxtfU5kDi1igBZjqszpj6S27b789vfdi8bUsJ1yh7480CBKqP7bNClDd4uRLi9FiXO6Ii2
 G5Cj6J0oHcBy/kEog8s0jmQDtVwVQFDMCrgmg7Jp9GyoaNLZXq+JL251U5wh9ekX/mJpgBRX
 mq8e493R3YqqJ8lbxSVjzuqsNKBGpGYd98YuxyKng2ViuFULMl0jf8WnW98Pnq7u3Q5yuk9h
 Bgo3JegvYHBJX8+mcDxShNeKDDxYNsevz/3iqML1OOfxYOyBdNMHjsRXZ3nZe2lGnQeuL60U
 mTGWC15sXqdFbfFSEW64V1lsmmJPpSlLXCRK1EGwN8kSBTXdyk9yEgEGT49mJA+DAWjwsfsJ
 Vx46j4m7Vn9shJQy+hsOkq3QiLFqQyvcDtxVImHIU8c8FRZ/0mMe5/7jKo7D2RC85amtgDIN
 mGLe1ECEzQSQkLdT1H7Yuv0vIOGqbLHQLPkcb2XO+XJ87E7Nb/AxIrzgNE/pXDWbJrJZyQkV
 7phhwJCRSwrQZ2D3W9VFGpOyGSVKJTE7Bakpn8t95/5r66tAVO1o9HTW/wIYLANs1i3mfvRZ
 7TW3Xgkb28Fh9VUgiWWgLkHgAxI0n4oKGPrS+xf83aKFv2Ym7cLXURCNGUsbo0Rvvh6gFUKY
 5C+6Ju916Yk3K5vTQ4bCBq7wJDvPJdSa2ClaAGXXgDSaunAf2aThZutKbW1Tbka5AlNnzu3v
 zvTU0rqPzDY0iLsSwjqKuZUyieSIB1Zvoi5NBdrE2nqCtz8OFW9N5dsgDs6zKdR5DuCPHMAM
 TV6b0JGr6GBpSJejPJlHmVd731jZeCakied5uPcJ94Yq/xuSihzkutb5jw9xd43pGlcQ+dpn
 SLJstN0i1Shj/XJ1TdtFhZD635KiI+NoUR+KPDZ+51HChOmtFoG6WSdDQhPpsMwUIS1/foKl
 Z6Wy+SqcmQnkZqc58YXCsnKJdjSNXMgNUGsAzvIFE4eSibtM2jDhktbmfXU93uPr5F8pIK//
 fhGArJdSlExEesXT0p/G9lXarJ+RDA5ivi2iMAS5HyxhAbcToNWs9qUM5DaSeWqMzufgbReM
 lEQxqjkKI0IKoDh80lld0U8g4nAXUbdF4MowGUpfko/p0ND92J7R2s41hf+aw+j13QUEOa9g
 h88jgYWiQUF8TDx/xEoK1CMqCZiyCHZdv36jDrXfDOjdc9YuKlJBiCyu0VjavvG
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:1SsLj6pHxv383pe5VJsIzn0aV5rzeYIsimQD101hICG9vPbo9f
 xG785rtiMc7wxhPk3I+OrwX5VoJEm2yXcb2+Ys1NuZLWzbUQiTQr2Kj7GP/9SIIUSXm9K1vp
 0QF5SWZueRMXFHrYLd/BSyFcomzeKK6aaymI7lvgxQpE1RCp2J9G1Ce3+m+6BNNXF77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:r1cD1mBeftrJv576EwQ36mxXRZp8SHf2ymboeRWRU2RLWLLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3ANiHbKg9eX9HOvfXECgrZJFGQf+M1vq7wJUQSq7A?=
 =?us-ascii?q?9hNu+KhF1HWm6gTviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,307,1695679200"; 
   d="scan'208";a="75376286"
X-MGA-submission: =?us-ascii?q?MDEfspHcY9iajEb4s+UACJ4TZYlDj5YwNYkNVj?=
 =?us-ascii?q?uhXwC187zhIMSkPHfqGgPUJi3dfSRJ0OD3RkyBndL0ImynA0XQl5JzwO?=
 =?us-ascii?q?5AEB8uj/kgfQlMv/H/4VWree8smCK3TFcyeCzMHc0KA5jrnCn31AuLYB?=
 =?us-ascii?q?VYJ0G1DYyZay4BkFtHSS6n+A=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 21:08:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703621295; x=1704226095; i=markus.elfring@web.de;
	bh=Qxkpdv8Qkq7jvs02pZx5pg9wtvajRnmTTkS9S609hRY=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=oAnD7QSqNbRJ4I8z3LJyvZ6S0Oj9GiR6kiseN5OKvZiLGdVlKFg8weWgeZpFBu5Y
	 8KidLKMKxKJtsu8v5vE7olre7V+pdOIDdyvx6GbiqHwuglLMlCM5OjPzoVZtLOqtM
	 25TGKBdi+lnXBZeYFhuoGx6lCRcbFj0fjQZI5n9t3LzL6AYaOqkjAckyiyrugJCzR
	 wxGl3QZYWDl3up9uG6mFuegfs3IqOw8jB1nB7B7pVY/jxFy3FmbnabTR6XIDyh2T6
	 iBcto0SecHQ2kdMiI4VeblOVo4XaEg0tpVLvH+EvNyXy15kg3g4duHndpMWe/OvyY
	 4ZvD61lLPMIcYPE2gQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXXRF-1rl7fE0BHr-00Z51x; Tue, 26
 Dec 2023 21:08:15 +0100
Message-ID: <9365c845-baa1-44d1-add9-ec8ca4d365eb@web.de>
Date: Tue, 26 Dec 2023 21:08:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Oliver Graute <oliver.graute@kococonnector.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 ye xingchen <ye.xingchen@zte.com.cn>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pT5nFzusZbp8RV1rQhzaJrru2NdpxfZ9+vejlMSgbSCpEsu87nx
 IRRVzt3RH6KQhyJ1kJ/nPPRlHlFTT2Ta++KXEYWIy9T9uRBtERBq0zA++AEWbFrsgMKqMXY
 EiipTmC4elOyjytjgmsBRJaQyc1sNI4N41uplGtQ9hN65xP1k2qJ2+YVfMXlGF8SKXGPmFH
 BQqHmoA1bxqY8NmZptKQA==
UI-OutboundReport: notjunk:1;M01:P0:REcKCG5gRbU=;3355Tq7aOrddSDMIBKH/phTHWM8
 w2HnWo9jfx+qPr0x1aeUuxKt3vBE4nuyjFhTm7DGFMSYYDTVCcC/5EotGZxQAW9GR1CAc1IZH
 MDbcAckohOjpcdbJqbbWa+Zkj7tryNEmm601cH7n7VVYlt2NbNVJRF8Lhg5uua+NPD3sbAZkS
 2Srar7F0E08sfQbgz2nMrd3tiBlDbO49yLqMA74tBKGGP8LGuAVfIstqD7dKJp3F0WdT+GNKi
 B+wLOh8z6MhRNULBepKEk3a7R8Z0YrZ1aaC20IHqBxcqDJhWXm2178gqMKImDikUFPJGsfZSe
 VC1pyJ8H/CcF5iR796GX4ipoCoRoPq30it8TcAury72diFN7abWqBPYqbTwZL8A+GcyrcLOvj
 +GoE4YBCbcARZ3PIXH1VleuFpgSmnGFeqW4Vf6795eedOvBaKz6aF8A6p6NRedxslCO8//Q/p
 iPi83I+2BrqxvOa9SWkZ0XBlTVqJGh/duc7u6LLy+CAmCns6/LAFmeVUPWPa70saxsMTTqFW3
 /VYEM8WgclxSYnfK4jqlDhgty1iNPmZUTPG+AhhrAODN3LZMLUNy6L7jDk5HNZPnqKxN0d4ri
 a1VGZKgTG3CMVgbUCaed1j3GuNflKq6mco5Mayg2agV2h3w8y9rMs9W0kGjMRI4TyTwheEai6
 8is+EAtrGuNkthwaVhI9Gl3VnIeW0NE1DmwhYQamHz+92JQxGMzk+/+VxetE+JgVc0lDx0FjP
 3VF+D4TMhGxdomHHreaa+U4d5gM7qyeQxIsUlzshxFJp/dowsWVjglPSlUfHCewmie1qvPWeC
 hS/1nZd190r2oawVw/WpCgsGyuePuPOuVo3xlQXxQA17C7+YepouHQKgR4OQ2Fl9MMev4YJdb
 l6rAxovFhlpAxsV7ftU+tvwL9zbyn3RYZGj4tRiMvvZRbldkb3jVpvie/8YKiBGmCuz8oUcGY
 gkPO0Q==
Subject: [cocci] [PATCH] Input: usbtouchscreen - Return directly after a
 failed kmalloc() in nexio_init()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1405
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/9365c845-baa1-44d1-add9-ec8ca4d365eb%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 21:00:25 +0100

The kfree() function was called in one case by
the nexio_init() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus return directly after a call of the function =E2=80=9Ckmalloc=E2=80=
=9D failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/input/touchscreen/usbtouchscreen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/to=
uchscreen/usbtouchscreen.c
index 60354ebc7242..1873c7918a78 100644
=2D-- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -977,7 +977,7 @@ static int nexio_init(struct usbtouch_usb *usbtouch)

 	buf =3D kmalloc(NEXIO_BUFSIZE, GFP_NOIO);
 	if (!buf)
-		goto out_buf;
+		return ret;

 	/* two empty reads */
 	for (i =3D 0; i < 2; i++) {
=2D-
2.43.0

