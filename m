Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323EDC433EF
	for <cocci@archiver.kernel.org>; Sun,  3 Apr 2022 17:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=SrQAvd06TRKHpH5lFbWEiwE297HF5ruOZfqhkL08r3A=;
  b=MZ6oUTTfXy/M+73iqy0stG2MR3DNFxpBbA1qfJdH9JzWKobRYHDFue9k
   MwfNu21lAHaJCVdK/pvpE5xEtKWKen3b10h3prXcY8TjkAwqSL2Hz8D4t
   u0K5siP75D4xw27nMxoramTZREdD3P0pu3XbTStKEScgHDsGZvqI5oVZR
   k=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="29757696"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Apr 2022 19:36:38 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0D11BE033B; Sun,  3 Apr 2022 19:36:38 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 776F2E00A8
	for <cocci@sympa.inria.fr>; Sun,  3 Apr 2022 19:36:34 +0200 (CEST)
IronPort-SDR: Ov7xKnevrwv+hFIu0BosDFNeq5/tRbubuPMaF4GshSNo2fyozs4Wrg02gbLdVnZzShcqU/UV42
 e67+lS0R1Ep2EFMcwW3DyLy5pp1Yzgn2hO5K0oVD18SX9tR/fnpkyT1Tuxrzn8hMIB2X8armWK
 CwFgsqSGnQ900y0Tw2P0qrU+38IJMepheSES+xbkInAGKoD174eXmiFh0kwYV6wLF7hVvPyUfK
 CeVjE9fcc9K4YIUCCJ1aQS0LIusBrft0wOdPsCOYdEsvUfh3zdlT5orIJz2DbKgKl9BkytlwkZ
 IEj5BzDOhEYjrAqP9sjEZWF3
X-IPAS-Result: =?us-ascii?q?A0AEAgDj2UlihwMP49RaHQEBAQEJARIBBQUBQIFaAoImf?=
 =?us-ascii?q?lcrBAtEhFSRG5JAjCMLAQMBDTkHAQIEAQGCEoJ1AoRaAh0HAQQ1BQ0BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBDA0JBQgKBw4QBTYGXgZkB?=
 =?us-ascii?q?IFLBIF0CzQNgjUpAYNkAQICASMdAQERJgEPCxoCJgICVwYNCAEBgwABgmQBA?=
 =?us-ascii?q?w0lC65rgTGBAYIIAQEGgT8BgwgfLCJSgVwDBoEQLAGOTScQgVVEgRUnDIJHM?=
 =?us-ascii?q?D6ERYMagmWaTT+BAMICNAeCEoE6gUIMiUeUUwYULoNikmMOBpF2ll6NGJl0g?=
 =?us-ascii?q?XmBfTMaJIM4TgECAQINAQICAwECAQIJAQECjh0ZHoNugQuJIj80Cy0CBgEKA?=
 =?us-ascii?q?QEDCYVHAQGKPQEB?=
IronPort-PHdr: A9a23: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
 Kc=
