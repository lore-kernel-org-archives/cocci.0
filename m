Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25ABCD98C5
	for <cocci@archiver.kernel.org>; Sat, 13 Jun 2026 11:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qeTk5b/IH9pvV/rSygfqGZrks1wHGJuLOzxLQz0T6nE=;
  b=dURH1wl2KETk/6WxEMPcMg4B8b9qqr8arIipKtlbT6jZFthe+viD3n09
   RLe4lI+w6v6H7eXzQnMWB6Zr55bPugysQXLJgkRhqA3Ae1/QLb4iITbCA
   dh+uJBdJ9NWM97JfvJpZ45H/wzdG2UeuqFZ9fPW9EphA/lYJVCkXNY44M
   o=;
X-CSE-ConnectionGUID: JOzW4KgySYKpKtfgaTvONQ==
X-CSE-MsgGUID: tIhtGa0DSvSo8mIcBwF16A==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.24,202,1774306800"; 
   d="scan'208";a="281369207"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jun 2026 13:16:27 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id DA75F80625; Sat, 13 Jun 2026 13:16:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 43E4480625
	for <cocci@sympa.inria.fr>; Sat, 13 Jun 2026 13:06:03 +0200 (CEST)
X-CSE-ConnectionGUID: FjwWDEKiTSWDyRN2OdJr9g==
X-CSE-MsgGUID: ogIFkvrhR220ENag5DEfNQ==
IronPort-SDR: 6a2d399a_qBu6Pv3WUsJtqs5bUAGF+1P/L5LiwX1ZDWG4wQyPH/drf7M
 VwLsvfncV3k/6lKjNbrvow+AsztGujvxTspYvPQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FjAwA1OC1qgAMP49RahRqBCl40BAtJhFiPU4IhA4Q7m?=
 =?us-ascii?q?XSBaAIPAQMBDUoEAQIEAQEBAgSEfwKNRAIeBwEENBMBAgQDAgMBAQEBAQEBA?=
 =?us-ascii?q?QEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQE7Bw47hk8NgluBLIEmAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBFwINOkQBAQECASMEGQEBERgPBAsLGgIRBw4CAlYbAQGCf?=
 =?us-ascii?q?gGCIgEGEAEDDycHDQa0NX8zgQGCDAEBBoFGBw4PgQDXfR8sIluBaQMGgR8uh?=
 =?us-ascii?q?XGCagGKcicPgVVEgRUnC4JIMT6CYQSBF0c/gxyCaoImgQyRGFJ4HANZLAFVE?=
 =?us-ascii?q?xcLBwWBI0MDgQYjDzwFLR2BIyEdFxYeWBsHBRIgKm5FIwMCGjVZQTgKAUMFg?=
 =?us-ascii?q?V0CghhOIx8DOX+Bc4EoZ2cVMDWBAhEfChwCAQttPTcJCxsEPY06GRcPgUKCC?=
 =?us-ascii?q?gErRjUlPw5NDi8DoweifDQHgjiBaIFmDIovlT8GEy+XUw6TC5giZo4KmziBf?=
 =?us-ascii?q?yOBRBEHMxokgzZQAxkPji0Wg2AzxjlFMgIBOgIHAgcOAwuFRAEBjFZrYAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vlGkkDN0tONLl2FiArdCjFXQQuq+x8C+k81xA==
IronPort-HdrOrdr: A9a23:2uw7360nJ8zuu2NRIEofPgqjBGwkLtp133Aq2lEZdPUnSL39qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFgrX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:06/V822crjq5OvsdVXyqULxfNMI6TVHw73bsGHCUGFxPEpqZa0XB9/Yx
X-Talos-MUID: 9a23:f+Am8wkYO/YcoT+GF7uYdnplO+ZG4Lq0CHpXy80rncCLaABdNRGk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,202,1774306800"; 
   d="scan'208";a="149339342"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGZN4O4GMMeG+Gn+1H6W9/0eaCNGvxrUVkwjY?=
 =?us-ascii?q?CoUiRJlWC/WdioreHewQMssYTsXxV1/iwD0L4bFb+vPZBhI4KLc4kepE?=
 =?us-ascii?q?nw+GxJ3m3Zd9dpXPG0vaFrzv2CglnVSQDZ75sB3rotyXhDsHjqIcBJbb?=
 =?us-ascii?q?Xfxk7B2MENI8ZWrLZRpxlgvw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 13:06:02 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Md6xz-1x7y3O2Znf-00jTw6 for
 <cocci@inria.fr>; Sat, 13 Jun 2026 13:06:01 +0200
