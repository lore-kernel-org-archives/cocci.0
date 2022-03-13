Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D883EC433EF
	for <cocci@archiver.kernel.org>; Sun, 13 Mar 2022 17:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6P4d/aKGs8eTZASrj7gnqd0vnExOkaeiG/R6W9x81tI=;
  b=EmBQf4SIywyGAjdyCRRUmX0OgTYzcK2C5HasSym0kpSt/ivg/Z8t0DBR
   wCm5py5g5Vr9Qs933FaqkwcSS3D2oRl+FTd9kx2BWCcVVPJTRWXUdUWfC
   si9QZLS2+/jLViPzTvY7TVR0XI8gfWyg9fPSGsHwcKigqGAvI/cdx0lkP
   M=;
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
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="25870270"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2022 18:24:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 275B7E006C; Sun, 13 Mar 2022 18:24:54 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E1A6FE0045
	for <cocci@sympa.inria.fr>; Sun, 13 Mar 2022 18:24:49 +0100 (CET)
IronPort-SDR: QDP/z5KKTrvOdds4SzrBYYLhlxtnWNsPioXXO47uxt/vMCs4loPCitkTZ/c9YOCG69NZ/goZab
 hPNXdIeXdZzSwtmwrx6J9vIwb1RAEweNmRQdMyOujoj5A8L3VaW3td6zHwXI4wDvomleo4hQdD
 6mKeER6Slo3D1fUWW7QCsZFkpF1PalLTfSFV9Eg4HaZc3ksWZ/gS1gjijF8zhG6Z+cNysROjRK
 SEtE5iEtiYJZC9Abo/Tdrxe1c4kgIV3dd1e4LetyfbRSZ+RSevFmiFWqVaK7XLQX4LdWuHQ+G7
 CMlLXXqueHjzEzFVVHyR4+/V
X-IPAS-Result: =?us-ascii?q?A0BOAwAyKC5ihw4P49RaHgEBCxIMQIFcgiaBVSsEC0SEV?=
 =?us-ascii?q?JBqi1SHFowiCwEDAQ0+AQIEAQGFBwKEJAIdBwEENQUNAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQMBAQUBAQECAQECAwQBEwEBAQwNCQUICgcOEAU2Bl4GZASBSwSBdAs0D?=
 =?us-ascii?q?YI1IoNsAwMjHQEBESYBDwsODAImAgJXBg0IAQGDAIJlAQMyrjCBMYEBgggBA?=
 =?us-ascii?q?QaESB8sIlKBWwmBEC2ORycQgVVEgTyCUzA+hEWDGoJluzmfdDQHghKBOoFAC?=
 =?us-ascii?q?54LBhQug2GSWQ4GkWmWV6Z7gXmBfTMaJIM4TgECAQINAQICAwECAQIJAQECj?=
 =?us-ascii?q?h0ZhAyKLEA0OAIGAQoBAQMJhUcBAY0cAQE?=
IronPort-PHdr: A9a23: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
 T17bl8LsbCaqy9V0K0X84lp8Xdva+WJyX7x0g==
