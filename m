Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585B9FA373E
	for <cocci@archiver.kernel.org>; Mon, 24 Oct 2022 13:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Ip23co/dcRaCdBfhpNpYonNM7EkYdEElG6Lf7VI2roQ=;
  b=NIbZmiBf4YVn0/pPFiOH7POXimAl6DN/R/X4HMcXmYx7z01AS2GDJGN0
   6VFXAk0YekCV944HDvs5/IlDuVNiHq2L2z0LjnLZ6wDGlmUsUCYviZUtH
   VqNwEEryKjuDzP7Zzi5f0L4dnjZ2DaCBM3MKhbdbIDwo2U76GwgpOVJfP
   A=;
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
X-IronPort-AV: E=Sophos;i="5.95,209,1661810400"; 
   d="scan'208";a="68109842"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2022 15:12:50 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4E2E1E0152; Mon, 24 Oct 2022 15:12:50 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9CBABE004E
	for <cocci@sympa.inria.fr>; Mon, 24 Oct 2022 15:12:45 +0200 (CEST)
IronPort-SDR: 63568f4d_vGzQiUmk4UzC9SUFPd6raeOwSIqZM5oZBhhCo8RAiCGF8Pn
 jScopXWgw1zgBlt/C//ISCQWtPDnalat2OkAHhA==
X-IPAS-Result: =?us-ascii?q?A0AXAwBHjlZjhwQP49RaHgEBCxIMQIFEC4ItgVcuBAtFh?=
 =?us-ascii?q?E6RGotBhymKNIF8DwEDAQ1BAQIEAQGCEoJzAoRxAh0HAQQyBw4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBGQkXBw4QBSKFaA2CNSkBg2QBA?=
 =?us-ascii?q?gIBIx0BAREmAQQLBQYaAiYCAlcGASOCbIJtAQMNIwercYEygQGCCAEBBoROH?=
 =?us-ascii?q?ywiU4FdCYERLIcjhQqDNHonEIFVRIFIgnc+hESDV4JmjxGGRzgDRB1AA0YyA?=
 =?us-ascii?q?wpRHDEnDgkfHA4XDQUGEgMgbgVBDygvZyscGweBDCooFQMEBAMCBhMDIgINK?=
 =?us-ascii?q?TEUBCkTDy0HI3EJAgMiZQUDAwQoLAMJQAclJDwHWDoBBAMCECI8BgMJAwIkg?=
 =?us-ascii?q?U0xJgUDDRclCAVOBAg6AgUGUhICChEDEg8GJ0cOSj45FgYnRAE0Dw4WA2OZF?=
 =?us-ascii?q?oECE4MjwVg0B4IdgUiBSwyfADMDlmQGkhOXISCnVIFpAjGBWzMaJIM2TgMZD?=
 =?us-ascii?q?44gGYQMii0/NDsCBgEKAQEDCYVHAQGFEgEB?=
IronPort-PHdr: A9a23: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
 MfCnuT/JWUamzox1dQRDY7YJZDfWEc=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Z341vqzNTLAGC/ziijqwKrPw3r1zdoMgy1knxilNoNJuEvBw8P
 re5MjztCWE6gr5PUtKpTnuAtjkfZqxz/BICKgqTNOftUzdyQ2VxeJZgbcKoQeOJ8SWzIc0uJ
 uIMZIOceEZyDNB/KHHCWKDYrUdKbe8kZyAuceb6WtxRgd3bKxa4x5+ERvzKDwIeOA8P+tCKH
 KGjPA32gZIlE5nEviTNz04f6zmq8fQnJzrJSMXHhJP0nj0sdsihYSRLySl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,209,1661810400"; 
   d="scan'208";a="33287212"
X-MGA-submission: =?us-ascii?q?MDHGkeevludxD0OGC9tFNUfDgH4CGz5V6OB1YZ?=
 =?us-ascii?q?owY559rKkA7040oDC3uhAoHh0i7ex4vxU7vNWycKH4OO5899fHRsD6bM?=
 =?us-ascii?q?gjdgnCkqrfJ50eThbB8q9Zu32AiaTdAjjUec+3c+Mv22Scnn0hRi75aX?=
 =?us-ascii?q?tGBzgpHRV/V6mOmVwysRf5zQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 15:12:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1666617163; bh=V748wnDpoEkNTDqDzHOlroOqI42inxnjuF3yVYZzmyo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=liWdT7FWjaAGSps1dNVvGJbmT5I9cvWGDdJVdub9ZKxLDfCN8bBgpxKGOGcJne91s
	 5BdngR1R4rjvny1UzEovC3jzap+l2feyuL6wBsh0JS9dscth+eh9IpH7vcErh5B2M9
	 AflZE+6J6hZigxNvkIQODxR0WuWE6W3Xyi0FJnNM518TjxyAdC/9X3Megy89K1YPeZ
	 2foFFogoD+i6NGTTaf5WZDXYnj62JcbaF407Gn+6re8Dk3884ETHEMEhxtJFWDOO8/
	 L5GwLY/Jjs9HA2wxUUWkyqrcjiM9cOkM9jFDG9U1nIzl9ddq1J9/W5vmJOCIlpyRcy
	 ZtmX5JWZm49+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [94.31.80.160] ([94.31.80.160]) by web-mail.web.de
 (3c-app-webde-bs11.server.lan [172.19.170.11]) (via HTTP); Mon, 24 Oct 2022
 15:12:43 +0200