Message-ID: <ab663a12-5993-48c2-aa0f-c093724cf930@web.de>
Date: Sat, 13 Jun 2026 13:05:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <c7c745e9-a593-4cca-8569-7dfe684dbce9@web.de>
 <0118baac-8e3e-48ac-ab6b-b326492627bb@web.de>
 <713ccb5e-331a-4e65-b91a-b6a6198c96e2@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <713ccb5e-331a-4e65-b91a-b6a6198c96e2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qbIefboDM6pFvJR+FOY5/RaVgpKboShCaQ0yKyxBWd+LiYYU1q0
 Umq6ei9mFImmkTpxCmu2ebycxxBbHUivBrbzCQyp3mkIvP6RNnWABDcbF3EuREowBU+hvAf
 B9kMucW2ucoGQZJWjWw79JgntTHz+b9q/4wKU5PcZ1gCzcJhlBJZ1eam2Wsy+Q3gl9prVN1
 MBnBaERkYJztS+cS8daHQ==
UI-OutboundReport: notjunk:1;M01:P0:+JCbnxPLLVs=;KfFicmDVlodZwC/K+cg+2WYF4qW
 nO2ApfqtiIMnuuyDRHNluk+GwbFlJ3BF3TXRH1TP+tx+m6zb/toekt4MOxu5Ob06s3Qt3hz89
 SZlPjVSm9DsKOUa7X+tslHXO+z2x8O9tTj80PutS2ewtq+U0NodalyZg+dui/MVn7oaT1BZmT
 41L+XAk6HzK91pgvUR077jFGyDjTsaiY75Epq6QdKeVN2dPLyHgATjq1WC009vJRBv8GwZsdz
 O62SiKGgsK2sgnxWPpuIjQXIuINYhoOWRwbJG4Mf7rKyyGuNM4kcqnDIxxSvhSSPUciehyBh6
 KWGtioJlRdjNNUW+RJSPlGzrnnfckqbaHUQpAd7fF9M8VINpCFq8/NuNeIj3JoEBx1G22iTmk
 3Ye456sjHdgzwLH2mE7N0wTOPAYsKcfoE6aiwms0SwJZyXxOSpH9gJ6X0G54tcyjQ3/aLp/8j
 Lnq8x2GQrt2a+R7XEIjPeGWcp4Y7cDbgeeR8oFSBSpzbo1hPL6ec2YWYoJ7vV+NEAT+zxl3FH
 xW4SuG0jfITo6HDqLqJ1zIw8nrfdhdwS6Xu45vg7xP7M6BKS1ao/qwQR1LEpH62HiGg5PtI03
 FFYmQuIOO9sdA8XoWViJQNKfJcnUfwZOV+iIJTumiGl8krqJ53eKsb7AZdFEGXJUMAt43NXCo
 DTIDHjv7wfkS8sYznYcbbZ1opGK58FytBIT9DojAscDkKg0lEGJIYqz7L5gTVOKAC6RPWOF5z
 UbI9vOjym++4AN34g9NyzsplAcEpC87v9eyzzoJFZrw2WxrAEoEsMqCgG+U0NxuBDIkh5mjJs
 yu6xju7VNtzh1yLC7rOpmOKqC5rjIJcY6pLwXKDAA7NoOqlWbaE75SgZNRlryxhRTUo5eEfhU
 JfAt3I3Mw7ECA5U3jgNs9/XDsC7LX4prGZ4FQ4pzj+LzgxxUKgH1RVuStXbC/bWUmOU0EXXIR
 zIhGPLiXKAfvpGGwTqsv5Eh7ZyqYc3SYEPXGH3lzEVwF13EinsezuRsI5N/Po4HAG3n2YUXwS
 RBvd9+ZcvIES5a498Ml+mR0Rh2XGYFagYyl6ohl9OZr3GDyTOJvOuENq8j/q/g9YtnvRW7AW+
 HBuAGtDpdeX6vd1GACjMBIu47Kdptmrk44AslBLMvlfxZhsotCFhRsaSngpW319YdcBo0Gy9Q
 UVNpZOyMgUl79N3dv+fE3xEsi/1Ztf4lzTFsG90QfSb6fdMMQxAJzDDXW8MEpaRguHBXM/cmw
 m/HBFkHxC/xXMuoa+sKs2yR8quYmUdJC6+6hN5e0vXjSLQjRRLVErEYbuWrw4vnAT8kRVbmfV
 VJjYvexbuuT4oT5kE1kP+rHVj6nOk2SlLgWH13ft+Hh0x2C8xNwDRWM/KQU0S3riXeSYsA/J0
 gOihSLEco1nMgizhD+txOuNRQ52AIH4kaAGcu71Po0HiQncUxbGAWp9rPMzKpJbH1DhmVa/FU
 LGsNqiF7MNO+qNLLnW+7KlXrKdosscb14niIejpklSAX+ODVVlTL6zyLEdm4tXqjzZsNGO6J4
 DDgfpzD4YTsnXIr5z/ox/drBdHe0xHSESprp7AV8KLqfehCc5gpcRz7lhhBjRLr5U0USzCu01
 fLpHdqAXl+jVRcvsGKH5ON9EGTwE2Q9/eYkt6XO5zU6TpMkTrdL92rU9xlMp0jssb+RCB7WK0
 luv1Tl0lxcSTHc8v4oDZDH34udAKui0gTv56ddrbbyPHSPP1nWxaWP8bSzT0wbLN7HTU4Uusk
 57ZYc2dMzsr8t+GITq5U0EfnoN+XD+kUmUddZ33CwhnGqYKeTB/EvhZ3435rIQxx8QiuM6dtH
 nNFnhWAw6b+MgxwCGaZPwgplC4Y6+EEZ/Tjk7BVfGq/7e7e2WFDgiriLhD+Hlv45ULDhvNlY3
 P6ajUuktR8CP68vu8yYStPjuHmKOG8nidX68IlPqcPR8cQMQEpAvR5XTEviZfcakqEhhT9X3x
 7zjNznCJQ2l6ZTrUgEqsainkd1ciTrkoMrZZohJeXWGAY8gkmxynUubRdqJW2Ix8qwMM3/Zzf
 JisltAYwsBWW+qx/A8iDvqUotlHkCymg15nvAi/SebAvlNhllnPfcL+uMNFHrJgtTs9KhX6n/
 juleUTtzRrm/lGJ0Xzm8UFULQ8wYgIxMedtvfMLJMdmj5gCKMu7hPlOEe2CbPjRiJvVT9SuD7
 e99qqgCLnwSUdrFSMqghrygk0XiPISTxyTXhWSlXezGvFYDR9xgnsTW+FH6e5KAdIJrKHx4fM
 XFYKR5wyAEfgBmtXV2Fl86AMWEmYoD9wsQK4Wx9/rtAQemjzNQIU2E24m8qRZnZvJgS4WlOV0
 9NxXHZcKozjkYxIjIvfJCEGya58ClDOlSW5T07Lfd0peaQk+DdwiVgjfgrnZVDgEStGL/RHB3
 pEeOZ+pX7YKWQOWmkJUcU1koaJl3m5jI2AVtainvqY4exDvBFgAw+AzQTyqSeDO+DqGgmZPCJ
 3rOBAZn17q4iRHfbOVL9IErmp4Y8XgqNLIA5sFS/+IRL4NT0npxVMu5lmPzKmy6L5miyj8/Ji
 5VivrGKKL12cbyXUjXckx0XtV38CfN4w0Xfor4gBdkpq48FrZ/SAvbQJXC+A0OdfmmosKKp+J
 rlQPHBNRPGjcIuuoRgef7zNotMSympCBV2W7mys9VqT6o35zQKf+CMJ5EbL6P3Tc8wtfSYFHr
 Yvv4K/QMqURuOSCZKQ7bCTQ06JFdzNJG9a83Mc8/6omYeEAl6JOyNEn/mrlyiSfJZBWQ0uBIY
 CmAkX/yNMSyxQcPR4sDa72J5tKAPIVLzPfP7D+DknVhpuTHqWTJbWCsfeNYFoF5XmEG189F+y
 qbR5r58uiWQ8pWLjt0d/CbXoAd4/uJO3F/xSF+rNaWh/xeslyWeWo+vEExrFEGuoKZM/cClhg
 +6E8jpb2sA0oipqgGNsLri7RkZhq34ry4OoTLjxJQwnwoevXCtH2iFi1tpv6Pj86yk5iW2+Ls
 XMpseE6olqip5vZEYvZPzzycuB/bNiKJbmAjQxJretQm/TITDz7YazboL7OAy9bkJAPNczUKn
 XPqnIS0FlflIb7XIyZCrcqkgiWTlFiPFZmUTC8NCxvo9lCrr8PRoW2mRg/D8m4+5ADH5JyVrh
 QR6MyqFSP4YQ4oc9yCJWdepwExqJG4dDcehkAhGUwLxIH4UC423iVb/ORSTofgu4wnIpi59w5
 0OyDgkv9naNgE68frhiULvAa1Pk66XPOAerVkYyvB5mfzR+58jtwEEm9iw7wHlCeP/s3M5Q8b
 9g49uJRnoGBM6I7ekD3u/GJDHwOKUwVpjfxRYWGDU0tuDPDSE3kAu4w8LDyHMx0ye44TjiC3S
 Uf8jG9ciJIY3YcchgPcnI07/n55+SkmvQelw2bDNcmxsuZaeZsI6Vcer37bE/LLt7FEegdpQA
 5S93Avk3F89m0rumK3YPLeWwXSjinLt3JP8X7hgfXcZXFX0sKBgVit14W55mrOVnVswIMEDiD
 v/jtJoPeIgRMYlq/vvhLtz7rL1vYvUXxMXlRqQrpT6L4Bof4jVK9GVaYbN48oJBUL/wyATVFT
 ixESm4NtclJu8uyMUqRwomN563oVEg02bGYEneMOpUPKuRdhifUrPrlnnzAWE/QeMZpQq82L5
 GVzR5u2f3YPiBk43c2kzeVCMVnWtA5/8bQz38rGVjxSShqq/jrUG79CNvZQ7MvYk8HzBlaf1+
 4DsD9BTSeJ9D2lRLQnEjRzDR4iCvM26H/0zrl01iFpNXHXlRIcESZtOfPMg0ZlsPTRkh8uOTg
 YsuDnqp6JLLNc/0HKUYd3/CGETxEwCODWLMJA6QKPDAVlaL9LarMTNmcRedFuXLAHInKUKCjV
 B2adKjhOhjzKN8+APtxcwYPIYfOIWAr5RkyaDzdGg63R4RGHfsWqZpFAsfZ1NvAktWSJBaI9t
 noU51A0d4KiKVgWhJAvZde50CWR/D9fVqjywm5RiRoWiNU2NKn8uJ38hfp+mouu0bvuyh4SHz
 sbF/hnEo/r16tgA1Mz2u31cE+Zuzb9N+Rmdn8/HarUdVOgRb6rWCBi3SP9oPioWGuiWxcFAs/
 VBmIhHSRPXyyCPTlIAv9QJnhYE72l1rqzs9BhFN5qgXyeElLTjyZLEEK3Eq1NHXrMzZjQrUnt
 WiZyf7YGetfBw17QNMre4fUuG6PnAhZmZCVLmST1pUaasTDv/JpsM5zeHAoOzjQZnpN97XofT
 hUjO26A/0Da9Yr8z6IB21aST3d9+zyKhb6j0yqmUqWX2dL2ZnzhapcOX0vXX5PSx8AmP6RbQZ
 gEf87+GFrb2K8tiv000Clm7MKpDg0KzFSQq4jEbDaQ9U97FJB/vehpveOW7hBIWikgrLSjN8a
 GtiSrmqL6V+FkiFs8qcFyOID+p7WHXV75KSLObeJOMtKVQ5sf3BSth8aSQCO6KceDR4uKmiHV
 2TJZrYJihVWWot5AH6tW4Q/QqgAf+hy8f9C2ORFeN4pEzA+OrUJNB/0BVUByh9JcqNlMvnXSC
 J9bO5zItFRIUxLrsUxZDUyAf6wJuqn1kbgBrEcv5iZAq3KhWJI9HaPaFsZ0afY2jvrfrcvRFW
 wNp8OkkJiRNuOwdN2dbxFfZIjNIosA6pXHHF9FsIh1fUxCZnrniC5YDQ+hWscQfk1NivIG7ZF
 QI15m4bW8Odilt7snx1BUVZHNxrGkKCnTonzc8nRCL5vjJkCOErAP1qTpi/FtKouBv2MH4Go3
 FgpdXx0IAnFbPc3ExJ9OGTeZ9mWWplk2CmhmKBCNg3Y7tJ0k43cD0uV44fJ9wPldiw5YM4R5T
 l036s1Y8y0EoMS4hRzZookzFMahXy7RronDVknCNjOg2LIBB1UITH2Dl+R2cJivkr4KMrJJaW
 m5kwVGuYnzig817OJkQn6zqR3AzoLirD/eji2G6e5H3sV5Gc85HoRuEPO5aCezeQKXJ+89fut
 vkwv0EGg+gHsF/5SWQItDpnd0SJMvbrEOnnN29Ddo5EKy9fF8dsii1D45k10fD04nNk5h9X7F
 7ocQ0oIcllD3zeZMedgSO/D30gl39nsRGo62Yq2SXfNAlgpBEMWsCHPy35VZux17ry3FcC8S5
 /Jl2xtdSczNc1sDZ+cikxlabk9RkAYI9VzOM7jHYealwFp1byn41vQqEzmudA2aO/LzcpYrz+
 h3/DWizAVPIwwcjqC1mMQ7WN7TU6hENIXe32Onc6x8SadtCbtyVjZS+hlCjN+0gSk5QEpzU3M
 Rz1zsBgUV7fgIP450bRdtLVpeIyIp9BynUz07fAj+D1DdLZblsNs78G9GCDDNgCiAJdJInvla
 KKdhv7Fmi9lML1e/Fud8YccaFPAVLvoGmlNmNC9x/ClUy0KprqnAJDjK47Yo4i2Gb+q8UC3OE
 jFHMyeXYWU6M6Haf0iFxUj2MlLZKoRUGuwcMZ4wdOQSqlyshVQEfum2ge7MR2/4Vi1SZAVqTz
 zsTz6HgrxhwJzLigg5FOzcHgI9A6MlS8LV6PAS8szd/8t0GNF3RDWvB2rBoQM+eTw9K3AV12K
 uZRk2oDznPpK/eQboXsw+3c0zIYjr92NsiWmaPNmN3plbNhTr1i3Nw6iQYvvJR24h3YmeFnq9
 8I1QNy6A0KV8BGtfTDoTie1+O5ewG99KpLnm9qnMVIgtfMtUw4nG+ZLBdX52OzRzgZOOfQ9eL
 alMUe33uW8BxUNiJM4=
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Searching for duplicate exception handling code with
 SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3560
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/2MkXcdR71-GOtcZJAg3lCA>