IronPort-Data: A9a23:xXa4zqlg+Va785plGnAKl97o5gz5IERdPkR7XQ2eYbSJt1+Wr1Gzt
 xJKCz2PafvbYWf0KoslaNm28hhTuZaEz9BiHgVrrS5gQltH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTres1hlZHWeIcg944f5Ys7N/09YAbeSRWVvX4
 4up+paHYTdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /1Qr5acFzktGJTyo+kXD0d9KHhaHfFZreqvzXiX6aR/zmXDdGbwhepjBgc6MOX0+M4tWDsIr
 6ZHbmlQKEnf7w616OrTpu1Eo805L9Tweq4btGthyz7xEvssB5zOK0nPzY8EhGpp3Jkm8fD2O
 skGdRByXDj5bV5fCnswNrJjxteFryyqG9FfgAvI+fRuuja7IBZK+LPqO9HUUsebQN1c2Eeev
 GPPuWrjaiz2L/SazieZtG2hjKnDkEsXRb7+CpWl7PRG3mOX4FUtMxAcCQWemqCdqhKhDoc3x
 1MvxgIiqq079UqOR9b7XgGlrHPsgiPwS+a8AMVnsF3WkPa8DxKxWThdHmQphMkO6ZduLQHGw
 GNliPvFKFSDWpWwTnSB/72dsCna1cM9cDFePHdsoect2dnuoYc3hxTDC+5tGaqn5uAZ9Bn1x
 C2W6jczjfMfgKbnNplXH3iX3VpARbCQEGbZAzk7uEr7t2uVg6b7PuSVBaDzt6ooEWpgZgDpU
 II4s8af9vsSKpqGiTaARu4AdJnwuaraaWSH2wM0TsVxn9hIx5JFVd8AiN2ZDBg4WvvohReyP
 yc/RCsMuM4NZyHCgVFfOd7hVptCIVfc+STND62IMIMXPPCdhSfesngmZEiM0nrrnVRkmK5XB
 HtoWZbEMJruMow+lGDeb75Fj9cDn3lirUuOG8yT50n5gNK2OS/NIZ9YYQDmRr1ovMus/l6Pm
 /4BbJTi9vmqeLajCsUh2dVPdg9iwLlSLcyelvG7gcbYe1s4Qj59U6GNqV7jEqQ895loei7z1
 inVcidlJJDX3BUr8C2GNSJubq3BR5F6oS5pNCAgJwj6xHUpJ4qitf9Ne5wydLgh1epi0f8tE
 6hbIZrdWKwXR2SV4SkZYLn8sJdmKkahizWOCCz5MjIxSJhtGl7S8dj+cwqzryQDV3LltcY3r
 7C6+BncRJ4PG1ZrAMrMNqCwwln3sXVEwLB+WE7BI99yfkTw8dE2enKr0aJte5kBcEyRyCGb2
 gCaBQYjidPM+4JlosPUga2krpuyF7UsFERtH17dseS8Ox7c8zfx2oRHSuuJIWvQWW6oqqWvY
 eJZk6P1PPEdxQ8Yto1hD/B0wKh469a2/+1WyQFtHXPqaVW3C+o8cyfcgpQV7vVAlu1DpA+7e
 kOT4d0Ea7+HD8PSFgJDLgQSaOneh+ofnSPf7KhuLUimtjV7+qGLDRdbMxWW0XUPKbxoLMU6z
 O1ntMNPs16zjR8jM9CniCFI9j3QfyJaDPh97skXUN3xlw4m6lBeepiCWCX415G4bYkeOEcdJ
 DLJ1rHJgK5RxxaZfnc+fZQXMTGxWXjTVNF2IF4+y5Chn93Ymrko0RcX/TlfosG5CPlY+7obB
 4SpHxQdyWayE/NAm8VJGWyhc+2ELAPM4VT/kjPli0WAJ3RFlQXxwKkVJuuHukwUm46Zkv634
 5nAoFvYvf3WkA0dE8f8tYOJaxAucDCpyjD/pQ==
IronPort-HdrOrdr: A9a23:MGnfcqH8CUs3TaeepLqEzMeALOsnbusQ8zAXPo5KOHhom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgjVQX+xA/DGdmprY/ts2Ik0dNz2DUstbnnpE4o33KCdLeDU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="8405121"
X-MGA-submission: =?us-ascii?q?MDFxjaiQZwdZXkUUnKKVyNDOPBpP2cAUAKgr6R?=
 =?us-ascii?q?hsL9LT0LUDtg4oDV2TtIvJxcO8BwZkNEosWH5ZLe3f+GyvaNRi3SIDJm?=
 =?us-ascii?q?A1MX1SSNNHdvMIMsqmdEJ56z2xt16DVeiNk2apvgRRJQf07hdajGnQrq?=
 =?us-ascii?q?xrL7B/IFT/XqL2kl18zvdILw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 18:24:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647192288;
	bh=6P4d/aKGs8eTZASrj7gnqd0vnExOkaeiG/R6W9x81tI=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=sIlLynr9b3YJLgzhdps1AExwheyU0KRiuOqq1qJti9Sw+EGHrnaL4De1JGZcT0eUR
	 vzVfm2Nu379JcrKGJMtXXu3gYV+xeF9a5rut/Gw1vpLl/BvaTSwC8YB42bQqJkqtYb
	 wP++S0Q3XCJIUaUkK4JsiOJjHqBRrZJCexh2SydU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.179.181]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTOhc-1nYymS05ca-00U0UO; Sun, 13
 Mar 2022 18:24:48 +0100
Message-ID: <fdf66d4d-8e82-77ca-b35f-13427bee0a02@web.de>
Date: Sun, 13 Mar 2022 18:24:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Luis Chamberlain <mcgrof@kernel.org>
References: <9112994e-3913-54e-dfc1-b1b7f54fc191@ewheeler.net>
 <Yi4ce+2k03795Rut@bombadil.infradead.org>
