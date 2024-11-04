Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D3BD1BDDA
	for <cocci@archiver.kernel.org>; Mon,  4 Nov 2024 18:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=p3ZDtZhX/jPG6PcOSN0NRnwE3a3XAK7It1WoVf/CSQk=;
  b=Gy9BYKhqUu9oIwbi81pEj0U+fap9GmLATLzeBbMoyzZgBjNVFue3Qb9I
   tNEaZe/Hi4cPslG5jL3spkZ9R/I/gUc7/11CjRV/Mzb9XIG3sbStdT2P9
   I+rKqglVhj/L5hLhL6tqivYBXyid+3KQlipZeyJL9nZCRjqJ/sH91R4l/
   k=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
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
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.11,257,1725314400"; 
   d="scan'208";a="192110938"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Nov 2024 19:35:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 12340E0D1C; Mon,  4 Nov 2024 19:35:22 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 67513E00B7
	for <cocci@sympa.inria.fr>; Mon,  4 Nov 2024 19:35:14 +0100 (CET)
IronPort-SDR: 672913e2_fY4PlfSe+j6pbYVse6qBkghZUt8KNwPHW7uzmCf7et5CB2j
 r1G71a8d/8GLp07U7rV0CEr+SmnsjtG9WbNreDg==
X-IPAS-Result: =?us-ascii?q?A0FRAACREiln/wwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDB1sbBlQzBAtIhFaPTYF0MIQ7jw+IdYFWgUA+DwEDAQ05CAECB?=
 =?us-ascii?q?AEBAwSEdgoCijQCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQKBCggLhTVGDYJiAYEkZQk4AQEBAQEBAQEBAQEBAQEBAQEBARYCPQpEA?=
 =?us-ascii?q?QEBAgEjHQEBEScECwsaAiYCAlYGARQBAYJ9AYIvAQMOIwcNr0OBMoEBggwBA?=
 =?us-ascii?q?QbaWx8sIleBYwMGgRouAYVpgmIBhiSEPCcPgVVEgTwLgkcxPoJhAgIBhTiCa?=
 =?us-ascii?q?YI2FYUfiFJol01SexwDWTIBVRMXCwcFgSkkLAOBelh/gTmBUQFCgl1Kgz2BX?=
 =?us-ascii?q?gU3SYJKaU06Ag0CNoIkJFmCUIElBAWDb4ELg2WEbFQdQAIBC209NQkLGwY9n?=
 =?us-ascii?q?klHgyOBQS+CAqRSoTY0B4I4gWWBYwyKJ5UuBhMvg3GTTg4GkniYdyKNXJsjg?=
 =?us-ascii?q?W4HL0aBEzMaJIM2UgsOD44hDBaEC4RhvmlCNTsCBwsBAQMJhUYBAYwZgUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:QQCBRqAeYxpWBxVW/z7iw5YqxClBgxIJ4kV8jS/XYbTApDt23jxSy
 TdOWj/Xb/aPMDSgfNh3bY+x8koOupSGn9NhOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6j8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuGYTdJ5xYuajhIsvvb9Es21BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc50uZMCCrmPdWNgJsOow/9sd+Gm9xr
 sVNfVjhbjjb7w636Le8V/UqmckpasXmVG8dkis5l3eDV6lgGM+FGv+iCdxwhF/cguhrFOzde
 tFfRD5hdhXGbDVQN11RBJ9WcOKA3yilKmQA+QjJzUYxy1bCkVJU3pjUCuPyZ4WEQt97oVuet
 m2TqgwVBTlfbrRz0wGt+XWnje7nhjL+QItUFbui9/csjkf7+4AIIBgRSEf9vvSzzEKzMz5CF
 3EpFuMVhfBa3CSWohPVBnVUDVbd1vLAc7K80tHW6T1hDoLR5BuFQHcJRHhNZbTKcSPwqSMCj
 je0cxHBXFSDc4F5jVqC+73SoT7a1e09MzoZfSFdJecay4CLnWzw5y4jiv58HaTzgtCd9fQcB
 dyVhHBWuoj/RvLnG0l2EZ4rTt5sSlX0otYJ2zjq
IronPort-HdrOrdr: A9a23:B2sKja2SJGElurQkiS9YzwqjBC4kLtp133Aq2lEZdPU0SKGlvu
 izgfIQzg/slV8qKRUdcKO7WJVoIEmskqKdhLN6AV7MZmbbUQeTXeNfBOjZrQEIeReTygc178
 4JGJSWY+eAaGSS4/yKgzVQX+xA/PC3tJuznO/bwjNERxxrbaYI1XYANi+rVnZtXQFDCN4ACJ
 aB6o5mqlObCBIqR/X+PWMdV+zP4+fGj43renc9dmQawTjLtyqh7LO/OBCCty1uKA9n8PMZ6G
 DAnkjD6r++tuzT8G6k61Pu
X-Talos-CUID: 9a23:9Tn5h2CTtavKup/6Ey84txVTQcIdSD6Hy3b3L26xEmhWE4TAHA==
X-Talos-MUID: 9a23:nueHGgiSvqQtZgUSNVFhasMpCtY1vYGgKHk3qLIb4seDLwJPJjGNg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,257,1725314400"; 
   d="scan'208";a="192110924"