>     But the desire is growing to reduce the presentation of unwanted
>     false positives considerably.
>     Thus there is a need to switch to more appropriate data formats.
>     It seems then that multiple code occurrences can eventually be taken
>     better into account with the help of SmPL position variables.
>     Their information can be stored in databases probably also according
>     to ACID criteria.

Another SmPL script variant:
@initialize:python@
@@
import sqlalchemy, sys
sys.stderr.write("\n".join(["Using SQLAlchemy version:",
                            sqlalchemy.__version__]))
sys.stderr.write("\n")
from sqlalchemy import Column, Integer, String, create_engine
# outdated: from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import DeclarativeBase
from sqlalchemy.orm import Mapped, mapped_column
from sqlalchemy.orm import sessionmaker
engine =3D create_engine("sqlite:///:memory:", echo=3DFalse)
# outdated: base =3D declarative_base()

class Base(DeclarativeBase):
   pass

class action(Base):
   __tablename__ =3D "statements"
   name: Mapped[str] =3D mapped_column(String, primary_key=3DTrue)
   source_file: Mapped[str] =3D mapped_column(String, primary_key=3DTrue)
   line: Mapped[int] =3D mapped_column(Integer, primary_key=3DTrue)
   column: Mapped[int] =3D mapped_column(Integer, primary_key=3DTrue)
   value1: Mapped[str] =3D mapped_column(String)
   value2: Mapped[str] =3D mapped_column(String)

   def __repr__(self):
      return """<action(name=3D'%s',
source_file=3D'%s',
line=3D'%s',
column=3D'%s',
value1=3D'%s',
value2=3D'%s')>""" % (self.name,
                              self.source_file,
                              self.line,
                              self.column,
                              self.value1,
                              self.value2)