Cc: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <Yi4ce+2k03795Rut@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yamGaj6CdqYTjbfYdVOvWv36qjN2RkEYBwZddA7v0APPhr8iome
 UMMH1IVS51PxyMsRBpYXrHeWctg9CY9lDDlx0nP5/acVCN8+I+S1cRqc+S3tzfkLBBCFLSF
 JuPlPO89aAKGYc3MqyGwGXv9fEApSDy+ZBwzk2N1zP7ghGLHHkPc1VEqatmV08fDboak94L
 g0r8xAbHzJy3o32FtkKzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7MLknOpFZrY=:1DBY7HCZ0PLmHvy7AQHDzE
 vFfMdoQJeF0cakOt5QYinZSvRsxSP+4oRrtUJ4eat0rSyHYBb4c/8Ou+Q4bGuWoLmVUfBfsMP
 78toU5guXTMZIAs08/7/lDgCSEtXBDpD1j86lLElFaJHotj8l/Kdz+2Hxv/XJW1r+5oW3UWgq
 CXyKsAd+vw02HgmblpPLKnNLOShOOVDcOCZ1u/qzIwQ7Ss3p3Cyc/Rzn6M0rKLOfzCt5+Cqiz
 w6akFM6dpX5OQmHCTZsEU/iwkT2nLhxhYrcfsC9Gtxj0OquYvh+2jKSxOw13Xy78GyhLOGmOv
 JowLN0mtQdI7PcU6W7OqIMpp8SXEmGiiU/FPvxkpYoELJ1DDDP1xdctFXKmo6o3D6E5eUb+dK
 8L3nacTDG62QX3JgdR+CpcZO1ahz4PSfw+Oj7ENk1cpP25QzaD8Rxx2RuOKeZVfjK3nragytZ
 ViNpV+ZYDCy9Up95DH83FZolJM+3Kuki3MwZghrJRhT+2uEGubLK18AQVUZowMbkv6Wj2mZun
 QyPYeYSzderYgMM8tlsO6XneEkxD6YdNELzZPnWrSMl++KKpmXP5PX7isLzoL3bWXro4NxA6M
 /V6GmYA39KcrZfb7BWQpwBI/7MbWaMUfQX4kWQfNrjftEnGnhdUoza27a/wAopFH+I+5AolGe
 6QTRwGoJQabYMuvcYBWEn4650XE5cTTCPjB/R4+Zd1pzYIf383d3FxohDBKLtGTxYV7r9jKL6
 t6tBlo4PS3qaJ9OWHQx3djlMgbFarqLYLC6siSn3w0wJTNWhmeTq4QK2Wq676iYrS1g5Bna3d
 2NmqNuvgaT1HTX9kzG3U75K0yvD3BdGCG2PmR605OOlUZkbRbRAYdy24i9EgBANKxwGrKNQL7
 OEqcDzTH2heYA9p2TsfaA/vOVxaoQzopNgQHRcOE19kCbHA6GLbTMctZ5G0hTbicbp5q4RNAY
 yqbeYkaEXeWis/EfFsI+KARYtzFmzvQsRq6Yr9gtLvhkY46V/0FGCaZEqOifrpttReyiXA+Ko
 4JVxGwuxN4CS+76PWZ9lrxIpb2OtMUAXcOIJOhzuZhhHD7Za7VJFfGsj9RuzaBf8YvwjI53tr
 9y2hxt2T7tuWbs=
Subject: Re: [cocci] Can Coccinelle concatenate or append to existing string
 literals?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 222
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/fdf66d4d-8e82-77ca-b35f-13427bee0a02%40web.de>

=E2=80=A6

> @initialize:python@
> @@
>
> def make_my_fresh_expression(s1, s2):
> return '"' + s1.strip('"') + "/" + s2.strip('"') + '"'
>
> @r3 depends on c1 && c2 && c3@
> expression c1.E1;
> identifier c1.sysctls;
> expression c2.E2;
> identifier c2.base;
> identifier c3.header;
> fresh identifier E3 =3D script:python(E2, E1) { make_my_fresh_expression=
(E2, E1) };
> @@
>
> header =3D
> -register_sysctl_table(base);
> +register_sysctl(E3, sysctls);


How relevant is such a SmPL script example (which seems to demonstrate the=
 selection
of a name pattern) when string literals should be constructed?

Regards,
Markus

