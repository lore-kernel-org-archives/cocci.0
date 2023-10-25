Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E9CC0032E
	for <cocci@archiver.kernel.org>; Wed, 25 Oct 2023 06:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/qT3MJRxueDJG+IVx/004edmW5MK8LJOygQxd6d5nDg=;
  b=Xk25eek/wHpwLlRjE8T6he9Guuc4aw56FOmRTR2iGXZdyxkAnxy7OrZj
   +TBg5OfoImtSPKVgMV/dOb2LQpoPKZUPsVsR/PRINa/1iHIvqZwmwHjUz
   dUC5nLzrjfawi1Li0WM5VHBLV3f9ZPUP90zbiZjUFJQSO4AYylP0srOuf
   4=;
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
X-IronPort-AV: E=Sophos;i="6.03,249,1694728800"; 
   d="scan'208";a="133037428"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Oct 2023 08:45:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0C66DE0CD6; Wed, 25 Oct 2023 08:45:35 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 86988E00B7
	for <cocci@sympa.inria.fr>; Wed, 25 Oct 2023 08:45:31 +0200 (CEST)
IronPort-SDR: 6538b98a_wZkMlfSFddojHiL+CqXFyALzu9ckkliSoxDaMn0dophaaNS
 dFt6YOejvEGG0HblaX5vycwE5GtDLcBl2/f7+tw==