class action2(Base):
   __tablename__ =3D "statements2"
   name: Mapped[str] =3D mapped_column(String, primary_key=3DTrue)
   source_file: Mapped[str] =3D mapped_column(String, primary_key=3DTrue)
   line: Mapped[int] =3D mapped_column(Integer, primary_key=3DTrue)
   column: Mapped[int] =3D mapped_column(Integer, primary_key=3DTrue)
   value1: Mapped[str] =3D mapped_column(String)
   value2: Mapped[str] =3D mapped_column(String)

   def __repr__(self):
      return """<action2(name=3D'%s',
source_file=3D'%s',
line=3D'%s',
column=3D'%s',
value1=3D'%s',
value2=3D'%s')>""" % (self.name,
                              self.source_file,
                              self.line,
                              self.column,
                              self.value1,
                              self.value2)

configured_session =3D sessionmaker(bind=3Dengine)
session =3D configured_session()
# base.metadata.create_all(engine)
#
# See also:
# https://stackoverflow.com/questions/70402667/how-to-use-create-all-for-s=
qlalchemy-orm-objects-across-files

Base.metadata.create_all(engine)

def store_data(fun, source1, source2, x, y):
    """Add data to internal tables."""
    for place in source1:
       entry =3D action(name =3D fun,
                      source_file =3D place.file,
                      line =3D place.line,
                      column =3D int(place.column) + 1,
                      value1 =3D x,
                      value2 =3D y)
       session.add(entry)

    for place in source2:
       entry =3D action2(name =3D fun,
                       source_file =3D place.file,
                       line =3D place.line,
                       column =3D int(place.column) + 1,
                       value1 =3D x,
                       value2 =3D y)
       session.add(entry)

