Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A524CC433EF
	for <cocci@archiver.kernel.org>; Sun, 20 Mar 2022 15:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9av+GpT/fe2c+5Vr1dt3baSWhwBdztCtJQ3CZmaM3z4=;
  b=kxb2+skEZjraN4hNlbsw0TlOUGHbyOAFpAOBzHzMoVdeXa4k6nziJXkp
   IeN+t+uJThwfRgj7cdpHxHEtrhAY8BXCSMevgLMs1I4TfFBK8PODZYjfV
   hEFrgS7C0Tglnz/IDDHLuDOut1SrZyl++Wi+Vwwqy90lhixcxAr1OI50z
   c=;
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
X-IronPort-AV: E=Sophos;i="5.90,195,1643670000"; 
   d="scan'208";a="27087525"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Mar 2022 16:30:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9147BE0219; Sun, 20 Mar 2022 16:30:54 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 52BC9E0069
	for <cocci@sympa.inria.fr>; Sun, 20 Mar 2022 16:30:49 +0100 (CET)
IronPort-SDR: zrKhyhWGfp5Ytmkmb7BJBuutrgUVac/mStJCyf2tutktkuUsyqHydTIdO3p3zlxtpAz/QIjOIr
 sEGSzbre9Xx+z2hiTQSnwJzziWlsDkd5iLnjjYZaTH/gjBCPBDlQCZ+wA8IBl7JXqG09QQ59/n
 rLxUoTlzXKAqIa8aKjCNzFsTojJVVVNMbe+8zWHwsC8TFxgg9jtOEaAlIctVirkjOdw0/M+X3i
 IvOmwoJiPzV8bYYJkRUFpQrdnX9qC+eEfZ1J7gJdvGVwFnRQiTkJuRNeQdFyuou4jL8R7VWbOg
 Zee5iq4Pt7ecqPChKSPRRt/d
X-IPAS-Result: =?us-ascii?q?A0BBBwBrSDdihk7ASNlaHgEBCxIMQIFcgiaBVSsEC0SEV?=
 =?us-ascii?q?JEbhB+HBYcYiiiBewsBAwENEgErAQIEAQGEfgkChDQCHQcBBDcDDQECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEMCwkHCAoHDhAFNgZeBmQEg?=
 =?us-ascii?q?UsEgXQLNA2CNSkBg2QBAgIBIx0BAREmAQ8LGgImAgJXBg0IAQGDAIJlAQMNJ?=
 =?us-ascii?q?a07gTGBAYIIAQEGhEgfLCJSgVsJgRAtjU56JxCBVUSBPIJTMD6HX4JlvXieR?=
 =?us-ascii?q?DQHghKBOoFBDJ4RBhQug2IBkloOBpFtHZY+pwKCCgGBazMaJIM4TgECAQINA?=
 =?us-ascii?q?QICAwECAQIJAQECjh0ZhAyKLEA0OAIGCwEBAwmFRwEBjCkBAQ?=
IronPort-PHdr: A9a23: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
 tWdzMrO