X-IPAS-Result: =?us-ascii?q?A0HHAgCauDhlhwMP49RagQmBT4I5fVMwBAtIhFOPPIF1h?=
 =?us-ascii?q?GuHNIdJiG+BVoFAPg8BAwENQQECBAEBAwSEfwKHGQIeBwEEMAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABAQEjFwcOECeFaA2CNysBEYEMg?=
 =?us-ascii?q?R4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCAwMjHQEBESYBDwsaAiYCAkwLBgEUA?=
 =?us-ascii?q?QGCeoIqAQMxB7IHgTKBAYIJAQEGr1QfLCJVgV8JgRouiAoBhRQ9gzt6Jw+BV?=
 =?us-ascii?q?USBPIMDPoRDg1uCaIN3l3FeIgVCcBsDBwOBAxArBwQtGwcGCRYYFSUGUQQtJ?=
 =?us-ascii?q?AkTEj4EgWeBUQqBBj8PDhGCQys2NhlLglsJFQw0TXYQKgQUF4ESBGofFR43E?=
 =?us-ascii?q?RIXDQMIdh0CESM8AwUDBDQKFQ0LIQVXA0cGSgsDAhoFAwMEgTYFDR4CEBoGD?=
 =?us-ascii?q?SkDAxlNAhAUAzsDAwYDCzEDMFdHDFkDbx82CTwPDB8CGx4NIAQOAxkrHUACA?=
 =?us-ascii?q?QttPTUJCxsGPgInniCCZshhNAeCMYFegV8MnyMGEy+DbpMvDgaSRoYNki8gq?=
 =?us-ascii?q?DE1gS46gVwzGiSDNk8DGQ+OOYQSj0g/NTsCBwEKAQEDCQGBVYNwAQGDWoIpA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23:PlJJzhfWfZAD2xJn84cOjdvalGM+QdTLVj580XLHo4xHfqnrxZn+J
 kuXvawr0AWZG9WKoKsc2qKW6/mmBTZep87Z8TgrS99lb1c9k8IYnggtUoauKHbQC7rUVRE8B
 9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUhrwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9I
 RmorgjdrMobjI9tJqos1hfEpmZDd+BKyW91P16ekAjw68aq8JJ/7yhcvu8q+tJdX6n9Y6k2V
 6FTAi48M2Ay6s3rtB3DQhWK63ABTGgYkQdGDhbc4h3iUZj/riX1tuxm2CmHJsL2Vqw7WS6j7
 6hwVhDljjoMOiMj/2HWjsxwi79boA6kqhdizYPYfJ2ZOfxjda7GY9gUWXROUdpQVyxZA4Ozc
 Y0PD/YaPe1Fq4XxvkYCoQeiCQWpAu7k1z1GiWLs3aAi0OovHw7J0wI9EdwQrnnUotX7O6UOX
 u6616TI0SzDYulK1Tvh9oTFcBYsquyMU7JqdsrRzFEiGQTfgVWKqozlIiiV3fkCvWif4epgT
 +Ovi2goqwpspTWhwd0jipPKhoII0VDI7yp3wII7Jd2iSU57Z9GkHYBeti6ELIR6WN4tTH9xt
 Ss817YJtoK1cjIQx5Q72x7QdeaHc46Q7x/jVuucPSp0iW55db+hiBi//kutx+3zWMWp31hEr
 jZJnNfSu30MyhHe5MqKRudz8Equ2DuC1QPe5+BYLU0wlKfWLYMqzL0olpcLr0jPAzH6lF/og
 KOIdEgo4PWk5uT9brjovpORM4B5hhvwP6gzgMCyAuA1PhIKUmWb/+m3yaft8lfjQLpQi/07i
 qnZv47eJcQcvqO5BghV0ps/6xqlATapzs8XkWMaI11bYB6Hjo7pNE/SIP3gE/uznkqgnC11y
 /zYPLDtGIjBI3jZnLrvZbp97lRTyAs3zdBR/ZJUDbQBLer0VEDrrtzYDQI5Mxeuz+joDNV92
 JkeWWOJAq+WK67Tv0GH6fk1L+aReoAZoDD9JOM96P70kXA5gUMdfbWu3ZYPdny0Bu5mLFmBY
 XrwntcBFn8Hvg4kQ+3kklKCVTpTam2zXqI94zE0E5imAp3ZSoCshryBxia7EYdMamBIEFCAC
 W3oeJmcW/cQdCKSJddsnSADVbe9V4Ah1AqjtBT6yrpiNurb4DcUtZPl1Nhv5u3cjws+9TJuD
 5fV72bYbXxwn2pAYzYp1aR76Rh/11OC2O58iuNREdh75vVTUw58O4SKi6RxDNv5WyrAeM2IQ
 RCoWIaIGzY0G/c42dwTeA5QH9u4jxbMl36PCqUWiqfNKZg66KPa0FDuKsw7x3uQh/pptEUvX
 sYabT7uvaV47QWGQteRyy1x9o6vfKUYh2vW8XubiHGJpAdeWRJxVqPMWTYeYFHXpJL3/BCKV
 KegXJIgNAYJ0sueMu1ScNS8qFxcR+r4fvnabXiwnWiYGhuCgL+BP8LxY2tI5CzGEwAflhwLu
 3OPNAwwHCCk9kfXFj9zDhTCZ0328O9xgGy2RAk4wlLCdFVvgpyy/BNdnvmAU7UT07YD7T8ms
 ClxFU2h0sj+Dt2du0x+ca8abd5VDE5v82XfukQ9O5WhK/snnVsCa0FsuFuo0RxrC4JGmMxsr
 XUwzQM0J7jKmFVGPyiV25z9INi1YiH74QyvZqjK21rfzMfe+6EB7+49okniuwfhH1Qr8nFu2
 d1Ym3WG4ZCCAA0XWJP3GkE5knoy75TTeCog/MX50XN2MK+7miDP0ZQlCaptyxqtecteLLLRD
 BX7QIURA8mjLvBvmkD8NEteeroIq+htYoX9JJ7kkOaxMe1tnSyrlzFC6YF5iQeX8jZkD/XPx
 9ADyu2Z2Q2OU3H9ik2gu4b5g9MhB3laE2yhxCzjHIMUaLd1eNNBLG60INCsgPh6iYTsXXFw6
 1OpQV8LkpzMG1Lafxnm0Atc2F5C61mugyil1HpZlz8zr6yQ9DPDyaLueVBUXwwDDHknhlDqL
 4+uitkcV0X9dAklmiyu4kPizrRarqByR4XKaX9BZDO+b2RrU6/r86GHf9YK85Qw9yNeTOW7Z
 1meDL/7uRoTlS35TSNSwzUydjfivZuc/VQyrWuHL2to6lfdd9txwxj3+9HWA/JcljYLXyh3j
 zDLC0P0ZYDzu4/OyNGa76blH2u6HoVeayzq0Z+NuE7ZrSVxDBuzkury0tzrHA4m0DPqgtxjV
 CHGthH5McHg06W3N/4if1E9XgamrZAgRccnz81r1/RykTAAi56Y/GQKizL2ONRfguflaWYVA
 CUM25jT6RTk30tqKjSIwZj4XzOT2JgEBZHyb2UI1yY6980PBr2T6ekOuCJvoUej6y/Vb+J8m
 Dg11vYkrnIXybJs2kJl3mCGD7YeEFMNdwnljReV9JaTqKtNZWCgWae93gxykJryadPK6hEZU
 3H/dJA4GCZ25cgqK1PA3kr47YT8ccXRZ9Ye5VWE1g3NhO9PJNcth+IH0GB5bHnlsyRvmItZx
 VR+mIu3t4+dJyBx8bKlV1RGYybtaZpb+ymx3/wHxIDMhd/pR88/XGxRDNyyEJfKWHoTrai1b
 V/UVmdm9THCRPyHWlXCoEZ+8yCVSsrtbSvIYiBGi40lHkbVJVQD0lpNA3NlxNhgR1rsnpCxN
 x0og1JZrl/g9kkckKQxaUS5CzqO4l/vMGl8SYDDfkAPsUcdvQGPaZPYtqUpQGlZ5sHz9lXSb
 DPBIV0ZVydXBgveWTWBdvGv/YWSo7LeX7TjaaGUMPPX8rQWVu/Ul8L1lNI4onDWbZ3JZCMqG
 fQ/3gArsWlRPcPfln1PTiUWk3mIdMuHvFKn/TUxqMmj8fPtUQap5I2VCrIUP889sxaxybyOM
 eKdnkMbYX5Ry48MyHnUybMewE9aiidgcCOoGKgBsiiFRbzZm6teBRoWIy1pM84A46U51whLc
 cnV77G9nqZ/leIwAkxZWEbJn8a0eYoVLmv7OF6GTEeHObKaJCHalsH6ZaTvLN8YxO5QthC2p
 XOaCxq5Z27FzWO2EUnyd7of6UPTdAZTs4y8bBt3XG3qTda9Lwa+LMcyljouh7s9mnLNM2cYd
 zl6aUJE6LOKvkY6yr1yHXJM6n19IKyKgSGcuqP9I4wVrOAtLyB6jeNc71wlxrET4CwOF5kX0
 GPC68VjpV2riLzF0j18TB9HsSpGnqqOulh+f7rU/N9MVDyXmXBFpXXVABMMqdx/D9TpsK0F0
 dnDmpX4LzJa+s7V988RbyA7AN2KOjwtPEiwcNYxJBQIR3inODOH76S8uPSV62HTsZUw7JThy
 sJmdw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ma8rHa/+lUcBJ/ks3zFuk+AMI+orL9Y04lQ7vn2ZhyYlF/Bw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3AY6Aq7mpW+YcTtAwuNyaQWRHmUZgBSHPXk3PiGHa?=
 =?us-ascii?q?bEThHTPq2RVOh/7wxxg=3D=3D?=