IronPort-Data: A9a23:/G/Mfq2LQ6i0rg22E/bD5aV3kn2cJEfYwER7XKvMYLTBsI5bpzYGm
 2VODWnXaPaMZDCmKtkja4u180MBu5KAmN42HlE43Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOH9IQMcacUsxLbVYMpBwJ1FQyw4bVvqYy2YLjW1/V4
 ouryyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt9pO4
 dhtjoSQclswOaLSh+otX0RgIS4raMWq+JefSZS+mcmU0lGAbHbmhfljZK00FddBoKAtWz4Ir
 KFec1jhbTjb7w6y6JeyUOpxnYIOKMfxPYUQkm5tx3fVAJ7KRLiaG/mTu4QGgl/cgOgJTNL4Q
 8ArNgZSbTHLPUcRCE4bCMgXybLAan7XKmAE9gvM+8Lb+VP7xwt627nFK8vQYtXMRMNPn0/eq
 Hiu13j8CwsGNdqS4SiE93i2j6nOmzn6UcQcDtWFGuVChVqO2ioMBRdQWVbTTeSFZlCWUe12J
 mwv4goV8bE1+1K0QOnxAiWKryvR1vIDYOZ4H+o/4QCL76Pb5QeFG2QJJgJ8hMwaWNweGGVwh
 w7S9z/9LW0z4eTNIZ6I3u3M9VuP1T4pwXgqSQJscOfoy9zkvZ11kR/FCNpueEJUsjEXMWGvq
 9xphHFg71n2sSLt//vilbwgq2z1zqUltiZvum3qspuNt2uVnrKNaY2y8kT85v1dNoufRVTpl
 CFax5jPtrxUVcnWyH3lrAAx8FeBuKbt3Nr03g8HInXd32/wk5JeVd0MsW8lfi+FzO5eJWW1O
 ic/Rj+9FLcKYSf0NPYpC25AI51klODhE8joTPbZcpJHbfBMmPyvrElTibqr9zm1yiAEyPlhU
 b/CKJrEJStEVcxPkWTnL89AgOdD7n1vngv7GMGrpzz5i+b2TCDOE98tbgDRBt3VGYvf/W05B
 f4Ea5DVo/ieOcWiChTqHXk7dgtVfSBiVcmp86S6tIere2JbJY3oMNeJqZtJRmCvt/09ej7g8
 i7vV0lG5kD4gHGbewyGZmo9OqziV9BzoCtjbyArOF+p3VklYJqutftOKcFoION/rOEzn+RpS
 /QletmbBqodQDrw+wMbMcv3ortkeUn5ngmJJSekPGMycsc4FQzE89PpZCX18ywKAnblvMcyu
 ePyyQ7RB5YOHlwwAMHTYfOp7lWwoXlExLMsBRSVeIELdRy1ooZwKiH3gvsmGO02KE3OlmmAy
 gKbIRYEvu2T8YU7x9n+g/zWpYmeFeYjTFFRGHPW7OrtOCTXojijzItHXLradDzRTjqtqqCle
 PkT0Pz2dvEKxQ4Yv415Grdt7KQ/+9q2++4ElFs5Ri2TYgT5EK5kL1mHwdJL6P9HyIhZjg3qC
 EiBzd9XZOeSM8T/HV9NfwcoMraZ2fcPlmWA5Pg5Ohyjtipw4abBTkhYeRWB0XQPILxwOYIj4
 OEgpM9Pt13h0EV3aI7eg3AG7XmII1wBT74j6MMQDrjrvQx3mFtMVprRV33t65aVZtQQaUQnL
 1d4XkYZa2iwG6YDT5YyKZQJ9e9amIhIpx1AilMPT7hMdhwpmddvtCC9MxxuJuiW8vmD+/1+M
 C5nOiWZ4I2QqixwipErs3+EQml86d7wxqA140QEnivVQiFEk4ALwHIVYY6wwazSz46QkvW3M
 l1VJKYJnAsGpP3M4xY=
IronPort-HdrOrdr: A9a23:VehhqKoOIsQH58FX42fPCqYaV5oPeYIsimQD101hICG9vPbo8/
 xG785rtiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadD/DDKysGVbfy19QYXceiGUdAb0+9BYDzrb3Gfz2R9b6YEKA
 ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="10416366"
X-MGA-submission: =?us-ascii?q?MDHnBWY/Y9OlNC2FYPCl7A6UaGGLhUYLwqCB1y?=
 =?us-ascii?q?LSAUPqT9uXboCJE1NvO1lEwIwlT9OybBcpn4PtmRXFI0ckKd3eagigCt?=
 =?us-ascii?q?FGdfWvToLmqrTprKDYuNXTi8Dj9T/vZsV8LZCSYO07qtrLWgVqbb2hu1?=
 =?us-ascii?q?R5/Dzdcu/kmjWO0VqYKrCKpw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 19:36:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1649007392;
	bh=SrQAvd06TRKHpH5lFbWEiwE297HF5ruOZfqhkL08r3A=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=XBFv2u4vEgwPBRGJlhLbqiY7dQBvAfdiN/R0MhNfMnoMT4aZDn1RqQxTB5LrBcww4
	 6SyJ9L43LgUHH9X3vXjGn4ZY9K06WGirR5zGD4PKSIQJr4ZeiJ3pk0IZSE6Uv++knZ
	 9+SUOF4tzzn0cCrTGX7M2iTKlx1FUaXXPBWyPIjg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.114.24]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M5j5y-1ndmuo0aR0-007a01; Sun, 03
 Apr 2022 19:36:32 +0200
Message-ID: <9ee629ff-76b8-5027-7732-78df5805f17f@web.de>
Date: Sun, 3 Apr 2022 19:36:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
References: <4f40e17b-67ed-97f0-10ca-41285d7c3d1a@ewheeler.net>
 <alpine.DEB.2.22.394.2204022320520.3208@hadrien>
 <9a8c392a-413b-afc0-16c5-a013e403372b@web.de>
 <4715acb0-7b7a-9671-bd15-e5dfd36af74e@univ-grenoble-alpes.fr>