IronPort-Data: A9a23:GU2d4qrwD3CiIIJf3SvgyvvZupteBmJwYxIvgKrLsJaIsI4StFCzt
 garIBmGb6rZZ2Ojet8kYYSxoRwEu8LQnN5qTgVq/ng0FXkU9ePIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKicfHkZqTZMEE/Nszo68wICqtMu0IDR7z+l4
 4uo+ZWEYgf9glaYD0pNg069gEM31BjNkGhA1rAOTagjUIj2yhH5pLpGTU2AByOQrrt8RoZWd
 M6fpF2NxV41yj92Yj+TfhkXRWVRKlLaFVDmZnO7wMFOiDAazsA5+v5T2Pbx9S67hh3R9+2dx
 umhurSPWSQCJL3zmNgedBleTgx0evcY06HudC3XXcy7lyUqclPpxOhySl47N8sU946bA0kUr
 KNed2pLN0HZwb3mqF64YrEEasALCcDxP54E/FxkwyvYC/kOXp3JBanHjTNd9G1v3pARQKyCD
 yYfQQc3Sjn9YztTA1seKpcQxN2IiFfzcSIN/Tp5ooJuvjSNlVUvuFT3C/LefdeBRO1Oj0OAr
 yTH+X74C1cULrS3zTOa+3aorv3OmCnhUcQTEqe5/7hkmjWuKnc7DRoLSR2krPP/hkPWt89jx
 1I8xToNhrIiy0yXTf79WUCVqjne4DUCco8FewEl0z2lxq3R6gefI2ELSD9dddAr3PMLqSwWO
 kyhwoqzVG002FGBYSPBp+7Mxd+nEXJNdQc/iTk4oRwtz/SLnW3ephfIU8olD6O/yNH4cd0R/
 9xohHhh71nwpZRTv0lewbwhq2z2znQuZlBsjjg7pkr/smtEiHeNPuREE2Tz4/daN5q+RVKcp
 nUCkMX2xLlQUc7SzXDTGL1WRurBCxO53Nv03g4H834JqGXFxpJfVdsOiN2DDBo1Y5hfI1cFn
 meJ5FkNuPe/w0dGnYcuPt7vUp10pUQRPY2rD7jVaMZDeJ58aEeO80lTib24jwjQfLwXufhnY
 /+zKJ7yZV5DUPgP5GfoG481jOBzrghjlDu7bc2qlHyPjOvODFbLEuxtGAXVMYgEAFas+1m9H
 yB3bJbSl32ykYTWPkHqzGLkBQtTfCZhWsyu9ZA/myzqClMOJVzNwsT5mdsJE7GJVYwM/gsR1
 n3iCEJe1nTlgnjLdVeDZnx5NuHwUJw5oX9iZX4gOlOh2n4CZ4ez7f5DJsVtIuR9rLRunaxuU
 v0IW8ScGfARGD7JzDQqa8WvpoJVchn21xmFODCoYWRkcpM5H17J99bocxHB7i4LCibr58Iyr
 6f+hBzWS9wPSl06XsrRbfuuyXK3vGQcwb4jARGXf4MLIEi1qdpkMS38iPMzMvogExSby2vIz
 RuSDDcZufLJ/d0//u7JsqbY/Y2nJO1zQxhBFG7B4LfqbiTX8zbxwYJEV+rULznRWHmtofenY
 vhJie7xOrsLkQ8S4YZ7Fr9qy4M45sfu/uMLkF47QS+TN1n7WKl9JnSm3NVUsvMfzLFuuTywB
 hCF9O5cNOjbI8jiClMQeFEoY7jRz/0SgTWOv/05LF+jvX1y+6ebF1pfNV+AhXUFfrdyNYokx
 8YnudIXslDu1EB1b4ze1i0EpX6RKnEgUrk8ss9ICoHcij0tlgNIb6vaB3Kk+5qIcdhNbhInL
 zL8aHAuXFiAKpcuskbfFEQhGcJYgokS/g9HxhkOKjxlXzYDauAfhHVsHfYfF2y5DSmrF8psN
 2ItO0AdyWCm4WJznMYaN4yzM1gpOfBak3AdD3MWmWefQ0TAuqkh6oEiEb7lwX31OF6wstSWE
 H90BYolvfvXkBnN4xYP
IronPort-HdrOrdr: A9a23:NHaa46gWedgKPcK7OGLShs9GqHBQXv4ji2hC6mlwRA09TyVXrb
 HKoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykfsS+Q2mmF+rgbsbu6GeyT5Ns31B1WPHpXgkxbnn1E4j/wKDwKeOHMaKBSKK
 ah
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,195,1643670000"; 
   d="scan'208";a="27087524"
X-MGA-submission: =?us-ascii?q?MDH88KQKZLGJX+PMHISkfG5wBbI14XtvX2Fr2K?=
 =?us-ascii?q?1Ua/D4cEhYSutTX/Sv+IfJHWaJqLtE0XpDjuvLCITAj29+y248fLFDd3?=
 =?us-ascii?q?tPegy3jyaBeEB7CfBDISsyar9tOWc3Y7zH8WFKqU6xKgL/ZmDFXzCETI?=
 =?us-ascii?q?PHC2Z/ZWnrr6Cwdk6Gz1mbSw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 16:30:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647790247;
	bh=9av+GpT/fe2c+5Vr1dt3baSWhwBdztCtJQ3CZmaM3z4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dXzQOcMZrrn1XkDn4307ql6zMDURADW7D0MoyMFWNW6vHB7Z8CFKqwSABxzTSXzBR
	 x+YBHYnP5es40F0GKDEnispxA8g4tWZQZCeyuQRQpA1Uyvk32J6sXbDhklvXyA56c4
	 9V4LEhBZqOohsGSEs+9L9JkRFdc3qbWuxdhJRsB0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.118.49]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGgJM-1nIGOb30Da-00DyGN; Sun, 20
 Mar 2022 16:30:47 +0100