MIME-Version: 1.0
Message-ID: <trinity-d4bcd599-1a10-4d96-b852-3ed8f3eafa19-1666617163749@3c-app-webde-bs11>
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Oct 2022 15:12:43 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <Y1WYWT0xU5hv1Gr9@zx2c4.com>
References: <CAHmME9rTWvUxsM-sFZh1r+D5gb-8rbHmeWiFEfobkjxDRrZO1Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2210200705030.2988@hadrien>
 <CAHmME9p7nTuAOS87NYKhbhh1rF-XJBkuWjjmHbrkiJUrth5XHQ@mail.gmail.com>
 <trinity-3c34f082-c650-4c08-9ff9-f746f20e4183-1666533323595@3c-app-webde-bap48>
 <Y1WYWT0xU5hv1Gr9@zx2c4.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:tLERk5gQZBevVzo7fphLjRznjXzVVytdKt1EgFRnNVDy8a4JRbxjXQetqfpEzLwbnn/5f
 8a7MRMdzvGzV1Ap6TWPs6I8KFDlFDdrFimd4mtZt33gfDH4TyBA9FwyVou6KYhXnUMBQ9qUL4tzn
 W4JW12niXhiHyRLNMA4mkVfQKgHLLB4pgwfvOLXgyG7kMTb0Hmc+F4E467Pn4HqaCPA40WnMtBha
 x25d8OkqfEm0llTIac9bvhMvulqlfpUdfBlFUHcdo/bKyoiOukO05JC7d+DoNDFoTwOuAJ2s0f61
 ww=
UI-OutboundReport: notjunk:1;M01:P0:ZiPpk0HgcMI=;kF6d2v9zYFTENHlnxnBJWFmeRCj
 SSz9stlj3DjQ+MxnfcNAnnM+hI/vulwrOtWpwNUyqMzgzI8gA2nPZo50a+j5Vnld+vSYyC87A
 h2ta6PVvlNOpJXQAP7jAVdpd7HEo4t2mvUrsw1z1UVEJKjKWuUf1HOqQKUY+IWQevuxqfS0iv
 tjSal94qvQHUUn0VAPjA2vP6pCcIXsMpw1aQWQXMpQciVV6HzHI78I+FlX/URuR2Ip9PiSc/v
 kI9Yln+T4ezCT1szkDC+w5ph6wLhMH1ktV9BnqCbw6jRPtoSin5AKnl8zAMyI7nO/7qDsbGbT
 GeYtIhuU97oxmyXcWxdpeB3Jh0YdROTw0++1OUQQk3/2DofDuAbXAM9zPCRNGPKuC3ukaxnAt
 hbNKph4SzloFDDtvaTaZFlVChAGqlUezfZqArKRztibpyFL6mGDtHz7simHCZmPl5ZBC2sIN0
 EUYYfKLFKZGUu2ARW3qReAC6Y3r2ir1c6pspXgHEcerL4d9x5j/qXBmcmn5VmhnKVHg6tC4MU
 D0Wrl/Fm/MWD4zdU0FtI+6GN3CwTMqfJsq/HqNMs0mrlkenyXls7gEMs9sqTKgaMFtvz+Zpsu
 uxxypbViWZbSpHW+hQVX+n/nr5gEuxI4I9oubGiiZH+97TywONNpYJDorEgtBd7a2hDJepnv/
 Qxf0JUEBpv2/rZ9vsgUf+KTD6BIz7j8hnXjMeNOunLs3deRqO78vtne99EL5mD5mK65we+pQ+
 jpIWVhIcTjOjKIfCfZ5OByPregB2aLsYdYKuXIpyuq6E1veJnP/gGl6us7J6arejBxnAzsDqN
 SrpJItpVO70W19UmaxiuQFgw==
Subject: Re: [cocci] algebraic simplification possibilities with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 682
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/trinity-d4bcd599-1a10-4d96-b852-3ed8f3eafa19-1666617163749%403c-app-webde-bs11>

> I can do something like that=2E These seem to work:

I wonder about another error response from the software =E2=80=9CCoccinell=
e 1=2E1=2E1=E2=80=9D
for an SmPL code variant like the following=2E


@replacement@
expression H, L;
@@
-(get_random_u32_below(H) + L)
+get_random_u32_between(L, H + L)

@cleanup@
expression H, L, E, F;
@@
 get_random_u32_between(L,
  H
(
- - E
  + F
- + E
|
- + E
  + F
- - E
|
- - E
- + E
|
- + E
- - E
)
                       )


linux@linux:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --parse-cocci sugg=
estion3_for_Jason_Donenfeld-20221024=2Ecocci
=E2=80=A6
minus: parse error:=20
  File "suggestion3_for_Jason_Donenfeld-20221024=2Ecocci", line 12, column=
 0, charpos =3D 167
  around =3D '(',
  whole content =3D (


Can such a test case trigger any further improvements for the advanced app=
lication
of SmPL disjunctions?

Regards,
Markus