X-Talos-MUID: 9a23:KhG84AU5hJfTXkvq/CbnpRU+Bvk42pWrUkYPgKwBsPCObhUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,249,1694728800"; 
   d="scan'208";a="69679676"
X-MGA-submission: =?us-ascii?q?MDE05pVeyhCQOCP/7KyKoElzmvO8dK+3+UrNTr?=
 =?us-ascii?q?XJNHpkEVxVt0u4Q2AaBWnwrQ4+6yrAAHYyRYinGG//0VoOCTM5etuU8c?=
 =?us-ascii?q?KYIXYNq/LJkOS/ZJ1M4fenzWDT9YTG06mXNUvlk7zW2CheLWimXoLD7U?=
 =?us-ascii?q?F5RQcWDEOy188p+HhOQXVOOQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 08:45:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1698216329; x=1698821129; i=markus.elfring@web.de;
	bh=kvJOI9HLsNFsXPH87eCmG1Es3A3aKfzaQ6H0vznDL80=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=M7NIcy+xVCFqaCec0aaie0w0PKh+5X4TWqEvW+F+dcbeU+HH565BxSR/vWEt08LX
	 kSRkUHhNQ3A/BUpdcNFWsHwwwidqVu6ZxO6ut9lpKr9C8rlWRm6tRAeG5eVq9Hli/
	 8v/arI1SHTfFREjk/YRHNyBFJ9NtiN1XnQVJazWh1WLPumeaLEteMwRORgOLsQXtT
	 DQsP/z/v+B3FrVt8FgYh7631C8W2BJycLktS7duDBjyjeNyUUu5ZE4CiGOuxuMARO
	 xYF2Ym/6TSCQYUXNO+VXCrLN5Mq1TEUWbJbs5fY4y2JRmSmGRtcpfvMLoav6BAd/B
	 4ZGX/eX+SsTbI4E//A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJnvp-1rBH703W7l-00Jr74; Wed, 25
 Oct 2023 08:45:27 +0200