@searching@
expression e, x;
identifier item, rc, work;
position p1, p2;
type T;
@@
 T work(...)
 {
 ... when any
 if (...)
 {
 ... when !=3D rc =3D e
     when !=3D item =3D x
 kfree@p1(item);
 return rc;
 }
 ... when any
 if (...)
 {
 ... when !=3D rc =3D e
     when !=3D item =3D x
 kfree@p2(item);
 return rc;
 }
 ... when any
 }

@script:python collection@
fun << searching.work;
x << searching.item;
y << searching.rc;
p1 << searching.p1;
p2 << searching.p2;
@@
store_data(fun, p1, p2, x, y)

@finalize:python@
@@
session.commit()
from sqlalchemy import func
entries =3D session.query(func.count("*")).select_from(action).scalar()

if entries > 0:
   from sqlalchemy import Index, Table, MetaData, select, text
   from sqlalchemy.engine.reflection import Inspector
   from sqlalchemy.sql import literal_column

   pairs =3D Index("pairs", action.value1, action.value2)
   pairs.create(engine)

   # See also:
   # https://stackoverflow.com/questions/30575111/how-to-create-a-new-tabl=
e-from-select-statement-in-sqlalchemy#answer-30577608

   q =3D session.query(action.value1, action.value2, action.name, action.s=
ource_file,
                     func.count(literal_column("*")).label("C")
                    ).group_by(action.value1,
                               action.value2,
                               action.name,
                               action.source_file) \
                     .having(func.count(literal_column("*")) > literal_col=
umn("1"))
   session.execute(text('create table t2 as ' + str(q.statement)))

   class results(Base):
       __table__ =3D Table("t2", Base.metadata, autoload_with =3D session.=
connection())
       __mapper_args__ =3D {
           "primary_key": [__table__.c.source_file,
                           __table__.c.name,
                           __table__.c.value1,
                           __table__.c.value2]
                         }

   entries2 =3D session.query(func.count("*")).select_from(results).scalar=