Message-ID: <3851edaa-5b04-e3ee-f246-a8a579aa6b26@web.de>
Date: Sun, 20 Mar 2022 16:30:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, Eric Wheeler <cocci@lists.ewheeler.net>
References: <30124bde-34e-65ca-d5bc-fc3255ccda3@ewheeler.net>
 <alpine.DEB.2.22.394.2203190922070.3204@hadrien>
 <66b66e5a-c024-7d0b-c84c-d780d5ce41f6@web.de>
 <6a41b56e-84bb-ead8-87c3-6d2d4421df7c@ewheeler.net>
 <alpine.DEB.2.22.394.2203192110540.3204@hadrien>
 <ad4280e9-4b24-0dfc-8ce6-b03ab68b1e28@web.de>
 <alpine.DEB.2.22.394.2203200949540.2917@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2203200949540.2917@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:48wTjV0ysJMWkDdiLh9itHIYEOBfRkUKysIYOyzgkXoqBjo8+GI
 O5Fiak8JCnj5nIPm1ik/OSDubEnsBTNd0HdNYY0zyOTBTYquPMjuUz6+9/t2x0AGbM00fyP
 oeNt1hIRgoLJ2N9yNhipSPq4+jJxylBzMz8fQzfzp/OCaDvq0rljkUYyRaJug7qOPAKrmMH
 gORKyDFGMzstSXc8XQVRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WF9V0I1JzIM=:cKf8j2SYGl10WoizudfruT
 MVlpIlO2e8Jfy/VVJ42JpnkGuYVu/Pm6+TqghpAwq4uW1U9nSj4qpZmFwZGOkoOgPT5FYZADg
 NUU/Sj6dadoC8pmwdEfX/MOpID5me0nOWxcotssDhBMjJompsaO4D9TSmFXEQUK9ZZKTpf9aj
 x5p42Sg+R9Gfs1dYrMKxQ+QMBDOreOYzA4tDMelLkh0S/PoEfGdiwcCXsvzdYUs6NB+SMLt48
 YMzpOHWx/q/QGlJrAFajWv9zh+26BtLf/EfRUeqXuROaTb9dvCkHT2800LZXewQPDiSUCA7WI
 aTRY2ynGpXGX1yUfaN+2ShkuWhtFWdlltecUCeCbILUFSaJeGdLmVCnR0qFYbZ5jaRtwhmAYw
 r52jX6LcGrKfkNHW32nx3gQk/p0QUxBgjBvtE9qbWpxBPOabEFvHzwEyewFoBvd+Qr6eKfgz8
 uJN6DrbUUs2MfzUHFuNjhH9JXUyqM40Qrx02aLvgneVkCzSwira4XLqH/ndAqemD/594rA/qp
 6oSWcNf8F7R7NJlBjFzgQaulA9cjkmzjjS8NH4c7fMcCs9WjXewIE6pHeVP2TtoMtnagZPt76
 vi708FG4HPOcd0TlQY3Z0siI7v+io1cancH9kjBw9yA7ReCj1xV8iYOkCHqCnRhiKFKvuNIpz
 HtFXzggzmXI3A9rePKJcfitt+EkyC855oQjVek4smF/7pLYj6qKkX9WL1NyCeeYXer+8ugeeP
 dpYeF73Fs3XVtQeEKXkZdS/Bfr24UMngjpSLbX2sw3ZNKkpLkI1F1lEZBPa2Lbmj6jq1mQDOP
 QpGSXwe71dU23JGbhvjgIASDOal+5Blrwe1JQyxdslbC5HgF/VjfrAVszRimDdVl6T1UmfUgt
 tXh8lUzOZPawATEkpSmGXjc+30tgVO8YomxvnT/eyQA3t3A2ZaWmna6TJR774DIVvIBWkANpQ
 uFzAUJzd0fqvYAvQJkCf0oHbIPiyt9TBlL5d9avEgM1ZZoCP1yDgbUde01fXpmzhB5bc492eR
 +jwpX5Sha/YCduwPlAtUpHJhXPIILQ/Gr3S0PUmylGn8r78OWdlPu1NWFO+1w3paspGh55irt
 PJpRfiwLZtg+Wo=
Subject: Re: [cocci] Improving descriptions for SmPL data processing
 indicators?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 263
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/3851edaa-5b04-e3ee-f246-a8a579aa6b26%40web.de>

>> What more do you want?


I propose to explain SmPL data processing indicators/annotations better by
a corresponding taxonomy.
Will such a documentation approach trigger a different visual representation?

Regards,
Markus