Cc: cocci@inria.fr, Eric Wheeler <cocci@lists.ewheeler.net>,
 Thierry Martinez <Thierry.Martinez@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4715acb0-7b7a-9671-bd15-e5dfd36af74e@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W14xlz2hU9Oe/oLYUwTi2OujjAD0HlXj3bVOW/wUuZrO239hAEw
 t8M5nLz94M4QJezH1XewlVEBTGQHhhIlh+46Yy+QmXOmXdYxOCpEQ38zpRDnsjtZxJBVpEg
 YnpYWLsNTXIVVhlLwrLBg7Qz42bSig9hvJruqRIH1EwFJUxdsuTeF33CYBVpQpSPWeAzHMl
 JS4uTgJH/p5XcY5Dgpg3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1gjXTFhRz+E=:LoSkFFAH0t15gOM1c6Hcj1
 fxpeaTsBiDBaevrvoffNLUTzHRzT0MQUzHM3uR88TnK7L+1Gzrg/h0tQiNIAUKnloxI0C8AeF
 PvzfI5XUBW+iiZkmigE/HrOvf8gIo4SJ3ao3W9GtdIAkH7ff63tm/QQgJRJQ5VHQpRLoLHu6n
 397bk71+9ED33wVEMKj3lW+7RLnRGBaJbYi4i33Xt6McDcoPoePaqfsGEVwQAV3mqHft+1GcF
 phE/00bxcLMm4GOmDyV8OhRn1JlWHZasfpzyjWkjdMWOaIkMNfkimwaf7mXpIY0a1GEHBysDq
 LsvaeYDnOqPwsJo9hY5UCRSGqrQCsWIfI03T5UX5GWTVHxWCBCR3t5LGiXyW00PnfLTjwO/1z
 g6JRo0puHiEeEs+/dkBWzZkk/TvG0Ge/elebum+M2n6mV1ZTF6aiBU+r70vHk769dMzCRzREh
 Takr8HZGzLoR3jaOo0pLKxbYqqjt+aViVgkhi2Io4SBQR2i0h6RBwbEpfjgjEkIqaNo3AAkCi
 RLPwIkEzde1Dp+vUP77bLquiq3tZ58bwd19rIBX42PgA7Q1nueMnmiF8hr5j1v5nH4ylKP0El
 iDlaDrpEEYUWfKt2GdqLDnJeVWEZQVReMjePm/t94fHQojMw7XZQpwokbubbfz4rvuAOPR4Ub
 q3B3t+CK76P8TjwDw85i72MAITja31hT3zWCHmET5R1IVH0YKykBu5mAVOd0M6WWQMLjldBMW
 0OBpL38wnNrKT5rUyR4PnHGsUS4lBsLPkPHiVS4Zvtl6pO618ulfjEcCz94vD9k4GVdcYqgQ0
 73qjLi1CZEmYaVK/7jiCWDQFnY3JkWg1ECHbDyHgYDD2ytzKJyv281VPh9KCIk5hobc5rDekI
 Ybcxh5Ce/0yku48bVA273LJWcAJNxAN73IGg/EYJO//31jaYfJdMN8NXNhMbCXLUn3cuUURe2
 09nXhGQCHQv+HP13Ph/mnDyVplJtZnVsa/HPgVnP0j9VYHnXqxAm9cKtDnzbJJQ++nmthKuRY
 1iNG8PxBf8lKdoomefZeQYzk/eAkM6dJjLJwT0O+0JkFMlvaY232d1TuJUrO7WwZkf6aTRtKl
 51u2+7u9sisPhE=
Subject: Re: [cocci] Evolution according to SmPL scripting interfaces and
 regular expressions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 352
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/9ee629ff-76b8-5027-7732-78df5805f17f%40web.de>


>> Should the method =E2=80=9Ccocci.make_expr()=E2=80=9D be explained also=
?
>
> An example:
>
> https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/d0666cf3f6faa4516=
bd42bac1f319d6bc894e32d


Thanks for your contribution =E2=80=9CScripting: Add example of make_expr=
=E2=80=9D.


I noticed also your contribution =E2=80=9CRegexp: Better error report with=
 PCRE=E2=80=9D
because of this reference.

Will your development branch =E2=80=9Cnpalix-regexp=E2=80=9D trigger any m=
ore software evolution
also according to improved handling of regular expressions?

Regards,
Markus