()

   if entries2 > 0:
      delimiter =3D "|"
      sys.stdout.write(delimiter.join(["value1",
                                       "value2",
                                       '"function name"',
                                       '"source file"',
                                       "incidence"]))
      sys.stdout.write("\r\n")
      for value1, value2, name, source_file, incidence \
          in session.query(results.value1,
                           results.value2,
                           results.name,
                           results.source_file,
                           results.C).order_by(results.source_file,
                                               results.name,
                                               results.value1,
                                               results.value2):
         sys.stdout.write(delimiter.join([value1,
                                          value2,
                                          name,
                                          source_file,
                                          str(incidence)]))
         sys.stdout.write("\r\n")
   else:
      sys.stderr.write("Duplicate statements were not determined from "
                       + str(entries) + " records.\n")
      delimiter =3D "|"
      sys.stderr.write(delimiter.join(["value1",
                                       "value2",
                                       '"function name"',
                                       '"source file"',
                                       "line"]))
      sys.stderr.write("\r\n")
      for value1, value2, name, source_file, line \
          in session.query(action.value1,
                           action.value2,
                           action.name,
                           action.source_file,
                           action.line).order_by(action.source_file,
                                               action.name,
                                               action.value1,
                                               action.value2,
                                               action.line):
         sys.stderr.write(delimiter.join([value1,
                                          value2,
                                          name,
                                          source_file,
                                          str(line)]))
         sys.stderr.write("\r\n")