X-MGA-submission: =?us-ascii?q?MDEbFKswdj0AJjRaZh7Y9L2F/gHwOYBJ/QKqSu?=
 =?us-ascii?q?quDwZoqlf9XHRP1/+EFCQLQO2oiA+djbuP/qsfP5vCN4e7fthirwyokC?=
 =?us-ascii?q?7NGhv+RuLJ/mHmf41fKtgta7+AYsl8xOWxHUhW4P/HzNHDQufGNBmm6b?=
 =?us-ascii?q?UiXXKqB0S0WAWwElmJOwrJaA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 19:35:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730745303; x=1731350103; i=markus.elfring@web.de;
	bh=p3ZDtZhX/jPG6PcOSN0NRnwE3a3XAK7It1WoVf/CSQk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QANMJBdpSAE5+CMJTANQ3dAyHW77YsMj5lLC6lsuBBFG+J6USZILZO8sA4USmHw1
	 8ThQrTAwVH+hyCLPcCY7PWnwMUaa4Mbr1uFDno19RpRyeIQZvpkFw/AuTC2UsorGn
	 QZgfF8SlrTbdI/V3ulUuIHTYwHwVOIVaKZML+QusNi8+3PesFSnRI1UdQXDj4D3c/
	 L9YXR5cFOoMU1ThGTBcSugYuFYCunDAizRFxRUfsk7WQ3QJJGtNqd97kcuqBtf3u+
	 ban4EYryuNO8jMlUMC/7wDFlL5znBh75dSuuuTTwoNyUTW8200anDinpe8cWbVNxp
	 lY0TsNX6K5/6C9vTfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJWoU-1tNVR10Yum-00YQGH; Mon, 04
 Nov 2024 19:35:03 +0100
Message-ID: <c8dc3a5a-0365-4725-bd68-0fd29a184384@web.de>
Date: Mon, 4 Nov 2024 19:34:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Derek M. Jones" <derek@knosof.co.uk>, cocci@inria.fr
References: <9aea38d0-4738-475a-b354-f26b44766544@web.de>
 <05354787-2a60-4c3d-8818-0d23c8e2e015@knosof.co.uk>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <05354787-2a60-4c3d-8818-0d23c8e2e015@knosof.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:s6+wAM/3UKHixie3GHZJ6Ux1pyIzMzEu9WqSr4NDctp8ZSfrylz
 5XjqXqU1nOBbxLie0+zvQtjppPHe5Cvfe0InxZOaIrEpu0dfXLrMwd1po/ruCHtq5P1pHzx
 HFLBj8nIZc0yk1WiEteAuN+gO6gRE/DNL5UAH0WGObdkvVEcoys9Wq/ZnkX2uBI59U/TKph
 Ej9WWQrIAORS7CZCXzvWA==
UI-OutboundReport: notjunk:1;M01:P0:tq6AMWuUegM=;E7Xorp9tglq3p98ITGS3SN2c64x
 pX2qLwcqysP397N0Qwc0LpyilOUHtpOMU5gZ1S0evZ1uY8yQbmXUr+gBkHX7IAzQAE2UJOTyY
 OPu0flage7UDfw0yl7vesvL9omxq4qvcw30XBMvpMMMsiZLgFwKZjCSdqqURX6O59OqoeEwMj
 vwk/MtnRKL/NUeL189YRkf367LNoB9NXwQ6xuqo07+b71Yd3STnA6OGSFCJPUs9l89ziYGsQr
 hRwShRq20lPluzXx7ogszbUK1LWCN/3/SsiEY8pCVvtY97ve7YWgXWfeXbXq6AtfNKr18ImDo
 RcmpswpG8tvVpN2JZ6GcVbvneC06tAFhUvTB6zp6vDzjC4zuv/XybNWvM8XO/OhKpgNAqnwEV
 8gHZ6Bp1t5pR6X4gsHiZXYFvjtm/7IYfZSdjhrwOGpQZt+8LQbY5k8HqEeNy8qTzOWaxZdyc/
 ZgXYY4lxckzie07GCOO44x03NNMr2yH1wOiRo2pHe+UulEexc8jaAhbl6Lhqi8bEo/QpOO88T
 v3DMp3Chsd1DMX9DBcYp+eUIVaYcfzTgGYaTle26EgVFroVV2cXZHugjobFZwDSq+s8DnFgtl
 UAZ3/cfIBd8TFZUpPjKQzn8WQGGG4/hrEXoN+BZXDUHO8FWk0hyO5pmT0LxoyrCPY95HQFV8u
 nzwb6dIk69cUg0dMlwLGSW5Kx32HeN5zK8H7+MqzB0JEvzNyuzYhOoIBvyfyX1swQ8JkqcXEC
 m7ACttj2LnxRWWhbqwXMeD7z195Ea+68bHBgGXdTmIPrtfXRElcQVikzEriTWzMsbDaYYnnfN
 I2Mjtrg+qFW+LEfJN50auyXg==
Subject: Re: [cocci] Importing source code into graph databases?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1965
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/c8dc3a5a-0365-4725-bd68-0fd29a184384%40web.de>

> Using a graph database implies that a particular kind of
> query is so common that this representation saves time.

Source code is usually converted into selected graphs because of parsing,
isn't it?
https://en.wikipedia.org/wiki/Parsing

Such information can be stored also in databases
(instead of generating some data structures in a non-persistent format).


> What kind of queries did you envisage running, that would
> make using a graph database worthwhile?
Our known use case:
Computation tree logic variations
https://en.wikipedia.org/wiki/Computation_tree_logic#Extensions

Semantic patch language

Regards,
Markus