Message-ID: <88a807cf-b1dc-44d1-8f8b-26dde2aa759d@web.de>
Date: Wed, 25 Oct 2023 08:45:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: =?UTF-8?Q?Martin_Schr=C3=B6der?= <info@swedishembedded.com>
References: <CAEqMKof5Ke4yV0KBZm2FW8z-Ct1UHZRDz5=Sd3gaO3a-f4+y_w@mail.gmail.com>
 <6213b47a-3ae7-d316-b1a4-8fb5d3bf9b5@inria.fr>
 <608e77e0-a36d-44ef-a2fd-9c0c50cf61b3@web.de>
 <CAEqMKoco-UjiPu4bwm69t1HexJi0y+cCPEH6NZ10xZCfn36=5w@mail.gmail.com>
 <alpine.DEB.2.22.394.2310240750150.3911@hadrien>
 <9e9bd6fe-10bc-4754-bde9-d3ba2743fb02@web.de>
 <alpine.DEB.2.22.394.2310250831040.3084@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2310250831040.3084@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cCySThF13Z6E9TBcVPUG+9CoozQRwJYQeS/34DCiSMr/ZGDOjq1
 zpjR8/XEF2PUybVqdHe4BAdZPzWLEkyGRxWdWGg3/xxcjLQLyhUmMFFd5xZakpEjwA1aZwp
 9qAqpN+wDXXKgx9nTfJng72t161vTtHcmceyltUYIJrAAeppRx8QlkPqi1+Y91BzZi1G1OS
 XdKL1qzEP+hhYRYrBud2g==
UI-OutboundReport: notjunk:1;M01:P0:eicRBVoGOqQ=;/Wh9w0MjmmHsJ2R6zop/h5LW1wW
 NlDlaTs5z0z2iDi7JuIw7cJ52Ut/2K0wZBKvZg0+I0q53hTiU/5F3ZBquj877IISsULQygSf0
 4cLh4djIPeaf0gZ7dffHcCdpIHTVQGLgOTk+q+7/z0jTiKFOObpsOOY21vZhW/sfSPJuPgJw9
 1XEjpSgKns5OdPBbqkNal9Fx9mPKFcHp+bcxCw2DW307znbZZ070LxVQ4i8urJRpsy3MD41Py
 y7PKjGx4kWemhu9Vqw1A3fsnCrfqtZWTvgd6zg64nCjicDnxIzo2hnsmDzxtOptnd1ZA5/fwV
 S/LbmYINsuUVNO2fMavCdzn5jDudTLK6wMQUUqu3GrY880VvdTPbBTVs7jQ8SXNTTd6TdxdFb
 TAIRE3UexH4TqXRJwjHtknyYBFZZSBNybkQDbZ7xFnLUbfag/5C5NntGMzBWmupFCJ/1sGGu0
 gqSFQ3jmdTRsFx41U6HJBbrV9i1MWHtqEljDytJhRGiZ42uAuDWhd87PlkkTfBplwXK/wL1PK
 RUmKy7FBjldhE/TRDPs2oLK/ifcRmUIdkQJN8SY+OeMF8VJ8dGhIMOEc5bWw9a04938Fzk/Yc
 35hnzVxjSKdtv3bKgpCHaKNLIhRmKxShnsxqWnFV5dJ8H9Te1lq3fPevxULVia7N4qmZv30O8
 HCTgojCPwhg9e3MPLZdfyNWt9Uvkjm+vX/O6+UD/MvyJpc57YcZcS4nsCg88dNMP2qn+YoDtp
 0Mxfon2aesz7p+t/B2k07cZ6HO/1V9QzbLNhFJ2QvyOsSgLLZllZmk1wN5PzMw8aQyGbXaRj9
 Em
Subject: Re: [cocci] Dependencies between key words =?UTF-8?Q?=E2=80=9Cgot?=
 =?UTF-8?Q?o=E2=80=9D?= and =?UTF-8?Q?=E2=80=9Creturn=E2=80=9D=3F?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1276
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/88a807cf-b1dc-44d1-8f8b-26dde2aa759d%40web.de>

>>>> if(r){ ... }
=E2=80=A6
>>> This will cover the case where there is a goto that leads to the retur=
n.
>>
>> Would you like to explain this information a bit more?
>
> The ... follows the control-flow patch over the goto until it reaches a =
return.

* Would you like to refer to =E2=80=9Ccode paths=E2=80=9D here?

* Goto statements can occasionally jump to source code places
  that would be connected to other items than a return statement.

Regards,
Markus