else:
   sys.stderr.write("No result for this analysis!\n")



Corresponding source file example:
https://elixir.bootlin.com/linux/v7.1-rc7/source/sound/core/seq/seq_fifo.c=
#L17-L47


// SPDX-License-Identifier: GPL-2.0-or-later
// deleted part
struct snd_seq_fifo *snd_seq_fifo_new(int poolsize)
{
	struct snd_seq_fifo *f;

	f =3D kzalloc_obj(*f);
	if (!f)
		return NULL;

	f->pool =3D snd_seq_pool_new(poolsize);
	if (f->pool =3D=3D NULL) {
		kfree(f);
		return NULL;
	}
	if (snd_seq_pool_init(f->pool) < 0) {
		snd_seq_pool_delete(&f->pool);
		kfree(f);
		return NULL;
	}
// deleted part
	return f;
}
// deleted part



Questionable test results:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> git checkout =
next-20260608 && time /usr/bin/spatch =E2=80=A6/Projekte/Coccinelle/janito=
r/list_selected_duplicate_statements_in_if_branches.cocci sound/core/seq/s=
eq_fifo.c
=E2=80=A6
Using SQLAlchemy version:
2.0.49
=E2=80=A6
Duplicate statements were not determined from 1 records.
value1|value2|"function name"|"source file"|line
f|NULL|snd_seq_fifo_new|sound/core/seq/seq_fifo.c|28

real    0m0,816s
user    0m0,658s
sys     0m0,148s

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> time /usr/bin/sp=
atch ../janitor/list_selected_duplicate_statements_in_if_branches.cocci sn=
d_seq_fifo_new-excerpt-20260608.c
=E2=80=A6
Using SQLAlchemy version:
2.0.49
=E2=80=A6
Duplicate statements were not determined from 1 records.
value1|value2|"function name"|"source file"|line
f|NULL|snd_seq_fifo_new|snd_seq_fifo_new-excerpt-20260608.c|13

real    0m0,785s
user    0m0,649s
sys     0m0,128s



Would anybody like to explain the different determined values?

How can presented expertise challenges be resolved?

Regards,
Markus
